<template>
  <v-data-table
    :headers="headers"
    :items="formattedSchedule"
    :items-per-page="hours.length"
    hide-default-footer
    density="compact"
  >
    <template v-slot:item="{ item }">
      <tr>
        <td>{{ item.hour }}</td>
        <td v-for="day in days" :key="day">
          <v-chip
            v-if="item.schedule[day].engineer"
            :color="getEngineerColor(item.schedule[day].engineer)"
            class="ma-2"
          >
            {{ item.schedule[day].engineer || '⚠' }}
          </v-chip>
        </td>
      </tr>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: {
    schedule: {
      type: Object,
      required: true
    }
  },
  computed: {
    days() {
      return Object.keys(this.schedule);
    },
    hours() {
      return Object.keys(this.schedule[this.days[0]]);
    },
    headers() {
      return [
        { title: 'Hora', align: 'start', sortable: false, key: 'hour' },
        ...this.days.map(day => ({ title: day, align: 'start', sortable: false, key: day }))
      ];
    },
    formattedSchedule() {
      return this.hours.map(hour => ({
        hour,
        schedule: Object.fromEntries(this.days.map(day => [day, this.schedule[day][hour] || {}]))
      }));
    }
  },
  methods: {
    getEngineerColor(engineer) {
      // if (engineer === '⚠') return 'red';
      const engineerColors = {
        Ernesto: 'green',
        Bárbara: 'purple',
        Benjamín: 'blue'
      };
      return engineerColors[engineer] || 'gray';
    }
  }
};
</script>

<style scoped>
</style>
