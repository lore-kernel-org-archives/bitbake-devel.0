Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id F13816086B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Jun 2013 08:59:53 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 04 Jun 2013 01:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,798,1363158000"; d="scan'208";a="311952217"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.221])
	by azsmga001.ch.intel.com with ESMTP; 04 Jun 2013 01:59:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Jun 2013 09:59:37 +0100
Message-Id: <1370336377-6394-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] lib/bb/cache.py: invalidate cache when file checksum entry no longer exists
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 04 Jun 2013 08:59:54 -0000

Go through the cached list of file checksums and check if any of the
files no longer exist; if any are missing then invalidate the cached
recipe, which will force it to be reparsed and thus force the list of
files to be collected again. This prevents a warning when moving a file
to a different location that is still picked up by the recipe, e.g.
moving a file from a "files" subdirectory to one named with the recipe
name (${BPN}).

Fixes [YOCTO #4474].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cache.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 9e89742..eee83b7 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -524,6 +524,15 @@ class Cache(object):
                     self.remove(fn)
                     return False
 
+        if hasattr(info_array[0], 'file_checksums'):
+            for _, fl in info_array[0].file_checksums.items():
+                for f in fl.split():
+                    if not os.path.exists(f):
+                        logger.debug(2, "Cache: %s's file checksum list file %s was removed",
+                                        fn, f)
+                        self.remove(fn)
+                        return False
+
         if appends != info_array[0].appends:
             logger.debug(2, "Cache: appends for %s changed", fn)
             logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
-- 
1.8.1.2


