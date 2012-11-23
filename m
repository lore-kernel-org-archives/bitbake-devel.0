Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tc0Pc-00033H-1i
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 22:03:48 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so6875224lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2012 12:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=leprnTp4ujJIx8C3vLz6CL36iK2xkTOoztxm1/+cFEY=;
	b=qwpF/5ooP91jYwq3vdllXNnX5JSZKi8Lgt7CIXIqtsa+fTFP8vl9U92wDrZZnPdyiK
	2dZjYb/uSvWvTGEpm+2RoItCpIqZUtfJU6Ro5l9vJXKNhfM41EwgVKMgjpaIaQQ7CzsP
	YFf+YIi+dhkYCEWlGGxsxkeLlXfMqORAB+eUE+9L957eQ1cXLHLfTCmfabbf41i9RKMU
	Y744rpRU0+vEhauFuIsqD3B7WaSprLychAXC7hHXvyjGRlGrxWtaOxO2UwOvZiOHjysW
	N5huKce6FAyrrgmoJLZMZ+ia4zFlWy3VuhumyD7UKuBpI7LS+dSUYAtKJ5xGtSbIKDnv
	Iz/w==
Received: by 10.112.45.35 with SMTP id j3mr2293327lbm.82.1353703779952; Fri,
	23 Nov 2012 12:49:39 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Fri, 23 Nov 2012 12:49:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211230823040.2322@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
	<alpine.DEB.2.02.1211221901200.5418@oneiric>
	<CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
	<alpine.DEB.2.02.1211230823040.2322@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 23 Nov 2012 13:49:19 -0700
X-Google-Sender-Auth: fjaF-Q15psojEs55wKKrlaaCtQs
Message-ID: <CABcZANnUf_bm+Oc2N9Er6=Oxdm5kyBm9hNapzchDht4xMxRUmQ@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
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
X-List-Received-Date: Fri, 23 Nov 2012 21:03:48 -0000
Content-Type: multipart/alternative; boundary=bcaec55405c8ef6a9904cf2fb805

--bcaec55405c8ef6a9904cf2fb805
Content-Type: text/plain; charset=UTF-8

On Fri, Nov 23, 2012 at 6:26 AM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

> > What variables are you not seeing? bitbake -e shows all variables
> > but ones which are flagged 'unexport' (e.g. DISTRO, MACHINE). --
>
>   *sigh* ... just ignore my stupidity.  in my fatigue, i totally
> forgot that configuring a pandaboard required adding meta-ti on top of
> straight OE, and there was no yocto-related content involved, but i
> was still remembering all of the variables i could see when i was
> using yocto.
>

Heh, oops, that'd explain it :)

 in any event, i like the bitbake-env script, is it worth adding some
> variant of that to bitbake itself?


I personally think that something like it would be useful in bitbake proper.

FYI, bitbake-env now supports optionally showing function dependencies:

$ bitbake-env -d TARGET_PREFIX
def csl_target_sys(d):
    toolchain_path = d.getVar('EXTERNAL_TOOLCHAIN', True)

    for triplet in d.getVar('CSL_TARGET_SYS', True).split():
        gcc = os.path.join(toolchain_path, 'bin', triplet + '-gcc')
        if os.path.exists(gcc):
            return triplet + '-'
    return 'powerpc-mel-linux-gnuspe-'

# TARGET_PREFIX="${@csl_target_sys(d)}"
TARGET_PREFIX="powerpc-linux-gnu-"

$ bitbake-env -d do_compile
base_do_compile () {
        if [ -e Makefile -o -e makefile -o -e GNUmakefile ]; then
                oe_runmake || die "make failed"
        else
                bbnote "nothing to compile"
        fi
}

do_compile () {
    base_do_compile
}
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--bcaec55405c8ef6a9904cf2fb805
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">On Fri, Nov 23, 2012 at 6:26 AM, Robert P. J. Da=
y <span dir=3D"ltr">&lt;<a href=3D"mailto:rpjday@crashcourse.ca" target=3D"=
_blank">rpjday@crashcourse.ca</a>&gt;</span> wrote:<br><div class=3D"gmail_=
quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">&gt; What variables are you not seeing? =
bitbake -e shows all variables<br>


&gt; but ones which are flagged &#39;unexport&#39; (e.g. DISTRO, MACHINE). =
--<br>
<br>
</div>=C2=A0 *sigh* ... just ignore my stupidity. =C2=A0in my fatigue, i to=
tally<br>
forgot that configuring a pandaboard required adding meta-ti on top of<br>
straight OE, and there was no yocto-related content involved, but i<br>
was still remembering all of the variables i could see when i was<br>
using yocto.<br></blockquote><div><br></div><div>Heh, oops, that&#39;d expl=
ain it :)=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">


=C2=A0in any event, i like the bitbake-env script, is it worth adding some<=
br>
variant of that to bitbake itself?</blockquote></div><br>I personally think=
 that something like it would be useful in bitbake proper.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_e=
xtra">

FYI, bitbake-env now supports optionally showing function dependencies:</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_extra">$ bitbake-env -d TARGET_PREFIX</div><div class=3D"gmail_e=
xtra">

def csl_target_sys(d):</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 toolch=
ain_path =3D d.getVar(&#39;EXTERNAL_TOOLCHAIN&#39;, True)</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=C2=A0 =C2=A0 for tri=
plet in d.getVar(&#39;CSL_TARGET_SYS&#39;, True).split():</div>

<div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 gcc =3D os.path.join=
(toolchain_path, &#39;bin&#39;, triplet + &#39;-gcc&#39;)</div><div class=
=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(gcc):</div><=
div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
triplet + &#39;-&#39;</div>

<div class=3D"gmail_extra">=C2=A0 =C2=A0 return &#39;powerpc-mel-linux-gnus=
pe-&#39;</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a"># TARGET_PREFIX=3D&quot;${@csl_target_sys(d)}&quot;</div><div class=3D"g=
mail_extra">TARGET_PREFIX=3D&quot;powerpc-linux-gnu-&quot;</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=
=3D"gmail_extra">$ bitbake-env -d do_compile</div><div class=3D"gmail_extra=
">base_do_compile () {</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if [ -e Makefile -o -e makefile -o -e GNUmakefile ]; then</div>

<div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 oe_runmake || die &quot;make failed&quot;</div><div class=3D"gmail_=
extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 else</div><div class=3D"gmail_extra">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bbnote &quot;nothing t=
o compile&quot;</div><div class=3D"gmail_extra">

=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi</div><div class=3D"gmail_extra">}</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">do_compile () {<=
/div><div class=3D"gmail_extra">=C2=A0 =C2=A0 base_do_compile</div><div cla=
ss=3D"gmail_extra">}</div></div></div>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics<br>
</div>

--bcaec55405c8ef6a9904cf2fb805--
