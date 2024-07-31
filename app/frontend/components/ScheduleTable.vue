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
    }
  },
  computed: {
    days() {
      return Object.keys(this.schedule);
    },
    headers() {
      return [
        { title: 'Hour', align: 'start', sortable: false, key: 'hour' },
        ...this.days.map(day => ({ title: day.charAt(0).toUpperCase() + day.slice(1), align: 'center', sortable: false, key: day }))
      ];
    },
    formattedSchedule() {
      const hours = Array.from(new Set(Object.values(this.schedule).flatMap(day => Object.keys(day).map(Number)))).sort((a, b) => a - b);
      return hours.map(hour => {
        const entry = { hour };
        this.days.forEach(day => {
          // entry[day] = this.schedule[day][hour]?.engineer || '⚠';
          console.log(this.schedule[day][hour]);
          entry[day] = this.schedule[day][hour] || { engineer: '⚠', color: 'red' };
        });
        return entry;
      });
    }
  },
  methods: {
    // getEngineerColor(engineer) {
    //   const engineerColors = {
    //     Ernesto: 'green',
    //     Bárbara: 'purple',
    //     Benjamín: 'blue',
    //     '-': 'grey'
    //   };
    //   return engineerColors[engineer] || 'red';
    // }
  }
};
</script>

<style scoped>
</style>
