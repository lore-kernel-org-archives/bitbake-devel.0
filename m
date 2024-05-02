Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6EC4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 10:58:05 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web11.10667.1714647475208393565
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 May 2024 03:57:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EQ/8LY31;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso127030971fa.1;
        Thu, 02 May 2024 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714647473; x=1715252273; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKpu5HWdcHr+YMeV9mcdhjx3vRCoiCfDC2x8YPr7g38=;
        b=EQ/8LY31vmkSY4ZHGhSWJxS2XPFMJR4ANdJd1FggSTk989wC2mhWlgWLgoykVVnknF
         RQEOCjY0PoiBX+hAvPaSUQeCzTfzjh8l7YPCisATMPYJXMM+NjWbyhbffgbOFwNa5NOj
         hPaOeclPohbhY3LjEvc+bzh+6xxfDw0m/4znfHWbrr5lc3MG+BobE7aCmWdRfRK1KPsx
         0H/cOXa8ntxP4LaEENf/2DfZzung121/21C03B8oHciLhj33SrDggb6MspxuWZhg1EEL
         dq+FmYagJ5oOuRf2Wt4QLX9B4bFb5v2wGepZB50h8zu5FU2VDpTm9bvSvdIgnw5aq84X
         DbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714647473; x=1715252273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKpu5HWdcHr+YMeV9mcdhjx3vRCoiCfDC2x8YPr7g38=;
        b=H/c/OIc5qgiTgFDRWTofE/Ia/WbTTmx5MqsXoIEDcUDtRET7KL73qldqeTXMBD35yh
         7U4RWyJhpS4kIpD46gULP/WLRyLPG4354r2z39EeHqxU2vKqJennegw5T6bL2HW88/TU
         Zu8xvLy0gH2JAqodTXfm5zXXPHSpQaDdmL2qCNA+P/wfG3t/TLboG/X3cdRixGqO7ef2
         uyY8rXx1k/XxFLzGW1WXS1mFrCYGy1ZXaCUVSI5PC5FDfqijwnN7wVk0NNYZrabuLxmu
         ZFp+fNTU3OwUftWgIoraQtMFKzsgieZg3GA9rvopuWQJ4Hf45eesnwfTVKNSlsnyngHM
         p7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUeAGVWxc0INrjQ1TSdiP9po2N28fTOehwUkE8y46LZ1H4Dt0EIxrPpNKnUBuIrVp1gUR/FXLkVHhW9hiPM1CjL1zoUEZkhG8xaf0G1uIf5omdwVBn2UhfwAek73ZeR+Gk=
X-Gm-Message-State: AOJu0YxFYxfT8ZTOuxyDUCSnIMAqigGkWAKWTmy7eEJETQ7mGPb6T3g9
	B6dqL1srfDB8mO2/DZMemjrMKF882JzccXHpzqBGRm0ZK3smustN73VsXA==
X-Google-Smtp-Source: AGHT+IHHUZ2vovqPLoQkuEIBoWkGHdjbgxeLqtrbagsYvOgcPT0y/X08yoNvzzUFruSZLExk591DEQ==
X-Received: by 2002:a05:6512:3a8d:b0:51d:3675:6a06 with SMTP id q13-20020a0565123a8d00b0051d36756a06mr5384024lfu.66.1714647472697;
        Thu, 02 May 2024 03:57:52 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id b27-20020a17090636db00b00a5216df5d25sm419890ejc.3.2024.05.02.03.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 03:57:52 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	yocto@lists.yoctoproject.org,
	openembedded-architecture@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH] bitbake-setup: add the proof of concept implementation
Date: Thu,  2 May 2024 12:57:45 +0200
Message-Id: <20240502105745.3073153-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 10:58:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16179

From: Alexander Kanavin <alex@linutronix.de>

For the rationale and design guidelines please see this message:
https://lists.openembedded.org/g/openembedded-architecture/message/1913

Left out for now but will be done later:
- config fragment support
- tests
- documentation
- official configuration repository

1. If you don't know where to start, list available configurations, and pick one:

===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup list
Available configurations:
poky-alex	Poky reference distribution, with alex fixes
poky-kirkstone	Poky reference distribution, kirkstone long term support release (supported until April 2026)
===

2. Then build is initialized this way:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup init poky-alex
Initializing build in /home/alex/builds/poky-alex

Run /home/alex/builds/poky-alex/build/build.sh to build using this configuration.
===

Note: 'init' sub-command can also take a path or a URL with a configuration file directly.
You can see how those files look like here:
https://github.com/kanavin/bitbake-setup-configurations

3. The above message refers to a one-liner shell script that would build the targets
specified in the chosen configuration:
===
alex@Zen2:/srv/work/alex/bitbake$ cat /home/alex/builds/poky-alex/build/build.sh
. /home/alex/builds/poky-alex/build/init-build-env && bitbake core-image-minimal
===

