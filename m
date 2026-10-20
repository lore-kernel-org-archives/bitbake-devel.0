Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6604.1792500414142979936
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Oct 2026 05:46:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DFBFzqBo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dc202a60eso885757f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792500412; x=1793105212; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Lws4BsJjR9iq5zC+WpWQK5fBOkCBWKvu93PBOeo8wn4=;
        b=DFBFzqBo60QY2Oy9NE7uMXtB1xXHUYW9WoId4pHg55b3Wk90XilElpkcDG+nKsz4DE
         MWjuqGQaAIMHcKngc0hEYQAjo04ytSynQncyzDctocGmnYQbUHJqCowwKXqavyh57cAn
         zmI2zw2A7xfAzHjkOLl/tHEuo2mn9nEMgG5Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500412; x=1793105212;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lws4BsJjR9iq5zC+WpWQK5fBOkCBWKvu93PBOeo8wn4=;
        b=t1too1yFHIzOAAOV/NOeHOYub6jUuoUgAf529YluT2yYqmfH3u3/oOSQMGCQMqP4eF
         Z1Ho3jo3Y/ZXPQtN4QObQZ4lR8TPbwQv757K90ZNyPtFOfpAdLQdRbeLVwvYHggokW9o
         gwmb878C3xESff1E5qnlJ34TQpr+cfZMz7IsssS2cncUiQXKTzzUFfC9qeXqsYynPZOB
         cOrhegKGrBCPzI+rg+9VE4BxWE2jRDiLhR6IetdgsFoFDuteyQiC4tzHQrC7Rkz80HDL
         5G6rIZNct2d1IPi8+NEN/bPTQP9nqWJoQdCuq8qY4cOAFxmrceFk+BC5iJn+C96TWwk1
         9oZA==
X-Forwarded-Encrypted: i=1; AKwUvBwzA4vwQ52ZQR0dbmYp/QblGjya5vbVKbNfk8OcQ3AaFG5T08jjjxY2V2R4ANkTqQvh/1tVVPIWBjnIhG2D@lists.openembedded.org
X-Gm-Message-State: AFq9FYKZrKDUCBR/sj9M6LvHdkDeeUrhV65nEaLvIUgK4V5jkl7Gss3Q
	Lj4SSnul25+5PF5qVWhksoCpsTFEUkZRxo1TMLE67p4BMVg1D0ZT5aAlJXpgbGIySLQ=
X-Gm-Gg: AYBFou3ENn5R1BSuf5w2VXqJeRqdUC3ewe424Myf17SGiZVQVlTJnE4AaYJfllzEfuu
	ETSy+D2a+9j6ZaXLKRnRpwwp96BFh/NNKvqlOcLMEsJEwCPQUIgCYemv8G+nDBT7dEuXRQS8M9Q
	qCIqBXY0/0yxJ8WGn1ljypuLrj9sTonHdkQB1KXz8YD7OJ0sca2Rt4Gc0svH4svu15NQJasWNMx
	z3I+ReNgjQfVol9hHEdWEM2lfjTvu9b7c0Pg79bzV38w2Pj4/Q4Qqrp3Pa1yft7zxuNOeLwZ8f3
	1348toe5weP8dlRwNS0gMoyVNj1T9ClwAa2ng112Hk8R9p9COGL3+RHpH6+8WijXymSkJ4aDZuk
	AeaPMy0G9/vFQKUQCjcuNva1RdxRR2Q6X/Zir9S3hXbEC/WIbakS7Fqlqqe0QnAC3UrRL5aAgMN
	BvijVBJ1rIDB3E88+9pHaUZWP8GmL7Z8CAOwFy4IWY5KRkNB1YAp+lzcbxwo80qfuuoQNGPEaWt
	Rmr5YOJ+IzHQH/rpXcHmvwSOBbalfoukCCWnpfxfFc6Ew0H59RUEklrdGOHeog=
X-Received: by 2002:a05:6000:2dc8:b0:48d:f1b3:c02e with SMTP id ffacd0b85a97d-48e07bbcf38mr22990595f8f.25.1792500412045;
        Tue, 20 Oct 2026 05:46:52 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e? ([2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e3csm4783961f8f.53.2026.10.20.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:46:49 -0700 (PDT)
Message-ID: <6b783ac19db5de9ef469f4a4c5908376635ac8d1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: only search each BBPATH
 directory once in include_all
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ross Burton <Ross.Burton@arm.com>
Cc: "ticotimo@gmail.com" <ticotimo@gmail.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 20 Oct 2026 13:46:48 +0100
In-Reply-To: <96915A49-AFB6-4CAD-8EEE-4A87612340E3@arm.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
	 <6C7FAEF1-2BE9-4E2C-B2DF-A037491D00D0@arm.com>
	 <7f00a969c9ef34a77342ca8909def148aceeb652.camel@linuxfoundation.org>
	 <96915A49-AFB6-4CAD-8EEE-4A87612340E3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 12:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20365

On Tue, 2026-10-20 at 12:33 +0000, Ross Burton wrote:
> On 20 Oct 2026, at 13:30, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > > Feels like using a set() instead of dict.fromkeys() would be
> > > neater.
> >=20
> > Ordering matters here=E2=80=A6
>=20
> Hm I thought sets have the same ordering behaviour as dictionary
> keys, but whilst they do in practise at the moment, this is not
> documented as behaviour.

They don't even in practise, I've seen sets not remember order at
all...

Cheers,

Richard
