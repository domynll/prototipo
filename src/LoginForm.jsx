import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { supabase } from './services/supabaseClient';
import { useNavigate } from 'react-router-dom';
import './FormStyles.css';

const LoginForm = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const { data: loginData, error: loginError } = await supabase.auth.signInWithPassword({ 
        email, 
        password 
      });

      if (loginError) throw loginError;
      if (!loginData.user) throw new Error('Usuario no registrado');

      // Buscar rol en tabla usuarios
      const { data: userData, error: roleError } = await supabase
        .from('usuarios')
        .select('rol, nombre')
        .eq('supabase_id', loginData.user.id)
        .maybeSingle();

      if (roleError) throw roleError;

      let rol = 'visitante';

      if (!userData) {
        // Crear usuario automáticamente si no existe
        const { data: newUser, error: insertError } = await supabase
          .from('usuarios')
          .insert({
            supabase_id: loginData.user.id,
            email: loginData.user.email,
            nombre: loginData.user.user_metadata?.full_name || loginData.user.email.split('@')[0],
            rol: 'visitante'
          })
          .select('rol')
          .single();

        if (insertError) throw insertError;
        rol = newUser.rol;
      } else {
        rol = userData.rol;
      }

      // Redirigir según rol
      switch (rol) {
        case 'admin': 
          navigate('/admin'); 
          break;
        case 'docente': 
          navigate('/teacher'); 
          break;
        case 'estudiante': 
          navigate('/student'); 
          break;
        default: 
          navigate('/visitor');
      }

      setLoading(false);
    } catch (err) {
      console.error('Error login:', err);
      setError(err?.message || 'Usuario no registrado o credenciales incorrectas');
      setLoading(false);
    }
  };

  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const handleGoBack = () => {
    navigate('/'); // Redirige a la página Welcome
  };

  return (
    <div className="login-form-container">
      {/* Figuras geométricas de fondo opcional */}
      <div className="geometric-shape shape-1"></div>
      <div className="geometric-shape shape-2"></div>
      <div className="geometric-shape shape-3"></div>

      <motion.form 
        onSubmit={handleLogin} 
        className="login-form"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        {/* Botón de retroceso en la esquina */}
        <button 
          type="button" 
          className="back-button" 
          onClick={handleGoBack}
        >
          ⬅
        </button>

        <h2 className="form-title">Iniciar Sesión</h2>
        
        {/* Campo de email */}
        <div className="input-group">
          <input 
            type="email" 
            id="email"
            className={`input ${error ? 'error' : ''}`}
            placeholder=" "
            value={email} 
            onChange={(e) => setEmail(e.target.value)} 
            required 
          />
          <label htmlFor="email" className="floating-label">
            Correo electrónico
          </label>
        </div>

        {/* Campo de contraseña */}
        <div className="input-group">
          <input 
            type={showPassword ? "text" : "password"}
            id="password"
            className={`input ${error ? 'error' : ''}`}
            placeholder=" "
            value={password} 
            onChange={(e) => setPassword(e.target.value)} 
            required 
          />
          <label htmlFor="password" className="floating-label">
            Contraseña
          </label>
          <button
            type="button"
            className="password-toggle"
            onClick={togglePasswordVisibility}
            tabIndex="-1"
          >
            {showPassword ? '👁️' : '👁️‍🗨️'}
          </button>
        </div>

        {/* Mensaje de error */}
        {error && (
          <motion.p 
            className="error-message" 
            initial={{ opacity: 0, y: -10 }} 
            animate={{ opacity: 1, y: 0 }}
          >
            {error}
          </motion.p>
        )}

        {/* Botón de submit */}
        <motion.button 
          type="submit" 
          disabled={loading} 
          className={`btn ${loading ? 'loading' : ''}`}
          whileHover={{ scale: loading ? 1 : 1.02 }}
          whileTap={{ scale: loading ? 1 : 0.98 }}
        >
          {loading ? 'Ingresando...' : 'Ingresar'}
        </motion.button>

        {/* Enlaces adicionales */}
        <div className="form-links">
          <a href="/forgot-password" className="form-link">
            ¿Olvidaste tu contraseña?
          </a>
          <br />
          <span style={{ color: '#7f8c8d', fontSize: '0.9rem' }}>
            ¿No tienes cuenta?{' '}
          </span>
          <a href="/register" className="form-link">
            Regístrate
          </a>
        </div>
      </motion.form>
    </div>
  );
};

export default LoginForm;
