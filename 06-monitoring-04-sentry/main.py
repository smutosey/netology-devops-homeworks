from fastapi import FastAPI
import sentry_sdk

sentry_sdk.init(
    dsn="https://a4c47f21a162c60d7d27304d2e0f35a1@o4506701026295808.ingest.sentry.io/4506701091241984",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    traces_sample_rate=1.0,
    # Set profiles_sample_rate to 1.0 to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    profiles_sample_rate=1.0,
)

app = FastAPI()
@app.get("/sentry-debug")
async def trigger_error():
    division_by_zero = 1 / 0