Основная концепция - использование готовых наработок с минимальным вмешательством.

Скрипт deploy.sh разварачивает кластер в AWS EKS, создаёт нужные namespace, поднимает приложения из чартов используя кастомные values.yaml. Для графаны добавляются dasboards.

http://3.122.231.150:30090/graph  - prometheus

http://3.122.231.150:30110/?orgId=1  - grafana, user/user. Добавлен дашбоард для apache exporter из wordpress. Так же добавлен дашбоард для nginx ingress

http://3.122.231.150:32080/ или http://af0070e023bce44baa26231fc1d1337f-586915009.eu-central-1.elb.amazonaws.com/  - wordpress, в качестве basic web application.

http://3.122.231.150:30903/#/alerts  - alertmanager