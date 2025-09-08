module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#047857",   // --primary
          dark: "#064e3b",      // --primary-dark
          light: "#10b981",     // --primary-light
        },
        accent: "#3b82f6",
      }
    },
  },
  plugins: [],
}
