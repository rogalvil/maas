<template>
  <v-select
    label="Selecciona un servicio"
    v-model="internalSelectedService"
    :items="services"
    item-title="name"
    item-value="id"
    @update:modelValue="onServiceChange"
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
  methods: {
    onServiceChange(event) {
      this.internalSelectedService = event;
      this.$emit('update:selectedService', event);
    }
  }
};
</script>

<style scoped>
</style>
