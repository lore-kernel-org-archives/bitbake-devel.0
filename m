Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 08A1A78281
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 12:11:02 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga104.jf.intel.com with ESMTP; 23 Aug 2017 05:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,416,1498546800"; d="scan'208";a="1209386445"
Received: from skhurana-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.139.43])
	by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2017 05:11:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Aug 2017 00:10:28 +1200
Message-Id: <2d77cd3ba76d2b469956458806e8770453cb58a4.1503489977.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503489977.git.paul.eggleton@linux.intel.com>
References: <cover.1503489977.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] fetch2: don't mandate path element in encodeurl()
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
X-List-Received-Date: Wed, 23 Aug 2017 12:11:02 -0000

URLs do not have to have a path; currently our npm URLs don't, so
encodeurl() needs to handle if the path element isn't specified. This
fixes errors using OpenEmbedded's devtool add / recipetool create on an
npm URL after OE-Core revision ecca596b75cfda2f798a0bdde75f4f774e23a95b
that uses decodeurl() and encodeurl() to change URL parameter values.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7afb2ae..3eb0e4d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -411,8 +411,6 @@ def encodeurl(decoded):
 
     type, host, path, user, pswd, p = decoded
 
-    if not path:
-        raise MissingParameterError('path', "encoded from the data %s" % str(decoded))
     if not type:
         raise MissingParameterError('type', "encoded from the data %s" % str(decoded))
     url = '%s://' % type
@@ -423,10 +421,11 @@ def encodeurl(decoded):
         url += "@"
     if host and type != "file":
         url += "%s" % host
-    # Standardise path to ensure comparisons work
-    while '//' in path:
-        path = path.replace("//", "/")
-    url += "%s" % urllib.parse.quote(path)
+    if path:
+        # Standardise path to ensure comparisons work
+        while '//' in path:
+            path = path.replace("//", "/")
+        url += "%s" % urllib.parse.quote(path)
     if p:
         for parm in p:
             url += ";%s=%s" % (parm, p[parm])
-- 
2.9.5


