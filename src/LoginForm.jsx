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

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const { data, error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) throw error;

      const { data: userData, error: roleError } = await supabase
        .from('usuarios')
        .select('rol')
        .eq('supabase_id', data.user.id)
        .single();

      if (roleError) throw roleError;

      setLoading(false);

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
      setError(err?.message || JSON.stringify(err) || 'Error al iniciar sesión.');
      setLoading(false);
    }
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-gradient-to-br from-indigo-50 to-purple-100 px-4 py-8">
      <motion.form
        onSubmit={handleLogin}
        className="w-full max-w-lg bg-white p-8 md:p-10 rounded-2xl shadow-2xl space-y-6"
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.3 }}
      >
        {/* Título */}
        <div className="text-center mb-8">
          <h2 className="text-3xl md:text-4xl font-bold text-emerald-700 mb-2">
            Iniciar Sesión
          </h2>
          <p className="text-gray-600">Ingresa tus credenciales para continuar</p>
        </div>

        {/* Campo Email */}
        <div className="space-y-2">
          <label className="block text-sm font-medium text-gray-700">
            Correo electrónico
          </label>
          <input
            type="email"
            placeholder="tu@email.com"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            className="shadow-sm border border-gray-300 rounded-lg w-full py-4 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all duration-200"
          />
        </div>

        {/* Campo Contraseña */}
        <div className="space-y-2">
          <label className="block text-sm font-medium text-gray-700">
            Contraseña
          </label>
          <input
            type="password"
            placeholder="Tu contraseña"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="shadow-sm border border-gray-300 rounded-lg w-full py-4 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all duration-200"
          />
        </div>

        {/* Mensaje de Error */}
        {error && (
          <motion.div
            className="bg-red-50 border border-red-200 rounded-lg p-4"
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <p className="text-red-600 text-sm text-center font-medium">
              {error}
            </p>
          </motion.div>
        )}

        {/* Botón Ingresar */}
        <motion.button
          type="submit"
          disabled={loading}
          className="w-full bg-emerald-700 hover:bg-emerald-800 disabled:bg-emerald-400 text-white font-bold py-4 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2 transition-all duration-200 flex items-center justify-center text-lg"
          whileHover={{ scale: loading ? 1 : 1.02 }}
          whileTap={{ scale: loading ? 1 : 0.98 }}
        >
          {loading ? (
            <div className="flex items-center justify-center space-x-3">
              <svg
                className="animate-spin h-6 w-6 text-white"
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
                />
                <path 
                  className="opacity-75" 
                  fill="currentColor" 
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                />
              </svg>
              <span>Ingresando...</span>
            </div>
          ) : (
            'Ingresar'
          )}
        </motion.button>

        {/* Link de ayuda */}
        <div className="text-center pt-4">
          <button
            type="button"
            className="text-emerald-600 hover:text-emerald-700 text-sm font-medium transition-colors duration-200"
          >
            ¿Olvidaste tu contraseña?
          </button>
        </div>

        {/* Footer */}
        <div className="text-center pt-6 border-t border-gray-200">
          <p className="text-gray-500 text-sm">
            ¿No tienes cuenta?{' '}
            <button
              type="button"
              className="text-emerald-600 hover:text-emerald-700 font-medium"
            >
              Crear cuenta
            </button>
          </p>
        </div>
      </motion.form>
    </div>
  );
};

export default LoginForm;