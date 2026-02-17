Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C9E6817C
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 12:13:26 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10591.1771330399539858183
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 04:13:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SZNeNFFk;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9A3751A1034;
	Tue, 17 Feb 2026 12:13:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EF60606D1;
	Tue, 17 Feb 2026 12:13:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55F4710368801;
	Tue, 17 Feb 2026 13:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771330396; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PTgB2ordjBX4LAHoJp0PvJIGsWO1ftDNKD0h1a5Rm88=;
	b=SZNeNFFkxwdmumo7QAHWvu0njcjRuxLuT2Kwzv2Ak3cMw1QItptrvDp9OJM3lI1yCqcZHv
	vm1MABdiVJnDA7lB6oGNQTZcPZr54He7wugqBXzxp+tQFcqg8cFnHS4hfLN9+Ee6O7pq5Q
	+LgrnHs3NXYVBxB6NGiVVlFWQEpg2DbJW6KhzCAyHq5koqlzXiWTfufwHClLC8Lw4aVvrM
	niSTYLzjStq60jcv5pyMxleF3n1x6yjKHhmwM+Xpj25UISvNG/i1gTqWHOH849Cgw1OH05
	uJBwE9rRN2TybCiHZPcuKkk21bLDwfbrEYBIfDmqTLW5tFs2MI09fi5NgGPSOg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 13:13:14 +0100
Message-Id: <DGH87XLG5SVZ.V95TRWOPLP62@bootlin.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v2 3/5] doc: bitbake-user-manual-ref-variables:
 expand and reorganize BBMASK explanations
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
 <20260216-bbmask-slashes-v2-3-b9bb52f5fd3d@cherry.de>
 <DGH5S8O1WAJV.1GBNF55N3LGY2@bootlin.com>
 <8c7d0a2e-e7cd-46d8-8747-899703a31071@cherry.de>
In-Reply-To: <8c7d0a2e-e7cd-46d8-8747-899703a31071@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 12:13:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19049

Hi,

On Tue Feb 17, 2026 at 12:52 PM CET, Quentin Schulz wrote:
> Hi Antonin,
>
> On 2/17/26 11:18 AM, Antonin Godard wrote:
>> Hi,
>>=20
>> On Mon Feb 16, 2026 at 11:36 AM CET, Quentin Schulz via lists.yoctoproje=
ct.org wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> The documentation doesn't explain the side-effect of putting a leading
>>> slash, only the trailing slash.
>>>
>>> The leading slash is not for making the regular expression match an
>>> absolute path, but to force the match on the directory or file that
>>> exactly starts (and ends if there is a trailing slash) with the
>>> specified string. So let's explain that.
>>>
>>> This also explains that this doesn't prevent more than the intended pat=
h
>>> to be caught, specifically because it is NOT a regular expression
>>> matching an absolute path.
>>>
>>> Because any pattern not starting with a ^ character can match multiple
>>> directories from multiple directories, let's make the usage of
>>> BBFILE_PATTERN_my-layer the recommended one. Keep the rest as hints at
>>> what can happen when not using but reiterate what users should be using=
.
>>>
>>> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   .../bitbake-user-manual-ref-variables.rst          | 87 +++++++++++++=
++++++---
>>>   1 file changed, 78 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> index f20a9012c..06e1112b5 100644
>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> @@ -1052,24 +1052,93 @@ overview of their function and contents.
>>>  =20
>>>         The following example uses a complete regular expression to tel=
l
>>>         BitBake to ignore all recipe and recipe append files in
>>> -      ``meta-ti/recipes-misc/`` directories (and their subdirectories)=
::
>>> +      ``recipes-bsp`` directory (recursively) of ``meta-ti``::
>>>  =20
>>> -         BBMASK =3D "/meta-ti/recipes-misc/"
>>> +         BBMASK =3D "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
>>>  =20
>>>         If you want to mask out multiple directories or recipes, you ca=
n
>>>         specify multiple regular expression fragments. This next exampl=
e
>>>         masks out multiple directories and individual recipes::
>>>  =20
>>> -         BBMASK +=3D "/meta-ti/recipes-ti/packagegroup/"
>>> -         BBMASK +=3D "/meta-oe/recipes-support/"
>>> -         BBMASK +=3D "/meta-foo/.*/openldap"
>>> -         BBMASK +=3D "opencv.*\.bbappend"
>>> -         BBMASK +=3D "lzma"
>>> +         BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libga=
l/"
>>> +         BBMASK +=3D "${BBFILE_PATTERN_openembedded-layer}/recipes-sup=
port/"
>>> +         BBMASK +=3D "${BBFILE_PATTERN_openembedded-layer}/.*/openldap=
"
>>> +         BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/.*/optee.*\.bbappend"
>>> +
>>> +      This masks the ``recipes-graphics/libgal/`` from ``meta-ti``, ev=
erything
>>> +      under ``recipes-support`` in ``meta-oe``, every directory or fil=
e whose
>>> +      name starts with ``openldap`` in ``meta-oe`` at any directory de=
pth > 1
>>> +      (e.g. in ``meta-oe``, ``recipes-foo/openldap-stuff/`` or
>>> +      ``recipes-bar/baz/openldap_0.1.bb`` but not ``openldap/``), ever=
y append
>>> +      file in ``meta-ti`` at any directory depth > 1 (e.g.
>>=20
>> s/every append file/every append file starting with ``optee``/ ?
>>=20
>
> I'm going for:
>
> every append file whose name starts with ``optee`` in
>
> does that work for you?

Works for me!

>>> +      ``optee/optee-examples_%.bbappend`` and
>>> +      ``recipes-security/optee/optee-client_%.bbappend``).
>>>  =20
>>>         .. note::
>>>  =20
>>> -         When specifying a directory name, use the trailing slash char=
acter
>>> -         to ensure you match just that directory name.
>>> +         Because these are complete regular expressions, if you want t=
o match a
>>> +         directory and not a file, you must end the expression with a =
trailing
>>> +         slash. That is::
>>> +
>>> +            BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/recipes-graphics/li=
bgal/"
>>> +
>>> +         Will match anything under ``recipes-graphics/ligbal/`` direct=
ory of
>>> +         ``meta-ti``. And::
>>> +
>>> +            BBMASK +=3D "${BBFILE_PATTERN_meta-ti}/recipes-graphics/li=
bgal"
>>> +
>>> +         Will match in ``meta-ti`` any file prefixed with ``libgal`` i=
n
>>> +         ``recipes-graphics/`` and any directory (recursively; and its
>>> +         recipes and recipe append files regardless how they are named=
) prefixed
>>> +         with ``libgal`` in ``recipes-graphics/``. That is, provided y=
our layers
>>> +         are available at ``/build/layers/``, it'll match::
>>=20
>> s/build/builds/
>>=20
>
> Mmmm.. Now to come to think of it, should I use
>
> /bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64/layers/

I think the default name should be "poky-master" now (doc needs an update).

> instead? It would match the instructions in=20
> doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst (but=20
> it'll make for very long lines :/).

So /bitbake-builds/poky-master/layers/ is reasonable I think

Antonin

