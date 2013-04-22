Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1UUL1h-0001ul-B4
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 19:59:42 +0200
Received: from cpebcc8100de718-cmbcc8100de715.cpe.net.cable.rogers.com
	([99.240.144.66]:39685 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1UUK3f-0006pO-SJ; Mon, 22 Apr 2013 12:57:39 -0400
Date: Mon, 22 Apr 2013 12:57:36 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Trevor Woerner <twoerner@gmail.com>
In-Reply-To: <CAHUNapQoJ4kOsEMZ-FB9gcSVQcU0ZcY2EfOOGcAGScvueHXHAw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1304221256590.10667@oneiric>
References: <1366640172.23738.12.camel@ted>
	<CAHUNapQoJ4kOsEMZ-FB9gcSVQcU0ZcY2EfOOGcAGScvueHXHAw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
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
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Mon, 22 Apr 2013 17:59:45 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 22 Apr 2013, Trevor Woerner wrote:

> On Mon, Apr 22, 2013 at 10:16 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
> > We'd add in some kind of
> > timeout of say 15 minutes so that it would gracefully exit.
>
> Hopefully this time-out will start at the completion of the most
> recent bitbake command, rather than from its start?
>
> > The reason for doing this is simple, it would allow commands to be much
> > more responsive rather than having the cache/configuration loading each
> > time which is where our current overhead is.
>
> This sounds like a very nice feature to have.
>
> > This would then lead into the second proposal which is to add better
> > support for new commands.
>
> It would be nice if there was a way to zero-in on an existing
> environment variable. For example:
>
>     $ bitbake -e <image>
>
> produces a lot of information which I then have to parse in order to
> figure out how a given environment variable is being set. It would be
> nice if I could simply:
>
>     $ bitbake -e <image> <variable>
>
> and just get the pertinent parts.

  i think bitbake-env would do this for you.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


