Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TcxTl-0002uk-Dz
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 13:08:01 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:40098 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1TcxG2-0000Ur-RG; Mon, 26 Nov 2012 06:53:50 -0500
Date: Mon, 26 Nov 2012 06:53:48 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <29436129.kTOWlB2TST@helios>
Message-ID: <alpine.DEB.2.02.1211260640170.4700@oneiric>
References: <alpine.DEB.2.02.1211240910580.934@oneiric>
	<29436129.kTOWlB2TST@helios>
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
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: wanting clarification on overrides, _append, += and combinations of those
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
X-List-Received-Date: Mon, 26 Nov 2012 12:08:01 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 26 Nov 2012, Paul Eggleton wrote:

> On Saturday 24 November 2012 09:23:20 Robert P. J. Day wrote:
> >   preparing my own write-up on how bitbake processes combinations of
> > overrides, _append and += and ran across an example in oe-core that is
> > unnecessarily whitespacey, just wanted to make sure i was
> > understanding this properly.
> >
> >   in the current bitbake user manual, there's this example of mixing
> > overrides, _append and +=:
> >
> >   OVERRIDES = "foo"
> >   A_foo_append = "X"
> >   A_foo_append += "Y"
> >
> >   This behaves as per the first case above, but the value of A would
> >   be "X Y" instead of just "X".
> >
> >   that, of course, makes sense as the "+=" operator automatically adds
> > a leading space to what is being appended.  so for fun, i scanned all
> > of oe-core looking for examples of "_append.*+=" for classroom demo
> > purposes, and the *only* examples i found were in
> > meta/recipes-devtools/python/python-smartpm_1.4.1.bb:
> >
> > RDEPENDS_python-smartpm_append = " python-smartpm-backend-rpm python-codecs
> > python-textutils python-xml" RDEPENDS_python-smartpm_append += "
> > python-fcntl python-pickle python-crypt python-compression python-shell"
> > RDEPENDS_python-smartpm_append += " python-resource python-netclient
> > python-threading python-unixadmin"
> >
> >   i can see that that first line *does* need an explicit leading space
> > in the value being assigned, but the next two "+=" lines don't, do
> > they?  it won't hurt, of course, you'll just *two* spaces inserted
> > instead of one.  but i just want to make sure i understand what's
> > happening there since it has the potential to be confusing for someone
> > trying to follow along.
>
> I would strongly discourage the use of += in conjunction with _append because
> the intent is unclear - I think we've discussed this before ...

  yes, i've whined about this sort of thing before :-P, not because it
makes any *functional* difference but because (and i know i've said
this before) when i teach OE/yocto, i like to use examples right out
of the source code, and oddities like the above sometimes cause
students to wonder if perhaps they've misunderstood something when
they see something like that.  it's a perfect example where telling
someone to RTFS can actually be counter-productive.

> Ideally this would just be done as a += split onto multiple lines
> and I will make sure it gets changed to that if someone else doesn't
> get to it first.

  help yourself.  on a related note, though, note that this feature is
described in the bitbake user manual which, while it's not clear where
to find it online, is in the bitbake git repo where one can build it.
so two questions.

  first, is the *individual* bitbake user manual considered part of
the official yocto documentation?  should it be listed here?

  https://www.yoctoproject.org/documentation

if not, where should one go online to read it?  is it regularly
rebuilt from the bitbake/doc directory?  and published where?  there
are enough references to the bitbake user manual that people should
know where to find it easily.

  also, WRT the above, it's the bitbake user manual itself that shows
the reader how to do this:

OVERRIDES = "foo"
A_foo_append = "X"
A_foo_append += "Y"

without perhaps explaining that that's a really weird thing to do and
should be discouraged.  so there's a definite logical disconnect
between things that are deprecated while still being explained in the
user manual.

  just my $0.02.  another doc note coming shortly ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================




