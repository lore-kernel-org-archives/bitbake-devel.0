Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3637CD6E64
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:58 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17314.1780483733996951656
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZySg0gNK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef4223be7so3134099f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483732; x=1781088532; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtViTKhp8sOT8aYJdmN20Ng3709hzsfdUlUIqXxK0qw=;
        b=ZySg0gNKp+pNJEWBmZ7x/Txx8b6Hs6oEK7FUQz09a6S80V5EiHax0CVEGyYDkvsVri
         TE2I9N3xJUjk08WZRa0+AeMEvS3DhlHPMI8FavIr8Kekv0yQiRZM4sI+tpDhbX+IBwVN
         Yu3eB+e1VwWcrQftWCxmaOJ83RumXKoG397RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483732; x=1781088532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xtViTKhp8sOT8aYJdmN20Ng3709hzsfdUlUIqXxK0qw=;
        b=Fvv2Zk9cL0nZek9/KKRKnMjRp8cpxLliYhbqjgRE67WhW35qpcGSM9R0zw8cpYRX1b
         lry9emJEY8xiCQPgGf8xm9401jMpajD2Ix4BkdxZk6MjMGThtxKtCZ+qfhWYE+aA4UKF
         cg9bP/Yv+GIWLLI0yysoOhx9rc5RnRb+XasspWy9796rE5U1GepUGoCB4Q67WV5CY5NE
         r0bPm34AxH+TKx5FJ8VqOFkAXQrq8OcW+lRca0i+nKAbLfP+szdFxIbCUAyeZ+1K1bRJ
         NJX7CequSUM4iss0p2PO4PHkwLInP0B5fF5RqBwlJsY13y+f0yO3FITVbuOUxkUuvS/j
         VsFw==
X-Gm-Message-State: AOJu0YzZu8YRy4r6EbJ1rD/MV9MguhelEb984r8Km1QY59lqk7DBhXjr
	h/Nc7xReD1XsxmvdZaH29ZJH9qaJgW+0hIEmoXKP3k3nF0deTMgqrS6dF+KpKKEq5x3sNbwRS23
	/OmEz
X-Gm-Gg: Acq92OFn3m66cy0ggojHxQz+527daugh0lnF+ow3PWbnfPjL8+F4uA830sb/Wme155R
	zMgYhJRgT6sROOjs7LIvpMeOeOuqQkEFBjMltV9ZsGdPjQEVeU7OzN6TF69mMVXRZxpY8JqoFqo
	FyFFftDau0pf3YufsiIGW4AQR3U458CMXjxPYfktWn8STSNXGUgJf1UTgk5Y+pSOWwL9pF5d1X+
	I/oAcE3jMSMAtZfAxNwT9V870LyXmSO6Roats5hjrKZP2zBmKxkZDls9DOsvNKHGIhH0RUszs1F
	pU1LXsRZBS20om+6tEKFcpI1NkY8D+EMUPunNhSNxSfnW2ucGjXq0bx0kd47+9N5Nqx/Ejv74dZ
	O44jGDoc0odTsOO1/4avXbZOJwE+iPfD5IvFqSsYiyRCpAswM68TOSkhPvVlD9A9RTp6B+nBsVr
	q8sfYcI4sOpErWrNpSqfo5M7wI2l6/Y86dMj172T6g7KZa7z4X6yPzB01S/keahQCiQwMaBTNi
X-Received: by 2002:a05:6000:144e:b0:45e:a19f:22c1 with SMTP id ffacd0b85a97d-460217e3018mr4130573f8f.15.1780483732154;
        Wed, 03 Jun 2026 03:48:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 7/8] fetch/{clearcase,gomod,hg,perforce,repo,s3}: Convert to use lists of command arguments
Date: Wed,  3 Jun 2026 11:48:39 +0100
Message-ID: <20260603104840.815399-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19600

To follow best practises and avoid shell=True subprocess usage, convert
the fetcher commands to use lists instead of strings. This improves variable
quoting and models modern coding standards.

