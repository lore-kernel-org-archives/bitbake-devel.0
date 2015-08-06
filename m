Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 675657653B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:01:45 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 06 Aug 2015 09:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="778218655"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2015 09:01:45 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id D1E116A4083;
	Thu,  6 Aug 2015 09:00:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:01:36 +0300
Message-Id: <0d143bd72928af35860c9f36970e9fbd519d552e.1438876763.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <d5bbed667ae3585aa515d0b90329c99a62d2a3b7.1438876763.git.ed.bartosh@linux.intel.com>
References: <d5bbed667ae3585aa515d0b90329c99a62d2a3b7.1438876763.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438876763.git.ed.bartosh@linux.intel.com>
References: <cover.1438876763.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/3] bitbake: toastermain: Add a longer default database timeout
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
X-List-Received-Date: Thu, 06 Aug 2015 16:01:46 -0000

From: Michael Wood <michael.g.wood@intel.com>

When using sqlite we sometimes see Database Locked exceptions when we
fire off database calls asynchronously from the UI. We need sqlite to
wait a bit longer for the lock to be released.
n.b In production setup we hopefully wouldn't be using sqlite.

docs.djangoproject.com/en/1.6/ref/databases/#database-is-locked-errors

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastermain/settings.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
index c72a904..b149a5e 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -49,6 +49,12 @@ DATABASES = {
     }
 }
 
+# Needed when Using sqlite especially to add a longer timeout for waiting
+# for the database lock to be  released
+# https://docs.djangoproject.com/en/1.6/ref/databases/#database-is-locked-errors
+if 'sqlite' in DATABASES['default']['ENGINE']:
+    DATABASES['default']['OPTIONS'] = { 'timeout': 20 }
+
 # Reinterpret database settings if we have DATABASE_URL environment variable defined
 
 if 'DATABASE_URL' in os.environ:
-- 
2.1.4


