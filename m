Received: from gandharva.secretlabs.de ([78.46.147.237])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <holger@freyther.de>) id 1Qcehb-0006pn-G1
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 16:28:15 +0200
Received: from [192.168.0.101] (91-64-95-94-dynip.superkabel.de [91.64.95.94])
	by gandharva.secretlabs.de (Postfix) with ESMTPSA id 91B4F1B10C03;
	Fri,  1 Jul 2011 14:26:07 +0000 (UTC)
Message-ID: <4E0DD729.3090301@freyther.de>
Date: Fri, 01 Jul 2011 16:18:17 +0200
From: Holger Hans Peter Freyther <holger@freyther.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: poky@yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <4E0DC212.5020808@freyther.de>
In-Reply-To: <4E0DC212.5020808@freyther.de>
X-Enigmail-Version: 1.1.1
X-Mailman-Approved-At: Sat, 02 Jul 2011 01:11:43 +0200
Subject: Re: [poky] Installing GDB or the saga of getting RPM/Zypp to run on	JFFS2
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
X-List-Received-Date: Fri, 01 Jul 2011 14:28:15 -0000
X-Groupsio-MsgNum: 126
Content-Type: multipart/mixed; boundary="------------080209030704080803080206"

--------------080209030704080803080206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/01/2011 02:48 PM, Holger Hans Peter Freyther wrote:
> Hi,

> 
> a) I CTRL+C'ed the build once and later I noticed that my poky repo had
> the git origin changed. I think bitbake should check the result of the
> os.chdir... I will prepare a patch for that...

Okay, I am doing an oe-core build using this patch right now. Any comments?

holger

--------------080209030704080803080206
Content-Type: text/x-patch;
 name="0001-misc-Replace-os.chdir-with-bb.utils.checked_chdir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-misc-Replace-os.chdir-with-bb.utils.checked_chdir.patch"

From 89e38923bdc01f2ef3f5ea81e5fd435e416b2ba6 Mon Sep 17 00:00:00 2001
From: Holger Hans Peter Freyther <zecke@selfish.org>
Date: Fri, 1 Jul 2011 22:12:52 +0800
Subject: [PATCH] misc: Replace os.chdir with bb.utils.checked_chdir

The Python os.chdir does not return the status, in some
rare condition it seems possible that a Keyboard interrupt
can interrupt the chdir and continue with the execution from
the wrong directory. Introduce the bb.utils.checked_chdir
to verify the chdir operation.

The users in bitbake of chdir are a bit sloppy, it is possible
that someone is using a relative directory, uses a trailing
slash or double slashes (e.g. license-destdir//).
---
 lib/bb/build.py           |    4 ++--
 lib/bb/cache.py           |    4 ++--
 lib/bb/fetch/bzr.py       |    6 +++---
 lib/bb/fetch/cvs.py       |   10 +++++-----
 lib/bb/fetch/git.py       |   18 +++++++++---------
 lib/bb/fetch/hg.py        |    8 ++++----
 lib/bb/fetch/osc.py       |    6 +++---
 lib/bb/fetch/perforce.py  |    2 +-
 lib/bb/fetch/repo.py      |    4 ++--
 lib/bb/fetch/svk.py       |    4 ++--
 lib/bb/fetch/svn.py       |    6 +++---
 lib/bb/fetch2/__init__.py |    6 +++---
 lib/bb/fetch2/bzr.py      |    6 +++---
 lib/bb/fetch2/cvs.py      |   10 +++++-----
 lib/bb/fetch2/git.py      |   14 +++++++-------
 lib/bb/fetch2/hg.py       |    8 ++++----
 lib/bb/fetch2/osc.py      |    6 +++---
 lib/bb/fetch2/perforce.py |    2 +-
 lib/bb/fetch2/repo.py     |    4 ++--
 lib/bb/fetch2/svk.py      |    4 ++--
 lib/bb/fetch2/svn.py      |    6 +++---
 lib/bb/pysh/builtin.py    |    4 ++--
 lib/bb/pysh/interp.py     |    4 ++--
 lib/bb/utils.py           |   17 +++++++++++++++++
 24 files changed, 90 insertions(+), 73 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 1c73ae2..0980e7a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -191,7 +191,7 @@ def exec_func_python(func, d, runfile, cwd=None):
             olddir = os.getcwd()
         except OSError:
             olddir = None
-        os.chdir(cwd)
+        bb.utils.checked_chdir(cwd)
 
     try:
         comp = utils.better_compile(code, func, bbfile)
@@ -204,7 +204,7 @@ def exec_func_python(func, d, runfile, cwd=None):
     finally:
         if cwd and olddir:
             try:
-                os.chdir(olddir)
+                bb.utils.checked_chdir(olddir)
             except OSError:
                 pass
 
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 99d7395..81d24ab 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -657,11 +657,11 @@ class Cache(object):
                 data.setVar('__BBAPPEND', " ".join(appends), bb_data)
             bb_data = parse.handle(bbfile, bb_data)
             if chdir_back:
-                os.chdir(oldpath)
+                bb.utils.checked_chdir(oldpath)
             return bb_data
         except:
             if chdir_back:
-                os.chdir(oldpath)
+                bb.utils.checked_chdir(oldpath)
             raise
 
 
diff --git a/lib/bb/fetch/bzr.py b/lib/bb/fetch/bzr.py
index 85a9294..9774c65 100644
--- a/lib/bb/fetch/bzr.py
+++ b/lib/bb/fetch/bzr.py
@@ -88,18 +88,18 @@ class Bzr(Fetch):
         if os.access(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir), '.bzr'), os.R_OK):
             bzrcmd = self._buildbzrcommand(ud, d, "update")
             logger.debug(1, "BZR Update %s", loc)