Some of these fetchers could not be tested so the changes are made blind.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/clearcase.py | 39 ++++++++++++++++---------------
 lib/bb/fetch2/gomod.py     |  4 ++--
 lib/bb/fetch2/hg.py        | 47 ++++++++++++++++----------------------
 lib/bb/fetch2/perforce.py  | 30 ++++++++++++++----------
 lib/bb/fetch2/repo.py      | 14 ++++++------
 lib/bb/fetch2/s3.py        |  7 +++---
 6 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 17500daf952..cb3f8b650c7 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -49,6 +49,7 @@ User credentials:
 #
 
 import os
+import shlex
 import shutil
 import bb
 from   bb.fetch2 import FetchMethod
@@ -94,7 +95,7 @@ class ClearCase(FetchMethod):
         else:
             ud.module = ""
 
-        ud.basecmd = d.getVar("FETCHCMD_ccrc") or "/usr/bin/env cleartool || rcleartool"
+        ud.fallbackcmd = shlex.split(d.getVar("FETCHCMD_ccrc") or "")
 
         if d.getVar("SRCREV") == "INVALID":
           raise FetchError("Set a valid SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your choice.")
@@ -122,7 +123,6 @@ class ClearCase(FetchMethod):
         self.debug("type            = %s" % ud.type)
         self.debug("vob             = %s" % ud.vob)
         self.debug("module          = %s" % ud.module)
-        self.debug("basecmd         = %s" % ud.basecmd)
         self.debug("label           = %s" % ud.label)
         self.debug("ccasedir        = %s" % ud.ccasedir)
         self.debug("viewdir         = %s" % ud.viewdir)
@@ -135,34 +135,35 @@ class ClearCase(FetchMethod):
         Build up a commandline based on ud
         command is: mkview, setcs, rmview
         """
-        options = []
+        cmd = [shutil.which("cleartool"), command]
+        if cmd[0] is None:
+            cmd = [shutil.which("rcleartool"), command]
+        if cmd[0] is None:
+            cmd = ud.fallbackcmd + [command]
 
-        if "rcleartool" in ud.basecmd:
-            options.append("-server %s" % ud.server)
-
-        basecmd = "%s %s" % (ud.basecmd, command)
+        if cmd[0].endswith("rcleartool"):
+            cmd += ['-server', ud.server]
 
         if command == 'mkview':
-            if not "rcleartool" in ud.basecmd:
+            if not cmd[0].endswith("rcleartool"):
                 # Cleartool needs a -snapshot view
-                options.append("-snapshot")
-            options.append("-tag %s" % ud.viewname)
-            options.append(ud.viewdir)
+                cmd.append("-snapshot")
+            cmd += ["-tag", ud.viewname]
+            cmd.append(ud.viewdir)
 
         elif command == 'rmview':
-            options.append("-force")
-            options.append("%s" % ud.viewdir)
+            cmd.append("-force")
+            cmd.append(ud.viewdir)
 
         elif command == 'setcs':
-            options.append("-overwrite")
-            options.append(ud.configspecfile)
+            cmd.append("-overwrite")
+            cmd.append(ud.configspecfile)
 
         else:
             raise FetchError("Invalid ccase command %s" % command)
 
-        ccasecmd = "%s %s" % (basecmd, " ".join(options))
-        self.debug("ccasecmd = %s" % ccasecmd)
-        return ccasecmd
+        self.debug("ccasecmd = %s" % cmd)
+        return cmd
 
     def _write_configspec(self, ud, d):
         """
@@ -235,7 +236,7 @@ class ClearCase(FetchMethod):
 
         # Clean clearcase meta-data before tar
 
-        runfetchcmd('tar -czf "%s" .' % (ud.localpath), d, cleanup = [ud.localpath], workdir = ud.viewdir)
+        runfetchcmd(['tar', '-czf', ud.localpath, '.'], d, cleanup = [ud.localpath], workdir = ud.viewdir)
 
         # Clean up so we can create a new view next time
         self.clean(ud, d);
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 53c1d8d115b..8a64f644dfd 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -242,9 +242,9 @@ class GoModGit(Git):
         srcrev = ud.parm['srcrev']
         version = ud.parm['version']
         escaped_version = escape(version)
