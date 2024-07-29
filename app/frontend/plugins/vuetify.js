import { createVuetify } from "vuetify";
import { aliases, mdi } from "vuetify/iconsets/mdi-svg";
import "vuetify/styles";

const myCustomLightTheme = {
  dark: false,
  colors: {
    background: '#FFFFFF',
    surface: '#FFFFFF',
    primary: '#2196F3', // Blue
    secondary: '#03A9F4', // Light blue
    accent: '#82B1FF', // Light blue accent
    error: '#FF5252', // Red
    info: '#2196F3', // Blue
    success: '#4CAF50', // Green
    warning: '#FB8C00', // Orange
    black: '#000000', // Black
    grey: '#9E9E9E', // Grey
  },
};

export default createVuetify({
  theme: {
    defaultTheme: 'myCustomLightTheme',
    themes: {
      myCustomLightTheme,
    },
  },
  icons: {
    defaultSet: "mdi",
    aliases,
    sets: {
      mdi,
    },
  },
});
