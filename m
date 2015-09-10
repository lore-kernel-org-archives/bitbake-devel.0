Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 974EC769A7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:04:25 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so49007860pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=X2XBVmWeQpcNeIgnLLBHuwZjfuLC0hDN4qCumu+qG88=;
	b=Ji6rO1IbV4c3/YHvkTVux5fDsEwsx4VVuyFR1A3KTvljlWTfeaceI6nfHV8WiSlEvS
	SINjZ3YaolAPZ0zwizDN31sjWv09j5MJAkvCNP4IwWgLh1zZQZXGduROoyhZw4b2AFgZ
	9y8h6LQnuoIQ0YploY9ukzbbOomCcJCvx3dsMZbZfhpPQMMtdMZgYgqQ0uG83uDxGa4Z
	6MowNMCuBXpHOK9wxjUuyVbU/yuvACQHTdQWvgQ1ZRNU6xet2MFGQfr7WPuLosgdShqZ
	N6hrPcxibpT33ySFjIBDTsonUirc4OIV5lfEgG066c9tMcpnSQNFEKlwm3k6UiFrH05x
	VuFg==
X-Received: by 10.66.193.230 with SMTP id hr6mr75896975pac.39.1441904666443;
	Thu, 10 Sep 2015 10:04:26 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	by1sm13099494pab.6.2015.09.10.10.04.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Sep 2015 10:04:25 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Sep 2015 10:05:17 -0700
Message-Id: <6e85fe5de3670b697ed21b4ea5bd3fb028523d2e.1441904599.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441904599.git.avery.brian@gmail.com>
References: <cover.1441904599.git.avery.brian@gmail.com>
Subject: [PATCH 3/5] toaster: Show correct builds count on project pages
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
X-List-Received-Date: Thu, 10 Sep 2015 17:04:26 -0000

From: Elliot Smith <elliot.smith@intel.com>

The counter for completed builds on the project pages
includes builds in progress.

Instead use the completedbuilds queryset to count the
number of completed builds for display on project pages.

Modify how the completedbuilds queryset is constructed so
it only excludes builds with status "in progress".

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/static/js/base.js | 4 ++--
 lib/toaster/toastergui/views.py          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index e0df463..895e61b 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -57,8 +57,8 @@ function basePageInit(ctx) {
 
   if ($(".total-builds").length !== 0){
     libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
-      if (prjInfo.builds)
-        $(".total-builds").text(prjInfo.builds.length);
+      if (prjInfo.completedbuilds)
+        $(".total-builds").text(prjInfo.completedbuilds.length);
     });
   }
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6ff510d..631d619 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2255,7 +2255,7 @@ if True:
         context = {
             "project" : prj,
             "lvs_nos" : Layer_Version.objects.all().count(),
-            "completedbuilds": Build.objects.filter(project_id = pid).filter(outcome__lte = Build.IN_PROGRESS),
+            "completedbuilds": Build.objects.exclude(outcome = Build.IN_PROGRESS).filter(project_id = pid),
             "prj" : {"name": prj.name, },
             "buildrequests" : prj.build_set.filter(outcome=Build.IN_PROGRESS),
             "builds" : _project_recent_build_list(prj),
-- 
1.9.1


