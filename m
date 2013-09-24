Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 57DF26CAC8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:18 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948498"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:07 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 941A35610D5; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:42 +0100
Message-Id: <27839bbdc52e5528a01890d5e20429867c6dc2d6.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 13/94] bitbake: webhob: set sane default settings
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:18 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Changes the default Django settings as to point
to sane default of using sqlite by default. This
is the preffered running mode for webhob.

Changes the list of installed applications.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/whbmain/settings.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
index 71bba4f..cd9dbe8 100644
--- a/bitbake/lib/webhob/whbmain/settings.py
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -11,8 +11,8 @@ MANAGERS = ADMINS
 
 DATABASES = {
     'default': {
-        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
-        'NAME': '',                      # Or path to database file if using sqlite3.
+        'ENGINE': 'django.db.backends.sqlite3', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
+        'NAME': 'webhob.sqlite',                      # Or path to database file if using sqlite3.
         'USER': '',
         'PASSWORD': '',
         'HOST': '127.0.0.1',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
@@ -124,6 +124,8 @@ INSTALLED_APPS = (
     # Uncomment the next line to enable admin documentation:
     # 'django.contrib.admindocs',
     'orm',
+    'whbmain',
+    'bldviewer',
 )
 
 # A sample logging configuration. The only tangible logging
-- 
1.8.1.2


