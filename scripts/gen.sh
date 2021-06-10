#!/bin/bash
set -e

WORKDIR=$(pwd)
CI_DIR=${WORKDIR}/.ci
README_GEN_BIN=$(which readme-generator)

to_workdir() {
  cd ${WORKDIR}
}

to_chart_dir() {
  local chart=$1
  cd ${WORKDIR}/ndustrial/${chart}
}

install_md_gen() {
  if [ -d ${CI_DIR} ]; then
    mkdir -p ${CI_DIR}
  fi

  if [ -d ${CI_DIR}/readme-generator-for-helm ]; then
    cd ${CI_DIR}
    git clone https://github.com/bitnami-labs/readme-generator-for-helm
    cd ${CI_DIR}/readme-generator-for-helm
    npm install
    cd ${CI_DIR}
    npm install -g readme-generator-for-helm
  fi

  to_workdir
}

gen_readme() {
  local chart=$1
  to_chart_dir ${chart}
  ${README_GEN_BIN} -r ./README.md -v values.yaml
  to_workdir
}

if [ -z ${README_GEN_BIN} ]; then
  echo "missing readme-generator"
  install_md_gen
fi

gen_readme "cronjob"
gen_readme "deployment"
gen_readme "statefulset"
