package co.ninuc.ninucco.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum ErrorRes implements Res{

    // 400 BAD_REQUEST 잘못된 요청
    INVALID_PARAMETER("N???"),

    // 403 Forbidden 접근 권한 없음 : A, B는 예시입니다.
    ACCESS_DENIED_A("N???"),
    ACCESS_DENIED_B("N???"),

    // 404 NOT_FOUND 잘못된 리소스 접근 : A, B는 예시입니다.
    NOT_FOUND_A("N???"),
    NOT_FOUND_B("N???"),


    // 409 CONFLICT 중복된 리소스 : A, B는 예시입니다.
    ALREADY_SAVED_A("N???"),
    ALREADY_SAVED_B("N???"),

    //500 INTERNAL SERVER ERROR
    INTERNAL_SERVER_ERROR("N???");

    private final String code;

}
