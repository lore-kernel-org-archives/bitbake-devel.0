Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id 755A2732A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:11 +0000 (UTC)
Received: by pdbft15 with SMTP id ft15so32774539pdb.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RQ7hjiSzbm6P+Qh53sasibWpQHU1uuLVYwAn8VloDw4=;
	b=aWzR+RxSMwsaY8ba7K2XIXeEG4VVNowJZ1ij35QYvpoyof+6S5Q3YaFEGUGRSV80Jp
	PmezVo4hKv1NLCB6nGycQjgUAiUD7PV2EuJjncz7EeRN1N3W1vcCLmSI07zl+73TTkBF
	uDxfGgzFoX/r5MCiwhK9CRzzbo1HXOt4WVu8hVL8i+Mum2P0EPHqpIZLbv4o1TAy+17X
	MjRFG/tvd9mnmApO4yr6dgv8h6YGwzEZZk4388czAsC6TVVj7pibR0jGLYAicbggZg6N
	ALNxK0VOLSbO1RE2e/k3Bf9kr0v+Z4kZfQtgB/x+xbE/LVLGmQdVxqQwi/oaF34TkQnL
	7B4g==
X-Gm-Message-State: ALoCoQlOF3WnhbZzrSaG28mEvZaxUN4VYYDcniD5g+S+Ep+BPU+rr+WYEmX+r2bVO/ivyd+mO2gs
X-Received: by 10.70.129.75 with SMTP id nu11mr31098291pdb.151.1423504932563; 
	Mon, 09 Feb 2015 10:02:12 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v4sm11083923pdq.15.2015.02.09.10.02.09
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 649815661BA; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:50 +0000
Message-Id: <b0ae4d2bb71e897d8a846a3cf14b7151baa09bd2.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 20/27] toaster: All machines Add filtering based on layer in project
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:12 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add a filter so that we can filter machines which are already being provided
by a layer in the current project.
Also make sure that we're only showing layers which are compatible with
the current project.
Also handle no results returned and page heading reflecting the number of
results returned from a search.

AlexD solved conflicts while merging the patch.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/machines.html | 67 +++++++++++++++++---------
 lib/toaster/toastergui/views.py                | 48 ++++++++++++++++--
 2 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index 650c47b..9930a94 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -30,38 +30,57 @@
 {% include "layers_dep_modal.html" %}
 <div class="page-header">
   <h1>
+    {% if request.GET.search %}
+      {% if objects.paginator.count != 0 %}
+        {{objects.paginator.count}} machines found
+       {% else %}
+        No Machines found
+       {% endif %}
+    {% else %}
+
     All machines
     <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with the current project that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
+    {% endif %}
   </h1>
 </div>
-
 <div class="alert alert-info lead" id="alert-area" style="display:none">
   <button type="button" class="close" id="dismiss-alert">&times;</button>
   <span id="alert-msg"></span>
 </div>
+{% if request.GET.search and objects.paginator.count == 0 %}
+<div class="alert row-fluid">
+<form class="navbar-search input-append pull-left" id="searchform">
+  <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search machines" value="{{request.GET.search}}"><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+    <input type="hidden" name="orderby" value="">
+      <input type="hidden" name="page" value="1">
+        <button class="btn" type="submit" value="Search">Search</button>
+        <button type="submit" class="btn btn-link"><a href="{%url 'machines' %}">Show all machines</a></button>
+      </form>
+    </div>
+{% else %}
+  {% include "basetable_top.html" %}
+  {% for o in objects %}
+  <tr class="data">
+    <td class="machine">{{o.name}}</td>
+    <td class="description">{{o.description}}</td>
+    <td class="layer"><a href="{%url "layerdetails" o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
+    <td class="source">{{o.layer_source.name}}</td>
+    <td class="branch">{{o.layer_version.get_vcs_reference}}</td>
+    <td class="machinefile"><code>/machine/conf/{{o.name}}.conf</code><a href="{{o.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a></td>
+    <td class="select-or-add">
+      <a href="#" class="btn btn-block select-machine-btn" data-machine-name="{{o.name}}" data-layer-version-id="{{o.layer_version.id}}"
+          {%if o.layer_version.id not in project_layers %}style="display:none" {%endif%}  >Select machine</a>
+      <a  href="#" class="btn btn-block nopop add-layer" data-layer-version-id="{{o.layer_version.id}}" data-layer-name="{{o.layer_version.layer.name}}" {%if o.layer_version.id in project_layers %}style="display:none" {%endif%}
+          >
+        <i class="icon-plus"></i>
+        Add layer
+        <i class="icon-question-sign get-help" title="To build this machine, you must first add the {{o.layer_version.layer.name}} layer to your project"></i>
+      </a>
+    </td>
+  </tr>
+  {% endfor %}
 
