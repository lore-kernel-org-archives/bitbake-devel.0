Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB85DCD6E64
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:48 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17309.1780483725406666004
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Esz1L6pb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4059448f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483724; x=1781088524; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+RbBiyaaIyLtlsP47vr0JIgt9sCNJ2P2wM6JRcTSMg=;
        b=Esz1L6pbHNpG/c1j2pP3haBWk8bCuk4qf0lNxA/AhyxA9EWN0EWwfOECX6pMb5HB1N
         fQFsYwh8Neg8nP69QxCYxYJ61pv/2FrQgQmAkOoMWC4uaxMXHEtJ8hXYMAkVXTIlqbF6
         SXF93n0a2t70DyXWEPGxAGQT8yhgYkXAnVfWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483724; x=1781088524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V+RbBiyaaIyLtlsP47vr0JIgt9sCNJ2P2wM6JRcTSMg=;
        b=kgcxkG48K63WusFly7/39hzBWgrNBbY7L6GcGbZozpEuGqHoLqevInEYVCMzOPHg/Q
         AefUkJ/7XNQvo9OQhoN36d0ws1Var6WNMh2+RLFsTMI2utqvVxB2UDB/zubLe8yPMrz+
         mqcB/pzUMBtuYmHbxX3vYZ9ezQ92CbyJ6/ydReOtPX7coRSqjtQyTKJHsXGxGWk8/Iqq
         SJPwoCKlzHGbmc6lxz6b0tqJbMlYGmjDnQaTxjqGy4+LNmzn8J/ZBUO0yWUYacaGqeUS
         A4suWbUIZLaNU0YGTBJti0SUzMnOuhkQnTiFWUQ52XweKk0ytc2/i1FKtScdk0IletAF
         V6DQ==
X-Gm-Message-State: AOJu0YzWJp77QlhvyYOLfgSHsDq7D75R/L5C+mu5yT8PH3Pc4VWpp9ia
	KwV51fxOwCAwxpN0eqSbbH4C2NggKJx4FwdsU+dbrQR3uhqxYKiQ6aEyvfPFeIRuu2ABuJuWfZ4
	7G7JG
X-Gm-Gg: Acq92OHmUemhWx71NLbAmaGcuCXT22UMy0KFihpq4gdyCbAVjDev1aWvj55UDS7CFnz
	oqhRfAPF+dT/59q4xsca28RA/QTEa7isACTRW9Ofsx2sshCXo/IJ/F1IqpGPRAkUW8E24W84x6t
	linFMiGQmcSvAfjWZpFpfrAgzmR+XHQAA+6hwSqHVVZOAzzWoytEk69F9UDSnndDhpUVd3GwTUz
	McH2EYCDY4fyUarNIIUH2hpJT7+C4NDGiRV7ePdOFgBi9uu/qSgdpiY6Rvu7DB8jq/8HTyQKuUE
	cUQ9lEXkx64aPJ8xO/AgpT8K1+uYdeWsujTwS6SP1roGrwRg4RN6Ibmm/4EzbKFg77RJ0ctAf1e
	r20dsojcsE7aX8fymtcYEB48TorHC1WeXJUrF172ctifVSH4Ki7RrU9FSEhhq9SSEuyLZahFL5m
	Kd9LxGsoZ/onYEA0KuLm0bQKVl+d1cW23SavaepwbrA2tfoTwA3UitBHAr9FBKng==
X-Received: by 2002:a05:600c:4ecc:b0:490:b724:dbd6 with SMTP id 5b1f17b1804b1-490b724dd8emr41797925e9.6.1780483723119;
        Wed, 03 Jun 2026 03:48:43 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/8] fetch/{git,gitannex,gitsm}: Convert to use lists of command arguments
Date: Wed,  3 Jun 2026 11:48:34 +0100
Message-ID: <20260603104840.815399-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19595

To follow best practises and avoid shell=True subprocess usage, convert
the fetcher commands to use lists instead of strings. This improves variable
quoting and models modern coding standards.

