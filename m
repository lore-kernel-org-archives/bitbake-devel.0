Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 091F371215
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 15:42:02 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id n3so985652wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 08:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	bh=gPQCRrOK/U0RNRIHLRiQx/QZWft2Qt4tSBV/8C7VTSg=;
	b=mhso3GamVxpukEFzUAE7qGGfkooXTsxawqmY1cHXb/Hi9bVP49jmFfO+ErD7hCmHvw
	j/qEdIIeorQgddK8aw6btimn10lbGoMRtImo7K1u+Yyq9A3kZ1KOEfq5jMA72jWiaGRY
	WclsqkH69AQxxylKIjDwqiKL6WFQvdGMGYbMHZNDS7Z2d9d1A4OjRXVCSyuig2Ayhpf+
	Y7stwQUoShALhWD1EDvrwcsOthtAzcsp+DTEyOYhxVREMdyAhXLA32s1DksWpmdKY6v2
	zZSP5iGDdRDzGviGBCEXKl1Esr3q2/Kh1pV2IeQOE48HAi/0HzpJIbBhTv015c19P8Fs
	c7Qg==
X-Gm-Message-State: ALoCoQlvDjvGscy7/hRP4gVjTnrluZIssE+xzMELTnCER1KSpO5azYf6/bslxkmMQNnenRFD49aK
X-Received: by 10.194.47.208 with SMTP id f16mr2097053wjn.130.1409326923427;
	Fri, 29 Aug 2014 08:42:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id g8sm1021515wiy.19.2014.08.29.08.42.01
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 Aug 2014 08:42:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id DE614560818; Fri, 29 Aug 2014 16:42:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 29 Aug 2014 16:41:59 +0100
Message-Id: <8309e8e58c1d7d559160747b5ec617d6c980bd26.1409326534.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1409326534.git.alexandru.damian@intel.com>
References: <cover.1409326534.git.alexandru.damian@intel.com>
MIME-Version: 1.0
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] toaster: add project pages for machines, targets, layers
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
X-List-Received-Date: Fri, 29 Aug 2014 15:42:03 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add new pages for the all-machines and all-targets
project-related views.

We update the existing template structure to create
a base project view, similar to a base build view, that includes
a breadcrumb.

Updating existing all layers view to use the new structure.

We update methods in the models to provide corrent
information display.

