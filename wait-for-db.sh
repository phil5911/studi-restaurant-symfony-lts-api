#!/bin/bash
echo "⏳ Attente de la base de données MySQL sur db:3306..."

until nc -z db 3306; do
  sleep 1
done

echo "✅ Base de données disponible ! Démarrage d'Apache..."
exec apache2-foreground
