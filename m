Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 67AD56DA97
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:54:02 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAKEqoPY022852 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:53:58 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hS2uvERMlcWN for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:53:58 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAKErrFv022865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:53:55 GMT
Message-ID: <1384959230.16887.62.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Nov 2013 14:53:50 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Stop passing around the pointless url parameter
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
X-List-Received-Date: Wed, 20 Nov 2013 14:54:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is no good reason to keep passing around the url parameter when
its contained within urldata (ud). This is left around due to
legacy reasons, some functions take it, some don't and its time
to cleanup.

This is fetcher internal API, there are a tiny number of external users
of the internal API (buildhistory and distrodata) which can be fixed up
after this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index ae99b72..199cdca 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -619,7 +619,7 @@ def get_srcrev(d):
         raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
 
     if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
-        autoinc, rev = urldata[scms[0]].method.sortable_revision(scms[0], urldata[scms[0]], d, urldata[scms[0]].names[0])
+        autoinc, rev = urldata[scms[0]].method.sortable_revision(urldata[scms[0]], d, urldata[scms[0]].names[0])
         if len(rev) > 10:
             rev = rev[:10]
         if autoinc:
@@ -637,7 +637,7 @@ def get_srcrev(d):
     for scm in scms:
         ud = urldata[scm]
         for name in ud.names:
-            autoinc, rev = ud.method.sortable_revision(scm, ud, d, name)
+            autoinc, rev = ud.method.sortable_revision(ud, d, name)
             seenautoinc = seenautoinc or autoinc
             if len(rev) > 10:
                 rev = rev[:10]
@@ -777,17 +777,17 @@ def try_mirror_url(origud, ud, ld, check = False):
     # False means try another url
     try:
         if check:
-            found = ud.method.checkstatus(ud.url, ud, ld)
+            found = ud.method.checkstatus(ud, ld)
             if found:
                 return found
             return False
 
         os.chdir(ld.getVar("DL_DIR", True))
 
-        if not os.path.exists(ud.donestamp) or ud.method.need_update(ud.url, ud, ld):
-            ud.method.download(ud.url, ud, ld)
+        if not os.path.exists(ud.donestamp) or ud.method.need_update(ud, ld):
+            ud.method.download(ud, ld)
             if hasattr(ud.method,"build_mirror_data"):
-                ud.method.build_mirror_data(ud.url, ud, ld)
+                ud.method.build_mirror_data(ud, ld)
 
         if not ud.localpath or not os.path.exists(ud.localpath):
             return False
@@ -805,10 +805,10 @@ def try_mirror_url(origud, ud, ld, check = False):
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
             if not os.path.exists(dest):
                 os.symlink(ud.localpath, dest)
-            if not os.path.exists(origud.donestamp) or origud.method.need_update(origud.url, origud, ld):
-                origud.method.download(origud.url, origud, ld)
+            if not os.path.exists(origud.donestamp) or origud.method.need_update(origud, ld):
+                origud.method.download(origud, ld)
                 if hasattr(ud.method,"build_mirror_data"):
-                    origud.method.build_mirror_data(origud.url, origud, ld)
+                    origud.method.build_mirror_data(origud, ld)
             return None
         # Otherwise the result is a local file:// and we symlink to it
         if not os.path.exists(origud.localpath):
@@ -888,7 +888,7 @@ def srcrev_internal_helper(ud, d, name):
             var = "SRCREV_%s_pn-%s" % (name, pn)
         raise FetchError("Please set %s to a valid value" % var, ud.url)
     if rev == "AUTOINC":
-        rev = ud.method.latest_revision(ud.url, ud, d, name)
+        rev = ud.method.latest_revision(ud, d, name)
 
     return rev
 
@@ -1009,7 +1009,7 @@ class FetchData(object):
 
         self.method = None
         for m in methods:
-            if m.supports(url, self, d):
+            if m.supports(self, d):
                 self.method = m
                 break                
 
@@ -1031,7 +1031,7 @@ class FetchData(object):
             self.localpath = self.parm["localpath"]
             self.basename = os.path.basename(self.localpath)
         elif self.localfile:
-            self.localpath = self.method.localpath(self.url, self, d)
+            self.localpath = self.method.localpath(self, d)
 
         dldir = d.getVar("DL_DIR", True)
         # Note: .done and .lock files should always be in DL_DIR whereas localpath may not be.
