assumed that there will be firewall and Incapsula DNS setup already for the app environment.

setup of the 3 tiers, 

web tier - (firewall, application gateway)
business tier - (azure k8s service)
data tier - (mysql database, redis cache server)

routing of user requests will be as follows,

Internet <> Incapsula/Firewall > appgateway > k8s > database/cache
