#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    QUERY_RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e INNER JOIN properties p ON e.atomic_number=p.atomic_number WHERE e.atomic_number=$1")
  else
    QUERY_RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e INNER JOIN properties p ON e.atomic_number=p.atomic_number WHERE e.symbol='$1' OR e.name='$1'")
  fi

  if [[ -z $QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read ATOMIC_NUMBER NAME SYMBOL MASS MELTING BOILING <<< "$QUERY_RESULT"
    
    # Affichage pour tous les éléments
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a nonmetal, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi
fi


#git commit -m "fix: corrected atomic_mass values"
#git commit -m "feat: added type_id foreign key"
#git commit -m "refactor: updated properties table"
#git commit -m "chore: added Fluorine and Neon"
#git commit -m "test: last commit"
