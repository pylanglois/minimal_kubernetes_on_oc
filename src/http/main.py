from fastapi import FastAPI
import os
import redis

app = FastAPI()
r = redis.Redis(
    host=f"{os.environ['APPLICATION_NAME']}-service-redis",
    port=6379)

for n in range(10):
    r.rpush('queue_a', f'bar-{n}')


@app.get("/")
async def root():
    return {
        "message": "Hello World!!!",
        "redis": r.lpop('queue_a')
    }