-        cmd = f"git ls-tree -r --name-only '{srcrev}'"
+        cmd = ['git', 'ls-tree', '-r', '--name-only', srcrev]
         if 'subpath' in ud.parm:
-            cmd += f" '{ud.parm['subpath']}'"
+            cmd.append(ud.parm['subpath'])
         files = runfetchcmd(cmd, d, workdir=repodir).split()
         name = escaped_version + '.mod'
         bb.note(f"Unpacking {name} to {unpackdir}/")
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index cbff8c490c9..5c65a1985bb 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -15,6 +15,7 @@ BitBake 'Fetch' implementation for mercurial DRCS (hg).
 import os
 import bb
 import errno
+import shlex
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import MissingParameterError
@@ -63,7 +64,7 @@ class Hg(FetchMethod):
         ud.pkgdir = os.path.join(hgdir, hgsrcname)
         ud.moddir = os.path.join(ud.pkgdir, ud.module)
         ud.localfile = ud.moddir
-        ud.basecmd = d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_hg") or "") or ["hg"]
 
         ud.setup_revisions(d)
 
@@ -113,7 +114,7 @@ class Hg(FetchMethod):
                 hgroot = ud.user + "@" + host + ud.path
 
         if command == "info":
-            return "%s identify -i %s://%s/%s" % (ud.basecmd, proto, hgroot, ud.module)
+            return ud.basecmd + ['identify', '-i', '%s://%s/%s' % (proto, hgroot, ud.module)]
 
         options = [];
 
@@ -122,26 +123,21 @@ class Hg(FetchMethod):
         # the tag actually exists in the specified revision + 1, so it won't
         # be available when used in any successive commands.
         if ud.revision and command != "fetch":
-            options.append("-r %s" % ud.revision)
+            options += ["-r", ud.revision]
+
+        authconfig = []
+        if ud.user and ud.pswd:
+            authconfig = ['--config', 'auth.default.prefix=*', '--config', 'auth.default.username=' + ud.user, '--config', 'auth.default.password=' + ud.pswd, '--config', 'auth.default.schemes=' + proto]
 
         if command == "fetch":
-            if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
-            else:
-                cmd = "%s clone %s %s://%s/%s %s" % (ud.basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)
+            cmd = ud.basecmd + authconfig + ['clone'] + options + ['%s://%s/%s' % (proto, hgroot, ud.module), ud.module]
         elif command == "pull":
             # do not pass options list; limiting pull to rev causes the local
             # repo not to contain it and immediately following "update" command
             # will crash
-            if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
-            else:
-                cmd = "%s pull" % (ud.basecmd)
+            cmd = ud.basecmd + authconfig + ['pull']
         elif command == "update" or command == "up":
-            if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
-            else:
-                cmd = "%s update -C %s" % (ud.basecmd, " ".join(options))
+            cmd = ud.basecmd + authconfig + ['update', '-C'] + options
         else:
             raise FetchError("Invalid hg command %s" % command, ud.url)
 
@@ -155,7 +151,7 @@ class Hg(FetchMethod):
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.pkgdir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.pkgdir)
-            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d, workdir=ud.pkgdir)
+            runfetchcmd(['tar', '-xzf', ud.fullmirror], d, workdir=ud.pkgdir)
 
         if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
             # Found the source, check whether need pull
@@ -228,8 +224,8 @@ class Hg(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of hg repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, ud.module), d, workdir=ud.pkgdir)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=ud.pkgdir)
+            runfetchcmd(['tar', '-czf', ud.fullmirror, ud.module], d, workdir=ud.pkgdir)
+            runfetchcmd(['touch', '%s.done' % ud.fullmirror], d, workdir=ud.pkgdir)
 
     def localpath(self, ud, d):
         return ud.pkgdir
@@ -249,16 +245,13 @@ class Hg(FetchMethod):
             proto = ud.parm.get('protocol', 'http')
             if not os.access(os.path.join(codir, '.hg'), os.R_OK):
                 logger.debug2("Unpack: creating new hg repository in '" + codir + "'")
