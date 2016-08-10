Return-Path: <matt@madison.systems>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id ED342771CE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 17:08:57 +0000 (UTC)
Received: by mail-pf0-f178.google.com with SMTP id y134so17827091pfg.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oK5M9Uz+hY3y5hqxHM3g3+LhlpIy+rrh0qfGuFt/xI4=;
	b=bjNMbtHNI2atn480NWzfcC7SryDb0oFbKQVlL1uZQaxr/erHTpws0UkGBPAir2jMTv
	snZlPQDkwgStZUtNijKYq5CPMCjmY8QtijDctKxZy+Nf0TOtkFReblibc/uaC09hxac0
	J1rVkjM574MGc4DMSH1oryplgheYLzUq9Yp+O8Oj5SiMfCaM+t15NORID6YynwbZWIE3
	h7FBOKkXC3wmbbZdleptm0LtUPgoGPE7tibV+8wG6R9wljNtvdwr17z+Hk3/V4VZXY4u
	bpXejLM5O3h9ENeh8njKkWpUZAbCa95dtWFBuITdanZsC6DVj0NOVD0HnDwtVwdbSRPg
	fVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oK5M9Uz+hY3y5hqxHM3g3+LhlpIy+rrh0qfGuFt/xI4=;
	b=e2wHdXw1o02d826JhrPOLckmjiQOwZkK/GWswdQ3ln/gdl7PYxMNfoZBSO+sT9chAT
	BS/Ue9EKIWpyrBrGebaQhknvqa1buG3qn5iIxZygwmGpe/VzOFR566ObhMBE4Y0LKrqn
	x0Rb2poMWeNsGqkyx109pSxfMy36pqG+OH2+7NKxJFnpK+548tnHw924BGykJ7CvbZYY
	Y3xzGih0kgC0hH/WBjxfXAWfrdk7X//4g1KSYWyxwD0sCXS+cTP7qTLrdGp4LgQunByL
	ArujdwLwimN+H2cWj1d9v7g6o+VD7SliZ94K3dJ3XF5HcvI4urMFoB8tBEdxm5vy3Jcz
	uqSw==
X-Gm-Message-State: AEkooutKL1kvBOdlYIgfB2MtjNV1jRRbiEN6kEmoBglIJygrr7Wn4MycTca9Jvv+22HF5Q==
X-Received: by 10.98.14.72 with SMTP id w69mr8893350pfi.119.1470848937708;
	Wed, 10 Aug 2016 10:08:57 -0700 (PDT)
Received: from localhost.localdomain ([12.30.244.5])
	by smtp.gmail.com with ESMTPSA id
	q26sm65399617pfj.53.2016.08.10.10.08.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 10 Aug 2016 10:08:56 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2016 10:08:16 -0700
Message-Id: <1470848896-23041-2-git-send-email-matt@madison.systems>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1470848896-23041-1-git-send-email-matt@madison.systems>
References: <1470848896-23041-1-git-send-email-matt@madison.systems>
Subject: [PATCH v2] fetch2: preserve current working directory
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
X-List-Received-Date: Wed, 10 Aug 2016 17:08:58 -0000

Fix the methods in all fetchers so they don't change
the current working directory of the calling process, which
could lead to "changed cwd" warnings from bitbake.

Signed-off-by: Matt Madison <matt@madison.systems>
---
 lib/bb/fetch2/__init__.py  | 21 +++++++++++----------
 lib/bb/fetch2/bzr.py       | 11 ++++-------
 lib/bb/fetch2/clearcase.py |  6 ++----
 lib/bb/fetch2/cvs.py       | 15 ++++++++-------
 lib/bb/fetch2/git.py       | 45 ++++++++++++++++++++-------------------------
 lib/bb/fetch2/gitannex.py  | 24 +++++++++++-------------
 lib/bb/fetch2/gitsm.py     | 23 ++++++++++-------------
 lib/bb/fetch2/hg.py        | 28 ++++++++++------------------
 lib/bb/fetch2/npm.py       | 22 +++++++---------------
 lib/bb/fetch2/osc.py       | 10 ++++------
 lib/bb/fetch2/perforce.py  |  6 ++----
 lib/bb/fetch2/repo.py      | 13 ++++++-------
 lib/bb/fetch2/svn.py       | 13 +++++--------
 13 files changed, 100 insertions(+), 137 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9054b2e..7a3eb3c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -779,7 +779,7 @@ def localpath(url, d):
     fetcher = bb.fetch2.Fetch([url], d)
     return fetcher.localpath(url)
 
