#!/bin/bash

source dataop.sh
function printMenu {

  echo "Welcome to Database Simple Manubilator"
  echo "**************************************"
  echo "Menu:"
  echo "*****"
  echo "-Display an invoice press 1 "
  echo "-Insert an invoice press 2 "
  echo "-Insert an invoice details press 3 "
  echo "-Delete an invoice press 4 "
  echo "-Exit press 5 "
}


function displayInvoiceUI
{
  echo "Invoice ID: "
  read ID
  echo $ID
  displayInvoice "$ID"
 # CHECK=$(displayInvoice "$ID")
  CHECK=$?
  if [ $CHECK -eq 1 ]
  then
    echo "No Invoice with such id"
    printMenu
    return 1
  fi
  printMenu
  return 0
}

function insertNewInvoiceUI
{
    echo "Enter Invoice ID"
    read ID
    echo "Enter customcer name"
    read NAME
    echo  "Enter invoice date"
    read DATE
    echo "Enter Invoice Total"
    read TOTAL
  CHECK=$(insertInvoice $ID $NAME $DATE $TOTAL)

  if [ $CHECK -eq 1 ]
  then
        echo "Invoice With the same ID already exists in the system"
   # elif [ $CHECK -ne 0  ]; then
        # echo "Something wrong happend data has not been saved in the data base"
        printMenu
        return 1
    else
      echo "Data Stored Successfully"
      printMenu
      return 0
    fi
}

function insertInvoiceDetailsUI
{
    echo "Enter Invoice ID"
    read ID
    echo "Enter product name"
    read PRODUCTNAME
    echo  "Enter product unit price"
    read PRICE
    echo "Enter number of units"
    read NO

  CHECK=$(insertInvoiceDetails $ID $PRODUCTNAME $NO $PRICE)

  if [ $CHECK -eq 1 ]
  then
        echo "There is no invoce with such id to insert details to it "
        printMenu
        return 1
   # elif [ $CHECK -ne 0  ]; then
        # echo "Something wrong happend data has not been saved in the data base"

    else
      echo "Data Stored Successfully"
      printMenu
      return 0
    fi
}
function deleteInvoiceUI {

  echo "Enter the invoice id you want to delete"

  read ID
  CHECK=$(deleteInvoice $ID)

  if [ $CHECK -eq 1 ]; then

    echo "There is no invoice with such id to delete"
    printMenu
    return 1
  else
    echo "Invoice Deleted successfully"
    printMenu
  fi
}

function main
{
    echo "Enter Your Choice: "
     choice=0
    while [ $choice -ne 5 ];
    do
      read choice
        case $choice in
        1)
          clear
          displayInvoiceUI
          ;;
        2)
          insertNewInvoiceUI
          ;;
        3)
          insertInvoiceDetailsUI
          ;;
        4)
          deleteInvoiceUI
          ;;
        5)
          echo "bye"
          ;;
        *)
          echo "improper choice!!"
        esac
    done

}


printMenu
main