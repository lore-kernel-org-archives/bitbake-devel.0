Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7AC6D7704A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:32:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Oct 2015 02:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="788373729"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by orsmga001.jf.intel.com with ESMTP; 09 Oct 2015 02:32:58 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:32:43 +0100
Message-Id: <184222c76e19b95840a89d4c0957e6dcc2c82c71.1444383025.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
References: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444383025.git.elliot.smith@intel.com>
References: <cover.1444383025.git.elliot.smith@intel.com>
Subject: [PATCH 5/5] toaster: Update JS unit tests
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
X-List-Received-Date: Fri, 09 Oct 2015 09:32:57 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update JS unit tests.
- Expand the add remove layer check to make sure that the layer is
  actually added to the project.
- Remove some unused vars
- Make sure that the layers/project ids will always exist at the point
  of running the test.
- Add the missing typeahead input fields to the dom to fix the failing
  typeahead test.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/tests/test.js     | 32 +++++++++++-----------
 .../toastergui/templates/js-unit-tests.html        | 16 ++++++++---
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/tests/test.js b/lib/toaster/toastergui/static/js/tests/test.js
index f0df6e4..aac0ba6 100644
--- a/lib/toaster/toastergui/static/js/tests/test.js
+++ b/lib/toaster/toastergui/static/js/tests/test.js
@@ -13,8 +13,6 @@ QUnit.test("Layer alert notification", function(assert) {
     "name":"meta-example"
   };
 
-  var correctResponse = "You have added <strong>3</strong> layers to your project: <a id=\"layer-affected-name\" href=\"/toastergui/project/1/layer/22\">meta-example</a> and its dependencies <a href=\"/toastergui/project/1/layer/9\" data-original-title=\"\" title=\"\">meta-example-two</a>, <a href=\"/toastergui/project/1/layer/9\" data-original-title=\"\" title=\"\">meta-example-three</a>";
-
   var layerDepsList = [
     {
     "layerdetailurl":"/toastergui/project/1/layer/9",
@@ -68,9 +66,9 @@ QUnit.test("Show notification", function(assert){
 });
 
 var layer = {
-  "id": 91,
-  "name":  "meta-crystalforest",
-  "layerdetailurl": "/toastergui/project/4/layer/91"
+  "id": 1,
+  "name":  "meta-testing",
+  "layerdetailurl": "/toastergui/project/1/layer/1"
 };
 
 QUnit.test("Add layer", function(assert){
@@ -84,11 +82,19 @@ QUnit.test("Add layer", function(assert){
     }
   }, 200);
 
-  libtoaster.addRmLayer(layer, true, function(deps){
-    assert.equal(deps.length, 1);
-    done();
+  /* Compare the number of layers before and after the add in the project */
+  libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+    var origNumLayers = prjInfo.layers.length;
+
+    libtoaster.addRmLayer(layer, true, function(deps){
+      libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
+        function(prjInfo){
+        assert.ok(prjInfo.layers.length > origNumLayers,
+          "Layer not added to project");
+        done();
+      });
+    });
   });
-
 });
 
 QUnit.test("Rm layer", function(assert){
@@ -156,7 +162,7 @@ QUnit.test("Layer btns init", function(assert){
 });
 
 QUnit.test("Table init", function(assert){
-  assert.throws(tableInit({ url : tableUrl }));
+  assert.throws(tableInit({ url : ctx.tableUrl }));
 });
 
 $(document).ajaxError(function(event, jqxhr, settings, errMsg){
@@ -167,9 +173,3 @@ $(document).ajaxError(function(event, jqxhr, settings, errMsg){
     assert.notOk(jqxhr.responseText);
   });
 });
-
-
-
-
-
-
diff --git a/lib/toaster/toastergui/templates/js-unit-tests.html b/lib/toaster/toastergui/templates/js-unit-tests.html
index 5b8fd84..8d65f33 100644
--- a/lib/toaster/toastergui/templates/js-unit-tests.html
+++ b/lib/toaster/toastergui/templates/js-unit-tests.html
@@ -22,9 +22,11 @@
 <script src="{% static 'js/table.js' %}"></script>
 
 <script>
-  var tableUrl = '{% url 'projectlayers' project.pk %}';
+  var ctx = {
+    tableUrl : '{% url 'projectlayers' project.pk %}',
+    projectId : {{project.pk}},
+  }
 </script>
-
 <script src="{% static 'js/tests/test.js' %}"></script>
 
 <div id="qunit"></div>
@@ -34,6 +36,12 @@
 <input type="text" id="projects" placeholder="projects"></input>
 <input type="text" id="machines" placeholder="machines"></input>
 
-{% endblock %}
-
+<!-- import layer dependency input typeahead -->
+<input type="text" id="layer-dependency" style="display:none"></input>
+<!-- project page input typeaheads -->
+<input type="text" id="layer-add-input" style="display:none"></input>
+<input type="text" id="machine-change-input" style="display:none"></input>
+<!-- import layer dependency input typeahead on layer details edit layer -->
+<input type="text" id="layer-dep-input" style="display:none"></input>
 
+{% endblock %}
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


