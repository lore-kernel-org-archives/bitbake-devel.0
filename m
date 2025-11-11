Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A0CCFA1E
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:13:48 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18299.1762870424786224385
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 06:13:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=af2wHg5w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso1838143f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762870423; x=1763475223; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Gcd1kzhpCz2f7xz1lHkyrM0yZ7V/YgqL/6qoTUJMBk=;
        b=af2wHg5waAiSBhQO32mKZAsi6whbL+L2lgGKQfhDRH69xUYvImohQejQ9sF+5FDhGT
         JApEQHIKyR264mcyHizt2aDqwp5BAy7Jt8DqutEM13MGomLAezW9GPNGVH/LN+Z2Uhsw
         F2d+JRJO+07z8WI15fOZSN0HiFNLLuS5joaUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870423; x=1763475223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gcd1kzhpCz2f7xz1lHkyrM0yZ7V/YgqL/6qoTUJMBk=;
        b=dDs1AC4CZejbNKrK005SKNMhtnZWGc+kRbtZxhutXHE3hemqpLlM5bYX25oLjJ9TiU
         +bZsK5TEaceqIFy+ZyegFMYJ+GXfhHprLTnbX5iaooy8LYsQ8i4wgRJ4qeroIRB1aoa0
         JkvzfWckr7KXOj58tLSZtfcolVQ+pGg75fnYlhCRlCiZWyHBTnog6H3rUJoFRe5v6u7j
         TDqJmPNu/3skxBsyT/rSMKxOoj5dpkuY3e1fkjxFBGaIjHqzHWXGt1mo9GDdLYCtUnBZ
         zi3C9zA9riCbCx9PvCL243PlqVUusAM7zuLEy99yRBeU8JNvpdB2LkfvqTdG51U7B+iF
         bVbw==
X-Forwarded-Encrypted: i=1; AJvYcCViAaitIMVBTCHV3/GwE9TIGCsCjcU2R/s7eElElZVXyGRzcOdLImn+x9/+HhaxHP23ObcxKquETmTfGSxy@lists.openembedded.org
X-Gm-Message-State: AOJu0YzzT2MqlXQS+d/wLCMhfFiuegy5/enlJwWLNez0eaNjGBPRwdCq
	L8Ps9Vzm6S0I6cu5Ek1wdhUh9Xer2xUD3qRL8dVatUGIhEE9ja/EAx9ZclBwucs5I3I=
X-Gm-Gg: ASbGncvR7+dL9El4mu3kdLk6cflvV+/oboE+6qFB3S1LPk0pZkYnYErHw2bgmgOW6GW
	qJy3OK9XmBGwD8nyABouQi+DuGQnhTDrEqKYAUnOCmXbC3jcCVvv7IwkpaDdZkJpuDTdCrlWMLa
	EsLvCYqWKT31J8dLAZRvjgXyb721wvWrS5P3C6H8E0drvOgS/Ebwk6IAg9MAX0aw6fvCYWGisWG
	C3SWutOS1K+U8L4ATXxje9hwSHQaZdkbof8FpeMIIgcJ0+0hoPO3zpSR6atEZgcITqfbnasFcLQ
	m7QFuI0IwClY0Suwf2WuEpgfryysSQqCqcW0SM846bUGjSWLqjFkdVFWVCWJfuR6w9RzjNzqEUk
	IR6Qrxqfa9Sta4VHhskatoM0UWRwYH5XphazzyRFqogE7ejnMSUe19Ph6FJ2wLk578A+z2j+Oqh
	O2Y/bJSOSzlrkbPTiZOhWcmRUvL170sE92E6FYyNTnHIBkhN2ybXEWQNIJ9WsHu/0Jkeo6W0zpL
	is=
X-Google-Smtp-Source: AGHT+IHyhxC1BGlYQZ9PkdvmY/Cb/IVnYz0shYMYNPZzWKRUCB8f2AtS9RMwox0IDd1ANBTQqLAYdw==
X-Received: by 2002:a05:6000:144e:b0:42b:3bfc:d5b4 with SMTP id ffacd0b85a97d-42b3bfcddd2mr6036803f8f.51.1762870423146;
        Tue, 11 Nov 2025 06:13:43 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e5b4:de25:c1b8:e4ca? ([2001:8b0:aba:5f3c:e5b4:de25:c1b8:e4ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca86sm28593364f8f.31.2025.11.11.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:13:42 -0800 (PST)
Message-ID: <22c4237afbfe24235beb3a537e84b79042bfd23a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] YP 5.3 Release readiness - not there yet
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>, openembedded-core
	 <openembedded-core@lists.openembedded.org>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Nov 2025 14:13:41 +0000
In-Reply-To: <CAO5Uq5SnV4d1ygktpOqkvXk6iCcjhJ9Wh97iM9av8qXK2C048g@mail.gmail.com>
References: 
	<29595a8ed6b004a981a82b14abf8e60592b14777.camel@linuxfoundation.org>
	 <CAO5Uq5SnV4d1ygktpOqkvXk6iCcjhJ9Wh97iM9av8qXK2C048g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 14:13:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18322

On Tue, 2025-11-11 at 13:44 +0000, Alex Kiernan wrote:
> On Tue, Nov 11, 2025 at 12:07=E2=80=AFPM Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >=20
> > Having gone through trying to use bitbake-setup again, I'm sad to say
> > that this isn't ready yet.
> >=20
> > The basic structure is there and is good but it has significant rough
> > edges that cause usability problems and putting this in front of new or
> > existing users is going to do the project reputation harm.
> >=20
> > I don't mind rough edges, but not when they're at the level they're
> > currently at.
> >=20
> > I appreciate saying this instantly puts the pressure on me to say
> > why/where it has issues and how to fix them. I will try and provide
> > some thoughts on that but I am pretty burnt out at this point and not
> > at my best. It is frustrating that I'm the one having to say this and
> > that in saying it, I just make things worse for myself but it is what
> > needs to be done.
> >=20
> > I had hoped more eyes, working through the docs and so on would let us
> > get through this but as yet, that hasn't happened. I don't think we can
> > release until we're in a better state.
>=20
> I started swapping over local builds to bitbake-setup this week, for a
> basic qemu core-image-base it was impressively straightforward.
>=20
> But I've immediately run into things where I know how to do them in
> the old world, but not the right way to do them in the new[1] and
> failing to find answers in the docs, which isn't to say the answers
> aren't there, I've just not found them.
>=20
> If there's things I could usefully help with documenting/testing, I've
> got time on my hands as my current contract is on hold...
>=20
> [1] how do I add a layer which hasn't been migrated to bitbake-setup
> was the first I hit

Firstly, lets drop the discussions after this reply to the bitbake-
devel list, I don't think we need all three.

The best place to start would be to write down the pain points you're
finding. I think we all need to write down our findings, see if they
are the same things or different ones.

Once we have that data, a plan/direction might become clearer.

Cheers,

Richard


