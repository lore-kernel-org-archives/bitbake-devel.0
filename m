Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S1n68-0005xh-6c; Mon, 27 Feb 2012 00:01:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1QMrEEi019141;
	Sun, 26 Feb 2012 22:53:14 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16773-07; Sun, 26 Feb 2012 22:53:08 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1QMr6VY019104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Feb 2012 22:53:07 GMT
Message-ID: <1330296788.31855.20.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 26 Feb 2012 22:53:08 +0000
In-Reply-To: <20120226212631.GA3859@jama.jama.net>
References: <1330261465.31855.4.camel@ted>
	<20120226212631.GA3859@jama.jama.net>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/ConfHandler: Be more strict about variable quoting
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
X-List-Received-Date: Sun, 26 Feb 2012 23:01:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-02-26 at 22:26 +0100, Martin Jansa wrote:
> On Sun, Feb 26, 2012 at 01:04:25PM +0000, Richard Purdie wrote:
> > [cross posted to OE-Core since this is a major change in behaviour but
> > in my opinion, probably a good one]
> 
> Agreed, missing quotes are hard to notice and easy to fix in existing
> recipes with resonable error message provided by this.
>  
> > Currently, bitbake will accept variables in the forms:
> > 
> > X = 1
> > X = '1 \
> > 
> > X = "1"
> > X = '1'
> > 
> > which will all set X=1. This patch removes the first two possibilities
> > and makes quoting mandatory. There is little metadata out there which
> > doesn't quote properly and bitbake will exit with an error about the
> > exact line number and file with any problem so users can easily identify
> > and fix issues. OE-Core has already been checked/fixed.
> 
> Not completly true about OE-Core, but I'll send another patch fixing the
> rest and also meta-oe and meta-smartphone layers..

Right, it looks like I didn't trigger a full reparse. Thanks for the
patches, I've applied the OE-Core one.

Cheers,

Richard



