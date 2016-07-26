Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4E3F371E63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 03:37:10 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 25 Jul 2016 20:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,422,1464678000"; d="scan'208";a="1023890394"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.139.129])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2016 20:37:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2016 15:36:40 +1200
Message-Id: <c6d59200973e19d358a2fa1a1e5bec4523894e69.1469504165.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1469504165.git.paul.eggleton@linux.intel.com>
References: <cover.1469504165.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1469504165.git.paul.eggleton@linux.intel.com>
References: <cover.1469504165.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/checksum: avoid exception on broken symlinks
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
X-List-Received-Date: Tue, 26 Jul 2016 03:37:10 -0000

If using OE's externalsrc with a source tree that is not tracked by git
and contains broken symlinks, you can receive "TypeError: unorderable
types: NoneType() < str()" within the file checksum code due to:

 checksums.sort(key=operator.itemgetter(1))

Don't add files with no checksum to the checksums list in order to avoid
this.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/checksum.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index be4ab68..8428920 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -120,13 +120,15 @@ class FileChecksumCache(MultiProcessCache):
                             checksums.extend(checksum_dir(f))
                     else:
                         checksum = checksum_file(f)
-                        checksums.append((f, checksum))
+                        if checksum:
+                            checksums.append((f, checksum))
             elif os.path.isdir(pth):
                 if not os.path.islink(pth):
                     checksums.extend(checksum_dir(pth))
             else:
                 checksum = checksum_file(pth)
-                checksums.append((pth, checksum))
+                if checksum:
+                    checksums.append((pth, checksum))
 
         checksums.sort(key=operator.itemgetter(1))
         return checksums
-- 
2.5.5


