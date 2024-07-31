<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6">
        <service-selector
          :services="services"
          :selected-service="selectedService"
          @update:selectedService="updateSelectedService"
          @service-changed="fetchSchedule"
        ></service-selector>
      </v-col>
      <v-col cols="12" sm="6">
        <week-selector
          :weeks="weeks"
          :selected-week="selectedWeek"
          @update:selectedWeek="updateSelectedWeek"
          @week-changed="fetchSchedule"
        ></week-selector>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <engineer-hours
          :engineers="engineers"
          :total-hours-per-week="totalHoursPerWeek"
        ></engineer-hours>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <schedule-table :schedule="schedule"></schedule-table>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import ServiceSelector from '../../components/ServiceSelector.vue';
import WeekSelector from '../../components/WeekSelector.vue';
import EngineerHours from '../../components/EngineerHours.vue';
import ScheduleTable from '../../components/ScheduleTable.vue';

export default {
  components: {
    ServiceSelector,
    WeekSelector,
    EngineerHours,
    ScheduleTable,
  },
  props: {
    services: Array,
    weeks: Array,
    engineers: Array
  },
  data() {
    return {
      selectedService: this.services[0]?.id || null,
      selectedWeek: this.weeks[0]?.value || null,
      schedule: this.generateExampleSchedule()
    };
  },
  computed: {
    totalHoursPerWeek() {
      return 7 * 24;
    }
  },
  methods: {
    updateSelectedService(newService) {
      this.selectedService = newService;
    },
    updateSelectedWeek(newWeek) {
      this.selectedWeek = newWeek;
    },
    fetchSchedule() {
      const exampleSchedule = this.generateExampleSchedule();
      this.schedule = exampleSchedule;
    },
    generateExampleSchedule() {
      const schedule = {};
      const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
      const hours = [
        '10:00-11:00', '11:00-12:00', '12:00-13:00', '13:00-14:00', '14:00-15:00', '15:00-16:00',
        '16:00-17:00', '17:00-18:00', '18:00-19:00', '19:00-20:00', '20:00-21:00', '21:00-22:00',
        '22:00-23:00', '23:00-00:00'
      ];

      days.forEach(day => {
        schedule[day] = {};
        hours.forEach(hour => {
          schedule[day][hour] = { engineer: null };
        });
      });

      schedule['Lunes']['10:00-11:00'] = { engineer: 'Ernesto' };
      schedule['Lunes']['11:00-12:00'] = { engineer: 'Bárbara' };
      schedule['Sábado']['14:00-15:00'] = { engineer: 'Benjamín' };
      schedule['Sábado']['15:00-16:00'] = { engineer: '⚠' };

      return schedule;
    }
  },
  mounted() {
    this.fetchSchedule();
  }
};
</script>

<style scoped>
</style>
