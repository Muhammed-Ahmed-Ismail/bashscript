#!/bin/bash
source checker.sh
USERNAME=muhammedahmed
USERPASSWORD=123
DATABASENAME=bash_lab
INVOICETABLE=invoices
INVOICEDETAILS=invoice_details
CONNECTION="-u ${USERNAME} -p${USERPASSWORD}"

function displayInvoice  {
  ID=$1
  EXIST=$(invoiceChecker ${ID})
 if [ $EXIST -eq 0 ]
    then
      return 1
 fi
 mysql $CONNECTION -e "select * from ${DATABASENAME}.${INVOICETABLE} where id=${ID}"

 return 0
}

function insertInvoice {
    ID=$1
    CUSTOMER=$2
    Date=$3
    Total=$4
    CHECK=$(invoiceChecker $ID)
    if [ $CHECK -ne 0 ]
        then
        return 1
    fi
    #echo "$CONNECTION -e "insert into ${DATABASENAME}.${INVOICETABLE} values  \( ${ID},\"${CUSTOMER}\"\,\"${Date}\",${Total}\)""
    mysql $CONNECTION -e "insert into ${DATABASENAME}.${INVOICETABLE} values  ( ${ID},\"${CUSTOMER}\",\"${Date}\",${Total});"
    return 0

}
#insertInvoice 88 foo 2020-6-10 500
function insertInvoiceDetails
{
      ID=$1
      PRODUCTNAME=$2
      NO=$3
      PRICE=$4
      CHECK=$(invoiceChecker $ID)
      echo $CHECK

      if [ $CHECK -eq 0 ]

          then
          return 1
      fi

      mysql $CONNECTION -e "insert into ${DATABASENAME}.${INVOICEDETAILS} values  (\"${PRODUCTNAME}\",${PRICE},${NO},${ID});"

      return 0

}
#insertInvoiceDetails 1 HH 3 29

function deleteInvoice
{
     ID=$1
        COUNT=$(invoiceChecker $ID)
        echo $COUNT
        if [ $COUNT -eq 0 ]
            then
            return 1
        fi
        mysql $CONNECTION -e " delete  from ${DATABASENAME}.${INVOICEDETAILS} where invoice_id = ${ID}"
        mysql $CONNECTION -e " delete  from ${DATABASENAME}.${INVOICETABLE} where id = ${ID}"
        return 0
}
#