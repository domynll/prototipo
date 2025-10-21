import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { supabase } from './services/supabaseClient';
import { useNavigate } from 'react-router-dom';
import './FormStyles.css';

// Hook
const useTheme = () => {
  const [theme, setTheme] = useState(() => {
    const savedTheme = localStorage.getItem('theme');
    return savedTheme || 'light';
  });

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }, [theme]);

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  return { theme, toggleTheme };
};

// Componente del botón toggle
const ThemeToggle = ({ theme, toggleTheme }) => {
  return (
    <button 
      className="theme-toggle-form" 
      onClick={toggleTheme}
      aria-label={`Cambiar a modo ${theme === 'light' ? 'oscuro' : 'claro'}`}
      title={`Modo ${theme === 'light' ? 'oscuro' : 'claro'}`}
    >
      {theme === 'light' ? '🌙' : '☀️'}
    </button>
  );
};

const LoginForm = ({ navigateBack }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();
  const { theme, toggleTheme } = useTheme();

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      console.log('🔐 Iniciando login para:', email);

      // 1. Login con Supabase Auth
      const { data: loginData, error: loginError } = await supabase.auth.signInWithPassword({ 
        email, 
        password 
      });

      if (loginError) {
        console.error('❌ Error de autenticación:', loginError);
        throw new Error('Credenciales incorrectas');
      }

      if (!loginData.user) {
        throw new Error('Usuario no encontrado');
      }

      console.log('✅ Usuario autenticado:', loginData.user.email);
      console.log('🆔 Auth ID:', loginData.user.id);

      // 2. Esperar un poco más para asegurar sincronización
      await new Promise(resolve => setTimeout(resolve, 1000));

      // 3. Intentar múltiples veces buscar el usuario (con retry)
      let userData = null;
      let attempts = 0;
      const maxAttempts = 5;

      while (!userData && attempts < maxAttempts) {
        attempts++;
        console.log(`🔍 Intento ${attempts} de ${maxAttempts} buscando usuario...`);

        const { data, error: roleError } = await supabase
          .from('usuarios')
          .select('id, rol, nombre, email, auth_id')
          .eq('auth_id', loginData.user.id)
          .maybeSingle();

        if (roleError) {
          console.error(`❌ Error en intento ${attempts}:`, roleError);
          if (attempts < maxAttempts) {
            await new Promise(resolve => setTimeout(resolve, 500));
            continue;
          }
          throw new Error(`Error de base de datos: ${roleError.message}`);
        }

        if (data) {
          userData = data;
          console.log('✅ Usuario encontrado en intento', attempts, ':', userData);
          break;
        }

        // Si no se encuentra, esperar antes del siguiente intento
        if (attempts < maxAttempts) {
          console.log('⏳ Usuario no encontrado, esperando...');
          await new Promise(resolve => setTimeout(resolve, 500));
        }
      }

      // 4. Si después de todos los intentos no se encuentra, crear el usuario
      if (!userData) {
        console.log('⚠️ Usuario no encontrado después de todos los intentos');
        console.log('🔧 Intentando crear usuario en la tabla...');

        const { data: newUserData, error: insertError } = await supabase
          .from('usuarios')
          .insert([{
            auth_id: loginData.user.id,
            email: loginData.user.email,
            nombre: loginData.user.email.split('@')[0],
            rol: 'visitante'
          }])
          .select()
          .single();

        if (insertError) {
          console.error('❌ Error creando usuario:', insertError);
          throw new Error('No se pudo crear el perfil del usuario');
        }

        userData = newUserData;
        console.log('✅ Usuario creado exitosamente:', userData);
      }

      console.log('✅ Datos finales del usuario:', userData);
      console.log('🎭 Rol del usuario:', userData.rol);

      // 5. Normalizar el rol y redirigir
      const rolNormalizado = (userData.rol || 'visitante').trim().toLowerCase();
      console.log('🎭 Rol normalizado:', rolNormalizado);

      // 6. Redirigir según el rol
      switch(rolNormalizado) {
        case 'admin':
          console.log('📍 Redirigiendo a /admin');
          navigate('/admin');
          break;
        case 'docente':
          console.log('📍 Redirigiendo a /teacher');
          navigate('/teacher');
          break;
        case 'estudiante':
          console.log('📍 Redirigiendo a /student');
          navigate('/student');
          break;
        default:
          console.log('📍 Rol visitante o desconocido, redirigiendo a home');
          navigate('/');
      }

      setLoading(false);
    } catch (err) {
      console.error('❌ Error completo en login:', err);
      setError(err?.message || 'Error al iniciar sesión. Por favor, intenta de nuevo.');
      setLoading(false);
    }
  };

  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  return (
    <div className="modern-form-container">
      <ThemeToggle theme={theme} toggleTheme={toggleTheme} />
      
      <motion.div 
        className="modern-form-card"
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, ease: "easeOut" }}
      >
        <div className="modern-form-header">
          <motion.button
            type="button"
            className="modern-back-button"
            onClick={navigateBack}
            aria-label="Volver al inicio"
            whileHover={{ scale: 1.05, x: -3 }}
            whileTap={{ scale: 0.95 }}
          >
            <svg className="back-icon" viewBox="0 0 24 24" fill="none">
              <path 
                d="M15 18L9 12L15 6" 
                stroke="currentColor" 
                strokeWidth="2.5" 
                strokeLinecap="round" 
                strokeLinejoin="round"
              />
            </svg>
          </motion.button>

          <motion.h2 
            className="modern-form-title"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
          >
            Iniciar Sesión
          </motion.h2>
        </div>

        <motion.form 
          onSubmit={handleLogin}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.3 }}
        >
          <motion.div 
            className="modern-input-group"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
          >
            <input 
              type="email" 
              id="email"
              className={`modern-input ${error ? 'error' : ''}`}
              placeholder=" "
              value={email} 
              onChange={(e) => setEmail(e.target.value)} 
              required 
            />
            <label htmlFor="email" className="modern-floating-label">
              📧 Correo electrónico
            </label>
            <div className="modern-input-border"></div>
          </motion.div>

          <motion.div 
            className="modern-input-group"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.5 }}
          >
            <input 
              type={showPassword ? "text" : "password"}
              id="password"
              className={`modern-input ${error ? 'error' : ''}`}
              placeholder=" "
              value={password} 
              onChange={(e) => setPassword(e.target.value)} 
              required 
            />
            <label htmlFor="password" className="modern-floating-label">
              🔒 Contraseña
            </label>
            <motion.button
              type="button"
              className="modern-password-toggle"
              onClick={togglePasswordVisibility}
            >
              {showPassword ? '👁️' : '👁️‍🗨️'}
            </motion.button>
            <div className="modern-input-border"></div>
          </motion.div>

          {error && (
            <motion.div 
              className="modern-error-message"
              initial={{ opacity: 0, y: -10, scale: 0.95 }} 
              animate={{ opacity: 1, y: 0, scale: 1 }}
              exit={{ opacity: 0, y: -10, scale: 0.95 }}
            >
              <span className="error-icon">⚠️</span>
              <span>{error}</span>
            </motion.div>
          )}

          <motion.button 
            type="submit" 
            disabled={loading} 
            className={`modern-btn-submit ${loading ? 'loading' : ''}`}
            whileHover={!loading ? { scale: 1.02, y: -2 } : {}}
            whileTap={!loading ? { scale: 0.98 } : {}}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.6 }}
          >
            {loading ? (
              <>
                <div className="loading-spinner"></div>
                <span>Ingresando...</span>
              </>
            ) : (
              <>
                <span>✨ Ingresar</span>
                <div className="btn-shine"></div>
              </>
            )}
          </motion.button>

          <motion.div 
            className="modern-form-links"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.7 }}
          >
            <a href="/forgot-password" className="modern-form-link">
              🔑 ¿Olvidaste tu contraseña?
            </a>
            <div className="modern-register-prompt">
              <span>¿No tienes cuenta?</span>
              <a href="/register" className="modern-form-link primary">
                🚀 Regístrate aquí
              </a>
            </div>
          </motion.div>
        </motion.form>
      </motion.div>
    </div>
  );
};

export default LoginForm;