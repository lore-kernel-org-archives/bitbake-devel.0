Return-Path: <brendan.le.foll@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 1A6177736C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 15:07:07 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 25 Feb 2016 07:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="923777728"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2016 07:06:44 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 15:07:06 +0000
Message-Id: <1456412828-11343-2-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
References: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
Subject: [PATCH 1/3] utils.py: Add sha1_file call
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
X-List-Received-Date: Thu, 25 Feb 2016 15:07:08 -0000

From: Brendan Le Foll <brendan.le.foll@intel.com>

This is useful as npm-lockdown uses sha1 because npm releases the sha1 of
packages and whilst this is undocumented it seems no other algorithm is
supported

Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
---
 lib/bb/utils.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 82579b8..7ab8927 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -534,6 +534,21 @@ def sha256_file(filename):
             s.update(line)
     return s.hexdigest()
 
+def sha1_file(filename):
+    """
+    Return the hex string representation of the SHA1 checksum of the filename
+    """
+    try:
+        import hashlib
+    except ImportError:
+        return None
+
+    s = hashlib.sha1()
+    with open(filename, "rb") as f:
+        for line in f:
+            s.update(line)
+    return s.hexdigest()
+
 def preserved_envvars_exported():
     """Variables which are taken from the environment and placed in and exported
     from the metadata"""
-- 
2.7.1


