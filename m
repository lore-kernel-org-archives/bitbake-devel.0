Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF9DCE7A9D
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 16:18:03 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.65221.1695658676285993490
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 09:17:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WYizMwNh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso71513645e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695658674; x=1696263474; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WirMZ/jhknGI7G6srvM1jBBw2SkzKab7xxvvgLWyl3g=;
        b=WYizMwNh6+78Ho892m5wR8ArKpz2I3gPy1WmtePyxb/eDQwEo/KZY+vuZ9YsE2gSBW
         42gM2SqwVTtOG7v2768/22r5D1Y2OH1UjMaqWL+bOhiGp8zsznsZ7rTPMFAMrkWrqYKq
         A1m626/X9PoywTs9PMACOD6Q9BNEODlMUhDlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658674; x=1696263474;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WirMZ/jhknGI7G6srvM1jBBw2SkzKab7xxvvgLWyl3g=;
        b=eZHpK5rLedVQuWEq0CSeZnklCrAJdMK56wUiKvXhDpUy7QQiv/Gb66FKNBr7f2/gwY
         G3B++3hna0YWOdu5MaP0hsSjdwslenPzOfg3GtolVETw46K0Zp5TGU6Wef01Tz61I2dc
         sS+ud79B4zIsBwbTaQ7bN0JZZ6f0ek9i/ibBatBprzU6Rm154+DS9kmwjJmpISTPBrWk
         9Cr5Pfk7V8D0esOGT6Hr2oT3QAiQsunV9iDBogmZOL6dwvBfv0N7pDldDtwLdyuHQr59
         JnQC5CF7ZoU+DS94bNZaAfURuAhnHDBX0NCq2a/t3utWaYZVea0iHlkgkB//FnJTVMN6
         /oWw==
X-Gm-Message-State: AOJu0YxO/Fa8/oqldKK5tbjJ++tXXOhJ7aniccpjj6Vmq7pW6VteS3Zq
	AVgS9raXiRIw3i1r26s63f2W0w==
X-Google-Smtp-Source: AGHT+IHmIHccZdgRYqciddnLWLaKsn/ygX4PWOKDJAd4axLycWTZx/5Vcwr/RslxYXOwYEdlfFgquw==
X-Received: by 2002:a5d:4bc1:0:b0:315:9e1b:4ea6 with SMTP id l1-20020a5d4bc1000000b003159e1b4ea6mr7040676wrt.58.1695658674422;
        Mon, 25 Sep 2023 09:17:54 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dc0c:9197:530a:4339? ([2001:8b0:aba:5f3c:dc0c:9197:530a:4339])
        by smtp.gmail.com with ESMTPSA id r2-20020adfe682000000b0031ff89af0e4sm12206321wrm.99.2023.09.25.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:17:54 -0700 (PDT)
Message-ID: <4e46959768ee5e6cc6f72a42fa566db267dd5d38.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Sep 2023 17:17:53 +0100
In-Reply-To: <DB5PR02MB1021356A2A4354ED39DB5CD96EFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230925032246.1316597-1-pkj@axis.com>
	 <2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
	 <DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <35b58142c73b9b22f960a87876f260d10c30b57c.camel@linuxfoundation.org>
	 <DB5PR02MB1021381B9F45F71019B89C8FAEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <659f37fdb542e410ab6ed039d6cadb2403024350.camel@linuxfoundation.org>
	 <DB5PR02MB1021356A2A4354ED39DB5CD96EFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 16:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15121

On Mon, 2023-09-25 at 16:00 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Sent: den 25 september 2023 16:07
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-
> > devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output
> > anything with --value and undefined variable
> >=20
> > On Mon, 2023-09-25 at 13:55 +0000, Peter Kjellerstedt wrote:
> > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > > On Mon, 2023-09-25 at 10:16 +0000, Peter Kjellerstedt wrote:
> > > > > > -----Original Message-----
> > > > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > > > > Sent: den 25 september 2023 11:22
> > > > > > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>;
> > > > > > bitbake-devel@lists.openembedded.org
> > > > > > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not
> > > > > > output anything with --value and undefined variable
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > My goal here was not really to be able to determine if the
> > > > > variable is
> > > > > defined or not
> > > >=20
> > > > I know, but that is an important detail and whilst it may not
> > > > matter to
> > > > you, it does matter a lot.
> > >=20
> > > Well, as I see it, with my change it _is_ now possible to make
> > > the
> > > distinction if you really care, where before you could only
> > > assume
> > > that a returned value of "None" actually meant that the variable
> > > is
> > > not defined.
> >=20
> > As things currently stand it is clear something went wrong through
> > the
> > process you yourself mentioned as how noticed. Once your proposed
> > change merges, it becomes very unclear what is happening.
>=20
> The documentation (i.e., `bitbake-getvar -h`) for --value states=20
> "Only report the value, no history and no variable name". When I=20
> read that, I instinctly assume that it will not output anything if=20
> I ask for a variable that does not exist, not that it will output=20
> something that looks like a valid value (i.e., "None"), but isn't.=20

Please stop trying to convince me the current behaviour is wrong. I've
said multiple times, I agree. What I don't agree with is how you're
fixing it.

> I would be fine with an error message to stderr, but then I would=20
> assume the same result if bitbake-getvar is called without --value=20
> for an undefined variable.

I agree with that.

>  I would also prefer if it is possible to silence the error for the
> case where you do not care if the variable is undefined.

I only agree with this if the user specifically asks for that behaviour
as I think it is a perfect way to end up with obscure bugs otherwise.

> Whether bitbake-getvar should actually fail with an error in case=20
> the variable does not exist is more debatable. I can see use cases=20
> both ways.

I can see the use case both ways but I think the user has to
specifically ask for undefined to result in "".

> > I'm not disagreeing that it needs to be fixed somehow we agree on
> > that
> > and I've already said as much. What we disagree on is how to fix
> > it. I
> > disagree on this way of addressing it.
>=20
> Based on my comments above, here is my suggestion:=20
>=20
> When an undefined variable is requested, give an error message, e.g.:
>=20
> $ bitbake-getvar UNDEFINED_VAR
> The variable 'UNDEFINED_VAR' is not defined! [on stderr]
>=20
> and set the exit code to 1. And the same result with --value:
>=20
> $ bitbake-getvar --value UNDEFINED_VAR
> The variable 'UNDEFINED_VAR' is not defined! [on stderr]

That seems reasonable to me, without the "!" though.

> If -s or --no-messages (borrowed from `grep`) is also specified, then
> no error message is output and the exit code is 0.

I'd suggest only a long option --ignore-undefined. That way when you
see it in a shell script, you know exactly what risk is being taken.

Cheers,

Richard

