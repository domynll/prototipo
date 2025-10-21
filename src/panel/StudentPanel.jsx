import React, { useEffect, useState } from 'react';
import { 
  Users, BookOpen, LogOut, Star, Trophy, Zap, Play, Lock, 
  CheckCircle, Clock, Award, TrendingUp, Target, Sparkles,
  Volume2, VolumeX, Heart, Brain, ChevronRight, Home,
  BarChart3, Gift, Calendar, MessageCircle, Medal, XCircle,
  Headphones, Video, Image, HelpCircle, ArrowLeft
} from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { useNavigate } from 'react-router-dom';

// Componente de Tarjeta de Logro
const AchievementCard = ({ achievement, unlocked }) => (
  <div className={`bg-white rounded-xl p-4 shadow-sm border-2 transition-all ${
    unlocked ? 'border-yellow-400 bg-gradient-to-br from-yellow-50 to-orange-50' : 'border-gray-200 opacity-60'
  }`}>
    <div className="text-center">
      <div className={`w-16 h-16 rounded-full mx-auto mb-3 flex items-center justify-center text-3xl ${
        unlocked ? 'bg-yellow-100' : 'bg-gray-100'
      }`}>
        {achievement.icono || '🏆'}
      </div>
      <h3 className="font-bold text-sm text-gray-800">{achievement.nombre}</h3>
      <p className="text-xs text-gray-600 mt-1">{achievement.descripcion}</p>
      {unlocked && (
        <div className="mt-2 flex items-center justify-center gap-1 text-xs text-yellow-600">
          <Star className="w-3 h-3 fill-yellow-600" />
          <span>+{achievement.puntos_recompensa} puntos</span>
        </div>
      )}
    </div>
  </div>
);

