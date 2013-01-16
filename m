Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TvSkT-0001gS-JC for bitbake-devel@lists.openembedded.org;
	Wed, 16 Jan 2013 14:10:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0GCsJSW024191;
	Wed, 16 Jan 2013 12:54:19 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23524-04; Wed, 16 Jan 2013 12:54:15 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0GCs9Nu024185
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2013 12:54:11 GMT
Message-ID: <1358340849.12628.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrew Stubbs <ams@codesourcery.com>
Date: Wed, 16 Jan 2013 12:54:09 +0000
In-Reply-To: <50F41A7D.7080108@codesourcery.com>
References: <50F4106E.8070404@codesourcery.com>
	<CAGfZjq4GBKd=qc5LQgZQ=6odp8bJgGSW72qE9N=397UjfcYGig@mail.gmail.com>
	<50F41A7D.7080108@codesourcery.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Minimal BitBake template
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
X-List-Received-Date: Wed, 16 Jan 2013 13:10:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-01-14 at 14:47 +0000, Andrew Stubbs wrote:
> On 14/01/13 14:23, Bill Traynor wrote:
> > This doesn't answer your problem directy, and you may have seen this
> > tutorial already, but in case not:
> >
> > http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/
> >
> > Note that I'm including a hello world example in the new BitBake User
> > Manual I'm working on.
> 
> Thanks!  That's a very useful resource. :)
> 
> It's surprisingly hard to find BitBake tutorials that do not assume that 
> one is trying to insert something into OE. I wish I'd found this sooner.
> 
> The other think I wish I'd found sooner, that you page references, are 
> the example conf and bbclass files inside the bitbake sources. I had 
> assumed they were some sort of internal detail, and not for the likes of me.
> 
> Apparently my base.bbclass and hello.bb files are absolutely fine, but 
> something, as yet unidentified, in the bitbake.conf from the sources has 
> fixed my problem.

At a guess, did you set the STAMP variable?

We could certainly make bitbake give less obtuse errors if some of the
key variables aren't set. Its not been a priority since people don't do
that very often though...

Cheers,

Richard



