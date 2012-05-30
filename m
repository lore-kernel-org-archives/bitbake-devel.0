Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZlkO-000556-Dm
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:27:44 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 May 2012 09:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105914742"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.128])
	by AZSMGA002.ch.intel.com with ESMTP; 30 May 2012 09:17:24 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 17:17:17 +0100
Message-Id: <323bc7e66a458fa7fc6c5caa6cabb33a32492d79.1338394341.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/5] lib/bb/fetch2: ignore remote URIs when doing file checksums
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
X-List-Received-Date: Wed, 30 May 2012 16:27:44 -0000

Skip evaluating remote URIs when doing local file checksums, because we
don't need to process them and doing so will trigger a parse failure if
SRCREV is not fully specified. Whilst this is just delaying a check
until runtime (when do_fetch runs for the recipe) we're only validating
this here accidentally and if we did wish to check it during parsing it
ought to be done explicitly.

Fixes [YOCTO #2512]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6ae69cd..83050e4 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -112,6 +112,9 @@ class NetworkAccess(BBFetchException):
          BBFetchException.__init__(self, msg)
          self.args = (url, cmd)
 
+class NonLocalMethod(Exception):
+    def __init__(self):
+        Exception.__init__(self)
 
 def decodeurl(url):
     """Decodes an URL into the tokens (scheme, network location, path,
@@ -565,17 +568,17 @@ def srcrev_internal_helper(ud, d, name):
 def get_checksum_file_list(d):
     """ Get a list of files checksum in SRC_URI
 
-    Returns the all resolved local path of all local file entries in
+    Returns the resolved local paths of all local file entries in
     SRC_URI as a space-separated string
     """
-    fetch = Fetch([], d)
+    fetch = Fetch([], d, cache = False, localonly = True)
 
     dl_dir = d.getVar('DL_DIR', True)
     filelist = []
     for u in fetch.urls:
         ud = fetch.ud[u]
 
-        if isinstance(ud.method, local.Local):
+        if ud and isinstance(ud.method, local.Local):
             ud.setup_localpath(d)
             f = ud.localpath
             if f.startswith(dl_dir):
@@ -639,7 +642,7 @@ class FetchData(object):
     """
     A class which represents the fetcher state for a given URI.
     """
-    def __init__(self, url, d):
+    def __init__(self, url, d, localonly = False):
         # localpath is the location of a downloaded result. If not set, the file is local.
         self.donestamp = None
         self.localfile = ""
@@ -686,6 +689,9 @@ class FetchData(object):
         if not self.method:
             raise NoMethodError(url)
 
+        if localonly and not isinstance(self.method, local.Local):
+            raise NonLocalMethod()
+
         if hasattr(self.method, "urldata_init"):
             self.method.urldata_init(self, d)
 
@@ -1009,7 +1015,10 @@ class FetchMethod(object):
         return "%s-%s" % (key, d.getVar("PN", True) or "")
 
 class Fetch(object):
-    def __init__(self, urls, d, cache = True):
+    def __init__(self, urls, d, cache = True, localonly = False):
+        if localonly and cache:
+            raise Exception("bb.fetch2.Fetch.__init__: cannot set cache and localonly at same time")
+
         if len(urls) == 0:
             urls = d.getVar("SRC_URI", True).split()
         self.urls = urls
@@ -1022,7 +1031,12 @@ class Fetch(object):
 
         for url in urls:
             if url not in self.ud:
-                self.ud[url] = FetchData(url, d)
+                try:
+                    self.ud[url] = FetchData(url, d, localonly)
+                except NonLocalMethod:
+                    if localonly:
+                        self.ud[url] = None
+                        pass
 
         if cache:
             urldata_cache[fn] = self.ud
-- 
1.7.9.5



