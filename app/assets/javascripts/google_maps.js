document.addEventListener('DOMContentLoaded', () => {
  const googleMapsApiKey = "<%= Rails.application.credentials.dig(:google_maps, :api_key) %>";
  let script = document.createElement('script');
  script.src = `https://maps.googleapis.com/maps/api/js?key=${googleMapsApiKey}&callback=initMap`;
  script.async = true;
  document.head.appendChild(script);
});

function initMap() {
  // Your map initialization code here
}
