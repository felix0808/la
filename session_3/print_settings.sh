#1/bin/bash
. settings.conf

function generateGrid(){
	for i in {1..40};do
		echo -n "#"
	done
}
generateGrid 
echo -e "\n## Default login/password: $OS_USERNAME/$OS_PASSWORD
## tennant: $OS_TENANT_NAME"
generateGrid

