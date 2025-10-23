#!/bin/bash

for i in {1..5}
do
  EMAIL="user${i}@test.com"
  TOKEN="token_${i}_$(date +%s)"

  RESPONSE=$(curl -s -X POST http://127.0.0.1/api/registration \
    -H "Content-Type: application/json" \
    -d "{
      \"email\": \"$EMAIL\",
      \"password\": \"123456\",
      \"first_name\": \"User${i}\",
      \"last_name\": \"Test\",
      \"api_token\": \"$TOKEN\",
      \"roles\": [\"ROLE_USER\"]
    }")

  echo -e "\nCreated user: $EMAIL"
  echo "Response: $RESPONSE"
done
