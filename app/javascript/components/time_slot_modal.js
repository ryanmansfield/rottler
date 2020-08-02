const timeSlotModal = () => {
  $(document).ready(function() {
    $('#timeSlotModal').on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget) // Button that triggered the modal
      var timeSlot = button.data('time-slot') // Extract info from data-* attributes
      // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
      // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
      var modal = $(this)
      const time = timeSlot.substr(3, 7)
      const hours = timeSlot.substr(3)[1]
      const minutes = timeSlot.substr(6,7)
      if (hours === '0') {
        modal.find('.modal-title').text('There is ' + minutes + ' minutes in this time slot.' )
      } else if (hours === '1') {
        modal.find('.modal-title').text('There is ' + hours + ' hour and ' + minutes + ' minutes in this time slot.' )
      } else {
        modal.find('.modal-title').text('There is ' + hours + ' hours and ' + minutes + ' minutes in this time slot.' )
      }
    });
  });
}

export { timeSlotModal }
