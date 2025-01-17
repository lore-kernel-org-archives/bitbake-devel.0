Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C388C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:39 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.11404.1737123097489893898
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 06:11:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KK9b7Vzu;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38634c35129so1751727f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737123096; x=1737727896; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmVH8lzH9fK7J9M3hGArLdm71upWOKqsei8I+tccFd0=;
        b=KK9b7VzuZMb4AS0zDcAEJ09l0/edpLbR1gv6sCFk2+otle5KkbhISI4ois+vdLc3ZI
         GRuZ7HxITwOHsG7wC9fuh3/ZZfP7+svG9F7yXvCN1EfNRnxkWX4WBA02PV3NfmTTeqMg
         daHO/WzNrxvEHBS4muHFj+vCB/8ZwhYjrdibqys107B2EqN76XukLsbmNjwPzUOU0Kir
         7vLDNSJadD8zxLaWC2HZYRZDNDwdxzuYVlGo35aA3wRvU0J8QqoCcC/wVHjQNk2dqGtX
         EGW1GmOy85FlVCfahR7EzIf/JUpY70Ho+xZvyEIaNjV0i1mS9lHA8UXdhFyUVdBVhQvc
         1fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123096; x=1737727896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmVH8lzH9fK7J9M3hGArLdm71upWOKqsei8I+tccFd0=;
        b=L/xrpNj0KgFW+0KCxXsWWUOgpQV/QsqrlisXIBqxuirABgbZwkVzfGQdh+l7e2hTVF
         oYlAzti7u1zGxC8/Rr7ln8i3/ku1FG+Bn8ZgqoWTwxz/rc1HumCVESos5xwT7UkwIhuI
         eRA2PuHdnalluYgnjvKKpKVr1hSoIV1s33VanaaSNGLr98Mj9NN87i8nesTNaAMMJq0k
         OBi+MA2zoZ8qiMePXQKBd0M2zqusDBGCB52AgZ1/IAqmY12sN620p9alDyEEbfKex3Tn
         dlU9glgHhwfy6zBvy+8PhoKgKmsnbSFcNSPqQoJfwGXjn7L4I12XEzLlYCREVTTqB/Kc
         NeHA==
X-Gm-Message-State: AOJu0Ywu6qo1qX29ETSwSTNumPwgGT4EM/4wOiUM1l8bcZ2GDpJmlQnK
	HdVOCxiqwis2tVt6zI9gICtxc4HPFLdWdAoCLBXivEviHffS19PQWr3arA==
X-Gm-Gg: ASbGncuR4wT/7Gue3n8w3G/hZWA+T+Up4GRCbhM+B/BG0WvX5CuWqwqq3YivMPFjN1Q
	fMJzjmvXVRSknT9z5H/NBp1aC/Svk3YdKMPSqIs1hufgF6hZJET/LzpLA/JAjNlwhM3/bkLmfCA
	8hfEJQ2xT4py1ZvvMFHjIvbLz1R7NzDNMgZeULgm+dlZ4rM0Gg6eaaEXqSdkJGa/IdXQZDFb2LX
	zbV71iIr4hTDPmEstVjzSa1+y+hZSALIaEqIm2ROGKoecFTgU4sOXQkhvxMAxhhliNa7UQkvcQ2
	dSk5bpJcRBWu0QcvOA==
X-Google-Smtp-Source: AGHT+IHPeDVEo3zaRGlWlUkP3/a5IXfZXuubYQHDlbLHgJHaxDFzC8kizhC5Ryxs6I+ii6FHs1H+xQ==
X-Received: by 2002:a5d:6dc5:0:b0:385:df5d:622c with SMTP id ffacd0b85a97d-38bf57a49a9mr1814063f8f.30.1737123095399;
        Fri, 17 Jan 2025 06:11:35 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468c67sm35105845e9.34.2025.01.17.06.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:11:35 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH 1/2] bitbake-setup: add the proof of concept implementation
Date: Fri, 17 Jan 2025 15:11:26 +0100
Message-Id: <20250117141127.255295-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 14:11:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17033

From: Alexander Kanavin <alex@linutronix.de>

For the rationale and design guidelines please see this message:
https://lists.openembedded.org/g/openembedded-architecture/message/1913

Left out for now but will be done later:

- base bitbake configs (a way to declare the common parts between several bitbake build configurations just once, like a parent 'class')
(this is inspired by a similar mechannism in yocto-autobuilder)

- tighten the terminology: 'build' and 'configuration' are each used to refer to
several distinct things, and should be replaced by specific, unambigous terms

- documentation

- official configuration repository (this probably depends on oe-core being
populated with a rich, useful set of fragments)

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

