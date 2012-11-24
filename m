Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TcEoZ-0003eS-60
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Nov 2012 13:26:31 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:34321 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1TcEas-0003BE-OP; Sat, 24 Nov 2012 07:12:22 -0500
Date: Sat, 24 Nov 2012 07:12:19 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANnUf_bm+Oc2N9Er6=Oxdm5kyBm9hNapzchDht4xMxRUmQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211240704590.4794@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
	<alpine.DEB.2.02.1211221901200.5418@oneiric>
	<CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
	<alpine.DEB.2.02.1211230823040.2322@oneiric>
	<CABcZANnUf_bm+Oc2N9Er6=Oxdm5kyBm9hNapzchDht4xMxRUmQ@mail.gmail.com>
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
X-List-Received-Date: Sat, 24 Nov 2012 12:26:31 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1243039917-1353759142=:4794"

--8323329-1243039917-1353759142=:4794
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Nov 2012, Chris Larson wrote:

> On Fri, Nov 23, 2012 at 6:26 AM, Robert P. J. Day <rpjday@crashcourse.ca>=
 wrote:

>       > What variables are you not seeing? bitbake -e shows all variables
>       > but ones which are flagged 'unexport' (e.g. DISTRO, MACHINE). --
>
> =C2=A0 *sigh* ... just ignore my stupidity. =C2=A0in my fatigue, i totall=
y
> forgot that configuring a pandaboard required adding meta-ti on top
> of straight OE, and there was no yocto-related content involved, but
> i was still remembering all of the variables i could see when i was
> using yocto.
>
> Heh, oops, that'd explain it :)=C2=A0

  yeah, that was one of those facepalm moments,

http://media.photobucket.com/image/recent/KoalaMeatPie/618px-JeanLucPicardF=
acepalm.jpg

> I personally think that something like it would be useful in bitbake prop=
er.
>
> FYI, bitbake-env now supports optionally showing function dependencies:
>
> $ bitbake-env -d TARGET_PREFIX
> def csl_target_sys(d):
> =C2=A0 =C2=A0 toolchain_path =3D d.getVar('EXTERNAL_TOOLCHAIN', True)
>
> =C2=A0 =C2=A0 for triplet in d.getVar('CSL_TARGET_SYS', True).split():
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gcc =3D os.path.join(toolchain_path, 'bin', t=
riplet + '-gcc')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(gcc):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return triplet + '-'
> =C2=A0 =C2=A0 return 'powerpc-mel-linux-gnuspe-'
>
> # TARGET_PREFIX=3D"${@csl_target_sys(d)}"
> TARGET_PREFIX=3D"powerpc-linux-gnu-"
>
> $ bitbake-env -d do_compile
> base_do_compile () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -e Makefile -o -e makefile -o -e GNUmake=
file ]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oe_runmake || die=
 "make failed"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bbnote "nothing t=
o compile"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
> }
>
> do_compile () {
> =C2=A0 =C2=A0 base_do_compile
> }

  whoa, where *is* this?  is it on tap to be added to bitbake/bin,
since i think that would be a delightful idea.

  just to recap, my interest in this sort of thing is not so much for
debugging as for instruction -- when i last taught an intro class
in OE/yocto, i made extensive use of the "bitbake-layers" utility when
explaining and defining layers, and the class loved it, that they
could see the results of adding a new layer.

  so something similar for the environment would be just ducky.  of
course, i really should learn python one of these days so i could do
this sort of thing myself.  soon ...

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

--8323329-1243039917-1353759142=:4794--
