<template>
  <div id="app">
    <h2>Blingy</h2>

    <button id="start" @click="go">Go</button>
  </div>
</template>


<script lang="ts">
import Vue from 'vue';
import Simulation, { ClothToEnchantingMatsShuffleSimulation } from "./simulation";

export default Vue.extend({
  name: 'app',
  components: {
  },
  methods: {
    go: () => {
      // loop through simulations
      // for each simulation
      let simulation = new ClothToEnchantingMatsShuffleSimulation()
      simulation.run()
      // end for each
    }
  }
});
</script>

<style lang="scss">
* {
  box-sizing: border-box;
}
html,body {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
}
#app {
  $color: #2c3e50;

  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

  color: $color;
  border: solid 2px $color;
  padding: 20px;
  margin: 20px;
}
</style>
