package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.response.MemberRes;

public interface MemberService {
    MemberRes insertMember(MemberCreateReq memberCreateReq);
}
