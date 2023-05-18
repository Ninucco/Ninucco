import { useRef, useEffect, useCallback, RefObject } from "react";

const useScrollCount = (
  end: number,
  start: number = 0,
  duration: number = 3000
) => {
  const element = useRef<HTMLDivElement>(null);
  const observer = useRef<IntersectionObserver | null>(null);
  const stepTime = Math.abs(Math.floor(duration / (end - start)));

  const onScroll = useCallback(
    ([entry]: IntersectionObserverEntry[]) => {
      const { current } = element;
      if (entry.isIntersecting && current) {
        let currentNumber = start;
        const counter = setInterval(() => {
          currentNumber += 1;
          current.innerHTML = currentNumber.toString();
          if (currentNumber === end) {
            clearInterval(counter);
            if (observer.current) {
              observer.current.disconnect();
            }
          }
        }, stepTime);
      }
    },
    [end, start, stepTime]
  );

  useEffect(() => {
    if (element.current) {
      observer.current = new IntersectionObserver(onScroll, { threshold: 0.7 });
      observer.current.observe(element.current);
    }

    return () => {
      if (observer.current) {
        observer.current.disconnect();
      }
    };
  }, [onScroll]);

  return {
    ref: element as RefObject<HTMLDivElement>,
  };
};

export default useScrollCount;
