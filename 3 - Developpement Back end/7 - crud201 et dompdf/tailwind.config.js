/** @type {import('tailwindcss').Config} */
const colors = require('tailwindcss/colors')
export default {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
  ],
  theme: {

          colors: {
            transparent: 'transparent',
            current: 'currentColor',
            black: colors.black,
            white: colors.white,
            red: colors.red,
            orange: colors.orange,
            yellow: colors.yellow,
            green: colors.green,
            teal: colors.teal,
            blue: colors.blue,
            indigo: colors.indigo,
            purple: colors.purple,
            pink: colors.pink,
            gray: colors.gray,
            emerald: colors.emerald,
            indigo: colors.indigo,
            yellow: colors.yellow,
          },
        },

  plugins: [],
}

