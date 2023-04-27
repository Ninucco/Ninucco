package co.ninuc.ninucco.api.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
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
    NOT_FOUND_ITEM("N103"),
    NOT_FOUND_MEMBER("N104"),

    // 409 CONFLICT 중복된 리소스
    CONFLICT_BETTING("N201"),
    CONFLICT_MEMBER("N202"),
    CONFLICT_NICKNAME("N203"),

    //500 INTERNAL SERVER ERROR
    INTERNAL_SERVER_ERROR("N301");

    @JsonProperty("code")
    private final String code;

}
