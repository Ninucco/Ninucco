package co.ninuc.ninucco.api.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@AllArgsConstructor
public class MemberListRes {
    List<MemberRes> memberList;
}
