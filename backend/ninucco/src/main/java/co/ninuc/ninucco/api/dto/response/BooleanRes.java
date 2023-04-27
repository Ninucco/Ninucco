package co.ninuc.ninucco.api.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class BooleanRes {

    boolean success;

    @Builder
    public BooleanRes(boolean success) {
        this.success = success;
    }
}
