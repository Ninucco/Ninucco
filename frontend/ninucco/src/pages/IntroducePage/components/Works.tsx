import React from "react";
import styled from "styled-components";
import { worksImage01, worksImage02, worksImage03 } from "../../../assets";
import { Button } from "../../../components";
import { useScrollFadeIn } from "../../../hooks";

interface IWorkItem {
  image: string;
  title: string;
  // label: string;
  description: string;
}

const S = {
  Wrapper: styled.div`
    width: 100%;
    max-width: 1180px;
    margin: auto;
    padding: 0 0 60px 0;
    display: flex;
    flex-direction: column;
    align-items: center;
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
    margin-bottom: 1rem;
  `,
  Description: styled.p`
    ${(props: { theme: any }) => props.theme.typography.description};
    color: ${(props: { theme: any }) => props.theme.palette.black};
    margin-bottom: 4rem;
  `,
  List: styled.ul`
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-bottom: 4rem;
  `,
  ListItem: styled.li`
    width: 380px;
    box-shadow: 0 0 16px 8px rgba(0, 0, 0, 0.03);
    border-radius: 0.5rem;
  `,
  ItemImage: styled.div`
    width: 100%;
    height: 380px;
    border-radius: 0.5rem 0.5rem 0 0;
    background: no-repeat center/cover
      ${(props: { image: string }) => `url(${props.image})`};
  `,
  TextContainer: styled.div`
    padding: 2rem;
  `,
  ItemTitle: styled.h3`
    ${(props: { theme: any }) => props.theme.typography.heading};
    color: ${(props: { theme: any }) => props.theme.palette.black};
    margin-bottom: 0.75rem;
  `,
  ItemLabel: styled.p`
    ${(props: { theme: any }) => props.theme.typography.caption};
    color: ${(props: { theme: any }) => props.theme.palette.gray};
    font-weight: 400;
    margin-bottom: 1.5rem;
  `,
  ItemDescription: styled.p`
    ${(props: { theme: any }) => props.theme.typography.description};
    margin-bottom: 1.5rem;
  `,
  TextButton: styled.button`
    width: fit-content;
    padding: 0;
    ${(props: { theme: any }) => props.theme.typography.textbutton};
    color: ${(props: { theme: any }) => props.theme.palette.secondary};
    cursor: pointer;
  `,
};

const WORKS_ITEMS: IWorkItem[] = [
  {
    image: worksImage01,
    title: "강아지의 상",
    description:
      "강아지상의 사람은 사랑스럽고 사회성이 뛰어난 사람입니다. 그들은 온화하고 친근한 성격을 지니며, 주변 사람들과의 관계에서 따뜻한 영향력을 행사합니다.",
  },
  {
    image: worksImage02,
    title: "복숭아의 상",
    description:
      "복숭아상의 사람은 우아하고 섬세한 성격을 가진 사람입니다. 그들은 아름다움과 우아함을 추구하며, 세련된 삶의 양식을 가지고 있습니다. 섬세하고 부드러운 매력을 가지고 있으며, 그들의 존재 자체가 주변에 아름다움을 전달합니다.",
  },
  {
    image: worksImage03,
    title: "전교 회장의 상",
    description:
      "전교 회장상의 사람은 학교 내에서 최고위의 학생 지도자로서 선출되는 사람을 의미합니다. 이들은 학교 내에서 리더십과 책임감을 갖고 있으며, 학생들을 대표하고 학교 생활을 조직화하는 역할을 맡습니다.",
  },
];

const Works: React.FC = () => {
  const animatedItem: { [key: number]: any } = {
    0: useScrollFadeIn("left", 1),
    1: useScrollFadeIn("left", 1, 0.2),
    2: useScrollFadeIn("left", 1, 0.4),
  };

  return (
    <S.Wrapper>
      <S.Label>User Profiles</S.Label>
      <S.Title>획득 가능한 프로필의 종류</S.Title>
      <S.Description>
        3가지 예시 외에도 다양한 이미지를 닮은꼴 찾기를 통해 획득할 수 있어요
      </S.Description>
      <S.List>
        {WORKS_ITEMS.map((item: IWorkItem, index: number) => (
          <S.ListItem key={item.title} {...animatedItem[index]}>
            <S.ItemImage image={item.image} />
            <S.TextContainer>
              <S.ItemTitle>{item.title}</S.ItemTitle>
              {/* <S.ItemLabel>{item.label}</S.ItemLabel> */}
              <S.ItemDescription>{item.description}</S.ItemDescription>
              <S.TextButton>Read more</S.TextButton>
            </S.TextContainer>
          </S.ListItem>
        ))}
      </S.List>
      <Button fill="outline">More Works</Button>
    </S.Wrapper>
  );
};

export default Works;
