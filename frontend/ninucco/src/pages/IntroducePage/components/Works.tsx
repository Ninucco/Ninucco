import React from "react";
import styled from "styled-components";
import { worksImage01, worksImage02, worksImage03 } from "../../../assets";
import { Button } from "../../../components";
import { useScrollFadeIn } from "../../../hooks";

interface IWorkItem {
  image: string;
  title: string;
  label: string;
  description: string;
}

const S = {
  Wrapper: styled.div`
    width: 100%;
    max-width: 1180px;
    margin: auto;
    padding: 120px 0;
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
    title: "Volutpat odio",
    label: "Dec 14th, 2019",
    description:
      "Facilisis mauris sit amet massa. Commodo odio aenean sed adipiscing. In hac habitasse platea dictumst.",
  },
  {
    image: worksImage02,
    title: "Arcu ac tortor dignissim",
    label: "Dec 14th, 2019",
    description:
      "Convallis aenean et tortor at. Pretium viverra suspendisse potenti nullam ac tortor vitae purus.",
  },
  {
    image: worksImage03,
    title: "Eros donec ac odio",
    label: "Dec 14th, 2019",
    description:
      "Tempor orci dapibus ultrices. Elementum nibh tellus molestie nunc. Et magnis dis parturient montes nascetur.",
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
      <S.Label>Our Recent Works</S.Label>
      <S.Title>
        Et malesuada fames ac <br />
        turpis egestas sed
      </S.Title>
      <S.Description>
        Sit amet nisl suscipit adipiscing bibendum est ultricies.
      </S.Description>
      <S.List>
        {WORKS_ITEMS.map((item: IWorkItem, index: number) => (
          <S.ListItem key={item.title} {...animatedItem[index]}>
            <S.ItemImage image={item.image} />
            <S.TextContainer>
              <S.ItemTitle>{item.title}</S.ItemTitle>
              <S.ItemLabel>{item.label}</S.ItemLabel>
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
