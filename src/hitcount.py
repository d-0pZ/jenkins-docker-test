import redis
# connect to redis server
r = redis.Redis(host='0.0.0.0', port=6379, db=0)

# increase the hit count for the usr
def hit(usr):
    r.incr(usr)

def getHit(usr):
    return (r.get(usr))