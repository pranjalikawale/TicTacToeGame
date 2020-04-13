#/bin/bash -x

# constant
ROW=3
COLUMN=3
HUMAN="Human"
COMPUTER="Computer"

# variable
declare -A board
declare -A player=([$HUMAN]=O [$COMPUTER]=O)

# initialize board
function board()
{
   for ((i=0;i<$ROW;i++))
   do
      for ((j=0;j<$COLUMN;j++))
      do
         board[$i,$j]=" "
      done
   done
}

# display board
function display()
{
   for ((i=0;i<$ROW;i++))
   do
      for ((j=0;j<$COLUMN;j++))
      do
         echo -n " ${board[$i,$j]} "
         if [[(($j < 2))]]
         then
            echo -n " | "
         fi
      done
   echo

   if [[ $i < 2 ]]
   then
      echo "----+-----+----"
   fi
   done
}

# assign symbol to player
function assignSymbol()
{
   if [[ "$(getRandom)" -eq 0 ]]
   then
      player[$HUMAN]=X
   else
      player[$COMPUTER]=X
   fi
}

# return random nos
function getRandom()
{
   MAX=1
   MIN=0
   echo $((RANDOM%($MAX-$MIN+1)+$MIN))
}

# display symbol
function displaySymbol()
{
   for symbol in "${!player[@]}"
   do
      echo "$symbol received ${player[$symbol]} symbol"
   done
}

# ticTacToc main function
function ticTacToe()
{
	board
	display
	assignSymbol
	displaySymbol
}

# invoke ticTacToe
echo "**************Start Tic Tac Toe Game**************"
ticTacToe