@@ -1055,7 +1055,7 @@ class FetchData(object):
 
     def setup_localpath(self, d):
         if not self.localpath:
-            self.localpath = self.method.localpath(self.url, self, d)
+            self.localpath = self.method.localpath(self, d)
 
     def getSRCDate(self, d):
         """
@@ -1079,13 +1079,13 @@ class FetchMethod(object):
     def __init__(self, urls = []):
         self.urls = []
 
-    def supports(self, url, urldata, d):
+    def supports(self, urldata, d):
         """
         Check to see if this fetch class supports a given url.
         """
         return 0
 
-    def localpath(self, url, urldata, d):
+    def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
         Can also setup variables in urldata for use in go (saving code duplication
@@ -1129,7 +1129,7 @@ class FetchMethod(object):
 
     urls = property(getUrls, setUrls, None, "Urls property")
 
-    def need_update(self, url, ud, d):
+    def need_update(self, ud, d):
         """
         Force a fetch, even if localpath exists?
         """
@@ -1143,7 +1143,7 @@ class FetchMethod(object):
         """
         return False
 
-    def download(self, url, urldata, d):
+    def download(self, urldata, d):
         """
         Fetch urls
         Assumes localpath was called first
@@ -1267,13 +1267,13 @@ class FetchMethod(object):
        """
        bb.utils.remove(urldata.localpath)
 
-    def try_premirror(self, url, urldata, d):
+    def try_premirror(self, urldata, d):
         """
         Should premirrors be used?
         """
         return True
 
