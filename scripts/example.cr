#!/usr/bin/env crystal
require "option_parser"

file = ""
mode = "none"
namespace = "chart-examples"

parser = OptionParser.parse do |parser|
  parser.banner = "Usage: question_gen [arguments]"
  parser.on("-f FILE", "--file=FILE", "example file to parse") { |f| file = f }
  parser.on("-i", "--install", "install the example") { mode = "install" }
  parser.on("-d", "--delete", "delete the example") { mode = "delete" }
  parser.on("-u", "--upgrade", "upgrade the example") { mode = "upgrade" }
  parser.on("-n NAMESPACE", "--namespace=NAMESPACE", "namespace to install to. (default: chart-examples)") { |ns| namespace = ns }

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
  case mode
  when "install"
    install(file, namespace)
  when "delete"
    delete(file, namespace)
  when "upgrade"
    upgrade(file, namespace)
  else
    STDERR.puts parser
    exit(1)
  end
else
  STDERR.puts parser
  exit(1)
end

def get_chart_type(file)
  case file
  when /cronjob/
    "cronjob"
  when /deployment/
    "cronjob"
  when /statefulset/
    "cronjob"
  else
    raise "Unknown chart type"
  end
end

def install(file, namespace)
  name = File.basename(file).chomp(File.extname(file))
  chart = get_chart_type(file)
  cmd = "helm install -n #{namespace} #{chart}-#{name} ./ndustrial/#{chart} -f #{file} --create-namespace"
  `#{cmd}`
end

def delete(file, namespace)
  name = File.basename(file).chomp(File.extname(file))
  chart = get_chart_type(file)
  cmd = "helm delete -n #{namespace} #{chart}-#{name}"
  `#{cmd}`
end

def upgrade(file, namespace)
  name = File.basename(file).chomp(File.extname(file))
  chart = get_chart_type(file)
  cmd = "helm upgrade -n #{namespace} #{chart}-#{name} ./ndustrial/#{chart} -f #{file}"
  `#{cmd}`
end
