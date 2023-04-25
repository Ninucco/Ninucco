package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.db.repository.BattleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BattleServiceImpl implements BattleService{
    private final BattleRepository battleRepository;
}
