import { createGlobalStyle, DefaultTheme } from "styled-components";
import reset from "styled-reset";

const GlobalStyle = createGlobalStyle<{ theme: DefaultTheme }>`
  ${reset};

  @font-face {
    font-family: 'SUITE';
    src: url('/fonts/SUITE-Regular.otf') format('opentype');
    font-style: normal;
  }

  *, *::before, *::after {
    box-sizing: border-box;
    font-family: 'SUITE', 'Noto Sans', 'Lato', sans-serif; 
  }
`;

export default GlobalStyle;