[YOCTO #6592]
[YOCTO #6593]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                          | 131 +++++++--------
 .../toastergui/templates/basebuilddetailpage.html  |   0
 .../toastergui/templates/baseprojectpage.html      |  43 +++++
 lib/toaster/toastergui/templates/layers.html       |   9 +-
 lib/toaster/toastergui/templates/machines.html     |  63 +++++++
 lib/toaster/toastergui/templates/project.html      |  69 ++++----
 lib/toaster/toastergui/templates/recipes.html      |   0
 lib/toaster/toastergui/templates/targets.html      | 186 +++++++++++++++++++++
 lib/toaster/toastergui/views.py                    | 173 ++++++++++++++++++-
 9 files changed, 559 insertions(+), 115 deletions(-)
 mode change 100755 => 100644 lib/toaster/toastergui/templates/basebuilddetailpage.html
 create mode 100644 lib/toaster/toastergui/templates/baseprojectpage.html
 mode change 100755 => 100644 lib/toaster/toastergui/templates/layers.html
 create mode 100644 lib/toaster/toastergui/templates/machines.html
 mode change 100755 => 100644 lib/toaster/toastergui/templates/recipes.html
 create mode 100644 lib/toaster/toastergui/templates/targets.html

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index bb921fc..77afe35 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -402,6 +402,18 @@ class Recipe(models.Model):
     bugtracker = models.URLField(blank=True)
     file_path = models.FilePathField(max_length=255)
 
+    def get_vcs_link_url(self):
+        if self.layer_version.layer.vcs_web_file_base_url is None:
+            return ""
+        return self.layer_version.layer.vcs_web_file_base_url.replace('%path%', self.file_path).replace('%branch%', self.layer_version.up_branch.name)
+
+    def get_layersource_view_url(self):
+        if self.layer_source is None:
+            return ""
+
+        url = self.layer_source.get_object_view(self.layer_version.up_branch, "recipes", self.name)
+        return url
+
     def __unicode__(self):
         return "Recipe " + self.name + ":" + self.version
 
@@ -508,6 +520,11 @@ class LayerIndexLayerSource(LayerSource):
         super(LayerIndexLayerSource, self).__init__(args, kwargs)
         self.sourcetype = LayerSource.TYPE_LAYERINDEX
 
+    def get_object_view(self, branch, objectype, upid):
+        if self != branch.layer_source:
+            raise Exception("Invalid branch specification")
+        return self.apiurl + "../branch/" + branch.name + "/" + objectype + "/?q=" + str(upid)
+
     def update(self):
         '''
             Fetches layer, recipe and machine information from remote repository
@@ -538,99 +555,79 @@ class LayerIndexLayerSource(LayerSource):
             return
 
         # update branches; only those that we already have names listed in the database
-        whitelist_branch_names = self.branchnames.split(",")
+        whitelist_branch_names = map(lambda x: x.name, Branch.objects.all())
 
         branches_info = _get_json_response(apilinks['branches']
             + "?filter=name:%s" % "OR".join(whitelist_branch_names))
         for bi in branches_info:
-            try:
-                b = Branch.objects.get(layer_source = self, name = bi['name'])
-                b.up_id = bi['id']
-                b.up_date = bi['updated']
-                b.name = bi['name']
-                b.bitbake_branch = bi['bitbake_branch']
-                b.short_description = bi['short_description']
-                b.save()
-            except Branch.DoesNotExist:
-                b = Branch.objects.create(
-                    layer_source = self,
-                    up_id = bi['id'],
-                    up_date = bi['updated'],
-                    name = bi['name'],
-                    bitbake_branch = bi['bitbake_branch'],
-                    short_description = bi['short_description']
-                )
+            b, created = Branch.objects.get_or_create(layer_source = self, name = bi['name'])
+            b.up_id = bi['id']
+            b.up_date = bi['updated']
+            b.name = bi['name']
+            b.bitbake_branch = bi['bitbake_branch']
+            b.short_description = bi['short_description']
+            b.save()
 
         # update layers
         layers_info = _get_json_response(apilinks['layerItems'])
         for li in layers_info:
-            try:
-                l = Layer.objects.get(layer_source = self,
-                    up_id = li['id'])
-                l.update(
-                    up_date = li['updated'],
-                    name = li['name'],
-                    vcs_url = li['vcs_url'],
-                    vcs_web_file_base_url = li['vcs_url'],
-                    summary = li['summary'],
-                    description = li['description'])
-            except Layer.DoesNotExist:
-                Layer.objects.create(layer_source = self,
-                    up_id = li['id'],
-                    up_date = li['updated'],
-                    name = li['name'],
-                    vcs_url = li['vcs_url'],
-                    vcs_web_file_base_url = li['vcs_url'],
-                    summary = li['summary'],
-                    description = li['description']
-                )
+            l, created = Layer.objects.get_or_create(layer_source = self, up_id = li['id'])
+            l.up_date = li['updated']
+            l.name = li['name']
+            l.vcs_url = li['vcs_url']
+            l.vcs_web_file_base_url = li['vcs_web_file_base_url']
+            l.summary = li['summary']
+            l.description = li['description']
+            l.save()
 
         # update layerbranches/layer_versions
         layerbranches_info = _get_json_response(apilinks['layerBranches']
                 + "?filter=branch:%s" % "OR".join(map(lambda x: str(x.up_id), Branch.objects.filter(layer_source = self)))
             )
         for lbi in layerbranches_info:
-            Layer_Version.objects.get_or_create(layer_source = self,
-                    up_id = lbi['id'],
-                    up_date = lbi['updated'],
-                    layer = Layer.objects.get(layer_source = self, up_id = lbi['layer']),
-                    up_branch = Branch.objects.get(layer_source = self, up_id = lbi['branch']),
-                    branch = lbi['actual_branch'],
-                    commit = lbi['vcs_last_rev'],
-                    dirpath = lbi['vcs_subdir'])
+            lv, created = Layer_Version.objects.get_or_create(layer_source = self, up_id = lbi['id'])
+
+            lv.up_date = lbi['updated']
+            lv.layer = Layer.objects.get(layer_source = self, up_id = lbi['layer'])
+            lv.up_branch = Branch.objects.get(layer_source = self, up_id = lbi['branch'])
+            lv.branch = lbi['actual_branch']
+            lv.commit = lbi['vcs_last_rev']
+            lv.dirpath = lbi['vcs_subdir']
+            lv.save()
+
 
         # update machines
         machines_info = _get_json_response(apilinks['machines']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
         for mi in machines_info:
-            Machine.objects.get_or_create(layer_source = self,
-                    up_id = mi['id'],
-                    up_date = mi['updated'],
-                    layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']),
-                    name = mi['name'],
-                    description = mi['description'])
+            mo, created = Machine.objects.get_or_create(layer_source = self, up_id = mi['id'])
+            mo.up_date = mi['updated']
+            mo.layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch'])
+            mo.name = mi['name']
+            mo.description = mi['description']
+            mo.save()
 
         # update recipes; paginate by layer version / layer branch
         recipes_info = _get_json_response(apilinks['recipes']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
         for ri in recipes_info:
-            Recipe.objects.get_or_create(layer_source = self,
-                    up_id = ri['id'],
-                    up_date = ri['updated'],
-                    layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']),
-
-                    name = ri['pn'],
-                    version = ri['pv'],
-                    summary = ri['summary'],
-                    description = ri['description'],
-                    section = ri['section'],
-                    license = ri['license'],
-                    homepage = ri['homepage'],
-                    bugtracker = ri['bugtracker'],
-                    file_path = ri['filepath'] + ri['filename']
-                )
+            ro, created = Recipe.objects.get_or_create(layer_source = self, up_id = ri['id'])
+
+            ro.up_date = ri['updated']
+            ro.layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch'])
+
+            ro.name = ri['pn']
+            ro.version = ri['pv']
+            ro.summary = ri['summary']
+            ro.description = ri['description']
+            ro.section = ri['section']
+            ro.license = ri['license']
+            ro.homepage = ri['homepage']
+            ro.bugtracker = ri['bugtracker']
+            ro.file_path = ri['filepath'] + ri['filename']
+            ro.save()
 
         pass
 
diff --git a/lib/toaster/toastergui/templates/basebuilddetailpage.html b/lib/toaster/toastergui/templates/basebuilddetailpage.html
old mode 100755
new mode 100644
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
new file mode 100644
index 0000000..54edaaf
--- /dev/null
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -0,0 +1,43 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% block pagecontent %}
+
+
+ <div class="">
+<!-- Breadcrumbs -->
+    <div class="section">
+        <ul class="breadcrumb" id="breadcrumb">
+            <li><a href="{% url 'all-builds' %}">All builds</a></li>
+            {% block parentbreadcrumb %}
+        {% if project %}
+            <li>
+                <a href="{%url 'project' project.id %}">{{project.name}}
+                </a>
+            </li>
+        {% endif %}
+            {% endblock %}
+            {% block localbreadcrumb %}{% endblock %}
+        </ul>
+        <script>
+        $( function () {
+            $('#breadcrumb > li').append("<span class=\"divider\">→</span>");
+            $('#breadcrumb > li:last').addClass("active");
+            $('#breadcrumb > li:last > span').remove();
+        });
+        </script>
+    </div>
+
+    <div class="row-fluid">
+
+        <!-- Begin right container -->
+        {% block projectinfomain %}{% endblock %}
+        <!-- End right container -->
+
+
+    </div>
+  </div>
+
+
+{% endblock %}
+
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
old mode 100755
new mode 100644
index d7d159e..bc6e5a3
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -1,7 +1,12 @@
-{% extends "base.html" %}
+{% extends "baseprojectpage.html" %}
 {% load projecttags %}
 {% load humanize %}
-{% block pagecontent %}
+
+{% block localbreadcrumb %}
+<li>Layers</li>
+{% endblock %}
+
+{% block projectinfomain %}
                 <div class="page-header">
                     <h1>
                         All layers
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
new file mode 100644
index 0000000..18e7485
--- /dev/null
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -0,0 +1,63 @@
+{% extends "baseprojectpage.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li>Machines</li>
+{% endblock %}
+
+{% block projectinfomain %}
+                <div class="page-header">
+                    <h1>
+                        All machines
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
+                     </h1>
+                </div>
+                <!--div class="alert">
+                    <div class="input-append" style="margin-bottom:0px;">
+                        <input class="input-xxlarge" type="text" placeholder="Search targets" value="browser" />
+                        <a class="add-on btn">
+                            <i class="icon-remove"></i>
+                        </a>
+                        <button class="btn" type="button">Search</button>
+                        <a class="btn btn-link" href="#">Show all targets</a>
+                    </div>
+                </div-->
+                <div id="target-added" class="alert alert-info lead" style="display:none;"></div>
+                <div id="target-removed" class="alert alert-info lead" style="display:none;">
+                    <button type="button" class="close" data-dismiss="alert">&times;</button>
+                    <strong>1</strong> target deleted from <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>
+                </div>
+
+
+{% include "basetable_top.html" %}
+    {% for o in objects %}
+    <tr class="data">
+	<td class="machine">
+		{{o.name}}
+		<a machine="_blank" href="http://layers.openembedded.org/layerindex/branch/master/machines/?q=3g-router-image"><i class="icon-share get-info"></i></a>
+	</td>
+	<td class="description">{{o.description}}</td>
+	<td class="machine-file">
+		<code>{{o.file_path}}</code>
+		<a href="http://github.com/embeddedgeeks/meta-embeddedgeeks/blob/master/machines-core/images/3g-router-image.bb" machine="_blank"><i class="icon-share get-info"></i></a>
+	</td>
+	<td class="layer"><a href="#">{{o.layer_version.layer.name}}</a></td>
+	<td class="source">{{o.layer_source.name}}</td>
+	<td class="branch">{{o.layer_version.commit}}</td>
+	<td class="build">
+		<a id="build-machine" href="project-with-machines.html?machine=3g-router-image" class="btn btn-block" style="display:none;">
+			Build machine
+		</a>
+		<a id="add-layer" href="#" class="btn btn-block nopop" title="1 layer added">
+			<i class="icon-plus"></i>
+			Add layer
+			<i class="icon-question-sign get-help" title="To build this machine, you must first add the meta-embeddedgeeks layer to your project"></i>
+		</a>
+	</td>
+    </tr>
+    {% endfor %}
+
+{% include "basetable_bottom.html" %}
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 3c59fcf..d7bfa2b 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -224,36 +224,14 @@ $(document).ready(function () {
                         <div id="dependency-alert" class="alert alert-info" style="display:none;">
                             <p><strong>meta-tizen</strong> depends on the layers below. Check the ones you want to add: </p>
                             <ul class="unstyled">
-                                <li>
-                                    <label class="checkbox">
-                                        <input checked="checked" type="checkbox">
-                                        meta-efl
-                                    </label>
-                                </li>
-                                <li>
-                                    <label class="checkbox">
-                                        <input checked="checked" type="checkbox">
-                                        meta-intel
-                                    </label>
-                                </li>
-                                <li>
-                                    <label class="checkbox">
-                                        <input checked="checked" type="checkbox">
-                                        meta-multimedia
-                                    </label>
-                                </li>
-                                <li>
-                                    <label class="checkbox">
-                                        <input checked="checked" type="checkbox">
-                                        meta-oe
-                                    </label>
-                                </li>
+	{% for f in layer_dependency %}
                                 <li>
                                     <label class="checkbox">
                                         <input checked="checked" type="checkbox">
                                         meta-ruby
                                     </label>
                                 </li>
+	{% endfor %}
                             </ul>
                             <button id="add-layer-dependencies" class="btn btn-info add-layer">Add layers</button>
                         </div>
@@ -315,27 +293,38 @@ $(document).ready(function () {
                 </div>
 
                 <div class="well well-transparent span4">
+
                     <h3>
-                        Set machine
-                        <i data-original-title="The machine is the hardware for which you want to build. You can only set one machine per project" class="icon-question-sign get-help heading-help" title=""></i>
+                        Project machine
+                        <i class="icon-question-sign get-help heading-help" title="The machine is the hardware for which you want to build. You can only set one machine per project"></i>
                     </h3>
-                    <p class="lead">
-                        {{machine}}
-                        <i title="" data-original-title="" class="icon-pencil"></i>
+                    <p class="lead" id="selected-machine"> {{machine}}
+                      <i id="change-machine" class="icon-pencil"></i>
                     </p>
-                    <h3>
-                        Set distro
-                        <i data-original-title="When you build an image using the Yocto Project and do not alter the distro, you are creating a Poky distribution" class="icon-question-sign get-help heading-help" title=""></i>
-                    </h3>
-                    <p class="lead">
-                        {{distro}}
-                        <i title="" data-original-title="" class="icon-pencil"></i>
+                    <form id="select-machine">
+                        <div class="alert alert-info">
+                            <strong>Machine changes have a big impact on build outcome.</strong>
+                            You cannot really compare the builds for the new machine with the previous ones.
+                        </div>
+                        <div class="input-append">
+                            <input type="text" id="machine" autocomplete="off" value="qemux86" data-provide="typeahead"
+                            data-minLength="1"
+                            data-autocomplete="off"
+                            data-source='[
+                            ]'>
+                            <button id="apply-change-machine" class="btn" type="button">Save</button>
+                            <a href="#" id="cancel-machine" class="btn btn-link">Cancel</a>
+                        </div>
+                        <p><a href="{% url 'machines' %}" class="link">View all machines</a></p>
+                    </form>
+                    <p class="link-action">
+                        <a href="{% url 'projectconf' project.id %}" class="link">Edit configuration variables</a>
+                        <i class="icon-question-sign get-help heading-help" title="You can set other project configuration options here. Each option, like everything else in the build system, is a variable - value pair"></i>
                     </p>
-					<p class="link-action">
-						<a href="{% url 'projectconf' project.id %}" class="link">Edit configuration variables</a>
-						<i class="icon-question-sign get-help heading-help" title="You can set other project configuration options here. Each option, like everything else in the build system, is a variable - value pair"></i>
-					</p>
+
                 </div>
+
+
             </div>
 
             <h2>Project details</h2>
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
old mode 100755
new mode 100644
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
new file mode 100644
index 0000000..3afdf0a
--- /dev/null
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -0,0 +1,186 @@
+{% extends "baseprojectpage.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li>Targets</li>
+{% endblock %}
+
+{% block projectinfomain %}
+                <div class="page-header">
+                    <h1>
+                        All targets
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the targets compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
+                     </h1>
+                </div>
+                <!--div class="alert">
+                    <div class="input-append" style="margin-bottom:0px;">
+                        <input class="input-xxlarge" type="text" placeholder="Search targets" value="browser" />
+                        <a class="add-on btn">
+                            <i class="icon-remove"></i>
+                        </a>
+                        <button class="btn" type="button">Search</button>
+                        <a class="btn btn-link" href="#">Show all targets</a>
+                    </div>
+                </div-->
+                <div id="target-added" class="alert alert-info lead" style="display:none;"></div>
+                <div id="target-removed" class="alert alert-info lead" style="display:none;">
+                    <button type="button" class="close" data-dismiss="alert">&times;</button>
+                    <strong>1</strong> target deleted from <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>
+                </div>
+
+
+{% include "basetable_top.html" %}
+    {% for o in objects %}
+    <tr class="data">
+	<td class="target">
+		{{o.name}} ({{o.id}}, {{o.up_id}})
+		<a target="_blank" href="{{o.get_layersource_view_url}}"><i class="icon-share get-info"></i></a>
+	</td>
+	<td class="version">{{o.version}}</td>
+	<td class="description">{{o.description}}</td>
+	<td class="recipe-file">
+		<code>{{o.file_path}}</code>
+		<a href="{{o.get_vcs_link_url}}" target="_blank"><i class="icon-share get-info"></i></a>
+	</td>
+	<td class="target-section">{{o.section}}</td>
+	<td class="license">{{o.license}}</td>
+	<td class="layer"><a href="#">{{o.layer_version.layer.name}}</a></td>
+	<td class="source">{{o.layer_source.name}}</td>
+	<td class="branch">{{o.layer_version.commit}}</td>
+	<td class="build">
+		<a id="build-target" href="project-with-targets.html?target=3g-router-image" class="btn btn-block" style="display:none;">
+			Build target
+		</a>
+		<a id="add-layer" href="#" class="btn btn-block nopop" title="1 layer added">
+			<i class="icon-plus"></i>
+			Add layer
+			<i class="icon-question-sign get-help" title="To build this target, you must first add the meta-embeddedgeeks layer to your project"></i>
+		</a>
+	</td>
+    </tr>
+    {% endfor %}
+{% include "basetable_bottom.html" %}
+
+    <!-- Modals -->
+
+    <!-- 'Layer dependencies modal' -->
+    <div id="dependencies-message" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
+        <div class="modal-header">
+            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
+            <h3>meta-acer dependencies</h3>
+        </div>
+        <div class="modal-body">
+            <p><strong>meta-acer</strong> depends on some targets that are not added to your project. Select the ones you want to add:</p>
+            <ul class="unstyled">
+                <li>
+                    <label class="checkbox">
+                        <input type="checkbox" checked="checked">
+                        meta-android
+                    </label>
+                </li>
+                <li>
+                    <label class="checkbox">
+                        <input type="checkbox" checked="checked">
+                        meta-oe
+                    </label>
+                </li>
+            </ul>
+        </div>
+        <div class="modal-footer">
+            <button id="add-target-dependencies" type="submit" class="btn btn-primary" data-dismiss="modal" >Add targets</button>
+            <button class="btn" data-dismiss="modal">Cancel</button>
+        </div>
+    </div>
+
+    <script src="assets/js/jquery-1.9.1.min.js" type='text/javascript'></script>
+    <script src="assets/js/jquery.tablesorter.min.js" type='text/javascript'></script>
+    <script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
+    <script src="assets/js/bootstrap.min.js" type='text/javascript'></script>
+    <script src="assets/js/prettify.js" type='text/javascript'></script>
+    <script src="assets/js/jit.js" type='text/javascript'></script>
+    <script src="assets/js/main.js" type='text/javascript'></script>
+
+    <script>
+     $(document).ready(function() {
+
+        //show or hide selected columns on load
+        $("input:checkbox").each(function(){
+            var selectedType = $(this).val();
+            if($(this).is(":checked")){
+                $("."+selectedType).show();
+            }
+            else{
+                $("."+selectedType).hide();
+            }
+        });
+
+        // enable add target button
+        $('#add-target-with-deps').removeAttr('disabled');
+
+        //edit columns functionality (show / hide table columns)
+        $("input:checkbox").change();
+            $("input:checkbox").change(function(){
+                var selectedType = $(this).val();
+                    if($(this).is(":checked")){
+                        $("."+selectedType).show();
+                    }
+                    else{
+                        $("."+selectedType).hide();
+                    }
+            });
+
+        //turn edit columns dropdown into a multi-select menu
+        $('.dropdown-menu input, .dropdown-menu label').click(function(e) {
+            e.stopPropagation();
+        });
+
+        //show tooltip with applied filter
+        $('#filtered').tooltip({container:'table', placement:'bottom', delay:{hide:1500}, html:true});
+
+        $('#filtered').click(function() {
+            $(this).tooltip('hide');
+        });
+
+        //show target added tooltip
+        $("#remove-target, #add-target, #add-target-with-deps2").tooltip({ trigger: 'manual' });
+
+        // add target without dependencies
+        $("#add-target").click(function(){
+            $('#target-removed').hide();
+            $('#target-added').html('<button type="button" class="close" data-dismiss="alert">&times;</button><strong>1</strong> target added to <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>').fadeIn();
+            $('#add-target').tooltip('show');
+            $("#add-target").hide();
+            $(".add-targets .tooltip").delay(2000).fadeOut(function(){
+                $("#remove-target").delay(300).fadeIn();
+            });
+        });
+
+        // add target with dependencies
+        $(document).on("click", "#add-target-dependencies", function() {
+            $('#target-removed').hide();
+            $('#target-added').html('<button type="button" class="close" data-dismiss="alert">&times;</button><strong>3</strong> targets added to <a href="project-with-targets.html">your project</a>: <a href="#">meta-acer</a> and its dependencies <a href="#">meta-android</a> and <a href="#">meta-oe</a>').delay(400).fadeIn(function(){
+                $('#add-target-with-deps').tooltip('show');
+                $("#add-target-with-deps, #add-target-with-deps").hide();
+                $(".add-targets .tooltip").delay(2000).fadeOut(function(){
+                    $("#remove-target-with-deps").delay(300).fadeIn();
+                });
+            });
+        });
+
+        // delete target
+        $("#remove-target").click(function(){
+            $('#target-added').hide();
+            $('#target-removed').show();
+            $('#remove-target').tooltip('show');
+            $("#remove-target").hide();
+            $(".add-targets .tooltip").delay(2000).fadeOut(function(){
+                $("#add-target").delay(300).fadeIn();
+            });
+        });
+
+     });
+
+</script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 86a34ad..167b687 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1761,7 +1761,7 @@ if toastermain.settings.MANAGED:
     from django.contrib.auth.decorators import login_required
 
     from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
-    from orm.models import Branch, LayerSource, ToasterSetting, Release
+    from orm.models import Branch, LayerSource, ToasterSetting, Release, Machine
     from bldcontrol.models import BuildRequest
 
     import traceback
@@ -1770,10 +1770,13 @@ if toastermain.settings.MANAGED:
 
     # the context processor that supplies data used across all the pages
     def managedcontextprocessor(request):
-        return {
+        ret = {
             "projects": Project.objects.all(),
             "MANAGED" : toastermain.settings.MANAGED
         }
+        if 'project' in request.session:
+            ret['project'] = request.session['project']
+        return ret
 
     # new project
     def newproject(request):
@@ -1922,7 +1925,7 @@ if toastermain.settings.MANAGED:
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
-        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'layer__name:-' };
+        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'layer__name:+' };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
             return _redirect_parameters( 'layers', request.GET, mandatory_parameters)
@@ -1945,7 +1948,8 @@ if toastermain.settings.MANAGED:
         context = {
             'objects' : layer_info,
             'objectname' : "layers",
-            'default_orderby' : 'completed_on:-',
+            'default_orderby' : 'layer__name:+',
+            'total_count': queryset_with_search.count(),
 
             'tablecols' : [
                 {   'name': 'Layer',
@@ -1954,8 +1958,10 @@ if toastermain.settings.MANAGED:
                 },
                 {   'name': 'Description',
                     'dclass': 'span4',
+                    'clclass': 'description',
                 },
                 {   'name': 'Layer source',
+                    'clclass': 'source',
                     'qhelp': "Where the layer is coming from, for example, if it's part of the OpenEmbedded collection of layers or if it's a layer you have imported",
                     'orderfield': _get_toggle_order(request, "layer_source__name"),
                     'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
@@ -1967,15 +1973,20 @@ if toastermain.settings.MANAGED:
                 },
                 {   'name': 'Git repository URL',
                     'dclass': 'span6',
+                    'clclass': 'git-repo', 'hidden': 1,
                     'qhelp': "The Git repository for the layer source code",
                 },
                 {   'name': 'Subdirectory',
+                    'clclass': 'git-subdir',
+                    'hidden': 1,
                     'qhelp': "The layer directory within the Git repository",
                 },
                 {   'name': 'Branch, tag o commit',
+                    'clclass': 'branch',
                     'qhelp': "The Git branch of the layer. For the layers from the OpenEmbedded source, the branch matches the Yocto Project version you selected for this project",
                 },
                 {   'name': 'Dependencies',
+                    'clclass': 'dependencies',
                     'qhelp': "Other layers a layer depends upon",
                 },
                 {   'name': 'Add | Delete',
@@ -1992,10 +2003,160 @@ if toastermain.settings.MANAGED:
         raise Exception("TODO: implement page #6591")
 
     def targets(request):
-        raise Exception("TODO: implement page #6592")
+        template = "targets.html"
+        # define here what parameters the view needs in the GET portion in order to
+        # be able to display something.  'count' and 'page' are mandatory for all views
+        # that use paginators.
+        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'name:+' };
+        retval = _verify_parameters( request.GET, mandatory_parameters )
+        if retval:
+            return _redirect_parameters( 'targets', request.GET, mandatory_parameters)
+
+        # boilerplate code that takes a request for an object type and returns a queryset
+        # for that object type. copypasta for all needed table searches
+        (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
+
+        queryset_all = Recipe.objects.all()
+        if 'project' in request.session:
+            queryset_all = queryset_all.filter(Q(layer_version__up_branch__in = Branch.objects.filter(name = request.session['project'].release.name)) | Q(layer_version__build__in = request.session['project'].build_set.all()))
+
+        queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
+        queryset = _get_queryset(Recipe, queryset_all, filter_string, search_term, ordering_string, '-name')
+
+        # retrieve the objects that will be displayed in the table; targets a paginator and gets a page range to display
+        target_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+
+
+        context = {
+            'objects' : target_info,
+            'objectname' : "targets",
+            'default_orderby' : 'name:+',
+            'total_count': queryset_with_search.count(),
+
+            'tablecols' : [
+                {   'name': 'Target',
+                    'orderfield': _get_toggle_order(request, "name"),
+                    'ordericon' : _get_toggle_order_icon(request, "name"),
+                },
+                {   'name': 'Target version',
+                    'dclass': 'span2',
+                },
+                {   'name': 'Description',
+                    'dclass': 'span5',
+                    'clclass': 'description',
+                },
+                {   'name': 'Recipe file',
+                    'clclass': 'recipe-file',
+                    'hidden': 1,
+                    'dclass': 'span5',
+                },
+                {   'name': 'Section',
+                    'clclass': 'target-section',
+                    'hidden': 1,
+                },
+                {   'name': 'License',
+                    'clclass': 'license',
+                    'hidden': 1,
+                },
+                {   'name': 'Layer',
+                    'clclass': 'layer',
+                },
+                {   'name': 'Layer source',
+                    'clclass': 'source',
+                    'qhelp': "Where the target is coming from, for example, if it's part of the OpenEmbedded collection of targets or if it's a target you have imported",
+                    'orderfield': _get_toggle_order(request, "layer_source__name"),
+                    'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
+                    'filter': {
+                        'class': 'target',
+                        'label': 'Show:',
+                        'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
+                    }
+                },
+                {   'name': 'Branch, tag or commit',
+                    'clclass': 'branch',
+                    'hidden': 1,
+                },
+                {   'name': 'Build',
+                    'dclass': 'span2',
+                    'qhelp': "Add or delete targets to / from your project ",
+                },
+
+            ]
+        }
+
+        return render(request, template, context)
 
     def machines(request):
-        raise Exception("TODO: implement page #6593")
+        template = "machines.html"
+        # define here what parameters the view needs in the GET portion in order to
+        # be able to display something.  'count' and 'page' are mandatory for all views
+        # that use paginators.
+        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'name:+' };
+        retval = _verify_parameters( request.GET, mandatory_parameters )
+        if retval:
+            return _redirect_parameters( 'machines', request.GET, mandatory_parameters)
+
+        # boilerplate code that takes a request for an object type and returns a queryset
+        # for that object type. copypasta for all needed table searches
+        (filter_string, search_term, ordering_string) = _search_tuple(request, Machine)
+
+        queryset_all = Machine.objects.all()
+#        if 'project' in request.session:
+#            queryset_all = queryset_all.filter(Q(layer_version__up_branch__in = Branch.objects.filter(name = request.session['project'].release.name)) | Q(layer_version__build__in = request.session['project'].build_set.all()))
+
+        queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
+        queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
+
+        # retrieve the objects that will be displayed in the table; machines a paginator and gets a page range to display
+        machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+
+
+        context = {
+            'objects' : machine_info,
+            'objectname' : "machines",
+            'default_orderby' : 'name:+',
+            'total_count': queryset_with_search.count(),
+
+            'tablecols' : [
+                {   'name': 'Machine',
+                    'orderfield': _get_toggle_order(request, "name"),
+                    'ordericon' : _get_toggle_order_icon(request, "name"),
+                },
+                {   'name': 'Description',
+                    'dclass': 'span5',
+                    'clclass': 'description',
+                },
+                {   'name': 'Machine file',
+                    'clclass': 'machine-file',
+                    'hidden': 1,
+                },
+                {   'name': 'Layer',
+                    'clclass': 'layer',
+                },
+                {   'name': 'Layer source',
+                    'clclass': 'source',
+                    'qhelp': "Where the machine is coming from, for example, if it's part of the OpenEmbedded collection of machines or if it's a machine you have imported",
+                    'orderfield': _get_toggle_order(request, "layer_source__name"),
+                    'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
+                    'filter': {
+                        'class': 'machine',
+                        'label': 'Show:',
+                        'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
+                    }
+                },
+                {   'name': 'Branch, tag or commit',
+                    'clclass': 'branch',
+                    'hidden': 1,
+                },
+                {   'name': 'Select',
+                    'dclass': 'span2',
+                    'qhelp': "Add or delete machines to / from your project ",
+                },
+
+            ]
+        }
+
+        return render(request, template, context)
 
     def projectconf(request, pid):
         raise Exception("TODO: implement page #6588")
-- 
1.9.1


