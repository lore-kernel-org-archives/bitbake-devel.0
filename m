Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664AFEC1EB9
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 13:40:31 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20847.1770298821944251128
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 05:40:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Trw6sqeo;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 137134E4241E
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 13:40:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE076606FD;
	Thu,  5 Feb 2026 13:40:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A841119A8891;
	Thu,  5 Feb 2026 14:40:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770298819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CRJr+6fcyYDQRcrvYFscUg0ms7e49/uu+bRr6VFPidA=;
	b=Trw6sqeopVWwI4A1uYIialr/xAGMBWwnIYYj1/LnY/D5mT2u9Id50ktUOuUolRxYQ9J+Nz
	cIO+M4vsNYQaJdEjQAYlBo4D4kgeN5C19upAqAdp1+MDIBarLZmQjkFllQIG6NHZMN0FTi
	bVDXM+A94W+7rr3QznRpaV8UTOJ84Q28yDPaCV+EaeeX0e6/PVwB8pPLq7Lft4bx9rUJYi
	TxANoiSIomeHQ2mzI1qCGebNHQS17EVyShh1mrXev6JHmkDrg/KwvZRjCrtFNZpEifUbHd
	wJnntLElqijUA3A4ZgypMrUiWvC5QUqCN32gDqAS/Yt1QerwnWW4Y0Sm4fD8IQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 14:40:17 +0100
Message-Id: <DG72K1JSFLI9.935906R7H60Z@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <quentin.schulz@cherry.de>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v2] doc: fix the switchers menu
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
 <f9a1db09-bf8d-4f29-b2a7-567f97ce0532@cherry.de>
 <DG6ZW1HMRGQY.2QNTJC8SOYOCP@bootlin.com>
 <a6c85602-e566-419b-8a76-0dec0085b92b@cherry.de>
In-Reply-To: <a6c85602-e566-419b-8a76-0dec0085b92b@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 13:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18968

Hi,

On Thu Feb 5, 2026 at 2:08 PM CET, Quentin Schulz via lists.yoctoproject.or=
g wrote:
> Hi Antonin,
>
> On 2/5/26 12:34 PM, Antonin Godard wrote:
>> Hi,
>>=20
>> On Wed Feb 4, 2026 at 4:01 PM CET, Quentin Schulz via lists.yoctoproject=
.org wrote:
>> [...]
>>>> +with open("sphinx-static/switchers.js.in", "r") as r, \
>>>> +     open("sphinx-static/switchers.js", "w") as w:
>>>> +    lines =3D r.readlines()
>>>> +    for line in lines:
>>>> +        if "VERSIONS_PLACEHOLDER" in line:
>>>> +            if ourversion !=3D "dev":
>>>> +                w.write(f"    'dev': 'Unstable (dev)',\n")
>>>> +            for series in activereleases:
>>>> +                w.write(f"    '{series}': '{series} ({yocto_mapping[s=
eries]})',\n")
>>>
>>> Why is this different from yp-docs? We don't handle showing the current
>>> series (ourseries)/version (ourversion) if it's outdated anymore?
>>=20
>> We do, but from switchers.js, where in build_version_select we push the =
current
>> version of the document last:
>>=20
>>      buf.push(
>>        '<option value=3D"' +
>>          current_version +
>>          '" selected=3D"selected">' +
>>          current_title +
>>          "</option>",
>>      );
>>=20
>> So the version from our branch gets displayed.
>>=20
>> (trust me, I've had a hard time locating and understanding how all of th=
is
>> worked :))
>>=20
>
> Yeah set_versions.py and the switchers aren't the nicest things to dig=20
> into :/
>
> Is the above mechanism something we could migrate yp-docs switcher to to=
=20
> simplify it a bit?

Yes, I think I'd like to port these simplifications to yocto-docs soon afte=
r,
while memory is still fresh

>> However, you made me realize that due to our branch the abbrev hash, it =
would
>> always appear as outdated. I fixed that for v2.
>>=20
>>> To answer Richard on the other thread, we use YAML because JSON doesn't
>>> allow comments. Also, because we used to want multiline variables (see
>>> https://yaml-multiline.info/) which aren't supported in JSON, but those
>>> are gone since 8d993022c2ae ("docs: use literalinclude for system
>>> requirements"). Not sure we can get rid of it for yp-docs as we only
>>> override *some* variables in this file by set_versions.py so the
>>> autobuilder won't replace poky.yaml.in, and the YAML is consumed by
>>> sphinx/yocto-vars.py.
>>>
>>> If we don't plan on having comments in this file *ever*, then the YAML
>>> dependency isn't necessary.
>>>
>>> Another option is INI and use configparser, c.f.
>>> https://docs.python.org/3/library/configparser.html
>>>
>>> It seems that INI supports the ':' as key-value delimiter as well as
>>> multiline strings (but not the way we used it for YAML!), so it could b=
e
>>> a drop-in replacement. We could even simply write to the file with
>>> configparser.write() (though that will drop the in-file comments).
>>=20
>> If we directly write the ini file with configparser.write(), maybe we ca=
n just
>> maintain the list of variable as Python instead, instead of a separate "=
.in"
>> file?
>>=20
>
> The benefit of having a .in file is that it's explicit what the user can=
=20
> use in the docs (if we have yocto-vars.py! which we don't (yet?) in=20
> BitBake).
>
> What's the usecase for DOCCONF_VERSION BTW? We only use it for setting=20
> the current version (always "dev") but we never override it? Either in=20
> release branches, in the autobuilder, only from set_versions.py do we=20
> read it and override it. But then it's nowhere to be found in the docs=20
> either so we don't use. Do we actually need this for BitBake?

We use it in doc/conf.py:

current_version =3D 'dev'

with open("bitbake.yaml") as data:
    buff =3D data.read()
    subst_vars =3D yaml.safe_load(buff)
    current_version =3D subst_vars["DOCCONF_VERSION"]

So basically we just need a way to pass this information from set_versions.=
py to
the sphinx-build command.

> We could push this even further if we wanted to and have a bitbake.py=20
> instead? In some internal Sphinx project, we provide a skeleton with=20
> options to provide (Python) variables through another file we then includ=
e:
>
> exec(open('variables.py').read())
>
> is what we use. This would support f-strings (can easily reference a=20
> variable from another one), multiline strings, etc. No need to parse=20
> anything, it just needs to be valid Python variable assignment.

So basically, you'd write a variables.py file from set_versions.py and read=
 it
from conf.py?

I'm starting to wonder if it just wouldn't be better do move all of this lo=
gic
into doc/conf.py, actually.

Thanks,
Antonin

