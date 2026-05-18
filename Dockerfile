# Image de base
FROM python:3.10-slim

# Répertoire de travail
WORKDIR /app

# Copier les dépendances et les installer
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code
COPY . .

# Commande pour lancer l'application
CMD ["streamlit", "run", "src/Home.py"]