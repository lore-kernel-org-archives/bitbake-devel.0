Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD1ECD6E56
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 18:27:58 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12309.1780252072966708870
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 May 2026 11:27:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=exQ0DrQA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso5085115e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780252071; x=1780856871; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mkb8N8vLVuWtQlHTqEV8WmDgzHhQttEP2tPXOVRRek=;
        b=exQ0DrQAi8uTPFby6AHAxuVYM1p/BywkFB/AROicEw1+XrrxbpAOTohjSI2ccUf3xU
         62fGS+IqwLGQCOQJ+JaPeCPmMoK1eZphrQiX+PoO+z7Ci7pZ9WuDOi3RJZBcem7MLUBj
         BLmv1kUp4EpNYzPUpiBuUJrn1Vwl2A1BoBj3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252071; x=1780856871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mkb8N8vLVuWtQlHTqEV8WmDgzHhQttEP2tPXOVRRek=;
        b=Z1CNhzJtXUvShC6OqsIvUEd5L7Ua0s4xM9ozMJbqOjvdw/J9hc0L+FWd80fBlgLwfg
         EgQJwnm6TAHAU88TLCc/7sJU1ixuWPcW4T2VPqxuDZyfIlFTRhdPML8iMueyB1ODQtne
         MsHEzz7cNRHM4Li9ISaw735WGmk9Rn4sNChkBPsGJwM1LvW4lX5wuB/LQbkN1kzY6pNe
         kKQIw/kbfiiWoHBYcmyhP2liLzuUTSnAz1UxVBLhWBccziiF2CeNcfE8gnECkyP5TiUs
         wjTw3BEzED02dRJAt3y3aefFEw5O3v8bloVe4r0oYALWsa8SJbgydGKTh6XG2DYh43Qf
         OjaQ==
X-Gm-Message-State: AOJu0Yy9CFBXTVcinVQcx2EhjOmonQFfhDjVNCqgZEhdokVPtg+0n90Y
	MahPoMNi8/QpdBEABV94iALfohcY4kmSKbDkRWRbTL9miwEKZkxLVD690y8/J7hhfA+HAI7UNCV
	BYTa/
X-Gm-Gg: Acq92OFZnSd7E1wthb/vJbBg5fwb2hr9LLvloxZ5UHkYCbEIogTYGFK7Vrb1Xn+hC97
	wp2TgfJ7lAPLDrvpfImh5H+xjXfYlVqw9wvFE+atbhhN5fY1MDXANsPuuP9yhItnysraiiUUIq9
	2R8gcphQF+74WcXEP3D/8fJofWIl49JpGZuqxIPn7gRTUYQLXPMpZczYgUPmurTtKzF+rL8H8c1
	P45hSSla+prWJjTyQn5Tk27sgoZhXHFbMJcrdlgYnNTXsOVRO/0UOIWg7nuEkK9IE2lYqvAxjQ1
	5mUD2J7S51W+hjwgYwgEnG+brc6hlsHDXqt4Q4lDMGzi0yq/hahdA0iRf8p2KbyP2R+t7XBjjt7
	UFQt3v7FeD0rNlijwpjuXC7jw0/l9JX5oqA0+DBfu0KOQBrcSMpPffWNMlynePliaQF8ieFO5gr
	/p3iNcdKcPF0h+5fM62/i5g/I7Q6X8UycLLvArCLsb68CGguxnyufroG+lNQNZJf4=
X-Received: by 2002:a05:600c:1d07:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490a294e7d4mr139532435e9.24.1780252071235;
        Sun, 31 May 2026 11:27:51 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm18563488f8f.19.2026.05.31.11.27.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:27:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] bb/fetch2: Improve runfetchcmd environment handling
Date: Sun, 31 May 2026 19:27:43 +0100
Message-ID: <20260531182743.2412946-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
References: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 18:27:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19577

