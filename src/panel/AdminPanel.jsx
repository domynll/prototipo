import React, { useState } from 'react';
import { Users, Settings, FilePlus, HelpCircle } from 'lucide-react';

export default function AdminPanel() {
  const [users, setUsers] = useState([
    { id: 1, name: 'Juan Pérez', role: 'student' },
    { id: 2, name: 'María López', role: 'teacher' },
  ]);

  const [showMenu, setShowMenu] = useState(false);

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Barra superior */}
      <header className="bg-white shadow px-6 py-3 flex justify-between items-center">
        <h1 className="text-2xl font-bold text-gray-700">Panel de Administrador</h1>

        {/* Usuario */}
        <div className="relative">
          <button
            onClick={() => setShowMenu(!showMenu)}
            className="flex items-center gap-2 focus:outline-none"
          >
            <img
              src="https://ui-avatars.com/api/?name=Admin&background=0D8ABC&color=fff"
              alt="Usuario"
              className="w-10 h-10 rounded-full border"
            />
            <span className="font-medium text-gray-700">Admin</span>
          </button>

          {showMenu && (
            <div className="absolute right-0 mt-2 w-40 bg-white border rounded-lg shadow-lg">
              <button className="block w-full text-left px-4 py-2 hover:bg-gray-100">
                Perfil
              </button>
              <button className="block w-full text-left px-4 py-2 hover:bg-gray-100">
                Ajustes
              </button>
              <button className="block w-full text-left px-4 py-2 text-red-600 hover:bg-gray-100">
                Salir
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
