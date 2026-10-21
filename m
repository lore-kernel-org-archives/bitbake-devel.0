Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.306.1792593763065686299
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Oct 2026 07:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iV/BSBC8;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B7BB9C5CD74;
	Wed, 21 Oct 2026 14:43:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1045606E3;
	Wed, 21 Oct 2026 14:42:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62703103289F5;
	Wed, 21 Oct 2026 16:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792593760; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TPayXeUZLe/VfYgpgLo8mRmHmCfTVFaBkjYaHtb235E=;
	b=iV/BSBC8Fhcf5RIVQcxqm4tBLqfWD/v1YmPvL+loaH5sWN7vdal+Zoc39FT7PoCyd3l8et
	rqTJOijoCPhYp87EanzPGjMDANFYsYUGIvYNJAhjQBDqLwfUFu0qVkyAK94xnr30E3DIYz
	q9gcf0AQNRd+wrUNpn+nde3rdS1FMo+UwKq4epFO56Lxedlac76GxhdFqDFMH7jSQsiCLh
	0hZqNYEunpXWz5p+3MnqzSBWwrchqqdCiQTNZuvoNahDKQ4XJRfl9dMWaTzqOB64UpvXeF
	a4gzlMhFYUz42/yh/CGiRaH6fqAv1DemVyjcJ89E0As17c986NqPJ9Gv7ZMLSA==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:42:38 +0200
Message-Id: <DMALGC6JACT5.1W26Q9VEIAV9K@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <michalwsieron@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
 <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
 <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
 <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org>
 <DM5GYBADXEX9.2UOTTZAL4JTT2@bootlin.com>
 <2040945.1792137545176168291@lists.openembedded.org>
 <DM6ADVADR7L1.F48JUYUSVTMF@bootlin.com>
 <3cb5e5d5db79f81b58c943752dcff67e7c603308.camel@linuxfoundation.org>
In-Reply-To: <3cb5e5d5db79f81b58c943752dcff67e7c603308.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 21 Oct 2026 14:42:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20366

On Sat Oct 17, 2026 at 5:02 PM CEST, Richard Purdie wrote:
> On Fri, 2026-10-16 at 15:11 +0200, Antonin Godard via lists.openembedded.=
org wrote:
>> Hi,
>>=20
>> On Fri Oct 16, 2026 at 9:59 AM CEST, Michal Sieron via lists.openembedde=
d.org wrote:
>> > Hi,
>> >=20
>> > two cents from my side. I think that warnings as errors would ideally =
work like normal -Werror in compilers.
>> >=20
>> > 1. Regarding name: -W doesn't indicate anything about errors. Only som=
ething
>> > =C2=A0=C2=A0 with warnings. I am not sure if having this short option =
is worth it.
>>=20
>> I agree.
>>=20
>> > 2. This might be controversial, but ability to do -Wno-error, would be=
 great.
>> > =C2=A0=C2=A0 Problem is we don't have categorized/named warnings/error=
s. But I think
>> > =C2=A0=C2=A0 that it could support a syntax where we use file name (or=
 partial match on
>> > =C2=A0=C2=A0 its path) and disable warnings-as-errors for that source =
file. Or this
>> > =C2=A0=C2=A0 might be even easier to implement: regex for warning mess=
age. It it
>> > =C2=A0=C2=A0 matches, it won't be treated as an error.
>>=20
>> That sounds like an interesting idea - but maybe as a follow-up of this =
though?
>>=20
>> > 3. Exit code only change won't force developers to immediately fix the=
ir code
>> > =C2=A0=C2=A0 as it's really easy to ignore in interactive terminals. S=
ure, later CI
>> > =C2=A0=C2=A0 would catch it, but I would prefer early fail if possible=
.
>>=20
>> That's true - however, I checked again, and error messages originating f=
rom
>> bb.error (or bberror) do NOT stop the execution of bitbake. This is the =
role of
>> bb.fatal (or bbfatal). bb.error only affects the return code of bitbake,=
 but
>> goes as far as possible - for example I was able to build an image recip=
e even
>> though one of its recipes emitted a bb.error.
>>=20
>> So if we want warnings to act like errors, I think this is already what =
this
>> series does. If we want warnings/errors to act like bb.fatal, that's ano=
ther
>> question.
>
> I should also mention that ERROR_QA and WARN_QA allow many warnings to
> actually become errors. That is the mechanism we should really be
> pointing people at if they want errors IMO...

Sure, but this couldn't possibly cover all warnings?

Maybe I can reword the intent of this series: give users an easy way of kno=
wing
when one or more warnings were emitted so that they look at them instead of
ignoring them.

Whether we should stop bitbake immediately on a warning or not seems to be
another question as per my previous email.

From your answers, I'm not really sure of whether you approve or deny of th=
is
idea though. Should I send a v2 with a long option only (--fail-on-warnings=
),
and keep the rest as-is?

Antonin