4. To check if the build configuration needs to be updated, run:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status ~/builds/poky-alex/
Configuration has not changed.
===

If the configuration has changed, you will see the difference:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status ~/builds/poky-alex/
Top level configuration has changed:
--- /home/alex/builds/poky-alex/config/poky-alex.conf.json	2024-04-18 13:42:54.312460823 +0200
+++ /home/alex/builds/poky-alex/config-tmp-b413az6s/poky-alex.conf.json	2024-04-18 13:50:42.635433203 +0200
@@ -7,7 +7,7 @@
                         "uri": "git://git.yoctoproject.org/poky-contrib"
                     }
                 },
-                "rev": "akanavin/sstate-for-all"
+                "rev": "akanavin/sstate-for-all-and-everyone"
             },
             "path": "poky"
         }
===

If the configuration has not changed, but layer revisions referred to it have (for example
if the configuration specifies a tip of a branch), you will see that too:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status ~/builds/poky-alex/
Layer repository git://git.yoctoproject.org/poky-contrib checked out into /home/alex/builds/poky-alex/layers/poky updated revision akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to aeb73e29379fe6007a8adc8d94c1ac18a93e68de
===

5. If the configuration has changed, you can bring it in sync with:
===
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update ~/builds/poky-alex/
Layer repository git://git.yoctoproject.org/poky-contrib checked out into /home/alex/builds/poky-alex/layers/poky updated revision akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to aeb73e29379fe6007a8adc8d94c1ac18a93e68de
... (skip git output)
Existing build directory renamed to /home/alex/builds/poky-alex/build-backup.20240418135458

Run /home/alex/builds/poky-alex/build/build.sh to build using this configuration.
===

Note that it will also rename the existing build directory, and print changes
in bitbake configuration (diff of content of build/conf/) if that has changed. I can't
at the moment think of anything more clever that is also not much more brittle or complex
to implement, but open to suggestions.

