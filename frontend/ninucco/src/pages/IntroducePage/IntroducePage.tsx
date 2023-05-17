import { Header, Footer } from "../../components";
import {
  Hero,
  Services,
  Feature,
  Figure,
  Works,
  Contact,
  Banner,
} from "../../pages/IntroducePage/components";

const IntroducePage: React.FC = () => {
  return (
    <>
      <Header />
      <Hero />
      <Services />
      <Feature />
      <Figure />
      <Works />
      <Contact />
      <Banner />
      <Footer />
    </>
  );
};

export default IntroducePage;
