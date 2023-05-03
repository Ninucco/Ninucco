package co.ninuc.ninucco.api.dto.interservice;

import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Builder;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class ImgToImgReq {
    @JsonValue
    List<Prompt> text_prompts;
    byte[] init_image;
    final String init_image_mode = "IMAGE_STRENGTH";
    final float image_strength = 0.35f;
    final int cfg_scale=7;
    final String clip_guidance_preset = "FAST_BLUE";
    //final String sampler;
    final int samples= 1;
    //final int seed;
    //final String stype_preset;
    final int steps= 30;
    @Builder
    public ImgToImgReq(byte[] init_image, String prompt) {
        this.init_image = init_image;
        this.text_prompts = new ArrayList<>();
        this.text_prompts.add(new Prompt(prompt));
    }
}
