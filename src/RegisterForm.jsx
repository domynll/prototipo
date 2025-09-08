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
    setError('');

    // Validaciones
    if (!name.trim()) return setError('Por favor ingresa tu nombre');
    if (!email.trim()) return setError('Por favor ingresa tu correo');
    if (password.length < 6) return setError('La contraseña debe tener al menos 6 caracteres');
    if (password !== confirmPassword) return setError('Las contraseñas no coinciden');

    setLoading(true);

    try {
      // Crear usuario en Supabase Auth
      const { data: authData, error: signUpError } = await supabase.auth.signUp({
        email,
        password,
        options: { data: { nombre: name } }
      });

      if (signUpError) throw signUpError;

      // Insertar en tabla "usuarios" con rol visitante
      const { error: dbError } = await supabase
        .from('usuarios')
        .insert([{
          supabase_id: authData.user.id,
          nombre: name,
          email,
          rol: 'visitante'
        }]);

      if (dbError) throw dbError;

      console.log('Usuario registrado correctamente', authData.user);
      setLoading(false);
      if (onRegisterSuccess) onRegisterSuccess();

    } catch (err) {
      console.error('Error registro:', err);
      setError(err?.message || 'Hubo un error al crear la cuenta');
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleRegister} className="flex flex-col space-y-4 max-w-md mx-auto mt-10 p-6 shadow-lg rounded-lg bg-white">
      <h2 className="text-2xl font-bold text-center text-emerald-700">Crear Cuenta</h2>

      <input type="text" placeholder="Nombre completo" value={name} onChange={e => setName(e.target.value)} required className="input" />
      <input type="email" placeholder="Correo electrónico" value={email} onChange={e => setEmail(e.target.value)} required className="input" />
      <input type="password" placeholder="Contraseña" value={password} onChange={e => setPassword(e.target.value)} required className="input" />
      <input type="password" placeholder="Confirmar contraseña" value={confirmPassword} onChange={e => setConfirmPassword(e.target.value)} required className="input" />

      {error && <motion.p className="text-red-500 text-sm text-center" initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}>{error}</motion.p>}

      <motion.button type="submit" disabled={loading} className="btn">
        {loading ? 'Registrando...' : 'Registrarse'}
      </motion.button>
    </form>
  );
};

export default RegisterForm;
