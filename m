Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 255EC6028A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 23:05:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1ON5KiT006055; Mon, 24 Feb 2014 23:05:21 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ryrUg5LmUH-M; Mon, 24 Feb 2014 23:05:20 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1ON5HQN006052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Feb 2014 23:05:18 GMT
Message-ID: <1393283110.31769.20.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Brad Litterell <brad@evidence.com>
Date: Mon, 24 Feb 2014 23:05:10 +0000
In-Reply-To: <E51394554A503C4E852F9BEE46B03E8D019D27CA@TI-THOR.tasernet.com>
References: <E51394554A503C4E852F9BEE46B03E8D019D27CA@TI-THOR.tasernet.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Getting-started page for bitbake development or debugging?
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
X-List-Received-Date: Mon, 24 Feb 2014 23:05:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-02-24 at 21:01 +0000, Brad Litterell wrote:
> I would like to debug bitbake on my project to better understand some
> of the actions it is taking.  I could add a bunch of logging
> statements, but it would be easier if I could just run it under a
> python debugger and set a breakpoint where I'm curious.  I'm new to
> Python, so I'm wondering if there is a suggested toolset?

None of the Bitbake maintainers use python's debugger so its hard to
give advice.

The closest I've got to this was the python devshell implementation I
started:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/wipqueue3&id=9ed8fd5c962ccf01daa669b79da70dfa7e8ff8bd

which may or may not let you experiment. I'd love to see improvements to
it and/or other docs on debugging bitbake with the debugger...

Cheers,

Richard





