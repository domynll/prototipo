// src/hooks/useAuth.js
import { useState, useEffect } from 'react';
import { supabase } from '../services/supabaseClient';

const useAuth = () => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
    });

    const { data: listener } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null);
    });

    return () => listener.subscription.unsubscribe();
  }, []);

  return user;
};

export default useAuth;
