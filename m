Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 31FAC79DC0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 19:59:51 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z5so20748422wrt.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2018 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=Qq908MUNgoryb+v8xCjYI46AbVfGXutwW/R5qUdCNXU=;
	b=A+kX7juGaM7eGS4xlQXRrVYxgtb3ytTR7wAWhA1apqgaIrS4Sa0IWnjFXccVGkf+b+
	FD1Sh7NPwlPSBsribN+jk02yDZJwTAzUu5n+WkX7EQf09aKJtPmqpSYs1EO6WYnRLhoX
	OycUymwYnkC0QF5PcwnEbnbW9dsdAaCGjMcNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=Qq908MUNgoryb+v8xCjYI46AbVfGXutwW/R5qUdCNXU=;
	b=P7YNs2/rQ3aQG9hS5dFxVNiZW5NDerG7H6L4ni/g2VEyolFrrF6fk5kFnb1BX8wks2
	DpAaMjqSeVOVfSvZ1jFaBRkg+tiOKjkacjGKhpqE8Me7SwH63SsSfzRgzqlMkw6BVq9E
	srKRsGFXzj8WOiy+B730wgkKgUkD2sOsVGuYkMKCS4kMlTTc82oN4zZhCnaK1jJHyWLo
	hrb4CeIuS5WEP2P7ZSPp95SJA13pHKXn9wUET7xupTKi6gTh+s6/RZkT6GjQrVpRHDdA
	PmhtINa0kYyc/Dizd2urlB9Htct0ahhrWLS/zxjazuvP61PdG+Lg4+5tJJTuYReggZ3d
	dZEg==
X-Gm-Message-State: AA+aEWZoUZBykHxQp0nqD9YiWZQ3/u9UfYxq7gfFvCvRwl2p3IIQeP4Q
	Eb9DJebQHz1LS5YOzVPPjQLbmg==
X-Google-Smtp-Source: AFSGD/VXElXBzRlKKCQ79m/Ug1yxJYW5BIcs3NFwdjdB+JoaaXumH1l6Gf1OJ+7CwpjN+Un1eJKh9g==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr21006396wrq.133.1545249591839; 
	Wed, 19 Dec 2018 11:59:51 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	i186sm7605189wmd.19.2018.12.19.11.59.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 19 Dec 2018 11:59:50 -0800 (PST)
Message-ID: <8a70e9bcda4fa6eb89252f59595ca529baed0be5.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 19 Dec 2018 19:59:49 +0000
In-Reply-To: <e1b2cb22e101463f8afa8a4fe084f869@XBOX04.axis.com>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
	<20181214140219.1553-2-richard.purdie@linuxfoundation.org>
	<ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
	<eae945fea01f12c8abd559b4988ae34f9e2fe405.camel@linuxfoundation.org>
	<0963d345ec074cbfac6a7e79ccbb0a9e@XBOX04.axis.com>
	<ab481f529628568941f4790a2cad883ac00b6384.camel@linuxfoundation.org>
	<e1b2cb22e101463f8afa8a4fe084f869@XBOX04.axis.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] data_smart: Allow numeric characters in	overrides
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Dec 2018 19:59:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-12-19 at 16:12 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: richard.purdie@linuxfoundation.org
> > <richard.purdie@linuxfoundation.org>
> > Sent: den 19 december 2018 12:42
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-
> > devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [PATCH 2/3] data_smart: Allow numeric
> > characters in overrides
> > 
> > On Wed, 2018-12-19 at 10:55 +0000, Peter Kjellerstedt wrote:
> > > I don't understand the commit message either. It says that there
> > > are
> > > problems with x86-64 because it contains digits, but x86 (which
> > > the
> > > commit message says works) contains digits too, so that cannot
> > > really
> > > be the case. If it is actually the dash in x86-64 that is
> > > supposedly
> > > a cause of problems, then islower() ignores both digits and non-
> > > alpha
> > > characters like the dash so that cannot really be a reason to
> > > change
> > > the code either. All in all I'm confused by this commit and what
> > > it
> > > is trying to solve...
> > 
> > Consider this output from python:
> > 
> > > > > "64".islower()
> > False
> > > > > "x64".islower()
> > True
> > > > > "x64A".islower()
> > False
> > 
> > The problem is that "64".islower() returns False when we need True
> > (overrides get split by '_' so x86_64 turns into "x86" and "64" in
> > the
> > code in question).
> > 
> > Cheers,
> > 
> > Richard
> 
> Ok, that makes more sense, except for one thing: where/when is _x86_64 
> used as override(s)? The only related overrides I can find in OE-Core 
> all use _x86-64, which matches ${TRANSLATED_TARGET_ARCH} for, e.g., 
> qemux86-64.

Its not obvious as its indirect:

conf/distro/include/maintainers.inc:RECIPE_MAINTAINER_pn-gcc-cross-${TARGET_ARCH} = "Khem Raj <raj.khem@gmail.com>"

That worked for MACHINE=qemux86 but not for MACHINE=qemux86-64.

Arguably you could rename that to use TRANSLATED_TARGET_ARCH but I seem
to remember there were others which would have been harder to rename
out of.

We should add some testcases to bitbake-selftest for this.

Cheers,

Richard


