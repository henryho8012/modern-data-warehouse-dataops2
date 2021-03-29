#!/bin/bash
###################
# REQUIRED ENVIRONMENT
GITHUB_REPO="henryho8012/modern-data-warehouse-dataops"
GITHUB_PAT_TOKEN="3a769018641a0c8372f65b63fc1479d711b300ce"
DEPLOYMENT_ID="kyljh"
RESOURCE_GROUP_NAME_PREFIX="mdwdo-park"
RESOURCE_GROUP_LOCATION="southcentralus"
AZURE_SUBSCRIPTION_ID="a6f5c246-0602-457d-a3ee-3a398ff4c8a0"
AZDO_PIPELINES_BRANCH_NAME="master"
AZURESQL_SERVER_PASSWORD="mdwdo-azsql-SqlP@ss-kyljh"

# check required variables are specified.


if [ -z $GITHUB_REPO ]
then 
    echo "Please specify a github repo using the GITHUB_REPO environment variable in this form '<my_github_handle>/<repo>'. (ei. 'devlace/mdw-dataops-import')"
    exit 1
fi
export GITHUB_REPO=$GITHUB_REPO

if [ -z $GITHUB_PAT_TOKEN ]
then 
    echo "Please specify a github PAT token using the GITHUB_PAT_TOKEN environment variable."
    exit 1
fi
export GITHUB_PAT_TOKEN=$GITHUB_PAT_TOKEN

# initialise optional variables.

export DEPLOYMENT_ID=${DEPLOYMENT_ID:-}
if [ -z "$DEPLOYMENT_ID" ]
then 
    export DEPLOYMENT_ID="$(random_str 5)"
    echo "No deployment id [DEPLOYMENT_ID] specified, defaulting to $DEPLOYMENT_ID"
fi


export RESOURCE_GROUP_NAME_PREFIX=${RESOURCE_GROUP_NAME_PREFIX:-}
if [ -z $RESOURCE_GROUP_NAME_PREFIX ]
then 
    export RESOURCE_GROUP_NAME_PREFIX="mdwdo-park-${DEPLOYMENT_ID}"
    echo "No resource group name [RESOURCE_GROUP_NAME] specified, defaulting to $RESOURCE_GROUP_NAME_PREFIX"
fi

export RESOURCE_GROUP_LOCATION=${RESOURCE_GROUP_LOCATION:-}
if [ -z $RESOURCE_GROUP_LOCATION ]
then    
    export RESOURCE_GROUP_LOCATION="westus"
    echo "No resource group location [RESOURCE_GROUP_LOCATION] specified, defaulting to $RESOURCE_GROUP_LOCATION"
fi

export AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID:-}
if [ -z $AZURE_SUBSCRIPTION_ID ]
then
    export AZURE_SUBSCRIPTION_ID=$(az account show --output json | jq -r '.id')
    echo "No Azure subscription id [AZURE_SUBSCRIPTION_ID] specified. Using default subscription id."
fi

export AZDO_PIPELINES_BRANCH_NAME=${AZDO_PIPELINES_BRANCH_NAME:-}
if [ -z $AZDO_PIPELINES_BRANCH_NAME ]
then
    export AZDO_PIPELINES_BRANCH_NAME="master"
    echo "No branch name in [AZDO_PIPELINES_BRANCH_NAME] specified. defaulting to $AZDO_PIPELINES_BRANCH_NAME."
fi

export AZURESQL_SERVER_PASSWORD=${AZURESQL_SERVER_PASSWORD:-}
if [ -z $AZURESQL_SERVER_PASSWORD ]
then 
    export AZURESQL_SERVER_PASSWORD="mdwdo-azsql-SqlP@ss-${DEPLOYMENT_ID}"
    echo "No password for sql server specified, defaulting to $AZURESQL_SERVER_PASSWORD"
fi