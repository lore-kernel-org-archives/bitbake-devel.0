Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860AEED600
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 15:05:05 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.22921.1694790303214255527
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Sep 2023 08:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G70fsWHj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso2609885e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694790301; x=1695395101; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWty9b0v+wkRj7Ol/JIVYDiM2VEgtBXmauWtkNKGWGE=;
        b=G70fsWHjIhspqf8qtDRMjgYxWLuSAeiY2rcoGvFRgqggZ5xK4C95Ht7yxffL5RiziZ
         mU9b2/Yl5spNXtLIrJNt/UHIAKMXkwd8Acm7UfMl0t+nJKqCmpALTCWD6KP/bxsYAIxw
         lU4K/mLXLLXZg0+NQgz7JihZsO5g7VRp0x11E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790301; x=1695395101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWty9b0v+wkRj7Ol/JIVYDiM2VEgtBXmauWtkNKGWGE=;
        b=X2mKLU0M9Y/Rs+QYgy8biGDOqyJcsFv2McF8DJXLhSVzjlI6Pe5n2p7jQvtb86VWMd
         LMc9LGASJwlGr43IxQSDoc4lVYDO+ZOYUShX+9l2bT9o8ZyxKeT7Jqe9MARJvHtR6Zx2
         gAWfFpC74kK1gGrQkhgpMmqdX6HWuL6sLTioxH2ZaDonqPgMLzMyakZqdL4LewPuzykz
         gzxqi7lDjX/GVSxJ0npjPqo0WxQwPkYeLNqi7zI7ZkE5eVzXwN4qXa/nDOatt2vzJqxD
         YrBGeFZXAh8FC8NjCS8bsUpaCoPHX8WF9xMh76qdNkh4xwB+EG9TCOY4mRXFqdR6Fi6e
         q/ag==
X-Gm-Message-State: AOJu0YzWxQfbIjbi/tusswOBEQ5jo1O1K1RTFTrfa216j1Aq1B/0CLJy
	q3Wtrylk52W3bouBp0yam/Z1s3Op1S8rSMCYhzY=
X-Google-Smtp-Source: AGHT+IHME8J4ARp0S36cox7/OrIo4F9hjp3c64MVniUBBbrBNe7OCNzHvqr2yfBScr6/JlIenec8LA==
X-Received: by 2002:adf:efd0:0:b0:31d:d977:4e3d with SMTP id i16-20020adfefd0000000b0031dd9774e3dmr1671214wrp.19.1694790301121;
        Fri, 15 Sep 2023 08:05:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:93a7:bb97:496b:8932? ([2001:8b0:aba:5f3c:93a7:bb97:496b:8932])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003180027d67asm4655438wro.19.2023.09.15.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:05:00 -0700 (PDT)
Message-ID: <83b505e05105730aab256bb4cd1b8abba8f9e913.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] [bitbake-devel] [PATCH]
 server/process: Disable the flush() call in server logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Philip Balister <philip@opensdr.com>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Date: Fri, 15 Sep 2023 16:04:59 +0100
In-Reply-To: <f5e5cf26-42a2-73a9-e8bb-b2ee7ee7f965@opensdr.com>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
	 <49c3f81299d8153f31b09cfd226cb183097e6c8f.camel@linuxfoundation.org>
	 <DB5PR02MB10213747F1C3061D3EC8C116FEFF6A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <f5e5cf26-42a2-73a9-e8bb-b2ee7ee7f965@opensdr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 15:05:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15070

