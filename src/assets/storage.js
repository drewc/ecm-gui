import localforage from 'localforage'

localforage.config({
  name: 'ECM GUI',
  storageName: 'ecmgui'
});

export const cache = localforage;

export default { localforage }
