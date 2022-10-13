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
				programLoop=0
				;;
			"1")
				echo "Not implemented!"
				;;
			"2")
				definitionLoop=1
				while [[ $definitionLoop == 1 ]]; do
					echo "Enter a definition:"
					read -a user_input
					inputLength="${#user_input[@]}"
					definition=${user_input[0]}
					conversionRate=${user_input[1]}
					if [[ "$definition" =~ $definitionRegex ]] && [[ "$conversionRate" =~ $conversionRateRegex ]] && [[ "$inputLength" == 2 ]]; then
						echo "$definition $conversionRate" >> definitions.txt
						definitionLoop=0
					else
						echo "The definition is incorrect!"
					fi
				done
				;;
			"3")
				if [[ ! -e definitions.txt ]] || [[ ! -s definitions.txt ]]; then
					echo "Please add a definition first!"
				else
					echo "Type the line number to delete or '0' to return"
					linesAmount=$(wc -l < definitions.txt)
					for i in $(seq 1 $linesAmount); do
						echo "$i." $( cat definitions.txt | head --lines "$i" | tail --lines 1 )
					done
					removeLoop=1
					while [[ $removeLoop == 1 ]]; do
						read lineToRemove
						lineRegex="^[1-${linesAmount}]$"
						if [[ $lineToRemove == '0' ]]; then
							removeLoop=0
						elif [[ ! $lineToRemove =~ $lineRegex ]]; then
							echo "Enter a valid line number!"
						else 
							sed -i "${lineToRemove}d" "definitions.txt"
							removeLoop=0
							
						fi
					done
				fi
				continue
		esac
	fi
done