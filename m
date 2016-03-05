Return-Path: <tanuk@iki.fi>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29])
	by mail.openembedded.org (Postfix) with ESMTP id E1FCA731C3
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Mar 2016 11:22:00 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E24FC2082A
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Mar 2016 06:22:00 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
	by compute3.internal (MEProxy); Sat, 05 Mar 2016 06:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=IR/Z3YTH2xgc3W5
	UOVoGaAk7R20=; b=BzCSyewHf0JD7+j88o06uP+FKnCKaOcIzL82kArBYbO1Ak5
	tRz/c2cABuMyVLCnaS4XC3xgbW39MmgYnHBAe1yI8wYPY77uGsGYmo7Wvn2Z0DXO
	bLWrAhlXadqI/GJDAA0kAU18xSviVI+VJqxPWvUQY/JfZfoueLrYx9HCYcwE=
X-Sasl-enc: BtICGV7LTrM3YyTYDudnCayQhilEuR2otTYjPU/BDhBq 1457176920
Received: from laptop (a88-113-211-72.elisa-laajakaista.fi [88.113.211.72])
	by mail.messagingengine.com (Postfix) with ESMTPA id 46433C00012;
	Sat,  5 Mar 2016 06:22:00 -0500 (EST)
Message-ID: <1457176919.11730.101.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 05 Mar 2016 13:21:59 +0200
In-Reply-To: <1457174505.11730.95.camel@iki.fi>
References: <1456836629.1737.41.camel@iki.fi>
	<1457114328.2804.53.camel@linuxfoundation.org>
	<1457174505.11730.95.camel@iki.fi>
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
Subject: Re: Triggering graceful bitbake shutdown
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
X-List-Received-Date: Sat, 05 Mar 2016 11:22:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2016-03-05 at 12:41 +0200, Tanu Kaskinen wrote:
> On Fri, 2016-03-04 at 17:58 +0000, Richard Purdie wrote:
> > Hi,
> > 
> > On Tue, 2016-03-01 at 14:50 +0200, Tanu Kaskinen wrote:
> > > I wrote a small script that runs bitbake sequentially with multiple
> > > MACHINE values. Sometimes I want to stop it with ctrl-c before it has
> > > finished, but it didn't work properly out-of-the box when running
> > > bitbake under the script (my script would not wait for bitbake to
> > > exit,
> > > and bitbake threw some backtrace too). I then modified SIGINT
> > > handling
> > > in my script so that it forwards the signal to bitbake and then waits
> > > for bitbake to exit. The problem is that bitbake ignores SIGINT. The
> > > UI
> > > handles python's KeyboardInterrupt exception, but that exception
> > > doesn't get raised when bitbake runs under my script. I don't know
> > > what
> > > triggers KeyboardInterrupt in normal conditions, since SIGINT doesn't
> > > seem to be sufficient, does python perhaps monitor stdin to catch the
> > > actual ctrl-c keypress?
> > > 
> > > Anyway, sending SIGTERM instead of SIGINT "works". However, the
> > > SIGTERM
> > > handler shuts down bitbake immediately rather than waiting for the
> > > current tasks to finish. Is that less safe than the normal ctrl-c
> > > handling? If the immediate shutdown is equally safe, then I have no
> > > problem, but if SIGTERM can cause state corruption so that resuming
> > > later doesn't work reliably, then I'd like to have some way for
> > > triggering graceful bitbake shutdown from my script. Any suggestions?
> > > 
> > > Or maybe there is already some way to run bitbake for multiple
> > > MACHINEs, and I don't need to write any script myself?
> > 
> > I'm curious which bitbake process you're sending SIGINT to. If its the
> > knotty UI, it should shutdown gracefully. Other pieces of the system
> > ignore SIGINT since we really want the UI to do it. The behaviour you
> > mention above sounds suboptimal though.
> 
> The script only sends the signal to the direct child process, which
> obviously won't work if knotty is in a different process and the direct
> child deliberately ignores the signal. However, I also tried sending
> SIGINT to all other bitbake processes from the command line with
> "kill", and none of them responded to it.
> 
> > I'm a bit pushed for time with the release stablisation at the moment
> > but would love to see if there is something better we can do here...
> 
> I suppose knotty could use a custom SIGINT handler rather than relying
> on KeyboardInterrupt. If I then change my script to send the signal to
> the knotty process instead of the direct child, that should work.

Hmm... now I realized that if it's normal for knotty to run in a
separate process and still get KeyboardInterrupts, there must be some
difference in how my script spawns bitbake compared to how the "main"
bitbake process spawns the knotty process. Adding a custom SIGINT
handler to knotty may still make sense, but that should not be required
to make this work.

-- 
Tanu

