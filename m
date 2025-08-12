Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9A9C87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 09:29:23 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.70378.1754990956711848717
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 02:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SnEV8sP8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so3127710f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754990955; x=1755595755; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TwPBw9UF4jaI2Lktl1LCp9eBIJ9j6z4842Lluni3VPs=;
        b=SnEV8sP8hJzt41aqbj9mQ435ieeS705AwQBNvLKym9jEL13rVF7FvgyRx1DpONJbv0
         qPyCrWu9fdD/ElBbO/UNgGyb9nzmntJfXggukkTOQVcn0Efgw8iTZKbBDxxAI9i4Dvda
         55DhK31WgSQtYRQDlPvA3CyfyOenYAvIev+hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990955; x=1755595755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwPBw9UF4jaI2Lktl1LCp9eBIJ9j6z4842Lluni3VPs=;
        b=G9sIFBkukrznB0XyAacHHPQBnsQParDU1yFF0a2bm+XL77z4TK7CEv/sLhI5HaZDJg
         VrUxt9T+FSPcVB4ooFhxj5Z17MV/3iUeGfMwhWCcEwG3d0vTEby3RtMyAFrifGirG/TC
         SI/TvG/phrTaQPIdA+L6FhbmoKNyWu/wlPn+bfwxB0vmIY82brVndlqR1aSnSYiQzjwt
         gvF9jh3EC+6lK9+dwxr9wYvS+fI3R/jPaLP/mjbdr8bo88tlvIyjvUZDKiKYUhDZpf0L
         mWklbDyJVjx+3LAo2FqUqopHW0Npkrnn/T8MGBgHK0z9U3xk8kfK646oJ2Czeh/jNGgz
         RvRQ==
X-Gm-Message-State: AOJu0Yx27RQIjPhN68OArM6LYTq3swVx4cDRwgbtSeSaFv2P8tyqm+Ny
	EZaxKdEQ9dg0uE4UharVURJX2uR5+RigQ8oNL/poM0R9G6bdApvHIhqfn8ivUGrmaIs=
X-Gm-Gg: ASbGncspM+FyURr0yeb5evUug0cHpXvDYeISwwVCW3D5TQv76OwpzImHZvmNRXoWojI
	OuGUB7DH1OTgO+r7PKcSQ1T+aHgklHsomWZscnrfFW2fjRp8zUZmac0PhYtjgBHSKozxkona2nK
	m7sTk2j30dLYJl1cEuov2atzv71ujiyRfBHhpoizBhfF0qSq0uya0cz15070/VtqliyeCS9vK4L
	pKlBQW0RPKe6Z2/6PDaeZtQMjaUxvW9whs/IurFLrT7ZtILkalxktcgGkcA4K9YyS05oEIiYh4f
	VBY0W4605bcQM8J/q1fFeh7JsoudOuAabdkcdVhfOVjNmkuG+troXeW+nyH1dmfKKKtpZsEWHNY
	HT5xq+/29rrf3s5IQNUe2Vo0j6TZsuBWlZLhj8VOKZ3tTuKoIizKXh7Gb6K5vmFBBfFihHixcjO
	RJcVJRGvCIlbI=
X-Google-Smtp-Source: AGHT+IH2kxIdbhJj2qfV6MkshrMpxmgomd7PhAhLk5GE17ND7eMTZ33cSrtG5wkYuR8L9c0YT/Rs+A==
X-Received: by 2002:a05:6000:310d:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3b911007a82mr2417202f8f.28.1754990955028;
        Tue, 12 Aug 2025 02:29:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:89f2:883f:9153:ef6b? ([2001:8b0:aba:5f3c:89f2:883f:9153:ef6b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583f9fcsm283029335e9.4.2025.08.12.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:29:14 -0700 (PDT)
Message-ID: <7783e54b446045c53f0583ffbf5275bea6a4b88e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chuck@wolber.net, JPEWhacker@gmail.com, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Aug 2025 10:29:13 +0100
In-Reply-To: <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net>
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
	 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
	 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
	 <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 09:29:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17869

On Sat, 2025-08-09 at 12:59 -0700, Chuck Wolber via lists.openembedded.org =
wrote:
> On Tue Jul 29, 2025 at 7:59 AM PDT, Joshua Watt via lists.openembedded.or=
g
> wrote:
> > On Tue, Jul 29, 2025 at 8:57=E2=80=AFAM Alexander Kanavin <alex.kanavin=
@gmail.com>
> > wrote:
> >=20
> > > On Tue, 29 Jul 2025 at 16:49, Joshua Watt via lists.openembedded.org
> > > <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> > > >=20
> > > > Our setup is that we have a "disto" layer that we need to maintain =
against
> > > > several version of Yocto at once. In this disto layer, we make poli=
cy
> > > > choices that sometimes are tied to a specific version of a recipe f=
ound in
> > > > a specific version of Yocto using a bbappend; and often that versio=
n is
> > > > only in one or two Yocto versions, which means that the bbappend wi=
ll be
> > > > dangling in the others.
> > >=20
> > > This is where the weak point of the argument is. Yocto does not make
> > > concessions to layers that attempt to be compatible across yocto rele=
ases,
> > > patches that help such layers had been previously rejected, and this =
would
> > > create a precedent to the contrary.
>=20
> Yes, but perhaps some consideration is merited? This is a perennial probl=
em for
> OEMs with long lived products.
>=20
>=20
> > > It's always possible to make a branch.
>=20
> While this is logically correct, it is also an unreasonable response.
>=20
> The argument is being made with sincerity, clarity, and consistency. I th=
ink it
> there is a lot to be gained by taking more time to understand it.
>=20
>=20
> > Branching isn't an option for us; we are unwilling to add the maintenan=
ce
> > overhead of dealing with that.
>=20
> You are not alone in this respect. Perhaps we need to find a better way t=
o
> explain this to the YP community? I believe adequate consideration of the
> problem will improve more than just the plight of OEMs with long lived
> products.

We took a decision to drop dangling bbappend support. We did that for
very specific reasons after discussion at the time. It wasn't a
universally popular decision but the issues that they caused and the=20
improvements dropping them allowed seemed attractive. The decision was
made and acted upon.

Now, we're being asked to effectively reverse that decision (with a
slightly different implementation we could have switched to at the time
but chose not to).

It is clear that the usecase this is being asked for is not something
we've officially supported, ever, and that has been really clear.

The precedent here is problematic if I do take this, since whether we
officially say so or not, we're effectively unofficially supporting
that use case.

We have two YP platinum members saying "we really want this".
Ironically we also have the wider YP membership telling me to say "no"
more often and more forcefully.

To me, this isn't an issue of discussing the pros/cons as personally,
I'm well aware of the trade offs on both sides of this.

Rather than the technical merits, the main concern for me is that I do
want to encourage project adoption and use and to push back against
this will hurt that and also potentially hurt some of our key
developers standing within their companies. As such, I don't feel like
I may have a lot of choice but to take this, but perhaps not for the
reasons people expect.

Cheers,

Richard

