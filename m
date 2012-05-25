Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXocD-0002Cs-0G for bitbake-devel@lists.openembedded.org;
	Fri, 25 May 2012 09:07:13 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4P6v0au031507;
	Fri, 25 May 2012 07:57:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30513-03; Fri, 25 May 2012 07:56:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4P6uqmf031500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 07:56:53 +0100
Message-ID: <1337929012.8248.175.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Fri, 25 May 2012 07:56:52 +0100
In-Reply-To: <20120522111359.54be2700@wrlaptop>
References: <cover.1337612802.git.peter.seebach@windriver.com>
	<CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
	<1337694219.8248.6.camel@ted> <20120522111359.54be2700@wrlaptop>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: v2 [PATCH 0/2] data_smart.py: Track inclusions and assignments
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
X-List-Received-Date: Fri, 25 May 2012 07:07:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-05-22 at 11:13 -0500, Peter Seebach wrote:
> On Tue, 22 May 2012 14:43:39 +0100
> Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
> 
> > So I want to take a closer look through the patches but I'm leaning
> > toward merging them. If we find ways to make things neater, great but
> > this is probably as good a start as we can hope for.
> 
> They need one small bug fixed (there's a missing [1] in the mods to
> createCopy), but apart from that I'm using them without noticeable
> trouble.

FWIW, I'm planning to look at this next week, am not likely to get there
today.

> If these get added to bitbake, there's a related change to oe-core
> that might be handy, to suppress sanity checks when using this feature
> so you can get an explanation of what went wrong.

I suspect a recent change to sanity.bbclass has made that obsolete...

Cheers,

Richard