Some shell pipeline commands are adapted to aviod the pipelines. Environment
variables are passed in separately using extraenv  where needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py      | 174 ++++++++++++++++++--------------------
 lib/bb/fetch2/gitannex.py |  18 ++--
 lib/bb/fetch2/gitsm.py    |  19 +++--
 3 files changed, 99 insertions(+), 112 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 793b3570b11..cd045a3a947 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -189,11 +189,11 @@ class Git(FetchMethod):
 
         ud.noshared = d.getVar("BB_GIT_NOSHARED") == "1"
 
-        ud.cloneflags = "-n"
+        ud.cloneflags = ["-n"]
         if not ud.noshared:
-            ud.cloneflags += " -s"
+            ud.cloneflags.append("-s")
         if ud.bareclone:
-            ud.cloneflags += " --mirror"
+            ud.cloneflags.append("--mirror")
 
         ud.shallow_skip_fast = False
         ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
@@ -249,6 +249,8 @@ class Git(FetchMethod):
 
         ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all -c clone.defaultRemoteName=origin"
 
+        ud.basecmd = shlex.split(ud.basecmd)
+
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
         ud.write_shallow_tarballs = (d.getVar("BB_GENERATE_SHALLOW_TARBALLS") or write_tarballs) != "0"
@@ -340,7 +342,7 @@ class Git(FetchMethod):
     def clonedir_need_shallow_revs(self, ud, d):
         for rev in ud.shallow_revs:
             try:
-                runfetchcmd('%s rev-parse -q --verify %s' % (ud.basecmd, rev), d, quiet=True, workdir=ud.clonedir)
+                runfetchcmd(ud.basecmd + ['rev-parse', '-q', '--verify', rev], d, quiet=True, workdir=ud.clonedir)
             except bb.fetch2.FetchError:
                 return rev
         return None
@@ -389,15 +391,15 @@ class Git(FetchMethod):
         elif os.path.exists(ud.fullmirror) and self.need_update(ud, d):
             if not os.path.exists(ud.clonedir):
                 bb.utils.mkdirhier(ud.clonedir)
-                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
+                runfetchcmd(['tar', '-xzf', ud.fullmirror], d, workdir=ud.clonedir)
             else:
                 with tempfile.TemporaryDirectory(dir=d.getVar('DL_DIR')) as tmpdir:
-                    runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
-                    output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
+                    runfetchcmd(['tar', '-xzf', ud.fullmirror], d, workdir=tmpdir)
+                    output = runfetchcmd(ud.basecmd + ['remote'], d, quiet=True, workdir=ud.clonedir)
                     if 'mirror' in output:
-                        runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
-                    runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
-                    fetch_cmd = "%s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
+                        runfetchcmd(ud.basecmd + ['remote', 'rm', 'mirror'], d, workdir=ud.clonedir)
+                    runfetchcmd(ud.basecmd + ['remote', 'add', '--mirror=fetch', 'mirror', tmpdir], d, workdir=ud.clonedir)
+                    fetch_cmd = ud.basecmd + ['fetch', '-f', '--update-head-ok', '--progress', 'mirror']
                     runfetchcmd(fetch_cmd, d, workdir=ud.clonedir, extraenv={'LANG':'C'})
         repourl = self._get_repo_url(ud)
 
@@ -407,7 +409,7 @@ class Git(FetchMethod):
             # repository in which case it needs to be deleted and re-cloned.
             try:
                 # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
