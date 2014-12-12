Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id BE693724F6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:25 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id b13so8950098wgh.18
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+3IIUNHmUuGo+PQ2Hg9aiL5TwTyypccQzk6t9VmRQKk=;
	b=fDOdjeybZ1rCkqH+wXvbabwsB6BTTZuCeU/JSdJLsDEPlq+Cz/AWeqbI/yKxplJxue
	iX+zY6NzWGSUFaXZdlEsxJ8pqv6o6YMrSI6o9wr/1GxW4tmdyqunjHl4iGUCnOb4RU4B
	S/JBPf9V/e6jeneA/KREiI9r0MuEIY+0RTsbQITVhyvZ/U7zEGStRN4JSZ5ft+jPGjjs
	MPOAxI9X8xUkVSeJiHx/G08WpbkiHQA2eOwmzo862Fux+LgY/Qb4FNBYSWUJfWvxLezg
	zDbCpmBCmptS7/xxiWgq167aP8zkxeuw2EGsb91iJKb1v8ime59QoXwne6UgCmSvchh0
	mrKg==
X-Gm-Message-State: ALoCoQnlKZ32BLSnN95ZcqkgiqWjcrVVhuwP5wwj1+bgwIAqCqUBzRdNQvQ0RYEEs3LXi15WAg0T
X-Received: by 10.181.8.66 with SMTP id di2mr6667315wid.49.1418384724158;
	Fri, 12 Dec 2014 03:45:24 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fo12sm1624118wic.19.2014.12.12.03.45.21
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 41573566221; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:08 +0000
Message-Id: <5f98f245bdd381a141a018a7f9953a5510fbb4df.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 09/18] toaster: libtoaster Add editProject and getLayerDepsForProject
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:26 -0000

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


