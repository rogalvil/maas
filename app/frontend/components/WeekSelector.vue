<template>
  <v-select
    label="Selecciona una semana"
    v-model="internalSelectedWeek"
    :items="weeks"
    item-title="label"
    item-value="value"
    @update:modelValue="onWeekChange"
    density="compact"
  ></v-select>
  <div>{{ weekDetails }}</div>
</template>

<script>
export default {
  props: {
    weeks: {
      type: Array,
      required: true
    },
    selectedWeek: {
      type: Number,
      required: true
    }
  },
  data() {
    console.log(this.selectedWeek);
    return {
      internalSelectedWeek: this.selectedWeek
    };
  },
  computed: {
    weekDetails() {
      const week = this.weeks.find(w => w.value === this.internalSelectedWeek);
      return week ? `Del ${week.start_date} al ${week.end_date}` : '';
    }
  },
  methods: {
    onWeekChange(event) {
      this.$emit('update:selectedWeek', event);
    }
  }
};
</script>

<style scoped>
</style>
