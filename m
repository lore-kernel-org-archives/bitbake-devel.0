Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sgkbc-0001sp-3O for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jun 2012 00:39:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5IMSnoM015922;
	Mon, 18 Jun 2012 23:28:49 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11609-03; Mon, 18 Jun 2012 23:28:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5IMSblP015875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Jun 2012 23:28:38 +0100
Message-ID: <1340058517.1640.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Mon, 18 Jun 2012 23:28:37 +0100
In-Reply-To: <4FDF99FB.2030503@windriver.com>
References: <alpine.DEB.2.02.1206181608120.22003@oneiric>
	<CAMKF1sqTiss0-CgVj5U=uvkUcuhs0o+fA+n-GbOCi8VunA+qGw@mail.gmail.com>
	<4FDF99FB.2030503@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: is there a bitbake command to *just* fetch all necessary packages?
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
X-List-Received-Date: Mon, 18 Jun 2012 22:39:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-06-18 at 16:13 -0500, Mark Hatle wrote:
> On 6/18/12 4:08 PM, Khem Raj wrote:
> > On Mon, Jun 18, 2012 at 1:10 PM, Robert P. J. Day<rpjday@crashcourse.ca>  wrote:
> >>
> >>   perhaps i'm just misreading the docs, but is there a bitbake
> >> incantation that does *nothing* more than fetch the packages needed
> >> for a target image?
> >>
> >>   if i use "bitbake -c fetchall", the result is not just to fetch the
> >> source, but to unload and patch it as well.
> >
> > hmmm I thought it did just what it says 'fetch all' but as you say it
> > seems to do more hmm I am not sure if its intended behavior
> 
> In order for fetchall to work, there are a few dependencies that have to be 
> executed as well..
> 
> But bitbake -c fetchall <target>, will fetch everything needed for the <target> 
> recipe.  It will extract and build only the items necessary for fetch to work 
> properly.

So just to be clear, the issues are git-native, potentially
subversion-native and also potentially pseudo-native getting built by
the wrapper. If you add those to ASSUME_PROVIDED, and skip the wrapper,
to avoid pseudo-native (or teach the wrapper to pass through -c fetchall
directly?) it will just fetch.

Cheers,

Richard



