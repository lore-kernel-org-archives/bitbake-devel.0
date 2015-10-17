Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 187AD77190
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:44 +0000 (UTC)
Received: by pacik9 with SMTP id ik9so16124983pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=XLG8PXewpY1WjLvUSajoJMD+2b00JXJxTIrXZ4jTMdQ=;
	b=QZsWvm1Udm/xF87EsJHOV7ZulwYYlLZGkUDb0x/FFni9Zsb+c8D/nRPbh7CMXZSIwt
	D+H7FDsmN+G7Rm19mxgcnZ0QmlD0zGnFeUKmUsPxlftWF+T2mHICnoYFaGUS6IMoOBvj
	8zqVrK1kJc2fsVqkvt2NnUQH9n00xAtt1sOvvyFqKgDA2Gs7OAL9Iw0GicxTJV0T7buV
	4mXHwmuQkqdalmM34bONd6Mw9s56HW44GyaG9bx+bR8TWfT8xPJYETN5zmFo2DvW/rX8
	8EB1UPeSCCrjWMERF+YEFSReGTmWURMsSVZDLPTliCDiXJO3TiBGGKhs9B/uXQBcdLmS
	R8MA==
X-Received: by 10.66.163.228 with SMTP id yl4mr24186440pab.112.1445103825372; 
	Sat, 17 Oct 2015 10:43:45 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	bn1sm27888794pad.17.2015.10.17.10.43.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:44 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:50 -0700
Message-Id: <d8e12a547388ddf7e86a1cd0b52defa8e1e9445a.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
References: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
In-Reply-To: <cover.1445103849.git.avery.brian@gmail.com>
References: <cover.1445103849.git.avery.brian@gmail.com>
Subject: [PATCH 3/6] toaster: Hide top bar buttons in analysis mode
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:45 -0000

From: Elliot Smith <elliot.smith@intel.com>

The "new build" and "new project" buttons are irrelevant in
analysis mode, as you can't start a build or a project.

Hide these buttons if not in BUILD_MODE.

[YOCTO #8514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/base.html | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index c1d0693..073c342 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -120,11 +120,19 @@
             </li>
           </ul>
           <span class="pull-right divider-vertical"></span>
-          <div class="btn-group pull-right">
-            <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
-          </div>
-          <!-- New build popover; only shown if there is at least one user-created project -->
-          {% if non_cli_projects.count > 0 %}
+
+          <!-- new project button; only show in build mode -->
+          {% if BUILD_MODE %}
+            <div class="btn-group pull-right">
+              <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
+            </div>
+          {% endif %}
+
+          <!--
+          New build popover; only shown if there is at least one user-created project
+          and we're in build mode
+          -->
+          {% if BUILD_MODE and non_cli_projects.count > 0 %}
             <div class="btn-group pull-right" id="new-build-button" style="display:none">
               <button class="btn dropdown-toggle" data-toggle="dropdown">
                 New build
-- 
1.9.1


