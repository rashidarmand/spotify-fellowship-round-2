// Using on turbolinks load instead of on DOMContentLoaded to ensure this JS is run on every page
document.addEventListener('turbolinks:load',()=>{
  // Grab the flash message
  let flash = document.querySelector('.flash');

  // Make the flash message disappear after 3 seconds
  if(flash){
    window.setTimeout(() => flash.classList.add("hide"), 3000);
  }

  // Gather all of the elements with class '.cal-days'
  let days = Array.from(document.querySelectorAll('.cal-days'));

  // Function to check the frequency that each month appears
  let mode = array =>{
    let obj = {};
    for(let val of array){
      if(obj[val.innerText[0]]){
        obj[val.innerText[0]]++;
      } else {
        obj[val.innerText[0]] = 1;
      }
    }
    return obj;
  }

  // Distinguish current month using the function we just made
  let currentMonth = Object.keys(mode(days)).reduce((a, b) => mode(days)[a] > mode(days)[b] ? a : b);

  // Create an array called 'outliers' with the months that are equal the current month being displayed
  let outliers = days.filter( day => day.innerText[0] != currentMonth );

  // Add the disabled class to the outliers' parent elements
  outliers.forEach(day => day.parentElement.parentElement.classList.add('disabled'));

  // Add Events to Calendar
  // Grab the add event button
  let addEventButton = document.querySelector('.add-event-button');

  addEventButton.addEventListener('click', () =>{
    
    let eventTitle = document.querySelector('.event-title').value;
    let eventDescription = document.querySelector('.event-description').value;
    let eventLocation = document.querySelector('.event-location').value;
    let startMonths = Array.from(document.getElementById('calendar_start_time_2i').children);
    let startMonth;
    startMonths.forEach(element =>{
      if(element.hasAttribute('selected')){
        startMonth = element.innerText;
      }
    });
    let startDays = Array.from(document.getElementById('calendar_start_time_3i').children);
    let startDay;
    startDays.forEach(element =>{
      if(element.hasAttribute('selected')){
        startDay = element.innerText;
      }
    });
    let endMonths = Array.from(document.getElementById('calendar_end_time_2i').children);
    let endMonth;
    endMonths.forEach(element =>{
      if(element.hasAttribute('selected')){
        endMonth = element.innerText;
      }
    });
    let endDays = Array.from(document.getElementById('calendar_end_time_3i').children);
    let endDay;
    endDays.forEach(element =>{
      if(element.hasAttribute('selected')){
        endDay = element.innerText;
      }
    });

    Rails.ajax({
      type: 'POST',
      contentType: "application/json",
      url: '/api/calendars',
      data: {
        "title" : eventTitle,
        "body" : eventDescription,
        "location" : eventLocation,
        "start_time" : `2018-${startMonth}-${startDay}`,
        "end_time" : `2018-${endMonth}-${endDay}`
      },
      success: data => {
        console.log(data)
        console.log('Adding of Event was Successful')
      },
      error: (data, error) => {
        console.log(data)
        console.log(error)
      }
    });
  });

  // Initialize all Materialize Components
  M.AutoInit();

  // Clear cache
  Turbolinks.clearCache();
})