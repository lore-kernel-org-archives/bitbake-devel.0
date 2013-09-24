Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 9FC8D6CB1A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:05 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442549"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:06 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 9DF2C561167; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:45 +0100
Message-Id: <18017d844c9e8adc1cc7feee275b1563c9c829cd.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 16/94] bitbake: webhob: disable synchronous sqlite connection
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

SQLite has very bad INSERT performance in synchronous mode.
We disable the synchronous mode to improve performance only
on sqlite connections.

This requires also to change the way the build info
wrapper loads the Django settings.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py   |  3 +--
 bitbake/lib/webhob/whbmain/settings.py | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 6f3b5c2..e12750e 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -366,9 +366,8 @@ class BuildInfoHelper(object):
         self.orm_wrapper = ORMWrapper(server)
 
     def configure_django(self):
+        os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
         import webhob.whbmain.settings as whb_django_settings
-        from django.core.management import setup_environ
-        setup_environ(whb_django_settings)
         # Add webhob to sys path for importing modules
         sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
 
diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
index cd9dbe8..aa1d4fc 100644
--- a/bitbake/lib/webhob/whbmain/settings.py
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -20,6 +20,16 @@ DATABASES = {
     }
 }
 
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
 # Hosts/domain names that are valid for this site; required if DEBUG is False
 # See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
 ALLOWED_HOSTS = []
-- 
1.8.1.2


