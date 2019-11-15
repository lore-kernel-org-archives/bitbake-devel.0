Return-Path: <raj.khem@gmail.com>
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
	[209.85.219.68])
	by mail.openembedded.org (Postfix) with ESMTP id C42EE7FACA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 18:10:02 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id s18so4128788qvr.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=yOMvScsqzUpX6JsI3HNmDcn6c0J8jTJPksUDph5V0DY=;
	b=WiW2Z6AYqTVra3bt4Thfl+E1y07P3fRkmGxJ3uAemMFat0M4qPyn6QiEwX4o3AwbHw
	DGNtxYYnXXO833tcPbWAB0KhSCxAMBMDrXN8vPiQ5hrr4UeAg5LCRB/shgaA7BPPeFIl
	9mPO9hR5xJHMWXlDDaxygW5jS2jqPyDIokjkl26z7YaL3/H8Klga6vf9Np5jG0TVA4XV
	5VZET7hCiHnevKENCbH02SlLpLySwXJIhHxKMjR4C4nUEk8/7pTUf9sVW2rxnxThct2d
	Z0V9VilrnAsF+3iwVJjmmVE//dqBRuXbjXEgF1t0FQkQ5Q5oDqb+2/TDYb3IlS92sosi
	9SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=yOMvScsqzUpX6JsI3HNmDcn6c0J8jTJPksUDph5V0DY=;
	b=aWMeUq9h26dvFSqokwdD6lGDBSBNUNGy0IX+HLMkkqr06yB9Gv8zbBXMEPJ0ni8jGi
	PUi1OW/qGGD5nSOBPSQbBBaPx4HHzo6kjlocB16SdNZr+kSXpAAwW+D45DhY/75hX3Rt
	vS9ksANqFkmzYHfvEn2C6XqyBzaH/XknzlyjirGH09zj3QjnMVhApn8ihRk79T/nWh6M
	3WkDskbb0aapH9kVC2todFMN2qU6C8zbFdv9Q4PhYWrEvbQSy+ErHwbMBzuv0n+uq016
	47Yc1rQNs8yfxJ/3xP89jCWIxJJElAkd2bSpw1tPxHR71hvSqUqaSjhP3MA3yPDTkFWH
	y0Pg==
X-Gm-Message-State: APjAAAXZQxOUW9rMacUCma2yyWevuRI/veBL+s4IjnSs/wT6BvArfq83
	TmzbXbwjlkUsOR+8PT3cY4L8JaCf3bn4k1zaZAM=
X-Google-Smtp-Source: APXvYqwrGkCMPwxWy0elUqom174sCNtF2gEIr09Yu2oAQEK4FzX/BPKLPorqHRGY5mM7gAwPEQb+1XW2n/ZpiZZ2XIc=
X-Received: by 2002:a05:6214:901:: with SMTP id
	dj1mr729902qvb.99.1573841403348; 
	Fri, 15 Nov 2019 10:10:03 -0800 (PST)
MIME-Version: 1.0
References: <5d3e68e3-5c06-43f5-8a28-b19834b7b7c5@www.fastmail.com>
	<22367b6d-6c98-41fe-b795-4618af17cd6c@Spark>
	<c2c0fb65a917506fb514588feffd8710be7c1fac.camel@gmail.com>
	<bc4e01ad343f942699462c9a65c9833404f0614f.camel@linuxfoundation.org>
In-Reply-To: <bc4e01ad343f942699462c9a65c9833404f0614f.camel@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 15 Nov 2019 10:09:36 -0800
Message-ID: <CAMKF1sr9iCorB7+YRgL3z2v2PokcQFoZyNRe53F868=MRs=zwg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Warnings when starting bitbake with Python 3.8.0
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
X-List-Received-Date: Fri, 15 Nov 2019 18:10:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 10:08 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Fri, 2019-11-15 at 09:26 -0800, Khem Raj wrote:
> > On Fri, 2019-11-15 at 09:21 -0700, Christopher Larson wrote:
> > > That=E2=80=99s definitely a bug, incorrect usage of `is`.
> > > On Nov 15, 2019, 6:06 AM -0700, Paul Barker <paul@betafive.co.uk>,
> > > wrote:
> > > > I'm using Arch on one of my dev machines and recent upgrades have
> > > > brought in Python 3.8.0.
> > > >
> > > > When running bitbake (latest master,
> > > > 33197db8abf82be240d7c1c5c9d2484a08a90849) I'm seeing the
> > > > following
> > > > warnings. This only happens on the first invocation as
> > > > __pycache__
> > > > is used after this.
> > > >
> > > > /.../bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is"
> > > > with a literal. Did you mean "=3D=3D"?
> > > > if command is 'mkview':
> > > > /.../bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is"
> > > > with a literal. Did you mean "=3D=3D"?
> > > > elif command is 'rmview':
> > > > /.../bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is"
> > > > with a literal. Did you mean "=3D=3D"?
> > > > elif command is 'setcs':
> > > >
> > > > I've never used the clearcase fetcher and have no way of testing
> > > > this myself so I don't want to dive into it. May be worth someone
> > > > who is using this taking a look at it though.
> > > >
> >
> > Yes, this was latent, either a patch or bug will be good to have
>
> Rather than see more emails and bugs on this I sent a patch...
>

superb. Arch users will send positive vibes to you :)

> Cheers,
>
> Richard
>

