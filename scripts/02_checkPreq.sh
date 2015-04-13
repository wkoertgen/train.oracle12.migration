# as oracle
# we prefer to see the results of 
# go to your installation scripts, in this case
cd /vagrant/files/Oracle12/database
./runInstaller -executePrereqs -silent

# this will create in /tmp an InstallActions<timestamp>.log, which we recommed 
# to save and to revise 
# Overall status is not passed, with warnings: some packages are missing, some
# sizes are missing (swap, ulimit), kernel parameters are too low
# The installation will perhaps succeed, but to run several databases we must take steps.

