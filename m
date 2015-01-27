Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id B62BE72666
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:34 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id w62so15221062wes.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Gx6cNSLGSh+1DXvmGCjoH0f422jhkFIIbbLiPp3clgY=;
	b=ltB+zL88h/kpRz4eMSx5hO4wsNUJGRJTK7NY9zv8i2+9iOfoq0YerQNnh4NT9Wd0Sg
	P3CvGvdoZLp22p4uaOy7JsmQS4Eef8rO658PVCFd0NR5tAwpgNr6H+AXwNlqSL2eDl7t
	qXXUQ0ybNVmmpSMOUsXtH2YrWEGsl5NPrrPhgitVpWxm3UUS5uZFyLrEMLSylfeMDEAt
	5XgGB10U3iTVxErPWhxwNOjBOgocBLAYMNb1GA66kleVnsiLlJcr93aGqMC8do7WfXQO
	NTJsEdxU165/cM6sQCdl+dWXiwWbc4bJWHfG4KKA3lQK5bWiuzgAoX5vS5BR7LyN0j5y
	J5Ow==
X-Gm-Message-State: ALoCoQlENykZM5Mb6yB5YmfvK9e0Ots6+chO2ecKJhEsUg+PF0gVcahMCc15g6ADq9hkvKQShDnr
X-Received: by 10.194.143.109 with SMTP id sd13mr1476912wjb.70.1422368855046; 
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hr1sm18359441wib.1.2015.01.27.06.27.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A98BE5622FB; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:26 +0000
Message-Id: <87deeb2016cbfdaff5531e1badb58761af6df848.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 05/14] toastergui: consistent add / remove layer notifications
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In my struggle to ensure consistency in the format and content
of the notifications we show when you add and remove layers to
a project, I've:

* added the project name to the notifications
in the layer details page

* removed the 'Go to project configuration' link
from the notifications in the layer details page

This changes align the notifications we show in the layer
details page with the ones we show in the 'all' pages.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   | 10 ++++++----
 lib/toaster/toastergui/templates/layerdetails.html |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 41cbf4b..2addecd 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -211,7 +211,7 @@ function layerDetailsPageInit (ctx) {
       addRmLayerBtn.prepend("<span class=\"icon-trash\"></span>");
 
       if (depsList) {
-        alertMsg.append("You have added <strong>"+(depsList.length+1)+"</strong> layers: <span id=\"layer-affected-name\"></span> and its dependencies ");
+        alertMsg.append("You have added <strong>"+(depsList.length+1)+"</strong> layers to <a id=\"project-affected-name\"></a>: <span id=\"layer-affected-name\"></span> and its dependencies ");
 
         /* Build the layer deps list */
         depsList.map(function(layer, i){
@@ -227,7 +227,7 @@ function layerDetailsPageInit (ctx) {
           alertMsg.append(link);
         });
       } else {
-        alertMsg.append("You have added <strong>1</strong> layer: <span id=\"layer-affected-name\"></span>");
+        alertMsg.append("You have added <strong>1</strong> layer to <a id=\"project-affected-name\"></a>: <span id=\"layer-affected-name\"></span>");
       }
     } else {
       /* disable and switch all the button states */
@@ -252,10 +252,12 @@ function layerDetailsPageInit (ctx) {
           break;
       }
 
-      alertMsg.append("You have deleted <strong>1</strong> layer: <span id=\"layer-affected-name\"></span>");
+      alertMsg.append("You have deleted <strong>1</strong> layer from <a id=\"project-affected-name\"></a>: <span id=\"layer-affected-name\"></span>");
     }
 
-    alertMsg.children("#layer-affected-name").text(ctx.layerVersion.name);
+    alertMsg.children("#layer-affected-name").html("<strong>" + ctx.layerVersion.name + "</strong>");
+    alertMsg.children("#project-affected-name").text(ctx.projectName);
+    alertMsg.children("#project-affected-name").attr("href", ctx.projectPageUrl);
     $("#alert-area").show();
   }
 
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 207197bce..a89ffb0 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -23,6 +23,7 @@
       xhrDataTypeaheadUrl : "{% url 'xhr_datatypeahead' %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
       projectId : {{project.id}},
+      projectName : "{{project.name}}",
       numTargets : {{total_targets}},
       numMachines: {{machines|length}},
       layerVersion : {
@@ -73,7 +74,6 @@
         <div class="alert alert-info lead" id="alert-area" style="display:none">
           <button type="button" class="close" id="dismiss-alert" data-dismiss="alert">&times;</button>
           <span id="alert-msg"></span>
-          <p style="margin-top:10px;"><a href="{% url 'project' project.id %}">Go to project configuration</a></p>
         </div>
         <ul class="nav nav-pills">
           <li class="active">
-- 
1.9.1


