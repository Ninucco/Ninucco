package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.type.BattleResult;

public class EloCalculator {
    static final int C = 20;
    //승패에 따라 Elo점수 반영
    public static void updateEloByResult(Member applicant, Member opponent, BattleResult winner){
        Member mWin, mLose;
        if(winner==BattleResult.APPLICANT) {
            mWin = applicant;
            mLose = opponent;
        } else if (winner==BattleResult.OPPONENT) {
            mWin = opponent;
            mLose = applicant;
        }else throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        int rLose = mLose.getElo();
        int rSum = mWin.getElo()+rLose;
        int d = (int)((double)C*2*rLose/rSum);
        if(d==0) d=1;
        mWin.updateElo(mWin.getElo()+d);
        mLose.updateElo(mLose.getElo()-d);
    }
    // 배당 구하기
    public static double[] calcOdds(Member m1, Member m2){
        int r1=m1.getElo();
        int r2=m2.getElo();
        int rSum = r1+r2;
        double o1 = 1+(double)2*r2/rSum;
        double o2 = 1+(double)2*r1/rSum;
        return new double[] {o1,o2};
    }
}
