Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TbtUn-0002LJ-2R
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 14:40:42 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:36404 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1TbtH3-0002sj-87; Fri, 23 Nov 2012 08:26:29 -0500
Date: Fri, 23 Nov 2012 08:26:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211230823040.2322@oneiric>
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
X-List-Received-Date: Fri, 23 Nov 2012 13:40:42 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-209999374-1353677189=:2322"

--8323329-209999374-1353677189=:2322
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Nov 2012, Chris Larson wrote:

>
>
> On Thu, Nov 22, 2012 at 5:03 PM, Robert P. J. Day <rpjday@crashcourse.ca>=
 wrote:
>       On Thu, 22 Nov 2012, Chris Larson wrote:
>
> > Yeah, that quick script just ran bitbake -e, not bitbake -e
> > <provider>. You could modify it easily enough to support that,
> > though.
>
> =C2=A0 hang on ... i actually did just that to search the output of:
>
> $ bitbake -e linux-omap4
>
> but i still don't see a number of variables i'm interested in, and
> i'm not sure how to do that.
>
> What variables are you not seeing? bitbake -e shows all variables
> but ones which are flagged 'unexport' (e.g. DISTRO, MACHINE). --

  *sigh* ... just ignore my stupidity.  in my fatigue, i totally
forgot that configuring a pandaboard required adding meta-ti on top of
straight OE, and there was no yocto-related content involved, but i
was still remembering all of the variables i could see when i was
using yocto.

 in any event, i like the bitbake-env script, is it worth adding some
variant of that to bitbake itself?

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

--8323329-209999374-1353677189=:2322--
