package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.service.BattleService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/battle")
@RequiredArgsConstructor
public class BattleController {
    private final BattleService battleService;
    private static final String SUCCESS = "Success";

//    @PostMapping("/")
//    public ResponseEntity<> insertBattle(BattleCreationReq battleCreationReq){
//
//    }
}
