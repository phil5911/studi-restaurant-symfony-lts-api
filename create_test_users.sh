#!/bin/bash

# Nombre d'utilisateurs à créer
N=5
BASE_URL="http://localhost:8080"

for i in $(seq 1 $N)
do
  EMAIL="user${i}@test.com"
  TOKEN="token_${i}_$(date +%s)"

  # Supprimer l'utilisateur existant pour éviter les doublons
  curl -s -X DELETE $BASE_URL/api/admin/delete-user \
    -H "Content-Type: application/json" \
    -d "{\"email\":\"$EMAIL\"}"

  # Créer l'utilisateur
  RESPONSE=$(curl -s -X POST $BASE_URL/api/registration \
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



