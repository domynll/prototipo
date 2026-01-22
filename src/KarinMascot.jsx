import { Player } from "@lottiefiles/react-lottie-player";
import { useEffect, useState } from "react";

const KARIN_ANIMATIONS = {
    idle: "https://assets9.lottiefiles.com/packages/lf20_ysrn2iwp.json",
    happy: "https://assets9.lottiefiles.com/packages/lf20_jbrw3hcz.json",
    encourage: "https://assets9.lottiefiles.com/packages/lf20_9pxtu2qj.json",
};

export default function KarinMascot({ state = "idle", message }) {
    const [isTyping, setIsTyping] = useState(false);

    useEffect(() => {
        setIsTyping(true);
        const timer = setTimeout(() => setIsTyping(false), 400);
        return () => clearTimeout(timer);
    }, [message]);

    return (
        <div className="flex items-center gap-2 group transition-all duration-500 min-h-[160px]">
            {/* ESTILOS INYECTADOS DIRECTAMENTE */}
            <style>{`
        @keyframes float-karin {
          0%, 100% { transform: translateY(0) rotate(0deg); }
          50% { transform: translateY(-15px) rotate(2deg); }
        }
        @keyframes shadow-pulse {
          0%, 100% { transform: scale(1); opacity: 0.2; }
          50% { transform: scale(1.2); opacity: 0.1; }
        }
        .animate-float { animation: float-karin 3s ease-in-out infinite; }
        .animate-shadow { animation: shadow-pulse 3s ease-in-out infinite; }
      `}</style>

            {/* BURBUJA DE DIÁLOGO */}
            <div className={`transition-all duration-300 transform ${isTyping ? "scale-75 opacity-0" : "scale-100 opacity-100"}`}>
                {message && (
                    <div className="relative bg-white border-[4px] border-blue-400 rounded-[2.5rem] px-6 py-4 shadow-[0_8px_0_0_#60a5fa] max-w-[280px]">
                        <p className="text-xl font-black text-blue-900 leading-tight tracking-tight">
                            {message}
                        </p>
                        {/* Puntero de la burbuja */}
                        <div className="absolute right-[-18px] top-1/2 -translate-y-1/2 w-0 h-0 border-t-[12px] border-t-transparent border-l-[20px] border-l-blue-400 border-b-[12px] border-b-transparent"></div>
                        <div className="absolute right-[-10px] top-1/2 -translate-y-1/2 w-0 h-0 border-t-[10px] border-t-transparent border-l-[16px] border-l-white border-b-[10px] border-b-transparent"></div>
                    </div>
                )}
            </div>

            {/* CONTENEDOR DE KARIN */}
            <div className="relative w-44 h-44 animate-float">
                {/* Sombra realista en el "piso" */}
                <div className="absolute bottom-2 left-1/2 -translate-x-1/2 w-20 h-5 bg-blue-900/20 rounded-[100%] blur-md -z-10 animate-shadow"></div>

                <Player
                    autoplay
                    loop
                    src={KARIN_ANIMATIONS[state] || KARIN_ANIMATIONS.idle}
                    className="w-full h-full drop-shadow-2xl"
                />
            </div>
        </div>
    );
}