Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69948CD6E51
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 14:52:29 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12015.1780066348581845586
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 07:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dym89QhJ;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso50977115e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066347; x=1780671147; darn=lists.openembedded.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIrqSb7Mz6LTBdS+HqJG4GK7d0YSdar0Oe/oH/DEKj0=;
        b=dym89QhJD0tVhvnPsSZy29061GjSVIn2k2cCAsgMDSFXeh1kAly8ZaTo/n13ntZ8xC
         qxcJqm1nLt1cr6uRtTYrfRketB6p/E3jFrtfu1pUhJn6hBghKf5hWhSm5VBE+iKsOHxZ
         Dpff//kkRsVsTkeV/yaxVo+7qd+7PR2ltqeHaFdwHnptNrpnHjDI/TH06KRMxdQ8ozBA
         jcHlS+7Z4gR9lvlMaPQAPdQUm0rwh/XweZvLykdWTA8vXuP8rkL2hhNnknYF1sfW2/1u
         V4MiJJJJTguMLXXbf8Y4JDM1V3xZpQ1Jffx77OzkIZOD1vN1gRDdGJAC3QujGukrxuTZ
         WQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066347; x=1780671147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qIrqSb7Mz6LTBdS+HqJG4GK7d0YSdar0Oe/oH/DEKj0=;
        b=fy4P+l5F0/8MDNq8heGL8XFsJ3OD0nBFYqEt7DjJisZZs4r8vmSJERxO0EHvGgtBPH
         n05eIvtjEYGlAudr8vBdgAEZHgs3kQr+3BNBLFjNtX/jCcjCeB50nlN7BYLgwILRDC03
         vKC5VrTdNmsIpsUz3pz/6fzLk64AF5HOcfzLZV8MrKFd7R802uq3lKcssjLjdNAnol9V
         woX8dCdPUtKUvRrlfIdhg4gi4730IvQpcVamhE2J8eaKZg66OePZhKRKNw+AGeoxd4AM
         8HyGffXWP7MX6qsXNXrJ4SuUfczHHNkTGDLQ5X4VtIYVfRQzaex/DSDUnO/L/CiGdKv7
         Wf3A==
X-Gm-Message-State: AOJu0Yw2uSuID+CdNXEESWJt/Q8laiASsZDEU3Gm5W+wUKUV+ChYbtpz
	vRTkn1cjXgIM37r03a+A+pQ2Mijjy80jmMJaVUaoinuUca2AeWzpb+yX5jcGUAZ4
X-Gm-Gg: Acq92OF4vQlT19l2Jk1n3KZopuCJbcQk63dmhruB1k2spkzLSVh42LbVREPgxNc+a5d
	5VnbHClnDvQfmLCXBrBzbn9cuJPdSY7ZHsG0Aa8fgh7vnaWs5iluc1X/sSzs4zx2ebgS/Uwglm4
	WDxGTG0+zAMYlJYNjg09WoJR2+91kYiCGDVlkj9/8ktQrN/lXbMOXqgleu+0wMMO/zq9aY3RhBO
	jOc/8kBuMKf7iikwC4FwI7/WSp2XPPU/di4jeDE8HZLgf6l9Q7gyVtVnJWm4ulladnQzs/1+MiL
	tGvoRPsXNmdkDX1qm8akyCHPw1+wNB2kwzyowY/3MLlqk7QN/brMLqbH/uf7iYwAsi6X1vNg9DB
	T7p7PG1W5CwvYSiWiN6GbjekJc437/Gdrth7N9mbb1a5o0SYla2MMZhczpsgB4/Yi8ITfB7hw7d
	4RHpAqM1anVhwa49eo1oGdtf/Zlz+riezpCcwvpc/kEFT5uhmSKa4JDvsagejcBdaRuI2Gn4/br
	yETxeNrC8ffhOUZarmVEZCswIGvfhbtfIEPvg==