-def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None):
+def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     """
     Run cmd returning the command output
     Raise an error if interrupted or cmd fails
@@ -821,7 +821,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None):
     error_message = ""
 
     try:
-        (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE)
+        (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir)
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s" % (e.command)
@@ -1436,17 +1436,11 @@ class FetchMethod(object):
         if not cmd:
             return
 
-        # Change to unpackdir before executing command
-        save_cwd = os.getcwd();
-        os.chdir(unpackdir)
-
         path = data.getVar('PATH', True)
         if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
-        bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
-        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
-
-        os.chdir(save_cwd)
+        bb.note("Unpacking %s to %s/" % (file, unpackdir))
+        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir)
 
         if ret != 0:
             raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
@@ -1559,6 +1553,8 @@ class Fetch(object):
         network = self.d.getVar("BB_NO_NETWORK", True)
         premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY", True) == "1")
 
+        save_cwd = os.getcwd()
+
         for u in urls:
             ud = self.ud[u]
             ud.setup_localpath(self.d)
@@ -1633,6 +1629,7 @@ class Fetch(object):
                 raise
 
             finally:
+                os.chdir(save_cwd)
                 if ud.lockfile:
                     bb.utils.unlockfile(lf)
 
@@ -1641,6 +1638,8 @@ class Fetch(object):
         Check all urls exist upstream
         """
 
+        save_cwd = os.getcwd()
+
         if not urls:
             urls = self.urls
 
@@ -1664,6 +1663,8 @@ class Fetch(object):
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
 
