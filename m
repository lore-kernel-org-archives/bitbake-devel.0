Received: from moutng.kundenserver.de ([212.227.126.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@informatik.tu-chemnitz.de>)
	id 1SIhf7-0002eu-PD for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 16:39:45 +0200
Received: from mail.bigo.ensc.de (p54ADE1CF.dip.t-dialin.net [84.173.225.207])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0M3SWO-1S1IkR2GIq-00r9Vp; Fri, 13 Apr 2012 16:06:23 +0200
Received: from sheridan.bigo.ensc.de (sheridan.bigo.ensc.de [192.168.46.11])
	by mail.bigo.ensc.de (8.14.4/8.14.4) with ESMTP id q3DE6MKs007824;
	Fri, 13 Apr 2012 16:06:22 +0200
Received: from ensc by sheridan.bigo.ensc.de with local (Exim 4.76)
	(envelope-from <ensc@sheridan.bigo.ensc.de>)
	id 1SIh8o-000479-1j; Fri, 13 Apr 2012 16:06:22 +0200
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:06:13 +0200
Message-Id: <1334325973-15760-3-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
References: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
Sender: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
X-Provags-ID: V02:K0:jVfjeP+EyfnTY9s5isnTjuVEh6yHrEzQKEtSzcoNCMS
	NFwTnz/EUnMGK5XDZhMBJSI4wqYz6aIvow5jaB6EZmAFUlyT5k
	MM9r1uE5JlkRMLl/84qtAdfUvusFA3rV0EQrHmne5jn8uFgwla
	CIsH7hh2fEvpAaf9FV3FHHW2DBpbxUiefltgqtTkz17gS2vqJo
	KebrIBFx5RDsEtjSrKz7rOoF9L/X+sKjW1zmwPr+vVuCWnkgsm
	95rwiqj0mSWKnRhtxEwPqAQugDTUkO5oVxFMtNAC39uEpiQn8Z
	yCWLgQbxnf7Cx/TvInaJ3rOYu/PaoCJhoAZopkwC4wGd1VX+R6
	P6ZOH8W5jSLw74Bj21P0/pHQXSjCz6POJzQAnVqvCYXCxSr7Uk
	Q8Ee1mu7Y1aJuXcFg4Q/jOY7uviLC/3s5K2C+8XQIwxcruwb1D Un1IS
Cc: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: [PATCH 3/3] fetch2/git: quote arguments
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
X-List-Received-Date: Fri, 13 Apr 2012 14:39:45 -0000

Patch makes sure that arguments given to 'git' are quoted properly.  It
uses the newly added runfetchcmd2() function or quotes them manually
when special shell functionality (pipes, io redirections) are used.

Signed-off-by: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
---
 lib/bb/fetch2/git.py |   53 +++++++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 61fdc4b..52adb9a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -65,8 +65,9 @@ import os
 import bb
 from   bb    import data
 from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import runfetchcmd, runfetchcmd2
 from   bb.fetch2 import logger
+import pipes
 
 class Git(FetchMethod):
     """Class to fetch a module or modules from git repositories"""
@@ -115,6 +116,7 @@ class Git(FetchMethod):
             ud.branches[name] = branch
 
         ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
+        ud.runfetch = lambda args,d,**opts: runfetchcmd2(ud.basecmd, args, d, **opts)
 
         ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
 
@@ -177,15 +179,15 @@ class Git(FetchMethod):
         if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.clonedir)
             os.chdir(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
+            runfetchcmd(['tar', '-xzf', ud.fullmirror], d)
 
         repourl = "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
-            bb.fetch2.check_network_access(d, clone_cmd)
-            runfetchcmd(clone_cmd, d)
+            clone_cmd = ['clone', '--bare', '--mirror', repourl, ud.clonedir]
+            bb.fetch2.check_network_access(d, clone_cmd, base_cmd = ud.basecmd, url = repourl)
+            ud.runfetch(clone_cmd, d)
 
         os.chdir(ud.clonedir)
         # Update the checkout if needed
@@ -200,10 +202,10 @@ class Git(FetchMethod):
             except bb.fetch2.FetchError:
                 logger.debug(1, "No Origin")
 
-            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d)
-            fetch_cmd = "%s fetch -f --prune %s refs/*:refs/*" % (ud.basecmd, repourl)
-            bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
-            runfetchcmd(fetch_cmd, d)
+            ud.runfetch(['remote', 'add', '--mirror=fetch', 'origin', repourl], d)
+            fetch_cmd = ['fetch', '-f', '--prune', repourl, 'refs/*:refs/*']
+            bb.fetch2.check_network_access(d, fetch_cmd, base_cmd = ud.basecmd, url = ud.url)
+            ud.runfetch(fetch_cmd, d)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
             ud.repochanged = True
