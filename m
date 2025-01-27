Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E2BC0218A
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 13:14:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.51179.1737983682415267776
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 05:14:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ndfOtXs9;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso34250045e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 05:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737983681; x=1738588481; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jq8SvAa6QvCqDaiMT2NiIdGha+JsnNBgdNq7WxT1LhI=;
        b=ndfOtXs9hTKFXc7zMoUUdcOkZwD3fsHkO8MtfEbBM6mG0IhJ6VquuH9apMNB+GlTGe
         hhdG/LaaO21u9Ks0SvbL2gmhTT+x2x/CQLdwokSlzXUJh1MaS+300mfZ8P+MTJTlqUTH
         VobmjOtbMA/SugQAOg13m19d1s7fL6utC+/1Emz5zAskVB/T4FQm4KE4BH5b8UgXROG4
         OFcMPtzPMcq6Ct6HIZxFmchPi/uhGMc8CIrsZutMY4KpDGiqltn7NkaDxcqI1nksvUIH
         XIWABGBEeLQKVuvva0VS0ZUj6Sr2nrJyMToTE6a9SAzKPM+gemnTiICQrtG+63LGmtW2
         06Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737983681; x=1738588481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq8SvAa6QvCqDaiMT2NiIdGha+JsnNBgdNq7WxT1LhI=;
        b=oeYrIQUfSE60HMsFhUmREL4nHU3HIAUnlgghHiax/+qf5ZhxgpYpybYI0ZamrF90QO
         lujpICvkFrfBvQ8A0ppkNrwLZi4bxpFcXuwfDMaNlvkUfgZpEDv6t5HYPfkMW3iOwSC6
         VEhIlc0O4RcG+iXww8SEFV1TethR6T6falfI8Agqs6JcmAstx/fYMkc/1i6/oL8Z0X3U
         RnYUTlAEOGtY9fYguocb8b/h3j9At9fJnH3ESYxd53BuQUJx1B/8tetd186/hOUaiOpu
         /6srSERON+8NZTnSPz0SGnRCt6F+55KOZhd8rM4cu6vXWLwNtFXiQ3mXmhech9XrJvMQ
         W8eA==
X-Gm-Message-State: AOJu0Yw1WaAsx1lreCNYjSBllYRM7isHB4tsePX63gY8Q80MgptQ8fgQ
	qrAVD3CfrXfNqknjx1zzM0/Khc+CXQv54Z5wdk/C+z03fa0vSCmgzYgqZw==
X-Gm-Gg: ASbGncuIR3z6Qv5Q/VfzPrkF2pGypTzgi7Etykf9IfCS+OUBAbcA3c6s508Q49ZdbFp
	QdpzY2iBgCGQGNdNE6pwL0axjIk7lETfGEWX6UzBu9yAnnuMdijwGZHXbdoIzQJpnBa3aTvPiGz
	+39vW02TQDpSrY5uw6I3NaiH7eAS3l1ps0BHZQyej5JMiLJqIVILAOU7TcyW8pFMvNG2jILNXVn
	25mTbC+Md63PZUA7WQmTcYYadaiTP2Hec6rLOdvWQ+WEY0vTQ+PauNm9h4zQKNTU7mbCMghETZD
	lSGCLIC2syVwzJ4mrm2wIYokNyj4xGXeBMVAGlzvhQ==
X-Google-Smtp-Source: AGHT+IGtMkzcrWUj6rFOWZZjXRsRivWE6EkUY/VGxByHLsgP0i08XBmC/2tbCZtwKDcqlZqKEpTRzQ==
X-Received: by 2002:a5d:5988:0:b0:386:4a16:dadb with SMTP id ffacd0b85a97d-38c2b7726admr11087000f8f.11.1737983680122;
        Mon, 27 Jan 2025 05:14:40 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1764d3sm11215996f8f.19.2025.01.27.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:14:39 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH 1/2] bitbake-setup: add the proof of concept implementation
Date: Mon, 27 Jan 2025 14:13:24 +0100
Message-Id: <20250127131325.2512259-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 13:14:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17093

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

