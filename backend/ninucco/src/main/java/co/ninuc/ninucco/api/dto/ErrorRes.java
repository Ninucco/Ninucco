package co.ninuc.ninucco.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum ErrorRes implements Res{

    // 400 BAD_REQUEST 잘못된 요청
    BAD_REQUEST("N001"),

    // 401 Unauthorized 미승인(회원도, 비회원도 아님)
    UNAUTHORIZED_MEMBER("N002"),

    // 403 Forbidden 접근 권한 없음(회원이 아님)
    ACCESS_DENIED_MEMBER("N003"),

    // 404 NOT_FOUND 잘못된 리소스 접근
    NOT_FOUND_BATTLE("N101"),
    NOT_FOUND_BETTING("N102"),
    NOT_FOUND_COMMENT("N103"),
    NOT_FOUND_ITEM("N104"),
    NOT_FOUND_MEMBER("N105"),
    NOT_FOUND_FRIEND("N106"),

    // 409 CONFLICT 중복된 리소스
    CONFLICT_BETTING("N201"),
    CONFLICT_MEMBER("N202"),
    CONFLICT_MEMBER_FRIEND("N203"),

    //500 INTERNAL SERVER ERROR
    INTERNAL_SERVER_ERROR("N301");

    private final String code;

}
