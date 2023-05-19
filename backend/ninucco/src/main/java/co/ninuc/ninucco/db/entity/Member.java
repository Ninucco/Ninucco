package co.ninuc.ninucco.db.entity;

import javax.persistence.*;

import java.util.Collection;
import lombok.Builder;
import org.hibernate.annotations.ColumnDefault;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "member")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Member implements UserDetails{
    @Id
    @Column(name="id", length = 40)
    String id;

    @Column(name="nickname", unique = true, nullable = false)
    String nickname;

    @Column(name="url")
    String url;

    @Column(name="win_count", nullable = false)
    @ColumnDefault("0")
    int winCount;

    @Column(name="lose_count", nullable = false)
    @ColumnDefault("0")
    int loseCount;

    @Column(name="point", nullable = false)
    @ColumnDefault("0")
    long point;

    @Column(name="elo", nullable = false)
    @ColumnDefault("1000")
    int elo;

    @CreatedDate
    LocalDateTime createdAt;

    @LastModifiedDate
    LocalDateTime updatedAt;

    @Builder
    public Member(String id, String nickname,String url){
        this.id=id;
        this.nickname=nickname;
        this.url=url;
        this.winCount=0;
        this.loseCount=0;
        this.point=0;
        this.elo =1000;
    }

    public void updateUrl(String url){
        this.url=url;
    }
    public void updateNickname(String nickname){
        this.nickname=nickname;
    }
    public void updateElo(int elo){
        this.elo =elo;
    }
    public void updatePoint(long point){
        this.point =point;
    }
    public void updateWinCount(int winCount) {
        this.winCount = winCount;
    }
    public void updateLoseCount(int loseCount) {
        this.loseCount = loseCount;
    }
    public boolean subtractPoint(int amount){
        if(this.point<amount) return false;
        this.point-=amount;
        return true;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String getPassword() {
        //우리 db엔 패스워드 정보가 없음
        return null;
    }

    @Override
    public String getUsername() {
        return nickname;
    }

    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public boolean isEnabled() {
        // TODO Auto-generated method stub
        return false;
    }
}
