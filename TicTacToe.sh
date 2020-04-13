#/bin/bash -x

# constant
ROW=3
COLUMN=3

# variable
declare -A board

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

# ticTacToc main function
function ticTacToe()
{
	board
	display
}

# invoke ticTacToe
echo "**************Start Tic Tac Toe Game**************"
ticTacToe



