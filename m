Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 5F9C07712B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:43 +0000 (UTC)
Received: by padfb7 with SMTP id fb7so6712769pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AabC0cEgiHiK2aGJa0XrFFFyOWXqsor2gkG2chTItjA=;
	b=a1IVf2F15tnKojGZRAmkcqGozJJ32gNRRSrVxx1xkMCuqlHLaNKMM/3lUIraLKofaG
	bs7MQ98IMbmHCeKVmhw7u1W7jhDwRdYK0lkKXoUuYVhvcesJ4MlKWyFqe9rzfownsdOD
	sbYTh878/ftOJLdWj1eEdyYezg9DhRkWwdfWmqI22+qvC9OK6+VNMo0/UFuD/lDHZwnX
	P6QPYntHwXQ5xdXfBQeIzKfcXs/B2H/BHhOTgNj5DqEnIIycSakCWwTlrMKOzmSRH+Ic
	w+O3twWCyttc6TT2HZLplyabb9Sg3+RC3CKICS3x1YTw+VR/yJJaiXkq8E4jQyLs4tH6
	tGmA==
X-Received: by 10.66.141.199 with SMTP id rq7mr24344246pab.140.1445103823498; 
	Sat, 17 Oct 2015 10:43:43 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	bn1sm27888794pad.17.2015.10.17.10.43.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:42 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:48 -0700
Message-Id: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1445103849.git.avery.brian@gmail.com>
References: <cover.1445103849.git.avery.brian@gmail.com>
Subject: [PATCH 1/6] toaster: Add BUILD_MODE flag to context
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:43 -0000

From: Elliot Smith <elliot.smith@intel.com>

We set a TOASTER_MANAGED env variable in the startup script,
which has a value of "1" if Toaster should run in build mode.

Add a BUILD_MODE variable to settings.py which is True if
TOASTER_MANAGED is set to "1", False otherwise.

Add this to the context for every template, so we can use this
information to conditionally alter the content of pages
according to the mode we're in.

[YOCTO #8514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py     | 4 ++++
 lib/toaster/toastermain/settings.py | 6 ++----
 lib/toaster/toastermain/urls.py     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e2f2874..10bbef5 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1880,6 +1880,10 @@ def managedcontextprocessor(request):
         "projects": projects,
         "non_cli_projects": projects.exclude(is_default=True),
         "DEBUG" : toastermain.settings.DEBUG,
+
+        # True if Toaster is in build mode, False otherwise
+        "BUILD_MODE": toastermain.settings.BUILD_MODE,
+
         "CUSTOM_IMAGE" : toastermain.settings.CUSTOM_IMAGE,
         "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
         "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 6439d68..b28ddb2 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -92,11 +92,9 @@ if 'DATABASE_URL' in os.environ:
     else:
         raise Exception("FIXME: Please implement missing database url schema for url: %s" % dburl)
 
-
+BUILD_MODE = False
 if 'TOASTER_MANAGED' in os.environ and os.environ['TOASTER_MANAGED'] == "1":
-    MANAGED = True
-else:
-    MANAGED = False
+    BUILD_MODE = True
 
 # Allows current database settings to be exported as a DATABASE_URL environment variable value
 
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 521588a..6c4a953 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -60,7 +60,7 @@ if toastermain.settings.DEBUG_PANEL_ENABLED:
     #logger.info("Enabled django_toolbar extension")
 
 
-if toastermain.settings.MANAGED:
+if toastermain.settings.BUILD_MODE:
     urlpatterns = [
         # Uncomment the next line to enable the admin:
         url(r'^admin/', include(admin.site.urls)),
-- 
1.9.1


