<template>
  <v-data-table
    :headers="headers"
    :items="engineersWithUnassigned"
    :items-per-page="engineersWithUnassigned.length"
    density="compact"
    hide-default-footer
    hide-default-header
  >
    <!-- <template v-slot:[`item.assigned_hours`]="{ item }">
      <span>{{ item.assigned_hours }}</span>
    </template> -->
    <template v-slot:[`item.assigned_hours`]="{ item }">
      <span>{{ item.assigned_hours }}</span>
    </template>
    <template v-slot:[`item.name`]="{ item }">
      <v-chip :color="item.color" dark>{{ item.name }}</v-chip>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: {
    engineers: {
      type: Array,
      required: true
    },
    totalHoursPerWeek: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      internalEngineers: this.engineers,
      headers: [
        { text: 'Name', value: 'name' },
        { text: 'Hours', value: 'hours' }
      ]
    };
  },
  computed: {
    engineersWithUnassigned() {
      const assignedHours = this.internalEngineers.reduce((sum, engineer) => sum + (engineer.hours || 0), 0);
      const unassignedHours = this.totalHoursPerWeek - assignedHours;
      const engineers = [...this.internalEngineers.map(engineer => ({
        ...engineer,
        assigned_hours: engineer.hours || 0
      }))];
      engineers.push({ id: 'unassigned', name: 'Sin asignar', hours: unassignedHours, color: 'red' });
      return engineers;
    }
  },
  watch: {
    engineers(newValue) {
      this.internalEngineers = newValue;
    }
  }
};
</script>

<style scoped>
</style>
