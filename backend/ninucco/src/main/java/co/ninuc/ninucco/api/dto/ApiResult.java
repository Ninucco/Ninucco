package co.ninuc.ninucco.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ApiResult<Res>{
    private final boolean success;
    /*
    * Response dto는 Res를 구현
    * 성공일 경우 XXXRes, 실패일 경우 ErrorRes
    * */
    private final Res response;
}
