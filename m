Return-Path: <bunk@stusta.de>
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
	by mail.openembedded.org (Postfix) with ESMTP id 37259616BF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 05:49:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 48Qrk344plz4S;
	Mon, 24 Feb 2020 06:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1582523387;
	bh=WAJ62RLBF5xMLvXgVkZ8cFjg9LqNp1p8QUovqxpctAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqGwTXFX0pdGKAVTDtGW0z+gpcS/Zs2824sunebVuVFenMGKtTGYU419aOoOuKX9L
	oiNfjYQH/X3gSktQr1pzf1WOntYWGkenna23De4go/Kn9ugHmRAxXfkuilrl1cekLL
	DsUZapNLxop5rf9HAesvfp44SYajLrKYdQ8iO60MzxptV98syLAmsSp0aNtNNuNte9
	b8xA08jBwn/e7W/N9gyeYKPFX+/FmzNL78r3tsd/KYB0ENs7Dat1g+TqTznC7xluNb
	fWD3odXBl/14dmAJ9UwphwdvMCQluTjhXiMWiwWYcAr0+pXUw0uzf/026WLK+dTbNX
	3rrNE/cVH53OEHlaSVlM+MdaZYdlx3TTs48y9oBd8zz8JRzNfnq3PKUo2KUafxEmnk
	8OVlKm2vHUXhJM9csaZVjxxRy6uGi6/NN434APSc72fFQHXmiDP/Z63BXo+R+F40T5
	Qhvicqh8gQebA3VRSRga0+c9GUED+SxXoOXAuSxxBclYSpRJy2hOljVEh4M1cp8i8W
	aRRBG56DTwaaKMcw6Yu1QbWel5zMqLICvKZowrOObB28TTdS2KLUwFHQay6OhxeWh1
	f8MvvNBCVLf5ib0QHl2E/FHj/8ITpOY3kZeIZ5spocnrjPpqbCYltWyeuHcz4arasS
	KOKnebe9h7mCeTR+SAJ8Qetg=
Date: Mon, 24 Feb 2020 07:49:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20200224054945.GB6683@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
	<20200223195148.GB3444@localhost>
	<49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Lower priority of debug messages that should not be shown on the console
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
X-List-Received-Date: Mon, 24 Feb 2020 05:49:49 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sun, Feb 23, 2020 at 11:53:57PM +0000, Richard Purdie wrote:
> On Sun, 2020-02-23 at 21:51 +0200, Adrian Bunk wrote:
> > On Sat, Feb 22, 2020 at 03:54:54PM +0000, Richard Purdie wrote:
> > > ...
> > > b) We actually fix/improve the way logging works.
> > > 
> > > I'd prefer b).
> > 
> > Makes sense, I've submitted this as bug #13813.
> 
> I note you believe this has to be fixed before we reach M3. I guess I'd
> agree, I just don't know who is going to do it.

I would have said M4, but that doesn't really change anything.

> Bitbake bugs get auto assigned to me. I physically cannot actually keep
> up with the incoming bugs despite working more than I should.
> 
> I was actually trying to do something about my bug count as its
> seriously depressing me. For each one I try and fix I seem to find
> three more intermittent issues on the autobuilder :(.

I know this might sound brutal, but in hindsight the hash equivalence 
work was not a good idea with the current resourcing.

I fully understand why it is attractive to properly fix a long-standing
problem, but the hash equivalence work and followup fixes might have 
been the difference between an OKish workload and working more than
you should have done.

> I know you didn't mean it this way and we need to track the issues, I
> just don't know how we're going to handle it.

From my side the problem is that my initial patch is what I can do with 
reasonable effort.

> Cheers,
> 
> Richard

cu
Adrian

