#!/bin/bash

TEST_ACCESS_TOKEN="pepitogrillo"
API_URL=https://pinocho.execute-api.eu-south-2.amazonaws.com

#################
### FUNCTIONS ###
#################

function testQuery() {
  curl -i $API_URL/v1/books/2
}

function testCommand() {
curl -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TEST_ACCESS_TOKEN" \
  -X POST \
  -i \
  -d '{"name": "Book Name", "description": "Book Description"}' \
  $API_URL/v1/books
}


testQuery
testCommand