Return-Path: <Joe.MacDonald@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8DF2F6AE36
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2013 15:05:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5SF5DlP002453
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jun 2013 08:05:13 -0700 (PDT)
Received: from burninator.wrs.com (128.224.146.166) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Fri, 28 Jun 2013 08:05:12 -0700
From: Joe MacDonald <joe.macdonald@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jun 2013 11:05:06 -0400
Message-ID: <1372431907-10142-2-git-send-email-joe.macdonald@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
References: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
MIME-Version: 1.0
Subject: [bitbake][oe-core][RFC PATCH 1/2] fetch2: Add an extra check for sstate_mirrors
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
X-List-Received-Date: Fri, 28 Jun 2013 15:05:13 -0000
Content-Type: text/plain

BB_NO_NETWORK disables any fetching, however if we're using an external
sstate cache, we may want to be able to fetch those objects even if we are
not fetching the upstream sources.

Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6211cd7..edd290b3 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -714,10 +714,13 @@ def check_network_access(d, info = "", url = None):
     """
     log remote network access, and error if BB_NO_NETWORK is set
     """
-    if d.getVar("BB_NO_NETWORK", True) == "1":
-        raise NetworkAccess(url, info)
+    if d.getVar("SSTATE_MIRROR_ALLOW_NETWORK", True) == "1" and d.getVar("LOCAL_SSTATE_CACHE", True) == True:
+        logger.debug(1, "Fetcher accessed the network for sstate cache data with the command %s" % info)
     else:
-        logger.debug(1, "Fetcher accessed the network with the command %s" % info)
+        if d.getVar("BB_NO_NETWORK", True) == "1":
+            raise NetworkAccess(url, info)
+        else:
+            logger.debug(1, "Fetcher accessed the network with the command %s" % info)
 
 def build_mirroruris(origud, mirrors, ld):
     uris = []
@@ -1301,7 +1304,7 @@ class FetchMethod(object):
         return "%s-%s" % (key, d.getVar("PN", True) or "")
 
 class Fetch(object):
-    def __init__(self, urls, d, cache = True, localonly = False):
+    def __init__(self, urls, d, cache = True, localonly = False, sstate_cache = False):
         if localonly and cache:
             raise Exception("bb.fetch2.Fetch.__init__: cannot set cache and localonly at same time")
 
@@ -1310,6 +1313,8 @@ class Fetch(object):
         self.urls = urls
         self.d = d
         self.ud = {}
+        self.sstate_cache = sstate_cache
+        d.setVar("LOCAL_SSTATE_CACHE", sstate_cache)
 
         fn = d.getVar('FILE', True)
         if cache and fn and fn in urldata_cache:
@@ -1354,7 +1359,10 @@ class Fetch(object):
         if len(urls) == 0:
             urls = self.urls
 
-        network = self.d.getVar("BB_NO_NETWORK", True)
+        if self.sstate_cache == True and self.d.getVar("SSTATE_MIRROR_ALLOW_NETWORK", True) == True:
+            network = True
+        else:
+            network = self.d.getVar("BB_NO_NETWORK", True)
         premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
 
         for u in urls:
-- 
1.7.10.4


