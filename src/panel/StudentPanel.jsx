import React, { useState, useEffect, useCallback } from 'react';
import { supabase } from '../services/supabaseClient';
import {
  ArrowRight, Book, Medal, GraduationCap, Lock, Check,
  Star, Award, AlertCircle, Brain, Target, Trophy, Users, 
  Calculator, Palette, Globe, Heart, Zap, Play, Pause,
  Volume2, VolumeX, Settings, Home, BarChart3, Gift
} from 'lucide-react';
import '../home.css';
import { useNavigate } from 'react-router-dom';

const ElementaryLearningApp = () => {
  const navigate = useNavigate();

  // Estados principales
  const [user, setUser] = useState(null);
  const [currentLevel, setCurrentLevel] = useState(1);
  const [energy, setEnergy] = useState(5);
  const [starsEarnedToday, setStarsEarnedToday] = useState(3);
  const [totalStars, setTotalStars] = useState(15);
  const [characterMessage, setCharacterMessage] = useState('¡Hola! Soy Carín, tu tortuga compañera de aventuras. ¿Listo para aprender?');
  const [characterAnimation, setCharacterAnimation] = useState('idle');
  const [selectedLevel, setSelectedLevel] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [modalType, setModalType] = useState(null);
  const [soundEnabled, setSoundEnabled] = useState(true);
  const [currentStreak, setCurrentStreak] = useState(7);
  const [showSettings, setShowSettings] = useState(false);
  const [achievements, setAchievements] = useState([]);

  // Configuración de niveles
  const levels = [
    {
      id: 1,
      title: 'Mis Primeros Números',
      unlocked: true,
      completed: true,
      stars: 3,
      icon: Calculator,
      color: 'from-blue-500 to-blue-600',
      description: 'Aprende a contar, sumar y restar de forma divertida',
      difficulty: 'Fácil',
      estimatedTime: '15 min',
      lessonsCount: 12
    },
    {
      id: 2,
      title: 'Palabras Mágicas',
      unlocked: true,
      completed: false,
      stars: 1,
      icon: Book,
      color: 'from-green-500 to-green-600',
      description: 'Descubre el mundo de las letras y forma tus primeras palabras',
      difficulty: 'Fácil',
      estimatedTime: '20 min',
      lessonsCount: 15
    },
    {
      id: 3,
      title: 'Colores y Formas',
      unlocked: true,
      completed: false,
      stars: 0,
      icon: Palette,
      color: 'from-purple-500 to-purple-600',
      description: 'Explora los colores del arcoíris y las formas que nos rodean',
      difficulty: 'Fácil',
      estimatedTime: '18 min',
      lessonsCount: 10
    },
    {
      id: 4,
      title: 'Ciencias Divertidas',
      unlocked: false,
      completed: false,
      stars: 0,
      icon: Brain,
      color: 'from-orange-500 to-orange-600',
      description: 'Experimenta y descubre cómo funciona el mundo',
      difficulty: 'Medio',
      estimatedTime: '25 min',
      lessonsCount: 18
    },
    {
      id: 5,
      title: 'Explorando el Mundo',
      unlocked: false,
      completed: false,
      stars: 0,
      icon: Globe,
      color: 'from-teal-500 to-teal-600',
      description: 'Viaja por países y culturas increíbles',
      difficulty: 'Medio',
      estimatedTime: '30 min',
      lessonsCount: 20
    },
    {
      id: 6,
      title: 'Arte y Creatividad',
      unlocked: false,
      completed: false,
      stars: 0,
      icon: Palette,
      color: 'from-pink-500 to-pink-600',
      description: 'Expresa tu creatividad a través del arte',
      difficulty: 'Fácil',
      estimatedTime: '22 min',
      lessonsCount: 14
    }
  ];

  // Logros disponibles
  const availableAchievements = [
    { id: 1, title: 'Primera Estrella', description: 'Ganaste tu primera estrella', icon: Star, unlocked: true },
    { id: 2, title: 'Racha de 7 días', description: 'Aprendiste 7 días seguidos', icon: Trophy, unlocked: true },
    { id: 3, title: 'Matemático', description: 'Completaste el nivel de números', icon: Calculator, unlocked: true },
    { id: 4, title: 'Explorador', description: 'Desbloqueaste 3 niveles', icon: Target, unlocked: false }
  ];

  // Función para que Carín hable
  const carinSpeak = useCallback((message) => {
    setCharacterMessage(message);
    setCharacterAnimation('talking');

    if (soundEnabled && 'speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(message);
      utterance.lang = 'es-ES';
      utterance.rate = 0.9;
      utterance.pitch = 1.2;

      utterance.onend = () => {
        setCharacterAnimation('idle');
      };

      window.speechSynthesis.cancel();
      window.speechSynthesis.speak(utterance);
    } else {
      setTimeout(() => setCharacterAnimation('idle'), 3000);
    }
  }, [soundEnabled]);

  // Seleccionar nivel
  const selectLevel = useCallback((level) => {
    if (level.unlocked) {
      setSelectedLevel(level);
      setModalType('level');
      setShowModal(true);
      carinSpeak(`¡Qué emocionante! El mundo de "${level.title}" está lleno de aventuras increíbles.`);
    } else {
      carinSpeak('Primero necesitas completar los niveles anteriores para desbloquear esta aventura.');
    }
  }, [carinSpeak]);

  // Iniciar nivel
  const startLevel = () => {
    if (energy > 0) {
      setEnergy(prev => prev - 1);
      setShowModal(false);
      carinSpeak(`¡Perfecto! Comencemos con ${selectedLevel.title}. ¡Tú puedes!`);
    } else {
      carinSpeak('No tienes suficiente energía. ¡Descansa un poco y vuelve más tarde!');
    }
  };

  // Calcular progreso
  const calculateCourseProgress = () => {
    const total = levels.length;
    const completed = levels.filter(l => l.completed).length;
    return (completed / total) * 100;
  };

  // Clases de animación del personaje
  const getCharacterClasses = () => {
    const base = "w-24 h-24 transition-all duration-500 cursor-pointer hover:scale-110";
    return characterAnimation === 'talking' ? `${base} animate-bounce` : base;
  };

  // Modal
  const closeModal = () => {
    setShowModal(false);
    setSelectedLevel(null);
    setModalType(null);
  };

  // Obtener usuario al cargar
  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session?.user) setUser(session.user);
    });

    const { data: listener } = supabase.auth.onAuthStateChange((event, session) => {
      if (session?.user) setUser(session.user);
      else setUser(null);
    });

    const timer = setTimeout(() => {
      carinSpeak('¡Bienvenido de vuelta! ¿Qué aventura quieres vivir hoy?');
    }, 1000);

    return () => {
      listener.subscription.unsubscribe();
      clearTimeout(timer);
    };
  }, [carinSpeak]);

  return (
    <div className="min-h-screen bg-gradient-to-br from-sky-100 via-indigo-50 to-purple-100">
      {/* Header */}
      <header className="bg-gradient-to-r from-indigo-600 to-purple-600 text-white shadow-xl sticky top-0 z-50">
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center space-x-4">
            <div className="bg-white/20 rounded-full p-2">
              <GraduationCap className="w-8 h-8 text-white" />
            </div>
            <div>
              <h1 className="text-2xl font-bold">DidaktikApp</h1>
              <p className="text-indigo-100 text-sm">Aprende jugando</p>
            </div>
          </div>

          {user ? (
            <div className="flex items-center space-x-4">
              <span className="font-semibold">{user.user_metadata?.nombre || user.email}</span>
              <button
                onClick={async () => {
                  await supabase.auth.signOut();
                  setUser(null);
                }}
                className="px-2 py-1 bg-white/20 rounded hover:bg-white/30"
              >
                Cerrar sesión
              </button>
            </div>
          ) : (
            <div className="flex space-x-4">
              <button onClick={() => navigate('/login')} className="text-white hover:underline">
                Iniciar sesión
              </button>
              <button onClick={() => navigate('/register')} className="text-white hover:underline">
                Registrarse
              </button>
            </div>
          )}

          <div className="flex items-center space-x-4 ml-4">
            <div className="flex items-center space-x-2">
              <Zap className="w-5 h-5 text-yellow-300" />
              <span className="font-semibold">{energy}</span>
            </div>
            <div className="flex items-center space-x-2">
              <Star className="w-5 h-5 text-yellow-300 fill-yellow-300" />
              <span className="font-semibold">{totalStars}</span>
            </div>
            <div className="flex items-center space-x-2">
              <Trophy className="w-5 h-5 text-orange-300" />
              <span className="font-semibold">{currentStreak}</span>
            </div>
            <button
              onClick={() => setSoundEnabled(!soundEnabled)}
              className="p-2 bg-white/20 rounded-full hover:bg-white/30 transition-colors"
            >
              {soundEnabled ? <Volume2 className="w-5 h-5" /> : <VolumeX className="w-5 h-5" />}
            </button>
          </div>
        </div>
      </header>

      {/* Progreso del curso */}
      <div className="container mx-auto px-4 py-4">
        <div className="bg-white rounded-xl shadow-lg p-4 mb-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="font-semibold text-gray-700">Progreso del Curso</h3>
            <span className="text-sm text-gray-500">{calculateCourseProgress().toFixed(0)}% completado</span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-3">
            <div
              className="bg-gradient-to-r from-green-400 to-blue-500 h-3 rounded-full transition-all duration-1000 ease-out"
              style={{ width: `${calculateCourseProgress()}%` }}
            ></div>
          </div>
        </div>
      </div>

      {/* Mensaje de Carín */}
      <div className="container mx-auto px-4 mb-6">
        <div className="bg-gradient-to-r from-emerald-400 to-cyan-400 text-white rounded-xl p-4 shadow-lg">
          <div className="flex items-center space-x-3">
            <div className="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
              <Heart className="w-6 h-6 text-white" />
            </div>
            <div className="flex-1">
              <p className="font-medium">{characterMessage}</p>
            </div>
          </div>
        </div>
      </div>

      {/* Grid de niveles */}
      <main className="container mx-auto px-4 pb-8">
        <h2 className="text-2xl font-bold text-gray-800 mb-6">Niveles de Aprendizaje</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {levels.map(level => (
            <div
              key={level.id}
              onClick={() => selectLevel(level)}
              className={`relative overflow-hidden rounded-2xl shadow-xl cursor-pointer transform transition-all duration-300 hover:scale-105 hover:shadow-2xl
                ${level.unlocked ? 'hover:ring-4 hover:ring-white/50' : 'opacity-60 cursor-not-allowed'}`}
            >
              <div className={`bg-gradient-to-br ${level.color} p-6 text-white`}>
                <div className="flex items-center justify-between mb-4">
                  <level.icon className="w-8 h-8" />
                  {!level.unlocked && <Lock className="w-6 h-6 text-white/70" />}
                </div>
                <h3 className="text-xl font-bold mb-2">{level.title}</h3>
                <p className="text-white/90 text-sm mb-4">{level.description}</p>
                <div className="flex items-center justify-between text-sm">
                  <div className="flex items-center space-x-4">
                    <span className="bg-white/20 px-2 py-1 rounded-full">{level.difficulty}</span>
                    <span className="bg-white/20 px-2 py-1 rounded-full">{level                    .estimatedTime}</span>
                  </div>
                  <span className="text-white/80">{level.lessonsCount} lecciones</span>
                </div>
                <div className="mt-4 flex items-center justify-between">
                  <div className="flex space-x-1">
                    {Array.from({ length: 3 }).map((_, i) => (
                      <Star
                        key={i}
                        className={`w-5 h-5 ${i < level.stars ? 'text-yellow-300 fill-yellow-300' : 'text-white/30'}`}
                      />
                    ))}
                  </div>
                  {level.completed && (
                    <div className="bg-green-500 rounded-full p-1">
                      <Check className="w-4 h-4 text-white" />
                    </div>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Sección de logros */}
        <div className="mt-12">
          <h2 className="text-2xl font-bold text-gray-800 mb-6">Tus Logros</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {availableAchievements.map(achievement => (
              <div
                key={achievement.id}
                className={`bg-white rounded-xl p-4 shadow-lg border-2 transition-all duration-300
                  ${achievement.unlocked 
                    ? 'border-yellow-300 bg-gradient-to-br from-yellow-50 to-orange-50' 
                    : 'border-gray-200 opacity-60'
                  }`}
              >
                <div className="text-center">
                  <div className={`w-12 h-12 rounded-full mx-auto mb-3 flex items-center justify-center
                    ${achievement.unlocked ? 'bg-yellow-100' : 'bg-gray-100'}`}>
                    <achievement.icon className={`w-6 h-6 ${achievement.unlocked ? 'text-yellow-600' : 'text-gray-400'}`} />
                  </div>
                  <h3 className="font-semibold text-sm text-gray-800">{achievement.title}</h3>
                  <p className="text-xs text-gray-600 mt-1">{achievement.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>

      {/* Personaje flotante */}
      <div className="fixed bottom-6 right-6 z-30">
        <div className="relative">
          <div className="bg-white rounded-full p-2 shadow-2xl">
            <div className={getCharacterClasses()}>🐢</div>
          </div>
          {characterAnimation === 'talking' && (
            <div className="absolute -top-2 -right-2 w-4 h-4 bg-green-500 rounded-full animate-pulse"></div>
          )}
        </div>
      </div>

      {/* Modal de nivel */}
      {showModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl max-w-md w-full max-h-[90vh] overflow-y-auto">
            {selectedLevel && (
              <div>
                <div className={`bg-gradient-to-br ${selectedLevel.color} p-6 text-white`}>
                  <div className="flex items-center justify-between">
                    <selectedLevel.icon className="w-12 h-12" />
                    <button
                      onClick={closeModal}
                      className="text-white/80 hover:text-white transition-colors"
                    >
                      ✕
                    </button>
                  </div>
                  <h2 className="text-2xl font-bold mt-4">{selectedLevel.title}</h2>
                  <p className="text-white/90 mt-2">{selectedLevel.description}</p>
                </div>
                
                <div className="p-6 space-y-4">
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Dificultad:</span>
                    <span className="font-semibold">{selectedLevel.difficulty}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Tiempo estimado:</span>
                    <span className="font-semibold">{selectedLevel.estimatedTime}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Lecciones:</span>
                    <span className="font-semibold">{selectedLevel.lessonsCount}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-600">Energía requerida:</span>
                    <div className="flex items-center space-x-1">
                      <Zap className="w-4 h-4 text-yellow-500" />
                      <span className="font-semibold">1</span>
                    </div>
                  </div>

                  <div className="mt-6 flex space-x-3">
                    <button
                      onClick={closeModal}
                      className="flex-1 px-4 py-3 bg-gray-200 text-gray-800 rounded-xl font-semibold hover:bg-gray-300 transition-colors"
                    >
                      Cancelar
                    </button>
                    <button
                      onClick={startLevel}
                      disabled={energy === 0}
                      className={`flex-1 px-4 py-3 rounded-xl font-semibold transition-colors flex items-center justify-center space-x-2
                        ${energy > 0
                          ? 'bg-gradient-to-r from-green-500 to-blue-500 text-white hover:from-green-600 hover:to-blue-600'
                          : 'bg-gray-300 text-gray-500 cursor-not-allowed'
                        }`}
                    >
                      <Play className="w-4 h-4" />
                      <span>¡Empezar!</span>
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default ElementaryLearningApp;
