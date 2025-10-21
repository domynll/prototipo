import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { supabase } from './services/supabaseClient';
import SuccessModal from './SuccessModal';
import './FormStyles.css';

const RegisterForm = ({ onRegisterSuccess, onBackToLogin, onGoToHome, navigateBack, onGoToLogin }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [name, setName] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [showSuccessModal, setShowSuccessModal] = useState(false);

  const handleRegister = async (e) => {
    e.preventDefault();
    setError('');
    
    // Validaciones
    if (!name.trim()) return setError('Por favor ingresa tu nombre');
    if (!email.trim()) return setError('Por favor ingresa tu correo');
    if (password.length < 6) return setError('La contraseña debe tener al menos 6 caracteres');
    if (password !== confirmPassword) return setError('Las contraseñas no coinciden');
    
    setLoading(true);
    
    try {
      // Crear usuario en Supabase Auth (el trigger se encarga del resto)
      const { data: authData, error: signUpError } = await supabase.auth.signUp({
        email,
        password,
        options: { 
          data: { 
            nombre: name,
            rol: 'visitante'
          } 
        }
      });
      
      if (signUpError) throw signUpError;
      
      console.log('Usuario registrado correctamente', authData.user);
      setLoading(false);
      
      // Mostrar modal de éxito
      setShowSuccessModal(true);
    } catch (err) {
      console.error('Error registro:', err);
      setError(err?.message || 'Hubo un error al crear la cuenta');
      setLoading(false);
    }
  };

  const handleGoToLogin = () => {
    setShowSuccessModal(false);
    // Usar onGoToLogin que va al login, no onBackToLogin que va al home
    if (onGoToLogin) {
      onGoToLogin();
    } else if (onRegisterSuccess) {
      onRegisterSuccess(); // Fallback al callback de éxito que también va al login
    }
  };

  const handleGoToHome = () => {
    setShowSuccessModal(false);
    if (onBackToLogin) onBackToLogin(); // Este SÍ debe ir al home
  };

  // Función para manejar el botón de volver a home
  const handleBackToHome = () => {
    console.log('Botón volver clickeado - Regresando a home'); // Para debug
    if (onBackToLogin && typeof onBackToLogin === 'function') {
      onBackToLogin();
    } else {
      console.warn('onBackToLogin no está definido o no es una función');
    }
  };

  // Función para ir al formulario de login
  const handleGoToLoginForm = () => {
    console.log('Ir a login clickeado'); // Para debug
    if (onRegisterSuccess && typeof onRegisterSuccess === 'function') {
      onRegisterSuccess();
    } else {
      console.warn('onRegisterSuccess no está definido o no es una función');
    }
  };

  return (
    <div className="modern-form-container">
      {/* Toggle de tema */}
      <button className="theme-toggle-form" type="button">
        🌙
      </button>

      <div className="modern-form-card">
        {/* Botón de volver dentro de la tarjeta */}
        <button 
          onClick={navigateBack || onBackToLogin}
          className="modern-back-button"
          type="button"
        >
          <svg className="back-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
          </svg>
           {/* Volver */}
        </button>

        {/* Header */}
        <div className="modern-form-header">
          <h2 className="modern-form-title">✨ Crear Cuenta</h2>
        </div>

        {/* Mensaje de error */}
        {error && (
          <motion.div 
            className="modern-error-message"
            initial={{ opacity: 0, y: -10 }} 
            animate={{ opacity: 1, y: 0 }}
          >
            <span className="error-icon">⚠️</span>
            {error}
          </motion.div>
        )}

        {/* Formulario */}
        <form onSubmit={handleRegister}>
          {/* Campo Nombre */}
          <div className="modern-input-group">
            <input
              type="text"
              className="modern-input"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder=" "
              required
            />
            <label className="modern-floating-label">👤 Nombre completo</label>
            <div className="modern-input-border"></div>
          </div>

          {/* Campo Email */}
          <div className="modern-input-group">
            <input
              type="email"
              className="modern-input"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder=" "
              required
            />
            <label className="modern-floating-label">📧 Correo electrónico</label>
            <div className="modern-input-border"></div>
          </div>

          {/* Campo Contraseña */}
          <div className="modern-input-group">
            <input
              type={showPassword ? 'text' : 'password'}
              className="modern-input"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder=" "
              required
            />
            <label className="modern-floating-label">🔒 Contraseña</label>
            <button
              type="button"
              className="modern-password-toggle"
              onClick={() => setShowPassword(!showPassword)}
            >
              {showPassword ? '👁️' : '👁️‍🗨️'}
            </button>
            <div className="modern-input-border"></div>
          </div>

          {/* Campo Confirmar Contraseña */}
          <div className="modern-input-group">
            <input
              type={showConfirmPassword ? 'text' : 'password'}
              className="modern-input"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder=" "
              required
            />
            <label className="modern-floating-label">🔐 Confirmar contraseña</label>
            <button
              type="button"
              className="modern-password-toggle"
              onClick={() => setShowConfirmPassword(!showConfirmPassword)}
            >
              {showConfirmPassword ? '👁️' : '👁️‍🗨️'}
            </button>
            <div className="modern-input-border"></div>
          </div>

          {/* Botón de submit */}
          <motion.button
            type="submit"
            disabled={loading}
            className={`modern-btn-submit ${loading ? 'loading' : ''}`}
            whileHover={!loading ? { scale: 1.02 } : {}}
            whileTap={!loading ? { scale: 0.98 } : {}}
          >
            {loading && <div className="loading-spinner"></div>}
            {loading ? 'Creando cuenta...' : '🚀 Registrarse'}
            <div className="btn-shine"></div>
          </motion.button>
        </form>

        {/* Enlaces adicionales */}
        <div className="modern-form-links">
          <div className="modern-register-prompt">
            ¿Ya tienes una cuenta?{' '}
            <button
              onClick={onGoToLogin || onRegisterSuccess}
              className="modern-form-link primary"
              type="button"
            >
                Inicia sesión aquí
              </button>
          </div>
        </div>
      </div>

      {/* Modal de éxito */}
      <SuccessModal 
        isOpen={showSuccessModal}
        onGoToLogin={handleGoToLogin}
        onGoToHome={handleGoToHome}
      />
    </div>
  );
};

export default RegisterForm;