from fastapi import FastAPI, HTTPException, Query
from dotenv import load_dotenv
import os
import httpx

load_dotenv()
app = FastAPI()

USDA_API_KEY = os.getenv("USDA_API_KEY")
if not USDA_API_KEY:
    raise RuntimeError("USDA_API_KEY missing. Put it in .env")

USDA_BASE = "https://api.nal.usda.gov/fdc/v1"

@app.get("/api/search")
async def search_foods(
    q: str = Query(..., min_length=1),
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=50),
):
    params = {
        "api_key": USDA_API_KEY,
        "query": q,
        "pageNumber": page,
        "pageSize": page_size,
    }
    async with httpx.AsyncClient(timeout=10) as client:
        r = await client.get(f"{USDA_BASE}/foods/search", params=params)

    if r.status_code != 200:
        raise HTTPException(status_code=r.status_code, detail=r.text)

    data = r.json()
    names = [f.get("description") or "" for f in data.get("foods", [])]

    return {"items": [{"name": n} for n in names]}