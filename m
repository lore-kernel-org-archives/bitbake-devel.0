Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TbdIm-0007vH-Py
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 21:23:13 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:33233 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tbd59-0002Xz-0w; Thu, 22 Nov 2012 15:09:07 -0500
Date: Thu, 22 Nov 2012 15:09:01 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211221500280.7504@oneiric>
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
X-List-Received-Date: Thu, 22 Nov 2012 20:23:13 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-453993005-1353614947=:7504"

--8323329-453993005-1353614947=:7504
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Nov 2012, Chris Larson wrote:

> On Thu, Nov 22, 2012 at 12:00 PM, Robert P. J. Day <rpjday@crashcourse.ca=
> wrote:
>       =C2=A0 i would find it *massively* useful to have a variation of "b=
itbake
>       -e" print only the values of the variables that i'm interested in;
>       this would be incredibly useful in a classroom if i wanted students=
 to
>       take a look at just those variables related to, say, the kernel.
>
>       =C2=A0 rather than having to hack up something using grep, it would=
 be nice
>       if a user could, say, define an extra variable or class and say
>       something like:
>
>       =C2=A0 $ bitbake -e core-image-minimal --area kernel =C2=A0(or simi=
lar)
>
>       where i could define that the "kernel area" represents the variable=
s
>       such as MACHINE, KMACHINE, KBRANCH, LINUX_KERNEL_TYPE and whatever
>       variables i decide should belong to that "area." =C2=A0then when i'=
m
>       discussing the kernel, i have a simple command that immediately all=
ows
>       the students to see how the kernel was configured.
>
>       =C2=A0 i realize this can't be hard -- just add some filtering code=
 to that
>       part of bitbake that prints everything. =C2=A0thoughts? =C2=A0is th=
ere a way to
>       do this that i'm not seeing?
>
>
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

  ok, i'll check that out when i'm a bit more with it.  just to be
clear what i want again, from a *teaching* perspective, i want the
ability to easily define lists of variables, and ask for those
variables to be printed from the current environment in precisely that
order, since there might be something i'm trying to explain which
involves examining that set of variables in a particular order.

  i can think of all sorts of "groups" that would be handy to examine
uncluttered by the rest of the environment:

 * kernel selection variables
 * build destination directory names
 * current compiler optimization values

and so on.

  i'll play with the above, it might be close to what i'm after.

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

--8323329-453993005-1353614947=:7504--
