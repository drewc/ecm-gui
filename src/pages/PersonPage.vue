<template>
  <div v-if="person" class="q-pa-md row items-start q-gutter-md full-width">

  <q-list bordered class="full-width">
    <q-expansion-item
      default-opened
    >
    <template slot="header">
     <div style="width:100%" class="text-center row items-stretch">
       <div class="vertical-middle col-1 self-center">
         <q-icon name="person"
                 style="font-size: 150%" />
       </div>
        <q-card-section class="col">
           {{ person.full_name }}
        </q-card-section>
      </div>
    </template>
      <q-card>
        <q-card-section> section!!
        </q-card-section>
      </q-card>

    </q-expansion-item>

    <q-separator />

    <q-expansion-item v-if="Object.keys(person.policies).length > 0"
       group="somegroup" icon="perm_identity" label="Second" header-class="text-teal">
      <template slot="header">
        <div style="width:100%" class="text-center row items-stretch">
          <div class="vertical-middle col-1 self-center">
            <q-icon name="person"
                    style="font-size: 150%" />
          </div>
          <q-card-section class="col">
           Policies
          </q-card-section>
        </div>
    </template>
      <q-card>
        <q-card-section>
         <q-tree
           :nodes="policies"
           accordion
           node-key="label"
           :expanded.sync="expanded"
           />
          <q-tree
            :nodes="policies"
            node-key="policy_id"
            >
            <!-- <template v-slot:default-body="prop"> -->
            <!--   <policy v-model="prop.node" :link="true"/> -->
            <!--   <div v-if="prop.node.story"> -->
            <!--     <span class="text-weight-bold">This node has a story</span>: {{ prop.node.story }} -->
            <!--   </div> -->

            <!--   <span v-else class="text-weight-light text-black">  -->

            <!--     {{ prop.node.policy_id }}This is some default content.</span> -->
            <!-- </template> -->
            </q-tree>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
          commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
          eveniet doloribus ullam aliquid.
        </q-card-section>
      </q-card>
    </q-expansion-item>

    <q-separator />

    <q-expansion-item group="somegroup" icon="shopping_cart" label="Third" header-class="text-purple">
    <template slot="header">
     <div style="width:100%">
       Fooo
      </div>
    </template>
      <q-card>
        <q-card-section>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
          commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
          eveniet doloribus ullam aliquid.
        </q-card-section>
      </q-card>
    </q-expansion-item>

    <q-separator />

    <q-expansion-item
      group="somegroup"
      icon="bluetooth"
      label="Fourth"
      header-class="bg-teal text-white"
      expand-icon-class="text-white"
    >
    <template slot="header">
     <div style="width:100%">
       Fooo
      </div>
    </template>
      <q-card class="bg-teal-2">
        <q-card-section>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
          commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
          eveniet doloribus ullam aliquid.
        </q-card-section>
      </q-card>
    </q-expansion-item>
  </q-list>
  </div>
</template>
<script>
// import Policy from 'components/Policy'

export default {
  name: 'PersonPage',
  props: { id: String },
  // components: {
  //   Policy
  // },
  data () {
    return {
      person: undefined,
      error: false,
      policies: [
        {
          label: 'Satisfied customers (with avatar)',
          avatar: 'https://cdn.quasar.dev/img/boy-avatar.png',
          children: [
            {
              label: 'Good food (with icon)',
              icon: 'restaurant_menu',
              children: [
                { label: 'Quality ingredients' },
                { label: 'Good recipe' }
              ]
            },
            {
              label: 'Good service (disabled node with icon)',
              icon: 'room_service',
              children: [
                { label: 'Prompt attention' },
                { label: 'Professional waiter' }
              ]
            },
            {
              label: 'Pleasant surroundings (with icon)',
              icon: 'photo',
              children: [
                {
                  label: 'Happy atmosphere (with image)',
                  img: 'https://cdn.quasar.dev/img/logo_calendar_128px.png'
                },
                { label: 'Good table presentation' },
                { label: 'Pleasing decor' }
              ]
            }
          ]
        },
        {
          label: 'Good food (with icon)',
          icon: 'restaurant_menu',
          children: [
            { label: 'Quality ingredients' }
          ]
        }
      ]
    }
  },
  methods: {
    policyTree () {
      const pmap = Object.entries(this.person.policies)
      var ptree = []
      function mapPs (ps) {
        return [
          { label: 'Quality ingredients' }
        ]
      }

      for (const [ptype, ps] of pmap) {
        ptree.push({
          label: ptype,
          children: mapPs(ps)
        })
        console.log('got ' + ptype + ps.length)
      }
      console.log(ptree)
      return ptree
    },
    findPerson (id) {
      this.$axios.get('/json/person', { params: { 'id': id } })
        .then((response) => {
          this.person = response.data
          document.title = this.person.full_name + ' - ECM'
          // this.policies = this.policyTree()
        })
        .catch((e) => {
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Loading failed ' + e.message,
            icon: 'report_problem'
          })
        })
    }
  },
  created () { this.findPerson(this.id) },
  // mounted () {console.log(this.claim)},
  watch: {
    $route (to, from) {
      this.findPerson(this.id)
    }
  }
}
</script>
