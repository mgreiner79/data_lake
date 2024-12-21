cd databuilder
echo "activate python venv..."
source venv/Scripts/activate
echo "syncing postgres db"
python example_mpi/scripts/sample_postgres_loader.py

read -p "Press enter to resume ..."