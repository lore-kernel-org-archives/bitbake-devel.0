Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id EDCC065D00
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Mar 2016 15:00:26 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 22 Mar 2016 07:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,377,1455004800"; d="scan'208";a="769111992"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga003.jf.intel.com with ESMTP; 22 Mar 2016 07:59:56 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Mar 2016 16:59:54 +0200
Message-Id: <1458658795-15511-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] FileChecksumCache: don't follow directory symlinks
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
X-List-Received-Date: Tue, 22 Mar 2016 15:00:27 -0000

Before this patch, directory symlinks mathcing filename pattern (either
a file name or a glob pattern) were followed. However, directory
symlinks deeper in the search chain were omitted by os.walk(). Now
directory traversal behaves consistently, ignoring syminks on all
levels.

One reason for choosing not to "walk into" directory symlinks is that
dir symlinks in externalsrc.bbclass in oe-core are causing problems in
source tree checksumming.

[YOCTO #8853]
---
 lib/bb/checksum.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 7fb46d8..2369db3 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -123,11 +123,14 @@ class FileChecksumCache(MultiProcessCache):
                 # Handle globs
                 for f in glob.glob(pth):
                     if os.path.isdir(f):
-                        checksums.extend(checksum_dir(f))
+                        if os.path.islink(f):
+                            continue
+                        else:
+                            checksums.extend(checksum_dir(f))
                     else:
                         checksum = checksum_file(f)
                         checksums.append((f, checksum))
-            elif os.path.isdir(pth):
+            elif os.path.isdir(pth) and not os.path.islink(f):
                 checksums.extend(checksum_dir(pth))
             else:
                 checksum = checksum_file(pth)
-- 
2.6.2


