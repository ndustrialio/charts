#!/usr/bin/env crystal
require "yaml"
require "option_parser"

file = ""
parser = OptionParser.parse do |parser|
  parser.banner = "Usage: question_gen [arguments]"
  parser.on("-f FILE", "--file=FILE", "values file to parse") { |_file| file = _file }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end

  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

if File.exists?(file)
  generate(file)
else
  STDERR.puts parser
  exit(1)
end

def parse_vars(file)
  data = Hash(String, Array(Tuple(String, String, String))).new
  current_section = "default"
  File.each_line(file) do |line|
    next unless line =~ /##\s+@(\w+)\s+([\w\.\[\]\d]+)\s+(.*)$/
    case $1
    when "section"
      current_section = $2 + " " + $3
    else
      data[current_section] = Array(Tuple(String, String, String)).new unless data[current_section]?
      data[current_section] << ({$1, $2, $3})
    end
  end
  data
end

def generate(file)
  data = YAML.parse(File.read(file))
  vars = parse_vars(file)
  q_vars = vars.transform_values do |val|
    val.select(&.[0].==("question")).map(&.[1]).uniq!
  end
  dir = File.dirname(file)

  write_question_file(dir, data, vars, q_vars)
  write_val_file(dir, data, vars)
end

def write_question_file(dir, data, vars, q_vars)
  questions = gen_questions(data, vars, q_vars)
  if File.exists?(File.join(dir, "_questions.yml"))
    x = YAML.parse(File.read(File.join(dir, "_questions.yml")))["questions"]?
    questions = x.as_a + questions unless x.nil?
  end

  qs = {
    questions: questions,
  }
  q_file = File.join(dir, "questions.yml")
  File.write(q_file, qs.to_yaml)
end

def write_val_file(dir, data, vars)
  vrs = vars.transform_values do |val|
    val.map(&.[1]).uniq!
  end.flat_map do |k, v|
    v.map do |i|
      parts = i.split(/[\.\[\]]/)
      parts = [i] if parts.empty?
      default = get_var(data, parts)
      {
        variable: i,
        group:    k.gsub(" parameters", ""),
        default:  default,
        type:     get_type(default),
      }
    end
  end
  v_file = File.join(dir, "_var_list.yml")
  File.write(v_file, vrs.to_yaml)
end

def gen_questions(data, vars, q_vars)
  q_vars.flat_map do |s, q|
    next if q.empty?
    q.map do |v|
      gen_question(data, s, v, vars[s].select(&.[1].==(v)))
    end
  end.reject(Nil)
end

def gen_question(data, group, val_path, vars)
  default = get_var(data, val_path.split(/[\.\[\]]/))
  {
    group:    group.gsub(" parameters", ""),
    variable: val_path,
    default:  default,
    type:     get_var_type(vars),
    required: get_var_required(vars),
    label:    get_var_label(vars),
    options:  get_var_options(vars),
  }
end

def get_type(val)
  case val
  when String
    "string"
  when Array, Hash
    nil
  when Number
    "number"
  when Bool
    "boolean"
  else
    nil
  end
end

def get_var_type(vars)
  vars.find(&.[0].==("question")).not_nil![2]
end

def get_var_options(vars)
  op = vars.find(&.[0].==("options"))
  if op.nil?
    [] of String
  else
    op[2].split(/,\s+/)
  end
end

def get_var_label(vars)
  op = vars.find(&.[0].==("label"))
  if op.nil?
    vars.find(&.[0].==("param")).not_nil![2]
  else
    op[2]
  end
end

def get_var_required(vars)
  op = vars.find(&.[0].==("required"))
  if op.nil?
    false
  else
    op[2] == "true"
  end
end

# Get the var by path parts
def get_var(data, parts)
  n = parts.shift
  if data[n]?
    case data[n]
    when .as_a?
      return data[n].raw if data[n].as_a.empty?
      get_var(data[n], parts)
    when .as_h?
      return data[n].raw if data[n].as_h.empty?
      get_var(data[n], parts)
    else
      data[n].raw
    end
  else
    nil
  end
end
