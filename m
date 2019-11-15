Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 591467FB43
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 18:08:39 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id t26so11411359wmi.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=kopgteY7EzId+4lpPhycoX1w3NAoNs51DcgXFpVN4m0=;
	b=eiO2BjNJtcrrxKahynRO5y+6K1SnwxFQK9tDIEN9rUtcpZEah3hpDmawAB74cnn2pn
	4u8DSHsZxPmtzmTiRLQWZLxRXabxkrGhXoeTZ92T14vmbX7Mg5X1qHNw+RDFNhlYr73P
	+LYlvfGzDyUNSnzhse8t8gC4jLuOowSvpC07Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=kopgteY7EzId+4lpPhycoX1w3NAoNs51DcgXFpVN4m0=;
	b=fAxw4ZyrHW7Wp8MELfCpAI2GzIABBaDS2m6dRtY6NdprJ8idM60QC+zPb9x0e67URa
	Owqn0YG8rOG8MFp9dcslI48zkOaLMAwIggQmdCSjkziCh/+EOGZxjPbeLt3aukL/AhuU
	XdAniJ286VTjYtoXJBV2Rg9KD8qPykgqsHvoDZFRZoO0uPqPSFEbQHzMFTo0Gp3R4mPG
	VFvUUshZU9+hYZ26wCt8eBTD17z5vf9rWWjiJ9gNEClM2Pld45WvertVV0fMsIClXpXt
	mHyHAj0WFoxZkxe0gHYbFtMeGKKegfoowvWbFBEFzxZrITZJ51K/lSIPehJmshxHC/dR
	myQg==
X-Gm-Message-State: APjAAAUBYDVPSC5ebZeEe8TPLPIACHsHyhTCJnBiigK59iQw8xOdVVw7
	fWds/HTY1MH9TLyEC49WCesFVg==
X-Google-Smtp-Source: APXvYqwLsyaqPtAuC6Drp4ibfz+cJExJ9yaI+lCUDjhqhOeMmTeLdJ7MLWiL+sxUtR2tFngQaT14bA==
X-Received: by 2002:a05:600c:410:: with SMTP id
	q16mr15370004wmb.2.1573841319988; 
	Fri, 15 Nov 2019 10:08:39 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g5sm11215446wma.43.2019.11.15.10.08.38
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 15 Nov 2019 10:08:39 -0800 (PST)
Message-ID: <bc4e01ad343f942699462c9a65c9833404f0614f.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Khem Raj <raj.khem@gmail.com>, Christopher Larson <kergoth@gmail.com>, 
	bitbake-devel@lists.openembedded.org, Paul Barker <paul@betafive.co.uk>
Date: Fri, 15 Nov 2019 18:08:38 +0000
In-Reply-To: <c2c0fb65a917506fb514588feffd8710be7c1fac.camel@gmail.com>
References: <5d3e68e3-5c06-43f5-8a28-b19834b7b7c5@www.fastmail.com>
	<22367b6d-6c98-41fe-b795-4618af17cd6c@Spark>
	<c2c0fb65a917506fb514588feffd8710be7c1fac.camel@gmail.com>
User-Agent: Evolution 3.34.1-2 
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
X-List-Received-Date: Fri, 15 Nov 2019 18:08:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2019-11-15 at 09:26 -0800, Khem Raj wrote:
> On Fri, 2019-11-15 at 09:21 -0700, Christopher Larson wrote:
> > That’s definitely a bug, incorrect usage of `is`.
> > On Nov 15, 2019, 6:06 AM -0700, Paul Barker <paul@betafive.co.uk>,
> > wrote:
> > > I'm using Arch on one of my dev machines and recent upgrades have
> > > brought in Python 3.8.0.
> > > 
> > > When running bitbake (latest master,
> > > 33197db8abf82be240d7c1c5c9d2484a08a90849) I'm seeing the
> > > following
> > > warnings. This only happens on the first invocation as
> > > __pycache__
> > > is used after this.
> > > 
> > > /.../bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is"
> > > with a literal. Did you mean "=="?
> > > if command is 'mkview':
> > > /.../bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is"
> > > with a literal. Did you mean "=="?
> > > elif command is 'rmview':
> > > /.../bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is"
> > > with a literal. Did you mean "=="?
> > > elif command is 'setcs':
> > > 
> > > I've never used the clearcase fetcher and have no way of testing
> > > this myself so I don't want to dive into it. May be worth someone
> > > who is using this taking a look at it though.
> > > 
> 
> Yes, this was latent, either a patch or bug will be good to have

Rather than see more emails and bugs on this I sent a patch...

Cheers,

Richard


