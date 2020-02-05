<template>
  <div id="app">
    <h2>Blingy</h2>

    <button id="start">Go</button>

    <div class="console">
    </div>
  </div>
</template>


<script lang="ts">
import Vue from 'vue';
import Simulation, { ClothToEnchantingMatsShuffleSimulation } from "./simulation";

function go() {
  // loop through simulations
  // for each simulation
  let simulation = new ClothToEnchantingMatsShuffleSimulation()
  simulation.run()
  // end for each
}

export default Vue.extend({
  name: 'app',
  components: {
  },
  mounted: () => {
    document.querySelector("#start").addEventListener("click", () => {
      go();
    })
  },
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

.console {
  margin-top: 2em;
  background: rgba(0, 0, 0, 0.7);
  padding: 10px;
  color: #f0f0f0;
  font-family: monospace;
  font-size: 1.5em;
  letter-spacing: 0.1em;
  height: 600px;
  overflow: auto;
}
</style>
