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
      <v-chip :color="getEngineerColor(value)"> {{ value }} </v-chip>
    </template>
    <!-- <template v-slot:item="{ item }">
      <tr>
        <td>{{ item.hour }}:00 - {{ item.hour +1 }}:00</td>
        <td v-for="day in days" :key="day">
          <v-chip
            v-if="item.schedule[day]"
            :color="getEngineerColor(item.schedule[day].engineer)"
          >
            {{ item.schedule[day].engineer || '⚠' }}
          </v-chip>
        </td>
      </tr>
    </template> -->
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
          entry[day] = this.schedule[day][hour]?.engineer || '⚠';
        });
        return entry;
      });
    }
    // formattedSchedule() {
    //   const hours = Array.from(new Set(Object.values(this.schedule).flatMap(day => Object.keys(day).map(Number)))).sort((a, b) => a - b);
    //   return hours.map(hour => ({
    //     hour,
    //     schedule: Object.fromEntries(this.days.map(day => [day, this.schedule[day][hour]]))
    //   }));
    // }
  },
  methods: {
    getEngineerColor(engineer) {
      const engineerColors = {
        Ernesto: 'green',
        Bárbara: 'purple',
        Benjamín: 'blue',
        '-': 'grey'
      };
      return engineerColors[engineer] || 'red';
    }
  }
};
</script>

<style scoped>
</style>

<!-- <template>
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
</style> -->