+        os.chdir(save_cwd)
+
     def unpack(self, root, urls=None):
         """
         Check all urls exist upstream
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index ce11ee7..72264af 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -88,19 +88,15 @@ class Bzr(FetchMethod):
             bzrcmd = self._buildbzrcommand(ud, d, "update")
             logger.debug(1, "BZR Update %s", ud.url)
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
-            os.chdir(os.path.join (ud.pkgdir, os.path.basename(ud.path)))
-            runfetchcmd(bzrcmd, d)
+            runfetchcmd(bzrcmd, d, workdir=os.path.join(ud.pkgdir, os.path.basename(ud.path)))
         else:
             bb.utils.remove(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir)), True)
             bzrcmd = self._buildbzrcommand(ud, d, "fetch")
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
             logger.debug(1, "BZR Checkout %s", ud.url)
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
             logger.debug(1, "Running %s", bzrcmd)
-            runfetchcmd(bzrcmd, d)
-
-        os.chdir(ud.pkgdir)
+            runfetchcmd(bzrcmd, d, workdir=ud.pkgdir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
@@ -109,7 +105,8 @@ class Bzr(FetchMethod):
             tar_flags = "--exclude='.bzr' --exclude='.bzrtags'"
 
         # tar them up to a defined filename
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(ud.pkgdir)), d, cleanup = [ud.localpath])
+        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(ud.pkgdir)),
+                    d, cleanup=[ud.localpath], workdir=ud.pkgdir)
 
     def supports_srcrev(self):
         return True
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index ba83e7c..70e280a 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -202,11 +202,10 @@ class ClearCase(FetchMethod):
 
     def _remove_view(self, ud, d):
         if os.path.exists(ud.viewdir):
-            os.chdir(ud.ccasedir)
             cmd = self._build_ccase_command(ud, 'rmview');
             logger.info("cleaning up [VOB=%s label=%s view=%s]", ud.vob, ud.label, ud.viewname)
             bb.fetch2.check_network_access(d, cmd, ud.url)
-            output = runfetchcmd(cmd, d)
+            output = runfetchcmd(cmd, d, workdir=ud.ccasedir)
             logger.info("rmview output: %s", output)
 
     def need_update(self, ud, d):
@@ -241,11 +240,10 @@ class ClearCase(FetchMethod):
                 raise e
 
         # Set configspec: Setting the configspec effectively fetches the files as defined in the configspec
-        os.chdir(ud.viewdir)
         cmd = self._build_ccase_command(ud, 'setcs');
         logger.info("fetching data [VOB=%s label=%s view=%s]", ud.vob, ud.label, ud.viewname)
         bb.fetch2.check_network_access(d, cmd, ud.url)
-        output = runfetchcmd(cmd, d)
+        output = runfetchcmd(cmd, d, workdir=ud.viewdir)
         logger.info("%s", output)
 
         # Copy the configspec to the viewdir so we have it in our source tarball later
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 43a234f..5ff70ba 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -123,22 +123,23 @@ class Cvs(FetchMethod):
         pkg = d.getVar('PN', True)
         pkgdir = os.path.join(d.getVar('CVSDIR', True), pkg)
         moddir = os.path.join(pkgdir, localdir)
+        workdir = None
         if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
             logger.info("Update " + ud.url)
             bb.fetch2.check_network_access(d, cvsupdatecmd, ud.url)
             # update sources there
-            os.chdir(moddir)
+            workdir = moddir
             cmd = cvsupdatecmd
         else:
             logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(pkgdir)
-            os.chdir(pkgdir)
+            workdir = pkgdir
             logger.debug(1, "Running %s", cvscmd)
             bb.fetch2.check_network_access(d, cvscmd, ud.url)
             cmd = cvscmd
 
-        runfetchcmd(cmd, d, cleanup = [moddir])
+        runfetchcmd(cmd, d, cleanup=[moddir], workdir=workdir)
 
         if not os.access(moddir, os.R_OK):
             raise FetchError("Directory %s was not readable despite sucessful fetch?!" % moddir, ud.url)
@@ -150,15 +151,15 @@ class Cvs(FetchMethod):
             tar_flags = "--exclude='CVS'"
 
         # tar them up to a defined filename
+        workdir = None
         if 'fullpath' in ud.parm:
-            os.chdir(pkgdir)
+            workdir = pkgdir
             cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, localdir)
         else:
-            os.chdir(moddir)
-            os.chdir('..')
+            workdir = os.path.dirname(os.path.realpath(moddir))
             cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(moddir))
 
-        runfetchcmd(cmd, d, cleanup = [ud.localpath])
+        runfetchcmd(cmd, d, cleanup=[ud.localpath], workdir=workdir)
 
     def clean(self, ud, d):
         """ Clean CVS Files and tarballs """
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4e2dcec..25dbab1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -205,9 +205,8 @@ class Git(FetchMethod):
     def need_update(self, ud, d):
         if not os.path.exists(ud.clonedir):
             return True
-        os.chdir(ud.clonedir)
         for name in ud.names:
-            if not self._contains_ref(ud, d, name):
+            if not self._contains_ref(ud, d, name, ud.clonedir):
                 return True
         if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             return True
@@ -228,8 +227,7 @@ class Git(FetchMethod):
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.clonedir)
-            os.chdir(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
+            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d, workdir=ud.clonedir)
 
         repourl = self._get_repo_url(ud)
 
@@ -244,34 +242,32 @@ class Git(FetchMethod):
             progresshandler = GitProgressHandler(d)
             runfetchcmd(clone_cmd, d, log=progresshandler)
 
-        os.chdir(ud.clonedir)
         # Update the checkout if needed
         needupdate = False
         for name in ud.names:
-            if not self._contains_ref(ud, d, name):
+            if not self._contains_ref(ud, d, name, ud.clonedir):
                 needupdate = True
         if needupdate:
             try: 
-                runfetchcmd("%s remote rm origin" % ud.basecmd, d) 
+                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
             except bb.fetch2.FetchError:
                 logger.debug(1, "No Origin")
 
-            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d)
+            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
             fetch_cmd = "LANG=C %s fetch -f --prune --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-            runfetchcmd(fetch_cmd, d, log=progresshandler)
-            runfetchcmd("%s prune-packed" % ud.basecmd, d)
-            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
+            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
+            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
+            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
             try:
                 os.unlink(ud.fullmirror)
             except OSError as exc:
                 if exc.errno != errno.ENOENT:
                     raise
-        os.chdir(ud.clonedir)
         for name in ud.names:
-            if not self._contains_ref(ud, d, name):
+            if not self._contains_ref(ud, d, name, ud.clonedir):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
@@ -281,10 +277,9 @@ class Git(FetchMethod):
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
 
-            os.chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d, workdir=ud.clonedir)
+            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=ud.clonedir)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
@@ -307,21 +302,21 @@ class Git(FetchMethod):
             cloneflags += " --mirror"
 
         runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, ud.clonedir, destdir), d)
-        os.chdir(destdir)
         repourl = self._get_repo_url(ud)
-        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
+        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
         if not ud.nocheckout:
             if subdir != "":
-                runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d)
-                runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d)
+                runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d,
+                            workdir=destdir)
+                runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d, workdir=destdir)
             elif not ud.nobranch:
                 branchname =  ud.branches[ud.names[0]]
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
-                            ud.revisions[ud.names[0]]), d)
+                            ud.revisions[ud.names[0]]), d, workdir=destdir)
                 runfetchcmd("%s branch --set-upstream %s origin/%s" % (ud.basecmd, branchname, \
-                            branchname), d)
+                            branchname), d, workdir=destdir)
             else:
-                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d)
+                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=destdir)
 
         return True
 
@@ -335,7 +330,7 @@ class Git(FetchMethod):
     def supports_srcrev(self):
         return True
 
-    def _contains_ref(self, ud, d, name):
+    def _contains_ref(self, ud, d, name, wd):
         cmd = ""
         if ud.nobranch:
             cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (
@@ -344,7 +339,7 @@ class Git(FetchMethod):
             cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
                 ud.basecmd, ud.revisions[name], ud.branches[name])
         try:
-            output = runfetchcmd(cmd, d, quiet=True)
+            output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
         except bb.fetch2.FetchError:
             return False
         if len(output.split()) > 1:
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 0f37897..d4e5446 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -34,43 +34,41 @@ class GitANNEX(Git):
         """
         return ud.type in ['gitannex']
 
