<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6">
        <service-selector
          :services="services"
          :selected-service="selectedService"
          @update:selectedService="updateSelectedService"
        ></service-selector>
      </v-col>
      <v-col cols="12" sm="6">
        <week-selector
          :weeks="weeks"
          :selected-week="selectedWeek"
          @update:selectedWeek="updateSelectedWeek"
        ></week-selector>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <weekly-schedule
          :engineer-availabilities="engineerAvailabilities"
          :contract-schedule="contractSchedule"
          :engineers="engineers"
          :selected-week="selectedWeek"
          :selected-year="selectedYear"
          :selected-service="selectedService"
        ></weekly-schedule>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import ServiceSelector from '../components/ServiceSelector.vue';
import WeekSelector from '../components/WeekSelector.vue';
import WeeklySchedule from '../components/WeeklySchedule.vue';

export default {
  components: {
    ServiceSelector,
    WeekSelector,
    WeeklySchedule
  },
  props: {
    services: {
      type: Array,
      required: true
    },
    weeks: {
      type: Array,
      required: true
    },
    engineers: {
      type: Array,
      required: true
    },
    workSchedules: {
      type: Array,
      required: true
    },
    contractSchedule: {
      type: Array,
      required: true
    },
    engineerAvailabilities: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      selectedService: parseInt(new URLSearchParams(window.location.search).get('service_id')) || this.services[0]?.id || null,
      selectedWeek: parseInt(new URLSearchParams(window.location.search).get('week')) || this.getCurrentWeek().value || null,
      selectedYear: parseInt(new URLSearchParams(window.location.search).get('year')) || this.getCurrentWeek().year || null,
    };
  },
  computed: {
  },
  methods: {
    getCurrentWeek() {
      const currentDate = new Date();
      const currentWeek = this.weeks.find(week => {
        const startDate = new Date(week.start_date.split('/').reverse().join('-'));
        const endDate = new Date(week.end_date.split('/').reverse().join('-'));
        return currentDate >= startDate && currentDate <= endDate;
      });
      return currentWeek || this.weeks[0];
    },
    updateSelectedService(newService) {
      this.selectedService = newService;
      this.redirectToUpdatedParams();
    },
    updateSelectedWeek(newWeek) {
      this.selectedWeek = newWeek;
      this.selectedYear = this.weeks.find(w => w.value === newWeek).year;
      this.redirectToUpdatedParams();
    },
    redirectToUpdatedParams() {
      const url = new URL(window.location.href);
      url.searchParams.set('service_id', this.selectedService);
      url.searchParams.set('week', this.selectedWeek);
      url.searchParams.set('year', this.selectedYear);
      window.location.href = url.toString();
    }
  },
  mounted() {
  }
};
</script>

<style scoped>
</style>
