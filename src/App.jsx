'use client';
import React, { useState, useEffect, useRef } from 'react';
import './App.css';
import { motion, AnimatePresence } from 'framer-motion';
import TurtleWelcome from './TurtleWelcome.jsx';
import './FormStyles.css';
import LoginForm from './LoginForm';
import RegisterForm from './RegisterForm';
import SuccessModal from './SuccessModal';
import { supabase } from './services/supabaseClient'; 
import { BrowserRouter as Router, Routes, Route, Navigate, useNavigate } from 'react-router-dom';
import DidaktikApp from './home'; // Aplicación principal

// TypewriterText mantiene su implementación original
const TypewriterText = ({ text, speed = 50 }) => {
  const [displayedText, setDisplayedText] = useState('');
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isComplete, setIsComplete] = useState(false);

  useEffect(() => {
    if (currentIndex < text.length) {
      const timeout = setTimeout(() => {
        setDisplayedText(prev => prev + text[currentIndex]);
        setCurrentIndex(prev => prev + 1);
      }, speed);
      return () => clearTimeout(timeout);
    } else {
      setIsComplete(true);
    }
  }, [currentIndex, text, speed]);

  return (
    <span className="inline-block">
      {displayedText}
      {!isComplete && (
        <motion.span
          animate={{ opacity: [0, 1, 0] }}
          transition={{ repeat: Infinity, duration: 0.8 }}
          className="inline-block ml-1"
        >
          |
        </motion.span>
      )}
    </span>
  );
};

// Confetti mantiene su implementación original
const Confetti = ({ isVisible }) => {
  const confettiCount = 50;
  const colors = ["#10b981", "#065f46", "#047857", "#115e59", "#0d9488"];

  return (
    <AnimatePresence>
      {isVisible && (
        <>
          {[...Array(confettiCount)].map((_, i) => {
            const randomX = Math.random() * window.innerWidth;
            const randomY = -20 - Math.random() * 100;
            const randomSize = Math.random() * 8 + 4;
            const randomColor = colors[Math.floor(Math.random() * colors.length)];
            const randomDuration = Math.random() * 2 + 1;

            return (
              <motion.div
                key={i}
                style={{
                  position: "fixed",
                  width: randomSize,
                  height: randomSize,
                  borderRadius: "50%",
                  backgroundColor: randomColor,
                  left: randomX,
                  top: randomY,
                  zIndex: 50
                }}
                initial={{ y: randomY }}
                animate={{
                  y: window.innerHeight + 100,
                  rotate: Math.random() * 360
                }}
                exit={{ opacity: 0 }}
                transition={{
                  duration: randomDuration,
                  ease: "linear",
                }}
              />
            );
          })}
        </>
      )}
    </AnimatePresence>
  );
};