-    def checkstatus(self, url, urldata, d):
+    def checkstatus(self, urldata, d):
         """
         Check the status of a URL
         Assumes localpath was called first
@@ -1281,7 +1281,7 @@ class FetchMethod(object):
         logger.info("URL %s could not be checked for status since no method exists.", url)
         return True
 
-    def latest_revision(self, url, ud, d, name):
+    def latest_revision(self, ud, d, name):
         """
         Look in the cache for the latest revision, if not present ask the SCM.
         """
@@ -1289,19 +1289,19 @@ class FetchMethod(object):
             raise ParameterError("The fetcher for this URL does not support _latest_revision", url)
 
         revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
-        key = self.generate_revision_key(url, ud, d, name)
+        key = self.generate_revision_key(ud, d, name)
         try:
             return revs[key]
         except KeyError:
-            revs[key] = rev = self._latest_revision(url, ud, d, name)
+            revs[key] = rev = self._latest_revision(ud, d, name)
             return rev
 
-    def sortable_revision(self, url, ud, d, name):
-        latest_rev = self._build_revision(url, ud, d, name)
+    def sortable_revision(self, ud, d, name):
+        latest_rev = self._build_revision(ud, d, name)
         return True, str(latest_rev)
 
-    def generate_revision_key(self, url, ud, d, name):
-        key = self._revision_key(url, ud, d, name)
+    def generate_revision_key(self, ud, d, name):
+        key = self._revision_key(ud, d, name)
         return "%s-%s" % (key, d.getVar("PN", True) or "")
 
 class Fetch(object):
@@ -1372,9 +1372,9 @@ class Fetch(object):
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
  
-                if os.path.exists(ud.donestamp) and not m.need_update(u, ud, self.d):
+                if os.path.exists(ud.donestamp) and not m.need_update(ud, self.d):
                     localpath = ud.localpath
-                elif m.try_premirror(u, ud, self.d):
+                elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
                     mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
                     localpath = try_mirrors(self.d, ud, mirrors, False)
@@ -1385,12 +1385,12 @@ class Fetch(object):
                 os.chdir(self.d.getVar("DL_DIR", True))
 
                 firsterr = None
-                if not localpath and ((not os.path.exists(ud.donestamp)) or m.need_update(u, ud, self.d)):
+                if not localpath and ((not os.path.exists(ud.donestamp)) or m.need_update(ud, self.d)):
                     try:
                         logger.debug(1, "Trying Upstream")
-                        m.download(u, ud, self.d)
+                        m.download(ud, self.d)
                         if hasattr(m, "build_mirror_data"):
-                            m.build_mirror_data(u, ud, self.d)
+                            m.build_mirror_data(ud, self.d)
                         localpath = ud.localpath
                         # early checksum verify, so that if checksum mismatched,
                         # fetcher still have chance to fetch from mirror
@@ -1452,7 +1452,7 @@ class Fetch(object):
             if not ret:
                 # Next try checking from the original uri, u
                 try:
-                    ret = m.checkstatus(u, ud, self.d)
+                    ret = m.checkstatus(ud, self.d)
                 except:
                     # Finally, try checking uri, u, from MIRRORS
                     mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
index 5d9e5f9..3caaa6f 100644
--- a/bitbake/lib/bb/fetch2/bzr.py
+++ b/bitbake/lib/bb/fetch2/bzr.py
@@ -34,7 +34,7 @@ from bb.fetch2 import runfetchcmd
 from bb.fetch2 import logger
 
 class Bzr(FetchMethod):
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         return ud.type in ['bzr']
 
     def urldata_init(self, ud, d):
@@ -81,12 +81,12 @@ class Bzr(FetchMethod):
 
         return bzrcmd
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """Fetch url"""
 
         if os.access(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir), '.bzr'), os.R_OK):
             bzrcmd = self._buildbzrcommand(ud, d, "update")
-            logger.debug(1, "BZR Update %s", loc)
+            logger.debug(1, "BZR Update %s", ud.url)
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
             os.chdir(os.path.join (ud.pkgdir, os.path.basename(ud.path)))
             runfetchcmd(bzrcmd, d)
@@ -94,7 +94,7 @@ class Bzr(FetchMethod):
             bb.utils.remove(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir)), True)
             bzrcmd = self._buildbzrcommand(ud, d, "fetch")
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
-            logger.debug(1, "BZR Checkout %s", loc)
+            logger.debug(1, "BZR Checkout %s", ud.url)
             bb.utils.mkdirhier(ud.pkgdir)
             os.chdir(ud.pkgdir)
             logger.debug(1, "Running %s", bzrcmd)
@@ -114,17 +114,17 @@ class Bzr(FetchMethod):
     def supports_srcrev(self):
         return True
 
-    def _revision_key(self, url, ud, d, name):
+    def _revision_key(self, ud, d, name):
         """
         Return a unique key for the url
         """
         return "bzr:" + ud.pkgdir
 
-    def _latest_revision(self, url, ud, d, name):
+    def _latest_revision(self, ud, d, name):
         """
         Return the latest upstream revision number
         """
-        logger.debug(2, "BZR fetcher hitting network for %s", url)
+        logger.debug(2, "BZR fetcher hitting network for %s", ud.url)
 
         bb.fetch2.check_network_access(d, self._buildbzrcommand(ud, d, "revno"), ud.url)
 
@@ -132,12 +132,12 @@ class Bzr(FetchMethod):
 
         return output.strip()
 
-    def sortable_revision(self, url, ud, d, name):
+    def sortable_revision(self, ud, d, name):
         """
         Return a sortable revision number which in our case is the revision number
         """
 
-        return False, self._build_revision(url, ud, d)
+        return False, self._build_revision(ud, d)
 
-    def _build_revision(self, url, ud, d):
+    def _build_revision(self, ud, d):
         return ud.revision
diff --git a/bitbake/lib/bb/fetch2/cvs.py b/bitbake/lib/bb/fetch2/cvs.py
index 0a672a3..d27d96f 100644
--- a/bitbake/lib/bb/fetch2/cvs.py
+++ b/bitbake/lib/bb/fetch2/cvs.py
@@ -36,7 +36,7 @@ class Cvs(FetchMethod):
     """
     Class to fetch a module or modules from cvs repositories
     """
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with cvs.
         """
