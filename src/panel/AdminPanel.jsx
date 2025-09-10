import React, { useState } from 'react';
import { Users, Settings, Gift } from 'lucide-react';

export default function AdminPanel() {
  const [users, setUsers] = useState([
    { id: 1, name: 'Juan Pérez', role: 'student' },
    { id: 2, name: 'María López', role: 'teacher' },
  ]);

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <header className="mb-6">
        <h1 className="text-3xl font-bold">Panel de Administrador</h1>
        <p className="text-gray-600">Gestión de usuarios y roles</p>
      </header>

      <section className="mb-6">
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <Users className="w-6 h-6"/> Usuarios
        </h2>
        <div className="space-y-2">
          {users.map(u => (
            <div key={u.id} className="bg-white rounded-lg p-4 shadow flex justify-between items-center">
              <span>{u.name}</span>
              <span className="font-medium">{u.role}</span>
            </div>
          ))}
        </div>
      </section>

      <section>
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <Settings className="w-6 h-6"/> Configuración
        </h2>
        <div className="bg-white rounded-lg p-6 shadow">
          <p>Opciones de administración global y recompensas <Gift className="inline w-5 h-5 ml-2"/></p>
        </div>
      </section>
    </div>
  );
}
