Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TbgxM-0003MH-Pt
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 01:17:23 +0100
Received: from cpe78cd8ec96008-cm78cd8ec96005.cpe.net.cable.rogers.com
	([99.241.167.182]:40454 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tbgji-0006DT-Pv; Thu, 22 Nov 2012 19:03:14 -0500
Date: Thu, 22 Nov 2012 19:03:08 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211221901200.5418@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
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
X-List-Received-Date: Fri, 23 Nov 2012 00:17:23 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1103249151-1353628994=:5418"

--8323329-1103249151-1353628994=:5418
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Nov 2012, Chris Larson wrote:

> Yeah, that quick script just ran bitbake -e, not bitbake -e
> <provider>. You could modify it easily enough to support that,
> though.

  hang on ... i actually did just that to search the output of:

$ bitbake -e linux-omap4

but i still don't see a number of variables i'm interested in, and i'm
not sure how to do that.

> You could also try out https://gist.github.com/4133101. It's just a
> quick prototype. Drop it next to bitbake in bitbake/bin/. It fixes a
> couple minor annoyances with bitbake -e and it sends all the bitbake
> log output from stdout to stderr, so you can redirect that
> independently of the emitted variables and values.
>
> Usage examples:
>
> =C2=A0 =C2=A0 bitbake-env DISTRO MACHINE do_configure
> =C2=A0 =C2=A0 bitbake-env -r virtual/kernel FILE
> =C2=A0 =C2=A0 eval $(bitbake-env TMPDIR | grep -v '^#')

  ok, i'll check that out, thanks.

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

--8323329-1103249151-1353628994=:5418--