- base bitbake configs (a way to declare the common parts between several bitbake build configurations just once, like a parent 'class')
(this is inspired by a similar mechannism in yocto-autobuilder)

- documentation

- official configuration repository (this probably depends on oe-core being
populated with a rich, useful set of fragments, and providing sstate for
official configurations)

Amble *scratch* HOWTO
=====================

1. If you don't know where to start, list available configurations, and pick one:

===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup list
Default parameter values are in /home/alex/.bitbake-setup/config - adjust as needed.

Fetching configuration repository git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main into /home/alex/.bitbake-setup/configurations

Available configurations:
poky-alex	Poky reference distribution, with alex fixes
poky-kirkstone	Poky reference distribution, kirkstone long term support release (supported until April 2026)
poky-ng	Poky-ng configuration: like poky but built from individual repositories
===

2. Then build is initialized this way:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup init poky-ng
Default parameter values are in /home/alex/.bitbake-setup/config - adjust as needed.

Initializing a poky-ng build in /home/alex/builds/poky-ng
Fetching configuration repository git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main into /home/alex/.bitbake-setup/configurations
Fetching layer/tool repository bitbake into /home/alex/builds/poky-ng/layers/bitbake
Fetching layer/tool repository openembedded-core into /home/alex/builds/poky-ng/layers/openembedded-core
Fetching layer/tool repository meta-yocto into /home/alex/builds/poky-ng/layers/meta-yocto
Fetching layer/tool repository yocto-docs into /home/alex/builds/poky-ng/layers/yocto-docs

Setting up configuration in /home/alex/builds/poky-ng/build-default
Configuration summary:
This is the default build configuration for the openembedded-core layer.

Additional information is in /home/alex/builds/poky-ng/build-default/conf/conf-notes.txt

Run /home/alex/builds/poky-ng/build-default/build-targets to execute the default build targets for this configuration.
Source the environment using '. /home/alex/builds/poky-ng/build-default/init-build-env' to run builds from the command line.
The bitbake build configuration (local.conf, bblayers.conf and more) can be found in /home/alex/builds/poky-ng/build-default/conf
===

Note: 'init' sub-command can also take a path or a URL with a configuration file directly.
You can see how those files look like here:
https://github.com/kanavin/bitbake-setup-configurations

3. The above message refers to a one-liner shell script that would build the targets
specified in the chosen configuration:
===
alex@Zen2:/srv/work/alex/bitbake$ cat /home/alex/builds/poky-alex/build-gadget/build-targets
. /home/alex/builds/poky-alex/build-gadget/init-build-env && bitbake core-image-minimal
===

4. You should also source the environment, and then subsequent status/update commands
will not require a parameter telling bitbake-setup where the initialized build is.

5. To check if the build configuration needs to be updated, run:
===
Default parameter values are in /home/alex/.bitbake-setup/config - adjust as needed.

Fetching configuration repository git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main into /home/alex/.bitbake-setup/configurations
Configuration in /home/alex/builds/poky-ng/ has not changed.
===

If the configuration has changed, you will see the difference:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status
...
Top level configuration in /home/alex/builds/poky-alex has changed:
--- /home/alex/builds/poky-alex/config/poky-alex.conf.json	2024-12-16 11:43:24.077446096 +0100
+++ /home/alex/builds/poky-alex/config-tmp-asoubw5u/poky-alex.conf.json	2024-12-16 11:47:43.237104405 +0100
@@ -7,7 +7,7 @@
                         "uri": "git://git.yoctoproject.org/poky-contrib"
                     }
                 },
-                "rev": "akanavin/sstate-for-all"
+                "rev": "akanavin/bitbake-setup-testing"
             },
             "path": "poky"
         }
===

If the configuration has not changed, but layer revisions referred to it have (for example
if the configuration specifies a tip of a branch), you will see that too:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status
...
Layer repository git://git.yoctoproject.org/poky-contrib checked out into /home/alex/builds/poky-alex/layers/poky updated revision akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to aeb73e29379fe6007a8adc8d94c1ac18a93e68de
===

