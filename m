Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 686D275645
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:31 +0000 (UTC)
Received: by wiwd19 with SMTP id d19so50729214wiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Ec1Mg3Lbv00/UzSnZqbNsYHDf3Uj/ZuJ0BtNTShkDuE=;
	b=UxDiIC6zb/AmO725UesihlhL9Ph6INvNpEqjWHmjrkrilzd6GMzYbv8zjHX9j1M6Fi
	pfgN0QtCSooRER/4Zq1ul3c+xPxskQoK3SPzxZkU38v9TGg4y38QSlVJ22G9y/J4HitX
	5oLk7bpDAgmLsTs8Wps0zWPlNaUP4cXJLm5QdixwxIrLk1HHsO6xFVfo+nTJJaCYYjI5
	NkbgoOay6Ln7muX0VPHQ/WhqHtEPoPgxAhfgbEmktDW8wO0INIUHuLdGo5ZQuE0/c5++
	K264B5VnYW0r2yZ4lInaSAIPrH84fAzUSEVmnNApUVEWat+neezvlzWhyC/t6QKNNENe
	/Zfw==
X-Gm-Message-State: ALoCoQk/1OVxGq7EPQ8pz45WNDTnbhn8G7xXLJ/Swxw4p2L6OkSbIxbgcwzo1r2TlURY5CLbGOSX
X-Received: by 10.194.120.198 with SMTP id le6mr6861475wjb.133.1433947171203; 
	Wed, 10 Jun 2015 07:39:31 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	z12sm14839661wjq.12.2015.06.10.07.39.29
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:30 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 1385E561148; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:55 +0100
Message-Id: <fb683135348b074412da154585c75865aad1eab0.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 07/19] toaster: ToasterTables add computational fields
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:33 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds the ability to pass a function to be computed
for generating a field value in setting up a column in
ToasterTables.

Also adding "displayable" property that can be turned False for
columns that are present in JSON data but are not part of the UI.

Add the "id" column by default for all rows.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 13 +++++++++++++
 lib/toaster/toastergui/tables.py          |  8 ++++++--
 lib/toaster/toastergui/views.py           |  3 +++
 lib/toaster/toastergui/widgets.py         | 19 ++++++++++++++++---
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 80e9ec2..45c6184 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -110,9 +110,13 @@ function tableInit(ctx){
     setupTableChrome(tableData);
 
     /* Add table data rows */
+    var column_index;
     for (var i in tableData.rows){
+      /* only display if the column is display-able */
       var row = $("<tr></tr>");
+      column_index = -1;
       for (var key_j in tableData.rows[i]){
+
         /* if we have a static: version of a key, prefer the static: version for rendering */
         var orig_key_j = key_j;
 
@@ -125,6 +129,12 @@ function tableInit(ctx){
           key_j = "static:" + key_j;
         }
 
+        /* we skip over un-displayable column entries */
+        column_index += 1;
+        if (! tableData.columns[column_index].displayable) {
+          continue;
+        }
+
         var td = $("<td></td>");
         td.prop("class", orig_key_j);
         if (tableData.rows[i][key_j]){
@@ -206,6 +216,9 @@ function tableInit(ctx){
     /* Add table header and column toggle menu */
     for (var i in tableData.columns){
       var col = tableData.columns[i];
+      if (col.displayable === false) {
+        continue;
+      }
       var header = $("<th></th>");
       header.prop("class", col.field_name);
 
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index b75e565..e540b91 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -79,7 +79,7 @@ class LayersTable(ToasterTable):
         self.add_column(title="Git repository URL",
                         help_text="The Git repository for the layer source code",
                         hidden=True,
-                        static_data_name="git_url",
+                        static_data_name="layer__vcs_url",
                         static_data_template=git_url_template)
 
         git_dir_template = '''
@@ -328,13 +328,17 @@ class RecipesTable(ToasterTable):
         self.add_column(title="Revision",
                         field_name="layer_version__get_vcs_reference")
 
-
         self.add_column(title="Build",
                         help_text="Add or delete recipes to and from your project",
                         hideable=False,
                         static_data_name="add-del-layers",
                         static_data_template='{% include "recipe_btn.html" %}')
 
+        self.add_column(title="Project compatible Layer ID",
+                        displayable = False,
+                        field_name = "projectcompatible_layer",
+                        computation = lambda x: (x.layer_version.get_equivalents_wpriority(Project.objects.get(pk=kwargs['pid']))[0]))
+
 class LayerRecipesTable(RecipesTable):
     """ Smaller version of the Recipes table for use in layer details """
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 280159a..c25c512 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -112,6 +112,9 @@ def objtojson(obj):
             elif isinstance(d[di], int) and hasattr(obj, "get_%s_display" % di):
                 nd[di] = getattr(obj, "get_%s_display" % di)()
         return nd
+    elif isinstance( obj, type(lambda x:x)):
+        import inspect
+        return inspect.getsourcelines(obj)[0]
     else:
         raise TypeError("Unserializable object %s (%s) of type %s" % ( obj, dir(obj), type(obj)))
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 82b7514..407a0fb 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -54,6 +54,13 @@ class ToasterTable(TemplateView):
         self.empty_state = "Sorry - no data found"
         self.default_orderby = ""
 
+        # add the "id" column, undisplayable, by default
+        self.add_column(title="Id",
+                        displayable=False,
+                        orderable=True,
+                        field_name="id")
+
+
     def get(self, request, *args, **kwargs):
         if request.GET.get('format', None) == 'json':
 
@@ -142,6 +149,7 @@ class ToasterTable(TemplateView):
     def add_column(self, title="", help_text="",
                    orderable=False, hideable=True, hidden=False,
                    field_name="", filter_name=None, static_data_name=None,
+                   displayable=True, computation=None,
                    static_data_template=None):
         """Add a column to the table.
 
@@ -168,6 +176,8 @@ class ToasterTable(TemplateView):
                              'filter_name' : filter_name,
                              'static_data_name': static_data_name,
                              'static_data_template': static_data_template,
+                             'displayable': displayable,
+                             'computation': computation,
                             })
 
     def render_static_data(self, template, row):
@@ -289,8 +299,11 @@ class ToasterTable(TemplateView):
 
                         col['field_name'] = col['static_data_name']
 
-                    if True:        # we add the raw model data at all times
-                        model_data = row
+                    # compute the computation on the raw data if needed
+                    model_data = row
+                    if col['computation']:
+                        model_data = col['computation'](row)
+                    else:
                         # Traverse to any foriegn key in the object hierachy
                         for subfield in field.split("__"):
                             if hasattr(model_data, subfield):
@@ -300,7 +313,7 @@ class ToasterTable(TemplateView):
                         if isinstance(model_data, types.MethodType):
                           model_data = model_data()
 
-                        required_data[field] = model_data
+                    required_data[col['field_name']] = model_data
 
                 data['rows'].append(required_data)
 
-- 
1.9.1


