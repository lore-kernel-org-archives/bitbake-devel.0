Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC4CA1002
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.52233.1756735125279287184
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 06:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XmeMhTyn;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b043da5a55fso74593666b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735123; x=1757339923; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmvcl1hFUFrhZb52iRcKGU9mThHx+5Wv4e+r32SHRfg=;
        b=XmeMhTynVd11547AFUmhZ7rYfQvzDpy7tSvLiumLnT01iL3ld4qIW+C1Cf/3RWKkfl
         KurNUwxBxHrcoxS/JquuoI+d9JRUfA3kmDbBGAIisX305ANNcD2V+1eHPUV53+PlYYxi
         qnOAyY+LI3MooBPA8l9GBT5+iT2gv7KhjTO0xF6Fee8ROy0/mLQqv735DYHPCcDQvZ4q
         D3yWwdysHlxZX0SmezaZf1K6T+pFHEhky0ecqnT2dnxSci2HlZ/MQ8vwOsTil11HfR2f
         ALMGJYI+esQAqixZNevFz9XRjxVwdAieCIQk1dcDAeluBRxco+oTIZiNlRgc2AR81vo0
         F51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735123; x=1757339923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmvcl1hFUFrhZb52iRcKGU9mThHx+5Wv4e+r32SHRfg=;
        b=HNc6Ty/1qLGADnILmnz48tmPhjauvgL4F2IgTm6ha1zpOAi9FFaluoo0oRImR5CWFC
         ut088sI9WVejuu1TSqP+lGZXI6jv5qNV8ZQogqb+ctfUGtmRC0dKpkT3TgGUw2tEXG7n
         +QAdkUTafiKuCqIr9XdzdcR05uMicA8RXzfbjuqLhbQ0gomTQcbFUmXetwOzr4Slm3u4
         o62PcRCRSz6+CM06E7Nx9ck4uq2HUd8nnKGRhAg+YJpJhE8fYDC8xgCATMiJHssmnwIm
         MbcWOJl9PuCERYEH4BxbN9NsWY7Y9PVQrbekkuixP0nYLfXGPFM1SvsH/FWXg30d1Man
         cJVQ==
X-Gm-Message-State: AOJu0YyMDiPed5BYDwHSZeYWkr/2gDvuGArEWVVqkugS9/fypkexLYsm
	kcc91Q/lDZf9g+VQwFKbN/EecGP/U9gMiHBKOa6NATnZjCZTzSlQiXp1aaSWcw==
X-Gm-Gg: ASbGncuoO7eB5Avj+bnuOKsvs5Qo/jYrjMs3C/4CR/5zJKEkSj4V56/99QjRGCbCJZB
	mVqysSTv7Jz1oIuEZy9c9vWhIqGS19W6G0xGUkjF88Qg1/AMpIQt7Jq9KXLhU7SosDbICnpPV35
	uX9uxwi8D8Sm261VsUE9Zvxlv8ju16hh62m8Qg51L6yHYK2dkQ4S6aRbuchL4zwt9TXx1KCJCwD
	lTIU6Bg/jsqZluxCgqtcn8HjdiXIw646sF9w9paPWN37EHYR02A+45YYfiSqJO2HGtM7QZPm4WC
	Aup1HqMHO/duJedzOhY6Dc6A4UQquK/xj7C+mZQgW2c4pwY/fVpB48Vx8AhDL1DxB2e1uPMfGX+
	nfqw/otJBExEuBaCRyhkPfrb3F0dbdURa5/UGf8W3lRHlKUj0p8/0zKAIOiqmeLZ5l8ddhm1Re0
	eaHVA0e/4s0zPBT3+XxT4ROEXGK9Mox8Quytp//W0s0C3eWqWyif3DQrdJ3A==
X-Google-Smtp-Source: AGHT+IHreCFsoh2vC0Sw5QIA9mBlsMhdPY3ChP9wzMtQ8joDGqrxU0Cj3dEIuA1CdHQlbh+VuTuchA==
X-Received: by 2002:a17:907:868b:b0:b04:31c6:a43a with SMTP id a640c23a62f3a-b0431c6a90fmr297021966b.41.1756735122893;
        Mon, 01 Sep 2025 06:58:42 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6fdsm873503166b.75.2025.09.01.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:42 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/6] bitbake-setup: add the initial implementation
Date: Mon,  1 Sep 2025 15:58:31 +0200
Message-Id: <20250901135836.2927686-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 13:58:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17913

From: Alexander Kanavin <alex@linutronix.de>

Preamble
========