On Fri, 2023-09-15 at 10:58 -0400, Philip Balister wrote:
> On 9/15/23 09:59, Peter Kjellerstedt wrote:
> > > -----Original Message-----
> > > From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.opene=
mbedded.org> On Behalf Of Richard Purdie
> > > Sent: den 15 september 2023 10:41
> > > To: bitbake-devel@lists.openembedded.org; openembedded-architecture <=
openembedded-architecture@lists.openembedded.org>
> > > Cc: Philip Balister <philip@opensdr.com>
> > > Subject: Re: [bitbake-devel] [PATCH] server/process: Disable the flus=
h() call in server logging
> > >=20
> > > On Thu, 2023-09-14 at 17:28 +0100, Richard Purdie via lists.openembed=
ded.org wrote:
> > > > We've been chasing bitbake timeouts for a while and it was unclear =
where things
> > > > were blocking on IO. It appears the flush() call in server logging =
can cause
> > > > pauses up to minutes long on systems with slow (spinning) disks tha=
t are heavily
> > > > loaded with IO.
> > > >=20
> > > > Since the flush() was added to aid debugging of other timing issues=
, we shouldn't
> > > > need it now and it can be disabled. Leave a comment as a reminder o=
f the pain this
> > > > can cause.
> > > >=20
> > > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > > ---
> > > >   lib/bb/server/process.py | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> > > > index 40cb99bc97..94e93bc3a6 100644
> > > > --- a/lib/bb/server/process.py
> > > > +++ b/lib/bb/server/process.py
> > > > @@ -43,7 +43,8 @@ def currenttime():
> > > >=20
> > > >   def serverlog(msg):
> > > >       print(str(os.getpid()) + " " +  currenttime() + " " + msg)
> > > > -    sys.stdout.flush()
> > > > +    #Seems a flush here triggers filesytem sync like behaviour and=
 long hangs in the server
