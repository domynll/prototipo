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
      const { data: loginData, error: loginError } = await supabase.auth.signInWithPassword({ email, password });
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
        case 'admin': navigate('/admin'); break;
        case 'docente': navigate('/docente'); break;
        case 'estudiante': navigate('/estudiante'); break;
        default: navigate('/visitante');
      }

      setLoading(false);
    } catch (err) {
      console.error('Error login:', err);
      setError(err?.message || 'Usuario no registrado o credenciales incorrectas');
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleLogin} className="flex flex-col space-y-4 max-w-md mx-auto mt-10 p-6 shadow-lg rounded-lg bg-white">
      <h2 className="text-2xl font-bold text-center text-emerald-700">Iniciar Sesión</h2>

      <input type="email" placeholder="Correo electrónico" value={email} onChange={e => setEmail(e.target.value)} required className="input" />
      <input type="password" placeholder="Contraseña" value={password} onChange={e => setPassword(e.target.value)} required className="input" />

      {error && <motion.p className="text-red-500 text-sm text-center" initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}>{error}</motion.p>}

      <motion.button type="submit" disabled={loading} className="btn">
        {loading ? 'Ingresando...' : 'Ingresar'}
      </motion.button>
    </form>
  );
};

export default LoginForm;