The latest iteration of this patchset is available at
https://github.com/kanavin/bitbake
I recommend taking the patches from there to ensure that
you are not trying out outdated code.

For the rationale and design guidelines please see this message:
https://lists.openembedded.org/g/openembedded-architecture/message/1913

Left out for now but will be done later:

- official configuration repository

- documentation

Amble *scratch* HOWTO
=====================

1. If you don't know where to start, run 'bitbake-setup init'.

Bitbake-setup will ask a few questions about available configuration choices and set up a build.

Note: 'init' sub-command can also take a path or a URL with a configuration file directly.
You can see how those files look like here:
https://github.com/kanavin/bitbake-setup-configurations

2. You can then source the bitbake environment and run bitbake to perform builds as usual:

$ . /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_qemux86-64/build/init-build-env

Also, subsequent status/update commands will not require a separate --build-dir argument telling
bitbake-setup where the build is.

3. To check if the build configuration needs to be updated, run:

===
$ bin/bitbake-setup status
...
Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed.
===

If the configuration has changed, you will see the difference as a diff.
...
  -                "rev": "akanavin/sstate-for-all"
  +                "rev": "akanavin/bitbake-setup-testing"
...

If the configuration has not changed, but layer revisions referred to it have (for example
if the configuration specifies a tip of a branch), you will see that too:

===
...
Layer repository git://git.yoctoproject.org/poky-contrib checked out into /home/alex/builds/poky-alex/layers/poky updated revision akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to aeb73e29379fe6007a8adc8d94c1ac18a93e68de
===

4. If the configuration has changed, you can bring it in sync with:

$ bin/bitbake-setup update

Note that it will also rename/preserve the existing build/conf directory, and print changes
in bitbake configuration (diff of content of build/conf/) if that has changed. I can't
at the moment think of anything more clever that is also not much more brittle or complex
to implement, but open to suggestions.

Terminology
===========

- 'top directory' means the place under which bitbake-setup reads and
writes everything. bitbake-setup makes a promise to not touch anything outside of
that, unless otherwise directed to by entries in settings (currently
there is one such setting for fetcher downloads for layers and config
registries). Top directory can be selected by an environment variable, a command line option,
or otherwise assumed to be ~/bitbake-builds/. If BBPATH is in environment
(e.g. we are in a bitbake environment), then the top directory is
deduced from that and doesn't need to be specified by hand.

- 'settings' means bitbake-setup operational parameters that are
global to all builds under a top directory. E.g. the location of
configuration registry, or where the bitbake fetcher should place the
downloads (DL_DIR setting). Settings are stored in a .conf file in ini
format just under the top directory.

- 'build' means a tree structure set up by 'bitbake-setup init',
consisting of, at least, a layers checkout, and a bitbake
build. It maps 1:1 to the json data it was constructed from, which is
called 'build configuration'. Build configurations are constructed from
generic configurations that may involve making one or more choices
about available options in them. Generic configurations are files, URLs
or are obtained from git repositories called 'config
registries', in which case they can be listed with 'bitbake-setup
list'. There can be multiple 'builds' under a top directory. Here are
two example generic configurations that showcase this:
https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-options.conf.json
https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-nested-configs.conf.json

- 'bitbake-setup status' will tell if a build is in sync with
the generic configuration it was made from. 'bitbake-setup update' will bring a build
in sync with a configuration if needed.

