#!/bin/bash
function  dbChecker {
  local DBNAME=$1
  local USER=muhammedahmed
  local PASSWORD=123
    mysql -u $USER -p${PASSWORD} -e "show databases;" | grep "${DBNAME}" > /dev/null 2>&1
    if [ $? -ne 0 ]
        then
          mysql -u muhammedahmed -p${PASSWORD} -e "create database ${DBNAME};"

    fi
    echo "CREATE TABLE if not exists ${DBNAME}.invoices (id int primary key, customer varchar(60), invoice_date date , total int)"

    mysql -u muhammedahmed -p${PASSWORD} -e "CREATE TABLE if not exists ${DBNAME}.invoice_details (product_name varchar(30) DEFAULT NULL,unit_price int DEFAULT NULL,no int DEFAULT NULL,invoice_id int DEFAULT NULL,KEY invoice_id (invoice_id), FOREIGN KEY (invoice_id) REFERENCES invoices (id));"

    return $?
}

dbChecker bash_lab

function invoiceChecker {
   local  INVOICEID=$1
    #echo $(mysql -u muhammedahmed -p123 -e "select count(*) from bash_lab.invoices where id=$INVOICEID;")
   COUNT=$(mysql -u muhammedahmed -p123 -e "select count(*) from bash_lab.invoices where id=$INVOICEID;" | tail  -1 )
   echo $COUNT
    return $COUNT
}
#invoiceChecker 1
function checkDetails
{
    INVOICEID=$1;

    COUNT=$(invoiceChecker $INVOICEID)
    #echo $COUNT
    if [ $COUNT -eq 0 ]
    then
      return 1
    fi
    ISDETAILS=$(mysql -u muhammedahmed -p123 -e "select count(*) from bash_lab.invoice_details where invoice_id=$INVOICEID;" | tail  -1 )
    if [ $ISDETAILS -eq 0 ]
        then
          return 2
        fi
    return 0
}








