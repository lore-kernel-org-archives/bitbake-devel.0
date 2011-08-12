Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QrtzM-00072p-HA for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 17:49:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CFiwlP013311;
	Fri, 12 Aug 2011 16:44:58 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12915-04; Fri, 12 Aug 2011 16:44:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CFiqvs013305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2011 16:44:53 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANncyNeZPg8aJ0D6bUkBbSTdLPOomORCaQpajDgN-kGPtQ@mail.gmail.com>
References: <1313159106.14274.490.camel@rex>
	<CA+M6bXm2Pt6FVsKOogg47Wme5T0+G-3AA+7tbNeJSA51QAGGpQ@mail.gmail.com>
	<CABcZANncyNeZPg8aJ0D6bUkBbSTdLPOomORCaQpajDgN-kGPtQ@mail.gmail.com>
Date: Fri, 12 Aug 2011 16:44:12 +0100
Message-ID: <1313163852.14274.506.camel@rex>
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
X-List-Received-Date: Fri, 12 Aug 2011 15:49:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 08:36 -0700, Chris Larson wrote:
> On Fri, Aug 12, 2011 at 8:31 AM, Tom Rini <tom.rini@gmail.com> wrote:
> > On Fri, Aug 12, 2011 at 7:25 AM, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> >> At the moment it bugs me a lot that we only have one effective logging
> >> level for bitbake, despite the logging module having provision to do
> >> more advanced things. This patch:
> >>
> >> * Changes the core log level to the lowest level we have messages of
> >>  (DEBUG-2) so messages always flow through the core logger
> >> * Allows build.py's task logging code to log all the output regardless
> >>  of what output is on the console and sets this so log files now
> >>  always contain debug level messages even if these don't appear
> >>  on the console
> >> * Moves the verbose/debug/debug-domains code to be a UI side setting
> >> * Adds a filter to the UI to only print the user requested output.
> >
> > Can we also get a way (or big enough log level) to get timestamps thrown in?
> 
> I think it would be nice to provide a way to influence the format
> string used by the formatter in the UI, either directly, or via a
> logging configuration file as supported by the logging module.

Agreed, but that one is for a different patch.

Cheers,

Richard