> > > > +    #sys.stdout.flush()
> > > >=20
> > > >   #
> > > >   # When we have lockfile issues, try and find infomation about whi=
ch process is
> > >=20
> > > Whilst this patch looks simple, it has all the signs of turning into
> > > weeks of pain after looking at the results from testing. It looks lik=
e
> > > we have a race in the system which this flush is masking.
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/20=
82/steps/14/logs/stdio
> > >=20
> > > Looking at just one of the failures there (of the 6), we see this tes=
t
> > > pass:
> > >=20
> > > 1: 20/57 355/537 (0.12s) (0 failed)
> > > (recipetool.RecipetoolTests.test_recipetool_split_pkg_licenses)
> > >=20
> > > then the next test to run on that build directory is:
> > >=20
> > > 1: 21/57 359/537 (137.64s) (0 failed)
> > > (signing.Signing.test_signing_packages)
> > >=20
> > > with an error which boils down to:
> > >=20
> > > FileNotFoundError: [Errno 2] No such file or directory:
> > > '/tmp/recipetoolqaizvjzf8h'
> > >=20
> > > from
> > >=20
> > > run(cmd=3D'git rev-parse --abbrev-ref HEAD', input=3DNone, log=3DNone=
,
> > > extrafiles=3D[], **options=3D{'cwd': '/tmp/recipetoolqaizvjzf8h', 'sh=
ell':
> > > True})
> > >=20
> > > i.e. it is trying to run a command in a directory which doesn't exist=
.
> > >=20
> > > Without looking, I know "recipetoolqa" tmpfiles will come from
> > > RecipetoolTests so the previous build directory is being removed and
> > > yet still is cwd for the server.
> > >=20
> > > I've not looked much into any of the other failures yet.
> > >=20
> > > Looking at the 5 different selftest failures:
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/20=
82/steps/14/logs/stdio
> > >=20
> > > 2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS -
> > > archiver.Archiver.test_archiver_srpm_mode: FAILED (237.00s)
> > > 2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS -
> > > overlayfs.OverlayFSEtcRunTimeTests.test_all_required_variables_set: F=
AILED
> > > (13.25s)
> > > 2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS -
> > > prservice.BitbakePrTests.test_pr_service_deb_arch_dep: FAILED (126.30=
s)
> > > 2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS -
> > > signing.Signing.test_signing_packages: FAILED (137.64s)
> > > 2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS -
> > > sstatetests.SStateHashSameSigs.test_sstate_32_64_same_hash: FAILED
> > > (541.51s)
> > > 2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS -
> > > sstatetests.SStateHashSameSigs3.test_sstate_multilib_or_not_native_sa=
mesig
> > > s: FAILED (224.05s)
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/571=
0/steps/14/logs/stdio
> > >=20
> > > 2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS -
> > > archiver.Archiver.test_archiver_srpm_mode: FAILED (59.78s)
> > > 2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS -
> > > bblogging.BitBakeLogging.test_shell_loggingA: FAILED (15.71s)
> > > 2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS -
> > > multiconfig.MultiConfig.test_multiconfig_reparse: FAILED (6.39s)
> > > 2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS -
> > > prservice.BitbakePrTests.test_pr_service_rpm_arch_indep: FAILED (0.84=
s)
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/574=
6/steps/14/logs/stdio
> > >=20
> > > 2023-09-14 23:33:02,720 - oe-selftest - INFO - RESULTS -
> > > package.VersionOrdering.test_dpkg: ERROR
> > > 2023-09-14 23:33:02,720 - oe-selftest - INFO - RESULTS -
> > > package.VersionOrdering.test_opkg: ERROR
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > package.VersionOrdering.test_rpm: ERROR
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > archiver.Archiver.test_archiver_srpm_mode: FAILED (129.04s)
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > bbtests.BitbakeTests.test_postfile: FAILED (2.06s)
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > bbtests.BitbakeTests.test_prefile: FAILED (1.73s)
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > devtool.DevtoolModifyTests.test_devtool_buildclean: FAILED (265.26s)
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > overlayfs.OverlayFSTests.test_mount_unit_not_set: FAILED (7.83s)
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > prservice.BitbakePrTests.test_import_export_override_db: FAILED (289.=
85s)
> > > 2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS -
> > > sstatetests.SStateHashSameSigs3.test_sstate_multilib_or_not_native_sa=
mesig
> > > s: FAILED (111.34s)
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/575=
7/steps/15/logs/stdio
> > >=20
> > > 2023-09-14 22:55:12,332 - oe-selftest - INFO - RESULTS -
> > > bblogging.BitBakeLogging.test_python_exec_func_python_loggingB: FAILE=
D
> > > (100.76s)
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/577=
7/steps/14/logs/stdio
> > >=20
> > > 2023-09-14 23:00:48,622 - oe-selftest - INFO - RESULTS -
> > > archiver.Archiver.test_archiver_srpm_mode: FAILED (71.69s)
> > > 2023-09-14 23:00:48,622 - oe-selftest - INFO - RESULTS -
> > > prservice.BitbakePrTests.test_pr_service_deb_arch_dep: FAILED (27.14s=
)
> > >=20
> > > so the failures are all over the place.
> > >=20
> > > We also had a wic test failure that when re-ran, didn't reproduce:
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/577=
7/steps/14/logs/stdio
> > >=20
> > > and some toolchain test failures for qemuppc:
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/153/builds/52=
9
> > >=20
> > > and qemuarm64:
> > >=20
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/151/builds/53=
0
> > >=20
> > > The question at this point is what do people want me to do. We clearl=
y
> > > have a really nasty bug in here. The patch is "right" and we do need =
to
> > > fix this. If I merge it, I suspect I'm going to end up having to chas=
e
> > > this down before we can release and I am going to struggle to find th=
e
> > > time to do it and I suspect my sanity will suffer. This does look to =
be
> > > a significant issue though.
> > >=20
> > > Cheers,
> > >=20
> > > Richard
> >=20
> > While the problem the patch tried to fix is real, it seems a lot less
> > problematic than the result of applying the patch. So from a release
> > perspective, I would keep the current code and possibly add it as a
> > known bug to the release notes. Then, after the release is out, start
> > the work of solving the fallout from applying the patch, with the
> > intention to have it solved for the first point release of Nanbield.
> >=20
> > While not ideal, it sounds a lot less stressful than applying the
> > patch at this stage.
>=20
> I understand this exposes some "interesting" issues, but I tend to agree=
=20
> with Peter here.

This is a 'bit' more than "interesting". If we ignore this, pretty much
every bitbake failure will be blamed on "the cache problem" and we'll
develop a reputation for reliability issues :(.

The damage this issue can do is scary even if I doubt most users would
hit it.

Cheers,

Richard

