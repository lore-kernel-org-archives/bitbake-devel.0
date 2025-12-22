Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA15E6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 10:41:40 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77796.1766400098375927894
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 02:41:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QCUmb0AB;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 28CBE4E41D32
	for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 10:41:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2AAA606C1;
	Mon, 22 Dec 2025 10:41:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6D2410AB00E9;
	Mon, 22 Dec 2025 11:41:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766400093; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YtsnadJXGy3hZLOIguxLd+dMW76zV3NweOPGqGz03Tg=;
	b=QCUmb0ABB0m1L6VLQD+Ph+/sqiF7i63gDAbCLTb1xyjEhmg9cZPL2dpsKZZUwKEwWhkt44
	n5rmgl/fw4V7YqO2km317BN6+k1ks/f8hG6h44+onAx/iaKBSTL4E9v/PiGHDDRoGSRCBJ
	47WJLrgrdznllj41HaK/ig8X1Bwa9aUpc/n17rV1PL5q7jvIvh9xkuz9/eihrHLxxnxxw8
	FMYPPLM5UaulwhkYQdxbJA2HBDl/ZuxevtkcwI3NLefSmMH4Qk/2HkGxwVRNYvN73u82Sq
	KxBPS/HI3gicbbKuzs6OHBfJVQNjwzgrueU0Dm7eq0kkjubgAeLA/ZnUxiovZQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 11:41:32 +0100
Message-Id: <DF4OKNSZFV84.3O7R9PLEQC12Y@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v4 1/4] bitbake-setup: add inline URI
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
In-Reply-To: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 10:41:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18634

On Fri Dec 19, 2025 at 5:12 PM CET, Corentin Guillevic via lists.openembedd=
ed.org wrote:
> Most of the time, when we describe a remote, a bitbake-setup source looks=
 like this:
>
> "bitbake": {
>     "git-remote": {
>         "remotes": {
>             "origin": {
>                 "uri": "https://git.openembedded.org/bitbake"
>             }
>         },
>         ...
>     }
> }
>
> i.e. an URI with the common name 'origin'. Alternatively, we could simpli=
fy this, by
> using a shorter structure with the property 'uri' only:
>
> "bitbake": {
>     "git-remote": {
>         "uri": "https://git.openembedded.org/bitbake",
>         ...
>     }
> }
>
> These properties can be used together.
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---
>
> Changes in v4:
> - Fix a wrong indentation in the file bitbake-user-manual-environment-set=
up.rst
>
>  bin/bitbake-setup | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 73f734e73..809077518 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -89,14 +89,30 @@ def _write_layer_list(dest, repodirs):
>      with open(layers_f, 'w') as f:
>          json.dump({"version":"1.0","layers":layers}, f, sort_keys=3DTrue=
, indent=3D4)
> =20
> +def _get_remotes(r_remote):
> +    remotes =3D []
> +
> +    if not 'remotes' in r_remote and not 'uri' in r_remote:
> +        raise Exception("Expected key(s): 'remotes', 'uri'")
> +
> +    if 'remotes' in r_remote:
> +        for remote in r_remote['remotes']:
> +            remotes.append(r_remote['remotes'][remote]['uri'])
> +
> +    if 'uri' in r_remote:
> +        remotes.append(r_remote['uri'])
> +
> +    return remotes
> +
>  def checkout_layers(layers, layerdir, d):
>      def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
>          rev =3D r_remote['rev']
>          branch =3D r_remote.get('branch', None)
> -        remotes =3D r_remote['remotes']
> +
> +        remotes =3D _get_remotes(r_remote)
> =20
>          for remote in remotes:
> -            prot,host,path,user,pswd,params =3D bb.fetch.decodeurl(remot=
es[remote]["uri"])
> +            prot,host,path,user,pswd,params =3D bb.fetch.decodeurl(remot=
e)
>              fetchuri =3D bb.fetch.encodeurl(('git',host,path,user,pswd,p=
arams))
>              logger.plain("    {}".format(r_name))
>              if branch:
> @@ -600,7 +616,8 @@ def are_layers_changed(layers, layerdir, d):
>          changed =3D False
>          rev =3D r_remote['rev']
>          branch =3D r_remote.get('branch', None)
> -        remotes =3D r_remote['remotes']
> +
> +        remotes =3D _get_remotes(r_remote)
> =20
>          for remote in remotes:
>              type,host,path,user,pswd,params =3D bb.fetch.decodeurl(remot=
es[remote]["uri"])

Hi Corentin,

Thanks for your patch.

It looks like this is breaking a bitbake-selftest:

ERROR: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/tests/setup.py", line 318, in test_setup
    out =3D self.runbbsetup("status")
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/tests/setup.py", line 90, in runbbsetup
    return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.p=
ath.join(self.tempdir, 'global-config'), cmd))
           ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/process.py", line 189, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of '/srv/pokybuild/yocto-worker/oe-sel=
ftest-armhost/build/layers/bitbake/bin/bitbake-setup --global-settings /tmp=
/bitbake-fetch-fb2c75qw/global-config status' failed with exit code 1:
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 1059, in <module>
    main()
    ~~~~^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 1052, in main
    args.func(top_dir, all_settings, args, d)
    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 675, in build_status
    if are_layers_changed(current_upstream_config["data"]["sources"], layer=
dir, d):
       ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 644, in are_layers_changed
    changed =3D changed | _is_git_remote_changed(git_remote, repodir)
                        ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 623, in _is_git_remote_changed
    type,host,path,user,pswd,params =3D bb.fetch.decodeurl(remotes[remote][=
"uri"])
                                                         ~~~~~~~^^^^^^^^
TypeError: list indices must be integers or slices, not str

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3016
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2879
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2774

Can you have a look at this failure?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