-    def uses_annex(self, ud, d):
+    def uses_annex(self, ud, d, wd):
         for name in ud.names:
             try:
-                runfetchcmd("%s rev-list git-annex" % (ud.basecmd), d, quiet=True)
+                runfetchcmd("%s rev-list git-annex" % (ud.basecmd), d, quiet=True, workdir=wd)
                 return True
             except bb.fetch.FetchError:
                 pass
 
         return False
 
-    def update_annex(self, ud, d):
+    def update_annex(self, ud, d, wd):
         try:
-            runfetchcmd("%s annex get --all" % (ud.basecmd), d, quiet=True)
+            runfetchcmd("%s annex get --all" % (ud.basecmd), d, quiet=True, workdir=wd)
         except bb.fetch.FetchError:
             return False
-        runfetchcmd("chmod u+w -R %s/annex" % (ud.clonedir), d, quiet=True)
+        runfetchcmd("chmod u+w -R %s/annex" % (ud.clonedir), d, quiet=True, workdir=wd)
 
         return True
 
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-        os.chdir(ud.clonedir)
-        annex = self.uses_annex(ud, d)
+        annex = self.uses_annex(ud, d, ud.clonedir)
         if annex:
-            self.update_annex(ud, d)
+            self.update_annex(ud, d, ud.clonedir)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
 
