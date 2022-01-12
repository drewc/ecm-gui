<script setup>

const fontFamilies = {
  "Cambria": "Cambria, Georgia, Palatino, Times New Roman, serif",
  "Trebuchet MS": "Trebuchet MS,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Tahoma,sans-serif",
  "DEFAULT": '-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji"'
}

const rtFontFamily = rt =>
      fontFamilies[rt.font.name] || fontFamilies['DEFAULT']

const argb2rgba = color =>
 '#' + color.argb.slice(2).concat(color.argb.slice(0,2))

const rtStyle = rt => {
  const style = {}
  style.fontFamily = rtFontFamily(rt)
  if (rt.font.underline) style.textDecoration = "underline"
  style.fontSize = '' + rt.font.size + 'pt'
  if (rt.font.color) style.color = argb2rgba(rt.font.color)
  if (rt.font.bold) style.fontWeight = "bold"
  return style
}



const props = defineProps({
    richText: Object
})
</script>

<template>
  <span v-for="rt in richText"
        :key="rt.text"
        :style="rtStyle(rt)">{{rt.text}}</span>
</template>