-                output = runfetchcmd("%s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir, extraenv={'LANG':'C'})
+                output = runfetchcmd(ud.basecmd + ['rev-parse', '--absolute-git-dir'], d, workdir=ud.clonedir, extraenv={'LANG':'C'})
                 toplevel = output.rstrip()
 
                 if not bb.utils.path_is_descendant(toplevel, ud.clonedir):
@@ -434,7 +436,7 @@ class Git(FetchMethod):
                 objects = os.path.join(repourl_path, 'objects')
                 if os.path.isdir(objects) and not os.path.islink(objects):
                     repourl = repourl_path
-            clone_cmd = "%s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            clone_cmd = ud.basecmd + ['clone', '--bare', '--mirror', repourl, ud.clonedir, '--progress']
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -460,23 +462,23 @@ class Git(FetchMethod):
 
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
-            output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
+            output = runfetchcmd(ud.basecmd + ['remote'], d, quiet=True, workdir=ud.clonedir)
             if "origin" in output:
-              runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
+              runfetchcmd(ud.basecmd + ['remote', 'rm', 'origin'], d, workdir=ud.clonedir)
 
-            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
+            runfetchcmd(ud.basecmd + ['remote', 'add', '--mirror=fetch', 'origin', repourl], d, workdir=ud.clonedir)
 
             if ud.nobranch:
-                fetch_cmd = "%s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
+                fetch_cmd = ud.basecmd + ['fetch', '-f', '--progress', repourl, 'refs/*:refs/*']
             else:
-                fetch_cmd = "%s fetch -f --progress %s refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repourl))
+                fetch_cmd = ud.basecmd + ['fetch', '-f', '--progress', repourl, 'refs/heads/*:refs/heads/*', 'refs/tags/*:refs/tags/*']
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
             runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir, extraenv={'LANG':'C'})
-            runfetchcmd("%s repack -adk" % ud.basecmd, d, workdir=ud.clonedir)
-            runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
-            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
+            runfetchcmd(ud.basecmd + ['repack','-adk'], d, workdir=ud.clonedir)
+            runfetchcmd(ud.basecmd + ['pack-refs','--all'], d, workdir=ud.clonedir)
+            runfetchcmd(ud.basecmd + ['prune-packed'], d, workdir=ud.clonedir)
             try:
                 os.unlink(ud.fullmirror)
             except OSError as exc:
@@ -501,11 +503,11 @@ class Git(FetchMethod):
                 self._ensure_git_lfs(d, ud)
 
                 # Using worktree with the revision because .lfsconfig may exists
-                worktree_add_cmd = "%s worktree add wt %s" % (ud.basecmd, revision)
+                worktree_add_cmd = ud.basecmd + ['worktree', 'add', 'wt', revision]
                 runfetchcmd(worktree_add_cmd, d, log=progresshandler, workdir=clonedir)
-                lfs_fetch_cmd = "%s lfs fetch %s" % (ud.basecmd, "--all" if fetchall else "")
+                lfs_fetch_cmd = ud.basecmd + ['lfs', 'fetch', "--all" if fetchall else ""]
                 runfetchcmd(lfs_fetch_cmd, d, log=progresshandler, workdir=(clonedir + "/wt"))
-                worktree_rem_cmd = "%s worktree remove -f wt" % ud.basecmd
+                worktree_rem_cmd = ud.basecmd + ['worktree', 'remove', '-f', 'wt']
                 runfetchcmd(worktree_rem_cmd, d, log=progresshandler, workdir=clonedir)
         except:
             logger.warning("Fetching LFS did not succeed.")
@@ -535,11 +537,10 @@ class Git(FetchMethod):
 
             logger.info("Creating tarball of git repository")
             with self.create_atomic(ud.fullmirror) as tfile:
