import { ThemeProvider } from "styled-components";
import { GlobalStyle, theme } from "./styles";

import { IntroducePage } from "./pages";

function App() {
  return (
    <ThemeProvider theme={theme}>
      <GlobalStyle />
      <IntroducePage />
    </ThemeProvider>
  );
}

export default App;
