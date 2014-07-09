Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 9C0F470466
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 21:42:29 +0000 (UTC)
Received: from [99.240.204.5] (port=59218 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4zdG-0003Yx-Cq; Wed, 09 Jul 2014 17:42:30 -0400
Date: Wed, 9 Jul 2014 17:42:27 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1404941917.15985.63.camel@ted>
Message-ID: <alpine.LFD.2.11.1407091742090.6258@localhost>
References: <alpine.LFD.2.11.1407091107010.10307@localhost>
	<1404941917.15985.63.camel@ted>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: possible clarification of EXPORT_FUNCTIONS for user manual
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
X-List-Received-Date: Wed, 09 Jul 2014 21:42:32 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 9 Jul 2014, Richard Purdie wrote:

> On Wed, 2014-07-09 at 11:14 -0400, Robert P. J. Day wrote:
> >   so, just to make sure i'm understanding this correctly, in section
> > 3.4.5 of BB user manual, discussion of EXPORT_FUNCTIONS talks about
> > the general concept of exporting *functions*, but the entire section
> > uses exclusively "do_" examples, which might mislead the reader into
> > thinking it's good only for *tasks*.
> >
> >   i decided to look through the oe-core layer for examples of
> > exporting an actual function, and i found all of one example -- in
> > meta/classes/debian.bbclass:
> >
> >   python debian_package_name_hook () {
> >       ... snip ...
> >   }
> >   ...
> >   EXPORT_FUNCTIONS package_name_hook
> >
> > which seems like a valid example of exporting a function, except i
> > can't find a single example of this function being used anywhere else.
> > am i missing something?
> >
> >   anyway, i guess my point is that that section could be tweaked to
> > emphasize that exporting works for both functions and tasks, although
> > the only function example i found seems unused. thoughts?
>
> package_name_hook is called by package.bbclass

  whoops, quite so, not sure how i missed that.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

