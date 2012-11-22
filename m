Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tbg8R-0002aa-Gp
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 00:24:43 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so6300883lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=wQPc1Cqa+uhSK+Kha8JTjRzPoPasp8FwTzUegsooc6Q=;
	b=Oehv7Ch9gVakz55Z/JledmdDWRGQBIqfXwpyvGO609IpUKCNUYE2VKmUHiBrOPcXFc
	gi4R0qsB9l7TvaLvisDwRWXeFQY8sILWhRvMnQgn0bFbkFg/KsbN5RSgzElDOwXmBCYh
	GJGJXfIukHNX0E6WGGOYKQfEtFRxUgBHXmN9/C4Jk6ERHaqEr6RQpsq4/JiWflUzogh4
	mShdIp8oiWkUTspGwSB/y141uVBemNy7eSRBrd0fstC8Eg6IVag+2MtqOTYrIvjqWU9U
	paTCJAC1+9EN+A4tHnDeqk9c/j4mzHLyZG1mt3a6hSYMUyoTQXKM/I1Zw1ToAxfbIFR6
	CtUw==
Received: by 10.112.47.233 with SMTP id g9mr1146193lbn.11.1353625836409; Thu,
	22 Nov 2012 15:10:36 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Thu, 22 Nov 2012 15:10:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211221531260.7504@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 22 Nov 2012 16:10:15 -0700
X-Google-Sender-Auth: v9CUebzO5BRi2rdftwV7yAPw7qg
Message-ID: <CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
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
X-List-Received-Date: Thu, 22 Nov 2012 23:24:43 -0000
Content-Type: multipart/alternative; boundary=bcaec554d4562353f804cf1d93d6

--bcaec554d4562353f804cf1d93d6
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 22, 2012 at 1:43 PM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

> On Thu, 22 Nov 2012, Chris Larson wrote:
>
> > I would personally like to see something like:
> >
> > bitbake -E MACHINE,DISTRO,TMPDIR
> >
> > Rather than having to define additional 'grouping' metadata.
> >
> > For now, something like this might be convenient:
> >
> > $ cat ~/bin/bitbake-env
> > #!/bin/sh
> > #
> > # bitbake-env VARIABLE [VARIBLE...]
> > #
> > # Filter out particular variables from bitbake -e, including the
> commented out
> > # unexpanded form, and both exported and unexported.
> >
> > args_pattern () {
> >     for arg; do
> >         printf "$arg|"
> >     done | sed 's,|$,,'
> > }
> >
> > bitbake -e | grep -E "^((export )?|(# )?)($(args_pattern "$@"))="
>
>   ok, but there's still something i'm missing.  from
> linux-yocto_3.4.bb, i might want to see the final value of
> LINUX_VERSION, but that's not printed as part of the normal
> environment, so i'm assuming i'd need to export it first, right?
> because there's a lot of content i'd be interested in seeing that is
> currently not printed by "bitbake -e".


Yeah, that quick script just ran bitbake -e, not bitbake -e <provider>. You
could modify it easily enough to support that, though.

You could also try out https://gist.github.com/4133101. It's just a quick
prototype. Drop it next to bitbake in bitbake/bin/. It fixes a couple minor
annoyances with bitbake -e and it sends all the bitbake log output from
stdout to stderr, so you can redirect that independently of the emitted
variables and values.

Usage examples:

    bitbake-env DISTRO MACHINE do_configure
    bitbake-env -r virtual/kernel FILE
    eval $(bitbake-env TMPDIR | grep -v '^#')
-- 
Christopher Larson

--bcaec554d4562353f804cf1d93d6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">On Thu, Nov 22, 2012 at 1:43 PM, Robert P. J. Da=
y <span dir=3D"ltr">&lt;<a href=3D"mailto:rpjday@crashcourse.ca" target=3D"=
_blank">rpjday@crashcourse.ca</a>&gt;</span> wrote:<br><div class=3D"gmail_=
quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Thu, 22 Nov 2012, Chris Larson wrote:=
<br>


<br>
</div><div class=3D"im">&gt; I would personally like to see something like:=
<br>
&gt;<br>
&gt; bitbake -E MACHINE,DISTRO,TMPDIR<br>
&gt;<br>
&gt; Rather than having to define additional &#39;grouping&#39; metadata.<b=
r>
&gt;<br>
&gt; For now, something like this might be convenient:<br>
&gt;<br>
&gt; $ cat ~/bin/bitbake-env<br>
&gt; #!/bin/sh<br>
&gt; #<br>
&gt; # bitbake-env VARIABLE [VARIBLE...]<br>
&gt; #<br>
&gt; # Filter out particular variables from bitbake -e, including the comme=
nted out<br>
&gt; # unexpanded form, and both exported and unexported.<br>
&gt;<br>
&gt; args_pattern () {<br>
&gt; =C2=A0 =C2=A0 for arg; do<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;$arg|&quot;<br>
&gt; =C2=A0 =C2=A0 done | sed &#39;s,|$,,&#39;<br>
&gt; }<br>
&gt;<br>
&gt; bitbake -e | grep -E &quot;^((export )?|(# )?)($(args_pattern &quot;$@=
&quot;))=3D&quot;<br>
<br>
</div>=C2=A0 ok, but there&#39;s still something i&#39;m missing. =C2=A0fro=
m<br>
<a href=3D"http://linux-yocto_3.4.bb" target=3D"_blank">linux-yocto_3.4.bb<=
/a>, i might want to see the final value of<br>
LINUX_VERSION, but that&#39;s not printed as part of the normal<br>
environment, so i&#39;m assuming i&#39;d need to export it first, right?<br=
>
because there&#39;s a lot of content i&#39;d be interested in seeing that i=
s<br>
currently not printed by &quot;bitbake -e&quot;.</blockquote></div><br>Yeah=
, that quick script just ran bitbake -e, not bitbake -e &lt;provider&gt;. Y=
ou could modify it easily enough to support that, though.</div><div class=
=3D"gmail_extra">

<br></div><div class=3D"gmail_extra">You could also try out <a href=3D"http=
s://gist.github.com/4133101">https://gist.github.com/4133101</a>. It&#39;s =
just a quick prototype. Drop it next to bitbake in bitbake/bin/. It fixes a=
 couple minor annoyances with bitbake -e and it sends all the bitbake log o=
utput from stdout to stderr, so you can redirect that independently of the =
emitted variables and values.</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Usage examp=
les:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
=C2=A0 =C2=A0 bitbake-env DISTRO MACHINE do_configure</div><div class=3D"gm=
ail_extra">=C2=A0 =C2=A0 bitbake-env -r virtual/kernel FILE</div>

<div class=3D"gmail_extra">=C2=A0 =C2=A0 eval $(bitbake-env TMPDIR | grep -=
v &#39;^#&#39;)</div><div class=3D"gmail_extra">-- <br>Christopher Larson<b=
r>
</div>

--bcaec554d4562353f804cf1d93d6--
