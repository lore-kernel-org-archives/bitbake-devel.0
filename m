Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690FEE6447
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 08:40:42 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.16400.1694767237859348969
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Sep 2023 01:40:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ezjN+8ES;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso1754817f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694767236; x=1695372036; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6h9884q/qviLGCkVvzzUrS6svESnC53Oc3jM7rWXxxQ=;
        b=ezjN+8ESXdAmegRdXzx6JNzliymZwWrg3sVW33MyVqYIFN8tuB3l5PVZc/dvz5hmxa
         zPvToNsO/Zk12NHFUN1prXWrg40n6W6qh8YXxCseUP9hfU4zjARFefW6eoC3jnKpVJY0
         YThN0spnNfkjupffz7x6N/tks74wK0MSIFcss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767236; x=1695372036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6h9884q/qviLGCkVvzzUrS6svESnC53Oc3jM7rWXxxQ=;
        b=HKwqb0rcxWnQnmi64Yq9y82F3YOZajTHVHl6rBu0L0JUD5gQytgPrgqwzY+653Y5g8
         CU/4JMODOHFBQSxiQyiHTTFm9hM51abBFTS6a5sIBGbPewPXMlLYVKbLa7G6jyM7BuNF
         UR4+u+HzCuimZxrkYWfQA5nJrpr8Pn4iSz6RcmN0g+RSBfiFxDtOYQ6TKAY7OfSGM3z6
         zrytIoYsar7OsJDotrgXMJAUrEZjOZagloAxu1FigLEKasxlM4haPtcM2gLJKtQqfxkk
         SZHKygi7w8/etvxyt4EfyMyDwSYtE7Tvx7Am4CYF9s5j8oTITvbn1WIpPY4o4T/TXAYc
         wLfw==
X-Gm-Message-State: AOJu0Yzv+JTTmMf1dkf7sHnSvZxIT67+OMPu9q9AM5Dqvvrxm5Y2urFX
	+TIMCXWfYW+cq6C3l2nJdCz3XvNgTbMqXTN+RLQ=
X-Google-Smtp-Source: AGHT+IGt63nvmtF+TgJ7FTc3zyINrANJDoBrbQXYbNJv3VqekDsOgvcMu3I7BoH25NdJabCI7nkNeA==
X-Received: by 2002:a5d:4acb:0:b0:313:eb09:c029 with SMTP id y11-20020a5d4acb000000b00313eb09c029mr895068wrs.43.1694767235760;
        Fri, 15 Sep 2023 01:40:35 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:93a7:bb97:496b:8932? ([2001:8b0:aba:5f3c:93a7:bb97:496b:8932])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b0031c6dc684f8sm3834992wrn.20.2023.09.15.01.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:40:35 -0700 (PDT)
Message-ID: <49c3f81299d8153f31b09cfd226cb183097e6c8f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: Disable the flush()
 call in server logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: Philip Balister <philip@opensdr.com>
Date: Fri, 15 Sep 2023 09:40:34 +0100
In-Reply-To: <1784D0C1F5057432.10618@lists.openembedded.org>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 08:40:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15065

On Thu, 2023-09-14 at 17:28 +0100, Richard Purdie via
lists.openembedded.org wrote:
> We've been chasing bitbake timeouts for a while and it was unclear where =
things
> were blocking on IO. It appears the flush() call in server logging can ca=
use
> pauses up to minutes long on systems with slow (spinning) disks that are =
heavily
> loaded with IO.
>=20
> Since the flush() was added to aid debugging of other timing issues, we s=
houldn't
> need it now and it can be disabled. Leave a comment as a reminder of the =
pain this
> can cause.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/server/process.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 40cb99bc97..94e93bc3a6 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -43,7 +43,8 @@ def currenttime():
> =20
>  def serverlog(msg):
>      print(str(os.getpid()) + " " +  currenttime() + " " + msg)
> -    sys.stdout.flush()
> +    #Seems a flush here triggers filesytem sync like behaviour and long =
hangs in the server
> +    #sys.stdout.flush()
> =20
>  #
>  # When we have lockfile issues, try and find infomation about which proc=
ess is

Whilst this patch looks simple, it has all the signs of turning into
weeks of pain after looking at the results from testing. It looks like
we have a race in the system which this flush is masking.

https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/2082/ste=
ps/14/logs/stdio

Looking at just one of the failures there (of the 6), we see this test
pass:

1: 20/57 355/537 (0.12s) (0 failed) (recipetool.RecipetoolTests.test_recipe=
tool_split_pkg_licenses)

then the next test to run on that build directory is:

1: 21/57 359/537 (137.64s) (0 failed) (signing.Signing.test_signing_package=
s)