-        os.chdir(ud.destdir)
         try:
-            runfetchcmd("%s annex sync" % (ud.basecmd), d)
+            runfetchcmd("%s annex sync" % (ud.basecmd), d, workdir=ud.destdir)
         except bb.fetch.FetchError:
             pass
 
-        annex = self.uses_annex(ud, d)
+        annex = self.uses_annex(ud, d, ud.destdir)
         if annex:
-            runfetchcmd("%s annex get" % (ud.basecmd), d)
-            runfetchcmd("chmod u+w -R %s/.git/annex" % (ud.destdir), d, quiet=True)
+            runfetchcmd("%s annex get" % (ud.basecmd), d, workdir=ud.destdir)
+            runfetchcmd("chmod u+w -R %s/.git/annex" % (ud.destdir), d, quiet=True, workdir=ud.destdir)
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 752f1d3..6613762 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -43,10 +43,10 @@ class GitSM(Git):
         """
         return ud.type in ['gitsm']
 
-    def uses_submodules(self, ud, d):
+    def uses_submodules(self, ud, d, wd):
         for name in ud.names:
             try:
-                runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True)
+                runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=wd)
                 return True
             except bb.fetch.FetchError:
                 pass
@@ -107,28 +107,25 @@ class GitSM(Git):
         os.mkdir(tmpclonedir)
         os.rename(ud.clonedir, gitdir)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
-        os.chdir(tmpclonedir)
-        runfetchcmd(ud.basecmd + " reset --hard", d)
-        runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d)
-        runfetchcmd(ud.basecmd + " submodule update --init --recursive", d)
+        runfetchcmd(ud.basecmd + " reset --hard", d, workdir=tmpclonedir)
+        runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=tmpclonedir)
+        runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=tmpclonedir)
         self._set_relative_paths(tmpclonedir)
-        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d)
+        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
         os.rename(gitdir, ud.clonedir,)
         bb.utils.remove(tmpclonedir, True)
 
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-        os.chdir(ud.clonedir)
-        submodules = self.uses_submodules(ud, d)
+        submodules = self.uses_submodules(ud, d, ud.clonedir)
         if submodules:
             self.update_submodules(ud, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
         
-        os.chdir(ud.destdir)
-        submodules = self.uses_submodules(ud, d)
+        submodules = self.uses_submodules(ud, d, ud.destdir)
         if submodules:
-            runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d)
+            runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
+            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 3b743ff..20df801 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -169,25 +169,22 @@ class Hg(FetchMethod):
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.pkgdir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
-            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
+            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d, workdir=ud.pkgdir)
 
         if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
             # Found the source, check whether need pull
             updatecmd = self._buildhgcommand(ud, d, "update")
-            os.chdir(ud.moddir)
             logger.debug(1, "Running %s", updatecmd)
             try:
-                runfetchcmd(updatecmd, d)
+                runfetchcmd(updatecmd, d, workdir=ud.moddir)
             except bb.fetch2.FetchError:
                 # Runnning pull in the repo
                 pullcmd = self._buildhgcommand(ud, d, "pull")
                 logger.info("Pulling " + ud.url)
                 # update sources there
-                os.chdir(ud.moddir)
                 logger.debug(1, "Running %s", pullcmd)
                 bb.fetch2.check_network_access(d, pullcmd, ud.url)
-                runfetchcmd(pullcmd, d)
+                runfetchcmd(pullcmd, d, workdir=ud.moddir)
                 try:
                     os.unlink(ud.fullmirror)
                 except OSError as exc:
@@ -200,17 +197,15 @@ class Hg(FetchMethod):
             logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
             logger.debug(1, "Running %s", fetchcmd)
             bb.fetch2.check_network_access(d, fetchcmd, ud.url)
-            runfetchcmd(fetchcmd, d)
+            runfetchcmd(fetchcmd, d, workdir=ud.pkgdir)
 
         # Even when we clone (fetch), we still need to update as hg's clone
         # won't checkout the specified revision if its on a branch
         updatecmd = self._buildhgcommand(ud, d, "update")
-        os.chdir(ud.moddir)
         logger.debug(1, "Running %s", updatecmd)
-        runfetchcmd(updatecmd, d)
+        runfetchcmd(updatecmd, d, workdir=ud.moddir)
 
     def clean(self, ud, d):
         """ Clean the hg dir """
@@ -246,10 +241,9 @@ class Hg(FetchMethod):
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
 
-            os.chdir(ud.pkgdir)
             logger.info("Creating tarball of hg repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, ud.module), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, ud.module), d, workdir=ud.pkgdir)
+            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=ud.pkgdir)
 
     def localpath(self, ud, d):
         return ud.pkgdir
@@ -269,10 +263,8 @@ class Hg(FetchMethod):
                 logger.debug(2, "Unpack: creating new hg repository in '" + codir + "'")
                 runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
             logger.debug(2, "Unpack: updating source in '" + codir + "'")
-            os.chdir(codir)
-            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d)
-            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d)
+            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
+            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
         else:
             logger.debug(2, "Unpack: extracting source to '" + codir + "'")
-            os.chdir(ud.moddir)
-            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d)
+            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d, workdir=ud.moddir)
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 2fd4303..b26ac22 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -113,16 +113,13 @@ class Npm(FetchMethod):
             bb.fatal("NPM package %s downloaded not a tarball!" % file)
 
         # Change to subdir before executing command
-        save_cwd = os.getcwd()
         if not os.path.exists(destdir):
             os.makedirs(destdir)
-        os.chdir(destdir)
         path = d.getVar('PATH', True)
         if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
-        bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
-        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
-        os.chdir(save_cwd)
+        bb.note("Unpacking %s to %s/" % (file, destdir))
+        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=destdir)
 
         if ret != 0:
             raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
@@ -239,10 +236,7 @@ class Npm(FetchMethod):
         if not os.listdir(ud.pkgdatadir) and os.path.exists(ud.fullmirror):
             dest = d.getVar("DL_DIR", True)
             bb.utils.mkdirhier(dest)
-            save_cwd = os.getcwd()
-            os.chdir(dest)
-            runfetchcmd("tar -xJf %s" % (ud.fullmirror), d)
-            os.chdir(save_cwd)
+            runfetchcmd("tar -xJf %s" % (ud.fullmirror), d, workdir=dest)
             return
 
         shwrf = d.getVar('NPM_SHRINKWRAP', True)
@@ -275,10 +269,8 @@ class Npm(FetchMethod):
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
 
-            save_cwd = os.getcwd()
-            os.chdir(d.getVar("DL_DIR", True))
+            dldir = d.getVar("DL_DIR", True)
             logger.info("Creating tarball of npm data")
-            runfetchcmd("tar -cJf %s npm/%s npm/%s" % (ud.fullmirror, ud.bbnpmmanifest, ud.pkgname), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
-            os.chdir(save_cwd)
-
+            runfetchcmd("tar -cJf %s npm/%s npm/%s" % (ud.fullmirror, ud.bbnpmmanifest, ud.pkgname), d,
+                        workdir=dldir)
+            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=dldir)
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index d051dfd..295abf9 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -88,23 +88,21 @@ class Osc(FetchMethod):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ ud.url)
             # update sources there
-            os.chdir(ud.moddir)
             logger.debug(1, "Running %s", oscupdatecmd)
             bb.fetch2.check_network_access(d, oscupdatecmd, ud.url)
-            runfetchcmd(oscupdatecmd, d)
+            runfetchcmd(oscupdatecmd, d, workdir=ud.moddir)
         else:
             oscfetchcmd = self._buildosccommand(ud, d, "fetch")
             logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
             logger.debug(1, "Running %s", oscfetchcmd)
             bb.fetch2.check_network_access(d, oscfetchcmd, ud.url)
-            runfetchcmd(oscfetchcmd, d)
+            runfetchcmd(oscfetchcmd, d, workdir=ud.pkgdir)
 
-        os.chdir(os.path.join(ud.pkgdir + ud.path))
         # tar them up to a defined filename
-        runfetchcmd("tar -czf %s %s" % (ud.localpath, ud.module), d, cleanup = [ud.localpath])
+        runfetchcmd("tar -czf %s %s" % (ud.localpath, ud.module), d,
+                    cleanup=[ud.localpath], workdir=os.path.join(ud.pkgdir + ud.path))
 
     def supports_srcrev(self):
         return False
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index b8169f2..50cb479 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -168,15 +168,13 @@ class Perforce(FetchMethod):
 
         bb.utils.remove(ud.pkgdir, True)
         bb.utils.mkdirhier(ud.pkgdir)
-        os.chdir(ud.pkgdir)
 
         for afile in filelist:
             p4fetchcmd = self._buildp4command(ud, d, 'print', afile)
             bb.fetch2.check_network_access(d, p4fetchcmd)
-            runfetchcmd(p4fetchcmd, d)
+            runfetchcmd(p4fetchcmd, d, workdir=ud.pkgdir)
 
-        os.chdir(ud.pkgdir)
-        runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup = [ud.localpath])
+        runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup=[ud.localpath], workdir=ud.pkgdir)
 
     def clean(self, ud, d):
         """ Cleanup p4 specific files and dirs"""
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fd64b7e..ecc6e68 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -69,15 +69,14 @@ class Repo(FetchMethod):
         else:
             username = ""
 
-        bb.utils.mkdirhier(os.path.join(codir, "repo"))
-        os.chdir(os.path.join(codir, "repo"))
-        if not os.path.exists(os.path.join(codir, "repo", ".repo")):
+        repodir = os.path.join(codir, "repo")
+        bb.utils.mkdirhier(repodir)
+        if not os.path.exists(os.path.join(repodir, ".repo")):
             bb.fetch2.check_network_access(d, "repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
-            runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d)
+            runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
 
         bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
-        runfetchcmd("repo sync", d)
-        os.chdir(codir)
+        runfetchcmd("repo sync", d, workdir=repodir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
@@ -86,7 +85,7 @@ class Repo(FetchMethod):
             tar_flags = "--exclude='.repo' --exclude='.git'"
 
         # Create a cache
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d)
+        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d, workdir=codir)
 
     def supports_srcrev(self):
         return False
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 968ca79..9ff9410 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -126,25 +126,22 @@ class Svn(FetchMethod):
         if os.access(os.path.join(ud.moddir, '.svn'), os.R_OK):
             svnupdatecmd = self._buildsvncommand(ud, d, "update")
             logger.info("Update " + ud.url)
-            # update sources there
-            os.chdir(ud.moddir)
             # We need to attempt to run svn upgrade first in case its an older working format
             try:
-                runfetchcmd(ud.basecmd + " upgrade", d)
+                runfetchcmd(ud.basecmd + " upgrade", d, workdir=ud.moddir)
             except FetchError:
                 pass
             logger.debug(1, "Running %s", svnupdatecmd)
             bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)
-            runfetchcmd(svnupdatecmd, d)
+            runfetchcmd(svnupdatecmd, d, workdir=ud.moddir)
         else:
             svnfetchcmd = self._buildsvncommand(ud, d, "fetch")
             logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
             logger.debug(1, "Running %s", svnfetchcmd)
             bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
-            runfetchcmd(svnfetchcmd, d)
+            runfetchcmd(svnfetchcmd, d, ud.pkgdir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
@@ -152,9 +149,9 @@ class Svn(FetchMethod):
         else:
             tar_flags = "--exclude='.svn'"
 
-        os.chdir(ud.pkgdir)
         # tar them up to a defined filename
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.path_spec), d, cleanup = [ud.localpath])
+        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.path_spec), d,
+                    cleanup=[ud.localpath], workdir=ud.pkgdir)
 
     def clean(self, ud, d):
         """ Clean SVN specific files and dirs """
-- 
2.7.4