-                mtime = runfetchcmd("{} log --all -1 --format=%cD".format(ud.basecmd), d,
+                mtime = runfetchcmd(ud.basecmd + ['log', '--all', '-1', '--format=%cD'], d,
                         quiet=True, workdir=ud.clonedir)
-                runfetchcmd("tar -czf %s --owner oe:0 --group oe:0 --mtime \"%s\" ."
-                        % (tfile, mtime), d, workdir=ud.clonedir)
-            runfetchcmd("touch %s.done" % ud.fullmirror, d)
+                runfetchcmd(['tar', '-czf', tfile, '--owner', 'oe:0', '--group', 'oe:0', '--mtime', mtime, '.'], d, workdir=ud.clonedir)
+            runfetchcmd(['touch', "%s.done" % ud.fullmirror], d)
 
     def clone_shallow_with_tarball(self, ud, d):
         for fast in [True, False]:
@@ -555,8 +556,8 @@ class Git(FetchMethod):
                     continue
                 logger.info("Creating tarball of git repository")
                 with self.create_atomic(ud.fullshallow) as tfile:
-                    runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
-                runfetchcmd("touch %s.done" % ud.fullshallow, d)
+                    runfetchcmd(['tar', '-czf', tfile, '.'], d, workdir=shallowclone)
+                runfetchcmd(['touch', '%s.done' % ud.fullshallow], d)
                 return True
         return False
 
@@ -570,9 +571,9 @@ class Git(FetchMethod):
         progresshandler = GitProgressHandler(d)
         repourl = self._get_repo_url(ud)
         bb.utils.mkdirhier(dest)
-        init_cmd = "%s init -q" % ud.basecmd
+        init_cmd = ud.basecmd + ['init', '-q']
         if ud.bareclone:
-            init_cmd += " --bare"
+            init_cmd.append('--bare')
         runfetchcmd(init_cmd, d, workdir=dest)
         # Use repourl when creating a fast initial shallow clone
         # Prefer already existing full bare clones if available
@@ -580,12 +581,12 @@ class Git(FetchMethod):
             remote = shlex.quote(repourl)
         else:
             remote = ud.clonedir
-        runfetchcmd("%s remote add origin %s" % (ud.basecmd, remote), d, workdir=dest)
+        runfetchcmd(ud.basecmd + ['remote', 'add', 'origin', remote], d, workdir=dest)
 
         # Check the histories which should be excluded
-        shallow_exclude = ''
+        shallow_exclude = []
         for revision in ud.shallow_revs:
-            shallow_exclude += " --shallow-exclude=%s" % revision
+            shallow_exclude.append("--shallow-exclude=%s" % revision)
 
         revision = ud.revision
         depth = ud.shallow_depths[ud.name]
@@ -605,9 +606,9 @@ class Git(FetchMethod):
         else:
             ref = "refs/remotes/origin/%s" % branch
 
-        fetch_cmd = "%s fetch origin %s" % (ud.basecmd, revision)
+        fetch_cmd = ud.basecmd + ['fetch', 'origin', revision]
         if depth:
-            fetch_cmd += " --depth %s" % depth
+            fetch_cmd += ['--depth', str(depth)]
 
         if shallow_exclude:
             fetch_cmd += shallow_exclude
@@ -616,17 +617,17 @@ class Git(FetchMethod):
         # error: Server does not allow request for unadvertised object.
         # The ud.clonedir is a local temporary dir, will be removed when
         # fetch is done, so we can do anything on it.
-        adv_cmd = 'git branch -f advertise-%s %s' % (revision, revision)
+        adv_cmd = ['git', 'branch', '-f', 'advertise-' + revision, revision]
         if ud.shallow_skip_fast:
             runfetchcmd(adv_cmd, d, workdir=ud.clonedir)
 
         runfetchcmd(fetch_cmd, d, workdir=dest)
-        runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
+        runfetchcmd(ud.basecmd + ['update-ref', ref, revision], d, workdir=dest)
         # Fetch Git LFS data
         self.lfs_fetch(ud, d, dest, ud.revision)
 
         # Apply extra ref wildcards
-        all_refs_remote = runfetchcmd("%s ls-remote origin 'refs/*'" % ud.basecmd, \
+        all_refs_remote = runfetchcmd(ud.basecmd + ['ls-remote', 'origin', 'refs/*'], \
                                         d, workdir=dest).splitlines()
         all_refs = []
         for line in all_refs_remote:
@@ -644,14 +645,12 @@ class Git(FetchMethod):
 
         for ref in extra_refs:
             ref_fetch = ref.replace('refs/heads/', '').replace('refs/remotes/origin/', '').replace('refs/tags/', '')
-            runfetchcmd("%s fetch origin --depth 1 -- %s" %
-                        (ud.basecmd, shlex.quote(ref_fetch)), d, workdir=dest)
-            revision = runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecmd, d, workdir=dest)
-            runfetchcmd("%s update-ref %s %s" %
-                        (ud.basecmd, shlex.quote(ref), revision), d, workdir=dest)
+            runfetchcmd(ud.basecmd + ['fetch', 'origin', '--depth', '1', '--', ref_fetch], d, workdir=dest)
+            revision = runfetchcmd(ud.basecmd + ['rev-parse', 'FETCH_HEAD'], d, workdir=dest).strip()
+            runfetchcmd(ud.basecmd + ['update-ref', ref, revision], d, workdir=dest)
 
         # The url is local ud.clonedir, set it to upstream one
-        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=dest)
+        runfetchcmd(ud.basecmd + ['remote', 'set-url', 'origin', repourl], d, workdir=dest)
 
     def unpack_update(self, ud, destdir, d):
         return self.unpack(ud, destdir, d, update=True)
