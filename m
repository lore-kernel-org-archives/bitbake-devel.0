Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id EC6F073E20
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 19:01:54 +0000 (UTC)
Received: by pacdd16 with SMTP id dd16so25774133pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xZE6M/KiOBK3G6osNRi8I5Pclg7YYql4Ob4+pI2W11M=;
	b=DJKdnScAFhnmaKKCMYlXCP4XFmpvTzrjXBwROINRf9yttCY/tquD4PkCY9T4SvwD9K
	cKOdF/nUFZdA7loIsEL4j3E+5ngqVbY6RCp38kT1uzL6p32rRhmImjYP3m5GAhgxQWmF
	NEZBWM6d4e3o1x4f5+Vdz2zcqB9dl1KAVj0rw4dTZ3iG0d+zowx9AsMFCm+SR7nqBcIc
	53z81LesZX1zSbhktYTFXqzgDvtaadXNF4D8oaOnHbWQ3snyoQYQXH8VFTkF5+k0n2o/
	1f9u3L9j84Ifvmg/EPdHAzK6/Z56btSDpEGWHAvUDnHdEQjH7r7LP6Y5PYlzVzNSjLZC
	Pi1A==
X-Received: by 10.66.253.170 with SMTP id ab10mr9158160pad.135.1440097314476; 
	Thu, 20 Aug 2015 12:01:54 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id w2sm3722574pdo.89.2015.08.20.12.01.53
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 20 Aug 2015 12:01:53 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Aug 2015 12:02:23 -0700
Message-Id: <413321e2452f75e96cff05f46505b5789824ddaa.1440096890.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1440096890.git.avery.brian@gmail.com>
References: <cover.1440096890.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toastergui: Add frontend javascript unit tests
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
X-List-Received-Date: Thu, 20 Aug 2015 19:01:55 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use Jquery's Qunit tests to create some unit tests for javascript
components used in toaster.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/static/js/tests/test.js     | 175 +++++++++++++++++++++
 .../toastergui/templates/js-unit-tests.html        |  39 +++++
 lib/toaster/toastergui/urls.py                     |   3 +
 lib/toaster/toastergui/views.py                    |  16 ++
 4 files changed, 233 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/tests/test.js
 create mode 100644 bitbake/lib/toaster/toastergui/templates/js-unit-tests.html

