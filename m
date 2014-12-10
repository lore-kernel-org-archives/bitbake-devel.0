Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id E098072619
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:22 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id r20so11520253wiv.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+3IIUNHmUuGo+PQ2Hg9aiL5TwTyypccQzk6t9VmRQKk=;
	b=bnERUMibVyAWZ3vgrT5g/v7SvMq76rwg4MCmdznkA4hYDPFT4DF1uoz/qhgDSCyp/S
	VNJ1UZcY6p1q139svx4itxPKR8PdOcSF3cA/KmD8NSDRh07x/2OKXamqlJhaoMwDUVSF
	cS9NHq5CwGXAXBuyMeDseX0b87PfjCN6ggGpsoNAM2+5UuNl3cvRcVluqVuOJUQTN9no
	nz7AAdKRXEZv5Zt0p97ilvQGZ0RgN9DA+w+g72yCTcy6zfIZgOYuH6R9cYAGG4Bg8wk4
	Q5+Mv9lOPTDiaAM6JA6P3Zx1WWRohvY/An8GRoR8da/wza4sh1rutU4+vMwmaVtJqCdx
	mikw==
X-Gm-Message-State: ALoCoQlZ9L7SiRmfL0U/Pl6XmEQxhMOlRY0O7J+HGcAoDruZWLEJApi+1zf8LF369cxPMiQEdkyg
X-Received: by 10.194.119.193 with SMTP id kw1mr7524137wjb.37.1418224342857;
	Wed, 10 Dec 2014 07:12:22 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id td6sm6688156wic.15.2014.12.10.07.12.19
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:20 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 71D2E560865; Wed, 10 Dec 2014 15:12:17 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:14 +0000
Message-Id: <fe1a344308d7abfcda9d571ea42491df468e833c.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
References: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
Subject: [PATCH 09/11] toaster: libtoaster Add editProject and getLayerDepsForProject
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
X-List-Received-Date: Wed, 10 Dec 2014 15:12:24 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add two utility functions for editing project settings and returning the
layer "dependencies" for a specified layer.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index b691a3b..15815b3 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -114,11 +114,60 @@ var libtoaster = (function (){
     });
   };
 
+  /* Properties for data can be:
+   * layerDel (csv)
+   * layerAdd (csv)
+   * projectName
+   * projectVersion
+   * machineName
+   */
+  function _editProject(url, projectId, data, onSuccess, onFail){
+    $.ajax({
+        type: "POST",
+        url: url,
+        data: data,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (data) {
+          if (data.error != "ok") {
+            console.log(data.error);
+            if (onFail != undefined)
+              onFail(data);
+          } else {
+            if (onSuccess != undefined)
+              onSuccess(data);
+          }
+        },
+        error: function (data) {
+          console.log("Call failed");
+          console.log(data);
+        }
+    });
+  };
+
+  function _getLayerDepsForProject(xhrDataTypeaheadUrl, projectId, layerId, onSuccess, onFail){
+    /* Check for dependencies not in the current project */
+    $.getJSON(xhrDataTypeaheadUrl,
+      { type: 'layerdeps', 'value': layerId , project_id: projectId },
+      function(data) {
+        if (data.error != "ok") {
+          console.log(data.error);
+          if (onFail != undefined)
+            onFail(data);
+        } else {
+          onSuccess(data);
+        }
+      }, function() {
+        console.log("E: Failed to make request");
+    });
+  };
+
   return {
     reload_params : reload_params,
     startABuild : _startABuild,
     makeTypeahead : _makeTypeahead,
     getProjectInfo: _getProjectInfo,
+    getLayerDepsForProject : _getLayerDepsForProject,
+    editProject : _editProject,
   }
 })();
 
-- 
1.9.1


