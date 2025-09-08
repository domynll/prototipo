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
    
    console.log('🔍 INICIO - handleLogin');

    try {
      // 1️⃣ Iniciar sesión en Supabase
      console.log('🔍 PASO 1 - Intentando login con:', { email });
      const { data, error: loginError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      
      console.log('🔍 PASO 1 - Resultado login:', { data: !!data, error: loginError });
      if (loginError) {
        console.log('❌ ERROR EN LOGIN:', loginError);
        throw loginError;
      }

      // 2️⃣ Buscar el rol en la tabla "usuarios" usando supabase_id
      console.log('🔍 PASO 2 - Buscando rol para user ID:', data.user.id);
      const { data: userData, error: roleError } = await supabase
        .from('usuarios')
        .select('rol')
        .eq('supabase_id', data.user.id);

      console.log('🔍 PASO 2 - Resultado búsqueda rol:', { userData, error: roleError });
      if (roleError) {
        console.log('❌ ERROR EN ROL:', roleError);
        throw roleError;
      }

      if (!userData || userData.length === 0) {
        console.log('❌ Usuario no encontrado en tabla usuarios');
        setError('Usuario no registrado en el sistema');
        setLoading(false);
        return;
      }

      const rol = userData[0].rol || 'visitante';
      console.log('🔍 PASO 3 - Rol encontrado:', rol);

      // 3️⃣ Redirigir según rol
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

      console.log('✅ LOGIN EXITOSO - Redirigiendo a:', rol);
      setLoading(false);
      
    } catch (err) {
      console.log('❌ ERROR CAPTURADO EN CATCH:');
      console.log('   - Tipo:', typeof err);
      console.log('   - Constructor:', err.constructor.name);
      console.log('   - Message:', err?.message);
      console.log('   - Error completo:', err);
      
      // Manejo seguro del error
      let errorMessage = 'Error al iniciar sesión';
      
      if (err && typeof err === 'object') {
        if (err.message) {
          errorMessage = err.message;
        } else if (err.error_description) {
          errorMessage = err.error_description;
        } else if (err.details) {
          errorMessage = err.details;
        }
      } else if (typeof err === 'string') {
        errorMessage = err;
      }
      
      console.log('🔍 Mensaje de error final:', errorMessage);
      setError(errorMessage);
      setLoading(false);
    }
  };

  const handleResetPassword = async () => {
    if (!email.trim()) {
      setError('Ingresa tu correo para restablecer la contraseña');
      return;
    }
    
    console.log('🔍 INICIO - handleResetPassword');
    
    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email);
      console.log('🔍 Resultado reset password:', { error });
      
      if (error) {
        console.log('❌ ERROR EN RESET:', error);
        throw error;
      }
      
      alert('Se ha enviado un correo para restablecer la contraseña');
      setError('');
      
    } catch (err) {
      console.log('❌ ERROR EN RESET PASSWORD:');
      console.log('   - Tipo:', typeof err);
      console.log('   - Message:', err?.message);
      console.log('   - Error completo:', err);
      
      let errorMessage = 'Error al enviar correo de recuperación';
      
      if (err && typeof err === 'object') {
        if (err.message) {
          errorMessage = err.message;
        } else if (err.error_description) {
          errorMessage = err.error_description;
        }
      } else if (typeof err === 'string') {
        errorMessage = err;
      }
      
      console.log('🔍 Mensaje de error reset final:', errorMessage);
      setError(errorMessage);
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
        <motion.p
          className="text-red-500 text-sm text-center"
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
        >
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