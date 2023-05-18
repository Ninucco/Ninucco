import React, { InputHTMLAttributes } from "react";
import styled from "styled-components";

const S = {
  Field: styled.input`
    ${({ theme }) => theme.typography.caption};
    border: 1px solid ${({ theme }) => theme.palette.lightgray};
    width: fit-content;
    padding: 1rem;
    border-radius: 0.5rem;
    :focus {
      outline: none;
      border: 1px solid ${({ theme }) => theme.palette.secondary};
    }
    ::placeholder {
      color: ${({ theme }) => theme.palette.gray};
    }
  `,
};

type TextFieldProps = InputHTMLAttributes<HTMLInputElement>;

const TextField: React.FC<TextFieldProps> = (props) => <S.Field {...props} />;

export default TextField;
