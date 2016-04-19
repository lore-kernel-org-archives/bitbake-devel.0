Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 4FA5C62133
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:28:57 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id u206so39016437wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fcyI6ic0Qwath65KMSkeLtEQShh6vRjjB6Bw+3k4xqg=;
	b=vTdazoVkXwckDYeriCpgyaJ4Bv++EcuwigAmwnQMm8M8RznVQAT0gzFDuiLIO3koTz
	76PBAwiWjjuMi2LHAzw0EhdPu56smTZ/kNT4Ci5r0gkixmlsFqIlF0NHn/zibCWKkW1M
	WkU8JK3LoSQ+NZ3Nw4snNgq1y4dBSoU8TIa8Hik/DNBkSMYVnTYitlRw5lCWOLP45Tu9
	jodSqU7pK78cw/7GkFCa1ch51ulAXyoUC0tnLVulCZ2b67PxyvhJiqLeUvH4Owa5WyvE
	e81PKd7WfrXa4iQNCPHzTA1hB3LcjYcv+MHpSB+H170qWghJudTtyOPK1ttfp2kIQJZQ
	afqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fcyI6ic0Qwath65KMSkeLtEQShh6vRjjB6Bw+3k4xqg=;
	b=b2TRASpxacIMrM8L8HUdS7678LXg/+73aCg3kyfo/DaATEmTHZuti8ypQq7uersvom
	YgRecqGMDTPatget5BDjrtClHZWfeWSqrN1m8fN47aQy1WPMhoXmiK3emtIFSC0JtNpG
	Il2z7lCmzzL2RQZfN70rSO9tCz70xjxFNWm38SbisKAnNCAJOmjPLK+iofEXyBwEjXq6
	5vAtEwao77IoCvtHbWRV3KXj7+Fs9Q/fIcer6Be4dIeqCayxpI8AJCdY5Gj2ch1bzVuj
	DjQ0exEBvPBtm0kU9DpWuJ40Zo7R9ObDBgbnSSD/GDjlC4q8DKfAGGGOTWFuLvFk8+7B
	AtRQ==
X-Gm-Message-State: AOPr4FU9EVrRC6q92J9hxs+0mu+gMYTKbnJ+2PbMWH6GNdAerRKT1f2V7sdmAwgtQM/ecB+c
X-Received: by 10.28.150.193 with SMTP id y184mr5746749wmd.41.1461083338381;
	Tue, 19 Apr 2016 09:28:58 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.28.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:28:57 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:40 +0100
Message-Id: <1461083327-11668-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 03/10] toaster: disable/enable "Add layer" button according to input's content
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
X-List-Received-Date: Tue, 19 Apr 2016 16:28:58 -0000

From: Elliot Smith <elliot.smith@intel.com>

In the import layer page, the "Add layer" button in the layer dependencies
section doesn't accurately reflect whether the layer name in the
corresponding input can be added. A partial or empty layer name can
leave the button active, such that when it is clicked, a
previously-selected layer can be accidentally added.

Fix by keeping track of the items currently available in the typeahead,
only activating the "Add layer" button when the input matches the name
of one of those items.

[YOCTO #8511]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 30 ++++++++++++++++++++++++-
 lib/toaster/toastergui/static/js/libtoaster.js  |  5 +++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index c68f366..5a59799 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -18,10 +18,38 @@ function importLayerPageInit (ctx) {
 
   libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
+  });
+
+  // choices available in the typeahead
+  var layerDepsChoices = {};
+
+  // when the typeahead choices change, store an array of the available layer
+  // choices locally, to use for enabling/disabling the "Add layer" button
+  layerDepInput.on("typeahead-choices-change", function (event, data) {
+    layerDepsChoices = {};
 
-    layerDepBtn.removeAttr("disabled");
+    if (data.choices) {
+      data.choices.forEach(function (item) {
+        layerDepsChoices[item.name] = item;
+      });
+    }
   });
 
+  // disable the "Add layer" button when the layer input typeahead is empty
+  // or not in the typeahead choices
+  layerDepInput.on("input change", function () {
+    // get the choices from the typeahead
+    var choice = layerDepsChoices[$(this).val()];
+
+    if (choice) {
+      layerDepBtn.removeAttr("disabled");
+      currentLayerDepSelection = choice;
+    }
+    else {
+      layerDepBtn.attr("disabled", "disabled");
+      currentLayerDepSelection = undefined;
+    }
+  });
 
   /* We automatically add "openembedded-core" layer for convenience as a
    * dependency as pretty much all layers depend on this one
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 8d1d20f..43930a2 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -21,6 +21,9 @@ var libtoaster = (function (){
     var xhrReq;
 
     jQElement.typeahead({
+        // each time the typeahead's choices change, a
+        // "typeahead-choices-change" event is fired with an object
+        // containing the available choices in a "choices" property
         source: function(query, process){
           xhrParams.search = query;
 
@@ -36,6 +39,8 @@ var libtoaster = (function (){
 
             xhrReq = null;
 
+            jQElement.trigger("typeahead-choices-change", {choices: data.results});
+
             return process(data.results);
           });
         },
-- 
2.5.0


