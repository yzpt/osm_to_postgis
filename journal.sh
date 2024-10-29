# venv
python3 -m venv venv_osm_postgres
source venv_osm_postgres/bin/activate

sudo apt-get install libpq-devù
pip install osmnx geopandas sqlalchemy psycopg2 geoalchemy2 nbformat
pip install ipykernel plotly matplotlib nbconvert


# === postgresql
# 1. Start and enable PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Install the PostGIS extension
sudo apt-get update
sudo apt-get install postgis postgresql-14-postgis-3
sudo systemctl restart postgresql

# 2. Access the PostgreSQL prompt as the default postgres user
sudo -u postgres psql

# 3. Inside the PostgreSQL prompt, run the following SQL commands:

# Create a new database
CREATE DATABASE osm_database;

# Create a new user with a password
CREATE USER yzpt WITH PASSWORD 'pwd';

# Grant the user privileges on the database
GRANT ALL PRIVILEGES ON DATABASE osm_database TO yzpt;

# Connect to the new database
\c osm_database;

# Enable the PostGIS extension
CREATE EXTENSION postgis;

# Exit PostgreSQL prompt
\q

# 4. (Optional) Allow remote connections:
# Edit postgresql.conf to allow remote connections
sudo nano /etc/postgresql/14/main/postgresql.conf
# Set listen_addresses to '*' in postgresql.conf
# listen_addresses = '*'

# Edit pg_hba.conf to allow remote connections from any IP (or a specific IP range)
sudo nano /etc/postgresql/14/main/pg_hba.conf
# Add the following line to pg_hba.conf
# host    all             all             0.0.0.0/0               md5

# Restart PostgreSQL to apply changes
sudo systemctl restart postgresql

rm -rf .git
git init
git add .
git branch -M main
git commit -m "first commit"
gh repo create osm_to_postgis --public
git remote add origin https://github.com/yzpt/osm_to_postgis.git
git push -u origin main
