# create venv directory one time. assume python interpreter is installed
# venv's should be used, as they are
# only needed as dev (not on server)

# first upgrade python pip
python -m pip install --upgrade pip
# first upgrade python pip
python -m pip install virtualenv
# remove old venv dir if exists
rm -rf venv
# create venv dir
python -m virtualenv venv
# activate
source ./venv/Scripts/activate
# install requirements
pip install -r requirements.txt