Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E99D2606D4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 17:27:23 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2014 10:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,827,1389772800"; d="scan'208";a="490122640"
Received: from sleopold-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.121.72])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2014 10:20:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 18:20:45 +0100
Message-Id: <1397064045-30314-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH v2] toaster: Allow toaster to start without pytz
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
X-List-Received-Date: Wed, 09 Apr 2014 17:27:26 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch allows toaster to start without pytz.

Django can work with or without pytz, but in the
time zone fix I mistakenly added a hard dependency
on this module.

This patch eliminates the hard dependency.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---

v2: Fix authorship and indentation issues

 lib/toaster/toastermain/settings.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 6e9d85d..645f327 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -64,15 +64,19 @@ else:
     for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
         for fn in filenames:
             filepath = os.path.join(dirpath, fn)
+            zonename = filepath.lstrip(ZONEINFOPATH).strip()
             try:
                 import pytz
                 from pytz.exceptions import UnknownTimeZoneError
-                zonename = filepath.lstrip(ZONEINFOPATH).strip()
-                if pytz.timezone(zonename) is not None:
-                    zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
-            except UnknownTimeZoneError, ValueError:
-                # we expect timezone failures here, just move over
                 pass
+                try:
+                    if pytz.timezone(zonename) is not None:
+                        zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+                except UnknownTimeZoneError, ValueError:
+                    # we expect timezone failures here, just move over
+                    pass
+            except ImportError:
+                zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
 
     TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
 
-- 
1.9.0


