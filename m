Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwBXD-0003wv-1t for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 13:59:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IChYEU008881;
	Fri, 18 Jan 2013 12:43:34 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05510-03; Fri, 18 Jan 2013 12:43:30 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IChSup008874
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 12:43:29 GMT
Message-ID: <1358513008.27799.20.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrew Stubbs <ams@codesourcery.com>
Date: Fri, 18 Jan 2013 12:43:28 +0000
In-Reply-To: <50F421E6.4060400@codesourcery.com>
References: <50F421E6.4060400@codesourcery.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fix bundled base.bbclass file
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
X-List-Received-Date: Fri, 18 Jan 2013 12:59:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-01-14 at 15:19 +0000, Andrew Stubbs wrote:
> The base.bbclass file that is included with the bitbake sources does not 
> appear to work properly. Specifically, none of the output appears on screen.
> 
> A quick look at the poky equivalent shows that they use a different 
> means to print the data. Presumably something got updated somewhere, and 
> the example base class is merely out of date.
> 
> The attached patch fixes the do_listtasks and do_showdata code such that 
> it works as I would expect.

I merged that, thanks.

> I had expected that the base_do_build function would run if my .bb file 
> did not define do_build, but it does not appear to, and it's not obvious 
> to me how, when, or why it is supposed to work.

Your expectation is correct, I'm not sure why that wouldn't happen. The
EXPORT_FUNCTIONS do_build should mean do_build gets mapped to
base_do_build.

Cheers,

Richard



