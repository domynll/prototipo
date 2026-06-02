import React, { useEffect, useState, useRef } from 'react';
import {
  Users, BookOpen, LogOut, Star, Trophy, Zap, Play, Lock,
  CheckCircle, Clock, Award, TrendingUp, Target, Sparkles,
  Volume2, VolumeX, Heart, Brain, ChevronRight, Home,
  BarChart3, Gift, Calendar, MessageCircle, Medal, XCircle,
  Headphones, Video, Image, HelpCircle, ArrowLeft, ChevronDown,
  RefreshCw, X
} from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { useNavigate } from 'react-router-dom';

const RoleSwitcherMejorado = ({ user, userPoints, onLogout }) => {
  const navigate = useNavigate();
  const [showRoleMenu, setShowRoleMenu] = useState(false);
  const [availableRoles, setAvailableRoles] = useState([]);
  const [currentViewRole, setCurrentViewRole] = useState(() => {
    const savedRole = localStorage.getItem('didaktik_view_role');
    const currentPath = window.location.hash;

    if (currentPath.includes('/student')) return 'estudiante';
    if (currentPath.includes('/teacher')) return 'docente';
    if (currentPath.includes('/admin')) return 'admin';

    return savedRole || null;
  });

  useEffect(() => {
    if (user) {
      loadAvailableRoles();

      const savedViewRole = localStorage.getItem('didaktik_view_role');
      const currentPath = window.location.hash;
      let correctRole = null;

      if (currentPath.includes('/student')) correctRole = 'estudiante';
      else if (currentPath.includes('/teacher')) correctRole = 'docente';
      else if (currentPath.includes('/admin')) correctRole = 'admin';

      if (!correctRole && savedViewRole) {
        const userRoles = [user.rol, ...(user.roles_adicionales || [])];
        if (userRoles.includes(savedViewRole)) {
          correctRole = savedViewRole;
        }
      }

      if (!correctRole) correctRole = user.rol;

      if (correctRole !== currentViewRole) {
        setCurrentViewRole(correctRole);
        localStorage.setItem('didaktik_view_role', correctRole);
      }
    }
  }, [user]);

  useEffect(() => {
    const currentPath = window.location.hash;
    const savedViewRole = localStorage.getItem('didaktik_view_role');

    if (savedViewRole && savedViewRole !== currentViewRole) {
      setCurrentViewRole(savedViewRole);
    }
  }, []);

  const loadAvailableRoles = () => {
    if (!user) return;

    try {
      const roles = [user.rol];
      if (user.roles_adicionales && Array.isArray(user.roles_adicionales)) {
        roles.push(...user.roles_adicionales);
      }
      const uniqueRoles = [...new Set(roles)];
      setAvailableRoles(uniqueRoles);
    } catch (error) {
      console.error('Error cargando roles:', error);
    }
  };

  const getRoleIcon = (role) => {
    const icons = {
      admin: '⚙️',
      docente: '👨‍🏫',
      estudiante: '📚',
      visitante: '👤'
    };
    return icons[role] || '👤';
  };

  const getRoleLabel = (role) => {
    const labels = {
      admin: 'Administrador',
      docente: 'Docente',
      estudiante: 'Estudiante',
      visitante: 'Visitante'
    };
    return labels[role] || role;
  };

  const getRolePath = (role) => {
    const paths = {
      admin: '/admin',
      docente: '/teacher',
      estudiante: '/student',
      visitante: '/'
    };
    return paths[role] || '/';
  };

  const handleSwitchRole = async (newRole) => {
    try {
      if (newRole === currentViewRole) {
        alert("✅ Ya estás viendo este panel");
        setShowRoleMenu(false);
        return;
      }

      const userRoles = [user.rol, ...(user.roles_adicionales || [])];
      if (!userRoles.includes(newRole)) {
        alert("❌ No tienes acceso a este rol");
        setShowRoleMenu(false);
        return;
      }

      if (!confirm(`¿Cambiar al panel de ${getRoleLabel(newRole)}?`)) {
        setShowRoleMenu(false);
        return;
      }

      localStorage.setItem('didaktik_view_role', newRole);
      setCurrentViewRole(newRole);
      setShowRoleMenu(false);

      // ✅ Definir targetPath correctamente
      const targetPath = getRolePath(newRole);

      setTimeout(() => {
        window.location.hash = targetPath;
        window.location.reload();
      }, 100);

    } catch (error) {
      console.error('❌ Error:', error);
      alert('Error al cambiar de panel: ' + error.message);
    }
  };

  const handleLogoutClick = () => {
    setShowRoleMenu(false);
    localStorage.removeItem('didaktik_view_role');
    onLogout();
  };

  return (
    <div className="flex items-center gap-2">
      <div className="relative">
        <button
          onClick={() => setShowRoleMenu(!showRoleMenu)}
          className="flex items-center gap-2 px-4 py-2 bg-white/10 hover:bg-white/20 rounded-lg transition-all text-white font-medium"
          title={`Viendo como: ${getRoleLabel(currentViewRole)}`}
        >
          <span className="text-lg">{getRoleIcon(currentViewRole)}</span>
          <span className="hidden sm:inline text-sm">{getRoleLabel(currentViewRole)}</span>
          {availableRoles.length > 1 && (
            <ChevronDown
              className={`w-4 h-4 transition-transform ${showRoleMenu ? 'rotate-180' : ''}`}
            />
          )}
        </button>

        {showRoleMenu && (
          <div className="absolute top-full right-0 mt-2 w-64 bg-white rounded-xl shadow-2xl z-50 overflow-hidden animate-in">
            <div className="bg-gradient-to-r from-indigo-600 to-purple-600 text-white p-4">
              <p className="font-bold text-sm">🔄 CAMBIAR VISTA</p>
              <p className="text-xs text-indigo-100 mt-1">
                Tu rol en BD: <strong>{getRoleLabel(user.rol)}</strong>
              </p>
            </div>

            <div className="divide-y max-h-96 overflow-y-auto">
              {availableRoles.map((role) => {
                const isActive = role === currentViewRole;

                return (
                  <button
                    key={role}
                    onClick={() => handleSwitchRole(role)}
                    className={`w-full text-left px-4 py-4 flex items-center gap-3 transition-all hover:bg-gray-50 ${isActive
                      ? 'bg-indigo-50 border-l-4 border-indigo-600'
                      : ''
                      }`}
                  >
                    <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${isActive
                      ? 'bg-indigo-600 text-white'
                      : 'bg-gray-100 text-gray-600'
                      }`}>
                      <span className="text-lg">{getRoleIcon(role)}</span>
                    </div>

                    <div className="flex-1">
                      <p className={`font-semibold text-sm ${isActive ? 'text-indigo-600' : 'text-gray-800'
                        }`}>
                        {getRoleLabel(role)}
                      </p>
                      {isActive && (
                        <p className="text-xs text-indigo-600 font-medium">✓ Viendo ahora</p>
                      )}
                      {role === user.rol && !isActive && (
                        <p className="text-xs text-gray-500">Rol principal</p>
                      )}
                    </div>

                    {!isActive && (
                      <div className="text-gray-400 text-lg">→</div>
                    )}
                  </button>
                );
              })}
            </div>

            <div className="border-t p-3 bg-gray-50">
              <p className="text-xs text-gray-600 text-center">
                ℹ️ Cambiar vista NO modifica tu rol en la BD
              </p>
            </div>

            <button
              onClick={handleLogoutClick}
              className="w-full bg-red-50 hover:bg-red-100 text-red-600 px-4 py-4 flex items-center gap-3 font-semibold transition-all"
            >
              <div className="w-10 h-10 rounded-lg bg-red-200 flex items-center justify-center">
                <LogOut className="w-5 h-5" />
              </div>
              <div className="text-left">
                <p className="text-sm font-bold">SALIR</p>
                <p className="text-xs text-red-500">Cerrar sesión</p>
              </div>
            </button>
          </div>
        )}
      </div>

      {availableRoles.length <= 1 && (
        <button
          onClick={handleLogoutClick}
          className="flex items-center gap-2 px-3 py-2 bg-red-500 hover:bg-red-600 text-white rounded-lg transition-all font-medium text-sm"
        >
          <LogOut className="w-4 h-4" />
          <span className="hidden sm:inline">SALIR</span>
        </button>
      )}
    </div>
  );
};

// ========================================
// 🐢 COMPONENTE: KARIN MASCOT SIMPLIFICADO
// ========================================
const KarinMascot = ({ state = 'idle', message }) => {
  const getStateEmoji = () => {
    const emojis = {
      idle: '🐢',
      thinking: '🤔',
      happy: '😊',
      encourage: '💪',
      explain: '📚'
    };
    return emojis[state] || '🐢';
  };

  const getBgColor = () => {
    const colors = {
      idle: 'from-green-100 to-emerald-100',
      thinking: 'from-blue-100 to-cyan-100',
      happy: 'from-yellow-100 to-amber-100',
      encourage: 'from-purple-100 to-pink-100',
      explain: 'from-indigo-100 to-blue-100'
    };
    return colors[state] || 'from-green-100 to-emerald-100';
  };

  return (
    <div className="bg-white rounded-2xl shadow-lg border-2 border-green-200 overflow-hidden">
      <div className={`bg-gradient-to-r ${getBgColor()} p-4`}>
        <div className="flex items-center gap-4">
          <div className="text-5xl animate-pulse">{getStateEmoji()}</div>
          <div className="flex-1">
            <p className="text-lg font-bold text-gray-800">¡Hola! Soy Karin 🐢</p>
            <p className="text-gray-700">{message || "¿Listo para aprender?"}</p>
          </div>
        </div>
      </div>
    </div>
  );
};

const StudentQuizView = ({
  resource,
  onClose,
  user,
  onComplete
}) => {
  // Refs para manejar timers y evitar choques
  const repeatIntervalRef = useRef(null);
  const timeoutIdsRef = useRef([]);
  const isMountedRef = useRef(true);
  const audioQueueRef = useRef([]);
  const isPlayingRef = useRef(false);
  const speechSynthesisRef = useRef(null);

  // Estados
  const [questions, setQuestions] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [attemptCount, setAttemptCount] = useState({});
  const [selectedOption, setSelectedOption] = useState(null);
  const [results, setResults] = useState(null);
  const [soundEnabled, setSoundEnabled] = useState(true);
  const [showTimer, setShowTimer] = useState(false);
  const [timeLeft, setTimeLeft] = useState(0);

  // Cargar preguntas del recurso
  useEffect(() => {
    isMountedRef.current = true;

    if (resource?.contenido_quiz) {
      const loadedQuestions = Array.isArray(resource.contenido_quiz)
        ? resource.contenido_quiz
        : (typeof resource.contenido_quiz === 'string' ? JSON.parse(resource.contenido_quiz || '[]') : []);

      const formattedQuestions = loadedQuestions.map((q, idx) => ({
        id: q.id || `q_${idx}`,
        pregunta: q.pregunta || q.text || q.question || '',
        opciones: q.opciones || q.options || ['', '', '', ''],
        respuesta_correcta: q.respuesta_correcta ?? q.correct ?? 0,
        puntos: q.puntos || q.points || 10,
        retroalimentacion_correcta: q.retroalimentacion_correcta || q.feedback_correct || '¡Excelente! 🎉',
        retroalimentacion_incorrecta: q.retroalimentacion_incorrecta || q.feedback_incorrect || '¡Intenta otra vez! 💪',
        audio_pregunta: q.audio_pregunta !== false,
        audio_retroalimentacion: q.audio_retroalimentacion !== false,
        video_url: q.video_url || '',
        imagen_url: q.imagen_url || q.image_url || '',
        imagen_opciones: q.imagen_opciones || q.image_options || ['🅰️', '🅱️', '🅲️', '🅳️'],
        tiempo_limite: q.tiempo_limite || q.timeLimit || 0
      }));

      setQuestions(formattedQuestions);
    }

    return () => {
      isMountedRef.current = false;
      if (repeatIntervalRef.current) clearInterval(repeatIntervalRef.current);
      timeoutIdsRef.current.forEach(id => clearTimeout(id));
      if (window.speechSynthesis) window.speechSynthesis.cancel();
    };
  }, [resource]);

  // Función de voz mejorada con cola
  const speakText = (text) => {
    if (!soundEnabled || !text || !("speechSynthesis" in window)) return;
    if (!isMountedRef.current) return;

    audioQueueRef.current.push(text);

    if (isPlayingRef.current) return;
    processAudioQueue();
  };

  const processAudioQueue = () => {
    if (!isMountedRef.current) {
      audioQueueRef.current = [];
      isPlayingRef.current = false;
      return;
    }

    if (audioQueueRef.current.length === 0) {
      isPlayingRef.current = false;
      return;
    }

    isPlayingRef.current = true;
    const text = audioQueueRef.current.shift();

    if (window.speechSynthesis) window.speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = "es-MX";
    utterance.rate = 0.85;
    utterance.pitch = 1.2;
    utterance.volume = 1;

    const loadVoicesAndSpeak = () => {
      const voices = window.speechSynthesis.getVoices();
      const preferredVoice = voices.find(v => v.lang === "es-MX" &&
        (v.name.toLowerCase().includes("google") ||
          v.name.toLowerCase().includes("female") ||
          v.name.toLowerCase().includes("paulina"))) ||
        voices.find(v => v.lang.startsWith("es")) ||
        voices[0];

      if (preferredVoice) utterance.voice = preferredVoice;
      window.speechSynthesis.speak(utterance);
    };

    if (speechSynthesis.getVoices().length === 0) {
      speechSynthesis.onvoiceschanged = loadVoicesAndSpeak;
    } else {
      loadVoicesAndSpeak();
    }

    utterance.onend = () => {
      setTimeout(() => processAudioQueue(), 200);
    };

    utterance.onerror = () => {
      processAudioQueue();
    };
  };

  // Efecto de audio automático al cambiar de pregunta
  useEffect(() => {
    if (questions.length === 0 || !isMountedRef.current) return;

    const question = questions[currentQuestionIndex];
    if (!question) return;

    const answer = answers[currentQuestionIndex];
    const attempts = attemptCount[currentQuestionIndex] || 0;

    timeoutIdsRef.current.forEach(id => clearTimeout(id));
    if (repeatIntervalRef.current) clearInterval(repeatIntervalRef.current);
    timeoutIdsRef.current = [];

    if (answer?.isCorrect || attempts >= 3) return;

    const timeout1 = setTimeout(() => {
      if (isMountedRef.current) speakText("Responde la pregunta");
    }, 300);
    timeoutIdsRef.current.push(timeout1);

    const timeout2 = setTimeout(() => {
      if (isMountedRef.current && question.pregunta) speakText(question.pregunta);
    }, 2000);
    timeoutIdsRef.current.push(timeout2);

    const timeout3 = setTimeout(() => {
      if (isMountedRef.current && question.opciones) {
        let opcionesTexto = "Las opciones son: ";
        question.opciones.forEach((opcion, idx) => {
          if (opcion) opcionesTexto += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
        });
        speakText(opcionesTexto);
      }
    }, 4000);
    timeoutIdsRef.current.push(timeout3);

    setShowTimer(true);
    setTimeLeft(15);

    const timerInterval = setInterval(() => {
      setTimeLeft(prev => {
        if (prev <= 1) {
          clearInterval(timerInterval);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    timeoutIdsRef.current.push(timerInterval);

    const repeatTimeout = setTimeout(() => {
      if (!isMountedRef.current) return;

      repeatIntervalRef.current = setInterval(() => {
        const currentAnswer = answers[currentQuestionIndex];
        const currentAttempts = attemptCount[currentQuestionIndex] || 0;

        if (isMountedRef.current && !currentAnswer?.isCorrect && currentAttempts < 3) {
          speakText("Recuerda responder la pregunta");
          setTimeout(() => {
            if (isMountedRef.current && !currentAnswer?.isCorrect && currentAttempts < 3) {
              speakText(question.pregunta);
            }
          }, 1000);
          setTimeout(() => {
            if (isMountedRef.current && !currentAnswer?.isCorrect && currentAttempts < 3 && question.opciones) {
              let opcionesTexto = "Las opciones son: ";
              question.opciones.forEach((opcion, idx) => {
                if (opcion) opcionesTexto += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
              });
              speakText(opcionesTexto);
            }
          }, 3000);
        } else if (!isMountedRef.current || currentAnswer?.isCorrect || currentAttempts >= 3) {
          if (repeatIntervalRef.current) clearInterval(repeatIntervalRef.current);
        }
      }, 15000);
    }, 12000);
    timeoutIdsRef.current.push(repeatTimeout);

    return () => {
      timeoutIdsRef.current.forEach(id => clearTimeout(id));
      if (repeatIntervalRef.current) clearInterval(repeatIntervalRef.current);
    };
  }, [currentQuestionIndex, questions, answers, attemptCount]);

  // Repetir pregunta con opciones
  const repeatQuestionWithOptions = () => {
    const question = questions[currentQuestionIndex];
    if (!question) return;
    let fullText = `La pregunta es: ${question.pregunta}. Las opciones son: `;
    question.opciones.forEach((opcion, idx) => {
      if (opcion) fullText += `${String.fromCharCode(65 + idx)}) ${opcion}. `;
    });
    speakText(fullText);

    setShowTimer(true);
    setTimeLeft(15);
  };

  // Manejar selección de respuesta
  const handleAnswerSelection = (selectedIdx) => {
    const question = questions[currentQuestionIndex];
    if (!question) return;

    const currentAnswer = answers[currentQuestionIndex];
    const currentAttempts = attemptCount[currentQuestionIndex] || 0;
    const maxAttempts = 3;

    if (currentAnswer?.isCorrect || currentAttempts >= maxAttempts) return;

    const isCorrect = selectedIdx === question.respuesta_correcta;
    const newAttempts = currentAttempts + 1;

    speakText(question.opciones[selectedIdx]);

    setAttemptCount(prev => ({ ...prev, [currentQuestionIndex]: newAttempts }));

    const newAnswer = {
      selected: selectedIdx,
      isCorrect: isCorrect,
      attempts: newAttempts,
      showCorrect: newAttempts >= maxAttempts && !isCorrect
    };

    setAnswers(prev => ({ ...prev, [currentQuestionIndex]: newAnswer }));
    setSelectedOption(selectedIdx);
    setShowTimer(false);

    setTimeout(() => {
      if (isCorrect) {
        speakText("¡Correcto! " + question.retroalimentacion_correcta);
        setTimeout(() => {
          speakText(`La pregunta era: ${question.pregunta}. La respuesta correcta es: ${question.opciones[question.respuesta_correcta]}`);
        }, 1500);
      } else if (newAttempts >= maxAttempts) {
        speakText(`Lo siento, te has equivocado ${maxAttempts} veces. La respuesta correcta es: ${question.opciones[question.respuesta_correcta]}`);
      } else {
        const remaining = maxAttempts - newAttempts;
        speakText(`Incorrecto. Te quedan ${remaining} intentos. Intenta de nuevo.`);
      }
    }, 1000);
  };

  // Navegar a siguiente pregunta
  const goToNextQuestion = () => {
    setShowTimer(false);
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
      setSelectedOption(null);
    } else {
      const correct = Object.values(answers).filter(a => a?.isCorrect).length;
      const totalQuestions = questions.length;
      const score = Math.round((correct / totalQuestions) * 100);

      const resultsData = {
        correct,
        total: totalQuestions,
        percentage: score,
        points: questions.reduce((sum, q, idx) => {
          if (answers[idx]?.isCorrect) return sum + (q.puntos || 10);
          return sum;
        }, 0),
        passed: score >= 60
      };

      setResults(resultsData);
      if (onComplete) onComplete(resultsData);
    }
  };

  // Reiniciar quiz
  const restartQuiz = () => {
    setCurrentQuestionIndex(0);
    setAnswers({});
    setAttemptCount({});
    setSelectedOption(null);
    setResults(null);
    setShowTimer(false);
  };

  const currentQuestion = questions[currentQuestionIndex];
  const answer = answers[currentQuestionIndex];
  const attempts = attemptCount[currentQuestionIndex] || 0;
  const maxAttempts = 3;

  // Estado de Karin mejorado
  const getKarinState = () => {
    if (answer?.isCorrect) {
      return { state: "happy", message: "¡Excelente! Respuesta correcta 🎉", emoji: "😊🎉", bgColor: "from-green-400 to-emerald-500" };
    }
    if (answer && !answer.isCorrect && attempts >= maxAttempts) {
      return { state: "encourage", message: "No te preocupes, sigamos aprendiendo juntos 💚", emoji: "💪📚", bgColor: "from-blue-400 to-cyan-500" };
    }
    if (attempts > 0 && attempts < maxAttempts) {
      const remaining = maxAttempts - attempts;
      return { state: "thinking", message: `Te quedan ${remaining} intento${remaining !== 1 ? 's' : ''}. ¡Tú puedes! 💪`, emoji: "🤔✨", bgColor: "from-yellow-400 to-orange-500" };
    }
    return { state: "idle", message: "¡Hola! Escucha la pregunta y elige la respuesta correcta", emoji: "🐢💚", bgColor: "from-emerald-400 to-teal-500" };
  };

  const karin = getKarinState();

  if (!questions.length) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-70 z-50 flex items-center justify-center p-4">
        <div className="bg-white rounded-3xl p-8 max-w-md text-center shadow-2xl">
          <XCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <h3 className="text-xl font-bold text-gray-800 mb-2">No hay preguntas</h3>
          <p className="text-gray-600 mb-4">Este quiz no tiene preguntas disponibles</p>
          <button onClick={onClose} className="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-xl font-bold transition-all">Cerrar</button>
        </div>
      </div>
    );
  }

  if (results) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-70 z-50 flex items-center justify-center p-4">
        <div className="bg-white rounded-3xl max-w-2xl w-full shadow-2xl overflow-hidden animate-fadeIn">
          <div className={`bg-gradient-to-r ${results.passed ? 'from-green-500 to-emerald-500' : 'from-orange-500 to-red-500'} text-white p-6`}>
            <h2 className="text-2xl font-black text-center">🎉 QUIZ COMPLETADO 🎉</h2>
          </div>
          <div className="p-8 text-center">
            <div className={`w-32 h-32 rounded-full mx-auto flex items-center justify-center text-6xl mb-6 shadow-lg ${results.passed ? 'bg-green-100' : 'bg-orange-100'}`}>
              {results.passed ? '🏆' : '💪'}
            </div>
            <h3 className="text-3xl font-black text-gray-800 mb-2">{results.passed ? '¡FELICITACIONES!' : '¡SIGUE PRACTICANDO!'}</h3>
            <p className="text-gray-600 mb-6">{results.passed ? 'Has completado el quiz exitosamente' : 'Necesitas al menos 60% para aprobar. ¡Sigue aprendiendo!'}</p>

            <div className="grid grid-cols-3 gap-4 mb-8">
              <div className="bg-blue-50 rounded-xl p-4 border-2 border-blue-200">
                <p className="text-xs text-gray-600">Correctas</p>
                <p className="text-3xl font-black text-blue-600">{results.correct}/{results.total}</p>
              </div>
              <div className="bg-purple-50 rounded-xl p-4 border-2 border-purple-200">
                <p className="text-xs text-gray-600">Puntuación</p>
                <p className="text-3xl font-black text-purple-600">{results.percentage}%</p>
              </div>
              <div className="bg-yellow-50 rounded-xl p-4 border-2 border-yellow-200">
                <p className="text-xs text-gray-600">Puntos</p>
                <p className="text-3xl font-black text-yellow-600">{results.points}</p>
              </div>
            </div>

            <div className="flex gap-4">
              <button onClick={restartQuiz} className="flex-1 bg-gradient-to-r from-indigo-500 to-purple-500 hover:from-indigo-600 hover:to-purple-600 text-white py-3 rounded-xl font-bold transition transform hover:scale-105">
                <RefreshCw className="inline w-5 h-5 mr-2" /> Reintentar
              </button>
              <button onClick={onClose} className="flex-1 bg-gradient-to-r from-gray-500 to-gray-600 hover:from-gray-600 hover:to-gray-700 text-white py-3 rounded-xl font-bold transition transform hover:scale-105">
                Salir
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-70 z-50 flex items-center justify-center p-2 md:p-4 overflow-y-auto">
      <div className="bg-white rounded-3xl max-w-6xl w-full max-h-[95vh] overflow-hidden shadow-2xl flex flex-col">
        {/* HEADER */}
        <div className="sticky top-0 z-10 bg-gradient-to-r from-blue-600 to-indigo-600 text-white p-4 md:p-5">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-xl md:text-2xl font-black flex items-center gap-2">
                <Sparkles className="w-6 h-6" />
                {resource?.titulo || 'Quiz Interactivo'}
              </h2>
              <p className="text-blue-100 text-xs md:text-sm mt-1">Responde correctamente para ganar puntos</p>
            </div>
            <div className="flex items-center gap-3">
              {showTimer && (
                <div className="bg-white/20 backdrop-blur-sm rounded-full px-4 py-2">
                  <span className="font-bold text-lg">⏱️ {timeLeft}s</span>
                </div>
              )}
              <button onClick={onClose} className="bg-white/20 hover:bg-white/30 p-2 md:p-3 rounded-xl transition-all">
                <X className="w-5 h-5 md:w-6 md:h-6" />
              </button>
            </div>
          </div>
        </div>

        {/* CONTENIDO DEL QUIZ */}
        <div className="flex-1 overflow-y-auto p-4 md:p-6 bg-gradient-to-br from-blue-50 via-white to-purple-50">
          <div className="max-w-4xl mx-auto">

            {/* ============================================ */}
            {/* KARIN MASCOTA - SOLO TORTUGA SIN CORAZÓN */}
            {/* ============================================ */}
            <div className="mb-6">
              <div className={`bg-gradient-to-r ${karin.bgColor} rounded-2xl p-5 shadow-xl transition-all duration-300 hover:shadow-2xl hover:scale-[1.01]`}>
                <div className="flex items-center gap-5">
                  <div>
                    {/* Tortuga principal con animación suave */}
                    <div className="w-24 h-24 md:w-28 md:h-28 bg-white/30 rounded-2xl flex items-center justify-center text-6xl md:text-7xl shadow-lg backdrop-blur-sm transition-all duration-700 hover:scale-105 animate-soft-bounce">
                      {karin.emoji || '🐢'}
                    </div>
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      {/* Tortuguita pequeña con movimiento sutil */}
                      <span className="text-2xl inline-block animate-soft-wave">
                        🐢
                      </span>
                      <h3 className="font-black text-white text-lg md:text-xl">Karin</h3>
                    </div>
                    <p className="text-white text-sm md:text-base font-medium leading-relaxed">
                      {karin.message}
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* BARRA DE PROGRESO */}
            <div className="mb-5">
              <div className="flex justify-between text-sm text-gray-600 mb-2">
                <span className="font-bold">Progreso</span>
                <span className="font-bold bg-white px-3 py-1 rounded-full shadow-sm">{currentQuestionIndex + 1} / {questions.length}</span>
              </div>
              <div className="flex gap-1.5">
                {questions.map((_, idx) => (
                  <div key={idx} className={`flex-1 h-3 rounded-full transition-all duration-500 ${idx === currentQuestionIndex ? 'bg-blue-500 shadow-md' : idx < currentQuestionIndex ? 'bg-green-400' : 'bg-gray-200'}`} />
                ))}
              </div>
            </div>

            {/* CONTADOR DE INTENTOS */}
            {attempts > 0 && (
              <div className="bg-yellow-50 border-2 border-yellow-300 rounded-xl p-3 mb-5 text-center shadow-sm">
                <p className="text-sm font-black text-yellow-800">🎯 INTENTOS: {attempts} / {maxAttempts}</p>
                <div className="flex gap-2 justify-center mt-2">
                  {[...Array(maxAttempts)].map((_, i) => (
                    <div key={i} className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold shadow-sm ${i < attempts ? (answer?.isCorrect ? 'bg-green-400 text-white' : 'bg-red-400 text-white') : 'bg-gray-200 text-gray-500'}`}>
                      {i < attempts ? (answer?.isCorrect ? '✓' : '✗') : i + 1}
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* PREGUNTA */}
            <div className="bg-white rounded-2xl shadow-xl p-6 mb-5 border-2 border-blue-100">
              <div className="text-center">
                {currentQuestion.imagen_url && (
                  <div className="mb-4">
                    <div className="inline-block bg-gradient-to-br from-purple-100 to-pink-100 rounded-2xl p-6 shadow-md">
                      <span className="text-7xl md:text-8xl drop-shadow-lg">{currentQuestion.imagen_url}</span>
                    </div>
                  </div>
                )}
                <p className="text-xl md:text-2xl font-black text-gray-800 mb-4 leading-relaxed">
                  {currentQuestion.pregunta}
                </p>
                <div className="flex items-center justify-center gap-3">
                  {currentQuestion.audio_pregunta && (
                    <button onClick={() => speakText(currentQuestion.pregunta)} className="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white px-5 py-2.5 rounded-xl font-semibold flex items-center gap-2 shadow-md transition-all">
                      <Volume2 className="w-5 h-5" /> Escuchar Pregunta
                    </button>
                  )}
                  <button onClick={repeatQuestionWithOptions} className="bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white px-5 py-2.5 rounded-xl font-semibold flex items-center gap-2 shadow-md transition-all">
                    <RefreshCw className="w-5 h-5" /> Repetir Todo
                  </button>
                </div>
              </div>
            </div>

            {/* OPCIONES */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
              {currentQuestion.opciones.map((opcion, idx) => {
                const isSelected = selectedOption === idx;
                const isCorrectOption = idx === currentQuestion.respuesta_correcta;
                const showAsCorrect = answer?.showCorrect && isCorrectOption;
                const isDisabled = answer?.isCorrect || attempts >= maxAttempts;
                const emojiOpcion = currentQuestion.imagen_opciones?.[idx] || ['🅰️', '🅱️', '🅲️', '🅳️'][idx];
                const letra = String.fromCharCode(65 + idx);

                return (
                  <div key={idx} className={`relative p-4 rounded-xl border-2 transition-all duration-300 ${showAsCorrect ? 'bg-green-50 border-green-400 shadow-md' : isDisabled && answer?.isCorrect && isSelected ? 'bg-green-100 border-green-500' : isDisabled && !isCorrectOption ? 'bg-gray-100 border-gray-300 opacity-60' : isSelected && !answer?.isCorrect ? 'bg-red-100 border-red-400' : 'bg-white border-gray-200 hover:border-blue-400 hover:shadow-md hover:bg-blue-50'}`}>
                    <div className="flex items-center gap-4 cursor-pointer" onClick={() => !isDisabled && handleAnswerSelection(idx)}>
                      <div className={`w-12 h-12 rounded-xl flex items-center justify-center text-2xl font-black shadow-sm ${isSelected && answer?.isCorrect ? 'bg-green-500 text-white' : isSelected && !answer?.isCorrect ? 'bg-red-500 text-white' : showAsCorrect ? 'bg-green-500 text-white' : 'bg-gray-100 text-gray-700'}`}>
                        {emojiOpcion}
                      </div>
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <span className={`font-black text-sm ${showAsCorrect ? 'text-green-600' : isSelected && !answer?.isCorrect ? 'text-red-600' : 'text-gray-500'}`}>{letra})</span>
                          <span className="font-medium text-gray-800">{opcion}</span>
                        </div>
                      </div>
                      <button onClick={(e) => { e.stopPropagation(); speakText(opcion); }} className="bg-blue-100 hover:bg-blue-200 text-blue-700 p-2 rounded-full transition-all" title="Escuchar opción">
                        <Volume2 className="w-4 h-4" />
                      </button>
                      {showAsCorrect && <span className="text-2xl animate-bounce">✅</span>}
                      {isSelected && answer?.isCorrect && <span className="text-2xl animate-bounce">🎉</span>}
                      {isSelected && !answer?.isCorrect && <span className="text-2xl">❌</span>}
                    </div>
                  </div>
                );
              })}
            </div>

            {/* RETROALIMENTACIÓN */}
            {answer && (
              <div className="space-y-4 animate-fadeIn">
                <div className={`rounded-xl p-5 text-center border-2 shadow-lg ${answer.isCorrect ? "bg-green-50 border-green-400" : attempts >= maxAttempts ? "bg-orange-50 border-orange-400" : "bg-red-50 border-red-400"}`}>
                  <div className="text-4xl mb-2">{answer.isCorrect ? "🎉✨" : attempts >= maxAttempts ? "💡📚" : "💪🌟"}</div>
                  <p className="text-xl font-black mb-2">{answer.isCorrect ? "¡CORRECTO!" : attempts >= maxAttempts ? "VAMOS A APRENDER" : "¡INTENTA DE NUEVO!"}</p>
                  <p className="text-gray-700">{answer.isCorrect ? currentQuestion.retroalimentacion_correcta : attempts >= maxAttempts ? `La respuesta correcta es: ${currentQuestion.opciones[currentQuestion.respuesta_correcta]}` : `Te quedan ${maxAttempts - attempts} intentos. ¡Sigue intentando!`}</p>
                </div>
                <button onClick={goToNextQuestion} className="w-full bg-gradient-to-r from-blue-500 to-indigo-600 hover:from-blue-600 hover:to-indigo-700 text-white py-4 rounded-xl text-lg font-bold transition transform hover:scale-[1.02] flex items-center justify-center gap-3 shadow-lg">
                  {currentQuestionIndex === questions.length - 1 ? <><Trophy className="w-6 h-6" /> FINALIZAR QUIZ</> : <><ChevronRight className="w-6 h-6" /> SIGUIENTE PREGUNTA</>}
                </button>
              </div>
            )}

            {/* NAVEGACIÓN RÁPIDA */}
            {!answer && (
              <div className="flex justify-between gap-3 mt-4">
                <button disabled={currentQuestionIndex === 0} onClick={() => { setCurrentQuestionIndex(prev => Math.max(0, prev - 1)); setSelectedOption(null); setShowTimer(false); }} className="flex-1 py-3 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-xl font-semibold disabled:opacity-40 transition-all">← Anterior</button>
                <button disabled={currentQuestionIndex === questions.length - 1} onClick={() => { setCurrentQuestionIndex(prev => Math.min(questions.length - 1, prev + 1)); setSelectedOption(null); setShowTimer(false); }} className="flex-1 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-semibold disabled:opacity-40 transition-all">Saltar →</button>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

// COMPONENTES AUXILIARES

const AchievementCard = ({ achievement, unlocked }) => (
  <div className={`bg-white rounded-xl p-4 shadow-sm border-2 transition-all ${unlocked ? 'border-yellow-400 bg-gradient-to-br from-yellow-50 to-orange-50' : 'border-gray-200 opacity-60'
    }`}>
    <div className="text-center">
      <div className={`w-16 h-16 rounded-full mx-auto mb-3 flex items-center justify-center text-3xl ${unlocked ? 'bg-yellow-100' : 'bg-gray-100'
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

const CourseCard = ({ course, onClick, progress = 0 }) => (
  <div
    onClick={onClick}
    className="bg-white rounded-2xl shadow-lg overflow-hidden cursor-pointer transform transition-all duration-300 hover:scale-105 hover:shadow-2xl"
  >
    <div
      className="h-32 flex items-center justify-center relative"
      style={{ backgroundColor: course.color || '#3B82F6' }}
    >
      <BookOpen className="w-16 h-16 text-white" />
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
    return icons[resource.tipo] || BookOpen;
  };

  const Icon = getIcon();

  return (
    <div
      onClick={onClick}
      className="bg-white rounded-xl p-4 shadow-sm border-2 border-gray-200 hover:border-blue-400 hover:shadow-md transition-all cursor-pointer"
    >
      <div className="flex items-start gap-3">
        <div className={`w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0 ${completed ? 'bg-green-100' : 'bg-blue-100'
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

// ========================================
// 🎓 COMPONENTE PRINCIPAL STUDENT PANEL
// ========================================
export default function StudentPanel() {
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
  const [chatOpen, setChatOpen] = useState(false);
  const [chatMessages, setChatMessages] = useState([
    { type: 'bot', text: '¡Hola! Soy Carín 🐢 ¿En qué puedo ayudarte hoy?' }
  ]);
  const [chatInput, setChatInput] = useState('');
  // Estados para medir tiempo en el quiz
  const [quizStartTime, setQuizStartTime] = useState(null);
  const [currentQuestionStartTime, setCurrentQuestionStartTime] = useState(null);
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
        window.location.hash = '/login';
        window.location.reload();
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

      const userRoles = [userData.rol, ...(userData.roles_adicionales || [])];
      const hasStudentAccess = userRoles.includes('estudiante');

      if (!hasStudentAccess) {
        setError('No tienes acceso al panel de estudiante');
        setTimeout(() => navigate('/'), 2000);
        return;
      }

      const currentPath = window.location.hash;
      let forceRole = null;

      if (currentPath.includes('/student')) forceRole = 'estudiante';
      else if (currentPath.includes('/teacher')) forceRole = 'docente';
      else if (currentPath.includes('/admin')) forceRole = 'admin';

      if (forceRole) {
        localStorage.setItem('didaktik_view_role', forceRole);
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

    if (resource.tipo === 'quiz') {
      setShowQuiz(true);
    } else {
      setActiveTab('resource-detail');
    }
  };

  const handleQuizComplete = async (results) => {
    try {
      const { error: progressError } = await supabase
        .from('progreso_estudiantes')
        .upsert({
          usuario_id: user.id,
          recurso_id: selectedResource.id,
          completado: results.passed,
          puntuacion: results.points,
          mejor_puntuacion: results.points,
          fecha_completado: results.passed ? new Date().toISOString() : null,
          intentos: 1
        }, {
          onConflict: 'usuario_id,recurso_id'
        });

      if (progressError) throw progressError;

      if (results.passed) {
        await supabase.rpc('increment', {
          row_id: user.id,
          x: results.points
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
  };

  const handleLogout = async () => {
    localStorage.removeItem('didaktik_view_role');
    await supabase.auth.signOut();
    window.location.hash = '/';
    window.location.reload();
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

              <div className="hidden lg:flex items-center gap-3">
                <div className="text-right">
                  <p className="font-semibold text-sm">{user?.nombre || 'Estudiante'}</p>
                  <p className="text-xs text-indigo-200">{user?.email}</p>
                </div>
              </div>

              <RoleSwitcherMejorado
                user={user}
                userPoints={userPoints}
                onLogout={handleLogout}
              />
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
                  className={`py-3 md:py-4 px-3 md:px-2 border-b-2 font-medium text-xs md:text-sm transition-colors flex items-center gap-1.5 md:gap-2 whitespace-nowrap ${activeTab === tab.id
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

      {/* QUIZ MODAL - CORREGIDO CON LAS MEJORAS */}
      {showQuiz && selectedResource && (
        <StudentQuizView
          resource={selectedResource}
          onClose={closeQuiz}
          user={user}
          onComplete={handleQuizComplete}
        />
      )}

      {/* Carín - Asistente de ayuda */}
      <div className="fixed bottom-6 right-6 z-50 flex items-end gap-4">
        {chatOpen && (
          <div className="w-80 md:w-96 bg-white rounded-2xl shadow-2xl overflow-hidden animate-in slide-in-from-right">
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

            <div className="h-80 overflow-y-auto p-4 space-y-3 bg-gray-50">
              {chatMessages.map((msg, idx) => (
                <div
                  key={idx}
                  className={`flex ${msg.type === 'user' ? 'justify-end' : 'justify-start'}`}
                >
                  <div className={`max-w-[75%] rounded-2xl px-4 py-2.5 ${msg.type === 'user'
                    ? 'bg-indigo-600 text-white rounded-br-sm'
                    : 'bg-white text-gray-800 rounded-bl-sm shadow-sm'
                    }`}>
                    <p className="text-sm">{msg.text}</p>
                  </div>
                </div>
              ))}
            </div>

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