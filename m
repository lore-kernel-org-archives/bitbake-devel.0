Return-Path: <evadeflow@gmail.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id 9BA3265CBA
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Sep 2016 19:26:38 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id e124so55380367ith.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Sep 2016 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=AWrH4uYW/P/FFj+nwWsWLYOG1tUNDmwghE2I0eq3t6g=;
	b=MbWGw6rWkbKO0rlvIVdZNvxtZadtJMyDWzkmXN8Kefne/jyFB9Ea63rQyeF7p9M2RF
	D9ETUhgGhTb/ma9FhOg61mGrzbwRXYRaPfzclGshm9ihyC/pZdCXyr3E+B549tJdFuNX
	pnRlg6/LIlzm4MiUSbtsGjMRmQVpT5xuwnxXNKj2G9ZxVzo9U4Ky+8S5abSelizM1e01
	3RVyo4jbk4N2o01W2TDuGev0fRrvvelWDyPS19FtkqlbWXdBPPCHDk9aEYrgxvBd9gs/
	i+f8A9w2yoLNKzua5cDzV0gzKvIfZlw3whr3VEhbKv8TDlHQD1ch3+YlEllW9zYsNqlb
	o3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=AWrH4uYW/P/FFj+nwWsWLYOG1tUNDmwghE2I0eq3t6g=;
	b=BMXjbRCR9ye4bSaud/Nr/S3XNzbA8gKK6D57m/wsP8qjKNSk79UWBTCfXytZeInhU6
	gfsnvA/VKxe+yfEpALyQyiHQX1i12I7EeFSsMy6H7ONTCJ2Qj9GH5c0BHINeGoaPZq2d
	aigHFYpOKKrrifBeW0ShIbr+f6s+XTtw9JoXOs9BhaywTPEeZUji1uWFfe7T57MqMNQM
	GX/UQ/gsCDIUdZUAbe3O599PgvW4yueKSwJOzn++NXAvlh9psTTqR3f8Lx9KuLb2dQ+S
	lt+1ynmmfdrUDYT1F78EOMxsOIi/YYxnI/qhfp91yZ/tGzfp7SPIBToVxqKEGqzPcffz
	ChVg==
X-Gm-Message-State: AE9vXwNGua3DyRHdtmrWitsLksWMnHMkKl6eiClqR5HJe6bRq8DyF00/ubOrOo6JVuOYELy8tjMnyC5oRwTO7Q==
X-Received: by 10.36.147.68 with SMTP id y65mr7408030itd.76.1472844399576;
	Fri, 02 Sep 2016 12:26:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.147.4 with HTTP; Fri, 2 Sep 2016 12:26:39 -0700 (PDT)
In-Reply-To: <1472817465.29583.164.camel@linuxfoundation.org>
References: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
	<1472817465.29583.164.camel@linuxfoundation.org>
From: Evade Flow <evadeflow@gmail.com>
Date: Fri, 2 Sep 2016 15:26:39 -0400
Message-ID: <CAMAb8ZP-oC0Pqgh22KjFk2Py1atsFCP-1KqaKod8XsdN9s0k9w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditionally inherit own-mirrors and set SOURCE_MIRROR_URL?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 02 Sep 2016 19:26:40 -0000
Content-Type: multipart/alternative; boundary=94eb2c08917c3f12db053b8b4f09

--94eb2c08917c3f12db053b8b4f09
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> You could do something like:
...
>
SOURCE_MIRROR_URL ?=3D "{@base_contains('LOCALBUILD', 'local', 'file://xxx'=
, '
http://xxx', d)}"


That's exactly what I was looking for, thanks. I gather I can't put
functions in local.conf, which is where our current build is setting
SOURCE_MIRROR_URL. Can I trouble you to recommend a home for such a
function? It 'feels weird' to put it in a recipe, is there some other,
semi-standard place to stuff helper functions?

