Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FEAFA3758
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:35:00 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11804.1767382494116412615
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KubLnmcB;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so2169659266b.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382492; x=1767987292; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zaPOJKSjunT5vNtkItcoKkfSyI6Xkz5e9Ne+wrTQgM=;
        b=KubLnmcBC25IsX/CcK66ZLW3xwpfm4zXylUsxdzhD5BlzmY/0U7iCKO2OlWNjLYsQ8
         UaeSZLJqt7/eOoF57jn2PqCRS8SE5Wzrz8BrXEL3f7o16NG6OfBGuPpkLJM/daVwDSKV
         bf7l57DHutbnPssIoSxY6OcQV3Wxl02YkAElKji6O0ahVqB05OWD48WUXMF7Q3bJEEiY
         STIeQQ7couCSjpaKdy1/1SFvpwklFwpxKF9sCPn8QQsEnBnhJcmHPGrvLXEFwkuk83P6
         S266LT1VZuYUx3vODKmyQqed22ePDr9NTW6j5vtBP5gksm87725vmg5txZERwwltxX+I
         E1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382492; x=1767987292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zaPOJKSjunT5vNtkItcoKkfSyI6Xkz5e9Ne+wrTQgM=;
        b=BQxUxvjMwaTgmdWjawrxb/y19vtxD3VLlkUQrMWo6Ac85cI2AQS97U0noh9iSFDi1W
         ijBeGdjNhRsl1vLs/xa68DkeTONFE8f6oKWt181pCAtyOM5ZzpgIsXG87MERm07288YY
         p36DRZlz91fy702rTeXpvXRl33ZQBSk2MiFDJ+ks0zGytkfnUqZRaootI+T0MoQrLWZk
         kesVzZ732zU6CtLnHIjOh/n4nbF0+G+hnzIj6++3/24yAAMg0oDkcpVopxPxc5HwHO/6
         8xiPqAADvFtlr5mvUalAP+4OkWtUatL8g2nNt9wk0VjVyKT9v54oeO284pvgySYwi/2D
         nIyQ==
X-Gm-Message-State: AOJu0YxtR0VCrYkHTFhdw5H/kTSuHOR4l1Pf6vSFFYLBiPYJyHO/Y534
	b9uTRK+2WyYIO8wQjRsvqwEKjonY9eWSS75+10Tfrw1R46DfXCHxJ9Wg6JfiWw==
X-Gm-Gg: AY/fxX6Yebs29WSK3IS50Ik8tZcninSMxnO3ktEQVl/ErMuXVhyypas3TdtDhnuoNqZ
	bhIiBu6RJ/1oD2k0dYGEFe1VAdkX06cDsnudJWXl3YxM1Qcegog+cE42FbE9X3nh7t2WxzABdeJ
	omK2Fvof5EkOipDnVLZqSqGizF6pOm3PCqqyAOsxZEQZakfkCklSzTBxOlhTUGp4REJhOHeCjbr
	y+JEX3UIvYCI9LZSwY4itACxQipxk54aDiBtEPGqNyLUcl/LkwSLGZ5Ah+n5yZsspG/Cv5hP83l
	Knp/WQQPFoP3MdwEVgGQ8mSIRxdNdEyKjnaN7wqVFTsjCw/g9ag0D9k3GR8qSz3/A8687ammlQn
	ui925pSapnyoPzk9qwxlm6lL19wWwfeiQu5KifYmloIulBTEItmCoDhAWMB/UboGf+gbyIcbPxv
	EgzPs/BOMdM1r61qJ6lso34WnzG318wYZpuSvaW0UjJpOh6r4gvmxoJ2awDg==
X-Google-Smtp-Source: AGHT+IEjVIze0sr7iOLE1kW6iqNub2nzQOoz6/zAqSGAMv81AO/rMHgU/1uobm6DrDbA5Rm27NtICg==
X-Received: by 2002:a17:906:6a26:b0:b76:3478:7d52 with SMTP id a640c23a62f3a-b803705d9e2mr4185507566b.38.1767382492194;
        Fri, 02 Jan 2026 11:34:52 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:51 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 10/10] bitbake-setup: correct (and test) several scenarios in layer checkout
Date: Fri,  2 Jan 2026 20:34:37 +0100
Message-ID: <20260102193438.2960561-10-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18680

From: Alexander Kanavin <alex@linutronix.de>

There were untested scenarios in layer updates which did not work properly.

The most serious of them is updating a remote layer which had user-made local
modifications (e.g. newly made local commits or simply edited files
without a commit). Bitbake-setup relies on git fetcher's unpack operation
which simply wipes it all out. Yes, the user should've used -L option
to symlink a local clone from elsewhere; this doesn't help when their
work is gone.

The commit adds a function that checks if such modifications have been
made, and a code that moves the layer into a backup location if the function
returns true. I considered asking the user what to do (similar to bitbake
config handling), but this would've resulted in a half-updated, possibly
broken layer set which ultimately just would be more confusing.

The above check is a part of a broader logic block that handles already
existing sources, and in particular addresses another issue: when a local
source replaces a git remote or another local source, this scenario failed
with 'file exists' errors (thanks to Anibal Limon for spotting that). In
this case the original symlink or source tree is removed before the new
one is unpacked from git or symlinked as a local source.

