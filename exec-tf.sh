#!/bin/bash

## ..:: usage function ::..
## ----------------------------------------------------------------------------

usage(){
	echo "
  Usage: $0 <infrastructure_module>
 
  infrastructure_module: aks
"
	exit 1
}

## ..:: main ::..
## ----------------------------------------------------------------------------

IS_MODULE_NAME_SET=0

[[ $# -eq 0 ]] && usage

if [[ $1 == "aks" ]]
then
    echo "Setting working dir to $1"
	WORKING_DIR=$1
else
	usage
fi

# re='^[0-9]+$'
# if ! [[ $2 =~ $re ]]
# then
# 	usage
# fi

cd $WORKING_DIR

terraform init
terraform plan

read -p "Do you want to actaully appy this? (any key to continue, ctlr+c to exit here)" -n 1 -r
echo    # (optional) move to a new line

terraform apply
