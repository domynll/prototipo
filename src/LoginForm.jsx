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
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      if (error) throw error;

      // 2️⃣ Buscar el rol en la tabla usuarios usando supabase_id
      const { data: userData, error: roleError } = await supabase
        .from('usuarios')
        .select('rol')
        .eq('supabase_id', data.user.id) // 👈 cambio aquí
        .single();

      if (roleError) throw roleError;

      console.log('Usuario:', data.user);
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
      setError(
        err?.message || JSON.stringify(err) || 'Error al iniciar sesión.'
      );
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
      setError(
        err?.message || JSON.stringify(err) || 'Error al enviar correo'
      );
    }
  };

  return (
    <form
      onSubmit={handleLogin}
      className="flex flex-col space-y-4 max-w-md mx-auto mt-10 p-6 shadow-lg rounded-lg bg-white"
    >
      <h2 className="text-2xl font-bold text-center text-emerald-700">
        Iniciar Sesión
      </h2>

      {/* Email */}
      <input
        type="email"
        placeholder="Correo electrónico"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight 
                   focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {/* Contraseña */}
      <input
        type="password"
        placeholder="Contraseña"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight 
                   focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {/* Error */}
      {error && (
        <motion.p
          className="text-red-500 text-sm text-center"
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
        className="bg-emerald-700 hover:bg-emerald-800 text-white font-bold py-2 px-4 rounded 
                   focus:outline-none focus:shadow-outline"
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        {loading ? (
          <div className="flex items-center justify-center">
            <svg
              className="animate-spin -ml-1 mr-2 h-4 w-4 text-white"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                className="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                strokeWidth="4"
              ></circle>
              <path
                className="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 
                3.042 1.135 5.824 3 7.938l3-2.647z"
              ></path>
            </svg>
            Ingresando...
          </div>
        ) : (
          'Ingresar'
        )}
      </motion.button>

      {/* Reset password */}
      <div className="text-center mt-4">
        <button
          type="button"
          onClick={handleResetPassword}
          className="text-sm text-emerald-700 hover:text-emerald-900 underline"
        >
          ¿Olvidaste tu contraseña?
        </button>
      </div>
    </form>
  );
};

export default LoginForm;
