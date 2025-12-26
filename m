Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A529FE8FDAD
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 16:45:48 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.156143.1766767541272043148
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Dec 2025 08:45:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=qAj9khQT;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8D8B14E41DD3
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 16:45:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44C28606E4;
	Fri, 26 Dec 2025 16:45:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AF97103C8D10;
	Fri, 26 Dec 2025 17:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766767538; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qzsZsVSh+c82V6e1uglRmW8z8Rz5ZyK5CZ8SPeF1Wl0=;
	b=qAj9khQTbNXP3TXM56VzhtYhQKt1PCM1eTJ9lsLPY34UJ/xSl/Rf4Iwe0qGLkGcfsNUDKn
	aaQe0UcwLqDfOJkGrKLm09ZppmnJbC9BfExX6XD4AvxNP0L9s1sDVPTUv02VA73shC08sl
	gBHIWrn6oTdpAEImeT1qjXuy537rlCJR+R1I6vvEilShcPUsHcH/K9LRyh3H1lrggZwqI+
	tgwCTH8HEDT+k7UHtec6j2ntTlSB5BurIBtGrqLcwIIoUXdmvtIBGVkCTPZWU9NY16Hign
	I90YZysBXXoUCIm4HA3Mde6OEu5yxNWYAePQ5+kUFLGF57u9qsOyVLPNty/duw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Dec 2025 17:45:36 +0100
Message-Id: <DF8ATLBIC41C.NPA04O86LL3L@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Skip AUTOREV management if no
 SCM URI
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251208161219.41335-1-corentin.guillevic@smile.fr>
In-Reply-To: <20251208161219.41335-1-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 16:45:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18651

On Mon Dec 8, 2025 at 5:12 PM CET, Corentin Guillevic via lists.openembedde=
d.org wrote:
> AUTOREV allows to fetch the latest revision. If no SCM URI is used (e.g. =
git://, ...),
> AUTOREV has no effect. However there is one case in which a recipe with A=
UTOREV
> but no SCM URI will lead to a parsing error:
>
> ERROR: /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools=
/i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to work pro=
perly, please set the variables earlier in parsing. Erroring instead of lat=
er obtuse build failures.
>
> This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is not ac=
ted
> upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the
> srcrev_internal_helper() function to run, and read the value of SRCREV. I=
f
> SRCREV =3D "${AUTOREV}", then AUTOREV will be acted upon.
>
> If the recipe does not have an SCM URI, SRCREV is not parsed and AUTOREV =
remains
> unchanged. However, if SRCREV is expanded during the parsing time in Pyth=
on code
> (either pure or evaluated from BitBake code), then AUTOREV will be expand=
ed too
> and resulting in the setting of __BBAUTOREV_SEEN. However, as there is no=
 SCM
> URI, the code flow that would act upon AUTOREV is never run.
>
> The fix slightly changes the way AUTOREV is handled: if no SCM URI is pro=
vided,
> AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN will =
not be
> defined).
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---

Hi Corentin,

Sorry for the delay, I didn't realise you replied to all questions about
this series.

I believe this is breaking some QA and selftests, am I missing some
other patches?

oeqa.utils.subprocesstweak.OETestCalledProcessError: Command '. /srv/pokybu=
ild/yocto-worker/qemuarm64-armhost/build/build/tmp/work/qemuarm64-poky-linu=
x/core-image-minimal/1.0/testsdkext/environment-setup-cortexa57-poky-linux =
> /dev/null; devtool add kernel-module-hello-world https://git.yoctoproject=
.org/git/kernel-module-hello-world;' returned non-zero exit status 1.
...
ERROR: ExpansionError during parsing /srv/pokybuild/yocto-worker/qemuarm64-=
armhost/build/build/tmp/work/qemuarm64-poky-linux/core-image-minimal/1.0/te=
stsdkext/workspace/recipes/recipetool/tmp-recipetool-g42ny7zl.bb
bb.data_smart.ExpansionError: Failure expanding variable AUTOREV, expressio=
n was ${@bb.fetch2.get_autorev(d)} which triggered exception RecursionError=
: maximum recursion depth exceeded
The variable dependency chain for the failure is: AUTOREV -> SRCREV -> AUTO=
REV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCRE=
V -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV=
 -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -=
> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV ->=
 SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> A=
UTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SR=
CREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTO=
REV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCRE=
V -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV=
 -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -=
> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV ->=
 SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> A=
UTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SR=
CREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTO=
REV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCRE=
V -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV -> SRCREV -> AUTOREV=
 -> SRCREV -> AUTOREV -> SRCREV -> fetcher_hashes_dummyfunc[vardepvalue]

ERROR: Parsing halted due to errors, see error messages above

https://autobuilder.yoctoproject.org/valkyrie/#/builders/8/builds/2957
https://autobuilder.yoctoproject.org/valkyrie/#/builders/16/builds/2965
https://autobuilder.yoctoproject.org/valkyrie/#/builders/30/builds/2906
https://autobuilder.yoctoproject.org/valkyrie/#/builders/36/builds/2931
https://autobuilder.yoctoproject.org/valkyrie/#/builders/45/builds/862
https://autobuilder.yoctoproject.org/valkyrie/#/builders/68/builds/3007
https://autobuilder.yoctoproject.org/valkyrie/#/builders/80/builds/2769

Failing selftests, all with a similar error as above:

pokybleeding.PokyBleeding.test_poky_bleeding_autorev
sstatetests.SStateTests.test_autorev_sstate_works
devtool.DevtoolAddTests.test_devtool_add_fetch_git
devtool.DevtoolAddTests.test_devtool_add_git_style1
recipetool.RecipetoolCreateTests.test_recipetool_create_git_http
recipetool.RecipetoolCreateTests.test_recipetool_create_git_srcbranch
recipetool.RecipetoolCreateTests.test_recipetool_create_git_srcuri_branch
recipetool.RecipetoolCreateTests.test_recipetool_create_git_srcuri_master

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2809
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2916
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3053

Can you have a look at these?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