-            os.chdir(os.path.join (ud.pkgdir, os.path.basename(ud.path)))
+            bb.utils.checked_chdir(os.path.join (ud.pkgdir, os.path.basename(ud.path)))
             runfetchcmd(bzrcmd, d)
         else:
             bb.utils.remove(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir)), True)
             bzrcmd = self._buildbzrcommand(ud, d, "fetch")
             logger.debug(1, "BZR Checkout %s", loc)
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", bzrcmd)
             runfetchcmd(bzrcmd, d)
 
-        os.chdir(ud.pkgdir)
+        bb.utils.checked_chdir(ud.pkgdir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
diff --git a/lib/bb/fetch/cvs.py b/lib/bb/fetch/cvs.py
index 64450af..9f9f2fd 100644
--- a/lib/bb/fetch/cvs.py
+++ b/lib/bb/fetch/cvs.py
@@ -132,13 +132,13 @@ class Cvs(Fetch):
         if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
             logger.info("Update " + loc)
             # update sources there
-            os.chdir(moddir)
+            bb.utils.checked_chdir(moddir)
             myret = os.system(cvsupdatecmd)
         else:
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(pkgdir)
-            os.chdir(pkgdir)
+            bb.utils.checked_chdir(pkgdir)
             logger.debug(1, "Running %s", cvscmd)
             myret = os.system(cvscmd)
 
@@ -157,11 +157,11 @@ class Cvs(Fetch):
 
         # tar them up to a defined filename
         if 'fullpath' in ud.parm:
-            os.chdir(pkgdir)
+            bb.utils.checked_chdir(pkgdir)
             myret = os.system("tar %s -czf %s %s" % (tar_flags, ud.localpath, localdir))
         else:
-            os.chdir(moddir)
-            os.chdir('..')
+            bb.utils.checked_chdir(moddir)
+            bb.utils.checked_chdir('..')
             myret = os.system("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(moddir)))
 
         if myret != 0:
diff --git a/lib/bb/fetch/git.py b/lib/bb/fetch/git.py
index 49c1cfe..0c1f170 100644
--- a/lib/bb/fetch/git.py
+++ b/lib/bb/fetch/git.py
@@ -132,14 +132,14 @@ class Git(Fetch):
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.clonedir) and os.path.exists(repofile):
             bb.utils.mkdirhier(ud.clonedir)
-            os.chdir(ud.clonedir)
+            bb.utils.checked_chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (repofile), d)
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
             runfetchcmd("%s clone -n %s://%s%s%s %s" % (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.clonedir), d)
 
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         # Update the checkout if needed
         if not self._contains_ref(ud.tag, d) or 'fullclone' in ud.parm:
             # Remove all but the .git directory
