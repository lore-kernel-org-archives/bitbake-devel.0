Return-Path: <raj.khem@gmail.com>
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
	[209.85.214.182])
	by mail.openembedded.org (Postfix) with ESMTP id 0ABBE7FAAD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 17:26:40 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id s10so5120310plp.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:date:in-reply-to:references:organization
	:user-agent:mime-version:content-transfer-encoding;
	bh=f66NcovRgY03Rjty9dLGTOd8ml1eTe4krEz6sS+x7bk=;
	b=sN0i65rRTsfZBc5mPIp/q8QmVSFfTAEeM7CeJ42qvlB+uSffdo5oLyWDo4LnJtM4wF
	VEdvBOAYpLavKSZlZlucp8zOPx5E69kzQPJ3dCgpIIoiLjoVu9PBPlBvGNyBYB9RJBsn
	msNEDcX76Nwd6g2e02PoaHuXJHsmT9i+CazNYeKRqQGnafz22jD0PyGKo0joXAhKUQzh
	MCmRtefhHvvRY7cifb5TLF/aE/6qxJMMSasToz/am92HVAn88FF1xnlL7msnHtYWQsk7
	AX8jgzKe33eAJ8odPTfEpLg+wkFA3SIpNe1UkR+5TkDoPYbroYunsu2UFBAf+rJCaTHb
	kHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:organization:user-agent:mime-version
	:content-transfer-encoding;
	bh=f66NcovRgY03Rjty9dLGTOd8ml1eTe4krEz6sS+x7bk=;
	b=dR1xGs8YLUx8bYcEhmlaWjI1nL9Y0XXnbkn7l0t6Sn4U2mHUdveftG4bZDz4mmQZFb
	EvVzacAgNuh3Rm7jBBKGKDuqwFXP5fOHUzSL0QGysnyuSfU1oEeB+JSEOIi0MplrbqXw
	EC0fxpAwXRlilVQdjAGkfXtmtqvH/K+HuBO9qjXPl9d1KL7jz16tiJSotoPd0SUlwkFy
	7dRtskV4w6hxNe1DfqQJf32kvdaUJIjZQ07VnsI5koklsqsUAa0QQVpaRib5oPwNmVk4
	7djOxUwICt4iXisDgFV7k3dmJTTFvS1vnq0qsSIetV6FSaFrT73V4zvnapybASOy26IS
	gDig==
X-Gm-Message-State: APjAAAWE/DS5/qEhKaHyLn2hwCnsMuUyc5jlr9kSMit7dL0K5J4TuprH
	xGSiT2ifWyLfYdFsJtJX10s=
X-Google-Smtp-Source: APXvYqy6DO189zB3wvwN31ENK5xCMRvwf4p1xQcsILrTtDsTUmW6wYJXBqqYxR13hH4rWMMWsmDuog==
X-Received: by 2002:a17:90b:d88:: with SMTP id
	bg8mr21286473pjb.78.1573838801746; 
	Fri, 15 Nov 2019 09:26:41 -0800 (PST)
Received: from apollo ([2601:646:8500:1c20::30e8])
	by smtp.gmail.com with ESMTPSA id u7sm9297299pjx.19.2019.11.15.09.26.40
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 15 Nov 2019 09:26:41 -0800 (PST)
Message-ID: <c2c0fb65a917506fb514588feffd8710be7c1fac.camel@gmail.com>
From: Khem Raj <raj.khem@gmail.com>
To: Christopher Larson <kergoth@gmail.com>, 
	bitbake-devel@lists.openembedded.org, Paul Barker <paul@betafive.co.uk>
Date: Fri, 15 Nov 2019 09:26:35 -0800
In-Reply-To: <22367b6d-6c98-41fe-b795-4618af17cd6c@Spark>
References: <5d3e68e3-5c06-43f5-8a28-b19834b7b7c5@www.fastmail.com>
	<22367b6d-6c98-41fe-b795-4618af17cd6c@Spark>
Organization: HIMVIS LLC
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
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
X-List-Received-Date: Fri, 15 Nov 2019 17:26:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2019-11-15 at 09:21 -0700, Christopher Larson wrote:
> That’s definitely a bug, incorrect usage of `is`.
> On Nov 15, 2019, 6:06 AM -0700, Paul Barker <paul@betafive.co.uk>,
> wrote:
> > I'm using Arch on one of my dev machines and recent upgrades have
> > brought in Python 3.8.0.
> > 
> > When running bitbake (latest master,
> > 33197db8abf82be240d7c1c5c9d2484a08a90849) I'm seeing the following
> > warnings. This only happens on the first invocation as __pycache__
> > is used after this.
> > 
> > /.../bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is"
> > with a literal. Did you mean "=="?
> > if command is 'mkview':
> > /.../bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is"
> > with a literal. Did you mean "=="?
> > elif command is 'rmview':
> > /.../bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is"
> > with a literal. Did you mean "=="?
> > elif command is 'setcs':
> > 
> > I've never used the clearcase fetcher and have no way of testing
> > this myself so I don't want to dive into it. May be worth someone
> > who is using this taking a look at it though.
> > 

Yes, this was latent, either a patch or bug will be good to have

> > Thanks,
> > 
> > --
> > Paul Barker
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel


