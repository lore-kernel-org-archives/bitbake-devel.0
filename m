Return-Path: <bunk@stusta.de>
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
	by mail.openembedded.org (Postfix) with ESMTP id 146B660AFA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2020 22:05:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 48Q2Sc5Wfdz3l;
	Sat, 22 Feb 2020 23:05:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1582409121;
	bh=tjxBtNnq18qUw4Yz2xPGnOWpYFsSvqNOINRyIF+V7P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDhjzFowN5xPBjNTUFFm7KA78i2DDh0swfyAaSR9L5o584yXaUlOIdIx3Oz0newYa
	aSTNkeJMetjhtntWJ4D6oU/r9DpusiwO1Y8vPTrFgpTHJOzuPrgpZNmWdq9BQYKG8n
	paBg3onZDuXWXlwD2QwNgoQwWJZbtVaRpOMDbrrRbzyvAFzNT3QgKzSNb5oFLaYtfF
	XoGASMdscSmW/R1i5zGSEvlHlIbTNBCUcHX2vtSEQsp6PaIzLNXrsDbODINRTuGCtA
	oX4hfBiKvKA6ssqOfe9p0hKWFs3ZfKwXMZppzu9rRqqRIaE3gLvnn/Wbl+t+rN8mVH
	tWr3JZVqF+Fwmni8p5KGwukfbdTIL/1GSyBqvZzqDy3YbMHUC04nW9dBaqY46OVIOK
	NgG9sDPBxwoMRdpeQvtDPdyqPwcWtCgvyJbnjFp1KMgEJzc/3H2iayCDowPnk0kLd6
	HwAjtYVPc5kVbN8tzls6MvxeTRTJ77gWe+VdMNh5RCLh7vBJSrdX6Iho8iS31DoKB3
	7nayQHmll86S1Hqy8rkyfFve/woLskdhPRP85463rtrS0vHdRFQOf+kOrWTS7l5z+3
	wYvq58HYps0wblDeJGPhZ/xNVuiXWFg6vS6ZnRG7+6AYdsMU/ucJwoOKkGZTEdtoCE
	zJ3UIEgkxOY3Y8pv5yJQfONM=
Date: Sun, 23 Feb 2020 00:05:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andreas =?utf-8?Q?M=C3=BCller?= <schnitzeltony@gmail.com>
Message-ID: <20200222220518.GD9628@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<CALbNGRT8Zctc43d9xJ-1A2aANjONos0-EF-rzyUgzibs47kk_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALbNGRT8Zctc43d9xJ-1A2aANjONos0-EF-rzyUgzibs47kk_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Sat, 22 Feb 2020 22:05:23 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Feb 22, 2020 at 12:57:47PM +0100, Andreas Müller wrote:
> On Fri, Feb 21, 2020 at 10:00 PM Adrian Bunk <bunk@stusta.de> wrote:
>...
> > --- a/bitbake/lib/bb/runqueue.py
> > +++ b/bitbake/lib/bb/runqueue.py
> > @@ -2054,7 +2054,7 @@ class RunQueueExecute:
> >          self.update_holdofftasks()
> >
> >          if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.updated_taskhash_queue and not self.holdoff_tasks:
> > -            logger.info("Setscene tasks completed")
> > +            logger.debug(1, "Setscene tasks completed")
> ^ Could you please leave this one - I consider it helpful
>...

It would be helpful if it would be shown only once.

I've seen it 10 times during a build where
"Setscene task .. became valid" and "Already covered setscene for ..."
also happened a few times.


cu
Adrian

