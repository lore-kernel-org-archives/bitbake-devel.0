Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE7CD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 11:05:29 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42942.1781175928266271750
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 04:05:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WOAnWDIv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so64298825e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781175927; x=1781780727; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJjovn7dwoRAD70YNDkfkg634ry85efpc7MuxzqjQ1U=;
        b=WOAnWDIvk3wqFkZYPSb+SGhvWfoKbC/7NF+SvRrJJwtl8tmydSp2nwfKmEhlDNS3a1
         hDMzyn8lfMzUQUJGO9cOo/4qgNZLbLgJy9QMXrDcSNERUJ1fzBf8C0aowhuk1QnRkeNM
         y0rtXqMLHdWxqpnm2W24V7fKh9JjrxdlVJSuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175927; x=1781780727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJjovn7dwoRAD70YNDkfkg634ry85efpc7MuxzqjQ1U=;
        b=GzEyNlp2ypr3DmC+RkWfZv1eVpS91U+hpBKSa7+ahT3kfCjZMk7irbrg1LgJEYCvtC
         +aWLfvFvn1kvqI3CPYgAphv/2jv3aAQcxQfK3pcvIsga3dg5Fugr08wBaxtTqDuOSp9y
         KFKAXu7oHt8gltEhBo5PpWbo++P1FNjV0ZWfKnY4rXnbkbbzkYjMgVFBUrpRChiqoKSd
         1z7jKjaiKnYIwEfxt3EpQo+aUs6dz4ofrd91HNZ7OtPAZkFH+8XyY9kN1NP+f5hG0mLt
         e9xkxz4ST6R3HP/gy5McrJHTewUn6uj9muofzb0U7lujyob3m7v6T+a4LWaORzFAuRKf
         +fgw==
X-Gm-Message-State: AOJu0YxFBZi2Df45EzZJQzywoZbihOFstwDyPs5eK/1XnL3Zyv8Ao8ZY
	vgjhOJpckEHku+79j4nuNswLW57s5nVQCeZCj+is1gFwqyMB6IYwPWVMl2pdF2zQUpPxxJinHn5
	+Y8Td
X-Gm-Gg: Acq92OGUaMG41JXNpJCMQO5iAKaYB+upIaGxgDAJF7iKXgtJIYp4nrLekEUa+B4pQfg
	syIgrt+v4KxI+JO6nLUJsKIJ9E9+ZPR+krCx2jEMGVNczSbfhgfHj6UpHcf3JnOLgZA7gJKOMJ4
	qboi9MeC6JAqUalZB/cp3vmyvrstUGcDUIk7VTN/VWh+fLfDje7Z3vb8RW7FkvpBd6qAXgIrQA6
	nsOxuVgNOPYPHeZRkrimHg82kUTb1G+ugO5+UZfk1nPdIv4U6gc1nR+Eihqb1khA5ujweKHtxyb
	I17Nqvkf8ttSRCbEz20UTHrcltv6dSyVGFbUXdX2eM/9+vN8G53bWIXH9M9KMfzPeIAcChisbKF
	8IWy1crA8XEkId75I9wKw1Zu2LaYso0UIFPR98tZ6sN0JxVndYntJFXDiMPPDxdGRhHwdp77fqJ
	B343ES5W4cuiRSDJJz13b5kwsBnSmuH+45HbPSI56rgULNjYE0lZ68xTNqsblc3r8=
X-Received: by 2002:a05:600c:8b56:b0:490:be44:32ea with SMTP id 5b1f17b1804b1-490e55c264fmr29201965e9.7.1781175926300;
        Thu, 11 Jun 2026 04:05:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e596:3a72:77cb:f054])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm81147411f8f.28.2026.06.11.04.05.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:05:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] lib/bb: Further shell=True cleanups
Date: Thu, 11 Jun 2026 12:05:23 +0100
Message-ID: <20260611110523.322273-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611110523.322273-1-richard.purdie@linuxfoundation.org>
References: <20260611110523.322273-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 11:05:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19655

