import React, { useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import './FormStyles.css';

const SuccessModal = ({ isOpen, onGoToLogin, onGoToHome }) => {
  const [theme, setTheme] = useState('light');

  // Detectar tema actual
  useEffect(() => {
    const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
    setTheme(currentTheme);

    // Observar cambios de tema
    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === 'attributes' && mutation.attributeName === 'data-theme') {
          const newTheme = document.documentElement.getAttribute('data-theme') || 'light';
          setTheme(newTheme);
        }
      });
    });

    observer.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['data-theme']
    });

    return () => observer.disconnect();
  }, []);

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          className="success-modal-overlay"
          data-theme={theme}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
        >
          <motion.div
            className="success-modal-card"
            initial={{ scale: 0.8, opacity: 0, y: 50 }}
            animate={{ scale: 1, opacity: 1, y: 0 }}
            exit={{ scale: 0.8, opacity: 0, y: 50 }}
            transition={{ type: "spring", damping: 20, stiffness: 300 }}
          >
            {/* Efecto de partículas de éxito */}
            <div className="success-particles" />

            <div className="success-content">
              {/* Ícono de éxito animado */}
              <motion.div
                className="success-icon"
                initial={{ scale: 0, rotate: -180 }}
                animate={{ scale: 1, rotate: 0 }}
                transition={{ delay: 0.2, type: "spring", damping: 15 }}
              >
                <motion.svg 
                  className="checkmark" 
                  fill="none" 
                  viewBox="0 0 24 24" 
                  stroke="currentColor"
                  initial={{ pathLength: 0 }}
                  animate={{ pathLength: 1 }}
                  transition={{ delay: 0.5, duration: 0.8, ease: "easeInOut" }}
                >
                  <motion.path 
                    strokeLinecap="round" 
                    strokeLinejoin="round" 
                    strokeWidth={3} 
                    d="M5 13l4 4L19 7"
                  />
                </motion.svg>
              </motion.div>

              {/* Título */}
              <motion.h3 
                className="success-title"
                initial={{ y: 20, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: 0.3 }}
              >
                🎉 ¡Registro exitoso!
              </motion.h3>

              {/* Mensaje descriptivo */}
              <motion.p 
                className="success-message"
                initial={{ y: 20, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: 0.4 }}
              >
                Tu cuenta ha sido creada correctamente. 
                <br />
                <span className="success-highlight">
                  ¡Bienvenido a DidactikApp! ✨
                </span>
              </motion.p>

              {/* Botones de acción */}
              <motion.div 
                className="success-buttons"
                initial={{ y: 30, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: 0.5 }}
              >
                <motion.button
                  className="success-btn primary"
                  whileHover={{ scale: 1.05, y: -2 }}
                  whileTap={{ scale: 0.98 }}
                  onClick={onGoToLogin}
                >
                  🚀 Iniciar sesión
                  <div className="btn-shine"></div>
                </motion.button>

                <motion.button
                  className="success-btn secondary"
                  whileHover={{ 
                    scale: 1.05, 
                    y: -2
                  }}
                  whileTap={{ scale: 0.98 }}
                  onClick={onGoToHome}
                >
                  🏠 Volver al inicio
                </motion.button>
              </motion.div>

              {/* Mensaje adicional pequeño */}
              <motion.div
                className="success-footer"
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ delay: 0.6 }}
              >
                💡 Revisa tu correo para verificar tu cuenta
              </motion.div>
            </div>

            {/* Efecto de brillo rotativo */}
            <div className="success-glow" />
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default SuccessModal;