@@ -65,14 +65,14 @@ class Cvs(FetchMethod):
 
         ud.localfile = bb.data.expand('%s_%s_%s_%s%s%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.tag, ud.date, norecurse, fullpath), d)
 
-    def need_update(self, url, ud, d):
+    def need_update(self, ud, d):
         if (ud.date == "now"):
             return True
         if not os.path.exists(ud.localpath):
             return True
         return False
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
 
         method = ud.parm.get('method', 'pserver')
         localdir = ud.parm.get('localdir', ud.module)
@@ -124,13 +124,13 @@ class Cvs(FetchMethod):
         pkgdir = os.path.join(d.getVar('CVSDIR', True), pkg)
         moddir = os.path.join(pkgdir, localdir)
         if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
-            logger.info("Update " + loc)
+            logger.info("Update " + ud.url)
             bb.fetch2.check_network_access(d, cvsupdatecmd, ud.url)
             # update sources there
             os.chdir(moddir)
             cmd = cvsupdatecmd
         else:
-            logger.info("Fetch " + loc)
+            logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(pkgdir)
             os.chdir(pkgdir)
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index a901a44..b899547 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -73,7 +73,7 @@ class Git(FetchMethod):
     def init(self, d):
         pass
 
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
         """
@@ -142,10 +142,10 @@ class Git(FetchMethod):
 
         ud.localfile = ud.clonedir
 
-    def localpath(self, url, ud, d):
+    def localpath(self, ud, d):
         return ud.clonedir
 
-    def need_update(self, u, ud, d):
+    def need_update(self, ud, d):
         if not os.path.exists(ud.clonedir):
             return True
         os.chdir(ud.clonedir)
@@ -156,7 +156,7 @@ class Git(FetchMethod):
             return True
         return False
 
-    def try_premirror(self, u, ud, d):
+    def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
         if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
@@ -165,7 +165,7 @@ class Git(FetchMethod):
             return False
         return True
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """Fetch url"""
 
         if ud.user:
@@ -214,7 +214,7 @@ class Git(FetchMethod):
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
             ud.repochanged = True
 
-    def build_mirror_data(self, url, ud, d):
+    def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
         if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
@@ -317,11 +317,11 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, url)
         return output.split()[0]
 
-    def _build_revision(self, url, ud, d, name):
+    def _build_revision(self, ud, d, name):
         return ud.revisions[name]
 
-    def checkstatus(self, uri, ud, d):
-        fetchcmd = "%s ls-remote %s" % (ud.basecmd, uri)
+    def checkstatus(self, ud, d):
+        fetchcmd = "%s ls-remote %s" % (ud.basecmd, ud.url)
         try:
             runfetchcmd(fetchcmd, d, quiet=True)
             return True
diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 572b637..4093f6e 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -27,7 +27,7 @@ from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
 class GitSM(Git):
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
         """
@@ -42,7 +42,7 @@ class GitSM(Git):
                 pass
         return False
 
-    def update_submodules(self, u, ud, d):
+    def update_submodules(self, ud, d):
         # We have to convert bare -> full repo, do the submodule bit, then convert back
         tmpclonedir = ud.clonedir + ".tmp"
         gitdir = tmpclonedir + os.sep + ".git"
@@ -58,13 +58,13 @@ class GitSM(Git):
         os.rename(gitdir, ud.clonedir,)
         bb.utils.remove(tmpclonedir, True)
 
-    def download(self, loc, ud, d):
-        Git.download(self, loc, ud, d)
+    def download(self, ud, d):
+        Git.download(self, ud, d)
 
         os.chdir(ud.clonedir)
         submodules = self.uses_submodules(ud, d)
         if submodules:
-            self.update_submodules(loc, ud, d)
+            self.update_submodules(ud, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index cf21481..76810ab 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -37,7 +37,7 @@ from bb.fetch2 import logger
 
 class Hg(FetchMethod):
     """Class to fetch from mercurial repositories"""
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with mercurial.
         """
@@ -66,7 +66,7 @@ class Hg(FetchMethod):
 
         ud.localfile = data.expand('%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
 
-    def need_update(self, url, ud, d):
+    def need_update(self, ud, d):
         revTag = ud.parm.get('rev', 'tip')
         if revTag == "tip":
             return True
@@ -126,14 +126,14 @@ class Hg(FetchMethod):
 
         return cmd
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """Fetch url"""
 
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
         if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
             updatecmd = self._buildhgcommand(ud, d, "pull")
-            logger.info("Update " + loc)
+            logger.info("Update " + ud.url)
             # update sources there
             os.chdir(ud.moddir)
             logger.debug(1, "Running %s", updatecmd)
@@ -142,7 +142,7 @@ class Hg(FetchMethod):
 
         else:
             fetchcmd = self._buildhgcommand(ud, d, "fetch")
-            logger.info("Fetch " + loc)
+            logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
             os.chdir(ud.pkgdir)
@@ -169,7 +169,7 @@ class Hg(FetchMethod):
     def supports_srcrev(self):
         return True
 
-    def _latest_revision(self, url, ud, d, name):
+    def _latest_revision(self, ud, d, name):
         """
         Compute tip revision for the url
         """
@@ -177,10 +177,10 @@ class Hg(FetchMethod):
         output = runfetchcmd(self._buildhgcommand(ud, d, "info"), d)
         return output.strip()
 
-    def _build_revision(self, url, ud, d, name):
+    def _build_revision(self, ud, d, name):
         return ud.revision
 
-    def _revision_key(self, url, ud, d, name):
+    def _revision_key(self, ud, d, name):
         """
         Return a unique key for the url
         """
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 58bbe20..5c4e42a 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -34,7 +34,7 @@ from   bb.fetch2 import FetchMethod, FetchError
 from   bb.fetch2 import logger
 
 class Local(FetchMethod):
-    def supports(self, url, urldata, d):
+    def supports(self, urldata, d):
         """
         Check to see if a given url represents a local fetch.
         """
@@ -47,7 +47,7 @@ class Local(FetchMethod):
         ud.basepath = ud.decodedurl
         return
 
-    def localpath(self, url, urldata, d):
+    def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
         """
@@ -75,14 +75,14 @@ class Local(FetchMethod):
                 return dldirfile
         return newpath
 
-    def need_update(self, url, ud, d):
-        if url.find("*") != -1:
+    def need_update(self, ud, d):
+        if ud.url.find("*") != -1:
             return False
         if os.path.exists(ud.localpath):
             return False
         return True
 
-    def download(self, url, urldata, d):
+    def download(self, urldata, d):
         """Fetch urls (no-op for Local method)"""
         # no need to fetch local files, we'll deal with them in place.
         if self.supports_checksum(urldata) and not os.path.exists(urldata.localpath):
@@ -95,17 +95,17 @@ class Local(FetchMethod):
                 locations.append(filesdir)
             locations.append(d.getVar("DL_DIR", True))
 
-            msg = "Unable to find file " + url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
+            msg = "Unable to find file " + urldata.url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
             raise FetchError(msg)
 
         return True
 
-    def checkstatus(self, url, urldata, d):
+    def checkstatus(self, urldata, d):
         """
         Check the status of the url
         """
         if urldata.localpath.find("*") != -1:
-            logger.info("URL %s looks like a glob and was therefore not checked.", url)
+            logger.info("URL %s looks like a glob and was therefore not checked.", urldata.url)
             return True
         if os.path.exists(urldata.localpath):
             return True
diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
index 1a3a7bb..3d87796 100644
--- a/bitbake/lib/bb/fetch2/osc.py
+++ b/bitbake/lib/bb/fetch2/osc.py
@@ -20,7 +20,7 @@ class Osc(FetchMethod):
     """Class to fetch a module or modules from Opensuse build server
        repositories."""
 
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with osc.
         """
@@ -77,7 +77,7 @@ class Osc(FetchMethod):
 
         return osccmd
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """
         Fetch url
         """
@@ -86,7 +86,7 @@ class Osc(FetchMethod):
 
         if os.access(os.path.join(data.expand('${OSCDIR}', d), ud.path, ud.module), os.R_OK):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
-            logger.info("Update "+ loc)
+            logger.info("Update "+ ud.url)
             # update sources there
             os.chdir(ud.moddir)
             logger.debug(1, "Running %s", oscupdatecmd)
@@ -94,7 +94,7 @@ class Osc(FetchMethod):
             runfetchcmd(oscupdatecmd, d)
         else:
             oscfetchcmd = self._buildosccommand(ud, d, "fetch")
-            logger.info("Fetch " + loc)
+            logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
             os.chdir(ud.pkgdir)
diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index fc4074d..ac1bfc7 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -37,7 +37,7 @@ from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 
 class Perforce(FetchMethod):
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         return ud.type in ['p4']
 
     def doparse(url, d):
@@ -120,12 +120,12 @@ class Perforce(FetchMethod):
 
         ud.localfile = data.expand('%s+%s+%s.tar.gz' % (host, base.replace('/', '.'), cset), d)
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """
         Fetch urls
         """
 
-        (host, depot, user, pswd, parm) = Perforce.doparse(loc, d)
+        (host, depot, user, pswd, parm) = Perforce.doparse(ud.url, d)
 
         if depot.find('/...') != -1:
             path = depot[:depot.find('/...')]
@@ -158,7 +158,7 @@ class Perforce(FetchMethod):
         tmpfile, errors = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
         tmpfile = tmpfile.strip()
         if not tmpfile:
-            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
+            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", ud.url)
 
         if "label" in parm:
             depot = "%s@%s" % (depot, parm["label"])
@@ -167,13 +167,13 @@ class Perforce(FetchMethod):
             depot = "%s@%s" % (depot, cset)
 
         os.chdir(tmpfile)
-        logger.info("Fetch " + loc)
+        logger.info("Fetch " + ud.url)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
         p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt, depot))
         p4file = [f.rstrip() for f in p4file.splitlines()]
 
         if not p4file:
-            raise FetchError("Fetch: unable to get the P4 files from %s" % depot, loc)
+            raise FetchError("Fetch: unable to get the P4 files from %s" % depot, ud.url)
 
         count = 0
 
@@ -191,7 +191,7 @@ class Perforce(FetchMethod):
 
         if count == 0:
             logger.error()
-            raise FetchError("Fetch: No files gathered from the P4 fetch", loc)
+            raise FetchError("Fetch: No files gathered from the P4 fetch", ud.url)
 
         runfetchcmd("tar -czf %s %s" % (ud.localpath, module), d, cleanup = [ud.localpath])
         # cleanup
diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index 8300da8..21678eb 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -31,7 +31,7 @@ from   bb.fetch2 import runfetchcmd
 
 class Repo(FetchMethod):
     """Class to fetch a module or modules from repo (git) repositories"""
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with repo.
         """
@@ -53,7 +53,7 @@ class Repo(FetchMethod):
 
         ud.localfile = data.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch), d)
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """Fetch url"""
 
         if os.access(os.path.join(data.getVar("DL_DIR", d, True), ud.localfile), os.R_OK):
