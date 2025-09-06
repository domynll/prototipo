import React from 'react';

export default function VisitorPanel() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-sky-100 via-indigo-50 to-purple-100 p-6 flex flex-col items-center justify-center">
      <h1 className="text-4xl font-bold mb-4">Bienvenido a DidaktikApp</h1>
      <p className="text-lg text-gray-700 mb-6 text-center">
        Explora nuestro contenido educativo interactivo y aprende de manera divertida.
      </p>
      <div className="flex space-x-4">
        <button className="px-6 py-3 bg-green-500 text-white rounded-lg hover:bg-green-600 transition">Iniciar sesión</button>
        <button className="px-6 py-3 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition">Registrarse</button>
      </div>
    </div>
  );
}
