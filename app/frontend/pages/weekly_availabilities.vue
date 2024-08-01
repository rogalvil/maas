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
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import ServiceSelector from '../components/ServiceSelector.vue';
import WeekSelector from '../components/WeekSelector.vue';

export default {
  components: {
    ServiceSelector,
    WeekSelector,
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
    }
  },
  data() {
    return {
      selectedService: parseInt(new URLSearchParams(window.location.search).get('service_id')) || this.services[0]?.id || null,
      selectedWeek: parseInt(new URLSearchParams(window.location.search).get('week')) || this.getCurrentWeek().value || null,
      selectedYear: parseInt(new URLSearchParams(window.location.search).get('year')) || this.getCurrentWeek().year || null,
      schedule: {},
    };
  },
  computed: {
    totalHoursPerWeek() {
      const selectedService = this.services.find(service => service.id === this.selectedService);
      if (!selectedService) return 0;
      const contractSchedules = selectedService.contract_schedules;
      let totalHours = 0;
      contractSchedules.forEach(schedule => {
        totalHours += schedule.end_time - schedule.start_time;
      });
      return totalHours;
    }
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
    // fetchSchedule() {
    //   const selectedService = this.services.find(service => service.id === this.selectedService);
    //   if (selectedService) {
    //     const days = this.extractContractSchedule(selectedService.contract_schedules);
    //     // const hoursRange = this.calculateHoursRange(days);
    //     // this.schedule = this.generateSchedule(days, hoursRange);
    //     // this.assignEngineersToSchedule(this.workSchedules);
    //     // this.itemsPerPage = hoursRange.max - hoursRange.min + 1;
    //   }
    // },
    extractContractSchedule(contractSchedules) {
      const days = {};
      contractSchedules.forEach(schedule => {
        days[schedule.day] = [schedule.start_time, schedule.end_time];
      });
      return days;
    },
    // generateSchedule(days, hoursRange) {
    //   const schedule = {};
    //   Object.keys(days).forEach(day => {
    //     schedule[day] = {};
    //     for (let hour = hoursRange.min; hour < hoursRange.max; hour++) {
    //       if (hour >= days[day][0] && hour < days[day][1]) {
    //         schedule[day][hour] = null;
    //       } else {
    //         schedule[day][hour] = { engineer: '-', color: 'grey' };
    //       }
    //     }
    //   });
    //   return schedule;
    // },
    // assignEngineersToSchedule(workSchedules) {
    //   workSchedules.forEach(workSchedule => {
    //     const day_of_week_name = workSchedule.day_of_week_name;
    //     const hour = workSchedule.hour;
    //     const engineer = workSchedule.engineer;
    //     const color = workSchedule.color;
    //     if (engineer) {
    //       this.schedule[day_of_week_name][hour] = { engineer: engineer, color: color };
    //     }
    //   });
    // },
    // calculateHoursRange(days) {
    //   return Object.values(days).reduce(
    //     (range, [start, end]) => {
    //       range.min = Math.min(range.min, start);
    //       range.max = Math.max(range.max, end);
    //       return range;
    //     },
    //     { min: 24, max: 0 }
    //   );
    // },
    redirectToUpdatedParams() {
      const url = new URL(window.location.href);
      url.searchParams.set('service_id', this.selectedService);
      url.searchParams.set('week', this.selectedWeek);
      url.searchParams.set('year', this.selectedYear);
      window.location.href = url.toString();
    }
  },
  mounted() {
    // this.fetchSchedule();
  }
};
</script>

<style scoped>
</style>
