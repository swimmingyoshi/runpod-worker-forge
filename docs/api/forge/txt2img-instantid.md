# Text to Image with InstantID

## Request

```json
{
  "input": {
    "api": {
      "method": "POST",
      "endpoint": "/sdapi/v1/txt2img"
    },
    "payload": {
      "override_settings":{
        "sd_model_checkpoint": "dynavisionXLAllInOneStylized_release0557Bakedvae",
        "CLIP_stop_at_last_layers": 2,
        "sd_vae": "Automatic"
      },
      "prompt": "watercolor painting, vibrant, beautiful, painterly, detailed, textural, artistic",
      "negative_prompt": "(lowres, low quality, worst quality:1.2), (text:1.2), watermark, anime, photorealistic, 35mm film, deformed, glitch, low contrast, noisy",
      "seed": -1,
      "batch_size": 1,
      "steps": 15,
      "cfg_scale": 4.5,
      "width": 960,
      "height": 1280,
      "hr_scale": 1.6,
      "enable_hr": true,
      "hr_prompt": "",
      "hr_upscaler": "R-ESRGAN 4x+",
      "denoising_strength": 0.05,
      "hr_negative_prompt": "",
      "hr_second_pass_steps": 0,
      "sampler_name": "DPM++ SDE Karras",
      "sampler_index": "DPM++ SDE Karras",
      "restore_faces": false,
      "alwayson_scripts": {
        "controlnet": {
          "args": [
            {
              "image": "base64 encoded image content",
              "module": "InsightFace (InstantID)",
              "model": "ip-adapter_instant_id_sdxl [eb2d3ec0]",
              "weight": 0.9,
              "resize_mode": "Crop and Resize",
              "lowvram": false,
              "processor_res": 1024,
              "threshold_a": 75,
              "threshold_b": 75,
              "guidance": 1,
              "guidance_start": 0,
              "guidance_end": 1,
              "control_mode": "Balanced",
              "pixel_perfect": false
            },
            {
              "image": "base64 encoded image content",
              "module": "instant_id_face_keypoints",
              "model": "control_instant_id_sdxl [c5c25a50]",
              "weight": 1,
              "resize_mode": "Crop and Resize",
              "lowvram": false,
              "processor_res": 1024,
              "threshold_a": 75,
              "threshold_b": 75,
              "guidance": 1,
              "guidance_start": 0,
              "guidance_end": 1,
              "control_mode": "Balanced",
              "pixel_perfect": false
            }
          ]
        }
      }
    }
  }
}
```

## Response

### RUN

```json
{
  "id": "83bbc301-5dcd-4236-9293-a65cdd681858",
  "status": "IN_QUEUE"
}
```

### RUNSYNC

```json
{
    "delayTime": 91153,
    "executionTime": 11080,
    "id": "sync-65929d7f-8115-48a7-bd84-198e2330bc85",
    "output": {
        "images": [
            "base64 encoded result image",
            "base64 encoded result image",
            "base64 encoded result image"
        ]
    },
  "status": "COMPLETED"
}
```