@@ -91,8 +91,8 @@ class Repo(FetchMethod):
     def supports_srcrev(self):
         return False
 
-    def _build_revision(self, url, ud, d):
+    def _build_revision(self, ud, d):
         return ud.manifest
 
-    def _want_sortable_revision(self, url, ud, d):
+    def _want_sortable_revision(self, ud, d):
         return False
diff --git a/bitbake/lib/bb/fetch2/sftp.py b/bitbake/lib/bb/fetch2/sftp.py
index 5fbbcfd..8ea4ef2 100644
--- a/bitbake/lib/bb/fetch2/sftp.py
+++ b/bitbake/lib/bb/fetch2/sftp.py
@@ -72,7 +72,7 @@ from bb.fetch2 import runfetchcmd
 class SFTP(FetchMethod):
     """Class to fetch urls via 'sftp'"""
 
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with sftp.
         """
@@ -95,10 +95,10 @@ class SFTP(FetchMethod):
 
         ud.localfile = data.expand(urllib.unquote(ud.basename), d)
 
-    def download(self, uri, ud, d):
+    def download(self, ud, d):
         """Fetch urls"""
 
-        urlo = URI(uri)
+        urlo = URI(ud.url)
         basecmd = 'sftp -oPasswordAuthentication=no'
         port = ''
         if urlo.port:
@@ -124,6 +124,6 @@ class SFTP(FetchMethod):
         cmd = '%s %s %s %s' % (basecmd, port, commands.mkarg(remote),
                                commands.mkarg(lpath))
 
-        bb.fetch2.check_network_access(d, cmd, uri)
+        bb.fetch2.check_network_access(d, cmd, ud.url)
         runfetchcmd(cmd, d)
         return True
diff --git a/bitbake/lib/bb/fetch2/ssh.py b/bitbake/lib/bb/fetch2/ssh.py
index 8b5acbf..4ae9794 100644
--- a/bitbake/lib/bb/fetch2/ssh.py
+++ b/bitbake/lib/bb/fetch2/ssh.py
@@ -72,8 +72,8 @@ __pattern__ = re.compile(r'''
 class SSH(FetchMethod):
     '''Class to fetch a module or modules via Secure Shell'''
 
-    def supports(self, url, urldata, d):
-        return __pattern__.match(url) != None
+    def supports(self, urldata, d):
+        return __pattern__.match(urldata.url) != None
 
     def supports_checksum(self, urldata):
         return False
@@ -89,10 +89,10 @@ class SSH(FetchMethod):
         host = m.group('host')
         urldata.localpath = os.path.join(d.getVar('DL_DIR', True), os.path.basename(path))
 
-    def download(self, url, urldata, d):
+    def download(self, urldata, d):
         dldir = d.getVar('DL_DIR', True)
 
-        m = __pattern__.match(url)
+        m = __pattern__.match(urldata.url)
         path = m.group('path')
         host = m.group('host')
         port = m.group('port')
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
index ee3823f..23631b4 100644
--- a/bitbake/lib/bb/fetch2/svk.py
+++ b/bitbake/lib/bb/fetch2/svk.py
@@ -37,7 +37,7 @@ from   bb.fetch2 import runfetchcmd
 
 class Svk(FetchMethod):
     """Class to fetch a module or modules from svk repositories"""
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with svk.
         """