@@ -687,8 +686,9 @@ class Git(FetchMethod):
 
         need_lfs = self._need_lfs(ud)
 
+        extraenv = {}
         if not need_lfs:
-            ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
+            extraenv["GIT_LFS_SKIP_SMUDGE"] = "1"
 
         source_found = False
         update_mode = False
@@ -699,7 +699,7 @@ class Git(FetchMethod):
             if update and os.path.exists(destdir):
                 update_mode = True
             else:
-                runfetchcmd("%s clone %s %s %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+                runfetchcmd(ud.basecmd + ['clone'] + ud.cloneflags + [ud.clonedir, destdir], d, extraenv=extraenv)
             source_found = True
         else:
             source_error.append("clone directory not available or not up to date: " + ud.clonedir)
@@ -711,7 +711,7 @@ class Git(FetchMethod):
                         update_mode = True
                     else:
                         bb.utils.mkdirhier(destdir)
-                        runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
+                        runfetchcmd(['tar', '-xzf', ud.fullshallow], d, workdir=destdir)
                     source_found = True
                 else:
                     source_error.append("shallow clone not available: " + ud.fullshallow)
@@ -725,26 +725,26 @@ class Git(FetchMethod):
             if ud.shallow:
                 raise bb.fetch2.UnpackError("Can't update shallow clones checkouts without network access, not supported.", ud.url)
 
-            output = runfetchcmd("%s status --untracked-files=no --porcelain" % (ud.basecmd), d, workdir=destdir)
+            output = runfetchcmd(ud.basecmd + ['status', '--untracked-files=no', '--porcelain'], d, workdir=destdir, extraenv=extraenv)
             if output:
                 raise bb.fetch2.LocalModificationsError(destdir, ud.url, output)
 
             # Set up remote for the download location if it doesn't exist
             try:
-                runfetchcmd("%s remote get-url dldir" % (ud.basecmd), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['remote', 'get-url', 'dldir'], d, workdir=destdir)
             except bb.fetch2.FetchError:
                 if ud.clonedir:
-                    runfetchcmd("%s remote add dldir file://%s" % (ud.basecmd, ud.clonedir), d, workdir=destdir)
+                    runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', 'file://' + ud.clonedir], d, workdir=destdir)
             try:
-                runfetchcmd("%s fetch dldir" % (ud.basecmd), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['fetch', 'dldir'], d, workdir=destdir, extraenv=extraenv)
             except bb.fetch2.FetchError as e:
                 raise bb.fetch2.UnpackError("Failed to fetch from dldir remote: %s" % str(e), ud.url)
             try:
-                runfetchcmd("%s rebase --no-autosquash --no-autostash %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['rebase', '--no-autosquash', '--no-autostash', ud.revision], d, workdir=destdir, extraenv=extraenv)
             except bb.fetch2.FetchError as e:
                 # If rebase failed, abort it
                 try:
-                    runfetchcmd("%s rebase --abort" % (ud.basecmd), d, workdir=destdir)
+                    runfetchcmd(ud.basecmd + ['rebase', '--abort'], d, workdir=destdir)
                 except Exception:
                     pass
                 raise bb.fetch2.RebaseError(destdir, ud.url, str(e))
@@ -753,23 +753,23 @@ class Git(FetchMethod):
         # If there is a tag parameter in the url and we also have a fixed srcrev, check the tag
         # matches the revision
         if 'tag' in ud.parm and sha1_re.match(ud.revision):
-            output = runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, ud.parm['tag']), d, workdir=destdir)
+            output = runfetchcmd(ud.basecmd + ['rev-list', '-n', '1', ud.parm['tag']], d, workdir=destdir, extraenv=extraenv)
             output = output.strip()
             if output != ud.revision:
                 # It is possible ud.revision is the revision on an annotated tag which won't match the output of rev-list
                 # If it resolves to the same thing there isn't a problem.