- 'bitbake build' means a particular sub-tree inside a build that
bitbake itself operates on, e.g. what is set in BBPATH/BUILDDIR
by oe-init-build-env. conf/* in that tree is 'bitbake configuration'.
Bitbake configurations are constructed from templates and fragments,
with existing mechanisms provided by oe-core. The configuration file
format is specified such that other mechanisms to set up a
bitbake build can be added; there was a mention of ability to specify
local.conf content and a set of layers directly in a configuration. I
think that scales poorly compared to templates and fragments, but I
made sure alternative ways to configure a bitbake build are possible
to add in the future :)

- 'source override' is a json file that can be used to modify revisions
and origins of layers that need to be checkout into a build (e.g.
when master branches need to be changed to master-next for purposes
of testing). Such a file is specified with a command-line option to 'init'
and an example can be seen here:
https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-next.override.json

This commit includes a fix by Ryan Eatmon <reatmon@ti.com>:
https://github.com/kanavin/bitbake/pull/1

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 711 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 711 insertions(+)
 create mode 100755 bin/bitbake-setup

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
new file mode 100755
index 000000000..a05433206
--- /dev/null
+++ b/bin/bitbake-setup
@@ -0,0 +1,711 @@
+#!/usr/bin/env python3
+
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import logging
+import os
+import sys
+import argparse
+import warnings
+import json
+import shutil
+import time
+import stat
+import tempfile
+import configparser
+import datetime
+
+default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
+
+bindir = os.path.abspath(os.path.dirname(__file__))
+sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
+
+import bb.msg
+import bb.process
+
+logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
+
+def cache_dir(top_dir):
+    return os.path.join(top_dir, '.bitbake-setup-cache')
+
+def init_bb_cache(settings, args):
+    dldir = settings["default"]["dl-dir"]
+    bb_cachedir = os.path.join(cache_dir(args.top_dir), 'bitbake-cache')
+
+    d = bb.data.init()
+    d.setVar("DL_DIR", dldir)
+    d.setVar("BB_CACHEDIR", bb_cachedir)
+    d.setVar("__BBSRCREV_SEEN", "1")
+    if args.no_network:
+        d.setVar("BB_SRCREV_POLICY", "cache")
+    bb.fetch.fetcher_init(d)
+    return d
+
+def save_bb_cache():
+    bb.fetch2.fetcher_parse_save()
+    bb.fetch2.fetcher_parse_done()
+
+def get_config_name(config):
+    return os.path.basename(config).split('.')[0]
+
+def write_config(config, config_dir):
+    with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
+        json.dump(config, s, sort_keys=True, indent=4)
+
+def commit_config(config_dir):
+    bb.process.run("git -C {} add .".format(config_dir))
+    bb.process.run("git -C {} commit -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
+
+def _write_layer_list(dest, repodirs):
+    layers = []
+    for r in repodirs:
+        for root, dirs, files in os.walk(os.path.join(dest,r)):
+            if os.path.basename(root) == 'conf' and 'layer.conf' in files:
+                layers.append(os.path.relpath(os.path.dirname(root), dest))
+    layers_f = os.path.join(dest, ".oe-layers.json")
+    with open(layers_f, 'w') as f:
+        json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
+
+def checkout_layers(layers, layerdir, d):
+    repodirs = []
+    oesetupbuild = None
+    print("Fetching layer/tool repositories into {}".format(layerdir))
+    for r_name in layers:
+        r_data = layers[r_name]
+        repodir = r_data["path"]
+        repodirs.append(repodir)
+
+        r_remote = r_data['git-remote']
+        rev = r_remote['rev']
+        remotes = r_remote['remotes']
+
+        for remote in remotes:
+            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
+            print("    {}".format(r_name))
+            fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
+            do_fetch(fetcher, layerdir)
+
+        if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
+            oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
+            oeinitbuildenv = os.path.join(layerdir, repodir, 'oe-init-build-env')
+
+    print("        ")
+    _write_layer_list(layerdir, repodirs)
+
+    if oesetupbuild:
+        links = {'setup-build': oesetupbuild, 'oe-scripts': os.path.dirname(oesetupbuild), 'init-build-env': oeinitbuildenv}
+        for l,t in links.items():
+            symlink = os.path.join(layerdir, l)
+            if os.path.lexists(symlink):
+                os.remove(symlink)
+            os.symlink(os.path.relpath(t,layerdir),symlink)
+
+def setup_bitbake_build(bitbake_config, layerdir, builddir):
+    def _setup_build_conf(layers, build_conf_dir):
+        os.makedirs(build_conf_dir)
+        layers_s = "\n".join(["  {} \\".format(os.path.join(layerdir,l)) for l in layers])
+        bblayers_conf = """BBLAYERS ?= " \
+{}
+  "
+""".format(layers_s)
+        with open(os.path.join(build_conf_dir, "bblayers.conf"), 'w') as f:
+            f.write(bblayers_conf)
+
+        local_conf = """#
+# This file is intended for local configuration tweaks.
+#
+# If you would like to publish and share changes made to this file,
+# it is recommended to put them into a distro config, or to create
+# layer fragments from changes made here.
+#
+"""
+        with open(os.path.join(build_conf_dir, "local.conf"), 'w') as f:
+            f.write(local_conf)
+
+        with open(os.path.join(build_conf_dir, "templateconf.cfg"), 'w') as f:
+            f.write("")
+
+        with open(os.path.join(build_conf_dir, "conf-summary.txt"), 'w') as f:
+            f.write(bitbake_config["description"] + "\n")
+
+        with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') as f:
+            f.write("")
+
+    def _make_init_build_env(builddir, initbuildenv):
+        cmd = ". {} {}".format(initbuildenv, builddir)
+        initbuild_in_builddir = os.path.join(builddir, 'init-build-env')
+        with open(initbuild_in_builddir, 'w') as f:
+            f.write(cmd)
+
+    bitbake_builddir = os.path.join(builddir, "build")
+    print("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
+
+    template = bitbake_config.get("oe-template")
+    layers = bitbake_config.get("bb-layers")
+    if not template and not layers:
+        print("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template' or a list of layers via 'bb-layers'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
+        return
+    oesetupbuild = os.path.join(layerdir, 'setup-build')
+    if template and not os.path.exists(oesetupbuild):
+        raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
+
+    bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
+    backup_bitbake_confdir = bitbake_confdir + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+    if os.path.exists(bitbake_confdir):
+        os.rename(bitbake_confdir, backup_bitbake_confdir)
+
+    if layers:
+        _setup_build_conf(layers, bitbake_confdir)
+
+    if template:
+        bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
+    else:
+        initbuildenv = os.path.join(layerdir, 'init-build-env')
+        if not os.path.exists(initbuildenv):
+            print("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
+            return
+        _make_init_build_env(bitbake_builddir, os.path.realpath(initbuildenv))
+
+    siteconf_symlink = os.path.join(bitbake_confdir, "site.conf")
+    siteconf = os.path.normpath(os.path.join(builddir, '..', "site.conf"))
+    if os.path.lexists(siteconf_symlink):
+        os.remove(symlink)
+    os.symlink(os.path.relpath(siteconf, bitbake_confdir) ,siteconf_symlink)
+
+
+    init_script = os.path.join(bitbake_builddir, "init-build-env")
+    shell = os.path.basename(os.environ.get("SHELL","bash"))
+    fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
+    if fragments:
+        bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
+
+    if os.path.exists(backup_bitbake_confdir):
+        bitbake_config_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
+        if bitbake_config_diff:
+            print("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
+            print("The bitbake configuration has changed:")
+            print(bitbake_config_diff)
+        else:
+            shutil.rmtree(backup_bitbake_confdir)
+
+    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
+
+    readme = """{}\n\nAdditional information is in {} and {}\n
+Source the environment using '. {}' to run builds from the command line.
+The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
+""".format(
+        bitbake_config["description"],
+        os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
+        os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
+        init_script,
+        bitbake_builddir
+        )
+    readme_file = os.path.join(bitbake_builddir, "README")
+    with open(readme_file, 'w') as f:
+        f.write(readme)
+    print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
+    print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
+    print("To run builds, source the environment using\n    source {}".format(init_script))
+
+def get_registry_config(registry_path, id):
+    for root, dirs, files in os.walk(registry_path):
+        for f in files:
+            if f.endswith('.conf.json') and id == get_config_name(f):
+                return os.path.join(root, f)
+    raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
+
+def update_build(config, confdir, builddir, layerdir, d):
+    layer_config = config["data"]["sources"]
+    layer_overrides = config["source-overrides"]["sources"]
+    for k,v in layer_overrides.items():
+        if k in layer_config:
+            layer_config[k]["git-remote"] = v["git-remote"]
+    checkout_layers(layer_config, layerdir, d)
+    bitbake_config = config["bitbake-config"]
+    setup_bitbake_build(bitbake_config, layerdir, builddir)
+
+def flatten_bitbake_configs(configs):
+    def merge_configs(c1,c2):
+        c_merged = {}
+        for k,v in c2.items():
+            if k not in c1.keys():
+                c_merged[k] = v
+        for k,v in c1.items():
+            if k not in c2.keys():
+                c_merged[k] = v
+            else:
+               c_merged[k] = c1[k] + c2[k]
+        del c_merged['configurations']
+        return c_merged
+
+    flattened_configs = []
+    for c in configs:
+        if 'configurations' not in c:
+            flattened_configs.append(c)
+        else:
+            for sub_c in flatten_bitbake_configs(c['configurations']):
+                flattened_configs.append(merge_configs(c, sub_c))
+    return flattened_configs
+
+def choose_bitbake_config(configs, parameters, non_interactive):
+    flattened_configs = flatten_bitbake_configs(configs)
+    configs_dict = {i["name"]:i for i in flattened_configs}
+
+    if parameters:
+        config_id = parameters[0]
+        if config_id not in configs_dict:
+            raise Exception("Bitbake configuration {} not found; replace with one of {}".format(config_id, configs_dict))
+        return configs_dict[config_id]
+
+    enumerated_configs = list(enumerate(flattened_configs))
+    if len(enumerated_configs) == 1:
+        only_config = flattened_configs[0]
+        print("\nSelecting the only available bitbake configuration {}".format(only_config["name"]))
+        return only_config
+
+    if non_interactive:
+        raise Exception("Unable to choose from bitbake configurations in non-interactive mode: {}".format(configs_dict))
+
+    print("\nAvailable bitbake configurations:")
+    for n, config_data in enumerated_configs:
+        print("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
+    print("\nPlease select one of the above bitbake configurations by its number:")
+    config_n = int(input())
+    return flattened_configs[config_n]
+
+def choose_config(configs, non_interactive):
+    not_expired_configs = [k for k in configs.keys() if not has_expired(configs[k].get("expires", None))]
+    config_list = list(enumerate(not_expired_configs))
+    if len(config_list) == 1:
+        only_config = config_list[0][1]
+        print("\nSelecting the only available configuration {}\n".format(only_config))
+        return only_config
+
+    if non_interactive:
+        raise Exception("Unable to choose from configurations in non-interactive mode: {}".format(not_expired_configs))
+
+    print("\nAvailable configurations:")
+    for n, config_name in config_list:
+        config_data = configs[config_name]
+        expiry_date = config_data.get("expires", None)
+        config_desc = config_data["description"]
+        if expiry_date:
+           print("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
+        else:
+           print("{}. {}\t{}".format(n, config_name, config_desc))
+    print("\nPlease select one of the above configurations by its number:")
+    config_n = int(input())
+    return config_list[config_n][1]
+
+def choose_fragments(possibilities, parameters, non_interactive):
+    choices = {}
+    for k,v in possibilities.items():
+        choice = [o for o in v["options"] if o in parameters]
+        if len(choice) > 1:
+            raise Exception("Options specified on command line do not allow a single selection from possibilities {}, please remove one or more from {}".format(v["options"], parameters))
+        if len(choice) == 1:
+            choices[k] = choice[0]
+            continue
+
+        if non_interactive:
+            raise Exception("Unable to choose from options in non-interactive mode: {}".format(v["options"]))
+
+        print("\n" + v["description"] + ":")
+        options_enumerated = list(enumerate(v["options"]))
+        for n,o in options_enumerated:
+            print("{}. {}".format(n, o))
+        print("\nPlease select one of the above options by its number:")
+        option_n = int(input())
+        choices[k] = options_enumerated[option_n][1]
+    return choices
+
+def obtain_config(settings, args, source_overrides, d):
+    if args.config:
+        config_id = args.config[0]
+        config_parameters = args.config[1:]
+        if os.path.exists(config_id):
+            print("Reading configuration from local file\n    {}".format(config_id))
+            upstream_config = {'type':'local','path':os.path.abspath(args.config),'name':get_config_name(config_id),'data':json.load(open(config_path))}
+        elif config_id.startswith("http://") or config_id.startswith("https://"):
+            print("Reading configuration from network URI\n    {}".format(config_id))
+            import urllib.request
+            with urllib.request.urlopen(config_id) as f:
+              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
+        else:
+            print("Looking up config {} in configuration registry".format(config_id))
+            registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+            registry_configs = list_registry(registry_path, with_expired=True)
+            if config_id not in registry_configs:
+                raise Exception("Config {} not found in configuration registry, re-run 'init' without parameters to choose from available configurations.".format(config_id))
+            upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+        expiry_date = upstream_config['data'].get("expires", None)
+        if has_expired(expiry_date):
+            print("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
+    else:
+        registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+        registry_configs = list_registry(registry_path, with_expired=True)
+        config_id = choose_config(registry_configs, args.non_interactive)
+        config_parameters = []
+        upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+
+    upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
+    upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive)
+    upstream_config['non-interactive-cmdline-options'] = " ".join([upstream_config['name'], upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values()))
+    upstream_config['source-overrides'] = source_overrides
+    return upstream_config
+
+def init_config(settings, args, d):
+    stdout = sys.stdout
+    def handle_task_progress(event, d):
+        rate = event.rate if event.rate else ''
+        progress = event.progress if event.progress > 0 else 0
+        print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
+
+    source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
+    upstream_config = obtain_config(settings, args, source_overrides, d)
+    print("\nRun 'bitbake-setup --non-interactive init {}' to select this configuration non-interactively.\n".format(upstream_config['non-interactive-cmdline-options']))
+
+    builddir = os.path.join(os.path.abspath(args.top_dir), upstream_config['non-interactive-cmdline-options'].replace(" ","-").replace("/","_"))
+    if os.path.exists(builddir):
+        print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
+        return
+
+    print("Initializing a build in\n    {}".format(builddir))
+    if not args.non_interactive:
+        y_or_n = input('Continue? y/n: ')
+        if y_or_n != 'y':
+            exit()
+        print()
+
+
+    os.makedirs(builddir)
+
+    confdir = os.path.join(builddir, "config")
+    layerdir = os.path.join(builddir, "layers")
+
+    os.makedirs(confdir)
+    os.makedirs(layerdir)
+
+    bb.process.run("git -C {} init -b main".format(confdir))
+    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
+
+    bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
+
+    write_config(upstream_config, confdir)
+    commit_config(confdir)
+    update_build(upstream_config, confdir, builddir, layerdir, d)
+
+    bb.event.remove("bb.build.TaskProgress", None)
+
+def get_diff(file1, file2):
+    try:
+        bb.process.run('diff -uNr {} {}'.format(file1, file2))
+    except bb.process.ExecutionError as e:
+        if e.exitcode == 1:
+            return e.stdout
+        else:
+            raise e
+    return None
+
+def are_layers_changed(layers, layerdir, d):
+    changed = False
+    for r_name in layers:
+        r_data = layers[r_name]
+        repodir = r_data["path"]
+
+        r_remote = r_data['git-remote']
+        rev = r_remote['rev']
+        remotes = r_remote['remotes']
+
+        for remote in remotes:
+            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
+            fetcher = bb.fetch.FetchData("{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir), d)
+            upstream_revision = fetcher.method.latest_revision(fetcher, d, 'default')
+            rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
+            local_revision = rev_parse_result[0].strip()
+            if upstream_revision != local_revision:
+                changed = True
+                print('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+
+    return changed
+
+def build_status(settings, args, d, update=False):
+    builddir = args.build_dir
+
+    confdir = os.path.join(builddir, "config")
+    layerdir = os.path.join(builddir, "layers")
+
+    current_upstream_config = json.load(open(os.path.join(confdir, "config-upstream.json")))
+
+    args.config = current_upstream_config['non-interactive-cmdline-options'].split()
+    args.non_interactive = True
+    source_overrides = current_upstream_config["source-overrides"]
+    new_upstream_config = obtain_config(settings, args, source_overrides, d)
+
+    write_config(new_upstream_config, confdir)
+    config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
+
+    if config_diff:
+        print('\nConfiguration in {} has changed:\n{}'.format(builddir, config_diff))
+        if update:
+            commit_config(confdir)
+            update_build(new_upstream_config, confdir, builddir, layerdir, d)
+        else:
+            bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
+        return
+
+    if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
+        if update:
+            update_build(current_upstream_config, confdir, builddir, layerdir, d)
+        return
+
+    print("\nConfiguration in {} has not changed.".format(builddir))
+
+def build_update(settings, args, d):
+    build_status(settings, args, d, update=True)
+
+def do_fetch(fetcher, dir):
+    # git fetcher simply dumps git output to stdout; in bitbake context that is redirected to temp/log.do_fetch
+    # and we need to set up smth similar here
+    fetchlogdir = os.path.join(dir, 'logs')
+    os.makedirs(fetchlogdir, exist_ok=True)
+    fetchlog = os.path.join(fetchlogdir, 'fetch_log.{}'.format(datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
+    with open(fetchlog, 'a') as f:
+        oldstdout = sys.stdout
+        sys.stdout = f
+        fetcher.download()
+        fetcher.unpack(dir)
+        sys.stdout = oldstdout
+
+def update_registry(registry, cachedir, d):
+    registrydir = 'configurations'
+    full_registrydir = os.path.join(cachedir, registrydir)
+    print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
+    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
+    do_fetch(fetcher, cachedir)
+    return full_registrydir
+
+def has_expired(expiry_date):
+    if expiry_date:
+        return datetime.datetime.now() > datetime.datetime.fromisoformat(expiry_date)
+    return False
+
+def list_registry(registry_path, with_expired):
+    json_data = {}
+
+    for root, dirs, files in os.walk(registry_path):
+        for f in files:
+            if f.endswith('.conf.json'):
+                config_name = get_config_name(f)
+                config_data = json.load(open(os.path.join(root, f)))
+                config_desc = config_data["description"]
+                expiry_date = config_data.get("expires", None)
+                if expiry_date:
+                    if with_expired or not has_expired(expiry_date):
+                        json_data[config_name] = {"description": config_desc, "expires": expiry_date}
+                else:
+                    json_data[config_name] = {"description": config_desc}
+    return json_data
+
+def list_configs(settings, args, d):
+    registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+    json_data = list_registry(registry_path, args.with_expired)
+    print("\nAvailable configurations:")
+    for config_name, config_data in json_data.items():
+        expiry_date = config_data.get("expires", None)
+        config_desc = config_data["description"]
+        if expiry_date:
+           if args.with_expired or not has_expired(expiry_date):
+               print("{}\t{} (supported until {})".format(config_name, config_desc, expiry_date))
+        else:
+           print("{}\t{}".format(config_name, config_desc))
+    print("\nRun 'init' with one of the above configuration identifiers to set up a build.")
+
+    if args.write_json:
+        with open(args.write_json, 'w') as f:
+            json.dump(json_data, f, sort_keys=True, indent=4)
+        print("Available configurations written into {}".format(args.write_json))
+
+def default_settings_path(top_dir):
+    return os.path.join(top_dir, 'bitbake-setup.conf')
+
+def write_settings(top_dir, force_replace, non_interactive=True):
+    settings_path = default_settings_path(top_dir)
+    if not os.path.exists(settings_path) or force_replace:
+
+        settings = configparser.ConfigParser()
+        settings['default'] = {
+                             'registry':default_registry,
+                             'dl-dir':os.path.join(top_dir, '.bitbake-setup-downloads'),
+                            }
+        os.makedirs(os.path.dirname(settings_path), exist_ok=True)
+
+        siteconfpath = os.path.join(top_dir, 'site.conf')
+        print('Configuration registry set to\n    {}\n'.format(settings['default']['registry']))
+        print('Bitbake-setup download cache (DL_DIR) set to\n    {}\n'.format(settings['default']['dl-dir']))
+        print('A new settings file will be created in\n    {}\n'.format(settings_path))
+        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
+        if not non_interactive:
+            y_or_n = input('Bitbake-setup will be configured in {}, y/n: '.format(top_dir))
+            if y_or_n != 'y':
+                print("\nYou can run 'bitbake-setup write-settings' to edit them before setting up builds")
+                exit()
+            print()
+
+        if os.path.exists(settings_path):
+            backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+            os.rename(settings_path, backup_conf)
+            print("Previous settings are in {}".format(backup_conf))
+        with open(settings_path, 'w') as settingsfile:
+            settings.write(settingsfile)
+
+        if os.path.exists(siteconfpath):
+            backup_siteconf = siteconfpath + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+            os.rename(siteconfpath, backup_siteconf)
+            print("Previous settings are in {}".format(backup_siteconf))
+        with open(siteconfpath, 'w') as siteconffile:
+            siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
+
+def load_settings(top_dir, non_interactive):
+    # This creates a new settings file if it does not yet exist
+    write_settings(top_dir, force_replace=False, non_interactive=non_interactive)
+
+    settings_path = default_settings_path(top_dir)
+    settings = configparser.ConfigParser()
+    print('Loading settings from\n    {}\n'.format(settings_path))
+    settings.read([settings_path])
+    return settings
+
+def change_settings(top_dir, new_settings):
+    # This creates a new settings file if it does not yet exist
+    write_settings(top_dir, force_replace=False)
+
+    settings = load_settings(top_dir, non_interactive=True)
+    for section, section_settings in new_settings.items():
+        for setting, value in section_settings.items():
+            settings[section][setting] = value
+            print("Setting '{}' in section '{}' is changed to '{}'".format(setting, section, value))
+
+    settings_path = default_settings_path(top_dir)
+    with open(settings_path, 'w') as settingsfile:
+        settings.write(settingsfile)
+    print("New settings written to {}".format(settings_path))
+    return settings
+
+def get_build_dir_via_bbpath():
+    bbpath = os.environ.get('BBPATH')
+    if bbpath:
+        bitbake_dir = os.path.normpath(bbpath.split(':')[0])
+        if os.path.exists(os.path.join(bitbake_dir,'init-build-env')):
+            build_dir = os.path.dirname(bitbake_dir)
+            return build_dir
+    return None
+
+def get_default_top_dir():
+    build_dir_via_bbpath = get_build_dir_via_bbpath()
+    if build_dir_via_bbpath:
+        top_dir = os.path.dirname(build_dir_via_bbpath)
+        if os.path.exists(default_settings_path(top_dir)):
+            return top_dir
+    return os.environ.get('BITBAKE_SETUP_TOP_DIR') or os.path.join(os.path.expanduser('~'), 'bitbake-builds')
+
+def main():
+    def add_top_dir_arg(parser):
+        parser.add_argument('--top-dir', default=get_default_top_dir(), help='Top level directory where builds are set up and downloaded configurations and layers are cached for reproducibility and offline builds, default is %(default)s, can be overriden via BITBAKE_SETUP_TOP_DIR environment variable')
+
+    def add_build_dir_arg(parser):
+        build_dir = get_build_dir_via_bbpath()
+        if build_dir:
+            parser.add_argument('--build-dir', default=build_dir, help="Path to the build, default is %(default)s via BBPATH")
+        else:
+            parser.add_argument('--build-dir', required=True, help="Path to the build")
+
+    parser = argparse.ArgumentParser(
+        description="BitBake setup utility. Run with 'init' argument to get started.",
+        epilog="Use %(prog)s <subcommand> --help to get help on a specific command"
+        )
+    parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
+    parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
+    parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
+
+    subparsers = parser.add_subparsers()
+
+    parser_list = subparsers.add_parser('list', help='List available configurations')
+    add_top_dir_arg(parser_list)
+    parser_list.add_argument('--with-expired', action='store_true', help='List also configurations that are no longer supported due to reaching their end-of-life dates.')
+    parser_list.add_argument('--write-json', action='store', help='Write available configurations into a json file so they can be programmatically processed.')
+    parser_list.set_defaults(func=list_configs)
+
+    parser_init = subparsers.add_parser('init', help='Select a configuration and initialize a build from it')
+    add_top_dir_arg(parser_init)
+    parser_init.add_argument('config', nargs='*', help="path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available choices if command line doesn't completely specify them.")
+    parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
+    parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
+    parser_init.set_defaults(func=init_config)
+
+    parser_status = subparsers.add_parser('status', help='Check if the build needs to be synchronized with configuration')
+    add_build_dir_arg(parser_status)
+    parser_status.set_defaults(func=build_status)
+
+    parser_update = subparsers.add_parser('update', help='Update a build to be in sync with configuration')
+    add_build_dir_arg(parser_update)
+    parser_update.set_defaults(func=build_update)
+
+    parser_install_settings = subparsers.add_parser('install-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other global settings)')
+    add_top_dir_arg(parser_install_settings)
+    parser_install_settings.set_defaults(func=write_settings)
+
+    parser_change_setting = subparsers.add_parser('change-setting', help='Change a setting in the settings file')
+    add_top_dir_arg(parser_change_setting)
+    parser_change_setting.add_argument('section', help="Section in a settings file, typically 'default'")
+    parser_change_setting.add_argument('key', help="Name of the setting")
+    parser_change_setting.add_argument('value', help="Value of the setting")
+    parser_change_setting.set_defaults(func=change_settings)
+
+    args = parser.parse_args()
+
+    logging.basicConfig(stream=sys.stdout)
+    if args.debug:
+        logger.setLevel(logging.DEBUG)
+    elif args.quiet:
+        logger.setLevel(logging.ERROR)
+
+    # Need to re-run logger_create with color argument
+    # (will be the same logger since it has the same name)
+    bb.msg.logger_create('bitbake-setup', output=sys.stdout,
+                         color=args.color,
+                         level=logger.getEffectiveLevel())
+
+
+    if hasattr(args, 'build_dir'):
+        if not os.path.exists(os.path.join(args.build_dir,'build', 'init-build-env')):
+            print("Not a valid build directory: build/init-build-env does not exist in {}".format(args.build_dir))
+            return
+        # commands without --top-dir argument (status, update) still need to know where
+        # the top dir is, but it should be auto-deduced as parent of args.build_dir
+        if not hasattr(args, 'top_dir'):
+            args.top_dir = os.path.dirname(os.path.normpath(args.build_dir))
+
+    if 'func' in args:
+        print('Bitbake-setup is using {} as top directory (can be changed with --top-dir argument or BITBAKE_SETUP_TOP_DIR variable).\n'.format(args.top_dir))
+        if args.func == write_settings:
+            write_settings(args.top_dir, force_replace=True)
+        elif args.func == change_settings:
+            change_settings(args.top_dir, {args.section:{args.key:args.value}})
+        else:
+            if not hasattr(args, 'non_interactive'):
+                args.non_interactive = True
+            settings = load_settings(args.top_dir, args.non_interactive)
+            d = init_bb_cache(settings, args)
+            args.func(settings, args, d)
+            save_bb_cache()
+    else:
+        from argparse import Namespace
+        parser.print_help()
+
+main()
-- 
2.39.5