6. If the configuration has changed, you can bring it in sync with:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update ~/builds/poky-alex/
Default parameter values are in /home/alex/.bitbake-setup/config - adjust as needed.

Fetching configuration repository git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main into /home/alex/.bitbake-setup/configurations
Layer repository git://git.yoctoproject.org/poky-contrib checked out into /home/alex/builds/poky-alex/layers/poky updated revision akanavin/bitbake-setup-testing from d174acad934f8ad1fe303abc5705733e15542859 to a3d2ee10045f8c1151d680ad97994c5d6cf51ece
Fetching layer/tool repository poky into /home/alex/builds/poky-alex/layers/poky

Setting up configuration in /home/alex/builds/poky-alex/build-gadget
Existing bitbake congfiguration directory renamed to /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007
The bitbake configuration has changed:
diff -uNr /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007/local.conf /home/alex/builds/poky-alex/build-gadget/conf/local.conf
--- /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007/local.conf	2024-12-16 11:47:51.865043102 +0100
+++ /home/alex/builds/poky-alex/build-gadget/conf/local.conf	2024-12-16 11:50:07.811942847 +0100
@@ -287,5 +287,3 @@
 # track the version of this file when it was generated. This can safely be ignored if
 # this doesn't mean anything to you.
 CONF_VERSION = "2"
-
-TCLIBC = "musl"

Configuration summary:
This is the default build configuration for the Poky reference distribution.

Additional information is in /home/alex/builds/poky-alex/build-gadget/conf/conf-notes.txt

Run /home/alex/builds/poky-alex/build-gadget/build-targets to execute the default build targets for this configuration.
Source the environment using '. /home/alex/builds/poky-alex/build-gadget/init-build-env' to run builds from the command line.
The bitbake build configuration (local.conf, bblayers.conf and more) can be found in /home/alex/builds/poky-alex/build-gadget/conf
===

Note that it will also rename/preserve the existing build/conf directory, and print changes
in bitbake configuration (diff of content of build/conf/) if that has changed. I can't
at the moment think of anything more clever that is also not much more brittle or complex
to implement, but open to suggestions.

7. To make it easier to review the code, please also review the data it's operating on:
===
alex@Zen2:/srv/work/alex/bitbake$ ls ~/.bitbake-setup/
cache  configurations  downloads
alex@Zen2:/srv/work/alex/bitbake$ ls ~/builds/poky-alex/
build  config  config-upstream.json  layers
===

Terminology
===========

- 'top directory' means the place under which bitbake-setup reads and
writes everything. bitbake-setup makes a promise to not touch anything outside of
that, unless otherwise directed to by entries in settings (currently
there is one such setting for fetcher downloads for layers and config
registries). Top directory can be selected by a command line option,
or otherwise assumed to be ~/bitbake-builds/. If BBPATH is in environment
(e.g. we are in a bitbake environment), then the top directory is
deduced from that and doesn't need to be specified by hand.

- 'settings' means bitbake-setup operational parameters that are
global to all builds under a top directory. E.g. the location of
configuration registry, or where the bitbake fetcher should place the
downloads (DL_DIR setting). Settings are stored in a .conf file in ini
format just under the top directory.

- ' build' means a tree structure set up by 'bitbake-setup init',
consisting of, at least, a layers checkout, and a set of bitbake
builds. It maps 1:1 to the json data it was constructed from, which is
called 'configuration'. Configuration files are either standalone
files, or are obtained from git repositories called 'config
registries', in which case they can be listed with 'bitbake-setup
list'. There can be multiple 'builds' under a top directory. Here's an
example configuration that showcases this:
https://github.com/kanavin/bitbake-setup-configurations/blob/main/poky-alex.conf.json

- 'bitbake-setup status' will tell if a configuration is in sync with
the build it was made from. 'bitbake-setup update' will bring a build
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

