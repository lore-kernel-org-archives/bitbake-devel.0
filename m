Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TgB2Q-0004JC-Tt
	for bitbake-devel@lists.openembedded.org;
	Wed, 05 Dec 2012 10:13:07 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Dec 2012 00:56:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,220,1355126400"; d="scan'208";a="229188322"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.152])
	by orsmga001.jf.intel.com with ESMTP; 05 Dec 2012 00:57:36 -0800
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Dec 2012 10:58:26 +0200
Message-Id: <1354697906-19696-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.11.7
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH 1/2] fetch2: remove localcount and use AUTOINC instead
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
X-List-Received-Date: Wed, 05 Dec 2012 09:13:07 -0000

- do not use the BB_URI_LOCALCOUNT database for computing revision
incremental numbers anymore
- sortable_revision now generates "AUTOINC+${latest_rev}"
- use one incrementing value rather than several
- PV becomes 0.1+gitAUTOINC+deadbeefdecafbad_decafbaddeadbeef
- remove all localcount code and simplify the fetcher
- this patch addresses the following proposal:
http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-November/003878.html

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 55 +++++++--------------------------------
 bitbake/lib/bb/fetch2/git.py      | 39 ++-------------------------
 2 files changed, 11 insertions(+), 83 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 81964f1..150dc3c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -422,10 +422,18 @@ def get_srcrev(d):
     if not format:
         raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
 
+    autoinc = False
+    autoinc_templ = 'AUTOINC+'
     for scm in scms:
         ud = urldata[scm]
         for name in ud.names:
             rev = ud.method.sortable_revision(scm, ud, d, name)
+            if rev.startswith(autoinc_templ):
+                if not autoinc:
+                    autoinc = True
+                    format = "%s%s" % (autoinc_templ, format)
+                rev = rev[len(autoinc_templ):]
+
             format = format.replace(name, rev)
 
     return format
@@ -1036,23 +1044,6 @@ class FetchMethod(object):
         logger.info("URL %s could not be checked for status since no method exists.", url)
         return True
 
-    def localcount_internal_helper(ud, d, name):
-        """
-        Return:
-            a) a locked localcount if specified
-            b) None otherwise
-        """
-
-        localcount = None
-        if name != '':
-            pn = d.getVar("PN", True)
-            localcount = d.getVar("LOCALCOUNT_" + name, True)
-        if not localcount:
-            localcount = d.getVar("LOCALCOUNT", True)
-        return localcount
-
-    localcount_internal_helper = staticmethod(localcount_internal_helper)
-
     def latest_revision(self, url, ud, d, name):
         """
         Look in the cache for the latest revision, if not present ask the SCM.
@@ -1075,36 +1066,8 @@ class FetchMethod(object):
         if hasattr(self, "_sortable_revision"):
             return self._sortable_revision(url, ud, d)
 
-        localcounts = bb.persist_data.persist('BB_URI_LOCALCOUNT', d)
-        key = self.generate_revision_key(url, ud, d, name)
-
         latest_rev = self._build_revision(url, ud, d, name)
-        last_rev = localcounts.get(key + '_rev')
-        uselocalcount = d.getVar("BB_LOCALCOUNT_OVERRIDE", True) or False
-        count = None
-        if uselocalcount:
-            count = FetchMethod.localcount_internal_helper(ud, d, name)
-        if count is None:
-            count = localcounts.get(key + '_count') or "0"
-
-        if last_rev == latest_rev:
-            return str(count + "+" + latest_rev)
-
-        buildindex_provided = hasattr(self, "_sortable_buildindex")
-        if buildindex_provided:
-            count = self._sortable_buildindex(url, ud, d, latest_rev)
-
-        if count is None:
-            count = "0"
-        elif uselocalcount or buildindex_provided:
-            count = str(count)
-        else:
-            count = str(int(count) + 1)
-
-        localcounts[key + '_rev'] = latest_rev
-        localcounts[key + '_count'] = count
-
-        return str(count + "+" + latest_rev)
+        return 'AUTOINC+%s' % str(latest_rev)
 
     def generate_revision_key(self, url, ud, d, name):
         key = self._revision_key(url, ud, d, name)
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0fd0b2f..2a8a727 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -71,11 +71,8 @@ from   bb.fetch2 import logger
 class Git(FetchMethod):
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
-        #
-        # Only enable _sortable revision if the key is set
-        #
-        if d.getVar("BB_GIT_CLONE_FOR_SRCREV", True):
-            self._sortable_buildindex = self._sortable_buildindex_disabled
+        pass
+
     def supports(self, url, ud, d):
         """
         Check to see if a given url can be fetched with git.
@@ -316,38 +313,6 @@ class Git(FetchMethod):
     def _build_revision(self, url, ud, d, name):
         return ud.revisions[name]
 
-    def _sortable_buildindex_disabled(self, url, ud, d, rev):
-        """
-        Return a suitable buildindex for the revision specified. This is done by counting revisions
-        using "git rev-list" which may or may not work in different circumstances.
-        """
-
-        cwd = os.getcwd()
-
-        # Check if we have the rev already
-
-        if not os.path.exists(ud.clonedir):
-            logger.debug(1, "GIT repository for %s does not exist in %s.  \
-                          Downloading.", url, ud.clonedir)
-            self.download(None, ud, d)
-            if not os.path.exists(ud.clonedir):
-                logger.error("GIT repository for %s does not exist in %s after \
-                             download. Cannot get sortable buildnumber, using \
-                             old value", url, ud.clonedir)
-                return None
-
-
-        os.chdir(ud.clonedir)
-        if not self._contains_ref(rev, d):
-            self.download(None, ud, d)
-
-        output = runfetchcmd("%s rev-list %s -- 2> /dev/null | wc -l" % (ud.basecmd, rev), d, quiet=True)
-        os.chdir(cwd)
-
-        buildindex = "%s" % output.split()[0]
-        logger.debug(1, "GIT repository for %s in %s is returning %s revisions in rev-list before %s", url, ud.clonedir, buildindex, rev)
-        return buildindex
-
     def checkstatus(self, uri, ud, d):
         fetchcmd = "%s ls-remote %s" % (ud.basecmd, uri)
         try:
-- 
1.7.11.7



