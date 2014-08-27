Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182])
	by mail.openembedded.org (Postfix) with ESMTP id 3F0927117D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:46 +0000 (UTC)
Received: by mail-we0-f182.google.com with SMTP id k48so552793wev.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=awWoCU7FfxdKgw3hjHWq1wwXUm511FCUgGs9EcEiEWY=;
	b=Zmvf5A0eF10HZIuiPNMRRx6Z7G8cHqK6Ihj3yO2CA2EJa4mBWgqQJIvZgerSRfUNK7
	4Zd0TAKN96fW84TbH5UTDk/fYCiAhKfvqyZrP/Ppqgrrd0mx+wH7UXTYpIfE5Xw2csV9
	6sHw9g8T3Sxxg8Gi51O7IEEvMdBBbWwn0etYBBrODFFRoLG5ccEsSB6Ec5tfCc2KLlQA
	pdPMpJjma8UrtPtev/Piv5MFCM8HZFlitUepQTYy2dQxTrwBw2ZIMMOtCrnnhd9YZzm+
	3Sh1Jw2v6ZZJEN43ZM6tmbuIvQ9Wi9usu/4C1APgEmylHKqzphVMrEh8SPcL+3Cr36sS
	AOQw==
X-Gm-Message-State: ALoCoQm8p8G2v6PMZeGXhG0P4JxDv9yHkhDrLB6RavC/4tcWBiqcrzKuux9Y3j64BEcPrC5iMFJ/
X-Received: by 10.194.119.41 with SMTP id kr9mr4979232wjb.114.1409160227575;
	Wed, 27 Aug 2014 10:23:47 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l3sm25889429wib.11.2014.08.27.10.23.46
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:46 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 72D1756113A; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:37 +0100
Message-Id: <c02136283805732a9a6a7744ae7d755915149abb.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/11] toaster: create project section navigation structure
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:48 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We create the navigation structure for the project section.
This includes adding URLs for configuration, builds, all layers,
layer details and all targets pages.

Changes to existing pages to exemplify navigation links.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/newproject.html |  5 ++-
 lib/toaster/toastergui/templates/project.html    | 47 ++++++++++++-----------
 lib/toaster/toastergui/urls.py                   | 11 +++++-
 lib/toaster/toastergui/views.py                  | 48 +++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 8f1867a..6ee27d1 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -28,8 +28,9 @@
 								<i class="icon-question-sign get-help" title="This sets the branch for the Yocto Project core layers (meta, meta-yocto and meta-yocto-bsp), and for the layers you use from the OpenEmbedded Metadata Index"></i>
 							</label>
 							<select name="projectversion" id="projectversion">
-		<!-- TODO: XHR data from http://layers.openembedded.org/layerindex/branch/master/layers/ -->
-		<option value="master" {%if projectversion == "master" %}selected{%endif%}>master</option>
+	{% for br in branches %}
+		<option value="{{br.id}}"{%if projectversion == br.id %} selected{%endif%}>{{br.name}} ({{br.short_description}})</option>
+	{% endfor %}
 							</select>
 						</fieldset>
 
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index c859f6b..0ddfeb3 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -71,10 +71,29 @@ function postEditAjaxRequest(reqdata) {
         })
 }
 
+
+
+
 $(document).ready(function () {
     setEventHandlers();
+
+    /* Provide XHR calls for the "build" buttons.*/
+    $("button#build-all-button").click( function (evt) {
+        var ajax = $.ajax({
+            type:"POST",
+            url:"{% url 'xhr_projectbuild' project.id %}",
+            headers: { 'X-CSRFToken': $.cookie("csrftoken")},
+            success: function (data, textstatus) {
+                if (data.error != "ok") {
+                    alert("XHR fail: " + data.error );
+                }
+            },
+            error: function (jqXHR, textstatus, error) { alert("XHR errored:" + error + "(" + textstatus + ")"); },
+        })
+    });
 });
 
+
 </script>
 
 
