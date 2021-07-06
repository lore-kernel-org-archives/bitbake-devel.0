Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web12.3497.1625560230406502044
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jul 2021 01:30:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.24, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="209032007"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="209032007"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:30:30 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="559876411"
Received: from sho7-mobl2.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.151.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:30:28 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/2] fetch2: add check for empty SRC_URI hash string
Date: Tue,  6 Jul 2021 16:30:21 +0800
Message-Id: <bff3c9dcbfcb64514462efad485e41abd585e6d1.1625560113.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625560113.git.anuj.mittal@intel.com>
References: <cover.1625560113.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Scott Weaver <weaverjs@gmail.com>

No error was being reported when the hash string was set to empty.
For example: SRC_URI[md5sum] = ""

On a related note (not a bug):
Because whitespace in the string will result in a checksum mismatch, the error
message was updated to make it a little clearer why the error was thrown.
For example: SRC_URI[md5sum] = " " or
SRC_URI[md5sum] = " 209f8326f5137d8817a6276d9577a2f1"

Now creates a message like this:
File: '/home/scott/yocto-cache/downloads/rsync-3.2.3.tar.gz' has md5
checksum '209f8326f5137d8817a6276d9577a2f1' when ' 209f8326f5137d8817a6276d9577a2f1' was expected

[YOCTO #14232]

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a13510d0028e234ea2f4744b0d0c38558395c70f)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf0201c49..c8e91262a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -562,6 +562,9 @@ def verify_checksum(ud, d, precomputed={}):
 
         checksum_expected = getattr(ud, "%s_expected" % checksum_id)
 
+        if checksum_expected == '':
+            checksum_expected = None
+
         return {
             "id": checksum_id,
             "name": checksum_name,
@@ -612,7 +615,7 @@ def verify_checksum(ud, d, precomputed={}):
 
     for ci in checksum_infos:
         if ci["expected"] and ci["expected"] != ci["data"]:
-            messages.append("File: '%s' has %s checksum %s when %s was " \
+            messages.append("File: '%s' has %s checksum '%s' when '%s' was " \
                             "expected" % (ud.localpath, ci["id"], ci["data"], ci["expected"]))
             bad_checksum = ci["data"]
 
-- 
2.31.1

