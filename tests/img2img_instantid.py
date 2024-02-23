#!/usr/bin/env python3
from util import *


if __name__ == '__main__':
    image_content = encode_image_to_base64('../data/src.jpg')

    payload = {
        "input": {
            "api": {
                "method": "POST",
                "endpoint": "/sdapi/v1/img2img"
            },
            "payload": {
                "init_images": [
                    image_content
                ],
                "override_settings":{
                    "sd_model_checkpoint": "dynavisionXLAllInOneStylized_release0557Bakedvae",
                    "CLIP_stop_at_last_layers": 2,
                    "sd_vae": "Automatic"
                },
                "prompt": "Clown from the movie it",
                "negative_prompt": "closed eyes, looking up, back and white, blush, white frame, frame, panties, ribs, muscular, busty, lens flare, bloom, red eyes, grayscale, monochrome, big breast, large breast, pubic hair, bad quality, low quality",
                "seed": -1,
                "batch_size": 1,
                "steps": 20,
                "cfg_scale": 4.5,
                "width": 960,
                "height": 1280,
                "denoising_strength": 1,
                "sampler_name": "DPM++ SDE Karras",
                "sampler_index": "DPM++ SDE Karras",
                "restore_faces": False,
                "alwayson_scripts": {
                    "controlnet": {
                        "args": [
                            {
                                "module": "InsightFace (InstantID)",
                                "model": "ip-adapter_instant_id_sdxl [eb2d3ec0]",
                                "weight": 0.9,
                                "resize_mode": "Crop and Resize",
                                "lowvram": False,
                                "processor_res": 1024,
                                "threshold_a": 75,
                                "threshold_b": 75,
                                "guidance": 1,
                                "guidance_start": 0,
                                "guidance_end": 1,
                                "control_mode": "Balanced",
                                "pixel_perfect": True
                            },
                            {
                                "module": "instant_id_face_keypoints",
                                "model": "control_instant_id_sdxl [c5c25a50]",
                                "weight": 1,
                                "resize_mode": "Crop and Resize",
                                "lowvram": False,
                                "processor_res": 1024,
                                "threshold_a": 75,
                                "threshold_b": 75,
                                "guidance": 1,
                                "guidance_start": 0,
                                "guidance_end": 1,
                                "control_mode": "Balanced",
                                "pixel_perfect": True
                            }
                        ]
                    }
                }
            }
        }
    }

    post_request(payload)