with an error which boils down to:

FileNotFoundError: [Errno 2] No such file or directory: '/tmp/recipetoolqai=
zvjzf8h'

from=20

run(cmd=3D'git rev-parse --abbrev-ref HEAD', input=3DNone, log=3DNone, extr=
afiles=3D[], **options=3D{'cwd': '/tmp/recipetoolqaizvjzf8h', 'shell': True=
})

i.e. it is trying to run a command in a directory which doesn't exist.

Without looking, I know "recipetoolqa" tmpfiles will come from
RecipetoolTests so the previous build directory is being removed and
yet still is cwd for the server.

I've not looked much into any of the other failures yet.

Looking at the 5 different selftest failures:

https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/2082/ste=
ps/14/logs/stdio

2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS - archiver.Archiver.=
test_archiver_srpm_mode: FAILED (237.00s)
2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS - overlayfs.OverlayF=
SEtcRunTimeTests.test_all_required_variables_set: FAILED (13.25s)
2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS - prservice.BitbakeP=
rTests.test_pr_service_deb_arch_dep: FAILED (126.30s)
2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS - signing.Signing.te=
st_signing_packages: FAILED (137.64s)
2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS - sstatetests.SState=
HashSameSigs.test_sstate_32_64_same_hash: FAILED (541.51s)
2023-09-15 01:56:12,685 - oe-selftest - INFO - RESULTS - sstatetests.SState=
HashSameSigs3.test_sstate_multilib_or_not_native_samesigs: FAILED (224.05s)

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5710/step=
s/14/logs/stdio

2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS - archiver.Archiver.=
test_archiver_srpm_mode: FAILED (59.78s)
2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS - bblogging.BitBakeL=
ogging.test_shell_loggingA: FAILED (15.71s)
2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS - multiconfig.MultiC=
onfig.test_multiconfig_reparse: FAILED (6.39s)
2023-09-14 16:00:20,642 - oe-selftest - INFO - RESULTS - prservice.BitbakeP=
rTests.test_pr_service_rpm_arch_indep: FAILED (0.84s)

https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/5746/step=
s/14/logs/stdio

2023-09-14 23:33:02,720 - oe-selftest - INFO - RESULTS - package.VersionOrd=
ering.test_dpkg: ERROR
2023-09-14 23:33:02,720 - oe-selftest - INFO - RESULTS - package.VersionOrd=
ering.test_opkg: ERROR
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - package.VersionOrd=
ering.test_rpm: ERROR
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - archiver.Archiver.=
test_archiver_srpm_mode: FAILED (129.04s)
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - bbtests.BitbakeTes=
ts.test_postfile: FAILED (2.06s)
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - bbtests.BitbakeTes=
ts.test_prefile: FAILED (1.73s)
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - devtool.DevtoolMod=
ifyTests.test_devtool_buildclean: FAILED (265.26s)
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - overlayfs.OverlayF=
STests.test_mount_unit_not_set: FAILED (7.83s)
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - prservice.BitbakeP=
rTests.test_import_export_override_db: FAILED (289.85s)
2023-09-14 23:33:02,721 - oe-selftest - INFO - RESULTS - sstatetests.SState=
HashSameSigs3.test_sstate_multilib_or_not_native_samesigs: FAILED (111.34s)

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5757/step=
s/15/logs/stdio

2023-09-14 22:55:12,332 - oe-selftest - INFO - RESULTS - bblogging.BitBakeL=
ogging.test_python_exec_func_python_loggingB: FAILED (100.76s)

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5777/step=
s/14/logs/stdio

2023-09-14 23:00:48,622 - oe-selftest - INFO - RESULTS - archiver.Archiver.=
test_archiver_srpm_mode: FAILED (71.69s)
2023-09-14 23:00:48,622 - oe-selftest - INFO - RESULTS - prservice.BitbakeP=
rTests.test_pr_service_deb_arch_dep: FAILED (27.14s)

so the failures are all over the place.

We also had a wic test failure that when re-ran, didn't reproduce:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5777/step=
s/14/logs/stdio

and some toolchain test failures for qemuppc:

https://autobuilder.yoctoproject.org/typhoon/#/builders/153/builds/529

and qemuarm64:

https://autobuilder.yoctoproject.org/typhoon/#/builders/151/builds/530

The question at this point is what do people want me to do. We clearly
have a really nasty bug in here. The patch is "right" and we do need to
fix this. If I merge it, I suspect I'm going to end up having to chase
this down before we can release and I am going to struggle to find the
time to do it and I suspect my sanity will suffer. This does look to be
a significant issue though.

Cheers,

Richard


