// import { Cookies, openURL } from 'quasar'
import axios from 'axios'
import {
  Loading,
  Cookies,
  date,
  // optional!, for example below
  // with custom spinner
  QSpinnerGears
} from 'quasar'

import Masonry from 'components/Masonry'

function humanize (str) {
  var i, frags = str.split('_')
  for (i = 0; i < frags.length; i++) {
    frags[i] = frags[i].charAt(0).toUpperCase() + frags[i].slice(1)
  }
  return frags.join(' ')
}

if (!Element.prototype.matches) {
  Element.prototype.matches = Element.prototype.msMatchesSelector ||
    Element.prototype.webkitMatchesSelector
}

if (!Element.prototype.closest) {
  Element.prototype.closest = function (s) {
    var el = this
    do {
      if (Element.prototype.matches.call(el, s)) return el
      el = el.parentElement || el.parentNode
    } while (el !== null && el.nodeType === 1)
    return null
  }
}

export default {
  name: 'ecm',
  session: false,
  humanize: humanize,
  date: date,
  layBricks: function () {
    Masonry.methods.layBricks()
  },
  hideBricks: function () {
    Masonry.methods.hideBricks()
  },
  raiseComp: function (comp, n = 1024) {
    comp.$el.style.position = 'relative'
    comp.$el.style.zIndex = n
  },
  revealComp: function (comp) {
    if (comp.masonry) {
      Masonry.methods.layBricks()
    }
    comp.$el.style.position = 'unset'
    comp.$el.style.zIndex = 'unset'
  },

  findSessionPromise: function () {
    var ecm = this
    // fully custtomizable
    Loading.show({
      spinner: QSpinnerGears
    })
    return axios.get('/json/session', {
      withCredentials: true,
      validateStatus: function (status) {
        return status < 500
        // Reject only if the status code is greater than or equal to 500
      }
    })
      .then(function (response) {
        // handle success
        if (response.status === 200) {
          ecm.session = response.data
        }
        Loading.hide()
        return ecm.session
      })
  },
  loginUserPromise: function (u, p) {
    return axios.post('json/login', {
      u: u,
      p: p
    })
      .then((result) => {
        if (result.data.error === undefined) {
          Cookies.set(
            'ecm-login', result.data.id,
            {
              expires: '30d',
              path: '/'
            })
        }
        return result
      })
  }
}
