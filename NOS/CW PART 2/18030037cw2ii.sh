#!/bin/bash

#function to enter the secret key 
secret_key_function(){
echo "Enter the secret key"
read key
}
secret_key_function # calling the function

ID=$2
Name=$1

#if statement to check whether the user have provided parameter or not
if [ -z "$Name" ] || [ -z "$ID" ] #-z checks if the parameter is empty or not
then
	echo "Exiting the program as you have not provided the parameters"
	exit
fi

#function which welcomes the user to welcome screen
welcome_function(){
if [[ $Name = "Aashish" ]] && [[ $ID = "18030037" ]] #if statement to check right user & ID
				then
						echo -e "-----------------------------------------------------------------------------------------------\n";
						echo "			Welcome!!!! Your ID is" $ID  "Your name is" $Name
						echo
						echo -e "	    The current date & time of execution is:\c"; date 
						echo
						echo -e "-----------------------------------------------------------------------------------------------";
			else 
						echo "Incorret parameters (Check your Name and ID resp. and Try Again. Thank you!!)"
						exit
			fi
}

#function that asks the user whether they are ready to start the program
start_game_function(){
while :; do
	echo -e "\t\t\t Are you ready to play the guessing game?(y/n)\c";
	read start
	if [ $start = "y" ]
		then 
			function_guess_country #calling function guess country
	elif [ $start = "n" ]
		then
			echo "Exiting the program"
			exit
	else 
		echo -e "\t\t\t\t\tInvalid Input"
	fi
done
}

#function that ask the user to re-run the program
restart_program()
{
while :;do
echo -e "Do you want to play again?(y/n):\t\c"
  read input
	if [ $input = "y" ]
	then	
		function_guess_country #calling guess country function
		function_guess_player #calling guess player function
	elif [ $input = "n" ];
		then
		echo "Exiting the program"
		exit
	else 
		echo "Invalid Input"
	fi
done
}

#function that displays the country name and code and asks the user to guess the correct country code
function_guess_country()
{
echo
	echo -e "***********************************************************************************************";
echo -e "\t\tWelcome to the Guessing Game"
echo -e "\t\t\tLevel 1"
	echo -e "***********************************************************************************************";
echo 

column countrycode.txt -t -s "/" #prints the data in tabular format
echo
echo -e "Guess the best cricket team using its code name: \c";
read code

# use case statement to make decision for Country code
case $code in
	"AUS")
		echo
		echo -e "\t\t\t\tYes! Your guess is correct"
		cat AUS; 
		function_guess_player #calling guess player function
	;;
	"BAN")
		echo "Incorrect"
		restart_program #calling restart function
	;;
	"NEP")
		echo "Incorrect"
		restart_program #calling restart function
	;;
	"IND")
		echo "Incorrect"
		restart_program #calling restart function
	;;
	"ENG")
		echo "Incorrect"
		restart_program #calling restart function
	;;
	*)
		echo "Sorry it is not in the list"
		restart_program #calling restart function
	;;
esac
}

#function that asks the user whether they want to exit or not
function_exit(){
while :; do
echo -e "Do you want to exit?(y/n):\c"
read exit
if [ $exit = "y" ]
then
	echo "Exiting the program"
	echo "Thank you for playing the game!!"
	exit
elif [ $exit = "n" ]
then
	restart_program #calling restart function
else 
	echo "Invalid Input"
fi
done
}

#function to tell the user that player description is not available and to start from guessing country code
function_select_player(){
		echo "Sorry the player description is absent"
		echo
		function_guess_country #calling country code
}

#function that asks the user to enter the three player code seperating them by spaces and asks to choose one of them using its respective number 
function_guess_player()
{
echo
	echo -e "***********************************************************************************************";
echo -e "\t\t\tLevel 2"
	echo -e "***********************************************************************************************";
echo 
column playercode.txt -t -s "/" #prints the data in tabular format
echo
echo -e "Type three of codes out of these five in any sequences separating them by spaces: \c"
read firstPlayer secondPlayer thirdPlayer fourthPlayer

# if statement to allow only three parameters
if [ -n "$fourthPlayer" ] 
then
	echo "You are allowed to enter three parameters only"
	function_guess_player
fi

# if statement to check repeated parameters 
if [ $firstPlayer = $secondPlayer ] ||[ $secondPlayer = $thirdPlayer ] || [ $firstPlayer = $thirdPlayer ]
then
	echo "You are not allowed to enter same parameters"
	function_guess_player
fi

echo "---------------------";
echo -e "\tMENU";
echo -e "\t1)"$firstPlayer 
echo -e "\t2)"$secondPlayer
echo -e "\t3)"$thirdPlayer
echo "---------------------";

while :; do
echo "You are required to choose one among three using its respective number: " ;
read pnum

#if statement to check whether the input falls between 1-3 or not
if [ $pnum == 1 ];
then
	if [[ $firstPlayer == "PK" ]] || [[ $firstPlayer == "VK" ]] || [[ $firstPlayer == "DW" ]]; #if statement to print description of player that is in no.1 between PK,VK & DW
	then
		cat $firstPlayer
		echo
		function_exit #calling exit function
	else
		function_select_player #calling function_select_player
	fi
elif [ $pnum == 2 ];
then 
	if [[ $secondPlayer == "PK" ]] || [[ $secondPlayer == "VK" ]] || [[ $secondPlayer == "DW" ]];#if statement to print description of player that is in no.2 between PK,VK & DW
	then
			cat $secondPlayer
			echo 
			function_exit #calling exit function
	else
		function_select_player #calling function_select_player
	fi
elif [ $pnum == 3 ];	
then
	if [[ $thirdPlayer == "PK" ]] || [[ $thirdPlayer == "VK" ]] || [[ $thirdPlayer == "DW" ]];#if statement to print description of player that is in no.3 between PK,VK & DW
	then	
		cat $thirdPlayer
		echo
		function_exit #calling exit function 
	else 
		function_select_player #calling function_select_player
	fi
else
	echo "Invalid input"
fi

done
}

#function for the verification of key 
key_verification_function(){
counter=0	 #setting the counter to zero	
until [ $counter -eq 4 ] 
	do
		if [ $key = 1234 ]
		then
			welcome_function #calling welcome function
			start_game_function # calling start game function
			function_guess_player #calling start guess function player
		else
		counter=$(($counter+1)) #increaseing the value of counter by 1
		echo "You have entered wrong key"
		secret_key_function #calling the secret_key_function if users enters wrong key
		fi
done
echo "Exiting the program"
exit
}
key_verification_function #calling the key verification function