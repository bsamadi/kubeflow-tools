#!/bin/bash

export ZONE=us-central1-c
export KFAPP=dashboard
export KUBEFLOW_REPO=kubeflow_repo
export KUBEFLOW_REPO="`pwd`/${KUBEFLOW_REPO}"

if [[ ! -d "${KUBEFLOW_REPO}" ]]; then
   mkdir ${KUBEFLOW_REPO}
   cd ${KUBEFLOW_REPO}
   export KUBEFLOW_TAG=v0.3.2
   
   curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash
   cd ..
fi

${KUBEFLOW_REPO}/scripts/kfctl.sh init ${KFAPP} --platform gcp --project ${PROJECT}
cd ${KFAPP}
${KUBEFLOW_REPO}/scripts/kfctl.sh generate platform
${KUBEFLOW_REPO}/scripts/kfctl.sh apply platform
${KUBEFLOW_REPO}/scripts/kfctl.sh generate k8s
${KUBEFLOW_REPO}/scripts/kfctl.sh apply k8s

kubectl -n kubeflow get  all