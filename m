Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id C0007732CE
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:10 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id fa1so20131321pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=datrGm+lsARC5SyckkbVUBlgf1RBXDI3hLCosn79ukk=;
	b=WmU4/JpB3AVgSvlc/Zh9rd3mRmrqilMpVjFjVanGNcxGv95F7AMZ4lcg4G6TVqAg+x
	3mZqpGQIYBQ61Bv8gttpFOJGRTuBHRARKNVWASBMRwF6r2ZuGo9dOvucJHARO1Gj7+we
	rqzN6oaDoxkSktXeuZsA/1nxsIUYR53doByj/9V1FfNiPf/NEC0OZnJE36xkCDyjdSLH
	y8teUStX1DyE8wUdFsXYLqZwNdgE0raqiWEMP3Re/i6qUDx4pkbjRHgi/kKZtOirlLh6
	BMB8OGujzn/Ib49vj2B8c454J9pNugwN2COasvgomVgtYEGVDF6IhsMyfBXkFISHkrk6
	KmAA==
X-Gm-Message-State: ALoCoQmsf4rYxR5VJGCRol7WDlfFiMkSFz1YDyT8ank0t7hVC+tS0pEpM+kjW3dmUlVK2E7d+ttO
X-Received: by 10.69.31.203 with SMTP id ko11mr30931036pbd.70.1423504931224;
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ev2sm16948826pbb.69.2015.02.09.10.02.09
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 606935661AE; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:47 +0000
Message-Id: <2a571a4523dbbe9b6afcf2e6b41edf2cb059729d.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 17/27] toaster: All machines Update layer notifications
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:10 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update layer notifications to the new wording for layer add remove
notifications.
Fix bug where the the alert area is being removed from the dom on
dismiss instead of re-hidden

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/machines.js   | 8 ++++++--
 lib/toaster/toastergui/templates/machines.html | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/machines.js b/lib/toaster/toastergui/static/js/machines.js
index a3ea43b..1b7ea36 100644
--- a/lib/toaster/toastergui/static/js/machines.js
+++ b/lib/toaster/toastergui/static/js/machines.js
@@ -24,7 +24,7 @@ function machinesPageInit (ctx) {
 
     /* If we have added layer dependencies */
     if (depsList) {
-      alertMsg.append("You have added <strong>"+(depsList.length+1)+"</strong> layers: <span id=\"layer-affected-name\"></span> and its dependencies ");
+      alertMsg.append("You have added <strong>"+(depsList.length+1)+"</strong> layers to <a id=\"project-affected-name\"></a>: <span id=\"layer-affected-name\"></span> and its dependencies ");
 
         /* Build the layer deps list */
         depsList.map(function(layer, i){
@@ -40,14 +40,18 @@ function machinesPageInit (ctx) {
           alertMsg.append(link);
         });
     } else {
-      alertMsg.append("You have added <strong>1</strong> layer: <span id=\"layer-affected-name\"></span>");
+      alertMsg.append("You have added <strong>1</strong> layer to <a id=\"project-affected-name\"></a>: <strong id=\"layer-affected-name\"></strong>");
     }
 
     var layerName = addLayerBtn.data('layer-name');
     alertMsg.children("#layer-affected-name").text(layerName);
+    alertMsg.children("#project-affected-name").text(ctx.projectName).attr('href', ctx.projectPageUrl);
+
     $("#alert-area").show();
   }
 
+  $("#dismiss-alert").click(function(){ $(this).parent().hide() });
+
   /* Add or remove this layer from the project */
   $(".add-layer").click(function() {
       var btn = $(this);
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index e3329bf..487d6b7 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -13,6 +13,7 @@
   $(document).ready(function (){
     var ctx = {
       projectPageUrl : "{% url 'project' project.id %}",
+      projectName : "{{project.name}}",
       xhrEditProjectUrl : "{% url 'xhr_projectedit' project.id %}",
       projectId : {{project.id}},
       xhrDataTypeaheadUrl : "{% url 'xhr_datatypeahead' %}",
@@ -35,9 +36,8 @@
 </div>
 
 <div class="alert alert-info lead" id="alert-area" style="display:none">
-  <button type="button" class="close" id="dismiss-alert" data-dismiss="alert">&times;</button>
+  <button type="button" class="close" id="dismiss-alert">&times;</button>
   <span id="alert-msg"></span>
-  <p style="margin-top:10px;"><a href="{% url 'project' project.id %}">Go to project configuration</a></p>
 </div>
 
 {% include "basetable_top.html" %}
-- 
1.9.1


