Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B02108B909
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:00:49 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10925.1774008046594970786
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 05:00:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VMZZU2X5;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so4936525e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008045; x=1774612845; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNY/GbeWqN43R/X/a7WPl99LjmIuS+fGD4ZKMyd2W/w=;
        b=VMZZU2X5wzxgzdZQGss2fZIM9OaK3Q6UwnbIBz3awJGcTH/pO1fwW2c48XM1zjlYYc
         +zeNtO2ztWM7uV2yY2YCfbJUzLNAL8mo5pHWtArYTg5LVpotXm389MlrO2o3FMAgAGip
         gqKlGwG49yJ6fgE7jQVTfeA7Fk3J1EBjtxR2FsxeYnThcX70zUnAWZmZqASzflcwK+T3
         7Ajxul6BIR35du89wrX5IL2Ola9pb7YOkc9JrzkZpc2sD1LxDSBQviy4DE0NB16wygLm
         01opvK8PKMP4lve6eyEUbF4TBkeAv2w3PQBo8/puNpMugRcTGrSFwzQOPF4wZN14si+O
         f8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008045; x=1774612845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNY/GbeWqN43R/X/a7WPl99LjmIuS+fGD4ZKMyd2W/w=;
        b=qh85Oq7M3vkibXoHVo55Q20RwpwJnNzKvber4+KpfroUe8DaFXBYIpp7ztEPDiQGTR
         uvCDKvjqpSfwfsHf/TAg2y0vJwtIaNH2EVSY0KzHHKC3RzNhC39PLRMhCB18SUpXf13S
         P6iQIow7GPyp40uECTsZ3CPr3qzoIHXdjlpCTVYmeymDmeigS7HpRHHkyIvJVFWlQH92
         1LNnSq+NnjhFfs3Z73zZMTOftt1a6Y/iVBOAbtdGZmj2azMBGaHId0wZZ6bY/mJhQSpY
         r4ZvH/Au/t+NSZ7lOpFwKiFWJjziRSvrp7X2IYYugVnjQM3nWxiULgtQV5JEbJcfuFcG
         Dw/w==
X-Gm-Message-State: AOJu0Yx6nEBZfOadWhbLbBdPRpeMFpxo63QFCHyFChM+j7Nwa+ieO10T
	2ubJJxsqIHDZRxfkZCEozfLOuzFkWuEZvywatwzVlTSFlobtfgvPivM/y3K6ew==
X-Gm-Gg: ATEYQzxcwYQd8JYE5q1V2FyLi8W82HN8ZmwQIdueXj7IpsYee7obymE4TlykFPL6JV6
	O/E27Ngk+bR0oUut+axTZLGpJPT7SRSH5iDFVskV5B0xtClqgFxYhWMBVWa2nJLCBB+dckiBL8P
	qxAHiD2NEzvU38/b64qz5F+SQ4W2/g5D0/v3KQYvXDgr5WZ/9BVullLu+ChNb7ZEEQYjTaIXHCP
	uewu0DmAHpJnFdtrZAkEp5So48Gx859I11pES5+Plh/DFIFPRSfVWs7pZEeLaIBrTdwsFkBa+er
	vw6mnf8p1Tt8akHx8wo49V4fv+5x0zB12MigLrbvpKbs60ZWJ9PQITWGU4nGp67k/zMWSmYPbkV
	tyRm8Pl2sv5E8Kk8XjcXEKTn+x1x94UtTOieonEhaaDbMAbeUthbXq6cV6rwyLSL/WEsmc5k8HW
	/U4t8p3awFBUU8IpbsSPnGX/jULlzhzk/Ojoq2PAuDILlsbyaFyhmCZUVnfc8=
X-Received: by 2002:a05:600c:8b46:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-486fee0fc11mr40977415e9.18.1774008043155;
        Fri, 20 Mar 2026 05:00:43 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fd9845a2sm126070095e9.6.2026.03.20.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:00:42 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v4] bitbake-setup: use non-destructive 'update' mode of the git fetcher
