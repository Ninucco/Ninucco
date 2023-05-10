package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Builder
@Getter
@AllArgsConstructor
public class MemberAllRes implements Res {
    MemberRes user;
    List<MemberRes> friendList;
    List<ScanResultResDummy> scanResults;
    List<Object> items;
    List<Object> curBattles;
    List<Object> prevBattles;
}
