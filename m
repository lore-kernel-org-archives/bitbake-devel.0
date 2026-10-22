Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22264.1792673476989876038
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Oct 2026 05:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Vfe63ZbO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1163623f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792673475; x=1793278275; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HuQGWn0mfZmA9fAJ4cKo+KfH8cWBSQbXKAa4/5CHSOk=;
        b=Vfe63ZbO6qiYg9pQdHHPzbzoIXQomG4uH7ANyj0SgV05z2ZTXHneYASTgYU09FsacE
         QENqCRQUAdRW041pFuJafkzntt83hjkzw7i8H+MUNN/fUwXxYbS3rQSLiWX3b8hDHQZl
         BmdWSkouPjorwnswxYcPCxUDP5PfTDs3i/ywc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673475; x=1793278275;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuQGWn0mfZmA9fAJ4cKo+KfH8cWBSQbXKAa4/5CHSOk=;
        b=eDt9mnYEwzIWLuOCACyqTt024EWaEKnNoI8eu/DLvlqUd4NnQ3vslc6I6t0V8xKuD8
         J4atqJkNS6Qcj29nY1FLYtkqwkQ93BhmuxujQdSbzvAKY/wVtF8lsyHIpK0VQ8nW9XTg
         CXbKpq0lUsAkaQukJwk+kfRibC9qXgAaCO3eU+hQdhAC80pQWDqdcrgQK8131MRAwVSS
         2dc4brcd58n6Edu8YvKz7b3jOSeuRzifPT7BDNNFd35sE/1+w29oA9zYp5057KXC6PqS
         VBru0hv9QvhAlEfbleigjyA0+JWRJyL5trBGt1mdEpulvxnDTSR6mWsJ/mQ7zjvQ3k+o
         Qwvw==
X-Forwarded-Encrypted: i=1; AKwUvBynuY/qW1+51EAzmyqixMLxAqwsqXPoP7f+SpgHvTfEcGpC4DueLQLttKi+8LWbhMmSlKCDevjknZ5VAqVc@lists.openembedded.org
X-Gm-Message-State: AFq9FYI/2pqgvaVEhF7HTV5CtgZ9EnlI5l3qTSFgEmPTn1a5nHT2LsGu
	d75ZNqkj3SwL6exfAioVMJovKr0XJV5NhzJiKrAHiXiDhpv1+o0ECcMd0F/iVRnLFg4=
X-Gm-Gg: AYBFou2BqFcwIor5qBf1gTq6Whs/3ImPhgAZe8VamsIB0KP+e3tZzfYk4P8DPIzFE8Y
	wO8U9j1+OzQU3NW73XWxnd2qn5LUn2YFkRv0I910KJeBL84M1HzrZTT0NwGF48lPVd7ztLfawSv
	1nbjCPjgRLL1i5QaLmZHfP+ZE51sJsPXawh2c4IGSJPB6GYMc2Eq455Gu+d2GKg5R+6dgJcrCmh
	tAlfHUQxL9DIRM5zX4vyR7vx9irDrt29ejP+P639iJnjYw4DJvd3SSxapBv05rUJPR7NS+5m5JV
	KncvSuaH2Fux6HZ4mV4YGpFmWLprqFJTFunySUkqDDz7tgt9MSmGBWb/5PMm77tLvWRxK+4kFZH
	+YnJXZTl7b5PHoNHR+7gko8+TeJkvk6lVWTexneBt/patDoLHVDrLrjae5jLQTax5HHFysC1iJg
	KWLLVZzYdkyuwVlW2FtzImQrQ9Q0v7xmhyg6OEj52W2xiHwFgsALa0gxz7l6NwBLWRdciSkHU+8
	B1/f8OFYfXTQCQBNgd6GsTXRCUu/yUrGT0HPqiOm6UIkrQqsXWj7V4uEB00922NuQSNSeh0vvCm
	HS3Ulq0c00KLw38k5fJ9wN+f8iqKdGDpkr5873MfNwv6
