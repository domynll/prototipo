import React, { useRef } from "react";
import { DotLottieReact } from "@lottiefiles/dotlottie-react";

const TurtleWelcome = () => {
  const lottieRef = useRef();

  return (
    <div className="flex flex-col items-center">
      <div className="w-64">
        <DotLottieReact
          lottieRef={lottieRef}
          src="https://lottie.host/fde2e3fb-a605-4f6c-9d04-a3cb390fc4b6/o17lF6ETz1.lottie"
          autoplay
          loop={true} // Hace que la animación se repita continuamente
        />
      </div>
    </div>
  );
};

export default TurtleWelcome;
