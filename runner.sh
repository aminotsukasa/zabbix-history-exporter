RANGE=86400 KEY="system.cpu.load[percpu,avg1]" HOST="Zabbix-server" ZABBIX_PASSWORD=term25oo php history-export.php | Rscript mean.r | zabbix_sender -vv -z localhost -p 10051   -T -i -


RANGE=86400 KEY="system.cpu.switches" HOST="Zabbix-server" ZABBIX_PASSWORD=term25oo php history-export.php | Rscript mean.r | zabbix_sender -vv -z localhost -p 10051   -T -i -
