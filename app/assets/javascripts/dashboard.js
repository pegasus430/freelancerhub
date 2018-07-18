// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require jquery.turbolinks
//= require summernote
//= require cable
//= require channels/personal_chat
//= require notifications
//= require uploads
//= require subscriptions
//= require dashboard/bootstrap.min
//= require dashboard/bootstrap-checkbox-radio-switch
//= require dashboard/chartist.min
//= require dashboard/bootstrap-notify
//= require dashboard/light-bootstrap-dashboard
//= require dashboard/bootstrap-datetimepicker.min
//= require dashboard/jquery.richtext
//= require dashboard/bootstrap-tagsinput

$(function () {
 $("#employer_wizard_start_date").datepicker();
 $("#work_start_date").datepicker({format: 'mm/yyyy'});
 $("#work_end_date").datepicker({format: 'mm/yyyy'});
 $("#education_date_start").datepicker({format: 'mm/yyyy'});
 $("#education_date_end").datepicker({format: 'mm/yyyy'});
 $("#coupon_expired_date").datepicker({format: 'dd/mm/yyyy'});
});