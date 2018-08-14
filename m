Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6C8C378F63
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 09:45:19 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w7E9jGIF008214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 14 Aug 2018 10:45:17 +0100
Message-ID: <8ac13026f3f66ce8a652d760162bb4cf74e13ebd.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, Mikko.Rapeli@bmw.de, Andreas
	=?ISO-8859-1?Q?M=FCller?= <schnitzeltony@gmail.com>,
	Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 14 Aug 2018 10:45:15 +0100
In-Reply-To: <98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 09:45:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2018-08-14 at 10:43 +0100, Richard Purdie wrote:
> On Tue, 2018-08-14 at 10:07 +0200, Alexander Kanavin wrote:
> > 2018-08-14 8:32 GMT+02:00  <Mikko.Rapeli@bmw.de>:
> > > Just my 2 € cents to the discussion:
> > > 
> > > we had to limit number of threads because heavy C++ projects were
> > > using
> > > all of RAM and causing heavy swapping. Single g++ processes were
> > > eating
> > > up to 20 gigabytes of physical ram. It's not just the CPU which
> > > is
> > > the
> > > limiting factor to parallel task execution.
> > 
> > I do believe some kind of clever dynamic limiter would be useful
> > here.
> > Obviously it's an absurd situation when on a 32 core processor
> > there
> > are 32 do_compile c++ tasks, each running 32 instances of g++ -
> > which
> > is the default configuration. On the other hand running things like
> > do_configure or do_install should happen in parallel. I like
> > Andre's
> > idea, but it should also watch the available RAM.
> 
> If people want to play, I did experiment with "proper" thread
> pooling:
> 
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/w
> ipqueue4&id=d66a327fb6189db5de8bc489859235dcba306237

More recent version of the patch:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/wipqueue7&id=236ca8be128ba7a4edb9fb2c9e512d181679eee8

Cheers,

Richard