This commit includes a fix by Ryan Eatmon <reatmon@ti.com>:
https://github.com/kanavin/bitbake/pull/1

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 461 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)
 create mode 100755 bin/bitbake-setup

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
new file mode 100755
index 000000000..6a7eb0d70
--- /dev/null
+++ b/bin/bitbake-setup
@@ -0,0 +1,461 @@
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
+def get_config_name(config):
+    return os.path.basename(config).split('.')[0]
+
+def copy_and_commit_config(config_path, dest_config_dir):
+    shutil.copy(config_path, dest_config_dir)
+
+    bb.process.run("git -C {} add .".format(dest_config_dir))
+    bb.process.run("git -C {} commit -a -m 'Configuration at {}'".format(dest_config_dir, time.asctime()))
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
+            print("Fetching layer/tool repository {} into {}".format(r_name, os.path.join(layerdir,repodir)))
+            fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
+            do_fetch(fetcher, layerdir)
+
+        if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
+            oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
+
+    _write_layer_list(layerdir, repodirs)
+
+    if oesetupbuild:
+        oesetupbuild_symlink = os.path.join(layerdir, 'setup-build')
+        if os.path.exists(oesetupbuild_symlink):
+            os.remove(oesetupbuild_symlink)
+        os.symlink(os.path.relpath(oesetupbuild,layerdir),oesetupbuild_symlink)
+
+def setup_bitbake_build(name, bitbake_config, layerdir, builddir):
+    bitbake_builddir = os.path.join(builddir, "build-{}".format(name))
+    print("==============================")
+    print("Setting up bitbake configuration {} in {}".format(name, bitbake_builddir))
+
+    template = bitbake_config.get("oe-template")
+    if not template:
+        print("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
+        return
+    oesetupbuild = os.path.join(layerdir, 'setup-build')
+    if not os.path.exists(oesetupbuild):
+        raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
+
+    bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
+    backup_bitbake_confdir = bitbake_confdir + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+    if os.path.exists(bitbake_confdir):
+        os.rename(bitbake_confdir, backup_bitbake_confdir)
+    bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
+
+    build_script = os.path.join(bitbake_builddir, "build-targets")
+    init_script = os.path.join(bitbake_builddir, "init-build-env")
+    targets = " && ".join(bitbake_config["targets"])
+    shell = os.path.basename(os.environ.get("SHELL","bash"))
+    with open(build_script,'w') as f:
+        f.write("#!/usr/bin/env {}\n. {} && {}\n".format(shell, init_script, targets))
+    st = os.stat(build_script)
+    os.chmod(build_script, st.st_mode | stat.S_IEXEC)
+
+    fragments = bitbake_config.get("oe-fragments")
+    if fragments:
+        for f in fragments:
+            bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, f))
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
+    with open(os.path.join(bitbake_builddir,'conf/conf-summary.txt')) as f:
+        print("Bitbake configuration summary:\n{}\nAdditional information is in {}\n".format(f.read(), os.path.join(bitbake_builddir,'conf/conf-notes.txt')))
+    print("Run {} to execute the default build targets for this bitbake configuration.".format(build_script))
+    print("Source the environment using '. {}' to run builds from the command line.".format(init_script))
+    print("The bitbake configuration (local.conf, bblayers.conf and more) can be found in {}/conf".format(bitbake_builddir))
+
+def get_registry_config(registry_path, id, dest_dir):
+    for root, dirs, files in os.walk(registry_path):
+        for f in files:
+            if f.endswith('.conf.json') and id == get_config_name(f):
+                shutil.copy(os.path.join(root, f), dest_dir)
+                return f
+    raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
+
+def obtain_config(upstream_config, dest_dir, cache_dir, d):
+    if upstream_config["type"] == 'local':
+        shutil.copy(upstream_config['path'], dest_dir)
+        basename = os.path.basename(upstream_config['path'])
+    elif upstream_config["type"] == 'network':
+        bb.process.run("wget {}".format(upstream_config["uri"]), cwd=dest_dir)
+        basename = os.path.basename(upstream_config['uri'])
+    elif upstream_config["type"] == 'registry':
+        registry_path = update_registry(upstream_config["registry"], cache_dir, d)
+        basename = get_registry_config(registry_path, upstream_config["id"], dest_dir)
+    else:
+        raise Exception("Unknown configuration type: {}".format(upstream_config["type"]))
+    return os.path.join(dest_dir, basename)
+
+def update_build(config_path, confdir, builddir, layerdir, d, update_layers_only=False):
+    bitbake_configs = json.load(open(config_path))["configuration"]["bitbake-setup"]
+    layer_config = json.load(open(config_path))["sources"]
+    if not update_layers_only:
+        copy_and_commit_config(config_path, confdir)
+    checkout_layers(layer_config, layerdir, d)
+    for bitbake_config_name, bitbake_config in bitbake_configs.items():
+        setup_bitbake_build(bitbake_config_name, bitbake_config, layerdir, builddir)
+
+def init_config(settings, args, d):
+    stdout = sys.stdout
+    def handle_task_progress(event, d):
+        rate = event.rate if event.rate else ''
+        progress = event.progress if event.progress > 0 else 0
+        print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
+
+    config_name = get_config_name(args.config)
+    builddir = os.path.join(os.path.abspath(args.top_dir), config_name)
+    if os.path.exists(builddir):
+        print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
+        return
+
+    print("Initializing a {} build in {}".format(config_name, builddir))
+
+    if os.path.exists(args.config):
+        upstream_config = {'type':'local','path':os.path.abspath(args.config)}
+    elif args.config.startswith("http://") or args.config.startswith("https://"):
+        upstream_config = {'type':'network','uri':args.config}
+    else:
+        upstream_config = {'type':'registry','registry':settings["default"]["registry"],'id':args.config}
+
+    os.makedirs(builddir)
+
+    with open(os.path.join(builddir, "config-upstream.json"),'w') as s:
+        json.dump(upstream_config, s, sort_keys=True, indent=4)
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
+    with tempfile.TemporaryDirectory(dir=builddir, prefix='config-tmp-') as tmpdirname:
+        config_path = obtain_config(upstream_config, tmpdirname, cache_dir(args.top_dir), d)
+        update_build(config_path, confdir, builddir, layerdir, d)
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
+    upstream_config = json.load(open(os.path.join(builddir, "config-upstream.json")))
+
+    with tempfile.TemporaryDirectory(dir=builddir, prefix='config-tmp-') as tmpdirname:
+        current_config_path = obtain_config(upstream_config, tmpdirname, cache_dir(args.top_dir), d)
+
+        build_config_path = os.path.join(confdir, os.path.basename(current_config_path))
+        config_diff = get_diff(build_config_path, current_config_path)
+        if config_diff:
+            print('Configuration in {} has changed:\n{}'.format(builddir, config_diff))
+            if update:
+                update_build(current_config_path, confdir, builddir, layerdir, d)
+            return
+
+    if are_layers_changed(json.load(open(build_config_path))["sources"], layerdir, d):
+        if update:
+            update_build(build_config_path, confdir, builddir, layerdir, d, update_layers_only=True)
+        return
+
+    print("Configuration in {} has not changed.".format(builddir))
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
+    print("Fetching configuration registry {} into {}".format(registry, full_registrydir))
+    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
+    do_fetch(fetcher, cachedir)
+    return full_registrydir
+
+def list_registry(registry_path):
+    print("\nAvailable configurations:")
+    for root, dirs, files in os.walk(registry_path):
+        for f in files:
+            if f.endswith('.conf.json'):
+                config_name = get_config_name(f)
+                config_desc = json.load(open(os.path.join(root, f)))["description"]
+                print("{}\t{}".format(config_name, config_desc))
+    print("\nRun 'init' with one of the above configuration identifiers to set up a build.")
+
+def list_configs(settings, args, d):
+    registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+    list_registry(registry_path)
+
+def default_settings_path(top_dir):
+    return os.path.join(top_dir, 'bitbake-setup.conf')
+
+def write_settings(top_dir, force_replace):
+    settings_path = default_settings_path(top_dir)
+    if not os.path.exists(settings_path) or force_replace:
+        if os.path.exists(settings_path):
+            backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+            os.rename(settings_path, backup_conf)
+            print("Previous settings are in {}".format(backup_conf))
+
+        settings = configparser.ConfigParser()
+        settings['default'] = {
+                             'registry':default_registry,
+                             'dl-dir':os.path.join(top_dir, '.bitbake-setup-downloads'),
+                            }
+        os.makedirs(os.path.dirname(settings_path), exist_ok=True)
+        with open(settings_path, 'w') as settingsfile:
+            settings.write(settingsfile)
+        print('Created a new settings file in {}.\n'.format(settings_path))
+
+def load_settings(top_dir):
+    # This creates a new settings file if it does not yet exist
+    write_settings(top_dir, force_replace=False)
+
+    settings_path = default_settings_path(top_dir)
+    settings = configparser.ConfigParser()
+    print('Loading settings from {}.\n'.format(settings_path))
+    settings.read([settings_path])
+    return settings
+
+def change_settings(top_dir, new_settings):
+    # This creates a new settings file if it does not yet exist
+    write_settings(top_dir, force_replace=False)
+
+    settings = load_settings(top_dir)
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
+        build_dir = os.path.dirname(bbpath.split(':')[0])
+        if os.path.exists(os.path.join(build_dir,'config-upstream.json')):
+            return build_dir
+    return None
+
+def get_default_top_dir():
+    build_dir_via_bbpath = get_build_dir_via_bbpath()
+    if build_dir_via_bbpath:
+        top_dir = os.path.dirname(build_dir_via_bbpath)
+        if os.path.exists(default_settings_path(top_dir)):
+            return top_dir
+    return os.path.join(os.path.expanduser('~'), 'bitbake-builds')
+
+def main():
+    def add_top_dir_arg(parser):
+        parser.add_argument('--top-dir', default=get_default_top_dir(), help='Top level directory where builds are set up and downloaded configurations and layers are cached for reproducibility and offline builds, default is %(default)s')
+
+    parser = argparse.ArgumentParser(
+        description="BitBake setup utility. Run with 'list' argument to get started.",
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
+    parser_list.set_defaults(func=list_configs)
+
+    parser_init = subparsers.add_parser('init', help='Initialize a build from a configuration')
+    add_top_dir_arg(parser_init)
+    parser_init.add_argument('config', help="path/URL/id to a configuration file, use 'list' command to get available ids")
+    parser_init.set_defaults(func=init_config)
+
+    build_dir = get_build_dir_via_bbpath()
+
+    parser_status = subparsers.add_parser('status', help='Check if the build needs to be synchronized with configuration')
+    if build_dir:
+        parser_status.add_argument('--build-dir', default=build_dir, help="Path to the build, default is %(default)s via BBPATH")
+    else:
+        parser_status.add_argument('--build-dir', required=True, help="Path to the build")
+    parser_status.set_defaults(func=build_status)
+
+    parser_update = subparsers.add_parser('update', help='Update a build to be in sync with configuration')
+    if build_dir:
+        parser_update.add_argument('--build-dir', default=build_dir, help="Path to the build, default is %(default)s via BBPATH")
+    else:
+        parser_update.add_argument('--build-dir', required=True, help="Path to the build")
+    parser_update.set_defaults(func=build_update)
+
+    parser_reset_settings = subparsers.add_parser('reset-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other global settings)')
+    add_top_dir_arg(parser_reset_settings)
+    parser_reset_settings.set_defaults(func=write_settings)
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
+    # commands without --top-dir argument (status, update) still need to know where
+    # the top dir is, but it should be auto-deduced as parent of args.build_dir
+    if not hasattr(args, 'top_dir') and hasattr(args, 'build_dir'):
+        args.top_dir = os.path.dirname(args.build_dir)
+
+    if 'func' in args:
+        if args.func == write_settings:
+            write_settings(args.top_dir, force_replace=True)
+        elif args.func == change_settings:
+            change_settings(args.top_dir, {args.section:{args.key:args.value}})
+        else:
+            settings = load_settings(args.top_dir)
+            d = init_bb_cache(settings, args)
+            args.func(settings, args, d)
+    else:
+        from argparse import Namespace
+        parser.print_help()
+
+main()
-- 
2.39.5