@@ -153,7 +153,7 @@ class Git(Fetch):
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
 
         # Generate a mirror tarball if needed
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         mirror_tarballs = data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True)
         if mirror_tarballs != "0" or 'fullclone' in ud.parm:
             logger.info("Creating tarball of git repository")
@@ -185,19 +185,19 @@ class Git(Fetch):
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
             runfetchcmd("%s clone -n %s %s" % (ud.basecmd, ud.clonedir, coprefix), d)
-            os.chdir(coprefix)
+            bb.utils.checked_chdir(coprefix)
             runfetchcmd("%s checkout -q -f %s%s" % (ud.basecmd, ud.tag, readpathspec), d)
         else:
             bb.utils.mkdirhier(codir)
-            os.chdir(ud.clonedir)
+            bb.utils.checked_chdir(ud.clonedir)
             runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.tag, readpathspec), d)
             runfetchcmd("%s checkout-index -q -f --prefix=%s -a" % (ud.basecmd, coprefix), d)
 
-        os.chdir(codir)
+        bb.utils.checked_chdir(codir)
         logger.info("Creating tarball of git checkout")
         runfetchcmd("tar -czf %s %s" % (ud.localpath, os.path.join(".", "*") ), d)
 
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         bb.utils.prunedir(codir)
 
     def supports_srcrev(self):
@@ -327,12 +327,12 @@ class Git(Fetch):
                 return None
 
 
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         if not self._contains_ref(rev, d):
             self.go(None, ud, d)
 
         output = runfetchcmd("%s rev-list %s -- 2> /dev/null | wc -l" % (ud.basecmd, rev), d, quiet=True)
-        os.chdir(cwd)
+        bb.utils.checked_chdir(cwd)
 
         buildindex = "%s" % output.split()[0]
         logger.debug(1, "GIT repository for %s in %s is returning %s revisions in rev-list before %s", url, ud.clonedir, buildindex, rev)
diff --git a/lib/bb/fetch/hg.py b/lib/bb/fetch/hg.py
index 2b3aec5..84a94b5 100644
--- a/lib/bb/fetch/hg.py
+++ b/lib/bb/fetch/hg.py
@@ -123,7 +123,7 @@ class Hg(Fetch):
             updatecmd = self._buildhgcommand(ud, d, "pull")
             logger.info("Update " + loc)
             # update sources there
-            os.chdir(ud.moddir)
+            bb.utils.checked_chdir(ud.moddir)
             logger.debug(1, "Running %s", updatecmd)
             runfetchcmd(updatecmd, d)
 
@@ -132,14 +132,14 @@ class Hg(Fetch):
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", fetchcmd)
             runfetchcmd(fetchcmd, d)
 
         # Even when we clone (fetch), we still need to update as hg's clone
         # won't checkout the specified revision if its on a branch
         updatecmd = self._buildhgcommand(ud, d, "update")
-        os.chdir(ud.moddir)
+        bb.utils.checked_chdir(ud.moddir)
         logger.debug(1, "Running %s", updatecmd)
         runfetchcmd(updatecmd, d)
 
@@ -149,7 +149,7 @@ class Hg(Fetch):
         else:
             tar_flags = "--exclude '.hg' --exclude '.hgrags'"
 
-        os.chdir(ud.pkgdir)
+        bb.utils.checked_chdir(ud.pkgdir)
         try:
             runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d)
         except:
diff --git a/lib/bb/fetch/osc.py b/lib/bb/fetch/osc.py
index 32237b9..3a69846 100644
--- a/lib/bb/fetch/osc.py
+++ b/lib/bb/fetch/osc.py
@@ -91,7 +91,7 @@ class Osc(Fetch):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ loc)
             # update sources there
-            os.chdir(ud.moddir)
+            bb.utils.checked_chdir(ud.moddir)
             logger.debug(1, "Running %s", oscupdatecmd)
             runfetchcmd(oscupdatecmd, d)
         else:
@@ -99,11 +99,11 @@ class Osc(Fetch):
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", oscfetchcmd)
             runfetchcmd(oscfetchcmd, d)
 
