Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 4059E7239A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:08 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id h11so16402282wiw.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ELDpHRoaVeb68TT1PY5SE/zkg1eaNOsU6VqHT9S6Qnc=;
	b=hRpXhAFC1wU/fIHIQX7EGng7g2f3EuBR9PeUdyHBUx3n7/zx/R2Zx2bLZvH/DONCbk
	sjUjaQOZDrnMNPeJSlNmWyRHiUBaBOOvkEW5FshDgN6JPhgUrIfjF6L73o9cgYrPMsfZ
	6jvntrNwpeOvF8LJgDX2uiRTZptnyfGxuO74XqA6CI4YEFuv+YuaWFNAj+3cAICVYYw8
	TEg2PF6gLlX+miBF/Ss8SqqH9wkC7Kbau6cNuNudWgTkP/F/fOMabRaVf1abqk0flsns
	k5PmxyBFz1UzbuETbLpAgv6XbvWUwGZizOvsHF9Hnc3E8fpir/7/MQwJtToZZA3elJl/
	8vhQ==
X-Gm-Message-State: ALoCoQnn9sosKS3M1wxXIIMhHLx7qBQz/udQyWKcFNYcKm32zLPPVN2sP6psOO4VqfQSlxy3j/A5
X-Received: by 10.194.235.193 with SMTP id uo1mr59713982wjc.105.1417108089263; 
	Thu, 27 Nov 2014 09:08:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	cz3sm11511830wjb.23.2014.11.27.09.08.07 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F1663563BB6; Thu, 27 Nov 2014 17:08:06 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:53 +0000
Message-Id: <6daada59ee846c4e957bba3574dc262a0c79854d.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Subject: [PATCH 02/14] toaster: base Only show New Build button when there are > 0 projects
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

Only show new build button if we have defined at least one project as we
can't select a project to build against if there are no projects created
yet.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/base.js   | 13 +++++++++----
 lib/toaster/toastergui/templates/base.html |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 864130d..fac59e6 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -3,10 +3,12 @@
 function basePageInit (ctx) {
 
   var newBuildButton = $("#new-build-button");
-  /* Hide the button if we're on the project,newproject or importlyaer page */
-  if (ctx.currentUrl.search('newproject|project/\\d/$|importlayer/$') > 0){
-    newBuildButton.hide();
-    return;
+  /* Hide the button if we're on the project,newproject or importlyaer page
+   * or if there are no projects yet defined
+   */
+  if (ctx.numProjects == 0 || ctx.currentUrl.search('newproject|project/\\d/$|importlayer/$') > 0){
+      newBuildButton.hide();
+      return;
   }
 
 
@@ -17,6 +19,9 @@ function basePageInit (ctx) {
 
 
   function _checkProjectBuildable(){
+    if (ctx.projectId == undefined)
+      return;
+
     libtoaster.getProjectInfo(ctx.projectInfoUrl, ctx.projectId,
       function(data){
         if (data.machine.name == undefined || data.layers.length == 0) {
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 734d2ad..f457b91 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -31,6 +31,7 @@
     ctx.projectBuildUrl = "{% url 'xhr_build' %}";
     ctx.projectPageUrl = "{% url 'project' %}";
     ctx.projectInfoUrl = "{% url 'xhr_projectinfo' %}";
+    ctx.numProjects = {{projects|length}};
     {% if project %}
       ctx.projectId = {{project.id}};
     {% endif %}
-- 
1.9.1


