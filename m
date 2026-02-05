Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A1EC1EA5
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 11:35:00 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18583.1770291298735584755
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 03:35:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YqV4+S1R;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CD9E71A2C1B
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 11:34:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A46F2606FD;
	Thu,  5 Feb 2026 11:34:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08EBB119A8891;
	Thu,  5 Feb 2026 12:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770291296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fCX/+3TIIEnxBQFv/LVgzNv+mRgkP34GOlT2Gen4BII=;
	b=YqV4+S1RkKI4juWUvxBtLVfQ7DzflIvMdX0ZQdgKxQZYCKoy3uDbnrfv2XOvSdvREH3KYG
	v3OR4U0xqdtIft85iFjdNr2JV1B6rfhzFKyC4goqsyBkgTrBXOTNBzE6GcM+IHYeQBCgI0
	1ysKKxLaWcbjy+l0yvc3ISFOvqblN1DQCrTSUGfS1YU4zbrOngDD0QwZ2tvEhLhB5uaYOT
	N2kCY2llvSSOGwER8Cck34tEyqfTvGA0ZRu1pG3yANCkzfYEI25L2scEteZaFQDGVBqCZN
	cP7zrffa94oO3FTUfKKkatTL0hyzF68ItTgsjSW1NOSvY+Ykh6ifufu/NC1aMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 12:34:54 +0100
Message-Id: <DG6ZW1HMRGQY.2QNTJC8SOYOCP@bootlin.com>
Subject: Re: [docs] [PATCH v2] doc: fix the switchers menu
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <quentin.schulz@cherry.de>, <bitbake-devel@lists.openembedded.org>
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
 <f9a1db09-bf8d-4f29-b2a7-567f97ce0532@cherry.de>
In-Reply-To: <f9a1db09-bf8d-4f29-b2a7-567f97ce0532@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 11:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18965

Hi,

On Wed Feb 4, 2026 at 4:01 PM CET, Quentin Schulz via lists.yoctoproject.or=
g wrote:
[...]
>> diff --git a/doc/set_versions.py b/doc/set_versions.py
>> new file mode 100755
>> index 00000000000..63fba2fe948
>> --- /dev/null
>> +++ b/doc/set_versions.py
>> @@ -0,0 +1,155 @@
>> +#!/usr/bin/env python3
>> +#
>> +# This is a minimal version of the set_versions.py from yocto-docs,
>> +# use to replace VERSIONS_PLACEHOLDER in switchers.js.in by a list defi=
ned below
>> +# with BITBAKE_ACTIVE_RELEASES in the environment.
>> +#
>
> Where?

A leftover from the previous version, thanks.

[...]
>> +with open("sphinx-static/switchers.js.in", "r") as r, \
>> +     open("sphinx-static/switchers.js", "w") as w:
>> +    lines =3D r.readlines()
>> +    for line in lines:
>> +        if "VERSIONS_PLACEHOLDER" in line:
>> +            if ourversion !=3D "dev":
>> +                w.write(f"    'dev': 'Unstable (dev)',\n")
>> +            for series in activereleases:
>> +                w.write(f"    '{series}': '{series} ({yocto_mapping[ser=
ies]})',\n")
>
> Why is this different from yp-docs? We don't handle showing the current=
=20
> series (ourseries)/version (ourversion) if it's outdated anymore?

We do, but from switchers.js, where in build_version_select we push the cur=
rent
version of the document last:

    buf.push(
      '<option value=3D"' +
        current_version +
        '" selected=3D"selected">' +
        current_title +
        "</option>",
    );

So the version from our branch gets displayed.

(trust me, I've had a hard time locating and understanding how all of this
worked :))

However, you made me realize that due to our branch the abbrev hash, it wou=
ld
always appear as outdated. I fixed that for v2.

> To answer Richard on the other thread, we use YAML because JSON doesn't=
=20
> allow comments. Also, because we used to want multiline variables (see=20
> https://yaml-multiline.info/) which aren't supported in JSON, but those=
=20
> are gone since 8d993022c2ae ("docs: use literalinclude for system=20
> requirements"). Not sure we can get rid of it for yp-docs as we only=20
> override *some* variables in this file by set_versions.py so the=20
> autobuilder won't replace poky.yaml.in, and the YAML is consumed by=20
> sphinx/yocto-vars.py.
>
> If we don't plan on having comments in this file *ever*, then the YAML=20
> dependency isn't necessary.
>
> Another option is INI and use configparser, c.f.=20
> https://docs.python.org/3/library/configparser.html
>
> It seems that INI supports the ':' as key-value delimiter as well as=20
> multiline strings (but not the way we used it for YAML!), so it could be=
=20
> a drop-in replacement. We could even simply write to the file with=20
> configparser.write() (though that will drop the in-file comments).

If we directly write the ini file with configparser.write(), maybe we can j=
ust
maintain the list of variable as Python instead, instead of a separate ".in=
"
file?

Antonin