// Componente principal de la aplicación
function AppContent() {
  const [currentPage, setCurrentPage] = useState('home'); // 'home', 'login', 'register'
  const [loginClicked, setLoginClicked] = useState(false);
  const [registerClicked, setRegisterClicked] = useState(false);
  const [showConfetti, setShowConfetti] = useState(false);
  const [isHovering, setIsHovering] = useState(false);
  const [titleNeedsAnimation, setTitleNeedsAnimation] = useState(true);
  const [showSuccessModal, setShowSuccessModal] = useState(false);

  const titleRef = useRef(null);
  const turtleRef = useRef(null);
  const navigate = useNavigate(); // Hook de navegación

  // Animaciones de contenedor y páginas
  const containerAnimation = {
    hidden: { opacity: 0, y: -100 },
    visible: { opacity: 1, y: 0, transition: { duration: 1, ease: 'easeOut' } },
  };

  const pageTransition = {
    hidden: { x: '100%', opacity: 0 },
    visible: { x: 0, opacity: 1, transition: { type: 'spring', damping: 25, stiffness: 100 } },
    exit: { x: '-100%', opacity: 0, transition: { ease: 'easeInOut', duration: 0.3 } },
  };

  const buttonAnimation = {
    rest: { scale: 1 },
    hover: { scale: 1.05, boxShadow: "0px 5px 15px rgba(0,0,0,0.1)", transition: { duration: 0.3, type: "spring", stiffness: 400 } },
    tap: { scale: 0.95, boxShadow: "0px 2px 5px rgba(0,0,0,0.1)", transition: { duration: 0.2 } },
  };

  // Animación del título
  useEffect(() => {
    if (currentPage !== 'home' || !titleNeedsAnimation) return;
    if (!titleRef.current) return;

    titleRef.current.innerHTML = '';
    titleRef.current.style.visibility = 'hidden';

    const timer = setTimeout(() => {
      const text = 'DIDACTIKAPP';
      const letters = text.split('');

      titleRef.current.innerHTML = '';
      titleRef.current.style.visibility = 'visible';

      letters.forEach((letter, index) => {
        const span = document.createElement('span');
        span.className = 'title-letter';
        span.textContent = letter;
        span.style.display = 'inline-block';
        span.style.opacity = '0';
        span.style.transform = 'translateY(20px)';
        span.style.color = '#000000';
        span.style.transition = `all 0.5s cubic-bezier(0.175,0.885,0.32,1.275) ${index * 0.1}s`;
        titleRef.current.appendChild(span);
      });

      setTimeout(() => {
        const letterElements = titleRef.current.querySelectorAll('.title-letter');
        letterElements.forEach(letter => {
          letter.style.opacity = '1';
          letter.style.transform = 'translateY(0)';
        });
        setTitleNeedsAnimation(false);
      }, 100);
    }, 100);

    return () => clearTimeout(timer);
  }, [currentPage, titleNeedsAnimation]);

  // Manejo de botones
  const handleButtonClick = (buttonType) => {
    if (buttonType === 'login') {
      setLoginClicked(true);
      setRegisterClicked(false);
      setShowConfetti(true);
      setTimeout(() => {
        setShowConfetti(false);
        setCurrentPage('login');
      }, 800);
    } else {
      setLoginClicked(false);
      setRegisterClicked(true);
      setShowConfetti(true);
      setTimeout(() => {
        setShowConfetti(false);
        setCurrentPage('register');
      }, 800);
    }
  };

  const handleBackToHome = () => {
    setTitleNeedsAnimation(true);
    setCurrentPage('home');
    setLoginClicked(false);
    setRegisterClicked(false);
    if (titleRef.current) {
      titleRef.current.innerHTML = '';
      titleRef.current.style.visibility = 'hidden';
    }
  };

  const handleRegisterSuccess = () => setShowSuccessModal(true);

  const goToLoginAfterRegister = () => {
    setShowSuccessModal(false);
    setCurrentPage('login');
  };

  const goToHomeAfterRegister = () => {
    setShowSuccessModal(false);
    handleBackToHome();
  };

  return (
    <div className="app-background">
      <Confetti isVisible={showConfetti} />
      <SuccessModal 
        isOpen={showSuccessModal} 
        onGoToLogin={goToLoginAfterRegister} 
        onGoToHome={goToHomeAfterRegister} 
      />

      <AnimatePresence mode="wait">
        {/* Home */}
        {currentPage === 'home' && (
          <motion.div
            key="home"
            className="white-box relative overflow-hidden"
            variants={containerAnimation}
            initial="hidden"
            animate="visible"
            exit="exit"
          >
            <motion.div ref={turtleRef} className="cursor-pointer" whileHover={{ scale: 1.05 }} whileTap={{ scale: 0.95 }}>
              <TurtleWelcome />
            </motion.div>

            <div className="mt-2">
              <h1 ref={titleRef} className="text-5xl font-bold text-center text-black">DIDACTIKAPP</h1>
            </div>

            <motion.p
              className="text-center text-gray-800 text-base sm:text-lg custom-title mt-4 min-h-16"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 1, delay: 0.7 }}
            >
              <TypewriterText text="Aprendé didáctica de forma interactiva, con simulaciones y herramientas pedagógicas." speed={40} />
            </motion.p>

            <div className="w-full flex flex-col space-y-4 mt-8">
              <motion.button
                className={`font-semibold rounded-full shadow w-full px-6 py-3 ${loginClicked ? 'bg-green-500 text-white' : 'bg-emerald-700 text-white'}`}
                variants={buttonAnimation}
                initial="rest"
                whileHover="hover"
                whileTap="tap"
                onClick={() => handleButtonClick('login')}
                onMouseEnter={() => setIsHovering(true)}
                onMouseLeave={() => setIsHovering(false)}
              >
                Iniciar sesión
              </motion.button>

              <motion.button
                className={`font-semibold border rounded-full w-full px-6 py-3 transition ${registerClicked ? 'bg-green-500 text-white' : 'border-emerald-700 text-emerald-700 hover:bg-emerald-100'}`}
                variants={buttonAnimation}
                initial="rest"
                whileHover="hover"
                whileTap="tap"
                onClick={() => handleButtonClick('register')}
              >
                Crear cuenta
              </motion.button>
            </div>
          </motion.div>
        )}

        {/* Login */}
        {currentPage === 'login' && (
          <motion.div key="login" className="white-box relative overflow-hidden" variants={pageTransition} initial="hidden" animate="visible" exit="exit">
            <div className="mobile-app-view relative">
              <motion.button onClick={handleBackToHome} className="flex items-center text-emerald-700 mb-4" whileHover={{ scale: 1.1 }} whileTap={{ scale: 0.9 }}>
                <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                <span className="ml-1">Volver</span>
              </motion.button>

              <LoginForm supabase={supabase} navigateToHome={() => navigate('/home')} />
            </div>
          </motion.div>
        )}

        {/* Register */}
        {currentPage === 'register' && (
          <motion.div key="register" className="white-box relative overflow-hidden" variants={pageTransition} initial="hidden" animate="visible" exit="exit">
                        <div className="mobile-app-view relative">
              <motion.button
                onClick={handleBackToHome}
                className="flex items-center text-emerald-700 mb-4"
                whileHover={{ scale: 1.1 }}
                whileTap={{ scale: 0.9 }}
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                <span className="ml-1">Volver</span>
              </motion.button>

              <RegisterForm supabase={supabase} onRegisterSuccess={handleRegisterSuccess} />
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

// Componente App principal con Router
export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<AppContent />} />
        <Route path="/home" element={<DidaktikApp />} />
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>
    </Router>
  );
}