X-Received: by 2002:a05:600c:5697:b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-4909c0b3493mr42582795e9.16.1780066346634;
        Fri, 29 May 2026 07:52:26 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c13d018sm21199535e9.8.2026.05.29.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:52:26 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 29 May 2026 16:51:39 +0200
Subject: [PATCH 2/2] bitbake-setup: support default source overrides
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-bb-setup-override-improvements-v1-2-91db62e0149e@toradex.com>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
In-Reply-To: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 14:52:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19562

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Allow a BitBake configuration to list source override files to apply by
default when that configuration is selected. This allows specifying
source-overrides files (such as fixed revisions) that live in a remote
registry, which is not possible with the CLI argument
'--source-overrides'.

Relative override paths resolve against the configuration file,
including files loaded from a fetched registry checkout. Default
overrides are applied before command-line source overrides.

For "config-upstream", keep "source-overrides" as the persisted
command-line override data so existing setups retain their meaning.
Store loaded defaults in "default-source-overrides" and merge them only
when applying sources.

Extend the setup selftest to cover a registry-provided default override
file.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 bin/bitbake-setup                                  | 41 ++++++++++++++++------
 .../bitbake-user-manual-environment-setup.rst      | 13 +++++++
 lib/bb/tests/setup.py                              | 33 ++++++++++++-----
 setup-schema/bitbake-setup.schema.json             |  7 ++++
 4 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2e234cccaba9..e032e1cd3a1e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -458,8 +458,13 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
+def effective_source_overrides(config):
+    overrides = copy.deepcopy(config.get("default-source-overrides", {'sources':{}}))
+    overrides["sources"].update(config["source-overrides"]["sources"])
+    return overrides
+
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):
-    layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
+    layer_config = merge_overrides_into_sources(config["data"]["sources"], effective_source_overrides(config)["sources"])
     sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
@@ -591,11 +596,13 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
     return choices
 
 def obtain_config(top_dir, registry, args, source_overrides, d):
+    config_dir = None
     if args.config:
         config_id = args.config[0]
         config_parameters = args.config[1:]
         if os.path.exists(config_id):
             config_id = os.path.abspath(config_id)