@@ -54,14 +54,14 @@ class Svk(FetchMethod):
 
         ud.localfile = data.expand('%s_%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision, ud.date), d)
 
-    def need_update(self, url, ud, d):
+    def need_update(self, ud, d):
         if ud.date == "now":
             return True
         if not os.path.exists(ud.localpath):
             return True
         return False
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """Fetch urls"""
 
         svkroot = ud.host + ud.path
@@ -81,11 +81,11 @@ class Svk(FetchMethod):
         tmpfile = tmpfile.strip()
         if not tmpfile:
             logger.error()
-            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
+            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", ud.url)
 
         # check out sources there
         os.chdir(tmpfile)
-        logger.info("Fetch " + loc)
+        logger.info("Fetch " + ud.url)
         logger.debug(1, "Running %s", svkcmd)
         runfetchcmd(svkcmd, d, cleanup = [tmpfile])
 
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 123aa13..9c46cca 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -37,7 +37,7 @@ from   bb.fetch2 import logger
 
 class Svn(FetchMethod):
     """Class to fetch a module or modules from svn repositories"""
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with svn.
         """
@@ -112,14 +112,14 @@ class Svn(FetchMethod):
 
         return svncmd
 
-    def download(self, loc, ud, d):
+    def download(self, ud, d):
         """Fetch url"""
 
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
         if os.access(os.path.join(ud.moddir, '.svn'), os.R_OK):
             svnupdatecmd = self._buildsvncommand(ud, d, "update")
-            logger.info("Update " + loc)
+            logger.info("Update " + ud.url)
             # update sources there
             os.chdir(ud.moddir)
             # We need to attempt to run svn upgrade first in case its an older working format
@@ -132,7 +132,7 @@ class Svn(FetchMethod):
             runfetchcmd(svnupdatecmd, d)
         else:
             svnfetchcmd = self._buildsvncommand(ud, d, "fetch")
-            logger.info("Fetch " + loc)
+            logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
             os.chdir(ud.pkgdir)
@@ -166,7 +166,7 @@ class Svn(FetchMethod):
         """
         return "svn:" + ud.moddir
 
-    def _latest_revision(self, url, ud, d, name):
+    def _latest_revision(self, ud, d, name):
         """
         Return the latest upstream revision number
         """
@@ -180,12 +180,12 @@ class Svn(FetchMethod):
 
         return revision
 
-    def sortable_revision(self, url, ud, d, name):
+    def sortable_revision(self, ud, d, name):
         """
         Return a sortable revision number which in our case is the revision number
         """
 
-        return False, self._build_revision(url, ud, d)
+        return False, self._build_revision(ud, d)
 
-    def _build_revision(self, url, ud, d):
+    def _build_revision(self, ud, d):
         return ud.revision
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 131016c..0073201 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -37,7 +37,7 @@ from   bb.fetch2 import runfetchcmd
 
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
-    def supports(self, url, ud, d):
+    def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with wget.
         """
@@ -58,7 +58,7 @@ class Wget(FetchMethod):
 
         ud.localfile = data.expand(urllib.unquote(ud.basename), d)
 
-    def download(self, uri, ud, d, checkonly = False):
+    def download(self, ud, d, checkonly = False):
         """Fetch urls"""
 
         basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
@@ -76,7 +76,7 @@ class Wget(FetchMethod):
         else:
             fetchcmd = d.getVar("FETCHCOMMAND_wget", True) or d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
 
-        uri = uri.split(";")[0]
+        uri = ud.url.split(";")[0]
 
         fetchcmd = fetchcmd.replace("${URI}", uri.split(";")[0])
         fetchcmd = fetchcmd.replace("${FILE}", ud.basename)
@@ -93,5 +93,5 @@ class Wget(FetchMethod):
 
         return True
 
-    def checkstatus(self, uri, ud, d):
-        return self.download(uri, ud, d, True)
+    def checkstatus(self, ud, d):
+        return self.download(ud, d, True)



