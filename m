Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C9D72350
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 08:34:46 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63800.1769157278805983594
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 00:34:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=nSpoHzbi;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B92274E421F1;
	Fri, 23 Jan 2026 08:34:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E55B6070A;
	Fri, 23 Jan 2026 08:34:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84899119A85ED;
	Fri, 23 Jan 2026 09:34:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769157275; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=weNGAXRRBx6Fk/t99gv7VrgixOJICsEhaP8mOvF905o=;
	b=nSpoHzbipQD+1fPObqlcJ9vb3DPbFVwdvcWnzf7IzpMhf+X3AJBQXRV1hrM5nkaszr8erS
	a5LWD8v4KnSjQCZ506IPDgoW0KWIIkLamn4WfFEwaVKaxkUbRTxcNl/6VvBufh8w/xbzvq
	R121mzgwpXTdB0pTDpvGnHnqQw1uancNqpgSbsEOqoIlAmO2W7aP+ZI178f0FWcPOquRSo
	hy29rAROadzPAPQiy4AUqDoLWrxAzgIzABMkS7e1OPe+hqKVGJuE0/ytrnr/VYhfaJuodD
	hELKR6i+NK1Pw7FZmKVQ5O44BMxtPQ1IMAiPAasIQS8ZBhmFDPPTrE4YuBCZAA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 09:34:33 +0100
Message-Id: <DFVTWVIZ6ZUP.1YHMAPRNIEF5M@bootlin.com>
Subject: Re: [docs] [PATCH v3 3/3] lib/bb/tests/setup.py: add tests for
 oe-fragments-one-of
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com> <20260122-bitbake-setup-choose-builtin-v3-3-c55291acc1a7@bootlin.com> <CANNYZj_SUcRFLWobRO9GHPzN+ZtG9koKVg4iZ-gzoKsSAUiMoQ@mail.gmail.com>
In-Reply-To: <CANNYZj_SUcRFLWobRO9GHPzN+ZtG9koKVg4iZ-gzoKsSAUiMoQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 08:34:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18856

Hi,

On Thu Jan 22, 2026 at 6:54 PM CET, Alexander Kanavin via lists.yoctoprojec=
t.org wrote:
> On Thu, 22 Jan 2026 at 16:02, Antonin Godard <antonin.godard@bootlin.com>=
 wrote:
>> +            },
>> +            {
>> +                "name": "gizmo-fragments-one-of",
>> +                "description": "Gizmo configuration using oe-fragments-=
one-of, both formats",
>> +                "oe-template": "test-configuration-gizmo",
>> +                "oe-fragments-one-of": {
>> +                    "fragment-desc": {
>> +                        "description": "Test fragments (with descriptio=
n)",
>> +                        "options" : [
>> +                            { "name": "fragment-desc-1", "description":=
 "fragment 1 desc" }
>> +                        ]
>> +                    },
>> +                    "fragment-nodesc": {
>> +                        "description": "Test fragments (no description)=
",
>> +                        "options" : [
>> +                            "fragment-nodesc-1"
>> +                        ]
>> +                    }
>> +                }
>
> To avoid multiplying test configs further (and making the tests
> slower), perhaps this can be added to gizmo-notemplate, and that
> renamed to gizmo-notemplate-fragments-one-of ?

Sure

>> -                                                                 'gadge=
t-notemplate','gizmo-notemplate')},
>> +                                                                 'gadge=
t-notemplate',
>> +                                                                 'gizmo=
-notemplate',
>> +                                                                 'gizmo=
-fragments-one-of fragment-desc-1 fragment-nodesc-1')},
>
> As there's only one choice in each, bitbake-setup should pick that
> without asking, or having to specify them on command line. Let's test
> that too, and drop the fragment names from here.

I tried that with the following modified configuration:

{
    "name": "gizmo-notemplate-fragments-one-of",
    "description": "Gizmo notemplate configuration",
    "bb-layers": ["layerC","layerD/meta-layer"],
    "oe-fragments": ["test-fragment-2"],
    "oe-fragments-one-of": {
        "fragment-desc": {
            "description": "Test fragments (with description)",
            "options" : [
                { "name": "fragment-desc-1", "description": "fragment 1 des=
c" }
            ]
        },
        "fragment-nodesc": {
            "description": "Test fragments (no description)",
            "options" : [
                "fragment-nodesc-1"
            ]
        }
    }
},

But I'm hitting:

bb.process.ExecutionError: Execution of '/bitbake/bin/bitbake-setup --globa=
l-settings /tmp/bitbake-fetch-q1wqa8zi/global-config init --non-interactive=
 test-config-1 gizmo-notemplate-fragments-one-of' failed with exit code 1:
Traceback (most recent call last):
  File "/bitbake/bin/bitbake-setup", line 1320, in <module>
    main()
  File "/bitbake/bin/bitbake-setup", line 1310, in main
    init_config(top_dir, all_settings, args)
  File "/bitbake/bin/bitbake-setup", line 767, in init_config
    upstream_config =3D obtain_config(top_dir, settings["default"]["registr=
y"], args, source_overrides, d)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/bitbake/bin/bitbake-setup", line 586, in obtain_config
    upstream_config['bitbake-config']['oe-fragment-choices'] =3D choose_fra=
gments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), con=
fig_parameters[1:], args.non_interactive, args.skip_selection)
                                                               ^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/bitbake/bin/bitbake-setup", line 534, in choose_fragments
    raise Exception(f"Unable to choose from options in non-interactive mode=
: {[o['name'] for o in options]}")
Exception: Unable to choose from options in non-interactive mode: ['fragmen=
t-desc-1']

So just after:

        # options can be a list of strings or a list of dicts
        options =3D v["options"]
        if len(options) > 0 and isinstance(v["options"][0], str):
            options =3D [{"name": o, "description": ""} for o in v["options=
"]]

I added:

        if len(options) =3D=3D 1:
            choices[k] =3D options[0]["name"]
            continue

which seems to accomplish what you had in mind.

However this makes the setup dir name "non-predictable" and I hit the follo=
wing
next error:

Traceback (most recent call last):
  File "/bitbake/lib/bb/tests/setup.py", line 357, in test_setup
    self.check_setupdir_files(setuppath, test_file_content)
  File "/bitbake/lib/bb/tests/setup.py", line 224, in check_setupdir_files
    with open(os.path.join(setuppath, 'config', "config-upstream.json")) as=
 f:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: '/tmp/bitbake-fetch=
-9d85c0us/bitbake-builds/test-config-1-gizmo-notemplate-fragments-one-of/co=
nfig/config-upstream.json'

which is due to the setup directory name containing the fragment choices (e=
ven
if none were passed on the command-line).

$ ls -l /tmp/bitbake-fetch-atck07q2/bitbake-builds
...
drwxr-xr-x    - builder 23 Jan 08:22 test-config-1-gizmo-notemplate-fragmen=
ts-one-of-fragment-desc-1-fragment-nodesc-1

So I added:

                "setup-dir-name": "gizmo-notemplate-fragments-one-of",

To make sure we get a fixed name for this configuration. Sounds good to you=
?

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


