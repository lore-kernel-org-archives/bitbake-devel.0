Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB09C25B76
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 05:45:44 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.31976.1717220738978699830
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 May 2024 22:45:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Ya9vg2rX;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C017E240004;
	Sat,  1 Jun 2024 05:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717220737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjpvrubRB39jlVuC6NtaBmBzw1Yf0LDL1zGJQ5+XsO4=;
	b=Ya9vg2rXkRQCC178X5or+TkFT8kg1xu10fNxK4j6S4z8bS3MwF5bGCgYBf1eFwmLorApRr
	/1DepYDmHgs4SW/iXLmzXxMd//hkOaduNQN2eOrn8SJmgkwB81oMsElnwpJp8gIedwaK/7
	vODdrMWR+5c5IP+9tNl3D70xFfI3W+BOsoL5UX+Yph5Ua44+a9xpZy1c/2uwxU43VzN85N
	1IzQIrbKv+O0c3wLOfY8htfhd1u+/meZnFgtRxUgK5SmgxO6I9oFUypiDbz3rzP9G5vEZW
	Kp/Ezp1qlerZ5ScU1eV0QOWtisdJ69m42pcxI6L59r7KNWpoKzuPl3sZVpZvqw==
Date: Sat, 1 Jun 2024 07:45:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Hieu Van Nguyen <hieu2.nguyen@lge.com>
Cc: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org, pkj@axis.com,
	nvhieudt11@gmail.com
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-layers: Support add-layer to
 prepend
Message-ID: <202406010545352491ca1a@mail.local>
References: <16194>
 <20240509110400.1093934-1-hieu2.nguyen@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509110400.1093934-1-hieu2.nguyen@lge.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:45:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16301

This fails on the autbuilders:

2024-06-01 04:08:35,036 - oe-selftest - INFO - ======================================================================
2024-06-01 04:08:35,195 - oe-selftest - INFO - FAIL: sstatetests.SStateBundles.test_minimal_bundle (subunit.RemotedTestCase)
2024-06-01 04:08:35,195 - oe-selftest - INFO - ----------------------------------------------------------------------
2024-06-01 04:08:35,195 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/selftest/cases/sstatetests.py", line 1016, in test_minimal_bundle
    runCmd("oe-replicate-build --targets {}".format(targets))
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/utils/commands.py", line 212, in runCmd
    raise AssertionError("Command '%s' returned non-zero exit status %d:\n%s" % (command, result.status, exc_output))
AssertionError: Command 'oe-replicate-build --targets core-image-minimal' returned non-zero exit status 1:
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/bin/bitbake-layers", line 101, in <module>
    ret = main()
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/bin/bitbake-layers", line 94, in main
    return args.func(args)
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/bblayers/create.py", line 76, in do_create_layer
    ActionPlugin.do_add_layer(self, args)
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/bblayers/action.py", line 52, in do_add_layer
    notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None, None, args.prepend)
AttributeError: 'Namespace' object has no attribute 'prepend'
Making a self-extracting bundle archive in build-bundle.sh ...
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/scripts/oe-replicate-build", line 74, in <module>
    _do_bundle(args)
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/scripts/oe-replicate-build", line 29, in _do_bundle
    subprocess.check_output("bitbake-layers create-layer --add-layer {}".format(layerdir), shell=True, cwd=bundledir)
  File "/usr/lib64/python3.9/subprocess.py", line 424, in check_output
    return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
  File "/usr/lib64/python3.9/subprocess.py", line 528, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command 'bitbake-layers create-layer --add-layer meta-build-config' returned non-zero exit status 1.


On 09/05/2024 20:04:00+0900, Hieu Van Nguyen wrote:
> From: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> 
> As you know, layer order in BBLAYERS can affect in parsing recipes process,
> in some cases, users want to add a layer on the top of BBLAYERS variable
> 
> So, add "--prepend" option for bitbake-layers to support add-layer to prepend
> 
> Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> ---
> v3: fix From:
>  lib/bb/utils.py        | 8 ++++++--
>  lib/bblayers/action.py | 3 ++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index ebee65d3d..f1634da0a 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1414,7 +1414,7 @@ def edit_metadata_file(meta_file, variables, varfunc):
>      return updated
>  
>  
> -def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
> +def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None, prepend=None):
>      """Edit bblayers.conf, adding and/or removing layers
>      Parameters:
>          bblayers_conf: path to bblayers.conf file to edit
> @@ -1424,6 +1424,7 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
>              empty list to remove nothing
>          edit_cb: optional callback function that will be called after
>              processing adds/removes once per existing entry.
> +        prepend: optional support add-layer to prepend
>      Returns a tuple:
>          notadded: list of layers specified to be added but weren't
>              (because they were already in the list)
> @@ -1484,7 +1485,10 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
>              for addlayer in addlayers:
>                  if addlayer not in bblayers:
>                      updated = True
> -                    bblayers.append(addlayer)
> +                    if prepend:
> +                        bblayers.insert(0,addlayer)
> +                    else:
> +                        bblayers.append(addlayer)
>              del addlayers[:]
>  
>          if edit_cb:
> diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
> index a14f19948..8ef89fc09 100644
> --- a/lib/bblayers/action.py
> +++ b/lib/bblayers/action.py
> @@ -49,7 +49,7 @@ class ActionPlugin(LayerPlugin):
>          shutil.copy2(bblayers_conf, backup)
>  
>          try:
> -            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
> +            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None, None, args.prepend)
>              if not (args.force or notadded):
>                  self.tinfoil.modified_files()
>                  try:
> @@ -269,6 +269,7 @@ build results (as the layer priority order has effectively changed).
>      def register_commands(self, sp):
>          parser_add_layer = self.add_command(sp, 'add-layer', self.do_add_layer, parserecipes=False)
>          parser_add_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to add')
> +        parser_add_layer.add_argument('--prepend', action='store_true', help='Prepend layer directory/directories')
>  
>          parser_remove_layer = self.add_command(sp, 'remove-layer', self.do_remove_layer, parserecipes=False)
>          parser_remove_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16196): https://lists.openembedded.org/g/bitbake-devel/message/16196
> Mute This Topic: https://lists.openembedded.org/mt/105998764/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

