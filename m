Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EECCAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 20:01:54 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.7084.1757620904173397180
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Sep 2025 13:01:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SS9dge8d;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: reatmon@ti.com)
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BK1cRV450309;
	Thu, 11 Sep 2025 15:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757620898;
	bh=1rR/oQZR5q6dxUIoDPSQJaez6wFUo28DA0mf5ww9B2w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SS9dge8dj/+UkP/TtJR1hcpT2MiH5LM8P+oUGAgPNCoVeqf1d5brPQQaJA8T9v2XE
	 6gO6mXMFZtv5Lb23lhHPU3VldV64kr9EzD2oA8VkxunDM4scSeIy/xxLoceKyWAFgw
	 o3/v7SQJ9fqxs+ZLgwMYtjRqtcTZRYwjrcXThicc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BK1cOj2231549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 15:01:38 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 15:01:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 15:01:38 -0500
Received: from [10.249.37.202] ([10.249.37.202])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BK1com2781378;
	Thu, 11 Sep 2025 15:01:38 -0500
Message-ID: <4eb83cb1-f5d5-49dc-bef5-9476e4018d40@ti.com>
Date: Thu, 11 Sep 2025 15:01:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
References: <20250908123437.1728264-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <20250908123437.1728264-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Sep 2025 20:01:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18007


Thank you, Alexander, for this update.  It is definitly an improvement 
over the initial version from last fall.

I really appreciate the addition of the layers and the fragments to 
allow for configs to control more things.

I have updated TI's oe-layersetup repository's bitbake-setup directory 
to conform to this new version and provide more examples for folks 
wanting to see it.

https://git.ti.com/cgit/arago-project/oe-layersetup/

The bitbake-setup/ directory contains all of the json files, and the 
conf/ directory acts like a yocto layer to provide the config fragments 
for the different configs.

The only feedback I have a sort of nitpick things.  And I will probably 
submit a patch series to address these in the next day or so as I work 
out fixes for them.

1) The interactive interface has a couple of usability issues.
   a) When prompted to pick a number, if you just hit enter, you get a 
stack trace since the empty string is not a number.
   b) If there is only a single choice to pick from, it would be nice to 
auto pick option instead of making someone type 0.

2) The directory name that is chosen is a little unweildy.  It looks 
like it takes the json file name, plus the configuration name, plus (if 
set it up like your example) the distro name and the machine name.  For 
my builds this resulted in:
   arago-master-wip-config-arago-distro_arago-machine_am62xx-evm
Which is just mouthful, with arago repated over and over three times.
   a) Maybe allow the json file to specify a style for this directory 
name?  long, short, custom?  With custom having another entry to specify 
how to build up that string.
   b) When finding the json file portion of the above, the code is just 
finding the first . and chopping off the end rather looking for the 
ending .json and removing it.  Some of our config files have versions in 
the file name with . and it made for a goofy directory name.

Again, nitpicky items.  Overall, though a big improvement.  I will work 
on some patches to address my concerns above and submit them to the list 
once I have them.

Thank you again for doing this work.