Date: Fri, 20 Mar 2026 13:00:40 +0100
Message-ID: <20260320120040.3017651-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 12:00:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19189

From: Alexander Kanavin <alex@linutronix.de>

This allows removing the git hook that prohibited making commits
in repositories under layers/, significantly improving user experience.

bitbake-setup logic is adjusted to account for:

- if a git checkout is being replaced with a local symlink,
that checkout is moved to a backup location, regardless of whether
it has local changes or not

The tests are modified so that:

- the check for layer backups is run earlier, and check that
backups happen when they're supposed to (which should be just once).

- the test that previously checked that local commits are rejected
is adjusted to check that such a commit is accepted, and layer
is updated from remote without creating a backup directory.

- a test is added to force a rebase conflict on update, and
check that it indeed happens. We can think of better ways
to handle rebase conflicts in bitbake-setup later on; right now
it simply stops at that point.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
v2: removed bogus empty 'aaaa' file which was from a local experiment
v3: removed auto-stashing of uncommitted changes
v4: adjusted commit message to not mention auto-stash
---
 bin/bitbake-setup     | 40 ++--------------------------------------
 lib/bb/tests/setup.py | 42 +++++++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ca4461b1e..dcad9c169 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -191,39 +191,6 @@ def checkout_layers(layers, confdir, layerdir, d):
         logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
         os.symlink(src, dst)
 
-    def _has_local_modifications(r_name, r_path):
-        fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
-
-        if not r_name in fixed_revisions['sources']:
-            logger.warning("""Source {} is added with path {}.
-This path already exists, but it has no entry in a fixed revisions
-record. To ensure possible local modifications are not lost, it will
-be preserved in a backup directory.""".format(r_name, r_path))
-            return True
-
-        rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
-        status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
-        if status:
-            return True
-        diff = bb.process.run('git -C {} diff {} {}'.format(r_path, get_diff_color_param(), rev))[0]
-        if diff:
-            return True
-        return False
-
-    def _restrict_commits(r_name, r_path):
-        hook_path = os.path.join(r_path, '.git', 'hooks', 'pre-commit')
-        restrict_hook = """#!/bin/sh
-echo "This repository is managed by bitbake-setup, and making commits is restricted.
-If you wish to make local modifications, clone it separately, and re-initialize using
-bitbake-setup init -L {} /path/to/repo/checkout"
-exit 1
-""".format(r_name)
-        with open(hook_path, 'w') as f:
-            f.write(restrict_hook)
-        import stat
-        st = os.stat(hook_path)
-        os.chmod(hook_path, st.st_mode | stat.S_IEXEC)
-
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
     oesetupbuild = None
@@ -242,19 +209,16 @@ exit 1
         if os.path.lexists(repodir_path):
             if os.path.islink(repodir_path):
                 os.remove(repodir_path)
-            elif _has_local_modifications(r_name, repodir_path):
+            elif r_local:
                 backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
                 logger.warning("""Source {} in {} contains local modifications. Renaming to {} to preserve them.
 For local development work it is recommended to clone the needed layers separately and re-initialize using -L option:
 bitbake-setup init -L {} /path/to/repo/checkout""".format(
                     r_name, repodir_path, backup_path, r_name))
                 os.rename(repodir_path, backup_path)
-            else:
-                shutil.rmtree(repodir_path)
 
         if r_remote:
             _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
-            _restrict_commits(r_name, repodir_path)
         if r_local:
             _symlink_local(os.path.expanduser(r_local["path"]), repodir_path)
 
@@ -830,7 +794,7 @@ def do_fetch(fetcher, dir):
         oldstdout = sys.stdout
         sys.stdout = f
         fetcher.download()
