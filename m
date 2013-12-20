Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id A318660D67
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 14:49:00 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Dec 2013 06:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,521,1384329600"; d="scan'208";a="453335482"
Received: from dsgunati-mobl.gar.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.122.40])
	by fmsmga002.fm.intel.com with ESMTP; 20 Dec 2013 06:49:00 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Dec 2013 14:48:45 +0000
Message-Id: <305ce13a6c7da54b17f80cc64dc3115f1b8cdad7.1387550848.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1387550848.git.paul.eggleton@linux.intel.com>
References: <cover.1387550848.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1387550848.git.paul.eggleton@linux.intel.com>
References: <cover.1387550848.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] fetch2: avoid printing "no checksum" error message twice
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
X-List-Received-Date: Fri, 20 Dec 2013 14:49:00 -0000

Because of the way we were handling this error, it was printed twice -
once via logger.error() (to avoid the log being printed) and a second
time when the exception gets wrapped in a FuncFailed at a higher level.
Call logger.error() earlier and change the text we send in the
exception to be more brief, so it more closely resembles the behaviour
when there is an invalid checksum.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6c6915c..8fdf59c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -527,10 +527,11 @@ def verify_checksum(ud, d):
         # If strict checking enabled and neither sum defined, raise error
         strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
         if strict and not (ud.md5_expected or ud.sha256_expected):
-            raise NoChecksumError('No checksum specified for %s, please add at least one to the recipe:\n'
+            logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
-                              ud.sha256_name, sha256data), ud.url)
+                              ud.sha256_name, sha256data))
+            raise NoChecksumError('Missing SRC_URI checksum', ud.url)
 
         # Log missing sums so user can more easily add them
         if not ud.md5_expected:
@@ -1424,9 +1425,7 @@ class Fetch(object):
                 update_stamp(ud, self.d)
 
             except BBFetchException as e:
-                if isinstance(e, NoChecksumError):
-                    logger.error("%s" % str(e))
-                elif isinstance(e, ChecksumError):
+                if isinstance(e, ChecksumError):
                     logger.error("Checksum failure fetching %s" % u)
                 raise
 
-- 
1.8.1.2