Go through the remaining shell=True references in bitbake and clean them up
to use lists where possible. By using existing helpers, chdir and PATH
settings can be dropped.

In toaster, the current branch can be obtained more easily with modern git
commands.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/crate.py                        | 21 ++++---------------
 lib/bb/fetch2/gomod.py                        |  7 ++-----
 lib/bb/ui/ncurses.py                          |  2 +-
 .../bldcontrol/localhostbecontroller.py       | 21 +++++++++++--------
 lib/toaster/toastermain/settings.py           |  4 ++--
 5 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 8f928ea6b4d..f94e153ee3b 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -17,7 +17,7 @@ import subprocess
 import re
 from functools import cmp_to_key
 import bb
-from   bb.fetch2 import logger, subprocess_setup, UnpackError
+from   bb.fetch2 import logger, subprocess_setup, UnpackError, runfetchcmd
 from   bb.fetch2.wget import Wget
 
 
@@ -110,19 +110,15 @@ class Crate(Wget):
         # possible metadata we need to write out
         metadata = {}
 
-        # change to the rootdir to unpack but save the old working dir
-        save_cwd = os.getcwd()
-        os.chdir(rootdir)
-
         bp = d.getVar('BP')
         if bp == ud.parm.get('name'):
-            cmd = "tar -xz --no-same-owner -f %s" % thefile
+            cmd = ['tar', '-xz', '--no-same-owner', '-f', thefile]
             ud.unpack_tracer.unpack("crate-extract", rootdir)
         else:
             cargo_bitbake = self._cargo_bitbake_path(rootdir)
             ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
 
-            cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, cargo_bitbake)
+            cmd = ['tar', '-xz', '--no-same-owner', '-f', thefile, '-C', cargo_bitbake]
 
             # ensure we've got these paths made
             bb.utils.mkdirhier(cargo_bitbake)
@@ -135,17 +131,8 @@ class Crate(Wget):
             metadata['files'] = {}
             metadata['package'] = tarhash
 
-        path = d.getVar('PATH')
-        if path:
-            cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (thefile, os.getcwd()))
-
-        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
-
-        os.chdir(save_cwd)
-
-        if ret != 0:
-            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
+        runfetchcmd(cmd, d, workdir=rootdir)
 
         # if we have metadata to write out..
         if len(metadata) > 0:
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 8a64f644dfd..5cdf8f99814 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -135,13 +135,10 @@ class GoMod(Wget):
         unpackdir = os.path.dirname(unpackpath)
         bb.utils.mkdirhier(unpackdir)
         ud.unpack_tracer.unpack("file-copy", unpackdir)
-        cmd = f"cp {ud.localpath} {unpackpath}"
-        path = d.getVar('PATH')
-        if path:
-            cmd = f"PATH={path} {cmd}"
+        cmd = ['cp', ud.localpath, unpackpath]
         name = os.path.basename(unpackpath)
         bb.note(f"Unpacking {name} to {unpackdir}/")
-        subprocess.check_call(cmd, shell=True, preexec_fn=subprocess_setup)
+        runfetchcmd(cmd, d)
 
         if name.endswith('.zip'):
             # Unpack the go.mod file from the zip file
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index 18a706547aa..228fa9a6dc7 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -291,7 +291,7 @@ class NCursesUI:
 #                            bb.error("log data follows (%s)" % logfile)
 #                            number_of_lines = data.getVar("BBINCLUDELOGS_LINES", d)
 #                            if number_of_lines:
-#                                subprocess.check_call('tail -n%s %s' % (number_of_lines, logfile), shell=True)
+#                                subprocess.check_call(['tail', '-n' + number_of_lines, logfile])
 #                            else:
 #                                f = open(logfile, "r")
 #                                while True:
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 50069d47a4c..dcbd9a8260d 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -51,7 +51,10 @@ class LocalhostBEController(BuildEnvironmentController):
             env=os.environ.copy()
 
         logger.debug("lbc_shellcmd: (%s) %s" % (cwd, command))
