<template>
  <div id="app">
    <img src="./assets/logo.png">
    <h1>{{ msg }}</h1><br><br>
    <input type="url" placeholder="Enter the URL to be shortened" id="urlinput" v-model="url" autofocus>&nbsp;&nbsp;&nbsp;&nbsp;
    <button @click="shorturl" class="btn btn-primary">Short The URL</button><br><br>
    <div class="row">
    <div class="col-md-4 col-md-offset-4">
    <div class="panel panel-default">
    <div class="panel-body"><h4>{{shortened_url}}</h4></div>
  </div>
    <button v-clipboard:copy="shortened_url"
      v-clipboard:success="onCopy"
      v-clipboard:error="onError" data-toggle="tooltip" data-placement="top" title="Copy to clipboard" v-bind:class="btn_class">{{btn_text}}</button>
  </div>
  </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  created(){
    var hashh = window.location.hash.substr(1)
    let final_endpoint = this.endpoint + "/" + hashh
    if (window.location.hash != "") {
      axios.get(final_endpoint)
      .then(function (response) {
        response = response.data.result.data;
        if (response != null) {
                window.location.href = response;
            }
      })
      .catch(function (error) {
        console.log(error);
      })
    }

  },
  name: 'app',
  data () {
    return {
      msg: '✂️🔗 URL shortner ✂️🔗',
      endpoint: 'https://www.jsonstore.io/aaed0aa727e4ec0ca70692dffc3888cda54516f4715b14d7845a7aba2553b33b',
      url : "",
      shortened_url: "",
      btn_class:"btn btn-primary",
      btn_text:"Copy URL",
      hashh: window.location.hash.substr(1)
    }
  },
  methods: {
    onCopy: function (e) {
      this.btn_class = "btn btn-success"
      this.btn_text = "URL Copied!"
      setTimeout(function(){
        this.btn_class = "btn btn-primary"
        this.btn_text = "Copy URL"
      }.bind(this),4000)
    },
    onError: function (e) {
      alert('Failed to copy texts')
    },
    getrandom() {
    var random_string = Math.random().toString(32).substring(2, 5) + Math.random().toString(32).substring(2, 5);
    return random_string;
    },
    geturl() {
    var url = this.url
    var protocol_ok = url.startsWith("http://") || url.startsWith("https://") || url.startsWith("ftp://");
    if (!protocol_ok) {
        newurl = "http://" + url;
        return newurl;
    } else {
        return url;
    }
    },
    genhash() {
    if (window.location.hash == "") {
        window.location.hash = this.getrandom();
        console.log("window.location.hash", window.location.hash);
        
    }
    },
    send_request(url) {
    this.url = url;
    this.hashh = window.location.hash.substr(1)
        axios.post(this.endpoint + "/" + this.hashh, {data:this.url})
      .then(function (response) {
      })
      .catch(function (error) {
        console.log("on error in post request......",error);
      })
      
    },
    shorturl() {
    var longurl = this.geturl();
    this.genhash();
    this.send_request(longurl);
    this.shortened_url = window.location
    }
  }
  }
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
