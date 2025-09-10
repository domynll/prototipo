import React, { useEffect, useState } from 'react';
import { Users, Settings, FilePlus, HelpCircle, LogOut } from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { useNavigate } from 'react-router-dom';

export default function AdminPanel() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [menuOpen, setMenuOpen] = useState(false);
  const navigate = useNavigate();

  // 🔹 Cargar usuarios
  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    setLoading(true);
    const { data, error } = await supabase.from('users').select('*');
    if (error) console.error('Error cargando usuarios:', error);
    else setUsers(data);
    setLoading(false);
  };

  const updateRole = async (id, newRole) => {
    const { error } = await supabase
      .from('users')
      .update({ role: newRole })
      .eq('id', id);

    if (error) console.error('Error actualizando rol:', error);
    else fetchUsers();
  };

// Logout
const handleLogout = async () => {
  await supabase.auth.signOut();
  navigate('/welcome'); // Ahora redirige a la página de bienvenida
};

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Header */}
      <header className="bg-white shadow px-6 py-3 flex justify-between items-center">
        <h1 className="text-2xl font-bold text-gray-700">Panel de Administrador</h1>

        {/* Menú Usuario */}
        <div className="relative">
          <button
            onClick={() => setMenuOpen(!menuOpen)}
            className="flex items-center gap-2 bg-gray-200 px-3 py-1 rounded-full"
          >
            <img
              src="https://i.pravatar.cc/40"
              alt="User Avatar"
              className="w-8 h-8 rounded-full"
            />
            <span className="font-medium">Admin</span>
          </button>

          {menuOpen && (
            <div className="absolute right-0 mt-2 w-40 bg-white shadow rounded-lg p-2">
              <button
                onClick={handleLogout}
                className="flex items-center gap-2 w-full px-3 py-2 text-red-600 hover:bg-gray-100 rounded"
              >
                <LogOut className="w-4 h-4" /> Salir
              </button>
            </div>
          )}
        </div>
      </header>

      {/* Contenido */}
      <main className="flex-1 p-6 space-y-6">
        {/* Gestión de usuarios */}
        <section>
          <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
            <Users className="w-6 h-6 text-blue-500" /> Usuarios
          </h2>
          <div className="space-y-2">
            {users.map((u) => (
              <div
                key={u.id}
                className="bg-white rounded-lg p-4 shadow flex justify-between items-center"
              >
                <span>{u.name}</span>
                <span className="font-medium text-gray-600">{u.role}</span>
              </div>
            ))}
          </div>
        </section>

        {/* Gestión de actividades */}
        <section>
          <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
            <FilePlus className="w-6 h-6 text-green-500" /> Actividades
          </h2>
          <div className="bg-white rounded-lg p-6 shadow">
            <p className="text-gray-600">
              Aquí puedes añadir secciones, subir recursos o crear <strong>quizzes</strong>.
            </p>
            <button className="mt-4 px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">
              + Nueva Actividad
            </button>
          </div>
        </section>

        {/* Configuración */}
        <section>
          <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
            <Settings className="w-6 h-6 text-gray-600" /> Configuración
          </h2>
          <div className="bg-white rounded-lg p-6 shadow">
            <p className="text-gray-600">
              Opciones generales del sistema y administración global.
            </p>
          </div>
        </section>

        {/* Soporte */}
        <section>
          <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
            <HelpCircle className="w-6 h-6 text-purple-500" /> Soporte
          </h2>
          <div className="bg-white rounded-lg p-6 shadow">
            <p className="text-gray-600">
              Centro de ayuda y preguntas frecuentes para administradores.
            </p>
          </div>
        </section>
      </main>
    </div>
  );
}