X-Received: by 2002:a05:600c:4684:b0:4a1:d36f:1ba0 with SMTP id 5b1f17b1804b1-4a1fdd74b6cmr106682835e9.35.1792673474902;
        Thu, 22 Oct 2026 05:51:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:b8c1:c201:8aca:1e39? ([2001:8b0:aba:5f3c:b8c1:c201:8aca:1e39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b28f70sm76207245e9.4.2026.10.22.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:51:14 -0700 (PDT)
Message-ID: <17ce52d0adcf9e8150aaff046301082c43bcae09.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, michalwsieron@gmail.com, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 22 Oct 2026 13:51:13 +0100
In-Reply-To: <DMALGC6JACT5.1W26Q9VEIAV9K@bootlin.com>
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
	 <DMALGC6JACT5.1W26Q9VEIAV9K@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 12:51:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20367

On Wed, 2026-10-21 at 16:42 +0200, Antonin Godard wrote:
> On Sat Oct 17, 2026 at 5:02 PM CEST, Richard Purdie wrote:
> > On Fri, 2026-10-16 at 15:11 +0200, Antonin Godard via lists.openembedde=
d.org wrote:
> > > Hi,
> > >=20
> > > On Fri Oct 16, 2026 at 9:59 AM CEST, Michal Sieron via lists.openembe=
dded.org wrote:
> > > > Hi,
> > > >=20
> > > > two cents from my side. I think that warnings as errors would ideal=
ly work like normal -Werror in compilers.
> > > >=20
> > > > 1. Regarding name: -W doesn't indicate anything about errors. Only =
something
> > > > =C2=A0=C2=A0 with warnings. I am not sure if having this short opti=
on is worth it.
> > >=20
> > > I agree.
> > >=20
> > > > 2. This might be controversial, but ability to do -Wno-error, would=
 be great.
> > > > =C2=A0=C2=A0 Problem is we don't have categorized/named warnings/er=
rors. But I think
> > > > =C2=A0=C2=A0 that it could support a syntax where we use file name =
(or partial match on
> > > > =C2=A0=C2=A0 its path) and disable warnings-as-errors for that sour=
ce file. Or this
> > > > =C2=A0=C2=A0 might be even easier to implement: regex for warning m=
essage. It it
> > > > =C2=A0=C2=A0 matches, it won't be treated as an error.
> > >=20
> > > That sounds like an interesting idea - but maybe as a follow-up of th=
is though?
> > >=20
> > > > 3. Exit code only change won't force developers to immediately fix =
their code
> > > > =C2=A0=C2=A0 as it's really easy to ignore in interactive terminals=
. Sure, later CI
> > > > =C2=A0=C2=A0 would catch it, but I would prefer early fail if possi=
ble.
> > >=20
> > > That's true - however, I checked again, and error messages originatin=
g from
> > > bb.error (or bberror) do NOT stop the execution of bitbake. This is t=
he role of
> > > bb.fatal (or bbfatal). bb.error only affects the return code of bitba=
ke, but
> > > goes as far as possible - for example I was able to build an image re=
cipe even
> > > though one of its recipes emitted a bb.error.
> > >=20
> > > So if we want warnings to act like errors, I think this is already wh=
at this
> > > series does. If we want warnings/errors to act like bb.fatal, that's =
another
> > > question.
> >=20
> > I should also mention that ERROR_QA and WARN_QA allow many warnings to
> > actually become errors. That is the mechanism we should really be
> > pointing people at if they want errors IMO...
>=20
> Sure, but this couldn't possibly cover all warnings?

No, it doesn't. People are often solving subtly different problems
though and those give a different set of controls.

> Maybe I can reword the intent of this series: give users an easy way of k=
nowing
> when one or more warnings were emitted so that they look at them instead =
of
> ignoring them.
>=20
> Whether we should stop bitbake immediately on a warning or not seems to b=
e
> another question as per my previous email.

Stopping immediately probably irritates users. We get into subtle
problems though as if you continue and let the task get marked as
success, the next build won't show the error. Even a clean build with
existing sstate can not show warnings which were shown the first time.

Including warnings in the sstate objects works to a point, for the
warnings on the sstate task specifically, but what if those warnings
come from an intermediate task like do_install? Those wouldn't get
captured anywhere even if we have sstate warnings :(.

> From your answers, I'm not really sure of whether you approve or deny of =
this
> idea though. Should I send a v2 with a long option only (--fail-on-warnin=
gs),
> and keep the rest as-is?

I'm torn.

If we do something, I do want the design to be consistent and for the
behaviour to be really clear. I'm therefore trying to show the
different corner cases I can think of. I don't have a good idea of what
the end result should look like, I do know it needs thought which I
don't really have the time to d justice myself :(.

If we don't do that, there will just be a stream of patches, each
subtly changing the behaviour to match what a given user wants at the
expense of others.

Cheers,

Richard
