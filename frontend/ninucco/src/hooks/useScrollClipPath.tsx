import { useRef, useEffect, useCallback, RefObject } from "react";

const useScrollClipPath = (
  direction: "up" | "down" | "left" | "right" = "left",
  duration: number = 1,
  delay: number = 0
) => {
  const element = useRef<HTMLDivElement>(null);

  const handleClipPath = (name: string) => {
    switch (name) {
      case "up":
        return "inset(100% 0 0 0)";
      case "down":
        return "inset(0 0 100% 0)";
      case "left":
        return "inset(0 100% 0 0)";
      case "right":
        return "inset(0 0 0 100%)";
      default:
        return;
    }
  };

  const onScroll = useCallback(
    ([entry]: IntersectionObserverEntry[]) => {
      const { current } = element;
      if (entry.isIntersecting && current) {
        current.style.transitionProperty = "transform, clip-path";
        current.style.transitionDuration = `${duration * 1.5}s, ${duration}s`;
        current.style.transitionTimingFunction = "cubic-bezier(0, 0, 0.2, 1)";
        current.style.transitionDelay = `${delay}s`;
        current.style.transform = "scale(1)";
        current.style.clipPath = "inset(0 0 0 0)";
      }
    },
    [delay, duration]
  );

  useEffect(() => {
    let observer: IntersectionObserver | null = null;

    if (element.current) {
      observer = new IntersectionObserver(onScroll, { threshold: 0.7 });
      observer.observe(element.current.parentNode as Element);
    }

    return () => {
      if (observer) {
        observer.disconnect();
      }
    };
  }, [onScroll]);

  return {
    ref: element as RefObject<HTMLDivElement>,
    style: {
      transform: "scale(1.2)",
      clipPath: handleClipPath(direction),
    },
  };
};

export default useScrollClipPath;
