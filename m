Return-Path: <tanuk@iki.fi>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29])
	by mail.openembedded.org (Postfix) with ESMTP id 2598C70018
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Mar 2016 10:41:46 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CD5CE20228
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Mar 2016 05:41:46 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
	by compute1.internal (MEProxy); Sat, 05 Mar 2016 05:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KylML7pnFhfBMPq
	HGh+Qx7NYSZs=; b=fCzrVscphQQ46QJHaW8XTcUZ+bLm1/maI/ytrVdUCLwnIKa
	4H8n84q+uzRWaV0VvjP9GzwPJcuuA+FqblRYmY2y5kHMiOVPrOL+vPJrcm3MmyvP
	9ypJZJrRD2hB4tg3+VzQ9bHQoQGDzsH7x4yNEgfjlFnaNeWdD8mNdNBNUUPI=
X-Sasl-enc: hF/yRl/1/Me0XyUanZwbkW7nb9HQLrJegY688Cqa2Q3k 1457174506
Received: from laptop (a88-113-211-72.elisa-laajakaista.fi [88.113.211.72])
	by mail.messagingengine.com (Postfix) with ESMTPA id 37740C00012;
	Sat,  5 Mar 2016 05:41:46 -0500 (EST)
Message-ID: <1457174505.11730.95.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 05 Mar 2016 12:41:45 +0200
In-Reply-To: <1457114328.2804.53.camel@linuxfoundation.org>
References: <1456836629.1737.41.camel@iki.fi>
	<1457114328.2804.53.camel@linuxfoundation.org>
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
X-List-Received-Date: Sat, 05 Mar 2016 10:41:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2016-03-04 at 17:58 +0000, Richard Purdie wrote:
> Hi,
> 
> On Tue, 2016-03-01 at 14:50 +0200, Tanu Kaskinen wrote:
> > I wrote a small script that runs bitbake sequentially with multiple
> > MACHINE values. Sometimes I want to stop it with ctrl-c before it has
> > finished, but it didn't work properly out-of-the box when running
> > bitbake under the script (my script would not wait for bitbake to
> > exit,
> > and bitbake threw some backtrace too). I then modified SIGINT
> > handling
> > in my script so that it forwards the signal to bitbake and then waits
> > for bitbake to exit. The problem is that bitbake ignores SIGINT. The
> > UI
> > handles python's KeyboardInterrupt exception, but that exception
> > doesn't get raised when bitbake runs under my script. I don't know
> > what
> > triggers KeyboardInterrupt in normal conditions, since SIGINT doesn't
> > seem to be sufficient, does python perhaps monitor stdin to catch the
> > actual ctrl-c keypress?
> > 
> > Anyway, sending SIGTERM instead of SIGINT "works". However, the
> > SIGTERM
> > handler shuts down bitbake immediately rather than waiting for the
> > current tasks to finish. Is that less safe than the normal ctrl-c
> > handling? If the immediate shutdown is equally safe, then I have no
> > problem, but if SIGTERM can cause state corruption so that resuming
> > later doesn't work reliably, then I'd like to have some way for
> > triggering graceful bitbake shutdown from my script. Any suggestions?
> > 
> > Or maybe there is already some way to run bitbake for multiple
> > MACHINEs, and I don't need to write any script myself?
> 
> I'm curious which bitbake process you're sending SIGINT to. If its the
> knotty UI, it should shutdown gracefully. Other pieces of the system
> ignore SIGINT since we really want the UI to do it. The behaviour you
> mention above sounds suboptimal though.

The script only sends the signal to the direct child process, which
obviously won't work if knotty is in a different process and the direct
child deliberately ignores the signal. However, I also tried sending
SIGINT to all other bitbake processes from the command line with
"kill", and none of them responded to it.

> I'm a bit pushed for time with the release stablisation at the moment
> but would love to see if there is something better we can do here...

I suppose knotty could use a custom SIGINT handler rather than relying
on KeyboardInterrupt. If I then change my script to send the signal to
the knotty process instead of the direct child, that should work.

-- 
Tanu