One of the reasons for using shell=True in runfetchcmd is due to environment
manipulations. There are better ways to do this directly with subprocess' env
parameter. Switch to doing this, paving the way for fewer shell=True process
calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 12 ++++++++----
 lib/bb/fetch2/git.py      | 16 ++++++++--------
 lib/bb/fetch2/svn.py      |  2 +-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ce7456b60f1..564147603b5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -933,7 +933,7 @@ def get_fetcher_environment(d):
             newenv[name] = value
     return newenv
 
-def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
+def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None, extraenv=None):
     """
     Run cmd returning the command output
     Raise an error if interrupted or cmd fails
@@ -958,13 +958,17 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         d.setVar("PR", "fetcheravoidrecurse")
 
     origenv = d.getVar("BB_ORIGENV", False)
+    env = os.environ.copy()
     for var in exportvars:
         val = d.getVar(var) or (origenv and origenv.getVar(var))
         if val:
-            cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
+            env[var] = val
+
+    for var in (extraenv or []):
+        env[var] = extraenv[var]
 
     # Disable pseudo as it may affect ssh, potentially causing it to hang.
-    cmd = 'export PSEUDO_DISABLED=1; ' + cmd
+    env["PSEUDO_DISABLED"] = "1"
 
     if workdir:
         logger.debug("Running '%s' in %s" % (cmd, workdir))
@@ -975,7 +979,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     error_message = ""
 
     try:
-        (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir)
+        (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir, env=env)
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s not found" % (e.command)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index d305eb878e8..793b3570b11 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -397,8 +397,8 @@ class Git(FetchMethod):
                     if 'mirror' in output:
                         runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
                     runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
-                    fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
-                    runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
+                    fetch_cmd = "%s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
+                    runfetchcmd(fetch_cmd, d, workdir=ud.clonedir, extraenv={'LANG':'C'})
         repourl = self._get_repo_url(ud)
 
         needs_clone = False
@@ -407,7 +407,7 @@ class Git(FetchMethod):
             # repository in which case it needs to be deleted and re-cloned.
             try:
                 # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
-                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
+                output = runfetchcmd("%s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir, extraenv={'LANG':'C'})
                 toplevel = output.rstrip()
 
                 if not bb.utils.path_is_descendant(toplevel, ud.clonedir):
@@ -434,7 +434,7 @@ class Git(FetchMethod):
                 objects = os.path.join(repourl_path, 'objects')
                 if os.path.isdir(objects) and not os.path.islink(objects):
                     repourl = repourl_path
-            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            clone_cmd = "%s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -456,7 +456,7 @@ class Git(FetchMethod):
 
             # When skipping fast initial shallow or the fast inital shallow clone failed:
             # Try again with an initial regular clone
-            runfetchcmd(clone_cmd, d, log=progresshandler)
+            runfetchcmd(clone_cmd, d, log=progresshandler, extraenv={'LANG':'C'})
 
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
@@ -467,13 +467,13 @@ class Git(FetchMethod):
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
 
             if ud.nobranch:
-                fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
+                fetch_cmd = "%s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
             else:
-                fetch_cmd = "LANG=C %s fetch -f --progress %s refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repourl))
+                fetch_cmd = "%s fetch -f --progress %s refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repourl))
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
+            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir, extraenv={'LANG':'C'})
             runfetchcmd("%s repack -adk" % ud.basecmd, d, workdir=ud.clonedir)
             runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
             runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index a097ffb76b5..b5862139fac 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -193,7 +193,7 @@ class Svn(FetchMethod):
         """
         bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"), ud.url)
 
-        output = runfetchcmd("LANG=C LC_ALL=C " + self._buildsvncommand(ud, d, "log1"), d, True)
+        output = runfetchcmd(self._buildsvncommand(ud, d, "log1"), d, True, extraenv={'LANG':'C', 'LC_ALL': 'C'})
 
         # skip the first line, as per output of svn log
         # then we expect the revision on the 2nd line

