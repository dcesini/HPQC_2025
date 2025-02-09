sudo yum install git
git clone https://baltig.infn.it/rossitisbeni/LogSimulator.git
ls
cd LogSimulator/
git clone https://github.com/logpai/loghub
ls loghub/
vim logsimulator.py
vim static/data/template.json    #change the paths!!! #ADD "Open" to SSH
ls ./loghub/OpenSSH/
vim static/data/template.json
python logsimulator.py &
tail -f logsimulator.log