6. To make it easier to review the code, please also review the data it's operating on:
===
alex@Zen2:/srv/work/alex/bitbake$ ls ~/.bitbake-setup/
cache  configurations  downloads
alex@Zen2:/srv/work/alex/bitbake$ ls ~/builds/poky-alex/
build  build-backup.20240418135458  config  config-upstream.json  layers
===

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 310 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 310 insertions(+)
 create mode 100755 bin/bitbake-setup

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
new file mode 100755
index 00000000..5baa0730
--- /dev/null
+++ b/bin/bitbake-setup
@@ -0,0 +1,310 @@
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
+    dldir = os.path.join(args.cachedir, 'downloads')
+    persistdir = os.path.join(args.cachedir, 'cache')
+
+    d = bb.data.init()
+    d.setVar("DL_DIR", dldir)
+    d.setVar("PERSISTENT_DIR", persistdir)
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
+            fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
+            fetcher.download()
+            fetcher.unpack(layerdir)
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
+def setup_build(config, layerdir, builddir):
+    oesetupbuild = os.path.join(layerdir, 'setup-build')
+    if not os.path.exists(oesetupbuild):
+        print("Cannot complete setting up a build directory as oe-setup-build was not found; please use oe-init-build-env manually.")
+        return
+    template = config["template"]
+    backup_builddir = None
+    if os.path.exists(builddir):
+        backup_builddir = builddir + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+        os.rename(builddir, backup_builddir)
+        print("Existing build directory renamed to {}".format(backup_builddir))
+    bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, builddir))
+    if backup_builddir:
+        config_diff_stdout, config_diff_stderr = bb.process.run("diff -uNr {} {}".format(os.path.join(backup_builddir, 'conf'), os.path.join(builddir, 'conf')))
+        if config_diff_stdout:
+            print("The bitbake configuration has changed:")
+            print(config_diff_stdout)
+    build_script = os.path.join(builddir, "build.sh")
+    init_script = os.path.join(builddir, "init-build-env")
+    targets = " && ".join(config["targets"])
+    shell = os.environ["SHELL"]
+    with open(build_script,'w') as f:
+        f.write("#!{}\n. {} && {}\n".format(shell, init_script, targets))
+    st = os.stat(build_script)
+    os.chmod(build_script, st.st_mode | stat.S_IEXEC)
+    print("\nRun {} to build using this configuration.".format(build_script))
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
+        registry_path = update_registry(upstream_config["registry"], args.cachedir, d)
+        basename = get_registry_config(registry_path, upstream_config["id"], dest_dir)
+    else:
+        raise Exception("Unknown configuration type: {}".format(upstream_config["type"]))
+    return os.path.join(dest_dir, basename)
+
+def update_build_config(config_path, confdir, builddir, layerdir, d, update_layers_only=False):
+    build_config = json.load(open(config_path))["configuration"]["bitbake-setup"]["default"]
+    layer_config = json.load(open(config_path))["sources"]
+    if not update_layers_only:
+        copy_and_commit_config(config_path, confdir)
+    checkout_layers(layer_config, layerdir, d)
+    setup_build(build_config, layerdir, builddir)
+
+def init_config(args, d):
+    topbuilddir = args.build_dir or os.path.join(os.path.expanduser('~'), 'builds', get_config_name(args.config))
+    os.makedirs(topbuilddir)
+    print("Initializing build in {}".format(topbuilddir))
+
+    if os.path.exists(args.config):
+        upstream_config = {'type':'local','path':os.path.abspath(args.config)}
+    elif args.config.startswith("http://") or args.config.startswith("https://"):
+        upstream_config = {'type':'network','uri':args.config}
+    else:
+        upstream_config = {'type':'registry','registry':args.registry,'id':args.config}
+
+    with open(os.path.join(topbuilddir, "config-upstream.json"),'w') as s:
+        json.dump(upstream_config, s, sort_keys=True, indent=4)
+
+    confdir = os.path.join(topbuilddir, "config")
+    builddir = os.path.join(topbuilddir, "build")
+    layerdir = os.path.join(topbuilddir, "layers")
+
+    os.makedirs(confdir)
+    os.makedirs(layerdir)
+
+    bb.process.run("git -C {} init -b main".format(confdir))
+    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
+
+    with tempfile.TemporaryDirectory(dir=topbuilddir, prefix='config-tmp-') as tmpdirname:
+        config_path = obtain_config(upstream_config, tmpdirname, args, d)
+        update_build_config(config_path, confdir, builddir, layerdir, d)
+
+def print_diff(file1, file2):
+    try:
+        bb.process.run('diff -u {} {}'.format(file1, file2))
+    except bb.process.ExecutionError as e:
+        if e.exitcode == 1:
+            print(e.stdout)
+        else:
+            raise e
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
+    builddir = os.path.join(topbuilddir, "build")
+    layerdir = os.path.join(topbuilddir, "layers")
+
+    upstream_config = json.load(open(os.path.join(topbuilddir, "config-upstream.json")))
+
+    with tempfile.TemporaryDirectory(dir=topbuilddir, prefix='config-tmp-') as tmpdirname:
+        current_config_path = obtain_config(upstream_config, tmpdirname, args, d)
+
+        current_config = open(current_config_path).read()
+        build_config_path = os.path.join(confdir, os.path.basename(current_config_path))
+        build_config = open(build_config_path).read()
+        if current_config != build_config:
+            print('Top level configuration has changed:')
+            print_diff(build_config_path, current_config_path)
+            if update:
+                update_build_config(current_config_path, confdir, builddir, layerdir, d)
+            return
+
+    if are_layers_changed(json.loads(build_config)["sources"], layerdir, d):
+        if update:
+            update_build_config(build_config_path, confdir, builddir, layerdir, d, update_layers_only=True)
+        return
+
+    print("Configuration has not changed.")
+
+def build_update(args, d):
+    build_status(args, d, update=True)
+
+def update_registry(registry, cachedir, d):
+    registrydir = 'configurations'
+    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
+    fetcher.download()
+    fetcher.unpack(cachedir)
+    return os.path.join(cachedir, registrydir)
+
+def list_registry(registry_path):
+    print("Available configurations:")
+    for root, dirs, files in os.walk(registry_path):
+        for f in files:
+            if f.endswith('.conf.json'):
+                config_name = get_config_name(f)
+                config_desc = json.load(open(os.path.join(root, f)))["description"]
+                print("{}\t{}".format(config_name, config_desc))
+
+def list_configs(args, d):
+    registry_path = update_registry(args.registry, args.cachedir, d)
+    list_registry(registry_path)
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="BitBake setup utility",
+        epilog="Use %(prog)s <subcommand> --help to get help on a specific command"
+        )
+    parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
+    parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
+    parser.add_argument('--registry', default='git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main', help='Git repository with configuration files (in bitbake SRC_URI format)')
+    parser.add_argument('--cachedir', default=os.path.join(os.path.expanduser('~'), '.bitbake-setup'), help='Directory where downloaded configurations and layers are cached for reproducibility and offline builds')
+    parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
+
+    subparsers = parser.add_subparsers()
+
+    parser_init = subparsers.add_parser('init', help='Initialize a configuration')
+    parser_init.add_argument('config', help="path/URL/id to a configuration file")
+    parser_init.add_argument('--build-dir', help="Where to initialize the build", required=False)
+    parser_init.set_defaults(func=init_config)
+
+    parser_status = subparsers.add_parser('status', help='Check if the build configuration needs to be updated')
+    parser_status.add_argument('build_dir', help="Path to the build")
+    parser_status.set_defaults(func=build_status)
+
+    parser_status = subparsers.add_parser('update', help='Update a build configuration')
+    parser_status.add_argument('build_dir', help="Path to the build")
+    parser_status.set_defaults(func=build_update)
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
2.39.2