On Fri, Sep 2, 2016 at 7:57 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2016-09-01 at 11:29 -0400, Evade Flow wrote:
> > This might be an 'X-Y' problem, so I should explain what I'm trying
> > to achieve. We have a somewhat beefy build server with 32 cores that
> > most of my team likes to `ssh` into to do builds of our Yocto/OE
> > -based BSP. But a few of us build on different machines often enough
> > that I recently spun up a web server=E2=80=94on the 32-core build machi=
ne=E2=80=94to
> > act as a 'pre-mirror' to statically serve  our dependencies for
> > remote builds. The web server is serving the exact same folder that
> > I've been pointing `SOURCE_MIRROR_URL` at, as described at: https://w
> > iki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_source_d
> > ownload_mirror_.3F
> >
> > When I went to integrate support for the HTTP pre-mirror, I ran into
> > the following problem: if I assign `SOURCE_MIRROR_URL` and the
> > specified folder doesn't exist (as will be the case for remote
> > builds), the build *fails*. I had hoped that bitbake would 'fall
> > through' to searching other pre-mirrors, but that doesn't appear to
> > be the case(?)
> >
> > IIs there some way I can use a specific (and *invariant*) local
> > source mirror folder *only if it exists*, and use our internal HTTP
> > pre-mirror otherwise?
>
> You could do something like:
>
> def testislocal(d):
>     if os.path.exists("xxxx")
>         return "local"
>
>   return ""
>
> LOCALBUILD =3D "${@testislocal(d)}"
>
> SOURCE_MIRROR_URL ?=3D "{@base_contains('LOCALBUILD', 'local', 'file://xx=
x',
> 'http://xxx', d)}"
>
> I'm sure there are ways to neaten this up but you get the idea...
>
> Cheers,
>
> Richard
>
>
>
>

--94eb2c08917c3f12db053b8b4f09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; You could do something like:<br>...<br>&gt; <br>
SOURCE_MIRROR_URL=C2=A0?=3D &quot;{@base_contains(&#39;LOCALBUILD&#39;, &#3=
9;local&#39;, &#39;file://xxx&#39;, &#39;<a href=3D"http://xxx" rel=3D"nore=
ferrer" target=3D"_blank">http://xxx</a>&#39;, d)}&quot;<br><br><br>That&#3=
9;s exactly what I was looking for, thanks. I gather I can&#39;t put functi=
ons in local.conf, which is where our current build is setting SOURCE_MIRRO=
R_URL. Can I trouble you to recommend a home for such a function? It &#39;f=
eels weird&#39; to put it in a recipe, is there some other, semi-standard p=
lace to stuff helper functions?<br></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Fri, Sep 2, 2016 at 7:57 AM, Richard Purdie <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" tar=
get=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">On Thu, 2016-09-01 at 11:29=
 -0400, Evade Flow wrote:<br>
&gt; This might be an &#39;X-Y&#39; problem, so I should explain what I&#39=
;m trying<br>
&gt; to achieve. We have a somewhat beefy build server with 32 cores that<b=
r>
&gt; most of my team likes to `ssh` into to do builds of our Yocto/OE<br>
&gt; -based BSP. But a few of us build on different machines often enough<b=
r>
&gt; that I recently spun up a web server=E2=80=94on the 32-core build mach=
ine=E2=80=94to<br>
&gt; act as a &#39;pre-mirror&#39; to statically serve=C2=A0 our dependenci=
es for<br>
&gt; remote builds. The web server is serving the exact same folder that<br=
>
&gt; I&#39;ve been pointing `SOURCE_MIRROR_URL` at, as described at: <a hre=
f=3D"https://w" rel=3D"noreferrer" target=3D"_blank">https://w</a><br>
&gt; <a href=3D"http://iki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_creat=
e_my_own_source_d" rel=3D"noreferrer" target=3D"_blank">iki.yoctoproject.or=
g/wiki/How_<wbr>do_I#Q:_How_do_I_create_my_<wbr>own_source_d</a><br>
&gt; ownload_mirror_.3F<br>
&gt;<br>
&gt; When I went to integrate support for the HTTP pre-mirror, I ran into<b=
r>
&gt; the following problem: if I assign `SOURCE_MIRROR_URL` and the<br>
&gt; specified folder doesn&#39;t exist (as will be the case for remote<br>
&gt; builds), the build *fails*. I had hoped that bitbake would &#39;fall<b=
r>
&gt; through&#39; to searching other pre-mirrors, but that doesn&#39;t appe=
ar to<br>
&gt; be the case(?)<br>
&gt;<br>
&gt; IIs there some way I can use a specific (and *invariant*) local<br>
&gt; source mirror folder *only if it exists*, and use our internal HTTP<br=
>
&gt; pre-mirror otherwise?<br>
<br>
</span>You could do something like:<br>
<br>
def testislocal(d):<br>
=C2=A0 =C2=A0 if os.path.exists(&quot;xxxx&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;local&quot;<br>
<br>
=C2=A0 return &quot;&quot;<br>
<br>
LOCALBUILD =3D &quot;${@testislocal(d)}&quot;<br>
<br>
SOURCE_MIRROR_URL=C2=A0?=3D &quot;{@base_contains(&#39;LOCALBUILD&#39;, &#3=
9;local&#39;, &#39;file://xxx&#39;, &#39;<a href=3D"http://xxx" rel=3D"nore=
ferrer" target=3D"_blank">http://xxx</a>&#39;, d)}&quot;<br>
<br>
I&#39;m sure there are ways to neaten this up but you get the idea...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div><br></div>

--94eb2c08917c3f12db053b8b4f09--
