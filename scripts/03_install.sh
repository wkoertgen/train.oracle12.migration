# as user oracle
# from earlier installations we have an Oracle12Install.rsp in place, we customize it to this
# 3.10.0-123.el7.x86_64 x86_64 GNU/Linux in the VagrantBox
cd /vagrant/files/Oracle12/database
./runInstaller -showProgress -silent -waitforcompletion -ignorePrereq \
# full pathname in VagrantBox
-responseFile /u01/app/Ora12Install.rsp

