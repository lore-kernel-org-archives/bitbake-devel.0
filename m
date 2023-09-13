Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B6EEB59A
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 06:36:02 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.5807.1694586959021276557
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 23:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@pianon.eu header.s=mail20151219 header.b=pJnVoutS;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 832CD5C0096;
	Wed, 13 Sep 2023 08:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1694586955; x=1696401356; bh=vN
	qYaFhu1hEDYoLsf4RV1vbTgdQLG38cn4fezkPpS4U=; b=pJnVoutSCCy3ctXSjq
	OfD41Qyo6H9p4tOrRFckrkj7JMGj+RZI+YeI8JXTosCafpgFxEspzII0+WvD0cwE
	paamht6Z+ztVkc7yTF9HLVO698DCpwpcHMq7H8ZIQIiAEFf3wtND83wS+djAQjJW
	BewiyiRemxuMDHqSr4+KiwpuI=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y47OWknsej4U; Wed, 13 Sep 2023 08:35:55 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 7E05A5C0095;
	Wed, 13 Sep 2023 08:35:55 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 13 Sep 2023 08:35:55 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Bitbake Devel
 <bitbake-devel@lists.openembedded.org>, Carlo Piana <carlo@piana.eu>
Subject: Re: [bitbake-devel] initial idea for hooks needed for source tracing
In-Reply-To: <CAJdd5Gbuc-ivs0LRTTefAoxp4QxLU7r4W3pD74sM+d73VBbpDA@mail.gmail.com>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
 <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
 <9924500659de9ef4cf2b0c6e127fa27a@pianon.eu>
 <CAJdd5Gbuc-ivs0LRTTefAoxp4QxLU7r4W3pD74sM+d73VBbpDA@mail.gmail.com>
Message-ID: <44a71328fd7d39160747cb0e88beec1d@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 06:36:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15041



--=20
Avv. Alberto Pianon
Contr=C3=A0 Pedemuro San Biagio 45
36100 Vicenza (Italy)
Tel +39 0444 1836651
Fax +39 0444 546505
alberto@pianon.eu

On 2023-09-13 00:01, Joshua Watt wrote:
> On Tue, Sep 12, 2023 at 3:26=E2=80=AFPM Alberto Pianon <alberto@pianon.=
eu>=20
> wrote:
>>=20
>> On 2023-09-12 23:05, Joshua Watt wrote:
>> > On Tue, Sep 12, 2023 at 2:55=E2=80=AFPM Alberto Pianon <alberto@pian=
on.eu>
>> > wrote:
>> >>
>> >> Hi Richard,
>> >>
>> >> as I said at today's meeting there is no hurry, but right after the
>> >> meeting I had an idea and I wanted to fix it in my mind and test it
>> >> before losing it :)
>> >>
>> >> It's just a temporary/WIP patch, but it should not be too far from =
a
>> >> working implementation of the hooks we were talking about:
>> >>
>> >> http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/s=
rctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
>> >>
>> >> There is no interference nor modification to the unpack process any
>> >> more, just collection of needed metadata through the urldata object=
.
>> >> Modifications to the core unpack function are minimal and (I hope!)
>> >> straightforward, and there is no fetcher-specific logic in it ant
>> >> more.
>> >>
>> >> When you find some time, could you please have a look and tell me i=
f
>> >> this may be the right direction?
>> >
>> > I think this is much better; there's still a few rough edges
>> > (`function.__name__ =3D=3D "unpack_submodules"` is kinda gross :),
>>=20
>>=20
>> I know :) but I couldn't figure out something better off the top of my
>> head...
>>=20
>> The thing is that "function" is passed to process_submodules:
>> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.=
py?h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n=
43
>>=20
>> and it's executed for each submodule:
>> http://cgit.openembedded.org/bitbake-contrib/tree/lib/bb/fetch2/gitsm.=
py?h=3Dalpianon/srctrace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8#n=
152
>>=20
>> I want to collect some metadata only when that "function" is
>> "unpack_submodules" and not some other function.
>>=20
>> May you suggest a better way to do it? Maybe with inspect?
>>=20
>>=20
>> > but this is much simpler and I think easier to understand.
>>=20
>> Thanks!
>>=20
>> > Also, I feel
>> > like this is actually reasonably testable; presumably there would be
>> > some mechanism to "plug" a different Trace class in instead of the
>> > pre-canned one, and tests could be written that use a special test
>> > implementation of that class to verify that it is being called
>> > correctly. This also means your special source tracing classes can
>> > live elsewhere instead of needing to be integrated into bitbake
>> > immediately
>>=20
>> Yes, that was the idea. Maybe a variable where to store the module to
>> load, like SRCTRACE_PYMODULE =3D "mybb.fetch2.trace"?
>> And something like SRCTRACE_PYTEST =3D "mybb.tests.trace" for
>> bitbake-selftest?
>=20
> Ya (assuming you meant SRCTRACE_PYMODULE in both places). You might
> even be able to combine the ENABLE and PYMODULE (or maybe CLASS?) into
> the same function. If the variable is empty do nothing, otherwise load
> the class. I'm pretty sure we've done that elsewhere in the
> codebase.... see siggen.py in bitbake where it loads a module using
> import_module. IDK if you'll run into trouble with the import path
> doing that or not.
>=20

Do you mean something like SRCTRACE_PYCLASS =3D "mybb.trace.TraceUnpack" =
?

And IIUC the test module should be a separately set anyway, like in
SRCTRACE_PYTESTMODULE =3D "mybb.tests.trace_unpack"... or am I missing
something?

In any case I've seen the example in siggen.py and I will try to use
it, thanks

