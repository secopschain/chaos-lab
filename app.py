from flask import Flask, request
import time
import random
import logging
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)

# Prometheus Metrics
metrics = PrometheusMetrics(app)

# Logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route("/")
def home():
    logger.info("Home endpoint called")
    return "Hello DevOps"

@app.route("/slow")
def slow():
    delay = random.uniform(1, 5)
    time.sleep(delay)
    logger.warning(f"Slow request: {delay:.2f}s")
    return f"Slow response: {delay:.2f}s"

@app.route("/error")
def error():
    logger.error("Error endpoint triggered!")
    return "Something went wrong", 500

@app.route("/log")
def log_spam():
    for i in range(100):
        logger.error(f"Log spam {i}")
    return "Logs generated"

if __name__== "__main__":
    app.run(host="0.0.0.0", port=5000)