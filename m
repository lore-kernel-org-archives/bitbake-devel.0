Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id E011076710
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:31 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="29894753"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2016 04:58:32 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 90DF86A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:28 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:02 +0200
Message-Id: <4e3226b2eb9be9c1c06cac5f89fc251c2cd36e81.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 19/23] toaster: toastergui: make "Apply" button state depend on filter range
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 15 Jan 2016 12:58:32 -0000

From: Elliot Smith <elliot.smith@intel.com>

If a range filter action had an empty from/to field, the range
filter could still be applied. This was confusing, as an invalid
filter range caused all records to display, even though a filter
appeared to have been applied (by the highlighted state of
the filter button).

Change the state of the "Apply" button, disabling it if the radio
button for a range filter action is selected but the range is
incomplete (from or to field is empty).

When a non-range filter is selected, the "Apply" button always
enable the "Apply" button.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/table.js          | 77 ++++++++++++++++------
 .../toastergui/templates/toastertable-filter.html  |  4 +-
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 9384386..87cac60 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -397,6 +397,8 @@ function tableInit(ctx){
    * filterActionData: (object)
    * filterActionData.count: (number) The number of items this filter will
    * show when selected
+   *
+   * NB this triggers a filtervalue event each time its radio button is checked
    */
   function createActionRadio(filterName, filterActionData) {
     var hasNoRecords = (Number(filterActionData.count) == 0);
@@ -420,7 +422,17 @@ function tableInit(ctx){
                  '</label>' +
                  '</div>';
 
-    return $(actionStr);
+    var action = $(actionStr);
+
+    // fire the filtervalue event from this action when the radio button
+    // is active so that the apply button can be enabled
+    action.find('[type="radio"]').change(function () {
+      if ($(this).is(':checked')) {
+        action.trigger('filtervalue', 'on');
+      }
+    });
+
+    return action;
   }
 
   /**
@@ -437,6 +449,8 @@ function tableInit(ctx){
    * datetime format
    * filterActionData.min: (string) minimum date for the pickers, ISO 8601
    * datetime
+   *
+   * NB this triggers a filtervalue event each time its radio button is checked
    */
   function createActionDateRange(filterName, filterValue, filterActionData) {
     var action = $('<div class="radio">' +
@@ -492,9 +506,26 @@ function tableInit(ctx){
     inputTo.val(selectedTo);
 
     // set filter_value based on date pickers when
-    // one of their values changes
+    // one of their values changes; if either from or to are unset,
+    // the new value is null;
+    // this triggers a 'filter_value-change' event on the action's element,
+    // which is used to determine the disabled/enabled state of the "Apply"
+    // button
     var changeHandler = function () {
-      value.val(inputFrom.val() + ',' + inputTo.val());
+      var fromValue = inputFrom.val();
+      var toValue = inputTo.val();
+
+      var newValue = undefined;
+      if (fromValue !== '' && toValue !== '') {
+        newValue = fromValue + ',' + toValue;
+      }
+
+      value.val(newValue);
+
+      // if this action is selected, fire an event for the new range
+      if (radio.is(':checked')) {
+        action.trigger('filtervalue', newValue);
+      }
     };
 
     inputFrom.change(changeHandler);
@@ -503,6 +534,10 @@ function tableInit(ctx){
     // check the associated radio button on clicking a date picker
     var checkRadio = function () {
       radio.prop('checked', 'checked');
+
+      // checking the radio button this way doesn't cause the "change"
+      // event to fire, so we manually call the changeHandler
+      changeHandler();
     };
 
     inputFrom.focus(checkRadio);
@@ -518,23 +553,9 @@ function tableInit(ctx){
       inputFrom.datepicker('option', 'maxDate', inputTo.val());
     });
 
-    // if the radio button is checked and one or both of the datepickers are
-    // empty, populate them with today's date
-    radio.change(function () {
-      var now = new Date();
-
-      if (inputFrom.val() === '') {
-        inputFrom.datepicker('setDate', now);
-      }
-
-      if (inputTo.val() === '') {
-        inputTo.datepicker('setDate', now);
-      }
-
-      // setting the date like this doesn't fire the changeHandler to
-      // update the filter_value, so do that manually instead
-      changeHandler()
-    });
+    // checking the radio input causes the "Apply" button disabled state to
+    // change, depending on which from/to dates are supplied
+    radio.change(changeHandler);
 
     return action;
   }
@@ -589,6 +610,16 @@ function tableInit(ctx){
             queryset on the table
           */
           var filterActionRadios = $('#filter-actions-' + ctx.tableName);
+          var filterApplyBtn = $('[data-role="filter-apply"]');
+
+          var setApplyButtonState = function (e, filterActionValue) {
+            if (filterActionValue !== undefined) {
+              filterApplyBtn.removeAttr('disabled');
+            }
+            else {
+              filterApplyBtn.attr('disabled', 'disabled');
+            }
+          };
 
           $('#filter-modal-title-' + ctx.tableName).text(filterData.title);
 
@@ -624,10 +655,14 @@ function tableInit(ctx){
               if ((tableParams.filter &&
                   tableParams.filter === radioInput.val()) ||
                   filterActionData.action_name == 'all') {
-                  radioInput.attr("checked", "checked");
+                  radioInput.prop("checked", "checked");
               }
 
               filterActionRadios.append(action);
+
+              // if the action's filter_value changes but is falsy, disable
+              // the "Apply" button
+              action.on('filtervalue', setApplyButtonState);
             }
           }
 
diff --git a/lib/toaster/toastergui/templates/toastertable-filter.html b/lib/toaster/toastergui/templates/toastertable-filter.html
index 7c8dc49..4d28793 100644
--- a/lib/toaster/toastergui/templates/toastertable-filter.html
+++ b/lib/toaster/toastergui/templates/toastertable-filter.html
@@ -10,7 +10,9 @@
       <span id="filter-actions-{{table_name}}"></span>
     </div>
     <div class="modal-footer">
-      <button class="btn btn-primary" type="submit">Apply</button>
+      <button class="btn btn-primary" type="submit" data-role="filter-apply">
+        Apply
+      </button>
     </div>
   </form>
 </div>
-- 
2.1.4


