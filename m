Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TbsUo-0001fP-Be
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 13:36:38 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:35268 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1TbsH9-0007NG-Ki; Fri, 23 Nov 2012 07:22:31 -0500
Date: Fri, 23 Nov 2012 07:22:28 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211230641010.4484@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
	<alpine.DEB.2.02.1211221901200.5418@oneiric>
	<CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
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
Subject: Re: how easy to extend "bitbake -e" to print *selected* subset of variables?
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
X-List-Received-Date: Fri, 23 Nov 2012 12:36:38 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-436910253-1353671605=:4484"
Content-ID: <alpine.DEB.2.02.1211230718160.612@oneiric>

--8323329-436910253-1353671605=:4484
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1211230718161.612@oneiric>

On Thu, 22 Nov 2012, Chris Larson wrote:

> On Thu, Nov 22, 2012 at 5:03 PM, Robert P. J. Day <rpjday@crashcourse.ca>=
 wrote:
>       On Thu, 22 Nov 2012, Chris Larson wrote:
>
> > Yeah, that quick script just ran bitbake -e, not bitbake -e
> > <provider>. You could modify it easily enough to support that,
> > though.
>
> =A0 hang on ... i actually did just that to search the output of:
>
> $ bitbake -e linux-omap4
>
> but i still don't see a number of variables i'm interested in, and
> i'm not sure how to do that.
>
> What variables are you not seeing? bitbake -e shows all variables
> but ones which are flagged 'unexport' (e.g. DISTRO, MACHINE).

  hmmmm ... i think i see my problem.  working from memory, i remember
being able to examine kernel-related variables when using OE to build
a qemuarm system, so i could examine, say, KMETA with:

$ bitbake -e virtual/kernel | grep KMETA
# KMETA=3Dmeta
KMETA=3D"meta"
=09export KMETA=3Dmeta
=09export KMETA=3Dmeta
=09## KMETA branch validation
=09export KMETA=3Dmeta
=09=09# If KMETA is defined, the branch must exist, but a machine branch
    # if KMETA isn't set globally by a recipe using this routine, we need t=
o
    kmeta =3D d.getVar( "KMETA", True ) or "meta"
$

  recently, i used OE and the meta-ti layer to build for pandaboard
but here's what happens when i tried the same thing there:

$ bitbake -e virtual/kernel | grep KMETA
$

  as in, nothing.  i guess i was just assuming i would see similar
information there, i obviously need to look at the meta-ti kernel
recipes more closely.  or should i still be able to see that variable?
it seems like a fairly critical part of the kernel configuration
phase.

rday

--=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--8323329-436910253-1353671605=:4484--
