Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id A3FB56013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:13 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id t79so32675706wmt.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LOEt6dRWLuo6WqyMnn6G3Sn5mBgV705+wei4EnRJag0=;
	b=lMXsv0vJ7Sir79isOJqjCCzJloefyYT/wm7M6VIFi4Ibdujjb8YwnfVYTgErFFUUBj
	/0JXFQkXZVXSdQcTr3jGc1er/WJ+sM1uhGk2EpBh0IkdDY+46qytlQSUjtEqqCoF/o56
	nL15PiAVHs/y0psNMbGM9TtrMiaw4A/1RCaeacF/Gq6ktRyY78Vx7g5ZOaUjx//H9hc6
	QoRg1P7BLe1FIcnc05gwBVM19+EPNioySps1uF8+BnuLuPR/1JfBbZroypjs36Pv+CNJ
	ixzaV5RRG9rc1eWym/WS3IGL+tDla5O84OmVtR2NesPBzz7c3zkWRzkAuU/a144XlDJq
	bEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LOEt6dRWLuo6WqyMnn6G3Sn5mBgV705+wei4EnRJag0=;
	b=kumIxGNxpXBkzVZRuXvqjtClRJEgrRvoRYaOO7haihTxKtyjXWoiKuzyrF7jOdfQs7
	rDRAIGbl/xbMJD06Aq/bBRkMRxPRRVH1wHtHMkUN/414ipBiNTZArUVCJ2bcUOOnLhTx
	cNneYLMKIBb8d/dGeuSrB53+MWV5oN43LVoGg0Qq2kowJFlLHSmO89MtZYCdQKNeetnw
	PqtiFADbsvd1NYYLnPE6UiuWPCQcgSdawUS1RSTN1BRcpQ9qHIxAGb83VrdHTWtoRZh7
	qTnPFdVg1aevfojpD/4ivuZ08CVKw8mFk1pY4mivIcp9np/hLoJxmCTOAUl8AHcL5gUQ
	jHaA==
X-Gm-Message-State: AKaTC03+Z1B/xLWeWH0BUdu5W/L6KE2Z50c2Qa20hmmB6r3bA1XpdBWxEqF6kvTcrr0e/gyw
X-Received: by 10.28.189.69 with SMTP id n66mr7276757wmf.35.1481302394709;
	Fri, 09 Dec 2016 08:53:14 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:14 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:53 +0000
Message-Id: <1481302375-7985-13-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 12/14] toaster: Switch front end to use Layer get REST API
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:14 -0000

Switch the front end to use the proper REST API for retrieving layer
information.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js     |  6 +++++-
 lib/toaster/toastergui/templates/layer_btn.html    | 15 ++++++++++++---
 lib/toaster/toastergui/templates/layerdetails.html |  1 +
 lib/toaster/toastergui/templates/machine_btn.html  |  7 ++++++-
 lib/toaster/toastergui/templates/recipe_btn.html   |  8 +++++++-
 5 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 86662b7..e7d6a95 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -274,9 +274,13 @@ var libtoaster = (function () {
   }
 
   function _addRmLayer(layerObj, add, doneCb){
+    if (layerObj.xhrLayerUrl === undefined){
+      throw("xhrLayerUrl is undefined")
+    }
+
     if (add === true) {
       /* If adding get the deps for this layer */
-      libtoaster.getLayerDepsForProject(layerObj.layerdetailurl,
+      libtoaster.getLayerDepsForProject(layerObj.xhrLayerUrl,
         function (layers) {
 
         /* got result for dependencies */
diff --git a/lib/toaster/toastergui/templates/layer_btn.html b/lib/toaster/toastergui/templates/layer_btn.html
index b2f73eb..1580991 100644
--- a/lib/toaster/toastergui/templates/layer_btn.html
+++ b/lib/toaster/toastergui/templates/layer_btn.html
@@ -1,4 +1,9 @@
-<a class="btn btn-danger btn-block layer-exists-{{data.pk}} layerbtn"  data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="remove"
+<a class="btn btn-danger btn-block layer-exists-{{data.pk}} layerbtn"  data-layer='{
+   "id": {{data.pk}},
+   "name":  "{{data.layer.name}}",
+   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.pk %}",
+   "layerdetailurl": "{% url 'layerdetails' extra.pid data.pk %}"
+   }' data-directive="remove"
     {% if data.pk not in extra.current_layers %}
     style="display:none;"
     {% endif %}
@@ -6,7 +11,12 @@
   <span class="glyphicon glyphicon-trash"></span>
   Remove layer
 </a>
-<a class="btn btn-default btn-block layer-add-{{data.pk}} layerbtn" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="add"
+<a class="btn btn-default btn-block layer-add-{{data.pk}} layerbtn"
+   data-layer='{ "id": {{data.pk}},
+   "name":  "{{data.layer.name}}",
+   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.pk %}",
+   "layerdetailurl": "{%url "layerdetails" extra.pid data.pk %}"
+   }' data-directive="add"
     {% if data.pk in extra.current_layers %}
     style="display:none;"
     {% endif %}
@@ -14,4 +24,3 @@
   <span class="glyphicon glyphicon-plus"></span>
   Add layer
 </a>
-
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index f1569bd..e0069db 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -71,6 +71,7 @@
           inCurrentPrj : false,
           {% endif %}
           layerdetailurl : "{% url 'layerdetails' project.id layerversion.id  %}",
+          xhrLayerUrl: "{% url 'xhr_layer' project.id layerversion.id  %}",
           layer_source: {{layerversion.layer_source|json}},
         },
         layerSourceTypes: {{layer_source|json}},
diff --git a/lib/toaster/toastergui/templates/machine_btn.html b/lib/toaster/toastergui/templates/machine_btn.html
index 5d93d7a..12b5c96 100644
--- a/lib/toaster/toastergui/templates/machine_btn.html
+++ b/lib/toaster/toastergui/templates/machine_btn.html
@@ -4,7 +4,12 @@
     {% endif %}
 >
   Select machine</a>
-<a class="btn btn-default btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{ "id": {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add"
+<a class="btn btn-default btn-block layerbtn
+layer-add-{{data.layer_version.id}}" data-layer='{ "id":
+   {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}",
+   "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %},
+   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.pk %}",
+   }' data-directive="add"
     {% if data.layer_version.pk in extra.current_layers %}
     style="display:none;"
     {% endif %}
diff --git a/lib/toaster/toastergui/templates/recipe_btn.html b/lib/toaster/toastergui/templates/recipe_btn.html
index e372964..0ee0ba5 100644
--- a/lib/toaster/toastergui/templates/recipe_btn.html
+++ b/lib/toaster/toastergui/templates/recipe_btn.html
@@ -5,7 +5,13 @@
  >
   Build recipe
 </a>
-<a class="btn btn-default btn-block layerbtn layer-add-{{data.layer_version.pk}}" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add"
+<a class="btn btn-default btn-block layerbtn layer-add-{{data.layer_version.pk}}" 
+  data-layer='{
+  "id": {{data.layer_version.pk}},
+  "name":  "{{data.layer_version.layer.name}}",
+  "layerdetailurl": "{%url "layerdetails" extra.pid data.layer_version.pk%}",
+   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.layer_version.pk %}"
+   }' data-directive="add"
     {% if data.layer_version.pk in extra.current_layers %}
      style="display:none;"
     {% endif %}
-- 
2.7.4


