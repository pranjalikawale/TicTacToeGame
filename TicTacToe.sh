#/bin/bash -x

# constant
ROW=3
COLUMN=3
HUMAN="Human"
COMPUTER="Computer"

# variable
declare -A board
declare -A player=([$HUMAN]=O [$COMPUTER]=O)
playing=" "
counter=1
row=-1
col=-1
isvalid=1
gameOn=1

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

# find who play first
function playFirst()
{
   if [[ "$(getRandom)" -eq 0 ]]
   then
      playing=$HUMAN
   else
      playing=$COMPUTER
   fi
   echo "$playing(${player[$playing]}) win toss & play first"
}

# read inut for board
function input()
{
   row=-1
   col=-1
   while true
   do
      if [ $HUMAN == $playing ]
      then
         read -p "Enter the row from 1-3" row
         read -p "Enter the column from 1-3" col
         ((row--))
         ((col--))
      else
			row="$(getInput)"
   		col="$(getInput)"
      fi
      valid
      if [[ (($isvalid -eq 1)) ]]
      then
         insert $playing
         break
      fi
   done
}

# get random input for row and col for computer
function getInput()
{
  echo $((RANDOM%3))
}

# check for valid row and col
function valid()
{
   isEmpty
   if [[ $isvalid -eq 1 ]]
   then
      if [[ (($row -lt 0)) && (($row -gt $ROW)) && (($col -lt 0)) && (($col -gt $COLUMN)) ]]
      then
         if [ $HUMAN == $playing ]
         then
            echo "Invalid $row & $col value !!!"
         fi
         isvalid=0
      fi
   fi
}

# check for empty space in board
function isEmpty()
{
   if [[ ${board[$row,$col]} == " " ]]
   then
      isvalid=1
   else
      if [ $HUMAN == $playing ]
      then
         echo "Already taken !!!"
      fi
      isvalid=0
   fi
}

# insert into the board
function insert()
{
   board[$row,$col]="${player[$playing]}"
   ((counter++))
}

# check for win
function win()
{
	# check row for winning condition
   for ((rows=0;rows<$ROW;rows++))
   do
      if [[ ${board[$rows,0]} == ${board[$rows,1]} && ${board[$rows,1]} == ${board[$rows,2]} && (( ${board[$rows,0]} != " "   )) ]]
      then
         echo "Player $playing (${board[$rows,0]}) is won!!!!"
         gameOn=0
      fi
   done

	# check col for winning condition
   for ((cols=0;cols<$COLUMN;cols++))
   do
      if [[ ${board[0,$cols]} == ${board[1,$cols]} && ${board[1,$cols]} == ${board[2,$cols]} && (( ${board[0,$cols]} != " " )) ]]
      then
         echo "Player $playing (${board[0,$cols]}) is won!!!!"
         gameOn=0
      fi
   done

	# check diagonal 1 for winning condition
   if [[ ${board[0,0]} == ${board[1,1]} && ${board[1,1]} == ${board[2,2]} && (( ${board[0,0]} != " ")) ]]
   then
      echo "Player $playing (${board[0,0]}) is won!!!!"
      gameOn=0
   fi

	# check diagonal 2 for winning condition
   if [[ ${board[1,2]} == ${board[1,1]} && ${board[1,1]} == ${board[2,1]} && (( ${board[1,1]} != " " )) ]]
   then
      echo "Player $playing (${board[1,1]}) is won!!!!"
      gameOn=0
   fi
}

# check for tie
function tie()
{
   if [[ counter -gt 10 ]]
   then
      echo "*******GAME TIE*******"
      gameOn=0
   fi
}

# switch player turn
function switchPlayer()
{
   if [ $playing == $HUMAN ]
   then
         playing=$COMPUTER
   else
         playing=$HUMAN
   fi
   if [[ $gameOn == 1 ]]
   then
      echo "$playing turn:"
   fi
}


# ticTacToc main function
function ticTacToe()
{
	board
	display
	assignSymbol
	displaySymbol
	playFirst
	while [[ $gameOn -eq 1 ]]
	do
   	input
   	display
   	tie
   	win
   	switchPlayer
	done
}

# invoke ticTacToe
echo "**************Start Tic Tac Toe Game**************"
ticTacToe



