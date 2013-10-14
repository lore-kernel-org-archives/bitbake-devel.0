Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4F7B86CE3F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 15:30:22 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9EFUHoc005685; Mon, 14 Oct 2013 16:30:17 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YOmDIHbYmwYN; Mon, 14 Oct 2013 16:30:17 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9EFUB9e005680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 14 Oct 2013 16:30:12 +0100
Message-ID: <1381764607.29912.345.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Morgan <chmorgan@gmail.com>
Date: Mon, 14 Oct 2013 16:30:07 +0100
In-Reply-To: <CAAPegz04fh+NP+ZEduiPo+Cbvh-bbzyqGNEsMaWJoOH0t_v23w@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<1381683215.29912.233.camel@ted>
	<CAAPegz12Mnrbipi0w4zMdcje1R4SUwhMiUKsOAOfKHpzukea2Q@mail.gmail.com>
	<1381761637.29912.326.camel@ted>
	<CAAPegz04fh+NP+ZEduiPo+Cbvh-bbzyqGNEsMaWJoOH0t_v23w@mail.gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake for native x86 project?
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
X-List-Received-Date: Mon, 14 Oct 2013 15:30:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-10-14 at 11:02 -0400, Chris Morgan wrote:
> Ahh. I see.
> 
> Thank you for those examples, I'll take a look at it in more detail
> and see what I can learn. I appreciate the help.
> 
> Today I'm going to try to setup a sstate on a remote machine that has
> a few hundred GB of free space, do a build and then try locally to do
> the same. One question I had was whether developers, when using the
> sstate, would receive tens of gigabytes of files downloaded to their
> machines. I think that would be ok but not idea but oh well.

They shouldn't see tens of gigabytes. I'd say we're talking a few
hundred megabytes.

As Trevor also mentions, there is the SDK/ADT standalone toolchain for
app development work which is worth looking at too. That could move the
need for the core builds to a small number of people and/or central
server.

> Would you be interested in doing some consulting/contracting around
> the issue? or know if some one that might be? It would probably be 10x
> faster than me doing it and we could avoid the various pitfalls that
> we might hit during experimentation. If you or anyone is interested
> you can contact me at chmorgan@gmail.com. We are in the Boston area
> but telecommute works too.

For me personally this isn't possible however there are a number of
community members offering consultancy around the project who may be
able to help and may get in touch :).

Cheers,

Richard


