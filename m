Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id F3B6060FAA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 14:40:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9EEeixg002681; Mon, 14 Oct 2013 15:40:44 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o5VHGTBpZdVX; Mon, 14 Oct 2013 15:40:43 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9EEeeMH002652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 14 Oct 2013 15:40:42 +0100
Message-ID: <1381761637.29912.326.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Morgan <chmorgan@gmail.com>
Date: Mon, 14 Oct 2013 15:40:37 +0100
In-Reply-To: <CAAPegz12Mnrbipi0w4zMdcje1R4SUwhMiUKsOAOfKHpzukea2Q@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<1381683215.29912.233.camel@ted>
	<CAAPegz12Mnrbipi0w4zMdcje1R4SUwhMiUKsOAOfKHpzukea2Q@mail.gmail.com>
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
X-List-Received-Date: Mon, 14 Oct 2013 14:40:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-10-14 at 09:28 -0400, Chris Morgan wrote:
> Ahh interesting. I was thinking that this kind of a short-circuit
> approach might make sense. Its good to hear that the concept isn't so
> crazy although I've literally found no information about anyone doing
> anything of the sort on the web.

I just sent out my notes/patch attempt at just short circuiting in gcc.
Its a bit messy and I found some issues I didn't expect. It would be
possible to do it with both gcc/libc I'd guess but its not something I'm
going to have any more time to try any time soon...

> I considered using the full blown x86/x86-64 targets but our build
> time right now using cmake and native tools is ~30 seconds with only a
> handful of MB of data to download.
> 
> Would using a sstate cache + a custom image target be able to get down
> to that kind of time? Today each developer is building on their
> desktop and from my own testing with angstrom it looks like the builds
> take nearly an hour and generate 30+GB of data. This is almost
> entirely why I've been hesitant to try to use the built-in x86/x86-64
> support. I love the idea of ensuring that everything matches exactly
> on each developer machine but the overhead is pretty crazy.

You can build a complete rootfs from sstate in about 4 minutes so I'd
suggest trying it and see. If you've just building a cmake app, it will
need to download and install a toolchain but it will just do that once
for any given build directory and I suspect you could make it work. 

Cheers,

Richard



