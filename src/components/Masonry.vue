<template>
  <div class="masonry-wrapper">
    <div class="masonry">
      <slot/>
    </div>
  </div>
</template>
<style>
  .masonry-wrapper {
    max-width: 4096px;
    margin-right: auto;
    margin-left: auto;
  }
  .masonry {
    display: grid;
    grid-template-columns: repeat(1, minmax(100px,1fr));
    grid-gap: 6px;
    grid-auto-rows: 0;
  }
  @media only screen and (max-width: 1023px) and (min-width: 768px) {
    .masonry {
      grid-template-columns: repeat(2, minmax(100px,1fr));
    }
  }
  @media only screen and (min-width: 1024px) {
    .masonry {
      grid-template-columns: repeat(2, minmax(100px,1fr));
    }
  }
  .masonry-item, .masonry-content {
    border-radius: 4px;
    /* overflow: hidden; */
  }
  .masonry-item {
     margin-top: 0.15em;
    border: 1px solid rgba(0, 0, 0, 0.12);
    /* filter: drop-shadow(0px 2px 2px rgba(0, 0, 0, .3)); */
    /* transition: filter .25s ease-in-out; */
  }
  /* .masonry-item:hover { */
  /*   filter: drop-shadow(0px 5px 5px rgba(0, 0, 0, .3)); */
  /* } */
  .masonry-content {
    /* overflow: hidden; */
  }
  .masonry-item {
    color: #111111;
    background-color: white;
  }
</style>
<script>
function isElement (element) {
  return element instanceof Element || element instanceof HTMLDocument
}
function itemGrid (item) { if (isElement(item)) return item.closest('.masonry') }
function gridRowGap (grid) { if (isElement(grid)) return parseInt(window.getComputedStyle(grid).getPropertyValue('grid-row-gap')) }
function gridRowHeight (grid) { if (isElement(grid)) return parseInt(window.getComputedStyle(grid).getPropertyValue('grid-auto-rows')) }
function resizeMasonryItem (
  item,
  grid = itemGrid(item),
  rowGap = gridRowGap(grid),
  rowHeight = gridRowHeight(grid)
) {
  /* Get the grid object, its row-gap, and the size of its implicit rows */
  if (isElement(grid)) {
    var gridImagesAsContent = item.querySelector('img.masonry-content')

    /*
     * Spanning for any brick = S
     * Grid's row-gap = G
     * Size of grid's implicitly create row-track = R
     * Height of item content = H
     * Net height of the item = H1 = H + G
     * Net height of the implicit row-track = T = G + R
     * S = H1 / T
     */
    console.log((item.querySelector('.masonry-content').getBoundingClientRect().height + rowGap))
    var rowSpan = Math.ceil((item.querySelector('.masonry-content').getBoundingClientRect().height + rowGap) / (rowHeight + rowGap))

    /* Set the spanning as calculated above (S) */
    item.style.gridRowEnd = 'span ' + rowSpan
    if (gridImagesAsContent) {
      item.querySelector('img.masonry-content').style.height = item.getBoundingClientRect().height + 'px'
    }
  }
}
/**
 * Set appropriate spanning to any masonry item
 *
 * Get different properties we already set for the masonry, calculate
 * height or spanning for any cell of the masonry grid based on its
 * content-wrapper's height, the (row) gap of the grid, and the size
 * of the implicit row tracks.
 *
 * @param item Object A brick/tile/cell inside the masonry
 */
function resizeMasonryItem1 (
  item,
  grid = item.closest('.masonry'),
  rowGap = gridRowGap(grid)
) {
  /* Get the grid object, its row-gap, and the size of its implicit rows */
  var rowHeight = parseInt(window.getComputedStyle(grid).getPropertyValue('grid-auto-rows'))

  /*
   * Spanning for any brick = S
   * Grid's row-gap = G
   * Size of grid's implicitly create row-track = R
   * Height of item content = H
   * Net height of the item = H1 = H + G
   * Net height of the implicit row-track = T = G + R
   * S = H1 / T
   */
  var rowSpan = Math.ceil((item.querySelector('.masonry-content').getBoundingClientRect().height + rowGap) / (rowHeight + rowGap))

  /* Set the spanning as calculated above (S) */
  item.style.gridRowEnd = 'span ' + rowSpan
}
function hideBricks () {
  var allItems = document.querySelectorAll('.masonry-item')
  for (var i = 0; i < allItems.length; i++) {
    allItems[i].style.opacity = '20%'
  }
}

/**
 * Apply spanning to all the masonry items
 *
 * Loop through all the items and apply the spanning to them using
 * `resizeMasonryItem()` function.
 *
 * @uses resizeMasonryItem
 * @link https://w3bits.com/css-grid-masonry/
 */
function resizeAllMasonryItems (grid = document.getElementsByClassName('masonry')[0]) {
  // Get all item class objects in one list
  var allItems = document.querySelectorAll('.masonry-item')
  /*
   * Loop through the above list and execute the spanning function to
   * each list-item (i.e. each masonry item)
   */
  if (allItems) {
    for (var i = 0; i < allItems.length; i++) {
      resizeMasonryItem1(allItems[i])
    }
  }
}

/**
 * Resize the items when all the images inside the masonry grid
 * finish loading. This will ensure that all the content inside our
 * masonry items is visible.
 *
 * @uses ImagesLoaded
 * @uses resizeMasonryItem
 * @link https://w3bits.com/css-grid-masonry/
 */
// function waitForImages() {
//   //var grid = document.getElementById("masonry");
//   var allItems = document.querySelectorAll('.masonry-item');
//   if( allItems ) {
//     for(var i=0;i<allItems.length;i++){
//       imagesLoaded( allItems[i], function(instance) {
//         var item = instance.elements[0];
//         resizeMasonryItem(item);
//         console.log("Waiting for Images");
//       } );
//     }
//   }
// }

/* Resize all the grid items on the load and resize events */
var masonryEvents = ['load', 'resize']
masonryEvents.forEach(function (event) {
  window.addEventListener(event, resizeAllMasonryItems)
})

/* Do a resize once more when all the images finish loading */
// waitForImages();

export default {
  name: 'Masonry',
  mounted () {
    resizeAllMasonryItems()
  },
  methods: {
    resizeMasonryItem,
    resizeMasonryItem1,
    layBricks () {
      console.log()
      resizeAllMasonryItems()
    },
    hideBricks () {
      hideBricks()
    }
  }
}
</script>
