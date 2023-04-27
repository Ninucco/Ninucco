package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.KeywordCreateReq;
import co.ninuc.ninucco.db.entity.Keyword;
import co.ninuc.ninucco.db.repository.KeywordRepository;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaceServiceImpl {
    private final KeywordRepository keywordRepository;
    @Transactional
    public Long saveKeyword(KeywordCreateReq keyword){
        return keywordRepository.save(Keyword.builder()
                .category(keyword.getCategory())
                .name(keyword.getName()).build()).getId();
    }
    public List<Keyword> findAllKeywords(){
        return keywordRepository.findAll();
    }
}
