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
    engineers: Array,
    workSchedules: Array
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
    updateSelectedService(newService) {
      this.selectedService = newService;
    },
    updateSelectedWeek(newWeek) {
      this.selectedWeek = newWeek;
    },
    fetchSchedule() {
      const selectedService = this.services.find(service => service.id === this.selectedService);
      if (selectedService) {
        const days = this.extractContractSchedule(selectedService.contract_schedules);
        const hoursRange = this.calculateHoursRange(days);
        this.schedule = this.generateSchedule(days, hoursRange);
        console.log(this.schedule);
        console.log(this.workSchedules);
        this.assignEngineersToSchedule(this.workSchedules);
        this.itemsPerPage = hoursRange.max - hoursRange.min + 1;
      }
    },
    extractContractSchedule(contractSchedules) {
      const days = {};
      contractSchedules.forEach(schedule => {
        days[schedule.day] = [schedule.start_time, schedule.end_time];
      });
      return days;
    },
    generateSchedule(days, hoursRange) {
      const schedule = {};

      Object.keys(days).forEach(day => {
        schedule[day] = {};
        for (let hour = hoursRange.min; hour < hoursRange.max; hour++) {
          if (hour >= days[day][0] && hour < days[day][1]) {
            schedule[day][hour] = null;
          } else {
            schedule[day][hour] = { engineer: '-', color: 'grey' };
          }
        }
      });

      // schedule['monday'][18] = { engineer: 'Ernesto' };
      // schedule['monday'][19] = { engineer: 'Bárbara' };
      // schedule['tuesday'][20] = { engineer: 'Ernesto' };
      // schedule['friday'][19] = { engineer: 'Benjamín' };
      // schedule['friday'][20] = { engineer: 'Bárbara' };
      // schedule['saturday'][14] = { engineer: 'Benjamín' };

      return schedule;
    },
    assignEngineersToSchedule(workSchedules) {
      workSchedules.forEach(workSchedule => {
        const day_of_week_name = workSchedule.day_of_week_name;
        const hour = workSchedule.hour;
        const engineer = workSchedule.engineer;
        const color = workSchedule.color;
        if (engineer) {
          this.schedule[day_of_week_name][hour] = { engineer: engineer, color: color };
        }
      });
      console.log(this.schedule);
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
