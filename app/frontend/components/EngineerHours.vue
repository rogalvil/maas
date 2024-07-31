<template>
  <v-data-table
    :headers="headers"
    :items="engineersWithUnassigned"
    density="compact"
    hide-default-footer
    hide-default-header
  >
    <template v-slot:[`item.assigned_hours`]="{ item }">
      <span>{{ item.assigned_hours }}</span>
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
        { text: 'Ingeniero', value: 'name' },
        { text: 'Horas Asignadas', value: 'assigned_hours' }
      ]
    };
  },
  computed: {
    engineersWithUnassigned() {
      const assignedHours = this.internalEngineers.reduce((sum, engineer) => sum + (engineer.assigned_hours || 0), 0);
      const unassignedHours = this.totalHoursPerWeek - assignedHours;
      const engineers = [...this.internalEngineers.map(engineer => ({
        ...engineer,
        assigned_hours: engineer.assigned_hours || 0
      }))];
      engineers.push({ id: 'unassigned', name: 'Sin asignar', assigned_hours: unassignedHours });
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
