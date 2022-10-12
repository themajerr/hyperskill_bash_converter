#!/usr/bin/bash

definitionRegex="^[a-zA-Z]+_to_[a-zA-Z]+$"
conversionRateRegex="^-?[0-9]+\.?[0-9]*$"
choiceRegex="^[0-3]$"
quitRegex="^quit$"
programLoop=1

echo "Welcome to the Simple converter!"

while [ $programLoop == 1 ]; do 
	echo "Select an option"
	echo "0. Type '0' or 'quit' to end program"
	echo "1. Convert units"
	echo "2. Add a definition"
	echo "3. Delete a definition"
	read userChoice
	if [[ ! $userChoice =~ $choiceRegex ]] && [[ ! $userChoice =~ $quitRegex ]]; then
		echo "Invalid option!"
		continue
	else
		case $userChoice in
			"quit"|"0")
				echo "Goodbye!"
				programLoop=0;;
			"1"|"2"|"3")
				echo "Not implemented!"
		esac
	fi
done
: '
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
'
