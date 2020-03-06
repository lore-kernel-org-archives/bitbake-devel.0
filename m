Return-Path: <bunk@stusta.de>
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
	by mail.openembedded.org (Postfix) with ESMTP id BABE26101C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2020 10:24:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 48YkHp09DPz4c;
	Fri,  6 Mar 2020 11:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1583490262;
	bh=NIYvHNuaGb+oEPuwvsu2cUo79hUXpoErjqWpcm1p05I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5/PdLvfYmfgC1YcdtKsqN1dsFaugemE7BvCu9Y/TVI8XhEpSDYAtA4++jfEAAzEp
	4KGLGCxNS/ZTJ66SiNmWaVJ3NoWhaGXIyW+lNGpKhE/v1cazgmjzflZJfEZHfG66KC
	1SzoTQqidO91lGzYriAFHks4aHEPsKo5aS4c3NZ/coOHVDoEiQIKSUmipPENPP57r8
	cD8hhY3vQNN3yT3b4/E2P56W/czdhOG8y3khEBFOExizixkI9bx+GcLyov0JMcNVlE
	e3MW1hzczkOpb1cTfJmKc0BM+i8tnPJoBUITsYfWPzHUjxYqfNmDrJ+Dp8oZvDMshX
	8bJbUpY2m9SacRhUp63vgN0qeAVVGL/D/DkGAzgZ3BjFQkJVHh7rquDn2ZUZJ9SZnr
	9jOqM2HXl3vLaCcKstWwnI2zDuVfctM/BqGeoKOJE+veDomPKw6yz/nlf0n//Z47KV
	FtXbTsSJ2V5u1fL+qFdN7KD7qjCJeCVL9VqNk0ZaSvmfmAvaSXSWtmpGQQlp9ZOOZT
	S3TfCWqZbR8JsNkONyVa5AGWIgzmKMeZyg9D1k2huVKF7+ZhBhsYoyLiqDy57a8FkZ
	RdH6VOq5JNq2W++261P67d4LzeSUKVmpu1wtOwp2chVFiUInCbzncYe8Ne2yhY0s87
	6n1RlZyznnlL4wchUwEWoA0Q=
Date: Fri, 6 Mar 2020 12:24:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20200306102420.GB17785@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
	<20200223195148.GB3444@localhost>
	<49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
	<20200224054945.GB6683@localhost>
	<f5a7208c16b4df00445cb280b3a556923c07db97.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <f5a7208c16b4df00445cb280b3a556923c07db97.camel@linuxfoundation.org>
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
X-List-Received-Date: Fri, 06 Mar 2020 10:24:23 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Feb 24, 2020 at 09:12:06AM +0000, Richard Purdie wrote:
> On Mon, 2020-02-24 at 07:49 +0200, Adrian Bunk wrote:
> > On Sun, Feb 23, 2020 at 11:53:57PM +0000, Richard Purdie wrote:
>...
> > > I know you didn't mean it this way and we need to track the issues,
> > > I
> > > just don't know how we're going to handle it.
> > 
> > From my side the problem is that my initial patch is what I can do
> > with reasonable effort.
> 
> Part of the reason I'm highlighting this is that I have a lot of
> feedback that says people don't believe there is any problem with our
> resourcing. Unless I can show where there are issues, its not going to
> change :/.

Why does YP give users false/misleading information regarding security
support of stable and LTS releases despite lack of resources to provide
security support?

There is no reason to believe claims that there would be any problem 
with resourcing when the public announcements from YP give the opposite 
impression.

> Cheers,
> 
> Richard

cu
Adrian

