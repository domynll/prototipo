import React, { useState } from 'react';
import { Users, Book, BarChart3 } from 'lucide-react';

export default function TeacherPanel() {
  const [students, setStudents] = useState([
    { id: 1, name: 'Juan Pérez', progress: 80 },
    { id: 2, name: 'María López', progress: 60 },
  ]);

  return (
    <div className="min-h-screen bg-gray-100 p-6">
      <header className="mb-6">
        <h1 className="text-3xl font-bold">Panel de Profesor</h1>
        <p className="text-gray-600">Gestiona a tus estudiantes y su progreso</p>
      </header>

      <section className="mb-6">
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <Users className="w-6 h-6"/> Estudiantes
        </h2>
        <div className="space-y-4">
          {students.map(s => (
            <div key={s.id} className="bg-white rounded-lg p-4 shadow flex justify-between items-center">
              <span>{s.name}</span>
              <span className="font-semibold">{s.progress}% completado</span>
            </div>
          ))}
        </div>
      </section>

      <section>
        <h2 className="text-xl font-semibold mb-3 flex items-center gap-2">
          <BarChart3 className="w-6 h-6"/> Estadísticas generales
        </h2>
        <div className="bg-white rounded-lg p-6 shadow">
          {/* Aquí podrías poner gráficas con recharts o cualquier librería */}
          <p>Próximamente: gráficos de progreso de estudiantes</p>
        </div>
      </section>
    </div>
  );
}
