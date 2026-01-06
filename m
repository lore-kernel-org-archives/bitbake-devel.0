Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B033BCDC17E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88573.1767701445162486617
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dPIRajwV;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8018eba13cso156538366b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701443; x=1768306243; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh4vsNd2YWbF65A76nR6MsWBgJh6ychYbzThMUvzcGI=;
        b=dPIRajwVDqkEiCzEVjXdUodA66eLGgQW84LpYjk7tA7RxLoBq6o8nW0LKuGEAfBa1x
         EcT2svOkhCmARHT3WrnQ9REvEH0US8xSrmZYY1WZi9O9yq5jshLnukmrmIp3y2DqynEn
         5ttFHfAH/Xz0pKMusXgn8URDuaUZxJr6bXoO4ONKc8D1BleiOPvLHfEtPG2sjcFQTqgc
         6szqXR9Fh1wXFEqcp7foAbOO7M22keXYaWo8w0/erGI2SXxNuJhaPq8TuSpMWv2xJhe2
         +An/pzprEI/RTFG1tTR0iTKECoqw5S12V7KrmY4JOFGKvsz3R0VcUVldBvBu2pa8mt2E
         z6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701443; x=1768306243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wh4vsNd2YWbF65A76nR6MsWBgJh6ychYbzThMUvzcGI=;
        b=xGylZ29XFBp3mxLlm/Evetun3uAbiiNobaEKWIuLJK2GipXVKST20ZoROTtwiIndSY
         w2V2XIAdl3NduVQ8vutNM8on84OnjxNczn3z5wb2EBauwQDeir0dFnkMW8qN/x/PN4cW
         0UVlyCBrg2yondbND6TYT17oTNjXeMiA5yLZqS1PNUFHDZ6sYil0Zy76iHAmc8v45B9O
         N4GwEowchLiJGWfyLOW/04Lc7i7WiFbA8PBS6Mv24RL00049DYUYYOoeIledlsl+LsTM
         6H8f1ygNuK1xd2jww/RSIt+wlkep62/Mp9SfT+uHEeyYJdoYeW1Bs8DxSQzAaa8W2eHY
         oa7g==
X-Gm-Message-State: AOJu0Yzi2C3xFUJGumRh8La3l2M8Da4ES/a9ngvGMh34F9dqM+7Yp4Vt
	84OKavD00ZEM5YKbIuOn+m8ky3nvTT2K0Y9jCpU4L0NZO2XU+k10bPyhX0Cp/Q==
X-Gm-Gg: AY/fxX4Dz9QaYrgsdvUiVDd2Ja7YAsOgqCM7N6Oz4mzbT8XlJoYLo+KA5ddTCByGasA
	QgyO3ZN9HlSSEwK9Smroba4kJsWqxLkeTZpSDFRfgo0a6IJ0cHXXG0/O1qOfEDaLQfDhfMIs3SK
	9rfJBMTlVkNrGZ2RoU/RWG/x/mcELrC4GbEpjEvIkCMJfPVq0aRFOWg+BlaMSNIQ2KoGP/fyB4S
	g0P4FYK7GLUfqUpXfApkzCjhbG4IiDRj620I0tQ+IEEPPugBkNrc21SQDnhiyIwPyj+JlNAYI0A
	RtIcN+Hn5hUc+xtPQcFbyRPmwtQ/SdX51ZTeuI3w1/5WZL96e9rEElzzuV2YGv3K9qcq+dCCjM8
	wHTz8NaPq6V/Pmpngp01+QHImH+VByVibV9aTIyct3zunVlHfzIT/sPe6Jvhw86Esxd7op1pc88
	r7wLJAEAbM8wX3HFOuvTqfgb0ctUGOFKrOCiRVc+yMVo8Vbu6vg5XYlWWNPA==
X-Google-Smtp-Source: AGHT+IFo0uflpDT5Oz9curKQLoWjDxHc0m3rBa+uLT9Bqz6JXsstND4EDGHuOr2diW29Zrsy8xtMNQ==
X-Received: by 2002:a17:906:d551:b0:b84:200d:15b5 with SMTP id a640c23a62f3a-b8426bb8790mr319155966b.31.1767701443328;
        Tue, 06 Jan 2026 04:10:43 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:42 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 10/10] bitbake-setup: correct (and test) several scenarios in layer checkout
Date: Tue,  6 Jan 2026 13:10:32 +0100
Message-ID: <20260106121033.3892596-10-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18700

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
v2: squash in an additional fix that was previously sent separately:

bitbake-setup: read fixed revisions json from config dir, not from layer dir

The file (or symlink to it) is present in layer dir only if the build was
set up by a newer version of bitbake-setup, and otherwise there will be a
'file not found' error. Reading it from config dir maintains compatibility
with setups made by previous iterations of bitbake-setup.
---
 bin/bitbake-setup     | 34 +++++++++++++++++++---
 lib/bb/tests/setup.py | 65 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 06255b112..38c1d4d36 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -81,7 +81,7 @@ def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
 
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
-    bb.process.run("git -C {} commit --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
+    bb.process.run("git -C {} commit --allow-empty --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
 
 def _write_layer_list(dest, repodirs):
     layers = []
@@ -93,7 +93,7 @@ def _write_layer_list(dest, repodirs):
     with open(layers_f, 'w') as f:
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
-def checkout_layers(layers, layerdir, d):
+def checkout_layers(layers, confdir, layerdir, d):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
@@ -117,6 +117,17 @@ def checkout_layers(layers, layerdir, d):
         logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
         os.symlink(src, dst)
 
+    def _has_local_modifications(r_name, r_path):
+        fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
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
@@ -344,7 +370,7 @@ def merge_overrides_into_sources(sources, overrides):
 
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
-    sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
+    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
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


