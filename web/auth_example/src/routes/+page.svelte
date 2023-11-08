<!-- Script -->
<script>
  console.log("+page.svelte /")

  export let data;  

  async function get_message() {
    console.log('get_message()')
    const res = await fetch('/api', {method: 'GET'})
    console.log(res)
  }
</script>


<!-- Markup -->
<div class="h-full flex flex-col justify-center items-center self-center">
  {#if data.user}
    <h1>User is logged in</h1>
  {:else}
    <h1>User is logged out</h1>
  {/if}
  <button on:click={get_message} class="btn variant-filled-primary">Get Message Data</button>
</div>
