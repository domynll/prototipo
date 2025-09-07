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

  const navigate = useNavigate();

  // Iniciar sesión
  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      // 1️⃣ Login con Supabase
      const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      if (authError) throw authError;

      const userId = authData.user.id;

      // 2️⃣ Buscar el rol en la tabla usuarios usando supabase_id
      const { data: userData, error: roleError } = await supabase
        .from('usuarios')
        .select('rol')
        .eq('supabase_id', userId)
        .single(); // ✅ asegura solo 1 fila

      if (roleError) throw roleError;

      console.log('Usuario:', authData.user);
      console.log('Rol:', userData.rol);

      setLoading(false);

      // 3️⃣ Redirigir según rol
      switch (userData.rol) {
        case 'admin':
          navigate('/admin');
          break;
        case 'docente':
          navigate('/docente');
          break;
        case 'estudiante':
          navigate('/estudiante');
          break;
        default:
          navigate('/visitante');
      }
    } catch (err) {
      console.error('Error al iniciar sesión:', err);
      setError(err?.message || 'Error al iniciar sesión.');
      setLoading(false);
    }
  };

  // Reset de contraseña
  const handleResetPassword = async () => {
    if (!email.trim()) {
      setError('Ingresa tu correo para restablecer la contraseña');
      return;
    }

    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email);
      if (error) throw error;
      alert('Se ha enviado un correo para restablecer la contraseña');
    } catch (err) {
      console.error('Error al enviar correo de recuperación:', err);
      setError(err?.message || 'Error al enviar correo');
    }
  };

  return (
    <motion.form
      onSubmit={handleLogin}
      className="form-container"
      initial={{ opacity: 0, y: -20 }}
      animate={{ opacity: 1, y: 0 }}
    >
      <h2 className="form-title">Iniciar Sesión</h2>

      {/* Email */}
      <input
        type="email"
        placeholder="Correo electrónico"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        required
        className="form-input"
      />

      {/* Contraseña */}
      <input
        type="password"
        placeholder="Contraseña"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        required
        className="form-input"
      />

      {/* Error */}
      {error && (
        <motion.p
          className="form-error"
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
        >
          {error}
        </motion.p>
      )}

      {/* Botón Ingresar */}
      <motion.button
        type="submit"
        disabled={loading}
        className="form-button"
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        {loading ? 'Ingresando...' : 'Ingresar'}
      </motion.button>

      {/* Reset password */}
      <div className="form-footer">
        <button
          type="button"
          onClick={handleResetPassword}
          className="form-link"
        >
          ¿Olvidaste tu contraseña?
        </button>
      </div>
    </motion.form>
  );
};

export default LoginForm;
