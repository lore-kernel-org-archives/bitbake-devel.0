Received: from moutng.kundenserver.de ([212.227.17.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@informatik.tu-chemnitz.de>)
	id 1SIhMm-0002T8-32 for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 16:20:48 +0200
Received: from mail.bigo.ensc.de (p54ADE1CF.dip.t-dialin.net [84.173.225.207])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MSGxn-1ShlB61uu3-00TOrs; Fri, 13 Apr 2012 16:06:23 +0200
Received: from sheridan.bigo.ensc.de (sheridan.bigo.ensc.de [192.168.46.11])
	by mail.bigo.ensc.de (8.14.4/8.14.4) with ESMTP id q3DE6LGn007822;
	Fri, 13 Apr 2012 16:06:22 +0200
Received: from ensc by sheridan.bigo.ensc.de with local (Exim 4.76)
	(envelope-from <ensc@sheridan.bigo.ensc.de>)
	id 1SIh8n-000473-Ey; Fri, 13 Apr 2012 16:06:21 +0200
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:06:11 +0200
Message-Id: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
X-Mailer: git-send-email 1.7.7.6
Sender: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
X-Provags-ID: V02:K0:uVeuYEuTi69/vpwBgd3AG57sOCbfq2KrYSiyNWdCMz0
	3WSgBn+zC1B3haW91ggkRjSUNVtUYOJI5jMGdLgF2nIJImr16K
	LNi2cX0xu6Pl2zE2gJmESbqQt+jQQF8eR672qlfP8q9Mxk6Uxy
	p4tpB9xXP2NbV+Y6+1AvRrin9p6iyX+NeAl9IdqEFrNfZsaU4I
	4CUHFtRCFHi1wpjyQeAJ8TwK5bkSRyw+SJ5JZotU2doEFDm1Kw
	eyzbrgZrkwv5qCuGze2+ifZfFigreld4V4NRya9g0dv1hTF0BQ
	zpDzkGgTYLFDPmsp4Gorr2qXt5QihPXEztsxjDBqWdsEjpLJuD
	A0DtoCwCEvx10yZTGQ+awS1lROLRlGYw0OUpzfrSJG2Wss8yjg
	jcRJGOEbNqXOtHFMJSzhS5FynLBnl1y7adkF6W/MJazwFpoFBp NkD2P
Cc: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: [PATCH 1/3] fetcher: quote filenames given in commands
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
X-List-Received-Date: Fri, 13 Apr 2012 14:20:48 -0000

Filenames were given as-is to shell commands. This causes problems
when names contain characters which have a special meaning. E.g. when
having a local systemd unit

| SRC_URI = "file://etc-machine\20id.mount"

the fetcher failed with

| NOTE: Unpacking .../etc-machine\20id.mount to ...
| cp: cannot stat `.../etc-machine20id.mount': No such file or directory

Patch uses the pipes.quote() function to apply shell escaping.  These
changes are not really complete; they are modifying __init__.py only
but most fetchers need similar adaptations too.

Signed-off-by: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
---
 lib/bb/fetch2/__init__.py |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 414cc2b..9afbc4f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -29,6 +29,7 @@ from __future__ import print_function
 import os, re
 import logging
 import bb.persist_data, bb.utils
+import pipes
 from bb import data
 
 __version__ = "2"
@@ -712,38 +713,39 @@ class FetchMethod(object):
         cmd = None
 
         if unpack:
+            qfile = pipes.quote(file)
             if file.endswith('.tar'):
-                cmd = 'tar x --no-same-owner -f %s' % file
+                cmd = ['tar', 'x', '--no-same-owner',  '-f', file]
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
-                cmd = 'tar xz --no-same-owner -f %s' % file
+                cmd = ['tar', 'xz', '--no-same-owner', '-f', file]
             elif file.endswith('.tbz') or file.endswith('.tbz2') or file.endswith('.tar.bz2'):
-                cmd = 'bzip2 -dc %s | tar x --no-same-owner -f -' % file
+                cmd = 'bzip2 -dc %s | tar x --no-same-owner -f -' % qfile
             elif file.endswith('.gz') or file.endswith('.Z') or file.endswith('.z'):
-                cmd = 'gzip -dc %s > %s' % (file, efile)
+                cmd = 'gzip -dc %s > %s' % (qfile, pipes.quote(efile))
             elif file.endswith('.bz2'):
-                cmd = 'bzip2 -dc %s > %s' % (file, efile)
+                cmd = 'bzip2 -dc %s > %s' % (qfile, pipes.quote(efile))
             elif file.endswith('.tar.xz'):
-                cmd = 'xz -dc %s | tar x --no-same-owner -f -' % file
+                cmd = 'xz -dc %s | tar x --no-same-owner -f -' % qfile
             elif file.endswith('.xz'):
-                cmd = 'xz -dc %s > %s' % (file, efile)
+                cmd = 'xz -dc %s > %s' % (qfile, pipes.quote(efile))
             elif file.endswith('.zip') or file.endswith('.jar'):
                 try:
                     dos = bb.utils.to_boolean(urldata.parm.get('dos'), False)
                 except ValueError as exc:
                     bb.fatal("Invalid value for 'dos' parameter for %s: %s" %
                              (file, urldata.parm.get('dos')))
-                cmd = 'unzip -q -o'
+                cmd = ['unzip', '-q', '-o']
                 if dos:
-                    cmd = '%s -a' % cmd
-                cmd = "%s '%s'" % (cmd, file)
+                    cmd.append('-a')
+                cmd.append(file)
             elif file.endswith('.src.rpm') or file.endswith('.srpm'):
                 if 'extract' in urldata.parm:
                     unpack_file = urldata.parm.get('extract')
-                    cmd = 'rpm2cpio.sh %s | cpio -i %s' % (file, unpack_file)
+                    cmd = 'rpm2cpio.sh %s | cpio -i %s' % (qfile, pipes.quote(unpack_file))
                     iterate = True
                     iterate_file = unpack_file
                 else:
-                    cmd = 'rpm2cpio.sh %s | cpio -i' % (file)
+                    cmd = 'rpm2cpio.sh %s | cpio -i' % qfile
 
         if not unpack or not cmd:
             # If file == dest, then avoid any copies, as we already put the file into dest!
@@ -759,8 +761,8 @@ class FetchMethod(object):
                             destdir = "."
                         elif not os.access("%s/%s" % (rootdir, destdir), os.F_OK):
                             os.makedirs("%s/%s" % (rootdir, destdir))
-                    cmd = 'cp -pPR %s %s/%s/' % (file, rootdir, destdir)
-                    #cmd = 'tar -cf - -C "%d" -ps . | tar -xf - -C "%s/%s/"' % (file, rootdir, destdir)
+                    cmd = ['cp', '-pPR', file, '%s/%s/' % (rootdir, destdir)]
+                    #cmd = 'tar -cf - -C "%d" -ps . | tar -xf - -C "%s/%s/"' % (pipes.quote(file), pipes.quote(rootdir), pipes.quote(destdir))
                 else:
                     # The "destdir" handling was specifically done for FILESPATH
                     # items.  So, only do so for file:// entries.
@@ -769,7 +771,7 @@ class FetchMethod(object):
                     else:
                        destdir = "."
                     bb.utils.mkdirhier("%s/%s" % (rootdir, destdir))
-                    cmd = 'cp %s %s/%s/' % (file, rootdir, destdir)
+                    cmd = ['cp', file, '%s/%s/' % (rootdir, destdir)]
 
         if not cmd:
             return
@@ -782,9 +784,11 @@ class FetchMethod(object):
             bb.utils.mkdirhier(newdir)
             os.chdir(newdir)
 
-        cmd = "PATH=\"%s\" %s" % (data.getVar('PATH', True), cmd)
+        new_env = os.environ.copy()
+        new_env['PATH'] = data.getVar('PATH', True)
         bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
-        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
+        ret = subprocess.call(cmd, preexec_fn=subprocess_setup,
+                              shell=isinstance(cmd, basestring), env=new_env)
 
         os.chdir(save_cwd)
 
-- 
1.7.7.6