Adjust commit_config() to allow updates with no changes to configs: this can
happen when local modifications to a layer are undone and the original layer
commit is unpacked.

Add tests for all of this: both transitions between remote and local sources,
and ensuring that layer backups do happen when that is expected.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 30 ++++++++++++++++++--
 lib/bb/tests/setup.py | 65 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 06255b112..58273e4dd 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -81,7 +81,7 @@ def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
 
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
-    bb.process.run("git -C {} commit --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
+    bb.process.run("git -C {} commit --allow-empty --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
 
 def _write_layer_list(dest, repodirs):
     layers = []
@@ -117,6 +117,17 @@ def checkout_layers(layers, layerdir, d):
         logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
         os.symlink(src, dst)
 
+    def _has_local_modifications(r_name, r_path):
+        fixed_revisions = json.load(open(os.path.join(layerdir, "sources-fixed-revisions.json")))
+        rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
+        status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
+        if status:
+            return True
+        diff = bb.process.run('git -C {} diff {}'.format(r_path, rev))[0]
+        if diff:
+            return True
+        return False
+
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
     oesetupbuild = None
@@ -130,10 +141,25 @@ def checkout_layers(layers, layerdir, d):
         r_local = r_data.get('local')
         if r_remote and r_local:
             raise Exception("Source {} contains both git-remote and local properties.".format(r_name))
+
+        repodir_path = os.path.join(layerdir, repodir)
+        if os.path.lexists(repodir_path):
+            if os.path.islink(repodir_path):
+                os.remove(repodir_path)
+            elif _has_local_modifications(r_name, repodir_path):
+                timestamp = time.strftime("%Y%m%d%H%M%S")
+                backup_path = repodir_path + '-backup.{}'.format(timestamp)
+                logger.warning("""Source {} in {} contains local modifications. Renaming to {} to preserve them.
+For local development work it is recommended to clone the needed layers separately and use 'bitbake-setup init' with -L option to use them.""".format(
+                    r_name, repodir_path, backup_path))
+                os.rename(repodir_path, backup_path)
+            else:
+                shutil.rmtree(repodir_path)
+
         if r_remote:
             _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
         if r_local:
-            _symlink_local(os.path.expanduser(r_local["path"]), os.path.join(layerdir,repodir))
+            _symlink_local(os.path.expanduser(r_local["path"]), repodir_path)
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 438dc0cd8..5ff489cbe 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -175,6 +175,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 """ % (self.testrepopath, branch, rev)
         return self._add_json_config_to_registry_helper(name, sources)
 
+    def add_local_json_config_to_registry(self, name, path):
+        sources = """
+        "test-repo": {
+            "local": {
+                "path": "%s"
+            }
+        }
+""" % (path)
+        return self._add_json_config_to_registry_helper(name, sources)
+
     def add_file_to_testrepo(self, name, content, script=False):
         fullname = os.path.join(self.testrepopath, name)
         os.makedirs(os.path.join(self.testrepopath, os.path.dirname(name)), exist_ok=True)
@@ -413,7 +423,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             sums_after = _conf_chksum(f"{setuppath}/build/conf")
             self.assertEqual(sums_before, sums_after)
 
-        # check source overrides, local sources provided with symlinks, and custom setup dir name
         def _check_local_sources(custom_setup_dir):
             custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
             custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
@@ -421,6 +430,60 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
             self.config_is_unchanged(custom_setup_path)
 
+        # Change the configuration to refer to a local source, then to another local source, then back to a git remote
+        # Run status/update after each change and verify that nothing breaks
+        c = 'gadget'
+        setuppath = self.get_setup_path('test-config-1', c)
+        self.config_is_unchanged(setuppath)
+
+        json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_local_sources(setuppath)
+
+        prev_path = self.testrepopath
+        self.testrepopath = prev_path + "-2"
+        self.git("clone {} {}".format(prev_path, self.testrepopath), cwd=self.tempdir)
+        json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_local_sources(setuppath)
+
+        self.testrepopath = prev_path
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        self.check_setupdir_files(setuppath, test_file_content)
+
+        # Also check that there are no layer backups up to this point, then make a change that should
+        # result in a layer backup, and check that it does happen.
+        def _check_layer_backups(layer_path, expected_backups):
+            files = os.listdir(layer_path)
+            backups = len([f for f in files if 'backup' in f])
+            self.assertEqual(backups, expected_backups, msg = "Expected {} layer backups, got {}, directory listing: {}".format(expected_backups, backups, files))
+
+        layers_path = os.path.join(setuppath, 'layers')
+        layer_path = os.path.join(layers_path, 'test-repo')
+        _check_layer_backups(layers_path, 0)
+
+        ## edit a file without making a commit
+        with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
+            f.write('locally-modified\n')
+        test_file_content = "modified-again\n"
+        self.add_file_to_testrepo('test-file', test_file_content)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_layer_backups(layers_path, 1)
+
+        ## edit a file and make a commit
+        with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
+            f.write('locally-modified-again\n')
+        self.git('add .', cwd=layer_path)
+        self.git('commit -m "Adding a local modification"', cwd=layer_path)
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_layer_backups(layers_path, 2)
+
+        # check source overrides, local sources provided with symlinks, and custom setup dir name
         source_override_content = """
 {
     "sources": {
-- 
2.47.3


