<template>
  <v-app id="vuetify-app">
    <v-app-bar app color="primary" dark>
      <v-btn text href="/" variant="plain">
        <v-toolbar-title>MaaS</v-toolbar-title>
      </v-btn>
    </v-app-bar>
    <v-main>
      <v-container fluid class="main-container">
        <slot></slot>
      </v-container>
    </v-main>
    <v-footer app color="primary" dark>
      <span class="white--text">&copy; 2024</span>
    </v-footer>
  </v-app>
</template>

<script>
export default {};
</script>

<style>
#vuetify-app {
  min-height: 100vh;
}
.main-container {
  padding-top: 20px;
}
</style>
