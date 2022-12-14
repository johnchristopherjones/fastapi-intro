from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI()


class Item(BaseModel):
    name: str = Field(title="Pen Name", description="Names of pens")
    price: float
    is_offer: bool | None = None


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
async def read_item(item_id: int = 1, q: str | None = None):
    return {"item_id": item_id, "q": q}


@app.put("/items/{item_id}")
async def create_item(item_id: int, item: Item):
    return {"item_name": item.name, "item_id": item_id}