-                output2 = runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
+                output2 = runfetchcmd(ud.basecmd + ['rev-list', '-n', '1', ud.revision], d, workdir=destdir)
                 output2 = output2.strip()
                 if output != output2:
                     raise bb.fetch2.FetchError("The revision the git tag '%s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'], output, ud.revision), ud.url)
 
         repourl = self._get_repo_url(ud)
-        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=destdir)
+        runfetchcmd(ud.basecmd + ['remote', 'set-url', 'origin', repourl], d, workdir=destdir)
         if ud.clonedir:
             try:
-                runfetchcmd("%s remote get-url dldir" % (ud.basecmd), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['remote', 'get-url', 'dldir'], d, workdir=destdir)
             except bb.fetch2.FetchError:
-                runfetchcmd("%s remote add dldir file://%s" % (ud.basecmd, ud.clonedir), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', "file://" + ud.clonedir], d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
             if not need_lfs:
@@ -777,27 +777,22 @@ class Git(FetchMethod):
             else:
                 self._ensure_git_lfs(d, ud)
 
-                runfetchcmd("%s lfs install --local" % ud.basecmd, d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['lfs', 'install', '--local'], d, workdir=destdir)
 
         if not ud.nocheckout:
             if subpath:
-                runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revision, readpathspec), d,
-                            workdir=destdir)
-                runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d, workdir=destdir)
-                runfetchcmd("%s update-ref --no-deref HEAD %s" % (ud.basecmd, ud.revision),
-                            d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['read-tree', ud.revision + readpathspec], d, workdir=destdir, extraenv=extraenv)
+                runfetchcmd(ud.basecmd + ['checkout-index', '-q', '-f', '-a'], d, workdir=destdir, extraenv=extraenv)
+                runfetchcmd(ud.basecmd + ['update-ref', '--no-deref', 'HEAD', ud.revision], d, workdir=destdir, extraenv=extraenv)
                 if not ud.nobranch:
                     branchname = ud.branch
-                    runfetchcmd("%s update-ref refs/heads/%s %s" % (ud.basecmd, branchname,
-                                ud.revision), d, workdir=destdir)
+                    runfetchcmd(ud.basecmd + ['update-ref', 'refs/heads/' + branchname, ud.revision], d, workdir=destdir, extraenv=extraenv)
             elif not ud.nobranch:
                 branchname =  ud.branch
-                runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
-                            ud.revision), d, workdir=destdir)
-                runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
-                            branchname), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['checkout', '-B', branchname, ud.revision], d, workdir=destdir, extraenv=extraenv)
+                runfetchcmd(ud.basecmd + ['branch', branchname, '--set-upstream-to', 'origin/' + branchname], d, workdir=destdir, extraenv=extraenv)
             else:
-                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
+                runfetchcmd(ud.basecmd + ['checkout', ud.revision], d, workdir=destdir, extraenv=extraenv)
 
         return True
 
@@ -825,22 +820,17 @@ class Git(FetchMethod):
         return True
 
     def _contains_ref(self, ud, d, name, wd, tag=False):
-        cmd = ""
         git_ref_name = 'refs/tags/%s' % ud.parm['tag'] if tag else ud.revision
 
         if ud.nobranch:
-            cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (
-                ud.basecmd, git_ref_name)
+            cmd = ud.basecmd + ['log', '--pretty=oneline', '-n', '1', git_ref_name, "--"]
         else:
-            cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
-                ud.basecmd, git_ref_name, ud.branch)
+            cmd = ud.basecmd + ['branch', '--contains', git_ref_name, '--list', ud.branch]
         try:
-            output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
-        except bb.fetch2.FetchError:
+            output = runfetchcmd(cmd, d, workdir=wd)
+        except (bb.fetch2.FetchError):
             return False
