Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E724E6CB72
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902517"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 74CB6562D68; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:53:03 +0100
Message-Id: <9b35cc5e33eff429612f8274dfed5aec02129313.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 94/94] bitbake: webhob: do not set timezones
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Preventing webhob setting a default timezone.
As such, it will always use the current time
for the local computer.

[YOCTO #5186]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/whbmain/settings.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
index d470328..c5222e5 100644
--- a/bitbake/lib/webhob/whbmain/settings.py
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -20,16 +20,6 @@ DATABASES = {
     }
 }
 
-# If we're using sqlite, we need to tweak the performance a bit
-from django.db.backends.signals import connection_created
-def activate_synchronous_off(sender, connection, **kwargs):
-    if connection.vendor == 'sqlite':
-        cursor = connection.cursor()
-        cursor.execute('PRAGMA synchronous = 0;')
-connection_created.connect(activate_synchronous_off)
-#
-
-
 # Hosts/domain names that are valid for this site; required if DEBUG is False
 # See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
 ALLOWED_HOSTS = []
@@ -38,7 +28,9 @@ ALLOWED_HOSTS = []
 # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
 # although not all choices may be available on all operating systems.
 # In a Windows environment this must be set to your system time zone.
-TIME_ZONE = 'America/Chicago'
+
+# Always use local computer's time zone
+TIME_ZONE = ''
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
@@ -54,6 +46,7 @@ USE_I18N = True
 # calendars according to the current locale.
 USE_L10N = True
 
+
 # If you set this to False, Django will not use timezone-aware datetimes.
 USE_TZ = True
 
@@ -167,3 +160,14 @@ LOGGING = {
         },
     }
 }
+
+# If we're using sqlite, we need to tweak the performance a bit
+from django.db.backends.signals import connection_created
+def activate_synchronous_off(sender, connection, **kwargs):
+    if connection.vendor == 'sqlite':
+        cursor = connection.cursor()
+        cursor.execute('PRAGMA synchronous = 0;')
+connection_created.connect(activate_synchronous_off)
+#
+
+
-- 
1.8.1.2


