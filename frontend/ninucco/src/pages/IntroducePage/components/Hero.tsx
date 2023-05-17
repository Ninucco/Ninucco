import React from "react";
import styled from "styled-components";
import { heroBackground, googlePlayLogo } from "../../../assets";
import { Button } from "../../../components";

const S = {
  Background: styled.section`
    position: absolute;
    top: 0;
    width: 100vw;
    height: 780px;
    background: no-repeat center/cover url(${heroBackground});
  `,
  Wrapper: styled.div`
    width: 100%;
    height: 100%;
    max-width: 1180px;
    padding-top: 100px;
    margin: auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
  `,
  Title: styled.h1`
    ${({ theme }) => theme.typography.title};
    color: #fff;
    margin-bottom: 0.5rem;
  `,
  Description: styled.p`
    ${({ theme }) => theme.typography.description};
    color: ${({ theme }) => theme.palette.white};
    margin-bottom: 2rem;
  `,
};

const Hero: React.FC = () => {
  return (
    <S.Background>
      <S.Wrapper>
        <S.Title>
          ninucco
          <br />
          니, 누꼬?
        </S.Title>
        <S.Description>
          다양한 사람들과 함께 내가 어떤 모습인지 공유하세요.
          <br />
          배틀을 통해 좀 더 어울리는 사람을 골라보아요.
        </S.Description>
        <Button fill="solid" type="button">
          <div>
            <img src={googlePlayLogo} alt="google play" width={100} />
          </div>
        </Button>
      </S.Wrapper>
    </S.Background>
  );
};

export default Hero;
