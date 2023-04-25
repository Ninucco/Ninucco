package co.ninuc.ninucco.common.exception;

import co.ninuc.ninucco.api.dto.ErrorRes;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class CustomException extends RuntimeException {
    private final ErrorRes errorCode;
}
