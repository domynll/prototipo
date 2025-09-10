'use client';
import React, { useState, useEffect, useRef } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate, useNavigate } from 'react-router-dom';
import { supabase } from './services/supabaseClient';
import TurtleWelcome from './TurtleWelcome.jsx';
import LoginForm from './LoginForm';
import RegisterForm from './RegisterForm';

import AdminPanel from './panel/AdminPanel';
import TeacherPanel from './panel/TeacherPanel';
import StudentPanel from './panel/StudentPanel';
import VisitorPanel from './panel/VisitorPanel';
import './App.css';
import './FormStyles.css';
import './home.css';

// Tipowriter para texto animado
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

// Componente principal de bienvenida
function Welcome() {
  const [currentPage, setCurrentPage] = useState('home'); // home | login | register
  const [user, setUser] = useState(null);
  const [role, setRole] = useState('visitante');
  const navigate = useNavigate();
  const titleRef = useRef(null);

  // Revisar sesión al cargar
  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session?.user) {
        setUser(session.user);
        // Traer rol desde la tabla usuarios
        fetchUserRole(session.user.id);
      }
    });

    const { data: listener } = supabase.auth.onAuthStateChange((event, session) => {
      if (session?.user) {
        setUser(session.user);
        fetchUserRole(session.user.id);
      } else {
        setUser(null);
        setRole('visitante');
      }
    });

    return () => listener.subscription.unsubscribe();
  }, []);

  const fetchUserRole = async (userId) => {
    try {
      const { data: userData } = await supabase
        .from('usuarios')
        .select('rol')
        .eq('supabase_id', userId)
        .maybeSingle(); // devuelve null si no existe

      let userRole = userData?.rol || 'visitante';
      setRole(userRole);
      navigateToRole(userRole);
    } catch (err) {
      console.error('Error al obtener rol:', err);
      setRole('visitante');
      navigateToRole('visitante');
    }
  };

  const navigateToRole = (role) => {
    switch(role) {
      case 'admin': navigate('/admin'); break;
      case 'docente': navigate('/teacher'); break;
      case 'estudiante': navigate('/student'); break;
      default: navigate('/visitor'); break;
    }
  };

  const handleButtonClick = (type) => setCurrentPage(type);

  if (currentPage === 'login') return <LoginForm supabase={supabase} navigateToRole={navigateToRole} />;
  if (currentPage === 'register') return <RegisterForm supabase={supabase} onRegisterSuccess={() => setCurrentPage('login')} />;

  return (
    <div className="min-h-screen">
      <div className="welcome-card">
        <div className="turtle-container">
          <TurtleWelcome />
        </div>

        <h1 ref={titleRef} className="main-title">
          DIDACTIKAPP
        </h1>

        <p className="description">
          <TypewriterText text="Aprendé didáctica de forma interactiva, con simulaciones y herramientas pedagógicas." speed={40} />
        </p>

        <div className="buttons-container">
          <button
            className="btn btn-primary"
            onClick={() => handleButtonClick('login')}
          >
            Iniciar sesión
          </button>
          <button
            className="btn btn-secondary"
            onClick={() => handleButtonClick('register')}
          >
            Crear cuenta
          </button>
        </div>
      </div>
    </div>
  );
}

// App.jsx principal con rutas - SIN CAMBIOS
export default function App() {
  return (
    <Router>
      <Routes>
        {/* Página de bienvenida */}
        <Route path="/" element={<Welcome />} />

        {/* Rutas de paneles por rol */}
        <Route path="/admin" element={<AdminPanel />} />
        <Route path="/teacher" element={<TeacherPanel />} />
        <Route path="/student" element={<StudentPanel />} />
        <Route path="/visitor" element={<VisitorPanel />} />

        {/* Autenticación */}
        <Route path="/login" element={<LoginForm supabase={supabase} />} />
        <Route path="/register" element={<RegisterForm supabase={supabase} />} />

        {/* Redirección de fallback */}
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>
    </Router>
  );
}