@@ -97,23 +116,7 @@ $(document).ready(function () {
                         <input class="huge input-xxlarge" placeholder="Or enter the target you want to build" autocomplete="off" data-minlength="1" data-autocomplete="off" data-provide="typeahead" data-source="" type="text">
                         <button id="build-button" class="btn btn-large" disabled="">Build</button>
                     </div>
-                    <script>
-/* Provide XHR calls for the "build" buttons.*/
-$("button#build-all-button").click( function (evt) {
-    var ajax = $.ajax({
-            type:"POST",
-            url:"{% url 'xhr_projectbuild' project.id %}",
-            headers: { 'X-CSRFToken': $.cookie("csrftoken")},
-            success: function (data, textstatus) {
-                if (data.error != "ok") {
-                    alert("XHR fail: " + data.error );
-                }
-            },
-            error: function (jqXHR, textstatus, error) { alert("XHR errored:" + error + "(" + textstatus + ")"); },
-        })
-});
 
-                    </script>
                     <!--span class="help-inline">This target is not provided <br />by any of your added layers
                         <i class="icon-question-sign get-help get-help-red" title="Review your list of added layers to make sure one of them provides core-image-xyz. Clicking on a layer name will give you all the information Toaster has about the layer"></i>
                     </span>
@@ -255,7 +258,7 @@ $("button#build-all-button").click( function (evt) {
                             <button id="add-layer-dependencies" class="btn btn-info add-layer">Add layers</button>
                         </div>
 
-                        <p><a href="#">Import your layer</a> | <a href="#">View all layers</a></p>
+                        <p><a href="{% url 'importlayer' %}">Import your layer</a> | <a href="{% url 'layers'%}">View all layers</a></p>
                     </form>
 
                     <h4 class="air">
@@ -286,7 +289,7 @@ $("button#build-all-button").click( function (evt) {
                             <button id="add-target-button" class="btn" type="button">Add</button>
                         </div>
 
-                        <p><a href="#" class="link">View all targets</a></p>
+                        <p><a href="{% url 'targets' %}" class="link">View all targets</a></p>
                     </form>
                     <h4 class="air">
                         Added targets
@@ -328,10 +331,10 @@ $("button#build-all-button").click( function (evt) {
                         {{distro}}
                         <i title="" data-original-title="" class="icon-pencil"></i>
                     </p>
-                    <p class="localconf">
-                        <a href="#" class="link">Edit the <code>local.conf</code> file</a>
-                        <i data-original-title="The <code>local.conf</code> file is where other project configuration options are set. Pretty much any configuration option can be set in this file. Each option, like everything else in the build system, is a variable - value pair" class="icon-question-sign get-help heading-help" title=""></i>
-                    </p>
+					<p class="link-action">
+						<a href="{% url 'projectconf' project.id %}" class="link">Edit configuration variables</a>
+						<i class="icon-question-sign get-help heading-help" title="You can set other project configuration options here. Each option, like everything else in the build system, is a variable - value pair"></i>
+					</p>
                 </div>
             </div>
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 7c4f894..30f0063 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -63,12 +63,21 @@ urlpatterns = patterns('toastergui.views',
 
 
         # urls not linked from the dashboard
-        url(r'^layers/$', 'layer', name='all-layers'),
         url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
 
         # project URLs
         url(r'^newproject/$', 'newproject', name='newproject'),
+        url(r'^importlayer/$', 'importlayer', name='importlayer'),
+
+        url(r'^layers/$', 'layers', name='layers'),
+        url(r'^layer/(?P<layerid>\d+)/$', 'layerdetails', name='layerdetails'),
+        url(r'^targets/$', 'targets', name='targets'),
+        url(r'^machines/$', 'machines', name='machines'),
+
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
+        url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
+        url(r'^project/(?P<pid>\d+)/builds$', 'projectbuilds', name='projectbuild'),
+
         url(r'^xhr_projectbuild/(?P<pid>\d+)/$', 'xhr_projectbuild', name='xhr_projectbuild'),
         url(r'^xhr_projectedit/(?P<pid>\d+)/$', 'xhr_projectedit', name='xhr_projectedit'),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bd65c08..cad2357 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1772,6 +1772,7 @@ if toastermain.settings.MANAGED:
     from django.contrib.auth.decorators import login_required
 
     from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
+    from orm.models import Branch, LayerSource, ToasterSetting
     from bldcontrol.models import BuildRequest
 
     import traceback
@@ -1791,6 +1792,8 @@ if toastermain.settings.MANAGED:
         context = {
             'email': request.user.email if request.user.is_authenticated() else '',
             'username': request.user.username if request.user.is_authenticated() else '',
+            'branches': Branch.objects.order_by("-up_id"),
+            'defaultbranch': ToasterSetting.objects.get(name = "DEFAULT_RELEASE").value,
         }
 
 
@@ -1816,7 +1819,7 @@ if toastermain.settings.MANAGED:
 
                 #  save the project
                 prj = Project.objects.create_project(name = request.POST['projectname'],
-                    branch = request.POST['projectversion'].split(" ")[0],
+                    branch = Branch.objects.get(pk = request.POST['projectversion'].split(" ")[0]),
                     short_description=request.POST['projectversion'].split(" ")[1:])
                 prj.user_id = request.user.pk
                 prj.save()
@@ -1919,6 +1922,26 @@ if toastermain.settings.MANAGED:
         except Exception as e:
             return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
+    def importlayer(request):
+        raise Exception("TODO: implement page #6595")
+
+    def layers(request):
+        raise Exception("TODO: implement page #6590")
+
+    def layerdetails(request, layerid):
+        raise Exception("TODO: implement page #6591")
+
+    def targets(request):
+        raise Exception("TODO: implement page #6592")
+
+    def machines(request):
+        raise Exception("TODO: implement page #6593")
+
+    def projectconf(request, pid):
+        raise Exception("TODO: implement page #6588")
+
+    def projectbuilds(request, pid):
+        raise Exception("TODO: implement page #6589")
 
 else:
     # these are pages that are NOT available in interactive mode
@@ -1940,3 +1963,26 @@ else:
     def xhr_projectedit(request, pid):
         raise Exception("page not available in interactive mode")
 
+    def importlayer(request):
+        raise Exception("page not available in interactive mode")
+
+    def layers(request):
+        raise Exception("page not available in interactive mode")
+
+    def layerdetails(request):
+        raise Exception("page not available in interactive mode")
+
+    def targets(request):
+        raise Exception("page not available in interactive mode")
+
+    def targetdetails(request):
+        raise Exception("page not available in interactive mode")
+
+    def machines(request):
+        raise Exception("page not available in interactive mode")
+
+    def projectconf(request):
+        raise Exception("page not available in interactive mode")
+
+    def projectbuilds(request):
+        raise Exception("page not available in interactive mode")
-- 
1.9.1


