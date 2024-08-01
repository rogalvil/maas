<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6">
        <v-row v-for="day in firstColumnDays" :key="day">
          <v-col cols="12">
            <h3>{{ formatDate(day) }}</h3>
            <v-data-table
              :headers="headers"
              :items="formattedSchedule(day)"
              :items-per-page="24"
              density="compact"
              hide-default-footer
            >
              <template v-slot:headers="{ columns }">
                <tr>
                  <template v-for="column in columns" :key="column.key">
                    <th v-if="column.key === 'hour'">
                      {{ column.title }}
                    </th>
                    <th v-else>
                      <v-chip :color="engineerColor(column.key)">
                        {{ column.title }}
                      </v-chip>
                    </th>
                  </template>
                </tr>
              </template>
              <template v-slot:item.hour="{ item }">
                <v-chip :color="item.assigned ? 'green' : 'red'">
                  {{ item.hour }}:00 - {{ item.hour + 1 }}:00
                </v-chip>
              </template>
              <template v-for="engineer in engineers" :key="engineer.name" v-slot:[`item.${engineer.name}`]="{ item }">
                <v-checkbox-btn v-model="item[engineer.name]" @change="updateAssignment(day, item.hour, engineer.name)" density="compact"></v-checkbox-btn>
              </template>
            </v-data-table>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="12" sm="6">
        <v-row v-for="day in secondColumnDays" :key="day">
          <v-col cols="12">
            <h3>{{ formatDate(day) }}</h3>
            <v-data-table
              :headers="headers"
              :items="formattedSchedule(day)"
              :items-per-page="24"
              density="compact"
              hide-default-footer
            >
              <template v-slot:headers="{ columns }">
                <tr>
                  <template v-for="column in columns" :key="column.key">
                    <th v-if="column.key === 'hour'">
                      {{ column.title }}
                    </th>
                    <th v-else>
                      <v-chip :color="engineerColor(column.key)">
                        {{ column.title }}
                      </v-chip>
                    </th>
                  </template>
                </tr>
              </template>
              <template v-slot:[`item.hour`]="{ item }">
                <v-chip :color="item.assigned ? 'green' : 'red'">
                  {{ item.hour }}:00 - {{ item.hour + 1 }}:00
                </v-chip>
              </template>
              <template v-for="engineer in engineers" :key="engineer.name" v-slot:[`item.${engineer.name}`]="{ item }">
                <v-checkbox-btn v-model="item[engineer.name]" @change="updateAssignment(day, item.hour, engineer.name)" density="compact"></v-checkbox-btn>
              </template>
            </v-data-table>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    contractSchedule: {
      type: Array,
      required: true
    },
    engineers: {
      type: Array,
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
  data() {
    return {
    };
  },
  computed: {
    firstColumnDays() {
      return ['monday', 'wednesday', 'friday', 'sunday'];
    },
    secondColumnDays() {
      return ['tuesday', 'thursday', 'saturday'];
    },
    headers() {
      return [
        { title: 'Hora', align: 'start', sortable: false, key: 'hour' },
        ...this.engineers.map(engineer => ({ title: engineer.name, align: 'center', sortable: false, key: engineer.name }))
      ];
    }
  },
  methods: {
    updateAssignment(day, hour, engineer) {
      this.$emit('update-assignment', { day, hour, engineer });
    },
    capitalize(str) {
      return str.charAt(0).toUpperCase() + str.slice(1);
    },
    formatDate(day) {
      const dayMapping = {
        monday: 1,
        tuesday: 2,
        wednesday: 3,
        thursday: 4,
        friday: 5,
        saturday: 6,
        sunday: 7
      };
      const date = new Date(this.selectedYear, 0, (this.selectedWeek - 1) * 7 + dayMapping[day]);
      return date.toLocaleDateString('es-ES', { weekday: 'long', day: '2-digit', month: 'long' });
    },
    formattedSchedule(day) {
      const daySchedule = this.contractSchedule.find(schedule => schedule.day === day);
      const formatted = [];
      if (daySchedule) {
        for (let hour = daySchedule.start_time; hour < daySchedule.end_time; hour++) {
          const entry = { hour };
          formatted.push(entry);
        }
      }
      return formatted;
    },
    engineerColor(engineerName) {
      console.log(engineerName);
      const engineer = this.engineers.find(engineer => engineer.name === engineerName);
      return engineer ? engineer.color : null;
    }
  }
};
</script>

<style scoped>
</style>
