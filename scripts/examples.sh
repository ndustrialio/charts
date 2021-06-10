#!/bin/bash
set -e

NAMESPACE="chart-examples"
WORKDIR=$(pwd)
TASK=$1
EXAMPLE_NAME=$2

if [ -z ${TASK} ]; then
  echo "must provide a task mode:"
  echo "  install"
  echo "  delete"
  echo "  upgrade"
  echo "  list"
  exit
fi

if [ "${TASK}" == "list" ]; then
  helm list -n ${NAMESPACE}
  exit
fi

if [[ -z ${EXAMPLE_NAME} && -e ${WORKDIR}/examples/${EXAMPLE_NAME} ]]; then
  echo "must provide one of the examples:"
  ls ${WORKDIR}/examples/
  exit
fi

install() {
  local _file=$1
  local path=${WORKDIR}/examples/${_file}
  local name=${_file%".yml"}
  helm install -n ${NAMESPACE} ${name} ./ndustrial/deployment -f ${path} --create-namespace
}

delete() {
  local _file=$1
  local path=${WORKDIR}/examples/${_file}
  local name=${_file%".yml"}
  helm delete -n ${NAMESPACE} ${name}
}

upgrade() {
  local _file=$1
  local path=${WORKDIR}/examples/${_file}
  local name=${_file%".yml"}
  helm upgrade -n ${NAMESPACE} ${name} ./ndustrial/deployment -f ${path}
}

if [ "${TASK}" == "install" ]; then
  install ${EXAMPLE_NAME}
elif [ "${TASK}" == "delete" ]; then
  delete ${EXAMPLE_NAME}
elif [ "${TASK}" == "upgrade" ]; then
  upgrade ${EXAMPLE_NAME}
else
  echo "unknown task: ${TASK}"
fi
