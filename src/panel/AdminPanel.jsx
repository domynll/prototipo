import React, { useState } from 'react';
import { Users, Settings, Book, BarChart3, UserPlus, Trash2, FilePlus2, Edit3 } from 'lucide-react';

export default function AdminPanel() {
  const [users, setUsers] = useState([
    { id: 1, name: 'Juan Pérez', role: 'student' },
    { id: 2, name: 'María López', role: 'teacher' },
  ]);

  const [newUser, setNewUser] = useState('');
  const [newRole, setNewRole] = useState('student');

  const [activities, setActivities] = useState([
    { id: 1, title: 'Quiz Matemáticas', section: 'Álgebra' },
    { id: 2, title: 'Actividad Historia', section: 'Edad Media' },
  ]);
  const [newActivity, setNewActivity] = useState('');
  const [newSection, setNewSection] = useState('');

  // --- Funciones Usuarios ---
  const handleAddUser = () => {
    if (!newUser.trim()) return;
    setUsers([...users, { id: Date.now(), name: newUser, role: newRole }]);
    setNewUser('');
  };

  const handleDeleteUser = (id) => {
    setUsers(users.filter(u => u.id !== id));
  };

  // --- Funciones Actividades ---
  const handleAddActivity = () => {
    if (!newActivity.trim() || !newSection.trim()) return;
    setActivities([...activities, { id: Date.now(), title: newActivity, section: newSection }]);
    setNewActivity('');
    setNewSection('');
  };

  const handleDeleteActivity = (id) => {
    setActivities(activities.filter(a => a.id !== id));
  };

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      {/* Header */}
      <header className="mb-6">
        <h1 className="text-3xl font-bold">Panel de Administrador</h1>
        <p className="text-gray-600">Gestión de usuarios, roles y actividades</p>
      </header>

      {/* Gestión de Usuarios */}
      <section className="mb-8">
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <Users className="w-6 h-6"/> Gestión de Usuarios
        </h2>
        <div className="bg-white rounded-lg p-6 shadow space-y-4">
          {/* Agregar usuario */}
          <div className="flex gap-2 items-center">
            <input
              type="text"
              placeholder="Nombre del usuario"
              value={newUser}
              onChange={(e) => setNewUser(e.target.value)}
              className="border rounded px-3 py-2 w-1/2"
            />
            <select
              value={newRole}
              onChange={(e) => setNewRole(e.target.value)}
              className="border rounded px-3 py-2"
            >
              <option value="student">Estudiante</option>
              <option value="teacher">Docente</option>
              <option value="admin">Administrador</option>
            </select>
            <button
              onClick={handleAddUser}
              className="bg-emerald-600 text-white px-4 py-2 rounded flex items-center gap-1"
            >
              <UserPlus className="w-4 h-4"/> Agregar
            </button>
          </div>

          {/* Lista usuarios */}
          <div className="space-y-3">
            {users.map(u => (
              <div key={u.id} className="bg-gray-50 border rounded-lg p-4 shadow-sm flex justify-between items-center">
                <div>
                  <span className="font-medium">{u.name}</span>
                  <span className="ml-2 text-sm text-gray-500">({u.role})</span>
                </div>
                <button
                  onClick={() => handleDeleteUser(u.id)}
                  className="text-red-500 hover:text-red-700"
                >
                  <Trash2 className="w-5 h-5"/>
                </button>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Gestión de Actividades */}
      <section className="mb-8">
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <Book className="w-6 h-6"/> Gestión de Actividades
        </h2>
        <div className="bg-white rounded-lg p-6 shadow space-y-4">
          {/* Agregar actividad */}
          <div className="flex flex-col sm:flex-row gap-2">
            <input
              type="text"
              placeholder="Nombre de la actividad/quiz"
              value={newActivity}
              onChange={(e) => setNewActivity(e.target.value)}
              className="border rounded px-3 py-2 flex-1"
            />
            <input
              type="text"
              placeholder="Sección (ej. Matemáticas)"
              value={newSection}
              onChange={(e) => setNewSection(e.target.value)}
              className="border rounded px-3 py-2 flex-1"
            />
            <button
              onClick={handleAddActivity}
              className="bg-blue-600 text-white px-4 py-2 rounded flex items-center gap-1"
            >
              <FilePlus2 className="w-4 h-4"/> Crear
            </button>
          </div>

          {/* Lista actividades */}
          <div className="space-y-3">
            {activities.map(a => (
              <div key={a.id} className="bg-gray-50 border rounded-lg p-4 shadow-sm flex justify-between items-center">
                <div>
                  <span className="font-medium">{a.title}</span>
                  <span className="ml-2 text-sm text-gray-500">[{a.section}]</span>
                </div>
                <div className="flex gap-2">
                  <button className="text-emerald-600 hover:text-emerald-800">
                    <Edit3 className="w-5 h-5"/>
                  </button>
                  <button
                    onClick={() => handleDeleteActivity(a.id)}
                    className="text-red-500 hover:text-red-700"
                  >
                    <Trash2 className="w-5 h-5"/>
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Estadísticas */}
      <section>
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <BarChart3 className="w-6 h-6"/> Estadísticas
        </h2>
        <div className="bg-white rounded-lg p-6 shadow">
          <p>📊 Aquí irán gráficas y reportes de participación de estudiantes.</p>
        </div>
      </section>

      {/* Configuración */}
      <section className="mt-8">
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <Settings className="w-6 h-6"/> Configuración Global
        </h2>
        <div className="bg-white rounded-lg p-6 shadow">
          <p>⚙️ Opciones generales de seguridad y personalización.</p>
        </div>
      </section>
    </div>
  );
}
