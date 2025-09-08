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
      // 1️⃣ Iniciar sesión en Supabase
      const { data, error: loginError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      if (loginError) throw loginError;

      // 2️⃣ Buscar rol en la tabla "usuarios"
      const { data: userData, error: roleError } = await supabase
        .from('usuarios')
        .select('rol, nombre')
        .eq('supabase_id', data.user.id)
        .maybeSingle(); // Devuelve null si no encuentra nada

      if (roleError) throw roleError;

      // 3️⃣ Si no existe, crear registro con rol visitante
      let rol = 'visitante';
      if (!userData) {
        const { data: newUser, error: insertError } = await supabase
          .from('usuarios')
          .insert({
            supabase_id: data.user.id,
            email: data.user.email,
            nombre: data.user.user_metadata?.full_name || data.user.email?.split('@')[0] || 'Usuario',
            rol: 'visitante'
          })
          .select('rol')
          .single();

        if (insertError) {
          setError('Error al registrar usuario en el sistema');
          setLoading(false);
          return;
        }
        rol = newUser.rol;
      } else {
        rol = userData.rol || 'visitante';
      }

      // 4️⃣ Redirigir según rol
      switch (rol) {
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

      setLoading(false);

    } catch (err) {
      console.error('Error en login:', err);
      setError(err?.message || 'Error al iniciar sesión');
      setLoading(false);
    }
  };

  const handleResetPassword = async () => {
    if (!email.trim()) {
      setError('Ingresa tu correo para restablecer la contraseña');
      return;
    }
    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email);
      if (error) throw error;
      alert('Se ha enviado un correo para restablecer la contraseña');
      setError('');
    } catch (err) {
      console.error('Error al enviar correo de recuperación:', err);
      setError(err?.message || 'Error al enviar correo de recuperación');
    }
  };

  return (
    <form
      onSubmit={handleLogin}
      className="flex flex-col space-y-4 max-w-md mx-auto mt-10 p-6 shadow-lg rounded-lg bg-white"
    >
      <h2 className="text-2xl font-bold text-center text-emerald-700">Iniciar Sesión</h2>

      <input
        type="email"
        placeholder="Correo electrónico"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight 
                   focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      <input
        type="password"
        placeholder="Contraseña"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight 
                   focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {error && (
        <motion.p className="text-red-500 text-sm text-center" initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}>
          {error}
        </motion.p>
      )}

      <motion.button
        type="submit"
        disabled={loading}
        className="bg-emerald-700 hover:bg-emerald-800 text-white font-bold py-2 px-4 rounded 
                   focus:outline-none focus:shadow-outline disabled:opacity-50 disabled:cursor-not-allowed"
        whileHover={{ scale: loading ? 1 : 1.05 }}
        whileTap={{ scale: loading ? 1 : 0.95 }}
      >
        {loading ? (
          <div className="flex items-center justify-center">
            <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Ingresando...
          </div>
        ) : (
          'Ingresar'
        )}
      </motion.button>

      <div className="text-center mt-4">
        <button
          type="button"
          onClick={handleResetPassword}
          className="text-sm text-emerald-700 hover:text-emerald-900 underline focus:outline-none"
        >
          ¿Olvidaste tu contraseña?
        </button>
      </div>
    </form>
  );
};

export default LoginForm;
