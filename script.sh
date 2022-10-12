#!/usr/bin/bash

definitionRegex="^[a-zA-Z]+_to_[a-zA-Z]+$"
conversionRateRegex="^-?[0-9]+\.?[0-9]*$"
echo "Enter a definition:"
read -a user_input
inputLength="${#user_input[@]}"
definition=${user_input[0]}
conversionRate=${user_input[1]}
if [[ "$definition" =~ $definitionRegex ]] && [[ "$conversionRate" =~ $conversionRateRegex ]] && [[ "$inputLength" == 2 ]]; then
	echo "Enter a value to convert:"
	read value
	while [[ ! "$value" =~ $conversionRateRegex ]]; do
		echo "Enter a float or integer value!"
		read value
	done
	echo Result: $( bc -l <<< "$value * $conversionRate" ) 
else
	echo "The definition is incorrect!"
fi