// Componente de Tarjeta de Curso
const CourseCard = ({ course, onClick, progress = 0 }) => {
  const Icon = BookOpen;
  
  return (
    <div
      onClick={onClick}
      className="bg-white rounded-2xl shadow-lg overflow-hidden cursor-pointer transform transition-all duration-300 hover:scale-105 hover:shadow-2xl"
    >
      <div
        className="h-32 flex items-center justify-center relative"
        style={{ backgroundColor: course.color || '#3B82F6' }}
      >
        <Icon className="w-16 h-16 text-white" />
        {progress > 0 && (
          <div className="absolute top-3 right-3 bg-white/20 backdrop-blur-sm rounded-full px-3 py-1">
            <span className="text-white text-sm font-bold">{progress}%</span>
          </div>
        )}
      </div>
      <div className="p-4">
        <h3 className="font-bold text-lg text-gray-800 mb-2">{course.titulo}</h3>
        <p className="text-sm text-gray-600 mb-3 line-clamp-2">
          {course.descripcion || 'Curso interactivo de aprendizaje'}
        </p>
        <div className="flex items-center justify-between text-xs text-gray-500">
          <span className="bg-gray-100 px-2 py-1 rounded-full">
            {course.nivel_nombre || 'Básico'}
          </span>
          <ChevronRight className="w-4 h-4 text-gray-400" />
        </div>
        {progress > 0 && (
          <div className="mt-3">
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div
                className="bg-gradient-to-r from-green-400 to-blue-500 h-2 rounded-full transition-all"
                style={{ width: `${progress}%` }}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

// Componente de Tarjeta de Recurso
const ResourceCard = ({ resource, onClick, completed = false }) => {
  const getIcon = () => {
    const icons = {
      video: Video,
      audio: Headphones,
      imagen: Image,
      quiz: HelpCircle,
      pdf: BookOpen,
      juego: Target
    };
    const Icon = icons[resource.tipo] || BookOpen;
    return Icon;
  };

  const Icon = getIcon();

  return (
    <div
      onClick={onClick}
      className="bg-white rounded-xl p-4 shadow-sm border-2 border-gray-200 hover:border-blue-400 hover:shadow-md transition-all cursor-pointer"
    >
      <div className="flex items-start gap-3">
        <div className={`w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0 ${
          completed ? 'bg-green-100' : 'bg-blue-100'
        }`}>
          <Icon className={`w-6 h-6 ${completed ? 'text-green-600' : 'text-blue-600'}`} />
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-start justify-between gap-2">
            <h4 className="font-semibold text-gray-800 text-sm">{resource.titulo}</h4>
            {completed && <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0" />}
          </div>
          <p className="text-xs text-gray-600 mt-1 line-clamp-2">
            {resource.descripcion || 'Recurso de aprendizaje'}
          </p>
          <div className="flex items-center gap-3 mt-2 text-xs text-gray-500">
            <span className="flex items-center gap-1">
              <Clock className="w-3 h-3" />
              {resource.tiempo_estimado || 5} min
            </span>
            <span className="flex items-center gap-1">
              <Star className="w-3 h-3 text-yellow-500" />
              {resource.puntos_recompensa || 10} pts
            </span>
            <span className="capitalize bg-gray-100 px-2 py-0.5 rounded-full">
              {resource.tipo}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};

// Componente Principal
export default function StudentDashboard() {
  const navigate = useNavigate();
  
  // Estados principales
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState('home');
  const [error, setError] = useState(null);
  
  // Estados de datos
  const [courses, setCourses] = useState([]);
  const [resources, setResources] = useState([]);
  const [achievements, setAchievements] = useState([]);
  const [userProgress, setUserProgress] = useState([]);
  const [userPoints, setUserPoints] = useState(null);
  const [userAchievements, setUserAchievements] = useState([]);
  
  // Estados de vista
  const [selectedCourse, setSelectedCourse] = useState(null);
  const [selectedResource, setSelectedResource] = useState(null);
  const [showQuiz, setShowQuiz] = useState(false);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [quizAnswers, setQuizAnswers] = useState({});
  const [quizResults, setQuizResults] = useState(null);
  const [soundEnabled, setSoundEnabled] = useState(true);
  const [chatOpen, setChatOpen] = useState(false);
  const [chatMessages, setChatMessages] = useState([
    { type: 'bot', text: '¡Hola! Soy Carín 🐢 ¿En qué puedo ayudarte hoy?' }
  ]);
  const [chatInput, setChatInput] = useState('');

  // Cargar datos iniciales
  useEffect(() => {
    checkAuth();
  }, []);

  useEffect(() => {
    if (user) {
      loadAllData();
    }
  }, [user]);

  const checkAuth = async () => {
    try {
      const { data: { session }, error: sessionError } = await supabase.auth.getSession();
      
      if (sessionError || !session) {
        navigate('/login');
        return;
      }

      const { data: userData, error: userError } = await supabase
        .from('usuarios')
        .select('*')
        .eq('auth_id', session.user.id)
        .single();

      if (userError || !userData) {
        setError('No se pudo obtener la información del usuario');
        return;
      }

      if (userData.rol !== 'estudiante' && userData.rol !== 'admin') {
        setError('Solo los estudiantes pueden acceder a este panel');
        setTimeout(() => navigate('/'), 2000);
        return;
      }

      setUser(userData);
    } catch (err) {
      console.error('Error de autenticación:', err);
      setError('Error de autenticación');
    }
  };

  const loadAllData = async () => {
    setLoading(true);
    await Promise.all([
      fetchCourses(),
      fetchResources(),
      fetchAchievements(),
      fetchUserProgress(),
      fetchUserPoints(),
      fetchUserAchievements()
    ]);
    setLoading(false);
  };

  const fetchCourses = async () => {
    try {
      const { data, error } = await supabase
        .from('cursos')
        .select(`
          *,
          niveles_aprendizaje(nombre)
        `)
        .eq('activo', true)
        .order('orden', { ascending: true });
      
      if (error) throw error;
      
      const coursesData = data?.map(course => ({
        ...course,
        nivel_nombre: course.niveles_aprendizaje?.nombre || 'Básico'
      })) || [];
      
      setCourses(coursesData);
    } catch (err) {
      console.error('Error cargando cursos:', err);
    }
  };

  const fetchResources = async () => {
    try {
      const { data, error } = await supabase
        .from('recursos')
        .select(`
          *,
          cursos(titulo, color)
        `)
        .eq('activo', true)
        .order('orden', { ascending: true });
      
      if (error) throw error;
      setResources(data || []);
    } catch (err) {
      console.error('Error cargando recursos:', err);
    }
  };

  const fetchAchievements = async () => {
    try {
      const { data, error } = await supabase
        .from('logros')
        .select('*')
        .eq('activo', true);
      
      if (error) throw error;
      setAchievements(data || []);
    } catch (err) {
      console.error('Error cargando logros:', err);
    }
  };

  const fetchUserProgress = async () => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('progreso_estudiantes')
        .select('*')
        .eq('usuario_id', user.id);
      
      if (error) throw error;
      setUserProgress(data || []);
    } catch (err) {
      console.error('Error cargando progreso:', err);
    }
  };

  const fetchUserPoints = async () => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('puntos_usuario')
        .select('*')
        .eq('usuario_id', user.id)
        .single();
      
      if (error && error.code !== 'PGRST116') throw error;
      
      if (!data) {
        const { data: newPoints, error: insertError } = await supabase
          .from('puntos_usuario')
          .insert([{ usuario_id: user.id }])
          .select()
          .single();
        
        if (insertError) throw insertError;
        setUserPoints(newPoints);
      } else {
        setUserPoints(data);
      }
    } catch (err) {
      console.error('Error cargando puntos:', err);
    }
  };

  const fetchUserAchievements = async () => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('usuarios_logros')
        .select(`
          *,
          logros(*)
        `)
        .eq('usuario_id', user.id);
      
      if (error) throw error;
      setUserAchievements(data || []);
    } catch (err) {
      console.error('Error cargando logros del usuario:', err);
    }
  };

  const getCourseProgress = (courseId) => {
    const courseResources = resources.filter(r => r.curso_id === courseId);
    if (courseResources.length === 0) return 0;
    
    const completed = courseResources.filter(r => 
      userProgress.some(p => p.recurso_id === r.id && p.completado)
    ).length;
    
    return Math.round((completed / courseResources.length) * 100);
  };

  const isResourceCompleted = (resourceId) => {
    return userProgress.some(p => p.recurso_id === resourceId && p.completado);
  };

  const openCourse = (course) => {
    setSelectedCourse(course);
    setActiveTab('course-detail');
  };

  const openResource = (resource) => {
    setSelectedResource(resource);
    
    if (resource.tipo === 'quiz' && resource.contenido_quiz) {
      setShowQuiz(true);
      setCurrentQuestionIndex(0);
      setQuizAnswers({});
      setQuizResults(null);
    } else {
      setActiveTab('resource-detail');
    }
  };

  const handleQuizAnswer = (questionIndex, answerIndex) => {
    setQuizAnswers({
      ...quizAnswers,
      [questionIndex]: answerIndex
    });
  };

  const submitQuiz = async () => {
    const quiz = selectedResource.contenido_quiz;
    let correctCount = 0;
    let totalPoints = 0;

    quiz.forEach((question, index) => {
      const userAnswer = quizAnswers[index];
      if (userAnswer === question.respuesta_correcta) {
        correctCount++;
        totalPoints += question.puntos;
      }
    });

    const percentage = Math.round((correctCount / quiz.length) * 100);
    const passed = percentage >= 60;

    setQuizResults({
      correct: correctCount,
      total: quiz.length,
      percentage,
      points: totalPoints,
      passed
    });

    try {
      const { error: progressError } = await supabase
        .from('progreso_estudiantes')
        .upsert({
          usuario_id: user.id,
          recurso_id: selectedResource.id,
          completado: passed,
          puntuacion: totalPoints,
          mejor_puntuacion: totalPoints,
          respuestas_quiz: quizAnswers,
          fecha_completado: passed ? new Date().toISOString() : null,
          intentos: 1
        }, {
          onConflict: 'usuario_id,recurso_id'
        });

      if (progressError) throw progressError;

      if (passed) {
        await supabase.rpc('increment', {
          row_id: user.id,
          x: totalPoints
        });
        
        await fetchUserProgress();
        await fetchUserPoints();
      }
    } catch (err) {
      console.error('Error guardando progreso:', err);
    }
  };

  const closeQuiz = () => {
    setShowQuiz(false);
    setSelectedResource(null);
    setQuizResults(null);
    setQuizAnswers({});
  };

  const speakText = (text) => {
    if (soundEnabled && 'speechSynthesis' in window) {
      window.speechSynthesis.cancel();
      const utterance = new SpeechSynthesisUtterance(text);
      utterance.lang = 'es-ES';
      utterance.rate = 0.9;
      window.speechSynthesis.speak(utterance);
    }
  };

  const handleLogout = async () => {
    await supabase.auth.signOut();
    navigate('/');
  };

  const handleChatSend = () => {
    if (!chatInput.trim()) return;
    
    setChatMessages(prev => [...prev, { type: 'user', text: chatInput }]);
    
    setTimeout(() => {
      let response = '';
      const input = chatInput.toLowerCase();
      
      if (input.includes('curso') || input.includes('aprender')) {
        response = '¡Excelente! Tienes ' + courses.length + ' cursos disponibles. ¿Te gustaría que te recomiende uno? 📚';
      } else if (input.includes('progreso') || input.includes('avance')) {
        const completed = userProgress.filter(p => p.completado).length;
        response = 'Has completado ' + completed + ' recursos. ¡Vas muy bien! Sigue así 🌟';
      } else if (input.includes('puntos') || input.includes('nivel')) {
        response = 'Tienes ' + (userPoints?.puntos_totales || 0) + ' puntos y estás en el nivel ' + (userPoints?.nivel_actual || 1) + '. ¡Sigue ganando puntos! 🎯';
      } else if (input.includes('ayuda') || input.includes('ayudar')) {
        response = 'Puedo ayudarte con: Ver tus cursos, revisar tu progreso, explicar cómo ganar puntos o recomendarte qué estudiar. ¿Qué te interesa? 💡';
      } else if (input.includes('hola') || input.includes('hi')) {
        response = '¡Hola! 👋 ¿Cómo estás? ¿Listo para aprender algo nuevo?';
      } else if (input.includes('gracias')) {
        response = '¡De nada! Estoy aquí para ayudarte siempre que lo necesites 😊';
      } else {
        response = 'Interesante pregunta. Puedo ayudarte con información sobre tus cursos, progreso y puntos. ¿Qué te gustaría saber? 🤔';
      }
      
      setChatMessages(prev => [...prev, { type: 'bot', text: response }]);
    }, 800);
    
    setChatInput('');
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-sky-100 via-indigo-50 to-purple-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-b-4 border-indigo-600 mx-auto mb-4"></div>
          <p className="text-gray-600 font-medium">Cargando tu panel...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-sky-100 via-indigo-50 to-purple-100 flex items-center justify-center p-4">
        <div className="bg-white p-8 rounded-2xl shadow-xl text-center max-w-md">
          <XCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <h2 className="text-2xl font-bold text-gray-800 mb-2">Error</h2>
          <p className="text-gray-600 mb-6">{error}</p>
          <button
            onClick={() => navigate('/')}
            className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-3 rounded-xl font-semibold transition-colors"
          >
            Volver al Inicio
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-sky-100 via-indigo-50 to-purple-100">
      {/* Header */}
      <header className="bg-gradient-to-r from-indigo-600 to-purple-600 text-white shadow-xl sticky top-0 z-50">
        <div className="container mx-auto px-4 py-3 md:py-4">
          <div className="flex items-center justify-between gap-4">
            <div className="flex items-center gap-2 md:gap-4">
              <div className="bg-white/20 rounded-full p-1.5 md:p-2">
                <Brain className="w-6 h-6 md:w-8 md:h-8" />
              </div>
              <div>
                <h1 className="text-lg md:text-2xl font-bold">DidaktikApp</h1>
                <p className="text-indigo-100 text-xs md:text-sm hidden sm:block">Panel de Estudiante</p>
              </div>
            </div>

            <div className="flex items-center gap-2 md:gap-6">
              <div className="flex items-center gap-2 md:gap-4">
                <div className="flex items-center gap-1.5 bg-white/10 px-2 py-1.5 md:px-3 md:py-2 rounded-lg">
                  <Zap className="w-4 h-4 md:w-5 md:h-5 text-yellow-300" />
                  <span className="font-bold text-sm md:text-base">{userPoints?.experiencia || 0}</span>
                </div>
                <div className="flex items-center gap-1.5 bg-white/10 px-2 py-1.5 md:px-3 md:py-2 rounded-lg">
                  <Star className="w-4 h-4 md:w-5 md:h-5 text-yellow-300 fill-yellow-300" />
                  <span className="font-bold text-sm md:text-base">{userPoints?.puntos_totales || 0}</span>
                </div>
                <div className="hidden sm:flex items-center gap-1.5 bg-white/10 px-2 py-1.5 md:px-3 md:py-2 rounded-lg">
                  <Trophy className="w-4 h-4 md:w-5 md:h-5 text-orange-300" />
                  <span className="font-bold text-sm md:text-base">{userPoints?.nivel_actual || 1}</span>
                </div>
              </div>

              <button
                onClick={() => setSoundEnabled(!soundEnabled)}
                className="p-1.5 md:p-2 bg-white/10 rounded-lg hover:bg-white/20 transition-colors hidden sm:block"
              >
                {soundEnabled ? <Volume2 className="w-4 h-4 md:w-5 md:h-5" /> : <VolumeX className="w-4 h-4 md:w-5 md:h-5" />}
              </button>

              <div className="hidden lg:flex items-center gap-3">
                <div className="text-right">
                  <p className="font-semibold text-sm">{user?.nombre || 'Estudiante'}</p>
                  <p className="text-xs text-indigo-200">{user?.email}</p>
                </div>
                <button
                  onClick={handleLogout}
                  className="p-2 bg-white/10 rounded-lg hover:bg-white/20 transition-colors"
                >
                  <LogOut className="w-5 h-5" />
                </button>
              </div>
              
              <button
                onClick={handleLogout}
                className="p-1.5 md:p-2 bg-white/10 rounded-lg hover:bg-white/20 transition-colors lg:hidden"
              >
                <LogOut className="w-4 h-4 md:w-5 md:h-5" />
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Navigation */}
      <div className="bg-white border-b sticky top-[64px] md:top-[72px] z-40 shadow-sm">
        <div className="container mx-auto px-2 md:px-4">
          <div className="flex gap-1 md:gap-6 overflow-x-auto scrollbar-hide">
            {[
              { id: 'home', label: 'Inicio', icon: Home },
              { id: 'courses', label: 'Cursos', icon: BookOpen },
              { id: 'achievements', label: 'Logros', icon: Award },
              { id: 'progress', label: 'Progreso', icon: BarChart3 }
            ].map(tab => {
              const TabIcon = tab.icon;
              return (
                <button
                  key={tab.id}
                  onClick={() => {
                    setActiveTab(tab.id);
                    setSelectedCourse(null);
                    setSelectedResource(null);
                  }}
                  className={`py-3 md:py-4 px-3 md:px-2 border-b-2 font-medium text-xs md:text-sm transition-colors flex items-center gap-1.5 md:gap-2 whitespace-nowrap ${
                    activeTab === tab.id
                      ? 'border-indigo-600 text-indigo-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700'
                  }`}
                >
                  <TabIcon className="w-4 h-4" />
                  <span className="hidden sm:inline">{tab.label}</span>
                </button>
              );
            })}
          </div>
        </div>
      </div>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-6 md:py-8 pb-32 min-h-[calc(100vh-200px)]">
        {/* HOME */}
        {activeTab === 'home' && (
          <div className="space-y-6 md:space-y-8">
            <div className="bg-gradient-to-r from-emerald-400 to-cyan-400 text-white rounded-2xl p-6 shadow-lg">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 md:w-16 md:h-16 bg-white/20 rounded-full flex items-center justify-center text-2xl md:text-3xl">
                  👋
                </div>
                <div>
                  <h2 className="text-xl md:text-2xl font-bold">¡Hola, {user?.nombre}!</h2>
                  <p className="text-sm md:text-base text-emerald-50">¿Listo para aprender algo nuevo hoy?</p>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 md:gap-6">
              <div className="bg-white rounded-xl p-6 shadow-lg">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="font-bold text-gray-800">Tus Cursos</h3>
                  <BookOpen className="w-6 h-6 text-indigo-600" />
                </div>
                <p className="text-4xl font-bold text-indigo-600">{courses.length}</p>
                <p className="text-sm text-gray-600 mt-2">cursos disponibles</p>
              </div>

              <div className="bg-white rounded-xl p-6 shadow-lg">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="font-bold text-gray-800">Completados</h3>
                  <CheckCircle className="w-6 h-6 text-green-600" />
                </div>
                <p className="text-4xl font-bold text-green-600">
                  {userProgress.filter(p => p.completado).length}
                </p>
                <p className="text-sm text-gray-600 mt-2">recursos completados</p>
              </div>

              <div className="bg-white rounded-xl p-6 shadow-lg">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="font-bold text-gray-800">Racha</h3>
                  <Trophy className="w-6 h-6 text-orange-600" />
                </div>
                <p className="text-4xl font-bold text-orange-600">
                  {userPoints?.racha_dias || 0}
                </p>
                <p className="text-sm text-gray-600 mt-2">días consecutivos</p>
              </div>
            </div>

            <div>
              <h2 className="text-xl md:text-2xl font-bold text-gray-800 mb-4 md:mb-6">Cursos Destacados</h2>
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
                {courses.slice(0, 6).map(course => (
                  <CourseCard
                    key={course.id}
                    course={course}
                    onClick={() => openCourse(course)}
                    progress={getCourseProgress(course.id)}
                  />
                ))}
              </div>
            </div>
          </div>
        )}

        {/* COURSES */}
        {activeTab === 'courses' && (
          <div className="space-y-6 min-h-[60vh]">
            <h2 className="text-xl md:text-2xl font-bold text-gray-800">Todos los Cursos</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
              {courses.map(course => (
                <CourseCard
                  key={course.id}
                  course={course}
                  onClick={() => openCourse(course)}
                  progress={getCourseProgress(course.id)}
                />
              ))}
            </div>
          </div>
        )}

        {/* COURSE DETAIL */}
        {activeTab === 'course-detail' && selectedCourse && (
          <div className="space-y-6 min-h-[60vh]">
            <button
              onClick={() => {
                setActiveTab('courses');
                setSelectedCourse(null);
              }}
              className="flex items-center gap-2 text-indigo-600 hover:text-indigo-700 font-medium"
            >
              <ArrowLeft className="w-4 h-4" />
              Volver a cursos
            </button>

            <div className="bg-white rounded-2xl shadow-xl overflow-hidden">
              <div
                className="h-32 md:h-40 flex items-center justify-center"
                style={{ backgroundColor: selectedCourse.color || '#3B82F6' }}
              >
                <BookOpen className="w-16 h-16 md:w-20 md:h-20 text-white" />
              </div>
              <div className="p-4 md:p-6">
                <h1 className="text-2xl md:text-3xl font-bold text-gray-800 mb-2">{selectedCourse.titulo}</h1>
                <p className="text-gray-600 mb-4">{selectedCourse.descripcion}</p>
                <div className="flex items-center gap-4 text-sm text-gray-500">
                  <span className="bg-gray-100 px-3 py-1 rounded-full">
                    {selectedCourse.nivel_nombre}
                  </span>
                  <span>{getCourseProgress(selectedCourse.id)}% completado</span>
                </div>
              </div>
            </div>

            <div>
              <h2 className="text-xl font-bold text-gray-800 mb-4">Recursos del Curso</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {resources
                  .filter(r => r.curso_id === selectedCourse.id)
                  .map(resource => (
                    <ResourceCard
                      key={resource.id}
                      resource={resource}
                      onClick={() => openResource(resource)}
                      completed={isResourceCompleted(resource.id)}
                    />
                  ))}
              </div>
            </div>
          </div>
        )}

        {/* ACHIEVEMENTS */}
        {activeTab === 'achievements' && (
          <div className="space-y-6 min-h-[60vh]">
            <h2 className="text-xl md:text-2xl font-bold text-gray-800">Tus Logros</h2>
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4 md:gap-6">
              {achievements.map(achievement => {
                const unlocked = userAchievements.some(
                  ua => ua.logro_id === achievement.id && ua.completado
                );
                return (
                  <AchievementCard
                    key={achievement.id}
                    achievement={achievement}
                    unlocked={unlocked}
                  />
                );
              })}
            </div>
          </div>
        )}

        {/* PROGRESS */}
        {activeTab === 'progress' && (
          <div className="space-y-6 min-h-[60vh]">
            <h2 className="text-xl md:text-2xl font-bold text-gray-800">Tu Progreso</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6">
              {courses.map(course => {
                const courseResources = resources.filter(r => r.curso_id === course.id);
                const completed = courseResources.filter(r => isResourceCompleted(r.id)).length;
                const progress = courseResources.length > 0 
                  ? Math.round((completed / courseResources.length) * 100)
                  : 0;

                return (
                  <div key={course.id} className="bg-white rounded-xl p-4 md:p-6 shadow-lg">
                    <div className="flex items-center gap-4 mb-4">
                      <div
                        className="w-12 h-12 rounded-xl flex items-center justify-center"
                        style={{ backgroundColor: course.color || '#3B82F6' }}
                      >
                        <BookOpen className="w-6 h-6 text-white" />
                      </div>
                      <div className="flex-1">
                        <h3 className="font-bold text-gray-800">{course.titulo}</h3>
                        <p className="text-sm text-gray-600">
                          {completed} de {courseResources.length} recursos completados
                        </p>
                      </div>
                    </div>
                    <div className="space-y-2">
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-gray-600">Progreso</span>
                        <span className="font-bold text-indigo-600">{progress}%</span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-3">
                        <div
                          className="bg-gradient-to-r from-green-400 to-blue-500 h-3 rounded-full transition-all"
                          style={{ width: `${progress}%` }}
                        />
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}
      </main>

      {/* QUIZ MODAL */}
      {showQuiz && selectedResource && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 overflow-y-auto">
          <div className="bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto my-8">
            {/* Quiz Header */}
            <div className="sticky top-0 bg-gradient-to-r from-purple-600 to-blue-600 text-white p-4 md:p-6 rounded-t-2xl z-10">
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-xl md:text-2xl font-bold mb-1">📝 {selectedResource.titulo}</h2>
                  <p className="text-sm md:text-base text-purple-100">
                    {quizResults 
                      ? '¡Quiz Completado!' 
                      : `Pregunta ${currentQuestionIndex + 1} de ${selectedResource.contenido_quiz.length}`
                    }
                  </p>
                </div>
                <button
                  onClick={closeQuiz}
                  className="bg-white/20 hover:bg-white/30 p-2 rounded-lg transition-colors"
                >
                  <XCircle className="w-5 h-5 md:w-6 md:h-6" />
                </button>
              </div>
            </div>

            {/* Quiz Results */}
            {quizResults ? (
              <div className="p-6 md:p-8 text-center space-y-6">
                <div className={`w-20 h-20 md:w-24 md:h-24 rounded-full mx-auto flex items-center justify-center text-4xl md:text-5xl ${
                  quizResults.passed ? 'bg-green-100' : 'bg-orange-100'
                }`}>
                  {quizResults.passed ? '🎉' : '💪'}
                </div>
                
                <div>
                  <h3 className="text-2xl md:text-3xl font-bold text-gray-800 mb-2">
                    {quizResults.passed ? '¡Felicitaciones!' : '¡Sigue intentando!'}
                  </h3>
                  <p className="text-gray-600">
                    {quizResults.passed 
                      ? 'Has completado el quiz exitosamente' 
                      : 'Necesitas al menos 60% para aprobar'
                    }
                  </p>
                </div>

                <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                  <div className="bg-blue-50 rounded-xl p-4">
                    <p className="text-sm text-gray-600 mb-1">Respuestas Correctas</p>
                    <p className="text-2xl md:text-3xl font-bold text-blue-600">
                      {quizResults.correct}/{quizResults.total}
                    </p>
                  </div>
                  <div className="bg-purple-50 rounded-xl p-4">
                    <p className="text-sm text-gray-600 mb-1">Porcentaje</p>
                    <p className="text-2xl md:text-3xl font-bold text-purple-600">
                      {quizResults.percentage}%
                    </p>
                  </div>
                  <div className="bg-yellow-50 rounded-xl p-4">
                    <p className="text-sm text-gray-600 mb-1">Puntos Ganados</p>
                    <p className="text-2xl md:text-3xl font-bold text-yellow-600">
                      {quizResults.points}
                    </p>
                  </div>
                </div>

                <div className="flex flex-col sm:flex-row gap-4">
                  <button
                    onClick={() => {
                      setQuizResults(null);
                      setCurrentQuestionIndex(0);
                      setQuizAnswers({});
                    }}
                    className="flex-1 bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-3 rounded-xl font-semibold transition-colors"
                  >
                    Reintentar Quiz
                  </button>
                  <button
                    onClick={closeQuiz}
                    className="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-3 rounded-xl font-semibold transition-colors"
                  >
                    Salir
                  </button>
                </div>
              </div>
            ) : (
              /* Quiz Questions */
              <div className="p-4 md:p-6 space-y-6">
                {selectedResource.contenido_quiz && selectedResource.contenido_quiz[currentQuestionIndex] && (
                  <>
                    {/* Progress Indicator */}
                    <div className="flex gap-2 mb-6">
                      {selectedResource.contenido_quiz.map((_, idx) => (
                        <div
                          key={idx}
                          className={`flex-1 h-2 rounded-full transition-colors ${
                            idx < currentQuestionIndex 
                              ? 'bg-green-500' 
                              : idx === currentQuestionIndex 
                              ? 'bg-purple-500' 
                              : 'bg-gray-200'
                          }`}
                        />
                      ))}
                    </div>

                    {(() => {
                      const question = selectedResource.contenido_quiz[currentQuestionIndex];
                      
                      return (
                        <div className="space-y-6">
                          {/* Video */}
                          {question.video_url && (
                            <div className="rounded-2xl overflow-hidden">
                              <video 
                                controls 
                                className="w-full"
                                src={question.video_url}
                              >
                                Tu navegador no soporta video
                              </video>
                            </div>
                          )}

                          {/* Imagen/Emoji */}
                          {question.imagen_url && !question.video_url && (
                            <div className="flex justify-center">
                              <div className="w-24 h-24 md:w-32 md:h-32 bg-gradient-to-br from-purple-100 to-pink-100 rounded-2xl flex items-center justify-center text-5xl md:text-7xl shadow-lg">
                                {question.imagen_url}
                              </div>
                            </div>
                          )}

                          {/* Pregunta */}
                          <div className="flex items-center gap-3 justify-center">
                            <h3 className="text-xl md:text-2xl font-bold text-gray-800 text-center">
                              {question.pregunta}
                            </h3>
                            {question.audio_pregunta && (
                              <button
                                onClick={() => speakText(question.pregunta)}
                                className="bg-blue-500 hover:bg-blue-600 text-white p-2 md:p-3 rounded-full shadow-lg transition-all"
                              >
                                <Volume2 className="w-4 h-4 md:w-5 md:h-5" />
                              </button>
                            )}
                          </div>

                          {/* Opciones */}
                          <div className="grid grid-cols-1 md:grid-cols-2 gap-3 md:gap-4 max-w-3xl mx-auto">
                            {question.opciones.map((opcion, idx) => (
                              <button
                                key={idx}
                                onClick={() => handleQuizAnswer(currentQuestionIndex, idx)}
                                className={`p-4 md:p-6 rounded-xl border-2 font-semibold text-base md:text-lg transition-all transform hover:scale-105 ${
                                  quizAnswers[currentQuestionIndex] === idx
                                    ? 'border-purple-500 bg-purple-50 shadow-lg'
                                    : 'border-gray-200 hover:border-purple-300 bg-white'
                                }`}
                              >
                                <div className="flex items-center justify-between">
                                  {question.tipo === 'imagen' && question.imagen_opciones[idx] ? (
                                    <div className="flex flex-col items-center gap-2 w-full">
                                      <span className="text-4xl md:text-5xl">{question.imagen_opciones[idx]}</span>
                                      <span className="text-xs md:text-sm">{opcion}</span>
                                    </div>
                                  ) : (
                                    <span>{opcion}</span>
                                  )}
                                  {quizAnswers[currentQuestionIndex] === idx && (
                                    <CheckCircle className="w-5 h-5 md:w-6 md:h-6 text-purple-600 flex-shrink-0" />
                                  )}
                                </div>
                              </button>
                            ))}
                          </div>

                          {/* Navegación */}
                          <div className="flex justify-between gap-4 pt-6 border-t">
                            <button
                              onClick={() => setCurrentQuestionIndex(prev => Math.max(0, prev - 1))}
                              disabled={currentQuestionIndex === 0}
                              className="px-4 md:px-6 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-xl font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition-colors text-sm md:text-base"
                            >
                              ← Anterior
                            </button>

                            {currentQuestionIndex === selectedResource.contenido_quiz.length - 1 ? (
                              <button
                                onClick={submitQuiz}
                                disabled={Object.keys(quizAnswers).length !== selectedResource.contenido_quiz.length}
                                className="px-4 md:px-6 py-3 bg-green-500 hover:bg-green-600 text-white rounded-xl font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition-colors text-sm md:text-base"
                              >
                                Enviar Quiz 🎯
                              </button>
                            ) : (
                              <button
                                onClick={() => setCurrentQuestionIndex(prev => 
                                  Math.min(selectedResource.contenido_quiz.length - 1, prev + 1)
                                )}
                                className="px-4 md:px-6 py-3 bg-purple-500 hover:bg-purple-600 text-white rounded-xl font-semibold transition-colors text-sm md:text-base"
                              >
                                Siguiente →
                              </button>
                            )}
                          </div>
                        </div>
                      );
                    })()}
                  </>
                )}
              </div>
            )}
          </div>
        </div>
      )}

      {/* Carín - Asistente de ayuda */}
      <div className="fixed bottom-6 right-6 z-50 flex items-end gap-4">
        {chatOpen && (
          <div className="w-80 md:w-96 bg-white rounded-2xl shadow-2xl overflow-hidden animate-in slide-in-from-right">
            {/* Chat Header */}
            <div className="bg-gradient-to-r from-emerald-500 to-cyan-500 text-white p-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center text-2xl">
                    🐢
                  </div>
                  <div>
                    <h3 className="font-bold">Carín</h3>
                    <p className="text-xs text-emerald-50">Tu asistente de aprendizaje</p>
                  </div>
                </div>
                <button
                  onClick={() => setChatOpen(false)}
                  className="bg-white/20 hover:bg-white/30 p-1.5 rounded-lg transition-colors"
                >
                  <XCircle className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* Chat Messages */}
            <div className="h-80 overflow-y-auto p-4 space-y-3 bg-gray-50">
              {chatMessages.map((msg, idx) => (
                <div
                  key={idx}
                  className={`flex ${msg.type === 'user' ? 'justify-end' : 'justify-start'}`}
                >
                  <div className={`max-w-[75%] rounded-2xl px-4 py-2.5 ${
                    msg.type === 'user'
                      ? 'bg-indigo-600 text-white rounded-br-sm'
                      : 'bg-white text-gray-800 rounded-bl-sm shadow-sm'
                  }`}>
                    <p className="text-sm">{msg.text}</p>
                  </div>
                </div>
              ))}
            </div>

            {/* Chat Input */}
            <div className="p-4 bg-white border-t">
              <div className="flex gap-2">
                <input
                  type="text"
                  value={chatInput}
                  onChange={(e) => setChatInput(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && handleChatSend()}
                  placeholder="Escribe tu pregunta..."
                  className="flex-1 px-4 py-2.5 rounded-xl border-2 border-gray-200 focus:border-emerald-500 focus:outline-none text-sm"
                />
                <button
                  onClick={handleChatSend}
                  className="bg-emerald-500 hover:bg-emerald-600 text-white px-4 py-2.5 rounded-xl font-semibold transition-colors"
                >
                  <MessageCircle className="w-5 h-5" />
                </button>
              </div>
              <div className="flex gap-2 mt-2 flex-wrap">
                <button
                  onClick={() => {
                    setChatInput('¿Qué cursos tengo disponibles?');
                    setTimeout(handleChatSend, 100);
                  }}
                  className="text-xs bg-emerald-50 hover:bg-emerald-100 text-emerald-700 px-3 py-1.5 rounded-full transition-colors"
                >
                  Ver cursos
                </button>
                <button
                  onClick={() => {
                    setChatInput('¿Cuál es mi progreso?');
                    setTimeout(handleChatSend, 100);
                  }}
                  className="text-xs bg-blue-50 hover:bg-blue-100 text-blue-700 px-3 py-1.5 rounded-full transition-colors"
                >
                  Mi progreso
                </button>
                <button
                  onClick={() => {
                    setChatInput('¿Cómo gano más puntos?');
                    setTimeout(handleChatSend, 100);
                  }}
                  className="text-xs bg-purple-50 hover:bg-purple-100 text-purple-700 px-3 py-1.5 rounded-full transition-colors"
                >
                  Ganar puntos
                </button>
              </div>
            </div>
          </div>
        )}

        {/* Carín Button */}
        <button
          onClick={() => setChatOpen(!chatOpen)}
          className="relative group bg-gradient-to-br from-emerald-400 to-cyan-500 rounded-full p-4 shadow-2xl hover:shadow-emerald-300/50 transform transition-all hover:scale-110 active:scale-95 flex-shrink-0"
        >
          <div className="w-14 h-14 flex items-center justify-center text-4xl relative">
            🐢
            {!chatOpen && (
              <div className="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full animate-pulse border-2 border-white"></div>
            )}
          </div>
          
          {!chatOpen && (
            <div className="absolute bottom-full right-0 mb-3 hidden group-hover:block">
              <div className="bg-gradient-to-r from-emerald-500 to-cyan-500 text-white px-4 py-2 rounded-xl shadow-lg whitespace-nowrap animate-in slide-in-from-bottom-2">
                <p className="text-sm font-medium">¡Hola! Soy Carín 🌟</p>
                <p className="text-xs text-emerald-50">¿En qué puedo ayudarte?</p>
              </div>
            </div>
          )}
        </button>
      </div>

      {/* Footer */}
      <footer className="bg-white border-t">
        <div className="container mx-auto px-4 py-6">
          <div className="flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-600">
            <div className="flex items-center gap-2">
              <Brain className="w-4 h-4 text-indigo-600" />
              <span>© 2025 DidaktikApp - Aprende jugando</span>
            </div>
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Trophy className="w-4 h-4 text-orange-500" />
                <span>Nivel {userPoints?.nivel_actual || 1}</span>
              </div>
              <div className="flex items-center gap-2">
                <Star className="w-4 h-4 text-yellow-500" />
                <span>{userPoints?.puntos_totales || 0} puntos</span>
              </div>
            </div>
          </div>
        </div>
      </footer>

      <style jsx>{`
        .scrollbar-hide::-webkit-scrollbar {
          display: none;
        }
        .scrollbar-hide {
          -ms-overflow-style: none;
          scrollbar-width: none;
        }
        .animate-in {
          animation: slideIn 0.3s ease-out;
        }
        @keyframes slideIn {
          from {
            opacity: 0;
            transform: translateY(10px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        .slide-in-from-right {
          animation: slideInRight 0.3s ease-out;
        }
        @keyframes slideInRight {
          from {
            opacity: 0;
            transform: translateX(20px);
          }
          to {
            opacity: 1;
            transform: translateX(0);
          }
        }
      `}</style>
    </div>
  );
}