from fastapi import FastAPI
from dotenv import load_dotenv
import os

load_dotenv()
app = FastAPI()

api_key = os.getenv("USDA_API_KEY")