#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    QUERY_RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e INNER JOIN properties p ON e.atomic_number=p.atomic_number INNER JOIN types t ON p.type_id=t.type_id WHERE e.atomic_number=$1")
  else
    QUERY_RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e INNER JOIN properties p ON e.atomic_number=p.atomic_number INNER JOIN types t ON p.type_id=t.type_id WHERE e.symbol='$1' OR e.name='$1'")
  fi

  if [[ -z $QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read ATOMIC_NUMBER NAME SYMBOL MASS MELTING BOILING TYPE <<< "$QUERY_RESULT"
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi
fi

#my second commit
#my thirth commit
#my fourth commit
#my fifth commit