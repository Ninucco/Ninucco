package co.ninuc.ninucco.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@Getter
public enum ErrorRes implements Res{
    //HttpStatus로 했는데 custom status로 변경해도 좋을 듯 합니다
    SUCCESS(HttpStatus.OK, ""),
    NOT_FOUND(HttpStatus.NOT_FOUND, "not found");
    private final HttpStatus status;
    private final String message;
}
