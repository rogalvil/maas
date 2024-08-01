<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6">
        <v-row v-for="day in firstColumnDays" :key="day">
          <v-col cols="12">
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
                      {{ formatDate(day) }}
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
                <v-chip :color="isAnyAssigned(day, item.hour)  ? 'green' : 'red'">
                  {{ item.hour }}:00 - {{ item.hour + 1 }}:00
                </v-chip>
              </template>
              <template v-for="engineer in engineers" :key="engineer.name" v-slot:[`item.${engineer.name}`]="{ item }">
                <v-checkbox-btn
                  :model-value="isAvailable(day, item.hour, engineer.name)"
                  @change="toggleAvailability(day, item.hour, engineer.name)"
                  density="compact"
                ></v-checkbox-btn>
              </template>
            </v-data-table>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="12" sm="6">
        <v-row v-for="day in secondColumnDays" :key="day">
          <v-col cols="12">
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
                      {{ formatDate(day) }}
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
                <v-chip :color="isAnyAssigned(day, item.hour) ? 'green' : 'red'">
                  {{ item.hour }}:00 - {{ item.hour + 1 }}:00
                </v-chip>
              </template>
              <template v-for="engineer in engineers" :key="engineer.name" v-slot:[`item.${engineer.name}`]="{ item }">
                <v-checkbox-btn
                  :model-value="isAvailable(day, item.hour, engineer.name)"
                  @change="toggleAvailability(day, item.hour, engineer.name)"
                  density="compact"
                ></v-checkbox-btn>
              </template>
            </v-data-table>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('[name="csrf-token"]').getAttribute('content');

export default {
  props: {
    engineerAvailabilities: {
      type: Array,
      required: true
    },
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
    },
    selectedService: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      availabilities: [...this.engineerAvailabilities],
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
    },
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
    toggleAvailability(day, hour, engineer) {
      const isAdded = this.updateAssignment(day, hour, engineer);
      if (isAdded) {
        this.addAvailability(day, hour, engineer);
      } else {
        this.removeAvailability(day, hour, engineer);
      }
    },
    prepareParams: function(day, hour, engineer) {
      const enginerId = this.engineers.find(e => e.name === engineer).id
      return {
        engineer_id: enginerId,
        service_id: this.selectedService,
        year: this.selectedYear,
        week: this.selectedWeek,
        day_of_week: this.dayMapping(day),
        hour: hour,
      };
    },
    addAvailability(day, hour, engineer) {
      const params = this.prepareParams(day, hour, engineer);
      axios.post('/engineer_availabilities/toggle', {
        ...params,
        available: 'create'
      })
      .catch(error => {
        console.error('Error creating availability', error);
      });
    },
    removeAvailability(day, hour, engineer) {
      const params = this.prepareParams(day, hour, engineer);
      axios.post('/engineer_availabilities/toggle', {
        ...params,
        available: 'destroy'
      })
      .catch(error => {
        console.error('Error removing availability', error);
      })
    },
    updateAssignment(day, hour, engineer) {
      const availabilityIndex = this.availabilities.findIndex(avail =>
        avail.day_of_week_name === day &&
        avail.hour === hour &&
        avail.engineer === engineer
      );
      let isAvailable = false;
      if (availabilityIndex !== -1) {
        this.availabilities.splice(availabilityIndex, 1);
      } else {
        const newAvailability = {
          year: this.selectedYear,
          week: this.selectedWeek,
          day_of_week_name: day,
          hour: hour,
          engineer: engineer,
        };
        this.availabilities.push(newAvailability);
        isAvailable = true;
      }
      this.$forceUpdate();
      return isAvailable;
    },
    isAvailable(day, hour, engineerName) {
      return this.availabilities.some(avail =>
        avail.day_of_week_name === day &&
        avail.hour === hour &&
        avail.engineer === engineerName
      );
    },
    isAnyAssigned(day, hour) {
      return this.availabilities.some(avail =>
        avail.day_of_week_name === day && avail.hour === hour
      );
    },
    capitalize(str) {
      return str.charAt(0).toUpperCase() + str.slice(1);
    },
    formatDate(day) {
      const date = new Date(this.selectedYear, 0, (this.selectedWeek - 1) * 7 + this.dayMapping(day));
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
      const engineer = this.engineers.find(engineer => engineer.name === engineerName);
      return engineer ? engineer.color : null;
    }
  },
  watch: {
    availabilities: {
      handler() {
        this.$forceUpdate();
      },
      deep: true
    }
  }
};
</script>

<style scoped>
</style>
