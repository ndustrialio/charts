#!/bin/bash
set -e

WORKDIR=$(pwd)
README_GEN_BIN=$(which readme-generator || true)

to_workdir() {
  cd "${WORKDIR}"
}

to_chart_dir() {
  local chart=$1
  cd "${WORKDIR}"/ndustrial/"${chart}"
}

install_md_gen() {
  npm install -g git+https://github.com/bitnami-labs/readme-generator-for-helm #--include=dev
}

gen_readme() {
  local chart=$1
  echo "Generating README.md for ${chart}"
  to_chart_dir "${chart}"
  ${README_GEN_BIN} -r ./README.md -v values.yaml
  to_workdir
}

gen_questions() {
  local chart=$1

  echo "Generating questions for ${chart}"
  docker run --rm -v "$(pwd)":/app crystallang/crystal:1.0.0 \
    crystal /app/scripts/question_gen.cr -f /app/ndustrial/"${chart}"/values.yaml
}

if [ -z "${README_GEN_BIN}" ]; then
  echo "missing readme-generator"
  install_md_gen
  README_GEN_BIN=$(which readme-generator)
fi

echo "Generating README.md"
gen_readme "common"
gen_readme "cronjob"
gen_readme "deployment"
gen_readme "statefulset"

echo "Generating questions"
gen_questions "cronjob"
gen_questions "deployment"
gen_questions "statefulset"
