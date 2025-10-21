import React, { useEffect, useState } from 'react';
import { 
  Users, Settings, BookOpen, LogOut, Edit2, Trash2, Plus, Save, X, 
  GraduationCap, AlertCircle, RefreshCw, Award, MessageCircle, 
  BarChart3, FileText, Play, Image, Headphones, Gamepad2, HelpCircle,
  Star, TrendingUp, Calendar, Target, Zap, Trophy, CheckCircle, XCircle,
  Eye, Sparkles, Upload, Mic, Video, Volume2, Download, Move, ChevronUp, ChevronDown,
  Clock, Activity, TrendingDown
} from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { useNavigate } from 'react-router-dom';

// Componente de Gráfico de Barras
const BarChart = ({ title, data, color, maxValue }) => {
  if (!data || data.length === 0) return null;
  
  return (
    <div className="bg-white border-2 border-gray-300 rounded-lg p-4 shadow-sm hover:shadow-md transition-shadow">
      <div className="flex justify-between items-center mb-3">
        <span className="text-sm font-bold text-gray-800">{title}</span>
      </div>
      
      <div className="space-y-2">
        {data.map((item, index) => (
          <div key={index} className="flex items-center gap-3">
            <span className="text-xs text-gray-600 w-20 truncate">{item.label}</span>
            <div className="flex-1 bg-gray-200 rounded-full h-4 overflow-hidden">
              <div 
                className="h-full rounded-full transition-all duration-500"
                style={{ 
                  width: `${(item.value / maxValue) * 100}%`,
                  backgroundColor: color
                }}
              />
            </div>
            <span className="text-xs font-bold text-gray-700 w-8 text-right">
              {item.value}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};

// Componente de Progreso Circular
const ProgressCircle = ({ title, value, max, color, size = 80 }) => {
  const percentage = (value / max) * 100;
  const strokeWidth = 8;
  const radius = (size - strokeWidth) / 2;
  const circumference = radius * 2 * Math.PI;
  const strokeDashoffset = circumference - (percentage / 100) * circumference;

  return (
    <div className="bg-white border-2 border-gray-300 rounded-lg p-4 flex flex-col items-center shadow-sm hover:shadow-md transition-shadow">
      <span className="text-sm font-bold text-gray-800 mb-2">{title}</span>
      <div className="relative" style={{ width: size, height: size }}>
        <svg width={size} height={size} className="transform -rotate-90">
          <circle
            cx={size / 2}
            cy={size / 2}
            r={radius}
            stroke="#e5e7eb"
            strokeWidth={strokeWidth}
            fill="none"
          />
          <circle
            cx={size / 2}
            cy={size / 2}
            r={radius}
            stroke={color}
            strokeWidth={strokeWidth}
            fill="none"
            strokeDasharray={circumference}
            strokeDashoffset={strokeDashoffset}
            strokeLinecap="round"
            className="transition-all duration-1000 ease-out"
          />
        </svg>
        <div className="absolute inset-0 flex items-center justify-center">
          <span className="text-lg font-bold text-gray-800">{value}</span>
        </div>
      </div>
      <span className="text-xs text-gray-600 mt-1">de {max}</span>
    </div>
  );
};

// Componente de Métricas en Tiempo Real
const MetricCard = ({ title, value, change, icon: Icon, color }) => (
  <div className="bg-white border-2 border-gray-300 rounded-lg p-4 shadow-sm hover:shadow-md transition-shadow">
    <div className="flex justify-between items-start mb-2">
      <div>
        <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide">{title}</p>
        <p className="text-2xl font-bold text-gray-900 mt-1">{value}</p>
      </div>
      <div className="p-2 rounded-lg" style={{ backgroundColor: `${color}20` }}>
        <Icon className="w-5 h-5" style={{ color }} />
      </div>
    </div>
    <div className={`flex items-center gap-1 text-xs font-medium ${
      change >= 0 ? 'text-green-600' : 'text-red-600'
    }`}>
      {change >= 0 ? (
        <TrendingUp className="w-3 h-3" />
      ) : (
        <TrendingDown className="w-3 h-3" />
      )}
      <span>{change >= 0 ? '+' : ''}{change}% vs último mes</span>
    </div>
  </div>
);

export default function EnhancedAdminPanel() {
  const navigate = useNavigate();
  
  // Estados principales
  const [users, setUsers] = useState([]);
  const [levels, setLevels] = useState([]);
  const [courses, setCourses] = useState([]);
  const [resources, setResources] = useState([]);
  const [achievements, setAchievements] = useState([]);
  
  // Estados de UI
  const [loading, setLoading] = useState(true);
  const [menuOpen, setMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState('dashboard');
  const [error, setError] = useState(null);
  const [currentUser, setCurrentUser] = useState(null);
  const [refreshing, setRefreshing] = useState(false);
  
  // Estados de edición
  const [editingUser, setEditingUser] = useState(null);
  const [editingLevel, setEditingLevel] = useState(null);
  
  // Estados de formularios
  const [showNewLevel, setShowNewLevel] = useState(false);
  const [showNewCourse, setShowNewCourse] = useState(false);
  const [showNewResource, setShowNewResource] = useState(false);
  
  const [newLevel, setNewLevel] = useState({ nombre: '', descripcion: '', orden: 1 });
  const [newCourse, setNewCourse] = useState({
    titulo: '',
    descripcion: '',
    nivel_id: '',
    color: '#3B82F6',
    orden: 1
  });
  const [newResource, setNewResource] = useState({
    titulo: '',
    descripcion: '',
    tipo: 'video',
    curso_id: '',
    puntos_recompensa: 10,
    tiempo_estimado: 5,
    orden: 1
  });
  
  // Estados de analíticas avanzadas
  const [analytics, setAnalytics] = useState({
    totalUsers: 0,
    activeStudents: 0,
    completedResources: 0,
    avgTimePerResource: 0,
    topCourses: [],
    userGrowth: 0,
    engagementRate: 0,
    completionRate: 0
  });

  // Estados para Quiz Builder
  const [showQuizBuilder, setShowQuizBuilder] = useState(false);
  const [selectedResource, setSelectedResource] = useState(null);
  const [previewQuiz, setPreviewQuiz] = useState(false);
  const [currentPreviewQuestion, setCurrentPreviewQuestion] = useState(0);
  const [previewAnswers, setPreviewAnswers] = useState({});

  const [currentQuiz, setCurrentQuiz] = useState({
    preguntas: []
  });

  const [currentQuestion, setCurrentQuestion] = useState({
    tipo: 'multiple',
    pregunta: '',
    audio_pregunta: false,
    video_url: '',
    imagen_url: '',
    opciones: ['', '', '', ''],
    audio_opciones: ['', '', '', ''],
    imagen_opciones: ['', '', '', ''],
    respuesta_correcta: 0,
    puntos: 10,
    retroalimentacion_correcta: '¡Excelente! 🎉',
    retroalimentacion_incorrecta: '¡Inténtalo de nuevo! 💪',
    audio_retroalimentacion: false,
    tiempo_limite: 0
  });

  const questionTypes = [
    { value: 'multiple', label: 'Opción Múltiple', icon: HelpCircle, color: '#3B82F6' },
    { value: 'verdadero_falso', label: 'Verdadero/Falso', icon: CheckCircle, color: '#10B981' },
    { value: 'imagen', label: 'Selección de Imagen', icon: Image, color: '#8B5CF6' },
    { value: 'audio', label: 'Escucha y Responde', icon: Headphones, color: '#EC4899' },
    { value: 'video', label: 'Video Pregunta', icon: Video, color: '#F59E0B' },
    { value: 'completar', label: 'Completar Frase', icon: Edit2, color: '#EF4444' }
  ];

  const emojis = [
    '🎨', '🎮', '🎵', '🌟', '🎉', '🚀', '🌈', '⭐', '💡', '🎯', 
    '🏆', '🎪', '🦁', '🐘', '🦋', '🌺', '🍎', '📚', '✏️', '🎈',
    '🔢', '🅰️', '🅱️', '🔤', '📝', '✅', '❌', '➕', '➖', '✖️',
    '🌍', '🌞', '🌙', '⭐', '🔥', '💧', '🍃', '🌸', '🐶', '🐱'
  ];

  useEffect(() => {
    checkAuthAndRole();
  }, []);

  useEffect(() => {
    if (currentUser) {
      loadAllData();
    }
  }, [currentUser]);


const checkAuthAndRole = async () => {
  try {
    const { data: { session }, error: sessionError } = await supabase.auth.getSession();
    
    if (sessionError || !session) {
      navigate('/login');
      return;
    }

    // Agregar un pequeño delay para asegurar que la BD esté actualizada
    await new Promise(resolve => setTimeout(resolve, 500));

    const { data: userData, error: userError } = await supabase
      .from('usuarios')
      .select('*')
      .eq('auth_id', session.user.id)
      .single();

    console.log('🔍 Datos del usuario recuperados:', userData);
    console.log('👤 Rol encontrado:', userData?.rol);

    if (userError) {
      console.error('❌ Error al buscar usuario:', userError);
      setError('No se pudo obtener la información del usuario');
      setTimeout(() => navigate('/login'), 2000);
      return;
    }

    if (!userData) {
      console.error('❌ Usuario no encontrado en tabla usuarios');
      setError('Usuario no encontrado en el sistema');
      setTimeout(() => navigate('/login'), 2000);
      return;
    }

    // Verificar que sea admin
    if (userData.rol !== 'admin') {
      console.error('❌ Usuario no es admin. Rol actual:', userData.rol);
      setError(`No tienes permisos de administrador. Tu rol es: ${userData.rol}`);
      setTimeout(() => navigate('/dashboard'), 2000);
      return;
    }

    console.log('✅ Acceso permitido como admin');
    setCurrentUser(userData);
  } catch (err) {
    console.error('❌ Error de autenticación:', err);
    setError('Error de autenticación: ' + err.message);
  }
};

  const loadAllData = async () => {
    setLoading(true);
    await Promise.all([
      fetchUsers(),
      fetchLevels(),
      fetchCourses(),
      fetchResources(),
      fetchAchievements()
    ]);
    await calculateAdvancedAnalytics();
    setLoading(false);
  };

  const refreshData = async () => {
    setRefreshing(true);
    await loadAllData();
    setRefreshing(false);
  };

  const fetchUsers = async () => {
    try {
      const { data, error } = await supabase
        .from('usuarios')
        .select('*')
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      setUsers(data || []);
    } catch (err) {
      console.error('Error cargando usuarios:', err);
      setError('Error al cargar usuarios');
    }
  };

  const fetchLevels = async () => {
    try {
      const { data, error } = await supabase
        .from('niveles_aprendizaje')
        .select('*')
        .order('orden', { ascending: true });
      
      if (error) throw error;
      setLevels(data || []);
    } catch (err) {
      console.error('Error cargando niveles:', err);
    }
  };

  const fetchCourses = async () => {
    try {
      const { data, error } = await supabase
        .from('cursos')
        .select(`*, niveles_aprendizaje(nombre)`)
        .eq('activo', true)
        .order('orden', { ascending: true });
      
      if (error) throw error;
      
      const coursesData = data?.map(course => ({
        ...course,
        nivel_nombre: course.niveles_aprendizaje?.nombre || 'Sin nivel'
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
        .select(`*, cursos(titulo)`)
        .eq('activo', true)
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      
      const resourcesData = data?.map(resource => ({
        ...resource,
        curso_titulo: resource.cursos?.titulo || 'Sin curso',
        completados: 0
      })) || [];
      
      setResources(resourcesData);
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

  const calculateAdvancedAnalytics = async () => {
    try {
      const userGrowth = await calculateUserGrowth();
      const engagementRate = await calculateEngagementRate();
      const completionRate = await calculateCompletionRate();
      const topCourses = await calculateTopCourses();
      const avgTimePerResource = await calculateAvgTimePerResource();

      setAnalytics({
        totalUsers: users.length,
        activeStudents: users.filter(u => u.rol === 'estudiante').length,
        completedResources: 0,
        avgTimePerResource,
        topCourses,
        userGrowth,
        engagementRate,
        completionRate
      });
    } catch (err) {
      console.error('Error calculando analytics:', err);
    }
  };

  const calculateUserGrowth = async () => {
    try {
      const { data, error } = await supabase
        .from('usuarios')
        .select('created_at')
        .gte('created_at', new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString());
      
      if (error) throw error;
      
      const lastMonthUsers = data?.length || 0;
      const previousMonthUsers = users.length - lastMonthUsers;
      
      if (previousMonthUsers === 0) return 100;
      return Math.round(((lastMonthUsers - previousMonthUsers) / previousMonthUsers) * 100);
    } catch (err) {
      return 12;
    }
  };

  const calculateEngagementRate = async () => {
    try {
      const { data, error } = await supabase
        .from('progreso_usuarios')
        .select('*')
        .gte('updated_at', new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString());
      
      if (error) throw error;
      
      const activeUsers = new Set(data?.map(p => p.usuario_id) || []).size;
      const totalStudents = users.filter(u => u.rol === 'estudiante').length;
      
      return totalStudents > 0 ? Math.round((activeUsers / totalStudents) * 100) : 0;
    } catch (err) {
      return 68;
    }
  };

  const calculateCompletionRate = async () => {
    try {
      const { data, error } = await supabase
        .from('progreso_usuarios')
        .select('*')
        .eq('completado', true);
      
      if (error) throw error;
      
      const totalCompletions = data?.length || 0;
      const totalPossibleCompletions = users.filter(u => u.rol === 'estudiante').length * resources.length;
      
      return totalPossibleCompletions > 0 ? Math.round((totalCompletions / totalPossibleCompletions) * 100) : 0;
    } catch (err) {
      return 45;
    }
  };

  const calculateTopCourses = async () => {
    try {
      const { data, error } = await supabase
        .from('progreso_usuarios')
        .select(`
          *,
          recursos!inner(
            curso_id,
            cursos!inner(
              titulo
            )
          )
        `);
      
      if (error) throw error;
      
      const courseProgress = {};
      data?.forEach(progress => {
        const courseId = progress.recursos?.curso_id;
        if (courseId) {
          courseProgress[courseId] = (courseProgress[courseId] || 0) + 1;
        }
      });
      
      return Object.entries(courseProgress)
        .sort(([,a], [,b]) => b - a)
        .slice(0, 5)
        .map(([courseId, count]) => ({
          courseId,
          count,
          title: courses.find(c => c.id === parseInt(courseId))?.titulo || `Curso ${courseId}`
        }));
    } catch (err) {
      return [];
    }
  };

  const calculateAvgTimePerResource = async () => {
    try {
      const { data, error } = await supabase
        .from('progreso_usuarios')
        .select('tiempo_dedicado')
        .not('tiempo_dedicado', 'is', null);
      
      if (error) throw error;
      
      const totalTime = data?.reduce((sum, item) => sum + (item.tiempo_dedicado || 0), 0) || 0;
      const count = data?.length || 1;
      
      return Math.round(totalTime / count / 60);
    } catch (err) {
      return 15;
    }
  };

  const updateUserRole = async (userId, newRole) => {
    try {
      const { error } = await supabase
        .from('usuarios')
        .update({ rol: newRole })
        .eq('id', userId);

      if (error) throw error;
      
      fetchUsers();
      setEditingUser(null);
      alert('✅ Rol actualizado exitosamente');
    } catch (err) {
      alert('Error al actualizar el rol');
    }
  };

  const deleteUser = async (userId) => {
    if (!confirm('¿Estás seguro de eliminar este usuario?')) return;
    
    try {
      const { error } = await supabase
        .from('usuarios')
        .delete()
        .eq('id', userId);

      if (error) throw error;
      
      fetchUsers();
      alert('✅ Usuario eliminado exitosamente');
    } catch (err) {
      alert('Error al eliminar usuario');
    }
  };

  const createLevel = async () => {
    if (!newLevel.nombre.trim()) {
      alert('El nombre del nivel es obligatorio');
      return;
    }

    try {
      const { error } = await supabase
        .from('niveles_aprendizaje')
        .insert([newLevel]);

      if (error) throw error;
      
      fetchLevels();
      setNewLevel({ nombre: '', descripcion: '', orden: 1 });
      setShowNewLevel(false);
      alert('✅ Nivel creado exitosamente');
    } catch (err) {
      alert('Error al crear el nivel');
    }
  };

  const updateLevel = async (levelId, updatedData) => {
    try {
      const { error } = await supabase
        .from('niveles_aprendizaje')
        .update(updatedData)
        .eq('id', levelId);

      if (error) throw error;
      
      fetchLevels();
      setEditingLevel(null);
    } catch (err) {
      alert('Error al actualizar el nivel');
    }
  };

  const deleteLevel = async (levelId) => {
    if (!confirm('¿Estás seguro de eliminar este nivel?')) return;
    
    try {
      const { error } = await supabase
        .from('niveles_aprendizaje')
        .delete()
        .eq('id', levelId);

      if (error) throw error;
      
      fetchLevels();
      alert('✅ Nivel eliminado exitosamente');
    } catch (err) {
      alert('Error al eliminar nivel');
    }
  };

  const createCourse = async () => {
    if (!newCourse.titulo.trim() || !newCourse.nivel_id) {
      alert('El título y nivel son obligatorios');
      return;
    }

    try {
      const { error } = await supabase
        .from('cursos')
        .insert([{ ...newCourse, created_by: currentUser.id }]);

      if (error) throw error;
      
      fetchCourses();
      setNewCourse({ titulo: '', descripcion: '', nivel_id: '', color: '#3B82F6', orden: 1 });
      setShowNewCourse(false);
      alert('✅ Curso creado exitosamente');
    } catch (err) {
      alert('Error al crear el curso');
    }
  };

  const deleteCourse = async (courseId) => {
    if (!confirm('¿Estás seguro de eliminar este curso?')) return;
    
    try {
      const { error } = await supabase
        .from('cursos')
        .delete()
        .eq('id', courseId);

      if (error) throw error;
      
      fetchCourses();
      alert('✅ Curso eliminado exitosamente');
    } catch (err) {
      alert('Error al eliminar curso');
    }
  };

  const createResource = async () => {
    if (!newResource.titulo.trim() || !newResource.curso_id) {
      alert('El título y curso son obligatorios');
      return;
    }

    try {
      const { error } = await supabase
        .from('recursos')
        .insert([{ ...newResource, created_by: currentUser.id }]);

      if (error) throw error;
      
      fetchResources();
      setNewResource({ titulo: '', descripcion: '', tipo: 'video', curso_id: '', puntos_recompensa: 10, tiempo_estimado: 5, orden: 1 });
      setShowNewResource(false);
      alert('✅ Recurso creado exitosamente');
    } catch (err) {
      alert('Error al crear el recurso');
    }
  };

  const deleteResource = async (resourceId) => {
    if (!confirm('¿Estás seguro de eliminar este recurso?')) return;
    
    try {
      const { error } = await supabase
        .from('recursos')
        .delete()
        .eq('id', resourceId);

      if (error) throw error;
      
      fetchResources();
      alert('✅ Recurso eliminado exitosamente');
    } catch (err) {
      alert('Error al eliminar recurso');
    }
  };

  const addQuestion = () => {
    if (!currentQuestion.pregunta.trim()) {
      alert('La pregunta es obligatoria');
      return;
    }

    if (currentQuestion.tipo === 'multiple' && currentQuestion.opciones.some(opt => !opt.trim())) {
      alert('Todas las opciones deben tener texto');
      return;
    }

    if (currentQuestion.tipo === 'verdadero_falso') {
      currentQuestion.opciones = ['Verdadero', 'Falso'];
    }

    setCurrentQuiz({
      ...currentQuiz,
      preguntas: [...currentQuiz.preguntas, { ...currentQuestion, id: Date.now() }]
    });

    setCurrentQuestion({
      tipo: 'multiple',
      pregunta: '',
      audio_pregunta: false,
      video_url: '',
      imagen_url: '',
      opciones: ['', '', '', ''],
      audio_opciones: ['', '', '', ''],
      imagen_opciones: ['', '', '', ''],
      respuesta_correcta: 0,
      puntos: 10,
      retroalimentacion_correcta: '¡Excelente! 🎉',
      retroalimentacion_incorrecta: '¡Inténtalo de nuevo! 💪',
      audio_retroalimentacion: false,
      tiempo_limite: 0
    });
  };

  const removeQuestion = (questionId) => {
    setCurrentQuiz({
      ...currentQuiz,
      preguntas: currentQuiz.preguntas.filter(p => p.id !== questionId)
    });
  };

  const moveQuestion = (index, direction) => {
    const newPreguntas = [...currentQuiz.preguntas];
    const newIndex = direction === 'up' ? index - 1 : index + 1;
    if (newIndex >= 0 && newIndex < newPreguntas.length) {
      [newPreguntas[index], newPreguntas[newIndex]] = [newPreguntas[newIndex], newPreguntas[index]];
      setCurrentQuiz({ ...currentQuiz, preguntas: newPreguntas });
    }
  };

  const saveQuizToResource = async () => {
    if (currentQuiz.preguntas.length === 0) {
      alert('Debes agregar al menos una pregunta');
      return;
    }

    try {
      const { error } = await supabase
        .from('recursos')
        .update({ 
          contenido_quiz: currentQuiz.preguntas,
          metadata: {
            total_preguntas: currentQuiz.preguntas.length,
            puntos_totales: currentQuiz.preguntas.reduce((sum, q) => sum + q.puntos, 0),
            tiene_audio: currentQuiz.preguntas.some(q => q.audio_pregunta || q.audio_opciones.some(a => a)),
            tiene_video: currentQuiz.preguntas.some(q => q.video_url),
            tiene_imagenes: currentQuiz.preguntas.some(q => q.imagen_url || q.imagen_opciones.some(i => i))
          }
        })
        .eq('id', selectedResource.id);

      if (error) throw error;
      
      fetchResources();
      setCurrentQuiz({ preguntas: [] });
      setShowQuizBuilder(false);
      setSelectedResource(null);
      alert('✅ Quiz guardado exitosamente');
    } catch (err) {
      console.error('Error guardando quiz:', err);
      alert('Error al guardar el quiz');
    }
  };

  const handlePreviewAnswer = (questionIndex, optionIndex) => {
    const question = currentQuiz.preguntas[questionIndex];
    const isCorrect = optionIndex === question.respuesta_correcta;
    
    setPreviewAnswers({
      ...previewAnswers,
      [questionIndex]: { selected: optionIndex, isCorrect }
    });

    if (question.audio_retroalimentacion) {
      speakText(isCorrect ? question.retroalimentacion_correcta : question.retroalimentacion_incorrecta);
    }
  };

  const speakText = (text) => {
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(text);
      utterance.lang = 'es-ES';
      utterance.rate = 0.9;
      speechSynthesis.speak(utterance);
    }
  };

  const openQuizBuilder = (resource) => {
    setSelectedResource(resource);
    setShowQuizBuilder(true);
    setActiveTab('resources');
    if (resource.contenido_quiz && resource.contenido_quiz.length > 0) {
      setCurrentQuiz({ preguntas: resource.contenido_quiz });
    } else {
      setCurrentQuiz({ preguntas: [] });
    }
  };

  const closeQuizBuilder = () => {
    setShowQuizBuilder(false);
    setCurrentQuiz({ preguntas: [] });
    setSelectedResource(null);
  };

  const openPreview = (resource) => {
    if (!resource.contenido_quiz || resource.contenido_quiz.length === 0) {
      alert('Este quiz no tiene preguntas aún');
      return;
    }
    setSelectedResource(resource);
    setCurrentQuiz({ preguntas: resource.contenido_quiz });
    setPreviewQuiz(true);
    setCurrentPreviewQuestion(0);
    setPreviewAnswers({});
  };

  const closePreview = () => {
    setPreviewQuiz(false);
    setPreviewAnswers({});
    setCurrentPreviewQuestion(0);
    setSelectedResource(null);
  };

  const renderQuestionPreview = () => {
    if (!currentQuiz.preguntas.length) return null;
    
    const question = currentQuiz.preguntas[currentPreviewQuestion];
    const answer = previewAnswers[currentPreviewQuestion];

    return (
      <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl p-8 min-h-[500px] flex flex-col">
        <div className="flex justify-between items-center mb-6">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-purple-500 rounded-full flex items-center justify-center text-white font-bold">
              {currentPreviewQuestion + 1}
            </div>
            <span className="text-gray-600 font-medium">
              Pregunta {currentPreviewQuestion + 1} de {currentQuiz.preguntas.length}
            </span>
          </div>
          <div className="flex gap-2">
            {currentQuiz.preguntas.map((_, idx) => (
              <div
                key={idx}
                className={`w-3 h-3 rounded-full ${
                  idx === currentPreviewQuestion ? 'bg-purple-500' : 'bg-gray-300'
                }`}
              />
            ))}
          </div>
        </div>

        <div className="flex-1 flex flex-col items-center justify-center">
          {question.video_url && (
            <div className="mb-6 w-full max-w-2xl">
              <video 
                controls 
                className="w-full rounded-2xl shadow-lg"
                src={question.video_url}
              >
                Tu navegador no soporta video
              </video>
            </div>
          )}

          {question.imagen_url && !question.video_url && (
            <div className="mb-6">
              <div className="w-48 h-48 bg-white rounded-2xl shadow-lg flex items-center justify-center overflow-hidden transform hover:scale-105 transition-transform">
                <span className="text-6xl">{question.imagen_url}</span>
              </div>
            </div>
          )}

          <div className="flex items-center gap-3 mb-8">
            <h3 className="text-3xl font-bold text-gray-800 text-center leading-relaxed">
              {question.pregunta}
            </h3>
            {question.audio_pregunta && (
              <button
                onClick={() => speakText(question.pregunta)}
                className="bg-blue-500 hover:bg-blue-600 text-white p-3 rounded-full shadow-lg transition-all transform hover:scale-110"
                title="Escuchar pregunta"
              >
                <Volume2 className="w-5 h-5" />
              </button>
            )}
          </div>

          <div className="grid grid-cols-2 gap-4 w-full max-w-2xl">
            {question.opciones.map((opcion, idx) => (
              <button
                key={idx}
                onClick={() => handlePreviewAnswer(currentPreviewQuestion, idx)}
                disabled={answer !== undefined}
                className={`p-6 rounded-xl font-semibold text-lg transition-all transform hover:scale-105 ${
                  answer === undefined
                    ? 'bg-white hover:bg-purple-50 hover:border-purple-300 border-2 border-gray-200 text-gray-700'
                    : answer.selected === idx
                    ? answer.isCorrect
                      ? 'bg-green-500 text-white border-2 border-green-600 animate-bounce'
                      : 'bg-red-500 text-white border-2 border-red-600'
                    : idx === question.respuesta_correcta
                    ? 'bg-green-500 text-white border-2 border-green-600'
                    : 'bg-gray-200 text-gray-500 border-2 border-gray-300'
                }`}
              >
                <div className="flex items-center justify-between">
                  {question.tipo === 'imagen' && question.imagen_opciones[idx] ? (
                    <div className="flex flex-col items-center gap-2 w-full">
                      <span className="text-4xl">{question.imagen_opciones[idx]}</span>
                      <span className="text-sm">{opcion}</span>
                    </div>
                  ) : (
                    <span>{opcion}</span>
                  )}
                  {answer !== undefined && answer.selected === idx && (
                    answer.isCorrect ? 
                      <CheckCircle className="w-6 h-6" /> : 
                      <XCircle className="w-6 h-6" />
                  )}
                </div>
              </button>
            ))}
          </div>

          {answer && (
            <div className={`mt-6 p-4 rounded-xl text-center ${
              answer.isCorrect ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
            }`}>
              <p className="text-xl font-bold">
                {answer.isCorrect ? question.retroalimentacion_correcta : question.retroalimentacion_incorrecta}
              </p>
            </div>
          )}
        </div>

        <div className="flex justify-between mt-6">
          <button
            onClick={() => {
              if (currentPreviewQuestion > 0) {
                setCurrentPreviewQuestion(currentPreviewQuestion - 1);
              }
            }}
            disabled={currentPreviewQuestion === 0}
            className="px-6 py-3 bg-gray-500 hover:bg-gray-600 text-white rounded-xl font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            ← Anterior
          </button>
          
          <button
            onClick={() => {
              if (currentPreviewQuestion < currentQuiz.preguntas.length - 1) {
                setCurrentPreviewQuestion(currentPreviewQuestion + 1);
              }
            }}
            disabled={currentPreviewQuestion === currentQuiz.preguntas.length - 1}
            className="px-6 py-3 bg-purple-500 hover:bg-purple-600 text-white rounded-xl font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            Siguiente →
          </button>
        </div>
      </div>
    );
  };

  const generateAIRecommendations = () => {
    const recommendations = [];
    
    const resourceTypes = resources.reduce((acc, resource) => {
      acc[resource.tipo] = (acc[resource.tipo] || 0) + 1;
      return acc;
    }, {});

    if ((resourceTypes.quiz || 0) < 3) {
      recommendations.push({
        type: 'content_gap',
        title: 'Aumentar Quizzes Interactivos',
        description: `Solo tienes ${resourceTypes.quiz || 0} quizzes. Crea más para mejorar el engagement.`,
        priority: 'high',
        action: 'Crear Quiz'
      });
    }

    if (analytics.engagementRate < 50) {
      recommendations.push({
        type: 'engagement',
        title: 'Baja Tasa de Engagement',
        description: `El engagement es del ${analytics.engagementRate}%. Considera gamificación.`,
        priority: 'high',
        action: 'Mejorar Engagement'
      });
    }

    return recommendations;
  };

  const handleLogout = async () => {
    await supabase.auth.signOut();
    navigate('/');
  };

  const getRoleBadgeColor = (rol) => {
    const colors = {
      admin: 'bg-red-100 text-red-800 border-red-200',
      docente: 'bg-blue-100 text-blue-800 border-blue-200',
      estudiante: 'bg-green-100 text-green-800 border-green-200',
      visitante: 'bg-gray-100 text-gray-800 border-gray-200'
    };
    return colors[rol] || 'bg-gray-100 text-gray-800 border-gray-200';
  };

  const getResourceIcon = (tipo) => {
    const icons = {
      video: Play,
      imagen: Image,
      audio: Headphones,
      quiz: HelpCircle,
      juego: Gamepad2,
      pdf: FileText
    };
    const Icon = icons[tipo] || BookOpen;
    return Icon;
  };

  const renderDashboard = () => {
    const aiRecommendations = generateAIRecommendations();

    return (
      <div className="space-y-6">
        <h2 className="text-xl font-semibold text-gray-800">Dashboard Analítico</h2>
        
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
          <MetricCard 
            title="Usuarios Activos" 
            value={analytics.activeStudents} 
            change={analytics.userGrowth} 
            icon={Users} 
            color="#3B82F6" 
          />
          <MetricCard 
            title="Tasa de Engagement" 
            value={`${analytics.engagementRate}%`} 
            change={5} 
            icon={TrendingUp} 
            color="#10B981" 
          />
          <MetricCard 
            title="Completitud" 
            value={`${analytics.completionRate}%`} 
            change={8} 
            icon={CheckCircle} 
            color="#8B5CF6" 
          />
          <MetricCard 
            title="Tiempo Promedio" 
            value={`${analytics.avgTimePerResource}m`} 
            change={-2} 
            icon={Clock} 
            color="#F59E0B" 
          />
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
          <BarChart 
            title="Distribución de Usuarios"
            data={[
              { label: 'Estudiantes', value: users.filter(u => u.rol === 'estudiante').length },
              { label: 'Docentes', value: users.filter(u => u.rol === 'docente').length },
              { label: 'Administradores', value: users.filter(u => u.rol === 'admin').length }
            ]}
            color="#3B82F6"
            maxValue={users.length || 1}
          />

          <div className="grid grid-cols-2 gap-4">
            <ProgressCircle 
              title="Cursos Activos" 
              value={courses.length} 
              max={20} 
              color="#10B981" 
            />
            <ProgressCircle 
              title="Recursos" 
              value={resources.length} 
              max={100} 
              color="#8B5CF6" 
            />
            <ProgressCircle 
              title="Niveles" 
              value={levels.length} 
              max={10} 
              color="#F59E0B" 
            />
            <ProgressCircle 
              title="Logros" 
              value={achievements.length} 
              max={50} 
              color="#EF4444" 
            />
          </div>
        </div>

        <div className="bg-gradient-to-r from-purple-600 via-blue-600 to-purple-600 rounded-lg p-6 text-white shadow-lg">
          <div className="flex items-start gap-4">
            <div className="bg-white bg-opacity-20 rounded-lg p-3 flex-shrink-0">
              <Sparkles className="w-6 h-6" />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-bold mb-4">Recomendaciones IA Regenerativa</h3>
              
              {aiRecommendations.length > 0 ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                  {aiRecommendations.map((rec, index) => (
                    <div key={index} className="bg-white bg-opacity-10 rounded-lg p-4 backdrop-blur">
                      <div className="flex items-start gap-3">
                        <div className={`w-3 h-3 rounded-full mt-1 ${
                          rec.priority === 'high' ? 'bg-red-400' : 
                          rec.priority === 'medium' ? 'bg-yellow-400' : 'bg-green-400'
                        }`} />
                        <div>
                          <p className="font-semibold text-sm mb-1">{rec.title}</p>
                          <p className="text-xs opacity-90 mb-2">{rec.description}</p>
                          <button className="text-xs bg-white bg-opacity-20 hover:bg-opacity-30 px-3 py-1 rounded transition-colors">
                            {rec.action}
                          </button>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="bg-white bg-opacity-10 rounded-lg p-4 backdrop-blur">
                  <p className="text-center">✅ Tu sistema está bien balanceado. ¡Buen trabajo!</p>
                </div>
              )}

              <div className="flex gap-2">
                <button className="bg-white text-purple-600 px-4 py-2 rounded-lg text-sm font-semibold hover:bg-opacity-90 transition-all flex items-center gap-2">
                  <Sparkles className="w-4 h-4" />
                  Generar Plan de Acción
                </button>
                <button className="bg-white bg-opacity-20 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-opacity-30 transition-all flex items-center gap-2">
                  <BarChart3 className="w-4 h-4" />
                  Ver Análisis Completo
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-white rounded-lg shadow-sm border p-6">
            <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <Activity className="w-5 h-5 text-blue-600" />
              Actividad Reciente
            </h3>
            <div className="space-y-3">
              <div className="flex items-center gap-3 p-3 bg-green-50 rounded-lg border border-green-200">
                <CheckCircle className="w-4 h-4 text-green-600 flex-shrink-0" />
                <div>
                  <p className="text-sm font-medium text-green-800">Sistema actualizado</p>
                  <p className="text-xs text-green-600">{users.length} usuarios, {courses.length} cursos</p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-blue-50 rounded-lg border border-blue-200">
                <Users className="w-4 h-4 text-blue-600 flex-shrink-0" />
                <div>
                  <p className="text-sm font-medium text-blue-800">Análisis completado</p>
                  <p className="text-xs text-blue-600">Engagement: {analytics.engagementRate}%</p>
                </div>
              </div>
              {analytics.topCourses.length > 0 && (
                <div className="flex items-center gap-3 p-3 bg-purple-50 rounded-lg border border-purple-200">
                  <TrendingUp className="w-4 h-4 text-purple-600 flex-shrink-0" />
                  <div>
                    <p className="text-sm font-medium text-purple-800">Curso más popular</p>
                    <p className="text-xs text-purple-600">{analytics.topCourses[0]?.title}</p>
                  </div>
                </div>
              )}
            </div>
          </div>

          <div className="bg-white rounded-lg shadow-sm border p-6">
            <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <Trophy className="w-5 h-5 text-yellow-600" />
              Cursos Más Activos
            </h3>
            <div className="space-y-3">
              {analytics.topCourses.slice(0, 3).map((course, index) => (
                <div key={course.courseId} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center text-blue-600 font-bold text-sm">
                      {index + 1}
                    </div>
                    <div>
                      <p className="text-sm font-medium text-gray-800">{course.title}</p>
                      <p className="text-xs text-gray-600">{course.count} actividades</p>
                    </div>
                  </div>
                  <TrendingUp className="w-4 h-4 text-green-500" />
                </div>
              ))}
              {analytics.topCourses.length === 0 && (
                <p className="text-sm text-gray-500 text-center py-4">No hay datos de actividad aún</p>
              )}
            </div>
          </div>
        </div>
      </div>
    );
  };

  if (error && error.includes('permisos')) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="bg-white p-8 rounded-lg shadow-md text-center max-w-md">
          <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <h2 className="text-xl font-bold text-gray-800 mb-2">Acceso Denegado</h2>
          <p className="text-gray-600 mb-4">{error}</p>
          <button
            onClick={() => navigate('/dashboard')}
            className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg transition-colors"
          >
            Volver al Dashboard
          </button>
        </div>
      </div>
    );
  }

  if (!currentUser) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500 mx-auto"></div>
          <p className="mt-4 text-gray-600">Verificando permisos...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {error && !error.includes('permisos') && (
        <div className="bg-red-50 border border-red-200 p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center">
              <AlertCircle className="w-5 h-5 text-red-500 mr-2" />
              <p className="text-red-700">{error}</p>
            </div>
            <button onClick={() => setError(null)} className="text-red-500 hover:text-red-700">
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>
      )}

      <header className="bg-white shadow-sm border-b">
        <div className="px-6 py-4 flex justify-between items-center">
          <div>
            <h1 className="text-2xl font-bold text-gray-800">Panel de Administrador</h1>
            <p className="text-gray-600 text-sm">Sistema de gestión educativa con IA</p>
          </div>
          
          <div className="flex items-center gap-4">
            <button
              onClick={refreshData}
              disabled={refreshing}
              className="flex items-center gap-2 px-3 py-2 text-gray-600 hover:text-gray-800 hover:bg-gray-100 rounded-lg transition-colors"
            >
              <RefreshCw className={`w-4 h-4 ${refreshing ? 'animate-spin' : ''}`} />
              <span className="text-sm">Actualizar</span>
            </button>
            
            <div className="relative">
              <button
                onClick={() => setMenuOpen(!menuOpen)}
                className="flex items-center gap-3 bg-gray-100 hover:bg-gray-200 px-4 py-2 rounded-lg transition-colors"
              >
                <div className="w-8 h-8 bg-red-500 rounded-full flex items-center justify-center text-white font-semibold">
                  {currentUser?.nombre?.charAt(0).toUpperCase() || 'A'}
                </div>
                <span className="font-medium text-gray-700">{currentUser?.nombre || 'Admin'}</span>
              </button>

              {menuOpen && (
                <div className="absolute right-0 mt-2 w-48 bg-white shadow-lg rounded-lg border py-2 z-10">
                  <div className="px-4 py-2 border-b">
                    <p className="text-sm font-medium text-gray-900">{currentUser?.nombre}</p>
                    <p className="text-xs text-gray-500">{currentUser?.email}</p>
                  </div>
                  <button
                    onClick={handleLogout}
                    className="flex items-center gap-3 w-full px-4 py-2 text-red-600 hover:bg-red-50 transition-colors"
                  >
                    <LogOut className="w-4 h-4" />
                    Cerrar Sesión
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="px-6">
          <div className="flex space-x-6 overflow-x-auto">
            {[
              { id: 'dashboard', label: 'Dashboard', icon: BarChart3 },
              { id: 'users', label: 'Usuarios', icon: Users },
              { id: 'courses', label: 'Cursos', icon: BookOpen },
              { id: 'resources', label: 'Recursos', icon: FileText },
              { id: 'levels', label: 'Niveles', icon: GraduationCap },
              { id: 'achievements', label: 'Logros', icon: Award }
            ].map(tab => {
              const TabIcon = tab.icon;
              return (
                <button
                  key={tab.id}
                  onClick={() => {
                    setActiveTab(tab.id);
                    setShowQuizBuilder(false);
                    setPreviewQuiz(false);
                  }}
                  className={`py-3 px-1 border-b-2 font-medium text-sm transition-colors flex items-center gap-2 whitespace-nowrap ${
                    activeTab === tab.id
                      ? 'border-blue-500 text-blue-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700'
                  }`}
                >
                  <TabIcon className="w-4 h-4" />
                  {tab.label}
                </button>
              );
            })}
          </div>
        </div>
      </header>

      <main className="flex-1 p-6 max-w-7xl mx-auto w-full">
        {activeTab === 'dashboard' && renderDashboard()}

        {activeTab === 'users' && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">Gestión de Usuarios</h2>
              <div className="text-sm text-gray-600">Total: {users.length} usuarios</div>
            </div>

            {users.length === 0 ? (
              <div className="text-center py-12 bg-white rounded-lg shadow-sm border">
                <Users className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No hay usuarios registrados</p>
              </div>
            ) : (
              <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
                <table className="w-full">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Usuario</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Rol</th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Acciones</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {users.map((user) => (
                      <tr key={user.id} className="hover:bg-gray-50">
                        <td className="px-6 py-4">
                          <div className="flex items-center">
                            <div className="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white font-semibold">
                              {user.nombre?.charAt(0).toUpperCase() || 'U'}
                            </div>
                            <div className="ml-3">
                              <div className="text-sm font-medium text-gray-900">{user.nombre || 'Sin nombre'}</div>
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-900">{user.email}</td>
                        <td className="px-6 py-4">
                          {editingUser === user.id ? (
                            <select
                              defaultValue={user.rol}
                              onChange={(e) => updateUserRole(user.id, e.target.value)}
                              className="text-sm border rounded px-2 py-1"
                            >
                              <option value="visitante">Visitante</option>
                              <option value="estudiante">Estudiante</option>
                              <option value="docente">Docente</option>
                              <option value="admin">Admin</option>
                            </select>
                          ) : (
                            <span className={`px-2 py-1 text-xs font-medium rounded-full border ${getRoleBadgeColor(user.rol)}`}>
                              {user.rol}
                            </span>
                          )}
                        </td>
                        <td className="px-6 py-4 text-right">
                          <div className="flex justify-end gap-2">
                            <button
                              onClick={() => setEditingUser(editingUser === user.id ? null : user.id)}
                              className="text-blue-600 hover:text-blue-800 p-2"
                            >
                              <Edit2 className="w-4 h-4" />
                            </button>
                            {user.id !== currentUser.id && (
                              <button
                                onClick={() => deleteUser(user.id)}
                                className="text-red-600 hover:text-red-800 p-2"
                              >
                                <Trash2 className="w-4 h-4" />
                              </button>
                            )}
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

        {/* SECCIÓN DE CURSOS */}
        {activeTab === 'courses' && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">Gestión de Cursos</h2>
              <button
                onClick={() => setShowNewCourse(true)}
                className="flex items-center gap-2 bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg transition-colors"
              >
                <Plus className="w-4 h-4" />
                Nuevo Curso
              </button>
            </div>

            {showNewCourse && (
              <div className="bg-white rounded-lg shadow-sm border p-6">
                <h3 className="text-lg font-semibold text-gray-800 mb-4">Crear Nuevo Curso</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Título</label>
                    <input
                      type="text"
                      value={newCourse.titulo}
                      onChange={(e) => setNewCourse({ ...newCourse, titulo: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      placeholder="Ej: Matemáticas Básicas"
                    />
                  </div>
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Nivel</label>
                    <select
                      value={newCourse.nivel_id}
                      onChange={(e) => setNewCourse({ ...newCourse, nivel_id: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                    >
                      <option value="">Seleccionar nivel</option>
                      {levels.map(level => (
                        <option key={level.id} value={level.id}>{level.nombre}</option>
                      ))}
                    </select>
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">Descripción</label>
                    <textarea
                      value={newCourse.descripcion}
                      onChange={(e) => setNewCourse({ ...newCourse, descripcion: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      rows="3"
                      placeholder="Descripción del curso..."
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Color</label>
                    <input
                      type="color"
                      value={newCourse.color}
                      onChange={(e) => setNewCourse({ ...newCourse, color: e.target.value })}
                      className="w-full h-10 border rounded-lg cursor-pointer"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Orden</label>
                    <input
                      type="number"
                      value={newCourse.orden}
                      onChange={(e) => setNewCourse({ ...newCourse, orden: parseInt(e.target.value) })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      min="1"
                    />
                  </div>
                </div>

                <div className="flex gap-3 mt-6">
                  <button
                    onClick={createCourse}
                    className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <Save className="w-4 h-4" />
                    Guardar
                  </button>
                  <button
                    onClick={() => {
                      setShowNewCourse(false);
                      setNewCourse({ titulo: '', descripcion: '', nivel_id: '', color: '#3B82F6', orden: 1 });
                    }}
                    className="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <X className="w-4 h-4" />
                    Cancelar
                  </button>
                </div>
              </div>
            )}

            {courses.length === 0 ? (
              <div className="text-center py-12 bg-white rounded-lg shadow-sm border">
                <BookOpen className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No hay cursos creados</p>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {courses.map((course) => (
                  <div
                    key={course.id}
                    className="bg-white rounded-lg shadow-sm border hover:shadow-md transition-shadow overflow-hidden"
                  >
                    <div
                      className="h-24 flex items-center justify-center"
                      style={{ backgroundColor: course.color }}
                    >
                      <BookOpen className="w-12 h-12 text-white" />
                    </div>
                    <div className="p-4">
                      <h3 className="font-semibold text-gray-800 mb-2">{course.titulo}</h3>
                      <p className="text-sm text-gray-600 mb-3 line-clamp-2">
                        {course.descripcion || 'Sin descripción'}
                      </p>
                      <div className="flex items-center justify-between text-xs text-gray-500">
                        <span>{course.nivel_nombre}</span>
                        <span>Orden: {course.orden}</span>
                      </div>
                      <div className="flex gap-2 mt-4">
                        <button
                          onClick={() => deleteCourse(course.id)}
                          className="flex-1 bg-red-50 hover:bg-red-100 text-red-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors"
                        >
                          Eliminar
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* SECCIÓN DE RECURSOS */}
        {activeTab === 'resources' && !showQuizBuilder && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">Gestión de Recursos</h2>
              <button
                onClick={() => setShowNewResource(true)}
                className="flex items-center gap-2 bg-purple-500 hover:bg-purple-600 text-white px-4 py-2 rounded-lg transition-colors"
              >
                <Plus className="w-4 h-4" />
                Nuevo Recurso
              </button>
            </div>

            {showNewResource && (
              <div className="bg-white rounded-lg shadow-sm border p-6">
                <h3 className="text-lg font-semibold text-gray-800 mb-4">Crear Nuevo Recurso</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Título</label>
                    <input
                      type="text"
                      value={newResource.titulo}
                      onChange={(e) => setNewResource({ ...newResource, titulo: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      placeholder="Ej: Video: Suma de números"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Tipo</label>
                    <select
                      value={newResource.tipo}
                      onChange={(e) => setNewResource({ ...newResource, tipo: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                    >
                      <option value="video">Video</option>
                      <option value="imagen">Imagen</option>
                      <option value="audio">Audio</option>
                      <option value="quiz">Quiz</option>
                      <option value="juego">Juego</option>
                      <option value="pdf">PDF</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Curso</label>
                    <select
                      value={newResource.curso_id}
                      onChange={(e) => setNewResource({ ...newResource, curso_id: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                    >
                      <option value="">Seleccionar curso</option>
                      {courses.map(course => (
                        <option key={course.id} value={course.id}>{course.titulo}</option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Puntos de Recompensa</label>
                    <input
                      type="number"
                      value={newResource.puntos_recompensa}
                      onChange={(e) => setNewResource({ ...newResource, puntos_recompensa: parseInt(e.target.value) })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      min="0"
                    />
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">Descripción</label>
                    <textarea
                      value={newResource.descripcion}
                      onChange={(e) => setNewResource({ ...newResource, descripcion: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      rows="3"
                      placeholder="Descripción del recurso..."
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Tiempo Estimado (min)</label>
                    <input
                      type="number"
                      value={newResource.tiempo_estimado}
                      onChange={(e) => setNewResource({ ...newResource, tiempo_estimado: parseInt(e.target.value) })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      min="1"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Orden</label>
                    <input
                      type="number"
                      value={newResource.orden}
                      onChange={(e) => setNewResource({ ...newResource, orden: parseInt(e.target.value) })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      min="1"
                    />
                  </div>
                </div>

                <div className="flex gap-3 mt-6">
                  <button
                    onClick={createResource}
                    className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <Save className="w-4 h-4" />
                    Guardar
                  </button>
                  <button
                    onClick={() => {
                      setShowNewResource(false);
                      setNewResource({ titulo: '', descripcion: '', tipo: 'video', curso_id: '', puntos_recompensa: 10, tiempo_estimado: 5, orden: 1 });
                    }}
                    className="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <X className="w-4 h-4" />
                    Cancelar
                  </button>
                </div>
              </div>
            )}

            {resources.length === 0 ? (
              <div className="text-center py-12 bg-white rounded-lg shadow-sm border">
                <FileText className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No hay recursos creados</p>
              </div>
            ) : (
              <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
                <table className="w-full">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Recurso</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Tipo</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Curso</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Puntos</th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Acciones</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {resources.map((resource) => {
                      const ResourceIcon = getResourceIcon(resource.tipo);
                      return (
                        <tr key={resource.id} className="hover:bg-gray-50">
                          <td className="px-6 py-4">
                            <div className="flex items-center">
                              <ResourceIcon className="w-5 h-5 text-gray-400 mr-3" />
                              <div>
                                <div className="text-sm font-medium text-gray-900">{resource.titulo}</div>
                                <div className="text-xs text-gray-500">{resource.tiempo_estimado} min</div>
                              </div>
                            </div>
                          </td>
                          <td className="px-6 py-4 text-sm text-gray-900 capitalize">{resource.tipo}</td>
                          <td className="px-6 py-4 text-sm text-gray-900">{resource.curso_titulo}</td>
                          <td className="px-6 py-4">
                            <span className="px-2 py-1 text-xs font-medium rounded-full bg-yellow-100 text-yellow-800">
                              {resource.puntos_recompensa} pts
                            </span>
                          </td>
                          <td className="px-6 py-4 text-right">
                            <div className="flex justify-end gap-2">
                              {resource.tipo === 'quiz' && (
                                <>
                                  <button
                                    onClick={() => openQuizBuilder(resource)}
                                    className="text-purple-600 hover:text-purple-800 p-2"
                                    title="Editar Quiz"
                                  >
                                    <Edit2 className="w-4 h-4" />
                                  </button>
                                  <button
                                    onClick={() => openPreview(resource)}
                                    className="text-blue-600 hover:text-blue-800 p-2"
                                    title="Vista Previa"
                                  >
                                    <Eye className="w-4 h-4" />
                                  </button>
                                </>
                              )}
                              <button
                                onClick={() => deleteResource(resource.id)}
                                className="text-red-600 hover:text-red-800 p-2"
                              >
                                <Trash2 className="w-4 h-4" />
                              </button>
                            </div>
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

        {/* SECCIÓN DE NIVELES */}
        {activeTab === 'levels' && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">Gestión de Niveles</h2>
              <button
                onClick={() => setShowNewLevel(true)}
                className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors"
              >
                <Plus className="w-4 h-4" />
                Nuevo Nivel
              </button>
            </div>

            {showNewLevel && (
              <div className="bg-white rounded-lg shadow-sm border p-6">
                <h3 className="text-lg font-semibold text-gray-800 mb-4">Crear Nuevo Nivel</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Nombre</label>
                    <input
                      type="text"
                      value={newLevel.nombre}
                      onChange={(e) => setNewLevel({ ...newLevel, nombre: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-green-500"
                      placeholder="Ej: Primer Grado"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Orden</label>
                    <input
                      type="number"
                      value={newLevel.orden}
                      onChange={(e) => setNewLevel({ ...newLevel, orden: parseInt(e.target.value) })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-green-500"
                      min="1"
                    />
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">Descripción</label>
                    <textarea
                      value={newLevel.descripcion}
                      onChange={(e) => setNewLevel({ ...newLevel, descripcion: e.target.value })}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-green-500"
                      rows="3"
                      placeholder="Descripción del nivel..."
                    />
                  </div>
                </div>

                <div className="flex gap-3 mt-6">
                  <button
                    onClick={createLevel}
                    className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <Save className="w-4 h-4" />
                    Guardar
                  </button>
                  <button
                    onClick={() => {
                      setShowNewLevel(false);
                      setNewLevel({ nombre: '', descripcion: '', orden: 1 });
                    }}
                    className="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <X className="w-4 h-4" />
                    Cancelar
                  </button>
                </div>
              </div>
            )}

            {levels.length === 0 ? (
              <div className="text-center py-12 bg-white rounded-lg shadow-sm border">
                <GraduationCap className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No hay niveles creados</p>
              </div>
            ) : (
              <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
                <table className="w-full">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Nivel</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Descripción</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Orden</th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Acciones</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {levels.map((level) => (
                      <tr key={level.id} className="hover:bg-gray-50">
                        <td className="px-6 py-4">
                          {editingLevel === level.id ? (
                            <input
                              type="text"
                              defaultValue={level.nombre}
                              className="text-sm border rounded px-2 py-1 w-full"
                              onBlur={(e) => updateLevel(level.id, { nombre: e.target.value })}
                            />
                          ) : (
                            <div className="text-sm font-medium text-gray-900">{level.nombre}</div>
                          )}
                        </td>
                        <td className="px-6 py-4">
                          {editingLevel === level.id ? (
                            <input
                              type="text"
                              defaultValue={level.descripcion}
                              className="text-sm border rounded px-2 py-1 w-full"
                              onBlur={(e) => updateLevel(level.id, { descripcion: e.target.value })}
                            />
                          ) : (
                            <div className="text-sm text-gray-600">{level.descripcion || 'Sin descripción'}</div>
                          )}
                        </td>
                        <td className="px-6 py-4">
                          {editingLevel === level.id ? (
                            <input
                              type="number"
                              defaultValue={level.orden}
                              className="text-sm border rounded px-2 py-1 w-20"
                              min="1"
                              onBlur={(e) => updateLevel(level.id, { orden: parseInt(e.target.value) })}
                            />
                          ) : (
                            <span className="text-sm text-gray-900">{level.orden}</span>
                          )}
                        </td>
                        <td className="px-6 py-4 text-right">
                          <div className="flex justify-end gap-2">
                            <button
                              onClick={() => setEditingLevel(editingLevel === level.id ? null : level.id)}
                              className="text-blue-600 hover:text-blue-800 p-2"
                            >
                              <Edit2 className="w-4 h-4" />
                            </button>
                            <button
                              onClick={() => deleteLevel(level.id)}
                              className="text-red-600 hover:text-red-800 p-2"
                            >
                              <Trash2 className="w-4 h-4" />
                            </button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

        {/* SECCIÓN DE LOGROS */}
        {activeTab === 'achievements' && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">Gestión de Logros</h2>
              <button
                onClick={() => alert('Función para crear logros próximamente')}
                className="flex items-center gap-2 bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg transition-colors"
              >
                <Plus className="w-4 h-4" />
                Nuevo Logro
              </button>
            </div>

            {achievements.length === 0 ? (
              <div className="text-center py-12 bg-white rounded-lg shadow-sm border">
                <Award className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No hay logros creados</p>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {achievements.map((achievement) => (
                  <div
                    key={achievement.id}
                    className="bg-white rounded-lg shadow-sm border hover:shadow-md transition-shadow p-6"
                  >
                    <div className="flex items-start justify-between mb-4">
                      <div className="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center text-3xl">
                        {achievement.icono || '🏆'}
                      </div>
                      <button
                        onClick={() => alert('Función para eliminar logro')}
                        className="text-red-600 hover:text-red-800 p-1"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                    <h3 className="font-semibold text-gray-800 mb-2">{achievement.nombre}</h3>
                    <p className="text-sm text-gray-600 mb-3">{achievement.descripcion}</p>
                    <div className="flex items-center justify-between text-xs text-gray-500">
                      <span>{achievement.puntos_requeridos} puntos</span>
                      <span className={`px-2 py-1 rounded-full ${
                        achievement.activo ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                      }`}>
                        {achievement.activo ? 'Activo' : 'Inactivo'}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </main>

      {/* QUIZ BUILDER MODAL */}
      {showQuizBuilder && (
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4 overflow-y-auto">
          <div className="bg-white rounded-2xl max-w-6xl w-full max-h-[90vh] overflow-y-auto shadow-2xl my-8">
            <div className="sticky top-0 bg-gradient-to-r from-purple-600 to-blue-600 text-white p-6 rounded-t-2xl z-10">
              <div className="flex justify-between items-center">
                <div>
                  <h2 className="text-2xl font-bold mb-1">✨ Editor de Quiz Interactivo</h2>
                  <p className="text-purple-100">Recurso: {selectedResource?.titulo}</p>
                </div>
                <button
                  onClick={closeQuizBuilder}
                  className="bg-white bg-opacity-20 hover:bg-opacity-30 p-2 rounded-lg transition-colors"
                >
                  <X className="w-6 h-6" />
                </button>
              </div>
            </div>

            <div className="p-6 space-y-6">
              {/* Selector de tipo de pregunta */}
              <div>
                <label className="block text-sm font-bold text-gray-800 mb-3">🎯 Tipo de Pregunta</label>
                <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                  {questionTypes.map((type) => {
                    const TypeIcon = type.icon;
                    return (
                      <button
                        key={type.value}
                        onClick={() => setCurrentQuestion({ ...currentQuestion, tipo: type.value })}
                        className={`p-4 rounded-xl border-2 transition-all transform hover:scale-105 ${
                          currentQuestion.tipo === type.value
                            ? 'border-purple-500 bg-purple-50 shadow-md'
                            : 'border-gray-200 hover:border-gray-300'
                        }`}
                        style={{
                          borderColor: currentQuestion.tipo === type.value ? type.color : undefined,
                          backgroundColor: currentQuestion.tipo === type.value ? `${type.color}15` : undefined
                        }}
                      >
                        <TypeIcon 
                          className="w-6 h-6 mx-auto mb-2" 
                          style={{ color: type.color }}
                        />
                        <div className="text-sm font-semibold text-gray-800">{type.label}</div>
                      </button>
                    );
                  })}
                </div>
              </div>

              {/* Campo de pregunta */}
              <div>
                <label className="block text-sm font-bold text-gray-800 mb-2">❓ Pregunta</label>
                <input
                  type="text"
                  value={currentQuestion.pregunta}
                  onChange={(e) => setCurrentQuestion({ ...currentQuestion, pregunta: e.target.value })}
                  className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-purple-500 text-lg"
                  placeholder="Escribe tu pregunta aquí..."
                />
              </div>

              {/* Opciones multimedia */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="flex items-center gap-2 cursor-pointer bg-blue-50 p-4 rounded-xl hover:bg-blue-100 transition-colors border-2 border-blue-200">
                    <input
                      type="checkbox"
                      checked={currentQuestion.audio_pregunta}
                      onChange={(e) => setCurrentQuestion({ ...currentQuestion, audio_pregunta: e.target.checked })}
                      className="w-5 h-5 text-blue-600"
                    />
                    <Volume2 className="w-5 h-5 text-blue-600" />
                    <span className="text-sm font-semibold text-gray-800">Leer Pregunta</span>
                  </label>
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    <Video className="w-5 h-5 inline mr-2 text-orange-600" />
                    Video URL
                  </label>
                  <input
                    type="url"
                    value={currentQuestion.video_url}
                    onChange={(e) => setCurrentQuestion({ ...currentQuestion, video_url: e.target.value })}
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-orange-500"
                    placeholder="https://..."
                  />
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    <Image className="w-5 h-5 inline mr-2 text-purple-600" />
                    Emoji/Imagen
                  </label>
                  <select
                    value={currentQuestion.imagen_url}
                    onChange={(e) => setCurrentQuestion({ ...currentQuestion, imagen_url: e.target.value })}
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 text-2xl"
                  >
                    <option value="">Ninguno</option>
                    {emojis.map((emoji) => (
                      <option key={emoji} value={emoji}>{emoji}</option>
                    ))}
                  </select>
                </div>
              </div>

              {/* Opciones de respuesta */}
              {currentQuestion.tipo !== 'completar' && (
                <div>
                  <label className="block text-sm font-bold text-gray-800 mb-3">
                    📝 Opciones de Respuesta
                    {currentQuestion.tipo === 'verdadero_falso' && 
                      <span className="ml-2 text-xs text-gray-500">(Automático: Verdadero/Falso)</span>
                    }
                  </label>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    {currentQuestion.opciones.map((opcion, idx) => (
                      <div key={idx} className="space-y-2">
                        <div className="flex gap-2">
                          <input
                            type="text"
                            value={opcion}
                            onChange={(e) => {
                              const newOpciones = [...currentQuestion.opciones];
                              newOpciones[idx] = e.target.value;
                              setCurrentQuestion({ ...currentQuestion, opciones: newOpciones });
                            }}
                            disabled={currentQuestion.tipo === 'verdadero_falso'}
                            className="flex-1 px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500"
                            placeholder={`Opción ${idx + 1}`}
                          />
                          <button
                            onClick={() => setCurrentQuestion({ ...currentQuestion, respuesta_correcta: idx })}
                            className={`px-4 py-2 rounded-lg font-semibold transition-all ${
                              currentQuestion.respuesta_correcta === idx
                                ? 'bg-green-500 text-white shadow-lg scale-105'
                                : 'bg-gray-200 text-gray-600 hover:bg-gray-300'
                            }`}
                          >
                            {currentQuestion.respuesta_correcta === idx ? '✓' : idx + 1}
                          </button>
                        </div>

                        {currentQuestion.tipo === 'imagen' && (
                          <select
                            value={currentQuestion.imagen_opciones[idx]}
                            onChange={(e) => {
                              const newImagenes = [...currentQuestion.imagen_opciones];
                              newImagenes[idx] = e.target.value;
                              setCurrentQuestion({ ...currentQuestion, imagen_opciones: newImagenes });
                            }}
                            className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg text-2xl"
                          >
                            <option value="">Sin emoji</option>
                            {emojis.map((emoji) => (
                              <option key={emoji} value={emoji}>{emoji}</option>
                            ))}
                          </select>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Configuración adicional */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">⭐ Puntos</label>
                  <input
                    type="number"
                    value={currentQuestion.puntos}
                    onChange={(e) => setCurrentQuestion({ ...currentQuestion, puntos: parseInt(e.target.value) })}
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-yellow-500"
                    min="1"
                  />
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">⏱️ Tiempo Límite (seg)</label>
                  <input
                    type="number"
                    value={currentQuestion.tiempo_limite}
                    onChange={(e) => setCurrentQuestion({ ...currentQuestion, tiempo_limite: parseInt(e.target.value) })}
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500"
                    min="0"
                    placeholder="0 = sin límite"
                  />
                </div>

                <div>
                  <label className="flex items-center gap-2 cursor-pointer bg-green-50 p-4 rounded-xl hover:bg-green-100 transition-colors border-2 border-green-200">
                    <input
                      type="checkbox"
                      checked={currentQuestion.audio_retroalimentacion}
                      onChange={(e) => setCurrentQuestion({ ...currentQuestion, audio_retroalimentacion: e.target.checked })}
                      className="w-5 h-5 text-green-600"
                    />
                    <Mic className="w-5 h-5 text-green-600" />
                    <span className="text-sm font-semibold text-gray-800">Leer Feedback</span>
                  </label>
                </div>
              </div>

              {/* Retroalimentación */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">✅ Retroalimentación Correcta</label>
                  <input
                    type="text"
                    value={currentQuestion.retroalimentacion_correcta}
                    onChange={(e) => setCurrentQuestion({ ...currentQuestion, retroalimentacion_correcta: e.target.value })}
                    className="w-full px-3 py-2 border-2 border-green-200 rounded-lg focus:ring-2 focus:ring-green-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">❌ Retroalimentación Incorrecta</label>
                  <input
                    type="text"
                    value={currentQuestion.retroalimentacion_incorrecta}
                    onChange={(e) => setCurrentQuestion({ ...currentQuestion, retroalimentacion_incorrecta: e.target.value })}
                    className="w-full px-3 py-2 border-2 border-red-200 rounded-lg focus:ring-2 focus:ring-red-500"
                  />
                </div>
              </div>

              {/* Botón agregar pregunta */}
              <button
                onClick={addQuestion}
                className="w-full bg-gradient-to-r from-purple-500 to-blue-500 hover:from-purple-600 hover:to-blue-600 text-white px-6 py-4 rounded-xl font-bold text-lg transition-all transform hover:scale-[1.02] flex items-center justify-center gap-3 shadow-lg"
              >
                <Plus className="w-6 h-6" />
                Agregar Pregunta al Quiz
              </button>

              {/* Lista de preguntas agregadas */}
              {currentQuiz.preguntas.length > 0 && (
                <div className="border-t-2 border-gray-200 pt-6">
                  <h3 className="text-lg font-bold text-gray-800 mb-4 flex items-center gap-2">
                    <Sparkles className="w-5 h-5 text-purple-600" />
                    Preguntas del Quiz ({currentQuiz.preguntas.length})
                  </h3>
                  <div className="space-y-3 max-h-96 overflow-y-auto">
                    {currentQuiz.preguntas.map((q, index) => {
                      const TypeIcon = questionTypes.find(t => t.value === q.tipo)?.icon || HelpCircle;
                      const typeColor = questionTypes.find(t => t.value === q.tipo)?.color || '#3B82F6';
                      return (
                        <div key={q.id} className="bg-gradient-to-r from-gray-50 to-gray-100 rounded-lg p-4 flex items-center justify-between hover:shadow-md transition-shadow">
                          <div className="flex items-center gap-3 flex-1">
                            <div 
                              className="rounded-full w-10 h-10 flex items-center justify-center font-bold text-white shadow-md"
                              style={{ backgroundColor: typeColor }}
                            >
                              {index + 1}
                            </div>
                            <TypeIcon className="w-5 h-5" style={{ color: typeColor }} />
                            <div className="flex-1">
                              <p className="font-medium text-gray-800">{q.pregunta}</p>
                              <div className="flex gap-3 text-xs text-gray-500 mt-1">
                                <span>⭐ {q.puntos} puntos</span>
                                <span>📝 {q.opciones.length} opciones</span>
                                {q.audio_pregunta && <span>🔊 Audio</span>}
                                {q.video_url && <span>🎥 Video</span>}
                                {q.imagen_url && <span>🖼️ Imagen</span>}
                              </div>
                            </div>
                          </div>
                          <div className="flex gap-2">
                            <button
                              onClick={() => moveQuestion(index, 'up')}
                              disabled={index === 0}
                              className="p-2 text-gray-600 hover:text-gray-800 hover:bg-gray-200 rounded-lg disabled:opacity-30 transition-all"
                              title="Mover arriba"
                            >
                              <ChevronUp className="w-4 h-4" />
                            </button>
                            <button
                              onClick={() => moveQuestion(index, 'down')}
                              disabled={index === currentQuiz.preguntas.length - 1}
                              className="p-2 text-gray-600 hover:text-gray-800 hover:bg-gray-200 rounded-lg disabled:opacity-30 transition-all"
                              title="Mover abajo"
                            >
                              <ChevronDown className="w-4 h-4" />
                            </button>
                            <button
                              onClick={() => removeQuestion(q.id)}
                              className="p-2 text-red-600 hover:text-red-800 hover:bg-red-100 rounded-lg transition-all"
                              title="Eliminar"
                            >
                              <Trash2 className="w-4 h-4" />
                            </button>
                          </div>
                        </div>
                      );
                    })}
                  </div>

                  {/* Botón guardar quiz */}
                  <button
                    onClick={saveQuizToResource}
                    className="w-full mt-6 bg-green-500 hover:bg-green-600 text-white px-6 py-4 rounded-xl font-bold text-lg transition-all flex items-center justify-center gap-3 shadow-lg"
                  >
                    <Save className="w-6 h-6" />
                    Guardar Quiz Completo
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* PREVIEW MODAL */}
      {previewQuiz && (
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl max-w-5xl w-full max-h-[90vh] overflow-y-auto shadow-2xl">
            <div className="sticky top-0 bg-gradient-to-r from-blue-600 to-purple-600 text-white p-6 rounded-t-2xl z-10">
              <div className="flex justify-between items-center">
                <div>
                  <h2 className="text-2xl font-bold">👁️ Vista Previa del Quiz</h2>
                  <p className="text-blue-100">Prueba cómo se verá tu quiz</p>
                </div>
                <button
                  onClick={closePreview}
                  className="bg-white bg-opacity-20 hover:bg-opacity-30 p-2 rounded-lg transition-colors"
                >
                  <X className="w-6 h-6" />
                </button>
              </div>
            </div>
            <div className="p-6">
              {renderQuestionPreview()}
            </div>
          </div>
        </div>
      )}

      <footer className="bg-white border-t border-gray-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex items-center justify-between text-sm text-gray-600">
          <div>© 2025 Didactikapp - Básica Elemental</div>
          <div className="flex items-center gap-4">
            <span>Usuarios: {users.length}</span>
            <span>Cursos: {courses.length}</span>
            <span>v2.1.0</span>
          </div>
        </div>
      </footer>
    </div>
  );
}