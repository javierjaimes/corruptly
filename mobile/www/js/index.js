/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
 
var geocoder;
var url = "http://lumba.lu/upload.php";
//var login_url = "http://lumba.lu/login.php";
var login_url = "http://corruptly.herokuapp.com/oauth/access_token";

var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // `load`, `deviceready`, `offline`, and `online`.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of `this` is the event. In order to call the `receivedEvent`
    // function, we must explicity call `app.receivedEvent(...);`
    onDeviceReady: function() {
        console.log('Received Event: deviceready');
        
        $(document).delegate('#report-page', 'pageinit', app.initReport);
        
        $('#login-form').on('submit', app.login);
        
        $(document).bind('mobileinit', function() {
            $.mobile.buttonMarkup.hoverDelay = 50;
        });
        
        var storage = window.localStorage;
        var token = storage.getItem("token");
        if(token)
          $.mobile.changePage('#main-page');
    },
    
    login: function(e) {
      console.log('login');
      
      e.preventDefault();
      
      $('.login-error').hide();
      
      if(!$('#username').val() || !$('#password').val()) {
        $('.login-error').show().text('Error: Ingrese usuario y contraseña');
        return;
      }
      
      $.post(login_url, {
          grant_type: "password",
          client_id: "50718adbe32ee70002000001",
          client_secret: "4c1817cc20c7ec460857e81cfb6ea3868e47342603e1415f5bb10a87a4040514",
          scope: "read write",
          redirect_uri: "http://movil.corruptly.co/auth",
          username: $('#username').val(),
          password: $('#password').val()
        },
      app.loginSuccess, 'json').error(app.loginError);
      
      return false;
    },
    
    loginSuccess: function(data) {
      var storage = window.localStorage;
      
      storage.setItem("token", data.access_token);
      
      $.ajaxSetup({ beforeSend : function(xhr, settings){
        this.url += this.url.indexOf("?") == -1 ? "?oauth_token="+data.access_token : "&oauth_token="+data.access_token;
        }
      });
            
      $.mobile.changePage('#main-page');
    },
    
    loginError: function() {
      $('.login-error').show().text('Error: Usuario o contraseña invalidos');
    },
    
    initReport: function() {
      console.log('Init');
      
      app.loadCandidates();
      app.attachEvidence();
      app.getLocation();
      
      $('#report-form').on('submit', app.submitForm);
    },
    
    loadCandidates: function() {
			$("#candidate").autocomplete({
				target: $('#suggestions'),
				source: [{value: 22, label: "Mockus"}, {value: 32, label: "Santos"}],
				callback: function(e) {
  				var candidate = $(e.currentTarget).data('autocomplete');
  				
  				$("#candidate_id").val(candidate.value);
  				$("#candidate").val(candidate.label);
  				$("#candidate").autocomplete('clear');
				},
				link: 'target.html?term=',
				minLength: 1
			});
		},
		
		attachEvidence: function() {
  		$("#take-picture-btn").on("tap", function(e) {
    		navigator.camera.getPicture(function(image_uri) { app.success('medium', image_uri, image_uri) }, app.handleError, { quality: 50, destinationType: navigator.camera.DestinationType.FILE_URI });
  		});
  		
  		$("#take-video-btn").on("tap", function(e) {
    		navigator.device.capture.captureVideo(function(media_files) { app.success("small", "img/46-movie-2.png", media_files[0].fullPath) }, app.handleError, {limit: 1});
  		});
  		
  		$("#attach-file-btn").on("tap", function(e) {
    		navigator.camera.getPicture(function(image_uri) { app.success("small", "img/68-paperclip.png", image_uri) }, app.handleError, { sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY, mediaType: navigator.camera.MediaType.ALLMEDIA, destinationType: navigator.camera.DestinationType.FILE_URI });
  		});
		},
		
		success: function(_class, src, path) {
		  $('#attachment').val(path);
  		$.mobile.showPageLoadingMsg("a", "Cargando...");
  		var $thumb = $("#attachment-thumb");
  		$thumb.attr("src", src).removeClass().addClass(_class).on('load', function() {$.mobile.hidePageLoadingMsg();});
  		$thumb.show();
		},
				
		handleError: function() {
		  $.mobile.hidePageLoadingMsg();
  		console.log("Error :(");
		},
		
		getLocation: function() {
  		navigator.geolocation.getCurrentPosition(app.locationSuccess, app.handleError);
		},
		
		locationSuccess: function(position) {
		  console.log('Geo Success');
		  
  		var lat = position.coords.latitude;
  		var lng = position.coords.longitude;
  		$('#lat').val(lat);
  		$('#lng').val(lng);
  		
  		var latlng = new google.maps.LatLng(lat, lng);
  		
  		geocoder = new google.maps.Geocoder();
      geocoder.geocode({'latLng': latlng}, function(results, status) {
        if(status == google.maps.GeocoderStatus.OK) {
          if(results[0]) {
            $('#location').val(results[0].formatted_address);
          } else {
            console.log('No results found');
          }
        } else {
          console.log('Geocoder failed due to: ' + status);
        }
      });
		},
		
		submitForm: function(e) {
  		e.preventDefault();
  		$('.error').hide();
  		
  		var loc = {address: $('#location').val(), lat: $('#lat').val(), lng: $('#lng').val()};
  		
  		var data = {
    		candidate_id: $('#candidate_id').val(),
    		description: $('#description').val(),
    		advertising_piece: $('#advertising_piece').val(),
    		location: JSON.stringify(loc),
    		image_uri: $('#attachment').val()
  		};
  		
  		if(!data.candidate_id || (!data.description && !data.image_uri)) {
  		  $('.error').show().text('Error: Debes llenar los campos');
  		} else {
    		app.uploadData(data);
  		}
  		
  		return false;
		},
		
		uploadData: function(data) {
		  $.mobile.showPageLoadingMsg("a", "Enviando...");
		  
		  if(data.image_uri) {
    		var options = new FileUploadOptions();
        options.fileKey = "file";
        options.fileName = data.image_uri.substr(data.image_uri.lastIndexOf('/') + 1);
  
        options.params = data;
  
        var ft = new FileTransfer();
        ft.upload(data.image_uri, encodeURI(url), app.win, app.handleError, options);
      } else {
        $.post(url, data, app.win).error(app.handleError);
      }
		},
		
		win: function() {
		  $.mobile.hidePageLoadingMsg();
  		$('#open-dialog').click();
		}
};