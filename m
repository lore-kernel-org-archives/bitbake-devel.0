Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id BA444731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 23:02:01 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id n129so156451136wmn.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Bp2bKNXLasWS8fWaE5dzKMoe9noODNtK3BmAVwZ2VOI=;
	b=AY54uUQML/QrsmmlNrf8Ne/i1u7ZHt/4jrAlemkmjCIUzYehccnwDQLS/x4P7kh5G2
	EKEFr+EKEZFB+/iL2tA9+b4QJRiD8TQaEVafOXkcbf1Qt1Cz/qimk2P5noVdSRqNgx6L
	d6/v5JqHj4/fx+NXWIVZYgXgDZ5NUI7kvRI0VnYc9Sx0KSw+SXFIm7HKx5doqGITKnKT
	JVRG9buFaC4ReOAkUklVUSlPBkawlTTUWtIFXVdGFO9rM/2/B0NzSDdfLgXVq9QFVEGL
	4iMoiEKatNhMFFRRQXBOJPA/rZPDkPKNETYEnBWdnqRIuU5wuQ0f6nbOLAUBRlQ7DEnl
	KXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Bp2bKNXLasWS8fWaE5dzKMoe9noODNtK3BmAVwZ2VOI=;
	b=k3OgDaLNN6kVyMtIwvJe/Zi7cTnIPv/FuBkm07KuwhBi7l1qpQjXLxJ5zmDzP1Gmsp
	vKGUlTYUDxGkdPck6hPxfHhR98IfeIxWpsWBsov3uTaGCTghofFK22zsGfrK5QUfPchF
	uEKTavLPwMZ5r/niz/mr5fUtnhPmVXGA/a42270jz+b75Q3Zk+I0EClUp/PWoq0BMQib
	wFxi+jP76BN/gqWL4MUsy51Jfz1jcSjlJ43O1eOj3tHXf+HC8JqEpOHKB+wVRJIw3a7A
	3I6W4eyWf7S5cqoJLuR4W01brEaXzUAzW9OlykWktGHbZuz0hOULwNtqV8EJFySet7tW
	lfRg==
X-Gm-Message-State: AOPr4FUjyQD/Mqx/USz6UZSoY9/73XGBfdqWB+GXXFowE+DZWymr8V5rbEdxPgNbC/XSvTom
X-Received: by 10.194.94.229 with SMTP id df5mr35870383wjb.176.1462834921835; 
	Mon, 09 May 2016 16:02:01 -0700 (PDT)
Received: from orion.home (host109-151-244-175.range109-151.btcentralplus.com.
	[109.151.244.175]) by smtp.gmail.com with ESMTPSA id
	b22sm27111436wmb.9.2016.05.09.16.02.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 09 May 2016 16:02:01 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 00:01:50 +0100
Message-Id: <1462834912-23449-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
References: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/5] toaster: ui handles duplicate project name in project page
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
X-List-Received-Date: Mon, 09 May 2016 23:02:02 -0000

From: Sujith H <sujith.h@gmail.com>

When already existing project name is typed by user,
the ui pops up message regarding the existance of the
project name. When an existing project is typed the save
button will be disabled. Else user can proceed ahead by
modifying the project name.

[YOCTO #7005]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/projecttopbar.js   | 7 +++++++
 lib/toaster/toastergui/templates/projecttopbar.html | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projecttopbar.js b/lib/toaster/toastergui/static/js/projecttopbar.js
index b09f974..f0cd18b 100644
--- a/lib/toaster/toastergui/static/js/projecttopbar.js
+++ b/lib/toaster/toastergui/static/js/projecttopbar.js
@@ -25,6 +25,7 @@ function projectTopBarInit(ctx) {
     e.preventDefault();
     projectNameForm.hide();
     projectNameContainer.fadeIn();
+    $("#project-name-change-input").val(projectName.text());
   });
 
   $("#project-name-change-btn").click(function(){
@@ -87,4 +88,10 @@ function projectTopBarInit(ctx) {
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
     }, null);
   });
+
+  /* Call makeProjectNameValidation function */
+  libtoaster.makeProjectNameValidation($("#project-name-change-input"),
+      $("#hint-error-project-name"), $("#validate-project-name"),
+      $("#project-name-change-btn"));
+
 }
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 007de06..e878cab 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -33,11 +33,12 @@
     {% endif %}
   </h1>
   <form id="project-name-change-form" style="margin-bottom: 0px; display: none;">
-    <div class="input-append">
+    <div class="input-append" id="validate-project-name">
       <input class="huge input-xxlarge" type="text" id="project-name-change-input" autocomplete="off" value="{{project.name}}">
         <button id="project-name-change-btn" class="btn btn-large" type="button">Save</button>
         <a href="#" id="project-name-change-cancel" class="btn btn-large btn-link">Cancel</a>
     </div>
+    <p class="help-block error" style="display: none;margin-top: 10px;" id="hint-error-project-name">A project with this name exists. Project names must be unique.</p>
   </form>
 </div>
 
-- 
2.7.4