This commit includes a fix by Ryan Eatmon <reatmon@ti.com>:
https://github.com/kanavin/bitbake/pull/1

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 403 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 403 insertions(+)
 create mode 100755 bin/bitbake-setup

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
new file mode 100755
index 000000000..9a78963a6
--- /dev/null
+++ b/bin/bitbake-setup
@@ -0,0 +1,403 @@
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
+bindir = os.path.abspath(os.path.dirname(__file__))
+topdir = os.path.dirname(bindir)
+sys.path[0:0] = [os.path.join(topdir, 'lib')]
+
+import bb.msg
+import bb.process
+
+logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
+
+def init_bb_cache(args):
+    dldir = os.path.join(args.cache_dir, 'downloads')
+    bb_cachedir = os.path.join(args.cache_dir, 'cache')
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
+def setup_build(name, config, layerdir, topbuilddir):
+    builddir = os.path.join(topbuilddir, "build-{}".format(name))
+    print("==============================")
+    print("Setting up configuration {} in {}".format(name, builddir))
+
+    template = config.get("oe-template")
+    if not template:
+        print("Configuration does not contain a reference to an OpenEmbedded build template via 'oe-template'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
+        return
+    oesetupbuild = os.path.join(layerdir, 'setup-build')
+    if not os.path.exists(oesetupbuild):
+        raise Exception("Cannot complete setting up a build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
+
+    confdir = os.path.join(builddir, 'conf')
+    backup_confdir = confdir + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+    if os.path.exists(confdir):
+        os.rename(confdir, backup_confdir)
+    bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, builddir))
+
+    build_script = os.path.join(builddir, "build-targets")
+    init_script = os.path.join(builddir, "init-build-env")
+    targets = " && ".join(config["targets"])
+    shell = os.path.basename(os.environ.get("SHELL","bash"))
+    with open(build_script,'w') as f:
+        f.write("#!/usr/bin/env {}\n. {} && {}\n".format(shell, init_script, targets))
+    st = os.stat(build_script)
+    os.chmod(build_script, st.st_mode | stat.S_IEXEC)
+
+    fragments = config.get("oe-fragments")
+    if fragments:
+        for f in fragments:
+            bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, f))
+
+    if os.path.exists(backup_confdir):
+        config_diff = get_diff(backup_confdir, confdir)
+        if config_diff:
+            print("Existing bitbake configuration directory renamed to {}".format(backup_confdir))
+            print("The bitbake configuration has changed:")
+            print(config_diff)
+        else:
+            shutil.rmtree(backup_confdir)
+
+    with open(os.path.join(builddir,'conf/conf-summary.txt')) as f:
+        print("Configuration summary:\n{}\nAdditional information is in {}\n".format(f.read(), os.path.join(builddir,'conf/conf-notes.txt')))
+    print("Run {} to execute the default build targets for this configuration.".format(build_script))
+    print("Source the environment using '. {}' to run builds from the command line.".format(init_script))
+    print("The bitbake build configuration (local.conf, bblayers.conf and more) can be found in {}/conf".format(builddir))
+
+def get_registry_config(registry_path, id, dest_dir):
+    for root, dirs, files in os.walk(registry_path):
+        for f in files:
+            if f.endswith('.conf.json') and id == get_config_name(f):
+                shutil.copy(os.path.join(root, f), dest_dir)
+                return f
+    raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
+
+def obtain_config(upstream_config, dest_dir, args, d):
+    if upstream_config["type"] == 'local':
+        shutil.copy(upstream_config['path'], dest_dir)
+        basename = os.path.basename(upstream_config['path'])
+    elif upstream_config["type"] == 'network':
+        bb.process.run("wget {}".format(upstream_config["uri"]), cwd=dest_dir)
+        basename = os.path.basename(upstream_config['uri'])
+    elif upstream_config["type"] == 'registry':
+        registry_path = update_registry(upstream_config["registry"], args.cache_dir, d)
+        basename = get_registry_config(registry_path, upstream_config["id"], dest_dir)
+    else:
+        raise Exception("Unknown configuration type: {}".format(upstream_config["type"]))
+    return os.path.join(dest_dir, basename)
+
+def update_build_config(config_path, confdir, topbuilddir, layerdir, d, update_layers_only=False):
+    build_configs = json.load(open(config_path))["configuration"]["bitbake-setup"]
+    layer_config = json.load(open(config_path))["sources"]
+    if not update_layers_only:
+        copy_and_commit_config(config_path, confdir)
+    checkout_layers(layer_config, layerdir, d)
+    for build_name, build_config in build_configs.items():
+        setup_build(build_name, build_config, layerdir, topbuilddir)
+
+def init_config(args, d):
+    stdout = sys.stdout
+    def handle_task_progress(event, d):
+        rate = event.rate if event.rate else ''
+        progress = event.progress if event.progress > 0 else 0
+        print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
+
+    config_name = get_config_name(args.config)
+    topbuilddir = os.path.join(os.path.abspath(args.build_dir_prefix), config_name)
+    if os.path.exists(topbuilddir):
+        print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(topbuilddir))
+        return
+
+    print("Initializing a {} build in {}".format(config_name, topbuilddir))
+
+    if os.path.exists(args.config):
+        upstream_config = {'type':'local','path':os.path.abspath(args.config)}
+    elif args.config.startswith("http://") or args.config.startswith("https://"):
+        upstream_config = {'type':'network','uri':args.config}
+    else:
+        upstream_config = {'type':'registry','registry':args.registry,'id':args.config}
+
+    os.makedirs(topbuilddir)
+
+    with open(os.path.join(topbuilddir, "config-upstream.json"),'w') as s:
+        json.dump(upstream_config, s, sort_keys=True, indent=4)
+
+    confdir = os.path.join(topbuilddir, "config")
+    layerdir = os.path.join(topbuilddir, "layers")
+
+    os.makedirs(confdir)
+    os.makedirs(layerdir)
+
+    bb.process.run("git -C {} init -b main".format(confdir))
+    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
+
+    bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
+
+    with tempfile.TemporaryDirectory(dir=topbuilddir, prefix='config-tmp-') as tmpdirname:
+        config_path = obtain_config(upstream_config, tmpdirname, args, d)
+        update_build_config(config_path, confdir, topbuilddir, layerdir, d)
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
+def build_status(args, d, update=False):
+    topbuilddir = args.build_dir
+
+    confdir = os.path.join(topbuilddir, "config")
+    layerdir = os.path.join(topbuilddir, "layers")
+
+    upstream_config = json.load(open(os.path.join(topbuilddir, "config-upstream.json")))
+
+    with tempfile.TemporaryDirectory(dir=topbuilddir, prefix='config-tmp-') as tmpdirname:
+        current_config_path = obtain_config(upstream_config, tmpdirname, args, d)
+
+        build_config_path = os.path.join(confdir, os.path.basename(current_config_path))
+        config_diff = get_diff(build_config_path, current_config_path)
+        if config_diff:
+            print('Top level configuration in {} has changed:\n{}'.format(topbuilddir, config_diff))
+            if update:
+                update_build_config(current_config_path, confdir, topbuilddir, layerdir, d)
+            return
+
+    if are_layers_changed(json.load(open(build_config_path))["sources"], layerdir, d):
+        if update:
+            update_build_config(build_config_path, confdir, topbuilddir, layerdir, d, update_layers_only=True)
+        return
+
+    print("Configuration in {} has not changed.".format(topbuilddir))
+
+def build_update(args, d):
+    build_status(args, d, update=True)
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
+    print("Fetching configuration repository {} into {}".format(registry, full_registrydir))
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
+
+def list_configs(args, d):
+    registry_path = update_registry(args.registry, args.cache_dir, d)
+    list_registry(registry_path)
+
+def default_tool_config_path():
+    return os.environ.get('BITBAKE_SETUP_CONFIG') or os.path.join(os.path.expanduser('~'), '.bitbake-setup', 'config')
+
+def write_tool_config(force_overwrite):
+    config_path = default_tool_config_path()
+    if not os.path.exists(config_path) or force_overwrite:
+        config = configparser.ConfigParser()
+        config['default'] = {'registry':'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main',
+                             'cache-dir':os.path.join(os.path.expanduser('~'), '.bitbake-setup'),
+                             'build-dir-prefix':os.path.join(os.path.expanduser('~'), 'builds')}
+        os.makedirs(os.path.dirname(config_path), exist_ok=True)
+        with open(config_path, 'w') as configfile:
+            config.write(configfile)
+
+def load_tool_config():
+    # This creates a new config file if it does not yet exist
+    write_tool_config(force_overwrite=False)
+
+    config_path = default_tool_config_path()
+    config = configparser.ConfigParser()
+    print('Default parameter values are in {} - adjust as needed.\n'.format(config_path))
+    config.read([config_path])
+    return config
+
+def get_build_dir():
+    bbpath = os.environ.get('BBPATH')
+    if bbpath:
+        build_dir = os.path.dirname(bbpath.split(':')[0])
+        if os.path.exists(os.path.join(build_dir,'config-upstream.json')):
+            return build_dir
+    return None
+
+def main():
+    config = load_tool_config()
+
+    parser = argparse.ArgumentParser(
+        description="BitBake setup utility",
+        epilog="Use %(prog)s <subcommand> --help to get help on a specific command"
+        )
+    parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
+    parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
+    parser.add_argument('--registry', default=config['default']['registry'], help='Git repository with configuration files (in bitbake SRC_URI format), default is %(default)s')
+    parser.add_argument('--cache-dir', default=config['default']['cache-dir'], help='Directory where downloaded configurations and layers are cached for reproducibility and offline builds, default is %(default)s')
+    parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
+
+    subparsers = parser.add_subparsers()
+
+    parser_init = subparsers.add_parser('init', help='Initialize a build from a configuration')
+    parser_init.add_argument('config', help="path/URL/id to a configuration file, use 'list' command to get available ids")
+    parser_init.add_argument('--build-dir-prefix', help="Directory prefix under which the build directory should be created and initialized, default is %(default)s", default=config['default']['build-dir-prefix'])
+    parser_init.set_defaults(func=init_config)
+
+    build_dir = get_build_dir()
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
+    parser_list = subparsers.add_parser('list', help='List available configurations')
+    parser_list.set_defaults(func=list_configs)
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
+    d = init_bb_cache(args)
+    if 'func' in args:
+        args.func(args, d)
+    else:
+        from argparse import Namespace
+        parser.print_help()
+
+main()
-- 
2.39.5


