import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // Exponer el servidor en la red local
    port: 5173        // Puedes cambiar el puerto si es necesario
  }
})