diff --git a/lib/toaster/toastergui/static/js/tests/test.js b/lib/toaster/toastergui/static/js/tests/test.js
new file mode 100644
index 0000000..d610113
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/tests/test.js
@@ -0,0 +1,175 @@
+"use strict";
+/* Unit tests for Toaster's JS */
+
+/* libtoaster tests */
+
+QUnit.test("Layer alert notification", function(assert) {
+  var layer = {
+    "layerdetailurl":"/toastergui/project/1/layer/22",
+    "vcs_url":"git://example.com/example.git",
+    "detail":"[ git://example.com/example.git | master ]",
+    "vcs_reference":"master",
+    "id": 22,
+    "name":"meta-example"
+  };
+
+  var correctResponse = "You have added <strong>3</strong> layers to your project: <a id=\"layer-affected-name\" href=\"/toastergui/project/1/layer/22\">meta-example</a> and its dependencies <a href=\"/toastergui/project/1/layer/9\" data-original-title=\"\" title=\"\">meta-example-two</a>, <a href=\"/toastergui/project/1/layer/9\" data-original-title=\"\" title=\"\">meta-example-three</a>";
+
+  var layerDepsList = [
+    {
+    "layerdetailurl":"/toastergui/project/1/layer/9",
+    "vcs_url":"git://example.com/example.git",
+    "detail":"[ git://example.com/example.git | master ]",
+    "vcs_reference":"master",
+    "id": 9,
+    "name":"meta-example-two"
+    },
+    {
+    "layerdetailurl":"/toastergui/project/1/layer/9",
+    "vcs_url":"git://example.com/example.git",
+    "detail":"[ git://example.com/example.git | master ]",
+    "vcs_reference":"master",
+    "id": 10,
+    "name":"meta-example-three"
+    },
+  ];
+
+  var msg = libtoaster.makeLayerAddRmAlertMsg(layer, layerDepsList, true);
+  var test = $("<div></div>");
+
+  test.html(msg);
+
+  assert.equal(test.children("strong").text(), "3");
+  assert.equal(test.children("a").length, 3);
+});
+
+QUnit.test("Project info", function(assert){
+  var done = assert.async();
+  libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+    assert.ok(prjInfo.machine.name);
+    assert.ok(prjInfo.releases.length > 0);
+    assert.ok(prjInfo.layers.length > 0);
+    assert.ok(prjInfo.freqtargets);
+    assert.ok(prjInfo.release);
+    done();
+  });
+});
+
+QUnit.test("Show notification", function(assert){
+  var msg = "Testing";
+  var element = $("#change-notification-msg");
+
+  libtoaster.showChangeNotification(msg);
+
+  assert.equal(element.text(), msg);
+  assert.ok(element.is(":visible"));
+
+  $("#change-notification").hide();
+});
+
+var layer = {
+  "id": 91,
+  "name":  "meta-crystalforest",
+  "layerdetailurl": "/toastergui/project/4/layer/91"
+};
+
+QUnit.test("Add layer", function(assert){
+  var done = assert.async();
+
+  /* Wait for the modal to be added to the dom */
+  var checkModal = setInterval(function(){
+    if ($("#dependencies-modal").length > 0) {
+      $("#dependencies-modal .btn-primary").click();
+      clearInterval(checkModal);
+    }
+  }, 200);
+
+  libtoaster.addRmLayer(layer, true, function(deps){
+    assert.equal(deps.length, 1);
+    done();
+  });
+
+});
+
+QUnit.test("Rm layer", function(assert){
+  var done = assert.async();
+
+  libtoaster.addRmLayer(layer, false, function(deps){
+    assert.equal(deps.length, 0);
+    done();
+  });
+
+});
+
+QUnit.test("Parse url params", function(assert){
+  var params = libtoaster.parseUrlParams();
+  assert.ok(params);
+});
+
+QUnit.test("Dump url params", function(assert){
+  var params = libtoaster.dumpsUrlParams();
+  assert.ok(params);
+});
+
+QUnit.test("Make typeaheads", function(assert){
+  var layersT = $("#layers");
+  var machinesT = $("#machines");
+  var projectsT = $("#projects");
+  var recipesT = $("#recipes");
+
+  libtoaster.makeTypeahead(layersT,
+    libtoaster.ctx.layersTypeAheadUrl, {}, function(){});
+
+  libtoaster.makeTypeahead(machinesT,
+    libtoaster.ctx.machinesTypeAheadUrl, {}, function(){});
+
+  libtoaster.makeTypeahead(projectsT,
+    libtoaster.ctx.projectsTypeAheadUrl, {}, function(){});
+
+  libtoaster.makeTypeahead(recipesT,
+    libtoaster.ctx.recipesTypeAheadUrl, {}, function(){});
+
+  assert.ok(recipesT.data('typeahead'));
+  assert.ok(layersT.data('typeahead'));
+  assert.ok(projectsT.data('typeahead'));
+  assert.ok(recipesT.data('typeahead'));
+});
+
+
+
+/* Page init functions */
+
+QUnit.test("Import layer page init", function(assert){
+  assert.throws(importLayerPageInit());
+});
+
+QUnit.test("Project page init", function(assert){
+  assert.throws(projectPageInit());
+});
+
+QUnit.test("Layer details page init", function(assert){
+  assert.throws(layerDetailsPageInit());
+});
+
+QUnit.test("Layer btns init", function(assert){
+  assert.throws(layerBtnsInit({ projectLayers : [] }));
+});
+
+QUnit.test("Table init", function(assert){
+  assert.throws(tableInit({ url : tableUrl }));
+});
+
+$(document).ajaxError(function(event, jqxhr, settings, errMsg){
+  if (errMsg === 'abort')
+    return;
+
+  QUnit.test("Ajax error", function(assert){
+    assert.notOk(jqxhr.responseText);
+  });
+});
+
+
+
+
+
+
diff --git a/lib/toaster/toastergui/templates/js-unit-tests.html b/lib/toaster/toastergui/templates/js-unit-tests.html
new file mode 100644
index 0000000..5b8fd84
--- /dev/null
+++ b/lib/toaster/toastergui/templates/js-unit-tests.html
@@ -0,0 +1,39 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% load static %}
+{% block pagecontent %}
+
+<link rel="stylesheet" href="//code.jquery.com/qunit/qunit-1.18.0.css" />
+
+<script src="//code.jquery.com/qunit/qunit-1.18.0.js"></script>
+
+<script src="{% static 'js/layerDepsModal.js' %}"></script>
+<script src="{% static 'js/projectpage.js' %}"></script>
+
+<script src="{% static 'js/bootstrap.min.js' %}"></script>
+<script src="{% static 'js/filtersnippet.js' %}"></script>
+<script src="{% static 'js/importlayer.js' %}"></script>
+<script src="{% static 'js/prettify.js' %}"></script>
+<script src="{% static 'js/layerBtn.js' %}"></script>
+<script src="{% static 'js/layerDepsModal.js' %}"></script>
+<script src="{% static 'js/projectpage.js' %}"></script>
+<script src="{% static 'js/layerdetails.js' %}"></script>
+<script src="{% static 'js/table.js' %}"></script>
+
+<script>
+  var tableUrl = '{% url 'projectlayers' project.pk %}';
+</script>
+
+<script src="{% static 'js/tests/test.js' %}"></script>
+
+<div id="qunit"></div>
+
+<input type="text" id="layers" placeholder="layers" ></input>
+<input type="text" id="recipes" placeholder="recipes"></input>
+<input type="text" id="projects" placeholder="projects"></input>
+<input type="text" id="machines" placeholder="machines"></input>
+
+{% endblock %}
+
+
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index f74090b..46e5761 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -145,6 +145,9 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
+        # JS Unit tests
+        url(r'^js-unit-tests/$', 'jsunittests', name='js-unit-tests'),
+
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'landing')),
 )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 889b6c6..e39baad 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -27,6 +27,7 @@ from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
+from orm.models import BitbakeVersion
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
@@ -2255,6 +2256,21 @@ if True:
 
         return context
 
+    def jsunittests(request):
+      """ Provides a page for the js unit tests """
+      bbv = BitbakeVersion.objects.filter(branch="master").first()
+      release = Release.objects.filter(bitbake_version=bbv).first()
+
+      name = "_js_unit_test_prj_"
+
+      # If there is an existing project by this name delete it. We don't want
+      # Lots of duplicates cluttering up the projects.
+      Project.objects.filter(name=name).delete()
+
+      new_project = Project.objects.create_project(name=name, release=release)
+
+      context = { 'project' : new_project }
+      return render(request, "js-unit-tests.html", context)
 
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
-- 
1.9.1


