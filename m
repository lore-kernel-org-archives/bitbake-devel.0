Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A8EE3F36
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 21:26:46 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web10.2468.1694554004104035731
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 14:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@pianon.eu header.s=mail20151219 header.b=b2N1eF3m;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 1D59B5C0096;
	Tue, 12 Sep 2023 23:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1694554001; x=1696368402; bh=FY
	DbffxYe6mPHB7qPNEij11CO0wGzzbtWnNJBRy+sRc=; b=b2N1eF3mnJ+aert40r
	7guHjlleGOVL6AQSAAf8mHWxuj7FKhpToUIMY4lY3FB7GAzQItfiRghrC3mANA24
	QzBauyQZ63Ikj/Q5c1802cW0lReEL2Kg/qsyVl/xt4vca9rVEJF0OhXDUcljqrht
	a575I0KprS9ZHLdgXISGFKGA4=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZMJ1Cx_ePEkl; Tue, 12 Sep 2023 23:26:41 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 693725C0095;
	Tue, 12 Sep 2023 23:26:41 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 12 Sep 2023 23:26:41 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Bitbake Devel
 <bitbake-devel@lists.openembedded.org>, Carlo Piana <carlo@piana.eu>
Subject: Re: [bitbake-devel] initial idea for hooks needed for source tracing
In-Reply-To: <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
 <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
Message-ID: <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 21:26:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15035

On 2023-09-12 23:05, Joshua Watt wrote:
> On Tue, Sep 12, 2023 at 2:55=E2=80=AFPM Alberto Pianon <alberto@pianon.=
eu>=20
> wrote:
>>=20
>> Hi Richard,
>>=20
>> as I said at today's meeting there is no hurry, but right after the
>> meeting I had an idea and I wanted to fix it in my mind and test it
>> before losing it :)
>>=20
>> It's just a temporary/WIP patch, but it should not be too far from a
>> working implementation of the hooks we were talking about:
>>=20
>> http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/srct=
race4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
>>=20
>> There is no interference nor modification to the unpack process any
>> more, just collection of needed metadata through the urldata object.
>> Modifications to the core unpack function are minimal and (I hope!)
>> straightforward, and there is no fetcher-specific logic in it ant=20
>> more.
>>=20
>> When you find some time, could you please have a look and tell me if
>> this may be the right direction?
>=20
> I think this is much better; there's still a few rough edges
> (`function.__name__ =3D=3D "unpack_submodules"` is kinda gross :),


I know :) but I couldn't figure out something better off the top of my=20
head...

The thing is that "function" is passed to process_submodules:
http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.py?=
h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n43

and it's executed for each submodule:
http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.py?=
h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n152

I want to collect some metadata only when that "function" is=20
"unpack_submodules" and not some other function.

May you suggest a better way to do it? Maybe with inspect?


> but this is much simpler and I think easier to understand.

Thanks!

> Also, I feel
> like this is actually reasonably testable; presumably there would be
> some mechanism to "plug" a different Trace class in instead of the
> pre-canned one, and tests could be written that use a special test
> implementation of that class to verify that it is being called
> correctly. This also means your special source tracing classes can
> live elsewhere instead of needing to be integrated into bitbake
> immediately

Yes, that was the idea. Maybe a variable where to store the module to=20
load, like SRCTRACE_PYMODULE =3D "mybb.fetch2.trace"?
And something like SRCTRACE_PYTEST =3D "mybb.tests.trace" for=20
bitbake-selftest?