-{% include "basetable_top.html" %}
-{% for o in objects %}
-<tr class="data">
-  <td class="machine">{{o.name}}</td>
-  <td class="description">{{o.description}}</td>
-  <td class="layer"><a href="{%url "layerdetails" o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
-  <td class="source">{{o.layer_source.name}}</td>
-  <td class="branch">{{o.layer_version.commit}}</td>
-  <td class="machinefile"><code>/machine/conf/{{o.name}}.conf</code><a href="{{o.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a></td>
-  <td class="select-or-add">
-    <a href="#" class="btn btn-block select-machine-btn" data-machine-name="{{o.name}}" data-layer-version-id="{{o.layer_version.id}}"
-        {%if o.layer_version.id not in project_layers %}style="display:none" {%endif%}  >Select machine</a>
-    <a  href="#" class="btn btn-block nopop add-layer" data-layer-version-id="{{o.layer_version.id}}" data-layer-name="{{o.layer_version.layer.name}}" {%if o.layer_version.id in project_layers %}style="display:none" {%endif%}
-        >
-      <i class="icon-plus"></i>
-      Add layer
-      <i class="icon-question-sign get-help" title="To build this machine, you must first add the {{o.layer_version.layer.name}} layer to your project"></i>
-    </a>
-  </td>
-</tr>
-{% endfor %}
-
-{% include "basetable_bottom.html" %}
+  {% include "basetable_bottom.html" %}
+{% endif %}
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2e52d2b..7dc4bbd 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2789,11 +2789,38 @@ if toastermain.settings.MANAGED:
 
         queryset_all = Machine.objects.all()
 
-        queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
-        queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
+        prj = Project.objects.get(pk = request.session['project_id'])
+        compatible_layers = prj.compatible_layerversions()
+        # Make sure we only show machines / layers which are compatible with the current project
+        queryset_all = queryset_all.filter(layer_version__in=compatible_layers)
 
         project_layers = ProjectLayer.objects.filter(project_id=request.session['project_id']).values_list('layercommit',flat=True)
 
+        by_pass_filter_string = False
+        #  "special" filters identified by these valid filter strings we
+        # by pass the usual filter applying method because we're filtering using
+        # a subquery done by project_layers
+        if "name:inprj" in filter_string:
+          queryset_all = queryset_all.filter(layer_version__in=project_layers)
+          by_pass_filter_string = True
+
+        if "name:notinprj" in filter_string:
+          queryset_all = queryset_all.exclude(layer_version__in=project_layers)
+          by_pass_filter_string = True
+
+        queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
+
+        if by_pass_filter_string:
+          queryset = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
+        else:
+          queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
+
+        selected_filter_count = {
+          'inprj' : queryset.filter(layer_version__in=project_layers).count(),
+          'notinprj' : queryset.exclude(layer_version__in=project_layers).count()
+        }
+
+
         # retrieve the objects that will be displayed in the table; machines a paginator and gets a page range to display
         machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
 
@@ -2802,7 +2829,7 @@ if toastermain.settings.MANAGED:
             'project_layers' : project_layers,
             'objectname' : "machines",
             'default_orderby' : 'name:+',
-            'total_count': queryset_with_search.count(),
+            'total_count': machine_info.paginator.count,
 
             'tablecols' : [
                 {   'name': 'Machine',
@@ -2840,12 +2867,23 @@ if toastermain.settings.MANAGED:
                     'hidden' : 1,
                 },
                 {   'name': 'Select',
-                    'dclass': 'span2',
-                    'qhelp': "Add or delete machines to / from your project ",
+                    'dclass': 'select span2',
+                    'qhelp': "Sets the selected machine as the project machine. You can only have one machine per project",
+                    'filter': {
+                        'class': 'select',
+                        'label': 'Show:',
+                        'options': [
+                          (u'Machines provided by layers added to this project', 'name:inprj', selected_filter_count['inprj']),
+                          (u'Machines provided by layers not added to this project', 'name:notinprj', selected_filter_count['notinprj']),
+
+                        ],
+                    }
+
                 },
 
             ]
         }
+
         response = render(request, template, context)
         _save_parameters_cookies(response, pagesize, orderby, request)
 
-- 
1.9.1


