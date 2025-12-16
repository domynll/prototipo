import { Player } from "@lottiefiles/react-lottie-player";

const KARIN_ANIMATIONS = {
    idle: "https://assets9.lottiefiles.com/packages/lf20_ysrn2iwp.json",      // espera / leyendo
    happy: "https://assets9.lottiefiles.com/packages/lf20_jbrw3hcz.json",     // acierto
    encourage: "https://assets9.lottiefiles.com/packages/lf20_9pxtu2qj.json", // error / ánimo
};

export default function KarinMascot({ state = "idle", message }) {
    return (
        <div className="flex items-center gap-4">
            {/* BURBUJA DE TEXTO */}
            {message && (
                <div className="bg-white border-2 border-blue-300 rounded-2xl px-4 py-2 shadow-md max-w-xs">
                    <p className="text-sm font-semibold text-gray-800">
                        {message}
                    </p>
                </div>
            )}

            {/* MASCOTA */}
            <div className="w-32 h-32">
                <Player
                    autoplay
                    loop
                    src={KARIN_ANIMATIONS[state]}
                    className="w-full h-full"
                />
            </div>
        </div>
    );
}
