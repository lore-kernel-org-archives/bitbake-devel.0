Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 522D065C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 18:44:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 26 Feb 2015 10:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,654,1418112000"; d="scan'208";a="691257830"
Received: from localhost.jf.intel.com ([10.7.201.37])
	by orsmga002.jf.intel.com with ESMTP; 26 Feb 2015 10:44:28 -0800
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 10:44:25 -0800
Message-Id: <1424976265-4918-1-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] bitbake: fetch2: Have decodeurl() return a namedtuple
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
X-List-Received-Date: Thu, 26 Feb 2015 18:44:29 -0000

Since decodeurl() returns a tuple with six values, return a namedtuple
instead, so the result is easier to use and assists in writing cleaner code.

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 599ea8c..8dfe978 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -39,6 +39,7 @@ import bb.checksum
 from bb import data
 import bb.process
 import subprocess
+from collections import namedtuple
 
 __version__ = "2"
 _checksum_cache = bb.checksum.FileChecksumCache()
@@ -379,8 +380,9 @@ def decodeurl(url):
                     raise MalformedUrl(url, "The URL: '%s' is invalid: parameter %s does not specify a value (missing '=')" % (url, s))
                 s1, s2 = s.split('=')
                 p[s1] = s2
-
-    return type, host, urllib.unquote(path), user, pswd, p
+    result_tuple = namedtuple('decodeurl_tuple',
+                              'type, host, path, user, password, parameters')
+    return result_tuple(type, host, urllib.unquote(path), user, pswd, p)
 
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
-- 
1.9.3


