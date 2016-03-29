Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 059C76E65F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Mar 2016 13:05:09 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 29 Mar 2016 06:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,410,1455004800"; d="scan'208";a="947208512"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2016 06:04:21 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Mar 2016 16:04:19 +0300
Message-Id: <1459256659-31391-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH v2] FileChecksumCache: don't follow directory symlinks
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
X-List-Received-Date: Tue, 29 Mar 2016 13:05:10 -0000

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
 lib/bb/checksum.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 7fb46d8..2ec964d 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -123,12 +123,14 @@ class FileChecksumCache(MultiProcessCache):
                 # Handle globs
                 for f in glob.glob(pth):
                     if os.path.isdir(f):
-                        checksums.extend(checksum_dir(f))
+                        if not os.path.islink(f):
+                            checksums.extend(checksum_dir(f))
                     else:
                         checksum = checksum_file(f)
                         checksums.append((f, checksum))
             elif os.path.isdir(pth):
-                checksums.extend(checksum_dir(pth))
+                if not os.path.islink(pth):
+                    checksums.extend(checksum_dir(pth))
             else:
                 checksum = checksum_file(pth)
                 checksums.append((pth, checksum))
-- 
2.6.2


