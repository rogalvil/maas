<template>
  <v-select
    v-model="internalSelectedService"
    :items="services"
    item-title="name"
    item-value="id"
    @change="onServiceChange"
    density="compact"
  ></v-select>
</template>

<script>
export default {
  props: {
    services: {
      type: Array,
      required: true
    },
    selectedService: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      internalSelectedService: this.selectedService
    };
  },
  watch: {
    selectedService(newValue) {
      this.selectedService = newValue;
    }
  },
  methods: {
    onServiceChange(event) {
      this.$emit('update:selectedService', event);
      this.$emit('service-changed', event);
    }
  }
};
</script>

<style scoped>
</style>
