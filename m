Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4099F6011C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jun 2016 13:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5RDpshE014292; Mon, 27 Jun 2016 14:51:54 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0GhbPNiY9u2D; Mon, 27 Jun 2016 14:51:54 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5RDppZW014277
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 Jun 2016 14:51:52 +0100
Message-ID: <1467035511.8590.55.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>, Robert Yang
	<liezhi.yang@windriver.com>, bitbake-devel@lists.openembedded.org, Mark
	Hatle <mark.hatle@windriver.com>
Date: Mon, 27 Jun 2016 14:51:51 +0100
In-Reply-To: <57712E31.6000100@windriver.com>
References: <cover.1466754896.git.liezhi.yang@windriver.com>
	<ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
	<1466774122.3319.235.camel@linuxfoundation.org>
	<57712E31.6000100@windriver.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] fetch2: remove "." in the end
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
X-List-Received-Date: Mon, 27 Jun 2016 13:51:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-06-27 at 08:46 -0500, Jason Wessel wrote:
> On 06/24/2016 08:15 AM, Richard Purdie wrote:
> > On Fri, 2016-06-24 at 00:55 -0700, Robert Yang wrote:
> > > From: Jason Wessel <jason.wessel@windriver.com>
> > > 
> > > The filename can't be "foo." for MS Windows filesystem, it will
> > > renamed
> > > to "foo" automatically, so we can't upload sources like "foo." to
> > > the
> > > Windows server, remove "." in the end will fix the problem.
> > This patch on its own is probably ok. What I worry about is that if
> > I
> > merge this, I'll then get all the follow ups which for example
> > force
> > lower or upper case everywhere, remove ":" characters from all
> > filenames (including sstate?), remove various other characters and
> > so
> > on.
> > 
> > We don't run on windows filesystems and we're not likely ever to be
> > able to.
> > 
> > So what are we aiming for here?
> 
> 
> It is compatibility with browsing and copying the bitbake/oe
> directory structures + the download cache.  We certainly don't expect
> to be building directly on Windows with a native bitbake. Today
> however, you can directly use git on Windows and building with the
> cross API's from a generated SDK.

You haven't really answered my question though. If we fix this, how
many other issues are we going to run into? Are we for example going to
need to change the sstate filename field separator? Are there other
filename issues we'll run into. Typically, someone sends a simple patch
like this, then a couple more and then we suddenly find we've committed
to rewriting half the system to "support windows filesystems".

I'm going to refuse to do this piecemeal. I'd like a thought out
proposal about exactly which files we need to support on windows and
how much of bitbake we're expecting to be able to use (or which class
code/tools) before we start adding patches.

Cheers,

Richard

