from fastapi import FastAPI, Request
from pydantic import BaseModel
import torch
from diffusers import StableDiffusionPipeline
from io import BytesIO
from PIL import Image
import base64

app = FastAPI()

# Load the model
device = "cuda" if torch.cuda.is_available() else "cpu"
model_id = "CompVis/stable-diffusion-v1-4"
pipe = StableDiffusionPipeline.from_pretrained(model_id).to(device)

class PromptRequest(BaseModel):
    prompt: str

@app.post("/generate/")
async def generate_image(request: PromptRequest):
    prompt = request.prompt
    image = pipe(prompt).images[0]
    
    # Save the image to a byte stream
    buffered = BytesIO()
    image.save(buffered, format="PNG")
    img_str = base64.b64encode(buffered.getvalue()).decode('utf-8')
    
    return {"image": img_str}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
