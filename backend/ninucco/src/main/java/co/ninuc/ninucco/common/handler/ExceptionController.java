package co.ninuc.ninucco.common.handler;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class ExceptionController {

    final boolean FAIL = false;

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ApiResult<Res>> handleCustomException(CustomException ex) {
        log.error("handleCustomException : {}", ex.getErrorRes().getCode());
        return ResponseEntity.ok(new ApiResult<>(FAIL, ex.getErrorRes()));
    }
}