On 9/8/2025 7:34 AM, Alexander Kanavin via lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
> 
> Preamble
> ========
> 
> The latest iteration of this patchset is available at
> https://github.com/kanavin/bitbake
> I recommend taking the patches from there to ensure that
> you are not trying out outdated code.
> 
> For the rationale and design guidelines please see this message:
> https://lists.openembedded.org/g/openembedded-architecture/message/1913
> 
> Left out for now but will be done later:
> 
> - official configuration repository
> 
> - documentation
> 
> Amble *scratch* HOWTO
> =====================
> 
> 1. If you don't know where to start, run 'bitbake-setup init'.
> 
> Bitbake-setup will ask a few questions about available configuration choices and set up a build.
> 
> Note: 'init' sub-command can also take a path or a URL with a configuration file directly.
> You can see how those files look like here:
> https://github.com/kanavin/bitbake-setup-configurations
> 
> 2. You can then source the bitbake environment and run bitbake to perform builds as usual:
> 
> $ . /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_qemux86-64/build/init-build-env
> 
> Also, subsequent status/update commands will not require a separate --build-dir argument telling
> bitbake-setup where the build is.
> 
> 3. To check if the build configuration needs to be updated, run:
> 
> ===
> $ bin/bitbake-setup status
> ...
> Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed.
> ===
> 
> If the configuration has changed, you will see the difference as a diff.
> ...
>    -                "rev": "akanavin/sstate-for-all"
>    +                "rev": "akanavin/bitbake-setup-testing"
> ...
> 
> If the configuration has not changed, but layer revisions referred to it have (for example
> if the configuration specifies a tip of a branch), you will see that too:
> 
> ===
> ...
> Layer repository git://git.yoctoproject.org/poky-contrib checked out into /home/alex/builds/poky-alex/layers/poky updated revision akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to aeb73e29379fe6007a8adc8d94c1ac18a93e68de
> ===
> 
> 4. If the configuration has changed, you can bring it in sync with:
> 
> $ bin/bitbake-setup update
> 
> Note that it will also rename/preserve the existing build/conf directory, and print changes
> in bitbake configuration (diff of content of build/conf/) if that has changed. I can't
> at the moment think of anything more clever that is also not much more brittle or complex
> to implement, but open to suggestions.
> 
> Terminology
> ===========
> 
> - 'top directory' means the place under which bitbake-setup reads and
> writes everything. bitbake-setup makes a promise to not touch anything outside of
> that, unless otherwise directed to by entries in settings (currently
> there is one such setting for fetcher downloads for layers and config
> registries). Top directory can be selected by an environment variable, a command line option,
> or otherwise assumed to be ~/bitbake-builds/. If BBPATH is in environment
> (e.g. we are in a bitbake environment), then the top directory is
> deduced from that and doesn't need to be specified by hand.
> 
> - 'settings' means bitbake-setup operational parameters that are
> global to all builds under a top directory. E.g. the location of
> configuration registry, or where the bitbake fetcher should place the
> downloads (DL_DIR setting). Settings are stored in a .conf file in ini
> format just under the top directory.
> 
> - 'build' means a tree structure set up by 'bitbake-setup init',
> consisting of, at least, a layers checkout, and a bitbake
> build. It maps 1:1 to the json data it was constructed from, which is
> called 'build configuration'. Build configurations are constructed from
> generic configurations that may involve making one or more choices
> about available options in them. Generic configurations are files, URLs
> or are obtained from git repositories called 'config
> registries', in which case they can be listed with 'bitbake-setup
> list'. There can be multiple 'builds' under a top directory. Here are
> two example generic configurations that showcase this:
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-options.conf.json
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-nested-configs.conf.json
> 
> - 'bitbake-setup status' will tell if a build is in sync with
> the generic configuration it was made from. 'bitbake-setup update' will bring a build
> in sync with a configuration if needed.
> 
> - 'bitbake build' means a particular sub-tree inside a build that
> bitbake itself operates on, e.g. what is set in BBPATH/BUILDDIR
> by oe-init-build-env. conf/* in that tree is 'bitbake configuration'.
> Bitbake configurations are constructed from templates and fragments,
> with existing mechanisms provided by oe-core. The configuration file
> format is specified such that other mechanisms to set up a
> bitbake build can be added; there was a mention of ability to specify
> local.conf content and a set of layers directly in a configuration. I
> think that scales poorly compared to templates and fragments, but I
> made sure alternative ways to configure a bitbake build are possible
> to add in the future :)
> 
> - 'source override' is a json file that can be used to modify revisions
> and origins of layers that need to be checkout into a build (e.g.
> when master branches need to be changed to master-next for purposes
> of testing). Such a file is specified with a command-line option to 'init'
> and an example can be seen here:
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-next.override.json
> 
> This commit includes fixes by
> Ryan Eatmon <reatmon@ti.com> https://github.com/kanavin/bitbake/pull/1
> Gyorgy Sarvari <skandigraun@gmail.com> https://github.com/kanavin/bitbake/pull/2
> Johannes Schneider <johannes.schneider@leica-geosystems.com> https://github.com/kanavin/bitbake/pull/3
> ---
>   bin/bitbake-setup | 791 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 791 insertions(+)
>   create mode 100755 bin/bitbake-setup
> 
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> new file mode 100755
> index 000000000..ef7ce35b4
> --- /dev/null
> +++ b/bin/bitbake-setup
> @@ -0,0 +1,791 @@
> +#!/usr/bin/env python3
> +
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +import logging
> +import os
> +import sys
> +import argparse
> +import warnings
> +import json
> +import shutil
> +import time
> +import stat
> +import tempfile
> +import configparser
> +import datetime
> +
> +default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
> +
> +bindir = os.path.abspath(os.path.dirname(__file__))
> +sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
> +
> +import bb.msg
> +import bb.process
> +
> +logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
> +
> +def cache_dir(top_dir):
> +    return os.path.join(top_dir, '.bitbake-setup-cache')
> +
> +def init_bb_cache(settings, args):
> +    dldir = settings["default"]["dl-dir"]
> +    bb_cachedir = os.path.join(cache_dir(args.top_dir), 'bitbake-cache')
> +
> +    d = bb.data.init()
> +    d.setVar("DL_DIR", dldir)
> +    d.setVar("BB_CACHEDIR", bb_cachedir)
> +    d.setVar("__BBSRCREV_SEEN", "1")
> +    if args.no_network:
> +        d.setVar("BB_SRCREV_POLICY", "cache")
> +    bb.fetch.fetcher_init(d)
> +    return d
> +
> +def save_bb_cache():
> +    bb.fetch2.fetcher_parse_save()
> +    bb.fetch2.fetcher_parse_done()
> +
> +def get_config_name(config):
> +    return os.path.basename(config).split('.')[0]
> +
> +def write_config(config, config_dir):
> +    with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
> +        json.dump(config, s, sort_keys=True, indent=4)
> +
> +def commit_config(config_dir):
> +    bb.process.run("git -C {} add .".format(config_dir))
> +    bb.process.run("git -C {} commit --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
> +
> +def _write_layer_list(dest, repodirs):
> +    layers = []
> +    for r in repodirs:
> +        for root, dirs, files in os.walk(os.path.join(dest,r)):
> +            if os.path.basename(root) == 'conf' and 'layer.conf' in files:
> +                layers.append(os.path.relpath(os.path.dirname(root), dest))
> +    layers_f = os.path.join(dest, ".oe-layers.json")
> +    with open(layers_f, 'w') as f:
> +        json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
> +
> +def checkout_layers(layers, layerdir, d):
> +    repodirs = []
> +    oesetupbuild = None
> +    print("Fetching layer/tool repositories into {}".format(layerdir))
> +    for r_name in layers:
> +        r_data = layers[r_name]
> +        repodir = r_data["path"]
> +        repodirs.append(repodir)
> +
> +        r_remote = r_data['git-remote']
> +        rev = r_remote['rev']
> +        remotes = r_remote['remotes']
> +
> +        for remote in remotes:
> +            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
> +            fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
> +            print("    {}".format(r_name))
> +            fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
> +            do_fetch(fetcher, layerdir)
> +
> +        if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
> +            oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
> +            oeinitbuildenv = os.path.join(layerdir, repodir, 'oe-init-build-env')
> +
> +    print("        ")
> +    _write_layer_list(layerdir, repodirs)
> +
> +    if oesetupbuild:
> +        links = {'setup-build': oesetupbuild, 'oe-scripts': os.path.dirname(oesetupbuild), 'init-build-env': oeinitbuildenv}
> +        for l,t in links.items():
> +            symlink = os.path.join(layerdir, l)
> +            if os.path.lexists(symlink):
> +                os.remove(symlink)
> +            os.symlink(os.path.relpath(t,layerdir),symlink)
> +
> +def setup_bitbake_build(bitbake_config, layerdir, builddir):
> +    def _setup_build_conf(layers, build_conf_dir):
> +        os.makedirs(build_conf_dir)
> +        layers_s = "\n".join(["  {} \\".format(os.path.join(layerdir,l)) for l in layers])
> +        bblayers_conf = """BBLAYERS ?= " \
> +{}
> +  "
> +""".format(layers_s)
> +        with open(os.path.join(build_conf_dir, "bblayers.conf"), 'w') as f:
> +            f.write(bblayers_conf)
> +
> +        local_conf = """#
> +# This file is intended for local configuration tweaks.
> +#
> +# If you would like to publish and share changes made to this file,
> +# it is recommended to put them into a distro config, or to create
> +# layer fragments from changes made here.
> +#
> +"""
> +        with open(os.path.join(build_conf_dir, "local.conf"), 'w') as f:
> +            f.write(local_conf)
> +
> +        with open(os.path.join(build_conf_dir, "templateconf.cfg"), 'w') as f:
> +            f.write("")
> +
> +        with open(os.path.join(build_conf_dir, "conf-summary.txt"), 'w') as f:
> +            f.write(bitbake_config["description"] + "\n")
> +
> +        with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') as f:
> +            f.write("")
> +
> +    def _make_init_build_env(builddir, initbuildenv):
> +        cmd = ". {} {}".format(initbuildenv, builddir)
> +        initbuild_in_builddir = os.path.join(builddir, 'init-build-env')
> +        with open(initbuild_in_builddir, 'w') as f:
> +            f.write(cmd)
> +
> +    bitbake_builddir = os.path.join(builddir, "build")
> +    print("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
> +
> +    template = bitbake_config.get("oe-template")
> +    layers = bitbake_config.get("bb-layers")
> +    if not template and not layers:
> +        print("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template' or a list of layers via 'bb-layers'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
> +        return
> +    oesetupbuild = os.path.join(layerdir, 'setup-build')
> +    if template and not os.path.exists(oesetupbuild):
> +        raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
> +
> +    bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
> +    backup_bitbake_confdir = bitbake_confdir + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> +    if os.path.exists(bitbake_confdir):
> +        os.rename(bitbake_confdir, backup_bitbake_confdir)
> +
> +    if layers:
> +        _setup_build_conf(layers, bitbake_confdir)
> +
> +    if template:
> +        bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
> +    else:
> +        initbuildenv = os.path.join(layerdir, 'init-build-env')
> +        if not os.path.exists(initbuildenv):
> +            print("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
> +            return
> +        _make_init_build_env(bitbake_builddir, os.path.realpath(initbuildenv))
> +
> +    siteconf_symlink = os.path.join(bitbake_confdir, "site.conf")
> +    siteconf = os.path.normpath(os.path.join(builddir, '..', "site.conf"))
> +    if os.path.lexists(siteconf_symlink):
> +        os.remove(symlink)
> +    os.symlink(os.path.relpath(siteconf, bitbake_confdir) ,siteconf_symlink)
> +
> +
> +    init_script = os.path.join(bitbake_builddir, "init-build-env")
> +    shell = os.path.basename(os.environ.get("SHELL","bash"))
> +    fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
> +    if fragments:
> +        bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
> +
> +    if os.path.exists(backup_bitbake_confdir):
> +        bitbake_config_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
> +        if bitbake_config_diff:
> +            print("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
> +            print("The bitbake configuration has changed:")
> +            print(bitbake_config_diff)
> +        else:
> +            shutil.rmtree(backup_bitbake_confdir)
> +
> +    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
> +
> +    readme = """{}\n\nAdditional information is in {} and {}\n
> +Source the environment using '. {}' to run builds from the command line.
> +The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
> +""".format(
> +        bitbake_config["description"],
> +        os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
> +        os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
> +        init_script,
> +        bitbake_builddir
> +        )
> +    readme_file = os.path.join(bitbake_builddir, "README")
> +    with open(readme_file, 'w') as f:
> +        f.write(readme)
> +    print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
> +    print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
> +    print("To run builds, source the environment using\n    source {}".format(init_script))
> +
> +def get_registry_config(registry_path, id):
> +    for root, dirs, files in os.walk(registry_path):
> +        for f in files:
> +            if f.endswith('.conf.json') and id == get_config_name(f):
> +                return os.path.join(root, f)
> +    raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
> +
> +def update_build(config, confdir, builddir, layerdir, d):
> +    layer_config = config["data"]["sources"]
> +    layer_overrides = config["source-overrides"]["sources"]
> +    for k,v in layer_overrides.items():
> +        if k in layer_config:
> +            layer_config[k]["git-remote"] = v["git-remote"]
> +    checkout_layers(layer_config, layerdir, d)
> +    bitbake_config = config["bitbake-config"]
> +    setup_bitbake_build(bitbake_config, layerdir, builddir)
> +
> +def flatten_bitbake_configs(configs):
> +    def merge_configs(c1,c2):
> +        c_merged = {}
> +        for k,v in c2.items():
> +            if k not in c1.keys():
> +                c_merged[k] = v
> +        for k,v in c1.items():
> +            if k not in c2.keys():
> +                c_merged[k] = v
> +            else:
> +               c_merged[k] = c1[k] + c2[k]
> +        del c_merged['configurations']
> +        return c_merged
> +
> +    flattened_configs = []
> +    for c in configs:
> +        if 'configurations' not in c:
> +            flattened_configs.append(c)
> +        else:
> +            for sub_c in flatten_bitbake_configs(c['configurations']):
> +                flattened_configs.append(merge_configs(c, sub_c))
> +    return flattened_configs
> +
> +def choose_bitbake_config(configs, parameters, non_interactive):
> +    flattened_configs = flatten_bitbake_configs(configs)
> +    configs_dict = {i["name"]:i for i in flattened_configs}
> +
> +    if parameters:
> +        config_id = parameters[0]
> +        if config_id not in configs_dict:
> +            raise Exception("Bitbake configuration {} not found; replace with one of {}".format(config_id, configs_dict))
> +        return configs_dict[config_id]
> +
> +    enumerated_configs = list(enumerate(flattened_configs))
> +    if len(enumerated_configs) == 1:
> +        only_config = flattened_configs[0]
> +        print("\nSelecting the only available bitbake configuration {}".format(only_config["name"]))
> +        return only_config
> +
> +    if non_interactive:
> +        raise Exception("Unable to choose from bitbake configurations in non-interactive mode: {}".format(configs_dict))
> +
> +    print("\nAvailable bitbake configurations:")
> +    for n, config_data in enumerated_configs:
> +        print("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
> +    print("\nPlease select one of the above bitbake configurations by its number:")
> +    config_n = int(input())
> +    return flattened_configs[config_n]
> +
> +def choose_config(configs, non_interactive):
> +    not_expired_configs = [k for k in configs.keys() if not has_expired(configs[k].get("expires", None))]
> +    config_list = list(enumerate(not_expired_configs))
> +    if len(config_list) == 1:
> +        only_config = config_list[0][1]
> +        print("\nSelecting the only available configuration {}\n".format(only_config))
> +        return only_config
> +
> +    if non_interactive:
> +        raise Exception("Unable to choose from configurations in non-interactive mode: {}".format(not_expired_configs))
> +
> +    print("\nAvailable configurations:")
> +    for n, config_name in config_list:
> +        config_data = configs[config_name]
> +        expiry_date = config_data.get("expires", None)
> +        config_desc = config_data["description"]
> +        if expiry_date:
> +           print("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
> +        else:
> +           print("{}. {}\t{}".format(n, config_name, config_desc))
> +    print("\nPlease select one of the above configurations by its number:")
> +    config_n = int(input())
> +    return config_list[config_n][1]
> +
> +def choose_fragments(possibilities, parameters, non_interactive):
> +    choices = {}
> +    for k,v in possibilities.items():
> +        choice = [o for o in v["options"] if o in parameters]
> +        if len(choice) > 1:
> +            raise Exception("Options specified on command line do not allow a single selection from possibilities {}, please remove one or more from {}".format(v["options"], parameters))
> +        if len(choice) == 1:
> +            choices[k] = choice[0]
> +            continue
> +
> +        if non_interactive:
> +            raise Exception("Unable to choose from options in non-interactive mode: {}".format(v["options"]))
> +
> +        print("\n" + v["description"] + ":")
> +        options_enumerated = list(enumerate(v["options"]))
> +        for n,o in options_enumerated:
> +            print("{}. {}".format(n, o))
> +        print("\nPlease select one of the above options by its number:")
> +        option_n = int(input())
> +        choices[k] = options_enumerated[option_n][1]
> +    return choices
> +
> +def obtain_config(settings, args, source_overrides, d):
> +    if args.config:
> +        config_id = args.config[0]
> +        config_parameters = args.config[1:]
> +        if os.path.exists(config_id):
> +            print("Reading configuration from local file\n    {}".format(config_id))
> +            upstream_config = {'type':'local',
> +                               'path':os.path.abspath(config_id),
> +                               'name':get_config_name(config_id),
> +                               'data':json.load(open(config_id))
> +                               }
> +        elif config_id.startswith("http://") or config_id.startswith("https://"):
> +            print("Reading configuration from network URI\n    {}".format(config_id))
> +            import urllib.request
> +            with urllib.request.urlopen(config_id) as f:
> +              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
> +        else:
> +            print("Looking up config {} in configuration registry".format(config_id))
> +            registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
> +            registry_configs = list_registry(registry_path, with_expired=True)
> +            if config_id not in registry_configs:
> +                raise Exception("Config {} not found in configuration registry, re-run 'init' without parameters to choose from available configurations.".format(config_id))
> +            upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
> +        expiry_date = upstream_config['data'].get("expires", None)
> +        if has_expired(expiry_date):
> +            print("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
> +    else:
> +        registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
> +        registry_configs = list_registry(registry_path, with_expired=True)
> +        config_id = choose_config(registry_configs, args.non_interactive)
> +        config_parameters = []
> +        upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
> +
> +    upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
> +    upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive)
> +    upstream_config['non-interactive-cmdline-options'] = [config_id, upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
> +    upstream_config['source-overrides'] = source_overrides
> +    return upstream_config
> +
> +def init_config(settings, args, d):
> +    stdout = sys.stdout
> +    def handle_task_progress(event, d):
> +        rate = event.rate if event.rate else ''
> +        progress = event.progress if event.progress > 0 else 0
> +        print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
> +
> +    source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
> +    upstream_config = obtain_config(settings, args, source_overrides, d)
> +    print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
> +
> +    builddir = os.path.join(os.path.abspath(args.top_dir), "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
> +    if os.path.exists(builddir):
> +        print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
> +        return
> +
> +    print("Initializing a build in\n    {}".format(builddir))
> +    if not args.non_interactive:
> +        y_or_n = input('Continue? y/n: ')
> +        if y_or_n != 'y':
> +            exit()
> +        print()
> +
> +
> +    os.makedirs(builddir)
> +
> +    confdir = os.path.join(builddir, "config")
> +    layerdir = os.path.join(builddir, "layers")
> +
> +    os.makedirs(confdir)
> +    os.makedirs(layerdir)
> +
> +    bb.process.run("git -C {} init -b main".format(confdir))
> +    # Make sure commiting doesn't fail if no default git user is configured on the machine
> +    bb.process.run("git -C {} config user.name bitbake-setup".format(confdir))
> +    bb.process.run("git -C {} config user.email bitbake-setup@not.set".format(confdir))
> +    bb.process.run("git -C {} commit --no-verify --allow-empty -m 'Initial commit'".format(confdir))
> +
> +    bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
> +
> +    write_config(upstream_config, confdir)
> +    commit_config(confdir)
> +    update_build(upstream_config, confdir, builddir, layerdir, d)
> +
> +    bb.event.remove("bb.build.TaskProgress", None)
> +
> +def get_diff(file1, file2):
> +    try:
> +        bb.process.run('diff -uNr {} {}'.format(file1, file2))
> +    except bb.process.ExecutionError as e:
> +        if e.exitcode == 1:
> +            return e.stdout
> +        else:
> +            raise e
> +    return None
> +
> +def are_layers_changed(layers, layerdir, d):
> +    changed = False
> +    for r_name in layers:
> +        r_data = layers[r_name]
> +        repodir = r_data["path"]
> +
> +        r_remote = r_data['git-remote']
> +        rev = r_remote['rev']
> +        remotes = r_remote['remotes']
> +
> +        for remote in remotes:
> +            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
> +            fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
> +            fetcher = bb.fetch.FetchData("{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir), d)
> +            upstream_revision = fetcher.method.latest_revision(fetcher, d, 'default')
> +            rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
> +            local_revision = rev_parse_result[0].strip()
> +            if upstream_revision != local_revision:
> +                changed = True
> +                print('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
> +
> +    return changed
> +
> +def build_status(settings, args, d, update=False):
> +    builddir = args.build_dir
> +
> +    confdir = os.path.join(builddir, "config")
> +    layerdir = os.path.join(builddir, "layers")
> +
> +    current_upstream_config = json.load(open(os.path.join(confdir, "config-upstream.json")))
> +
> +    args.config = current_upstream_config['non-interactive-cmdline-options']
> +    args.non_interactive = True
> +    source_overrides = current_upstream_config["source-overrides"]
> +    new_upstream_config = obtain_config(settings, args, source_overrides, d)
> +
> +    write_config(new_upstream_config, confdir)
> +    config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
> +
> +    if config_diff:
> +        print('\nConfiguration in {} has changed:\n{}'.format(builddir, config_diff))
> +        if update:
> +            commit_config(confdir)
> +            update_build(new_upstream_config, confdir, builddir, layerdir, d)
> +        else:
> +            bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
> +        return
> +
> +    if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
> +        if update:
> +            update_build(current_upstream_config, confdir, builddir, layerdir, d)
> +        return
> +
> +    print("\nConfiguration in {} has not changed.".format(builddir))
> +
> +def build_update(settings, args, d):
> +    build_status(settings, args, d, update=True)
> +
> +def do_fetch(fetcher, dir):
> +    # git fetcher simply dumps git output to stdout; in bitbake context that is redirected to temp/log.do_fetch
> +    # and we need to set up smth similar here
> +    fetchlogdir = os.path.join(dir, 'logs')
> +    os.makedirs(fetchlogdir, exist_ok=True)
> +    fetchlog = os.path.join(fetchlogdir, 'fetch_log.{}'.format(datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
> +    with open(fetchlog, 'a') as f:
> +        oldstdout = sys.stdout
> +        sys.stdout = f
> +        fetcher.download()
> +        fetcher.unpack(dir)
> +        sys.stdout = oldstdout
> +
> +def update_registry(registry, cachedir, d):
> +    registrydir = 'configurations'
> +    full_registrydir = os.path.join(cachedir, registrydir)
> +    print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
> +    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
> +    do_fetch(fetcher, cachedir)
> +    return full_registrydir
> +
> +def has_expired(expiry_date):
> +    if expiry_date:
> +        return datetime.datetime.now() > datetime.datetime.fromisoformat(expiry_date)
> +    return False
> +
> +def list_registry(registry_path, with_expired):
> +    json_data = {}
> +
> +    for root, dirs, files in os.walk(registry_path):
> +        for f in files:
> +            if f.endswith('.conf.json'):
> +                config_name = get_config_name(f)
> +                config_data = json.load(open(os.path.join(root, f)))
> +                config_desc = config_data["description"]
> +                expiry_date = config_data.get("expires", None)
> +                if expiry_date:
> +                    if with_expired or not has_expired(expiry_date):
> +                        json_data[config_name] = {"description": config_desc, "expires": expiry_date}
> +                else:
> +                    json_data[config_name] = {"description": config_desc}
> +    return json_data
> +
> +def list_configs(settings, args, d):
> +    registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
> +    json_data = list_registry(registry_path, args.with_expired)
> +    print("\nAvailable configurations:")
> +    for config_name, config_data in json_data.items():
> +        expiry_date = config_data.get("expires", None)
> +        config_desc = config_data["description"]
> +        if expiry_date:
> +           if args.with_expired or not has_expired(expiry_date):
> +               print("{}\t{} (supported until {})".format(config_name, config_desc, expiry_date))
> +        else:
> +           print("{}\t{}".format(config_name, config_desc))
> +    print("\nRun 'init' with one of the above configuration identifiers to set up a build.")
> +
> +    if args.write_json:
> +        with open(args.write_json, 'w') as f:
> +            json.dump(json_data, f, sort_keys=True, indent=4)
> +        print("Available configurations written into {}".format(args.write_json))
> +
> +def default_settings_path(top_dir):
> +    return os.path.join(top_dir, 'bitbake-setup.conf')
> +
> +def write_settings(top_dir, force_replace, non_interactive=True):
> +    settings_path = default_settings_path(top_dir)
> +    if not os.path.exists(settings_path) or force_replace:
> +
> +        settings = configparser.ConfigParser()
> +        settings['default'] = {
> +                             'registry':default_registry,
> +                             'dl-dir':os.path.join(top_dir, '.bitbake-setup-downloads'),
> +                            }
> +        os.makedirs(os.path.dirname(settings_path), exist_ok=True)
> +
> +        siteconfpath = os.path.join(top_dir, 'site.conf')
> +        print('Configuration registry set to\n    {}\n'.format(settings['default']['registry']))
> +        print('Bitbake-setup download cache (DL_DIR) set to\n    {}\n'.format(settings['default']['dl-dir']))
> +        print('A new settings file will be created in\n    {}\n'.format(settings_path))
> +        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
> +        if not non_interactive:
> +            y_or_n = input('Bitbake-setup will be configured with the above settings in {}, y/n: '.format(top_dir))
> +            if y_or_n != 'y':
> +                print("\nYou can run 'bitbake-setup install-settings' to edit them before setting up builds")
> +                exit()
> +            print()
> +
> +        if os.path.exists(settings_path):
> +            backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> +            os.rename(settings_path, backup_conf)
> +            print("Previous settings are in {}".format(backup_conf))
> +        with open(settings_path, 'w') as settingsfile:
> +            settings.write(settingsfile)
> +
> +        if os.path.exists(siteconfpath):
> +            backup_siteconf = siteconfpath + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> +            os.rename(siteconfpath, backup_siteconf)
> +            print("Previous settings are in {}".format(backup_siteconf))
> +        with open(siteconfpath, 'w') as siteconffile:
> +            siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
> +
> +def load_settings(top_dir, non_interactive):
> +    # This creates a new settings file if it does not yet exist
> +    write_settings(top_dir, force_replace=False, non_interactive=non_interactive)
> +
> +    settings_path = default_settings_path(top_dir)
> +    settings = configparser.ConfigParser()
> +    print('Loading settings from\n    {}\n'.format(settings_path))
> +    settings.read([settings_path])
> +    return settings
> +
> +def global_settings_path(args):
> +    return args.global_settings if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'config')
> +
> +def write_global_settings(settings_path, force_replace, non_interactive=True):
> +    if not os.path.exists(settings_path) or force_replace:
> +
> +        settings = configparser.ConfigParser()
> +        settings['default'] = {
> +                             'top-dir-prefix':os.path.expanduser('~'),
> +                             'top-dir-name':'bitbake-builds'
> +                            }
> +        os.makedirs(os.path.dirname(settings_path), exist_ok=True)
> +        print('Configuring global settings in\n    {}\n'.format(settings_path))
> +        print('Top directory prefix (where all top level directories are created) set to\n    {}\n'.format(settings['default']['top-dir-prefix']))
> +        print('Top directory name (this is added to the top directory prefix to form a top directory where builds are set up) set to\n    {}\n'.format(settings['default']['top-dir-name']))
> +        if not non_interactive:
> +            y_or_n = input('Write out the global settings as specified above (y/n)? ')
> +            if y_or_n != 'y':
> +                print("\nYou can run 'bitbake-setup install-global-settings' to edit them before setting up builds")
> +                exit()
> +            print()
> +
> +        if os.path.exists(settings_path):
> +            backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> +            os.rename(settings_path, backup_conf)
> +            print("Previous global settings are in {}".format(backup_conf))
> +        with open(settings_path, 'w') as settingsfile:
> +            settings.write(settingsfile)
> +
> +def load_global_settings(settings_path, non_interactive):
> +    # This creates a new settings file if it does not yet exist
> +    write_global_settings(settings_path, force_replace=False, non_interactive=non_interactive)
> +
> +    settings = configparser.ConfigParser()
> +    print('Loading global settings from\n    {}\n'.format(settings_path))
> +    settings.read([settings_path])
> +    return settings
> +
> +def change_settings(top_dir, new_settings):
> +    settings = load_settings(top_dir, non_interactive=True)
> +    for section, section_settings in new_settings.items():
> +        for setting, value in section_settings.items():
> +            settings[section][setting] = value
> +            print("Setting '{}' in section '{}' is changed to '{}'".format(setting, section, value))
> +
> +    settings_path = default_settings_path(top_dir)
> +    with open(settings_path, 'w') as settingsfile:
> +        settings.write(settingsfile)
> +    print("New settings written to {}".format(settings_path))
> +    return settings
> +
> +def change_global_settings(settings_path, new_settings):
> +    settings = load_global_settings(settings_path, non_interactive=True)
> +    for section, section_settings in new_settings.items():
> +        for setting, value in section_settings.items():
> +            settings[section][setting] = value
> +            print("Setting '{}' in section '{}' is changed to '{}'".format(setting, section, value))
> +
> +    with open(settings_path, 'w') as settingsfile:
> +        settings.write(settingsfile)
> +    print("New global settings written to {}".format(settings_path))
> +    return settings
> +
> +def get_build_dir_via_bbpath():
> +    bbpath = os.environ.get('BBPATH')
> +    if bbpath:
> +        bitbake_dir = os.path.normpath(bbpath.split(':')[0])
> +        if os.path.exists(os.path.join(bitbake_dir,'init-build-env')):
> +            build_dir = os.path.dirname(bitbake_dir)
> +            return build_dir
> +    return None
> +
> +def get_top_dir(args, global_settings):
> +    build_dir_via_bbpath = get_build_dir_via_bbpath()
> +    if build_dir_via_bbpath:
> +        top_dir = os.path.dirname(build_dir_via_bbpath)
> +        if os.path.exists(default_settings_path(top_dir)):
> +            return top_dir
> +
> +    if hasattr(args, 'build_dir'):
> +        # commands without --top-dir-prefix/name arguments (status, update) still need to know where
> +        # the top dir is, but it should be auto-deduced as parent of args.build_dir
> +        top_dir = os.path.dirname(os.path.normpath(args.build_dir))
> +        return top_dir
> +
> +    top_dir_prefix = args.top_dir_prefix if args.top_dir_prefix else global_settings['default']['top-dir-prefix']
> +    top_dir_name = args.top_dir_name if args.top_dir_name else global_settings['default']['top-dir-name']
> +    return os.path.join(top_dir_prefix, top_dir_name)
> +
> +def main():
> +    def add_top_dir_arg(parser):
> +        parser.add_argument('--top-dir-prefix', help='Top level directory prefix. This is where all top level directories are created.')
> +        parser.add_argument('--top-dir-name', help='Top level directory name. Together with the top directory prefix this forms a top directory where builds are set up and downloaded configurations and layers are cached for reproducibility and offline builds.')
> +
> +    def add_build_dir_arg(parser):
> +        build_dir = get_build_dir_via_bbpath()
> +        if build_dir:
> +            parser.add_argument('--build-dir', default=build_dir, help="Path to the build, default is %(default)s via BBPATH")
> +        else:
> +            parser.add_argument('--build-dir', required=True, help="Path to the build")
> +
> +    parser = argparse.ArgumentParser(
> +        description="BitBake setup utility. Run with 'init' argument to get started.",
> +        epilog="Use %(prog)s <subcommand> --help to get help on a specific command"
> +        )
> +    parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
> +    parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
> +    parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
> +    parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
> +    parser.add_argument('--global-settings', action='store', help='Path to the global settings file where defaults for top directory prefix and name can be specified')
> +
> +    subparsers = parser.add_subparsers()
> +
> +    parser_list = subparsers.add_parser('list', help='List available configurations')
> +    add_top_dir_arg(parser_list)
> +    parser_list.add_argument('--with-expired', action='store_true', help='List also configurations that are no longer supported due to reaching their end-of-life dates.')
> +    parser_list.add_argument('--write-json', action='store', help='Write available configurations into a json file so they can be programmatically processed.')
> +    parser_list.set_defaults(func=list_configs)
> +
> +    parser_init = subparsers.add_parser('init', help='Select a configuration and initialize a build from it')
> +    add_top_dir_arg(parser_init)
> +    parser_init.add_argument('config', nargs='*', help="path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available choices if command line doesn't completely specify them.")
> +    parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
> +    parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
> +    parser_init.set_defaults(func=init_config)
> +
> +    parser_status = subparsers.add_parser('status', help='Check if the build needs to be synchronized with configuration')
> +    add_build_dir_arg(parser_status)
> +    parser_status.set_defaults(func=build_status)
> +
> +    parser_update = subparsers.add_parser('update', help='Update a build to be in sync with configuration')
> +    add_build_dir_arg(parser_update)
> +    parser_update.set_defaults(func=build_update)
> +
> +    parser_install_settings = subparsers.add_parser('install-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other settings specific to a top directory)')
> +    add_top_dir_arg(parser_install_settings)
> +    parser_install_settings.set_defaults(func=write_settings)
> +
> +    parser_install_global_settings = subparsers.add_parser('install-global-settings', help='Write a global settings file with default values (contains the default prefix and name of the top directory)')
> +    parser_install_global_settings.set_defaults(func=write_global_settings)
> +
> +    parser_change_setting = subparsers.add_parser('change-setting', help='Change a setting in the settings file')
> +    add_top_dir_arg(parser_change_setting)
> +    parser_change_setting.add_argument('section', help="Section in a settings file, typically 'default'")
> +    parser_change_setting.add_argument('key', help="Name of the setting")
> +    parser_change_setting.add_argument('value', help="Value of the setting")
> +    parser_change_setting.set_defaults(func=change_settings)
> +
> +    parser_change_global_setting = subparsers.add_parser('change-global-setting', help='Change a setting in the global settings file')
> +    parser_change_global_setting.add_argument('section', help="Section in a global settings file, typically 'default'")
> +    parser_change_global_setting.add_argument('key', help="Name of the setting")
> +    parser_change_global_setting.add_argument('value', help="Value of the setting")
> +    parser_change_global_setting.set_defaults(func=change_global_settings)
> +
> +    args = parser.parse_args()
> +
> +    logging.basicConfig(stream=sys.stdout)
> +    if args.debug:
> +        logger.setLevel(logging.DEBUG)
> +    elif args.quiet:
> +        logger.setLevel(logging.ERROR)
> +
> +    # Need to re-run logger_create with color argument
> +    # (will be the same logger since it has the same name)
> +    bb.msg.logger_create('bitbake-setup', output=sys.stdout,
> +                         color=args.color,
> +                         level=logger.getEffectiveLevel())
> +
> +    if 'func' in args:
> +        if args.func == write_global_settings:
> +            write_global_settings(global_settings_path(args), force_replace=True)
> +            return
> +        elif args.func == change_global_settings:
> +            change_global_settings(global_settings_path(args), {args.section:{args.key:args.value}})
> +            return
> +
> +        if hasattr(args, 'build_dir'):
> +            if not os.path.exists(os.path.join(args.build_dir,'build', 'init-build-env')):
> +                print("Not a valid build directory: build/init-build-env does not exist in {}".format(args.build_dir))
> +                return
> +
> +        if not hasattr(args, 'non_interactive'):
> +            args.non_interactive = True
> +
> +        global_settings = load_global_settings(global_settings_path(args), args.non_interactive)
> +        args.top_dir = get_top_dir(args, global_settings)
> +
> +        print('Bitbake-setup is using {} as top directory (can be changed with --top-dir-prefix/name arguments or by setting them in {}).\n'.format(args.top_dir, global_settings_path(args)))
> +        if args.func == write_settings:
> +            write_settings(args.top_dir, force_replace=True)
> +        elif args.func == change_settings:
> +            change_settings(args.top_dir, {args.section:{args.key:args.value}})
> +        else:
> +            settings = load_settings(args.top_dir, args.non_interactive)
> +            d = init_bb_cache(settings, args)
> +            args.func(settings, args, d)
> +            save_bb_cache()
> +    else:
> +        from argparse import Namespace
> +        parser.print_help()
> +
> +main()
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17988): https://lists.openembedded.org/g/bitbake-devel/message/17988
> Mute This Topic: https://lists.openembedded.org/mt/115129357/6551054
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [reatmon@ti.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

