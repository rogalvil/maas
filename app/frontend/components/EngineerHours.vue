<template>
  <v-data-table
    :headers="headers"
    :items="engineersWithUnassigned"
    hide-default-footer
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
      localEngineers: this.engineers,
      headers: [
        { text: 'Ingeniero', value: 'name' },
        { text: 'Horas Asignadas', value: 'assigned_hours' }
      ]
    };
  },
  computed: {
    engineersWithUnassigned() {
      const assignedHours = this.localEngineers.reduce((sum, engineer) => sum + (engineer.assigned_hours || 0), 0);
      const unassignedHours = this.totalHoursPerWeek - assignedHours;
      const engineers = [...this.localEngineers.map(engineer => ({
        ...engineer,
        assigned_hours: engineer.assigned_hours || 0
      }))];
      engineers.push({ id: 'unassigned', name: 'Sin asignar', assigned_hours: unassignedHours });
      return engineers;
    }
  },
  watch: {
    engineers(newValue) {
      this.localEngineers = newValue;
    }
  }
};
</script>

<style scoped>
.v-data-table >>> thead {
  display: none;
}
</style>
