Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TcOlo-0003Rd-14
	for bitbake-devel@lists.openembedded.org;
	Sun, 25 Nov 2012 00:04:20 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so7284749lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Nov 2012 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=8W3q6Xj9Q/M0UhZLEpE7DEjRwUTgUuEu156GfWsQcr4=;
	b=YbB7cnameDvfcoC0U+35swVCN/zXOdO5Rp3BnLNZ86pC5LPi2gncWsvyBjioJmZfkv
	wdVJB0zE487rQKFAFrk2tiHP8kbJeP6pc5mdJ82GjSsVgqkB+B5pPm8tFrtibQ7hG8Th
	6eZ6t4vQHEGBr3tOLqAqXNI8htxW4Ijyn/gFifs2d39y2/P9dPa5EiB+u2LDiAWPw0/e
	XqLcUqIVc9c4EKBu2heMlzE9KSpRJX87u63k4l0RgkITHJFuIYQpB3Iqh5o7dtNWRq1o
	WCQziNfi8nJjtya8VT7nizwrNr/A5yGDiDUb3Tj0EDLPtaZKT7HpOW0tgxypUlTiRkxX
	LNAQ==
Received: by 10.152.104.44 with SMTP id gb12mr6929131lab.11.1353797410141;
	Sat, 24 Nov 2012 14:50:10 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Sat, 24 Nov 2012 14:49:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211240704590.4794@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
	<alpine.DEB.2.02.1211221901200.5418@oneiric>
	<CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
	<alpine.DEB.2.02.1211230823040.2322@oneiric>
	<CABcZANnUf_bm+Oc2N9Er6=Oxdm5kyBm9hNapzchDht4xMxRUmQ@mail.gmail.com>
	<alpine.DEB.2.02.1211240704590.4794@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 24 Nov 2012 15:49:49 -0700
X-Google-Sender-Auth: V6ca_Hm2XshvlYpICovB_8OYGu0
Message-ID: <CABcZANnf=bx4-YUgaCKPThVKLpH0GQU7E5JwvQa=09=yPH+POQ@mail.gmail.com>
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
X-List-Received-Date: Sat, 24 Nov 2012 23:04:20 -0000
Content-Type: multipart/alternative; boundary=f46d04088ef5bab62e04cf458573

--f46d04088ef5bab62e04cf458573
Content-Type: text/plain; charset=UTF-8

On Sat, Nov 24, 2012 at 5:12 AM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

> > I personally think that something like it would be useful in bitbake
> proper.
> >
> > FYI, bitbake-env now supports optionally showing function dependencies:
> >
> > $ bitbake-env -d TARGET_PREFIX
> > def csl_target_sys(d):
> >     toolchain_path = d.getVar('EXTERNAL_TOOLCHAIN', True)
> >
> >     for triplet in d.getVar('CSL_TARGET_SYS', True).split():
> >         gcc = os.path.join(toolchain_path, 'bin', triplet + '-gcc')
> >         if os.path.exists(gcc):
> >             return triplet + '-'
> >     return 'powerpc-mel-linux-gnuspe-'
> >
> > # TARGET_PREFIX="${@csl_target_sys(d)}"
> > TARGET_PREFIX="powerpc-linux-gnu-"
> >
> > $ bitbake-env -d do_compile
> > base_do_compile () {
> >         if [ -e Makefile -o -e makefile -o -e GNUmakefile ]; then
> >                 oe_runmake || die "make failed"
> >         else
> >                 bbnote "nothing to compile"
> >         fi
> > }
> >
> > do_compile () {
> >     base_do_compile
> > }
>
>   whoa, where *is* this?  is it on tap to be added to bitbake/bin,
> since i think that would be a delightful idea.
>

The latest code at https://gist.github.com/4133101 has it. The new readme
there describes the usage and behavioral differences relative to bitbake -e.

  just to recap, my interest in this sort of thing is not so much for
> debugging as for instruction -- when i last taught an intro class
> in OE/yocto, i made extensive use of the "bitbake-layers" utility when
> explaining and defining layers, and the class loved it, that they
> could see the results of adding a new layer.
>

Ah! Interesting. I hadn't considered the training aspects of that sort of
utility, as I normally just use them in debugging. I'll have to keep that
in mind in the future.
-- 
Christopher Larson

--f46d04088ef5bab62e04cf458573
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Sat, Nov 2=
4, 2012 at 5:12 AM, Robert P. J. Day <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.ca</a>&gt;</s=
pan> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">&gt; I personally think that something l=
ike it would be useful in bitbake proper.<br>


&gt;<br>
&gt; FYI, bitbake-env now supports optionally showing function dependencies=
:<br>
&gt;<br>
&gt; $ bitbake-env -d TARGET_PREFIX<br>
&gt; def csl_target_sys(d):<br>
&gt; =C2=A0 =C2=A0 toolchain_path =3D d.getVar(&#39;EXTERNAL_TOOLCHAIN&#39;=
, True)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 for triplet in d.getVar(&#39;CSL_TARGET_SYS&#39;, True).=
split():<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 gcc =3D os.path.join(toolchain_path, &#39;=
bin&#39;, triplet + &#39;-gcc&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(gcc):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return triplet + &#39;-&#39;=
<br>
&gt; =C2=A0 =C2=A0 return &#39;powerpc-mel-linux-gnuspe-&#39;<br>
&gt;<br>
&gt; # TARGET_PREFIX=3D&quot;${@csl_target_sys(d)}&quot;<br>
&gt; TARGET_PREFIX=3D&quot;powerpc-linux-gnu-&quot;<br>
&gt;<br>
&gt; $ bitbake-env -d do_compile<br>
&gt; base_do_compile () {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -e Makefile -o -e makefile -o -e GNUm=
akefile ]; then<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oe_runmake || =
die &quot;make failed&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bbnote &quot;n=
othing to compile&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; }<br>
&gt;<br>
&gt; do_compile () {<br>
&gt; =C2=A0 =C2=A0 base_do_compile<br>
&gt; }<br>
<br>
</div>=C2=A0 whoa, where *is* this? =C2=A0is it on tap to be added to bitba=
ke/bin,<br>
since i think that would be a delightful idea.<br></blockquote><div><br></d=
iv><div>The latest code at <a href=3D"https://gist.github.com/4133101">http=
s://gist.github.com/4133101</a> has it. The new readme there describes the =
usage and behavioral differences relative to bitbake -e.</div>

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
=C2=A0 just to recap, my interest in this sort of thing is not so much for<=
br>
debugging as for instruction -- when i last taught an intro class<br>
in OE/yocto, i made extensive use of the &quot;bitbake-layers&quot; utility=
 when<br>
explaining and defining layers, and the class loved it, that they<br>
could see the results of adding a new layer.<br></blockquote><div><br></div=
><div>Ah! Interesting. I hadn&#39;t considered the training aspects of that=
 sort of utility, as I normally just use them in debugging. I&#39;ll have t=
o keep that in mind in the future.</div>

</div>-- <br>Christopher Larson<br>
</div>

--f46d04088ef5bab62e04cf458573--
