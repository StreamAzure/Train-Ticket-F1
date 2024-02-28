import logging
from queries import Query
from scenarios import *
import time

url = 'http://localhost:8080'

# login train-ticket and store the cookies
q = Query(url)
if not q.login():
    print('login failed')
    exit(1)

print('login successfully')

# execute scenario on current user
# query_and_preserve(q)
query_and_preserve(q)
query_and_cancel(q)

# or execute query directly
# q.query_high_speed_ticket()