-        os.chdir(os.path.join(ud.pkgdir + ud.path))
+        bb.utils.checked_chdir(os.path.join(ud.pkgdir + ud.path))
         # tar them up to a defined filename
         try:
             runfetchcmd("tar -czf %s %s" % (ud.localpath, ud.module), d)
diff --git a/lib/bb/fetch/perforce.py b/lib/bb/fetch/perforce.py
index e933d27..b1e79ce 100644
--- a/lib/bb/fetch/perforce.py
+++ b/lib/bb/fetch/perforce.py
@@ -168,7 +168,7 @@ class Perforce(Fetch):
             cset = Perforce.getcset(d, depot, host, user, pswd, parm)
             depot = "%s@%s" % (depot, cset)
 
-        os.chdir(tmpfile)
+        bb.utils.checked_chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
         p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
diff --git a/lib/bb/fetch/repo.py b/lib/bb/fetch/repo.py
index 512fffb..cda36bf 100644
--- a/lib/bb/fetch/repo.py
+++ b/lib/bb/fetch/repo.py
@@ -72,12 +72,12 @@ class Repo(Fetch):
             username = ""
 
         bb.utils.mkdirhier(os.path.join(codir, "repo"))
-        os.chdir(os.path.join(codir, "repo"))
+        bb.utils.checked_chdir(os.path.join(codir, "repo"))
         if not os.path.exists(os.path.join(codir, "repo", ".repo")):
             runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d)
 
         runfetchcmd("repo sync", d)
-        os.chdir(codir)
+        bb.utils.checked_chdir(codir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
diff --git a/lib/bb/fetch/svk.py b/lib/bb/fetch/svk.py
index dc818d2..d67ae16 100644
--- a/lib/bb/fetch/svk.py
+++ b/lib/bb/fetch/svk.py
@@ -80,7 +80,7 @@ class Svk(Fetch):
             raise FetchError(ud.module)
 
         # check out sources there
-        os.chdir(tmpfile)
+        bb.utils.checked_chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.debug(1, "Running %s", svkcmd)
         myret = os.system(svkcmd)
@@ -91,7 +91,7 @@ class Svk(Fetch):
                 pass
             raise FetchError(ud.module)
 
-        os.chdir(os.path.join(tmpfile, os.path.dirname(ud.module)))
+        bb.utils.checked_chdir(os.path.join(tmpfile, os.path.dirname(ud.module)))
         # tar them up to a defined filename
         myret = os.system("tar -czf %s %s" % (ud.localpath, os.path.basename(ud.module)))
         if myret != 0:
diff --git a/lib/bb/fetch/svn.py b/lib/bb/fetch/svn.py
index 6c2a118..25c13a4 100644
--- a/lib/bb/fetch/svn.py
+++ b/lib/bb/fetch/svn.py
@@ -139,7 +139,7 @@ class Svn(Fetch):
             svnupdatecmd = self._buildsvncommand(ud, d, "update")
             logger.info("Update " + loc)
             # update sources there
-            os.chdir(ud.moddir)
+            bb.utils.checked_chdir(ud.moddir)
             logger.debug(1, "Running %s", svnupdatecmd)
             runfetchcmd(svnupdatecmd, d)
         else:
@@ -147,7 +147,7 @@ class Svn(Fetch):
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", svnfetchcmd)
             runfetchcmd(svnfetchcmd, d)
 
@@ -157,7 +157,7 @@ class Svn(Fetch):
         else:
             tar_flags = "--exclude '.svn'"
 
-        os.chdir(ud.pkgdir)
+        bb.utils.checked_chdir(ud.pkgdir)
         # tar them up to a defined filename
         try:
             runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e9a64c5..e325f6e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -739,17 +739,17 @@ class FetchMethod(object):
 
         # Change to subdir before executing command
         save_cwd = os.getcwd();
-        os.chdir(rootdir)
+        bb.utils.checked_chdir(rootdir)
         if 'subdir' in urldata.parm:
             newdir = ("%s/%s" % (rootdir, urldata.parm.get('subdir')))
             bb.utils.mkdirhier(newdir)
-            os.chdir(newdir)
+            bb.utils.checked_chdir(newdir)
 
         cmd = "PATH=\"%s\" %s" % (bb.data.getVar('PATH', data, True), cmd)
         bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
         ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
 
-        os.chdir(save_cwd)
+        bb.utils.checked_chdir(save_cwd)
 
         if ret != 0:
             raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 0d10eb4..404d004 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -88,7 +88,7 @@ class Bzr(FetchMethod):
             bzrcmd = self._buildbzrcommand(ud, d, "update")
             logger.debug(1, "BZR Update %s", loc)
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
-            os.chdir(os.path.join (ud.pkgdir, os.path.basename(ud.path)))
+            bb.utils.checked_chdir(os.path.join (ud.pkgdir, os.path.basename(ud.path)))
             runfetchcmd(bzrcmd, d)
         else:
             bb.utils.remove(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir)), True)