-        if len(output.split()) > 1:
-            raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
-        return output.split()[0] != "0"
+        return len(output.splitlines()) > 0
 
     def _lfs_objects_downloaded(self, ud, d, wd):
         """
@@ -855,8 +845,7 @@ class Git(FetchMethod):
         # The Git LFS specification specifies ([1]) the LFS folder layout so it should be safe to check for file
         # existence.
         # [1] https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md#intercepting-git
-        cmd = "%s lfs ls-files -l %s" \
-                % (ud.basecmd, ud.revision)
+        cmd = ud.basecmd + ['lfs', 'ls-files', '-l', ud.revision]
         output = runfetchcmd(cmd, d, quiet=True, workdir=wd).rstrip()
         # Do not do any further matching if no objects are managed by LFS
         if not output:
@@ -880,12 +869,10 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-        cmd = "%s grep '^[^#].*lfs' %s:.gitattributes | wc -l" % (
-            ud.basecmd, ud.revision)
-
+        cmd = ud.basecmd + ['grep', '^[^#].*lfs',  ud.revision + ':.gitattributes']
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
-            if int(output) > 0:
+            if len(output.splitlines()) > 0:
                 return True
         except (bb.fetch2.FetchError,ValueError):
             pass
@@ -937,8 +924,9 @@ class Git(FetchMethod):
         d.setVar('_BB_GIT_IN_LSREMOTE', '1')
         try:
             repourl = self._get_repo_url(ud)
-            cmd = "%s ls-remote %s %s" % \
-                (ud.basecmd, shlex.quote(repourl), search)
+            cmd = ud.basecmd + ['ls-remote', repourl]
+            if search:
+                cmd.append(search)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, cmd, repourl)
             output = runfetchcmd(cmd, d, True)
@@ -1041,11 +1029,9 @@ class Git(FetchMethod):
             commits = None
         else:
             if not os.path.exists(rev_file) or not os.path.getsize(rev_file):
-                commits = bb.fetch2.runfetchcmd(
-                        "git rev-list %s -- | wc -l" % shlex.quote(rev),
-                        d, quiet=True).strip().lstrip('0')
+                commits = bb.fetch2.runfetchcmd(['git', 'rev-list', rev, '--'], d).splitlines()
                 if commits:
-                    open(rev_file, "w").write("%d\n" % int(commits))
+                    open(rev_file, "w").write("%d\n" % len(commits))
             else:
                 commits = open(rev_file, "r").readline(128).strip()
         if commits:
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 80a808d88f0..b0b2c229eeb 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -27,7 +27,7 @@ class GitANNEX(Git):
     def uses_annex(self, ud, d, wd):
         for name in ud.names:
             try:
-                runfetchcmd("%s rev-list git-annex" % (ud.basecmd), d, quiet=True, workdir=wd)
+                runfetchcmd(ud.basecmd + ['rev-list', 'git-annex'], d, quiet=True, workdir=wd)
                 return True
             except bb.fetch.FetchError:
                 pass
@@ -36,10 +36,10 @@ class GitANNEX(Git):
 
     def update_annex(self, ud, d, wd):
         try:
-            runfetchcmd("%s annex get --all" % (ud.basecmd), d, quiet=True, workdir=wd)
+            runfetchcmd(ud.basecmd + ['annex get', '--all'], d, quiet=True, workdir=wd)
         except bb.fetch.FetchError:
             return False
-        runfetchcmd("chmod u+w -R %s/annex" % (ud.clonedir), d, quiet=True, workdir=wd)
+        runfetchcmd(['chmod', 'u+w', '-R', '%s/annex' % ud.clonedir], d, quiet=True, workdir=wd)
 
         return True
 
@@ -54,24 +54,24 @@ class GitANNEX(Git):
         super(GitANNEX, self).clone_shallow_local(ud, dest, d)
 
         try:
-            runfetchcmd("%s annex init" % ud.basecmd, d, workdir=dest)
+            runfetchcmd(ud.basecmd + ['annex', 'init'], d, workdir=dest)
         except bb.fetch.FetchError:
             pass
 
         if self.uses_annex(ud, d, dest):
-            runfetchcmd("%s annex get" % ud.basecmd, d, workdir=dest)
-            runfetchcmd("chmod u+w -R %s/.git/annex" % (dest), d, quiet=True, workdir=dest)
+            runfetchcmd(ud.basecmd + ['annex', 'get'], d, workdir=dest)
+            runfetchcmd(['chmod', 'u+w', '-R',  '%s/.git/annex' % dest], d, quiet=True, workdir=dest)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
 
         try:
-            runfetchcmd("%s annex init" % (ud.basecmd), d, workdir=ud.destdir)
+            runfetchcmd(ud.basecmd + ['annex' ,'init'], d, workdir=ud.destdir)
         except bb.fetch.FetchError:
             pass
 
         annex = self.uses_annex(ud, d, ud.destdir)
         if annex:
-            runfetchcmd("%s annex get" % (ud.basecmd), d, workdir=ud.destdir)
-            runfetchcmd("chmod u+w -R %s/.git/annex" % (ud.destdir), d, quiet=True, workdir=ud.destdir)
+            runfetchcmd(ud.basecmd + ['annex', 'get'], d, workdir=ud.destdir)
+            runfetchcmd(['chmod', 'u+w', '-R',  '%s/.git/annex' % ud.destdir], d, quiet=True, workdir=ud.destdir)
 
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5869e1b99b7..d4340e11651 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -63,14 +63,14 @@ class GitSM(Git):
 
         # Collect the defined submodules, and their attributes
         try:
-            gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revision), d, quiet=True, workdir=workdir)
+            gitmodules = runfetchcmd(ud.basecmd + ['show', '%s:.gitmodules' % ud.revision], d, quiet=True, workdir=workdir)
         except:
             # No submodules to update
             gitmodules = ""
 
         for m, md in parse_gitmodules(gitmodules).items():
             try:
-                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revision, md['path']), d, quiet=True, workdir=workdir)
+                module_hash = runfetchcmd(ud.basecmd + ['ls-tree', '-z', '-d', ud.revision, md['path']], d, quiet=True, workdir=workdir)
             except:
                 # If the command fails, we don't have a valid file to check.  If it doesn't
                 # fail -- it still might be a failure, see next check...
@@ -155,7 +155,7 @@ class GitSM(Git):
         if ud.shallow and os.path.exists(ud.fullshallow) and unpack:
             tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
             try:
-                runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+                runfetchcmd(['tar', '-xzf', ud.fullshallow], d, workdir=tmpdir)
                 self.process_submodules(ud, tmpdir, subfunc, d)
             finally:
                 shutil.rmtree(tmpdir)
@@ -228,14 +228,14 @@ class GitSM(Git):
             local_path = newfetch.localpath(url)
 
             # Correct the submodule references to the local download version...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
+            runfetchcmd(ud.basecmd + ['config', 'submodule.%s.url' % module, local_path], d, workdir=ud.destdir)
 
             if ud.shallow:
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
+                runfetchcmd(ud.basecmd + ['config', 'submodule.%s.shallow' % module, 'true'], d, workdir=ud.destdir)
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
             try:
-                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', module))
+                runfetchcmd(ud.basecmd + ['config', 'core.bare', 'false'], d, quiet=True, workdir=os.path.join(repo_conf, 'modules', module))
             except:
                 logger.error("Unable to set git config core.bare to false for %s" % os.path.join(repo_conf, 'modules', module))
                 raise
@@ -245,11 +245,12 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            cmdprefix = ""
+            extraenv = {}
             # Avoid LFS smudging (replacing the LFS pointers with the actual content) when LFS shouldn't be used but git-lfs is installed.
             if not self._need_lfs(ud):
-                cmdprefix = "GIT_LFS_SKIP_SMUDGE=1 "
-            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (cmdprefix, ud.basecmd), d, quiet=True, workdir=ud.destdir)
+                extraenv['GIT_LFS_SKIP_SMUDGE'] = '1'
+            runfetchcmd(ud.basecmd + ['submodule', 'update', '--recursive', '--no-fetch'], d, quiet=True, workdir=ud.destdir, extraenv=extraenv)
+
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"

