import React, { useEffect, useState, useCallback } from "react";
import styled from "styled-components";
import Button from "./Button";

const S = {
  Wrapper: styled.div<{ isScroll: boolean }>`
    width: 100vw;
    position: sticky;
    top: 0;
    z-index: 1000;
    transition: all 0.2s ease-in-out;
    background-color: ${({ isScroll, theme }) =>
      isScroll ? theme.palette.white : "none"};
    box-shadow: ${({ isScroll }) =>
      isScroll ? "0 0 16px 8px rgba(0, 0, 0, 0.03)" : "none"};
  `,
  Header: styled.header<{ isScroll: boolean }>`
    width: 100%;
    max-width: 1180px;
    margin: auto;
    transition: all 0.2s ease-in-out;
    height: ${({ isScroll }) => (isScroll ? "70px" : "100px")};
    display: flex;
    flex-direction: row;
    align-items: center;
  `,
  Logo: styled.span<{ isScroll: boolean }>`
    color: ${({ isScroll, theme }) =>
      isScroll ? theme.palette.black : theme.palette.white};
    font-weight: 900;
    font-size: 1.5rem;
    flex: 0 0 25%;
    max-width: 25%;
  `,
  Navigation: styled.div`
    flex: 0 0 50%;
    max-width: 50%;
    display: flex;
    justify-content: center;
  `,
  NavigationItem: styled.a<{ isScroll: boolean }>`
    color: ${({ isScroll, theme }) =>
      isScroll ? theme.palette.black : theme.palette.white};
    margin: 0 1rem;
    cursor: pointer;
    &:hover {
      opacity: 0.5;
    }
  `,
  ButtonWrapper: styled.div`
    flex: 0 0 25%;
    max-width: 25%;
    display: flex;
    justify-content: flex-end;
  `,
};

const NAVIGATION_ITEMS = ["Home", "About", "Services", "Blog", "Contact"];

const Header: React.FC = () => {
  const [isScroll, setIsScroll] = useState(false);

  const handleScroll = useCallback(() => {
    if (window.pageYOffset > 0) {
      setIsScroll(true);
    } else {
      setIsScroll(false);
    }
  }, []);

  useEffect(() => {
    window.addEventListener("scroll", handleScroll);
    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, [handleScroll]);

  return (
    <S.Wrapper isScroll={isScroll}>
      <S.Header isScroll={isScroll}>
        <S.Logo isScroll={isScroll}>Lorem</S.Logo>
        <S.Navigation>
          {NAVIGATION_ITEMS.map((item) => (
            <S.NavigationItem key={item} isScroll={isScroll}>
              {item}
            </S.NavigationItem>
          ))}
        </S.Navigation>
        <S.ButtonWrapper>
          <Button fill="solid" type="button" style={{ marginLeft: "auto" }}>
            Get a Quote
          </Button>
        </S.ButtonWrapper>
      </S.Header>
    </S.Wrapper>
  );
};

export default Header;
