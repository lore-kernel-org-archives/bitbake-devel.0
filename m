Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112B4109190A
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 18:18:44 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2931.1773944314549996803
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 11:18:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kIgpq5gA;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd27754bso4964395e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944313; x=1774549113; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CgBhB2NpIhu9PLBioIjGjKeWx+1rA7wMhC8G1ww2Tcc=;
        b=kIgpq5gAW4baavFm9buxIClGlv4Ue3yDWXHtkWHiBZeVxr/tNVvcJU4LdM60jNZvZB
         Mc+FXRj0bLbF7Y5MT2KCPdFa5Nqqyt8NCiJ0IXF+bHFLoByc3r4GVfX/boRJIRhuAOVn
         Kjhw9TU/p6Ij9s3RT+acc+op3w8f1BHr3aCZ7yTv4dbYyqvBMA4TUtUS1HyVnLwFfFLE
         l2BebvvPHMkArvJ3k2233zwCluu1FgiG7gxF11/M6HPrjdB3b8NE0ie+PE8PuSpOuIRd
         Sxe6hCmc/d0GVv1E5pwB1ABroA+UsYto/ktCQkCnD5RdZ23wBnJ5r9ojN7KMk0S0CEkW
         BHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944313; x=1774549113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgBhB2NpIhu9PLBioIjGjKeWx+1rA7wMhC8G1ww2Tcc=;
        b=suSjw7FjOjN9xw2QR8pti1NpvyusOqv5cPj3Ox7AxGZoMirwKqCwIJNuHNxD7ln8dk
         JRZndlZpGAJNkqlrL5lXu6W1tHxovTw2gUfffxjGWaUWfnoC8eOw1qUy0dKJnJXgKstm
         LntcUV0EMzmHcIVWNFrwSLOWvG1RWqPUSq91uIyz127nM/2vFLAOJKMW4xWCgf/EOpuG
         rZcoacbjtTEhFv1H6E49e59pPgblQAIA+hIEqbocsuSb3yfhVmz8Z1qy4BHjWvEqqKAU
         zzZqDMjVrVHoL61V6hANBSkj08+NzHyuLOFwvEuUS8DYiZThb4UUJO19Xp45gt7uxQeY
         jyTQ==
X-Gm-Message-State: AOJu0YwmD4SowuDM5pLr/Cr8dF1swhO4TjVw55ZohpRVSn8cvMeq4HFu
	zxHRtY9GQpJT0jMKrG28KpNn8Xjc2mU4fEVIgxdFPNQLBbIxBLS1xbkbQ6lqTQ==
X-Gm-Gg: ATEYQzyVpZL8QWQJ2Szp4KTXF22jDG0/Qfd1odgQSWmSphtk4BhBOr9SaD1j6jQttoo
	wPWWr44lK8TuT6dAD5t9D1UGgnaJ7h3l6h2Vut1zLMbU/R890cALOWWtstDVA6DTOUtTSNalIn3
	WiwX4qB9X6+/W+W8sDO0D9z/urrUhNsnqT51d/IV2zNy6PbSyXFnMhNE9gCWdkve7VDO7/1uSAl
	iLnhZzcV7JmDASOyfqfDDDan4Tdsd0OFapsBO5Uhse/Cbet3/lnyNTxzFL/ItAZYJrWbyekXv5Q
	BBluzUJ5YTdb4y1fcjhHyBznhYq1NtS10B+ppHMrs3IgR9kO/6K8gJZuPZ5WVIJStJhZeofFGT+
	56BAHLkQSVXCnLzdYhErcteYe/xswaibZMAr96cpyEzg6vOC715IyQCidxmsiWe/VzotshkOpwT
	7/gdfOfF5W8lGBWHNFOp+XswPq9yGR1FUR4JwXxbowqNLxQx7ytAAm/h98RUM=
X-Received: by 2002:a05:600c:8b0a:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-486fee0f917mr1420975e9.16.1773944312630;
        Thu, 19 Mar 2026 11:18:32 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4a74sm82794005e9.12.2026.03.19.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:18:32 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: use non-destructive 'update' mode of the git fetcher
Date: Thu, 19 Mar 2026 19:18:29 +0100
Message-ID: <20260319181829.2818648-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 18:18:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19173

From: Alexander Kanavin <alex@linutronix.de>

This allows removing the git hook that prohibited making commits
in repositories under layers/, significantly improving user experience.

bitbake-setup logic is adjusted to account for these situations:

- if a git checkout is being replaced with a local symlink,
that checkout is moved to a backup location, regardless of whether
it has local changes or not
- if a git checkout has uncommited changes, the 'update' mode is
going to fail. Bitbake-setup anticipates this, and stashes these
changes, with a warning.

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
 aaaa                  |  0
 bin/bitbake-setup     | 42 ++++++++----------------------------------
 lib/bb/tests/setup.py | 42 +++++++++++++++++++++++++++---------------
 3 files changed, 35 insertions(+), 49 deletions(-)
 create mode 100644 aaaa

diff --git a/aaaa b/aaaa
new file mode 100644
index 000000000..e69de29bb
diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ca4461b1e..a446efbd9 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -191,38 +191,10 @@ def checkout_layers(layers, confdir, layerdir, d):
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
+    def _has_uncommitted_changes(r_path):
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
             return True
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
 
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
@@ -242,19 +214,21 @@ exit 1
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
+            elif _has_uncommitted_changes(repodir_path):
+                logger.warning("""Source {} in {} contains uncommitted changes. They will be saved using 'git stash',
+to allow rebasing onto latest commits""".format(r_name, repodir_path))
+                bb.process.run("git -C {} add .".format(repodir_path))
+                bb.process.run("git -C {} stash".format(repodir_path))
 
         if r_remote:
             _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
-            _restrict_commits(r_name, repodir_path)
         if r_local:
             _symlink_local(os.path.expanduser(r_local["path"]), repodir_path)
 
@@ -830,7 +804,7 @@ def do_fetch(fetcher, dir):
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


