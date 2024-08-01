import * as Turbo from "@hotwired/turbo";
Turbo.start();

import { createApp, defineAsyncComponent } from "vue";
import TurbolinksAdapter from "vue-turbolinks";
import vuetify from "~/plugins/vuetify";

import App from "~/app";

const ConfirmedShifts = defineAsyncComponent(() => import("~/pages/confirmed_shifts"));
const WeeklyAvailabilities = defineAsyncComponent(() => import("~/pages/weekly_availabilities"));
console.log(WeeklyAvailabilities);

document.addEventListener("turbo:load", () => {
  const app = createApp({});

  app.use(TurbolinksAdapter);
  app.use(vuetify);

  app.component("App", App);
  app.component("ConfirmedShifts", ConfirmedShifts);
  app.component("WeeklyAvailabilities", WeeklyAvailabilities);

  app.mount("#app");
});