+            config_dir = os.path.dirname(config_id)
             logger.info("Reading configuration from local file\n    {}".format(config_id))
             upstream_config = {'type':'local',
                                'path':config_id,
@@ -617,7 +624,9 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
             registry_configs = list_registry(registry_path, with_expired=True)
             if config_id not in registry_configs:
                 raise Exception("Config {} not found in configuration registry, re-run 'init' without parameters to choose from available configurations.".format(config_id))
-            upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+            config_path = get_registry_config(registry_path,config_id)
+            config_dir = os.path.dirname(config_path)
+            upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(config_path))}
         expiry_date = upstream_config['data'].get("expires", None)
         if has_expired(expiry_date):
             logger.warning("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
@@ -626,18 +635,26 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
         registry_configs = list_registry(registry_path, with_expired=True)
         config_id = choose_config(registry_configs, args.non_interactive)
         config_parameters = []
-        upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+        config_path = get_registry_config(registry_path,config_id)
+        config_dir = os.path.dirname(config_path)
+        upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(config_path))}
 
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
     upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
     upstream_config['non-interactive-cmdline-options'] = [config_id, upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
-    upstream_config['source-overrides'] = source_overrides
     upstream_config['skip-selection'] = args.skip_selection
+    default_source_overrides = upstream_config['bitbake-config'].get('default-source-overrides')
+    if default_source_overrides and not config_dir:
+        raise Exception("default-source-overrides can only be used with configuration templates from a registry or a local file.")
+    upstream_config['default-source-overrides'] = read_source_overrides(default_source_overrides, base_dir=config_dir)
+    upstream_config['source-overrides'] = source_overrides
     return upstream_config
 
-def obtain_overrides(args):
+def read_source_overrides(source_override_files, base_dir=None):
     all_overrides = {'sources':{}}
-    for overrides_file in args.source_overrides or []:
+    for overrides_file in source_override_files or []:
+        if base_dir and not os.path.isabs(overrides_file):
+            overrides_file = os.path.join(base_dir, overrides_file)
         overrides = json.load(open(overrides_file))
         overrides_dir = os.path.dirname(os.path.abspath(overrides_file))
         for s,v in overrides['sources'].items():
@@ -647,11 +664,13 @@ def obtain_overrides(args):
                 if not os.path.isabs(path):
                     v['local']['path'] = os.path.join(overrides_dir, path)
             all_overrides['sources'][s] = v
+    return all_overrides
 
+def obtain_cli_overrides(args):
+    overrides = read_source_overrides(args.source_overrides)
     for local_name, local_path in args.use_local_source:
-        all_overrides['sources'][local_name] = {'local':{'path':os.path.abspath(os.path.expanduser(local_path))}}
-
-    return all_overrides
+        overrides['sources'][local_name] = {'local':{'path':os.path.abspath(os.path.expanduser(local_path))}}
+    return overrides
 
 def configure_vscode(setupdir, layerdir, builddir, init_script):
     """
@@ -811,7 +830,7 @@ def init_config(top_dir, settings, args):
         logger.plain("{}% {}                ".format(progress, rate))
         logger.handlers[0].terminator = '\n'
 
-    source_overrides = obtain_overrides(args)
+    source_overrides = obtain_cli_overrides(args)
     upstream_config = obtain_config(top_dir, settings["default"]["registry"], args, source_overrides, d)
     logger.info("Run 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
@@ -949,7 +968,7 @@ def build_status(top_dir, settings, args, d, update=False):
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
-    layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])
+    layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], effective_source_overrides(current_upstream_config)["sources"])
     if are_layers_changed(layer_config, layerdir, d):
         if update:
             update_build(current_upstream_config, confdir, setupdir, layerdir,
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 77fc4c3dcba0..b30ebe8aeaeb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -1141,6 +1141,12 @@ They contain the following sections:
       See https://docs.yoctoproject.org/dev/ref-manual/fragments.html for
       more information of OpenEmbedded configuration fragments.
 
+   -  ``default-source-overrides`` (*optional*): a list of source override files
+      to apply by default when this configuration is selected. This is supported
+      only for configuration templates read from registries or local files; paths
+      are resolved relative to the configuration file. See the
+      :ref:`ref-bbsetup-source-overrides` section.
+
    -  ``setup-dir-name`` (*optional*): a suggestion for the :term:`Setup`
       directory name. Bitbake-setup will use it, unless it already exists, or
       the :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting is set
@@ -1193,6 +1199,13 @@ These files are written in the JSON file format and are optionally passed to the
 The ``--source-overrides`` option can be passed multiple times, in which case the
 overrides are applied in the order specified in the command-line.
 
+A :term:`BitBake Configuration` can also select source override files with the
+``default-source-overrides`` property. These overrides are applied before any
+``--source-overrides`` arguments. Relative paths are resolved relative to the
+:term:`Configuration Template` file, or inside the fetched registry checkout.
+This allows a remote registry to provide its own default override files; the
+``--source-overrides`` command-line option only accepts local files.
+
 Here is an example file that overrides the branch of the BitBake repository to
 "master-next", and provides openembedded-core as a symlink to a path on local disk:
 
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index d425faa1f6b6..de9fde488539 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -95,7 +95,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd))
 
 
-    def _add_json_config_to_registry_helper(self, name, sources):
+    def _add_json_config_to_registry_helper(self, name, sources, default_source_overrides=()):
         config = """
 {
     "sources": {
@@ -107,6 +107,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             {
                 "name": "gadget",
                 "description": "Gadget configuration",
+                "default-source-overrides": %s,
                 "oe-template": "test-configuration-gadget",
                 "oe-fragments": ["test-fragment-1"]
             },
@@ -172,7 +173,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     },
     "version": "1.0"
 }
-""" % (sources)
+""" % (sources, json.dumps(default_source_overrides))
         os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
         with open(os.path.join(self.registrypath, name), 'w') as f:
             f.write(config)
@@ -180,7 +181,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('commit -m "Adding {}"'.format(name), cwd=self.registrypath)
         return json.loads(config)
 
-    def add_json_config_to_registry(self, name, rev, branch, source_names=("test-repo",)):
+    def add_json_config_to_registry(self, name, rev, branch, source_names=("test-repo",), default_source_overrides=()):
         sources = []
         for source_name in source_names:
             sources.append("""
@@ -196,7 +197,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 }
             }
 """ % (source_name, self.testrepopath, branch, rev))
-        return self._add_json_config_to_registry_helper(name, ",\n".join(sources))
+        return self._add_json_config_to_registry_helper(name, ",\n".join(sources), default_source_overrides)
 
     def add_local_json_config_to_registry(self, name, path):
         sources = """
@@ -520,11 +521,21 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             out = self.runbbsetup("update --update-bb-conf='yes'")
         _check_layer_backups(layers_path, 1)
 
-        # check source overrides, local sources provided with symlinks, and custom setup dir name
-        source_override_content = """
+        # check source overrides, default source overrides, local sources provided with symlinks, and custom setup dir name
+        default_source_overrides_content = """
 {
     "sources": {
         "test-repo": {
+            "local": {
+                "path": "%s"
+            }
+        }
+    }
+}""" % (self.testrepopath)
+        source_override_content = """
+{
+    "sources": {
+        "test-repo-cli": {
             "local": {
                 "path": "."
             }
@@ -546,14 +557,20 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         }
     }
 }"""
+        default_source_overrides_filename = 'releases/default-source-overrides.json'
         override_filename = 'source-overrides.json'
         second_override_filename = 'second-source-overrides.json'
         custom_setup_dir = 'special-setup-dir'
-        self.add_json_config_to_registry('test-config-1.conf.json', branch, branch, ("test-repo", "test-repo-extra"))
+        os.makedirs(os.path.join(self.registrypath, os.path.dirname(default_source_overrides_filename)), exist_ok=True)
+        with open(os.path.join(self.registrypath, default_source_overrides_filename), 'w') as f:
+            f.write(default_source_overrides_content)
+        self.git('add {}'.format(default_source_overrides_filename), cwd=self.registrypath)
+        self.git('commit -m "Adding {}"'.format(default_source_overrides_filename), cwd=self.registrypath)
+        self.add_json_config_to_registry('test-config-1.conf.json', branch, branch, ("test-repo", "test-repo-cli", "test-repo-extra"), default_source_overrides=[default_source_overrides_filename])
         self.add_file_to_testrepo(override_filename, source_override_content)
         self.add_file_to_testrepo(second_override_filename, second_source_override_content)
         out = self.runbbsetup("init --non-interactive --source-overrides {} --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), os.path.join(self.testrepopath, second_override_filename), custom_setup_dir))
-        _check_local_sources(custom_setup_dir, ("test-repo", "test-repo-extra"))
+        _check_local_sources(custom_setup_dir, ("test-repo", "test-repo-cli", "test-repo-extra"))
 
         # same but use command line options to specify local overrides
         custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index be8772db1b2d..1a3a056198cd 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -120,6 +120,13 @@
                                     "type": "string"
                                 }
                             },
+                            "default-source-overrides": {
+                                "description": "Source override files to apply by default when this configuration is selected from a registry or local file. Relative paths are relative to the configuration file.",
+                                "type": "array",
+                                "items": {
+                                    "type": "string"
+                                }
+                            },
                             "setup-dir-name": {
                                 "type": "string",
                                 "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections."

-- 
2.43.0