-        fetcher.unpack(dir)
+        fetcher.unpack_update(dir)
         sys.stdout = oldstdout
 
 def update_registry(registry, cachedir, d):
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index e3557d8f3..a66f05b36 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -447,16 +447,27 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
             self.config_is_unchanged(custom_setup_path)
 
+        def _check_layer_backups(layer_path, expected_backups):
+            files = os.listdir(layer_path)
+            backups = len([f for f in files if 'backup' in f])
+            self.assertEqual(backups, expected_backups, msg = "Expected {} layer backups, got {}, directory listing: {}".format(expected_backups, backups, files))
+
         # Change the configuration to refer to a local source, then to another local source, then back to a git remote
         # Run status/update after each change and verify that nothing breaks
+        # Also check that layer backups happen when expected
         c = 'gadget'
         setuppath = self.get_setup_path('test-config-1', c)
         self.config_is_unchanged(setuppath)
 
+        layers_path = os.path.join(setuppath, 'layers')
+        layer_path = os.path.join(layers_path, 'test-repo')
+        _check_layer_backups(layers_path, 0)
+
         json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
         out = self.runbbsetup("update --update-bb-conf='yes'")
         _check_local_sources(setuppath)
+        _check_layer_backups(layers_path, 1)
 
         prev_path = self.testrepopath
         self.testrepopath = prev_path + "-2"
@@ -465,23 +476,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
         out = self.runbbsetup("update --update-bb-conf='yes'")
         _check_local_sources(setuppath)
+        _check_layer_backups(layers_path, 1)
 
         self.testrepopath = prev_path
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
         out = self.runbbsetup("update --update-bb-conf='yes'")
         self.check_setupdir_files(setuppath, test_file_content)
-
-        # Also check that there are no layer backups up to this point, then make a change that should
-        # result in a layer backup, and check that it does happen.
-        def _check_layer_backups(layer_path, expected_backups):
-            files = os.listdir(layer_path)
-            backups = len([f for f in files if 'backup' in f])
-            self.assertEqual(backups, expected_backups, msg = "Expected {} layer backups, got {}, directory listing: {}".format(expected_backups, backups, files))
-
-        layers_path = os.path.join(setuppath, 'layers')
-        layer_path = os.path.join(layers_path, 'test-repo')
-        _check_layer_backups(layers_path, 0)
+        _check_layer_backups(layers_path, 1)
 
         ## edit a file without making a commit
         with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
@@ -492,16 +494,26 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         out = self.runbbsetup("update --update-bb-conf='yes'")
         _check_layer_backups(layers_path, 1)
 
-        ## edit a file and try to make a commit; this should be rejected
+        ## edit a file and make a commit such that no rebase conflicts occur
         with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
             f.write('locally-modified-again\n')
         self.git('add .', cwd=layer_path)
-        with self.assertRaisesRegex(bb.process.ExecutionError, "making commits is restricted"):
-            self.git('commit -m "Adding a local modification"', cwd=layer_path)
+        self.git('commit -m "Adding a local modification"', cwd=layer_path)
         test_file_content = "modified-again-and-again\n"
         self.add_file_to_testrepo('test-file', test_file_content)
         out = self.runbbsetup("update --update-bb-conf='yes'")
-        _check_layer_backups(layers_path, 2)
+        _check_layer_backups(layers_path, 1)
+
+        ## edit a file and make a commit in a way that causes a rebase conflict
+        with open(os.path.join(layer_path, 'test-file'), 'w') as f:
+            f.write('locally-modified\n')
+        self.git('add .', cwd=layer_path)
+        self.git('commit -m "Adding a local modification"', cwd=layer_path)
+        test_file_content = "remotely-modified\n"
+        self.add_file_to_testrepo('test-file', test_file_content)
+        with self.assertRaisesRegex(bb.process.ExecutionError, "Merge conflict in test-file"):
+            out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_layer_backups(layers_path, 1)
 
         # check source overrides, local sources provided with symlinks, and custom setup dir name
         source_override_content = """
-- 
2.47.3


