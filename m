Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTuBS-0003Km-JH for bitbake-devel@lists.openembedded.org;
	Fri, 25 Nov 2011 12:43:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAPBaX1k004770;
	Fri, 25 Nov 2011 11:36:33 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04359-06; Fri, 25 Nov 2011 11:36:29 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAPBaQkO004764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Nov 2011 11:36:27 GMT
Message-ID: <1322220993.10928.63.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Fri, 25 Nov 2011 11:36:33 +0000
In-Reply-To: <4ECF5AB0.5020204@windriver.com>
References: <cover.1321364305.git.liezhi.yang@windriver.com>
	<c7fca16d218cd31ab32239b970d57a95b2858532.1321364305.git.liezhi.yang@windriver.com>
	<1322139798.24143.22.camel@ted> <4ECF5AB0.5020204@windriver.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] Fix bitbake-runtask
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Nov 2011 11:43:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-11-25 at 17:06 +0800, Robert Yang wrote:
> Thank you very much, this is pretty good, I've tested it, it worked
> well. What shall I do for it then? Should I send the pull request or
> you will merge it from you branch?

I've merged this patch into Poky, splitting out the siggen change into a
separate commit which I also pushed upstream. bitbake-runtask isn't in
upstream bitbake, it was one of the last remaining differences between
bitbake in poky and the upstream.

Now the script works, we can likely get this into upstream and get that
difference resolved once and for all.

Cheers,

Richard




