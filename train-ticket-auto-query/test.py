import logging
from queries import Query
from scenarios import query_and_preserve
import time

url = 'http://localhost:8080'

# login train-ticket and store the cookies
q = Query(url)
if not q.login():
    logging.fatal('login failed')
    exit(1)

logging.info('login successfully')

# execute scenario on current user
# query_and_preserve(q)
while(True):
    time.sleep(1)
    print("q.query_normal_ticket()")
    q.query_normal_ticket()

# or execute query directly
# q.query_high_speed_ticket()