@@ -96,11 +96,11 @@ class Bzr(FetchMethod):
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
             logger.debug(1, "BZR Checkout %s", loc)
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", bzrcmd)
             runfetchcmd(bzrcmd, d)
 
-        os.chdir(ud.pkgdir)
+        bb.utils.checked_chdir(ud.pkgdir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index a111467..0710b32 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -134,13 +134,13 @@ class Cvs(FetchMethod):
             logger.info("Update " + loc)
             bb.fetch2.check_network_access(d, cvsupdatecmd, ud.url)
             # update sources there
-            os.chdir(moddir)
+            bb.utils.checked_chdir(moddir)
             cmd = cvsupdatecmd
         else:
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(pkgdir)
-            os.chdir(pkgdir)
+            bb.utils.checked_chdir(pkgdir)
             logger.debug(1, "Running %s", cvscmd)
             bb.fetch2.check_network_access(d, cvscmd, ud.url)
             cmd = cvscmd
@@ -158,11 +158,11 @@ class Cvs(FetchMethod):
 
         # tar them up to a defined filename
         if 'fullpath' in ud.parm:
-            os.chdir(pkgdir)
+            bb.utils.checked_chdir(pkgdir)
             cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, localdir)
         else:
-            os.chdir(moddir)
-            os.chdir('..')
+            bb.utils.checked_chdir(moddir)
+            bb.utils.checked_chdir('..')
             cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(moddir))
 
         runfetchcmd(cmd, d, cleanup = [ud.localpath])
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 534c87d..d4f841b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -135,7 +135,7 @@ class Git(FetchMethod):
     def need_update(self, u, ud, d):
         if not os.path.exists(ud.clonedir):
             return True
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         for name in ud.names:
             if not self._contains_ref(ud.revisions[name], d):
                 return True
@@ -165,7 +165,7 @@ class Git(FetchMethod):
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.clonedir)
-            os.chdir(ud.clonedir)
+            bb.utils.checked_chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
 
         # If the repo still doesn't exist, fallback to cloning it
@@ -175,7 +175,7 @@ class Git(FetchMethod):
             bb.fetch2.check_network_access(d, clone_cmd)
             runfetchcmd(clone_cmd, d)
 
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         # Update the checkout if needed
         needupdate = False
         for name in ud.names:
@@ -199,7 +199,7 @@ class Git(FetchMethod):
     def build_mirror_data(self, url, ud, d):
         # Generate a mirror tarball if needed
         if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
-            os.chdir(ud.clonedir)
+            bb.utils.checked_chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
             runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
 
@@ -219,7 +219,7 @@ class Git(FetchMethod):
 
         runfetchcmd("git clone -s -n %s %s" % (ud.clonedir, destdir), d)
         if not ud.nocheckout:
-            os.chdir(destdir)
+            bb.utils.checked_chdir(destdir)
             if subdir != "":
                 runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d)
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d)
@@ -289,12 +289,12 @@ class Git(FetchMethod):
                 return None
 
 
-        os.chdir(ud.clonedir)
+        bb.utils.checked_chdir(ud.clonedir)
         if not self._contains_ref(rev, d):
             self.download(None, ud, d)
 
         output = runfetchcmd("%s rev-list %s -- 2> /dev/null | wc -l" % (ud.basecmd, rev), d, quiet=True)