-        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
+        if isinstance(command, str):
+            p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
+        else:
+            p = subprocess.Popen(command, cwd = cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
         if nowait:
             return
         (out,err) = p.communicate()
@@ -136,7 +139,7 @@ class LocalhostBEController(BuildEnvironmentController):
         cached_layers = {}
 
         try:
-            for remotes in self._shellcmd("git remote -v", self.be.sourcedir,env=git_env).split("\n"):
+            for remotes in self._shellcmd(['git', 'remote', '-v'], self.be.sourcedir, env=git_env).split("\n"):
                 try:
                     remote = remotes.split("\t")[1].split(" ")[0]
                     if remote not in cached_layers:
@@ -172,8 +175,7 @@ class LocalhostBEController(BuildEnvironmentController):
             # see if our directory is a git repository
             if os.path.exists(localdirname):
                 try:
-                    localremotes = self._shellcmd("git remote -v",
-                                                  localdirname,env=git_env)
+                    localremotes = self._shellcmd(['git' ,'remote', '-v'], localdirname, env=git_env)
                     # NOTE: this nice-to-have check breaks when using git remaping to get past firewall
                     #       Re-enable later with .gitconfig remapping checks
                     #if not giturl in localremotes and commit != 'HEAD':
@@ -186,12 +188,12 @@ class LocalhostBEController(BuildEnvironmentController):
             else:
                 if giturl in cached_layers:
                     logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
-                    self._shellcmd("git clone \"%s\" \"%s\"" % (cached_layers[giturl], localdirname),env=git_env)
-                    self._shellcmd("git remote remove origin", localdirname,env=git_env)
-                    self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname,env=git_env)
+                    self._shellcmd(['git', 'clone', cached_layers[giturl]], localdirname], env=git_env)
+                    self._shellcmd(['git', 'remote', 'remove', 'origin'], localdirname, env=git_env)
+                    self._shellcmd(['git', 'remote', 'add', 'origin', giturl], localdirname, env=git_env)
                 else:
                     logger.debug("localhostbecontroller: cloning %s in %s" % (giturl, localdirname))
-                    self._shellcmd('git clone "%s" "%s"' % (giturl, localdirname),env=git_env)
+                    self._shellcmd(['git', 'clone', giturl, localdirname], env=git_env)
 
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
@@ -199,7 +201,8 @@ class LocalhostBEController(BuildEnvironmentController):
                 ref = commit if re.match('^[a-fA-F0-9]+$', commit) else 'origin/%s' % commit
                 # DEBUGGING NOTE: this is the 'git fetch" to disable after the initial clone to
                 # prevent inserted debugging commands from being lost
-                self._shellcmd('git fetch && git reset --hard "%s"' % ref, localdirname,env=git_env)
+                self._shellcmd(['git', 'fetch'], localdirname, env=git_env)
+                self._shellcmd(['git', 'reset', '--hard', ref], localdirname, env=git_env)
 
             # verify our repositories
             for name, dirpath, index in gitrepos[(giturl, commit)]:
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index d2a449627f8..9d2dbc464ec 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -229,8 +229,8 @@ from os.path import dirname as DN
 SITE_ROOT=DN(DN(os.path.abspath(__file__)))
 
 import subprocess
-TOASTER_BRANCH = subprocess.Popen('git branch | grep "^* " | tr -d "* "', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
-TOASTER_REVISION = subprocess.Popen('git rev-parse HEAD ', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
+TOASTER_BRANCH = subprocess.check_output(['git', 'branch', '--show-current'], cwd=SITE_ROOT, text=True).strip()
+TOASTER_REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=SITE_ROOT, text=True).strip()
 
 ROOT_URLCONF = 'toastermain.urls'
 

