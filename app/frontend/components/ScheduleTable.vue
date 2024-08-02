<template>
  <v-data-table
    :headers="headers"
    :items="formattedSchedule"
    :items-per-page="itemsPerPage"
    hide-default-footer
    density="compact"
  >
    <template v-slot:item.hour="{ value }">
      {{ value }}:00 - {{ value +1 }}:00
    </template>
    <template v-for="day in days" :key="day" v-slot:[`item.${day}`]="{ value }">
      <v-chip :color="value.color"> {{ value.engineer }} </v-chip>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: {
    schedule: {
      type: Object,
      required: true
    },
    itemsPerPage: {
      type: Number,
      required: true
    },
    selectedWeek: {
      type: Number,
      required: true
    },
    selectedYear: {
      type: Number,
      required: true
    }
  },
  computed: {
    days() {
      return Object.keys(this.schedule);
    },
    headers() {
      return [
        { title: '', align: 'start', sortable: false, key: 'hour' },
        ...this.days.map(day => ({,
          title: this.formatDate(day),
          align: 'center',
          sortable: false,
          key: day
        }))
      ];
    },
    formattedSchedule() {
      const hours = Array.from(new Set(Object.values(this.schedule).flatMap(day => Object.keys(day).map(Number)))).sort((a, b) => a - b);
      return hours.map(hour => {
        const entry = { hour };
        this.days.forEach(day => {
          entry[day] = this.schedule[day][hour] || { engineer: '⚠', color: 'red' };
        });
        return entry;
      });
    }
  },
  methods: {
    dayMapping(day) {
      const mapping = {
        monday: 1,
        tuesday: 2,
        wednesday: 3,
        thursday: 4,
        friday: 5,
        saturday: 6,
        sunday: 7
      };
      return mapping[day];
    },
    formatDate(day) {
      console.log(day, this.selectedYear, this.selectedWeek, this.dayMapping(day));
      const date = new Date(this.selectedYear, 0, (this.selectedWeek - 1) * 7 + this.dayMapping(day));
      return date.toLocaleDateString('es-ES', { weekday: 'short', day: '2-digit', month: 'short' });
    },
  }
};
</script>

<style scoped>
</style>
