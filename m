Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TbdqT-0008LP-OK
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 21:58:02 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:33398 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tbdcq-0000Uy-0w; Thu, 22 Nov 2012 15:43:56 -0500
Date: Thu, 22 Nov 2012 15:43:54 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211221531260.7504@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
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
X-List-Received-Date: Thu, 22 Nov 2012 20:58:02 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1014888528-1353617036=:7504"

--8323329-1014888528-1353617036=:7504
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Nov 2012, Chris Larson wrote:

> I would personally like to see something like:
>
> bitbake -E MACHINE,DISTRO,TMPDIR
>
> Rather than having to define additional 'grouping' metadata.
>
> For now, something like this might be convenient:
>
> $ cat ~/bin/bitbake-env
> #!/bin/sh
> #
> # bitbake-env VARIABLE [VARIBLE...]
> #
> # Filter out particular variables from bitbake -e, including the commente=
d out
> # unexpanded form, and both exported and unexported.
>
> args_pattern () {
> =C2=A0 =C2=A0 for arg; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf "$arg|"
> =C2=A0 =C2=A0 done | sed 's,|$,,'
> }
>
> bitbake -e | grep -E "^((export )?|(# )?)($(args_pattern "$@"))=3D"

  ok, but there's still something i'm missing.  from
linux-yocto_3.4.bb, i might want to see the final value of
LINUX_VERSION, but that's not printed as part of the normal
environment, so i'm assuming i'd need to export it first, right?
because there's a lot of content i'd be interested in seeing that is
currently not printed by "bitbake -e".

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

--8323329-1014888528-1353617036=:7504--
