Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB253CE7A94
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 10:30:10 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.57716.1695637810172109948
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 03:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZBhJmFuv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-32167a4adaaso5819928f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695637808; x=1696242608; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5OAyCqsCiWVp5DeCej4Sdys/5kjL5tEVth5BcQBQ6M=;
        b=ZBhJmFuvC/is8/wkkZv+r6cmDdNiEkAXeoYYbvHkLDlkZ5dczOMEp7Jf//RsngBCUv
         grLhX/1zG4QmT1McaRQx1gCFj6mhkE/MKpkUl2eNjIFr1EVVpn6wwj+hAOqxjzaQABk9
         Qmc4DM85cgQAn/ZBuJjDH4gzXSbJTYg1+RJPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695637808; x=1696242608;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5OAyCqsCiWVp5DeCej4Sdys/5kjL5tEVth5BcQBQ6M=;
        b=nndbNSOmBd1dOXUOlJaDGVBUlCr6wGPnSq0lsJ5zjGaxusm8b38VM+aYPrIYTOYPGb
         2Gl4gtRQddb5r7DL+e2PI+j9Tq6HEe0qMKTNe9J7pE5DNlgRqqVABWDM2g5fBL+L4tPk
         TCn97ACqcTnTiOf6pwy4xHzysqtnkhAz03M8LkSZ0R7GY84LRN5kqm8clMmuT3qU978B
         JK9T1ohlsTsmzXc40JI51JTN4MkOjB4D8+1vwfG0bFjb3pKmJwzqE5NxUjgcy8/i6qZe
         ivkL0xInTHg4xcfZPY8McO6gev3ZzkvZU5coNIYxKXi42+YlVjBU36jpyY8YDn8VY0Ff
         Ks4w==
X-Gm-Message-State: AOJu0YzlW1yPgG5v3yh+qWGNpmeZ89YhOTn9KU3ZXpOaegqv8BbNHDsX
	kMFj055R6ii7qE0QFLD+IpTkUA==
X-Google-Smtp-Source: AGHT+IGFfSj58EVinSTicJkW2Md6g4ebs3Dgf8DHOAhjHU7397/Dw41QoBzffoVCdyW6N3CKWqXjcg==
X-Received: by 2002:a5d:5389:0:b0:31f:6524:2de1 with SMTP id d9-20020a5d5389000000b0031f65242de1mr5735962wrv.32.1695637808344;
        Mon, 25 Sep 2023 03:30:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dc0c:9197:530a:4339? ([2001:8b0:aba:5f3c:dc0c:9197:530a:4339])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4642000000b00317e77106dbsm11467073wrs.48.2023.09.25.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:30:07 -0700 (PDT)
Message-ID: <35b58142c73b9b22f960a87876f260d10c30b57c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Sep 2023 11:30:07 +0100
In-Reply-To: <DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230925032246.1316597-1-pkj@axis.com>
	 <2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
	 <DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 10:30:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15116

On Mon, 2023-09-25 at 10:16 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Sent: den 25 september 2023 11:22
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-devel@lis=
ts.openembedded.org
> > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anyt=
hing with --value and undefined variable
> >=20
> > On Mon, 2023-09-25 at 05:22 +0200, Peter Kjellerstedt wrote:
> > > Rather than outputting the string "None" when an unknown variable is
> > > used together with --value, output nothing. This is consistent with t=
he
> > > no --value case where only a comment stating that the variable is not
> > > known is output.
> > >=20
> > > This also means it is now possible to differentiate between an undefi=
ned
> > > variable and an empty variable since the empty variable will be outpu=
t
> > > as a linefeed.
> > >=20
> > > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > > ---
> > > =C2=A0bitbake/bin/bitbake-getvar | 7 +++++--
> > > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
> > > index 4a9eb4f311..806bbd8e4e 100755
> > > --- a/bitbake/bin/bitbake-getvar
> > > +++ b/bitbake/bin/bitbake-getvar
> > > @@ -43,9 +43,12 @@ if __name__ =3D=3D "__main__":
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0tinfoil.prepare(quiet=3D2, config_only=3DTrue)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0d =3D tinfoil.config_data
> > > +        value =3D None
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if args.flag:
> > > -            print(str(d.getVarFlag(args.variable, args.flag, expand=
=3D(not args.unexpand))))
> > > +            value =3D d.getVarFlag(args.variable, args.flag, expand=
=3D(not args.unexpand))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0elif args.value=
:
> > > -            print(str(d.getVar(args.variable, expand=3D(not args.une=
xpand))))
> > > +            value =3D d.getVar(args.variable, expand=3D(not args.une=
xpand))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0bb.data.emit_var(args.variable, d=3Dd, all=3DTrue)
> > > +        if value is not None:
> > > +            print(str(value))
> >=20
> > Whilst I can see where you're going with this, I'm worried users will
> > be confused by it.
>=20
> Too be honest, I expect them to be much more confused if they get the
> string "None" back when asking for the value of a variable, which=20
> happens to not be defined.
>=20
> >=20
> > getVar within bitbake returns None for things which do not exist. Not
> > many users will notice the difference between linefeed output and no
> > linefeed. It might be better to do something more obvious like an error
> > exit code but that also has challenges. Variables not existing when the
> > user expects them to is something we need to make really clear.
> >=20
> > It was issues like this which stopped us implementing bitbake-getvar
> > for a lot of years too :/.
> >=20
> > Cheers,
> >=20
> > Richard
>=20
> My goal here was not really to be able to determine if the variable is=
=20
> defined or not

I know, but that is an important detail and whilst it may not matter to
you, it does matter a lot.

> , but to not get the string "None" back as a result of=20
> asking for an undefined variable, because that is really problematic=20
> when `bitbake-getvar --value` is used from a script or similar.

I do agree on that. I just don't agree we should hide "undefined" as
we're replacing one bad problem with equally bad one.

>  This=20
> is because there is no way to determine (from the value) whether the=20
> variable is undefined, or if it is defined and has the actual value=20
> "None".

FWIW I'm not aware of any variable having "None" as a valid value.

> My assumption is that for most people the difference will not matter and=
=20
> the reason for that is that since if you use `bitbake-getvar --value` in=
=20
> a script or similar, you typically strip the linefeed that is output afte=
r=20
> the variable so you get the actual value, and then there is no difference=
=20
> in the result whether there was a linefeed (if the variable was defined,=
=20
> but empty) or there was no linefeed (if the variable was not defined). In=
=20
> both cases the result will be an empty string.

This is a problem as users likely should care if the variable is not
set at all, it suggests bigger problems.

Cheers,

Richard

