package co.ninuc.ninucco.api.dto.interservice;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
public class PromptToImgReq {
    @JsonValue
    List<Prompt> text_prompts;
    final int cfg_scale=7;
    final String clip_guidance_preset = "FAST_BLUE";
    final int height = 512;
    final int width= 512;
    final int samples= 1;
    final int steps= 30;
    public PromptToImgReq(String prompt) {
        this.text_prompts = new ArrayList<>();
        this.text_prompts.add(new Prompt(prompt));
    }
}
