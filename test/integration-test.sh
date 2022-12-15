#!/bin/bash

TEST_ACCESS_TOKEN="pepitogrillo"
API_URL=https://pinocho.execute-api.eu-south-2.amazonaws.com

#################
### FUNCTIONS ###
#################

function testQuery() {
  echo 'Test Query' 
  curl -i $API_URL/v1/catalog/books/2
}

function testCommand() {
  echo 'Test Command'
  curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TEST_ACCESS_TOKEN" \
    -X POST \
    -i \
    -d '{"name": "Book Name", "description": "Book Description"}' \
    $API_URL/catalog/v1/books
}


testQuery
echo -e "\n\n*****************\n"
testCommand