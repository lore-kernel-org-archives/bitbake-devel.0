Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3874ACD1288
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 15:55:08 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web10.15107.1712159699452411399
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Apr 2024 08:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ux7EuDjz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.222.174, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789e2bf854dso395362885a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Apr 2024 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712159698; x=1712764498; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gA5yRgxUAWz8iNZMacBOX3ueyvRLQnyUJljGlir6T9U=;
        b=Ux7EuDjzuAnaD5bs4NMNkQ30zr5WnZeySvyBA918zUoh4KdAlnXaIfT8ciHZ0wDBbk
         1mrMcgmMHLg//b4KjyYVVpbh8hDVagDfck13VQ7rT43eEm80UEM4O9aTLP1YTOHOn6pn
         VsyZOSkhL6fOccKqUGpgEkI0S4SzsyORnKYK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159698; x=1712764498;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gA5yRgxUAWz8iNZMacBOX3ueyvRLQnyUJljGlir6T9U=;
        b=exx21KU5qgtjuaStzsPxMcgucYIzeC2jkNkGTm3SUnSlhmf9v8V3OKHmOwWf/NVp2b
         NGbT5qtrP16/q+1qwGR3zCB5DIztCXhV4g1pnMWgqBbmVnC4n1wSz7S2i+U92ofcpBNg
         9CNE13TQgtcdAp6Nf9RHud/IAMOU97MTbZBmRVYPXDD2BruPc2C5nYQEqb5R5xBn3Wnk
         znkY6i6zLlSPmEledNOaa2ONWMPZvHNqPQb2lOWGsH6Hr5zmgd770aXwJ9U0dkO863gD
         I+Aku+wSluuDAE0mGPfHiKRUjogTTPERwy3gN9DQY57TnMOLDFAb41UEmaDfjpFFa7We
         rTFQ==
X-Gm-Message-State: AOJu0Yw4lkSBtc/K+ayRfhipgNfGqXl0tUrADQzoH24+CosQUJjWKa29
	PuY3PPZ+YJZsziGe2wwk7Cbb4dtDD54seaFIrOSN/h01dybV0/SKFOXVYqit87g=
X-Google-Smtp-Source: AGHT+IHPPAj9/Hso9lRl4WWF2qZpT2wFKXuZIYzOqrTHgTe89s9+LI7O31uH7zWkqwYuilq/3dgJwQ==
X-Received: by 2002:a05:620a:d53:b0:789:f2fe:4ca1 with SMTP id o19-20020a05620a0d5300b00789f2fe4ca1mr15283170qkl.52.1712159698371;
        Wed, 03 Apr 2024 08:54:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:aa55:3838:e4c5:26f0? ([2001:8b0:aba:5f3c:aa55:3838:e4c5:26f0])
        by smtp.gmail.com with ESMTPSA id vq18-20020a05620a559200b0078be6590696sm2289383qkn.102.2024.04.03.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:54:58 -0700 (PDT)
Message-ID: <a7a67fe9f5cdd8818545d73c79950ea85e266665.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 00/12] prserv: add support for an
 "upstream" server
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 03 Apr 2024 16:54:56 +0100
In-Reply-To: <80bcd78e-7c42-4b10-b1b2-f04955059c2e@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
	 <c04991f85ccf2d28ef0e04ffbc18e5faf93f1e63.camel@linuxfoundation.org>
	 <80bcd78e-7c42-4b10-b1b2-f04955059c2e@bootlin.com>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Apr 2024 15:55:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16045

On Wed, 2024-04-03 at 17:33 +0200, Michael Opdenacker wrote:
> Hi Richard,
>=20
> Many thanks for the first review!
>=20
> On 4/3/24 at 17:09, Richard Purdie wrote:
> > On Fri, 2024-03-29 at 15:39 +0100, Michael Opdenacker via
> > lists.openembedded.org wrote:
> > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > >=20
> > > This makes it possible to customize an "upstream" distribution
> > > by modifying local packages. If the "upstream" package bears
> > > revision "x", the local one will have revision "x.y", this
> > > having priority over the upstream one.
> > >=20
> > > Take advantage of this work to clean-up and update the prserv code
> > > too.
> > >=20
> > > Michael Opdenacker (12):
> > > =C2=A0=C2=A0 prserv: simplify the PRServerClient() interface
> > > =C2=A0=C2=A0 prserv: use double quotes by default
> > > =C2=A0=C2=A0 bitbake-prserv: replace deprecated optparse by argparse
> > > =C2=A0=C2=A0 prserv: use self.logger instead of logger directly
> > > =C2=A0=C2=A0 asyncrpc: include parse_address from hashserv
> > > =C2=A0=C2=A0 prserv: capitalization and spacing improvements
> > > =C2=A0=C2=A0 prserv: fix read_only test
> > > =C2=A0=C2=A0 prserv: add extra requests
> > > =C2=A0=C2=A0 prserv: remove redundant exception handler
> > > =C2=A0=C2=A0 prserv: correct error message
> > > =C2=A0=C2=A0 prserv: remove unnecessary code
> > > =C2=A0=C2=A0 prserv: add "upstream" server support
> > Most of these series looks like cleanups to make prserv look more like
> > hashserv, which is fine.
> >=20
> > The piece I'm struggling to understand is what happens if we have three
> > prservs where A has B an upstream and B has C as an upstream. Does the
> > system cope with multiple levels of increment, x.y.z and so on?
>=20
>=20
> I haven't tested that yet, but wasn't sure we wanted to support such as=
=20
> multi-level scenario. If you confirm that's within the scope, I can try=
=20
> to make this work!

I believe we will need to support a potential hierarchy of these
servers in the same way hash equivalence can.

> > I'm a bit worried we're seeing floats in the results, which suggests
> > that generic x.y.z wouldn't work?
>=20
>=20
> I first tried to explicitly convert all the responses from the PR server=
=20
> to strings, but that didn't help. Could it be that a return value like=
=20
> '0.1' could be automatically interpreted as a float if it can be=20
> converted to one? There is no explicit conversion to float in the PR=20
> server code, so it seemed to me that the conversion was done automaticall=
y.

I suspect that it is SQL that is making these floats and you're just
passing the results around from there. The trouble is that whilst X+0.1
will work for x.y, it isn't going to work for x.y.z and beyond. That is
one reason I'm mentioning this now, at same time as we're seening
issues with the float() values.

> > Also, where do we stand on automated tests for this code?
>=20
>=20
> Not done yet. I was waiting for the reviews on the first series, but I=
=20
> understand that tests will be necessary :)

I would have a bit more confidence if there were some test cases
showing what was working!

Cheers,

Richard



