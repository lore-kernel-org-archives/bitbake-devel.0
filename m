Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 471DC60124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 23:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB7NNuV0004085; Mon, 7 Dec 2015 23:23:56 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pcqd2DqBRTFT; Mon,  7 Dec 2015 23:23:56 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB7NNesW004072
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 7 Dec 2015 23:23:51 GMT
Message-ID: <1449530620.19730.18.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ed.bartosh@linux.intel.com
Date: Mon, 07 Dec 2015 23:23:40 +0000
In-Reply-To: <20151207182248.GA9348@linux.intel.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
	<3bf6fe429855eb5b4d44e28c7bf832423d2f72cb.1449078919.git.avery.brian@gmail.com>
	<1449509817.19730.8.camel@linuxfoundation.org>
	<20151207182248.GA9348@linux.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 28/30] command: add CommandStarted event
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
X-List-Received-Date: Mon, 07 Dec 2015 23:24:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-12-07 at 20:22 +0200, Ed Bartosh wrote:
> On Mon, Dec 07, 2015 at 05:36:57PM +0000, Richard Purdie wrote:
> > On Wed, 2015-12-02 at 10:03 -0800, brian avery wrote:
> > I'm not sure I like the idea of this, particularly after I've seen what
> > you're using it to do. Just from a performance standpoint, adding in an
> > event per command execution adds in round trips and will increase the
> > time something simple like "bitbake -p" takes to do nothing when the
> > cache is hot.
> >
> > I note in a later patch you use this to check for a command coming from
> > elsewhere to modify the data store and I worry that we'll end up with
> > unstructured code if we encourage people to do that too.
> >
> The reason of adding this event is that I wanted to introduce generic
> event that can be used by other people. Less generic ones would be 'VariableSet' or
> 'BRBESet'. I'm not sure those are better choice than CommandStarted.
> 
> > I did briefly talk to Brian and he mentioned you needed a way to
> > differentiate between events from different builds. I'd suggest you can
> > could do this if you markup the events as they come through your event
> > receiver, since events for a specific build should come through a
> > specific socket. Worst case I'd prefer doing this internally to bitbake
> > rather than the command interception above but adding data to every
> > event being sent over IPC is something I'd prefer to avoid if we can
> > too.
> >
> There were no suitable events for this purpose I'm afraid. All events I
> looked at were fired late than BRBE variable is set. I wanted to know
> when it's changed as soon as possible.
> 
> > Would you be able to see if there is a different way we could handle
> > this?
> I'll try to look again.

We did support custom event injection for toaster if I remember
correctly. Could the code that is setting this variable generate an
event that suited your needs?

Cheers,

Richard


