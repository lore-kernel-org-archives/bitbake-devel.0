Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 81E686FC48
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 15:17:27 +0000 (UTC)
Received: from [69.196.158.250] (port=39631 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxHc7-00017B-MH; Wed, 18 Jun 2014 11:17:27 -0400
Date: Wed, 18 Jun 2014 11:13:45 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <1413867.iP4Nqeb177@peggleto-mobl5.ger.corp.intel.com>
Message-ID: <alpine.LFD.2.11.1406181111280.28862@localhost>
References: <alpine.LFD.2.11.1406180835440.24706@localhost>
	<1413867.iP4Nqeb177@peggleto-mobl5.ger.corp.intel.com>
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
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake-user-manual-intro.xml: Semantic cleanup, clarifications.
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
X-List-Received-Date: Wed, 18 Jun 2014 15:17:34 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 18 Jun 2014, Paul Eggleton wrote:

> On Wednesday 18 June 2014 08:38:04 Robert P. J. Day wrote:
> > @@ -413,6 +414,18 @@
> >                      you have a directory entitled
> >                      <filename>bitbake-1.17.0</filename>.
> >                      </para></listitem>
> > +                <listitem><para><emphasis>Using the BitBake that comes with
> > your build checkout:</emphasis> +                    A final possibility
> > for getting a copy of BitBake is that it +                    already comes
> > with your checkout of a larger Bitbake-based build system, +
> >     such as Poky or Yocto Project. Rather than manually checking out +
> >               individual layers and gluing them together yourself, you can
> > check +                    out an entire build system such as Poky with
> > something like: +                    <literallayout class='monospaced'>
> > +     $ git clone git://git.yoctoproject.org/poky
> > +                    </literallayout>
> > +                    where that checkout will already include a version of
> > BitBake which +                    has been thoroughly tested for
> > compatibility with the other components. +
> > </para></listitem>
> >              </itemizedlist>
> >          </para>
> >      </section>
>
> Ignoring the mangling that my email client has done, I'm hesitant
> about the latter change. I appreciate the intention and what you've
> added isn't incorrect per se, but the pointer to actually check out
> poky might be a bit too much - I'd rather see a pointer to a
> different document (perhaps the Yocto Project Quick Start guide?).
> Additionally poky doesn't completely free you from fetching and
> incorporating individual layers, just OE-Core / meta-yocto /
> meta-yocto-bsp.

  i see your point, but i still think the reader should at least be
aware that, under normal(?) circumstances, they might not need to go
hunting around for bitbake as they might already have it. i'm totally
open to anyone wanting to reword that.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

