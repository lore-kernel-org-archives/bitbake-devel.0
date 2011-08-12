Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qrtzy-00073t-Ry for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 17:50:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CFjcG3013404;
	Fri, 12 Aug 2011 16:45:38 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12915-06; Fri, 12 Aug 2011 16:45:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CFjXfl013398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2011 16:45:33 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZAN=zSAB5pgVk_F2pqgQEu1D=G_aG-rrrm3g8BOGZw2GvjQ@mail.gmail.com>
References: <1313159106.14274.490.camel@rex>
	<CABcZAN=zSAB5pgVk_F2pqgQEu1D=G_aG-rrrm3g8BOGZw2GvjQ@mail.gmail.com>
Date: Fri, 12 Aug 2011 16:44:53 +0100
Message-ID: <1313163893.14274.507.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake/logging: Overhaul internal logging process
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
X-List-Received-Date: Fri, 12 Aug 2011 15:50:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 07:35 -0700, Chris Larson wrote:
> On Fri, Aug 12, 2011 at 7:25 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > -def set_debug_level(level):
> > -    for log in loggers.itervalues():
> > -        log.setLevel(logging.NOTSET)
> > +loggerDefaults = [0, False, []]
> 
> This line is meaningless at first glance. It's impossible to tell what
> these values are intended to mean without finding its usages. Have you
> considered using a different container than a list for this, or just
> using separate variables?

Yes, I'd meant to do something about that but didn't get back around to
it.

Cheers,

Richard




