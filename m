Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SXaQp-0001o0-PA
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 17:58:32 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 May 2012 08:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="147354982"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.182])
	by azsmga001.ch.intel.com with ESMTP; 24 May 2012 08:48:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 May 2012 16:47:55 +0100
Message-Id: <1337874475-5086-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] lib/bb/fetch2: fix comments for verify_checksum
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 24 May 2012 15:58:32 -0000

This function no longer returns a value, it raises errors instead, so
update the comments to reflect this.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index d4b6c3e..6ae69cd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -274,13 +274,10 @@ def verify_checksum(u, ud, d):
     """
     verify the MD5 and SHA256 checksum for downloaded src
 
-    return value:
-        - True: a checksum matched
-        - False: neither checksum matched
+    Raises a FetchError if one or both of the SRC_URI checksums do not match
+    the downloaded file, or if BB_STRICT_CHECKSUM is set and there are no
+    checksums specified.
 
-    if checksum is missing in recipes file, "BB_STRICT_CHECKSUM" decide the return value.
-    if BB_STRICT_CHECKSUM = "1" then return false as unmatched, otherwise return true as
-    matched
     """
 
     if not ud.method.supports_checksum(ud):
-- 
1.7.9.5



