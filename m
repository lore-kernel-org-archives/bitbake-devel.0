Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (unknown [74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id 0B6496ABDB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 14:15:10 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id u56so2137271wes.14
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=MLBWDWhhxlEOUPi4HdwteB/seMJzKotVGl3Z9TtDsk8=;
	b=cSP/JF6laao18k7dP0cGOdlhptxPvjPKRRKp25/K8Npqi23BumU0Zq2OEzkkXLHkvq
	VqxhiDa42ddcJYwCO014tgGgJeA9a2Rl75qisIduxHAjDjfWCV2zwhlNVM4ivV0MCwWD
	VBENNSaAyEsX7f/ZS4z6nq99BsJOcZXDwgi6PxTwbRw6hZoCQGqhyMrodf0BY42K7knH
	E6H92keoJVfvLuy91y6Joh7SpndCwh5ojMT3g9/90V19VpuNpKc5psUoWdX9wUD2x84f
	AJE4JSMy/t9/9tP0AMicxQHbRRPvOMbXhEyM2R7QGSe5NPdgFMbYdT/GdnAztSvwiFNg
	dQ1g==
X-Gm-Message-State: ALoCoQkFc5ja+9NrwG+RYPCgq00dAdybonCdPzKRbq2Bd3g8AWk9yq1x5R71+dhOGMxHBzArXRRU
X-Received: by 10.180.211.36 with SMTP id mz4mr10794603wic.20.1400681711169;
	Wed, 21 May 2014 07:15:11 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id na4sm2515323wic.21.2014.05.21.07.15.09
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 May 2014 07:15:10 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 4C72F56032B; Wed, 21 May 2014 15:15:10 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 May 2014 15:15:08 +0100
Message-Id: <1c549f33c63ac7388018dc46a29014d2b1c854b7.1400681628.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bee80157c3652f498ae1b98a90fb022356c6ff53.1400681628.git.alexandru.damian@intel.com>
References: <bee80157c3652f498ae1b98a90fb022356c6ff53.1400681628.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1400681628.git.alexandru.damian@intel.com>
References: <cover.1400681628.git.alexandru.damian@intel.com>
Cc: Farrell Wymore <farrell.wymore@windriver.com>
Subject: [PATCH 2/3] toaster: sort columns properly after edit columns
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
X-List-Received-Date: Wed, 21 May 2014 14:15:15 -0000

From: Farrell Wymore <farrell.wymore@windriver.com>

If a sorted column is made invisible through the edit columns function,
resort the table the its default order.

[YOCTO 5919]

Signed-off-by: Farrell Wymore <farrell.wymore@windriver.com>
---
 .../toastergui/templates/basetable_top.html        | 172 +++++++++++++++++++--
 lib/toaster/toastergui/views.py                    |  46 +++++-
 2 files changed, 204 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 22c3897..1231e1f 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -1,17 +1,42 @@
 {% load projecttags %}
 <!-- component to display a generic table -->
     <script>
-    function showhideTableColumn(clname, sh) {
-        if (sh) $('.' + clname).show(100);
-        else $('.' + clname).hide(100);
 
-	// save cookie for all checkboxes
-	save = '';
-	$('.chbxtoggle').each(function() { if ($(this).attr('id') != undefined) { save += ';' + $(this).attr('id') +':'+ $(this).is(':checked')} })
-	$.cookie('_displaycols_{{objectname}}',  save);
-	save = '';
-    }
+    //
+    // most of the following javascript is for managing the 'Edit Columns'
+    // pop-up dialog and actions. the idea is that there are 2 types
+    // of actions: immediate - performed while the dialog is still
+    // visible - hide/show columns, and delayed - performed when the
+    // dialog becomes invisible - any resorting if necessary.
+    //
+    // When the dialog is open, an interval timer is set up to
+    // determine if the dialog is still visible. when the dialog
+    // closes - goes invisible, the delayed actions are performed.
+    //
+    // the interval timer and interrupt handler is a way of simulating
+    // an onclose event. there is probably a simpler way to do this
+    // however the pop-up window id was elusive.
+    //
+
+    var editColTimer;
+    var editColAction;
 
+    //
+    // this is the target function of the interval timeout.
+    // check to see if the dialog is visible. if the dialog
+    // has gone invisible since the last check, take any delayed
+    // actions indicated in the action list and clear the timer.
+    //
+
+    function checkVisible( ) {
+        editcol = document.getElementById( 'editcol' );
+        if ( editcol.offsetWidth <= 0 ) {
+            clearInterval( editColTimer );
+            editColTimer = false;
+            hideshowColumns( );
+            editColAction = [ ];
+        }
+    }
 
     function filterTableRows(test) {
         if (test.length > 0) {
@@ -24,6 +49,113 @@
             $('tr.data').show();
         }
     }
+
+    //
+    // determine the value of the indicated url arg.
+    // this is needed to determine whether a resort
+    // is necessary. it looks like a lot of gorp stuff
+    // but its actually pretty simple.
+    //
+
+    function getURLParameter( name ) {
+        return decodeURIComponent((new RegExp('[?|&]' + name + '=' +
+          '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g,
+          '%20'))||null
+    }
+
+    //
+    // when the dialog box goes invisible
+    // this function is called to interpret
+    // the action list and take any delayed actions necessary.
+    // the editColAction list is a hash table with
+    // the column name as the hash key, the hash value
+    // is a 2 element list. the first element is a flag
+    // indicating whether the column is on or off. the
+    // 2nd element is the sort order indicator for the column.
+    //
+
+    function hideshowColumns( ) {
+        for( var k in editColAction ) {
+            showhideDelayedTableAction( k, editColAction[ k ][ 0 ], editColAction[ k ][ 1 ]);
+        }
+    }
+
+    //
+    // this function actually performs the delayed table actions
+    // namely any resorting if necessary
+    //
+
+    function showhideDelayedTableAction( clname, sh, orderkey ) {
+        if ( !sh ) {
+            p = getURLParameter( "orderby" ).split( ":" )[ 0 ];
+            if ( p == orderkey ) {
+                reload_params({ 'orderby' : '{{default_orderby}}'});
+            }
+        }
+    }
+
+    //
+    // this function actually performs the immediate table actions
+    // namely any colums that need to be hidden/shown
+    //
+
+    function showhideImmediateTableAction( clname, sh, orderkey ) {
+        if ( sh ) {
+            $( '.' + clname ).show( 100 );
+        }
+        else {
+            $( '.' + clname ).hide( 100 );
+        }
+
+	// save cookie for all checkboxes
+	save = '';
+	$( '.chbxtoggle' ).each(function( ) {
+            if ( $( this ).attr( 'id' ) != undefined ) {
+                save += ';' + $( this ).attr( 'id' ) +':'+ $( this ).is( ':checked' )
+            }
+        });
+	$.cookie( '_displaycols_{{objectname}}', save );
+	save = '';
+    }
+
+    //
+    // this is the onclick handler for all of the check box
+    // items in edit columns dialog
+    //
+
+    function showhideTableColumn( clname, sh, orderkey ) {
+        editcol = document.getElementById( 'editcol' );
+        if ( editcol.offsetWidth <= 0 ) {
+
+            //
+            // this path is taken when the page is first
+            // getting initialized - no dialog visible,
+            // perform both the immediate and delayed actions
+            //
+
+            showhideImmediateTableAction( clname, sh, orderkey );
+            showhideDelayedTableAction( clname, sh, orderkey );
+            return;
+        }
+        if ( !editColTimer ) {
+
+            //
+            // we don't have a timer active so set one up
+            // and clear the action list
+            //
+
+            editColTimer = setInterval( checkVisible, 250 );
+            editColAction = [ ];
+        }
+
+        //
+        // save the action to be taken when the dialog closes
+        //
+
+        editColAction[ clname ] = [ sh, orderkey ];
+        showhideImmediateTableAction( clname, sh, orderkey );
+    }
+
     </script>
 
 <!-- control header -->
@@ -33,7 +165,6 @@
             <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
             <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
             <input type="hidden" name="page" value="1">
-            <input type="hidden" name="count" value="{{request.GET.count}}">
             <button class="btn" type="submit" value="Search">Search</button>
         </form>
         <div class="pull-right">
@@ -45,12 +176,27 @@
 <!--
 	{{tablecols|sortcols}}
 -->
-                <ul class="dropdown-menu">{% for i in tablecols|sortcols %}
+                <ul id='editcol' class="dropdown-menu">
+                  {% for i in tablecols|sortcols %}
                     <li>
                         <label {% if not i.clclass %} class="checkbox muted" {%else%} class="checkbox" {%endif%}>
-                            <input type="checkbox" class="chbxtoggle" {% if i.clclass %}id="{{i.clclass}}" value="ct{{i.name}}" {% if not i.hidden %}checked="checked"{%endif%} onchange="showhideTableColumn($(this).attr('id'), $(this).is(':checked'))" {%else%} checked disabled {% endif %}/>   {{i.name}}
+                            <input type="checkbox" class="chbxtoggle"
+                                   {% if i.clclass %}
+                                       id="{{i.clclass}}"
+                                       value="ct{{i.name}}"
+                                       {% if not i.hidden %}
+                                           checked="checked"
+                                       {%endif%}
+                                       onclick="showhideTableColumn(
+                                           $(this).attr('id'),
+                                           $(this).is(':checked'),
+                                           '{{i.orderkey}}' )"
+                                   {%else%}
+                                       checked disabled
+                                   {% endif %}/>   {{i.name}}
                         </label>
-                    </li>{% endfor %}
+                    </li>
+                  {% endfor %}
                 </ul>
             </div>
 {% endif %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e3b24ba..4622810 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -262,6 +262,7 @@ def builds(request):
             # TODO: common objects for all table views, adapt as needed
                 'objects' : build_info,
                 'objectname' : "builds",
+                'default_orderby' : 'completed_on:-',
                 'fstypes' : fstypes_map,
                 'search_term' : search_term,
                 'total_count' : queryset_with_search.count(),
@@ -311,6 +312,7 @@ def builds(request):
                  'qhelp': "The date and time the build finished",
                  'orderfield': _get_toggle_order(request, "completed_on", True),
                  'ordericon':_get_toggle_order_icon(request, "completed_on"),
+                 'orderkey' : 'completed_on',
                  'filter' : {'class' : 'completed_on',
                              'label': 'Show:',
                              'options' : [
@@ -334,6 +336,7 @@ def builds(request):
                  'qhelp': "How many errors were encountered during the build (if any)",
                  'orderfield': _get_toggle_order(request, "errors_no", True),
                  'ordericon':_get_toggle_order_icon(request, "errors_no"),
+                 'orderkey' : 'errors_no',
                  'filter' : {'class' : 'errors_no',
                              'label': 'Show:',
                              'options' : [
@@ -346,6 +349,7 @@ def builds(request):
                  'qhelp': "How many warnings were encountered during the build (if any)",
                  'orderfield': _get_toggle_order(request, "warnings_no", True),
                  'ordericon':_get_toggle_order_icon(request, "warnings_no"),
+                 'orderkey' : 'warnings_no',
                  'filter' : {'class' : 'warnings_no',
                              'label': 'Show:',
                              'options' : [
@@ -358,6 +362,7 @@ def builds(request):
                  'qhelp': "How long it took the build to finish",
                  'orderfield': _get_toggle_order(request, "timespent", True),
                  'ordericon':_get_toggle_order_icon(request, "timespent"),
+                 'orderkey' : 'timespent',
                 },
                 {'name': 'Log',
                  'dclass': "span4",
@@ -365,6 +370,7 @@ def builds(request):
                  'clclass': 'log', 'hidden': 1,
                  'orderfield': _get_toggle_order(request, "cooker_log_path"),
                  'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
+                 'orderkey' : 'cooker_log_path',
                 },
                 {'name': 'Output', 'clclass': 'output',
                  'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
@@ -502,7 +508,7 @@ def task( request, build_id, task_id ):
             'log_head'        : log_head,
             'log_body'        : log_body,
             'showing_matches' : False,
-			'uri_list'        : uri_list,
+            'uri_list'        : uri_list,
     }
     if request.GET.get( 'show_matches', "" ):
         context[ 'showing_matches' ] = True
@@ -559,6 +565,7 @@ def target(request, build_id, target_id):
                 'objects': packages,
                 'packages_sum' : packages_sum['installed_size__sum'],
                 'object_search_display': "packages included",
+                'default_orderby' : 'name:+',
                 'tablecols':[
                 {
                     'name':'Package',
@@ -575,6 +582,7 @@ def target(request, build_id, target_id):
                     'qhelp':'The size of the package',
                     'orderfield': _get_toggle_order(request, "size", True),
                     'ordericon':_get_toggle_order_icon(request, "size"),
+                    'orderkey' : 'size',
                     'clclass': 'size',
                     'dclass' : 'span2',
                     'hidden' : 0,
@@ -582,6 +590,7 @@ def target(request, build_id, target_id):
                 {
                     'name':'Size over total (%)',
                     'qhelp':'Proportion of the overall included package size represented by this package',
+                    'orderkey' : 'size',
                     'clclass': 'size_over_total',
                     'dclass' : 'span2',
                     'hidden' : 1,
@@ -591,6 +600,7 @@ def target(request, build_id, target_id):
                     'qhelp':'The license under which the package is distributed. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source',
                     'orderfield': _get_toggle_order(request, "license"),
                     'ordericon':_get_toggle_order_icon(request, "license"),
+                    'orderkey' : 'license',
                     'clclass': 'license',
                     'hidden' : 1,
                 },
@@ -611,6 +621,7 @@ def target(request, build_id, target_id):
                     'qhelp':'The name of the recipe building the package',
                     'orderfield': _get_toggle_order(request, "recipe__name"),
                     'ordericon':_get_toggle_order_icon(request, "recipe__name"),
+                    'orderkey' : 'recipe__name',
                     'clclass': 'recipe_name',
                     'hidden' : 0,
                 },
@@ -625,6 +636,7 @@ def target(request, build_id, target_id):
                     'qhelp':'The name of the layer providing the recipe that builds the package',
                     'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__name"),
                     'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__name"),
+                    'orderkey' : 'recipe__layer_version__layer__name',
                     'clclass': 'layer_name',
                     'hidden' : 1,
                 },
@@ -633,6 +645,7 @@ def target(request, build_id, target_id):
                     'qhelp':'The Git branch of the layer providing the recipe that builds the package',
                     'orderfield': _get_toggle_order(request, "recipe__layer_version__branch"),
                     'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__branch"),
+                    'orderkey' : 'recipe__layer_version__branch',
                     'clclass': 'layer_branch',
                     'hidden' : 1,
                 },
@@ -830,21 +843,25 @@ def tasks_common(request, build_id, variant, task_anchor):
         object_search_display="time data"
         filter_search_display="tasks"
         mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'elapsed_time:-'};
+        default_orderby = 'elapsed_time:-';
     elif 'diskio'    == variant:
         title_variant='Disk I/O'
         object_search_display="disk I/O data"
         filter_search_display="tasks"
         mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'disk_io:-'};
+        default_orderby = 'disk_io:-';
     elif 'cpuusage'  == variant:
         title_variant='CPU usage'
         object_search_display="CPU usage data"
         filter_search_display="tasks"
         mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'cpu_usage:-'};
+        default_orderby = 'cpu_usage:-';
     else :
         title_variant='Tasks'
         object_search_display="tasks"
         filter_search_display="tasks"
         mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'order:+'};
+        default_orderby = 'order:+';
 
     template = 'tasks.html'
     retval = _verify_parameters( request.GET, mandatory_parameters )
@@ -886,12 +903,14 @@ def tasks_common(request, build_id, variant, task_anchor):
         'name':'Order',
         'qhelp':'The running sequence of each task in the build',
         'clclass': 'order', 'hidden' : 1,
+        'orderkey' : 'order',
         'orderfield':_get_toggle_order(request, "order"),
         'ordericon':_get_toggle_order_icon(request, "order")}
     if 'tasks' == variant: tc_order['hidden']='0'; del tc_order['clclass']
     tc_recipe={
         'name':'Recipe',
         'qhelp':'The name of the recipe to which each task applies',
+        'orderkey' : 'recipe__name',
         'orderfield': _get_toggle_order(request, "recipe__name"),
         'ordericon':_get_toggle_order_icon(request, "recipe__name"),
     }
@@ -905,6 +924,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'qhelp':'The name of the task',
         'orderfield': _get_toggle_order(request, "task_name"),
         'ordericon':_get_toggle_order_icon(request, "task_name"),
+        'orderkey' : 'task_name',
     }
     tc_executed={
         'name':'Executed',
@@ -912,6 +932,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'clclass': 'executed', 'hidden' : 0,
         'orderfield': _get_toggle_order(request, "task_executed"),
         'ordericon':_get_toggle_order_icon(request, "task_executed"),
+        'orderkey' : 'task_executed',
         'filter' : {
                    'class' : 'executed',
                    'label': 'Show:',
@@ -928,6 +949,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'clclass': 'outcome', 'hidden' : 0,
         'orderfield': _get_toggle_order(request, "outcome"),
         'ordericon':_get_toggle_order_icon(request, "outcome"),
+        'orderkey' : 'outcome',
         'filter' : {
                    'class' : 'outcome',
                    'label': 'Show:',
@@ -947,6 +969,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'qhelp':'Path to the task log file',
         'orderfield': _get_toggle_order(request, "logfile"),
         'ordericon':_get_toggle_order_icon(request, "logfile"),
+        'orderkey' : 'logfile',
         'clclass': 'task_log', 'hidden' : 1,
     }
     tc_cache={
@@ -955,6 +978,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'clclass': 'cache_attempt', 'hidden' : 0,
         'orderfield': _get_toggle_order(request, "sstate_result"),
         'ordericon':_get_toggle_order_icon(request, "sstate_result"),
+        'orderkey' : 'sstate_result',
         'filter' : {
                    'class' : 'cache_attempt',
                    'label': 'Show:',
@@ -973,6 +997,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'qhelp':'How long it took the task to finish in seconds',
         'orderfield': _get_toggle_order(request, "elapsed_time", True),
         'ordericon':_get_toggle_order_icon(request, "elapsed_time"),
+        'orderkey' : 'elapsed_time',
         'clclass': 'time_taken', 'hidden' : 1,
     }
     if   'buildtime' == variant: tc_time['hidden']='0'; del tc_time['clclass']; tc_cache['hidden']='1';
@@ -981,6 +1006,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'qhelp':'The percentage of task CPU utilization',
         'orderfield': _get_toggle_order(request, "cpu_usage", True),
         'ordericon':_get_toggle_order_icon(request, "cpu_usage"),
+        'orderkey' : 'cpu_usage',
         'clclass': 'cpu_used', 'hidden' : 1,
     }
     if   'cpuusage' == variant: tc_cpu['hidden']='0'; del tc_cpu['clclass']; tc_cache['hidden']='1';
@@ -989,6 +1015,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         'qhelp':'Number of miliseconds the task spent doing disk input and output',
         'orderfield': _get_toggle_order(request, "disk_io", True),
         'ordericon':_get_toggle_order_icon(request, "disk_io"),
+        'orderkey' : 'disk_io',
         'clclass': 'disk_io', 'hidden' : 1,
     }
     if   'diskio' == variant: tc_diskio['hidden']='0'; del tc_diskio['clclass']; tc_cache['hidden']='1';
@@ -1000,6 +1027,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                 'title': title_variant,
                 'build': Build.objects.filter(pk=build_id)[0],
                 'objects': tasks,
+                'default_orderby' : default_orderby,
                 'search_term': search_term,
                 'total_count': queryset_with_search.count(),
                 'tablecols':[
@@ -1050,6 +1078,7 @@ def recipes(request, build_id):
         'objectname': 'recipes',
         'build': Build.objects.filter(pk=build_id)[0],
         'objects': recipes,
+        'default_orderby' : 'name:+',
         'tablecols':[
             {
                 'name':'Recipe',
@@ -1076,6 +1105,7 @@ def recipes(request, build_id):
                 'qhelp':'Path to the recipe .bb file',
                 'orderfield': _get_toggle_order(request, "file_path"),
                 'ordericon':_get_toggle_order_icon(request, "file_path"),
+                'orderkey' : 'file_path',
                 'clclass': 'recipe_file', 'hidden': 0,
             },
             {
@@ -1083,6 +1113,7 @@ def recipes(request, build_id):
                 'qhelp':'The section in which recipes should be categorized',
                 'orderfield': _get_toggle_order(request, "section"),
                 'ordericon':_get_toggle_order_icon(request, "section"),
+                'orderkey' : 'section',
                 'clclass': 'recipe_section', 'hidden': 0,
             },
             {
@@ -1090,6 +1121,7 @@ def recipes(request, build_id):
                 'qhelp':'The list of source licenses for the recipe. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source',
                 'orderfield': _get_toggle_order(request, "license"),
                 'ordericon':_get_toggle_order_icon(request, "license"),
+                'orderkey' : 'license',
                 'clclass': 'recipe_license', 'hidden': 0,
             },
             {
@@ -1097,6 +1129,7 @@ def recipes(request, build_id):
                 'qhelp':'The name of the layer providing the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__layer__name"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__layer__name"),
+                'orderkey' : 'layer_version__layer__name',
                 'clclass': 'layer_version__layer__name', 'hidden': 0,
             },
             {
@@ -1104,6 +1137,7 @@ def recipes(request, build_id):
                 'qhelp':'The Git branch of the layer providing the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__branch"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__branch"),
+                'orderkey' : 'layer_version__branch',
                 'clclass': 'layer_version__branch', 'hidden': 1,
             },
             {
@@ -1116,6 +1150,7 @@ def recipes(request, build_id):
                 'qhelp':'Path to the layer prodiving the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__layer__local_path"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__layer__local_path"),
+                'orderkey' : 'layer_version__layer__local_path',
                 'clclass': 'layer_version__layer__local_path', 'hidden': 1,
             },
             ]
@@ -1198,6 +1233,7 @@ def configvars(request, build_id):
                 'build': Build.objects.filter(pk=build_id)[0],
                 'objects' : variables,
                 'total_count':queryset_with_search.count(),
+                'default_orderby' : 'variable_name:+',
                 'search_term':search_term,
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
@@ -1213,6 +1249,7 @@ def configvars(request, build_id):
                 {'name': 'Set in file',
                  'qhelp': "The last configuration file that touched the variable value",
                  'clclass': 'file', 'hidden' : 0,
+                 'orderkey' : 'vhistory__file_name',
                  'filter' : {
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
@@ -1259,6 +1296,7 @@ def bpackage(request, build_id):
         'objectname': 'packages built',
         'build': Build.objects.filter(pk=build_id)[0],
         'objects' : packages,
+        'default_orderby' : 'name:+',
         'tablecols':[
             {
                 'name':'Package',
@@ -1275,6 +1313,7 @@ def bpackage(request, build_id):
                 'qhelp':'The size of the package',
                 'orderfield': _get_toggle_order(request, "size", True),
                 'ordericon':_get_toggle_order_icon(request, "size"),
+                'orderkey' : 'size',
                 'clclass': 'size', 'hidden': 0,
                 'dclass' : 'span2',
             },
@@ -1283,6 +1322,7 @@ def bpackage(request, build_id):
                 'qhelp':'The license under which the package is distributed. Multiple license names separated by the pipe character indicates a choice between licenses. Multiple license names separated by the ampersand character indicates multiple licenses exist that cover different parts of the source',
                 'orderfield': _get_toggle_order(request, "license"),
                 'ordericon':_get_toggle_order_icon(request, "license"),
+                'orderkey' : 'license',
                 'clclass': 'license', 'hidden': 1,
             },
             {
@@ -1290,6 +1330,7 @@ def bpackage(request, build_id):
                 'qhelp':'The name of the recipe building the package',
                 'orderfield': _get_toggle_order(request, "recipe__name"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__name"),
+                'orderkey' : 'recipe__name',
                 'clclass': 'recipe__name', 'hidden': 0,
             },
             {
@@ -1302,6 +1343,7 @@ def bpackage(request, build_id):
                 'qhelp':'The name of the layer providing the recipe that builds the package',
                 'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__name"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__name"),
+                'orderkey' : 'recipe__layer_version__layer__name',
                 'clclass': 'recipe__layer_version__layer__name', 'hidden': 1,
             },
             {
@@ -1309,6 +1351,7 @@ def bpackage(request, build_id):
                 'qhelp':'The Git branch of the layer providing the recipe that builds the package',
                 'orderfield': _get_toggle_order(request, "recipe__layer_version__branch"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__branch"),
+                'orderkey' : 'recipe__layer_version__layer__branch',
                 'clclass': 'recipe__layer_version__branch', 'hidden': 1,
             },
             {
@@ -1321,6 +1364,7 @@ def bpackage(request, build_id):
                 'qhelp':'Path to the layer providing the recipe that builds the package',
                 'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__local_path"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__local_path"),
+                'orderkey' : 'recipe__layer_version__layer__local_path',
                 'clclass': 'recipe__layer_version__layer__local_path', 'hidden': 1,
             },
             ]
-- 
1.9.1


