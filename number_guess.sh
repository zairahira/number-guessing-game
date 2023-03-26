#!/bin/bash

PSQL_CMD="psql --username=freecodecamp --dbname=game -t --no-align -c"

# Prompt for username
echo "Enter your username:"
read USERNAME_INPUT

# Get user_id
USER_ID=$($PSQL_CMD "SELECT user_id FROM usernames WHERE username = '$USERNAME_INPUT'")

# check if USERNAME_INPUT exists
if [[ -z $USER_ID ]]
then
echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."

# save username
SAVE_RESULT=$($PSQL_CMD "INSERT INTO usernames (username) VALUES ('$USERNAME_INPUT')")

# get user_id
USER_ID=$($PSQL_CMD "SELECT user_id FROM usernames WHERE username = '$USERNAME_INPUT'")

else
GAME_PLAYED=$($PSQL_CMD "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")
BEST_GAME=$($PSQL_CMD "SELECT MIN(guess_number) FROM games WHERE user_id = $USER_ID")
echo "Welcome back, $USERNAME_INPUT! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Choose a random number between 1 and 1000
R_NUMBER=$((RANDOM % 1000 + 1))

# guess counter
COUNTER=0

# First guess
echo "Guess the secret number between 1 and 1000:"
read GUESSED_NUMBER
COUNTER=$((COUNTER+1))
while [[ ! $GUESSED_NUMBER =~ ^[0-9]+$ ]]
do
echo "That is not an integer, guess again:"
read GUESSED_NUMBER
COUNTER=$((COUNTER+1))
done

while [[ $GUESSED_NUMBER -ne $R_NUMBER ]]
do

# in case guess too low
if [[ $GUESSED_NUMBER -lt $R_NUMBER ]]
then
echo "It's higher than that, guess again:"
read GUESSED_NUMBER
COUNTER=$((COUNTER+1))
while [[ ! $GUESSED_NUMBER =~ ^[0-9]+$ ]]
do
echo "That is not an integer, guess again:"
read GUESSED_NUMBER
COUNTER=$((COUNTER+1))
done
fi

# When guess higher than expected
if [[ $GUESSED_NUMBER -gt $R_NUMBER ]]
then
echo "It's lower than that, guess again:"
read GUESSED_NUMBER
COUNTER=$((COUNTER+1))
while [[ ! $GUESSED_NUMBER =~ ^[0-9]+$ ]]
do
echo "That is not an integer, guess again:"
read GUESSED_NUMBER
COUNTER=$((COUNTER+1))
done
fi

done

# In case the number is correctly guessed
echo "You guessed it in $COUNTER tries. The secret number was $R_NUMBER. Nice job!"

# save the result
SAVE_RESULT=$($PSQL_CMD "INSERT INTO games (user_id, guess_number, won) VALUES ($USER_ID, $COUNTER, true)")