-                runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
+                runfetchcmd(ud.basecmd + ['init', codir], d)
             logger.debug2("Unpack: updating source in '" + codir + "'")
+            authconfig = []
             if ud.user and ud.pswd:
-                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull %s" % (ud.basecmd, ud.user, ud.pswd, proto, ud.moddir), d, workdir=codir)
-            else:
-                runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
-            if ud.user and ud.pswd:
-                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" up -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, revflag), d, workdir=codir)
-            else:
-                runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
+                authconfig = ['--config', 'auth.default.prefix=*', '--config', 'auth.default.username=' + ud.user, '--config', 'auth.default.password=' + ud.pswd, '--config', 'auth.default.schemes=' + proto]
+            runfetchcmd(ud.basecmd + authconfig + ['pull', ud.moddir], d, workdir=codir)
+            runfetchcmd(ud.basecmd + authconfig + ['up', '-C', revflag], d, workdir=codir)
         else:
             logger.debug2("Unpack: extracting source to '" + codir + "'")
-            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d, workdir=ud.moddir)
+            runfetchcmd(ud.basecmd + ['archive', '-t', 'files', revflag, codir], d, workdir=ud.moddir)
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 3b6fa4b1ec9..52ea061c04b 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -26,6 +26,7 @@ Supported SRC_URI options are:
 
 import os
 import bb
+import shlex
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
@@ -73,7 +74,7 @@ class Perforce(FetchMethod):
         provided by the env, use it.  If P4PORT is specified by the recipe, use
         its values, which may override the settings in P4CONFIG.
         """
-        ud.basecmd = d.getVar("FETCHCMD_p4") or "/usr/bin/env p4"
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_p4") or "") or ["p4"]
 
         ud.dldir = d.getVar("P4DIR") or (d.getVar("DL_DIR") + "/p4")
 
@@ -95,10 +96,15 @@ class Perforce(FetchMethod):
         else:
             logger.debug('Trying to use P4CONFIG to automatically set P4PORT...')
             ud.usingp4config = True
-            p4cmd = '%s info | grep "Server address"' % ud.basecmd
+            p4cmd = ud.basecmd + ['info']
             bb.fetch2.check_network_access(d, p4cmd, ud.url)
-            ud.host = runfetchcmd(p4cmd, d, True)
-            ud.host = ud.host.split(': ')[1].strip()
+            output = runfetchcmd(p4cmd, d, True)
+            ud.host = None
+            for line in output.splitlines():
+                if "Server address" in line:
+                    ud.host = line.split(': ')[1].strip()
+                    break
+
             logger.debug('Determined P4PORT to be: %s' % ud.host)
             if not ud.host:
                 raise FetchError('Could not determine P4PORT from P4CONFIG')
@@ -142,16 +148,16 @@ class Perforce(FetchMethod):
         "files".  depot_filename is the full path to the file in the depot
         including the trailing '#rev' value.
         """
-        p4opt = ""
+        p4opt = []
 
         if ud.user:
-            p4opt += ' -u "%s"' % (ud.user)
+            p4opt += ['-u', ud.user]
 
         if ud.pswd:
-            p4opt += ' -P "%s"' % (ud.pswd)
+            p4opt += ['-P', ud.pswd]
 
         if ud.host and not ud.usingp4config:
-            p4opt += ' -p %s' % (ud.host)
+            p4opt += ['-p', ud.host]
 
         if hasattr(ud, 'revision') and ud.revision:
             pathnrev = '%s@%s' % (ud.path, ud.revision)
@@ -176,14 +182,14 @@ class Perforce(FetchMethod):
             filename = filename[:filename.find('#')] # Remove trailing '#rev'
 
         if command == 'changes':
-            p4cmd = '%s%s changes -m 1 //%s' % (ud.basecmd, p4opt, pathnrev)
+            p4cmd = ud.basecmd + p4opt + ['changes', '-m', '1', '//%s' % pathnrev]
         elif command == 'print':
             if depot_filename is not None:
