import React, { useEffect, useState } from "react";
import {
  Users, Settings, BookOpen, LogOut, Edit2, Trash2, Plus, Save, X, GraduationCap, AlertCircle,
  RefreshCw, Award, MessageCircle, Gift, BarChart3, FileText, Play, Image, Headphones, Gamepad2, HelpCircle,
  Star, TrendingUp, Calendar, Target, Zap, Trophy, CheckCircle, XCircle, Eye, Sparkles, Upload, Mic, Video,
  Volume2, Download, Move, ChevronUp, ChevronDown, ChevronRight, Clock, Activity, TrendingDown, Filter, UserCheck,
  UserX, FileUp, Brain, Search, PieChart, BarChart2, LineChart, Printer, Loader, Send, Copy, Shield,
  Library, Grid, Lightbulb
} from "lucide-react";
import { supabase } from "../services/supabaseClient";
import { useNavigate } from "react-router-dom";
import * as pdfjsLib from 'pdfjs-dist';
import KarinMascot from "../KarinMascot";

pdfjsLib.GlobalWorkerOptions.workerSrc = new URL('pdfjs-dist/build/pdf.worker.min.mjs', import.meta.url,).href;
// Agrega esta función al inicio de tu componente EnhancedAdminPanel
const fixMobileTouch = () => {
  if (typeof window !== 'undefined' && /iPhone|iPad|iPod|Android/i.test(navigator.userAgent)) {
    // Corregir todos los botones
    setTimeout(() => {
      document.querySelectorAll('button, .cursor-pointer').forEach(btn => {
        if (!btn.hasAttribute('data-touch-fixed')) {
          btn.setAttribute('data-touch-fixed', 'true');
          btn.style.touchAction = 'manipulation';

          // Forzar que los clics funcionen
          btn.addEventListener('touchstart', (e) => {
            e.preventDefault();
            setTimeout(() => btn.click(), 10);
          }, { passive: false });
        }
      });
    }, 100);
  }
};

// Componente de Gráfica de Barras Horizontales
const ExcelHorizontalBarChart = ({ title, data, colors }) => {
  const maxValue = Math.max(...data.map(d => d.value));

  return (
    <div className="bg-white rounded-xl p-4 border-2 border-gray-200 shadow-sm">
      <h4 className="text-sm font-bold text-gray-800 mb-4">{title}</h4>
      <div className="space-y-3">
        {data.map((item, idx) => (
          <div key={idx}>
            <div className="flex justify-between mb-1">
              <span className="text-xs font-semibold text-gray-700">{item.label}</span>
              <span className="text-xs font-bold text-gray-800">{item.value}</span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-4 overflow-hidden">
              <div
                className="h-full rounded-full transition-all duration-700 flex items-center justify-end pr-2"
                style={{
                  width: `${(item.value / maxValue) * 100}%`,
                  backgroundColor: colors[idx % colors.length],
                }}
              >
                <span className="text-xs font-bold text-white">
                  {Math.round((item.value / maxValue) * 100)}%
                </span>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

// Componente de Gráfica de Línea (Progreso en el tiempo)
const ExcelLineChart = ({ title, data, color }) => {
  const maxValue = Math.max(...data.map(d => d.value));
  const points = data.map((d, i) => ({
    x: (i / (data.length - 1)) * 100,
    y: 100 - ((d.value / maxValue) * 80)
  }));

  const pathD = points.map((p, i) =>
    `${i === 0 ? 'M' : 'L'} ${p.x} ${p.y}`
  ).join(' ');

  return (
    <div className="bg-white rounded-xl p-4 border-2 border-gray-200 shadow-sm">
      <h4 className="text-sm font-bold text-gray-800 mb-4">{title}</h4>
      <div className="relative h-48">
        <svg className="w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none">
          {/* Grid */}
          {[0, 25, 50, 75, 100].map(y => (
            <line key={y} x1="0" y1={y} x2="100" y2={y} stroke="#e5e7eb" strokeWidth="0.2" />
          ))}

          {/* Área bajo la línea */}
          <path
            d={`${pathD} L 100 100 L 0 100 Z`}
            fill={`${color}30`}
          />

          {/* Línea principal */}
          <path
            d={pathD}
            fill="none"
            stroke={color}
            strokeWidth="1"
            strokeLinecap="round"
            strokeLinejoin="round"
          />

          {/* Puntos */}
          {points.map((p, i) => (
            <circle key={i} cx={p.x} cy={p.y} r="1.5" fill={color} />
          ))}
        </svg>

        {/* Labels */}
        <div className="absolute bottom-0 left-0 right-0 flex justify-between text-xs text-gray-600 mt-2">
          {data.map((d, i) => (
            <span key={i}>{d.label}</span>
          ))}
        </div>
      </div>
    </div>
  );
};

// Componente de Gráfica de Dona (Donut Chart)
const ExcelDonutChart = ({ title, data, colors }) => {
  const total = data.reduce((sum, d) => sum + d.value, 0);
  let currentAngle = -90;

  const slices = data.map((item, idx) => {
    const percentage = (item.value / total) * 100;
    const angle = (percentage / 100) * 360;
    const startAngle = currentAngle;
    const endAngle = currentAngle + angle;
    currentAngle = endAngle;

    const startRad = (startAngle * Math.PI) / 180;
    const endRad = (endAngle * Math.PI) / 180;

    const x1 = 50 + 40 * Math.cos(startRad);
    const y1 = 50 + 40 * Math.sin(startRad);
    const x2 = 50 + 40 * Math.cos(endRad);
    const y2 = 50 + 40 * Math.sin(endRad);

    const largeArc = angle > 180 ? 1 : 0;

    return {
      path: `M 50 50 L ${x1} ${y1} A 40 40 0 ${largeArc} 1 ${x2} ${y2} Z`,
      color: colors[idx % colors.length],
      percentage: percentage.toFixed(1),
      label: item.label,
      value: item.value
    };
  });

  return (
    <div className="bg-white rounded-xl p-4 border-2 border-gray-200 shadow-sm">
      <h4 className="text-sm font-bold text-gray-800 mb-4">{title}</h4>
      <div className="flex items-center gap-4">
        <div className="relative w-32 h-32">
          <svg viewBox="0 0 100 100" className="transform -rotate-90">
            {slices.map((slice, idx) => (
              <path
                key={idx}
                d={slice.path}
                fill={slice.color}
                className="hover:opacity-80 transition-opacity cursor-pointer"
              />
            ))}
            {/* Centro blanco */}
            <circle cx="50" cy="50" r="25" fill="white" />
          </svg>
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="text-center">
              <div className="text-xl font-bold text-gray-800">{total}</div>
              <div className="text-xs text-gray-600">Total</div>
            </div>
          </div>
        </div>

        <div className="flex-1 space-y-2">
          {slices.map((slice, idx) => (
            <div key={idx} className="flex items-center gap-2">
              <div
                className="w-3 h-3 rounded-full"
                style={{ backgroundColor: slice.color }}
              />
              <span className="text-xs text-gray-700 flex-1">{slice.label}</span>
              <span className="text-xs font-bold text-gray-800">
                {slice.value} ({slice.percentage}%)
              </span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

// Componente de Gráfica de Columnas
const ExcelColumnChart = ({ title, data, colors }) => {
  const maxValue = Math.max(...data.map(d => d.value));

  return (
    <div className="bg-white rounded-xl p-4 border-2 border-gray-200 shadow-sm">
      <h4 className="text-sm font-bold text-gray-800 mb-4">{title}</h4>
      <div className="flex items-end justify-between gap-2 h-40">
        {data.map((item, idx) => (
          <div key={idx} className="flex-1 flex flex-col items-center">
            <div className="w-full flex flex-col items-center justify-end flex-1">
              <span className="text-xs font-bold text-gray-800 mb-1">{item.value}</span>
              <div
                className="w-full rounded-t-lg transition-all duration-700 relative group"
                style={{
                  height: `${(item.value / maxValue) * 100}%`,
                  backgroundColor: colors[idx % colors.length],
                  minHeight: '20px'
                }}
              >
                <div className="absolute inset-0 bg-white opacity-0 group-hover:opacity-20 transition-opacity" />
              </div>
            </div>
            <span className="text-xs text-gray-600 mt-2 text-center">{item.label}</span>
          </div>
        ))}
      </div>
    </div>
  );
};

// Componente de Gráfico de Barras
const BarChart = ({ title, data, color }) => {
  if (!data || data.length === 0) return null;

  const values = data.map(d => d.value);
  const maxValue = Math.max(...values, 1);

  return (
    <div className="bg-white border-2 border-gray-300 rounded-lg p-4">
      <h4 className="text-sm font-bold text-gray-800 mb-4">{title}</h4>

      <div className="space-y-3">
        {data.map((item, idx) => {
          // ✅ Forzar un mínimo de 8% para que se vea aunque sea 1
          let porcentaje = (item.value / maxValue) * 100;
          const esValorPequeno = item.value > 0 && porcentaje < 8;
          if (esValorPequeno) porcentaje = 8; // Mínimo visible

          return (
            <div key={idx}>
              <div className="flex justify-between text-sm mb-1">
                <span className="font-bold text-gray-700">{item.label}</span>
                <span className="font-bold text-gray-800">{item.value}</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-6 overflow-hidden">
                <div
                  className="h-full rounded-full transition-all flex items-center justify-end px-2"
                  style={{
                    width: `${porcentaje}%`,
                    backgroundColor: color,
                  }}
                >
                  {item.value > 0 && (
                    <span className="text-xs font-bold text-white">
                      {item.value}
                    </span>
                  )}
                </div>
              </div>
            </div>
          );
        })}
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
// Componente de Métricas en Tiempo Real (CORREGIDO)
const MetricCard = ({ title, value, change, icon: Icon, color, suffix = "" }) => (
  <div className="bg-white border-2 border-gray-300 rounded-lg p-4 shadow-sm hover:shadow-md transition-shadow">
    <div className="flex justify-between items-start mb-2">
      <div>
        <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide">
          {title}
        </p>
        <p className="text-2xl font-bold text-gray-900 mt-1">
          {value}{suffix}
        </p>
      </div>
      <div className="p-2 rounded-lg" style={{ backgroundColor: `${color}20` }}>
        <Icon className="w-5 h-5" style={{ color }} />
      </div>
    </div>
    {change !== undefined && change !== null && (
      <div
        className={`flex items-center gap-1 text-xs font-medium ${change >= 0 ? "text-green-600" : "text-red-600"}`}
      >
        {change >= 0 ? (
          <TrendingUp className="w-3 h-3" />
        ) : (
          <TrendingDown className="w-3 h-3" />
        )}
        <span>
          {change >= 0 ? "+" : ""}
          {change}% vs último mes
        </span>
      </div>
    )}
  </div>
);

const SimpleLastAccessDate = ({ lastAccess }) => {
  const [displayDate, setDisplayDate] = useState("");

  useEffect(() => {
    const updateDisplay = () => {
      if (!lastAccess) {
        setDisplayDate("Nunca");
        return;
      }

      try {
        const lastAccessDate = new Date(lastAccess);
        const now = new Date();
        const diffMs = now - lastAccessDate;
        const diffSeconds = Math.floor(diffMs / 1000);
        const diffMinutes = Math.floor(diffSeconds / 60);
        const diffHours = Math.floor(diffMinutes / 60);
        const diffDays = Math.floor(diffHours / 24);

        let dateText = "";

        // Hace segundos/minutos
        if (diffSeconds < 60) {
          dateText = "Hace unos segundos";
        }
        // Hace minutos
        else if (diffMinutes < 60) {
          dateText = `Hace ${diffMinutes}m`;
        }
        // Hace horas
        else if (diffHours < 24) {
          dateText = `Hace ${diffHoras}h`;
        }
        // Hace días
        else if (diffDays < 7) {
          dateText = `Hace ${diffDays}d`;
        }
        // Más de una semana - mostrar fecha
        else {
          dateText = lastAccessDate.toLocaleDateString("es-ES", {
            year: "numeric",
            month: "short",
            day: "numeric",
            hour: "2-digit",
            minute: "2-digit"
          });
        }

        setDisplayDate(dateText);
      } catch (err) {
        console.error("Error calculando fecha:", err);
        setDisplayDate("Error");
      }
    };

    updateDisplay();

    // Actualizar cada 30 segundos
    const interval = setInterval(updateDisplay, 30000);

    return () => clearInterval(interval);
  }, [lastAccess]);

  return (
    <span className="text-xs text-gray-600 font-medium">
      {displayDate}
    </span>
  );
};

export default function EnhancedAdminPanel() {
  const navigate = useNavigate();

  // Estados principales
  const [users, setUsers] = useState([]);
  const [levels, setLevels] = useState([]);
  const [courses, setCourses] = useState([]);
  const [resources, setResources] = useState([]);
  const [achievements, setAchievements] = useState([]);
  const [groups, setGroups] = useState([]);
  const [documentText, setDocumentText] = useState("");

  // Estados de UI
  const [loading, setLoading] = useState(true);
  const [menuOpen, setMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState("dashboard");
  const [error, setError] = useState(null);
  const [currentUser, setCurrentUser] = useState(null);
  const [refreshing, setRefreshing] = useState(false);

  // Estados de edición
  const [editingUser, setEditingUser] = useState(null);
  const [editingLevel, setEditingLevel] = useState(null);
  const [selectedRoles, setSelectedRoles] = useState({});
  const [selectedGroups, setSelectedGroups] = useState({});

  // Estados de formularios
  const [showNewLevel, setShowNewLevel] = useState(false);
  const [showNewCourse, setShowNewCourse] = useState(false);
  const [showNewResource, setShowNewResource] = useState(false);
  const [showNewGroup, setShowNewGroup] = useState(false);

  const [newLevel, setNewLevel] = useState({
    nombre: "",
    descripcion: "",
    orden: 1,
  });
  const [newCourse, setNewCourse] = useState({
    titulo: "",
    descripcion: "",
    nivel_id: "",
    color: "#3B82F6",
    orden: 1,
  });
  const [newResource, setNewResource] = useState({
    titulo: "",
    descripcion: "",
    tipo: "video",
    curso_id: "",
    puntos_recompensa: 10,
    tiempo_estimado: 5,
    orden: 1,
  });
  const [newGroup, setNewGroup] = useState({ nombre: "", descripcion: "" });

  // Estados para crear estudiantes
  const [showNewStudent, setShowNewStudent] = useState(false);
  const [newStudentData, setNewStudentData] = useState({
    nombre: "",
    usuario: "",
    password: "",
    confirm_password: "",
    grupo_id: "",
    email: "",
  });
  const [creatingStudent, setCreatingStudent] = useState(false);
  const [studentMessage, setStudentMessage] = useState("");

  // Estados de analíticas avanzadas
  const [analytics, setAnalytics] = useState({
    totalUsers: 0,
    activeStudents: 0,
    completedResources: 0,
    avgTimePerResource: 0,
    topCourses: [],
    userGrowth: 0,
    engagementRate: 0,
    completionRate: 0,
  });

  // Estados para análisis detallado
  const [initialLoad, setInitialLoad] = useState(true);
  const [showDetailedAnalytics, setShowDetailedAnalytics] = useState(false);
  const [selectedStudent, setSelectedStudent] = useState(null);
  const [selectedCourse, setSelectedCourse] = useState(null);
  const [aiMetrics, setAiMetrics] = useState(null); const [aiInsights, setAiInsights] = useState([]); const [aiRecommendations, setAiRecommendations] = useState([]); const [loadingAI, setLoadingAI] = useState(true); const [expandedMetric, setExpandedMetric] = useState(null);
  const [studentProgress, setStudentProgress] = useState([]);
  const [courseAnalytics, setCourseAnalytics] = useState(null);
  const [filterStudent, setFilterStudent] = useState("");
  const [filterCourse, setFilterCourse] = useState("");
  const [selectedCourseForReport, setSelectedCourseForReport] = useState(null);
  const [showCourseDropdown, setShowCourseDropdown] = useState(false);
  const [isAnalyzingAllCourses, setIsAnalyzingAllCourses] = useState(false);

  //  ESTADOS PARA INTERACTIVIDAD 
  const [playingGame, setPlayingGame] = useState(null);
  const [gameState, setGameState] = useState(null);
  const [storyPage, setStoryPage] = useState(0);
  const [challengeProgress, setChallengeProgress] = useState({});
  const [exerciseAnswers, setExerciseAnswers] = useState({});
  // ESTADOS PARA EDICIÓN AVANZADA DE CONTENIDO 
  const [editingQuizQuestion, setEditingQuizQuestion] = useState(null);
  const [editingCompleteQuiz, setEditingCompleteQuiz] = useState(null);
  const [editingQuestionModal, setEditingQuestionModal] = useState(null);
  const [tempQuestionData, setTempQuestionData] = useState(null);
  const [showEmojiPicker, setShowEmojiPicker] = useState(false);
  const [emojiPickerFor, setEmojiPickerFor] = useState(null); // 'question', 'option-0', 'option-1', etc.
  const [savingChanges, setSavingChanges] = useState(false);

  // Estados para Quiz Builder
  const [showQuizBuilder, setShowQuizBuilder] = useState(false);
  const [selectedResource, setSelectedResource] = useState(null);
  const [previewQuiz, setPreviewQuiz] = useState(false);
  const [currentPreviewQuestion, setCurrentPreviewQuestion] = useState(0);
  const [previewAnswers, setPreviewAnswers] = useState({});
  const [optionListenState, setOptionListenState] = useState({});
  const [uploadedDocument, setUploadedDocument] = useState(null);
  const [generatingQuestions, setGeneratingQuestions] = useState(false);
  const [selectedOption, setSelectedOption] = useState(null);
  const [mascotAnimation, setMascotAnimation] = useState('idle');

  const [inactivityTimer, setInactivityTimer] = useState(null);
  const [showTimer, setShowTimer] = useState(false);
  const [timeLeft, setTimeLeft] = useState(0);

  // Notificaciones tipo Toast
  const [toastMessage, setToastMessage] = useState(null);
  const showToast = (message, type = 'success') => {
    setToastMessage({ message, type });
    setTimeout(() => setToastMessage(null), 3000);
  };

  const [currentQuiz, setCurrentQuiz] = useState({
    preguntas: [],
  });



  const [currentQuestion, setCurrentQuestion] = useState({
    tipo: "multiple",
    pregunta: "",
    audio_pregunta: true,
    video_url: "",
    imagen_url: "",
    opciones: ["", "", "", ""],
    audio_opciones: ["", "", "", ""],
    imagen_opciones: ["", "", "", ""],
    respuesta_correcta: 0,
    puntos: 10,
    retroalimentacion_correcta: "¡Excelente! 🎉",
    retroalimentacion_incorrecta: "¡Inténtalo de nuevo! 💪",
    audio_retroalimentacion: true,
    tiempo_limite: 0,
  });

  const [showAIChat, setShowAIChat] = useState(false);
  const [chatMessages, setChatMessages] = useState([]);
  const [chatInput, setChatInput] = useState("");
  const [chatLoading, setChatLoading] = useState(false);

  // Estados para modal de reporte visual
  const [showCourseReportModal, setShowCourseReportModal] = useState(false);
  const [showNewAchievement, setShowNewAchievement] = useState(false);
  const [newAchievementData, setNewAchievementData] = useState({
    nombre: "",
    descripcion: "",
    icono: "🏆",
    puntos_requeridos: 100,
  });
  const [showReauthModal, setShowReauthModal] = useState(false);
  const [targetRole, setTargetRole] = useState(null);
  const [reauthPassword, setReauthPassword] = useState("");
  const [reauthLoading, setReauthLoading] = useState(false);
  const [reauthError, setReauthError] = useState(null);
  const [activeRoleView, setActiveRoleView] = useState(null);
  const [courseReportData, setCourseReportData] = useState(null);

  // ===== GENERADOR DE CONTENIDO =====
  const [showContentGenerator, setShowContentGenerator] = useState(false);
  const [viewingContent, setViewingContent] = useState(null);
  const [editingContent, setEditingContent] = useState(null);
  const [showContentViewer, setShowContentViewer] = useState(false);
  const [contentGeneratorTab, setContentGeneratorTab] = useState('generator');
  const [contentType, setContentType] = useState('quiz');
  const [generatorPrompt, setGeneratorPrompt] = useState('');
  const [generatingContent, setGeneratingContent] = useState(false);
  const [generatedContent, setGeneratedContent] = useState(null);
  const [contentLibrary, setContentLibrary] = useState([]);
  const [expandedContentId, setExpandedContentId] = useState(null);
  const [editingInPlace, setEditingInPlace] = useState(null);
  const [showContentPreview, setShowContentPreview] = useState(false);
  const [previewMode, setPreviewMode] = useState('desktop'); // 'desktop' | 'mobile' 
  const [editingGeneratedQuiz, setEditingGeneratedQuiz] = useState(null);
  const [quizPreviewIndex, setQuizPreviewIndex] = useState(0);
  const [quizPreviewAnswers, setQuizPreviewAnswers] = useState({});
  const [attemptCount, setAttemptCount] = useState({}); // Contador de intentos por pregunta
  const [lastAutoRepeat, setLastAutoRepeat] = useState(Date.now()); // Última repetición automática
  // Estados para control de repetición de audio
  const [lastRepeatTime, setLastRepeatTime] = useState(0);
  const [isRepeating, setIsRepeating] = useState(false);
  const REPEAT_COOLDOWN = 3000; // 3 segundos de espera entre repeticiones

  // Estados de filtros de usuarios
  const [filterRole, setFilterRole] = useState("todos");
  const [filterGroup, setFilterGroup] = useState("todos");
  const [filterStatus, setFilterStatus] = useState("todos");
  const [searchUserText, setSearchUserText] = useState("");
  // Estados para reportes avanzados
  const [filterByGroup, setFilterByGroup] = useState("");
  const [filterByStatus, setFilterByStatus] = useState("");
  const [expandedStudent, setExpandedStudent] = useState(null);
  const [filterByCourse, setFilterByCourse] = useState("");
  const [searchStudent, setSearchStudent] = useState("");

  const [quizConfig, setQuizConfig] = useState({
    totalPreguntas: 5,
    tiposSeleccionados: {
      multiple: true,
      verdadero_falso: true,
      completar: true,
      imagen: false,
      audio: false,
    },
    dificultad: "medio", // facil, medio, dificil
    audio_automatico: true,
    retroalimentacion_detallada: true,
  });

  // Obtener el estado real del usuario =====
  const getUserStatus = (lastAccess, userId) => {
    if (!lastAccess)
      return {
        isActive: false,
        label: "Nunca conectado",
        color: "gray",
        icon: "⭕",
      };

    const lastAccessDate = new Date(lastAccess);
    const now = new Date();
    const diffInMinutes = (now - lastAccessDate) / (1000 * 60);

    if (diffInMinutes < 5) {
      return {
        isActive: true,
        label: "En línea",
        color: "green",
        icon: "🟢",
      };
    }

    if (diffInMinutes < 30) {
      return {
        isActive: true,
        label: `Activo hace ${Math.round(diffInMinutes)} min`,
        color: "blue",
        icon: "🔵",
      };
    }

    if (diffInMinutes < 1440) {
      const hours = Math.floor(diffInMinutes / 60);
      return {
        isActive: false,
        label: `Inactivo hace ${hours}h`,
        color: "orange",
        icon: "🟠",
      };
    }

    const days = Math.floor(diffInMinutes / 1440);
    return {
      isActive: false,
      label: `Inactivo hace ${days} días`,
      color: "red",
      icon: "🔴",
    };
  };

  const formatLastConnection = (lastAccess) => {
    if (!lastAccess) {
      return { text: 'Nunca conectado', color: 'text-gray-500', bgColor: 'bg-gray-100', icon: '⚫', detail: 'Nunca ha iniciado sesión' };
    }

    const now = new Date();
    const lastDate = new Date(lastAccess);
    const diffMs = now - lastDate;
    const diffSeconds = Math.floor(diffMs / 1000);
    const diffMinutes = Math.floor(diffSeconds / 60);
    const diffHours = Math.floor(diffMinutes / 60);
    const diffDays = Math.floor(diffHours / 24);

    if (diffSeconds < 300) {
      return {
        text: 'Conectado ahora',
        color: 'text-green-700',
        bgColor: 'bg-green-100',
        icon: '🟢',
        detail: 'Activo en este momento'
      };
    }

    if (diffMinutes < 60) {
      return {
        text: `Conectado hace ${diffMinutes} minuto${diffMinutes !== 1 ? 's' : ''}`,
        color: 'text-green-600',
        bgColor: 'bg-green-50',
        icon: '🟢',
        detail: `Última actividad: hace ${diffMinutes} minutos`
      };
    }

    if (diffHours < 24) {
      return {
        text: `Conectado hace ${diffHours} hora${diffHours !== 1 ? 's' : ''}`,
        color: 'text-yellow-700',
        bgColor: 'bg-yellow-50',
        icon: '🟡',
        detail: `Última conexión: ${lastDate.toLocaleTimeString()}`
      };
    }

    if (diffDays === 1) {
      return {
        text: 'Conectado ayer',
        color: 'text-orange-600',
        bgColor: 'bg-orange-50',
        icon: '🟠',
        detail: `Última conexión: ${lastDate.toLocaleDateString()}`
      };
    }

    if (diffDays < 7) {
      return {
        text: `Conectado hace ${diffDays} día${diffDays !== 1 ? 's' : ''}`,
        color: 'text-orange-700',
        bgColor: 'bg-orange-50',
        icon: '🟠',
        detail: `Última conexión: ${lastDate.toLocaleDateString()}`
      };
    }

    if (diffDays < 30) {
      const semanas = Math.floor(diffDays / 7);
      return {
        text: `Conectado hace ${semanas} semana${semanas !== 1 ? 's' : ''}`,
        color: 'text-red-600',
        bgColor: 'bg-red-50',
        icon: '🔴',
        detail: `Última conexión: ${lastDate.toLocaleDateString()}`
      };
    }

    const meses = Math.floor(diffDays / 30);
    return {
      text: `Conectado hace ${meses} mes${meses !== 1 ? 'es' : ''}`,
      color: 'text-red-700',
      bgColor: 'bg-red-100',
      icon: '🔴',
      detail: `Última conexión: ${lastDate.toLocaleDateString()}`
    };
  };
  // 1. Análisis por Temas/Materias
  const analyzeStudentByTopic = async (studentId, courseId) => {
    try {
      const { data: progressData, error } = await supabase
        .from("progreso_estudiantes")
        .select(
          `
        *,
        recursos(
          titulo,
          tipo,
          tema,
          subtema,
          curso_id
        )
      `
        )
        .eq("usuario_id", studentId)
        .eq("recursos.curso_id", courseId);

      if (error) throw error;

      const topicAnalysis = {};

      progressData?.forEach((progress) => {
        const tema = progress.recursos?.tema || "General";
        const subtema = progress.recursos?.subtema || "Sin especificar";

        if (!topicAnalysis[tema]) {
          topicAnalysis[tema] = {
            subtemas: {},
            totalProgreso: 0,
            totalTiempo: 0,
            completados: 0,
            total: 0,
          };
        }

        if (!topicAnalysis[tema].subtemas[subtema]) {
          topicAnalysis[tema].subtemas[subtema] = {
            progreso: 0,
            tiempo: 0,
            completados: 0,
            total: 0,
            recursos: [],
          };
        }

        topicAnalysis[tema].subtemas[subtema].progreso +=
          progress.progreso || 0;
        topicAnalysis[tema].subtemas[subtema].tiempo +=
          progress.tiempo_dedicado || 0;
        if (progress.completado)
          topicAnalysis[tema].subtemas[subtema].completados++;
        topicAnalysis[tema].subtemas[subtema].total++;
        topicAnalysis[tema].subtemas[subtema].recursos.push(
          progress.recursos?.titulo
        );

        topicAnalysis[tema].totalProgreso += progress.progreso || 0;
        topicAnalysis[tema].totalTiempo += progress.tiempo_dedicado || 0;
        if (progress.completado) topicAnalysis[tema].completados++;
        topicAnalysis[tema].total++;
      });

      Object.keys(topicAnalysis).forEach((tema) => {
        topicAnalysis[tema].totalProgreso = Math.round(
          topicAnalysis[tema].totalProgreso / topicAnalysis[tema].total
        );
        topicAnalysis[tema].totalTiempo = Math.round(
          topicAnalysis[tema].totalTiempo / 60
        );
      });

      return topicAnalysis;
    } catch (err) {
      console.error("Error analizando temas:", err);
      return {};
    }
  };


  // 2. Exportar a Excel
  const exportReportToExcel = () => {
    if (!courseReportData) return;

    try {
      let csvRows = [];

      // Título
      csvRows.push(['"REPORTE DE CURSO"']);
      csvRows.push([`"Curso: ${courseReportData.course.titulo}"`]);
      csvRows.push([`"Nivel: ${courseReportData.course.nivel}"`]);
      csvRows.push([`"Fecha: ${courseReportData.course.fecha}"`]);
      csvRows.push([]);

      // Estadísticas
      csvRows.push(['"ESTADÍSTICAS GENERALES"']);
      csvRows.push([`"Total Estudiantes","${courseReportData.stats.totalStudents}"`]);
      csvRows.push([`"Progreso Promedio","${courseReportData.stats.avgProgress}%"`]);
      csvRows.push([`"Recursos Completados","${courseReportData.stats.completedResources}"`]);
      csvRows.push([`"Tiempo Total","${courseReportData.stats.totalTime} minutos"`]);
      csvRows.push([]);

      // Estudiantes
      csvRows.push(['"ANÁLISIS POR ESTUDIANTE"']);
      csvRows.push(['"Nombre"', '"Email"', '"Grupo"', '"Estado General"', '"Aprendizaje Real"', '"Confianza"', '"Atención"', '"Puntuación"', '"Fortalezas"', '"Áreas Mejora"']);

      courseReportData.students.forEach((data) => {
        const { student, feedback, grupo } = data;
        const escape = (text) => `"${String(text || '').replace(/"/g, '""')}"`;

        csvRows.push([
          escape(student.nombre),
          escape(student.email),
          escape(grupo),
          escape(feedback.overallStatus),
          escape(feedback.learningEffectiveness?.isLearning ? "Sí" : "No"),
          feedback.learningEffectiveness?.confidence?.toFixed(1) || 0,
          escape(feedback.attentionLevel?.level || "Sin datos"),
          feedback.attentionLevel?.score || 0,
          escape(feedback.strengths?.join("; ") || "N/A"),
          escape(feedback.weaknesses?.join("; ") || "N/A")
        ]);
      });

      const csvContent = csvRows.map(row => row.join(',')).join('\n');
      const blob = new Blob(['\uFEFF' + csvContent], { type: 'text/csv;charset=utf-8;' });
      const link = document.createElement('a');
      const url = URL.createObjectURL(blob);
      link.setAttribute('href', url);
      link.setAttribute('download', `Reporte_${courseReportData.course.titulo.replace(/[^a-z0-9]/gi, '_')}_${Date.now()}.csv`);
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);

      alert('✅ Reporte exportado a Excel correctamente');
    } catch (error) {
      console.error('Error:', error);
      alert('❌ Error al exportar: ' + error.message);
    }
  };

  // 3. Retroalimentación Avanzada
  const generateAdvancedFeedback = async (studentId, courseId) => {
    try {
      const learningAnalysis = await analyzeLearningEffectiveness(
        studentId,
        courseId
      );
      const attentionAnalysis = await analyzeAttentionLevel(
        studentId,
        courseId
      );
      const topicAnalysis = await analyzeStudentByTopic(studentId, courseId);

      const feedback = {
        studentId,
        courseId,
        timestamp: new Date().toISOString(),
        overallStatus: "En Progreso",
        learningEffectiveness: learningAnalysis,
        attentionLevel: attentionAnalysis,
        topicAnalysis: topicAnalysis,
        strengths: [],
        weaknesses: [],
        recommendations: [],
        teacherDecisions: [],
        actionPlan: [],
      };

      if (learningAnalysis?.isLearning && attentionAnalysis?.score >= 70) {
        feedback.overallStatus = "✅ Aprendizaje Efectivo";
        feedback.strengths.push("Demuestra comprensión real del contenido");
        feedback.strengths.push("Mantiene buena atención en clase");
      } else if (
        !learningAnalysis?.isLearning ||
        attentionAnalysis?.score < 30
      ) {
        feedback.overallStatus = "🚨 Requiere Intervención Urgente";
        feedback.teacherDecisions.push(
          "📋 PRIORITARIO: Reunión con estudiante para diagnosticar dificultades"
        );
        feedback.teacherDecisions.push("👥 Activar plan de apoyo pedagógico");
      } else {
        feedback.overallStatus = "⚠️ Necesita Apoyo";
      }

      Object.entries(topicAnalysis).forEach(([tema, datos]) => {
        if (datos.totalProgreso < 40) {
          feedback.weaknesses.push(
            `🎯 Dificultad en tema: ${tema} (${datos.totalProgreso}%)`
          );
          feedback.recommendations.push(`📚 Refuerzo recomendado: ${tema}`);
          feedback.teacherDecisions.push(
            `🔍 Evaluar: ${tema} - necesita intervención`
          );
        } else if (datos.totalProgreso > 80) {
          feedback.strengths.push(
            `✨ Destaca en: ${tema} (${datos.totalProgreso}%)`
          );
          feedback.teacherDecisions.push(
            `⭐ Considerar actividades avanzadas: ${tema}`
          );
        }
      });

      if (
        attentionAnalysis?.score < 50 &&
        learningAnalysis?.indicators?.averageAttempts > 3
      ) {
        feedback.teacherDecisions.push(
          "💡 Cambiar estrategia de enseñanza - demasiados intentos fallidos"
        );
        feedback.teacherDecisions.push(
          "🎮 Incluir elementos lúdicos para mejorar compromiso"
        );
      }

      if (attentionAnalysis?.score >= 70 && learningAnalysis?.isLearning) {
        feedback.teacherDecisions.push(
          "🚀 Proponer desafíos avanzados para mantener motivación"
        );
        feedback.teacherDecisions.push("🏆 Reconocer logros públicamente");
      }

      if (feedback.weaknesses.length > 0) {
        feedback.actionPlan.push(
          "📝 Evaluación diagnóstica adicional de áreas débiles"
        );
        feedback.actionPlan.push("👥 Trabajo colaborativo en grupos pequeños");
        feedback.actionPlan.push("🎯 Establecer metas específicas por tema");
        feedback.actionPlan.push("📊 Monitoreo semanal del progreso");
      }

      return feedback;
    } catch (err) {
      console.error("Error generando retroalimentación:", err);
      return null;
    }
  };

  const questionTypes = [
    {
      value: "multiple",
      label: "Opción Múltiple",
      icon: HelpCircle,
      color: "#3B82F6",
    },
    {
      value: "verdadero_falso",
      label: "Verdadero/Falso",
      icon: CheckCircle,
      color: "#10B981",
    },
    {
      value: "imagen",
      label: "Selección de Imagen",
      icon: Image,
      color: "#8B5CF6",
    },
    {
      value: "audio",
      label: "Escucha y Responde",
      icon: Headphones,
      color: "#EC4899",
    },
    { value: "video", label: "Video Pregunta", icon: Video, color: "#F59E0B" },
    {
      value: "completar",
      label: "Completar Frase",
      icon: Edit2,
      color: "#EF4444",
    },
  ];

  const emojis = [
    // Formas geométricas
    "🔴", "🔵", "🟡", "🟢", "🟣", "🟠", "⭕", "📍",
    // Figuras
    "▶️", "⏹️", "✂️", "✏️", "🎯", "🎪", "🎨", "🎭",
    // Animales
    "🦁", "🐘", "🦒", "🐼", "🦊", "🐶", "🐱", "🐭",
    "🦆", "🦉", "🦅", "🦜", "🐢", "🐟", "🦀", "🦑",
    // Comida
    "🍎", "🍊", "🍋", "🍌", "🍓", "🥕", "🌽", "🍕",
    "🍔", "🍟", "🍗", "🍖", "🥩", "🧀", "🥛", "🍯",
    // Números y símbolos
    "🔢", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣",
    "8️⃣", "9️⃣", "0️⃣", "✅", "❌", "➕", "➖", "✖️",
    // Letras
    "🅰️", "🅱️", "🆎", "🅾️", "Ⓜ️", "♈️", "♉️", "♊️",
    // Transportes
    "🚀", "🛸", "🚁", "✈️", "🚂", "🚃", "🚄", "🚅",
    "🚗", "🚕", "🚙", "🚌", "🚎", "🚐", "🚚", "🚛",
    "🚜", "⛵", "🚤", "🛥️", "🛳️", "⛴️", "🚢", "⛽",
    // Deportes
    "⚽", "🏀", "🏈", "⚾", "🥎", "🎾", "🏐", "🏉",
    "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍",
    // Profesiones
    "👨‍⚕️", "👩‍⚕️", "👨‍🌾", "👩‍🌾", "👨‍🏫", "👩‍🏫", "👨‍🍳", "👩‍🍳",
    // Objetos educativos
    "📚", "📖", "📝", "✏️", "📐", "📏", "📊", "📈",
    "🎓", "🧮", "🔭", "🔬", "⚗️", "🧪", "🧬", "🔍",
    // Naturaleza
    "🌳", "🌲", "🌴", "🌵", "🌾", "🌿", "☘️", "🍀",
    "🎄", "🌱", "🌲", "🌳", "⛅", "🌤️", "⛈️", "🌈",
    // Diversión
    "🎉", "🎊", "🎈", "🎀", "🎁", "🎂", "🍰", "🎆",
    "🎇", "🎃", "🎄", "🎀", "🎗️", "🏆", "🥇", "🥈",
  ];

  const availableRoles = [
    { value: "admin", label: "Admin", color: "red" },
    { value: "docente", label: "Docente", color: "blue" },
    { value: "estudiante", label: "Estudiante", color: "green" },
    { value: "visitante", label: "Visitante", color: "gray" },
  ];

  const contentTypes = [
    {
      id: 'quiz',
      name: 'Quiz Interactivo',
      icon: '❓',
      description: 'Preguntas coloridas con emojis y retroalimentación inmediata',
      color: 'from-blue-500 to-cyan-500',
      bgColor: 'from-blue-50 to-cyan-50',
      prompt: 'Crea un quiz visualmente atractivo sobre...',
      examples: ['animales', 'números', 'colores', 'formas', 'letras']
    },
    {
      id: 'game',
      name: 'Juego Educativo',
      icon: '🎮',
      description: 'Juegos interactivos con mecánicas divertidas',
      color: 'from-purple-500 to-pink-500',
      bgColor: 'from-purple-50 to-pink-50',
      prompt: 'Crea un juego educativo divertido sobre...',
      examples: ['persecución', 'rompecabezas', 'memoria', 'carreras']
    },
    {
      id: 'exercise',
      name: 'Ejercicios Prácticos',
      icon: '📝',
      description: 'Actividades con instrucciones claras y ejemplos visuales',
      color: 'from-green-500 to-emerald-500',
      bgColor: 'from-green-50 to-emerald-50',
      prompt: 'Crea 10 ejercicios prácticos con ejemplos visuales sobre...',
      examples: ['sumas', 'restas', 'lectura', 'escritura', 'pronunciación']
    },
    {
      id: 'story',
      name: 'Historia Educativa',
      icon: '📖',
      description: 'Historias coloridas con personajes, diálogos e ilustraciones',
      color: 'from-orange-500 to-yellow-500',
      bgColor: 'from-orange-50 to-yellow-50',
      prompt: 'Crea una historia educativa ilustrada sobre...',
      examples: ['aventuras', 'amistad', 'naturaleza', 'descubrimiento', 'magia']
    },
    {
      id: 'challenge',
      name: 'Desafío Semanal',
      icon: '⚡',
      description: 'Retos emocionantes con recompensas y logros',
      color: 'from-red-500 to-pink-500',
      bgColor: 'from-red-50 to-pink-50',
      prompt: 'Crea un desafío emocionante y educativo sobre...',
      examples: ['búsqueda del tesoro', 'misiones', 'competencia', 'aventura']
    }
  ];

  useEffect(() => {
    checkAuthAndRole();
  }, []);

  useEffect(() => {
    if (!currentUser) return;

    const path = window.location.pathname;
    let currentRole = 'admin';

    if (path.includes('/teacher')) {
      currentRole = 'docente';
    } else if (path.includes('/student')) {
      currentRole = 'estudiante';
    }

    const allRoles = [currentUser.rol, ...(currentUser.roles_adicionales || [])];
    if (allRoles.includes(currentRole)) {
      setActiveRoleView(currentRole);
      localStorage.setItem(`activeRole_${currentUser.id}`, currentRole);
      console.log('✅ Rol activo detectado desde URL:', currentRole);
    } else {
      setActiveRoleView(currentUser.rol);
      localStorage.setItem(`activeRole_${currentUser.id}`, currentUser.rol);
    }
  }, [currentUser]);

  useEffect(() => {
    const initializeData = async () => {
      if (currentUser && initialLoad) {
        setLoading(true);
        await loadAllData();
        await loadContentLibrary();
        await calculateAdvancedAnalytics();
        setInitialLoad(false);
        setLoading(false);
      }
    };
    initializeData();
  }, [currentUser, initialLoad]);

  useEffect(() => {
    fixMobileTouch();
  }, []);

  useEffect(() => {
    const initializeData = async () => {
      if (currentUser) {
        await loadAllData();
        await loadContentLibrary();
        await calculateAdvancedAnalytics();
      }
    };
    initializeData();
  }, [currentUser]);

  useEffect(() => {
    if (users.length > 0 && courses.length > 0) {
      calculateAdvancedAnalytics();
    }
  }, [users, courses, resources]);

  useEffect(() => {
    if (!currentUser?.id) return;

    console.log("🔄 Iniciando actualización de último acceso...");

    const updateLastAccess = async () => {
      try {
        const now = new Date().toISOString();
        const { error } = await supabase
          .from("usuarios")
          .update({ ultimo_acceso: now })
          .eq("id", currentUser.id);

        if (error) {
          console.error("❌ Error en updateLastAccess:", error);
        } else {
          console.log("✅ Último acceso actualizado:", now);
        }
      } catch (err) {
        console.error("❌ Error:", err);
      }
    };

    // Actualizar inmediatamente
    updateLastAccess();

    // Actualizar cada 30 segundos (no cada 10)
    const interval = setInterval(updateLastAccess, 30000);

    return () => clearInterval(interval);
  }, [currentUser]);



  const checkAuthAndRole = async () => {
    try {
      const {
        data: { session },
        error: sessionError,
      } = await supabase.auth.getSession();
      if (sessionError || !session) {
        navigate("/login");
        return;
      }
      await new Promise((resolve) => setTimeout(resolve, 500));
      const { data: userData, error: userError } = await supabase
        .from("usuarios")
        .select("*")
        .eq("auth_id", session.user.id)
        .single();
      if (userError || !userData) {
        setError("No se pudo obtener la información del usuario");
        setTimeout(() => navigate("/login"), 2000);
        return;
      }

      setCurrentUser(userData);
    } catch (err) {
      console.error("❌ Error de autenticación:", err);
      setError("Error de autenticación: " + err.message);
    }
  };

  // ✅ VALIDACIÓN DE ACCESO (SIN BUCLE INFINITO)
  useEffect(() => {
    if (!currentUser || !activeRoleView) {
      return;
    }

    // Obtener TODOS los roles del usuario
    const allRoles = [currentUser.rol, ...(currentUser.roles_adicionales || [])].filter(
      (rol, index, self) => self.indexOf(rol) === index
    );

    // Validar que el activeRoleView sea válido
    if (!allRoles.includes(activeRoleView)) {
      setActiveRoleView(currentUser.rol);
      localStorage.removeItem(`activeRole_${currentUser.id}`);
      return;
    }
    console.log("✅ Rol validado:", activeRoleView);

  }, [currentUser, activeRoleView]);


  const confirmRoleSwitch = async () => {
    if (!reauthPassword.trim()) {
      setReauthError("❌ Debes ingresar tu contraseña");
      return;
    }

    if (!targetRole) {
      setReauthError("❌ No se seleccionó rol");
      return;
    }

    setReauthLoading(true);
    setReauthError(null);

    try {
      const { error } = await supabase.auth.signInWithPassword({
        email: currentUser.email,
        password: reauthPassword,
      });

      if (error) {
        setReauthError("❌ Contraseña incorrecta");
        setReauthLoading(false);
        return;
      }

      const allRoles = [currentUser.rol, ...(currentUser.roles_adicionales || [])];
      if (!allRoles.includes(targetRole)) {
        setReauthError("❌ No tienes acceso a este rol");
        setReauthLoading(false);
        return;
      }

      // ✅ GUARDAR el rol antes de navegar
      localStorage.setItem(`activeRole_${currentUser.id}`, targetRole);

      // ✅ Cerrar modal primero
      setShowReauthModal(false);
      setReauthPassword("");
      setReauthError(null);
      setMenuOpen(false);

      // ✅ RUTAS CORRECTAS según App.jsx
      const routes = {
        admin: "/admin",
        docente: "/teacher",
        estudiante: "/student"
      };

      console.log(`🔄 Cambiando a rol: ${targetRole}`);
      console.log(`🚀 Navegando a: ${routes[targetRole] || "/"}`);

      // Navegar inmediatamente
      const targetRoute = routes[targetRole] || "/";
      navigate(targetRoute, { replace: true });

      // Resetear estado después de navegar
      setTargetRole(null);

    } catch (error) {
      setReauthError(`❌ Error: ${error.message}`);
    } finally {
      setReauthLoading(false);
    }
  };

  const renderContentPreview = () => {
    if (!editingGeneratedQuiz) return null;

    // Extraer preguntas del contenido generado
    const questions = editingGeneratedQuiz.preguntas ||
      editingGeneratedQuiz.content?.questions || [];

    if (questions.length === 0) {
      return (
        <div className="fixed inset-0 bg-black bg-opacity-60 z-[60] flex items-center justify-center p-4">
          <div className="bg-white rounded-3xl p-8 max-w-md text-center shadow-2xl">
            <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
            <h3 className="text-xl font-bold text-gray-800 mb-2">No hay preguntas</h3>
            <p className="text-gray-600 mb-4">Este quiz no tiene preguntas para mostrar</p>
            <button
              onClick={() => {
                setShowContentPreview(false);
                setEditingGeneratedQuiz(null);
                setQuizPreviewIndex(0);
                setQuizPreviewAnswers({});
                setAttemptCount({});
              }}
              className="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-xl font-bold transition-all"
            >
              Cerrar
            </button>
          </div>
        </div>
      );
    }

    const currentQuestion = questions[quizPreviewIndex];
    if (!currentQuestion) return null;

    // Normalizar pregunta para usar la misma estructura
    const normalizedQuestion = {
      pregunta: currentQuestion.pregunta || currentQuestion.text || '',
      opciones: currentQuestion.opciones || currentQuestion.options || [],
      respuesta_correcta: currentQuestion.respuesta_correcta ?? currentQuestion.correct ?? 0,
      puntos: currentQuestion.puntos || currentQuestion.points || 10,
      retroalimentacion_correcta: currentQuestion.retroalimentacion_correcta ||
        currentQuestion.feedback_correct ||
        '¡Excelente! 🎉',
      retroalimentacion_incorrecta: currentQuestion.retroalimentacion_incorrecta ||
        currentQuestion.feedback_incorrect ||
        '¡Intenta otra vez! 💪',
      audio_pregunta: currentQuestion.audio_pregunta !== false,
      audio_retroalimentacion: currentQuestion.audio_retroalimentacion !== false,
      video_url: currentQuestion.video_url || '',
      imagen_url: currentQuestion.imagen_url || currentQuestion.image_url || '',
      imagen_opciones: currentQuestion.imagen_opciones || currentQuestion.image_options || [],
      tiempo_limite: currentQuestion.tiempo_limite ?? currentQuestion.timeLimit ?? 0,
    };

    const answer = quizPreviewAnswers[quizPreviewIndex];
    const attempts = attemptCount[quizPreviewIndex] || 0;
    const maxAttempts = 3;

    const handleImmediateAnswer = async (selectedIdx) => {
      if (answer?.isCorrect || attempts >= maxAttempts) return;

      const isCorrect = selectedIdx === normalizedQuestion.respuesta_correcta;
      const newAttempts = attempts + 1;

      // Calcular el progreso actual basado en respuestas correctas
      const respuestasTemp = { ...previewAnswers, [currentPreviewQuestion]: { isCorrect } };
      const correctas = Object.values(respuestasTemp).filter(a => a?.isCorrect).length;
      const nuevoProgreso = Math.round((correctas / currentQuiz.preguntas.length) * 100);

      // Usar el estudiante real (si eres admin, necesitas un ID de estudiante)
      const userId = currentUser?.rol === 'estudiante' ? currentUser.id : null;
      if (userId && selectedResource?.id) {
        try {
          const { data: existing } = await supabase
            .from('progreso_estudiantes')
            .select('id')
            .eq('usuario_id', userId)
            .eq('recurso_id', selectedResource.id)
            .maybeSingle();

          if (existing) {
            await supabase
              .from('progreso_estudiantes')
              .update({ progreso: nuevoProgreso, intentos: newAttempts, updated_at: new Date() })
              .eq('id', existing.id);
          } else {
            await supabase
              .from('progreso_estudiantes')
              .insert({
                usuario_id: userId,
                recurso_id: selectedResource.id,
                progreso: nuevoProgreso,
                intentos: newAttempts,
                iniciado_en: new Date()  // ← necesario para trigger de tiempo
              });
          }
        } catch (err) {
          console.error("Error guardando progreso:", err);
        }
      }

      // Actualizar el estado local (intentos, respuestas, etc.)
      setAttemptCount({ ...attemptCount, [currentPreviewQuestion]: newAttempts });
      const newAnswer = {
        selected: selectedIdx,
        isCorrect: isCorrect,
        attempts: newAttempts,
        showCorrect: newAttempts >= maxAttempts && !isCorrect
      };
      setPreviewAnswers({ ...previewAnswers, [currentPreviewQuestion]: newAnswer });

      // Retroalimentación por voz (igual que antes)
      setTimeout(() => {
        if (isCorrect) {
          speakText("¡Correcto! " + normalizedQuestion.retroalimentacion_correcta);
          setTimeout(() => {
            speakText(`La pregunta era: ${normalizedQuestion.pregunta}. La respuesta correcta es: ${normalizedQuestion.opciones[normalizedQuestion.respuesta_correcta]}`);
          }, 1500);
        } else if (newAttempts >= maxAttempts) {
          speakText(`Lo siento, te has equivocado ${maxAttempts} veces. La respuesta correcta es: ${normalizedQuestion.opciones[normalizedQuestion.respuesta_correcta]}`);
        } else {
          const remaining = maxAttempts - newAttempts;
          speakText(`Lo siento, te has equivocado. Te quedan ${remaining} intentos. Intenta de nuevo.`);
        }
      }, 1000);
    };
    // Determinar estado de Karin
    const getKarinState = () => {
      if (answer?.isCorrect) {
        return {
          state: "happy",
          message: "¡Excelente! Respuesta correcta 🎉",
        };
      }
      if (answer && !answer.isCorrect && attempts >= maxAttempts) {
        return {
          state: "encourage",
          message: "No te preocupes, sigamos aprendiendo 💚",
        };
      }
      if (attempts > 0 && attempts < maxAttempts) {
        const remaining = maxAttempts - attempts;
        return {
          state: "thinking",
          message: `Te quedan ${remaining} intentos. ¡Tú puedes! 💪`,
        };
      }
      return {
        state: "idle",
        message: "Escucha la pregunta y elige la respuesta correcta",
      };
    };

    // Función para repetir pregunta y opciones
    const repeatQuestionWithOptions = () => {
      let fullText = `La pregunta es: ${normalizedQuestion.pregunta}. `;
      fullText += `Las opciones son: `;
      normalizedQuestion.opciones.forEach((opcion, idx) => {
        fullText += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
      });
      speakText(fullText);
    };

    const karin = getKarinState();

    return (
      <div className="fixed inset-0 bg-black bg-opacity-70 z-[60] flex items-center justify-center p-4 overflow-y-auto">
        <div className="bg-white rounded-3xl max-w-6xl w-full max-h-[95vh] overflow-hidden shadow-2xl">
          {/* HEADER - YA ES AZUL, ESTÁ CORRECTO */}
          <div className="sticky top-0 z-10 bg-gradient-to-r from-blue-600 to-blue-500 text-white p-6">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-2xl font-black flex items-center gap-2">
                  👁️ Vista Previa del Quiz
                </h2>
                <p className="text-blue-100 text-sm mt-1">
                  {editingGeneratedQuiz.title || 'Quiz generado con IA'}
                </p>
              </div>
              <button
                onClick={() => {
                  setShowContentPreview(false);
                  setEditingGeneratedQuiz(null);
                  setQuizPreviewIndex(0);
                  setQuizPreviewAnswers({});
                  setAttemptCount({});
                }}
                className="bg-white bg-opacity-20 hover:bg-opacity-30 p-3 rounded-xl transition-all"
              >
                <X className="w-6 h-6" />
              </button>
            </div>
          </div>

          {/* CONTENIDO IDÉNTICO AL DE RECURSOS */}
          <div className="p-6 overflow-y-auto max-h-[calc(95vh-200px)]">
            <div className="bg-[#F7F9FC] rounded-3xl p-6 min-h-[600px] flex flex-col">
              {/* HEADER: KARIN + PROGRESO */}
              <div className="flex justify-between items-start mb-6">
                <KarinMascot state={karin.state} message={karin.message} />
                <div className="bg-white rounded-full px-5 py-2 shadow-sm border text-sm font-bold">
                  {quizPreviewIndex + 1} / {questions.length}
                </div>
              </div>

              {/* BARRA DE PROGRESO */}
              <div className="flex gap-2 mb-8">
                {questions.map((_, idx) => (
                  <div
                    key={idx}
                    className={`flex-1 h-2 rounded-full transition-all ${idx === quizPreviewIndex
                      ? "bg-blue-500"
                      : idx < quizPreviewIndex
                        ? "bg-green-400"
                        : "bg-gray-200"
                      }`}
                  />
                ))}
              </div>

              {/* CONTADOR DE INTENTOS */}
              {attempts > 0 && (
                <div className="bg-yellow-100 border-2 border-yellow-300 rounded-xl p-4 mb-4 text-center">
                  <p className="text-lg font-bold text-yellow-800">
                    🎯 Intentos: {attempts} / {maxAttempts}
                  </p>
                  <div className="flex gap-2 justify-center mt-2">
                    {[...Array(maxAttempts)].map((_, i) => (
                      <div
                        key={i}
                        className={`w-8 h-8 rounded-full ${i < attempts
                          ? answer?.isCorrect ? 'bg-green-400' : 'bg-red-400'
                          : 'bg-gray-300'
                          }`}
                      />
                    ))}
                  </div>
                </div>
              )}

              {/* PREGUNTA */}
              <div className="bg-white rounded-3xl shadow-sm p-8 mb-8 border">
                <div className="flex items-center gap-4 justify-center">
                  {normalizedQuestion.audio_pregunta && (
                    <button
                      onClick={() => speakText(normalizedQuestion.pregunta)}
                      className="bg-blue-500 hover:bg-blue-600 text-white p-4 rounded-full transition shadow-md hover:shadow-lg"
                    >
                      🔊
                    </button>
                  )}
                  <p className="text-3xl font-bold text-gray-800 text-center flex-1">
                    {normalizedQuestion.pregunta}
                  </p>
                </div>
                <div className="mt-6 text-center">
                  <button
                    onClick={repeatQuestionWithOptions}
                    className="bg-blue-100 hover:bg-blue-200 text-blue-800 px-6 py-3 rounded-xl font-bold flex items-center gap-2 mx-auto transition-all hover:scale-105"
                  >
                    <RefreshCw className="w-5 h-5" />
                    Repetir Pregunta y Opciones
                  </button>
                </div>
              </div>

              {/* OPCIONES CON BOTÓN DE REPETIR */}
              <div className="grid grid-cols-1 gap-4 max-w-3xl mx-auto w-full">
                {normalizedQuestion.opciones.map((opcion, idx) => {
                  const isSelected = answer?.selected === idx;
                  const isCorrectOption = idx === normalizedQuestion.respuesta_correcta;
                  const showAsCorrect = answer?.showCorrect && isCorrectOption;
                  const isDisabled = answer?.isCorrect || attempts >= maxAttempts;
                  const emojiOpcion = normalizedQuestion.imagen_opciones?.[idx] || ['🅰️', '🅱️', '🅲️', '🅳️'][idx];

                  return (
                    <div
                      key={idx}
                      className={`relative p-5 rounded-2xl text-xl font-semibold border transition-all flex items-center gap-4 ${showAsCorrect
                        ? 'bg-green-50 border-green-400 ring-4 ring-green-200'
                        : isDisabled && answer?.isCorrect && isSelected
                          ? 'bg-green-100 border-green-500 ring-4 ring-green-200'
                          : isDisabled && !isCorrectOption
                            ? 'bg-gray-100 border-gray-300 opacity-50'
                            : isSelected && !answer?.isCorrect
                              ? 'bg-red-100 border-red-400 ring-4 ring-red-200'
                              : 'bg-white border-gray-300 hover:bg-blue-50 hover:border-blue-400'
                        }`}
                    >
                      {/* BOTÓN REPETIR PALABRA (IZQUIERDA) */}
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          speakText(`La opción ${String.fromCharCode(65 + idx)} dice: ${opcion}`);
                        }}
                        className="absolute -left-12 top-1/2 transform -translate-y-1/2 bg-blue-100 hover:bg-blue-200 text-blue-800 p-3 rounded-full flex-shrink-0 z-10"
                        title="Repetir esta palabra"
                      >
                        <Volume2 className="w-6 h-6" />
                      </button>

                      {/* CONTENIDO DE LA OPCIÓN */}
                      <div
                        className="flex-1 flex items-center gap-4 cursor-pointer"
                        onClick={() => handleImmediateAnswer(idx)}
                      >
                        <span className="text-5xl flex-shrink-0 drop-shadow-sm">
                          {emojiOpcion}
                        </span>
                        <span className="flex-1">{opcion}</span>
                      </div>

                      {/* BOTÓN REPETIR PALABRA (DERECHA) */}
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          speakText(opcion);
                        }}
                        className="bg-blue-100 hover:bg-blue-200 text-blue-800 p-3 rounded-full flex-shrink-0 ml-2"
                        title="Repetir palabra"
                      >
                        <Volume2 className="w-6 h-6" />
                      </button>

                      {/* INDICADORES DE RESPUESTA */}
                      {showAsCorrect && (
                        <span className="text-3xl animate-bounce flex-shrink-0 ml-2">
                          ✅
                        </span>
                      )}
                      {isSelected && answer?.isCorrect && (
                        <span className="text-3xl animate-bounce flex-shrink-0 ml-2">
                          🎉
                        </span>
                      )}
                      {isSelected && !answer?.isCorrect && (
                        <span className="text-3xl flex-shrink-0 ml-2">
                          ❌
                        </span>
                      )}
                    </div>
                  );
                })}
              </div>

              {/* RETROALIMENTACIÓN */}
              {answer && (
                <div className="mt-8 max-w-2xl mx-auto w-full space-y-4 animate-fadeIn">
                  <div className={`rounded-2xl p-6 text-center border-4 shadow-2xl ${answer.isCorrect
                    ? "bg-green-100 border-green-400 animate-pulse"
                    : attempts >= maxAttempts
                      ? "bg-orange-100 border-orange-400"
                      : "bg-red-100 border-red-400"
                    }`}>
                    <p className="text-5xl font-black mb-3">
                      {answer.isCorrect ? "🎉" : attempts >= maxAttempts ? "💡" : "💪"}
                    </p>
                    <p className="text-3xl font-black mb-2">
                      {answer.isCorrect
                        ? "¡CORRECTO!"
                        : attempts >= maxAttempts
                          ? "VAMOS A APRENDER"
                          : "¡INTENTA DE NUEVO!"}
                    </p>
                    <p className="text-lg font-bold text-gray-800 mb-4">
                      {answer.isCorrect
                        ? normalizedQuestion.retroalimentacion_correcta
                        : attempts >= maxAttempts
                          ? `La respuesta correcta es: ${normalizedQuestion.opciones[normalizedQuestion.respuesta_correcta]}`
                          : `Lo siento, te has equivocado. Te quedan ${maxAttempts - attempts} intentos.`}
                    </p>
                  </div>

                  {/* BOTÓN SIGUIENTE */}
                  <button
                    onClick={() => {
                      if (quizPreviewIndex < questions.length - 1) {
                        setQuizPreviewIndex(quizPreviewIndex + 1);
                        // Resetear estados para la siguiente pregunta
                        setQuizPreviewAnswers({
                          ...quizPreviewAnswers,
                          [quizPreviewIndex + 1]: undefined
                        });
                        setAttemptCount({
                          ...attemptCount,
                          [quizPreviewIndex + 1]: 0
                        });
                      } else {
                        // FIN DEL QUIZ
                        const correct = Object.values(quizPreviewAnswers).filter(a => a?.isCorrect).length;
                        const totalQuestions = questions.length;
                        const score = Math.round((correct / totalQuestions) * 100);

                        let message = `🎉 ¡QUIZ COMPLETADO!\n\n`;
                        message += `Total de preguntas: ${totalQuestions}\n`;
                        message += `Correctas: ${correct}\n`;
                        message += `Puntuación: ${score}%\n\n`;

                        if (score >= 80) {
                          message += "¡Excelente trabajo! Eres un experto 🏆";
                        } else if (score >= 60) {
                          message += "Buen trabajo, sigue practicando 💪";
                        } else {
                          message += "Sigue practicando, aprenderás más cada día 📚";
                        }

                        alert(message);
                        setShowContentPreview(false);
                        setEditingGeneratedQuiz(null);
                        setQuizPreviewIndex(0);
                        setQuizPreviewAnswers({});
                        setAttemptCount({});
                      }
                    }}
                    className="w-full bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white py-4 rounded-2xl text-xl font-bold transition transform hover:scale-105 flex items-center justify-center gap-2"
                  >
                    {quizPreviewIndex === questions.length - 1 ? (
                      <>
                        <Trophy className="w-6 h-6" />
                        Finalizar Quiz
                      </>
                    ) : (
                      <>
                        <ChevronRight className="w-6 h-6" />
                        Siguiente Pregunta
                      </>
                    )}
                  </button>
                </div>
              )}

              {/* NAVEGACIÓN */}
              <div className="flex justify-between mt-10 gap-4">
                <button
                  disabled={quizPreviewIndex === 0}
                  onClick={() => {
                    setQuizPreviewIndex(quizPreviewIndex - 1);
                    // Resetear estados para la pregunta anterior
                    setQuizPreviewAnswers({
                      ...quizPreviewAnswers,
                      [quizPreviewIndex - 1]: undefined
                    });
                    setAttemptCount({
                      ...attemptCount,
                      [quizPreviewIndex - 1]: 0
                    });
                  }}
                  className="flex-1 py-3 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-xl font-bold disabled:opacity-40"
                >
                  ← Anterior
                </button>

                {answer?.isCorrect || attempts >= maxAttempts ? (
                  <button
                    onClick={() => {
                      if (quizPreviewIndex < questions.length - 1) {
                        setQuizPreviewIndex(quizPreviewIndex + 1);
                        // Resetear estados para la siguiente pregunta
                        setQuizPreviewAnswers({
                          ...quizPreviewAnswers,
                          [quizPreviewIndex + 1]: undefined
                        });
                        setAttemptCount({
                          ...attemptCount,
                          [quizPreviewIndex + 1]: 0
                        });
                      } else {
                        // FIN DEL QUIZ
                        const correct = Object.values(quizPreviewAnswers).filter(a => a?.isCorrect).length;
                        const totalQuestions = questions.length;
                        const score = Math.round((correct / totalQuestions) * 100);

                        let message = `🎉 ¡QUIZ COMPLETADO!\n\n`;
                        message += `Total de preguntas: ${totalQuestions}\n`;
                        message += `Correctas: ${correct}\n`;
                        message += `Puntuación: ${score}%\n\n`;

                        if (score >= 80) {
                          message += "¡Excelente trabajo! Eres un experto 🏆";
                        } else if (score >= 60) {
                          message += "Buen trabajo, sigue practicando 💪";
                        } else {
                          message += "Sigue practicando, aprenderás más cada día 📚";
                        }

                        alert(message);
                        setShowContentPreview(false);
                        setEditingGeneratedQuiz(null);
                        setQuizPreviewIndex(0);
                        setQuizPreviewAnswers({});
                        setAttemptCount({});
                      }
                    }}
                    className="flex-1 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-bold flex items-center justify-center gap-2"
                  >
                    {quizPreviewIndex === questions.length - 1 ? (
                      <>
                        <Trophy className="w-6 h-6" />
                        Finalizar Quiz
                      </>
                    ) : (
                      <>
                        Siguiente →
                      </>
                    )}
                  </button>
                ) : (
                  <button
                    disabled={quizPreviewIndex === questions.length - 1}
                    onClick={() => {
                      setQuizPreviewIndex(quizPreviewIndex + 1);
                      // Resetear estados para la siguiente pregunta
                      setQuizPreviewAnswers({
                        ...quizPreviewAnswers,
                        [quizPreviewIndex + 1]: undefined
                      });
                      setAttemptCount({
                        ...attemptCount,
                        [quizPreviewIndex + 1]: 0
                      });
                    }}
                    className="flex-1 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-bold disabled:opacity-40"
                  >
                    Saltar Pregunta →
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  };

  const loadAllData = async () => {
    setLoading(true);
    await Promise.all([
      fetchUsers(),
      fetchLevels(),
      fetchCourses(),
      fetchResources(),
      fetchAchievements(),
      fetchGroups(),
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
        .from("usuarios")
        .select("*")
        .order("created_at", { ascending: false });

      if (error) throw error;
      setUsers(data || []);
    } catch (err) {
      console.error("Error cargando usuarios:", err);
      setError("Error al cargar usuarios");
    }
  };

  const fetchGroups = async () => {
    try {
      const { data, error } = await supabase
        .from("grupos")
        .select("*")
        .order("nombre", { ascending: true });

      if (error) throw error;
      setGroups(data || []);
    } catch (err) {
      console.error("Error cargando grupos:", err);
    }
  };

  const fetchLevels = async () => {
    try {
      const { data, error } = await supabase
        .from("niveles_aprendizaje")
        .select("*")
        .order("orden", { ascending: true });

      if (error) throw error;
      setLevels(data || []);
    } catch (err) {
      console.error("Error cargando niveles:", err);
    }
  };

  const fetchCourses = async () => {
    try {
      const { data, error } = await supabase
        .from("cursos")
        .select(`*, niveles_aprendizaje(nombre)`)
        .eq("activo", true)
        .order("orden", { ascending: true });

      if (error) throw error;

      const coursesData =
        data?.map((course) => ({
          ...course,
          nivel_nombre: course.niveles_aprendizaje?.nombre || "Sin nivel",
        })) || [];

      setCourses(coursesData);
    } catch (err) {
      console.error("Error cargando cursos:", err);
    }
  };

  const fetchResources = async () => {
    try {
      console.log("📚 Cargando recursos reales...");

      // Contar recursos ACTIVOS (no todos)
      const { data: recursosData, error, count } = await supabase
        .from("recursos")
        .select("*", { count: 'exact', head: false })
        .eq("activo", true);  // 👈 CLAVE: solo activos

      if (error) throw error;

      console.log(`📊 Recursos encontrados: ${recursosData?.length || 0}`);

      // Mostrar en consola los recursos reales
      if (recursosData && recursosData.length > 0) {
        console.log("📋 Lista de recursos reales:");
        recursosData.forEach(r => {
          console.log(`   - ${r.titulo} (${r.tipo})`);
        });
      }

      setResources(recursosData || []);

    } catch (err) {
      console.error("❌ Error cargando recursos:", err);
      setResources([]);
    }
  };

  const fetchAchievements = async () => {
    try {
      const { data, error } = await supabase
        .from("logros")
        .select("*")
        .eq("activo", true);

      if (error) throw error;
      setAchievements(data || []);
    } catch (err) {
      console.error("Error cargando logros:", err);
    }
  };

  // Cargar biblioteca de contenido generado
  // ========== MEJORAR loadContentLibrary ==========
  const loadContentLibrary = async () => {
    if (!currentUser?.auth_id) return;
    try {
      const { data, error } = await supabase
        .from('contenido_generado')
        .select('*')
        .eq('created_by', currentUser.auth_id)
        .order('created_at', { ascending: false });

      if (error) throw error;

      const formatted = (data || []).map(item => ({
        id: item.id,
        type: item.type,
        prompt: item.prompt,
        title: item.title,
        createdAt: new Date(item.created_at).toLocaleString('es-ES'),
        content: item.content,
        status: item.status,
      }));
      setContentLibrary(formatted);
    } catch (err) {
      console.warn('Error cargando biblioteca:', err);
      setContentLibrary([]);
    }
  };

  // FUNCIÓN 1: Calcular Tiempo Promedio (CORREGIDA)

  const calculateAvgTimePerResource = async () => {
    try {
      console.log("⏱️ Calculando tiempo promedio...");

      const { data, error } = await supabase
        .from("progreso_estudiantes")
        .select("tiempo_dedicado")
        .gt("tiempo_dedicado", 0)
        .not("tiempo_dedicado", "is", null)
        .lt("tiempo_dedicado", 7200); // Máximo 2 horas

      if (error) throw error;

      if (!data || data.length === 0) {
        console.warn("⚠️ No hay datos de tiempo");
        return 0;
      }

      const totalSeconds = data.reduce((sum, item) => sum + (item.tiempo_dedicado || 0), 0);
      const avgSeconds = totalSeconds / data.length;
      const avgMinutes = Math.round(avgSeconds / 60);

      console.log(`✅ Tiempo promedio: ${avgMinutes} minutos (${data.length} registros)`);
      return avgMinutes;
    } catch (err) {
      console.error("❌ Error:", err);
      return 0;
    }
  };

  // FUNCIÓN 2: Calcular Engagement (CORREGIDA)

  const calculateEngagementRate = async () => {
    try {
      console.log("📊 Calculando engagement correctamente...");

      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

      // ✅ Obtener TODOS los estudiantes
      const { data: allStudents, error: studentsError } = await supabase
        .from("usuarios")
        .select("id, ultimo_acceso, activo")
        .eq("rol", "estudiante");

      if (studentsError) throw studentsError;

      if (!allStudents || allStudents.length === 0) {
        console.log("⚠️ No hay estudiantes registrados");
        return 0;
      }

      const totalStudents = allStudents.length;

      // ✅ Contar SOLO estudiantes que han tenido actividad en los últimos 7 días
      const activeStudents = allStudents.filter(student => {
        // Si no tiene último acceso, nunca ha entrado
        if (!student.ultimo_acceso) return false;

        // Convertir a Date y comparar
        const lastAccess = new Date(student.ultimo_acceso);
        return lastAccess > sevenDaysAgo;
      }).length;

      const engagementRate = Math.round((activeStudents / totalStudents) * 100);

      console.log(`📊 RESULTADO ENGAGEMENT:`);
      console.log(`   - Total estudiantes: ${totalStudents}`);
      console.log(`   - Activos última semana: ${activeStudents}`);
      console.log(`   - Inactivos: ${totalStudents - activeStudents}`);
      console.log(`   - Tasa: ${engagementRate}%`);

      // Mostrar lista de estudiantes inactivos (para debugging)
      const inactiveStudents = allStudents.filter(student => {
        if (!student.ultimo_acceso) return true;
        return new Date(student.ultimo_acceso) <= sevenDaysAgo;
      });

      if (inactiveStudents.length > 0) {
        console.log(`📋 Estudiantes inactivos (${inactiveStudents.length}):`);
        inactiveStudents.slice(0, 5).forEach(s => {
          console.log(`   - ID: ${s.id}, Último acceso: ${s.ultimo_acceso || 'NUNCA'}`);
        });
      }

      return engagementRate;

    } catch (err) {
      console.error("❌ Error calculando engagement:", err);
      return 0;
    }
  };

  // FUNCIÓN 3: Calcular Analytics 
  const calculateAdvancedAnalytics = async () => {
    try {
      console.log("🚀 Iniciando cálculo de analytics...");

      //1. Obtener estudiantes
      const { data: students, error: studentsError } = await supabase
        .from("usuarios")
        .select("id, nombre, activo, ultimo_acceso, created_at")
        .eq("rol", "estudiante");

      if (studentsError) throw studentsError;

      const totalStudents = students?.length || 0;
      const activeStudents = students?.filter(s => s.activo === true)?.length || 0;

      console.log(`✅ Total estudiantes: ${totalStudents}`);

      // Calcular ENGAGEMENT (por días de inactividad)
      const hoy = new Date();
      let sumaCompromiso = 0;

      students?.forEach(student => {
        let compromiso = 0;

        if (student.ultimo_acceso) {
          const diasInactivo = Math.floor((hoy - new Date(student.ultimo_acceso)) / (1000 * 60 * 60 * 24));

          // ✅ SOLO CAMBIAMOS LOS DÍAS: de 30 días a 120 días (4 meses)
          if (diasInactivo <= 7) compromiso = 100;      // Activo esta semana
          else if (diasInactivo <= 30) compromiso = 75;  // Activo este mes
          else if (diasInactivo <= 60) compromiso = 50;  // 2 meses
          else if (diasInactivo <= 120) compromiso = 25; // 4 meses ← CAMBIADO de 30 a 120
          else compromiso = 0;                           // Más de 4 meses
        }

        sumaCompromiso += compromiso;
      });

      const engagementRate = totalStudents > 0 ? Math.round(sumaCompromiso / totalStudents) : 0;

      console.log(`✅ Tasa de compromiso: ${engagementRate}%`);

      // ✅ 3. Calcular recursos completados
      const { data: progressData, error: progressError } = await supabase
        .from("progreso_estudiantes")
        .select("completado, progreso, tiempo_dedicado");

      if (progressError) throw progressError;

      const completedResources = progressData?.filter(p => p.completado === true)?.length || 0;
      const totalActivities = progressData?.length || 0;

      // ✅ 4. Tiempo promedio
      const validTimeData = progressData?.filter(p => p.tiempo_dedicado && p.tiempo_dedicado > 0) || [];
      const avgTime = validTimeData.length > 0
        ? Math.round(validTimeData.reduce((sum, p) => sum + p.tiempo_dedicado, 0) / validTimeData.length / 60)
        : 0;

      // ✅ 5. Completitud
      const completionRate = totalActivities > 0
        ? Math.round((completedResources / totalActivities) * 100)
        : 0;

      // ✅ 6. TOP CURSOS MÁS ACTIVOS
      let topCourses = [];

      try {
        const { data: topData, error: topError } = await supabase
          .from("progreso_estudiantes")
          .select(`
          recursos!inner(
            curso_id,
            cursos!inner(
              id,
              titulo,
              color
            )
          )
        `);

        if (!topError && topData && topData.length > 0) {
          const courseCount = {};

          topData.forEach(progress => {
            const cursoId = progress.recursos?.curso_id;
            const cursoTitulo = progress.recursos?.cursos?.titulo;
            const cursoColor = progress.recursos?.cursos?.color;

            if (cursoId) {
              if (!courseCount[cursoId]) {
                courseCount[cursoId] = {
                  count: 0,
                  title: cursoTitulo || `Curso ${cursoId}`,
                  color: cursoColor || "#3B82F6"
                };
              }
              courseCount[cursoId].count++;
            }
          });

          topCourses = Object.entries(courseCount)
            .sort(([, a], [, b]) => b.count - a.count)
            .slice(0, 5)
            .map(([courseId, data]) => ({
              courseId,
              count: data.count,
              title: data.title,
              color: data.color
            }));
        }
      } catch (err) {
        console.warn("⚠️ Error calculando top cursos:", err);
      }

      // ✅ 7. Calcular crecimiento de usuarios
      const monthAgo = new Date();
      monthAgo.setDate(monthAgo.getDate() - 30);

      const newUsersLastMonth = students?.filter(s =>
        s.created_at && new Date(s.created_at) > monthAgo
      )?.length || 0;

      const previousMonthUsers = totalStudents - newUsersLastMonth;
      const userGrowth = previousMonthUsers > 0 && totalStudents > 0
        ? Math.round((newUsersLastMonth / totalStudents) * 100)
        : 0;

      // ✅ 8. GUARDAR ANALYTICS
      setAnalytics({
        totalUsers: totalStudents,
        activeStudents: activeStudents,
        completedResources: completedResources,
        avgTimePerResource: avgTime,
        topCourses: topCourses,
        userGrowth: userGrowth,
        engagementRate: engagementRate,
        completionRate: completionRate,
      });

      console.log("✅ Analytics actualizado:", {
        totalStudents,
        engagementRate: `${engagementRate}%`,
        topCourses: topCourses.length
      });

    } catch (err) {
      console.error("❌ Error:", err);
    }
  };

  const calculateUserGrowth = async () => {
    try {
      const { data, error } = await supabase
        .from("usuarios")
        .select("created_at")
        .gte(
          "created_at",
          new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString()
        );

      if (error) throw error;

      const lastMonthUsers = data?.length || 0;
      const previousMonthUsers = users.length - lastMonthUsers;

      if (previousMonthUsers === 0) return 100;
      return Math.round(
        ((lastMonthUsers - previousMonthUsers) / previousMonthUsers) * 100
      );
    } catch (err) {
      return 0;
    }
  };

  const calculateCompletionRate = async () => {
    try {
      const { data, error } = await supabase
        .from("progreso_estudiantes")
        .select("*")
        .eq("completado", true);
      if (error) throw error;
      const totalCompletions = data?.length || 0;
      const totalPossibleCompletions =
        users.filter((u) => u.rol === "estudiante").length * resources.length;
      return totalPossibleCompletions > 0
        ? Math.round((totalCompletions / totalPossibleCompletions) * 100)
        : 0;
    } catch (err) {
      return 0;
    }
  };

  const calculateTopCourses = async () => {
    try {
      const { data, error } = await supabase.from("progreso_estudiantes")
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
      data?.forEach((progress) => {
        const courseId = progress.recursos?.curso_id;
        const courseTitle = progress.recursos?.cursos?.titulo;
        if (courseId) {
          if (!courseProgress[courseId]) {
            courseProgress[courseId] = {
              count: 0,
              title: courseTitle || `Curso ${courseId}`,
            };
          }
          courseProgress[courseId].count++;
        }
      });

      return Object.entries(courseProgress)
        .sort(([, a], [, b]) => b.count - a.count)
        .slice(0, 5)
        .map(([courseId, data]) => ({
          courseId,
          count: data.count,
          title: data.title,
        }));
    } catch (err) {
      return [];
    }
  };


  // VERSIÓN CON IA - RÁPIDA Y CONFIABLE

  const generateAIAnalyticsImproved = async () => {
    console.log('=== INICIO generateAIAnalyticsImproved ===');

    setLoadingAI(true);
    setShowDetailedAnalytics(true);

    console.log('✅ Estados iniciales configurados');
    console.log('📊 Users:', users?.length);
    console.log('📚 Courses:', courses?.length);
    console.log('📝 Resources:', resources?.length);

    try {
      console.log('🔍 Intentando calcular métricas básicas...');

      // PASO 1: Métricas básicas síncronas
      const totalStudents = users?.filter(u => u.rol === 'estudiante')?.length || 0;
      const activeStudents = users?.filter(u => u.rol === 'estudiante' && u.activo)?.length || 0;
      const inactiveStudents = totalStudents - activeStudents;

      console.log('✅ Estudiantes calculados:', { totalStudents, activeStudents, inactiveStudents });

      // PASO 2: Engagement (última semana)
      const lastWeek = new Date();
      lastWeek.setDate(lastWeek.getDate() - 7);

      const engagedStudents = users?.filter(u => {
        if (!u.ultimo_acceso) return false;
        return new Date(u.ultimo_acceso) > lastWeek;
      })?.length || 0;

      const engagementRate = totalStudents > 0
        ? Math.round((engagedStudents / totalStudents) * 100)
        : 0;

      console.log('✅ Compromiso calculado:', { engagedStudents, engagementRate });

      // PASO 3: Construir métricas completas
      const metrics = {
        students: {
          total: totalStudents,
          active: activeStudents,
          inactive: inactiveStudents,
        },
        content: {
          courses: courses?.length || 0,
          resources: resources?.length || 0,
          achievements: achievements?.length || 0,
        },
        engagement: {
          rate: engagementRate,
          activeCount: engagedStudents,
        },
        progress: {
          average: analytics?.completionRate || 0,
          completionRate: analytics?.completionRate || 0,
          totalActivities: 0,
          completedActivities: 0,
          totalTimeSpent: analytics?.avgTimePerResource || 0,
        },
      };

      console.log('✅ Métricas construidas:', metrics);

      // PASO 4: Calcular salud del sistema
      const healthScore = Math.min(
        100,
        Math.max(0, Math.round(
          (metrics.engagement.rate * 0.3 +
            metrics.progress.completionRate * 0.4 +
            metrics.progress.average * 0.3)
        ))
      );

      console.log('✅ Health Score calculado:', healthScore);

      // PASO 5: Generar insights
      const insights = [
        `📊 Sistema con ${metrics.students.total} estudiantes: ${metrics.students.active} activos y ${metrics.students.inactive} inactivos`,
        `🎯 Compromiso del ${metrics.engagement.rate}% con ${metrics.engagement.activeCount} estudiantes activos esta semana`,
        `📈 Progreso promedio del ${metrics.progress.average}% y completitud del ${metrics.progress.completionRate}%`,
        `📚 Contenido: ${metrics.content.courses} cursos, ${metrics.content.resources} recursos, ${metrics.content.achievements} logros`,
      ];

      console.log('✅ Insights generados:', insights.length);

      // PASO 6: Generar recomendaciones
      const recommendations = [];

      if (metrics.engagement.rate < 50) {
        recommendations.push({
          title: '🎯 Aumentar Compromiso',
          description: `Solo ${metrics.engagement.rate}% de estudiantes están activos. Implementa gamificación y actividades interactivas.`,
          priority: 'high',
        });
      } else {
        recommendations.push({
          title: '✅ Compromiso Excelente',
          description: `${metrics.engagement.rate}% de compromiso. Mantén las estrategias actuales.`,
          priority: 'low',
        });
      }

      if (metrics.progress.completionRate < 40) {
        recommendations.push({
          title: '📈 Mejorar Completitud',
          description: `${metrics.progress.completionRate}% de actividades completadas. Considera reducir complejidad o añadir incentivos.`,
          priority: 'high',
        });
      } else {
        recommendations.push({
          title: '✅ Completitud Buena',
          description: `${metrics.progress.completionRate}% completadas. Continúa monitoreando el progreso.`,
          priority: 'low',
        });
      }

      if (metrics.students.inactive > 0) {
        recommendations.push({
          title: '👥 Reactivar Estudiantes',
          description: `${metrics.students.inactive} estudiantes inactivos. Envía recordatorios y contenido motivacional.`,
          priority: 'medium',
        });
      }

      if (metrics.content.resources < 10) {
        recommendations.push({
          title: '📚 Agregar Más Recursos',
          description: `Solo tienes ${metrics.content.resources} recursos. Usa el generador de IA para crear contenido rápidamente.`,
          priority: 'medium',
        });
      }

      console.log('✅ Recomendaciones generadas:', recommendations.length);

      // PASO 7: Guardar resultados
      const finalMetrics = {
        ...metrics,
        systemHealth: {
          status: healthScore >= 70 ? 'healthy' : healthScore >= 50 ? 'warning' : 'critical',
          score: healthScore,
        },
        timestamp: new Date(),
      };

      console.log('✅ Métricas finales preparadas');
      console.log('🔄 Guardando en estados...');

      setAiMetrics(finalMetrics);
      console.log('✅ aiMetrics guardado');

      setAiInsights(insights);
      console.log('✅ aiInsights guardado');

      setAiRecommendations(recommendations);
      console.log('✅ aiRecommendations guardado');

      setLoadingAI(false);
      console.log('✅ loadingAI = false');

      console.log('=== FIN generateAIAnalyticsImproved EXITOSO ===');

    } catch (error) {
      console.error('❌❌❌ ERROR CRÍTICO:', error);
      console.error('Stack:', error.stack);

      // Fallback básico
      const fallbackMetrics = {
        students: {
          total: users?.filter(u => u.rol === 'estudiante')?.length || 0,
          active: users?.filter(u => u.rol === 'estudiante' && u.activo)?.length || 0,
          inactive: 0,
        },
        content: {
          courses: courses?.length || 0,
          resources: resources?.length || 0,
          achievements: achievements?.length || 0,
        },
        engagement: {
          rate: 0,
          activeCount: 0,
        },
        progress: {
          average: 0,
          completionRate: 0,
          totalActivities: 0,
          completedActivities: 0,
          totalTimeSpent: 0,
        },
        systemHealth: {
          status: 'warning',
          score: 50,
        },
        timestamp: new Date(),
      };

      fallbackMetrics.students.inactive = fallbackMetrics.students.total - fallbackMetrics.students.active;

      console.log('⚠️ Usando fallback metrics');
      setAiMetrics(fallbackMetrics);
      setAiInsights([
        '📊 Sistema inicializado',
        '⚠️ Error al calcular métricas: ' + error.message,
        `👥 Total: ${fallbackMetrics.students.total} estudiantes`,
      ]);
      setAiRecommendations([
        {
          title: '⚠️ Error en análisis',
          description: 'Revisa la consola para más detalles',
          priority: 'high',
        },
      ]);

      setLoadingAI(false);
      console.log('=== FIN generateAIAnalyticsImproved CON ERROR ===');
    }
  };

  const calculateRealSystemMetrics = async () => {
    console.log('📊 Calculando métricas de Supabase...');

    try {
      // CONSULTA 1: Estudiantes y su estado
      const { data: studentsData, error: studentsError } = await supabase
        .from('usuarios')
        .select('id, activo, ultimo_acceso, created_at')
        .eq('rol', 'estudiante');

      if (studentsError) {
        console.error('Error estudiantes:', studentsError);
        throw studentsError;
      }

      const totalStudents = studentsData?.length || 0;
      const activeStudents = studentsData?.filter(u => u.activo)?.length || 0;
      const inactiveStudents = totalStudents - activeStudents;

      console.log(`✅ Estudiantes: ${totalStudents}`);

      // CONSULTA 2: Engagement (última semana)
      const lastWeek = new Date();
      lastWeek.setDate(lastWeek.getDate() - 7);

      const engagedStudents = studentsData?.filter(u => {
        if (!u.ultimo_acceso) return false;
        return new Date(u.ultimo_acceso) > lastWeek;
      })?.length || 0;

      const engagementRate = totalStudents > 0
        ? Math.round((engagedStudents / totalStudents) * 100)
        : 0;

      console.log(`✅ Engagement: ${engagementRate}%`);

      // CONSULTA 3: Cursos y Recursos
      const { data: coursesData, error: coursesError } = await supabase
        .from('cursos')
        .select('id')
        .eq('activo', true);

      if (coursesError) throw coursesError;

      const { data: resourcesData, error: resourcesError } = await supabase
        .from('recursos')
        .select('id, tipo')
        .eq('activo', true);

      if (resourcesError) throw resourcesError;

      console.log(`✅ Contenido: ${coursesData?.length || 0} cursos, ${resourcesData?.length || 0} recursos`);

      // CONSULTA 4: Progreso de estudiantes
      const { data: progressData, error: progressError } = await supabase
        .from('progreso_estudiantes')
        .select('progreso, completado, tiempo_dedicado');

      if (progressError) throw progressError;

      const completedActivities = progressData?.filter(p => p.completado)?.length || 0;
      const totalActivities = progressData?.length || 0;

      const avgProgress = totalActivities > 0
        ? Math.round(progressData.reduce((sum, p) => sum + (p.progreso || 0), 0) / totalActivities)
        : 0;

      const completionRate = totalActivities > 0
        ? Math.round((completedActivities / totalActivities) * 100)
        : 0;

      const totalTimeSpent = Math.round(
        (progressData?.reduce((sum, p) => sum + (p.tiempo_dedicado || 0), 0) || 0) / 60
      );

      console.log(`✅ Progreso: ${avgProgress}% | Completitud: ${completionRate}%`);

      // CONSULTA 5: Logros
      const { data: achievementsData, error: achievementsError } = await supabase
        .from('logros')
        .select('id')
        .eq('activo', true);

      if (achievementsError) throw achievementsError;

      console.log(`✅ Logros: ${achievementsData?.length || 0}`);

      // RETORNAR MÉTRICAS COMPLETAS
      const metrics = {
        students: {
          total: totalStudents,
          active: activeStudents,
          inactive: inactiveStudents,
        },
        content: {
          courses: coursesData?.length || 0,
          resources: resourcesData?.length || 0,
          achievements: achievementsData?.length || 0,
        },
        engagement: {
          rate: engagementRate,
          activeCount: engagedStudents,
        },
        progress: {
          average: avgProgress,
          completionRate,
          totalActivities,
          completedActivities,
          totalTimeSpent,
        },
        timestamp: new Date(),
      };

      console.log('✅ Métricas completas:', metrics);
      return metrics;

    } catch (err) {
      console.error('❌ Error en métricas:', err);
      return null;
    }
  };

  // ALGORITMOS DE ANÁLISIS DE APRENDIZAJE

  // Algoritmo 1: Detección de Aprendizaje Real (LEA)
  const analyzeLearningEffectiveness = async (studentId, fechaInicio, fechaFin) => {
    try {
      let query = supabase
        .from("progreso_estudiantes")
        .select(`
        id,
        completado,
        tiempo_dedicado,
        intentos,
        progreso,
        updated_at,
        recursos!inner(titulo, tipo, tiempo_estimado)
      `)
        .eq("usuario_id", studentId)
        .order("updated_at", { ascending: true });

      if (fechaInicio && fechaFin) {
        query = query
          .gte("updated_at", `${fechaInicio} 00:00:00`)
          .lte("updated_at", `${fechaFin} 23:59:59`);
      }

      const { data: registros, error } = await query;

      if (error) throw error;

      if (!registros || registros.length === 0) {
        return {
          tieneDatos: false,
          isLearning: false,
          confidence: 0,
          mensaje: "Sin actividad en el período seleccionado",
          indicators: {
            totalActividades: 0,
            completadas: 0,
            retentionRate: 0,
            averageAttempts: 0,
            averageTimePerQuestion: 0,
            improvementTrend: 0
          },
          alerts: ["No hay actividad en las fechas seleccionadas"]
        };
      }

      const totalActividades = registros.length;
      const completadas = registros.filter(r => r.completado === true).length;
      const retentionRate = Math.round((completadas / totalActividades) * 100);

      const intentosValores = registros.map(r => r.intentos || 1);
      const averageAttempts = Number((intentosValores.reduce((a, b) => a + b, 0) / intentosValores.length).toFixed(1));

      const tiemposValidos = registros.map(r => r.tiempo_dedicado || 0).filter(t => t > 0 && t < 7200);
      const averageTimePerQuestion = tiemposValidos.length > 0
        ? Math.round(tiemposValidos.reduce((a, b) => a + b, 0) / tiemposValidos.length)
        : 0;

      let improvementTrend = 0;
      if (registros.length >= 2) {
        const sorted = [...registros].sort((a, b) => new Date(a.updated_at) - new Date(b.updated_at));
        const primerProgreso = sorted[0]?.progreso || 0;
        const ultimoProgreso = sorted[sorted.length - 1]?.progreso || 0;
        improvementTrend = Math.round(ultimoProgreso - primerProgreso);
      }

      let confidence = 50;

      if (retentionRate >= 80) confidence += 20;
      else if (retentionRate >= 60) confidence += 10;
      else if (retentionRate >= 40) confidence += 5;
      else if (retentionRate < 30) confidence -= 15;

      if (averageAttempts <= 1.3) confidence += 20;
      else if (averageAttempts <= 1.8) confidence += 10;
      else if (averageAttempts <= 2.5) confidence += 5;
      else if (averageAttempts >= 4) confidence -= 20;
      else if (averageAttempts >= 3) confidence -= 10;

      if (averageTimePerQuestion >= 30 && averageTimePerQuestion <= 120) confidence += 15;
      else if (averageTimePerQuestion > 180) confidence -= 10;
      else if (averageTimePerQuestion > 300) confidence -= 20;

      if (improvementTrend > 15) confidence += 15;
      else if (improvementTrend > 5) confidence += 10;
      else if (improvementTrend < -15) confidence -= 15;
      else if (improvementTrend < -5) confidence -= 10;

      confidence = Math.max(0, Math.min(100, Math.round(confidence)));
      const isLearning = confidence >= 50;

      const alerts = [];
      if (averageAttempts >= 4) alerts.push(`Demasiados intentos (${averageAttempts} promedio) - Necesita refuerzo`);
      if (retentionRate < 40) alerts.push(`Baja retención (${retentionRate}% completado) - Repasar conceptos`);
      if (averageTimePerQuestion > 300) alerts.push(`Tiempo excesivo (${Math.round(averageTimePerQuestion / 60)} min) - Posible distracción`);
      if (improvementTrend < -15) alerts.push(`Rendimiento decreciente (${improvementTrend}%) - Intervención necesaria`);
      if (totalActividades < 3) alerts.push(`Pocas actividades (${totalActividades}) - Datos limitados`);

      const evolucionDiaria = [];
      const progresoPorFecha = new Map();

      registros.forEach(r => {
        const fecha = new Date(r.updated_at).toISOString().split('T')[0];
        if (!progresoPorFecha.has(fecha)) {
          progresoPorFecha.set(fecha, { progresos: [], completados: 0 });
        }
        const entry = progresoPorFecha.get(fecha);
        entry.progresos.push(r.progreso || 0);
        if (r.completado) entry.completados++;
      });

      for (const [fecha, data] of progresoPorFecha.entries()) {
        evolucionDiaria.push({
          fecha,
          progreso: Math.round(data.progresos.reduce((a, b) => a + b, 0) / data.progresos.length),
          completados: data.completados
        });
      }
      evolucionDiaria.sort((a, b) => a.fecha.localeCompare(b.fecha));

      return {
        tieneDatos: true,
        isLearning,
        confidence,
        indicators: {
          totalActividades,
          completadas,
          retentionRate,
          averageAttempts,
          averageTimePerQuestion,
          averageTimePerQuestionMin: Math.round(averageTimePerQuestion / 60),
          improvementTrend
        },
        evolucionDiaria,
        alerts
      };

    } catch (err) {
      console.error("Error LEA:", err);
      return null;
    }
  };
  // Algoritmo 2: Detección de Atención (ADA)
  const analyzeAttentionLevel = async (studentId, fechaInicio, fechaFin) => {
    try {
      let query = supabase
        .from("progreso_estudiantes")
        .select(`
        id,
        progreso,
        completado,
        tiempo_dedicado,
        intentos,
        updated_at,
        recursos!inner(titulo, tiempo_estimado)
      `)
        .eq("usuario_id", studentId)
        .order("updated_at", { ascending: true });

      if (fechaInicio && fechaFin) {
        query = query
          .gte("updated_at", `${fechaInicio} 00:00:00`)
          .lte("updated_at", `${fechaFin} 23:59:59`);
      }

      const { data: registros, error } = await query;

      if (error) throw error;

      if (!registros || registros.length === 0) {
        return {
          tieneDatos: false,
          level: "Sin datos",
          score: 0,
          indicators: {
            consistencyScore: 0,
            focusIndex: 0,
            inactivityPeriods: 0
          },
          recommendations: ["No hay actividad en el período seleccionado"]
        };
      }

      const progresos = registros.map(r => r.progreso || 0);
      const media = progresos.reduce((a, b) => a + b, 0) / progresos.length;
      const varianza = progresos.reduce((sum, val) => sum + Math.pow(val - media, 2), 0) / progresos.length;
      const desviacionEstandar = Math.sqrt(varianza);
      const consistencyScore = Math.min(100, Math.max(0, 100 - desviacionEstandar));

      let focusIndex = 50;
      const ratios = [];

      for (const r of registros) {
        const estimado = r.recursos?.tiempo_estimado || 3;
        const real = (r.tiempo_dedicado || 0) / 60;
        if (real > 0) {
          ratios.push(real / estimado);
        }
      }

      if (ratios.length > 0) {
        const avgRatio = ratios.reduce((a, b) => a + b, 0) / ratios.length;
        if (avgRatio <= 1.2) focusIndex = 90;
        else if (avgRatio <= 1.5) focusIndex = 70;
        else if (avgRatio <= 2) focusIndex = 50;
        else focusIndex = 30;
      }

      const fechasUnicas = [...new Set(registros.map(r => new Date(r.updated_at).toISOString().split('T')[0]))].sort();
      let inactivityPeriods = 0;

      for (let i = 1; i < fechasUnicas.length; i++) {
        const diff = (new Date(fechasUnicas[i]) - new Date(fechasUnicas[i - 1])) / (1000 * 60 * 60 * 24);
        if (diff > 1) inactivityPeriods++;
      }

      let score = (consistencyScore * 0.4) + (focusIndex * 0.4);
      score -= Math.min(30, inactivityPeriods * 10);
      score = Math.max(0, Math.min(100, Math.round(score)));

      let level = "Baja";
      if (score >= 80) level = "Excelente";
      else if (score >= 60) level = "Buena";
      else if (score >= 40) level = "Regular";

      const recommendations = [];
      if (consistencyScore < 50) recommendations.push("Rendimiento inconsistente - Establecer rutina de estudio");
      if (focusIndex < 50) recommendations.push("Tiempo excesivo por actividad - Reducir distracciones");
      if (inactivityPeriods > 2) recommendations.push("Períodos largos sin actividad - Enviar recordatorios");
      if (score < 40) recommendations.push("ALERTA: Baja atención - Intervención pedagógica necesaria");

      return {
        tieneDatos: true,
        level,
        score,
        indicators: {
          consistencyScore: Math.round(consistencyScore),
          focusIndex: Math.round(focusIndex),
          inactivityPeriods,
          desviacionEstandar: Math.round(desviacionEstandar * 10) / 10
        },
        recommendations
      };

    } catch (err) {
      console.error("Error ADA:", err);
      return null;
    }
  };
  // Función auxiliar: Desviación estándar
  const calculateStdDev = (values) => {
    const mean = values.reduce((a, b) => a + b, 0) / values.length;
    const squaredDiffs = values.map((v) => Math.pow(v - mean, 2));
    const variance = squaredDiffs.reduce((a, b) => a + b, 0) / values.length;
    return Math.sqrt(variance);
  };

  // Algoritmo 3: Retroalimentación Adaptativa (AFS)
  const generateAdaptiveFeedback = async (studentId, fechaInicio, fechaFin) => {
    try {
      const [learningAnalysis, attentionAnalysis] = await Promise.all([
        analyzeLearningEffectiveness(studentId, fechaInicio, fechaFin),
        analyzeAttentionLevel(studentId, fechaInicio, fechaFin)
      ]);

      const { data: studentData } = await supabase
        .from("usuarios")
        .select("id, nombre, email, grupo_id")
        .eq("id", studentId)
        .single();

      const strengths = [];
      const weaknesses = [];
      const recommendations = [];
      const actionPlan = [];

      let overallStatus = "";
      let statusColor = "";

      console.log(`📊 Analizando: ${studentData?.nombre}`);
      console.log(`   - learningAnalysis.isLearning: ${learningAnalysis?.isLearning}`);
      console.log(`   - attentionAnalysis.score: ${attentionAnalysis?.score}`);
      console.log(`   - tieneDatos: ${learningAnalysis?.tieneDatos}`);

      // ============================================
      // CASO 1: Sin datos en el período
      // ============================================
      if (learningAnalysis?.tieneDatos === false || learningAnalysis?.indicators?.totalActividades === 0) {
        overallStatus = "Sin actividad en el período";
        statusColor = "gray";
        strengths.push("Estudiante registrado en el sistema");
        recommendations.push("Selecciona un período con actividad o espera a que complete actividades");
        actionPlan.push("Realizar primera actividad del curso");
      }
      // ============================================
      // CASO 2: VERDE - Aprendizaje Efectivo (Excelente)
      // ============================================
      else if (learningAnalysis?.isLearning === true && attentionAnalysis?.score >= 60) {
        overallStatus = "✅ Aprendizaje Efectivo";
        statusColor = "green";
        strengths.push(`Demuestra comprensión real del contenido (${learningAnalysis.confidence}% confianza)`);
        strengths.push(`Mantiene buena atención (${attentionAnalysis.score}%)`);

        if (learningAnalysis.indicators.improvementTrend > 0) {
          strengths.push(`Mejora continua (+${learningAnalysis.indicators.improvementTrend}% de progreso)`);
        }
        if (learningAnalysis.indicators.retentionRate >= 80) {
          strengths.push(`Excelente retención (${learningAnalysis.indicators.retentionRate}%)`);
        }
        if (learningAnalysis.indicators.averageAttempts <= 1.5) {
          strengths.push(`Comprende rápidamente (${learningAnalysis.indicators.averageAttempts} intentos promedio)`);
        }

        actionPlan.push("🎯 Proponer desafíos avanzados para mantener motivación");
        actionPlan.push("🏆 Reconocer logros públicamente");
        actionPlan.push("📚 Material complementario para profundizar");
      }
      // ============================================
      // CASO 3: AMARILLO - Intermedio (Atención baja pero aprendizaje bien)
      // ============================================
      else if (learningAnalysis?.isLearning === true && attentionAnalysis?.score < 60 && attentionAnalysis?.score >= 40) {
        overallStatus = "⚠️ Problemas de Atención";
        statusColor = "yellow";
        strengths.push(`Comprensión aceptable (${learningAnalysis.confidence}% confianza)`);
        weaknesses.push(`Falta de concentración sostenida (${attentionAnalysis.score}% atención)`);

        recommendations.push(...attentionAnalysis.recommendations);
        recommendations.push("📋 Actividades cortas para mantener concentración (máximo 15 minutos)");
        recommendations.push("🎮 Incluir elementos lúdicos y gamificación");

        actionPlan.push("⏰ Pausas activas cada 15 minutos");
        actionPlan.push("👀 Ubicar al estudiante en primeras filas");
        actionPlan.push("📊 Monitoreo semanal de atención");
      }
      // ============================================
      // CASO 4: AMARILLO - Dificultades de Aprendizaje (Aprendizaje bajo pero atención bien)
      // ============================================
      else if (learningAnalysis?.isLearning === false && attentionAnalysis?.score >= 60) {
        overallStatus = "⚠️ Dificultades de Aprendizaje";
        statusColor = "yellow";
        weaknesses.push(`Necesita refuerzo en conceptos básicos (${learningAnalysis?.confidence || 0}% confianza)`);
        strengths.push(`Mantiene buena atención (${attentionAnalysis.score}%) - buena base para mejorar`);

        if (learningAnalysis?.indicators.retentionRate < 50) {
          weaknesses.push(`Baja retención (${learningAnalysis.indicators.retentionRate}%) - necesita repaso frecuente`);
        }
        if (learningAnalysis?.indicators.averageAttempts >= 4) {
          weaknesses.push(`Requiere muchos intentos (${learningAnalysis.indicators.averageAttempts}) - dificultad alta`);
        }

        recommendations.push("📚 Material complementario y ejercicios adicionales");
        recommendations.push("👥 Trabajo colaborativo con compañeros de nivel similar");
        recommendations.push("🎯 Metas semanales alcanzables");

        actionPlan.push("📝 Seguimiento semanal personalizado");
        actionPlan.push("🎨 Actividades multisensoriales para reforzar conceptos");
        actionPlan.push("⭐ Refuerzo positivo por pequeños logros");
      }
      // ============================================
      // CASO 5: ROJO - Requiere Intervención Urgente
      // ============================================
      else if (learningAnalysis?.isLearning === false && attentionAnalysis?.score < 60) {
        overallStatus = "🚨 Requiere Intervención Urgente";
        statusColor = "red";
        weaknesses.push(`Dificultad significativa en el aprendizaje (${learningAnalysis?.confidence || 0}% confianza)`);
        weaknesses.push(`Problemas de atención severos (${attentionAnalysis?.score || 0}%)`);

        if (learningAnalysis?.indicators.retentionRate < 40) {
          weaknesses.push(`Baja retención (${learningAnalysis.indicators.retentionRate}%) - riesgo de rezago`);
        }
        if (learningAnalysis?.indicators.averageAttempts >= 4) {
          weaknesses.push(`Requiere muchos intentos (${learningAnalysis.indicators.averageAttempts}) - nivel de dificultad inadecuado`);
        }
        if (learningAnalysis?.indicators.improvementTrend < -10) {
          weaknesses.push(`Rendimiento decreciente (${learningAnalysis.indicators.improvementTrend}%) - intervención inmediata`);
        }
        if (learningAnalysis?.alerts && learningAnalysis.alerts.length > 0) {
          learningAnalysis.alerts.forEach(alert => weaknesses.push(alert));
        }

        recommendations.push("🎯 Intervención pedagógica individualizada");
        recommendations.push("📋 Reducir carga de trabajo y priorizar conceptos clave");
        recommendations.push("👥 Asignar compañero tutor para apoyo");

        actionPlan.push("📞 PRIORITARIO: Reunión con familia y equipo psicopedagógico");
        actionPlan.push("📋 Evaluación diagnóstica completa para identificar causas");
        actionPlan.push("👨‍🏫 Asignar mentor de apoyo dentro del aula");
        actionPlan.push("🎮 Actividades de refuerzo lúdicas y motivacionales");
      }
      // ============================================
      // CASO 6: AMARILLO - Recién comenzando (pocos datos)
      // ============================================
      else if (learningAnalysis?.indicators?.totalActividades < 3) {
        overallStatus = "📊 Recién comenzando";
        statusColor = "yellow";
        strengths.push(`Ha completado ${learningAnalysis.indicators.totalActividades} actividad(es)`);
        weaknesses.push("Pocos datos para un análisis completo");
        recommendations.push("Completar más actividades para obtener un análisis preciso");
        actionPlan.push("Realizar al menos 3 actividades para evaluar el progreso");
      }
      // ============================================
      // CASO 7: Por defecto - AMARILLO (no debería llegar aquí)
      // ============================================
      else {
        overallStatus = "📊 Evaluación en Proceso";
        statusColor = "yellow";
        strengths.push("Estudiante activo en el sistema");
        recommendations.push("Completar más actividades para un análisis detallado");
        actionPlan.push("Continuar con el plan de estudios y monitorear progreso");

        console.log(`⚠️ Caso no clasificado para: ${studentData?.nombre}`);
        console.log(`   learningAnalysis:`, learningAnalysis);
        console.log(`   attentionAnalysis:`, attentionAnalysis);
      }

      // Limitar arrays a 5 elementos
      const finalStrengths = strengths.slice(0, 5);
      const finalWeaknesses = weaknesses.slice(0, 5);
      const finalRecommendations = recommendations.slice(0, 5);
      const finalActionPlan = actionPlan.slice(0, 5);

      console.log(`🎨 ${studentData?.nombre}: ${overallStatus} -> ${statusColor}`);

      return {
        studentId,
        studentName: studentData?.nombre,
        periodo: fechaInicio && fechaFin ? `${fechaInicio} al ${fechaFin}` : "Todo el período",
        overallStatus,
        statusColor, // 'green', 'yellow', 'red', o 'gray'
        learningEffectiveness: learningAnalysis,
        attentionLevel: attentionAnalysis,
        strengths: finalStrengths,
        weaknesses: finalWeaknesses,
        recommendations: finalRecommendations,
        actionPlan: finalActionPlan,
        timestamp: new Date().toISOString()
      };

    } catch (err) {
      console.error("Error AFS:", err);
      return {
        studentId,
        studentName: "Error",
        periodo: "Error en análisis",
        overallStatus: "⚠️ Error en el análisis",
        statusColor: "yellow",
        strengths: [],
        weaknesses: [`Error: ${err.message}`],
        recommendations: ["Reintentar el análisis más tarde"],
        actionPlan: ["Verificar conexión a la base de datos"],
        learningEffectiveness: null,
        attentionLevel: null
      };
    }
  };
  // Función para generar contenido con IA usando Groq
  const generateContentWithAI = async () => {
    if (!generatorPrompt.trim()) {
      alert("✏️ Escribe qué contenido deseas generar");
      return;
    }

    setGeneratingContent(true);
    setError(null);

    try {
      const selectedType = contentTypes.find(c => c.id === contentType);
      if (!selectedType) throw new Error("Tipo de contenido no válido");

      const apiKey = import.meta.env.VITE_GROQ_API_KEY;

      // Si no hay API key, usar modo offline directamente
      if (!apiKey || apiKey === "") {
        console.warn("⚠️ API key no configurada, usando modo offline");
        const mock = generateMockContent(contentType, generatorPrompt);
        const fallback = {
          id: Date.now(),
          type: contentType,
          prompt: generatorPrompt,
          title: `${selectedType.name}: ${generatorPrompt.slice(0, 40)} (ejemplo)`,
          createdAt: new Date().toLocaleString(),
          content: mock,
          status: "offline",
        };
        setGeneratedContent(fallback);
        setContentLibrary(prev => [fallback, ...prev]);
        setGeneratorPrompt("");
        alert("✅ Contenido generado en modo offline (sin IA)");
        setGeneratingContent(false);
        return;
      }

      // Timeout para evitar bloqueos
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 30000);

      // Prompts más específicos para mejor respuesta
      const systemPrompts = {
        quiz: `Eres un experto educativo. Genera un quiz de 5 preguntas para niños de 6-10 años sobre: "${generatorPrompt}".

Responde EXACTAMENTE con este formato JSON, sin texto adicional:

{
  "questions": [
    {
      "text": "pregunta aquí",
      "options": ["opción A", "opción B", "opción C", "opción D"],
      "correct": 0,
      "explanation": "explicación corta"
    }
  ]
}`,

        game: `Diseña un juego educativo simple para niños de 6-10 años sobre: "${generatorPrompt}".

Responde EXACTAMENTE con este formato JSON:

{
  "name": "nombre del juego",
  "description": "descripción corta",
  "levels": 3,
  "mechanics": ["mecánica 1", "mecánica 2", "mecánica 3"],
  "challenges": [
    {"question": "pregunta 1", "options": ["A","B","C","D"], "correct": 0, "reward": 100}
  ],
  "rewards": ["recompensa 1", "recompensa 2"],
  "instructions": ["instrucción 1", "instrucción 2"]
}`,

        exercise: `Crea 5 ejercicios prácticos para niños de 6-10 años sobre: "${generatorPrompt}".

Responde EXACTAMENTE con este formato JSON:

{
  "exercises": [
    {"id": 1, "instruction": "instrucción", "example": "ejemplo", "difficulty": "facil"}
  ],
  "difficulty": "medio",
  "estimatedTime": 30
}`,

        story: `Escribe una historia educativa corta para niños de 6-10 años sobre: "${generatorPrompt}".

Responde EXACTAMENTE con este formato JSON:

{
  "title": "título",
  "chapters": 3,
  "description": "descripción",
  "keywords": ["palabra1", "palabra2"],
  "moralLesson": "lección"
}`,

        challenge: `Crea un desafío semanal educativo para niños de 6-10 años sobre: "${generatorPrompt}".

Responde EXACTAMENTE con este formato JSON:

{
  "title": "título",
  "difficulty": "medio",
  "reward": "recompensa",
  "duration": "7 días",
  "tasks": ["tarea 1", "tarea 2", "tarea 3"],
  "criteria": ["criterio 1", "criterio 2"]
}`,
      };

      const prompt = systemPrompts[contentType];
      if (!prompt) throw new Error("Tipo no soportado");

      console.log("📤 Enviando solicitud a Groq API...");

      // Intentar con diferentes modelos en orden
      const models = ["mixtral-8x7b-32768", "llama-3.1-8b-instant", "gemma2-9b-it"];
      let lastError = null;
      let data = null;

      for (const model of models) {
        try {
          console.log(`🔄 Intentando con modelo: ${model}`);

          const response = await fetch(
            "https://api.groq.com/openai/v1/chat/completions",
            {
              method: "POST",
              signal: controller.signal,
              headers: {
                Authorization: `Bearer ${apiKey}`,
                "Content-Type": "application/json",
              },
              body: JSON.stringify({
                model: model,
                messages: [
                  {
                    role: "system",
                    content: "Eres un asistente educativo. Responde ÚNICAMENTE con JSON válido. No agregues texto antes o después del JSON. Usa comillas dobles.",
                  },
                  { role: "user", content: prompt },
                ],
                temperature: 0.5,
                max_tokens: 2000,
              }),
            }
          );

          clearTimeout(timeout);

          if (response.ok) {
            data = await response.json();
            console.log(`✅ Éxito con modelo: ${model}`);
            break;
          } else {
            const errorText = await response.text();
            console.warn(`⚠️ Modelo ${model} falló: ${response.status}`);
            lastError = new Error(`HTTP ${response.status}: ${errorText.substring(0, 100)}`);
          }
        } catch (modelError) {
          console.warn(`⚠️ Error con modelo ${model}:`, modelError.message);
          lastError = modelError;
        }
      }

      if (!data) {
        throw lastError || new Error("Todos los modelos fallaron");
      }

      let aiText = data?.choices?.[0]?.message?.content?.trim();

      if (!aiText) {
        throw new Error("Respuesta vacía de la IA");
      }

      console.log("📥 Respuesta recibida (primeros 200 chars):", aiText.substring(0, 200));

      // Limpieza más robusta
      aiText = aiText
        .replace(/```json\n?/gi, "")
        .replace(/```\n?/g, "")
        .replace(/`/g, "")
        .replace(/^[^{]*/, "")
        .replace(/[^}]*$/, "")
        .trim();

      // Buscar JSON válido
      let jsonMatch = aiText.match(/\{[\s\S]*\}/);
      if (!jsonMatch) {
        // Intentar con otra expresión regular
        jsonMatch = aiText.match(/[\{\[][\s\S]*[\}\]]/);
        if (!jsonMatch) {
          console.error("❌ Texto recibido:", aiText);
          throw new Error("No se encontró JSON válido en la respuesta");
        }
      }

      let parsed;
      try {
        parsed = JSON.parse(jsonMatch[0]);
      } catch (e) {
        console.error("❌ Error parsing JSON:", e);
        throw new Error("La IA devolvió un formato JSON inválido");
      }

      // Validaciones según tipo
      if (contentType === "quiz") {
        if (!parsed.questions || !Array.isArray(parsed.questions) || parsed.questions.length === 0) {
          throw new Error("El quiz no tiene preguntas válidas");
        }
        parsed.questions = parsed.questions.map((q, i) => ({
          id: i + 1,
          pregunta: q.text || q.pregunta || `Pregunta ${i + 1}`,
          opciones: q.options || q.opciones || ["Opción 1", "Opción 2", "Opción 3", "Opción 4"],
          respuesta_correcta: q.correct ?? q.respuesta_correcta ?? 0,
          puntos: q.puntos || 10,
          imagen_url: q.image_theme || "❓",
          imagen_opciones: q.option_emojis || ["🔴", "🔵", "🟢", "🟡"],
          retroalimentacion_correcta: q.explanation || q.retroalimentacion_correcta || "¡Excelente! 🎉",
          retroalimentacion_incorrecta: q.feedback || "¡Intenta otra vez! 💪"
        }));
        parsed.totalPoints = parsed.totalPoints || parsed.questions.length * 10;
      }

      const newContent = {
        id: Date.now(),
        type: contentType,
        prompt: generatorPrompt,
        title: `${selectedType.name}: ${generatorPrompt.slice(0, 40)}`,
        createdAt: new Date().toLocaleString(),
        content: parsed,
        status: "generated",
        preguntas: parsed.questions || [],
      };

      setGeneratedContent(newContent);
      setContentLibrary(prev => [newContent, ...prev]);

      // Guardar en Supabase
      if (currentUser?.auth_id) {
        try {
          await supabase.from("contenido_generado").insert([{
            type: contentType,
            prompt: generatorPrompt,
            title: newContent.title,
            content: parsed,
            created_by: currentUser.auth_id,
            status: "generated",
          }]);
          console.log("✅ Guardado en Supabase");
        } catch (dbError) {
          console.warn("⚠️ No se pudo guardar en Supabase:", dbError);
        }
      }

      setGeneratorPrompt("");
      alert(`✅ ${selectedType.name} generado correctamente`);

      // Cambiar a biblioteca para ver el resultado
      setContentGeneratorTab("library");

    } catch (error) {
      console.error("❌ Error en generación:", error);

      let msg = "❌ Error desconocido";

      if (error.name === "AbortError") {
        msg = "⏱️ La IA tardó demasiado. Usando contenido de ejemplo.";
      } else if (error.message.includes("API key") || error.message.includes("api key")) {
        msg = "🔑 Error de API key. Usando modo offline.";
      } else if (error.message.includes("JSON")) {
        msg = "⚠️ La IA devolvió formato incorrecto. Usando contenido de ejemplo.";
      } else if (error.message.includes("fetch")) {
        msg = "🌐 Error de conexión. Verifica tu internet.";
      } else {
        msg = error.message;
      }

      setError(msg);

      // Usar contenido de ejemplo automáticamente
      const selectedType = contentTypes.find(c => c.id === contentType);
      const mock = generateMockContent(contentType, generatorPrompt);

      const fallback = {
        id: Date.now(),
        type: contentType,
        prompt: generatorPrompt,
        title: `${selectedType?.name || contentType}: ${generatorPrompt.slice(0, 40)} (ejemplo)`,
        createdAt: new Date().toLocaleString(),
        content: mock,
        status: "fallback",
      };

      setGeneratedContent(fallback);
      setContentLibrary(prev => [fallback, ...prev]);
      setGeneratorPrompt("");

      alert(`⚠️ ${msg}\n\n✅ Se ha generado un contenido de ejemplo como alternativa.`);
      setContentGeneratorTab("library");

    } finally {
      setGeneratingContent(false);
    }
  };

  // Función para generar contenido mock mejorado
  const generateMockContent = (type, prompt) => {
    const words = prompt.split(' ').filter(w => w.length > 3);
    const mainTopic = words[0] || 'tema';

    const baseContent = {
      quiz: {
        questions: [
          {
            id: 1,
            text: `¿Qué es ${mainTopic}?`,
            options: [
              `Es un concepto relacionado con ${prompt}`,
              'Es algo completamente diferente',
              'No existe',
              'Es una herramienta tecnológica'
            ],
            correct: 0,
            explanation: `${mainTopic} está directamente relacionado con ${prompt}`
          },
          {
            id: 2,
            text: `¿Para qué sirve estudiar ${mainTopic}?`,
            options: [
              'No sirve para nada',
              `Para comprender mejor ${prompt}`,
              'Solo para pasar el tiempo',
              'Es obligatorio y aburrido'
            ],
            correct: 1,
            explanation: `Estudiar ${mainTopic} nos ayuda a entender ${prompt} completamente`
          },
          {
            id: 3,
            text: `¿Cuál es un ejemplo de ${mainTopic}?`,
            options: [
              'Un videojuego',
              'Una mascota',
              `Un caso relacionado con ${prompt}`,
              'Una película'
            ],
            correct: 2,
            explanation: `Los ejemplos de ${mainTopic} están relacionados con ${prompt}`
          },
          {
            id: 4,
            text: `¿Cómo se aplica ${mainTopic} en la vida real?`,
            options: [
              'No se puede aplicar',
              `Se usa diariamente en situaciones de ${prompt}`,
              'Solo en laboratorios',
              'Únicamente en libros'
            ],
            correct: 1,
            explanation: `${mainTopic} tiene aplicaciones prácticas en ${prompt}`
          },
          {
            id: 5,
            text: `¿Por qué es importante ${mainTopic}?`,
            options: [
              'No es importante',
              'Solo para exámenes',
              `Porque nos ayuda a resolver problemas de ${prompt}`,
              'Es una moda pasajera'
            ],
            correct: 2,
            explanation: `${mainTopic} es fundamental para entender ${prompt}`
          }
        ],
        totalPoints: 50,
        timeLimit: 300
      },
      game: {
        name: `Aventura de ${mainTopic}`,
        description: `Explora el mundo de ${prompt} mientras aprendes jugando`,
        type: 'adventure', // 'adventure', 'puzzle', 'memory', 'quiz-game'
        levels: 3,
        currentLevel: 0,
        score: 0,
        lives: 3,
        mechanics: [
          { id: 1, name: `Recolecta ${mainTopic}`, icon: '🎯', completed: false },
          { id: 2, name: `Responde sobre ${prompt}`, icon: '❓', completed: false },
          { id: 3, name: 'Completa el desafío', icon: '🏆', completed: false }
        ],
        challenges: [
          {
            id: 1,
            question: `¿Qué sabes sobre ${mainTopic}?`,
            options: [`Es ${prompt}`, 'Otra cosa', 'No sé', 'Todo lo anterior'],
            correct: 0,
            reward: 100
          },
          {
            id: 2,
            question: `¿Para qué sirve ${mainTopic}?`,
            options: ['No sirve', `Para ${prompt}`, 'Solo diversión', 'Es complicado'],
            correct: 1,
            reward: 150
          },
          {
            id: 3,
            question: `¿Dónde se usa ${mainTopic}?`,
            options: ['En ningún lado', 'Solo en libros', `En ${prompt} diario`, 'Solo en escuela'],
            correct: 2,
            reward: 200
          }
        ],
        rewards: ['⭐ 50 puntos', `🏆 Medalla de ${mainTopic}`, '💎 Logro especial'],
        instructions: [
          `Aprende sobre ${prompt}`,
          'Completa los desafíos',
          'Gana recompensas',
          'Desbloquea niveles'
        ]
      },
      exercise: {
        exercises: [
          {
            id: 1,
            instruction: `Define con tus palabras qué es ${mainTopic}`,
            example: `Por ejemplo: ${mainTopic} es...`,
            difficulty: 'facil'
          },
          {
            id: 2,
            instruction: `Menciona 3 características de ${prompt}`,
            example: 'Característica 1..., Característica 2...',
            difficulty: 'facil'
          },
          {
            id: 3,
            instruction: `Da un ejemplo real de ${mainTopic}`,
            example: 'Un ejemplo es...',
            difficulty: 'medio'
          },
          {
            id: 4,
            instruction: `¿Cómo se relaciona ${mainTopic} con tu vida diaria?`,
            example: 'En mi vida diaria...',
            difficulty: 'medio'
          },
          {
            id: 5,
            instruction: `Explica la importancia de ${prompt}`,
            example: 'Es importante porque...',
            difficulty: 'medio'
          },
          {
            id: 6,
            instruction: `Compara ${mainTopic} con otro concepto similar`,
            example: 'Se parece a... pero se diferencia en...',
            difficulty: 'dificil'
          },
          {
            id: 7,
            instruction: `Crea un problema sobre ${prompt} y resuélvelo`,
            example: 'Problema: ... Solución: ...',
            difficulty: 'dificil'
          },
          {
            id: 8,
            instruction: `Diseña una actividad para enseñar ${mainTopic}`,
            example: 'Actividad: ...',
            difficulty: 'dificil'
          },
          {
            id: 9,
            instruction: `¿Qué preguntas tienes sobre ${prompt}?`,
            example: 'Me gustaría saber...',
            difficulty: 'medio'
          },
          {
            id: 10,
            instruction: `Reflexiona sobre lo que aprendiste de ${mainTopic}`,
            example: 'Lo más importante que aprendí es...',
            difficulty: 'medio'
          }
        ],
        difficulty: 'medio',
        estimatedTime: 45
      },
      story: {
        title: `El Viaje de ${mainTopic}`,
        chapters: 5,
        description: `Una aventura educativa donde descubrirás los secretos de ${prompt}. Acompaña a nuestros personajes mientras exploran y aprenden.`,
        keywords: [mainTopic, ...words.slice(1, 5), 'aventura', 'aprendizaje', 'descubrimiento'],
        moralLesson: `La importancia de comprender ${mainTopic} y aplicarlo en la vida real`
      },
      challenge: {
        title: `Desafío Master: ${mainTopic}`,
        difficulty: 'experto',
        reward: '⭐ 100 puntos + 🏆 Trofeo de Maestro + 💎 Logro Especial',
        duration: '7 días',
        tasks: [
          `Completa el quiz sobre ${prompt}`,
          `Resuelve 10 ejercicios prácticos de ${mainTopic}`,
          `Lee la historia educativa completa`,
          `Crea tu propio ejemplo de ${prompt}`,
          `Comparte lo aprendido con un compañero`
        ],
        criteria: [
          'Comprensión profunda del tema',
          'Aplicación práctica de conceptos',
          'Creatividad en las soluciones',
          'Capacidad de explicar a otros'
        ]
      }
    };
    return baseContent[type] || baseContent.quiz;
  };

  // FUNCIÓN PARA ABRIR VISOR (CORREGIDA)

  const viewGeneratedContent = (item) => {
    console.log('👁️ Abriendo visor para:', item);

    //  Asegurar que editingContent sea una copia profunda
    const deepCopy = JSON.parse(JSON.stringify({
      ...item,
      content: item.content || {}
    }));

    setViewingContent(item);
    setEditingContent(deepCopy);
    setShowContentViewer(true);

    console.log('✅ Visor abierto con contenido:', deepCopy.title);
  };

  // Función para guardar cambios editados

  const saveEditedContent = async () => {
    if (!editingContent) {
      alert('❌ No hay contenido para guardar');
      return;
    }

    setSavingChanges(true);

    try {
      console.log('💾 Guardando cambios...', editingContent);

      //  Si es contenido generado (en biblioteca)
      if (editingContent.id && currentUser?.auth_id) {
        const { data, error } = await supabase
          .from('contenido_generado')
          .update({
            content: editingContent.content,
            title: editingContent.title,
            updated_at: new Date().toISOString()
          })
          .eq('id', editingContent.id)
          .eq('created_by', currentUser.auth_id)
          .select();

        if (error) {
          console.error('❌ Error en Supabase:', error);
          throw error;
        }

        console.log('✅ Guardado en Supabase:', data);

        //  Actualizar biblioteca local
        setContentLibrary(prev => prev.map(item =>
          item.id === editingContent.id ? editingContent : item
        ));

        // Actualizar generatedContent si existe
        if (generatedContent?.id === editingContent.id) {
          setGeneratedContent(editingContent);
        }

        alert('✅ Cambios guardados correctamente en la base de datos');
        setShowContentViewer(false);
        setEditingContent(null);
        setViewingContent(null);
        setEditingQuizQuestion(null);

        //  Recargar biblioteca
        await loadContentLibrary();
      } else {
        alert('❌ No se puede guardar: falta información del contenido');
      }
    } catch (error) {
      console.error('❌ Error guardando:', error);
      alert(`❌ Error al guardar: ${error.message}`);
    } finally {
      setSavingChanges(false);
    }
  };

  // Función para eliminar contenido
  const deleteGeneratedContent = async (id) => {
    if (!confirm('¿Eliminar este contenido?')) return;

    try {
      const { error } = await supabase
        .from('contenido_generado')
        .delete()
        .eq('id', id)
        .eq('created_by', currentUser.auth_id);

      if (error) throw error;

      setContentLibrary(contentLibrary.filter(item => item.id !== id));
      if (generatedContent?.id === id) {
        setGeneratedContent(null);
      }

      alert('✅ Contenido eliminado correctamente');
    } catch (error) {
      console.error('Error eliminando:', error);
      alert('❌ Error al eliminar el contenido');
    }
  };

  // Función para descargar contenido (MEJORADA)
  const downloadContentFile = (item) => {
    try {
      let fileContent = '';
      let fileName = '';
      let fileType = 'application/json';

      switch (item.type) {
        case 'quiz':
          fileName = `Quiz_${item.title.replace(/[^a-z0-9]/gi, '_')}_${Date.now()}.txt`;
          fileType = 'text/plain;charset=utf-8';
          fileContent = `
╔════════════════════════════════════════════════════════════════╗
║                    QUIZ INTERACTIVO                            ║
║                   Generado con Didactikapp                     ║
╚════════════════════════════════════════════════════════════════╝

📚 Título: ${item.title}
📝 Prompt original: ${item.prompt}
📅 Fecha de creación: ${item.createdAt}
⭐ Puntos totales: ${item.content.totalPoints}
⏱️ Tiempo límite: ${item.content.timeLimit} segundos
📊 Total de preguntas: ${item.content.questions?.length || 0}

════════════════════════════════════════════════════════════════
                        PREGUNTAS
════════════════════════════════════════════════════════════════

${item.content.questions?.map((q, i) => `
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Pregunta ${i + 1}:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❓ ${q.text}

Opciones:
${q.options?.map((opt, j) => `   ${j === q.correct ? '✅ CORRECTA' : '⭕'} ${String.fromCharCode(65 + j)}) ${opt}`).join('\n')}

💡 Explicación: ${q.explanation || 'Sin explicación'}

`).join('') || 'Sin preguntas'}

════════════════════════════════════════════════════════════════
          Generado por Didactikapp - Educación Básica Elemental
════════════════════════════════════════════════════════════════
          `;
          break;

        case 'game':
          fileName = `Juego_${item.title.replace(/[^a-z0-9]/gi, '_')}_${Date.now()}.txt`;
          fileType = 'text/plain;charset=utf-8';
          fileContent = `
╔════════════════════════════════════════════════════════════════╗
║                    JUEGO EDUCATIVO                             ║
║                   Generado con Didactikapp                     ║
╚════════════════════════════════════════════════════════════════╝

🎮 Nombre: ${item.content.name}
📝 Descripción: ${item.content.description}
🎲 Niveles: ${item.content.levels}
📅 Fecha de creación: ${item.createdAt}

════════════════════════════════════════════════════════════════
                   MECÁNICAS DEL JUEGO
════════════════════════════════════════════════════════════════

${item.content.mechanics?.map((m, i) => `${i + 1}. ${m}`).join('\n') || 'Sin mecánicas'}

════════════════════════════════════════════════════════════════
                      RECOMPENSAS
════════════════════════════════════════════════════════════════

${item.content.rewards?.map((r, i) => `${i + 1}. ${r}`).join('\n') || 'Sin recompensas'}

════════════════════════════════════════════════════════════════
                     INSTRUCCIONES
════════════════════════════════════════════════════════════════

${item.content.instructions?.map((ins, i) => `${i + 1}. ${ins}`).join('\n') || 'Sin instrucciones'}

════════════════════════════════════════════════════════════════
          Generado por Didactikapp - Educación Básica Elemental
════════════════════════════════════════════════════════════════
          `;
          break;

        case 'exercise':
          fileName = `Ejercicios_${item.title.replace(/[^a-z0-9]/gi, '_')}_${Date.now()}.txt`;
          fileType = 'text/plain;charset=utf-8';
          fileContent = `
╔════════════════════════════════════════════════════════════════╗
║                  EJERCICIOS PRÁCTICOS                          ║
║                   Generado con Didactikapp                     ║
╚════════════════════════════════════════════════════════════════╝

📚 Título: ${item.title}
📊 Dificultad: ${item.content.difficulty}
⏱️ Tiempo estimado: ${item.content.estimatedTime} minutos
📝 Total de ejercicios: ${item.content.exercises?.length || 0}

════════════════════════════════════════════════════════════════
                       EJERCICIOS
════════════════════════════════════════════════════════════════

${item.content.exercises?.map((ex) => `
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Ejercicio ${ex.id} (${ex.difficulty.toUpperCase()}):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Instrucción: ${ex.instruction}

💡 Ejemplo: ${ex.example || 'Sin ejemplo'}

`).join('') || 'Sin ejercicios'}

════════════════════════════════════════════════════════════════
          Generado por Didactikapp - Educación Básica Elemental
════════════════════════════════════════════════════════════════
          `;
          break;

        default:
          fileName = `${item.type}_${Date.now()}.json`;
          fileContent = JSON.stringify(item, null, 2);
          fileType = 'application/json';
      }

      const blob = new Blob([fileContent], { type: fileType });
      const url = URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = fileName;
      link.style.visibility = 'hidden';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);

      const notification = document.createElement('div');
      notification.className = 'fixed top-4 right-4 bg-green-500 text-white px-6 py-4 rounded-xl shadow-2xl z-[70] animate-slideIn';
      notification.innerHTML = `
        <div class="flex items-center gap-3">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
          </svg>
          <div>
            <p class="font-bold">✅ Descarga Exitosa</p>
            <p class="text-sm opacity-90">${fileName}</p>
          </div>
        </div>
      `;
      document.body.appendChild(notification);
      setTimeout(() => notification.remove(), 3000);

    } catch (error) {
      console.error('Error descargando:', error);
      alert('❌ Error al descargar el archivo: ' + error.message);
    }
  };

  // ✅ BLOQUE 1: FUNCIÓN CONVERTIR CONTENIDO A RECURSO (CORREGIDA)
  const convertContentToResource = async (item) => {
    try {
      // 1. Validar cursos
      if (!courses || courses.length === 0) {
        alert('⚠️ No hay cursos disponibles. Crea un curso primero.');
        return;
      }

      // 2. Cerrar visor de contenido
      setShowContentViewer(false);

      // 3. Crear modal para seleccionar curso
      const selectedCourseId = await new Promise((resolve) => {
        const modal = document.createElement('div');
        modal.className = 'fixed inset-0 bg-black bg-opacity-60 z-[60] flex items-center justify-center p-4';

        modal.innerHTML = `
        <div class="bg-white rounded-2xl max-w-lg w-full p-6 shadow-2xl">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">
            📚 Convertir a Recurso
          </h3>
          <p class="text-gray-600 mb-6">
            Selecciona el curso donde quieres agregar este contenido:
          </p>

          <div class="space-y-3 mb-6 max-h-64 overflow-y-auto">
            ${courses
            .map(
              (c) => `
              <button
                class="w-full text-left p-4 rounded-xl border-2 border-gray-200 hover:border-blue-500 hover:bg-blue-50 transition-all course-button"
                data-course-id="${c.id}"
              >
                <div class="flex items-center gap-3">
                  <div class="w-12 h-12 rounded-lg flex items-center justify-center"
                       style="background-color:${c.color}20">
                    <span class="text-2xl">📖</span>
                  </div>
                  <div class="flex-1">
                    <p class="font-bold text-gray-800">${c.titulo}</p>
                    <p class="text-xs text-gray-600">
                      ${c.nivel_nombre || 'Sin nivel'}
                    </p>
                  </div>
                </div>
              </button>
            `
            )
            .join('')}
          </div>

          <button
            class="w-full bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-3 rounded-xl font-semibold transition-all cancel-btn"
          >
            Cancelar
          </button>
        </div>
      `;

        document.body.appendChild(modal);

        // ✅ EVENT LISTENERS CORRECTOS
        const courseButtons = modal.querySelectorAll('.course-button');
        courseButtons.forEach((btn) => {
          btn.addEventListener('click', () => {
            const courseId = btn.getAttribute('data-course-id');
            console.log('✅ Curso seleccionado:', courseId);
            modal.remove();
            resolve(courseId); // ← RETORNA STRING
          });
        });

        const cancelBtn = modal.querySelector('.cancel-btn');
        cancelBtn.addEventListener('click', () => {
          modal.remove();
          resolve(null);
        });
      });

      // 4. Si canceló
      if (!selectedCourseId) {
        console.log('❌ Usuario canceló la selección');
        return;
      }

      // CONVERSIÓN CORRECTA: Buscar curso con conversión de tipos
      const selectedCourse = courses.find(
        (c) => String(c.id) === String(selectedCourseId)
      );

      if (!selectedCourse) {
        console.error('❌ Curso no encontrado. Buscado:', selectedCourseId);
        console.log('📚 Cursos disponibles:', courses.map(c => ({ id: c.id, titulo: c.titulo })));
        alert('❌ No se pudo encontrar el curso seleccionado');
        return;
      }

      console.log('✅ Curso encontrado:', selectedCourse.titulo);

      // 5. Crear estructura del recurso
      const resourceData = {
        titulo: item.title || `Recurso: ${item.type}`,
        descripcion: `Contenido generado: ${item.prompt}`,
        tipo: item.type === 'quiz' ? 'quiz' : 'video',
        curso_id: selectedCourse.id, // ← USAR ID DEL CURSO
        contenido_quiz: item.content || null,
        puntos_recompensa: item.type === 'quiz' ? 50 : 10,
        tiempo_estimado: 10,
        orden: 1,
        activo: true,
        created_by: currentUser.id,
        created_at: new Date().toISOString(),
      };

      console.log('📝 Datos del recurso a crear:', resourceData);

      // 6. Insertar en Supabase
      const { data, error } = await supabase
        .from('recursos')
        .insert([resourceData])
        .select();

      if (error) {
        console.error('❌ Error de Supabase:', error);
        throw error;
      }

      console.log('✅ Recurso creado:', data);

      // 7. Actualizar lista de recursos
      await fetchResources();

      // 8. Notificación de éxito
      alert(`✅ ¡Contenido convertido a recurso correctamente!
    
Recurso: ${resourceData.titulo}
Curso: ${selectedCourse.titulo}
Tipo: ${resourceData.tipo}`);

    } catch (error) {
      console.error('❌ Error al convertir contenido:', error);
      alert(`❌ Error: ${error.message}`);
    }
  };



  const updateUserRole = async (userId, newRole) => {
    try {
      const { error } = await supabase
        .from("usuarios")
        .update({ rol: newRole })
        .eq("id", userId);

      if (error) throw error;

      fetchUsers();
      setEditingUser(null);
      alert("✅ Rol actualizado exitosamente");
    } catch (err) {
      alert("Error al actualizar el rol");
    }
  };

  const updateUserRoles = async (userId, roles) => {
    try {
      const rolesArray = Array.isArray(roles) ? roles : [roles];

      if (rolesArray.length === 0) {
        alert("Debes seleccionar al menos un rol");
        return;
      }

      const updateData = {
        rol: rolesArray[0],
        roles_adicionales: rolesArray.length > 1 ? rolesArray.slice(1) : [],
        updated_at: new Date().toISOString(),
      };

      const { data, error } = await supabase
        .from("usuarios")
        .update(updateData)
        .eq("id", userId)
        .select();

      if (error) throw error;

      await fetchUsers();
      setSelectedRoles({});
      setEditingUser(null);
      alert("✅ Roles actualizados exitosamente");
    } catch (err) {
      console.error("❌ Error actualizando roles:", err);
      alert("Error al actualizar los roles: " + err.message);
    }
  };

  const updateUserGroups = async (userId, groups) => {
    try {
      const groupsArray = Array.isArray(groups) ? groups : [groups];

      if (groupsArray.length === 0) {
        alert("Debes seleccionar al menos un grupo");
        return;
      }

      const updateData = {
        grupo_id: groupsArray[0],
        grupos_adicionales: groupsArray.length > 1 ? groupsArray.slice(1) : [],
        updated_at: new Date().toISOString(),
      };

      const { data, error } = await supabase
        .from("usuarios")
        .update(updateData)
        .eq("id", userId)
        .select();

      if (error) throw error;

      await fetchUsers();
      setSelectedGroups({});
      alert("✅ Grupos actualizados exitosamente");
    } catch (err) {
      console.error("❌ Error actualizando grupos:", err);
      alert("Error al actualizar los grupos: " + err.message);
    }
  };

  const updateUserStatus = async (userId, isActive) => {
    try {
      const { error } = await supabase
        .from("usuarios")
        .update({
          activo: isActive,
          ultimo_acceso: new Date().toISOString(),
        })
        .eq("id", userId);

      if (error) throw error;

      fetchUsers();
      alert(`✅ Usuario ${isActive ? "activado" : "desactivado"} exitosamente`);
    } catch (err) {
      alert("Error al actualizar el estado");
    }
  };

  const deleteUser = async (userId) => {
    if (!confirm("¿Estás seguro de eliminar este usuario?")) return;

    try {
      const { error } = await supabase
        .from("usuarios")
        .delete()
        .eq("id", userId);

      if (error) throw error;

      fetchUsers();
      alert("✅ Usuario eliminado exitosamente");
    } catch (err) {
      alert("Error al eliminar usuario");
    }
  };

  const createLevel = async () => {
    if (!newLevel.nombre.trim()) {
      alert("El nombre del nivel es obligatorio");
      return;
    }

    try {
      const { error } = await supabase
        .from("niveles_aprendizaje")
        .insert([newLevel]);

      if (error) throw error;

      fetchLevels();
      setNewLevel({ nombre: "", descripcion: "", orden: 1 });
      setShowNewLevel(false);
      alert("✅ Nivel creado exitosamente");
    } catch (err) {
      alert("Error al crear el nivel");
    }
  };

  const updateLevel = async (levelId, updatedData) => {
    try {
      const { error } = await supabase
        .from("niveles_aprendizaje")
        .update(updatedData)
        .eq("id", levelId);

      if (error) throw error;

      fetchLevels();
      setEditingLevel(null);
    } catch (err) {
      alert("Error al actualizar el nivel");
    }
  };

  const deleteLevel = async (levelId) => {
    if (!confirm("¿Estás seguro de eliminar este nivel?")) return;

    try {
      const { error } = await supabase
        .from("niveles_aprendizaje")
        .delete()
        .eq("id", levelId);

      if (error) throw error;

      fetchLevels();
      alert("✅ Nivel eliminado exitosamente");
    } catch (err) {
      alert("Error al eliminar nivel");
    }
  };

  const createCourse = async () => {
    if (!newCourse.titulo.trim() || !newCourse.nivel_id) {
      alert("El título y nivel son obligatorios");
      return;
    }

    try {
      const { error } = await supabase
        .from("cursos")
        .insert([{ ...newCourse, created_by: currentUser.id }]);

      if (error) throw error;

      fetchCourses();
      setNewCourse({
        titulo: "",
        descripcion: "",
        nivel_id: "",
        color: "#3B82F6",
        orden: 1,
      });
      setShowNewCourse(false);
      alert("✅ Curso creado exitosamente");
    } catch (err) {
      alert("Error al crear el curso");
    }
  };

  const deleteCourse = async (courseId) => {
    if (!confirm("¿Estás seguro de eliminar este curso?")) return;

    try {
      const { error } = await supabase
        .from("cursos")
        .delete()
        .eq("id", courseId);

      if (error) throw error;

      fetchCourses();
      alert("✅ Curso eliminado exitosamente");
    } catch (err) {
      alert("Error al eliminar curso");
    }
  };

  const createResource = async () => {
    if (!newResource.titulo.trim() || !newResource.curso_id) {
      alert("El título y curso son obligatorios");
      return;
    }

    try {
      const { error } = await supabase
        .from("recursos")
        .insert([{ ...newResource, created_by: currentUser.id }]);

      if (error) throw error;

      fetchResources();
      setNewResource({
        titulo: "",
        descripcion: "",
        tipo: "video",
        curso_id: "",
        puntos_recompensa: 10,
        tiempo_estimado: 5,
        orden: 1,
      });
      setShowNewResource(false);
      alert("✅ Recurso creado exitosamente");
    } catch (err) {
      alert("Error al crear el recurso");
    }
  };

  const deleteResource = async (resourceId) => {
    if (!confirm("¿Estás seguro de eliminar este recurso?")) return;

    try {
      const { error } = await supabase
        .from("recursos")
        .delete()
        .eq("id", resourceId);

      if (error) throw error;

      fetchResources();
      alert("✅ Recurso eliminado exitosamente");
    } catch (err) {
      alert("Error al eliminar recurso");
    }
  };

  //Crear Grupo con actualización inmediata

  const createGroup = async () => {
    if (!newGroup.nombre.trim()) {
      alert("⚠️ El nombre del grupo es obligatorio");
      return;
    }

    try {
      const { data, error } = await supabase
        .from("grupos")
        .insert([
          {
            nombre: newGroup.nombre.trim(),
            descripcion: newGroup.descripcion.trim(),
            created_at: new Date().toISOString(),
          },
        ])
        .select()
        .single(); // Obtener el registro creado

      if (error) throw error;

      //  Actualizar estado inmediatamente
      setGroups((prevGroups) => [...prevGroups, data]);

      // Limpiar formulario
      setNewGroup({ nombre: "", descripcion: "" });
      setShowNewGroup(false);

      alert('✅ Grupo "' + data.nombre + '" creado exitosamente');
    } catch (err) {
      console.error("❌ Error creando grupo:", err);
      alert("Error al crear el grupo: " + err.message);
    }
  };

  //  Crear estudiante

  const createStudent = async () => {
    if (!newStudentData.nombre.trim()) {
      setStudentMessage("❌ El nombre es obligatorio");
      return;
    }

    if (!newStudentData.usuario.trim()) {
      setStudentMessage("❌ El usuario es obligatorio");
      return;
    }

    if (newStudentData.password.length < 6) {
      setStudentMessage("❌ La contraseña debe tener al menos 6 caracteres");
      return;
    }

    if (newStudentData.password !== newStudentData.confirm_password) {
      setStudentMessage("❌ Las contraseñas no coinciden");
      return;
    }

    setCreatingStudent(true);
    setStudentMessage("");

    try {
      const emailEstudiante = newStudentData.email?.trim()
        ? newStudentData.email.trim().toLowerCase()
        : `${newStudentData.usuario.toLowerCase()}@didactikapp.com`;

      console.log("📝 Creando usuario en auth...");

      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: emailEstudiante,
        password: newStudentData.password,
        options: {
          data: {
            nombre: newStudentData.nombre.trim(),
            usuario: newStudentData.usuario.trim().toLowerCase(),
            rol: "estudiante",
            grupo_id: newStudentData.grupo_id || null,
          },
        },
      });

      if (authError) {
        console.error("❌ Auth error:", authError);
        setStudentMessage(`❌ Error: ${authError.message}`);
        setCreatingStudent(false);
        return;
      }

      console.log("✅ Usuario creado en auth:", authData.user?.id);

      if (newStudentData.grupo_id && newStudentData.grupo_id.trim() !== "") {
        console.log("📝 Actualizando grupo_id...");

        const { error: updateError } = await supabase
          .from("usuarios")
          .update({ grupo_id: newStudentData.grupo_id })
          .eq("auth_id", authData.user.id);

        if (updateError) {
          console.error("⚠️ Error actualizando grupo:", updateError);
        } else {
          console.log("✅ Grupo actualizado");
        }
      }

      setStudentMessage(
        `✅ Estudiante "${newStudentData.nombre}" creado exitosamente`
      );

      setNewStudentData({
        nombre: "",
        usuario: "",
        email: "",
        password: "",
        confirm_password: "",
        grupo_id: "",
      });

      await fetchUsers();

      setTimeout(() => {
        setShowNewStudent(false);
        setStudentMessage("");
      }, 2000);

    } catch (unexpectedError) {
      console.error("❌ Error inesperado:", unexpectedError);
      setStudentMessage(`❌ Error: ${unexpectedError.message}`);
    } finally {
      setCreatingStudent(false);
    }
  };

  const deleteGroup = async (groupId) => {
    if (!confirm("¿Estás seguro de eliminar este grupo?")) return;

    try {
      const { error } = await supabase
        .from("grupos")
        .delete()
        .eq("id", groupId);

      if (error) throw error;

      fetchGroups();
      alert("✅ Grupo eliminado exitosamente");
    } catch (err) {
      alert("Error al eliminar grupo");
    }
  };
  const createAchievement = async (achievement) => {
    if (!achievement.nombre.trim()) {
      alert("⚠️ El nombre del logro es obligatorio");
      return;
    }

    try {
      const { data, error } = await supabase
        .from("logros")
        .insert([
          {
            nombre: achievement.nombre,
            descripcion: achievement.descripcion,
            icono: achievement.icono || "🏆",
            puntos_requeridos: achievement.puntos_requeridos || 100,
            activo: true,
            created_at: new Date().toISOString(),
          },
        ])
        .select();

      if (error) throw error;

      fetchAchievements();
      setShowNewAchievement(false);
      setNewAchievementData({
        nombre: "",
        descripcion: "",
        icono: "🏆",
        puntos_requeridos: 100,
      });
      alert(`✅ Logro "${achievement.nombre}" creado exitosamente`);
    } catch (err) {
      console.error("Error creando logro:", err);
      alert("Error al crear logro: " + err.message);
    }
  };

  const deleteAchievementItem = async (achievementId) => {
    if (!confirm("¿Estás seguro de eliminar este logro?")) return;

    try {
      const { error } = await supabase
        .from("logros")
        .delete()
        .eq("id", achievementId);

      if (error) throw error;

      fetchAchievements();
      alert("✅ Logro eliminado exitosamente");
    } catch (err) {
      alert("Error al eliminar logro");
    }
  };

  const extractTextFromPDF = async (file) => {
    try {
      const arrayBuffer = await file.arrayBuffer();
      const pdf = await pdfjsLib.getDocument({ data: arrayBuffer }).promise;

      let fullText = '';

      for (let i = 1; i <= pdf.numPages; i++) {
        const page = await pdf.getPage(i);
        const textContent = await page.getTextContent();
        const pageText = textContent.items
          .map(item => item.str)
          .join(' ');
        fullText += pageText + '\n';
      }

      return fullText.trim();
    } catch (error) {
      console.error('Error extrayendo PDF:', error);
      throw new Error('No se pudo procesar el PDF. Intenta con otro archivo.');
    }
  };

  const handleDocumentUpload = async (event) => {
    const file = event.target.files[0];
    if (!file) return;

    setError(null);
    setLoading(true);

    try {
      const validTypes = [
        'application/pdf',
        'text/plain',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      ];

      if (!validTypes.includes(file.type)) {
        setError('⚠️ Formato no válido. Solo se aceptan TXT, PDF, DOC o DOCX');
        event.target.value = '';
        setLoading(false);
        return;
      }

      if (file.size > 5 * 1024 * 1024) {
        setError('⚠️ El archivo es demasiado grande. Máximo 5MB');
        event.target.value = '';
        setLoading(false);
        return;
      }

      let text = '';

      if (file.type === 'application/pdf') {
        text = await extractTextFromPDF(file);
      } else {
        text = await new Promise((resolve, reject) => {
          const reader = new FileReader();
          reader.onload = (e) => resolve(e.target.result);
          reader.onerror = () => reject(new Error('Error leyendo archivo'));
          reader.readAsText(file, 'UTF-8');
        });
      }

      if (!text || text.trim().length < 100) {
        setError(
          '❌ El documento es muy corto. Necesita al menos 100 caracteres'
        );
        setLoading(false);
        return;
      }

      text = text
        .replace(/\s+/g, ' ')
        .replace(/[^\w\s\.¿?¡!áéíóúñ,;:-]/g, '')
        .trim();

      setDocumentText(text);
      setUploadedDocument(file);
      setLoading(false);

      alert(`✅ Documento cargado (${text.length} caracteres)`);
    } catch (err) {
      setError(`❌ Error: ${err.message}`);
      setLoading(false);
    }
  };

  // GUARDAR QUIZ AI COMO RECURSO AUTOMÁTICAMENTE

  const generateQuestionsWithAI = async () => {
    if (!documentText) {
      setError('⚠️ Por favor, sube un documento primero');
      return;
    }

    setGeneratingQuestions(true);
    setError(null);

    try {
      let cleanText = documentText.replace(/\s+/g, ' ').trim();

      const MAX_CHARS = 15000;
      if (cleanText.length > MAX_CHARS) {
        cleanText = cleanText.substring(0, MAX_CHARS);
        const lastPoint = cleanText.lastIndexOf('.');
        if (lastPoint > MAX_CHARS - 500) {
          cleanText = cleanText.substring(0, lastPoint + 1);
        }
      }

      const num = quizConfig.totalPreguntas || 5;

      const prompt = `Eres profesor de básica elemental (6-10 años).

Lee este texto y genera EXACTAMENTE ${num} preguntas simples.
- Máximo 15 palabras por pregunta
- Lenguaje para niños
- 4 opciones cada pregunta
- Solo 1 respuesta correcta
- Explicaciones claras

TEXTO:
"${cleanText}"

FORMATO:
P1: ¿Pregunta?
A) Opción
B) Opción
C) Opción
D) Opción
R: A

Genera ${num} preguntas.`;

      try {
        const response = await fetch(
          `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${import.meta.env.VITE_GEMINI_API_KEY}`,
          {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              contents: [{ parts: [{ text: prompt }] }],
              generationConfig: {
                temperature: 0.3,
                maxOutputTokens: 4096,
              },
            }),
          }
        );

        if (!response.ok) throw new Error(`Error: ${response.status}`);

        const data = await response.json();
        let aiText = data?.candidates?.[0]?.content?.parts?.[0]?.text || '';

        if (!aiText || aiText.trim().length === 0) {
          throw new Error('Sin respuesta');
        }

        aiText = aiText
          .replace(/```json\n?/g, '')
          .replace(/```\n?/g, '')
          .replace(/^[^P]*/gm, '')
          .trim();

        const questions = parseQuestionsImproved(aiText);

        if (questions.length === 0) throw new Error('No hay preguntas');

        const generatedQuestions = questions.map((q, idx) => ({
          id: `ai_${Date.now()}_${idx}`,
          tipo: 'multiple',
          pregunta: q.pregunta,
          opciones: q.opciones,
          respuesta_correcta: q.respuesta_correcta,
          puntos: 10,
          retroalimentacion_correcta: '¡Excelente! 🎉',
          retroalimentacion_incorrecta: '¡Intenta otra vez! 💪',
          audio_pregunta: true,
          audio_retroalimentacion: true,
          video_url: '',
          imagen_url: '',
          audio_opciones: ['', '', '', ''],
          imagen_opciones: ['🎨', '📚', '✏️', '🌟'],
          tiempo_limite: 45,
        }));

        //  CREAR RECURSO AUTOMÁTICAMENTE CON EL QUIZ
        if (!selectedResource && currentUser && courses.length > 0) {
          const defaultCourse = courses[0]; // Usar el primer curso por defecto

          const newQuizResource = {
            titulo: `Quiz: ${documentText.substring(0, 40)}...`,
            descripcion: `Quiz generado automáticamente con IA basado en: ${documentText.substring(0, 100)}`,
            tipo: 'quiz',
            curso_id: defaultCourse.id,
            contenido_quiz: generatedQuestions,
            puntos_recompensa: generatedQuestions.length * 10,
            tiempo_estimado: (generatedQuestions.length * 45) / 60,
            orden: 1,
            activo: true,
            created_by: currentUser.id,
            created_at: new Date().toISOString(),
          };

          console.log('💾 Guardando quiz como recurso:', newQuizResource);

          const { data: insertedData, error: insertError } = await supabase
            .from('recursos')
            .insert([newQuizResource])
            .select();

          if (insertError) {
            console.warn('⚠️ No se guardó en recursos:', insertError.message);
          } else {
            console.log('✅ Quiz guardado en recursos:', insertedData);
            await fetchResources(); // Actualizar lista de recursos
          }
        }

        setCurrentQuiz({ preguntas: generatedQuestions });
        setShowQuizBuilder(true);

        alert(`✅ ${generatedQuestions.length} preguntas generadas y guardadas como recurso`);
        setUploadedDocument(null);
        setDocumentText('');
        setGeneratingQuestions(false);

      } catch (aiError) {
        console.warn('⚠️ IA no disponible, usando modo fallback');

        const questions = generateQuestionsFromDocumentImproved(cleanText, num);
        const generatedQuestions = questions.map((q, idx) => ({
          id: `local_${Date.now()}_${idx}`,
          tipo: 'multiple',
          pregunta: q.pregunta,
          opciones: q.opciones,
          respuesta_correcta: q.respuesta_correcta,
          puntos: 10,
          retroalimentacion_correcta: '¡Excelente! 🎉',
          retroalimentacion_incorrecta: '¡Intenta otra vez! 💪',
          audio_pregunta: true,
          audio_retroalimentacion: true,
          video_url: '',
          imagen_url: '',
          audio_opciones: ['', '', '', ''],
          imagen_opciones: ['🎨', '📚', '✏️', '🌟'],
          tiempo_limite: 45,
        }));

        setCurrentQuiz({ preguntas: generatedQuestions });
        setShowQuizBuilder(true);

        alert(`📊 ${generatedQuestions.length} preguntas generadas (modo offline).`);
        setUploadedDocument(null);
        setDocumentText('');
        setGeneratingQuestions(false);
      }
    } catch (err) {
      setError(`❌ Error: ${err.message}`);
      setGeneratingQuestions(false);
    }
  };

  const generateQuestionsFromDocumentImproved = (text, numQuestions) => {
    const questions = [];
    const oraciones = text
      .split(/[.!?]+/)
      .map(o => o.trim())
      .filter(o => o.length > 30);

    if (oraciones.length < numQuestions) {
      return generateQuestionsFromParagraphs(text.split(/\n\n+/), numQuestions);
    }

    const step = Math.max(1, Math.floor(oraciones.length / numQuestions));
    const selected = [];

    for (let i = 0; i < oraciones.length && selected.length < numQuestions; i += step) {
      selected.push(oraciones[i]);
    }

    selected.forEach((sentence) => {
      const words = sentence.split(/\s+/).filter(w => w.length > 3);
      if (words.length < 3) return;

      const opciones = [
        sentence.substring(0, 60) + (sentence.length > 60 ? '...' : ''),
        `Habla sobre ${words[0]}`,
        `Se refiere a ${words[1]}`,
        'No está relacionado',
      ];

      questions.push({
        pregunta: `¿Cuál es la idea? "${sentence.substring(0, 50)}..."`,
        opciones,
        respuesta_correcta: 0,
      });
    });

    return questions.slice(0, numQuestions);
  };

  const generateQuestionsFromParagraphs = (parrafos, numQuestions) => {
    const questions = [];
    const step = Math.max(1, Math.floor(parrafos.length / numQuestions));

    for (let i = 0; i < parrafos.length && questions.length < numQuestions; i += step) {
      const p = parrafos[i];
      const words = p.split(/\s+/).filter(w => w.length > 3);

      if (words.length < 5) continue;

      questions.push({
        pregunta: `¿Cuál es el tema? "${p.substring(0, 40)}..."`,
        opciones: [
          `Sobre ${words[0]}`,
          `De ${words[1]}`,
          'De historia',
          'Sin relación',
        ],
        respuesta_correcta: 0,
      });
    }

    return questions;
  };

  const parseQuestionsImproved = (aiText) => {
    const questions = [];
    const lines = aiText.split('\n').filter(l => l.trim());
    let currentQuestion = null;
    let currentOptions = [];
    let expectingOptions = false;

    for (let line of lines) {
      line = line.trim();
      // Detecta inicio de pregunta: "P1:", "Pregunta 1:", "1." , "1)"
      const questionMatch = line.match(/^(?:P\d+:|Pregunta\s*\d+:|\d+\.|\d+\))\s*(.+)/i);
      if (questionMatch) {
        if (currentQuestion && currentOptions.length > 0) {
          currentQuestion.opciones = currentOptions;
          questions.push(currentQuestion);
        }
        currentQuestion = {
          pregunta: questionMatch[1].trim(),
          opciones: [],
          respuesta_correcta: 0
        };
        currentOptions = [];
        expectingOptions = true;
        continue;
      }

      // Detecta opciones: "A) texto" o "A. texto"
      const optionMatch = line.match(/^([A-D])[\.\)]\s*(.+)/i);
      if (optionMatch && currentQuestion) {
        currentOptions.push(optionMatch[2].trim());
        continue;
      }

      // Detecta respuesta: "R: B" o "Respuesta: B"
      const answerMatch = line.match(/^(?:R:|Respuesta:)\s*([A-D])/i);
      if (answerMatch && currentQuestion) {
        const letter = answerMatch[1].toUpperCase();
        const index = ['A', 'B', 'C', 'D'].indexOf(letter);
        if (index !== -1) currentQuestion.respuesta_correcta = index;
      }
    }

    // Agregar última pregunta
    if (currentQuestion && currentOptions.length > 0) {
      currentQuestion.opciones = currentOptions;
      questions.push(currentQuestion);
    }

    // Si no encontró estructura, intenta detectar bloques estilo "Pregunta: ... Opciones: ..."
    if (questions.length === 0) {
      // Búsqueda alternativa por párrafos
      const paragraphs = aiText.split(/\n\s*\n/);
      for (let para of paragraphs) {
        if (para.includes('?') && (para.includes('A)') || para.includes('A.'))) {
          const qMatch = para.match(/([^?!]+[?])/);
          if (qMatch) {
            const options = [];
            const optMatches = para.match(/([A-D])[\.\)]\s*([^\n]+)/g);
            if (optMatches) {
              optMatches.forEach(opt => {
                const txt = opt.replace(/^[A-D][\.\)]\s*/, '').trim();
                options.push(txt);
              });
            }
            if (options.length >= 2) {
              questions.push({
                pregunta: qMatch[1].trim(),
                opciones: options.slice(0, 4),
                respuesta_correcta: 0
              });
            }
          }
        }
      }
    }

    return questions;
  };

  const parseQuestionsSimple = (aiText) => {
    return parseQuestionsImproved(aiText);
  };

  // Función auxiliar para procesar respuesta de IA
  const processAIResponse = (data) => {
    console.log("✅ Respuesta de Gemini recibida");

    let aiText = data?.candidates?.[0]?.content?.parts?.[0]?.text || "";

    if (!aiText || aiText.trim().length === 0) {
      throw new Error("La IA no devolvió ninguna respuesta. El documento puede estar vacío o en un formato no compatible.");
    }

    console.log("📝 Respuesta IA:", aiText.substring(0, 500));

    const questions = parseQuestionsSimple(aiText);

    if (questions.length === 0) {
      throw new Error("No se pudieron extraer preguntas del texto. Asegúrate de que el documento tenga contenido educativo claro.");
    }

    const generatedQuestions = questions.map((q, idx) => ({
      id: Date.now() + idx,
      tipo: "multiple",
      pregunta: q.pregunta,
      opciones: q.opciones,
      respuesta_correcta: q.respuesta_correcta,
      puntos: 10,
      retroalimentacion_correcta: "¡Excelente! 🎉 ¡Muy bien!",
      retroalimentacion_incorrecta: "¡Intenta otra vez! 💪 Puedes hacerlo mejor",
      audio_pregunta: true,
      audio_retroalimentacion: true,
      video_url: "",
      imagen_url: "",
      audio_opciones: ["", "", "", ""],
      imagen_opciones: ["🎨", "📚", "✏️", "🌟"],
      tiempo_limite: 45,
    }));

    setCurrentQuiz({ preguntas: generatedQuestions });
    console.log(`🎉 ${generatedQuestions.length} preguntas generadas exitosamente`);

    alert(`✅ ¡Éxito! Se generaron ${generatedQuestions.length} preguntas basadas en el documento (${documentText.length} caracteres procesados)`);

    setUploadedDocument(null);
    setDocumentText("");
  };

  // COMPONENTE UI: Panel de Configuración de Quiz


  const renderQuizConfigPanel = () => (
    <div className="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl p-6 border-2 border-blue-200 space-y-6">
      <h3 className="text-lg font-bold text-gray-800 flex items-center gap-2">
        <Sparkles className="w-6 h-6 text-blue-600" />
        ⚙️ Configurar Generador de Preguntas
      </h3>

      {/* Total de preguntas */}
      <div>
        <label className="block text-sm font-semibold text-gray-800 mb-2">
          📊 Total de preguntas:{" "}
          <span className="text-blue-600">{quizConfig.totalPreguntas}</span>
        </label>
        <input
          type="range"
          min="3"
          max="15"
          value={quizConfig.totalPreguntas}
          onChange={(e) =>
            setQuizConfig({
              ...quizConfig,
              totalPreguntas: parseInt(e.target.value),
            })
          }
          className="w-full h-2 bg-blue-200 rounded-lg appearance-none cursor-pointer"
        />
        <div className="flex justify-between text-xs text-gray-600 mt-1">
          <span>3</span>
          <span>15</span>
        </div>
      </div>

      {/* Tipos de preguntas */}
      <div>
        <label className="block text-sm font-semibold text-gray-800 mb-3">
          🎯 Tipos de preguntas (selecciona al menos 1):
        </label>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
          {[
            { key: "multiple", label: "📝 Opción Múltiple", emoji: "📋" },
            {
              key: "verdadero_falso",
              label: "✓✗ Verdadero/Falso",
              emoji: "☑️",
            },
            { key: "completar", label: "✍️ Completar", emoji: "📝" },
            { key: "imagen", label: "🖼️ Imagen/Emoji", emoji: "🎨" },
            { key: "audio", label: "🔊 Audio", emoji: "🎵" },
          ].map((tipo) => (
            <label
              key={tipo.key}
              className={`cursor-pointer p-3 rounded-lg border-2 transition-all ${quizConfig.tiposSeleccionados[tipo.key]
                ? "border-blue-500 bg-blue-100"
                : "border-gray-300 bg-white hover:border-gray-400"
                }`}
            >
              <input
                type="checkbox"
                checked={quizConfig.tiposSeleccionados[tipo.key]}
                onChange={(e) =>
                  setQuizConfig({
                    ...quizConfig,
                    tiposSeleccionados: {
                      ...quizConfig.tiposSeleccionados,
                      [tipo.key]: e.target.checked,
                    },
                  })
                }
                className="mr-2"
              />
              <span className="text-sm font-medium">{tipo.label}</span>
            </label>
          ))}
        </div>
      </div>

      {/* Dificultad */}
      <div>
        <label className="block text-sm font-semibold text-gray-800 mb-2">
          🔥 Nivel de dificultad:
        </label>
        <div className="flex gap-3">
          {[
            { value: "facil", label: "😊 Fácil", color: "green" },
            { value: "medio", label: "😐 Medio", color: "yellow" },
            { value: "dificil", label: "🤔 Difícil", color: "red" },
          ].map((nivel) => (
            <button
              key={nivel.value}
              onClick={() =>
                setQuizConfig({ ...quizConfig, dificultad: nivel.value })
              }
              className={`flex-1 px-4 py-2 rounded-lg font-medium transition-all ${quizConfig.dificultad === nivel.value
                ? `bg-${nivel.color}-500 text-white shadow-lg`
                : `bg-${nivel.color}-100 text-${nivel.color}-800 hover:bg-${nivel.color}-200`
                }`}
            >
              {nivel.label}
            </button>
          ))}
        </div>
      </div>

      {/* Opciones adicionales */}
      <div className="space-y-2">
        <label className="flex items-center gap-3 cursor-pointer p-3 bg-white rounded-lg border-2 border-gray-200 hover:border-blue-300 transition-colors">
          <input
            type="checkbox"
            checked={quizConfig.audio_automatico}
            onChange={(e) =>
              setQuizConfig({
                ...quizConfig,
                audio_automatico: e.target.checked,
              })
            }
            className="w-4 h-4"
          />
          <div>
            <span className="font-medium text-gray-800">
              🔊 Audio automático
            </span>
            <p className="text-xs text-gray-600">
              Reproducir preguntas automáticamente
            </p>
          </div>
        </label>

        <label className="flex items-center gap-3 cursor-pointer p-3 bg-white rounded-lg border-2 border-gray-200 hover:border-blue-300 transition-colors">
          <input
            type="checkbox"
            checked={quizConfig.retroalimentacion_detallada}
            onChange={(e) =>
              setQuizConfig({
                ...quizConfig,
                retroalimentacion_detallada: e.target.checked,
              })
            }
            className="w-4 h-4"
          />
          <div>
            <span className="font-medium text-gray-800">
              💬 Retroalimentación detallada
            </span>
            <p className="text-xs text-gray-600">
              Mostrar información adicional en respuestas
            </p>
          </div>
        </label>
      </div>

      {/* Resumen */}
      <div className="bg-blue-100 rounded-lg p-4 border-l-4 border-blue-500">
        <p className="text-sm text-blue-900 font-medium">
          ℹ️ Se generarán <strong>{quizConfig.totalPreguntas} preguntas</strong>{" "}
          de tipo{" "}
          <strong>
            {Object.entries(quizConfig.tiposSeleccionados)
              .filter(([_, v]) => v)
              .map(([k, _]) => k)
              .join(", ")}
          </strong>{" "}
          con dificultad <strong>{quizConfig.dificultad}</strong>.
        </p>
      </div>
    </div>
  );

  const addQuestion = () => {
    if (!currentQuestion.pregunta.trim()) {
      alert("La pregunta es obligatoria");
      return;
    }

    if (
      currentQuestion.tipo === "multiple" &&
      currentQuestion.opciones.some((opt) => !opt.trim())
    ) {
      alert("Todas las opciones deben tener texto");
      return;
    }

    if (currentQuestion.tipo === "verdadero_falso") {
      currentQuestion.opciones = ["Verdadero", "Falso"];
    }

    if (currentQuestion.audio_pregunta) {
      speakText(currentQuestion.pregunta);
    }

    setCurrentQuiz({
      ...currentQuiz,
      preguntas: [
        ...currentQuiz.preguntas,
        { ...currentQuestion, id: Date.now() },
      ],
    });

    setCurrentQuestion({
      tipo: "multiple",
      pregunta: "",
      audio_pregunta: true,
      video_url: "",
      imagen_url: "",
      opciones: ["", "", "", ""],
      audio_opciones: ["", "", "", ""],
      imagen_opciones: ["", "", "", ""],
      respuesta_correcta: 0,
      puntos: 10,
      retroalimentacion_correcta: "¡Excelente! 🎉",
      retroalimentacion_incorrecta: "¡Inténtalo de nuevo! 💪",
      audio_retroalimentacion: true,
      tiempo_limite: 0,
    });
  };

  const removeQuestion = (questionId) => {
    setCurrentQuiz({
      ...currentQuiz,
      preguntas: currentQuiz.preguntas.filter((p) => p.id !== questionId),
    });
  };

  const moveQuestion = (index, direction) => {
    const newPreguntas = [...currentQuiz.preguntas];
    const newIndex = direction === "up" ? index - 1 : index + 1;
    if (newIndex >= 0 && newIndex < newPreguntas.length) {
      [newPreguntas[index], newPreguntas[newIndex]] = [
        newPreguntas[newIndex],
        newPreguntas[index],
      ];
      setCurrentQuiz({ ...currentQuiz, preguntas: newPreguntas });
    }
  };

  const handlePreviewAnswer = (questionIndex, optionIndex) => {
    const question = currentQuiz.preguntas[questionIndex];
    const isCorrect = optionIndex === question.respuesta_correcta;

    // Obtener intentos actuales
    const currentAttempts = attemptCount[questionIndex] || 0;

    // Si ya respondió correctamente o agotó intentos, no hacer nada
    if (previewAnswers[questionIndex]?.isCorrect || currentAttempts >= 3) {
      return;
    }

    // Incrementar intentos
    const newAttempts = currentAttempts + 1;
    setAttemptCount({
      ...attemptCount,
      [questionIndex]: newAttempts
    });

    if (isCorrect) {
      // CORRECTO: Guardar respuesta y mostrar feedback
      setPreviewAnswers({
        ...previewAnswers,
        [questionIndex]: { selected: optionIndex, isCorrect: true, attempts: newAttempts }
      });

      setTimeout(() => {
        speakText(question.retroalimentacion_correcta);
      }, 500);

    } else {
      // INCORRECTO: Verificar intentos
      if (newAttempts >= 3) {
        // AGOTÓ INTENTOS: Mostrar respuesta correcta
        setPreviewAnswers({
          ...previewAnswers,
          [questionIndex]: {
            selected: optionIndex,
            isCorrect: false,
            attempts: 3,
            showCorrect: true
          }
        });

        setTimeout(() => {
          speakText(`Has agotado tus intentos. La respuesta correcta era: ${question.opciones[question.respuesta_correcta]}`);
        }, 500);

      } else {
        // AÚN TIENE INTENTOS: Dar feedback y permitir reintentar
        setTimeout(() => {
          const remainingAttempts = 3 - newAttempts;
          speakText(`${question.retroalimentacion_incorrecta} Te quedan ${remainingAttempts} intentos`);
        }, 500);

        // Limpiar selección para permitir reintentar
        setSelectedOption(null);
      }
    }
  };
  // FUNCIÓN DE VOZ MEJORADA Y NATURAL

  // Cola de reproducción de audio
  let audioQueue = [];
  let isPlaying = false;

  const speakText = (text) => {
    if (!text || text.trim() === "") {
      console.log("❌ Texto vacío, no se puede reproducir");
      return;
    }

    if (!("speechSynthesis" in window)) {
      console.error("❌ El navegador no soporta síntesis de voz");
      return;
    }

    // Agregar a la cola
    audioQueue.push(text);

    // Si ya se está reproduciendo, no hacer nada
    if (isPlaying) {
      console.log("⏳ Audio en cola:", text.substring(0, 30));
      return;
    }

    // Procesar la cola
    processAudioQueue();
  };

  const processAudioQueue = () => {
    if (audioQueue.length === 0) {
      isPlaying = false;
      return;
    }

    isPlaying = true;
    const text = audioQueue.shift();

    // Cancelar solo el audio actual, no toda la cola
    window.speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = "es-ES";
    utterance.rate = 0.9;
    utterance.pitch = 1.1;
    utterance.volume = 1;

    const speakWithVoice = () => {
      const voices = window.speechSynthesis.getVoices();
      const spanishVoice = voices.find(voice =>
        voice.lang.includes("es-") ||
        voice.lang === "es-MX" ||
        voice.lang === "es-ES"
      );
      if (spanishVoice) utterance.voice = spanishVoice;
      window.speechSynthesis.speak(utterance);
    };

    if (window.speechSynthesis.getVoices().length === 0) {
      window.speechSynthesis.onvoiceschanged = speakWithVoice;
    } else {
      speakWithVoice();
    }

    utterance.onend = () => {
      console.log("✅ Audio completado:", text.substring(0, 30));
      // Procesar siguiente audio en la cola después de un pequeño retraso
      setTimeout(() => {
        processAudioQueue();
      }, 300);
    };

    utterance.onerror = (event) => {
      console.error("❌ Error en audio:", event);
      processAudioQueue(); // Continuar con la cola aunque haya error
    };
  };

  // Cargar voces al iniciar 
  if ('speechSynthesis' in window) {
    window.speechSynthesis.onvoiceschanged = () => {
      console.log('🎤 Voces disponibles cargadas');
    };
  }

  // FUNCIÓN 1: ABRIR EDITOR DE QUIZ MEJORADO
  const openQuizBuilder = (resource) => {
    setSelectedResource(resource);

    if (resource.contenido_quiz && Array.isArray(resource.contenido_quiz)) {
      // MAPEAR PREGUNTAS CON CAMPOS DE IMAGEN
      const preguntasFormateadas = resource.contenido_quiz.map((q, idx) => ({
        id: q.id || `quiz_${Date.now()}_${idx}`,
        tipo: q.tipo || q.type || 'multiple',
        pregunta: q.pregunta || q.text || q.question || '',
        opciones: q.opciones || q.options || ['', '', '', ''],
        respuesta_correcta: q.respuesta_correcta ?? q.correct ?? 0,
        puntos: q.puntos ?? q.points ?? 10,
        retroalimentacion_correcta: q.retroalimentacion_correcta || q.feedback_correct || '¡Excelente! 🎉',
        retroalimentacion_incorrecta: q.retroalimentacion_incorrecta || q.feedback_incorrect || '¡Intenta otra vez! 💪',
        audio_pregunta: q.audio_pregunta !== false,
        audio_retroalimentacion: q.audio_retroalimentacion !== false,
        video_url: q.video_url || q.videoUrl || '',
        imagen_url: q.imagen_url || q.imageUrl || q.image_url || '', // ✅ NEW
        audio_opciones: q.audio_opciones || q.audioOptions || ['', '', '', ''],
        imagen_opciones: q.imagen_opciones || q.imageOptions || q.image_options || ['', '', '', ''], // ✅ NEW
        tiempo_limite: q.tiempo_limite ?? q.timeLimit ?? 45,
      }));

      setCurrentQuiz({ preguntas: preguntasFormateadas });
    } else {
      setCurrentQuiz({ preguntas: [] });
    }

    setShowQuizBuilder(true);
  };

  // FUNCIÓN 2: CERRAR EDITOR
  const closeQuizBuilder = () => {
    console.log('❌ Cerrando editor');
    setShowQuizBuilder(false);
    setCurrentQuiz({ preguntas: [] });
    setSelectedResource(null);
    setUploadedDocument(null);
    setDocumentText('');
    setCurrentQuestion({
      tipo: "multiple",
      pregunta: "",
      audio_pregunta: true,
      video_url: "",
      imagen_url: "",
      opciones: ["", "", "", ""],
      audio_opciones: ["", "", "", ""],
      imagen_opciones: ["", "", "", ""],
      respuesta_correcta: 0,
      puntos: 10,
      retroalimentacion_correcta: "¡Excelente! 🎉",
      retroalimentacion_incorrecta: "¡Inténtalo de nuevo! 💪",
      audio_retroalimentacion: true,
      tiempo_limite: 0,
    });
  };


  // FUNCIÓN: Registrar inicio de recurso

  const registrarInicioRecurso = async (recursoId) => {
    if (!currentUser || currentUser.rol !== 'estudiante') return;

    try {
      const { error } = await supabase
        .from('progreso_estudiantes')
        .upsert({
          usuario_id: currentUser.id,
          recurso_id: recursoId,
          iniciado_en: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }, {
          onConflict: 'usuario_id,recurso_id'
        });

      if (error) console.error('Error:', error);
      else console.log('✅ Inicio registrado');
    } catch (err) {
      console.error('Error:', err);
    }
  };

  const openPreview = (resource) => {
    console.log('👁️ Abriendo vista previa del quiz:', resource);

    if (!resource) {
      console.error('❌ No hay recurso seleccionado');
      alert('No se pudo abrir el quiz: recurso no encontrado');
      return;
    }

    // Verificar si el recurso tiene preguntas
    let quizQuestions = resource.contenido_quiz;

    if (!quizQuestions || !Array.isArray(quizQuestions) || quizQuestions.length === 0) {
      console.error('❌ El quiz no tiene preguntas:', resource);
      alert('⚠️ Este quiz no tiene preguntas aún. Agrega preguntas primero.');
      return;
    }

    console.log(`✅ Quiz tiene ${quizQuestions.length} preguntas`);

    // Formatear las preguntas para la vista previa
    const preguntasFormateadas = quizQuestions.map((q, idx) => ({
      id: q.id || idx,
      tipo: q.tipo || 'multiple',
      pregunta: q.pregunta || q.text || '',
      opciones: q.opciones || q.options || [],
      respuesta_correcta: q.respuesta_correcta ?? q.correct ?? 0,
      puntos: q.puntos ?? q.points ?? 10,
      retroalimentacion_correcta: q.retroalimentacion_correcta || q.feedback_correct || '¡Excelente! 🎉',
      retroalimentacion_incorrecta: q.retroalimentacion_incorrecta || q.feedback_incorrect || '¡Intenta otra vez! 💪',
      audio_pregunta: q.audio_pregunta !== false,
      audio_retroalimentacion: q.audio_retroalimentacion !== false,
      video_url: q.video_url || '',
      imagen_url: q.imagen_url || q.image_url || '',
      imagen_opciones: q.imagen_opciones || q.image_options || ['🎨', '📚', '✏️', '🌟'],
      tiempo_limite: q.tiempo_limite ?? q.timeLimit ?? 45,
    }));

    // Guardar en el estado
    setSelectedResource(resource);
    setCurrentQuiz({ preguntas: preguntasFormateadas });
    setPreviewQuiz(true);
    setCurrentPreviewQuestion(0);
    setPreviewAnswers({});
    setAttemptCount({});
    setSelectedOption(null);

    console.log('✅ Vista previa abierta con', preguntasFormateadas.length, 'preguntas');
  };

  // FUNCIÓN 4: CERRAR VISTA PREVIA (CORREGIDA)
  const closePreview = () => {
    console.log('❌ Cerrando vista previa');

    // DETENER TODOS LOS AUDIOS INMEDIATAMENTE
    if (window.speechSynthesis) {
      window.speechSynthesis.cancel(); // Detiene cualquier audio en reproducción
      window.speechSynthesis.pause();  // Pausa por si acaso
    }

    // LIMPIAR COLA DE AUDIOS
    audioQueue = [];
    isPlaying = false;

    // Guardamos los IDs de los timeouts para poder limpiarlos
    if (window._quizTimeouts) {
      window._quizTimeouts.forEach(timeoutId => clearTimeout(timeoutId));
      window._quizTimeouts = [];
    }
    if (window._quizIntervals) {
      window._quizIntervals.forEach(intervalId => clearInterval(intervalId));
      window._quizIntervals = [];
    }

    // Limpiar estados
    setPreviewQuiz(false);
    setPreviewAnswers({});
    setAttemptCount({});
    setOptionListenState({});
    setCurrentPreviewQuestion(0);
    setSelectedResource(null);
    setSelectedOption(null);
    setLastAutoRepeat(Date.now());
  };

  // FUNCIÓN 5: GUARDAR QUIZ A RECURSO (MEJORADA)
  const saveQuizToResource = async () => {
    if (currentQuiz.preguntas.length === 0) {
      alert("⚠️ Debes agregar al menos una pregunta");
      return;
    }

    if (!selectedResource) {
      alert("❌ No hay recurso seleccionado");
      return;
    }

    try {
      console.log('💾 Guardando quiz con', currentQuiz.preguntas.length, 'preguntas');

      const updateData = {
        contenido_quiz: currentQuiz.preguntas,
        metadata: {
          total_preguntas: currentQuiz.preguntas.length,
          puntos_totales: currentQuiz.preguntas.reduce((sum, q) => sum + (q.puntos || 10), 0),
          tiene_audio: currentQuiz.preguntas.some((q) => q.audio_pregunta),
          tiene_video: currentQuiz.preguntas.some((q) => q.video_url),
          tiene_imagenes: currentQuiz.preguntas.some((q) => q.imagen_url || q.imagen_opciones?.some((i) => i)),
          actualizado_en: new Date().toISOString(),
        },
        updated_at: new Date().toISOString(),
      };

      const { data, error } = await supabase
        .from("recursos")
        .update(updateData)
        .eq("id", selectedResource.id)
        .select();

      if (error) {
        console.error('❌ Error de Supabase:', error);
        throw error;
      }

      console.log('✅ Quiz guardado:', data);

      await fetchResources();
      closeQuizBuilder();

      alert(`✅ Quiz guardado correctamente
    
📚 Recurso: ${selectedResource.titulo}
📝 Preguntas: ${currentQuiz.preguntas.length}
⭐ Puntos: ${updateData.metadata.puntos_totales}`);

    } catch (err) {
      console.error("❌ Error:", err);
      alert(`Error al guardar: ${err.message}`);
    }
  };

  const fetchStudentProgress = async (studentId) => {
    try {
      const { data, error } = await supabase
        .from("progreso_estudiantes")
        .select(
          `
          *,
          recursos(titulo, tipo, puntos_recompensa, cursos(titulo)),
          usuarios(nombre)
        `
        )
        .eq("usuario_id", studentId)
        .order("updated_at", { ascending: false });

      if (error) throw error;
      setStudentProgress(data || []);
    } catch (err) {
      console.error("Error cargando progreso del estudiante:", err);
    }
  };

  const fetchCourseAnalytics = async (courseId) => {
    try {
      const { data: progressData, error: progressError } = await supabase
        .from("progreso_estudiantes")
        .select(
          `
          *,
          usuarios(nombre, grupo_id),
          recursos!inner(curso_id)
        `
        )
        .eq("recursos.curso_id", courseId);

      if (progressError) throw progressError;

      const totalStudents = new Set(progressData?.map((p) => p.usuario_id))
        .size;
      const completedResources =
        progressData?.filter((p) => p.completado).length || 0;
      const avgProgress =
        progressData?.reduce((sum, p) => sum + (p.progreso || 0), 0) /
        (progressData?.length || 1);
      const totalTime = progressData?.reduce(
        (sum, p) => sum + (p.tiempo_dedicado || 0),
        0
      );

      setCourseAnalytics({
        totalStudents,
        completedResources,
        avgProgress: Math.round(avgProgress),
        totalTime: Math.round(totalTime / 60),
        progressData,
      });
    } catch (err) {
      console.error("Error cargando analíticas del curso:", err);
    }
  };

  const generateCourseReport = async (courseId) => {
    try {
      // Usar el courseId que se pasó O el seleccionado en el formulario
      const finalCourseId = courseId || selectedCourseForReport;

      // Si no hay courseId seleccionado, analizar TODOS los cursos
      if (!finalCourseId) {
        await generateAllCoursesReport();
        return;
      }

      // Buscar curso correctamente
      const course = courses.find((c) => String(c.id) === String(finalCourseId));
      if (!course) {
        console.error("❌ Curso no encontrado. ID buscado:", finalCourseId);
        alert("❌ Curso no encontrado. Verifica que el curso exista.");
        return;
      }

      console.log("✅ Curso encontrado:", course.titulo);

      // Obtener progreso de estudiantes para este curso
      const { data: progressData, error: progressError } = await supabase.from(
        "progreso_estudiantes"
      ).select(`
      *,
      usuario_id,
      recurso_id,
      usuarios!inner(id, nombre, email, grupo_id, activo, ultimo_acceso),
      recursos!inner(id, curso_id, titulo, tipo, puntos_recompensa)
    `);

      if (progressError) {
        console.error("❌ Error en consulta de progreso:", progressError);
        alert("Error al cargar datos de progreso: " + progressError.message);
        return;
      }

      // Filtrar progreso por curso
      const courseProgressData =
        progressData?.filter(
          (p) => String(p.recursos?.curso_id) === String(finalCourseId)
        ) || [];

      console.log(`📊 Total registros de progreso: ${progressData?.length || 0}`);
      console.log(`📊 Progreso filtrado del curso: ${courseProgressData.length}`);

      // Obtener estudiantes únicos
      let uniqueStudentIds = [
        ...new Set(courseProgressData.map((p) => p.usuario_id)),
      ];

      if (uniqueStudentIds.length === 0) {
        alert("⚠️ Este curso no tiene estudiantes con progreso registrado todavía.");
        return;
      }

      console.log(`👥 Estudiantes únicos: ${uniqueStudentIds.length}`);

      // ========== 🔥 NUEVO: APLICAR FILTROS ANTES DE ANALIZAR ==========
      let estudiantesParaAnalizar = users.filter(u =>
        u.rol === 'estudiante' && uniqueStudentIds.includes(u.id)
      );

      // 🔥 FILTRO 1: Por grupo (usando los estados que ya tienes)
      if (filterByGroup && filterByGroup !== "") {
        if (filterByGroup === "sin_grupo") {
          estudiantesParaAnalizar = estudiantesParaAnalizar.filter(u => !u.grupo_id);
        } else {
          estudiantesParaAnalizar = estudiantesParaAnalizar.filter(u =>
            u.grupo_id === parseInt(filterByGroup)
          );
        }
      }

      // 🔥 FILTRO 2: Por estado (excelente/warning/critical)
      // Nota: Esto solo funciona si ya tienes feedback previo, pero lo dejamos para después del análisis
      // Por ahora, solo filtramos por grupo

      // 🔥 FILTRO 3: Búsqueda por nombre
      if (searchStudent && searchStudent !== "") {
        estudiantesParaAnalizar = estudiantesParaAnalizar.filter(u =>
          u.nombre.toLowerCase().includes(searchStudent.toLowerCase())
        );
      }

      const estudiantesFiltradosIds = estudiantesParaAnalizar.map(u => u.id);

      if (estudiantesFiltradosIds.length === 0) {
        alert("⚠️ No hay estudiantes que coincidan con los filtros seleccionados");
        return;
      }

      console.log(`✅ Después de filtros: ${estudiantesFiltradosIds.length} estudiantes para analizar`);
      // ========== FIN DE FILTROS ==========

      // Calcular estadísticas generales (con TODOS los estudiantes del curso)
      const completedCount = courseProgressData.filter((p) => p.completado).length;
      const avgProgress =
        courseProgressData.length > 0
          ? Math.round(
            courseProgressData.reduce((sum, p) => sum + (p.progreso || 0), 0) /
            courseProgressData.length
          )
          : 0;
      const totalTime = Math.round(
        (courseProgressData.reduce(
          (sum, p) => sum + (p.tiempo_dedicado || 0),
          0
        ) || 0) / 60
      );
      const completionRate = Math.round(
        (completedCount / courseProgressData.length) * 100
      );

      console.log("📊 Estadísticas calculadas");

      // 🔥 ANALIZAR SOLO LOS ESTUDIANTES FILTRADOS
      const studentsData = [];

      for (const studentId of estudiantesFiltradosIds) {
        const student = users.find((u) => u.id === studentId);

        if (!student) {
          console.warn(`⚠️ Usuario no encontrado: ${studentId}`);
          continue;
        }

        console.log(`🔍 Analizando estudiante: ${student.nombre}`);

        const feedback = await generateAdaptiveFeedback(studentId, finalCourseId);

        if (!feedback) {
          console.warn(`⚠️ No se pudo analizar a: ${student.nombre}`);
          continue;
        }

        const evolutionData = await fetchStudentEvolution(studentId, finalCourseId);

        const grupoNombre = student.grupo_id
          ? groups.find((g) => g.id === student.grupo_id)?.nombre || "Sin grupo"
          : "Sin grupo";

        studentsData.push({
          student,
          feedback,
          grupo: grupoNombre,
          evolution: evolutionData,
        });
      }

      console.log(`✅ ${studentsData.length} estudiantes analizados`);

      // Crear objeto del reporte
      const reportObj = {
        course: {
          titulo: course.titulo,
          nivel: course.nivel_nombre || "Sin nivel",
          color: course.color,
          fecha: new Date().toLocaleDateString("es-ES", {
            weekday: "long",
            year: "numeric",
            month: "long",
            day: "numeric",
          }),
        },
        stats: {
          totalStudents: uniqueStudentIds.length,
          filteredStudents: studentsData.length,
          avgProgress,
          completedResources: completedCount,
          totalTime,
          completionRate,
        },
        students: studentsData,
      };

      console.log("✅ Análisis generado correctamente");

      // Mostrar modal con los datos
      setCourseReportData(reportObj);
      setShowCourseReportModal(true);

      // Limpiar la selección
      setSelectedCourseForReport(null);

    } catch (err) {
      console.error("❌ Error generando análisis:", err);
      alert("Error al generar el análisis: " + err.message);
    }
  };

  // Obtener evolución temporal de un estudiante 
  const fetchStudentEvolution = async (studentId, fechaInicio, fechaFin) => {
    try {
      let query = supabase
        .from('progreso_estudiantes')
        .select(`
        id,
        progreso,
        completado,
        tiempo_dedicado,
        intentos,
        updated_at,
        created_at,
        iniciado_en,
        recursos!inner(
          id,
          tipo,
          curso_id,
          titulo,
          tiempo_estimado
        )
      `)
        .eq('usuario_id', studentId)
        .order('updated_at', { ascending: true });

      if (fechaInicio && fechaFin) {
        query = query
          .gte('updated_at', `${fechaInicio} 00:00:00`)
          .lte('updated_at', `${fechaFin} 23:59:59`);
      }

      const { data, error } = await query;

      if (error) {
        console.error('Error en fetchStudentEvolution:', error);
        return [];
      }

      if (!data || data.length === 0) {
        return [];
      }

      const evolutionData = data.map((record, index) => {
        const fechaReal = new Date(record.updated_at);
        const meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
        const dia = fechaReal.getDate();
        const mes = meses[fechaReal.getMonth()];
        const año = fechaReal.getFullYear();
        const formatFecha = `${dia} ${mes} ${año}`;

        let tiempoReal = 0;
        if (record.tiempo_dedicado && record.tiempo_dedicado > 0) {
          tiempoReal = Math.floor(record.tiempo_dedicado / 60);
          tiempoReal = Math.min(5, Math.max(1, tiempoReal));
        } else if (record.recursos?.tiempo_estimado) {
          tiempoReal = Math.min(5, Math.max(1, record.recursos.tiempo_estimado));
        } else {
          tiempoReal = 2;
        }

        const progreso = record.completado ? 100 : (record.progreso || 0);
        const intentos = record.intentos || 1;

        let comportamiento = "";
        let comportamientoColor = "";

        if (progreso === 100 && intentos === 1 && tiempoReal <= 2) {
          comportamiento = "Excelente";
          comportamientoColor = "text-green-700 bg-green-100";
        } else if (progreso === 100 && intentos <= 2 && tiempoReal <= 3) {
          comportamiento = "Bueno";
          comportamientoColor = "text-blue-700 bg-blue-100";
        } else if (progreso >= 70 && intentos <= 2) {
          comportamiento = "Regular";
          comportamientoColor = "text-yellow-700 bg-yellow-100";
        } else if (progreso < 70 || intentos > 2 || tiempoReal > 3) {
          comportamiento = "Requiere atención";
          comportamientoColor = "text-red-700 bg-red-100";
        } else {
          comportamiento = "En proceso";
          comportamientoColor = "text-gray-700 bg-gray-100";
        }

        return {
          id: record.id || index,
          fecha: formatFecha,
          fechaCompleta: fechaReal,
          fechaOriginal: record.updated_at,
          progreso: progreso,
          tiempo: tiempoReal,
          intentos: intentos,
          comportamiento: comportamiento,
          comportamientoColor: comportamientoColor,
          recursoTitulo: record.recursos?.titulo || 'Actividad sin título',
          recursoTipo: record.recursos?.tipo || 'actividad'
        };
      });

      return evolutionData;

    } catch (err) {
      console.error('Error en fetchStudentEvolution:', err);
      return [];
    }
  };

  const calculateTrend = (values) => {
    // Validación
    if (!values || !Array.isArray(values) || values.length === 0) {
      return { texto: "Sin datos", color: "text-gray-500", bgColor: "bg-gray-100" };
    }

    // Filtrar valores numéricos válidos
    const validValues = values.filter(v =>
      typeof v === 'number' && !isNaN(v) && isFinite(v)
    );

    if (validValues.length === 0) {
      return { texto: "Sin datos", color: "text-gray-500", bgColor: "bg-gray-100" };
    }

    // Obtener métricas
    const primero = validValues[0];
    const ultimo = validValues[validValues.length - 1];
    const promedio = validValues.reduce((a, b) => a + b, 0) / validValues.length;
    const minimo = Math.min(...validValues);
    const cambio = ultimo - primero;

    // 1. CRÍTICO (menos de 40%)
    if (promedio < 40 || ultimo < 40 || minimo < 30) {
      if (cambio > 15) {
        return { texto: "Mejorando", color: "text-yellow-600", bgColor: "bg-yellow-100" };
      }
      return { texto: "Crítico", color: "text-red-600", bgColor: "bg-red-100" };
    }

    // 2. REGULAR (40% - 60%)
    if (promedio >= 40 && promedio < 60) {
      if (cambio > 10) {
        return { texto: "Mejorando", color: "text-green-600", bgColor: "bg-green-100" };
      }
      if (cambio < -10) {
        return { texto: "Declive", color: "text-orange-600", bgColor: "bg-orange-100" };
      }
      return { texto: "Regular", color: "text-yellow-600", bgColor: "bg-yellow-100" };
    }

    // 3. BUENO (60% - 80%)
    if (promedio >= 60 && promedio < 80) {
      if (cambio > 10) {
        return { texto: "Mejorando", color: "text-green-600", bgColor: "bg-green-100" };
      }
      if (cambio < -10) {
        return { texto: "Declive", color: "text-orange-600", bgColor: "bg-orange-100" };
      }
      return { texto: "Bueno", color: "text-blue-600", bgColor: "bg-blue-100" };
    }

    // 4. EXCELENTE (80% o más)
    if (promedio >= 80) {
      if (cambio > 5) {
        return { texto: "Mejorando", color: "text-green-600", bgColor: "bg-green-100" };
      }
      if (cambio < -10) {
        return { texto: "Declive", color: "text-orange-600", bgColor: "bg-orange-100" };
      }
      return { texto: "Excelente", color: "text-purple-600", bgColor: "bg-purple-100" };
    }

    // Fallback por si acaso
    return { texto: "Estable", color: "text-gray-600", bgColor: "bg-gray-100" };
  };

  // Componente gráfico simple
  const SimpleLineChart = ({ data, xKey, yKey, color, label }) => {
    if (!data || data.length < 2) {
      return (
        <div className="w-full h-full flex items-center justify-center bg-gray-50 rounded-xl">
          <div className="text-center">
            <div className="text-4xl mb-2">📊</div>
            <p className="text-sm text-gray-500">Datos insuficientes</p>
          </div>
        </div>
      );
    }

    const valores = data.map(d => Math.min(100, Math.max(0, d[yKey] || 0)));
    const maxValue = Math.max(...valores, 1);

    const points = data.map((d, i) => ({
      x: (i / (data.length - 1)) * 100,
      y: 100 - ((d[yKey] || 0) / maxValue) * 85
    }));

    const pathD = points.map((p, i) => `${i === 0 ? 'M' : 'L'} ${p.x} ${p.y}`).join(' ');
    const promedio = Math.round(valores.reduce((a, b) => a + b, 0) / valores.length);
    const tendencia = calculateTrend(valores);

    return (
      <div className="relative w-full h-full" style={{ minHeight: '250px' }}>
        <svg className="w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none" style={{ background: '#f9fafb' }}>
          {/* Grid */}
          {[0, 25, 50, 75, 100].map(y => (
            <line key={y} x1="0" y1={y} x2="100" y2={y} stroke="#e5e7eb" strokeWidth="0.5" strokeDasharray="2,2" />
          ))}

          {/* Área */}
          <path d={`${pathD} L 100 100 L 0 100 Z`} fill={`${color}15`} />

          {/* Línea */}
          <path d={pathD} fill="none" stroke={color} strokeWidth="2" strokeLinecap="round" />

          {/* Puntos */}
          {points.map((p, i) => (
            <circle key={i} cx={p.x} cy={p.y} r="3" fill={color} stroke="white" strokeWidth="1.5" />
          ))}
        </svg>

        {/* Etiquetas X */}
        <div className="absolute -bottom-6 left-0 right-0 flex justify-between text-[10px] text-gray-500">
          {data.map((d, i) => (
            <span key={i} className="text-center truncate" style={{ width: `${100 / data.length}%` }}>
              {d[xKey]?.split(' ').slice(0, 2).join(' ') || `Act ${i + 1}`}
            </span>
          ))}
        </div>

        {/* Estadísticas */}
        <div className="absolute -top-6 left-0 text-[10px] font-bold text-gray-700 bg-white px-2 py-0.5 rounded shadow-sm">
          📊 {label}: {promedio}%
        </div>
        <div className={`absolute -top-6 right-0 text-[10px] font-bold bg-white px-2 py-0.5 rounded shadow-sm ${tendencia.color}`}>
          {tendencia.texto}
        </div>
      </div>
    );
  };

  const generateAllCoursesReport = async () => {
    try {
      setIsAnalyzingAllCourses(true);
      console.log("🚀 Iniciando análisis de TODOS los cursos...");

      const { data: progressData, error: progressError } = await supabase.from(
        "progreso_estudiantes"
      ).select(`
      *,
      usuario_id,
      recurso_id,
      usuarios!inner(id, nombre, email, grupo_id),
      recursos!inner(id, curso_id, titulo, tipo, puntos_recompensa, cursos!inner(id, titulo))
    `);

      if (progressError) {
        console.error("❌ Error en consulta Supabase:", progressError);
        throw new Error(`Error de consulta: ${progressError.message}`);
      }

      if (!progressData || progressData.length === 0) {
        alert("⚠️ No hay datos de progreso disponibles para analizar");
        setIsAnalyzingAllCourses(false);
        return;
      }

      console.log(`📊 Se obtuvieron ${progressData.length} registros de progreso`);

      // Agrupar por curso
      const courseMap = {};
      progressData.forEach((progress) => {
        const cursoId = progress.recursos?.curso_id;
        if (!cursoId) return;

        if (!courseMap[cursoId]) {
          const courseData = courses.find((c) => c.id === cursoId);
          courseMap[cursoId] = {
            id: cursoId,
            titulo: courseData?.titulo || `Curso ${cursoId}`,
            nivel: courseData?.nivel_nombre || "Sin nivel",
            color: courseData?.color || "#3B82F6",
            data: [],
          };
        }
        courseMap[cursoId].data.push(progress);
      });

      console.log(`✅ ${Object.keys(courseMap).length} cursos identificados`);

      // Obtener estudiantes únicos
      const uniqueStudentIds = [...new Set(progressData.map((p) => p.usuario_id))];
      console.log(`👥 ${uniqueStudentIds.length} estudiantes únicos`);

      // Analizar cada estudiante (máximo 10)
      const studentsData = [];
      const studentsToAnalyze = uniqueStudentIds;

      for (const studentId of studentsToAnalyze) {
        const student = users.find((u) => u.id === studentId);
        if (!student) {
          console.warn(`⚠️ Estudiante no encontrado: ${studentId}`);
          continue;
        }

        console.log(`🔍 Analizando estudiante: ${student.nombre}`);

        try {
          // ✅ USAR null para análisis GENERAL (todos los cursos)
          const feedback = await generateAdaptiveFeedback(studentId, null);

          if (!feedback) {
            console.warn(`⚠️ No se pudo generar feedback para: ${student.nombre}`);
            continue;
          }

          // Obtener evolución temporal (todos los cursos)
          const evolutionData = await fetchStudentEvolution(studentId, null);

          const grupoNombre = student.grupo_id
            ? groups.find((g) => g.id === student.grupo_id)?.nombre || "Sin grupo"
            : "Sin grupo";

          studentsData.push({
            student,
            feedback,
            grupo: grupoNombre,
            evolution: evolutionData,
          });
        } catch (studentError) {
          console.error(`❌ Error analizando ${student.nombre}:`, studentError);
          continue;
        }
      }

      console.log(`✅ ${studentsData.length} estudiantes analizados exitosamente`);

      // Calcular estadísticas generales
      const completedCount = progressData.filter((p) => p.completado).length;
      const avgProgress = Math.round(
        progressData.reduce((sum, p) => sum + (p.progreso || 0), 0) / progressData.length
      );
      const totalTime = Math.round(
        progressData.reduce((sum, p) => sum + (p.tiempo_dedicado || 0), 0) / 60
      );
      const completionRate = Math.round(
        (completedCount / progressData.length) * 100
      );

      // Crear objeto del reporte de todos los cursos
      const reportObj = {
        course: {
          titulo: `ANÁLISIS GENERAL - ${Object.keys(courseMap).length} Cursos`,
          nivel: "Sistema Completo",
          color: "#8B5CF6",
          fecha: new Date().toLocaleDateString("es-ES", {
            weekday: "long",
            year: "numeric",
            month: "long",
            day: "numeric",
          }),
        },
        stats: {
          totalStudents: uniqueStudentIds.length,
          avgProgress,
          completedResources: completedCount,
          totalTime,
          completionRate,
        },
        students: studentsData,
        allCoursesStats: Object.values(courseMap)
          .sort((a, b) => b.data.length - a.data.length)
          .map((course) => {
            const courseStudents = new Set(course.data.map((p) => p.usuario_id)).size;
            const courseCompleted = course.data.filter((p) => p.completado).length;
            return {
              titulo: course.titulo,
              nivel: course.nivel,
              color: course.color,
              totalEstudiantes: courseStudents,
              totalRegistros: course.data.length,
              progresoPromedio: Math.round(
                course.data.reduce((sum, p) => sum + (p.progreso || 0), 0) / course.data.length
              ),
              completados: courseCompleted,
              completionRate: Math.round((courseCompleted / course.data.length) * 100),
            };
          }),
      };

      console.log("✅ Análisis de todos los cursos completado");
      setCourseReportData(reportObj);
      setShowCourseReportModal(true);
      setIsAnalyzingAllCourses(false);

    } catch (err) {
      console.error("❌ Error analizando todos los cursos:", err);
      alert(`❌ Error al generar el análisis general:\n\n${err.message}`);
      setIsAnalyzingAllCourses(false);
    }
  };

  // ✅ Función para generar texto del reporte (para descargar)
  const generateReportText = () => {
    if (!courseReportData) return "";

    let text = `
╔════════════════════════════════════════════════════════════════╗
║          REPORTE DETALLADO DE CURSO CON IA PREDICTIVA          ║
╚════════════════════════════════════════════════════════════════╝

📚 CURSO: ${courseReportData.course.titulo}
📅 FECHA: ${courseReportData.course.fecha}
🎯 NIVEL: ${courseReportData.course.nivel}
👥 ESTUDIANTES ANALIZADOS: ${courseReportData.stats.totalStudents}

═══════════════════════════════════════════════════════════════
                    ESTADÍSTICAS GENERALES
═══════════════════════════════════════════════════════════════

📊 Progreso Promedio General: ${courseReportData.stats.avgProgress}%
✅ Recursos Completados: ${courseReportData.stats.completedResources}
⏱️ Tiempo Total Dedicado: ${courseReportData.stats.totalTime} minutos
📈 Tasa de Completitud: ${courseReportData.stats.completionRate}%

`;

    courseReportData.students.forEach((data) => {
      const { student, feedback, grupo } = data;
      text += `
┌────────────────────────────────────────────────────────────┐
│ 👤 ESTUDIANTE: ${student.nombre.padEnd(45)} │
│ 📧 EMAIL: ${(student.email || "Sin email").padEnd(48)} │
│ 🏫 GRUPO: ${grupo.padEnd(48)} │
└────────────────────────────────────────────────────────────┘

🎯 ESTADO GENERAL: ${feedback.overallStatus}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 ANÁLISIS DE APRENDIZAJE (Learning Effectiveness Analysis)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   ❓ ¿Está aprendiendo realmente?  ${feedback.learningEffectiveness?.isLearning ? "✅ SÍ" : "❌ NO"
        }
   
   📊 Confianza del análisis:       ${feedback.learningEffectiveness?.confidence?.toFixed(1) || 0
        }%
   
   🔢 Indicadores:
      • Promedio de intentos:        ${feedback.learningEffectiveness?.indicators?.averageAttempts?.toFixed(
          1
        ) || 0
        }
      • Tiempo por pregunta:         ${feedback.learningEffectiveness?.indicators?.averageTimePerQuestion?.toFixed(
          0
        ) || 0
        } seg
      • Tasa de repetición:          ${feedback.learningEffectiveness?.indicators?.repetitionRate?.toFixed(
          1
        ) || 0
        }%
      • Tasa de retención:           ${feedback.learningEffectiveness?.indicators?.retentionRate?.toFixed(1) ||
        0
        }%
      • Tendencia de mejora:         ${(feedback.learningEffectiveness?.indicators?.improvementTrend || 0) >= 0
          ? "+"
          : ""
        }${feedback.learningEffectiveness?.indicators?.improvementTrend?.toFixed(
          1
        ) || 0
        }%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
👁️ ANÁLISIS DE ATENCIÓN EN CLASE (Attention Detection Algorithm)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   📊 Nivel de Atención:            ${feedback.attentionLevel?.level || "Sin datos"
        }
   
   🎯 Puntaje de Atención:          ${feedback.attentionLevel?.score || 0}/100
   
   🔍 Indicadores:
      • Períodos de inactividad:     ${feedback.attentionLevel?.indicators?.inactivityPeriods || 0
        }
      • Consistencia (desv. std):    ${feedback.attentionLevel?.indicators?.consistencyScore?.toFixed(1) || 0
        }
      • Índice de foco:              ${feedback.attentionLevel?.indicators?.focusIndex?.toFixed(1) || 0
        }/100

⚠️ ALERTAS DETECTADAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${feedback.learningEffectiveness?.alerts?.length > 0
          ? feedback.learningEffectiveness.alerts.map((a) => `   ${a}`).join("\n")
          : "   ✅ No hay alertas"
        }

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 FORTALEZAS IDENTIFICADAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${feedback.strengths?.length > 0
          ? feedback.strengths.map((s) => `   ✓ ${s}`).join("\n")
          : "   - Por desarrollar"
        }

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 ÁREAS DE MEJORA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${feedback.weaknesses?.length > 0
          ? feedback.weaknesses.map((w) => `   ✗ ${w}`).join("\n")
          : "   ✅ Ninguna identificada"
        }

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 RECOMENDACIONES PEDAGÓGICAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${feedback.recommendations?.length > 0
          ? feedback.recommendations.map((r) => `   → ${r}`).join("\n")
          : "   ✅ Continuar con el buen trabajo"
        }

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PLAN DE ACCIÓN SUGERIDO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
${feedback.actionPlan?.length > 0
          ? feedback.actionPlan.map((a) => `   ${a}`).join("\n")
          : "   ✅ Mantener el progreso actual"
        }

═══════════════════════════════════════════════════════════════

`;
    });

    text += `
═══════════════════════════════════════════════════════════════
                    CONCLUSIONES GENERALES
═══════════════════════════════════════════════════════════════

📊 ALGORITMOS DE IA UTILIZADOS:
   • LEA (Learning Effectiveness Analysis)
     → Analiza patrones de aprendizaje real vs memorización
     → Detecta comprensión profunda mediante intentos y tiempo
   
   • ADA (Attention Detection Algorithm)
     → Monitorea consistencia y concentración
     → Identifica períodos de distracción
   
   • AFS (Adaptive Feedback System)
     → Genera retroalimentación personalizada
     → Crea planes de acción individualizados

⚡ EVALUACIÓN GENERAL DEL CURSO:
${courseReportData.stats.avgProgress >= 70
        ? `   ✅ EXCELENTE: El curso muestra resultados positivos
   → Metodología efectiva
   → Estudiantes comprometidos
   → Continuar con el enfoque actual`
        : courseReportData.stats.avgProgress >= 50
          ? `   ⚠️ REGULAR: Hay espacio para mejoras
   → Revisar metodología de enseñanza
   → Implementar más actividades interactivas
   → Reforzar seguimiento individualizado`
          : `   🚨 CRÍTICO: Se requiere intervención urgente
   → Revisión completa de metodología
   → Reunión con equipo pedagógico
   → Implementar plan de mejora inmediato`
      }

═══════════════════════════════════════════════════════════════
           Generado por Didactikapp - IA Educativa
           Fecha: ${new Date().toLocaleString("es-ES")}
═══════════════════════════════════════════════════════════════
`;

    return text;
  };

  // Función para descargar el reporte
  const handleDownloadReport = () => {
    if (!courseReportData) return;

    try {
      // Crear contenido CSV correctamente formateado para Excel
      let csvRows = [];

      // 1. Título principal
      csvRows.push(['"REPORTE ANALÍTICO DE CURSO CON IA PREDICTIVA"']);
      csvRows.push([`"Curso: ${courseReportData.course.titulo.replace(/"/g, '""')}"`]);
      csvRows.push([`"Nivel: ${courseReportData.course.nivel.replace(/"/g, '""')}"`]);
      csvRows.push([`"Fecha: ${courseReportData.course.fecha}"`]);
      csvRows.push([]); // Línea en blanco

      // 2. Estadísticas generales
      csvRows.push(['"ESTADÍSTICAS GENERALES"']);
      csvRows.push([`"Total Estudiantes","${courseReportData.stats.totalStudents}"`]);
      csvRows.push([`"Progreso Promedio","${courseReportData.stats.avgProgress}%"`]);
      csvRows.push([`"Recursos Completados","${courseReportData.stats.completedResources}"`]);
      csvRows.push([`"Tiempo Total","${courseReportData.stats.totalTime} minutos"`]);
      csvRows.push([`"Tasa de Completitud","${courseReportData.stats.completionRate}%"`]);
      csvRows.push([]);

      // 3. Encabezados de estudiantes
      csvRows.push(['"ANÁLISIS DETALLADO POR ESTUDIANTE"']);
      csvRows.push([
        '"Nombre"', '"Email"', '"Grupo"', '"Estado General"',
        '"Aprendizaje (LEA)"', '"Confianza"', '"Atención (ADA)"', '"Score Atención"',
        '"Intentos Promedio"', '"Tiempo Respuesta"', '"Tasa Retención"', '"Mejora Tendencia"',
        '"Fortalezas"', '"Áreas Mejora"', '"Plan de Acción"'
      ]);

      // 4. Datos de estudiantes
      courseReportData.students.forEach((data) => {
        const { student, feedback, grupo } = data;

        // Escapar comillas dobles para CSV
        const escapeCSV = (text) => text ? `"${String(text).replace(/"/g, '""')}"` : '""';

        csvRows.push([
          escapeCSV(student.nombre),
          escapeCSV(student.email),
          escapeCSV(grupo),
          escapeCSV(feedback.overallStatus),
          escapeCSV(feedback.learningEffectiveness?.isLearning ? "Sí" : "No"),
          feedback.learningEffectiveness?.confidence?.toFixed(1) || 0,
          escapeCSV(feedback.attentionLevel?.level || "Sin datos"),
          feedback.attentionLevel?.score || 0,
          feedback.learningEffectiveness?.indicators?.averageAttempts?.toFixed(2) || 0,
          feedback.learningEffectiveness?.indicators?.averageTimePerQuestion?.toFixed(0) || 0,
          feedback.learningEffectiveness?.indicators?.retentionRate?.toFixed(1) || 0,
          feedback.learningEffectiveness?.indicators?.improvementTrend?.toFixed(1) || 0,
          escapeCSV(feedback.strengths?.join("; ") || "N/A"),
          escapeCSV(feedback.weaknesses?.join("; ") || "N/A"),
          escapeCSV(feedback.actionPlan?.join("; ") || "N/A")
        ]);
      });

      // 5. Leyenda
      csvRows.push([]);
      csvRows.push(['"LEYENDA DE INDICADORES"']);
      csvRows.push(['"LEA"', '"Learning Effectiveness Analysis - Detecta aprendizaje real"']);
      csvRows.push(['"ADA"', '"Attention Detection Algorithm - Analiza concentración"']);
      csvRows.push(['"AFS"', '"Adaptive Feedback System - Sistema de retroalimentación"']);
      csvRows.push([]);
      csvRows.push([`"Generado por Didaktikapp - ${new Date().toLocaleString('es-ES')}"`]);

      // Convertir a CSV
      const csvContent = csvRows.map(row => row.join(',')).join('\n');

      // Agregar BOM para UTF-8 (evita problemas con caracteres especiales en Excel)
      const blob = new Blob(['\uFEFF' + csvContent], {
        type: 'text/csv;charset=utf-8;'
      });

      // Crear link de descarga
      const link = document.createElement('a');
      const url = URL.createObjectURL(blob);
      link.setAttribute('href', url);
      link.setAttribute('download', `Reporte_${courseReportData.course.titulo.replace(/[^a-z0-9]/gi, '_')}_${new Date().toISOString().split('T')[0]}.csv`);
      link.style.visibility = 'hidden';

      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);

      alert('✅ Reporte exportado correctamente. Se abrirá en Excel.');

    } catch (error) {
      console.error('Error descargando reporte:', error);
      alert('❌ Error al descargar el reporte: ' + error.message);
    }
  };

  // Función para imprimir el reporte
  const handlePrintReport = () => {
    window.print();
  };

  useEffect(() => {
    let timeoutId1, timeoutId2, timeoutId3;
    let repeatInterval = null;
    let isMounted = true;

    if (!previewQuiz) {
      console.log('🔇 Modal cerrado, limpiando recursos...');
      if (window.speechSynthesis) {
        window.speechSynthesis.cancel();
      }
      return;
    }

    if (!currentQuiz?.preguntas?.length) return;

    const question = currentQuiz.preguntas[currentPreviewQuestion];
    if (!question) return;

    const answer = previewAnswers[currentPreviewQuestion];
    const attempts = attemptCount[currentPreviewQuestion] || 0;

    if (answer || attempts >= 3) return;

    console.log('🎤 Iniciando secuencia de audio para pregunta:', question.pregunta?.substring(0, 30));

    const executeAudioSequence = () => {
      if (!isMounted || !previewQuiz || answer || attempts >= 3) return;

      // PRIMERO: "Responde la pregunta"
      timeoutId1 = setTimeout(() => {
        if (isMounted && previewQuiz && !answer && attempts < 3) {
          speakText("Responde la pregunta");
        }
      }, 300);

      // SEGUNDO: Pregunta completa
      timeoutId2 = setTimeout(() => {
        if (isMounted && previewQuiz && !answer && attempts < 3 && question?.pregunta) {
          speakText(question.pregunta);
        }
      }, 2000);

      // TERCERO: Opciones enumeradas
      timeoutId3 = setTimeout(() => {
        if (isMounted && previewQuiz && !answer && attempts < 3 && question?.opciones) {
          let opcionesTexto = "Las opciones son: ";
          question.opciones.forEach((opcion, idx) => {
            if (opcion) {
              opcionesTexto += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
            }
          });
          speakText(opcionesTexto);
        }
      }, 4000);

      // Esperar a que termine la locución (12 segundos) ANTES de iniciar el intervalo
      setTimeout(() => {
        // Solo crear el intervalo si aún no ha respondido
        if (!answer && attempts < 3 && isMounted && previewQuiz) {
          repeatInterval = setInterval(() => {
            const currentAnswer = previewAnswers[currentPreviewQuestion];
            const currentAttempts = attemptCount[currentPreviewQuestion] || 0;

            if (isMounted && previewQuiz && !currentAnswer && currentAttempts < 3) {
              console.log('🔄 Repitiendo pregunta (intervalo de 15s)');
              speakText("Recuerda responder la pregunta");

              setTimeout(() => {
                if (isMounted && previewQuiz && !currentAnswer && currentAttempts < 3) {
                  speakText(question.pregunta);
                }
              }, 1000);

              setTimeout(() => {
                if (isMounted && previewQuiz && !currentAnswer && currentAttempts < 3 && question?.opciones) {
                  let opcionesTexto = "Las opciones son: ";
                  question.opciones.forEach((opcion, idx) => {
                    if (opcion) {
                      opcionesTexto += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
                    }
                  });
                  speakText(opcionesTexto);
                }
              }, 3000);
            } else if (!previewQuiz) {
              if (repeatInterval) {
                clearInterval(repeatInterval);
                repeatInterval = null;
              }
            }
          }, 15000);
        }
      }, 12000); // Esperar 12 segundos (tiempo total de la locución inicial)
    };

    executeAudioSequence();

    return () => {
      console.log('🧹 LIMPIANDO: Cerrando useEffect del quiz');
      isMounted = false;

      if (timeoutId1) clearTimeout(timeoutId1);
      if (timeoutId2) clearTimeout(timeoutId2);
      if (timeoutId3) clearTimeout(timeoutId3);

      if (repeatInterval) {
        clearInterval(repeatInterval);
        repeatInterval = null;
      }

      if (window.speechSynthesis) {
        try {
          window.speechSynthesis.cancel();
          window.speechSynthesis.pause();
        } catch (e) {
          console.warn('Error deteniendo speech:', e);
        }
      }

      if (typeof audioQueue !== 'undefined') {
        audioQueue = [];
      }
      if (typeof isPlaying !== 'undefined') {
        isPlaying = false;
      }
    };
  }, [previewQuiz, currentPreviewQuestion, previewAnswers, attemptCount, currentQuiz.preguntas]);

  // Este se ejecuta cuando el usuario SELECCIONA una opción
  useEffect(() => {
    if (selectedOption === null || !previewQuiz) return;

    const question = currentQuiz.preguntas[currentPreviewQuestion];
    const opcionTexto = question.opciones[selectedOption];

    // Leer la opción seleccionada después de 500ms
    const timeoutId = setTimeout(() => {
      console.log('🎙️ Usuario seleccionó:', opcionTexto);
      speakText(`Has seleccionado: ${opcionTexto}`);
    }, 500);

    return () => clearTimeout(timeoutId);
  }, [selectedOption, previewQuiz, currentPreviewQuestion, currentQuiz.preguntas]);


  // Este se ejecuta cuando el usuario RESPONDE (click en Revisar)
  useEffect(() => {
    // Si hay una respuesta guardada, leer retroalimentación
    const answer = previewAnswers[currentPreviewQuestion];
    if (!answer || !previewQuiz) return;

    const question = currentQuiz.preguntas[currentPreviewQuestion];

    setTimeout(() => {
      if (answer.isCorrect) {
        console.log('✅ Respuesta correcta');
        speakText('¡Excelente! Respuesta correcta');
      } else {
        console.log('❌ Respuesta incorrecta');
        speakText('Vamos a aprender juntos. Respuesta correcta: ' + question.opciones[question.respuesta_correcta]);
      }
    }, 500);
  }, [previewAnswers, previewQuiz, currentPreviewQuestion, currentQuiz.preguntas]);

  //  COMPONENTE: Instrucción con Audio (NUEO)
  useEffect(() => {
    if (!previewQuiz || !selectedOption) return;

    // Cuando se selecciona una opción, leer instrucción
    const question = currentQuiz.preguntas[currentPreviewQuestion];
    const opcionTexto = question.opciones[selectedOption];

    setTimeout(() => {
      console.log('🎙️ Leyendo opción seleccionada...');
      speakText(`Has seleccionado: ${opcionTexto}`);
    }, 500);
  }, [selectedOption, previewQuiz]);

  // Efecto para repetición automática en el Generador de Contenido
  useEffect(() => {
    if (!showContentPreview || !editingGeneratedQuiz) return;

    const questions = editingGeneratedQuiz.preguntas ||
      editingGeneratedQuiz.content?.questions || [];
    if (questions.length === 0) return;

    const currentQuestion = questions[quizPreviewIndex];
    if (!currentQuestion) return;

    const normalizedQuestion = {
      pregunta: currentQuestion.pregunta || currentQuestion.text || '',
      opciones: currentQuestion.opciones || currentQuestion.options || [],
      respuesta_correcta: currentQuestion.respuesta_correcta ?? currentQuestion.correct ?? 0,
    };

    const answer = quizPreviewAnswers[quizPreviewIndex];
    const attempts = attemptCount[quizPreviewIndex] || 0;

    let timeoutId1, timeoutId2, timeoutId3;

    const executeAudioSequence = () => {
      // Solo si no ha respondido y no ha agotado intentos
      if (answer || attempts >= 3) return;

      // PRIMERO: "Responde la pregunta"
      timeoutId1 = setTimeout(() => {
        speakText("Responde la pregunta");
      }, 300);

      // SEGUNDO: Pregunta completa
      timeoutId2 = setTimeout(() => {
        speakText(normalizedQuestion.pregunta);
      }, 2000);

      // TERCERO: Opciones enumeradas
      timeoutId3 = setTimeout(() => {
        let opcionesTexto = "Las opciones son: ";
        normalizedQuestion.opciones.forEach((opcion, idx) => {
          opcionesTexto += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
        });
        speakText(opcionesTexto);
      }, 4000);

      // REPETIR CADA 15 SEGUNDOS si no ha respondido
      const repeatInterval = setInterval(() => {
        if (!answer && attempts < 3) {
          speakText("Recuerda responder la pregunta");
          setTimeout(() => {
            speakText(normalizedQuestion.pregunta);
            setTimeout(() => {
              let opcionesTexto = "Las opciones son: ";
              normalizedQuestion.opciones.forEach((opcion, idx) => {
                opcionesTexto += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
              });
              speakText(opcionesTexto);
            }, 2000);
          }, 1000);
        } else {
          clearInterval(repeatInterval);
        }
      }, 15000);

      return () => clearInterval(repeatInterval);
    };

    const cleanup = executeAudioSequence();

    return () => {
      clearTimeout(timeoutId1);
      clearTimeout(timeoutId2);
      clearTimeout(timeoutId3);
      if (cleanup) cleanup();
      window.speechSynthesis.cancel();
    };
  }, [showContentPreview, editingGeneratedQuiz, quizPreviewIndex, quizPreviewAnswers, attemptCount]);

  //  QUIZ REDISEÑADO PARA NIÑOS
  const renderQuestionPreview = () => {
    console.log('🎨 Renderizando vista previa...');
    console.log('currentQuiz:', currentQuiz);
    console.log('preguntas:', currentQuiz?.preguntas);

    if (!currentQuiz?.preguntas || currentQuiz.preguntas.length === 0) {
      console.log('❌ No hay preguntas en currentQuiz');
      return (
        <div className="text-center py-12">
          <AlertCircle className="w-16 h-16 text-yellow-500 mx-auto mb-4" />
          <p className="text-gray-600">⚠️ Este quiz no tiene preguntas aún.</p>
          <p className="text-sm text-gray-500 mt-2">Edita el quiz para agregar preguntas.</p>
        </div>
      );
    }

    const question = currentQuiz.preguntas[currentPreviewQuestion];
    if (!question) {
      console.log('❌ No se encontró la pregunta actual');
      return (
        <div className="text-center py-12">
          <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <p className="text-gray-600">Error: No se pudo cargar la pregunta</p>
        </div>
      );
    }

    console.log('✅ Mostrando pregunta:', question.pregunta);

    // Normalizar la pregunta
    const normalizedQuestion = {
      pregunta: question.pregunta || question.text || '',
      opciones: question.opciones || question.options || [],
      respuesta_correcta: question.respuesta_correcta ?? question.correct ?? 0,
      puntos: question.puntos || question.points || 10,
      retroalimentacion_correcta: question.retroalimentacion_correcta || question.feedback_correct || '¡Excelente! 🎉',
      retroalimentacion_incorrecta: question.retroalimentacion_incorrecta || question.feedback_incorrect || '¡Intenta otra vez! 💪',
      audio_pregunta: question.audio_pregunta !== false,
      audio_retroalimentacion: question.audio_retroalimentacion !== false,
      video_url: question.video_url || '',
      imagen_url: question.imagen_url || question.image_url || '',
      imagen_opciones: question.imagen_opciones || question.image_options || [],
      tiempo_limite: question.tiempo_limite ?? question.timeLimit ?? 0,
    };

    const answer = previewAnswers[currentPreviewQuestion];
    const attempts = attemptCount[currentPreviewQuestion] || 0;
    const maxAttempts = 3;

    // Función para manejar la selección de respuesta
    const handleAnswer = (selectedIdx) => {
      if (answer?.isCorrect || attempts >= maxAttempts) return;

      const isCorrect = selectedIdx === normalizedQuestion.respuesta_correcta;
      const newAttempts = attempts + 1;

      setAttemptCount(prev => ({ ...prev, [currentPreviewQuestion]: newAttempts }));

      setPreviewAnswers(prev => ({
        ...prev,
        [currentPreviewQuestion]: {
          selected: selectedIdx,
          isCorrect: isCorrect,
          attempts: newAttempts,
          showCorrect: newAttempts >= maxAttempts && !isCorrect
        }
      }));

      // Feedback de voz
      if (isCorrect) {
        speakText(normalizedQuestion.retroalimentacion_correcta);
      } else if (newAttempts >= maxAttempts) {
        speakText(`La respuesta correcta es: ${normalizedQuestion.opciones[normalizedQuestion.respuesta_correcta]}`);
      } else {
        speakText(`${normalizedQuestion.retroalimentacion_incorrecta} Te quedan ${maxAttempts - newAttempts} intentos`);
      }
    };

    // Determinar estado de Karin
    const getKarinState = () => {
      if (answer?.isCorrect) return { state: "happy", message: "¡Excelente! Respuesta correcta 🎉" };
      if (answer && !answer.isCorrect && attempts >= maxAttempts) return { state: "encourage", message: "No te preocupes, sigamos aprendiendo 💚" };
      if (attempts > 0 && attempts < maxAttempts) return { state: "thinking", message: `Te quedan ${maxAttempts - attempts} intentos. ¡Tú puedes! 💪` };
      return { state: "idle", message: "Escucha la pregunta y elige la respuesta correcta" };
    };

    const repeatQuestionWithOptions = () => {
      let fullText = `La pregunta es: ${normalizedQuestion.pregunta}. Las opciones son: `;
      normalizedQuestion.opciones.forEach((opcion, idx) => {
        fullText += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
      });
      speakText(fullText);
    };

    const karin = getKarinState();

    return (
      <div className="bg-[#F7F9FC] rounded-3xl p-6 min-h-[600px] flex flex-col">
        {/* HEADER: KARIN + PROGRESO */}
        <div className="flex justify-between items-start mb-6">
          <KarinMascot state={karin.state} message={karin.message} />
          <div className="bg-white rounded-full px-5 py-2 shadow-sm border text-sm font-bold">
            {currentPreviewQuestion + 1} / {currentQuiz.preguntas.length}
          </div>
        </div>

        {/* BARRA DE PROGRESO */}
        <div className="flex gap-2 mb-8">
          {currentQuiz.preguntas.map((_, idx) => (
            <div
              key={idx}
              className={`flex-1 h-2 rounded-full transition-all ${idx === currentPreviewQuestion ? "bg-blue-500" : idx < currentPreviewQuestion ? "bg-green-400" : "bg-gray-200"}`}
            />
          ))}
        </div>

        {/* CONTADOR DE INTENTOS */}
        {attempts > 0 && (
          <div className="bg-yellow-100 border-2 border-yellow-300 rounded-xl p-4 mb-4 text-center">
            <p className="text-lg font-bold text-yellow-800">🎯 Intentos: {attempts} / {maxAttempts}</p>
            <div className="flex gap-2 justify-center mt-2">
              {[...Array(maxAttempts)].map((_, i) => (
                <div key={i} className={`w-8 h-8 rounded-full ${i < attempts ? (answer?.isCorrect ? 'bg-green-400' : 'bg-red-400') : 'bg-gray-300'}`} />
              ))}
            </div>
          </div>
        )}

        {/* PREGUNTA */}
        {/* PREGUNTA - SIN EMOJI */}
        <div className="bg-white rounded-3xl shadow-sm p-8 mb-8 border">
          <div className="flex items-center gap-4 justify-center">
            {normalizedQuestion.audio_pregunta && (
              <button
                onClick={() => speakText(normalizedQuestion.pregunta)}
                className="bg-blue-500 hover:bg-blue-600 text-white p-4 rounded-full transition shadow-md hover:shadow-lg"
              >
                🔊
              </button>
            )}
            {/* ✅ ELIMINADO: {normalizedQuestion.imagen_url && ( ... )} */}
            <p className="text-3xl font-bold text-gray-800 text-center flex-1">
              {normalizedQuestion.pregunta}
            </p>
          </div>
          <div className="mt-6 text-center">
            <button
              onClick={repeatQuestionWithOptions}
              className="bg-blue-100 hover:bg-blue-200 text-blue-800 px-6 py-3 rounded-xl font-bold flex items-center gap-2 mx-auto transition-all hover:scale-105"
            >
              <RefreshCw className="w-5 h-5" />
              Repetir Pregunta y Opciones
            </button>
          </div>
        </div>

        {/* OPCIONES */}
        <div className="grid grid-cols-1 gap-4 max-w-3xl mx-auto w-full">
          {normalizedQuestion.opciones.map((opcion, idx) => {
            const isSelected = answer?.selected === idx;
            const isCorrectOption = idx === normalizedQuestion.respuesta_correcta;
            const showAsCorrect = answer?.showCorrect && isCorrectOption;
            const isDisabled = answer?.isCorrect || attempts >= maxAttempts;
            const emojiOpcion = normalizedQuestion.imagen_opciones?.[idx] || ['🅰️', '🅱️', '🅲️', '🅳️'][idx];

            return (
              <div
                key={idx}
                onClick={() => !isDisabled && handleAnswer(idx)}
                className={`p-5 rounded-2xl text-xl font-semibold border transition-all flex items-center gap-4 cursor-pointer ${showAsCorrect ? 'bg-green-50 border-green-400 ring-4 ring-green-200' : isDisabled && answer?.isCorrect && isSelected ? 'bg-green-100 border-green-500 ring-4 ring-green-200' : isDisabled && !isCorrectOption ? 'bg-gray-100 border-gray-300 opacity-50' : isSelected && !answer?.isCorrect ? 'bg-red-100 border-red-400 ring-4 ring-red-200' : 'bg-white border-gray-300 hover:bg-blue-50 hover:border-blue-400'}`}
              >
                <span className="text-5xl flex-shrink-0 drop-shadow-sm">{emojiOpcion}</span>
                <span className="flex-1">{opcion}</span>
                {showAsCorrect && <span className="text-3xl animate-bounce flex-shrink-0 ml-2">✅</span>}
                {isSelected && answer?.isCorrect && <span className="text-3xl animate-bounce flex-shrink-0 ml-2">🎉</span>}
                {isSelected && !answer?.isCorrect && <span className="text-3xl flex-shrink-0 ml-2">❌</span>}
              </div>
            );
          })}
        </div>

        {/* RETROALIMENTACIÓN Y BOTONES */}
        {answer && (
          <div className="mt-8 max-w-2xl mx-auto w-full space-y-4">
            <div className={`rounded-2xl p-6 text-center border-4 shadow-2xl ${answer.isCorrect ? "bg-green-100 border-green-400 animate-pulse" : attempts >= maxAttempts ? "bg-orange-100 border-orange-400" : "bg-red-100 border-red-400"}`}>
              <p className="text-5xl font-black mb-3">{answer.isCorrect ? "🎉" : attempts >= maxAttempts ? "💡" : "💪"}</p>
              <p className="text-3xl font-black mb-2">
                {answer.isCorrect ? "¡CORRECTO!" : attempts >= maxAttempts ? "VAMOS A APRENDER" : "¡INTENTA DE NUEVO!"}
              </p>
              <p className="text-lg font-bold text-gray-800 mb-4">
                {answer.isCorrect ? normalizedQuestion.retroalimentacion_correcta : attempts >= maxAttempts ? `La respuesta correcta es: ${normalizedQuestion.opciones[normalizedQuestion.respuesta_correcta]}` : `Te quedan ${maxAttempts - attempts} intentos.`}
              </p>
            </div>

            <button onClick={() => {
              if (currentPreviewQuestion < currentQuiz.preguntas.length - 1) {
                setCurrentPreviewQuestion(currentPreviewQuestion + 1);
                setPreviewAnswers(prev => ({ ...prev, [currentPreviewQuestion + 1]: undefined }));
                setAttemptCount(prev => ({ ...prev, [currentPreviewQuestion + 1]: 0 }));
              } else {
                const correctas = Object.values(previewAnswers).filter(a => a?.isCorrect).length;
                alert(`🎉 Quiz completado!\n✅ Correctas: ${correctas}/${currentQuiz.preguntas.length}\n📊 Puntuación: ${Math.round((correctas / currentQuiz.preguntas.length) * 100)}%`);
                closePreview();
              }
            }} className="w-full bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white py-4 rounded-2xl text-xl font-bold transition flex items-center justify-center gap-2 shadow-lg">
              {currentPreviewQuestion === currentQuiz.preguntas.length - 1 ? <><Trophy className="w-6 h-6" /> Finalizar Quiz</> : <>Siguiente Pregunta →</>}
            </button>
          </div>
        )}

        {/* NAVEGACIÓN */}
        <div className="flex justify-between mt-10 gap-4">
          <button disabled={currentPreviewQuestion === 0} onClick={() => {
            setCurrentPreviewQuestion(currentPreviewQuestion - 1);
            setPreviewAnswers(prev => ({ ...prev, [currentPreviewQuestion - 1]: undefined }));
            setAttemptCount(prev => ({ ...prev, [currentPreviewQuestion - 1]: 0 }));
          }} className="flex-1 py-3 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-xl font-bold disabled:opacity-40">
            ← Anterior
          </button>
          {!answer && (
            <button disabled={currentPreviewQuestion === currentQuiz.preguntas.length - 1} onClick={() => {
              setCurrentPreviewQuestion(currentPreviewQuestion + 1);
              setPreviewAnswers(prev => ({ ...prev, [currentPreviewQuestion + 1]: undefined }));
              setAttemptCount(prev => ({ ...prev, [currentPreviewQuestion + 1]: 0 }));
            }} className="flex-1 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-bold disabled:opacity-40">
              Saltar Pregunta →
            </button>
          )}
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

    // RECOMENDACIÓN 1: GENERADOR DE CONTENIDO
    recommendations.push({
      type: "ai_generator",
      title: "Generador de Contenido con IA",
      description: `Crea Quiz, Juegos y Ejercicios.`,
      priority: "high",
      action: "Abrir Generador",
      targetTab: "dashboard",
      icon: Sparkles,
      action_type: "open_generator",
    });

    // Recomendación para crear más quizzes
    if ((resourceTypes.quiz || 0) < 3) {
      recommendations.push({
        type: "content_gap",
        title: "Crear Más Quizzes",
        description: `Solo tienes ${resourceTypes.quiz || 0} quizzes. Genera más con IA en segundos.`,
        priority: "high",
        action: "Generar",
        targetTab: "resources",
        icon: Brain,
        action_type: "open_generator",
      });
    }

    // Recomendación de compromiso
    if (analytics.engagementRate < 50) {
      recommendations.push({
        type: "engagement",
        title: "Baja Tasa de Compromiso",
        description: `${analytics.engagementRate}%. Aumenta con quizzes interactivos y gamificación.`,
        priority: "high",
        action: "Mejorar",
        targetTab: "resources",
        icon: TrendingUp,
      });
    }

    // Usuarios inactivos
    const inactiveUsers = users.filter((u) => {
      if (!u.ultimo_acceso) return true;
      const lastAccess = new Date(u.ultimo_acceso);
      const daysSinceAccess = (Date.now() - lastAccess) / (1000 * 60 * 60 * 24);
      return daysSinceAccess > 7;
    }).length;

    if (inactiveUsers > 0) {
      recommendations.push({
        type: "retention",
        title: "👥 Reactivar Estudiantes",
        description: `${inactiveUsers} estudiantes inactivos. Envía contenido motivacional.`,
        priority: "medium",
        action: "Revisar",
        targetTab: "users",
        icon: UserX,
      });
    }

    return recommendations;
  };

  // ASISTENTE IA - FUNCIÓN PRINCIPAL
  const handleAIChat = async (userMessage) => {
    if (!userMessage.trim()) return;

    const newUserMessage = {
      id: Date.now(),
      role: "user",
      content: userMessage,
      timestamp: new Date(),
    };

    setChatMessages((prev) => [...prev, newUserMessage]);
    setChatInput("");
    setChatLoading(true);

    const apiKey = import.meta.env.VITE_GROQ_API_KEY;

    if (!apiKey) {
      const errorMsg = {
        id: Date.now() + 1,
        role: "assistant",
        content: "❌ Error: API key de Groq no configurada. Verifica tu .env",
        timestamp: new Date(),
      };
      setChatMessages((prev) => [...prev, errorMsg]);
      setChatLoading(false);
      return;
    }

    try {
      const response = await fetch(
        "https://api.groq.com/openai/v1/chat/completions",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${apiKey}`,
          },
          body: JSON.stringify({
            model: "llama-3.1-8b-instant",
            messages: [
              {
                role: "system",
                content: `Eres un asistente educativo experto en DidactikApp. Tu objetivo es ayudar a docentes de educación básica a optimizar su monitoreo académico.

              Contexto actual de la plataforma:
              - Usuarios: ${users.length}
              - Cursos activos: ${courses.length}
              - Recursos didácticos: ${resources.length}
              - Tasa de engagement: ${analytics.engagementRate}%`,
              },
              {
                role: "user",
                content: userMessage,
              },
            ],
            temperature: 0.7,
            max_tokens: 800,
          }),
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        const errorMessage = errorData.error?.message || response.statusText;
        throw new Error(errorMessage);
      }

      const data = await response.json();

      const aiResponse =
        data.choices?.[0]?.message?.content ||
        "Lo siento, no pude procesar una respuesta en este momento.";

      const aiMessage = {
        id: Date.now() + 1,
        role: "assistant",
        content: aiResponse,
        timestamp: new Date(),
      };

      setChatMessages((prev) => [...prev, aiMessage]);
    } catch (error) {
      console.error("Error en DidactikApp AI:", error);

      const errorMsg = {
        id: Date.now() + 1,
        role: "assistant",
        content: `⚠️ Error de conexión: ${error.message}. Verifica Groq o tu API key.`,
        timestamp: new Date(),
      };

      setChatMessages((prev) => [...prev, errorMsg]);
    } finally {
      setChatLoading(false);
    }
  };

  const clearChat = () => {
    setChatMessages([]);
    setChatInput("");
  };

  const handleLogout = async () => {
    await supabase.auth.signOut();
    navigate("/");
  };

  const getRoleBadgeColor = (rol) => {
    const colors = {
      admin: "bg-red-100 text-red-800 border-red-200",
      docente: "bg-blue-100 text-blue-800 border-blue-200",
      estudiante: "bg-green-100 text-green-800 border-green-200",
      visitante: "bg-gray-100 text-gray-800 border-gray-200",
    };
    return colors[rol] || "bg-gray-100 text-gray-800 border-gray-200";
  };

  // RENDERIZADOR INTERACTIVO DE CONTENIDO
  const renderInteractiveContent = () => {
    if (!viewingContent || !editingContent) return null;

    const type = contentTypes.find(c => c.id === viewingContent.type);

    return (
      <div className="fixed inset-0 bg-black bg-opacity-70 z-[60] flex items-center justify-center p-4 overflow-y-auto">
        <div className="bg-white rounded-3xl max-w-6xl w-full max-h-[95vh] overflow-hidden shadow-2xl my-8">
          {/* HEADER */}
          <div className={`sticky top-0 z-10 bg-gradient-to-r ${type?.color} text-white p-6`}>
            <div className="flex justify-between items-start">
              <div className="flex-1">
                <div className="flex items-center gap-3 mb-2">
                  <span className="text-5xl">{type?.icon}</span>
                  <div>
                    <h2 className="text-2xl font-bold">{viewingContent.title}</h2>
                    <p className="text-sm text-white text-opacity-90">
                      {type?.name} • {viewingContent.createdAt}
                    </p>
                  </div>
                </div>
              </div>
              <button
                onClick={() => {
                  setShowContentViewer(false);
                  setViewingContent(null);
                  setEditingContent(null);
                  setGameState(null);
                  setStoryPage(0);
                  setChallengeProgress({});
                  setExerciseAnswers({});
                }}
                className="bg-white bg-opacity-20 hover:bg-opacity-30 p-2 rounded-lg transition-colors"
              >
                <X className="w-6 h-6" />
              </button>
            </div>
          </div>

          {/* CONTENIDO ESPECÍFICO */}
          <div className="overflow-y-auto max-h-[calc(95vh-250px)] p-6">
            {/* QUIZ INTERACTIVO Y EDITABLE */}
            {viewingContent.type === 'quiz' && (
              <div className="space-y-6">
                {/* Header con botón guardar todo */}
                <div className="flex justify-between items-center bg-blue-50 rounded-xl p-4 border-2 border-blue-200">
                  <div>
                    <h3 className="text-xl font-bold text-gray-800">📝 Editor de Quiz</h3>
                    <p className="text-sm text-gray-600">Haz clic en "Editar" en cualquier pregunta para modificarla</p>
                  </div>
                  <button
                    onClick={() => {
                      if (editingCompleteQuiz) {
                        saveEditedContent();
                      } else {
                        setEditingCompleteQuiz(true);
                      }
                    }}
                    disabled={savingChanges}
                    className={`px-6 py-3 rounded-xl font-bold text-white transition-all flex items-center gap-2 ${savingChanges
                      ? 'bg-gray-400 cursor-not-allowed'
                      : editingCompleteQuiz
                        ? 'bg-green-500 hover:bg-green-600'
                        : 'bg-blue-500 hover:bg-blue-600'
                      }`}
                  >
                    {savingChanges ? (
                      <>
                        <RefreshCw className="w-5 h-5 animate-spin" />
                        Guardando...
                      </>
                    ) : editingCompleteQuiz ? (
                      <>
                        <Save className="w-5 h-5" />
                        Guardar Todo
                      </>
                    ) : (
                      <>
                        <Edit2 className="w-5 h-5" />
                        Modo Edición
                      </>
                    )}
                  </button>
                </div>

                {/* Stats */}
                <div className="grid grid-cols-3 gap-4 bg-blue-50 rounded-xl p-6 border-2 border-blue-200">
                  <div className="text-center">
                    <p className="text-4xl font-bold text-blue-600">
                      {editingContent.content.questions?.length || 0}
                    </p>
                    <p className="text-sm text-gray-600 mt-1">Preguntas</p>
                  </div>
                  <div className="text-center">
                    <p className="text-4xl font-bold text-green-600">
                      {editingContent.content.totalPoints ||
                        (editingContent.content.questions?.length * 10) || 0}
                    </p>
                    <p className="text-sm text-gray-600 mt-1">Puntos Totales</p>
                  </div>
                  <div className="text-center">
                    <p className="text-4xl font-bold text-orange-600">
                      {editingContent.content.timeLimit || 0}s
                    </p>
                    <p className="text-sm text-gray-600 mt-1">Tiempo Límite</p>
                  </div>
                </div>

                {/* Lista de preguntas */}
                <div className="space-y-4">
                  {editingContent.content.questions?.map((question, qIdx) => (
                    <div key={qIdx} className="bg-white rounded-xl p-6 border-2 border-blue-200 shadow-md hover:shadow-lg transition-all">
                      <div className="flex items-start gap-4">
                        <div className="w-10 h-10 bg-blue-500 text-white rounded-full flex items-center justify-center font-bold flex-shrink-0">
                          {qIdx + 1}
                        </div>
                        {(question.imagen_url || question.image_url) && (
                          <div className="text-5xl">{question.imagen_url || question.image_url}</div>
                        )}
                        <div className="flex-1">
                          <h3 className="font-bold text-lg text-gray-800">
                            {question.pregunta || question.text}
                          </h3>
                          <p className="text-xs text-gray-500 mt-1">
                            ⭐ {question.puntos || 10} puntos
                            {(question.tiempo_limite || question.timeLimit) > 0 && (
                              <> • ⏱️ {question.tiempo_limite || question.timeLimit}s</>
                            )}
                          </p>
                        </div>
                        <button
                          onClick={() => {
                            // Abrir modal de edición con una copia de la pregunta
                            setEditingQuestionModal({
                              quizIndex: qIdx,
                              question: JSON.parse(JSON.stringify(question)),
                              originalIndex: qIdx
                            });
                          }}
                          className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg font-bold flex items-center gap-2 transition-all"
                        >
                          <Edit2 className="w-4 h-4" />
                          Editar
                        </button>
                      </div>

                      <div className="space-y-2 mt-4">
                        {(question.opciones || question.options)?.map((option, oIdx) => (
                          <div
                            key={oIdx}
                            className={`px-4 py-3 rounded-lg font-medium flex items-center gap-3 ${(question.respuesta_correcta ?? question.correct) === oIdx
                              ? "bg-green-100 border-2 border-green-500 text-green-800"
                              : "bg-gray-100 border-2 border-gray-200"
                              }`}
                          >
                            <span className="text-2xl">
                              {(question.imagen_opciones || question.image_options || [])[oIdx] || '🎨'}
                            </span>
                            <span className="flex-1">
                              {String.fromCharCode(65 + oIdx)}) {option}
                            </span>
                            {(question.respuesta_correcta ?? question.correct) === oIdx && (
                              <span className="text-2xl">✓</span>
                            )}
                          </div>
                        ))}
                      </div>

                      {(question.explanation || question.retroalimentacion_correcta) && (
                        <div className="bg-blue-50 p-4 rounded-lg border-l-4 border-blue-500 mt-4">
                          <p className="text-sm text-gray-700">
                            <strong>💡 Explicación:</strong> {question.explanation || question.retroalimentacion_correcta}
                          </p>
                        </div>
                      )}
                    </div>
                  ))}
                </div>

                {/* Modal de edición de pregunta */}
                {editingQuestionModal && (
                  <div className="fixed inset-0 bg-black bg-opacity-60 z-[70] flex items-center justify-center p-4 overflow-y-auto">
                    <div className="bg-white rounded-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto shadow-2xl">
                      {/* Header del modal */}
                      <div className="sticky top-0 bg-gradient-to-r from-blue-600 to-blue-500 text-white p-4 rounded-t-2xl flex justify-between items-center">
                        <h3 className="text-xl font-bold">✏️ Editar Pregunta {editingQuestionModal.quizIndex + 1}</h3>
                        <button
                          onClick={() => setEditingQuestionModal(null)}
                          className="bg-white bg-opacity-20 hover:bg-opacity-30 p-2 rounded-lg"
                        >
                          <X className="w-6 h-6" />
                        </button>
                      </div>

                      {/* Formulario de edición */}
                      <div className="p-6 space-y-4">
                        {/* Texto de la pregunta */}
                        <div>
                          <label className="block text-sm font-bold text-gray-700 mb-2">📝 Texto de la pregunta</label>
                          <textarea
                            value={editingQuestionModal.question.pregunta || editingQuestionModal.question.text || ''}
                            onChange={(e) => setEditingQuestionModal({
                              ...editingQuestionModal,
                              question: { ...editingQuestionModal.question, pregunta: e.target.value, text: e.target.value }
                            })}
                            className="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
                            rows="3"
                          />
                        </div>

                        {/* Imagen/Emoji de la pregunta */}
                        <div>
                          <label className="block text-sm font-bold text-gray-700 mb-2">🎨 Emoji/Imagen de la pregunta</label>
                          <div className="flex gap-2 items-center">
                            <div className="w-20 h-20 bg-gray-100 rounded-xl flex items-center justify-center text-5xl border-2 border-gray-300">
                              {editingQuestionModal.question.imagen_url || editingQuestionModal.question.image_url || '❓'}
                            </div>
                            <select
                              value={editingQuestionModal.question.imagen_url || editingQuestionModal.question.image_url || ''}
                              onChange={(e) => setEditingQuestionModal({
                                ...editingQuestionModal,
                                question: { ...editingQuestionModal.question, imagen_url: e.target.value, image_url: e.target.value }
                              })}
                              className="flex-1 px-4 py-2 border-2 border-gray-300 rounded-lg text-2xl"
                            >
                              <option value="">❓ Ninguno</option>
                              {emojis.slice(0, 50).map(emoji => (
                                <option key={emoji} value={emoji}>{emoji}</option>
                              ))}
                            </select>
                          </div>
                        </div>

                        {/* Opciones de respuesta */}
                        <div>
                          <label className="block text-sm font-bold text-gray-700 mb-2">📋 Opciones de respuesta</label>
                          <div className="space-y-3">
                            {(editingQuestionModal.question.opciones || editingQuestionModal.question.options || ['', '', '', '']).map((opt, oIdx) => (
                              <div key={oIdx} className="flex gap-2 items-center">
                                <div className="w-12 h-12 bg-gray-100 rounded-lg flex items-center justify-center text-2xl border-2 border-gray-300">
                                  {(editingQuestionModal.question.imagen_opciones || editingQuestionModal.question.image_options || [])[oIdx] || '🎨'}
                                </div>
                                <select
                                  value={(editingQuestionModal.question.imagen_opciones || editingQuestionModal.question.image_options || [])[oIdx] || ''}
                                  onChange={(e) => {
                                    const newImagenes = [...(editingQuestionModal.question.imagen_opciones || editingQuestionModal.question.image_options || ['', '', '', ''])];
                                    newImagenes[oIdx] = e.target.value;
                                    setEditingQuestionModal({
                                      ...editingQuestionModal,
                                      question: {
                                        ...editingQuestionModal.question,
                                        imagen_opciones: newImagenes,
                                        image_options: newImagenes
                                      }
                                    });
                                  }}
                                  className="w-20 text-2xl border-2 border-gray-300 rounded-lg"
                                >
                                  <option value="">🎨</option>
                                  {emojis.slice(0, 30).map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </select>
                                <input
                                  type="text"
                                  value={opt}
                                  onChange={(e) => {
                                    const newOpciones = [...(editingQuestionModal.question.opciones || editingQuestionModal.question.options || ['', '', '', ''])];
                                    newOpciones[oIdx] = e.target.value;
                                    setEditingQuestionModal({
                                      ...editingQuestionModal,
                                      question: {
                                        ...editingQuestionModal.question,
                                        opciones: newOpciones,
                                        options: newOpciones
                                      }
                                    });
                                  }}
                                  className="flex-1 px-3 py-2 border-2 border-gray-300 rounded-lg"
                                  placeholder={`Opción ${String.fromCharCode(65 + oIdx)}`}
                                />
                                <button
                                  onClick={() => setEditingQuestionModal({
                                    ...editingQuestionModal,
                                    question: {
                                      ...editingQuestionModal.question,
                                      respuesta_correcta: oIdx,
                                      correct: oIdx
                                    }
                                  })}
                                  className={`w-12 h-12 rounded-lg font-bold ${(editingQuestionModal.question.respuesta_correcta ?? editingQuestionModal.question.correct) === oIdx
                                    ? 'bg-green-500 text-white'
                                    : 'bg-gray-200 text-gray-700'
                                    }`}
                                >
                                  {(editingQuestionModal.question.respuesta_correcta ?? editingQuestionModal.question.correct) === oIdx ? '✓' : oIdx + 1}
                                </button>
                              </div>
                            ))}
                          </div>
                        </div>

                        {/* Puntos y tiempo */}
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <label className="block text-sm font-bold text-gray-700 mb-2">⭐ Puntos</label>
                            <input
                              type="number"
                              value={editingQuestionModal.question.puntos || editingQuestionModal.question.points || 10}
                              onChange={(e) => setEditingQuestionModal({
                                ...editingQuestionModal,
                                question: { ...editingQuestionModal.question, puntos: parseInt(e.target.value), points: parseInt(e.target.value) }
                              })}
                              className="w-full px-3 py-2 border-2 border-gray-300 rounded-lg"
                              min="1"
                            />
                          </div>
                          <div>
                            <label className="block text-sm font-bold text-gray-700 mb-2">⏱️ Tiempo límite (segundos)</label>
                            <input
                              type="number"
                              value={editingQuestionModal.question.tiempo_limite || editingQuestionModal.question.timeLimit || 0}
                              onChange={(e) => setEditingQuestionModal({
                                ...editingQuestionModal,
                                question: { ...editingQuestionModal.question, tiempo_limite: parseInt(e.target.value), timeLimit: parseInt(e.target.value) }
                              })}
                              className="w-full px-3 py-2 border-2 border-gray-300 rounded-lg"
                              min="0"
                              placeholder="0 = sin límite"
                            />
                          </div>
                        </div>

                        {/* Retroalimentación */}
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <label className="block text-sm font-bold text-gray-700 mb-2">✅ Retroalimentación correcta</label>
                            <input
                              type="text"
                              value={editingQuestionModal.question.retroalimentacion_correcta || editingQuestionModal.question.feedback_correct || '¡Excelente! 🎉'}
                              onChange={(e) => setEditingQuestionModal({
                                ...editingQuestionModal,
                                question: { ...editingQuestionModal.question, retroalimentacion_correcta: e.target.value, feedback_correct: e.target.value }
                              })}
                              className="w-full px-3 py-2 border-2 border-green-300 rounded-lg"
                            />
                          </div>
                          <div>
                            <label className="block text-sm font-bold text-gray-700 mb-2">❌ Retroalimentación incorrecta</label>
                            <input
                              type="text"
                              value={editingQuestionModal.question.retroalimentacion_incorrecta || editingQuestionModal.question.feedback_incorrect || '¡Intenta otra vez! 💪'}
                              onChange={(e) => setEditingQuestionModal({
                                ...editingQuestionModal,
                                question: { ...editingQuestionModal.question, retroalimentacion_incorrecta: e.target.value, feedback_incorrect: e.target.value }
                              })}
                              className="w-full px-3 py-2 border-2 border-red-300 rounded-lg"
                            />
                          </div>
                        </div>

                        {/* Audio automático */}
                        <div className="flex items-center gap-2">
                          <input
                            type="checkbox"
                            id="audio_pregunta_modal"
                            checked={editingQuestionModal.question.audio_pregunta !== false}
                            onChange={(e) => setEditingQuestionModal({
                              ...editingQuestionModal,
                              question: { ...editingQuestionModal.question, audio_pregunta: e.target.checked }
                            })}
                            className="w-4 h-4"
                          />
                          <label htmlFor="audio_pregunta_modal" className="text-sm font-semibold text-gray-700">
                            🔊 Reproducir audio automáticamente
                          </label>
                        </div>

                        {/* Botones de acción */}
                        <div className="flex gap-3 pt-4 border-t-2 border-gray-200">
                          <button
                            onClick={() => {
                              // Guardar cambios en editingContent
                              const updated = { ...editingContent };
                              if (!updated.content.questions[editingQuestionModal.quizIndex]) {
                                updated.content.questions[editingQuestionModal.quizIndex] = {};
                              }
                              // Copiar todos los campos de la pregunta editada
                              updated.content.questions[editingQuestionModal.quizIndex] = {
                                ...updated.content.questions[editingQuestionModal.quizIndex],
                                ...editingQuestionModal.question
                              };
                              setEditingContent(updated);
                              setEditingQuestionModal(null);
                              // Opcional: auto-guardar en Supabase
                              saveEditedContent();
                            }}
                            className="flex-1 bg-green-500 hover:bg-green-600 text-white py-3 rounded-xl font-bold flex items-center justify-center gap-2"
                          >
                            <Save className="w-5 h-5" />
                            Guardar Cambios
                          </button>
                          <button
                            onClick={() => setEditingQuestionModal(null)}
                            className="px-6 py-3 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-xl font-bold"
                          >
                            Cancelar
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            )}

            {/* ===== JUEGO INTERACTIVO ===== */}
            {viewingContent.type === 'game' && (
              <div className="space-y-6">
                {!gameState ? (
                  /* PANTALLA INICIAL */
                  <div className="text-center py-12">
                    <div className="text-8xl mb-6 animate-bounce">🎮</div>
                    <h2 className="text-4xl font-black text-gray-800 mb-4">
                      {editingContent.content.name}
                    </h2>
                    <p className="text-lg text-gray-600 mb-8 max-w-2xl mx-auto">
                      {editingContent.content.description}
                    </p>
                    <div className="grid grid-cols-3 gap-4 max-w-xl mx-auto mb-8">
                      <div className="bg-blue-100 rounded-xl p-4 border-2 border-blue-300">
                        <p className="text-3xl font-bold text-blue-600">
                          {editingContent.content.levels}
                        </p>
                        <p className="text-sm text-gray-700 font-semibold">Niveles</p>
                      </div>
                      <div className="bg-yellow-100 rounded-xl p-4 border-2 border-yellow-300">
                        <p className="text-3xl font-bold text-yellow-600">
                          {editingContent.content.challenges?.length || 0}
                        </p>
                        <p className="text-sm text-gray-700 font-semibold">Desafíos</p>
                      </div>
                      <div className="bg-green-100 rounded-xl p-4 border-2 border-green-300">
                        <p className="text-3xl font-bold text-green-600">3</p>
                        <p className="text-sm text-gray-700 font-semibold">Vidas</p>
                      </div>
                    </div>
                    {/* BOTÓN JUGAR - CAMBIADO DE MORADO A AZUL */}
                    <button
                      onClick={() => setGameState({
                        level: 0,
                        score: 0,
                        lives: 3,
                        currentChallenge: 0,
                        completedMechanics: []
                      })}
                      className="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white px-12 py-4 rounded-2xl text-xl font-black shadow-2xl transform hover:scale-105 transition-all"
                    >
                      🚀 ¡JUGAR AHORA!
                    </button>
                  </div>
                ) : (
                  /* JUEGO ACTIVO */
                  <div>
                    {/* HUD - CAMBIADO DE MORADO A AZUL */}
                    <div className="bg-gradient-to-r from-blue-600 to-blue-500 rounded-xl p-4 mb-6 text-white">
                      <div className="flex justify-between items-center">
                        <div>
                          <p className="text-sm font-bold opacity-90">NIVEL</p>
                          <p className="text-3xl font-black">{gameState.level + 1}</p>
                        </div>
                        <div>
                          <p className="text-sm font-bold opacity-90">PUNTOS</p>
                          <p className="text-3xl font-black">{gameState.score}</p>
                        </div>
                        <div>
                          <p className="text-sm font-bold opacity-90">VIDAS</p>
                          <p className="text-3xl">{'❤️'.repeat(gameState.lives)}</p>
                        </div>
                      </div>
                    </div>

                    {/* DESAFÍO ACTUAL - CAMBIADO BORDE DE MORADO A AZUL */}
                    {editingContent.content.challenges?.[gameState.currentChallenge] && (
                      <div className="bg-white rounded-2xl p-8 border-4 border-blue-300 shadow-xl">
                        <h3 className="text-2xl font-black text-gray-800 mb-6 text-center">
                          {editingContent.content.challenges[gameState.currentChallenge].question}
                        </h3>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                          {editingContent.content.challenges[gameState.currentChallenge].options.map((opt, idx) => (
                            <button
                              key={idx}
                              onClick={() => {
                                const challenge = editingContent.content.challenges[gameState.currentChallenge];
                                const isCorrect = idx === challenge.correct;
                                if (isCorrect) {
                                  const newScore = gameState.score + challenge.reward;
                                  const nextChallenge = gameState.currentChallenge + 1;
                                  if (nextChallenge >= editingContent.content.challenges.length) {
                                    // JUEGO COMPLETADO
                                    alert(`🎉 ¡FELICIDADES! Ganaste con ${newScore} puntos`);
                                    setGameState(null);
                                  } else {
                                    setGameState({
                                      ...gameState,
                                      score: newScore,
                                      currentChallenge: nextChallenge
                                    });
                                  }
                                } else {
                                  const newLives = gameState.lives - 1;
                                  if (newLives <= 0) {
                                    alert(`💀 ¡GAME OVER! Puntuación final: ${gameState.score}`);
                                    setGameState(null);
                                  } else {
                                    setGameState({
                                      ...gameState,
                                      lives: newLives
                                    });
                                  }
                                }
                              }}
                              className="p-4 rounded-xl bg-gray-100 hover:bg-blue-100 border-2 border-gray-300 hover:border-blue-400 transition-all text-center"
                            >
                              <span className="text-lg font-medium">{opt}</span>
                            </button>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
    );
  };

  //  FUNCIÓN: Abrir Quiz Builder con contenido generado
  const openQuizBuilderWithGeneratedContent = (generatedQuiz) => {
    console.log("📝 Abriendo Quiz Builder con contenido generado:", generatedQuiz);

    const tempResource = {
      id: `temp_${Date.now()}`,
      titulo: generatedQuiz.title || `Quiz: ${generatedQuiz.prompt}`,
      tipo: "quiz",
      contenido_quiz: generatedQuiz.content?.questions || [],
    };

    setSelectedResource(tempResource);
    setCurrentQuiz({
      preguntas: (generatedQuiz.content?.questions || []).map((q, idx) => ({
        id: q.id || `generated_${Date.now()}_${idx}`,
        tipo: q.tipo || q.type || "multiple",
        pregunta: q.pregunta || q.text || q.question || "",
        opciones: q.opciones || q.options || ["", "", "", ""],
        respuesta_correcta: q.respuesta_correcta ?? q.correct ?? 0,
        puntos: q.puntos ?? q.points ?? 10,
        retroalimentacion_correcta: q.retroalimentacion_correcta || "¡Excelente! 🎉",
        retroalimentacion_incorrecta: q.retroalimentacion_incorrecta || "¡Intenta otra vez! 💪",
        audio_pregunta: q.audio_pregunta !== false,
        audio_retroalimentacion: q.audio_retroalimentacion !== false,
        video_url: q.video_url || "",
        imagen_url: q.imagen_url || "",
        audio_opciones: q.audio_opciones || ["", "", "", ""],
        imagen_opciones: q.imagen_opciones || ["🎨", "📚", "✏️", "🌟"],
        tiempo_limite: q.tiempo_limite ?? 45,
      })),
    });

    setShowContentGenerator(false);
    setShowQuizBuilder(true);
    setActiveTab("resources");

    console.log("✅ Quiz Builder abierto con", currentQuiz.preguntas.length, "preguntas");
  };

  // Ver contenido generado mejorado
  const viewGeneratedContentImproved = (item) => {
    console.log("👁️ Abriendo visor para:", item);

    const deepCopy = JSON.parse(
      JSON.stringify({
        ...item,
        content: item.content || {},
      })
    );

    setViewingContent(item);
    setEditingContent(deepCopy);
    setShowContentViewer(true);

    console.log("✅ Visor abierto con contenido:", deepCopy.title);
  };

  const getResourceIcon = (tipo) => {
    const icons = {
      video: Play,
      imagen: Image,
      audio: Headphones,
      quiz: HelpCircle,
      juego: Gamepad2,
      pdf: FileText,
    };
    const Icon = icons[tipo] || BookOpen;
    return Icon;
  };

  const getFilteredUsers = () => {
    return users.filter((user) => {
      // Filtro por rol - CORREGIDO
      if (filterRole !== "todos" && filterRole !== "") {
        if (user.rol !== filterRole) return false;
      }

      // Filtro por grupo - CORREGIDO
      if (filterGroup !== "todos" && filterGroup !== "") {
        if (filterGroup === "sin_grupo") {
          if (user.grupo_id || (user.grupos_adicionales && user.grupos_adicionales.length > 0)) {
            return false;
          }
        } else {
          const userGroups = [user.grupo_id, ...(user.grupos_adicionales || [])].filter(Boolean);
          if (!userGroups.includes(parseInt(filterGroup))) {
            return false;
          }
        }
      }

      // Filtro por estado - CORREGIDO
      if (filterStatus !== "todos" && filterStatus !== "") {
        if (filterStatus === "active" && !user.activo) return false;
        if (filterStatus === "inactive" && user.activo) return false;
      }

      // Búsqueda por nombre
      if (searchUserText && !user.nombre?.toLowerCase().includes(searchUserText.toLowerCase())) {
        return false;
      }

      return true;
    });
  };

  const formatLastAccess = (lastAccess) => {
    if (!lastAccess) return "Nunca";
    const date = new Date(lastAccess);
    const now = new Date();
    const diffInHours = (now - date) / (1000 * 60 * 60);

    if (diffInHours < 1) return "Hace menos de 1 hora";
    if (diffInHours < 24) return `Hace ${Math.floor(diffInHours)} horas`;
    const diffInDays = Math.floor(diffInHours / 24);
    if (diffInDays === 1) return "Hace 1 día";
    if (diffInDays < 30) return `Hace ${diffInDays} días`;
    return date.toLocaleDateString("es-ES");
  };

  const renderDashboard = () => {
    const aiRecommendations = generateAIRecommendations();

    return (
      <div className="space-y-6">
        <h2 className="text-xl font-semibold text-gray-800">
          Dashboard Analítico
        </h2>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
          <MetricCard
            title="Usuarios Activos"
            value={analytics.activeStudents}
            change={analytics.userGrowth}
            icon={Users}
            color="#3B82F6"
          />
          <MetricCard
            title="Tasa de Compromiso"
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
            icon={Clock}
            color="#F59E0B"
          />
        </div>   <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
          <BarChart
            title="Distribución de Usuarios"
            data={[
              {
                label: "Estudiantes",
                value: users.filter((u) => u.rol === "estudiante").length,
              },
              {
                label: "Docentes",
                value: users.filter((u) => u.rol === "docente").length,
              },
              {
                label: "Administradores",
                value: users.filter((u) => u.rol === "admin").length,
              },
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


        <div className="bg-gradient-to-br from-indigo-900 to-blue-950 rounded-xl p-6 text-white">
          <div className="flex items-start gap-4">

            {/* Icono principal */}
            <div className="bg-white/10 rounded-lg p-3 flex-shrink-0 border border-white/15">
              <Sparkles className="w-6 h-6 text-white" />
            </div>

            <div className="flex-1">
              <h3 className="text-lg font-semibold mb-5 text-white">
                Recomendaciones IA Generativa
              </h3>

              {aiRecommendations.length > 0 ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                  {aiRecommendations.map((rec, index) => (
                    <div
                      key={index}
                      className="
                bg-indigo-800/80
                rounded-lg p-4
                border border-white/20
                hover:border-white/40
                transition-colors
              "
                    >
                      <div className="flex flex-col justify-between h-full">

                        {/* Contenido */}
                        <div>
                          <div className="flex items-start gap-3 mb-3">
                            <div
                              className={`w-1.5 h-6 rounded-full mt-1 ${rec.priority === 'high'
                                ? 'bg-red-500'
                                : rec.priority === 'medium'
                                  ? 'bg-amber-400'
                                  : 'bg-emerald-400'
                                }`}
                            />
                            <p className="text-sm font-semibold text-white leading-tight">
                              {rec.title}
                            </p>
                          </div>

                          <p className="text-xs text-indigo-200 leading-relaxed ml-4">
                            {rec.description}
                          </p>
                        </div>

                        {/* Acción */}
                        <button
                          onClick={() => {
                            if (rec.action_type === 'open_generator') {
                              setShowContentGenerator(true)
                              setContentGeneratorTab('generator')
                              setContentType('quiz')
                            } else if (rec.action_type === 'open_analytics') {
                              generateAIAnalyticsImproved()
                            } else if (rec.targetTab) {
                              setActiveTab(rec.targetTab)
                            }
                          }}
                          className="
                    mt-4 w-full
                    text-xs font-semibold
                    text-indigo-900
                    bg-white
                    hover:bg-indigo-100
                    px-3 py-2
                    rounded-md
                    transition-colors
                  "
                        >
                          {rec.action}
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="bg-indigo-800/60 rounded-lg p-4 border border-white/20">
                  <p className="text-center text-sm text-indigo-200">
                    Tu sistema está bien balanceado.
                  </p>
                </div>
              )}

              {/* Footer */}
              <div className="flex justify-start pt-4 border-t border-white/15">
                <button
                  onClick={() => generateAIAnalyticsImproved()}
                  className="
            flex items-center gap-2
            text-sm font-semibold
            text-indigo-900
            bg-white
            hover:bg-indigo-100
            px-4 py-2
            rounded-md
            transition-colors
          "
                >
                  <BarChart3 className="w-4 h-4" />
                  Ver análisis detallado
                </button>
              </div>
            </div>
          </div>
        </div>


        {/* Chat Flotante IA - Bola Flotante */}
        {/*BOTÓN FLOTANTE*/}
        {!showAIChat && (
          <button
            onClick={() => setShowAIChat(true)}
            className="fixed bottom-6 right-6 z-50 group"
          >
            <div className="relative w-14 h-14 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-full shadow-xl hover:shadow-2xl transition-all duration-300 transform hover:scale-110 cursor-pointer flex items-center justify-center">
              <div className="absolute inset-0 rounded-full bg-white opacity-20 animate-ping"></div>
              <MessageCircle className="w-7 h-7 text-white" strokeWidth={1.5} />
            </div>
            <div className="absolute bottom-full right-0 mb-2 bg-gray-900 text-white text-xs font-medium px-2 py-1 rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity">
              Asistente IA
            </div>
          </button>
        )}

        {/* VENTANA DE CHAT FLOTANTE */}
        {showAIChat && (
          <div className="fixed bottom-6 right-6 z-50 w-80 h-[520px] bg-white rounded-2xl shadow-2xl flex flex-col overflow-hidden border border-gray-200 animate-fadeInUp">

            {/* Cabecera con botón cerrar - AHORA AZUL */}
            <div className="bg-gradient-to-r from-blue-600 to-cyan-600 px-4 py-3 flex items-center justify-between">
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 bg-white/20 rounded-full flex items-center justify-center text-lg backdrop-blur-sm">
                  🤖
                </div>
                <div>
                  <h3 className="text-white font-bold text-base">Asistente IA</h3>
                  <div className="flex items-center gap-1 mt-0.5">
                    <div className="w-1.5 h-1.5 bg-green-400 rounded-full animate-pulse"></div>
                    <span className="text-[10px] text-blue-100">Conectado</span>
                  </div>
                </div>
              </div>
              <button
                onClick={() => {
                  window.speechSynthesis.cancel();
                  setShowAIChat(false);
                  setChatMessages([]);
                  setChatInput("");
                }}
                className="bg-white/20 hover:bg-white/30 p-1.5 rounded-lg transition-all"
                aria-label="Cerrar chat"
              >
                <X className="w-4 h-4 text-white" />
              </button>
            </div>

            {/* Área de mensajes */}
            <div className="flex-1 overflow-y-auto p-3 space-y-2 bg-gray-50">
              {chatMessages.length === 0 ? (
                <div className="flex flex-col items-center justify-center h-full text-center px-3">
                  <div className="w-12 h-12 bg-gradient-to-br from-blue-100 to-cyan-100 rounded-2xl flex items-center justify-center text-2xl mb-2">
                    💬
                  </div>
                  <h4 className="font-bold text-gray-800 text-sm">¡Hola! Soy tu asistente</h4>
                  <p className="text-xs text-gray-500 mt-1">Pregúntame sobre estadísticas, recomendaciones o cómo usar la plataforma.</p>
                  <div className="grid grid-cols-2 gap-1 w-full mt-4">
                    <button onClick={() => handleAIChat("¿Cuál es el estado general del sistema?")} className="bg-blue-50 hover:bg-blue-100 text-blue-700 text-[11px] font-semibold px-2 py-1.5 rounded-lg transition">📊 Estado</button>
                    <button onClick={() => handleAIChat("Dame recomendaciones para mejorar el compromiso")} className="bg-blue-50 hover:bg-blue-100 text-blue-700 text-[11px] font-semibold px-2 py-1.5 rounded-lg transition">💡 Recomendaciones</button>
                    <button onClick={() => handleAIChat("¿Qué cursos son los más populares?")} className="bg-blue-50 hover:bg-blue-100 text-blue-700 text-[11px] font-semibold px-2 py-1.5 rounded-lg transition">📈 Popularidad</button>
                    <button onClick={() => handleAIChat("¿Cómo puedo generar un quiz con IA?")} className="bg-blue-50 hover:bg-blue-100 text-blue-700 text-[11px] font-semibold px-2 py-1.5 rounded-lg transition">❓ Ayuda</button>
                  </div>
                </div>
              ) : (
                <>
                  {chatMessages.map((msg) => (
                    <div key={msg.id} className={`flex ${msg.role === "user" ? "justify-end" : "justify-start"}`}>
                      <div className={`max-w-[85%] px-3 py-1.5 rounded-xl text-xs ${msg.role === "user" ? "bg-blue-600 text-white rounded-br-none" : "bg-white border border-gray-200 text-gray-800 rounded-bl-none shadow-sm"}`}>
                        {msg.content}
                        <div className={`text-[9px] mt-1 ${msg.role === "user" ? "text-blue-200" : "text-gray-400"}`}>
                          {new Date(msg.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                        </div>
                      </div>
                    </div>
                  ))}
                  {chatLoading && (
                    <div className="flex justify-start">
                      <div className="bg-white border border-gray-200 rounded-xl rounded-bl-none px-3 py-1.5 flex gap-1">
                        <div className="w-1.5 h-1.5 bg-blue-400 rounded-full animate-bounce"></div>
                        <div className="w-1.5 h-1.5 bg-blue-400 rounded-full animate-bounce" style={{ animationDelay: "0.2s" }}></div>
                        <div className="w-1.5 h-1.5 bg-blue-400 rounded-full animate-bounce" style={{ animationDelay: "0.4s" }}></div>
                      </div>
                    </div>
                  )}
                </>
              )}
            </div>

            {/* Input y acciones */}
            <div className="border-t border-gray-200 p-2 bg-white">
              <div className="flex gap-2">
                <input
                  type="text"
                  value={chatInput}
                  onChange={(e) => setChatInput(e.target.value)}
                  onKeyPress={(e) => e.key === "Enter" && !chatLoading && handleAIChat(chatInput)}
                  placeholder="Escribe tu pregunta..."
                  disabled={chatLoading}
                  className="flex-1 px-3 py-1.5 bg-gray-100 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all disabled:opacity-50 text-xs"
                />
                <button
                  onClick={() => handleAIChat(chatInput)}
                  disabled={chatLoading || !chatInput.trim()}
                  className="bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 text-white p-1.5 rounded-lg transition-all"
                >
                  <Send className="w-4 h-4" />
                </button>
              </div>
              <div className="flex justify-between mt-1.5 text-[9px] text-gray-400">
                <span>✨ Asistente IA</span>
                <button onClick={() => { setChatMessages([]); setChatInput(""); }} className="hover:text-gray-600">Limpiar</button>
              </div>
            </div>
          </div>
        )}
        {showContentPreview && renderContentPreview()}

        {/* Análisis con Algoritmos */}

        <div className="bg-white rounded-lg shadow-sm border p-6">
          <h3 className="font-semibold text-gray-800 mb-6 flex items-center gap-2">
            <FileText className="w-5 h-5 text-blue-600" />
            Análisis Inteligente de Cursos
          </h3>

          {/* DESCRIPCIÓN CLARA */}
          <div className="bg-blue-50 border-l-4 border-blue-500 p-4 mb-6 rounded-r-lg">
            <p className="text-sm text-gray-700">
              📌 <strong>Selecciona un curso abajo</strong> para ver análisis detallado con algoritmos de IA (LEA, ADA, AFS)
            </p>
          </div>

          {/* GRID LIMPIO: SOLO LOS CURSOS */}
          {courses && courses.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {courses.map((course) => {
                const studentCount = users.filter(u => u.rol === "estudiante").length;

                return (
                  <button
                    key={course.id}
                    onClick={() => {
                      setSelectedCourseForReport(course.id);
                      setTimeout(() => generateCourseReport(course.id), 100);
                    }}
                    className="text-left rounded-xl p-5 border-2 transition-all transform hover:scale-105 shadow-md hover:shadow-lg group"
                    style={{
                      borderColor: selectedCourseForReport === course.id ? course.color : '#e5e7eb',
                      backgroundColor: selectedCourseForReport === course.id ? `${course.color}15` : '#ffffff',
                    }}
                  >
                    {/* HEADER CON COLOR DEL CURSO */}
                    <div
                      className="h-2 -mx-5 -mt-5 mb-4 rounded-t-lg"
                      style={{ backgroundColor: course.color }}
                    ></div>

                    {/* CONTENIDO */}
                    <div className="flex items-start gap-3 mb-3">
                      <div
                        className="w-12 h-12 rounded-lg flex items-center justify-center flex-shrink-0 text-white font-bold shadow-md"
                        style={{ backgroundColor: course.color }}
                      >
                        {course.titulo.charAt(0)}
                      </div>
                      <div className="flex-1 min-w-0">
                        <h4 className="font-bold text-gray-800 group-hover:text-gray-900 truncate">
                          {course.titulo}
                        </h4>
                        <p className="text-xs text-gray-500 font-medium">{course.nivel_nombre || "Sin nivel"}</p>
                      </div>
                    </div>

                    {/* ESTADÍSTICAS RÁPIDAS */}
                    <div className="bg-white bg-opacity-60 rounded-lg p-3 space-y-1 mb-3 text-xs border border-gray-200">
                      <div className="flex justify-between">
                        <span className="text-gray-600">👥 Estudiantes:</span>
                        <span className="font-bold text-gray-800">{studentCount}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-gray-600">📚 Recursos:</span>
                        <span className="font-bold text-gray-800">
                          {resources.filter(r => r.curso_id === course.id).length}
                        </span>
                      </div>
                    </div>

                    {/* BOTÓN DE ACCIÓN */}
                    <button
                      className="w-full py-2 rounded-lg text-xs font-bold transition-all"
                      style={{
                        backgroundColor: selectedCourseForReport === course.id ? course.color : `${course.color}20`,
                        color: selectedCourseForReport === course.id ? '#ffffff' : course.color,
                        border: `2px solid ${course.color}`
                      }}
                      onMouseEnter={(e) => {
                        if (selectedCourseForReport !== course.id) {
                          e.target.style.backgroundColor = course.color;
                          e.target.style.color = '#ffffff';
                        }
                      }}
                      onMouseLeave={(e) => {
                        if (selectedCourseForReport !== course.id) {
                          e.target.style.backgroundColor = `${course.color}20`;
                          e.target.style.color = course.color;
                        }
                      }}
                    >
                      {selectedCourseForReport === course.id ? "✓ ANALIZANDO" : "Analizar →"}
                    </button>
                  </button>
                );
              })}
            </div>
          ) : (
            <div className="text-center py-12 bg-gray-50 rounded-xl border-2 border-dashed border-gray-300">
              <BookOpen className="w-16 h-16 text-gray-400 mx-auto mb-3" />
              <p className="text-gray-600 font-semibold">No hay cursos disponibles</p>
              <p className="text-sm text-gray-500 mt-1">Ve a la sección "Cursos" y crea uno primero</p>
            </div>
          )}

          {/* BOTÓN ESPECIAL: ANALIZAR TODO (Opcional, debajo) */}
          {courses && courses.length > 0 && (
            <div className="mt-6 pt-6 border-t border-gray-200">
              <button
                onClick={() => {
                  setSelectedCourseForReport(null);
                  setTimeout(() => generateCourseReport(null), 100);
                }}
                className="w-full py-3 px-4 bg-gradient-to-r from-blue-600 to-blue-800 hover:from-blue-700 hover:to-blue-900 text-white rounded-xl font-bold transition-all transform hover:scale-[1.02] flex items-center justify-center gap-2 shadow-lg"
              >
                <BarChart3 className="w-5 h-5" />
                Ver Análisis General del Sistema
              </button>
            </div>
          )}
        </div>

        {/* SECCIÓN DE ACTIVIDAD RECIENTE Y CURSOS MÁS ACTIVOS */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* ✅ ACTIVIDAD RECIENTE */}
          <div className="bg-white rounded-lg shadow-sm border p-6">
            <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <Activity className="w-5 h-5 text-blue-600" />
              Actividad Reciente
            </h3>
            <div className="space-y-3">
              <div className="flex items-center gap-3 p-3 bg-green-50 rounded-lg border border-green-200">
                <CheckCircle className="w-4 h-4 text-green-600 flex-shrink-0" />
                <div>
                  <p className="text-sm font-medium text-green-800">
                    Sistema actualizado
                  </p>
                  <p className="text-xs text-green-600">
                    {users.length} usuarios, {courses.length} cursos
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-blue-50 rounded-lg border border-blue-200">
                <Users className="w-4 h-4 text-blue-600 flex-shrink-0" />
                <div>
                  <p className="text-sm font-medium text-blue-800">
                    Análisis completado
                  </p>
                  <p className="text-xs text-blue-600">
                    Compromiso: {analytics.engagementRate}%
                  </p>
                </div>
              </div>
              {analytics.topCourses && analytics.topCourses.length > 0 && (
                <div className="flex items-center gap-3 p-3 bg-purple-50 rounded-lg border border-purple-200">
                  <TrendingUp className="w-4 h-4 text-purple-600 flex-shrink-0" />
                  <div>
                    <p className="text-sm font-medium text-purple-800">
                      Curso más popular
                    </p>
                    <p className="text-xs text-purple-600">
                      {analytics.topCourses[0]?.title || "N/A"}
                    </p>
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* ✅ CURSOS MÁS ACTIVOS */}
          <div className="bg-white rounded-lg shadow-sm border p-6">
            <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <Trophy className="w-5 h-5 text-yellow-600" />
              Cursos Más Activos
            </h3>
            <div className="space-y-3">
              {analytics.topCourses && analytics.topCourses.length > 0 ? (
                analytics.topCourses.slice(0, 3).map((course, index) => (
                  <div
                    key={course.courseId}
                    className="flex items-center justify-between p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors cursor-pointer"
                  >
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center text-blue-600 font-bold text-sm">
                        {index + 1}
                      </div>
                      <div>
                        <p className="text-sm font-medium text-gray-800">
                          {course.title}
                        </p>
                        <p className="text-xs text-gray-600">
                          {course.count} actividades
                        </p>
                      </div>
                    </div>
                    <TrendingUp className="w-4 h-4 text-green-500" />
                  </div>
                ))
              ) : (
                <p className="text-sm text-gray-500 text-center py-8">
                  No hay datos de actividad aún
                </p>
              )}
            </div>
          </div>
        </div>
      </div>
    );
  };

  const renderDetailedAnalyticsImproved = () => {
    if (!showDetailedAnalytics) return null;

    if (loadingAI) {
      return (
        <div className="fixed inset-0 bg-black/40 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl p-12 text-center shadow-2xl">
            <RefreshCw className="w-12 h-12 text-blue-600 animate-spin mx-auto mb-3" />
            <p className="text-gray-700 font-semibold">Generando análisis con IA...</p>
          </div>
        </div>
      );
    }

    if (!aiMetrics) {
      return (
        <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl p-8 text-center max-w-md shadow-xl">
            <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-3" />
            <p className="text-gray-700 font-semibold">No hay datos disponibles</p>
            <button
              onClick={() => setShowDetailedAnalytics(false)}
              className="mt-4 bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-xl font-medium transition"
            >
              Cerrar
            </button>
          </div>
        </div>
      );
    }

    // Preparar datos para gráficas
    const studentDistributionData = [
      { label: 'Activos', value: aiMetrics.students?.active || 0 },
      { label: 'Inactivos', value: aiMetrics.students?.inactive || 0 },
    ];

    const contentDistributionData = [
      { label: 'Cursos', value: aiMetrics.content?.courses || 0 },
      { label: 'Recursos', value: aiMetrics.content?.resources || 0 },
      { label: 'Logros', value: aiMetrics.content?.achievements || 0 },
    ];

    const performanceData = [
      { label: 'Engagement', value: aiMetrics.engagement?.rate || 0 },
      { label: 'Progreso', value: aiMetrics.progress?.average || 0 },
      { label: 'Completitud', value: aiMetrics.progress?.completionRate || 0 },
    ];

    const timeSeriesData = [
      { label: 'Sem 1', value: 45 },
      { label: 'Sem 2', value: 52 },
      { label: 'Sem 3', value: 48 },
      { label: 'Sem 4', value: aiMetrics.engagement?.rate || 60 },
    ];

    return (
      <div className="fixed inset-0 bg-gray-900/60 backdrop-blur-sm z-50 flex items-center justify-center p-4 overflow-y-auto">
        <div className="bg-white rounded-3xl max-w-7xl w-full max-h-[90vh] overflow-y-auto shadow-2xl my-8">

          {/* HEADER PROFESIONAL */}
          <div className="sticky top-0 z-10 bg-gradient-to-r from-slate-800 to-slate-700 text-white p-6 rounded-t-3xl">
            <div className="flex items-center justify-between">
              <div>
                <h1 className="text-2xl font-bold mb-1 flex items-center gap-2">
                  <BarChart3 className="w-6 h-6" />
                  Panel de Análisis Avanzado
                </h1>
                <p className="text-slate-300 text-sm">
                  Métricas en tiempo real con visualizaciones interactivas
                </p>
              </div>
              <div className="flex items-center gap-3">
                <span className="text-sm bg-white/20 px-3 py-1 rounded-full">
                  {new Date().toLocaleDateString('es-ES')}
                </span>
                <button
                  onClick={() => setShowDetailedAnalytics(false)}
                  className="bg-white/10 hover:bg-white/20 p-2 rounded-xl transition"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>
          </div>

          <div className="p-6 space-y-8 bg-gray-50">

            {/* SALUD DEL SISTEMA - Moderna */}
            <section className="bg-gradient-to-r from-blue-700 to-indigo-700 rounded-2xl p-6 text-white shadow-lg">
              <div className="flex items-center justify-between flex-wrap gap-4">
                <div>
                  <p className="text-sm font-medium text-blue-200 uppercase tracking-wide">Estado General</p>
                  <div className="flex items-baseline gap-2 mt-1">
                    <span className="text-5xl font-black">{aiMetrics.systemHealth?.score || 0}</span>
                    <span className="text-xl">%</span>
                  </div>
                  <p className="text-blue-200 text-sm mt-1">
                    {aiMetrics.systemHealth?.status === 'healthy' ? '✅ Saludable' :
                      aiMetrics.systemHealth?.status === 'warning' ? '⚠️ Atención' : '🚨 Crítico'}
                  </p>
                </div>
                <div className="relative w-28 h-28">
                  <svg className="w-full h-full transform -rotate-90">
                    <circle cx="56" cy="56" r="48" fill="none" stroke="rgba(255,255,255,0.2)" strokeWidth="8" />
                    <circle
                      cx="56" cy="56" r="48" fill="none"
                      stroke="white"
                      strokeWidth="8"
                      strokeDasharray={`${(aiMetrics.systemHealth?.score || 0) * 3.02} 302`}
                      strokeLinecap="round"
                      className="transition-all duration-1000"
                    />
                  </svg>
                  <div className="absolute inset-0 flex items-center justify-center text-3xl">
                    {aiMetrics.systemHealth?.score >= 70 ? '😊' :
                      aiMetrics.systemHealth?.score >= 50 ? '😐' : '😟'}
                  </div>
                </div>
              </div>
            </section>

            {/* GRÁFICAS PRINCIPALES */}
            <section>
              <h2 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                <div className="w-1 h-6 bg-blue-600 rounded-full"></div>
                Visualización de Datos
              </h2>
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                <ExcelDonutChart
                  title="👥 Distribución de Estudiantes"
                  data={studentDistributionData}
                  colors={['#10b981', '#ef4444']}
                />
                <ExcelColumnChart
                  title="📊 Métricas de Rendimiento"
                  data={performanceData}
                  colors={['#3b82f6', '#8b5cf6', '#ec4899']}
                />
              </div>
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <ExcelHorizontalBarChart
                  title="📚 Distribución de Contenido"
                  data={contentDistributionData}
                  colors={['#f59e0b', '#10b981', '#6366f1']}
                />
                <ExcelLineChart
                  title="📈 Tendencia de Engagement"
                  data={timeSeriesData}
                  color="#8b5cf6"
                />
              </div>
            </section>

            {/* MÉTRICAS DETALLADAS */}
            <section>
              <h2 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                <div className="w-1 h-6 bg-emerald-600 rounded-full"></div>
                Métricas Clave
              </h2>
              <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
                {[
                  { label: 'Total Estudiantes', value: aiMetrics.students?.total, icon: '👥', color: 'from-blue-500 to-blue-600' },
                  { label: 'Engagement', value: `${aiMetrics.engagement?.rate}%`, icon: '🎯', color: 'from-emerald-500 to-emerald-600' },
                  { label: 'Progreso Promedio', value: `${aiMetrics.progress?.average}%`, icon: '📈', color: 'from-violet-500 to-violet-600' },
                  { label: 'Completitud', value: `${aiMetrics.progress?.completionRate}%`, icon: '✅', color: 'from-amber-500 to-amber-600' },
                  { label: 'Cursos', value: aiMetrics.content?.courses, icon: '📚', color: 'from-rose-500 to-rose-600' },
                  { label: 'Recursos', value: aiMetrics.content?.resources, icon: '📝', color: 'from-indigo-500 to-indigo-600' },
                  { label: 'Logros', value: aiMetrics.content?.achievements, icon: '🏆', color: 'from-yellow-500 to-yellow-600' },
                  { label: 'Tiempo Total', value: `${aiMetrics.progress?.totalTimeSpent}m`, icon: '⏱️', color: 'from-slate-500 to-slate-600' },
                ].map((stat, idx) => (
                  <div
                    key={idx}
                    className={`bg-gradient-to-br ${stat.color} rounded-xl p-4 text-white shadow-md hover:shadow-lg transition-all hover:scale-105`}
                  >
                    <div className="text-2xl mb-1">{stat.icon}</div>
                    <p className="text-xs font-semibold uppercase opacity-90">{stat.label}</p>
                    <p className="text-2xl font-bold mt-1">{stat.value}</p>
                  </div>
                ))}
              </div>
            </section>

            {/* INSIGHTS */}
            <section>
              <h2 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                <div className="w-1 h-6 bg-amber-600 rounded-full"></div>
                💡 Insights generados por IA
              </h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {aiInsights?.map((insight, idx) => (
                  <div
                    key={idx}
                    className="bg-white border-l-4 border-blue-500 rounded-xl p-4 shadow-sm hover:shadow-md transition"
                  >
                    <p className="text-gray-700 text-sm flex gap-2">
                      <span className="text-blue-600 font-bold">•</span>
                      {insight}
                    </p>
                  </div>
                ))}
              </div>
            </section>

            {/* RECOMENDACIONES */}
            <section>
              <h2 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                <div className="w-1 h-6 bg-red-600 rounded-full"></div>
                🎯 Recomendaciones de Acción
              </h2>
              <div className="space-y-3">
                {aiRecommendations?.map((rec, idx) => {
                  const priorityColors = {
                    high: 'bg-red-50 border-red-200',
                    medium: 'bg-yellow-50 border-yellow-200',
                    low: 'bg-green-50 border-green-200',
                  };
                  const priorityIcons = {
                    high: '🔴',
                    medium: '🟡',
                    low: '🟢',
                  };
                  return (
                    <div
                      key={idx}
                      className={`${priorityColors[rec.priority]} border rounded-xl p-4 shadow-sm hover:shadow-md transition`}
                    >
                      <div className="flex gap-3">
                        <span className="text-xl">{priorityIcons[rec.priority]}</span>
                        <div>
                          <h3 className="font-bold text-gray-800">{rec.title}</h3>
                          <p className="text-sm text-gray-600 mt-0.5">{rec.description}</p>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </section>
          </div>

          {/* FOOTER */}
          <div className="sticky bottom-0 bg-white border-t border-gray-200 p-4 flex justify-end gap-3 rounded-b-3xl">
            <button
              onClick={() => setShowDetailedAnalytics(false)}
              className="px-5 py-2 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-xl font-medium transition"
            >
              Cerrar
            </button>
            <button
              onClick={generateAIAnalyticsImproved}
              className="px-5 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-medium transition flex items-center gap-2 shadow-sm"
            >
              <RefreshCw className="w-4 h-4" />
              Actualizar Análisis
            </button>
          </div>
        </div>
      </div>
    );
  };
  // VISTA MEJORADA: GESTIÓN DE LOGROS

  const renderAchievementsManagement = () => {
    const achievementEmojis = [
      "🏆",
      "⭐",
      "🥇",
      "🥈",
      "🥉",
      "🎖️",
      "🏅",
      "👑",
      "💎",
      "✨",
      "🌟",
      "🎯",
      "🚀",
      "💡",
      "📚",
      "🧠",
    ];

    return (
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h2 className="text-xl font-semibold text-gray-800">
            Gestión de Logros
          </h2>
          <button
            onClick={() => setShowNewAchievement(true)}
            className="flex items-center gap-2 bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg transition-colors"
          >
            <Plus className="w-4 h-4" />
            Nuevo Logro
          </button>
        </div>

        {showNewAchievement && (
          <div className="bg-white rounded-lg shadow-sm border p-6">
            <h3 className="text-lg font-semibold text-gray-800 mb-4">
              Crear Nuevo Logro
            </h3>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Nombre
                </label>
                <input
                  type="text"
                  value={newAchievementData.nombre}
                  onChange={(e) =>
                    setNewAchievementData({
                      ...newAchievementData,
                      nombre: e.target.value,
                    })
                  }
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-500"
                  placeholder="Ej: Matemático Estrella"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Puntos Requeridos
                </label>
                <input
                  type="number"
                  value={newAchievementData.puntos_requeridos}
                  onChange={(e) =>
                    setNewAchievementData({
                      ...newAchievementData,
                      puntos_requeridos: parseInt(e.target.value),
                    })
                  }
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-500"
                  min="1"
                />
              </div>

              <div className="md:col-span-2">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Descripción
                </label>
                <textarea
                  value={newAchievementData.descripcion}
                  onChange={(e) =>
                    setNewAchievementData({
                      ...newAchievementData,
                      descripcion: e.target.value,
                    })
                  }
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-500"
                  rows="3"
                />
              </div>

              <div className="md:col-span-2">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Ícono/Emoji
                </label>
                <div className="grid grid-cols-8 gap-2"> {achievementEmojis.map((emoji, index) => (<button key={`achievement_${index}`} onClick={() => setNewAchievementData({ ...newAchievementData, icono: emoji, })}
                  className={`w-10 h-10 rounded-lg text-xl transition-all ${newAchievementData.icono === emoji
                    ? "bg-yellow-200 scale-110"
                    : "bg-gray-100 hover:bg-gray-200"
                    }`}
                >
                  {emoji}
                </button>
                ))}
                </div>
              </div>
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => {
                  createAchievement(newAchievementData);
                  setShowNewAchievement(false);
                  setNewAchievementData({
                    nombre: "",
                    descripcion: "",
                    icono: "🏆",
                    puntos_requeridos: 100,
                  });
                }}
                className="px-6 py-2 bg-green-500 hover:bg-green-600 text-white rounded-lg font-semibold"
              >
                Guardar
              </button>
              <button
                onClick={() => setShowNewAchievement(false)}
                className="px-6 py-2 bg-gray-500 hover:bg-gray-600 text-white rounded-lg font-semibold"
              >
                Cancelar
              </button>
            </div>
          </div>
        )}

        {/* GALERÍA DE LOGROS */}
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {achievements.map((achievement) => (
            <div
              key={achievement.id}
              className="bg-gradient-to-br from-yellow-50 to-orange-50 rounded-lg p-6 border-2 border-yellow-200 hover:shadow-lg transition-shadow text-center"
            >
              <div className="text-5xl mb-3">{achievement.icono}</div>
              <h3 className="font-bold text-gray-800 mb-2">
                {achievement.nombre}
              </h3>
              <p className="text-xs text-gray-600 mb-3 line-clamp-2">
                {achievement.descripcion}
              </p>
              <div className="flex items-center justify-between mb-4">
                <span className="text-xs font-bold text-yellow-700">
                  ⭐ {achievement.puntos_requeridos} pts
                </span>
                <span
                  className={`px-2 py-1 rounded-full text-xs font-semibold ${achievement.activo
                    ? "bg-green-100 text-green-800"
                    : "bg-gray-100 text-gray-800"
                    }`}
                >
                  {achievement.activo ? "Activo" : "Inactivo"}
                </span>
              </div>
              <button
                onClick={() => deleteAchievementItem(achievement.id)}
                className="w-full px-3 py-2 bg-red-50 hover:bg-red-100 text-red-600 rounded-lg text-xs font-semibold transition-colors"
              >
                Eliminar
              </button>
            </div>
          ))}
        </div>

        {achievements.length === 0 && (
          <div className="text-center py-12 bg-white rounded-lg border">
            <Award className="w-16 h-16 text-gray-400 mx-auto mb-3" />
            <p className="text-gray-500">No hay logros creados</p>
          </div>
        )}
      </div>
    );
  };

  // Selector visual de emojis mejorado
  const EmojiSelector = ({ onSelect, currentEmoji }) => {
    const [searchEmoji, setSearchEmoji] = useState('');

    const emojiCategories = {
      'Formas': ["🔴", "🔵", "🟡", "🟢", "🟣", "🟠", "⭕", "📍"],
      'Números': ["1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣"],
      'Animales': ["🦁", "🐘", "🦒", "🐼", "🦊", "🐶", "🐱", "🦆", "🦉"],
      'Comida': ["🍎", "🍊", "🍋", "🍌", "🍓", "🥕", "🌽", "🍕", "🍔"],
      'Transporte': ["🚀", "✈️", "🚂", "🚗", "🚢", "⛵", "🚁", "🛸"],
      'Deportes': ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🎱", "⛳"],
      'Educación': ["📚", "📖", "📝", "✏️", "📐", "📏", "📊", "🎓", "🔬"],
      'Emojis': ["🎉", "🎊", "🎈", "🎀", "🎁", "✅", "❌", "👍", "👏"]
    };

    return (
      <div className="space-y-3">
        {Object.entries(emojiCategories).map(([category, emojis]) => (
          <div key={category}>
            <p className="text-xs font-bold text-gray-600 uppercase mb-2">{category}</p>
            <div className="grid grid-cols-8 gap-2">
              {emojis.map((emoji, idx) => (
                <button
                  key={`${category}_${idx}`}
                  onClick={() => onSelect(emoji)}
                  className={`w-10 h-10 rounded-lg text-xl transition-all transform hover:scale-110 ${currentEmoji === emoji
                    ? 'bg-purple-500 scale-110 shadow-lg ring-2 ring-purple-300'
                    : 'bg-gray-100 hover:bg-gray-200'
                    }`}
                >
                  {emoji}
                </button>
              ))}
            </div>
          </div>
        ))}
      </div>
    );
  };

  const renderContentGenerator = () => {
    if (!contentTypes || contentTypes.length === 0) return null;

    return (
      <div className="fixed inset-0 bg-black/40 backdrop-blur-sm z-50 flex items-center justify-center p-4 overflow-y-auto">
        <div className="bg-white rounded-2xl max-w-6xl w-full max-h-[90vh] overflow-y-auto shadow-xl border border-gray-200 animate-fadeIn">

          {/* HEADER - Azul moderno */}
          <div className="sticky top-0 bg-gradient-to-r from-blue-700 to-cyan-700 text-white p-6 rounded-t-2xl z-20 shadow-md">
            <div className="flex justify-between items-center">
              <div>
                <h2 className="text-3xl font-bold flex items-center gap-2">
                  <Sparkles className="w-7 h-7 text-blue-200" />
                  Generador de Contenido con IA
                </h2>
                <p className="text-blue-100 text-sm mt-1">
                  Crea quizzes, juegos, ejercicios y más con inteligencia artificial
                </p>
              </div>
              <button
                onClick={() => setShowContentGenerator(false)}
                className="bg-white/10 hover:bg-white/20 p-2 rounded-lg transition-all"
              >
                <X className="w-6 h-6" />
              </button>
            </div>
          </div>

          {/* TABS */}
          <div className="flex gap-2 p-4 border-b border-gray-200 bg-gray-50">
            {[
              { id: "generator", label: "Generador", icon: Sparkles },
              { id: "library", label: " Biblioteca", icon: Library },
            ].map(tab => {
              const Icon = tab.icon;
              return (
                <button
                  key={tab.id}
                  onClick={() => setContentGeneratorTab(tab.id)}
                  className={`flex items-center gap-2 px-5 py-2.5 rounded-lg font-semibold transition-all ${contentGeneratorTab === tab.id
                    ? "bg-blue-600 text-white shadow-sm"
                    : "bg-white text-gray-700 hover:bg-gray-100 border border-gray-300"
                    }`}
                >
                  <Icon className="w-4 h-4" />
                  {tab.label}
                </button>
              );
            })}
          </div>

          {/* BODY */}
          <div className="p-6 bg-gray-50">

            {/* ==================== GENERADOR ==================== */}
            {contentGeneratorTab === "generator" && (
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* Tipos de contenido */}
                <div className="lg:col-span-1">
                  <h3 className="text-lg font-bold text-gray-800 mb-4 flex items-center gap-2">
                    <Grid className="w-5 h-5 text-blue-600" />
                    Tipos de Contenido
                  </h3>
                  <div className="space-y-3">
                    {contentTypes.map(type => (
                      <button
                        key={type.id}
                        onClick={() => setContentType(type.id)}
                        className={`w-full text-left p-4 rounded-xl border transition-all ${contentType === type.id
                          ? "border-blue-500 bg-blue-50 shadow-sm ring-1 ring-blue-200"
                          : "border-gray-200 bg-white hover:border-gray-300 hover:shadow-sm"
                          }`}
                      >
                        <div className="flex items-center gap-3">
                          <span className="text-3xl">{type.icon}</span>
                          <div>
                            <h4 className="font-semibold text-gray-800">{type.name}</h4>
                            <p className="text-xs text-gray-500 mt-0.5">{type.description}</p>
                          </div>
                        </div>
                      </button>
                    ))}
                  </div>
                </div>

                {/* Formulario de generación */}
                <div className="lg:col-span-2">
                  <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div className="bg-gray-50 p-5 border-b border-gray-200">
                      <div className="flex items-center gap-3">
                        <span className="text-4xl">{contentTypes.find(c => c.id === contentType)?.icon}</span>
                        <div>
                          <h3 className="text-xl font-bold text-gray-800">
                            {contentTypes.find(c => c.id === contentType)?.name}
                          </h3>
                          <p className="text-gray-500 text-sm">
                            {contentTypes.find(c => c.id === contentType)?.prompt}
                          </p>
                        </div>
                      </div>
                    </div>

                    <div className="p-6 space-y-5">
                      <textarea
                        value={generatorPrompt}
                        onChange={(e) => setGeneratorPrompt(e.target.value)}
                        placeholder={`Ejemplo: ${contentTypes.find(c => c.id === contentType)?.examples?.join(', ') || 'fracciones, animales, números'}`}
                        className="w-full h-36 px-4 py-3 bg-gray-50 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all resize-none text-gray-800"
                      />

                      <button
                        onClick={generateContentWithAI}
                        disabled={generatingContent}
                        className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-lg transition-all flex items-center justify-center gap-2 shadow-sm disabled:opacity-50"
                      >
                        {generatingContent ? (
                          <>
                            <RefreshCw className="w-5 h-5 animate-spin" />
                            Generando...
                          </>
                        ) : (
                          <>
                            <Sparkles className="w-5 h-5" />
                            Generar con IA
                          </>
                        )}
                      </button>
                    </div>
                  </div>

                  {/* Sugerencia */}
                  <div className="mt-5 bg-blue-50 rounded-lg p-4 border border-blue-200">
                    <p className="text-sm text-blue-800 flex items-center gap-2">
                      <Lightbulb className="w-5 h-5 text-blue-500" />
                      <strong>💡 Sugerencia:</strong> Sé específico. Por ejemplo: "Crea un quiz de 5 preguntas sobre los animales de la granja para niños de 6 años".
                    </p>
                  </div>
                </div>
              </div>
            )}

            {/* ==================== BIBLIOTECA ==================== */}
            {contentGeneratorTab === "library" && (
              <div>
                <div className="flex justify-between items-center mb-6">
                  <div>
                    <h3 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                      <Library className="w-6 h-6 text-blue-600" />
                      Contenido Generado
                    </h3>
                    <p className="text-gray-500 text-sm mt-1">
                      Todos tus quizzes, juegos y ejercicios creados con IA
                    </p>
                  </div>
                  {editingContent && (
                    <button
                      onClick={saveEditedContent}
                      disabled={savingChanges}
                      className="bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 text-white px-4 py-2 rounded-lg font-semibold flex items-center gap-2 transition-all shadow-sm"
                    >
                      {savingChanges ? (
                        <RefreshCw className="w-4 h-4 animate-spin" />
                      ) : (
                        <Save className="w-4 h-4" />
                      )}
                      Guardar Cambios
                    </button>
                  )}
                </div>

                {contentLibrary.length === 0 ? (
                  <div className="text-center py-16 bg-white rounded-xl border border-dashed border-gray-300">
                    <Sparkles className="w-16 h-16 text-gray-300 mx-auto mb-4" />
                    <p className="text-xl font-semibold text-gray-600">📭 Aún no hay contenido</p>
                    <p className="text-gray-400 mt-2">Usa el generador para crear tu primer contenido educativo</p>
                  </div>
                ) : (
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {contentLibrary.map(item => {
                      const isEditing = editingContent?.id === item.id;
                      const currentData = isEditing ? editingContent : item;
                      const typeInfo = contentTypes.find(c => c.id === item.type);

                      return (
                        <div
                          key={item.id}
                          className={`group rounded-xl overflow-hidden bg-white shadow-sm hover:shadow-md transition-all duration-200 border ${isEditing ? "border-amber-400 ring-2 ring-amber-200" : "border-gray-200"
                            }`}
                        >
                          {/* Header gris oscuro */}
                          <div className="bg-gray-800 p-4 text-white">
                            <div className="flex justify-between items-start">
                              <div className="flex-1">
                                {isEditing ? (
                                  <input
                                    type="text"
                                    value={currentData.title}
                                    onChange={(e) => setEditingContent({ ...currentData, title: e.target.value })}
                                    className="w-full bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-white text-sm font-medium focus:outline-none focus:ring-1 focus:ring-blue-400"
                                  />
                                ) : (
                                  <>
                                    <span className="text-xs font-medium uppercase tracking-wide bg-gray-700 px-2 py-0.5 rounded-full">
                                      {typeInfo?.name || item.type}
                                    </span>
                                    <h3 className="font-bold text-base mt-2 line-clamp-2">{item.title}</h3>
                                  </>
                                )}
                              </div>
                              <span className="text-2xl ml-2">{typeInfo?.icon}</span>
                            </div>
                          </div>

                          {/* Body */}
                          <div className="p-4 space-y-3">
                            {isEditing ? (
                              <textarea
                                value={currentData.prompt}
                                onChange={(e) => setEditingContent({ ...currentData, prompt: e.target.value })}
                                className="w-full bg-gray-50 border border-gray-300 rounded-md p-2 text-sm resize-none focus:ring-1 focus:ring-blue-500"
                                rows={2}
                              />
                            ) : (
                              <div className="bg-gray-50 rounded-md p-2 text-sm text-gray-700 line-clamp-2 border-l-3 border-blue-400">
                                💡 {item.prompt}
                              </div>
                            )}

                            {/* Edición específica para quizzes */}
                            {isEditing && item.type === 'quiz' && (
                              <div className="max-h-80 overflow-y-auto border rounded-md p-3 space-y-3 bg-gray-50">
                                <p className="font-bold text-sm text-gray-700">📝 Editar preguntas del Quiz</p>
                                {currentData.content.questions?.map((q, idx) => (
                                  <div key={idx} className="bg-white p-4 rounded-lg border space-y-3 shadow-sm">
                                    <div className="flex items-center gap-2">
                                      <span className="font-bold text-blue-600">Pregunta {idx + 1}</span>
                                      <input
                                        type="text"
                                        value={q.text || q.pregunta || ''}
                                        onChange={(e) => {
                                          const updated = { ...currentData };
                                          updated.content.questions[idx].text = e.target.value;
                                          updated.content.questions[idx].pregunta = e.target.value;
                                          setEditingContent(updated);
                                        }}
                                        className="flex-1 border rounded px-3 py-2 text-base"
                                        placeholder="Texto de la pregunta"
                                      />
                                    </div>
                                    <div className="space-y-2">
                                      {(q.options || q.opciones || []).map((opt, oIdx) => (
                                        <div key={oIdx} className="flex gap-2 items-center">
                                          <div className="w-10 text-center text-2xl">
                                            {(q.imagen_opciones || q.image_options || [])[oIdx] || '🎨'}
                                          </div>
                                          <input
                                            type="text"
                                            value={opt}
                                            onChange={(e) => {
                                              const updated = { ...currentData };
                                              updated.content.questions[idx].options[oIdx] = e.target.value;
                                              updated.content.questions[idx].opciones[oIdx] = e.target.value;
                                              setEditingContent(updated);
                                            }}
                                            className="flex-1 border rounded px-3 py-2 text-base"
                                            placeholder={`Opción ${String.fromCharCode(65 + oIdx)}`}
                                          />
                                          <button
                                            onClick={() => {
                                              const updated = { ...currentData };
                                              updated.content.questions[idx].correct = oIdx;
                                              updated.content.questions[idx].respuesta_correcta = oIdx;
                                              setEditingContent(updated);
                                            }}
                                            className={`w-10 h-10 rounded text-base font-bold ${(q.correct ?? q.respuesta_correcta) === oIdx ? 'bg-blue-500 text-white' : 'bg-gray-200'
                                              }`}
                                          >
                                            {(q.correct ?? q.respuesta_correcta) === oIdx ? '✓' : oIdx + 1}
                                          </button>
                                        </div>
                                      ))}
                                    </div>
                                  </div>
                                ))}
                              </div>
                            )}

                            {/* Fecha y tipo */}
                            <div className="flex justify-between items-center text-xs text-gray-400 pt-1 border-t">
                              <span>📅 {item.createdAt}</span>
                              <span className="capitalize font-medium text-gray-500">{item.type}</span>
                            </div>

                            {/* BOTONES ACTUALIZADOS */}
                            <div className="grid grid-cols-2 gap-2 pt-2">

                              {/* Botón Ver (solo quizzes)  */}
                              {item.type === 'quiz' && !isEditing && (
                                <button
                                  onClick={() => {
                                    // Crear un objeto "resource" simulado para usar openPreview
                                    const tempResource = {
                                      id: item.id,
                                      titulo: item.title,
                                      tipo: 'quiz',
                                      contenido_quiz: item.content?.questions || item.preguntas || []
                                    };
                                    // Usar la misma función openPreview que usan los recursos
                                    openPreview(tempResource);
                                  }}
                                  className="bg-blue-500 hover:bg-blue-600 text-white py-1.5 rounded-md text-xs font-medium flex items-center justify-center gap-1 transition"
                                >
                                  <Eye className="w-3.5 h-3.5" /> Ver
                                </button>
                              )}
                              {/* MANDAR A RECURSOS (solo quizzes) */}
                              {item.type === 'quiz' && !isEditing && (
                                <button
                                  onClick={() => convertContentToResource(item)}
                                  className="bg-green-500 hover:bg-green-600 text-white py-1.5 rounded-md text-xs font-medium flex items-center justify-center gap-1 transition"
                                >
                                  <Upload className="w-3.5 h-3.5" /> Mandar a Recursos
                                </button>
                              )}

                              {/* Botón Editar/Guardar */}
                              <button
                                onClick={() => {
                                  if (isEditing) {
                                    saveEditedContent();
                                    setEditingContent(null);
                                  } else {
                                    setEditingContent(JSON.parse(JSON.stringify(item)));
                                  }
                                }}
                                className={`py-1.5 rounded-md text-xs font-medium flex items-center justify-center gap-1 transition ${isEditing
                                  ? 'bg-blue-600 hover:bg-blue-700 text-white'
                                  : 'bg-amber-500 hover:bg-amber-600 text-white'
                                  }`}
                              >
                                {isEditing ? <Save className="w-3.5 h-3.5" /> : <Edit2 className="w-3.5 h-3.5" />}
                                {isEditing ? 'Guardar' : 'Editar'}
                              </button>

                              {/* Botón Descargar */}
                              {!isEditing && (
                                <button
                                  onClick={() => downloadContentFile(item)}
                                  className="bg-gray-500 hover:bg-gray-600 text-white py-1.5 rounded-md text-xs font-medium flex items-center justify-center gap-1 transition"
                                >
                                  <Download className="w-3.5 h-3.5" /> Descargar
                                </button>
                              )}
                            </div>

                            {/* Fila adicional para Eliminar (si no está en edición) */}
                            {!isEditing && (
                              <div className="grid grid-cols-1 gap-2">
                                <button
                                  onClick={() => {
                                    if (confirm(`¿Eliminar "${item.title}"?`)) deleteGeneratedContent(item.id);
                                  }}
                                  className="bg-red-500 hover:bg-red-600 text-white py-1.5 rounded-md text-xs font-medium flex items-center justify-center gap-1 transition"
                                >
                                  <Trash2 className="w-3.5 h-3.5" /> Eliminar
                                </button>
                              </div>
                            )}

                            {isEditing && (
                              <button
                                onClick={() => setEditingContent(null)}
                                className="w-full mt-1 bg-gray-200 hover:bg-gray-300 text-gray-700 py-1.5 rounded-md text-xs font-medium transition"
                              >
                                Cancelar edición
                              </button>
                            )}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Footer */}
          <div className="border-t border-gray-200 p-4 bg-gray-50 flex justify-end rounded-b-2xl">
            <button
              onClick={() => setShowContentGenerator(false)}
              className="px-5 py-2 bg-gray-200 hover:bg-gray-300 text-gray-700 rounded-lg font-medium transition"
            >
              Cerrar
            </button>
          </div>
        </div>
      </div>
    );
  };

  if (error && error.includes("permisos")) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="bg-white p-8 rounded-lg shadow-md text-center max-w-md">
          <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <h2 className="text-xl font-bold text-gray-800 mb-2">
            Acceso Denegado
          </h2>
          <p className="text-gray-600 mb-4">{error}</p>
          <button
            onClick={() => navigate("/dashboard")}
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

  // Renderizar visor/editor de contenido interactivo



  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {error && !error.includes("permisos") && (
        <div className="bg-red-50 border border-red-200 p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center">
              <AlertCircle className="w-5 h-5 text-red-500 mr-2" />
              <p className="text-red-700">{error}</p>
            </div>
            <button
              onClick={() => setError(null)}
              className="text-red-500 hover:text-red-700"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>
      )}

      <header className="bg-white shadow-sm border-b">
        <div className="px-6 py-4 flex justify-between items-center">
          <div>
            <h1 className="text-2xl font-bold text-gray-800">
              Panel de Administrador
            </h1>
            <p className="text-gray-600 text-sm">
              Sistema de gestión educativa con IA
            </p>
          </div>

          <div className="flex items-center gap-4">
            <button
              onClick={refreshData}
              disabled={refreshing}
              className="flex items-center gap-2 px-3 py-2 text-gray-600 hover:text-gray-800 hover:bg-gray-100 rounded-lg transition-colors"
            >
              <RefreshCw
                className={`w-4 h-4 ${refreshing ? "animate-spin" : ""}`}
              />
              <span className="text-sm">Actualizar</span>
            </button>

            <div className="relative">
              <button
                onClick={() => setMenuOpen(!menuOpen)}
                className="flex items-center gap-3 bg-gray-100 hover:bg-gray-200 px-4 py-2 rounded-lg transition-colors"
              >
                <div className="w-8 h-8 bg-red-500 rounded-full flex items-center justify-center text-white font-semibold">
                  {currentUser?.nombre?.charAt(0).toUpperCase() || "A"}
                </div>
                <span className="font-medium text-gray-700">
                  {currentUser?.nombre || "Admin"}
                </span>
              </button>

              {menuOpen && (
                <div className="absolute right-0 mt-2 w-80 bg-white shadow-2xl rounded-xl border-2 border-gray-200 py-3 z-50">
                  {/* HEADER: Info del Usuario */}
                  <div className="px-4 py-3 border-b-2 border-gray-200">
                    <div className="flex items-center gap-3 mb-3">
                      <div className="w-10 h-10 bg-red-500 rounded-full flex items-center justify-center text-white font-bold text-lg">
                        {currentUser?.nombre?.charAt(0).toUpperCase() || "U"}
                      </div>
                      <div className="flex-1">
                        <p className="text-sm font-bold text-gray-900">
                          {currentUser?.nombre}
                        </p>
                        <p className="text-xs text-gray-500">
                          {currentUser?.email}
                        </p>
                      </div>
                    </div>

                    {/* SELECTOR DE ROLES - CON CONTRASEÑA */}
                    <div className="space-y-2">
                      <p className="text-xs font-bold text-gray-600 uppercase mb-2">
                        🔄 Mis Roles (cambiar requiere contraseña)
                      </p>

                      {(() => {
                        const allRoles = [
                          currentUser?.rol,
                          ...(currentUser?.roles_adicionales || []),
                        ].filter((rol, index, self) => self.indexOf(rol) === index && rol);

                        return (
                          <div className="space-y-2">
                            {allRoles.length > 1 ? (
                              allRoles.map((rol) => {
                                const roleInfo = availableRoles.find(
                                  (r) => r.value === rol
                                );
                                const isActive = rol === activeRoleView;

                                return (
                                  <button
                                    key={rol}
                                    onClick={() => {
                                      if (isActive) {
                                        setMenuOpen(false);
                                        return;
                                      }

                                      console.log(`🔐 Solicitando cambio a rol: ${rol}`);
                                      setTargetRole(rol);
                                      setShowReauthModal(true);
                                      setReauthPassword("");
                                      setReauthError(null);
                                      setMenuOpen(false);
                                    }}
                                    className={`w-full text-left px-4 py-3 rounded-lg transition-all border-2 flex items-center justify-between gap-3 ${isActive
                                      ? "bg-blue-100 border-blue-500 font-bold text-blue-900 shadow-md cursor-default"
                                      : "border-gray-300 hover:border-blue-400 hover:bg-blue-50 text-gray-800 cursor-pointer"
                                      }`}
                                  >
                                    <div className="flex items-center gap-2">
                                      <div
                                        className={`w-3 h-3 rounded-full ${roleInfo?.color === "red"
                                          ? "bg-red-500"
                                          : roleInfo?.color === "blue"
                                            ? "bg-blue-500"
                                            : roleInfo?.color === "green"
                                              ? "bg-green-500"
                                              : "bg-gray-500"
                                          }`}
                                      />
                                      <span className="capitalize font-semibold">
                                        {roleInfo?.label || rol}
                                      </span>
                                    </div>
                                    {isActive && (
                                      <span className="text-xs bg-blue-500 text-white px-2 py-1 rounded-full font-bold">
                                        ● ACTIVO
                                      </span>
                                    )}
                                    {!isActive && (
                                      <span className="text-xs text-gray-400">🔒</span>
                                    )}
                                  </button>
                                );
                              })
                            ) : (
                              <p className="text-xs text-gray-500 italic">
                                Solo tienes un rol disponible
                              </p>
                            )}
                          </div>
                        );
                      })()}
                    </div>
                  </div>

                  {/* LOGOUT */}
                  <div className="px-4 py-2 border-t-2 border-gray-200">
                    <button
                      onClick={handleLogout}
                      className="w-full flex items-center gap-3 px-4 py-2 text-red-600 hover:bg-red-50 rounded transition-colors font-semibold"
                    >
                      <LogOut className="w-4 h-4" />
                      Cerrar Sesión
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="px-6">
          <div className="flex space-x-6 overflow-x-auto">
            {[
              { id: "dashboard", label: "Dashboard", icon: BarChart3 },
              { id: "users", label: "Usuarios", icon: Users },
              { id: "courses", label: "Cursos", icon: BookOpen },
              { id: "resources", label: "Recursos", icon: FileText },
              { id: "levels", label: "Niveles", icon: GraduationCap },
              { id: "achievements", label: "Logros", icon: Award },
            ].map((tab) => {
              const TabIcon = tab.icon;
              return (
                <button
                  key={tab.id}
                  onClick={() => {
                    setActiveTab(tab.id);
                    setShowQuizBuilder(false);
                    setPreviewQuiz(false);
                    setShowDetailedAnalytics(false);
                  }}
                  className={`py-3 px-1 border-b-2 font-medium text-sm transition-colors flex items-center gap-2 whitespace-nowrap ${activeTab === tab.id
                    ? "border-blue-500 text-blue-600"
                    : "border-transparent text-gray-500 hover:text-gray-700"
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
        {activeTab === "dashboard" && renderDashboard()}

        {activeTab === "users" && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">
                👥 Gestión de Usuarios y Estudiantes
              </h2>
              <div className="flex gap-3">
                {/* NUEVO BOTÓN: AGREGAR ESTUDIANTE */}
                <button
                  onClick={() => setShowNewStudent(true)}
                  className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors font-semibold shadow-lg"
                >
                  <Plus className="w-5 h-5" />
                  Nuevo Estudiante
                </button>

                <button
                  onClick={() => setShowNewGroup(true)}
                  className="flex items-center gap-2 bg-purple-500 hover:bg-purple-600 text-white px-4 py-2 rounded-lg transition-colors"
                >
                  <Plus className="w-4 h-4" />
                  Nuevo Grupo
                </button>
                <div className="text-sm text-gray-600 flex items-center">
                  Total: {getFilteredUsers().length} usuarios
                </div>
              </div>
            </div>

            {/* MODAL: CREAR NUEVO ESTUDIANTE - COMPACTO */}
            {showNewStudent && (
              <div className="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center p-4">
                <div className="bg-white rounded-3xl max-w-sm w-full shadow-2xl overflow-hidden">

                  {/* HEADER */}
                  <div className="relative h-32 bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600">
                    <div className="relative h-full flex items-center justify-between p-4">
                      <div className="flex items-center gap-2">
                        <div className="w-10 h-10 bg-white bg-opacity-90 rounded-xl flex items-center justify-center">
                          <Users className="w-5 h-5 text-indigo-600" />
                        </div>
                        <div>
                          <h2 className="text-lg font-black text-white">Nuevo Estudiante</h2>
                          <p className="text-indigo-100 text-xs font-medium">Registro rápido</p>
                        </div>
                      </div>

                      <button
                        onClick={() => {
                          setShowNewStudent(false);
                          setStudentMessage("");
                        }}
                        className="hover:bg-white hover:bg-opacity-20 p-2 rounded-lg transition-all"
                      >
                        <X className="w-5 h-5 text-white" />
                      </button>
                    </div>
                  </div>

                  {/* CONTENIDO */}
                  <div className="px-4 py-4 space-y-3 max-h-[70vh] overflow-y-auto">

                    {studentMessage && (
                      <div className={`p-3 rounded-xl text-xs font-semibold border-l-4 flex items-center gap-2 ${studentMessage.includes("✅")
                        ? "bg-emerald-50 text-emerald-800 border-emerald-500"
                        : "bg-rose-50 text-rose-800 border-rose-500"
                        }`}>
                        {studentMessage.includes("✅") ? (
                          <CheckCircle className="w-4 h-4 flex-shrink-0" />
                        ) : (
                          <AlertCircle className="w-4 h-4 flex-shrink-0" />
                        )}
                        <span>{studentMessage}</span>
                      </div>
                    )}

                    <div className="space-y-1">
                      <label className="block text-xs font-bold text-gray-800">
                        👤 Nombre <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={newStudentData.nombre}
                        onChange={(e) =>
                          setNewStudentData({
                            ...newStudentData,
                            nombre: e.target.value,
                          })
                        }
                        className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-sm text-gray-800"
                        placeholder="Juan Pérez García"
                        disabled={creatingStudent}
                      />
                    </div>

                    <div className="space-y-1">
                      <label className="block text-xs font-bold text-gray-800">
                        🎯 Usuario <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={newStudentData.usuario}
                        onChange={(e) =>
                          setNewStudentData({
                            ...newStudentData,
                            usuario: e.target.value.toLowerCase().replace(/\s/g, ""),
                          })
                        }
                        className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-sm text-gray-800"
                        placeholder="juanperez"
                        disabled={creatingStudent}
                      />
                      <p className="text-xs text-gray-500">Mínimo 3 caracteres, sin espacios</p>
                    </div>

                    <div className="space-y-1">
                      <label className="block text-xs font-bold text-gray-800">
                        🏫 Grupo (Opcional)
                      </label>
                      <select
                        value={newStudentData.grupo_id}
                        onChange={(e) =>
                          setNewStudentData({
                            ...newStudentData,
                            grupo_id: e.target.value,
                          })
                        }
                        className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 text-sm text-gray-800 bg-white cursor-pointer"
                        disabled={creatingStudent}
                      >
                        <option value="">-- Selecciona --</option>
                        {groups.map((group) => (
                          <option key={group.id} value={group.id}>
                            {group.nombre}
                          </option>
                        ))}
                      </select>
                    </div>

                    <div className="flex items-center gap-2 my-3">
                      <div className="flex-1 h-px bg-gray-300"></div>
                      <span className="text-xs text-gray-500 font-bold px-1">SEGURIDAD</span>
                      <div className="flex-1 h-px bg-gray-300"></div>
                    </div>

                    <div className="space-y-1">
                      <label className="block text-xs font-bold text-gray-800">
                        🔐 Contraseña <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="password"
                        value={newStudentData.password}
                        onChange={(e) =>
                          setNewStudentData({
                            ...newStudentData,
                            password: e.target.value,
                          })
                        }
                        className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-sm text-gray-800"
                        placeholder="••••••••"
                        disabled={creatingStudent}
                      />
                      <p className="text-xs text-gray-500">Mínimo 6 caracteres</p>
                    </div>

                    <div className="space-y-1">
                      <label className="block text-xs font-bold text-gray-800">
                        🔁 Confirmar <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="password"
                        value={newStudentData.confirm_password}
                        onChange={(e) =>
                          setNewStudentData({
                            ...newStudentData,
                            confirm_password: e.target.value,
                          })
                        }
                        className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-sm text-gray-800"
                        placeholder="••••••••"
                        disabled={creatingStudent}
                      />
                      {newStudentData.password && newStudentData.confirm_password && (
                        <div className={`flex items-center gap-1 text-xs font-semibold ${newStudentData.password === newStudentData.confirm_password
                          ? "text-emerald-700"
                          : "text-rose-700"
                          }`}>
                          {newStudentData.password === newStudentData.confirm_password ? (
                            <>
                              <CheckCircle className="w-3 h-3" />
                              Coinciden ✓
                            </>
                          ) : (
                            <>
                              <AlertCircle className="w-3 h-3" />
                              No coinciden
                            </>
                          )}
                        </div>
                      )}
                    </div>

                    <div className="space-y-1 bg-blue-50 p-3 rounded-lg border border-blue-200">
                      <label className="block text-xs font-bold text-gray-800">
                        📧 Email (Auto-generado)
                      </label>
                      <div className="text-sm font-mono text-blue-600 break-all">
                        {newStudentData.email ||
                          `${newStudentData.usuario || "[usuario]"}@didactikapp.com`}
                      </div>
                      <input
                        type="email"
                        value={newStudentData.email}
                        onChange={(e) =>
                          setNewStudentData({
                            ...newStudentData,
                            email: e.target.value,
                          })
                        }
                        className="w-full px-2 py-1 border border-blue-200 rounded text-xs mt-2"
                        placeholder="Dejar en blanco para usar generado"
                        disabled={creatingStudent}
                      />
                    </div>
                  </div>

                  {/* BOTONES - SOLO UN ONCLICK POR BOTÓN */}
                  <div className="flex gap-2 p-4 bg-gray-50 border-t border-gray-200">
                    <button
                      onClick={() => {
                        setShowNewStudent(false);
                        setStudentMessage("");
                        setNewStudentData({
                          nombre: "",
                          usuario: "",
                          password: "",
                          confirm_password: "",
                          grupo_id: "",
                          email: "",
                        });
                      }}
                      disabled={creatingStudent}
                      className="flex-1 px-3 py-2 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-lg font-bold text-sm transition-all disabled:opacity-50"
                    >
                      ✕ Cancelar
                    </button>

                    {/* ✅ BOTÓN CREAR - UN SOLO ONCLICK */}
                    <button
                      onClick={createStudent}
                      disabled={
                        creatingStudent ||
                        !newStudentData.nombre.trim() ||
                        newStudentData.usuario.length < 3 ||
                        newStudentData.password.length < 6 ||
                        newStudentData.password !== newStudentData.confirm_password
                      }
                      className="flex-1 px-3 py-2 bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 hover:from-indigo-700 hover:via-purple-700 hover:to-pink-700 text-white rounded-lg font-bold text-sm transition-all disabled:opacity-50 flex items-center justify-center gap-1"
                    >
                      {creatingStudent ? (
                        <>
                          <RefreshCw className="w-4 h-4 animate-spin" />
                          <span>Creando...</span>
                        </>
                      ) : (
                        <>
                          <Plus className="w-4 h-4" />
                          <span>Crear</span>
                        </>
                      )}
                    </button>
                  </div>
                </div>
              </div>
            )}
            {/* Formulario Nuevo Grupo */}
            {showNewGroup && (
              <div className="bg-white rounded-lg shadow-sm border p-6">
                <h3 className="text-lg font-semibold text-gray-800 mb-4">
                  Crear Nuevo Grupo
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Nombre del Grupo
                    </label>
                    <input
                      type="text"
                      value={newGroup.nombre}
                      onChange={(e) =>
                        setNewGroup({ ...newGroup, nombre: e.target.value })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      placeholder="Ej: Grupo A, Grupo B"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Descripción
                    </label>
                    <input
                      type="text"
                      value={newGroup.descripcion}
                      onChange={(e) =>
                        setNewGroup({
                          ...newGroup,
                          descripcion: e.target.value,
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      placeholder="Descripción opcional"
                    />
                  </div>
                </div>
                <div className="flex gap-3 mt-4">
                  <button
                    onClick={createGroup}
                    className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <Save className="w-4 h-4" />
                    Guardar
                  </button>
                  <button
                    onClick={() => {
                      setShowNewGroup(false);
                      setNewGroup({ nombre: "", descripcion: "" });
                    }}
                    className="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg transition-colors"
                  >
                    <X className="w-4 h-4" />
                    Cancelar
                  </button>
                </div>
              </div>
            )}

            {/* Filtros */}
            <div className="bg-white rounded-lg shadow-sm border p-4">
              <div className="flex items-center gap-2 mb-3">
                <Filter className="w-5 h-5 text-gray-600" />
                <h3 className="font-semibold text-gray-800">Filtros</h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                {/* Búsqueda por nombre */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    🔍 Buscar por nombre
                  </label>
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <input
                      type="text"
                      value={searchUserText}
                      onChange={(e) => setSearchUserText(e.target.value)}
                      placeholder="Ej: Juan Pérez"
                      className="w-full pl-9 pr-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                    />
                  </div>
                </div>

                {/* Filtro por Rol */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    👤 Rol
                  </label>
                  <select
                    value={filterRole}
                    onChange={(e) => setFilterRole(e.target.value)}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="todos">📋 Todos los roles</option>
                    <option value="admin">👑 Admin</option>
                    <option value="docente">👨‍🏫 Docente</option>
                    <option value="estudiante">🎓 Estudiante</option>
                    <option value="visitante">👤 Visitante</option>
                  </select>
                </div>

                {/* Filtro por Grupo */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    🏫 Grupo
                  </label>
                  <select
                    value={filterGroup}
                    onChange={(e) => setFilterGroup(e.target.value)}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="todos">📋 Todos los grupos</option>
                    {groups.map((group) => (
                      <option key={group.id} value={group.id}>
                        {group.nombre}
                      </option>
                    ))}
                    <option value="sin_grupo">📭 Sin grupo</option>
                  </select>
                </div>

                {/* Filtro por Estado */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    🔘 Estado
                  </label>
                  <select
                    value={filterStatus}
                    onChange={(e) => setFilterStatus(e.target.value)}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="todos">📋 Todos</option>
                    <option value="active">🟢 Activos</option>
                    <option value="inactive">🔴 Inactivos</option>
                  </select>
                </div>
              </div>

              {/* Botón limpiar filtros */}
              {(filterRole !== "todos" || filterGroup !== "todos" || filterStatus !== "todos" || searchUserText) && (
                <button
                  onClick={() => {
                    setFilterRole("todos");
                    setFilterGroup("todos");
                    setFilterStatus("todos");
                    setSearchUserText("");
                  }}
                  className="mt-4 text-sm text-blue-600 hover:text-blue-800 font-medium flex items-center gap-1"
                >
                  <X className="w-3 h-3" />
                  Limpiar todos los filtros
                </button>
              )}
            </div>

            {/* Lista de Grupos */}
            {groups.length > 0 && (
              <div className="bg-white rounded-lg shadow-sm border p-4">
                <h3 className="font-semibold text-gray-800 mb-3">
                  Grupos Existentes
                </h3>
                <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                  {groups.map((group) => {
                    const groupUserCount = users.filter(
                      (u) => u.grupo_id === group.id
                    ).length;
                    return (
                      <div
                        key={group.id}
                        className="bg-purple-50 border-2 border-purple-200 rounded-lg p-3 hover:bg-purple-100 transition-colors"
                      >
                        <div className="flex items-start justify-between">
                          <div className="flex-1">
                            <p className="font-semibold text-gray-800 text-sm">
                              {group.nombre}
                            </p>
                            <p className="text-xs text-gray-600 mt-1">
                              {groupUserCount} usuarios
                            </p>
                          </div>
                          <button
                            onClick={() => deleteGroup(group.id)}
                            className="text-red-500 hover:text-red-700 p-1"
                          >
                            <Trash2 className="w-3 h-3" />
                          </button>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            )}

            {/* Tabla de Usuarios */}
            {getFilteredUsers().length === 0 ? (
              <div className="text-center py-12 bg-white rounded-lg shadow-sm border">
                <Users className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">
                  No hay usuarios que coincidan con los filtros
                </p>
              </div>
            ) : (
              <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead className="bg-gray-50">
                      <tr>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Usuario
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          👤 Usuario/Pass (Estudiantes)
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Email
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Roles
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Grupo
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Último Acceso
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Estado
                        </th>
                        <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">
                          Acciones
                        </th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-200">
                      {getFilteredUsers().map((user) => (
                        <tr key={user.id} className="hover:bg-gray-50">
                          <td className="px-6 py-4">
                            <div className="flex items-center">
                              <div className="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white font-semibold">
                                {user.nombre?.charAt(0).toUpperCase() || "U"}
                              </div>
                              <div className="ml-3">
                                <div className="text-sm font-medium text-gray-900">
                                  {user.nombre || "Sin nombre"}
                                </div>
                              </div>
                            </div>
                          </td>

                          {/* ✅ NUEVA COLUMNA: Usuario/Contraseña */}
                          <td className="px-6 py-4">
                            {user.rol === "estudiante" ? (
                              <div className="bg-blue-50 rounded-lg p-3 border border-blue-200">
                                <p className="text-xs font-semibold text-gray-700 mb-2">👤 Usuario:</p>
                                <p className="font-mono text-sm font-bold text-blue-600 mb-3 break-all">
                                  {user.usuario || "N/A"}
                                </p>
                                <div className="flex gap-2">
                                  <button
                                    onClick={() => {
                                      navigator.clipboard.writeText(user.usuario || "");
                                      alert("✅ Usuario copiado al portapapeles");
                                    }}
                                    className="flex-1 bg-blue-500 hover:bg-blue-600 text-white px-2 py-1 text-xs rounded font-bold transition-colors"
                                  >
                                    Copiar
                                  </button>
                                  <button
                                    onClick={() => {
                                      alert(`📋 CREDENCIALES DEL ESTUDIANTE\n\nNombre: ${user.nombre}\nUsuario: ${user.usuario}\n\n⚠️ Contraseña: No se muestra por seguridad.\n\nSi el estudiante olvida su contraseña, debe notificarte para restablecerla.`);
                                    }}
                                    className="flex-1 bg-gray-500 hover:bg-gray-600 text-white px-2 py-1 text-xs rounded font-bold transition-colors"
                                  >
                                    Ver Info
                                  </button>
                                </div>
                              </div>
                            ) : (
                              <span className="text-gray-400 text-sm">No aplica</span>
                            )}
                          </td>

                          <td className="px-6 py-4 text-sm text-gray-900">
                            {user.email}
                          </td>
                          <td className="px-6 py-4">
                            {editingUser === user.id ? (
                              <div className="space-y-2">
                                <div className="flex flex-wrap gap-2">
                                  {availableRoles.map((role) => (
                                    <label
                                      key={role.value}
                                      className="flex items-center gap-1 cursor-pointer"
                                    >
                                      <input
                                        type="checkbox"
                                        checked={
                                          selectedRoles[user.id]?.includes(
                                            role.value
                                          ) ||
                                          (selectedRoles[user.id] ===
                                            undefined &&
                                            user.rol === role.value)
                                        }
                                        onChange={(e) => {
                                          const currentRoles = selectedRoles[
                                            user.id
                                          ] || [user.rol];
                                          if (e.target.checked) {
                                            setSelectedRoles({
                                              ...selectedRoles,
                                              [user.id]: [
                                                ...currentRoles,
                                                role.value,
                                              ],
                                            });
                                          } else {
                                            setSelectedRoles({
                                              ...selectedRoles,
                                              [user.id]: currentRoles.filter(
                                                (r) => r !== role.value
                                              ),
                                            });
                                          }
                                        }}
                                        className="w-3 h-3"
                                      />
                                      <span className="text-xs">
                                        {role.label}
                                      </span>
                                    </label>
                                  ))}
                                </div>
                                <button
                                  onClick={() => {
                                    const roles = selectedRoles[user.id] || [
                                      user.rol,
                                    ];
                                    updateUserRoles(user.id, roles);
                                  }}
                                  className="text-xs bg-green-500 hover:bg-green-600 text-white px-2 py-1 rounded"
                                >
                                  Guardar Roles
                                </button>
                              </div>
                            ) : (
                              <div className="flex flex-wrap gap-1">
                                <span
                                  className={`px-2 py-1 text-xs font-medium rounded-full border ${getRoleBadgeColor(
                                    user.rol
                                  )}`}
                                >
                                  {user.rol}
                                </span>
                                {user.roles_adicionales &&
                                  user.roles_adicionales.map((rol, idx) => (
                                    <span
                                      key={idx}
                                      className={`px-2 py-1 text-xs font-medium rounded-full border ${getRoleBadgeColor(
                                        rol
                                      )}`}
                                    >
                                      {rol}
                                    </span>
                                  ))}
                              </div>
                            )}
                          </td>
                          <td className="px-6 py-4">
                            {editingUser === user.id ? (
                              <div className="space-y-2">
                                <div className="flex flex-wrap gap-2">
                                  {groups.map((group) => (
                                    <label
                                      key={group.id}
                                      className="flex items-center gap-1 cursor-pointer"
                                    >
                                      <input
                                        type="checkbox"
                                        checked={
                                          selectedGroups[user.id]?.includes(
                                            group.id
                                          ) ||
                                          (selectedGroups[user.id] ===
                                            undefined &&
                                            (user.grupo_id === group.id ||
                                              user.grupos_adicionales?.includes(
                                                group.id
                                              )))
                                        }
                                        onChange={(e) => {
                                          const currentGroups =
                                            selectedGroups[user.id] ||
                                            [
                                              user.grupo_id,
                                              ...(user.grupos_adicionales ||
                                                []),
                                            ].filter(Boolean);

                                          if (e.target.checked) {
                                            setSelectedGroups({
                                              ...selectedGroups,
                                              [user.id]: [
                                                ...currentGroups,
                                                group.id,
                                              ],
                                            });
                                          } else {
                                            setSelectedGroups({
                                              ...selectedGroups,
                                              [user.id]: currentGroups.filter(
                                                (g) => g !== group.id
                                              ),
                                            });
                                          }
                                        }}
                                        className="w-3 h-3"
                                      />
                                      <span className="text-xs">
                                        {group.nombre}
                                      </span>
                                    </label>
                                  ))}
                                </div>
                                <button
                                  onClick={() => {
                                    const groupIds = selectedGroups[
                                      user.id
                                    ] || [user.grupo_id];
                                    updateUserGroups(user.id, groupIds);
                                  }}
                                  className="text-xs bg-green-500 hover:bg-green-600 text-white px-2 py-1 rounded"
                                >
                                  Guardar Grupos
                                </button>
                              </div>
                            ) : (
                              <div className="flex flex-wrap gap-1">
                                {user.grupo_id && (
                                  <span className="px-2 py-1 text-xs font-medium rounded-full bg-purple-100 text-purple-800 border border-purple-200">
                                    {groups.find((g) => g.id === user.grupo_id)
                                      ?.nombre || "Grupo Principal"}
                                  </span>
                                )}
                                {user.grupos_adicionales &&
                                  user.grupos_adicionales.map(
                                    (groupId, idx) => (
                                      <span
                                        key={idx}
                                        className="px-2 py-1 text-xs font-medium rounded-full bg-blue-100 text-blue-800 border border-blue-200"
                                      >
                                        {groups.find((g) => g.id === groupId)
                                          ?.nombre || `Grupo ${groupId}`}
                                      </span>
                                    )
                                  )}
                                {!user.grupo_id &&
                                  (!user.grupos_adicionales ||
                                    user.grupos_adicionales.length === 0) && (
                                    <span className="px-2 py-1 text-xs font-medium rounded-full bg-gray-100 text-gray-600 border border-gray-200">
                                      Sin grupo
                                    </span>
                                  )}
                              </div>
                            )}
                          </td>
                          <td className="px-6 py-4">
                            <SimpleLastAccessDate lastAccess={user.ultimo_acceso} />
                          </td>
                          <td className="px-6 py-4">
                            {(() => {
                              const status = formatLastConnection(user.ultimo_acceso);
                              return (
                                <div className="group relative">
                                  <div className={`flex items-center gap-2 ${status.bgColor} px-3 py-1.5 rounded-full inline-flex`}>
                                    <span className="text-base">{status.icon}</span>
                                    <span className={`text-xs font-semibold ${status.color}`}>
                                      {status.text}
                                    </span>
                                  </div>
                                  {/* Tooltip con información detallada */}
                                  <div className="absolute z-50 invisible group-hover:visible bg-gray-900 text-white text-xs rounded-lg p-2 mt-1 whitespace-nowrap shadow-xl">
                                    <div className="flex items-center gap-2">
                                      <span>{status.icon}</span>
                                      <span>{status.detail || status.text}</span>
                                    </div>
                                    {user.ultimo_acceso && (
                                      <div className="text-gray-300 text-[10px] mt-1">
                                        📅 {new Date(user.ultimo_acceso).toLocaleString()}
                                      </div>
                                    )}
                                  </div>
                                </div>
                              );
                            })()}
                          </td>
                          <td className="px-6 py-4 text-right">
                            <div className="flex justify-end gap-2">
                              <button
                                onClick={() =>
                                  setEditingUser(
                                    editingUser === user.id ? null : user.id
                                  )
                                }
                                className="text-blue-600 hover:text-blue-800 p-2"
                                title="Editar roles"
                              >
                                <Edit2 className="w-4 h-4" />
                              </button>
                              {user.id !== currentUser.id && (
                                <button
                                  onClick={() => deleteUser(user.id)}
                                  className="text-red-600 hover:text-red-800 p-2"
                                  title="Eliminar usuario"
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
              </div>
            )}
          </div>
        )}

        {/* SECCIÓN DE CURSOS */}
        {activeTab === "courses" && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">
                Gestión de Cursos
              </h2>
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
                <h3 className="text-lg font-semibold text-gray-800 mb-4">
                  Crear Nuevo Curso
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Título
                    </label>
                    <input
                      type="text"
                      value={newCourse.titulo}
                      onChange={(e) =>
                        setNewCourse({ ...newCourse, titulo: e.target.value })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      placeholder="Ej: Matemáticas Básicas"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Nivel
                    </label>
                    <select
                      value={newCourse.nivel_id}
                      onChange={(e) =>
                        setNewCourse({ ...newCourse, nivel_id: e.target.value })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                    >
                      <option value="">Seleccionar nivel</option>
                      {levels.map((level) => (
                        <option key={level.id} value={level.id}>
                          {level.nombre}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Descripción
                    </label>
                    <textarea
                      value={newCourse.descripcion}
                      onChange={(e) =>
                        setNewCourse({
                          ...newCourse,
                          descripcion: e.target.value,
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      rows="3"
                      placeholder="Descripción del curso..."
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Color
                    </label>
                    <input
                      type="color"
                      value={newCourse.color}
                      onChange={(e) =>
                        setNewCourse({ ...newCourse, color: e.target.value })
                      }
                      className="w-full h-10 border rounded-lg cursor-pointer"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Orden
                    </label>
                    <input
                      type="number"
                      value={newCourse.orden}
                      onChange={(e) =>
                        setNewCourse({
                          ...newCourse,
                          orden: parseInt(e.target.value),
                        })
                      }
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
                      setNewCourse({
                        titulo: "",
                        descripcion: "",
                        nivel_id: "",
                        color: "#3B82F6",
                        orden: 1,
                      });
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
                      <h3 className="font-semibold text-gray-800 mb-2">
                        {course.titulo}
                      </h3>
                      <p className="text-sm text-gray-600 mb-3 line-clamp-2">
                        {course.descripcion || "Sin descripción"}
                      </p>
                      <div className="flex items-center justify-between text-xs text-gray-500">
                        <span>{course.nivel_nombre}</span>
                        <span>Orden: {course.orden}</span>
                      </div>
                      <div className="flex gap-2 mt-4">
                        {/* BOTÓN REPORTE CORREGIDO - DESCARGA DIRECTA EXCEL */}
                        <button
                          onClick={async () => {
                            try {
                              // Mostrar loading
                              const loadingDiv = document.createElement('div');
                              loadingDiv.className = 'fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center';
                              loadingDiv.innerHTML = '<div class="bg-white rounded-xl p-6 flex items-center gap-3 shadow-2xl"><div class="animate-spin rounded-full h-6 w-6 border-b-2 border-blue-600"></div><span class="font-medium">Generando reporte del curso...</span></div>';
                              document.body.appendChild(loadingDiv);

                              // Obtener estudiantes con progreso en este curso
                              const courseResources = resources.filter(r => r.curso_id === course.id);
                              const courseResourceIds = courseResources.map(r => r.id);

                              const studentsWithProgress = users.filter(u => u.rol === 'estudiante');

                              // Crear contenido CSV
                              let csvContent = "\uFEFF"; // BOM para UTF-8
                              csvContent += `"REPORTE DEL CURSO: ${course.titulo.replace(/"/g, '""')}"\n`;
                              csvContent += `"Fecha de generación","${new Date().toLocaleString('es-ES')}"\n`;
                              csvContent += `"Nivel","${course.nivel_nombre || 'Sin nivel'}"\n`;
                              csvContent += `"Total Estudiantes","${studentsWithProgress.length}"\n`;
                              csvContent += `"Total Recursos","${courseResources.length}"\n`;
                              csvContent += `"Recursos del curso","${courseResources.map(r => r.titulo).join(', ')}"\n`;
                              csvContent += `\n`;
                              csvContent += `"ESTUDIANTES","","","",""\n`;
                              csvContent += `"Nombre","Email","Grupo","Progreso %","Intentos Promedio","Recursos Completados","Último Acceso"\n`;

                              for (const student of studentsWithProgress) {
                                // Obtener progreso del estudiante en este curso
                                const studentProgress = userProgress.filter(p =>
                                  p.usuario_id === student.id && courseResourceIds.includes(p.recurso_id)
                                );

                                const avgProgress = studentProgress.length > 0
                                  ? Math.round(studentProgress.reduce((a, b) => a + (b.progreso || 0), 0) / studentProgress.length)
                                  : 0;

                                const avgAttempts = studentProgress.length > 0
                                  ? (studentProgress.reduce((a, b) => a + (b.intentos || 1), 0) / studentProgress.length).toFixed(1)
                                  : 0;

                                const completedCount = studentProgress.filter(p => p.completado).length;

                                const grupoNombre = student.grupo_id
                                  ? groups.find(g => g.id === student.grupo_id)?.nombre || "Sin grupo"
                                  : "Sin grupo";

                                const ultimoAcceso = student.ultimo_acceso
                                  ? new Date(student.ultimo_acceso).toLocaleDateString('es-ES')
                                  : "Nunca";

                                csvContent += `"${student.nombre.replace(/"/g, '""')}","${student.email || ''}","${grupoNombre}",${avgProgress},${avgAttempts},${completedCount},"${ultimoAcceso}"\n`;
                              }

                              // Descargar archivo
                              const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
                              const link = document.createElement('a');
                              const url = URL.createObjectURL(blob);
                              link.href = url;
                              link.download = `Reporte_${course.titulo.replace(/[^a-z0-9]/gi, '_')}_${new Date().toISOString().split('T')[0]}.csv`;
                              link.click();
                              URL.revokeObjectURL(url);

                              loadingDiv.remove();
                              alert('✅ Reporte descargado correctamente');

                            } catch (error) {
                              console.error('Error:', error);
                              document.querySelector('.fixed.inset-0.bg-black.bg-opacity-50')?.remove();
                              alert('❌ Error al generar el reporte: ' + error.message);
                            }
                          }}
                          className="flex-1 bg-green-50 hover:bg-green-100 text-green-700 px-3 py-2 rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-1"
                        >
                          <Download className="w-3 h-3" />
                          Reporte Excel
                        </button>
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
        {activeTab === "resources" && !showQuizBuilder && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">
                Gestión de Recursos
              </h2>
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
                <h3 className="text-lg font-semibold text-gray-800 mb-4">
                  Crear Nuevo Recurso
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Título
                    </label>
                    <input
                      type="text"
                      value={newResource.titulo}
                      onChange={(e) =>
                        setNewResource({
                          ...newResource,
                          titulo: e.target.value,
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      placeholder="Ej: Video: Suma de números"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Tipo
                    </label>
                    <select
                      value={newResource.tipo}
                      onChange={(e) =>
                        setNewResource({ ...newResource, tipo: e.target.value })
                      }
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
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Curso
                    </label>
                    <select
                      value={newResource.curso_id}
                      onChange={(e) =>
                        setNewResource({
                          ...newResource,
                          curso_id: e.target.value,
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                    >
                      <option value="">Seleccionar curso</option>
                      {courses.map((course) => (
                        <option key={course.id} value={course.id}>
                          {course.titulo}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Puntos de Recompensa
                    </label>
                    <input
                      type="number"
                      value={newResource.puntos_recompensa}
                      onChange={(e) =>
                        setNewResource({
                          ...newResource,
                          puntos_recompensa: parseInt(e.target.value),
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      min="0"
                    />
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Descripción
                    </label>
                    <textarea
                      value={newResource.descripcion}
                      onChange={(e) =>
                        setNewResource({
                          ...newResource,
                          descripcion: e.target.value,
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      rows="3"
                      placeholder="Descripción del recurso..."
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Tiempo Estimado (min)
                    </label>
                    <input
                      type="number"
                      value={newResource.tiempo_estimado}
                      onChange={(e) =>
                        setNewResource({
                          ...newResource,
                          tiempo_estimado: parseInt(e.target.value),
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                      min="1"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Orden
                    </label>
                    <input
                      type="number"
                      value={newResource.orden}
                      onChange={(e) =>
                        setNewResource({
                          ...newResource,
                          orden: parseInt(e.target.value),
                        })
                      }
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
                      setNewResource({
                        titulo: "",
                        descripcion: "",
                        tipo: "video",
                        curso_id: "",
                        puntos_recompensa: 10,
                        tiempo_estimado: 5,
                        orden: 1,
                      });
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
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Recurso
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Tipo
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Curso
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Puntos
                      </th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">
                        Acciones
                      </th>
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
                                <div className="text-sm font-medium text-gray-900">
                                  {resource.titulo}
                                </div>
                                <div className="text-xs text-gray-500">
                                  {resource.tiempo_estimado} min
                                </div>
                              </div>
                            </div>
                          </td>
                          <td className="px-6 py-4 text-sm text-gray-900 capitalize">
                            {resource.tipo}
                          </td>
                          <td className="px-6 py-4 text-sm text-gray-900">
                            {resource.curso_titulo}
                          </td>
                          <td className="px-6 py-4">
                            <span className="px-2 py-1 text-xs font-medium rounded-full bg-yellow-100 text-yellow-800">
                              {resource.puntos_recompensa} pts
                            </span>
                          </td>
                          <td className="px-6 py-4 text-right">
                            <div className="flex justify-end gap-2">
                              {resource.tipo === "quiz" && (
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
        {activeTab === "levels" && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">
                Gestión de Niveles
              </h2>
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
                <h3 className="text-lg font-semibold text-gray-800 mb-4">
                  Crear Nuevo Nivel
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Nombre
                    </label>
                    <input
                      type="text"
                      value={newLevel.nombre}
                      onChange={(e) =>
                        setNewLevel({ ...newLevel, nombre: e.target.value })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-green-500"
                      placeholder="Ej: Primer Grado"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Orden
                    </label>
                    <input
                      type="number"
                      value={newLevel.orden}
                      onChange={(e) =>
                        setNewLevel({
                          ...newLevel,
                          orden: parseInt(e.target.value),
                        })
                      }
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-green-500"
                      min="1"
                    />
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Descripción
                    </label>
                    <textarea
                      value={newLevel.descripcion}
                      onChange={(e) =>
                        setNewLevel({
                          ...newLevel,
                          descripcion: e.target.value,
                        })
                      }
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
                      setNewLevel({ nombre: "", descripcion: "", orden: 1 });
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
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Nivel
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Descripción
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Orden
                      </th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">
                        Acciones
                      </th>
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
                              onBlur={(e) =>
                                updateLevel(level.id, {
                                  nombre: e.target.value,
                                })
                              }
                            />
                          ) : (
                            <div className="text-sm font-medium text-gray-900">
                              {level.nombre}
                            </div>
                          )}
                        </td>
                        <td className="px-6 py-4">
                          {editingLevel === level.id ? (
                            <input
                              type="text"
                              defaultValue={level.descripcion}
                              className="text-sm border rounded px-2 py-1 w-full"
                              onBlur={(e) =>
                                updateLevel(level.id, {
                                  descripcion: e.target.value,
                                })
                              }
                            />
                          ) : (
                            <div className="text-sm text-gray-600">
                              {level.descripcion || "Sin descripción"}
                            </div>
                          )}
                        </td>
                        <td className="px-6 py-4">
                          {editingLevel === level.id ? (
                            <input
                              type="number"
                              defaultValue={level.orden}
                              className="text-sm border rounded px-2 py-1 w-20"
                              min="1"
                              onBlur={(e) =>
                                updateLevel(level.id, {
                                  orden: parseInt(e.target.value),
                                })
                              }
                            />
                          ) : (
                            <span className="text-sm text-gray-900">
                              {level.orden}
                            </span>
                          )}
                        </td>
                        <td className="px-6 py-4 text-right">
                          <div className="flex justify-end gap-2">
                            <button
                              onClick={() =>
                                setEditingLevel(
                                  editingLevel === level.id ? null : level.id
                                )
                              }
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
        {activeTab === "achievements" && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-semibold text-gray-800">
                🏆 Gestión de Logros
              </h2>
              <button
                onClick={() => setShowNewAchievement(true)}
                className="flex items-center gap-2 bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg transition-colors font-semibold shadow-lg"
              >
                <Plus className="w-5 h-5" />
                Nuevo Logro
              </button>
            </div>

            {/* FORMULARIO DE NUEVO LOGRO */}
            {showNewAchievement && (
              <div className="bg-gradient-to-r from-yellow-50 to-orange-50 rounded-2xl border-2 border-yellow-300 p-8 shadow-lg">
                <h3 className="text-2xl font-bold text-yellow-800 mb-6 flex items-center gap-2">
                  <Sparkles className="w-6 h-6" />
                  ✨ Crear Nuevo Logro
                </h3>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                  {/* NOMBRE */}
                  <div>
                    <label className="block text-sm font-bold text-gray-800 mb-3">
                      📝 Nombre del Logro
                    </label>
                    <input
                      type="text"
                      value={newAchievementData.nombre}
                      onChange={(e) =>
                        setNewAchievementData({
                          ...newAchievementData,
                          nombre: e.target.value,
                        })
                      }
                      className="w-full px-4 py-3 border-2 border-yellow-200 rounded-xl focus:ring-2 focus:ring-yellow-500 focus:border-yellow-500 text-lg"
                      placeholder="Ej: Matemático Estrella"
                    />
                  </div>
                  {/* PUNTOS REQUERIDOS */}
                  <div>
                    <label className="block text-sm font-bold text-gray-800 mb-3">
                      ⭐ Puntos Requeridos
                    </label>
                    <input
                      type="number"
                      value={newAchievementData.puntos_requeridos}
                      onChange={(e) =>
                        setNewAchievementData({
                          ...newAchievementData,
                          puntos_requeridos: parseInt(e.target.value) || 100,
                        })
                      }
                      className="w-full px-4 py-3 border-2 border-yellow-200 rounded-xl focus:ring-2 focus:ring-yellow-500 text-lg"
                      min="1"
                    />
                  </div>

                  {/* DESCRIPCIÓN */}
                  <div className="md:col-span-2">
                    <label className="block text-sm font-bold text-gray-800 mb-3">
                      📖 Descripción
                    </label>
                    <textarea
                      value={newAchievementData.descripcion}
                      onChange={(e) =>
                        setNewAchievementData({
                          ...newAchievementData,
                          descripcion: e.target.value,
                        })
                      }
                      className="w-full px-4 py-3 border-2 border-yellow-200 rounded-xl focus:ring-2 focus:ring-yellow-500 text-base"
                      rows="3"
                      placeholder="Describe qué hace especial este logro..."
                    />
                  </div>

                  {/* SELECTOR DE EMOJI/ICONO */}
                  <div className="md:col-span-2">
                    <label className="block text-sm font-bold text-gray-800 mb-3">
                      🎨 Selecciona un Icono/Emoji
                    </label>
                    <div className="bg-white rounded-xl p-4 border-2 border-yellow-200">
                      <div className="grid grid-cols-8 gap-2 mb-4">
                        {[
                          "🏆",
                          "⭐",
                          "🥇",
                          "🥈",
                          "🥉",
                          "🎖️",
                          "🏅",
                          "👑",
                          "💎",
                          "✨",
                          "🌟",
                          "🎯",
                          "🚀",
                          "💡",
                          "📚",
                          "🧠",
                          "🎓",
                          "📖",
                          "✏️",
                          "📝",
                          "🎨",
                          "🎭",
                          "🎪",
                          "🎬",
                          "🎤",
                          "🎸",
                          "🎹",
                          "🎺",
                          "🎻",
                          "🥁",
                          "🏃",
                          "⚽",
                          "🏀",
                          "🎾",
                          "🏐",
                          "⛳",
                          "🏈",
                          "🎱",
                          "🎳",
                          "🏏",
                        ].map((emoji) => (
                          <button
                            key={emoji}
                            onClick={() =>
                              setNewAchievementData({
                                ...newAchievementData,
                                icono: emoji,
                              })
                            }
                            className={`w-12 h-12 rounded-lg text-2xl transition-all transform hover:scale-110 ${newAchievementData.icono === emoji
                              ? "bg-yellow-300 scale-110 ring-4 ring-yellow-500 shadow-lg"
                              : "bg-gray-100 hover:bg-gray-200"
                              }`}
                          >
                            {emoji}
                          </button>
                        ))}
                      </div>
                      <div className="text-center">
                        <p className="text-lg font-bold text-gray-800">
                          Ícono seleccionado: {newAchievementData.icono}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* BOTONES DE ACCIÓN */}
                <div className="flex gap-3">
                  <button
                    onClick={() => {
                      // ✅ IMPORTANTE: Enviar condicion como JSON vacío
                      createAchievement({
                        ...newAchievementData,
                        condicion: {}, // ← SIEMPRE ENVIAR ESTO
                      });
                      setNewAchievementData({
                        nombre: "",
                        descripcion: "",
                        icono: "🏆",
                        puntos_requeridos: 100,
                      });
                      setShowNewAchievement(false);
                    }}
                    className="flex items-center gap-2 bg-green-500 hover:bg-green-600 text-white px-8 py-3 rounded-xl font-bold text-lg transition-all transform hover:scale-105 shadow-lg"
                  >
                    <Save className="w-5 h-5" />
                    ✅ Guardar Logro
                  </button>
                  <button
                    onClick={() => {
                      setShowNewAchievement(false);
                      setNewAchievementData({
                        nombre: "",
                        descripcion: "",
                        icono: "🏆",
                        puntos_requeridos: 100,
                      });
                    }}
                    className="flex items-center gap-2 bg-gray-500 hover:bg-gray-600 text-white px-8 py-3 rounded-xl font-bold transition-all"
                  >
                    <X className="w-5 h-5" />
                    Cancelar
                  </button>
                </div>
              </div>
            )}

            {/* GALERÍA DE LOGROS */}
            {achievements.length === 0 ? (
              <div className="text-center py-16 bg-gradient-to-br from-yellow-50 to-orange-50 rounded-2xl border-2 border-dashed border-yellow-300">
                <Trophy className="w-24 h-24 text-yellow-400 mx-auto mb-4 opacity-50" />
                <p className="text-gray-600 text-xl font-semibold">
                  📭 No hay logros creados
                </p>
                <p className="text-gray-500 mt-2">
                  ¡Haz clic en "Nuevo Logro" para crear el primero!
                </p>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {achievements.map((achievement) => (
                  <div
                    key={achievement.id}
                    className="bg-gradient-to-br from-yellow-50 to-orange-50 rounded-2xl p-6 border-2 border-yellow-300 hover:shadow-xl hover:scale-105 transition-all transform"
                  >
                    {/* ENCABEZADO CON ICONO */}
                    <div className="flex items-start justify-between mb-4">
                      <div className="w-20 h-20 bg-gradient-to-br from-yellow-300 to-orange-300 rounded-2xl flex items-center justify-center text-5xl shadow-lg">
                        {achievement.icono || "🏆"}
                      </div>
                      <button
                        onClick={() => {
                          if (
                            confirm(
                              `¿Eliminar el logro "${achievement.nombre}"?`
                            )
                          ) {
                            deleteAchievementItem(achievement.id);
                          }
                        }}
                        className="bg-red-500 hover:bg-red-600 text-white p-2 rounded-lg transition-all transform hover:scale-110"
                        title="Eliminar logro"
                      >
                        <Trash2 className="w-5 h-5" />
                      </button>
                    </div>

                    {/* CONTENIDO */}
                    <h3 className="font-bold text-gray-800 mb-2 text-lg">
                      {achievement.nombre}
                    </h3>
                    <p className="text-sm text-gray-600 mb-4 line-clamp-3">
                      {achievement.descripcion || "Sin descripción"}
                    </p>

                    {/* ESTADÍSTICAS */}
                    <div className="bg-white rounded-xl p-3 mb-4 border border-yellow-200">
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-xs font-bold text-yellow-700 uppercase">
                          ⭐ Puntos Requeridos
                        </span>
                        <span className="text-lg font-bold text-yellow-600">
                          {achievement.puntos_requeridos}
                        </span>
                      </div>
                      <div className="w-full bg-yellow-200 rounded-full h-2">
                        <div
                          className="bg-yellow-500 h-2 rounded-full"
                          style={{
                            width: `${Math.min(100, (achievement.puntos_requeridos / 500) * 100)}%`,
                          }}
                        ></div>
                      </div>
                    </div>

                    {/* ESTADO */}
                    <div className="flex items-center gap-2 justify-between">
                      <span
                        className={`px-3 py-1 rounded-full text-xs font-bold transition-all ${achievement.activo
                          ? "bg-green-100 text-green-800"
                          : "bg-gray-100 text-gray-800"
                          }`}
                      >
                        {achievement.activo ? "✅ Activo" : "⚫ Inactivo"}
                      </span>
                      <span className="text-xs text-gray-500">
                        ID: {achievement.id}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}

            {/* RESUMEN DE LOGROS */}
            {achievements.length > 0 && (
              <div className="bg-gradient-to-r from-purple-500 via-yellow-500 to-orange-500 rounded-2xl p-6 text-white shadow-lg">
                <h3 className="text-lg font-bold mb-4 flex items-center gap-2">
                  <Trophy className="w-6 h-6" />
                  📊 Resumen de Logros
                </h3>
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                  <div className="bg-white bg-opacity-20 rounded-xl p-4 text-center backdrop-blur">
                    <p className="text-3xl font-bold">{achievements.length}</p>
                    <p className="text-sm font-semibold mt-1">Total Logros</p>
                  </div>
                  <div className="bg-white bg-opacity-20 rounded-xl p-4 text-center backdrop-blur">
                    <p className="text-3xl font-bold">
                      {achievements.filter((a) => a.activo).length}
                    </p>
                    <p className="text-sm font-semibold mt-1">Activos</p>
                  </div>
                  <div className="bg-white bg-opacity-20 rounded-xl p-4 text-center backdrop-blur">
                    <p className="text-3xl font-bold">
                      {achievements.reduce((sum, a) => sum + a.puntos_requeridos, 0)}
                    </p>
                    <p className="text-sm font-semibold mt-1">Total Puntos</p>
                  </div>
                  <div className="bg-white bg-opacity-20 rounded-xl p-4 text-center backdrop-blur">
                    <p className="text-3xl font-bold">
                      {Math.round(
                        achievements.reduce((sum, a) => sum + a.puntos_requeridos, 0) /
                        achievements.length
                      )}
                    </p>
                    <p className="text-sm font-semibold mt-1">Promedio</p>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}
        {/* MODAL DE REPORTE CON FILTROS FUNCIONALES */}
        {showCourseReportModal && courseReportData && (
          <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4 overflow-y-auto backdrop-blur-md">
            <div className="bg-white rounded-3xl max-w-7xl w-full shadow-2xl my-8 overflow-hidden">

              {/* HEADER ULTRA COMPACTO */}
              <div className="sticky top-0 z-10 bg-gradient-to-br from-blue-50 to-blue-100 border-b border-blue-200 p-4">
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-3 flex-1">
                    <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center text-2xl shadow-md">
                      📊
                    </div>
                    <div className="flex-1 min-w-0">
                      <h1 className="text-2xl font-black text-gray-900 truncate">
                        {courseReportData.course.titulo}
                      </h1>
                      <p className="text-xs text-gray-600 font-bold">LEA • ADA • AFS</p>
                    </div>
                  </div>
                  <button
                    onClick={() => setShowCourseReportModal(false)}
                    className="bg-red-100 hover:bg-red-200 p-2 rounded-lg transition-all flex-shrink-0 ml-2"
                  >
                    <X className="w-5 h-5 text-red-600" />
                  </button>
                </div>

                {/* STATS EN UNA LÍNEA */}
                <div className="grid grid-cols-4 gap-2">
                  <div className="bg-white rounded-lg p-2 border border-blue-200 text-center">
                    <p className="text-xs font-bold text-gray-600">👥</p>
                    <p className="text-lg font-black text-gray-900">{courseReportData.stats.totalStudents}</p>
                    <p className="text-xs text-gray-500">Estudiantes</p>
                  </div>
                  <div className="bg-white rounded-lg p-2 border border-blue-200 text-center">
                    <p className="text-xs font-bold text-gray-600">📈</p>
                    <p className="text-lg font-black text-gray-900">{courseReportData.stats.avgProgress}%</p>
                    <p className="text-xs text-gray-500">Progreso</p>
                  </div>
                  <div className="bg-white rounded-lg p-2 border border-blue-200 text-center">
                    <p className="text-xs font-bold text-gray-600">✅</p>
                    <p className="text-lg font-black text-gray-900">{courseReportData.stats.completedResources}</p>
                    <p className="text-xs text-gray-500">Recursos</p>
                  </div>
                  <div className="bg-white rounded-lg p-2 border border-blue-200 text-center">
                    <p className="text-xs font-bold text-gray-600">⏱️</p>
                    <p className="text-lg font-black text-gray-900">{courseReportData.stats.totalTime}m</p>
                    <p className="text-xs text-gray-500">Tiempo</p>
                  </div>
                </div>
              </div>

              {/* FILTROS */}
              <div className="sticky top-24 z-9 bg-white border-b border-gray-200 p-3 flex gap-2 items-end flex-wrap">
                <div className="flex-1 min-w-32">
                  <label className="block text-xs font-bold text-gray-600 mb-1 uppercase">Grupo</label>
                  <select
                    value={filterByGroup}
                    onChange={(e) => setFilterByGroup(e.target.value)}
                    className="w-full px-3 py-1.5 bg-gray-50 border border-gray-300 rounded-lg focus:border-blue-500 focus:ring-1 focus:ring-blue-200 transition-all font-medium text-sm text-gray-800"
                  >
                    <option value="">Todos</option>
                    {[...new Set(courseReportData.students.map((d) => d.grupo))].map((grupo) => (
                      <option key={grupo} value={grupo}>{grupo}</option>
                    ))}
                  </select>
                </div>

                <div className="flex-1 min-w-32">
                  <label className="block text-xs font-bold text-gray-600 mb-1 uppercase">Estado</label>
                  <select
                    value={filterByStatus}
                    onChange={(e) => setFilterByStatus(e.target.value)}
                    className="w-full px-3 py-1.5 bg-gray-50 border border-gray-300 rounded-lg focus:border-blue-500 focus:ring-1 focus:ring-blue-200 transition-all font-medium text-sm text-gray-800"
                  >
                    <option value="">Todos</option>
                    <option value="excellent">✅ Excelente</option>
                    <option value="warning">⚠️ Apoyo</option>
                    <option value="critical">🚨 Crítico</option>
                  </select>
                </div>

                <div className="flex-1 min-w-40">
                  <label className="block text-xs font-bold text-gray-600 mb-1 uppercase">Buscar</label>
                  <input
                    type="text"
                    value={searchStudent}
                    onChange={(e) => setSearchStudent(e.target.value)}
                    placeholder="Nombre..."
                    className="w-full px-3 py-1.5 bg-gray-50 border border-gray-300 rounded-lg focus:border-blue-500 focus:ring-1 focus:ring-blue-200 transition-all placeholder-gray-500 font-medium text-sm"
                  />
                </div>

                <div className="flex items-center gap-2">
                  <div className="bg-blue-100 text-blue-700 px-3 py-1.5 rounded-lg font-bold text-xs border border-blue-300">
                    {courseReportData.students.filter((data) => {
                      if (filterByGroup && data.grupo !== filterByGroup) return false;
                      if (filterByStatus === "excellent" && !data.feedback.overallStatus.includes("✅")) return false;
                      if (filterByStatus === "warning" && !data.feedback.overallStatus.includes("⚠️")) return false;
                      if (filterByStatus === "critical" && !data.feedback.overallStatus.includes("🚨")) return false;
                      if (searchStudent && !data.student.nombre.toLowerCase().includes(searchStudent.toLowerCase())) return false;
                      return true;
                    }).length}
                  </div>

                  {(filterByGroup || filterByStatus || searchStudent) && (
                    <button
                      onClick={() => {
                        setFilterByGroup("");
                        setFilterByStatus("");
                        setSearchStudent("");
                        setExpandedStudent(null);
                      }}
                      className="px-3 py-1.5 bg-red-100 hover:bg-red-200 text-red-700 rounded-lg text-xs font-bold transition-all"
                    >
                      Limpiar
                    </button>
                  )}
                </div>
              </div>

              {/* CONTENIDO PRINCIPAL */}
              <div className="overflow-y-auto max-h-[calc(90vh-280px)] p-4 space-y-3 bg-gradient-to-b from-white to-gray-50">

                {(() => {
                  const filteredStudents = courseReportData.students.filter((data) => {
                    if (filterByGroup && data.grupo !== filterByGroup) return false;
                    if (filterByStatus === "excellent" && !data.feedback.overallStatus.includes("✅")) return false;
                    if (filterByStatus === "warning" && !data.feedback.overallStatus.includes("⚠️")) return false;
                    if (filterByStatus === "critical" && !data.feedback.overallStatus.includes("🚨")) return false;
                    if (searchStudent && !data.student.nombre.toLowerCase().includes(searchStudent.toLowerCase())) return false;
                    return true;
                  });

                  if (filteredStudents.length === 0) {
                    return (
                      <div className="text-center py-16 bg-gray-50 rounded-xl border-2 border-dashed border-gray-300">
                        <Users className="w-20 h-20 text-gray-400 mx-auto mb-3" />
                        <p className="text-gray-600 font-bold">No hay estudiantes</p>
                      </div>
                    );
                  }

                  return filteredStudents.map((data, idx) => {
                    const { student, feedback, grupo, evolution } = data;
                    const isExpanded = expandedStudent === idx;

                    const getStatusColor = (status) => {
                      if (status.includes("✅")) return { header: "bg-green-500 hover:bg-green-600" };
                      if (status.includes("⚠️")) return { header: "bg-yellow-500 hover:bg-yellow-600" };
                      return { header: "bg-red-500 hover:bg-red-600" };
                    };

                    const colors = getStatusColor(feedback.overallStatus);

                    return (
                      <div key={idx} className="bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-md transition-all border border-gray-200">

                        {/* HEADER ESTUDIANTE */}
                        <button
                          onClick={() => setExpandedStudent(isExpanded ? null : idx)}
                          className={`w-full ${colors.header} text-white p-3 hover:shadow-md transition-all flex items-center justify-between`}
                        >
                          <div className="flex items-center gap-3 flex-1 text-left">
                            <div className="w-11 h-11 bg-white bg-opacity-30 rounded-lg flex items-center justify-center text-lg font-black backdrop-blur-sm">
                              {student.nombre?.charAt(0).toUpperCase()}
                            </div>
                            <div className="min-w-0">
                              <h3 className="font-bold text-sm truncate">{student.nombre}</h3>
                              <p className="text-xs text-white text-opacity-90">{grupo}</p>
                            </div>
                          </div>

                          <div className="flex items-center gap-2 ml-2 flex-shrink-0">
                            <span className="text-xs font-bold bg-white bg-opacity-20 px-2 py-1 rounded">
                              {feedback.overallStatus}
                            </span>
                            <ChevronDown className={`w-5 h-5 transition-transform ${isExpanded ? "rotate-180" : ""}`} />
                          </div>
                        </button>

                        {/* CONTENIDO EXPANDIDO */}
                        {isExpanded && (
                          <div className="p-4 space-y-4 bg-gray-50">

                            {/* 3 COLUMNAS: LEA, ADA, AFS */}
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">

                              {/* LEA */}
                              <div className="bg-white rounded-lg p-3 border-2 border-blue-200">
                                <div className="flex items-center justify-between mb-2">
                                  <p className="text-sm font-black text-blue-600">📚 LEA</p>
                                  <span className="text-lg">{feedback.learningEffectiveness?.isLearning ? "✅" : "❌"}</span>
                                </div>
                                <div className="mb-2">
                                  <div className="flex justify-between mb-1 text-xs">
                                    <span className="text-gray-700 font-bold">Confianza</span>
                                    <span className="text-blue-600 font-black">
                                      {feedback.learningEffectiveness?.confidence?.toFixed(0)}%
                                    </span>
                                  </div>
                                  <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                                    <div
                                      className="bg-gradient-to-r from-blue-500 to-blue-600 h-full rounded-full transition-all"
                                      style={{ width: `${feedback.learningEffectiveness?.confidence || 0}%` }}
                                    ></div>
                                  </div>
                                </div>
                                <div className="bg-blue-50 rounded-lg p-2 space-y-1 text-xs border border-blue-100">
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Intentos</span>
                                    <span className="font-black">{feedback.learningEffectiveness?.indicators?.averageAttempts?.toFixed(1)}</span>
                                  </div>
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Tiempo/Pregunta</span>
                                    <span className="font-black">{feedback.learningEffectiveness?.indicators?.averageTimePerQuestion?.toFixed(0)}s</span>
                                  </div>
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Retención</span>
                                    <span className="font-black">{feedback.learningEffectiveness?.indicators?.retentionRate?.toFixed(1)}%</span>
                                  </div>
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Mejora</span>
                                    <span className={`font-black ${feedback.learningEffectiveness?.indicators?.improvementTrend >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                                      {feedback.learningEffectiveness?.indicators?.improvementTrend >= 0 ? '↑' : '↓'}
                                      {Math.abs(feedback.learningEffectiveness?.indicators?.improvementTrend || 0)}%
                                    </span>
                                  </div>
                                </div>
                              </div>

                              {/* ADA */}
                              <div className="bg-white rounded-lg p-3 border-2 border-blue-200">
                                <div className="flex items-center justify-between mb-2">
                                  <p className="text-sm font-black text-blue-600">👁️ ADA</p>
                                  <span className="text-lg">🎯</span>
                                </div>
                                <div className="mb-2">
                                  <div className="flex justify-between mb-1 text-xs">
                                    <span className="text-gray-700 font-bold">Atención</span>
                                    <span className="text-blue-600 font-black">{feedback.attentionLevel?.score || 0}/100</span>
                                  </div>
                                  <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                                    <div
                                      className={`h-full rounded-full transition-all bg-gradient-to-r ${(feedback.attentionLevel?.score || 0) >= 70 ? "from-green-500 to-green-600" : (feedback.attentionLevel?.score || 0) >= 50 ? "from-yellow-500 to-yellow-600" : "from-red-500 to-red-600"}`}
                                      style={{ width: `${feedback.attentionLevel?.score || 0}%` }}
                                    ></div>
                                  </div>
                                </div>
                                <div className={`text-center py-1 rounded text-xs font-bold mb-2 ${(feedback.attentionLevel?.score || 0) >= 70 ? "bg-green-100 text-green-800" : (feedback.attentionLevel?.score || 0) >= 50 ? "bg-yellow-100 text-yellow-800" : "bg-red-100 text-red-800"}`}>
                                  {feedback.attentionLevel?.level}
                                </div>
                                <div className="bg-blue-50 rounded-lg p-2 space-y-1 text-xs border border-blue-100">
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Inactividad</span>
                                    <span className="font-black">{feedback.attentionLevel?.indicators?.inactivityPeriods || 0}</span>
                                  </div>
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Foco</span>
                                    <span className="font-black">{feedback.attentionLevel?.indicators?.focusIndex?.toFixed(1) || 0}%</span>
                                  </div>
                                  <div className="flex justify-between">
                                    <span className="text-gray-700">Consistencia</span>
                                    <span className="font-black">{feedback.attentionLevel?.indicators?.consistencyScore?.toFixed(1)}</span>
                                  </div>
                                </div>
                              </div>

                              {/* AFS */}
                              <div className="bg-white rounded-lg p-3 border-2 border-blue-200">
                                <div className="flex items-center justify-between mb-2">
                                  <p className="text-sm font-black text-blue-600">💬 AFS</p>
                                  <span className="text-lg">📋</span>
                                </div>
                                <div className="bg-blue-50 rounded-lg p-2 space-y-1 text-xs border border-blue-100">
                                  <div className="flex items-center justify-between">
                                    <span className="text-gray-700">Fortalezas</span>
                                    <span className="font-black bg-green-200 text-green-800 px-2 py-0.5 rounded">{feedback.strengths?.length || 0}</span>
                                  </div>
                                  <div className="flex items-center justify-between">
                                    <span className="text-gray-700">Por Mejorar</span>
                                    <span className="font-black bg-yellow-200 text-yellow-800 px-2 py-0.5 rounded">{feedback.weaknesses?.length || 0}</span>
                                  </div>
                                  <div className="flex items-center justify-between">
                                    <span className="text-gray-700">Acciones</span>
                                    <span className="font-black bg-blue-200 text-blue-800 px-2 py-0.5 rounded">{feedback.actionPlan?.length || 0}</span>
                                  </div>
                                </div>
                              </div>
                            </div>

                            {/* Comportamiento del Estudiante - CON FECHAS REALES */}
                            {/* Comportamiento del Estudiante - CON ESPACIO ADECUADO */}
                            <div className="mt-6 bg-white rounded-xl p-6 border-2 border-blue-200 shadow-sm">

                              {/* TÍTULO */}
                              <h4 className="text-base font-bold text-gray-800 mb-4 flex items-center gap-2">
                                <Activity className="w-5 h-5 text-blue-600" />
                                Comportamiento del Estudiante
                              </h4>

                              {/* MENSAJE SI NO HAY DATOS */}
                              {!evolution || evolution.length === 0 ? (
                                <div className="text-center py-12 bg-gray-50 rounded-xl border-2 border-dashed border-gray-300">
                                  <Activity className="w-16 h-16 text-gray-400 mx-auto mb-3" />
                                  <p className="text-gray-600 font-semibold">📭 Sin datos de comportamiento</p>
                                  <p className="text-sm text-gray-500 mt-1">
                                    Este estudiante aún no ha completado ninguna actividad.
                                  </p>
                                  <p className="text-xs text-gray-400 mt-2">
                                    Las actividades aparecerán aquí cuando el estudiante complete recursos.
                                  </p>
                                </div>
                              ) : evolution.length === 1 ? (
                                <div className="text-center py-12 bg-blue-50 rounded-xl border-2 border-blue-200">
                                  <div className="text-5xl mb-3">📊</div>
                                  <p className="text-gray-700 font-semibold">Datos insuficientes</p>
                                  <p className="text-sm text-gray-600 mt-1">
                                    Solo hay {evolution.length} actividad completada.
                                  </p>
                                  <p className="text-xs text-gray-500 mt-2">
                                    Se necesitan al menos 2 actividades para mostrar la evolución.
                                  </p>
                                </div>
                              ) : (
                                <>
                                  {/* GRÁFICO CON ALTURA ADECUADA */}
                                  <div className="w-full h-64 mb-6">
                                    <SimpleLineChart
                                      data={evolution}
                                      xKey="fecha"
                                      yKey="progreso"
                                      color="#3b82f6"
                                      label="Comportamiento %"
                                    />
                                  </div>

                                  {/* ESTADÍSTICAS - CON ESPACIO */}
                                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                                    <div className="bg-gradient-to-br from-green-50 to-green-100 rounded-xl p-4 border border-green-200 text-center">
                                      <p className="text-xs font-bold text-green-700 uppercase">Tendencia</p>
                                      <p className={`text-xl font-black mt-1 ${(() => {
                                        const progressValues = evolution.map(e => e.progreso);
                                        const trend = calculateTrend(progressValues);
                                        return trend.color;
                                      })()}`}>
                                        {(() => {
                                          const progressValues = evolution.map(e => e.progreso);
                                          const trend = calculateTrend(progressValues);
                                          return trend.texto;
                                        })()}
                                      </p>
                                      <p className="text-[10px] text-gray-500 mt-1">vs primera actividad</p>
                                    </div>

                                    <div className="bg-gradient-to-br from-blue-50 to-blue-100 rounded-xl p-4 border border-blue-200 text-center">
                                      <p className="text-xs font-bold text-blue-700 uppercase">Promedio</p>
                                      <p className="text-2xl font-black text-blue-700 mt-1">
                                        {Math.round(evolution.reduce((a, b) => a + b.progreso, 0) / evolution.length)}%
                                      </p>
                                      <p className="text-[10px] text-gray-500 mt-1">general</p>
                                    </div>

                                    <div className="bg-gradient-to-br from-purple-50 to-purple-100 rounded-xl p-4 border border-purple-200 text-center">
                                      <p className="text-xs font-bold text-purple-700 uppercase">Actividades</p>
                                      <p className="text-2xl font-black text-purple-700 mt-1">
                                        {evolution.length}
                                      </p>
                                      <p className="text-[10px] text-gray-500 mt-1">completadas</p>
                                    </div>
                                  </div>

                                  {/* TABLA CON SCROLL Y ESPACIO */}
                                  <div className="overflow-x-auto">
                                    <table className="w-full text-sm border-collapse">
                                      <thead>
                                        <tr className="bg-gray-100">
                                          <th className="px-3 py-2 text-left font-bold text-gray-700">#</th>
                                          <th className="px-3 py-2 text-left font-bold text-gray-700">Fecha</th>
                                          <th className="px-3 py-2 text-left font-bold text-gray-700">Actividad</th>
                                          <th className="px-3 py-2 text-center font-bold text-gray-700">Comportamiento</th>
                                          <th className="px-3 py-2 text-center font-bold text-gray-700">Progreso</th>
                                          <th className="px-3 py-2 text-center font-bold text-gray-700">Tiempo</th>
                                          <th className="px-3 py-2 text-center font-bold text-gray-700">Intentos</th>
                                        </tr>
                                      </thead>
                                      <tbody className="divide-y divide-gray-200">
                                        {evolution.map((act, idx) => (
                                          <tr key={idx} className="hover:bg-gray-50">
                                            <td className="px-3 py-2 font-bold text-gray-500">{idx + 1}</td>
                                            <td className="px-3 py-2 whitespace-nowrap">
                                              <span className="text-gray-700">{act.fecha}</span>
                                            </td>
                                            <td className="px-3 py-2">
                                              <div className="flex items-center gap-2">
                                                <span className="text-lg">
                                                  {act.recursoTipo === 'quiz' ? '❓' :
                                                    act.recursoTipo === 'video' ? '🎥' :
                                                      act.recursoTipo === 'juego' ? '🎮' : '📝'}
                                                </span>
                                                <span className="text-gray-700 truncate max-w-[200px]" title={act.recursoTitulo}>
                                                  {act.recursoTitulo}
                                                </span>
                                              </div>
                                            </td>
                                            <td className="px-3 py-2 text-center">
                                              <span className={`px-2 py-1 rounded-full text-xs font-bold ${act.comportamientoColor}`}>
                                                {act.comportamiento}
                                              </span>
                                            </td>
                                            <td className="px-3 py-2 text-center">
                                              <div className="flex items-center justify-center gap-2">
                                                <div className="w-16 bg-gray-200 rounded-full h-2">
                                                  <div className="bg-blue-500 h-2 rounded-full" style={{ width: `${act.progreso}%` }}></div>
                                                </div>
                                                <span className="text-sm font-bold">{act.progreso}%</span>
                                              </div>
                                            </td>
                                            <td className="px-3 py-2 text-center text-gray-700">
                                              ⏱️ {act.tiempo} min
                                            </td>
                                            <td className="px-3 py-2 text-center">
                                              <span className={`px-2 py-0.5 rounded-full text-xs font-bold ${act.intentos === 1 ? "bg-green-100 text-green-700" :
                                                act.intentos <= 2 ? "bg-yellow-100 text-yellow-700" :
                                                  "bg-red-100 text-red-700"
                                                }`}>
                                                {act.intentos} {act.intentos === 1 ? "vez" : "veces"}
                                              </span>
                                            </td>
                                          </tr>
                                        ))}
                                      </tbody>
                                    </table>
                                  </div>
                                </>
                              )}
                            </div>
                            {/* FORTALEZAS Y DEBILIDADES */}
                            {(feedback.strengths?.length > 0 || feedback.weaknesses?.length > 0) && (
                              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                                {feedback.strengths?.length > 0 && (
                                  <div className="bg-green-50 rounded-lg p-3 border border-green-200">
                                    <h4 className="font-black text-green-800 mb-2 text-xs">✓ Fortalezas</h4>
                                    <ul className="space-y-1">
                                      {feedback.strengths.map((s, i) => (
                                        <li key={i} className="flex gap-1 text-xs text-gray-700">
                                          <span className="text-green-600 font-black flex-shrink-0">✓</span>
                                          <span>{s}</span>
                                        </li>
                                      ))}
                                    </ul>
                                  </div>
                                )}
                                {feedback.weaknesses?.length > 0 && (
                                  <div className="bg-orange-50 rounded-lg p-3 border border-orange-200">
                                    <h4 className="font-black text-orange-800 mb-2 text-xs">→ Por Mejorar</h4>
                                    <ul className="space-y-1">
                                      {feedback.weaknesses.map((w, i) => (
                                        <li key={i} className="flex gap-1 text-xs text-gray-700">
                                          <span className="text-orange-600 font-black flex-shrink-0">→</span>
                                          <span>{w}</span>
                                        </li>
                                      ))}
                                    </ul>
                                  </div>
                                )}
                              </div>
                            )}

                            {/* PLAN DE ACCIÓN */}
                            {feedback.actionPlan?.length > 0 && (
                              <div className="bg-gradient-to-r from-blue-500 to-blue-600 rounded-lg p-3 text-white">
                                <h4 className="font-black mb-2 text-xs">📋 Plan de Acción</h4>
                                <ol className="space-y-1">
                                  {feedback.actionPlan.map((action, i) => (
                                    <li key={i} className="flex gap-2 text-xs">
                                      <span className="bg-white bg-opacity-30 rounded-full w-5 h-5 flex items-center justify-center flex-shrink-0 text-xs font-black">
                                        {i + 1}
                                      </span>
                                      <span>{action}</span>
                                    </li>
                                  ))}
                                </ol>
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  });
                })()}
              </div>

              {/* FOOTER */}
              <div className="sticky bottom-0 bg-white border-t border-gray-200 p-3 flex gap-2 justify-end">
                <button
                  onClick={() => {
                    setShowCourseReportModal(false);
                    setFilterByGroup("");
                    setFilterByStatus("");
                    setSearchStudent("");
                    setExpandedStudent(null);
                  }}
                  className="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg font-bold text-sm transition-all"
                >
                  Cerrar
                </button>
                <button
                  onClick={handlePrintReport}
                  className="px-4 py-2 bg-gray-500 hover:bg-gray-600 text-white rounded-lg font-bold text-sm transition-all flex items-center gap-1"
                >
                  <Printer className="w-4 h-4" />
                  Imprimir
                </button>
                <button
                  onClick={handleDownloadReport}
                  className="px-4 py-2 bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white rounded-lg font-bold text-sm transition-all flex items-center gap-1 shadow-md"
                >
                  <Download className="w-4 h-4" />
                  Excel
                </button>
              </div>
            </div>
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
                  <h2 className="text-2xl font-bold mb-1">
                    ✨ Editor de Quiz Interactivo
                  </h2>
                  <p className="text-purple-100">
                    Recurso: {selectedResource?.titulo}
                  </p>
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
              {/* Generador de Preguntas con IA desde Documento */}
              <div className="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-xl p-6 border-2 border-indigo-200">
                <div className="flex items-start gap-4">
                  <div className="bg-indigo-500 rounded-lg p-3 flex-shrink-0">
                    <Brain className="w-6 h-6 text-white" />
                  </div>
                  <div className="flex-1">
                    <h3 className="text-lg font-bold text-gray-800 mb-2">
                      🤖 Generador de Preguntas con IA
                    </h3>
                    <p className="text-sm text-gray-600 mb-4">
                      Sube un documento (PDF, TXT, DOCX) y la IA generará
                      preguntas automáticamente basadas en el contenido para
                      estudiantes de básica elemental.
                    </p>

                    <div className="flex gap-3 items-center">
                      <label className="flex-1 cursor-pointer">
                        <div className="flex items-center gap-2 bg-white border-2 border-dashed border-indigo-300 hover:border-indigo-500 rounded-lg p-4 transition-colors">
                          <FileUp className="w-5 h-5 text-indigo-600" />
                          <div className="flex-1">
                            {uploadedDocument ? (
                              <div>
                                <p className="text-sm font-semibold text-gray-800">
                                  {uploadedDocument.name}
                                </p>
                                <p className="text-xs text-gray-500">
                                  {(uploadedDocument.size / 1024).toFixed(2)} KB
                                </p>
                              </div>
                            ) : (
                              <p className="text-sm text-gray-600">
                                Haz clic para subir documento
                              </p>
                            )}
                          </div>
                        </div>
                        <input
                          type="file"
                          accept=".pdf,.txt,.doc,.docx"
                          onChange={handleDocumentUpload}
                          className="hidden"
                        />
                      </label>

                      {uploadedDocument && (
                        <button
                          onClick={generateQuestionsWithAI}
                          disabled={generatingQuestions}
                          className="bg-indigo-500 hover:bg-indigo-600 text-white px-6 py-3 rounded-lg font-semibold transition-colors flex items-center gap-2 disabled:opacity-50"
                        >
                          {generatingQuestions ? (
                            <>
                              <RefreshCw className="w-5 h-5 animate-spin" />
                              Generando...
                            </>
                          ) : (
                            <>
                              <Sparkles className="w-5 h-5" />
                              Generar Preguntas
                            </>
                          )}
                        </button>
                      )}
                    </div>

                    {uploadedDocument && (
                      <button
                        onClick={() => setUploadedDocument(null)}
                        className="mt-2 text-sm text-red-600 hover:text-red-800 flex items-center gap-1"
                      >
                        <X className="w-3 h-3" />
                        Quitar documento
                      </button>
                    )}
                  </div>
                </div>
              </div>

              {/* Selector de tipo de pregunta */}
              <div>
                <label className="block text-sm font-bold text-gray-800 mb-3">
                  🎯 Tipo de Pregunta
                </label>
                <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                  {questionTypes.map((type) => {
                    const TypeIcon = type.icon;
                    return (
                      <button
                        key={type.value}
                        onClick={() =>
                          setCurrentQuestion({
                            ...currentQuestion,
                            tipo: type.value,
                          })
                        }
                        className={`p-4 rounded-xl border-2 transition-all transform hover:scale-105 ${currentQuestion.tipo === type.value
                          ? "border-purple-500 bg-purple-50 shadow-md"
                          : "border-gray-200 hover:border-gray-300"
                          }`}
                        style={{
                          borderColor:
                            currentQuestion.tipo === type.value
                              ? type.color
                              : undefined,
                          backgroundColor:
                            currentQuestion.tipo === type.value
                              ? `${type.color}15`
                              : undefined,
                        }}
                      >
                        <TypeIcon
                          className="w-6 h-6 mx-auto mb-2"
                          style={{ color: type.color }}
                        />
                        <div className="text-sm font-semibold text-gray-800">
                          {type.label}
                        </div>
                      </button>
                    );
                  })}
                </div>
              </div>
              {/* ✅ NUEVO: Botón para editar preguntas existentes */}
              {currentQuiz.preguntas.length > 0 && (
                <div className="bg-yellow-50 border-2 border-yellow-300 rounded-xl p-4">
                  <h3 className="font-bold text-yellow-800 mb-3 flex items-center gap-2">
                    <Edit2 className="w-5 h-5" />
                    ✏️ Editar Preguntas Existentes
                  </h3>
                  <div className="space-y-2 max-h-64 overflow-y-auto">
                    {currentQuiz.preguntas.map((q, idx) => (
                      <button
                        key={q.id}
                        onClick={() => {
                          // Cargar pregunta en el editor
                          setCurrentQuestion({ ...q });
                          setEditingQuestionIndex(idx);

                          // Scroll al editor
                          document.querySelector('[data-editor-section]')?.scrollIntoView({
                            behavior: 'smooth'
                          });
                        }}
                        className="w-full text-left p-3 bg-white border-2 border-yellow-200 rounded-lg hover:border-yellow-400 transition-all flex items-center justify-between group"
                      >
                        <div className="flex-1">
                          <p className="font-semibold text-gray-800 line-clamp-1">
                            {idx + 1}. {q.pregunta}
                          </p>
                          <p className="text-xs text-gray-500 mt-1">
                            {q.opciones.length} opciones • ⭐ {q.puntos} puntos
                          </p>
                        </div>
                        <Edit2 className="w-4 h-4 text-yellow-600 group-hover:scale-110 transition-transform" />
                      </button>
                    ))}
                  </div>
                </div>
              )}

              {/* Campo de pregunta con audio automático */}
              <div>
                <label className="block text-sm font-bold text-gray-800 mb-2">
                  ❓ Pregunta
                </label>
                <div className="flex gap-2">
                  <input
                    type="text"
                    value={currentQuestion.pregunta}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        pregunta: e.target.value,
                      })
                    }
                    className="flex-1 px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-purple-500 text-lg"
                    placeholder="Escribe tu pregunta aquí..."
                  />
                  <button
                    onClick={() => {
                      if (currentQuestion.pregunta) {
                        speakText(currentQuestion.pregunta);
                      }
                    }}
                    disabled={!currentQuestion.pregunta}
                    className="bg-blue-500 hover:bg-blue-600 text-white px-4 rounded-xl transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                    title="Escuchar pregunta"
                  >
                    <Volume2 className="w-5 h-5" />
                  </button>
                </div>
                <div className="mt-2 flex items-center gap-2">
                  <input
                    type="checkbox"
                    id="audio-auto"
                    checked={currentQuestion.audio_pregunta}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        audio_pregunta: e.target.checked,
                      })
                    }
                    className="w-4 h-4 text-blue-600"
                  />
                  <label
                    htmlFor="audio-auto"
                    className="text-sm text-gray-700 font-medium"
                  >
                    🔊 Reproducir audio automáticamente (recomendado para básica
                    elemental)
                  </label>
                </div>
              </div>

              {/* Opciones multimedia */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    <Video className="w-5 h-5 inline mr-2 text-orange-600" />
                    Video URL
                  </label>
                  <input
                    type="url"
                    value={currentQuestion.video_url}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        video_url: e.target.value,
                      })
                    }
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
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        imagen_url: e.target.value,
                      })
                    }
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 text-2xl"
                  >
                    <option value="">Ninguno</option>
                    {emojis.map((emoji, index) => (<option key={`emoji_${index}_${emoji}`} value={emoji}> {emoji} </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    <Mic className="w-5 h-5 inline mr-2 text-green-600" />
                    Retroalimentación
                  </label>
                  <label className="flex items-center gap-2 cursor-pointer bg-green-50 p-3 rounded-lg hover:bg-green-100 transition-colors border-2 border-green-200">
                    <input
                      type="checkbox"
                      checked={currentQuestion.audio_retroalimentacion}
                      onChange={(e) =>
                        setCurrentQuestion({
                          ...currentQuestion,
                          audio_retroalimentacion: e.target.checked,
                        })
                      }
                      className="w-5 h-5 text-green-600"
                    />
                    <span className="text-sm font-semibold text-gray-800">
                      Leer Feedback
                    </span>
                  </label>
                </div>
              </div>


              {/* Opciones de respuesta - DISEÑO MINIMALISTA MEJORADO */}
              {currentQuestion.tipo !== "completar" && (
                <div>
                  <label className="block text-sm font-bold text-gray-800 mb-3">
                    📝 Opciones de Respuesta
                    {currentQuestion.tipo === "verdadero_falso" && (
                      <span className="ml-2 text-xs text-gray-500">
                        (Automático: Verdadero/Falso)
                      </span>
                    )}
                  </label>

                  <div className="space-y-3">
                    {currentQuestion.opciones.map((opcion, idx) => (
                      <div
                        key={idx}
                        className={`bg-white rounded-xl border-2 p-4 transition-all ${currentQuestion.respuesta_correcta === idx
                          ? "border-green-500 bg-green-50 shadow-md ring-2 ring-green-200"
                          : "border-gray-200 hover:border-gray-300 hover:shadow-sm"
                          }`}
                      >
                        {/* ===== HEADER DE LA OPCIÓN ===== */}
                        <div className="flex items-center gap-3 mb-3">
                          <div className={`w-10 h-10 rounded-lg flex items-center justify-center font-bold text-lg transition-all ${currentQuestion.respuesta_correcta === idx
                            ? "bg-green-500 text-white shadow-md"
                            : "bg-gray-200 text-gray-700"
                            }`}>
                            {String.fromCharCode(65 + idx)}
                          </div>

                          <div className="flex-1 font-semibold text-gray-700 text-sm">
                            Opción {idx + 1}
                            {currentQuestion.respuesta_correcta === idx && (
                              <span className="ml-2 text-green-600 text-xs font-black">
                                ✓ Correcta
                              </span>
                            )}
                          </div>

                          <button
                            onClick={() =>
                              setCurrentQuestion({
                                ...currentQuestion,
                                respuesta_correcta: idx,
                              })
                            }
                            className={`px-4 py-2 rounded-lg font-bold text-sm transition-all transform hover:scale-105 ${currentQuestion.respuesta_correcta === idx
                              ? "bg-green-500 text-white shadow-md"
                              : "bg-gray-200 text-gray-700 hover:bg-gray-300"
                              }`}
                          >
                            {currentQuestion.respuesta_correcta === idx ? "✓ Correcta" : "Marcar"}
                          </button>
                        </div>

                        {/* ===== SELECTOR DE EMOJI/IMAGEN VISUAL ===== */}
                        <div className="mb-3">
                          <label className="block text-xs font-bold text-gray-600 mb-2 uppercase tracking-wide">
                            🎨 Emoji/Imagen Visual
                          </label>
                          <div className="flex items-center gap-3">
                            {/* Preview grande del emoji */}
                            <div className="w-20 h-20 bg-gradient-to-br from-purple-100 via-blue-100 to-pink-100 rounded-xl flex items-center justify-center text-5xl border-2 border-purple-200 shadow-sm">
                              {currentQuestion.imagen_opciones?.[idx] || "🎨"}
                            </div>

                            {/* Selector desplegable */}
                            <div className="flex-1">
                              <select
                                value={currentQuestion.imagen_opciones?.[idx] || ""}
                                onChange={(e) => {
                                  const newImagenes = [...(currentQuestion.imagen_opciones || ["", "", "", ""])];
                                  newImagenes[idx] = e.target.value;
                                  setCurrentQuestion({
                                    ...currentQuestion,
                                    imagen_opciones: newImagenes,
                                  });
                                }}
                                className="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 text-xl bg-white cursor-pointer transition-all hover:border-purple-300"
                              >
                                <option value="">🚫 Sin emoji</option>

                                {/* Formas geométricas */}
                                <optgroup label="🔺 Formas">
                                  {["🔴", "🔵", "🟡", "🟢", "🟣", "🟠", "⭕", "📍"].map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </optgroup>

                                {/* Números */}
                                <optgroup label="🔢 Números">
                                  {["1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣", "0️⃣"].map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </optgroup>

                                {/* Animales */}
                                <optgroup label="🦁 Animales">
                                  {["🦁", "🐘", "🦒", "🐼", "🦊", "🐶", "🐱", "🦆", "🦉", "🐢"].map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </optgroup>

                                {/* Comida */}
                                <optgroup label="🍎 Comida">
                                  {["🍎", "🍊", "🍋", "🍌", "🍓", "🥕", "🌽", "🍕", "🍔", "🍟"].map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </optgroup>

                                {/* Transporte */}
                                <optgroup label="🚗 Transporte">
                                  {["🚀", "✈️", "🚂", "🚗", "🚢", "⛵", "🚁", "🛸", "🚲", "🛴"].map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </optgroup>

                                {/* Educación */}
                                <optgroup label="📚 Educación">
                                  {["📚", "📖", "📝", "✏️", "📐", "📏", "🎓", "🔬", "🧮", "🎨"].map(emoji => (
                                    <option key={emoji} value={emoji}>{emoji}</option>
                                  ))}
                                </optgroup>
                              </select>
                            </div>
                          </div>
                        </div>

                        {/* ===== TEXTO DE LA OPCIÓN ===== */}
                        <div>
                          <label className="block text-xs font-bold text-gray-600 mb-2 uppercase tracking-wide">
                            ✏️ Texto de la Opción
                          </label>
                          <input
                            type="text"
                            value={opcion}
                            onChange={(e) => {
                              const newOpciones = [...currentQuestion.opciones];
                              newOpciones[idx] = e.target.value;
                              setCurrentQuestion({
                                ...currentQuestion,
                                opciones: newOpciones,
                              });
                            }}
                            disabled={currentQuestion.tipo === "verdadero_falso"}
                            className="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500 disabled:bg-gray-100 disabled:cursor-not-allowed font-medium text-gray-800 transition-all"
                            placeholder={`Escribe la opción ${String.fromCharCode(65 + idx)}...`}
                          />
                        </div>

                        {/* ===== PREVIEW VISUAL (Cómo se verá para el estudiante) ===== */}
                        <div className="mt-3 p-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-lg border-2 border-dashed border-gray-300">
                          <p className="text-xs font-bold text-gray-500 mb-2 uppercase tracking-wider">
                            👁️ Vista Previa del Estudiante
                          </p>
                          <div className="flex items-center gap-4 bg-white p-3 rounded-lg border border-gray-200">
                            {/* Emoji en grande */}
                            {currentQuestion.imagen_opciones?.[idx] && (
                              <div className="text-5xl flex-shrink-0">
                                {currentQuestion.imagen_opciones[idx]}
                              </div>
                            )}
                            {/* Texto */}
                            <span className="text-base font-semibold text-gray-800 flex-1">
                              {opcion || `Opción ${String.fromCharCode(65 + idx)}`}
                            </span>
                            {/* Badge de letra */}
                            <div className="w-8 h-8 bg-blue-500 text-white rounded-lg flex items-center justify-center font-bold text-sm flex-shrink-0">
                              {String.fromCharCode(65 + idx)}
                            </div>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>

                  {/* ===== AYUDA EDUCATIVA ===== */}
                  <div className="mt-4 bg-gradient-to-r from-blue-50 to-indigo-50 border-l-4 border-blue-500 p-4 rounded-r-lg shadow-sm">
                    <div className="flex items-start gap-3">
                      <span className="text-3xl flex-shrink-0">💡</span>
                      <div>
                        <p className="text-sm font-bold text-blue-800 mb-1">
                          Tip Pedagógico para Básica Elemental
                        </p>
                        <p className="text-xs text-blue-700 leading-relaxed">
                          Los emojis visuales ayudan a los niños a:
                        </p>
                        <ul className="text-xs text-blue-700 mt-2 space-y-1 ml-4">
                          <li>✓ Identificar opciones más rápido</li>
                          <li>✓ Asociar conceptos con imágenes</li>
                          <li>✓ Mantener el interés y atención</li>
                          <li>✓ Recordar mejor las respuestas</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* Configuración adicional */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    ⭐ Puntos
                  </label>
                  <input
                    type="number"
                    value={currentQuestion.puntos}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        puntos: parseInt(e.target.value),
                      })
                    }
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-yellow-500"
                    min="1"
                  />
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    ⏱️ Tiempo Límite (seg)
                  </label>
                  <input
                    type="number"
                    value={currentQuestion.tiempo_limite}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        tiempo_limite: parseInt(e.target.value),
                      })
                    }
                    className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500"
                    min="0"
                    placeholder="0 = sin límite"
                  />
                </div>
              </div>

              {/* Retroalimentación */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    ✅ Retroalimentación Correcta
                  </label>
                  <input
                    type="text"
                    value={currentQuestion.retroalimentacion_correcta}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        retroalimentacion_correcta: e.target.value,
                      })
                    }
                    className="w-full px-3 py-2 border-2 border-green-200 rounded-lg focus:ring-2 focus:ring-green-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-gray-800 mb-2">
                    ❌ Retroalimentación Incorrecta
                  </label>
                  <input
                    type="text"
                    value={currentQuestion.retroalimentacion_incorrecta}
                    onChange={(e) =>
                      setCurrentQuestion({
                        ...currentQuestion,
                        retroalimentacion_incorrecta: e.target.value,
                      })
                    }
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
                      const TypeIcon =
                        questionTypes.find((t) => t.value === q.tipo)?.icon ||
                        HelpCircle;
                      const typeColor =
                        questionTypes.find((t) => t.value === q.tipo)?.color ||
                        "#3B82F6";
                      return (
                        <div
                          key={q.id}
                          className="bg-gradient-to-r from-gray-50 to-gray-100 rounded-lg p-4 flex items-center justify-between hover:shadow-md transition-shadow"
                        >
                          <div className="flex items-center gap-3 flex-1">
                            <div
                              className="rounded-full w-10 h-10 flex items-center justify-center font-bold text-white shadow-md"
                              style={{ backgroundColor: typeColor }}
                            >
                              {index + 1}
                            </div>
                            <TypeIcon
                              className="w-5 h-5"
                              style={{ color: typeColor }}
                            />
                            <div className="flex-1">
                              <p className="font-medium text-gray-800">
                                {q.pregunta}
                              </p>
                              <div className="flex gap-3 text-xs text-gray-500 mt-1">
                                <span>⭐ {q.puntos} puntos</span>
                                <span>📝 {q.opciones.length} opciones</span>
                                {q.audio_pregunta && <span>🔊 Audio Auto</span>}
                                {q.video_url && <span>🎥 Video</span>}
                                {q.imagen_url && <span>🖼️ Imagen</span>}
                              </div>
                            </div>
                          </div>
                          <div className="flex gap-2">
                            <button
                              onClick={() => moveQuestion(index, "up")}
                              disabled={index === 0}
                              className="p-2 text-gray-600 hover:text-gray-800 hover:bg-gray-200 rounded-lg disabled:opacity-30 transition-all"
                              title="Mover arriba"
                            >
                              <ChevronUp className="w-4 h-4" />
                            </button>
                            <button
                              onClick={() => moveQuestion(index, "down")}
                              disabled={
                                index === currentQuiz.preguntas.length - 1
                              }
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
        <div className="fixed inset-0 bg-black bg-opacity-70 z-[60] flex items-center justify-center p-4 overflow-y-auto">
          <div className="bg-white rounded-3xl max-w-6xl w-full max-h-[95vh] overflow-hidden shadow-2xl">
            {/* HEADER AZUL IDÉNTICO */}
            <div className="sticky top-0 z-10 bg-gradient-to-r from-blue-600 to-blue-500 text-white p-6">
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-2xl font-black flex items-center gap-2">
                    👁️ Vista Previa del Quiz
                  </h2>
                  <p className="text-blue-100 text-sm mt-1">
                    {selectedResource?.titulo || 'Quiz desde Recursos'}
                  </p>
                </div>
                <button
                  onClick={closePreview}
                  className="bg-white bg-opacity-20 hover:bg-opacity-30 p-3 rounded-xl transition-all"
                >
                  <X className="w-6 h-6" />
                </button>
              </div>
            </div>
            <div className="p-6 overflow-y-auto max-h-[calc(95vh-200px)]">
              {renderQuestionPreview()}
            </div>
          </div>
        </div>
      )}

      {/* MODAL DE ANÁLISIS DETALLADO */}
      {showDetailedAnalytics && renderDetailedAnalyticsImproved()}

      {showReauthModal && (
        <div className="fixed inset-0 bg-black bg-opacity-60 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl max-w-md w-full shadow-2xl animate-fadeIn">
            {/* HEADER */}
            <div className="bg-gradient-to-r from-blue-600 to-purple-600 text-white p-6 rounded-t-2xl">
              <div className="flex items-center justify-between mb-2">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 bg-white bg-opacity-20 rounded-full flex items-center justify-center">
                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                    </svg>
                  </div>
                  <div>
                    <h2 className="text-xl font-bold">🔐 Verificación de Seguridad</h2>
                    <p className="text-sm text-blue-100">Confirma tu identidad</p>
                  </div>
                </div>
                <button
                  onClick={() => {
                    setShowReauthModal(false);
                    setReauthPassword("");
                    setReauthError(null);
                    setTargetRole(null);
                  }}
                  className="text-white hover:bg-white hover:bg-opacity-20 rounded-lg p-2 transition-colors"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* CONTENIDO */}
            <div className="p-6 space-y-4">
              {/* INFO DEL CAMBIO */}
              <div className="bg-blue-50 border-2 border-blue-200 rounded-xl p-4">
                <div className="flex items-center gap-3 mb-3">
                  <div className="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white font-bold">
                    {currentUser?.nombre?.charAt(0).toUpperCase()}
                  </div>
                  <div className="flex-1">
                    <p className="font-semibold text-gray-800">{currentUser?.nombre}</p>
                    <p className="text-xs text-gray-600">{currentUser?.email}</p>
                  </div>
                </div>

                <div className="flex items-center justify-between bg-white rounded-lg p-3 border border-blue-300">
                  <div className="text-center flex-1">
                    <p className="text-xs text-gray-500 font-semibold mb-1">Vista Actual</p>
                    <span className={`px-3 py-1 text-xs font-bold rounded-full ${getRoleBadgeColor(activeRoleView || currentUser?.rol)}`}>
                      {(activeRoleView || currentUser?.rol).toUpperCase()}
                    </span>
                  </div>

                  <div className="flex items-center justify-center px-3">
                    <ChevronRight className="w-6 h-6 text-blue-500" />
                  </div>

                  <div className="text-center flex-1">
                    <p className="text-xs text-gray-500 font-semibold mb-1">Nueva Vista</p>
                    <span className={`px-3 py-1 text-xs font-bold rounded-full ${getRoleBadgeColor(targetRole)}`}>
                      {targetRole?.toUpperCase()}
                    </span>
                  </div>
                </div>
              </div>

              {/* ADVERTENCIA DE SEGURIDAD */}
              <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded-r-lg">
                <div className="flex items-start gap-3">
                  <AlertCircle className="w-5 h-5 text-yellow-600 flex-shrink-0 mt-0.5" />
                  <div>
                    <p className="text-sm font-semibold text-yellow-800">Medida de Seguridad</p>
                    <p className="text-xs text-yellow-700 mt-1">
                      Para cambiar de vista debes confirmar tu identidad ingresando tu contraseña
                    </p>
                  </div>
                </div>
              </div>

              {/* INPUT DE CONTRASEÑA */}
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-2">
                  🔑 Ingresa tu Contraseña
                </label>
                <div className="relative">
                  <input
                    type="password"
                    value={reauthPassword}
                    onChange={(e) => setReauthPassword(e.target.value)}
                    onKeyPress={(e) => {
                      if (e.key === 'Enter' && !reauthLoading) {
                        confirmRoleSwitch();
                      }
                    }}
                    placeholder="••••••••"
                    disabled={reauthLoading}
                    className="w-full px-4 py-3 border-2 border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all disabled:bg-gray-100 disabled:cursor-not-allowed text-lg"
                    autoFocus
                  />
                </div>
              </div>

              {/* ERROR */}
              {reauthError && (
                <div className="bg-red-50 border-2 border-red-300 rounded-lg p-3 animate-shake">
                  <div className="flex items-center gap-2">
                    <XCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
                    <p className="text-sm font-semibold text-red-700">{reauthError}</p>
                  </div>
                </div>
              )}

              {/* BOTONES */}
              <div className="flex gap-3 pt-2">
                <button
                  onClick={() => {
                    setShowReauthModal(false);
                    setReauthPassword("");
                    setReauthError(null);
                    setTargetRole(null);
                  }}
                  disabled={reauthLoading}
                  className="flex-1 px-4 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-xl font-semibold transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Cancelar
                </button>
                <button
                  onClick={confirmRoleSwitch}
                  disabled={reauthLoading || !reauthPassword.trim()}
                  className="flex-1 px-4 py-3 bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white rounded-xl font-semibold transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                >
                  {reauthLoading ? (
                    <>
                      <RefreshCw className="animate-spin w-5 h-5" />
                      <span>Verificando...</span>
                    </>
                  ) : (
                    <>
                      <CheckCircle className="w-5 h-5" />
                      <span>Confirmar Cambio</span>
                    </>
                  )}
                </button>
              </div>

              {/* INFO ADICIONAL */}
              <div className="text-center pt-2">
                <p className="text-xs text-gray-500">
                  🔒 Tu contraseña está protegida y nunca se almacena
                </p>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* MODAL GENERADOR DE CONTENIDO */}
      {showContentGenerator && renderContentGenerator()}

      {/* VISOR/EDITOR DE CONTENIDO */}
      {showContentViewer && renderInteractiveContent()}

      {/* Toast de notificaciones */}
      {toastMessage && (
        <div className={`fixed bottom-4 right-4 z-50 px-6 py-3 rounded-lg shadow-xl text-white font-semibold transition-all animate-fadeIn ${toastMessage.type === 'success' ? 'bg-green-500' : 'bg-red-500'
          }`}>
          {toastMessage.message}
        </div>
      )}

      {/* ESTILOS PARA ANIMACIONES */}
      <style jsx>{`
        @keyframes fadeIn {
          from { opacity: 0; transform: scale(0.95); }
          to { opacity: 1; transform: scale(1); }
        }
        
        @keyframes shake {
          0%, 100% { transform: translateX(0); }
          25% { transform: translateX(-5px); }
          75% { transform: translateX(5px); }
        }
        
        .animate-fadeIn {
          animation: fadeIn 0.2s ease-out;
        }
        
        .animate-shake {
          animation: shake 0.3s ease-in-out;
        }
      `}</style>


      <footer className="bg-white border-t border-gray-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex items-center justify-between text-sm text-gray-600">
          <div>© 2026 Didactikapp - Básica Elemental</div>
          <div className="flex items-center gap-4">
            <span>Usuarios: {users.length}</span>
            <span>Cursos: {courses.length}</span>
            <span>Recursos: {resources.length}</span>
            <span>v2.2.1</span>
          </div>
        </div>
      </footer>
    </div>
  );
}