-        os.chdir(cwd)
+        bb.utils.checked_chdir(cwd)
 
         buildindex = "%s" % output.split()[0]
         logger.debug(1, "GIT repository for %s in %s is returning %s revisions in rev-list before %s", url, ud.clonedir, buildindex, rev)
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 793831a..f8a3b1e 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -124,7 +124,7 @@ class Hg(FetchMethod):
             updatecmd = self._buildhgcommand(ud, d, "pull")
             logger.info("Update " + loc)
             # update sources there
-            os.chdir(ud.moddir)
+            bb.utils.checked_chdir(ud.moddir)
             logger.debug(1, "Running %s", updatecmd)
             bb.fetch2.check_network_access(d, updatecmd, ud.url)
             runfetchcmd(updatecmd, d)
@@ -134,7 +134,7 @@ class Hg(FetchMethod):
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", fetchcmd)
             bb.fetch2.check_network_access(d, fetchcmd, ud.url)
             runfetchcmd(fetchcmd, d)
@@ -142,7 +142,7 @@ class Hg(FetchMethod):
         # Even when we clone (fetch), we still need to update as hg's clone
         # won't checkout the specified revision if its on a branch
         updatecmd = self._buildhgcommand(ud, d, "update")
-        os.chdir(ud.moddir)
+        bb.utils.checked_chdir(ud.moddir)
         logger.debug(1, "Running %s", updatecmd)
         runfetchcmd(updatecmd, d)
 
@@ -152,7 +152,7 @@ class Hg(FetchMethod):
         else:
             tar_flags = "--exclude '.hg' --exclude '.hgrags'"
 
-        os.chdir(ud.pkgdir)
+        bb.utils.checked_chdir(ud.pkgdir)
         runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d, cleanup = [ud.localpath])
 
     def supports_srcrev(self):
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index a16a53e..1e22ca9 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -88,7 +88,7 @@ class Osc(FetchMethod):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ loc)
             # update sources there
-            os.chdir(ud.moddir)
+            bb.utils.checked_chdir(ud.moddir)
             logger.debug(1, "Running %s", oscupdatecmd)
             bb.fetch2.check_network_access(d, oscupdatecmd, ud.url)
             runfetchcmd(oscupdatecmd, d)
@@ -97,12 +97,12 @@ class Osc(FetchMethod):
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", oscfetchcmd)
             bb.fetch2.check_network_access(d, oscfetchcmd, ud.url)
             runfetchcmd(oscfetchcmd, d)
 
-        os.chdir(os.path.join(ud.pkgdir + ud.path))
+        bb.utils.checked_chdir(os.path.join(ud.pkgdir + ud.path))
         # tar them up to a defined filename
         runfetchcmd("tar -czf %s %s" % (ud.localpath, ud.module), d, cleanup = [ud.localpath])
 
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index cbdc848..bb13594 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -165,7 +165,7 @@ class Perforce(FetchMethod):
             cset = Perforce.getcset(d, depot, host, user, pswd, parm)
             depot = "%s@%s" % (depot, cset)
 
-        os.chdir(tmpfile)
+        bb.utils.checked_chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.info("%s%s files %s", p4cmd, p4opt, depot)
         p4file = os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 8300da8..e267917 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -70,14 +70,14 @@ class Repo(FetchMethod):
             username = ""
 
         bb.utils.mkdirhier(os.path.join(codir, "repo"))
-        os.chdir(os.path.join(codir, "repo"))
+        bb.utils.checked_chdir(os.path.join(codir, "repo"))
         if not os.path.exists(os.path.join(codir, "repo", ".repo")):
             bb.fetch2.check_network_access(d, "repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
             runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d)
 
         bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
         runfetchcmd("repo sync", d)
