import React from "react";
import styled from "styled-components";
import { useScrollFadeIn } from "../../../hooks";

interface IServiceItem {
  title: string;
  description: string;
  button: string;
}

const S = {
  Wrapper: styled.section`
    width: 100%;
    max-width: 1180px;
    margin: auto;
    padding: 150px 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  `,
  Label: styled.p`
    display: inline-block;
    ${(props: { theme: any }) => props.theme.typography.label};
    color: ${(props: { theme: any }) => props.theme.palette.primary};
    margin-bottom: 1rem;
  `,
  Title: styled.h2`
    ${(props: { theme: any }) => props.theme.typography.subtitle};
    color: ${(props: { theme: any }) => props.theme.palette.black};
    text-align: center;
    margin-bottom: 4rem;
  `,
  ItemWrapper: styled.ul`
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  `,
  ItemBox: styled.li`
    width: 380px;
    padding: 3rem 2rem;
    text-align: center;
    background-color: ${(props: { theme: any }) => props.theme.palette.white};
    display: flex;
    flex-direction: column;
    box-shadow: 0 0 16px 8px rgba(0, 0, 0, 0.03);
    border-radius: 0.5rem;
  `,
  ItemTitle: styled.h3`
    ${(props: { theme: any }) => props.theme.typography.heading};
    color: ${(props: { theme: any }) => props.theme.palette.black};
    margin-top: 1rem;
    margin-bottom: 1rem;
  `,
  ItemDescription: styled.p`
    ${(props: { theme: any }) => props.theme.typography.description};
    margin-top: 1rem;
    margin-bottom: 1.5rem;
  `,
  ItemButton: styled.button`
    ${(props: { theme: any }) => props.theme.typography.textbutton};
    color: ${(props: { theme: any }) => props.theme.palette.secondary};
    margin-top: auto;
    cursor: pointer;
  `,
};

const SERVICES_ITEMS: IServiceItem[] = [
  {
    title: "닮은꼴 찾기",
    description:
      "여러 가지 닮은꼴 검사를 통해 내가 어떤 것들과 유사한지를 확인할 수 있어요",
    button: "",
  },
  {
    title: "비교 배틀",
    description:
      "다른 유저와의 이미지 비교를 통해 어떤 사람이 좀 더 유사한 이미지를 가지는지 확인하고, 포인트를 획득할 수 있어요",
    button: "",
  },
  {
    title: "이미지 공유",
    description:
      "AI가 생성해 준 이미지를 카카오톡을 통해 친구들과 공유하고 앱을 소개할 수 있어요",
    button: "",
  },
];

const Services: React.FC = () => {
  const animatedItem: { [key: number]: any } = {
    0: useScrollFadeIn("up", 1, 0),
    1: useScrollFadeIn("up", 1, 0.2),
    2: useScrollFadeIn("up", 1, 0.3),
  };

  return (
    <S.Wrapper>
      <S.Label>Our Services</S.Label>
      <S.Title>니누꼬에서 체험할 수 있는 것들</S.Title>
      <S.ItemWrapper>
        {SERVICES_ITEMS.map((item: IServiceItem, index: number) => (
          <S.ItemBox key={item.title} {...animatedItem[index]}>
            <S.ItemTitle>{item.title}</S.ItemTitle>
            <S.ItemDescription>{item.description}</S.ItemDescription>
            {/* <S.ItemButton>{item.button}</S.ItemButton> */}
          </S.ItemBox>
        ))}
      </S.ItemWrapper>
    </S.Wrapper>
  );
};

export default Services;
