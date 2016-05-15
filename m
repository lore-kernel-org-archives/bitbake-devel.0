Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A84506011C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 May 2016 08:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4F8FiQW019370; Sun, 15 May 2016 09:15:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id C-JYWTUGhOM4; Sun, 15 May 2016 09:15:44 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4F8Fg5O019366
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 15 May 2016 09:15:43 +0100
Message-ID: <1463300142.9746.154.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Ohly <patrick.ohly@intel.com>, bitbake-devel@lists.openembedded.org
Date: Sun, 15 May 2016 09:15:42 +0100
In-Reply-To: <1463065210-3823-1-git-send-email-patrick.ohly@intel.com>
References: <1463065210-3823-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] runqueue.py: always emit bb.event.DepTreeGenerated
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
X-List-Received-Date: Sun, 15 May 2016 08:15:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-05-12 at 17:00 +0200, Patrick Ohly wrote:
> The data included in the event is useful for implementing a pre-build
> check that warns about unexpected components, for example because of
> an incorrect configuration or changed dependencies.
> 
> Such a check can be done in a .bbclass that gets inherited
> globally. But in contrast to a UI, such a class cannot request that
> the event shall be emitted, and thus the event has to be emitted
> whether there is a consumer or not.
> 
> This was done conditionally earlier out of concerns about the
> performance impact. But now events are handled more efficiently, so
> that concern no longer seems valid: in some simple testing
> (admittedly
> on a fast build workstation), the two lines (generating the data and
> emitting the event with it) only took about 0.05 seconds (measured
> with timeit). That was for a build with roughly 500 recipes (from
> pn-buildlist aka depgraph['pn']), triggered via the command line.
> That
> was even with a consumer of the data active and doing some work, so
> it
> should be even faster when there is no consumer.

I've taken this since now we have event filtering, we don't take the
IPC/RPC cost for data that the receiver doesn't care about. I added a
follow up patch which removes the feature entirely since this code
block was the only reason for it.

Cheers,

Richard

