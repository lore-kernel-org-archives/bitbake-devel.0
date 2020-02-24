Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 270E0607C7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 09:12:08 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c9so9418273wrw.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=RX498W+hXFsllFYs5AblXl1Xo1sxMw0YAk+Gg6jXb9E=;
	b=bDUp6iyQQwHb+wvV7TGXWyUvtQWqqpf7PiZ1rjQdlBdkOSHhsD5ED67r1r5FgNVvUY
	BXbImFcNfE9hfYs/twb7ML9fkHxkblLwEgosY2EkvfZpcktUw1odg1mslilb+xq61k0m
	z6GV9V43khR7kfRDw33cFHIePBk9LaijGLo6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=RX498W+hXFsllFYs5AblXl1Xo1sxMw0YAk+Gg6jXb9E=;
	b=dqOY586Zk54Tdi9L7cDBktNRXJfaMgP64iHtuj+w/76ilPLePmlxfhRrRh27heLB6J
	d+vws4ZA2YkXIT0CVpJtLwhf4cDYFGnDQ0WWaRKx94SJuVkMms+TZ9bdxh7AeQoRD5GW
	EF3iqNChQQeWnsJ1cXimTy4cDAQM1ZG2+vm2epGFUGW6kLcunPC5zUy6Mopaog6NFn+K
	2BhaNn68/aLMQBH9B1nM0Y4WtTxuErgU4hoxos+2feIbOd32L7DUoZg3DSDjboXC6eW5
	PADLFcG2wevczN+SBUfZiW3H3TRyy/EoIbkGkiCsj8s1P33ZXt4xUogOwoXn5sP6h8c3
	0Xmg==
X-Gm-Message-State: APjAAAWcCxQsp7F7HcOhsl/EqO/amg/+IpDaAdeHwt6jsSD5/tjrRCdR
	9qIqZfpS0apoOPoyocRURm7vIDpbXDg=
X-Google-Smtp-Source: APXvYqwfY90rQx17QhNpFttIRVXsjH1vNHSnR9W+7k67NsFFvA0NyZkqUSwQft8eAFKIuwLzjPnOwA==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr11818473wrj.315.1582535528663;
	Mon, 24 Feb 2020 01:12:08 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id n3sm819328wrw.52.2020.02.24.01.12.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 24 Feb 2020 01:12:07 -0800 (PST)
Message-ID: <f5a7208c16b4df00445cb280b3a556923c07db97.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Adrian Bunk <bunk@stusta.de>
Date: Mon, 24 Feb 2020 09:12:06 +0000
In-Reply-To: <20200224054945.GB6683@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
	<20200223195148.GB3444@localhost>
	<49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
	<20200224054945.GB6683@localhost>
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
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
X-List-Received-Date: Mon, 24 Feb 2020 09:12:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-24 at 07:49 +0200, Adrian Bunk wrote:
> On Sun, Feb 23, 2020 at 11:53:57PM +0000, Richard Purdie wrote:
> > On Sun, 2020-02-23 at 21:51 +0200, Adrian Bunk wrote:
> > > On Sat, Feb 22, 2020 at 03:54:54PM +0000, Richard Purdie wrote:
> > > > ...
> > > > b) We actually fix/improve the way logging works.
> > > > 
> > > > I'd prefer b).
> > > 
> > > Makes sense, I've submitted this as bug #13813.
> > 
> > I note you believe this has to be fixed before we reach M3. I guess
> > I'd
> > agree, I just don't know who is going to do it.
> 
> I would have said M4, but that doesn't really change anything.

Technically its feature work although I guess it can be argued both
ways as its also a usability/bug fix.

> > Bitbake bugs get auto assigned to me. I physically cannot actually
> > keep
> > up with the incoming bugs despite working more than I should.
> > 
> > I was actually trying to do something about my bug count as its
> > seriously depressing me. For each one I try and fix I seem to find
> > three more intermittent issues on the autobuilder :(.
> 
> I know this might sound brutal, but in hindsight the hash
> equivalence work was not a good idea with the current resourcing.

Not brutal, in hindsight it hasn't been such a good idea.

> I fully understand why it is attractive to properly fix a long-
> standing
> problem, but the hash equivalence work and followup fixes might have 
> been the difference between an OKish workload and working more than
> you should have done.

Agreed, and now why I kind of feel guilty if I don't resolve some of
the issues. We could just turn it off again I guess, I keep wondering
about that.

> > I know you didn't mean it this way and we need to track the issues,
> > I
> > just don't know how we're going to handle it.
> 
> From my side the problem is that my initial patch is what I can do
> with reasonable effort.

Part of the reason I'm highlighting this is that I have a lot of
feedback that says people don't believe there is any problem with our
resourcing. Unless I can show where there are issues, its not going to
change :/.

Cheers,

Richard



