'use client';
import React, { useState, useEffect, useRef } from 'react';
import { HashRouter as Router, Routes, Route, Navigate, useNavigate } from 'react-router-dom';
import { supabase } from './services/supabaseClient';
import TurtleWelcome from './TurtleWelcome.jsx';
import LoginForm from './LoginForm';
import RegisterForm from './RegisterForm';
import AdminPanel from './panel/AdminPanel';
import TeacherPanel from './panel/TeacherPanel';
import StudentPanel from './panel/StudentPanel';
import './App.css';

const TypewriterText = ({ text, speed = 50 }) => {
  const [displayedText, setDisplayedText] = useState('');
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    if (currentIndex < text.length) {
      const timeout = setTimeout(() => {
        setDisplayedText(prev => prev + text[currentIndex]);
        setCurrentIndex(prev => prev + 1);
      }, speed);
      return () => clearTimeout(timeout);
    }
  }, [currentIndex, text, speed]);

  return <span>{displayedText}</span>;
};

// Hook para manejar el tema
const useTheme = () => {
  const [theme, setTheme] = useState(() => {
    const savedTheme = localStorage.getItem('theme');
    return savedTheme || 'light';
  });

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }, [theme]);

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  return { theme, toggleTheme };
};

// Componente del botón toggle
const ThemeToggle = ({ theme, toggleTheme }) => {
  return (
    <button
      className="theme-toggle"
      onClick={toggleTheme}
      aria-label={`Cambiar a modo ${theme === 'light' ? 'oscuro' : 'claro'}`}
      title={`Modo ${theme === 'light' ? 'oscuro' : 'claro'}`}
    >
      {theme === 'light' ? '🌙' : '☀️'}
    </button>
  );
};

function Welcome() {
  const [currentPage, setCurrentPage] = useState('home');
  const [user, setUser] = useState(null);
  const [role, setRole] = useState(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();
  const { theme, toggleTheme } = useTheme();

  useEffect(() => {
    setLoading(true);
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session?.user) {
        setUser(session.user);
        fetchUserRole(session.user.id);
      } else {
        setLoading(false);
      }
    });

    const { data: listener } = supabase.auth.onAuthStateChange((event, session) => {
      if (session?.user) {
        setUser(session.user);
        fetchUserRole(session.user.id);
      } else {
        setUser(null);
        setRole(null);
        setLoading(false);
      }
    });

    return () => listener.subscription.unsubscribe();
  }, []);

  const fetchUserRole = async (userId) => {
    try {
      console.log('🔍 Buscando rol para userId:', userId);

      const { data: userData, error } = await supabase
        .from('usuarios')
        .select('rol, nombre, email')
        .eq('auth_id', userId)
        .maybeSingle();

      if (error) {
        console.error('❌ Error fetching user role:', error);
        setRole(null);
        setLoading(false);
        return;
      }

      if (!userData) {
        console.error('❌ Usuario no encontrado en tabla usuarios');
        setRole(null);
        setLoading(false);
        return;
      }

      const userRole = (userData?.rol || '').trim().toLowerCase();
      console.log('✅ Usuario encontrado:', userData?.nombre, 'Email:', userData?.email, 'Rol:', userRole);

      setRole(userRole);
      setLoading(false);
      navigateToRole(userRole);
    } catch (err) {
      console.error('❌ Error al obtener rol:', err);
      setRole(null);
      setLoading(false);
    }
  };

  const navigateToRole = (roleToNavigate) => {
    const normalizedRole = (roleToNavigate || '').trim().toLowerCase();
    console.log('📍 Navegando a rol:', normalizedRole);

    switch (normalizedRole) {
      case 'admin':
        console.log('➡️ Redirigiendo a /admin');
        navigate('/admin');
        break;
      case 'docente':
        console.log('➡️ Redirigiendo a /teacher');
        navigate('/teacher');
        break;
      case 'estudiante':
        console.log('➡️ Redirigiendo a /student');
        navigate('/student');
        break;
      default:
        console.log('⚠️ Rol desconocido, permaneciendo en home:', normalizedRole);
      // No navegar a ningún lado si el rol es desconocido
    }
  };

  const handleButtonClick = (type) => setCurrentPage(type);
  const handleBackToHome = () => setCurrentPage('home');

  if (currentPage === 'login') return (
    <>
      <ThemeToggle theme={theme} toggleTheme={toggleTheme} />
      <LoginForm
        supabase={supabase}
        navigateBack={handleBackToHome}
      />
    </>
  );

  if (currentPage === 'register') return (
    <>
      <ThemeToggle theme={theme} toggleTheme={toggleTheme} />
      <RegisterForm
        supabase={supabase}
        navigateBack={handleBackToHome}
        onGoToLogin={() => setCurrentPage('login')}
        onRegisterSuccess={() => setCurrentPage('login')}
      />
    </>
  );

  return (
    <>
      <ThemeToggle theme={theme} toggleTheme={toggleTheme} />

      <div className="app-container">
        <div className="welcome-card">
          <div className="turtle-wrapper">
            <TurtleWelcome />
          </div>

          <h1 className="main-title">DIDACTIKAPP</h1>

          <p className="description">
            <TypewriterText
              text="Aprendé didáctica de forma interactiva, con simulaciones y herramientas pedagógicas."
              speed={40}
            />
          </p>

          <div className="buttons-container">
            <button className="btn btn-primary" onClick={() => handleButtonClick('login')}>
              <span>Iniciar sesión</span>
            </button>
            <button className="btn btn-secondary" onClick={() => handleButtonClick('register')}>
              <span>Crear cuenta</span>
            </button>
          </div>
        </div>
      </div>
    </>
  );
}

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Welcome />} />
        <Route path="/admin" element={<AdminPanel />} />
        <Route path="/teacher" element={<TeacherPanel />} />
        <Route path="/student" element={<StudentPanel />} />
        <Route path="/login" element={<LoginForm supabase={supabase} />} />
        <Route path="/register" element={<RegisterForm supabase={supabase} />} />
        <Route path="/visitor" element={<Navigate to="/" />} />
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>
    </Router>
  );
}