-        os.chdir(codir)
+        bb.utils.checked_chdir(codir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
diff --git a/lib/bb/fetch2/svk.py b/lib/bb/fetch2/svk.py
index 9d34abf..a2fb864 100644
--- a/lib/bb/fetch2/svk.py
+++ b/lib/bb/fetch2/svk.py
@@ -84,12 +84,12 @@ class Svk(FetchMethod):
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", loc)
 
         # check out sources there
-        os.chdir(tmpfile)
+        bb.utils.checked_chdir(tmpfile)
         logger.info("Fetch " + loc)
         logger.debug(1, "Running %s", svkcmd)
         runfetchcmd(svkcmd, d, cleanup = [tmpfile])
 
-        os.chdir(os.path.join(tmpfile, os.path.dirname(ud.module)))
+        bb.utils.checked_chdir(os.path.join(tmpfile, os.path.dirname(ud.module)))
         # tar them up to a defined filename
         runfetchcmd("tar -czf %s %s" % (ud.localpath, os.path.basename(ud.module)), d, cleanup = [ud.localpath])
 
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 59d7ccb..0bc5203 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -116,7 +116,7 @@ class Svn(FetchMethod):
             svnupdatecmd = self._buildsvncommand(ud, d, "update")
             logger.info("Update " + loc)
             # update sources there
-            os.chdir(ud.moddir)
+            bb.utils.checked_chdir(ud.moddir)
             logger.debug(1, "Running %s", svnupdatecmd)
             bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)
             runfetchcmd(svnupdatecmd, d)
@@ -125,7 +125,7 @@ class Svn(FetchMethod):
             logger.info("Fetch " + loc)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            os.chdir(ud.pkgdir)
+            bb.utils.checked_chdir(ud.pkgdir)
             logger.debug(1, "Running %s", svnfetchcmd)
             bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
             runfetchcmd(svnfetchcmd, d)
@@ -136,7 +136,7 @@ class Svn(FetchMethod):
         else:
             tar_flags = "--exclude '.svn'"
 
-        os.chdir(ud.pkgdir)
+        bb.utils.checked_chdir(ud.pkgdir)
         # tar them up to a defined filename
         runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d, cleanup = [ud.localpath])
 
diff --git a/lib/bb/pysh/builtin.py b/lib/bb/pysh/builtin.py
index b748e4a..693becf 100644
--- a/lib/bb/pysh/builtin.py
+++ b/lib/bb/pysh/builtin.py
@@ -581,11 +581,11 @@ def utility_sort(name, args, interp, env, stdin, stdout, stderr, debugflags):
     # Load all files lines
     curdir = os.getcwd()
     try:
-        os.chdir(env['PWD'])
+        bb.utils.checked_chdir(env['PWD'])
         for path in args:
             alllines += sort(path)
     finally:
-        os.chdir(curdir)
+        bb.utils.checked_chdir(curdir)
             
     alllines.sort()
     for line in alllines:
diff --git a/lib/bb/pysh/interp.py b/lib/bb/pysh/interp.py
index 25d8c92..da3aa21 100644
--- a/lib/bb/pysh/interp.py
+++ b/lib/bb/pysh/interp.py
@@ -1261,11 +1261,11 @@ class Interpreter:
             
         def pwd_glob(pattern):
             cwd = os.getcwd()
-            os.chdir(self._env['PWD'])
+            bb.utils.checked_chdir(self._env['PWD'])
             try:
                 return glob.glob(pattern) 
             finally:
-                os.chdir(cwd)    
+                bb.utils.checked_chdir(cwd)
             
         #TODO: check working directory issues here wrt relative patterns
         try:
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 82e5dc4..99d3d8a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -856,3 +856,20 @@ def to_boolean(string, default=None):
         return False
     else:
         raise ValueError("Invalid value for to_boolean: %s" % string)
+
+def checked_chdir(name):
+    """I change the directory and verify that it was changed, if
+    not I am raising an exception."""
+
+    # We are a bit sloppy with '/' or using a relative dir like
+    # .. in the fetchers. We resolve the new path here, remove a
+    # trailing slash and see if things match now.
+    old_dir = os.getcwd()
+    new_dir = os.path.join(old_dir, name)
+    new_dir = new_dir.replace('//', '/')
+    if new_dir[-1] == '/':
+        new_dir = new_dir[:-1]
+    os.chdir(new_dir)
+
+    if os.getcwd() != new_dir:
+        raise OSError('Failed to change to directory: \'%s\'. You are in \'%s\', resolved \'%s\'' % (new_dir, os.getcwd(), new_dir))
-- 
1.7.4.1


--------------080209030704080803080206--