-                p4cmd = '%s%s print -o "p4/%s" "%s"' % (ud.basecmd, p4opt, filename, depot_filename)
+                p4cmd = ud.basecmd + p4opt + ['print', '-o', 'p4/%s' % filename, depot_filename]
             else:
                 raise FetchError('No depot file name provided to p4 %s' % command, ud.url)
         elif command == 'files':
-            p4cmd = '%s%s files //%s' % (ud.basecmd, p4opt, pathnrev)
+            p4cmd = ud.basecmd + p4opt + ['files', '//%s' % pathnrev]
         else:
             raise FetchError('Invalid p4 command %s' % command, ud.url)
 
@@ -231,7 +237,7 @@ class Perforce(FetchMethod):
             bb.fetch2.check_network_access(d, p4fetchcmd, ud.url)
             runfetchcmd(p4fetchcmd, d, workdir=ud.pkgdir, log=progresshandler)
 
-        runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup=[ud.localpath], workdir=ud.pkgdir)
+        runfetchcmd(['tar', '-czf', ud.localpath, 'p4'], d, cleanup=[ud.localpath], workdir=ud.pkgdir)
 
     def clean(self, ud, d):
         """ Cleanup p4 specific files and dirs"""
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fa4cb8149b7..1f9ede04430 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -33,7 +33,7 @@ class Repo(FetchMethod):
         "master".
         """
 
-        ud.basecmd = d.getVar("FETCHCMD_repo") or "/usr/bin/env repo"
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_repo") or "") or ["repo"]
 
         ud.proto = ud.parm.get('protocol', 'git')
         ud.branch = ud.parm.get('branch', 'master')
@@ -63,19 +63,19 @@ class Repo(FetchMethod):
         bb.utils.mkdirhier(repodir)
         if not os.path.exists(os.path.join(repodir, ".repo")):
             bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
-            runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
+            runfetchcmd(ud.basecmd + ['init', '-m', ud.manifest, '-b', ud.branch, '-u', '%s://%s%s%s' % (ud.proto, username, ud.host, ud.path)], d, workdir=repodir)
 
-        bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud.url), ud.url)
-        runfetchcmd("%s sync" % ud.basecmd, d, workdir=repodir)
+        bb.fetch2.check_network_access(d, ud.basecmd + ['sync'], ud.url)
+        runfetchcmd(ud.basecmd + ['sync'], d, workdir=repodir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
-            tar_flags = ""
+            tar_flags = []
         else:
-            tar_flags = "--exclude='.repo' --exclude='.git'"
+            tar_flags = ["--exclude='.repo'", "--exclude='.git'"]
 
         # Create a cache
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d, workdir=codir)
+        runfetchcmd(['tar'] + tar_flags + ['-czf', ud.localpath, os.path.join(".", "*")], d, workdir=codir)
 
     def supports_srcrev(self):
         return False
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 22c05381392..05935101471 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -19,6 +19,7 @@ import os
 import bb
 import urllib.request, urllib.parse, urllib.error
 import re
+import shlex
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import runfetchcmd
@@ -79,7 +80,7 @@ class S3(FetchMethod):
 
         ud.localfile = ud.basename
 
-        ud.basecmd = d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_s3") or "") or ["aws", "s3"]
 
     def download(self, ud, d):
         """
@@ -87,7 +88,7 @@ class S3(FetchMethod):
         Assumes localpath was called first
         """
 
-        cmd = '%s cp s3://%s%s %s' % (ud.basecmd, ud.host, ud.path, ud.localpath)
+        cmd = ud.basecmd + ['cp', 's3://%s%s' % (ud.basecmd, ud.host, ud.path), ud.localpath]
         bb.fetch2.check_network_access(d, cmd, ud.url)
 
         progresshandler = S3ProgressHandler(d)
@@ -111,7 +112,7 @@ class S3(FetchMethod):
         Check the status of a URL
         """
 
-        cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
+        cmd = ud.basecmd + ['ls', 's3://%s%s' % (ud.basecmd, ud.host, ud.path)]
         bb.fetch2.check_network_access(d, cmd, ud.url)
         output = runfetchcmd(cmd, d)
 

