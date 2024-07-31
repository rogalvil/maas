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
        <schedule-table :schedule="schedule" :items-per-page="itemsPerPage"></schedule-table>
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
      schedule: {},
      itemsPerPage: 0
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
      this.updateSchedule();
    },
    updateSchedule() {
      const days = {
        monday: [18, 24],
        tuesday: [16, 22],
        wednesday: [16, 24],
        thursday: [18, 24],
        friday: [18, 23],
        saturday: [10, 24],
        sunday: [12, 20]
      };
      const hoursRange = this.calculateHoursRange(days);
      this.schedule = this.generateExampleSchedule(days, hoursRange);
      this.itemsPerPage = hoursRange.max - hoursRange.min + 1;
    },
    generateExampleSchedule(days, hoursRange) {
      const schedule = {};

      Object.keys(days).forEach(day => {
        schedule[day] = {};
        console.log(hoursRange.min, hoursRange.max);
        for (let hour = hoursRange.min; hour < hoursRange.max; hour++) {
          if (hour >= days[day][0] && hour < days[day][1]) {
            schedule[day][hour] = { engineer: null };
          } else {
            schedule[day][hour] = { engineer: '-' };
          }
        }
      });

      schedule['monday'][18] = { engineer: 'Ernesto' };
      schedule['monday'][19] = { engineer: 'Bárbara' };
      schedule['tuesday'][20] = { engineer: 'Ernesto' };
      schedule['friday'][19] = { engineer: 'Benjamín' };
      schedule['friday'][20] = { engineer: 'Bárbara' };
      schedule['saturday'][14] = { engineer: 'Benjamín' };

      return schedule;
    },
    calculateHoursRange(days) {
      return Object.values(days).reduce(
        (range, [start, end]) => {
          range.min = Math.min(range.min, start);
          range.max = Math.max(range.max, end);
          return range;
        },
        { min: 24, max: 0 }
      );
    },
  },
  mounted() {
    this.fetchSchedule();
  }
};
</script>

<style scoped>
</style>
