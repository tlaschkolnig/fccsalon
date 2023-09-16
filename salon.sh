#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

#script to handle salon appointments

echo -e "\n~~ Welcome to this salon. Let's get your hair or beard done ~~\n"

MAIN_MENU(){
if [[ $1 ]]
then
  echo -e "\n$1"
fi

SERVICE_NUMBER1=$($PSQL "SELECT service_id FROM services WHERE service_id = 1")
SERVICE_NAME1=$($PSQL "SELECT name FROM services WHERE service_id = 1")
SERVICE_NUMBER2=$($PSQL "SELECT service_id FROM services WHERE service_id = 2")
SERVICE_NAME2=$($PSQL "SELECT name FROM services WHERE service_id = 2")
SERVICE_NUMBER3=$($PSQL "SELECT service_id FROM services WHERE service_id = 3")
SERVICE_NAME3=$($PSQL "SELECT name FROM services WHERE service_id = 3")

echo -e "What service do you wish?"
echo -e "\n1) cut\n2) shave\n3) wash"
echo -e "\n $SERVICE_NUMBER1) $SERVICE_NAME1 \n $SERVICE_NUMBER2) $SERVICE_NAME2 \n $SERVICE_NUMBER3) $SERVICE_NAME3"

read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
  1) CUT_MENU ;;
  2) SHAVE_MENU ;;
  3) WASH_MENU ;;
  *) MAIN_MENU "we don't offer that option at the current moment. Therefore, please, PLEASE choose something out of the list of these items." ;;
esac
}

  CUT_MENU() {
    echo -e "\nFantastic, I'll put you down for a cutting down of your hair, and for a little tip, we can cut some other stuff too of course.\nNow, what is your phone number?"
    #get phone number
    read CUSTOMER_PHONE
    #check if phone number exists in database
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    #if doesnt exist, asks customer for futher information
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nLooks like you're new with us. That's fantastic, but we'll need some information. What's your name?"
      read CUSTOMER_NAME
      #create new customer
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    #ask for timeslot
    echo -e "\nFor what time would you want your service? We're a 24hour service, however quality might vary depending on the time of day or night."
    read SERVICE_TIME
    SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    SERVICE_SELECTED_FORMATTED=$(echo $SERVICE_SELECTED | sed 's/ //')
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ //')
    #insert appointment into appointment table
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    #give confirmation message
    echo -e "\nI have put you down for a $SERVICE_SELECTED_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
  }

  SHAVE_MENU(){
    echo -e "\nFantastic, I'll put you down for a shaving down of your beard, and for a little tip, we can cut some other stuff too of course.\nNow, what is your phone number?"
    #get phone number
    read CUSTOMER_PHONE
    #check if phone number exists in database
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    #if doesnt exist, asks customer for futher information
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nLooks like you're new with us. That's fantastic, but we'll need some information. What's your name?"
      read CUSTOMER_NAME
      #create new customer
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    #ask for timeslot
    echo -e "\nFor what time would you want your service? We're a 24hour service, however quality might vary depending on the time of day or night."
    read SERVICE_TIME
    SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    SERVICE_SELECTED_FORMATTED=$(echo $SERVICE_SELECTED | sed 's/ //')
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ //')
    #insert appointment into appointment table
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    #give confirmation message
    echo -e "\nI have put you down for a $SERVICE_SELECTED_FORMATTED at '$SERVICE_TIME', $CUSTOMER_NAME_FORMATTED."
  }

  WASH_MENU(){
    echo -e "\nFantastic, I'll put you down for a wash.\nNow, what is your phone number?"
    #get phone number
    read CUSTOMER_PHONE
    #check if phone number exists in database
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    #if doesnt exist, asks customer for futher information
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nLooks like you're new with us. That's fantastic, but we'll need some information. What's your name?"
      read CUSTOMER_NAME
      #create new customer
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    #ask for timeslot
    echo -e "\nFor what time would you want your service? We're a 24hour service, however quality might vary depending on the time of day or night."
    read SERVICE_TIME
    SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    SERVICE_SELECTED_FORMATTED=$(echo $SERVICE_SELECTED | sed 's/ //')
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ //')
    #insert appointment into appointment table
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    #give confirmation message
    echo -e "\nI have put you down for a $SERVICE_SELECTED_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
  }


MAIN_MENU