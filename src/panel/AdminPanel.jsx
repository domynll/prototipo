import React, { useEffect, useState } from "react";
import {
  Users, Settings, BookOpen, LogOut, Edit2, Trash2, Plus, Save, X, GraduationCap, AlertCircle,
  RefreshCw, Award, MessageCircle, BarChart3, FileText, Play, Image, Headphones, Gamepad2, HelpCircle,
  Star, TrendingUp, Calendar, Target, Zap, Trophy, CheckCircle, XCircle, Eye, Sparkles, Upload, Mic, Video,
  Volume2, Download, Move, ChevronUp, ChevronDown, Clock, Activity, TrendingDown, Filter, UserCheck,
  UserX, FileUp, Brain, Search, PieChart, BarChart2, LineChart, Printer,
} from "lucide-react";
import { supabase } from "../services/supabaseClient";
import { useNavigate } from "react-router-dom";
import * as pdfjsLib from 'pdfjs-dist';

pdfjsLib.GlobalWorkerOptions.workerSrc = new URL('pdfjs-dist/build/pdf.worker.min.mjs', import.meta.url,).href;

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
            <span className="text-xs text-gray-600 w-20 truncate">
              {item.label}
            </span>
            <div className="flex-1 bg-gray-200 rounded-full h-4 overflow-hidden">
              <div
                className="h-full rounded-full transition-all duration-500"
                style={{
                  width: `${(item.value / maxValue) * 100}%`,
                  backgroundColor: color,
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
        <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide">
          {title}
        </p>
        <p className="text-2xl font-bold text-gray-900 mt-1">{value}</p>
      </div>
      <div className="p-2 rounded-lg" style={{ backgroundColor: `${color}20` }}>
        <Icon className="w-5 h-5" style={{ color }} />
      </div>
    </div>
    {change !== undefined && (
      <div
        className={`flex items-center gap-1 text-xs font-medium ${change >= 0 ? "text-green-600" : "text-red-600"
          }`}
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
  const [courseReportData, setCourseReportData] = useState(null);

  // Estados de filtros de usuarios
  const [filterRole, setFilterRole] = useState("");
  const [filterGroup, setFilterGroup] = useState("");
  const [filterStatus, setFilterStatus] = useState("");
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

    let csvContent = "REPORTE ANALÍTICO DEL CURSO\n";
    csvContent += `Curso,${courseReportData.course.titulo}\n`;
    csvContent += `Nivel,${courseReportData.course.nivel}\n`;
    csvContent += `Fecha,${courseReportData.course.fecha}\n\n`;

    csvContent += "ESTADÍSTICAS GENERALES\n";
    csvContent += `Total Estudiantes,${courseReportData.stats.totalStudents}\n`;
    csvContent += `Progreso Promedio,${courseReportData.stats.avgProgress}%\n`;
    csvContent += `Recursos Completados,${courseReportData.stats.completedResources}\n`;
    csvContent += `Tiempo Total,${courseReportData.stats.totalTime} minutos\n\n`;

    csvContent += "ANÁLISIS POR ESTUDIANTE\n";
    csvContent +=
      "Nombre,Email,Grupo,Estado General,Aprendizaje Real,Confianza,Atención,Puntuación,Fortalezas,Áreas Mejora\n";

    courseReportData.students.forEach((data) => {
      const { student, feedback, grupo } = data;
      csvContent += `"${student.nombre}","${student.email}","${grupo}","${feedback.overallStatus
        }","${feedback.learningEffectiveness?.isLearning ? "Sí" : "No"}",${feedback.learningEffectiveness?.confidence || 0
        },${feedback.attentionLevel?.level},"${feedback.attentionLevel?.score || 0
        }","${feedback.strengths.join("; ")}","${feedback.weaknesses.join(
          "; "
        )}"\n`;
    });

    const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    const url = URL.createObjectURL(blob);

    link.setAttribute("href", url);
    link.setAttribute(
      "download",
      `Reporte_${courseReportData.course.titulo}_${Date.now()}.csv`
    );
    link.style.visibility = "hidden";

    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

    alert("✅ Reporte exportado a Excel correctamente");
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
    "🎨",
    "🎮",
    "🎵",
    "🌟",
    "🎉",
    "🚀",
    "🌈",
    "⭐",
    "💡",
    "🎯",
    "🏆",
    "🎪",
    "🦁",
    "🐘",
    "🦋",
    "🌺",
    "🍎",
    "📚",
    "✏️",
    "🎈",
    "🔢",
    "🅰️",
    "🅱️",
    "🔤",
    "📝",
    "✅",
    "❌",
    "➕",
    "➖",
    "✖️",
    "🌍",
    "🌞",
    "🌙",
    "⭐",
    "🔥",
    "💧",
    "🍃",
    "🌸",
    "🐶",
    "🐱",
  ];

  const availableRoles = [
    { value: "visitante", label: "Visitante", color: "gray" },
    { value: "estudiante", label: "Estudiante", color: "green" },
    { value: "docente", label: "Docente", color: "blue" },
    { value: "admin", label: "Admin", color: "red" },
  ];

  useEffect(() => {
    checkAuthAndRole();
  }, []);

  useEffect(() => {
    if (currentUser) {
      loadAllData();
    }
  }, [currentUser]);

  useEffect(() => {
    if (!currentUser || !currentUser.id) return;

    console.log("🔄 Iniciando sincronización de acceso en tiempo real...");

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
          console.log("✅ BD actualizada:", now);
        }
      } catch (err) {
        console.error("❌ Error:", err);
      }
    };

    // Actualizar inmediatamente
    updateLastAccess();

    // Actualizar cada 10 segundos
    const interval = setInterval(updateLastAccess, 10000);

    return () => clearInterval(interval);
  }, [currentUser]);

  // Recargar lista de usuarios cada 12 segundos
  useEffect(() => {
    if (!currentUser) return;

    console.log("🔄 Iniciando refresco automático de usuarios...");

    const interval = setInterval(() => {
      console.log("🔄 Refrescando lista de usuarios...");
      fetchUsers();
    }, 12000);

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

  useEffect(() => {
    if (!currentUser) return;
    const isAdmin =
      currentUser.rol === "admin" ||
      currentUser.roles_adicionales?.includes("admin");
    if (!isAdmin) {
      navigate("/dashboard");
    }
  }, [currentUser, navigate]);

  const handleRoleSwitch = async (newRol) => {
    try {
      const allRoles = [
        currentUser.rol,
        ...(currentUser.roles_adicionales || []),
      ];
      if (!allRoles.includes(newRol)) {
        alert("❌ No tienes acceso a este rol");
        return;
      }

      if (!confirm(`¿Cambiar a ${newRol}? Se cerrará la sesión actual.`)) {
        return;
      }

      // Actualizar rol en BD ANTES de logout
      const { error: updateError } = await supabase
        .from("usuarios")
        .update({ rol: newRol })
        .eq("id", currentUser.id);

      if (updateError) throw updateError;

      // Cerrar sesión
      await supabase.auth.signOut();

      // Redirigir al login
      setMenuOpen(false);
      navigate("/login");

      // Mostrar mensaje
      setTimeout(() => {
        alert(
          `✅ Rol actualizado a ${newRol}. Por favor, inicia sesión nuevamente.`
        );
      }, 500);
    } catch (error) {
      console.error("❌ Error:", error);
      alert("Error al cambiar de rol: " + error.message);
    }
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
      const { data, error } = await supabase
        .from("recursos")
        .select(`*, cursos(titulo)`)
        .eq("activo", true)
        .order("created_at", { ascending: false });

      if (error) throw error;

      const resourcesData =
        data?.map((resource) => ({
          ...resource,
          curso_titulo: resource.cursos?.titulo || "Sin curso",
          completados: 0,
        })) || [];

      setResources(resourcesData);
    } catch (err) {
      console.error("Error cargando recursos:", err);
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

  const calculateAdvancedAnalytics = async () => {
    try {
      const userGrowth = await calculateUserGrowth();
      const engagementRate = await calculateEngagementRate();
      const completionRate = await calculateCompletionRate();
      const topCourses = await calculateTopCourses();
      const avgTimePerResource = await calculateAvgTimePerResource();

      setAnalytics({
        totalUsers: users.length,
        activeStudents: users.filter((u) => u.rol === "estudiante").length,
        completedResources: 0,
        avgTimePerResource,
        topCourses,
        userGrowth,
        engagementRate,
        completionRate,
      });
    } catch (err) {
      console.error("Error calculando analytics:", err);
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

  const calculateEngagementRate = async () => {
    try {
      const { data, error } = await supabase
        .from("progreso_estudiantes")
        .select("*")
        .gte(
          "updated_at",
          new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString()
        );

      if (error) throw error;

      const activeUsers = new Set(data?.map((p) => p.usuario_id) || []).size;
      const totalStudents = users.filter((u) => u.rol === "estudiante").length;

      return totalStudents > 0
        ? Math.round((activeUsers / totalStudents) * 100)
        : 0;
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

  const calculateAvgTimePerResource = async () => {
    try {
      const { data, error } = await supabase
        .from("progreso_estudiantes")
        .select("tiempo_dedicado")
        .not("tiempo_dedicado", "is", null);

      if (error) throw error;

      const totalTime =
        data?.reduce((sum, item) => sum + (item.tiempo_dedicado || 0), 0) || 0;
      const count = data?.length || 1;

      return Math.round(totalTime / count / 60);
    } catch (err) {
      return 0;
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
  const analyzeLearningEffectiveness = async (studentId, courseId = null) => {
    try {
      const { data, error } = await supabase
        .from("progreso_estudiantes") // ← CAMBIO: progreso_usuarios → progreso_estudiantes
        .select(
          `
        *,
        recursos!inner(titulo, tipo, curso_id)
      `
        )
        .eq("usuario_id", studentId)
        .order("updated_at", { ascending: true });

      if (error) throw error;

      const filteredData = courseId
        ? data.filter((p) => p.recursos.curso_id === courseId)
        : data;

      const analysis = {
        isLearning: true,
        confidence: 0,
        indicators: {
          averageAttempts: 0,
          averageTimePerQuestion: 0,
          repetitionRate: 0,
          retentionRate: 0,
          improvementTrend: 0,
        },
        alerts: [],
      };

      if (filteredData.length === 0) {
        return {
          ...analysis,
          isLearning: false,
          alerts: ["Sin datos suficientes"],
        };
      }

      // 1. Tasa de Intentos
      const attempts = filteredData.map((p) => p.intentos || 1);
      analysis.indicators.averageAttempts =
        attempts.reduce((a, b) => a + b, 0) / attempts.length;

      if (analysis.indicators.averageAttempts > 3) {
        analysis.alerts.push(
          "⚠️ Requiere muchos intentos - posible dificultad de comprensión"
        );
        analysis.confidence -= 20;
      }

      // 2. Tiempo de Respuesta
      const times = filteredData
        .map((p) => p.tiempo_dedicado || 0)
        .filter((t) => t > 0);
      if (times.length > 0) {
        analysis.indicators.averageTimePerQuestion =
          times.reduce((a, b) => a + b, 0) / times.length;

        if (analysis.indicators.averageTimePerQuestion < 5) {
          analysis.alerts.push(
            "⚡ Respuestas muy rápidas - posible adivinación"
          );
          analysis.confidence -= 15;
        } else if (analysis.indicators.averageTimePerQuestion > 300) {
          analysis.alerts.push("🐌 Tiempo excesivo - posible distracción");
          analysis.confidence -= 10;
        }
      }

      // 3. Tasa de Repetición
      const repeated = filteredData.filter((p) => (p.intentos || 1) > 1).length;
      analysis.indicators.repetitionRate =
        (repeated / filteredData.length) * 100;

      if (analysis.indicators.repetitionRate > 50) {
        analysis.alerts.push("🔄 Alta tasa de repetición - refuerzo necesario");
        analysis.confidence -= 15;
      }

      // 4. Tendencia de Mejora
      if (filteredData.length >= 10) {
        const first5 = filteredData.slice(0, 5);
        const last5 = filteredData.slice(-5);

        const firstAvg =
          first5.reduce((sum, p) => sum + (p.progreso || 0), 0) / 5;
        const lastAvg =
          last5.reduce((sum, p) => sum + (p.progreso || 0), 0) / 5;

        analysis.indicators.improvementTrend = lastAvg - firstAvg;

        if (analysis.indicators.improvementTrend < 0) {
          analysis.alerts.push("📉 Rendimiento decreciente - necesita apoyo");
          analysis.confidence -= 20;
          analysis.isLearning = false;
        } else if (analysis.indicators.improvementTrend > 15) {
          analysis.alerts.push("✅ Excelente progreso - aprendizaje efectivo");
          analysis.confidence += 30;
        }
      }

      // 5. Tasa de Retención
      const completed = filteredData.filter((p) => p.completado).length;
      analysis.indicators.retentionRate =
        (completed / filteredData.length) * 100;

      if (analysis.indicators.retentionRate < 30) {
        analysis.alerts.push("⚠️ Baja retención - revisar metodología");
        analysis.confidence -= 15;
      }

      // Calcular confianza final
      analysis.confidence = Math.max(
        0,
        Math.min(100, 60 + analysis.confidence)
      );
      analysis.isLearning = analysis.confidence >= 50;

      return analysis;
    } catch (err) {
      console.error("Error analizando efectividad:", err);
      return null;
    }
  };

  // Algoritmo 2: Detección de Atención (ADA)
  const analyzeAttentionLevel = async (studentId, courseId = null) => {
    try {
      const { data, error } = await supabase
        .from("progreso_estudiantes")
        .select(
          `
        *,
        recursos!inner(curso_id)
      `
        )
        .eq("usuario_id", studentId)
        .order("updated_at", { ascending: false })
        .limit(20);

      if (error) throw error;

      const filteredData = courseId
        ? data.filter((p) => p.recursos.curso_id === courseId)
        : data;

      const attention = {
        level: "Buena",
        score: 75,
        indicators: {
          inactivityPeriods: 0,
          consistencyScore: 0,
          focusIndex: 0,
        },
        recommendations: [],
      };

      if (filteredData.length < 3) {
        return { ...attention, level: "Insuficientes datos", score: 0 };
      }

      // 1. Períodos de inactividad
      const updates = filteredData
        .map((p) => new Date(p.updated_at))
        .sort((a, b) => a - b);
      let longGaps = 0;

      for (let i = 1; i < updates.length; i++) {
        const diffMinutes = (updates[i] - updates[i - 1]) / (1000 * 60);
        if (diffMinutes > 30) longGaps++;
      }

      attention.indicators.inactivityPeriods = longGaps;

      if (longGaps > 3) {
        attention.score -= 20;
        attention.recommendations.push(
          "🕐 Establecer horarios regulares de estudio"
        );
      }

      // 2. Consistencia de rendimiento
      const progressValues = filteredData.map((p) => p.progreso || 0);
      const stdDev = calculateStdDev(progressValues);

      attention.indicators.consistencyScore = stdDev;

      if (stdDev > 30) {
        attention.score -= 15;
        attention.recommendations.push(
          "📊 Rendimiento inconsistente - revisar ambiente de estudio"
        );
      }

      // 3. Índice de Foco
      const focusTimes = filteredData.filter(
        (p) => p.tiempo_dedicado && p.tiempo_dedicado > 0
      );
      if (focusTimes.length > 0) {
        const avgTime =
          focusTimes.reduce((sum, p) => sum + p.tiempo_dedicado, 0) /
          focusTimes.length;
        attention.indicators.focusIndex = Math.min(100, (avgTime / 300) * 100);

        if (attention.indicators.focusIndex < 30) {
          attention.score -= 20;
          attention.recommendations.push(
            "⚡ Aumentar tiempo de dedicación por actividad"
          );
        }
      }

      // Determinar nivel
      if (attention.score >= 70) {
        attention.level = "Excelente";
      } else if (attention.score >= 50) {
        attention.level = "Buena";
      } else if (attention.score >= 30) {
        attention.level = "Regular";
        attention.recommendations.push(
          "⚠️ Necesita mejorar concentración en clase"
        );
      } else {
        attention.level = "Baja";
        attention.recommendations.push(
          "🚨 ALERTA: Baja atención - intervención necesaria"
        );
      }

      return attention;
    } catch (err) {
      console.error("Error analizando atención:", err);
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
  const generateAdaptiveFeedback = async (studentId, courseId) => {
    try {
      const learningAnalysis = await analyzeLearningEffectiveness(
        studentId,
        courseId
      );
      const attentionAnalysis = await analyzeAttentionLevel(
        studentId,
        courseId
      );

      const feedback = {
        studentId,
        courseId,
        timestamp: new Date().toISOString(),
        overallStatus: "En Progreso",
        learningEffectiveness: learningAnalysis,
        attentionLevel: attentionAnalysis,
        strengths: [],
        weaknesses: [],
        recommendations: [],
        actionPlan: [],
      };

      // Determinar estado general
      if (learningAnalysis?.isLearning && attentionAnalysis?.score >= 70) {
        feedback.overallStatus = "✅ Aprendizaje Efectivo";
        feedback.strengths.push("Demuestra comprensión real del contenido");
        feedback.strengths.push("Mantiene buena atención en clase");
      } else if (
        !learningAnalysis?.isLearning ||
        attentionAnalysis?.score < 30
      ) {
        feedback.overallStatus = "🚨 Requiere Intervención";
        feedback.actionPlan.push(
          "🎯 PRIORITARIO: Reunión con docente y padres"
        );
      } else {
        feedback.overallStatus = "⚠️ Necesita Apoyo";
      }

      // Identificar fortalezas
      if (learningAnalysis) {
        if (learningAnalysis.indicators.improvementTrend > 10) {
          feedback.strengths.push("Muestra mejora continua en su aprendizaje");
        }
        if (learningAnalysis.indicators.retentionRate > 70) {
          feedback.strengths.push("Buena retención de conocimientos");
        }
        if (learningAnalysis.indicators.averageAttempts > 3) {
          feedback.weaknesses.push("Dificultad para comprender a la primera");
          feedback.recommendations.push(
            "📚 Reforzar conceptos básicos antes de avanzar"
          );
        }
      }

      if (attentionAnalysis) {
        if (attentionAnalysis.score < 50) {
          feedback.weaknesses.push("Problemas de atención y concentración");
          feedback.recommendations.push(...attentionAnalysis.recommendations);
        }
      }

      // Plan de acción
      if (feedback.weaknesses.length > 0) {
        feedback.actionPlan.push("📝 Evaluación diagnóstica adicional");
        feedback.actionPlan.push("👥 Trabajo en grupos pequeños");
        feedback.actionPlan.push("🎮 Actividades interactivas personalizadas");
      }

      if (feedback.strengths.length > 0) {
        feedback.actionPlan.push("⭐ Reconocer logros públicamente");
        feedback.actionPlan.push(
          "🎯 Desafíos avanzados para mantener motivación"
        );
      }

      return feedback;
    } catch (err) {
      console.error("Error generando retroalimentación:", err);
      return null;
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

      console.log(`📄 Documento: ${cleanText.length} caracteres`);

      const num = quizConfig.totalPreguntas || 5;

      const prompt = `Eres profesor de básica elemental (6-10 años).

Lee este texto y genera EXACTAMENTE ${num} preguntas simples.
- Máximo 15 palabras por pregunta
- Lenguaje para niños
- 4 opciones cada pregunta
- Solo 1 respuesta correcta

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
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyDuJcvWLZnCAlKY1gS7wi_5ESHQBSnEJeE',
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

        if (!aiText) throw new Error('Sin respuesta');

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

        setCurrentQuiz({ preguntas: generatedQuestions });
        setShowQuizBuilder(true);

        alert(`✅ ${generatedQuestions.length} preguntas generadas.\n\n💡 Puedes editarlas antes de guardar.`);
        setUploadedDocument(null);
        setDocumentText('');
        setGeneratingQuestions(false);
      } catch (aiError) {
        console.warn('⚠️ IA no disponible');

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

        alert(`📊 ${generatedQuestions.length} preguntas generadas (sin IA).`);
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

  const saveQuizToResource = async () => {
    if (currentQuiz.preguntas.length === 0) {
      alert("Debes agregar al menos una pregunta");
      return;
    }

    try {
      const { error } = await supabase
        .from("recursos")
        .update({
          contenido_quiz: currentQuiz.preguntas,
          metadata: {
            total_preguntas: currentQuiz.preguntas.length,
            puntos_totales: currentQuiz.preguntas.reduce(
              (sum, q) => sum + q.puntos,
              0
            ),
            tiene_audio: currentQuiz.preguntas.some(
              (q) => q.audio_pregunta || q.audio_opciones.some((a) => a)
            ),
            tiene_video: currentQuiz.preguntas.some((q) => q.video_url),
            tiene_imagenes: currentQuiz.preguntas.some(
              (q) => q.imagen_url || q.imagen_opciones.some((i) => i)
            ),
          },
        })
        .eq("id", selectedResource.id);

      if (error) throw error;

      fetchResources();
      setCurrentQuiz({ preguntas: [] });
      setShowQuizBuilder(false);
      setSelectedResource(null);
      setUploadedDocument(null);
      alert("✅ Quiz guardado exitosamente");
    } catch (err) {
      console.error("Error guardando quiz:", err);
      alert("Error al guardar el quiz");
    }
  };

  const handlePreviewAnswer = (questionIndex, optionIndex) => {
    const question = currentQuiz.preguntas[questionIndex];
    const isCorrect = optionIndex === question.respuesta_correcta;

    setPreviewAnswers({
      ...previewAnswers,
      [questionIndex]: { selected: optionIndex, isCorrect },
    });

    if (question.audio_retroalimentacion) {
      speakText(
        isCorrect
          ? question.retroalimentacion_correcta
          : question.retroalimentacion_incorrecta
      );
    }
  };

  const speakText = (text) => {
    if ("speechSynthesis" in window) {
      window.speechSynthesis.cancel();
      const utterance = new SpeechSynthesisUtterance(text);
      utterance.lang = "es-ES";
      utterance.rate = 0.9;
      utterance.pitch = 1.1;
      window.speechSynthesis.speak(utterance);
    }
  };

  const openQuizBuilder = (resource) => {
    setSelectedResource(resource);
    setShowQuizBuilder(true);
    setActiveTab("resources");
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
    setUploadedDocument(null);
  };

  const openPreview = (resource) => {
    if (!resource.contenido_quiz || resource.contenido_quiz.length === 0) {
      alert("Este quiz no tiene preguntas aún");
      return;
    }
    setSelectedResource(resource);
    setCurrentQuiz({ preguntas: resource.contenido_quiz });
    setPreviewQuiz(true);
    setCurrentPreviewQuestion(0);
    setPreviewAnswers({});

    if (resource.contenido_quiz[0]?.audio_pregunta) {
      setTimeout(() => speakText(resource.contenido_quiz[0].pregunta), 500);
    }
  };

  const closePreview = () => {
    window.speechSynthesis.cancel();
    setPreviewQuiz(false);
    setPreviewAnswers({});
    setOptionListenState({});
    setCurrentPreviewQuestion(0);
    setSelectedResource(null);
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

      // ✅ Buscar curso correctamente
      const course = courses.find((c) => String(c.id) === String(finalCourseId));

      if (!course) {
        console.error("❌ Curso no encontrado. ID buscado:", finalCourseId);
        alert("❌ Curso no encontrado. Verifica que el curso exista.");
        return;
      }

      console.log("✅ Curso encontrado:", course.titulo);

      // ✅ CORRECCIÓN: Usar 'progreso_estudiantes' (tabla correcta)
      const { data: progressData, error: progressError } = await supabase.from(
        "progreso_estudiantes"
      ).select(`
      *,
      usuario_id,
      recurso_id,
      usuarios!inner(id, nombre, email, grupo_id),
      recursos!inner(id, curso_id, titulo, tipo, puntos_recompensa)
    `);

      if (progressError) {
        console.error("❌ Error en consulta de progreso:", progressError);
        alert("Error al cargar datos de progreso: " + progressError.message);
        return;
      }

      // ✅ Filtrar progreso por curso
      const courseProgressData =
        progressData?.filter(
          (p) => String(p.recursos?.curso_id) === String(finalCourseId)
        ) || [];

      console.log(
        `📊 Total registros de progreso: ${progressData?.length || 0}`
      );
      console.log(
        `📊 Progreso filtrado del curso: ${courseProgressData.length}`
      );

      // Obtener estudiantes únicos
      const uniqueStudentIds = [
        ...new Set(courseProgressData.map((p) => p.usuario_id)),
      ];

      if (uniqueStudentIds.length === 0) {
        alert(
          "⚠️ Este curso no tiene estudiantes con progreso registrado todavía."
        );
        return;
      }

      console.log(`👥 Estudiantes únicos: ${uniqueStudentIds.length}`);

      // ✅ Calcular estadísticas generales
      const completedCount = courseProgressData.filter(
        (p) => p.completado
      ).length;
      const avgProgress =
        courseProgressData.length > 0
          ? Math.round(
            courseProgressData.reduce(
              (sum, p) => sum + (p.progreso || 0),
              0
            ) / courseProgressData.length
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

      // ✅ Recolectar datos de estudiantes con algoritmos de IA
      const studentsData = [];
      const studentsToAnalyze = uniqueStudentIds.slice(0, 10);

      for (const studentId of studentsToAnalyze) {
        const student = users.find((u) => u.id === studentId);

        if (!student) {
          console.warn(`⚠️ Usuario no encontrado: ${studentId}`);
          continue;
        }

        console.log(`🔍 Analizando estudiante: ${student.nombre}`);

        // ✅ Llamar a los algoritmos de IA
        const feedback = await generateAdaptiveFeedback(studentId, finalCourseId);

        if (!feedback) {
          console.warn(`⚠️ No se pudo analizar a: ${student.nombre}`);
          continue;
        }

        const grupoNombre = student.grupo_id
          ? groups.find((g) => g.id === student.grupo_id)?.nombre || "Sin grupo"
          : "Sin grupo";

        studentsData.push({
          student,
          feedback,
          grupo: grupoNombre,
        });
      }

      console.log(`✅ ${studentsData.length} estudiantes analizados`);

      // ✅ Crear objeto del reporte
      const reportObj = {
        course: {
          titulo: course.titulo,
          nivel: course.nivel_nombre || "Sin nivel",
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
      };

      console.log("✅ Análisis generado correctamente");

      // ✅ Mostrar modal con los datos
      setCourseReportData(reportObj);
      setShowCourseReportModal(true);

      // Limpiar la selección
      setSelectedCourseForReport(null);
    } catch (err) {
      console.error("❌ Error generando análisis:", err);
      alert("Error al generar el análisis: " + err.message);
    }
  };

  const generateAllCoursesReport = async () => {
    try {
      setIsAnalyzingAllCourses(true);
      console.log("🚀 Iniciando análisis de TODOS los cursos...");

      // ✅ CORRECCIÓN: Removido nivel_nombre de la consulta (no existe en BD)
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

      // ✅ Agrupar por curso
      const courseMap = {};
      progressData.forEach((progress) => {
        const cursoId = progress.recursos?.curso_id;
        if (!cursoId) return;

        if (!courseMap[cursoId]) {
          // ✅ Obtener datos del curso desde el ESTADO 'courses'
          // (que ya tiene nivel_nombre cargado desde fetchCourses)
          const courseData = courses.find((c) => c.id === cursoId);

          courseMap[cursoId] = {
            id: cursoId,
            titulo: courseData?.titulo || `Curso ${cursoId}`,
            nivel: courseData?.nivel_nombre || "Sin nivel", // ✅ Del estado, no de BD
            data: [],
          };
        }
        courseMap[cursoId].data.push(progress);
      });

      console.log(`✅ ${Object.keys(courseMap).length} cursos identificados`);

      // Obtener estudiantes únicos
      const uniqueStudentIds = [
        ...new Set(progressData.map((p) => p.usuario_id)),
      ];

      console.log(`👥 ${uniqueStudentIds.length} estudiantes únicos`);

      // ✅ Analizar cada estudiante (máximo 10)
      const studentsData = [];
      const studentsToAnalyze = uniqueStudentIds.slice(0, 10);

      for (const studentId of studentsToAnalyze) {
        const student = users.find((u) => u.id === studentId);
        if (!student) {
          console.warn(`⚠️ Estudiante no encontrado: ${studentId}`);
          continue;
        }

        console.log(`🔍 Analizando estudiante: ${student.nombre}`);

        try {
          // Analizar sin filtro de curso (análisis general)
          const feedback = await generateAdaptiveFeedback(studentId, null);

          if (!feedback) {
            console.warn(`⚠️ No se pudo generar feedback para: ${student.nombre}`);
            continue;
          }

          const grupoNombre = student.grupo_id
            ? groups.find((g) => g.id === student.grupo_id)?.nombre || "Sin grupo"
            : "Sin grupo";

          studentsData.push({
            student,
            feedback,
            grupo: grupoNombre,
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
        progressData.reduce((sum, p) => sum + (p.progreso || 0), 0) /
        progressData.length
      );
      const totalTime = Math.round(
        progressData.reduce((sum, p) => sum + (p.tiempo_dedicado || 0), 0) / 60
      );
      const completionRate = Math.round(
        (completedCount / progressData.length) * 100
      );

      console.log("📈 Estadísticas calculadas:");
      console.log(`  - Progreso promedio: ${avgProgress}%`);
      console.log(`  - Completitud: ${completionRate}%`);
      console.log(`  - Tiempo total: ${totalTime} minutos`);

      // Crear objeto del reporte de todos los cursos
      const reportObj = {
        course: {
          titulo: `📊 ANÁLISIS GENERAL - ${Object.keys(courseMap).length} Cursos`,
          nivel: "Sistema Completo",
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
          .sort((a, b) => b.data.length - a.data.length) // Ordenar por cantidad de registros
          .map((course) => {
            const courseStudents = new Set(
              course.data.map((p) => p.usuario_id)
            ).size;
            const courseCompleted = course.data.filter((p) => p.completado).length;

            return {
              titulo: course.titulo,
              nivel: course.nivel,
              totalEstudiantes: courseStudents,
              totalRegistros: course.data.length,
              progresoPromedio: Math.round(
                course.data.reduce((sum, p) => sum + (p.progreso || 0), 0) /
                course.data.length
              ),
              completados: courseCompleted,
              completionRate: Math.round(
                (courseCompleted / course.data.length) * 100
              ),
            };
          }),
      };

      console.log("✅ Análisis de todos los cursos completado");
      console.log("📊 Reporte final:", reportObj);

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
    try {
      // Crear contenido CSV
      let csvContent = "sep=,\n"; // Separador para Excel en español

      // ENCABEZADO PRINCIPAL
      csvContent += `REPORTE ANALÍTICO DE CURSO CON IA PREDICTIVA\n`;
      csvContent += `Curso,${courseReportData.course.titulo}\n`;
      csvContent += `Nivel,${courseReportData.course.nivel}\n`;
      csvContent += `Fecha de Generación,${courseReportData.course.fecha}\n`;
      csvContent += `\n`;

      // ESTADÍSTICAS GENERALES
      csvContent += `ESTADÍSTICAS GENERALES\n`;
      csvContent += `Total Estudiantes,${courseReportData.stats.totalStudents}\n`;
      csvContent += `Progreso Promedio,${courseReportData.stats.avgProgress}%\n`;
      csvContent += `Recursos Completados,${courseReportData.stats.completedResources}\n`;
      csvContent += `Tiempo Total,${courseReportData.stats.totalTime} minutos\n`;
      csvContent += `Tasa de Completitud,${courseReportData.stats.completionRate}%\n`;
      csvContent += `\n`;

      // ENCABEZADOS DE ESTUDIANTES
      csvContent += `ANÁLISIS DETALLADO POR ESTUDIANTE\n`;
      csvContent += `Nombre,Email,Grupo,Estado General,Aprendizaje (LEA),Confianza,Atención (ADA),Score Atención,`;
      csvContent += `Intentos Promedio,Tiempo Respuesta,Tasa Retención,Mejora Tendencia,`;
      csvContent += `Fortalezas,Áreas Mejora,Plan de Acción\n`;

      // DATOS DE ESTUDIANTES con filtros aplicados
      const filteredStudentsForExport = courseReportData.students.filter(
        (data) => {
          if (filterByGroup && data.grupo !== filterByGroup) return false;
          if (
            filterByStatus === "excellent" &&
            !data.feedback.overallStatus.includes("✅")
          )
            return false;
          if (
            filterByStatus === "warning" &&
            !data.feedback.overallStatus.includes("⚠️")
          )
            return false;
          if (
            filterByStatus === "critical" &&
            !data.feedback.overallStatus.includes("🚨")
          )
            return false;
          if (
            searchStudent &&
            !data.student.nombre
              .toLowerCase()
              .includes(searchStudent.toLowerCase())
          )
            return false;
          return true;
        }
      );

      filteredStudentsForExport.forEach((data) => {
        const { student, feedback } = data;

        csvContent += `"${student.nombre}",`;
        csvContent += `"${student.email}",`;
        csvContent += `"${data.grupo}",`;
        csvContent += `"${feedback.overallStatus}",`;
        csvContent += `"${feedback.learningEffectiveness?.isLearning ? "Sí" : "No"
          }",`;
        csvContent += `${feedback.learningEffectiveness?.confidence?.toFixed(1) || 0
          },`;
        csvContent += `"${feedback.attentionLevel?.level || "Sin datos"}",`;
        csvContent += `${feedback.attentionLevel?.score || 0},`;
        csvContent += `${feedback.learningEffectiveness?.indicators?.averageAttempts?.toFixed(
          2
        ) || 0
          },`;
        csvContent += `${feedback.learningEffectiveness?.indicators?.averageTimePerQuestion?.toFixed(
          0
        ) || 0
          },`;
        csvContent += `${feedback.learningEffectiveness?.indicators?.retentionRate?.toFixed(
          1
        ) || 0
          }%,`;
        csvContent += `${feedback.learningEffectiveness?.indicators?.improvementTrend?.toFixed(
          1
        ) || 0
          }%,`;
        csvContent += `"${feedback.strengths?.join("; ") || "N/A"}",`;
        csvContent += `"${feedback.weaknesses?.join("; ") || "N/A"}",`;
        csvContent += `"${feedback.actionPlan?.join("; ") || "N/A"}"\n`;
      });

      csvContent += `\n`;
      csvContent += `LEYENDA DE INDICADORES\n`;
      csvContent += `LEA,Learning Effectiveness Analysis - Detecta aprendizaje real\n`;
      csvContent += `ADA,Attention Detection Algorithm - Analiza concentración\n`;
      csvContent += `AFS,Adaptive Feedback System - Sistema de retroalimentación\n`;
      csvContent += `\n`;
      csvContent += `Generado por Didactikapp - Plataforma Educativa con IA\n`;

      // Crear blob y descargar
      const blob = new Blob([csvContent], {
        type: "application/vnd.ms-excel;charset=utf-8;",
      });
      const link = document.createElement("a");
      const url = URL.createObjectURL(blob);

      link.setAttribute("href", url);
      link.setAttribute(
        "download",
        `Reporte_${courseReportData.course.titulo.replace(/\s+/g, "_")}_${new Date().toISOString().split("T")[0]
        }.xlsx`
      );
      link.style.visibility = "hidden";

      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);

      alert("✅ Reporte descargado en Excel correctamente");
    } catch (error) {
      console.error("Error descargando reporte:", error);
      alert("❌ Error al descargar el reporte");
    }
  };

  // ✅ Función para imprimir el reporte
  const handlePrintReport = () => {
    window.print();
  };

  useEffect(() => {
    if (!previewQuiz || !currentQuiz.preguntas.length) return;

    const question = currentQuiz.preguntas[currentPreviewQuestion];

    // Leer la pregunta al cargar
    setTimeout(() => {
      speakText(question.pregunta);
    }, 500);

    // Detectar demora y repetir pregunta
    const tiempoMax = question.tiempo_limite
      ? question.tiempo_limite * 1000 * 0.7
      : 20000;
    const timer = setTimeout(() => {
      if (!previewAnswers[currentPreviewQuestion]) {
        // Repetir la pregunta automáticamente
        speakText(question.pregunta);
      }
    }, tiempoMax);

    return () => clearTimeout(timer);
  }, [previewQuiz, currentPreviewQuestion, previewAnswers]);

  useEffect(() => {
    if (!previewQuiz || !currentQuiz.preguntas.length) return;

    const question = currentQuiz.preguntas[currentPreviewQuestion];

    // Leer la pregunta al cargar
    setTimeout(() => {
      speakText(question.pregunta);

      // Leer las opciones después de la pregunta
      setTimeout(() => {
        const opciones = question.opciones.join(". ");
        speakText(`Las opciones son: ${opciones}`);
      }, 2000);
    }, 500);

    // Detectar demora y repetir pregunta
    const tiempoMax = question.tiempo_limite
      ? question.tiempo_limite * 1000 * 0.7
      : 20000;
    const timer = setTimeout(() => {
      if (!previewAnswers[currentPreviewQuestion]) {
        // Repetir la pregunta automáticamente
        speakText(question.pregunta);

        // Repetir las opciones después
        setTimeout(() => {
          const opciones = question.opciones.join(". ");
          speakText(`Las opciones son: ${opciones}`);
        }, 2000);
      }
    }, tiempoMax);

    return () => clearTimeout(timer);
  }, [previewQuiz, currentPreviewQuestion, previewAnswers]);

  const renderQuestionPreview = () => {
    if (!currentQuiz.preguntas.length) return null;

    const question = currentQuiz.preguntas[currentPreviewQuestion];
    const answer = previewAnswers[currentPreviewQuestion];

    // Mascota educativa - Expresiones y animaciones según el estado
    const getMascotState = () => {
      if (answer?.isCorrect) {
        return {
          animation: 'celebrate',
          message: "¡Increíble! ¡Lo lograste! 🎉",
          bgColor: 'from-green-400 to-green-600',
          eyesLeft: '25%',
          eyesTop: '35%',
          mouth: 'M 30 50 Q 40 60, 50 50',
          expression: '😄'
        };
      }
      if (answer && !answer.isCorrect) {
        return {
          animation: 'encourage',
          message: "¡Casi! Inténtalo otra vez 💪",
          bgColor: 'from-orange-400 to-orange-600',
          eyesLeft: '28%',
          eyesTop: '38%',
          mouth: 'M 30 55 Q 40 52, 50 55',
          expression: '😊'
        };
      }
      if (selectedOption !== null) {
        return {
          animation: 'thinking',
          message: "¿Estás seguro? Presiona el botón verde ✅",
          bgColor: 'from-blue-400 to-blue-600',
          eyesLeft: '20%',
          eyesTop: '35%',
          mouth: 'M 30 53 Q 40 53, 50 53',
          expression: '🤔'
        };
      }
      return {
        animation: 'idle',
        message: "¡Hola! Escucha cada opción y elige 🔊",
        bgColor: 'from-green-400 to-green-600',
        eyesLeft: '25%',
        eyesTop: '35%',
        mouth: 'M 30 52 Q 40 55, 50 52',
        expression: '😊'
      };
    };

    const mascotState = getMascotState();

    const handleOptionClick = (idx) => {
      // Si ya confirmó la respuesta, no hacer nada
      if (answer !== undefined) return;

      // Reproducir audio de la opción
      speakText(question.opciones[idx]);

      // Seleccionar la opción (puede cambiar cuantas veces quiera)
      setSelectedOption(idx);
      setMascotAnimation('thinking');

      // Marcar como escuchada
      const optionKey = `${currentPreviewQuestion}-${idx}`;
      setOptionListenState({ ...optionListenState, [optionKey]: true });
    };

    const handleConfirmAnswer = () => {
      if (selectedOption === null) {
        speakText("Debes seleccionar una opción primero");
        setMascotAnimation('shake');
        setTimeout(() => setMascotAnimation('idle'), 500);
        return;
      }

      // Confirmar respuesta
      handlePreviewAnswer(currentPreviewQuestion, selectedOption);

      const isCorrect = selectedOption === question.respuesta_correcta;
      setMascotAnimation(isCorrect ? 'celebrate' : 'encourage');
    };

    return (
      <div className="bg-gradient-to-br from-blue-100 via-purple-100 to-pink-100 rounded-3xl p-6 min-h-[600px] flex flex-col relative overflow-hidden">
        {/* Decoración de fondo animada */}
        <div className="absolute top-0 right-0 w-32 h-32 bg-yellow-300 rounded-full opacity-20 -mr-16 -mt-16 animate-pulse"></div>
        <div className="absolute bottom-0 left-0 w-40 h-40 bg-blue-300 rounded-full opacity-20 -ml-20 -mb-20 animate-pulse"></div>
        <div className="absolute top-1/2 left-1/2 w-24 h-24 bg-pink-300 rounded-full opacity-10 animate-ping"></div>

        {/* Header con mascota animada SVG */}
        <div className="flex justify-between items-start mb-6 relative z-10">
          <div className="flex items-center gap-4">
            {/* Mascota SVG Animada */}
            <div className={`relative ${mascotAnimation === 'celebrate' ? 'animate-bounce' :
              mascotAnimation === 'shake' ? 'animate-shake' :
                mascotAnimation === 'thinking' ? 'animate-pulse' :
                  'animate-float'
              }`}>
              <svg width="80" height="80" viewBox="0 0 100 100" className="drop-shadow-2xl">
                {/* Cuerpo de la tortuga */}
                <ellipse cx="50" cy="70" rx="35" ry="25" fill="#4ade80" className="animate-breathe" />

                {/* Caparazón con gradiente */}
                <defs>
                  <linearGradient id="shellGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                    <stop offset="0%" style={{ stopColor: '#22c55e', stopOpacity: 1 }} />
                    <stop offset="100%" style={{ stopColor: '#16a34a', stopOpacity: 1 }} />
                  </linearGradient>
                  <filter id="shadow">
                    <feDropShadow dx="0" dy="2" stdDeviation="3" floodOpacity="0.3" />
                  </filter>
                </defs>
                <ellipse cx="50" cy="50" rx="40" ry="35" fill="url(#shellGradient)" filter="url(#shadow)" />

                {/* Patrón del caparazón */}
                <ellipse cx="50" cy="45" rx="25" ry="20" fill="#15803d" opacity="0.3" />
                <circle cx="40" cy="50" r="8" fill="#15803d" opacity="0.4" />
                <circle cx="60" cy="50" r="8" fill="#15803d" opacity="0.4" />
                <circle cx="50" cy="60" r="8" fill="#15803d" opacity="0.4" />

                {/* Cabeza */}
                <ellipse cx="50" cy="30" rx="20" ry="18" fill="#4ade80" />

                {/* Ojos con animación */}
                <g className={mascotAnimation === 'thinking' ? 'animate-look-around' : ''}>
                  <ellipse cx="43" cy="28" rx="4" ry="5" fill="white" />
                  <ellipse cx="57" cy="28" rx="4" ry="5" fill="white" />
                  <circle cx="44" cy="29" r="2.5" fill="#1f2937" className="animate-blink" />
                  <circle cx="58" cy="29" r="2.5" fill="#1f2937" className="animate-blink" />
                  <circle cx="45" cy="28" r="1" fill="white" className="shine" />
                  <circle cx="59" cy="28" r="1" fill="white" className="shine" />
                </g>

                {/* Boca con expresión */}
                <path
                  d={mascotState.mouth}
                  stroke="#1f2937"
                  strokeWidth="2"
                  fill="none"
                  strokeLinecap="round"
                  className="transition-all duration-300"
                />

                {/* Mejillas cuando está feliz */}
                {(mascotAnimation === 'celebrate' || mascotAnimation === 'idle') && (
                  <>
                    <circle cx="35" cy="32" r="4" fill="#fb923c" opacity="0.5" />
                    <circle cx="65" cy="32" r="4" fill="#fb923c" opacity="0.5" />
                  </>
                )}

                {/* Patitas */}
                <ellipse cx="30" cy="75" rx="8" ry="6" fill="#4ade80" />
                <ellipse cx="70" cy="75" rx="8" ry="6" fill="#4ade80" />

                {/* Efectos especiales según animación */}
                {mascotAnimation === 'celebrate' && (
                  <>
                    <text x="15" y="25" fontSize="20" className="animate-float-sparkle">✨</text>
                    <text x="75" y="25" fontSize="20" className="animate-float-sparkle-delayed">✨</text>
                    <text x="45" y="15" fontSize="20" className="animate-float-sparkle">🎉</text>
                  </>
                )}

                {mascotAnimation === 'thinking' && (
                  <text x="70" y="20" fontSize="25" className="animate-bounce">💭</text>
                )}
              </svg>
            </div>

            {/* Burbuja de diálogo */}
            <div className={`bg-white rounded-2xl px-4 py-3 shadow-lg border-2 transition-all ${mascotAnimation === 'celebrate' ? 'border-green-400 bg-green-50' :
              mascotAnimation === 'encourage' ? 'border-orange-400 bg-orange-50' :
                'border-blue-400'
              }`}>
              <p className="text-sm font-bold text-gray-800">{mascotState.message}</p>
            </div>
          </div>

          <div className="flex items-center gap-3">
            <div className="bg-white rounded-full px-4 py-2 shadow-md border-2 border-purple-300">
              <span className="text-lg font-bold text-purple-600">
                {currentPreviewQuestion + 1} de {currentQuiz.preguntas.length}
              </span>
            </div>
          </div>
        </div>

        {/* Progreso visual */}
        <div className="flex gap-2 mb-6">
          {currentQuiz.preguntas.map((_, idx) => (
            <div
              key={idx}
              className={`flex-1 h-3 rounded-full transition-all ${idx === currentPreviewQuestion
                ? "bg-gradient-to-r from-purple-500 to-pink-500 shadow-lg"
                : idx < currentPreviewQuestion
                  ? "bg-green-400"
                  : "bg-gray-300"
                }`}
            />
          ))}
        </div>

        <div className="flex-1 flex flex-col items-center justify-center">
          {/* Imagen ilustrativa grande */}
          {question.imagen_url && (
            <div className="mb-6 transform hover:scale-105 transition-transform">
              <div className="w-64 h-64 bg-white rounded-3xl shadow-2xl flex items-center justify-center border-8 border-yellow-300">
                <span className="text-9xl">{question.imagen_url}</span>
              </div>
            </div>
          )}

          {/* Pregunta con audio grande */}
          <div className="bg-white rounded-3xl shadow-2xl p-8 mb-8 max-w-3xl w-full border-4 border-purple-300">
            <div className="flex items-center gap-4 justify-center">
              {question.audio_pregunta && (
                <button
                  onClick={() => speakText(question.pregunta)}
                  className="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white p-6 rounded-full shadow-2xl transition-all transform hover:scale-110 animate-pulse"
                  title="Escuchar pregunta"
                >
                  <Volume2 className="w-8 h-8" />
                </button>
              )}
              <h3 className="text-4xl font-black text-gray-800 text-center leading-relaxed">
                {question.pregunta}
              </h3>
            </div>
          </div>

          {/* Opciones con audio individual - AHORA PUEDEN CAMBIAR DE OPINIÓN */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 w-full max-w-4xl">
            {question.opciones.map((opcion, idx) => {
              const optionKey = `${currentPreviewQuestion}-${idx}`;
              const isListened = optionListenState[optionKey];
              const isSelected = selectedOption === idx;

              return (
                <button
                  key={idx}
                  onClick={() => handleOptionClick(idx)}
                  disabled={answer !== undefined}
                  className={`relative p-8 rounded-3xl font-bold text-2xl transition-all transform hover:scale-105 shadow-xl ${answer === undefined
                    ? isSelected
                      ? "bg-gradient-to-br from-yellow-300 to-yellow-400 border-4 border-yellow-500 text-gray-800 scale-105 shadow-2xl"
                      : isListened
                        ? "bg-gradient-to-br from-blue-100 to-blue-200 border-4 border-blue-300 text-gray-800"
                        : "bg-white hover:bg-gradient-to-br hover:from-purple-50 hover:to-pink-50 border-4 border-gray-300 text-gray-700"
                    : answer.selected === idx
                      ? answer.isCorrect
                        ? "bg-gradient-to-br from-green-400 to-green-600 text-white border-4 border-green-700 animate-bounce"
                        : "bg-gradient-to-br from-red-400 to-red-600 text-white border-4 border-red-700"
                      : idx === question.respuesta_correcta
                        ? "bg-gradient-to-br from-green-400 to-green-600 text-white border-4 border-green-700"
                        : "bg-gray-200 text-gray-500 border-4 border-gray-400"
                    }`}
                >
                  {/* Botón de audio pequeño en la esquina */}
                  {answer === undefined && (
                    <div className="absolute top-3 right-3">
                      <div className={`w-10 h-10 rounded-full flex items-center justify-center transition-all ${isListened ? "bg-green-400 animate-pulse" : "bg-blue-400"
                        }`}>
                        <Volume2 className="w-5 h-5 text-white" />
                      </div>
                    </div>
                  )}

                  {/* Indicador de selección */}
                  {isSelected && answer === undefined && (
                    <div className="absolute top-3 left-3">
                      <div className="w-10 h-10 rounded-full flex items-center justify-center bg-green-500 animate-bounce">
                        <span className="text-2xl">✓</span>
                      </div>
                    </div>
                  )}

                  <div className="flex flex-col items-center gap-3">
                    {question.tipo === "imagen" && question.imagen_opciones[idx] && (
                      <span className="text-6xl">{question.imagen_opciones[idx]}</span>
                    )}
                    <span className="text-center">{opcion}</span>

                    {answer !== undefined && answer.selected === idx && (
                      <div className="mt-2">
                        {answer.isCorrect ? (
                          <CheckCircle className="w-10 h-10" />
                        ) : (
                          <XCircle className="w-10 h-10" />
                        )}
                      </div>
                    )}
                  </div>

                  {/* Indicadores de estado */}
                  {!isSelected && !isListened && answer === undefined && (
                    <div className="absolute bottom-3 left-0 right-0 text-center">
                      <span className="text-xs bg-blue-500 text-white px-3 py-1 rounded-full animate-pulse">
                        Toca para escuchar 🔊
                      </span>
                    </div>
                  )}

                  {isSelected && answer === undefined && (
                    <div className="absolute bottom-3 left-0 right-0 text-center">
                      <span className="text-xs bg-yellow-600 text-white px-3 py-1 rounded-full font-bold animate-bounce">
                        SELECCIONADA ⭐
                      </span>
                    </div>
                  )}
                </button>
              );
            })}
          </div>

          {/* Botón "ESTOY SEGURO" - Solo aparece cuando ya respondió */}
          {!answer && selectedOption !== null && (
            <div className="mt-8 w-full max-w-2xl">
              <button
                onClick={handleConfirmAnswer}
                className="w-full bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white px-12 py-6 rounded-3xl text-3xl font-black transition-all transform hover:scale-105 shadow-2xl border-4 border-green-700 animate-pulse"
              >
                ✅ ¡ESTOY SEGURO!
              </button>
              <p className="text-center text-sm text-gray-600 mt-3">
                Puedes cambiar tu respuesta tocando otra opción
              </p>
            </div>
          )}

          {/* Retroalimentación con mascota */}
          {answer && (
            <div className="mt-8 max-w-2xl w-full">
              <div
                className={`rounded-3xl p-6 text-center shadow-2xl border-4 animate-bounce-in ${answer.isCorrect
                  ? "bg-gradient-to-br from-green-100 to-green-200 border-green-400"
                  : "bg-gradient-to-br from-orange-100 to-orange-200 border-orange-400"
                  }`}
              >
                <div className="flex items-center justify-center gap-4 mb-3">
                  <span className="text-6xl animate-bounce">{answer.isCorrect ? "🎉" : "💪"}</span>
                  <span className="text-5xl animate-wiggle">🐢</span>
                  <span className="text-6xl animate-bounce">{answer.isCorrect ? "✨" : "🌟"}</span>
                </div>
                <p className="text-4xl font-black mb-2">
                  {answer.isCorrect
                    ? question.retroalimentacion_correcta
                    : question.retroalimentacion_incorrecta}
                </p>
                {!answer.isCorrect && (
                  <p className="text-lg text-gray-700 mt-3">
                    La respuesta correcta era: <strong>{question.opciones[question.respuesta_correcta]}</strong>
                  </p>
                )}
              </div>
            </div>
          )}
        </div>

        {/* Botones de navegación más grandes y amigables */}
        <div className="flex justify-between mt-8 gap-4">
          <button
            onClick={() => {
              if (currentPreviewQuestion > 0) {
                setCurrentPreviewQuestion(currentPreviewQuestion - 1);
                setPreviewAnswers({});
                setOptionListenState({});
                setSelectedOption(null);
                setMascotAnimation('idle');
                const prevQuestion = currentQuiz.preguntas[currentPreviewQuestion - 1];
                if (prevQuestion?.audio_pregunta) {
                  setTimeout(() => speakText(prevQuestion.pregunta), 300);
                }
              }
            }}
            disabled={currentPreviewQuestion === 0}
            className="flex-1 px-8 py-4 bg-gradient-to-r from-gray-500 to-gray-600 hover:from-gray-600 hover:to-gray-700 text-white rounded-2xl text-xl font-bold disabled:opacity-30 disabled:cursor-not-allowed transition-all shadow-lg"
          >
            ← Anterior
          </button>

          <button
            onClick={() => {
              if (currentPreviewQuestion < currentQuiz.preguntas.length - 1) {
                setCurrentPreviewQuestion(currentPreviewQuestion + 1);
                setPreviewAnswers({});
                setOptionListenState({});
                setSelectedOption(null);
                setMascotAnimation('idle');
                const nextQuestion = currentQuiz.preguntas[currentPreviewQuestion + 1];
                if (nextQuestion?.audio_pregunta) {
                  setTimeout(() => speakText(nextQuestion.pregunta), 300);
                }
              }
            }}
            disabled={currentPreviewQuestion === currentQuiz.preguntas.length - 1 || !answer}
            className="flex-1 px-8 py-4 bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white rounded-2xl text-xl font-bold disabled:opacity-30 disabled:cursor-not-allowed transition-all shadow-lg"
          >
            {answer ? "Siguiente →" : "Responde primero"}
          </button>
        </div>

        {/* CSS personalizado para animaciones */}
        <style jsx>{`
          @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
          }
          @keyframes breathe {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
          }
          @keyframes blink {
            0%, 90%, 100% { opacity: 1; }
            95% { opacity: 0; }
          }
          @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
          }
          @keyframes wiggle {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(-5deg); }
            75% { transform: rotate(5deg); }
          }
          @keyframes float-sparkle {
            0% { transform: translateY(0) scale(1); opacity: 1; }
            100% { transform: translateY(-20px) scale(1.5); opacity: 0; }
          }
          @keyframes float-sparkle-delayed {
            0% { transform: translateY(0) scale(1); opacity: 1; }
            100% { transform: translateY(-20px) scale(1.5); opacity: 0; }
          }
          @keyframes bounce-in {
            0% { transform: scale(0); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
          }
          @keyframes look-around {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-2px); }
            75% { transform: translateX(2px); }
          }
          
          .animate-float {
            animation: float 3s ease-in-out infinite;
          }
          .animate-breathe {
            animation: breathe 2s ease-in-out infinite;
          }
          .animate-blink {
            animation: blink 4s infinite;
          }
          .animate-shake {
            animation: shake 0.5s;
          }
          .animate-wiggle {
            animation: wiggle 1s ease-in-out infinite;
          }
          .animate-float-sparkle {
            animation: float-sparkle 2s ease-out infinite;
          }
          .animate-float-sparkle-delayed {
            animation: float-sparkle-delayed 2s ease-out 0.5s infinite;
          }
          .animate-bounce-in {
            animation: bounce-in 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
          }
          .animate-look-around {
            animation: look-around 2s ease-in-out infinite;
          }
          .shine {
            opacity: 0.8;
          }
        `}</style>
      </div>
    );
  };

  const generateAIRecommendations = () => {
    const recommendations = [];

    const resourceTypes = resources.reduce((acc, resource) => {
      acc[resource.tipo] = (acc[resource.tipo] || 0) + 1;
      return acc;
    }, {});

    // Recomendación para crear más quizzes con IA
    if ((resourceTypes.quiz || 0) < 3) {
      recommendations.push({
        type: "content_gap",
        title: "Crear Quizzes con IA",
        description: `Solo tienes ${resourceTypes.quiz || 0
          } quizzes. Usa el generador con IA para crear más rápidamente.`,
        priority: "high",
        action: "Ir a Recursos",
        targetTab: "resources",
        icon: Brain,
      });
    }

    // Recomendación de compromiso
    if (analytics.engagementRate < 50) {
      recommendations.push({
        type: "engagement",
        title: "Baja Tasa de Compromiso",
        description: `El Compromiso es del ${analytics.engagementRate}%. Los quizzes interactivos pueden ayudar.`,
        priority: "high",
        action: "Ver Recursos",
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
        title: "Usuarios Inactivos",
        description: `${inactiveUsers} usuarios no han accedido en más de 7 días.`,
        priority: "medium",
        action: "Revisar Usuarios",
        targetTab: "users",
        icon: UserX,
      });
    }

    // Recomendación para usar IA si hay pocos recursos
    if (resources.length < 10) {
      recommendations.push({
        type: "ai_generator",
        title: "🤖 Genera Contenido con IA",
        description:
          "Usa el generador de quizzes con IA para crear contenido educativo rápidamente desde documentos.",
        priority: "high",
        action: "Probar IA",
        targetTab: "resources",
        icon: Sparkles,
      });
    }

    return recommendations;
  };

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

    try {
      const systemContext = `Eres un asistente educativo experto para DidactikApp, una plataforma de educación básica elemental.

INFORMACIÓN DEL SISTEMA:
- Total usuarios: ${users.length}
- Estudiantes activos: ${users.filter((u) => u.rol === "estudiante").length}
- Docentes: ${users.filter((u) => u.rol === "docente").length}
- Cursos disponibles: ${courses.length}
- Recursos educativos: ${resources.length}
- Niveles de aprendizaje: ${levels.length}
- Engagement actual: ${analytics.engagementRate}%
- Tasa de completitud: ${analytics.completionRate}%

CURSOS PRINCIPALES:
${courses
          .slice(0, 5)
          .map((c) => `- ${c.titulo} (${c.nivel_nombre})`)
          .join("\n")}

RECURSOS POR TIPO:
${Object.entries(
            resources.reduce((acc, r) => {
              acc[r.tipo] = (acc[r.tipo] || 0) + 1;
              return acc;
            }, {})
          )
          .map(([tipo, count]) => `- ${tipo}: ${count}`)
          .join("\n")}

Responde de manera clara, concisa y educativa. Si te preguntan sobre estadísticas, usa los datos anteriores. Si te piden recomendaciones, da sugerencias específicas y accionables.`;

      // ✅ Usa el endpoint v1beta y el modelo "gemini-1.5-flash-latest"
      const response = await fetch(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyDtyQgSqzFMV_M6w6iOvjrKlNe5NdK4gb8",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            contents: [
              {
                parts: [
                  {
                    text: `${systemContext}\n\nUSUARIO: ${userMessage}\n\nASISTENTE:`,
                  },
                ],
              },
            ],
            generationConfig: {
              temperature: 0.7,
              topK: 40,
              topP: 0.95,
              maxOutputTokens: 1024,
            },
          }),
        }
      );

      if (!response.ok) {
        let errorText = `Error API: ${response.status}`;
        try {
          const errJson = await response.json();
          if (errJson?.error?.message)
            errorText += ` - ${errJson.error.message}`;
        } catch (_) { }
        throw new Error(errorText);
      }

      const data = await response.json();
      const aiResponse =
        data.candidates?.[0]?.content?.parts?.[0]?.text ||
        "Sin respuesta del modelo.";

      const aiMessage = {
        id: Date.now() + 1,
        role: "assistant",
        content: aiResponse,
        timestamp: new Date(),
      };

      setChatMessages((prev) => [...prev, aiMessage]);
      setChatLoading(false);
    } catch (error) {
      console.error("Error en chat IA:", error);
      const errorMessage = {
        id: Date.now() + 1,
        role: "assistant",
        content: `❌ Lo siento, hubo un error al procesar tu mensaje. ${error.message}`,
        timestamp: new Date(),
      };
      setChatMessages((prev) => [...prev, errorMessage]);
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
      if (filterRole && user.rol !== filterRole) return false;

      if (filterGroup) {
        if (filterGroup === "sin_grupo") {
          if (
            user.grupo_id ||
            (user.grupos_adicionales && user.grupos_adicionales.length > 0)
          ) {
            return false;
          }
        } else {
          const userGroups = [
            user.grupo_id,
            ...(user.grupos_adicionales || []),
          ].filter(Boolean);

          if (!userGroups.includes(parseInt(filterGroup))) {
            return false;
          }
        }
      }

      if (filterStatus === "active" && !user.activo) return false;
      if (filterStatus === "inactive" && user.activo) return false;
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
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
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

        <div className="bg-gradient-to-r from-purple-600 via-blue-600 to-purple-600 rounded-lg p-6 text-white shadow-lg">
          <div className="flex items-start gap-4">
            <div className="bg-white bg-opacity-20 rounded-lg p-3 flex-shrink-0">
              <Sparkles className="w-6 h-6" />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-bold mb-4">
                Recomendaciones IA Regenerativa
              </h3>

              {aiRecommendations.length > 0 ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                  {aiRecommendations.map((rec, index) => {
                    const IconComponent = rec.icon || AlertCircle;
                    return (
                      <div
                        key={index}
                        className="bg-white bg-opacity-10 rounded-lg p-4 backdrop-blur hover:bg-opacity-20 transition-all"
                      >
                        <div className="flex items-start gap-3">
                          <div
                            className={`w-3 h-3 rounded-full mt-1 flex-shrink-0 ${rec.priority === "high"
                              ? "bg-red-400"
                              : rec.priority === "medium"
                                ? "bg-yellow-400"
                                : "bg-green-400"
                              }`}
                          />
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-1">
                              <IconComponent className="w-4 h-4" />
                              <p className="font-semibold text-sm">
                                {rec.title}
                              </p>
                            </div>
                            <p className="text-xs opacity-90 mb-2">
                              {rec.description}
                            </p>
                            <button
                              onClick={() => {
                                if (rec.type === "ai_generator") {
                                  // Ir a recursos y abrir el Quiz Builder con IA
                                  setActiveTab("resources");

                                  // Crear un recurso temporal para abrir el builder
                                  const tempResource = {
                                    id: "temp_" + Date.now(),
                                    titulo: "Nuevo Quiz con IA",
                                    tipo: "quiz",
                                    contenido_quiz: [],
                                  };

                                  setTimeout(() => {
                                    setSelectedResource(tempResource);
                                    setShowQuizBuilder(true);

                                    // Scroll al generador de IA después de abrir
                                    setTimeout(() => {
                                      const aiSection = document.querySelector(
                                        ".bg-gradient-to-r.from-indigo-50"
                                      );
                                      if (aiSection) {
                                        aiSection.scrollIntoView({
                                          behavior: "smooth",
                                          block: "center",
                                        });
                                      }
                                    }, 300);
                                  }, 100);
                                } else if (rec.targetTab) {
                                  setActiveTab(rec.targetTab);
                                }
                              }}
                              className="text-xs bg-white bg-opacity-20 hover:bg-opacity-30 px-3 py-1 rounded transition-colors flex items-center gap-1"
                            >
                              {rec.type === "ai_generator" && (
                                <Sparkles className="w-3 h-3" />
                              )}
                              {rec.action}
                            </button>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              ) : (
                <div className="bg-white bg-opacity-10 rounded-lg p-4 backdrop-blur">
                  <p className="text-center">
                    ✅ Tu sistema está bien balanceado. ¡Buen trabajo!
                  </p>
                </div>
              )}

              <div className="flex gap-2">
                <button
                  onClick={() => {
                    console.log('🔘 Botón clickeado');
                    generateAIAnalyticsImproved();
                  }}
                  className="bg-white text-purple-600 px-4 py-2 rounded-lg text-sm font-semibold hover:bg-opacity-90 transition-all flex items-center gap-2"
                >
                  <BarChart3 className="w-4 h-4" />
                  Ver Análisis Detallado
                </button>
              </div>
            </div>
          </div>
        </div>

        {/* Chat Interactivo con IA */}
        <div className="bg-gradient-to-r from-blue-600 via-purple-600 to-pink-600 rounded-lg p-6 text-white shadow-lg">
          <div className="flex items-start gap-4">
            <div className="bg-white bg-opacity-20 rounded-lg p-3 flex-shrink-0">
              <MessageCircle className="w-6 h-6" />
            </div>
            <div className="flex-1">
              <div className="flex items-center justify-between mb-4">
                <div>
                  <h3 className="text-lg font-bold flex items-center gap-2">
                    💬 Chat Interactivo con IA
                    <span className="text-xs bg-white bg-opacity-20 px-2 py-1 rounded-full">
                      Nuevo
                    </span>
                  </h3>
                  <p className="text-sm text-blue-100">
                    Pregunta sobre estadísticas, recomendaciones o cualquier
                    duda del sistema
                  </p>
                </div>
                <button
                  onClick={() => setShowAIChat(!showAIChat)}
                  className="bg-white text-purple-600 px-4 py-2 rounded-lg text-sm font-semibold hover:bg-opacity-90 transition-all"
                >
                  {showAIChat ? "Cerrar Chat" : "Abrir Chat"}
                </button>
              </div>

              {showAIChat && (
                <div className="bg-white bg-opacity-10 rounded-lg p-4 backdrop-blur">
                  {/* Mensajes del chat */}
                  <div className="mb-4 max-h-96 overflow-y-auto space-y-3">
                    {chatMessages.length === 0 ? (
                      <div className="text-center py-8">
                        <Brain className="w-12 h-12 mx-auto mb-3 opacity-70" />
                        <p className="text-sm opacity-90 mb-4">
                          ¡Hola! Soy tu asistente de IA. Puedo ayudarte con:
                        </p>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-2 text-xs">
                          <button
                            onClick={() =>
                              handleAIChat(
                                "¿Cuál es el estado actual del sistema?"
                              )
                            }
                            className="bg-white bg-opacity-20 hover:bg-opacity-30 px-3 py-2 rounded transition-all text-left"
                          >
                            📊 Estado del sistema
                          </button>
                          <button
                            onClick={() =>
                              handleAIChat(
                                "Dame recomendaciones para mejorar el Compromiso                                                                                                                  "
                              )
                            }
                            className="bg-white bg-opacity-20 hover:bg-opacity-30 px-3 py-2 rounded transition-all text-left"
                          >
                            💡 Mejorar Compromiso
                          </button>
                          <button
                            onClick={() =>
                              handleAIChat(
                                "¿Qué recursos son los más populares?"
                              )
                            }
                            className="bg-white bg-opacity-20 hover:bg-opacity-30 px-3 py-2 rounded transition-all text-left"
                          >
                            ⭐ Recursos populares
                          </button>
                          <button
                            onClick={() =>
                              handleAIChat("¿Cómo crear un quiz interactivo?")
                            }
                            className="bg-white bg-opacity-20 hover:bg-opacity-30 px-3 py-2 rounded transition-all text-left"
                          >
                            🎯 Crear quizzes
                          </button>
                        </div>
                      </div>
                    ) : (
                      <>
                        {chatMessages.map((msg) => (
                          <div
                            key={msg.id}
                            className={`flex ${msg.role === "user"
                              ? "justify-end"
                              : "justify-start"
                              }`}
                          >
                            <div
                              className={`max-w-[80%] rounded-lg p-3 ${msg.role === "user"
                                ? "bg-white text-purple-900"
                                : "bg-white bg-opacity-20 text-white"
                                }`}
                            >
                              <div className="flex items-start gap-2">
                                {msg.role === "assistant" && (
                                  <Brain className="w-4 h-4 mt-1 flex-shrink-0" />
                                )}
                                <div className="flex-1">
                                  <p className="text-sm whitespace-pre-wrap">
                                    {msg.content}
                                  </p>
                                  <p className="text-xs opacity-70 mt-1">
                                    {msg.timestamp.toLocaleTimeString("es-ES", {
                                      hour: "2-digit",
                                      minute: "2-digit",
                                    })}
                                  </p>
                                </div>
                              </div>
                            </div>
                          </div>
                        ))}
                        {chatLoading && (
                          <div className="flex justify-start">
                            <div className="bg-white bg-opacity-20 rounded-lg p-3">
                              <div className="flex items-center gap-2">
                                <Brain className="w-4 h-4 animate-pulse" />
                                <span className="text-sm">Pensando...</span>
                              </div>
                            </div>
                          </div>
                        )}
                      </>
                    )}
                  </div>

                  {/* Input del chat */}
                  <div className="flex gap-2">
                    <input
                      type="text"
                      value={chatInput}
                      onChange={(e) => setChatInput(e.target.value)}
                      onKeyPress={(e) => {
                        if (e.key === "Enter" && !chatLoading) {
                          handleAIChat(chatInput);
                        }
                      }}
                      placeholder="Escribe tu pregunta..."
                      disabled={chatLoading}
                      className="flex-1 px-4 py-2 rounded-lg bg-white bg-opacity-20 text-white placeholder-white placeholder-opacity-70 border border-white border-opacity-30 focus:outline-none focus:ring-2 focus:ring-white focus:ring-opacity-50 disabled:opacity-50"
                    />
                    <button
                      onClick={() => handleAIChat(chatInput)}
                      disabled={chatLoading || !chatInput.trim()}
                      className="bg-white text-purple-600 px-4 py-2 rounded-lg font-semibold hover:bg-opacity-90 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      Enviar
                    </button>
                    {chatMessages.length > 0 && (
                      <button
                        onClick={clearChat}
                        className="bg-red-500 bg-opacity-50 hover:bg-opacity-70 text-white px-4 py-2 rounded-lg transition-all"
                        title="Limpiar chat"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    )}
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Análisis con Algoritmos */}
        <div className="bg-white rounded-lg shadow-sm border p-6">
          <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <FileText className="w-5 h-5 text-blue-600" />
            🤖 Generador de Análisis con Algoritmos
          </h3>

          {/* SELECTOR + BOTONES */}
          <div className="bg-gradient-to-r from-blue-50 to-purple-50 rounded-lg p-4 border-2 border-blue-200 mb-6">
            <p className="text-sm text-gray-700 mb-4">
              📌 <strong>Selecciona un curso</strong> para análisis específico, o haz clic en <strong>"Todos"</strong> para ver el estado general del sistema
            </p>

            <div className="flex gap-3 items-end flex-wrap">
              <div className="flex-1 min-w-[200px]">
                <label className="block text-sm font-semibold text-gray-800 mb-2">
                  🎯 Seleccionar Curso
                </label>

                {/* DROPDOWN PERSONALIZADO */}
                <div className="relative">
                  <button
                    type="button"
                    onClick={() => setShowCourseDropdown(!showCourseDropdown)}
                    className="w-full px-4 py-3 border-2 border-gray-300 rounded-lg font-medium bg-white cursor-pointer hover:border-blue-400 transition-colors text-left flex items-center justify-between"
                  >
                    <span>
                      {selectedCourseForReport
                        ? courses.find(c => c.id === selectedCourseForReport)?.titulo || "Selecciona un curso"
                        : "-- Selecciona un curso --"
                      }
                    </span>
                    <span className="text-gray-600">▼</span>
                  </button>

                  {/* OPCIONES DROPDOWN */}
                  {showCourseDropdown && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border-2 border-gray-300 rounded-lg shadow-2xl z-50 max-h-64 overflow-y-auto">
                      {/* Opción Limpiar */}
                      <button
                        type="button"
                        onClick={() => {
                          setSelectedCourseForReport(null);
                          setShowCourseDropdown(false);
                        }}
                        className="w-full px-4 py-3 text-left hover:bg-gray-100 border-b border-gray-200 text-gray-800 font-medium transition-colors"
                      >
                        -- Limpiar selección --
                      </button>

                      {/* Opciones de Cursos */}
                      {courses && courses.length > 0 ? (
                        courses.map((course) => (
                          <button
                            type="button"
                            key={course.id}
                            onClick={() => {
                              setSelectedCourseForReport(course.id);
                              setShowCourseDropdown(false);
                            }}
                            className={`w-full px-4 py-3 text-left border-b border-gray-100 transition-colors ${selectedCourseForReport === course.id
                              ? "bg-blue-500 text-white font-semibold hover:bg-blue-600"
                              : "text-gray-800 hover:bg-blue-50"
                              }`}
                          >
                            ✓ {course.titulo}
                          </button>
                        ))
                      ) : (
                        <div className="px-4 py-6 text-center text-gray-500">
                          No hay cursos disponibles
                        </div>
                      )}
                    </div>
                  )}
                </div>
              </div>

              {/* BOTÓN ANALIZAR */}
              <button
                onClick={() => {
                  if (selectedCourseForReport) {
                    generateCourseReport(selectedCourseForReport);
                  } else {
                    generateCourseReport(null);
                  }
                }}
                disabled={isAnalyzingAllCourses}
                className="bg-blue-500 hover:bg-blue-600 disabled:bg-gray-400 disabled:cursor-not-allowed text-white px-6 py-3 rounded-lg text-sm font-semibold transition-colors flex items-center gap-2 whitespace-nowrap shadow-lg"
              >
                {isAnalyzingAllCourses ? (
                  <>
                    <RefreshCw className="w-4 h-4 animate-spin" />
                    Analizando...
                  </>
                ) : (
                  <>
                    <BarChart3 className="w-4 h-4" />
                    {selectedCourseForReport ? "Analizar Curso" : "Ver Sistema"}
                  </>
                )}
              </button>

              {/* BOTÓN LIMPIAR */}
              {selectedCourseForReport && (
                <button
                  onClick={() => setSelectedCourseForReport(null)}
                  className="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-3 rounded-lg text-sm font-semibold transition-colors flex items-center gap-2"
                >
                  <X className="w-4 h-4" />
                  Limpiar
                </button>
              )}
            </div>
          </div>

          {/* GRID DE CURSOS PARA SELECCIONAR RÁPIDO */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {/* ✅ TARJETA ANÁLISIS GENERAL */}
            <div
              onClick={() => {
                setSelectedCourseForReport(null);
                setTimeout(() => generateCourseReport(null), 100);
              }}
              className="rounded-lg p-4 border-2 border-dashed border-purple-300 bg-gradient-to-br from-purple-50 to-purple-100 hover:from-purple-100 hover:to-purple-200 transition-all cursor-pointer group shadow-md"
            >
              <div className="flex items-start justify-between mb-3">
                <div className="flex-1">
                  <h4 className="font-bold text-gray-800 text-sm mb-1 group-hover:text-purple-700">
                    📊 ANÁLISIS GENERAL
                  </h4>
                  <p className="text-xs text-gray-600">
                    {courses.length} cursos • {users.filter(u => u.rol === "estudiante").length} estudiantes
                  </p>
                </div>
                <div className="text-3xl">🎯</div>
              </div>
              <button className="w-full bg-purple-500 hover:bg-purple-600 text-white px-3 py-2 rounded-lg text-xs font-semibold transition-colors group-hover:shadow-lg">
                Ver Estado del Sistema
              </button>
            </div>

            {/* ✅ TARJETAS DE CURSOS INDIVIDUALES */}
            {courses && courses.length > 0 ? (
              courses.slice(0, 6).map((course) => (
                <div
                  key={course.id}
                  onClick={() => {
                    setSelectedCourseForReport(course.id);
                    console.log("📌 Curso clickeado:", course.id, course.titulo);
                  }}
                  className={`rounded-lg p-4 border-2 transition-all cursor-pointer ${selectedCourseForReport === course.id
                    ? "bg-blue-100 border-blue-400 shadow-lg scale-105"
                    : "bg-gradient-to-br from-gray-50 to-gray-100 border-gray-200 hover:border-blue-300 hover:shadow-md"
                    }`}
                >
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex-1">
                      <h4 className="font-semibold text-gray-800 text-sm mb-1">
                        {course.titulo}
                      </h4>
                      <p className="text-xs text-gray-600">{course.nivel_nombre || "Sin nivel"}</p>
                    </div>
                    <div
                      className="w-10 h-10 rounded-lg flex items-center justify-center flex-shrink-0"
                      style={{ backgroundColor: `${course.color}20` }}
                    >
                      <BookOpen
                        className="w-5 h-5"
                        style={{ color: course.color }}
                      />
                    </div>
                  </div>
                  {selectedCourseForReport === course.id && (
                    <div className="text-xs font-bold text-blue-600 bg-blue-50 px-2 py-1 rounded text-center">
                      ✓ SELECCIONADO
                    </div>
                  )}
                </div>
              ))
            ) : (
              <div className="col-span-full text-center py-8 bg-gray-50 rounded-lg border-2 border-dashed border-gray-300">
                <BookOpen className="w-12 h-12 text-gray-400 mx-auto mb-2" />
                <p className="text-gray-500">No hay cursos disponibles</p>
              </div>
            )}
          </div>
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
    if (loadingAI) {
      return (
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl p-12 text-center">
            <RefreshCw className="w-12 h-12 text-purple-600 animate-spin mx-auto mb-3" />
            <p className="text-gray-600 font-semibold">Generando análisis con IA...</p>
          </div>
        </div>
      );
    }

    if (!aiMetrics) {
      return (
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl p-8 text-center max-w-md">
            <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-3" />
            <p className="text-gray-700 font-semibold">No hay datos disponibles</p>
            <button
              onClick={() => setShowDetailedAnalytics(false)}
              className="mt-4 bg-blue-500 text-white px-4 py-2 rounded-lg"
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
      <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4 overflow-y-auto">
        <div className="bg-gradient-to-br from-gray-50 to-blue-50 rounded-2xl max-w-7xl w-full max-h-[90vh] overflow-y-auto shadow-2xl my-8">

          {/* HEADER */}
          <div className="sticky top-0 bg-gradient-to-r from-blue-600 via-purple-600 to-pink-600 text-white p-8 z-10 rounded-t-2xl">
            <div className="flex items-center justify-between">
              <div>
                <h1 className="text-3xl font-black mb-1 flex items-center gap-3">
                  📊 Panel de Análisis Avanzado
                  <span className="text-lg bg-white bg-opacity-20 px-3 py-1 rounded-full">
                    {aiMetrics.timestamp.toLocaleDateString('es-ES')}
                  </span>
                </h1>
                <p className="text-purple-100">
                  Métricas en tiempo real con visualizaciones interactivas
                </p>
              </div>
              <button
                onClick={() => setShowDetailedAnalytics(false)}
                className="bg-white bg-opacity-20 hover:bg-opacity-30 p-2 rounded-lg transition-all"
              >
                <X className="w-6 h-6" />
              </button>
            </div>
          </div>

          <div className="p-8 space-y-8">

            {/* SALUD DEL SISTEMA - Grande y destacado */}
            <section className="bg-gradient-to-r from-blue-500 to-purple-600 rounded-2xl p-8 text-white shadow-xl">
              <div className="flex items-center justify-between">
                <div className="flex-1">
                  <p className="text-sm font-bold text-blue-100 uppercase tracking-wide mb-2">
                    Estado General del Sistema
                  </p>
                  <div className="flex items-end gap-4">
                    <h2 className="text-6xl font-black">
                      {aiMetrics.systemHealth?.score || 0}<span className="text-3xl">%</span>
                    </h2>
                    <div className="mb-2">
                      <p className="text-2xl font-bold">
                        {aiMetrics.systemHealth?.status === 'healthy'
                          ? '✅ Excelente'
                          : aiMetrics.systemHealth?.status === 'warning'
                            ? '⚠️ Advertencia'
                            : '🚨 Crítico'}
                      </p>
                      <p className="text-sm text-blue-100">Salud del sistema</p>
                    </div>
                  </div>
                </div>

                {/* Medidor circular */}
                <div className="relative w-40 h-40">
                  <svg className="w-full h-full transform -rotate-90">
                    <circle
                      cx="80"
                      cy="80"
                      r="70"
                      fill="none"
                      stroke="rgba(255,255,255,0.2)"
                      strokeWidth="12"
                    />
                    <circle
                      cx="80"
                      cy="80"
                      r="70"
                      fill="none"
                      stroke="white"
                      strokeWidth="12"
                      strokeDasharray={`${(aiMetrics.systemHealth?.score || 0) * 4.4} 440`}
                      strokeLinecap="round"
                      className="transition-all duration-1000"
                    />
                  </svg>
                  <div className="absolute inset-0 flex items-center justify-center">
                    <span className="text-4xl">
                      {aiMetrics.systemHealth?.score >= 70 ? '😊' :
                        aiMetrics.systemHealth?.score >= 50 ? '😐' : '😟'}
                    </span>
                  </div>
                </div>
              </div>
            </section>

            {/* GRÁFICAS PRINCIPALES */}
            <section>
              <h2 className="text-2xl font-bold text-gray-800 mb-6 flex items-center gap-3">
                <div className="w-1 h-8 bg-gradient-to-b from-blue-600 to-purple-600 rounded-full"></div>
                Análisis Visual de Datos
              </h2>
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                {/* Gráfica de Dona - Distribución de Estudiantes */}
                <ExcelDonutChart
                  title="👥 Distribución de Estudiantes"
                  data={studentDistributionData}
                  colors={['#10b981', '#ef4444']}
                />

                {/* Gráfica de Columnas - Performance */}
                <ExcelColumnChart
                  title="📊 Métricas de Rendimiento"
                  data={performanceData}
                  colors={['#3b82f6', '#8b5cf6', '#ec4899']}
                />
              </div>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {/* Gráfica de Barras - Contenido */}
                <ExcelHorizontalBarChart
                  title="📚 Distribución de Contenido"
                  data={contentDistributionData}
                  colors={['#f59e0b', '#10b981', '#6366f1']}
                />

                {/* Gráfica de Línea - Tendencia */}
                <ExcelLineChart
                  title="📈 Tendencia de Engagement"
                  data={timeSeriesData}
                  color="#8b5cf6"
                />
              </div>
            </section>

            {/* MÉTRICAS DETALLADAS EN TARJETAS */}
            <section>
              <h2 className="text-2xl font-bold text-gray-800 mb-6 flex items-center gap-3">
                <div className="w-1 h-8 bg-gradient-to-b from-green-600 to-blue-600 rounded-full"></div>
                Métricas Detalladas
              </h2>

              <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {[
                  {
                    label: 'Total Estudiantes',
                    value: aiMetrics.students?.total,
                    icon: '👥',
                    color: 'from-blue-500 to-blue-600',
                    detail: `${aiMetrics.students?.active} activos`
                  },
                  {
                    label: 'Engagement',
                    value: `${aiMetrics.engagement?.rate}%`,
                    icon: '🎯',
                    color: 'from-green-500 to-green-600',
                    detail: `${aiMetrics.engagement?.activeCount} esta semana`
                  },
                  {
                    label: 'Progreso Avg',
                    value: `${aiMetrics.progress?.average}%`,
                    icon: '📈',
                    color: 'from-purple-500 to-purple-600',
                    detail: 'Promedio general'
                  },
                  {
                    label: 'Completitud',
                    value: `${aiMetrics.progress?.completionRate}%`,
                    icon: '✅',
                    color: 'from-orange-500 to-orange-600',
                    detail: 'Actividades finalizadas'
                  },
                  {
                    label: 'Cursos',
                    value: aiMetrics.content?.courses,
                    icon: '📚',
                    color: 'from-pink-500 to-pink-600',
                    detail: 'Cursos activos'
                  },
                  {
                    label: 'Recursos',
                    value: aiMetrics.content?.resources,
                    icon: '📝',
                    color: 'from-indigo-500 to-indigo-600',
                    detail: 'Material disponible'
                  },
                  {
                    label: 'Logros',
                    value: aiMetrics.content?.achievements,
                    icon: '🏆',
                    color: 'from-yellow-500 to-yellow-600',
                    detail: 'Logros desbloqueables'
                  },
                  {
                    label: 'Tiempo Total',
                    value: `${aiMetrics.progress?.totalTimeSpent}m`,
                    icon: '⏱️',
                    color: 'from-red-500 to-red-600',
                    detail: 'Tiempo dedicado'
                  },
                ].map((stat, idx) => (
                  <div
                    key={idx}
                    className={`bg-gradient-to-br ${stat.color} rounded-xl p-5 text-white shadow-lg hover:shadow-xl transition-all transform hover:scale-105`}
                  >
                    <div className="text-3xl mb-2">{stat.icon}</div>
                    <p className="text-xs font-semibold text-white text-opacity-90 uppercase">
                      {stat.label}
                    </p>
                    <p className="text-3xl font-black mt-1">{stat.value}</p>
                    <p className="text-xs text-white text-opacity-75 mt-1">{stat.detail}</p>
                  </div>
                ))}
              </div>
            </section>

            {/* INSIGHTS */}
            <section>
              <h2 className="text-2xl font-bold text-gray-800 mb-4 flex items-center gap-3">
                <div className="w-1 h-8 bg-gradient-to-b from-yellow-600 to-orange-600 rounded-full"></div>
                💡 Insights Generados por IA
              </h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {aiInsights?.map((insight, idx) => (
                  <div
                    key={idx}
                    className="bg-gradient-to-r from-blue-50 to-purple-50 border-2 border-blue-200 rounded-xl p-4 hover:shadow-md transition-all"
                  >
                    <p className="text-sm text-gray-800 font-medium flex items-start gap-2">
                      <span className="text-blue-600 font-bold">•</span>
                      {insight}
                    </p>
                  </div>
                ))}
              </div>
            </section>

            {/* RECOMENDACIONES */}
            <section>
              <h2 className="text-2xl font-bold text-gray-800 mb-4 flex items-center gap-3">
                <div className="w-1 h-8 bg-gradient-to-b from-red-600 to-pink-600 rounded-full"></div>
                🎯 Recomendaciones de Acción
              </h2>
              <div className="space-y-3">
                {aiRecommendations?.map((rec, idx) => {
                  const priorityColors = {
                    high: 'from-red-50 to-red-100 border-red-300',
                    medium: 'from-yellow-50 to-yellow-100 border-yellow-300',
                    low: 'from-green-50 to-green-100 border-green-300',
                  };

                  const priorityIcons = {
                    high: '🔴',
                    medium: '🟡',
                    low: '🟢',
                  };

                  return (
                    <div
                      key={idx}
                      className={`bg-gradient-to-r ${priorityColors[rec.priority]} border-2 rounded-xl p-5 hover:shadow-lg transition-all`}
                    >
                      <div className="flex items-start gap-4">
                        <span className="text-3xl">{priorityIcons[rec.priority]}</span>
                        <div className="flex-1">
                          <h3 className="font-bold text-gray-800 text-lg mb-1">{rec.title}</h3>
                          <p className="text-sm text-gray-700">{rec.description}</p>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </section>
          </div>

          {/* FOOTER */}
          <div className="sticky bottom-0 bg-white border-t-2 border-gray-200 p-6 flex gap-4 justify-end rounded-b-2xl">
            <button
              onClick={() => setShowDetailedAnalytics(false)}
              className="px-6 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg font-semibold transition-all"
            >
              Cerrar
            </button>
            <button
              onClick={generateAIAnalyticsImproved}
              className="px-6 py-3 bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white rounded-lg font-semibold transition-all flex items-center gap-2"
            >
              <RefreshCw className="w-5 h-5" />
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
                <div className="absolute right-0 mt-2 w-64 bg-white shadow-lg rounded-lg border py-2 z-10">
                  <div className="px-4 py-2 border-b">
                    <p className="text-sm font-medium text-gray-900">
                      {currentUser?.nombre}
                    </p>
                    <p className="text-xs text-gray-500">
                      {currentUser?.email}
                    </p>
                    <div className="flex flex-wrap gap-1 mt-2">
                      <span
                        className={`px-2 py-1 text-xs font-medium rounded-full border ${getRoleBadgeColor(
                          currentUser?.rol
                        )}`}
                      >
                        {currentUser?.rol}
                      </span>
                      {currentUser?.roles_adicionales?.map((rol, idx) => (
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
                  </div>

                  {/* SELECTOR DE PERFILES MEJORADO */}

                  {currentUser?.roles_adicionales &&
                    currentUser.roles_adicionales.length > 0 && (
                      <div className="px-4 py-2 border-b">
                        <p className="text-xs font-semibold text-gray-500 uppercase mb-2">
                          🔄 Cambiar Perfil
                        </p>
                        <div className="space-y-1">
                          {[currentUser.rol, ...currentUser.roles_adicionales]
                            .filter(
                              (rol, index, self) => self.indexOf(rol) === index
                            )
                            .map((rol) => {
                              const roleInfo = availableRoles.find(
                                (r) => r.value === rol
                              );
                              const isActive = rol === currentUser.rol;
                              return (
                                <button
                                  key={rol}
                                  onClick={() => {
                                    if (isActive) {
                                      setMenuOpen(false);
                                      alert("✅ Ya usas este perfil");
                                      return;
                                    }
                                    handleRoleSwitch(rol);
                                  }}
                                  className={`w-full text-left px-3 py-2 text-sm rounded transition-all flex items-center justify-between gap-2 ${isActive
                                    ? "bg-blue-50 border-2 border-blue-300 font-semibold text-blue-700"
                                    : "border border-gray-200 hover:bg-gray-50"
                                    }`}
                                >
                                  <div className="flex items-center gap-2">
                                    <div
                                      className={`w-2 h-2 rounded-full ${roleInfo?.color === "red"
                                        ? "bg-red-500"
                                        : roleInfo?.color === "blue"
                                          ? "bg-blue-500"
                                          : roleInfo?.color === "green"
                                            ? "bg-green-500"
                                            : "bg-gray-500"
                                        }`}
                                    />
                                    <span className="capitalize">
                                      {roleInfo?.label || rol}
                                    </span>
                                  </div>
                                  {isActive && (
                                    <span className="text-xs font-bold">
                                      ● ACTIVO
                                    </span>
                                  )}
                                </button>
                              );
                            })}
                        </div>
                      </div>
                    )}
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
                Gestión de Usuarios
              </h2>
              <div className="flex gap-3">
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
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Rol
                  </label>
                  <select
                    value={filterRole}
                    onChange={(e) => setFilterRole(e.target.value)}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">Todos los roles</option>
                    {availableRoles.map((role) => (
                      <option key={role.value} value={role.value}>
                        {role.label}
                      </option>
                    ))}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Grupo
                  </label>
                  <select
                    value={filterGroup}
                    onChange={(e) => setFilterGroup(e.target.value)}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">Todos los grupos</option>
                    {groups.map((group) => (
                      <option key={group.id} value={group.id}>
                        {group.nombre}
                      </option>
                    ))}
                    <option value="sin_grupo">Sin grupo</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Estado
                  </label>
                  <select
                    value={filterStatus}
                    onChange={(e) => setFilterStatus(e.target.value)}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">Todos</option>
                    <option value="active">Activos</option>
                    <option value="inactive">Inactivos</option>
                  </select>
                </div>
              </div>
              {(filterRole || filterGroup || filterStatus) && (
                <button
                  onClick={() => {
                    setFilterRole("");
                    setFilterGroup("");
                    setFilterStatus("");
                  }}
                  className="mt-3 text-sm text-blue-600 hover:text-blue-800 font-medium"
                >
                  Limpiar filtros
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
                              const status = getUserStatus(user.ultimo_acceso);
                              return (
                                <div className="flex items-center gap-2">
                                  <div
                                    className={`w-3 h-3 rounded-full ${status.color === "green"
                                      ? "bg-green-500 animate-pulse shadow-lg shadow-green-300"
                                      : status.color === "blue"
                                        ? "bg-blue-500"
                                        : status.color === "gray"
                                          ? "bg-gray-400"
                                          : "bg-red-500"
                                      }`}
                                  />
                                  <span
                                    className={`text-xs font-medium ${status.color === "green"
                                      ? "text-green-800"
                                      : status.color === "blue"
                                        ? "text-blue-800"
                                        : status.color === "gray"
                                          ? "text-gray-600"
                                          : "text-red-800"
                                      }`}
                                  >
                                    {status.label}
                                  </span>
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
                        <button
                          onClick={() => generateCourseReport(course.id)}
                          className="flex-1 bg-blue-50 hover:bg-blue-100 text-blue-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-1"
                        >
                          <Download className="w-3 h-3" />
                          Reporte
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
                Gestión de Logros
              </h2>
              <button
                onClick={() => alert("Función para crear logros próximamente")}
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
                        {achievement.icono || "🏆"}
                      </div>
                      <button
                        onClick={() => alert("Función para eliminar logro")}
                        className="text-red-600 hover:text-red-800 p-1"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                    <h3 className="font-semibold text-gray-800 mb-2">
                      {achievement.nombre}
                    </h3>
                    <p className="text-sm text-gray-600 mb-3">
                      {achievement.descripcion}
                    </p>
                    <div className="flex items-center justify-between text-xs text-gray-500">
                      <span>{achievement.puntos_requeridos} puntos</span>
                      <span
                        className={`px-2 py-1 rounded-full ${achievement.activo
                          ? "bg-green-100 text-green-800"
                          : "bg-gray-100 text-gray-800"
                          }`}
                      >
                        {achievement.activo ? "Activo" : "Inactivo"}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* MODAL DE REPORTE CON FILTROS FUNCIONALES */}
        {showCourseReportModal && courseReportData && (
          <div className="fixed inset-0 bg-black bg-opacity-60 z-50 flex items-center justify-center p-4 overflow-y-auto">
            <div className="bg-white rounded-3xl max-w-5xl w-full shadow-2xl my-8 overflow-hidden">
              {/* HEADER CON FILTROS */}
              <div className="sticky top-0 z-10 bg-gradient-to-r from-blue-600 via-blue-700 to-purple-700 text-white p-8">
                <div className="flex justify-between items-start mb-6">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-2">
                      <BarChart3 className="w-8 h-8" />
                      <div>
                        <h2 className="text-3xl font-bold mb-1"> 🤖 Análisis con Algoritmos {courseReportData?.stats?.totalStudents && (<span className="text-lg text-blue-100 ml-3"> ({courseReportData.stats.totalStudents} estudiantes) </span>)} </h2> <p className="text-sm text-blue-100"> LEA (Learning Effectiveness) | ADA (Attention Detection) | AFS (Adaptive Feedback) </p>
                      </div>
                    </div>
                  </div>
                  <button
                    onClick={() => setShowCourseReportModal(false)}
                    className="p-2 hover:bg-white hover:bg-opacity-20 rounded-lg transition-colors"
                  >
                    <X className="w-6 h-6" />
                  </button>
                </div>

                <div className="grid grid-cols-1 gap-4 pt-6 border-t border-white border-opacity-20">
                  <div className="bg-white bg-opacity-10 rounded-lg p-3 border border-white border-opacity-20">
                    <div className="grid grid-cols-3 gap-4">
                      <div>
                        {" "}
                        <p className="text-xs font-semibold text-blue-100">
                          CURSO ANALIZADO
                        </p>
                        <p className="text-lg font-bold">
                          {courseReportData.course.titulo}
                        </p>
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-blue-100">
                          FECHA DEL REPORTE
                        </p>
                        <p className="text-lg font-bold">
                          {courseReportData.course.fecha}
                        </p>
                      </div>
                      <div>
                        <p className="text-xs font-semibold text-blue-100">
                          TOTAL ESTUDIANTES
                        </p>
                        <p className="text-lg font-bold">
                          {courseReportData.stats.totalStudents}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* FILTROS */}
                <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-3">
                  <div>
                    <label className="block text-xs font-semibold text-blue-100 mb-2">
                      🏫 FILTRAR POR GRUPO
                    </label>
                    <select
                      value={filterByGroup}
                      onChange={(e) => setFilterByGroup(e.target.value)}
                      className="w-full px-3 py-2 bg-white bg-opacity-20 text-white rounded-lg text-sm border border-white border-opacity-30 focus:outline-none focus:ring-2 focus:ring-white"
                    >
                      <option value="" className="text-gray-800">
                        Todos los grupos
                      </option>
                      {[
                        ...new Set(
                          courseReportData.students.map((d) => d.grupo)
                        ),
                      ].map((grupo) => (
                        <option
                          key={grupo}
                          value={grupo}
                          className="text-gray-800"
                        >
                          {grupo}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label className="block text-xs font-semibold text-blue-100 mb-2">
                      📊 FILTRAR POR ESTADO
                    </label>
                    <select
                      value={filterByStatus}
                      onChange={(e) => setFilterByStatus(e.target.value)}
                      className="w-full px-3 py-2 bg-white bg-opacity-20 text-white rounded-lg text-sm border border-white border-opacity-30 focus:outline-none focus:ring-2 focus:ring-white"
                    >
                      <option value="" className="text-gray-800">
                        Todos los estados
                      </option>
                      <option value="excellent" className="text-gray-800">
                        ✅ Excelente
                      </option>
                      <option value="warning" className="text-gray-800">
                        ⚠️ Necesita apoyo
                      </option>
                      <option value="critical" className="text-gray-800">
                        🚨 Crítico
                      </option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-xs font-semibold text-blue-100 mb-2">
                      🔍 BUSCAR ESTUDIANTE
                    </label>
                    <input
                      type="text"
                      value={searchStudent}
                      onChange={(e) => setSearchStudent(e.target.value)}
                      placeholder="Escribe un nombre..."
                      className="w-full px-3 py-2 bg-white bg-opacity-20 text-white rounded-lg text-sm border border-white border-opacity-30 focus:outline-none focus:ring-2 focus:ring-white placeholder-white placeholder-opacity-60"
                    />
                  </div>

                  <div className="flex items-end gap-2">
                    <div className="flex-1">
                      <p className="text-xs font-semibold text-blue-100 mb-2">
                        📈 RESULTADOS
                      </p>
                      <div className="grid grid-cols-2 gap-2 text-sm">
                        <div className="bg-white bg-opacity-10 rounded px-2 py-1 text-center">
                          <p className="font-bold text-lg">
                            {
                              courseReportData.students.filter((data) => {
                                if (
                                  filterByGroup &&
                                  data.grupo !== filterByGroup
                                )
                                  return false;
                                if (
                                  filterByStatus === "excellent" &&
                                  !data.feedback.overallStatus.includes("✅")
                                )
                                  return false;
                                if (
                                  filterByStatus === "warning" &&
                                  !data.feedback.overallStatus.includes("⚠️")
                                )
                                  return false;
                                if (
                                  filterByStatus === "critical" &&
                                  !data.feedback.overallStatus.includes("🚨")
                                )
                                  return false;
                                if (
                                  searchStudent &&
                                  !data.student.nombre
                                    .toLowerCase()
                                    .includes(searchStudent.toLowerCase())
                                )
                                  return false;
                                return true;
                              }).length
                            }
                          </p>
                          <p className="text-xs opacity-90">Estudiantes</p>
                        </div>
                        <div className="bg-white bg-opacity-10 rounded px-2 py-1 text-center">
                          <p className="font-bold text-lg">
                            {
                              courseReportData.students
                                .filter((data) => {
                                  if (
                                    filterByGroup &&
                                    data.grupo !== filterByGroup
                                  )
                                    return false;
                                  if (
                                    filterByStatus === "excellent" &&
                                    !data.feedback.overallStatus.includes("✅")
                                  )
                                    return false;
                                  if (
                                    filterByStatus === "warning" &&
                                    !data.feedback.overallStatus.includes("⚠️")
                                  )
                                    return false;
                                  if (
                                    filterByStatus === "critical" &&
                                    !data.feedback.overallStatus.includes("🚨")
                                  )
                                    return false;
                                  if (
                                    searchStudent &&
                                    !data.student.nombre
                                      .toLowerCase()
                                      .includes(searchStudent.toLowerCase())
                                  )
                                    return false;
                                  return true;
                                })
                                .filter(
                                  (d) => d.feedback.attentionLevel?.score >= 70
                                ).length
                            }
                          </p>
                          <p className="text-xs opacity-90">
                            Con buena atención
                          </p>
                        </div>
                      </div>
                    </div>
                    {(filterByGroup || filterByStatus || searchStudent) && (
                      <button
                        onClick={() => {
                          setFilterByGroup("");
                          setFilterByStatus("");
                          setSearchStudent("");
                          setExpandedStudent(null);
                        }}
                        className="bg-red-500 hover:bg-red-600 text-white px-3 py-2 rounded-lg text-sm font-semibold transition-colors flex items-center gap-1 h-fit whitespace-nowrap"
                      >
                        <X className="w-3 h-3" />
                        Limpiar
                      </button>
                    )}
                  </div>
                </div>
              </div>

              {/* CONTENIDO SCROLLEABLE */}
              <div className="overflow-y-auto max-h-[calc(90vh-300px)] p-8 space-y-4">
                {/* ESTADÍSTICAS GENERALES */}
                <section className="mb-6">
                  <h3 className="text-2xl font-bold text-gray-800 mb-4 flex items-center gap-3">
                    <div className="w-1 h-8 bg-gradient-to-b from-blue-600 to-purple-600"></div>
                    Estadísticas Generales
                  </h3>

                  <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                    {[
                      {
                        label: "Total Estudiantes",
                        value: courseReportData.stats.totalStudents,
                        icon: "👥",
                        color: "from-blue-500 to-blue-600",
                      },
                      {
                        label: "Progreso Promedio",
                        value: `${courseReportData.stats.avgProgress}%`,
                        icon: "📈",
                        color: "from-green-500 to-green-600",
                      },
                      {
                        label: "Recursos Completados",
                        value: courseReportData.stats.completedResources,
                        icon: "✅",
                        color: "from-purple-500 to-purple-600",
                      },
                      {
                        label: "Tiempo Total",
                        value: `${courseReportData.stats.totalTime}m`,
                        icon: "⏱️",
                        color: "from-orange-500 to-orange-600",
                      },
                    ].map((stat, idx) => (
                      <div
                        key={idx}
                        className={`bg-gradient-to-br ${stat.color} rounded-xl p-5 text-white shadow-lg`}
                      >
                        <div className="flex items-start justify-between mb-3">
                          <div className="text-3xl">{stat.icon}</div>
                        </div>
                        <p className="text-xs font-semibold text-white text-opacity-90">
                          {stat.label}
                        </p>
                        <p className="text-2xl font-bold mt-2">{stat.value}</p>
                      </div>
                    ))}
                  </div>
                </section>

                {/* ANÁLISIS POR ESTUDIANTE (CON FILTROS APLICADOS) */}
                <section>
                  <h3 className="text-2xl font-bold text-gray-800 mb-4 flex items-center gap-3">
                    <div className="w-1 h-8 bg-gradient-to-b from-blue-600 to-purple-600"></div>
                    Análisis de Estudiantes
                  </h3>

                  {(() => {
                    const filteredStudents = courseReportData.students.filter(
                      (data) => {
                        if (filterByGroup && data.grupo !== filterByGroup)
                          return false;
                        if (
                          filterByStatus === "excellent" &&
                          !data.feedback.overallStatus.includes("✅")
                        )
                          return false;
                        if (
                          filterByStatus === "warning" &&
                          !data.feedback.overallStatus.includes("⚠️")
                        )
                          return false;
                        if (
                          filterByStatus === "critical" &&
                          !data.feedback.overallStatus.includes("🚨")
                        )
                          return false;
                        if (
                          searchStudent &&
                          !data.student.nombre
                            .toLowerCase()
                            .includes(searchStudent.toLowerCase())
                        )
                          return false;
                        return true;
                      }
                    );

                    return filteredStudents.length === 0 ? (
                      <div className="text-center py-12 bg-gray-50 rounded-xl border-2 border-dashed border-gray-300">
                        <p className="text-gray-500 text-lg">
                          No hay estudiantes que coincidan con los filtros
                        </p>
                      </div>
                    ) : (
                      <div className="space-y-4">
                        {filteredStudents.map((data, idx) => {
                          const { student, feedback, grupo } = data;
                          const isExpanded = expandedStudent === idx;

                          return (
                            <div
                              key={idx}
                              className="bg-gray-50 rounded-2xl overflow-hidden shadow-md border border-gray-200 hover:shadow-lg transition-shadow"
                            >
                              {/* HEADER COMPACTO */}
                              <button
                                onClick={() =>
                                  setExpandedStudent(isExpanded ? null : idx)
                                }
                                className="w-full bg-gradient-to-r from-slate-700 to-slate-800 text-white p-6 hover:from-slate-600 hover:to-slate-700 transition-colors"
                              >
                                <div className="flex items-center justify-between">
                                  <div className="flex items-center gap-4 flex-1 text-left">
                                    <div className="w-12 h-12 bg-white bg-opacity-20 rounded-full flex items-center justify-center text-xl font-bold">
                                      {student.nombre?.charAt(0).toUpperCase()}
                                    </div>
                                    <div className="flex-1">
                                      <h4 className="text-lg font-bold">
                                        {student.nombre}
                                      </h4>
                                      <p className="text-sm text-slate-300">
                                        {grupo}
                                      </p>
                                    </div>
                                  </div>

                                  <div className="flex items-center gap-3">
                                    <div className="text-right">
                                      <p className="text-xs text-slate-300">
                                        Estado
                                      </p>
                                      <p className="text-sm font-bold">
                                        {feedback.overallStatus}
                                      </p>
                                    </div>
                                    <ChevronDown
                                      className={`w-5 h-5 transition-transform ${isExpanded ? "rotate-180" : ""
                                        }`}
                                    />
                                  </div>
                                </div>
                              </button>

                              {/* DETALLES EXPANDIDOS */}
                              {isExpanded && (
                                <div className="p-6 space-y-6 bg-white">
                                  {/* CUADROS DE ALGORITMOS */}
                                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    {/* LEA */}
                                    <div className="bg-blue-50 rounded-xl p-4 border-2 border-blue-300">
                                      <div className="flex items-center justify-between mb-3">
                                        <div>
                                          <p className="text-xs font-bold text-blue-700 uppercase">
                                            LEA
                                          </p>
                                          <p className="text-xs text-blue-600">
                                            Aprendizaje Real
                                          </p>
                                        </div>
                                        <span className="text-2xl">
                                          {feedback.learningEffectiveness
                                            ?.isLearning
                                            ? "✅"
                                            : "❌"}
                                        </span>
                                      </div>

                                      <div className="space-y-2">
                                        <div>
                                          <div className="flex justify-between mb-1">
                                            <span className="text-xs font-semibold text-gray-700">
                                              Confianza
                                            </span>
                                            <span className="text-xs font-bold text-blue-600">
                                              {feedback.learningEffectiveness?.confidence?.toFixed(
                                                0
                                              )}
                                              %
                                            </span>
                                          </div>
                                          <div className="w-full bg-blue-200 rounded-full h-2">
                                            <div
                                              className="bg-blue-600 h-2 rounded-full"
                                              style={{
                                                width: `${feedback.learningEffectiveness
                                                  ?.confidence || 0
                                                  }%`,
                                              }}
                                            ></div>
                                          </div>
                                        </div>

                                        <div className="bg-white rounded-lg p-2 space-y-1 text-xs">
                                          <div className="flex justify-between">
                                            <span className="text-gray-600">
                                              Intentos:
                                            </span>
                                            <span className="font-bold">
                                              {feedback.learningEffectiveness?.indicators?.averageAttempts?.toFixed(
                                                1
                                              )}
                                            </span>
                                          </div>
                                          <div className="flex justify-between">
                                            <span className="text-gray-600">
                                              Tiempo:
                                            </span>
                                            <span className="font-bold">
                                              {feedback.learningEffectiveness?.indicators?.averageTimePerQuestion?.toFixed(
                                                0
                                              )}
                                              s
                                            </span>
                                          </div>
                                          <div className="flex justify-between">
                                            <span className="text-gray-600">
                                              Retención:
                                            </span>
                                            <span className="font-bold">
                                              {feedback.learningEffectiveness?.indicators?.retentionRate?.toFixed(
                                                1
                                              )}
                                              %
                                            </span>
                                          </div>
                                        </div>
                                      </div>
                                    </div>

                                    {/* ADA */}
                                    <div className="bg-purple-50 rounded-xl p-4 border-2 border-purple-300">
                                      <div className="flex items-center justify-between mb-3">
                                        <div>
                                          <p className="text-xs font-bold text-purple-700 uppercase">
                                            ADA
                                          </p>
                                          <p className="text-xs text-purple-600">
                                            Atención
                                          </p>
                                        </div>
                                        <span className="text-2xl">👁️</span>
                                      </div>

                                      <div className="space-y-2">
                                        <div>
                                          <div className="flex justify-between mb-1">
                                            <span className="text-xs font-semibold text-gray-700">
                                              Puntuación
                                            </span>
                                            <span className="text-xs font-bold text-purple-600">
                                              {feedback.attentionLevel?.score ||
                                                0}
                                              /100
                                            </span>
                                          </div>
                                          <div className="w-full bg-purple-200 rounded-full h-2">
                                            <div
                                              className={`h-2 rounded-full ${feedback.attentionLevel
                                                ?.score >= 70
                                                ? "bg-green-500"
                                                : feedback.attentionLevel
                                                  ?.score >= 50
                                                  ? "bg-yellow-500"
                                                  : "bg-red-500"
                                                }`}
                                              style={{
                                                width: `${feedback.attentionLevel
                                                  ?.score || 0
                                                  }%`,
                                              }}
                                            ></div>
                                          </div>
                                        </div>

                                        <div
                                          className={`text-center py-2 rounded text-xs font-bold ${feedback.attentionLevel?.score >= 70
                                            ? "bg-green-200 text-green-800"
                                            : feedback.attentionLevel
                                              ?.score >= 50
                                              ? "bg-yellow-200 text-yellow-800"
                                              : "bg-red-200 text-red-800"
                                            }`}
                                        >
                                          {feedback.attentionLevel?.level}
                                        </div>

                                        <div className="bg-white rounded-lg p-2 space-y-1 text-xs">
                                          <div className="flex justify-between">
                                            <span className="text-gray-600">
                                              Inactividad:
                                            </span>
                                            <span className="font-bold">
                                              {
                                                feedback.attentionLevel
                                                  ?.indicators
                                                  ?.inactivityPeriods
                                              }
                                            </span>
                                          </div>
                                          <div className="flex justify-between">
                                            <span className="text-gray-600">
                                              Foco:
                                            </span>
                                            <span className="font-bold">
                                              {feedback.attentionLevel?.indicators?.focusIndex?.toFixed(
                                                1
                                              )}
                                              %
                                            </span>
                                          </div>
                                        </div>
                                      </div>
                                    </div>

                                    {/* AFS */}
                                    <div className="bg-green-50 rounded-xl p-4 border-2 border-green-300">
                                      <div className="flex items-center justify-between mb-3">
                                        <div>
                                          <p className="text-xs font-bold text-green-700 uppercase">
                                            AFS
                                          </p>
                                          <p className="text-xs text-green-600">
                                            Retroalimentación
                                          </p>
                                        </div>
                                        <span className="text-2xl">🎯</span>
                                      </div>

                                      <div className="bg-white rounded-lg p-2 space-y-1 text-xs">
                                        {feedback.strengths?.length > 0 && (
                                          <div>
                                            <p className="font-bold text-green-700">
                                              ✓ {feedback.strengths.length}{" "}
                                              Fortalezas
                                            </p>
                                          </div>
                                        )}

                                        {feedback.weaknesses?.length > 0 && (
                                          <div className="border-t pt-1">
                                            <p className="font-bold text-red-700">
                                              ✗ {feedback.weaknesses.length}{" "}
                                              Debilidades
                                            </p>
                                          </div>
                                        )}

                                        {feedback.actionPlan?.length > 0 && (
                                          <div className="border-t pt-1">
                                            <p className="font-bold text-blue-700">
                                              📋 {feedback.actionPlan.length}{" "}
                                              Acciones
                                            </p>
                                          </div>
                                        )}
                                      </div>
                                    </div>
                                  </div>

                                  {/* FORTALEZAS Y DEBILIDADES */}
                                  <div className="grid grid-cols-2 gap-3">
                                    <div className="bg-green-50 rounded-xl p-4 border-2 border-green-300">
                                      <h5 className="font-bold text-green-800 mb-2 text-sm">
                                        💪 Fortalezas
                                      </h5>
                                      <div className="space-y-1">
                                        {feedback.strengths?.map((s, i) => (
                                          <p
                                            key={i}
                                            className="text-xs text-gray-700"
                                          >
                                            ✓ {s}
                                          </p>
                                        ))}
                                      </div>
                                    </div>

                                    <div className="bg-red-50 rounded-xl p-4 border-2 border-red-300">
                                      <h5 className="font-bold text-red-800 mb-2 text-sm">
                                        🎯 Mejora
                                      </h5>
                                      <div className="space-y-1">
                                        {feedback.weaknesses?.map((w, i) => (
                                          <p
                                            key={i}
                                            className="text-xs text-gray-700"
                                          >
                                            ✗ {w}
                                          </p>
                                        ))}
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    );
                  })()}
                </section>
              </div>

              {/* FOOTER */}
              <div className="sticky bottom-0 bg-white border-t border-gray-200 p-6 flex gap-4 justify-end">
                <button
                  onClick={() => {
                    setShowCourseReportModal(false);
                    setFilterByGroup("");
                    setFilterByStatus("");
                    setSearchStudent("");
                    setFilterByCourse("");
                    setExpandedStudent(null);
                  }}
                  className="px-6 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg font-semibold transition-colors flex items-center gap-2"
                >
                  <X className="w-5 h-5" />
                  Cerrar
                </button>
                <button
                  onClick={handlePrintReport}
                  className="px-6 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-lg font-semibold transition-colors flex items-center gap-2"
                >
                  <Printer className="w-5 h-5" />
                  Imprimir
                </button>
                <button
                  onClick={handleDownloadReport}
                  className="px-6 py-3 bg-green-500 hover:bg-green-600 text-white rounded-lg font-semibold transition-colors flex items-center gap-2"
                >
                  <Download className="w-5 h-5" />
                  Descargar
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

              {/* Opciones de respuesta */}
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
                              setCurrentQuestion({
                                ...currentQuestion,
                                opciones: newOpciones,
                              });
                            }}
                            disabled={
                              currentQuestion.tipo === "verdadero_falso"
                            }
                            className="flex-1 px-3 py-2 border-2 border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500"
                            placeholder={`Opción ${idx + 1}`}
                          />
                          <button
                            onClick={() =>
                              setCurrentQuestion({
                                ...currentQuestion,
                                respuesta_correcta: idx,
                              })
                            }
                            className={`px-4 py-2 rounded-lg font-semibold transition-all ${currentQuestion.respuesta_correcta === idx
                              ? "bg-green-500 text-white shadow-lg scale-105"
                              : "bg-gray-200 text-gray-600 hover:bg-gray-300"
                              }`}
                          >
                            {currentQuestion.respuesta_correcta === idx
                              ? "✓"
                              : idx + 1}
                          </button>
                        </div>

                        {currentQuestion.tipo === "imagen" && (
                          <select
                            value={currentQuestion.imagen_opciones[idx]}
                            onChange={(e) => {
                              const newImagenes = [
                                ...currentQuestion.imagen_opciones,
                              ];
                              newImagenes[idx] = e.target.value;
                              setCurrentQuestion({
                                ...currentQuestion,
                                imagen_opciones: newImagenes,
                              });
                            }}
                            className="w-full px-3 py-2 border-2 border-gray-200 rounded-lg text-2xl"
                          >
                            <option value="">Sin emoji</option>
                            {emojis.map((emoji) => (
                              <option key={emoji} value={emoji}>
                                {emoji}
                              </option>
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
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl max-w-5xl w-full max-h-[90vh] overflow-y-auto shadow-2xl">
            <div className="sticky top-0 bg-gradient-to-r from-blue-600 to-purple-600 text-white p-6 rounded-t-2xl z-10">
              <div className="flex justify-between items-center">
                <div>
                  <h2 className="text-2xl font-bold">
                    👁️ Vista Previa del Quiz
                  </h2>
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
            <div className="p-6">{renderQuestionPreview()}</div>
          </div>
        </div>
      )}

      {/* MODAL DE ANÁLISIS DETALLADO */}
      {showDetailedAnalytics && renderDetailedAnalyticsImproved()}

      <footer className="bg-white border-t border-gray-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex items-center justify-between text-sm text-gray-600">
          <div>© 2025 Didactikapp - Básica Elemental</div>
          <div className="flex items-center gap-4">
            <span>Usuarios: {users.length}</span>
            <span>Cursos: {courses.length}</span>
            <span>Recursos: {resources.length}</span>
            <span>v2.2.0</span>
          </div>
        </div>
      </footer>
    </div>
  );
}
