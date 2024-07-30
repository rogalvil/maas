<template>
  <v-select
    v-model="selectedWeekInternal"
    :items="weeks"
    item-title="label"
    item-value="value"
    @change="onWeekChange"
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
    return {
      selectedWeekInternal: this.selectedWeek
    };
  },
  watch: {
    selectedService(newValue) {
      this.selectedServiceInternal = newValue;
    }
  },
  computed: {
    weekDetails() {
      const week = this.weeks.find(w => w.value === this.selectedWeekInternal);
      return week ? `Del ${week.start_date} al ${week.end_date}` : '';
    }
  },
  methods: {
    onWeekChange(event) {
      this.$emit('update:selectedWeek', event);
      this.$emit('week-changed', event);
    }
  }
};
</script>

<style scoped>
</style>
