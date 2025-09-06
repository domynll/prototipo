import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { supabase } from './services/supabaseClient';
import './FormStyles.css';

const RegisterForm = ({ onRegisterSuccess }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [name, setName] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleRegister = async (e) => {
    e.preventDefault();

    // Validaciones básicas
    if (!name.trim()) return setError('Por favor ingresa tu nombre');
    if (!email.trim()) return setError('Por favor ingresa tu correo electrónico');
    if (password.length < 6) return setError('La contraseña debe tener al menos 6 caracteres');
    if (password !== confirmPassword) return setError('Las contraseñas no coinciden');

    setLoading(true);
    setError('');

    try {
      // 1️⃣ Crear usuario en Supabase Auth
      const { data: authData, error: signUpError } = await supabase.auth.signUp({
        email,
        password,
        options: { data: { nombre: name } }, // metadata
      });

      if (signUpError) throw signUpError;

      // 2️⃣ Guardar info adicional en tabla "usuarios"
      const { error: dbError } = await supabase
        .from('usuarios')
        .insert([{ supabase_id: authData.user.id, nombre: name, email }]);

      if (dbError) throw dbError;

      console.log('Usuario registrado y guardado en DB:', authData.user);

      setLoading(false);
      if (onRegisterSuccess) onRegisterSuccess();

    } catch (err) {
      console.error('Error al registrar:', err);
      setError(err?.message || JSON.stringify(err) || 'Hubo un error al crear la cuenta');
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleRegister} className="flex flex-col space-y-4">
      <h2 className="text-2xl font-bold text-center text-emerald-700">Crear Cuenta</h2>

      {/* Nombre */}
      <input
        type="text"
        placeholder="Nombre completo"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {/* Email */}
      <input
        type="email"
        placeholder="Correo electrónico"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {/* Contraseña */}
      <input
        type="password"
        placeholder="Contraseña"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {/* Confirmar contraseña */}
      <input
        type="password"
        placeholder="Confirmar contraseña"
        value={confirmPassword}
        onChange={(e) => setConfirmPassword(e.target.value)}
        required
        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-emerald-500"
      />

      {/* Error */}
      {error && <motion.p className="text-red-500 text-sm text-center" initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}>{error}</motion.p>}

      {/* Botón */}
      <motion.button
        type="submit"
        disabled={loading}
        className="bg-emerald-700 hover:bg-emerald-800 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        {loading ? (
          <div className="flex items-center justify-center">
            <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Registrando...
          </div>
        ) : (
          'Registrarse'
        )}
      </motion.button>
    </form>
  );
};

export default RegisterForm;