@@ -213,8 +215,8 @@ class Git(FetchMethod):
         if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
             os.chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+            runfetchcmd(['tar', '-czf', ud.fullmirror, os.path.join(".")], d)
+            runfetchcmd(['touch', ud.fullmirror + '.done'], d)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
@@ -232,18 +234,20 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        cloneflags = "-s -n"
+        cloneflags = ['clone', '-s', '-n']
         if ud.bareclone:
-            cloneflags += " --mirror"
+            cloneflags.append("--mirror")
+
+        cloneflags.extend(["%s/" % ud.clonedir, destdir])
+        ud.runfetch(cloneflags, d)
 
-        runfetchcmd("git clone %s %s/ %s" % (cloneflags, ud.clonedir, destdir), d)
         if not ud.nocheckout:
             os.chdir(destdir)
             if subdir != "":
-                runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d)
+                ud.runfetch(['read-tree', '%s%s' % ud.revisions[ud.names[0]], readpathspec])
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d)
             else:
-                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d)
+                ud.runfetch(['checkout', ud.revisions[ud.names[0]]], d)
         return True
 
     def clean(self, ud, d):
@@ -257,7 +261,7 @@ class Git(FetchMethod):
 
     def _contains_ref(self, tag, d):
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (basecmd, tag)
+        cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (basecmd, pipes.quote(tag))
         output = runfetchcmd(cmd, d, quiet=True)
         if len(output.split()) > 1:
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
@@ -279,10 +283,12 @@ class Git(FetchMethod):
             username = ""
 
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
-        bb.fetch2.check_network_access(d, cmd)
-        output = runfetchcmd(cmd, d, True)
+        cmd = ['ls-remote',
+               '%s://%s%s%s' % (ud.proto, username, ud.host, ud.path),
+               ud.branches[name]]
+
+        bb.fetch2.check_network_access(d, cmd, base_cmd = ud.basecmd)
+        output = ud.runfetch(cmd, d, quiet=True)
         if not output:
             raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, url)
         return output.split()[0]
@@ -315,7 +321,7 @@ class Git(FetchMethod):
         if not self._contains_ref(rev, d):
             self.download(None, ud, d)
 
-        output = runfetchcmd("%s rev-list %s -- 2> /dev/null | wc -l" % (ud.basecmd, rev), d, quiet=True)
+        output = runfetchcmd("%s rev-list %s -- 2> /dev/null | wc -l" % (ud.basecmd, pipes.quote(rev)), d, quiet=True)
         os.chdir(cwd)
 
         buildindex = "%s" % output.split()[0]
@@ -323,9 +329,8 @@ class Git(FetchMethod):
         return buildindex
 
     def checkstatus(self, uri, ud, d):
-        fetchcmd = "%s ls-remote %s" % (ud.basecmd, uri)
         try:
-            runfetchcmd(fetchcmd, d, quiet=True)
+            ud.runfetch(['ls-remote',  uri], d, quiet=True)
             return True
         except FetchError:
             return False
-- 
1.7.7.6



