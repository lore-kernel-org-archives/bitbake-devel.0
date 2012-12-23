Received: from mail-la0-f42.google.com ([209.85.215.42])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TmvW8-0007pj-4f
	for bitbake-devel@lists.openembedded.org;
	Mon, 24 Dec 2012 01:03:45 +0100
Received: by mail-la0-f42.google.com with SMTP id s15so7900335lag.29
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Dec 2012 15:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=dPfxRx0QA9yppOA0mWwNk4RuiwV03P0Cm3QNI9KcEA4=;
	b=P3ngZzZXQR2TKiXfJxVTp4d68qGWuz7QiTJan2ShxrbDxmdpZioaYnZjnu8bYIjPkI
	JR9pOQ8hG0SqR0wGoiqoMMJ6hLcsFM4DAt3jul1PLrrZQlQj5V35Mk1Tt2cJf90Bk8jy
	ue2gozL6tXt7ZTDkSKKzAL/9JN4QefxT3cL3h0u1IPtjqbIUjPvRlV+1kbPb9pPExtAB
	vC4DOqTJnUyMiSxH2Zdzr+xD4PWpdwvughCsiCkV6L+D2gW7rMl/r1MvFGJYpAadSXpf
	rO6FHffe3iribmVayjW7X71GchnYLNp+8QFhwrEQiMnbi+yKWUW8kd3KPo7d2G7Z2sLk
	FvDA==
Received: by 10.112.28.65 with SMTP id z1mr7982868lbg.119.1356306530727; Sun,
	23 Dec 2012 15:48:50 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Sun, 23 Dec 2012 15:48:30 -0800 (PST)
In-Reply-To: <20121223204500.GO8988@jama.palm1.palmone.com>
References: <1356294176-12058-1-git-send-email-Martin.Jansa@gmail.com>
	<CABcZANmR7JKetymVnVD4TorB+DoMXPPN-sQ-BDsDegeWWwph5w@mail.gmail.com>
	<20121223204500.GO8988@jama.palm1.palmone.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 23 Dec 2012 16:48:30 -0700
X-Google-Sender-Auth: CmX3Exs4cu1HoJW4JqOMIRdyixA
Message-ID: <CABcZANmLfGp7WZ2TK9whLq+mn-Sda2wy1E5nGLF5jEPREiFFtQ@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: allow to set EXCLUDE_FROM_WORLD outside recipe
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
X-List-Received-Date: Mon, 24 Dec 2012 00:03:46 -0000
Content-Type: multipart/alternative; boundary=bcaec554d9d6f876d604d18db8c7

--bcaec554d9d6f876d604d18db8c7
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 23, 2012 at 1:45 PM, Martin Jansa <martin.jansa@gmail.com>wrote:

> On Sun, Dec 23, 2012 at 01:36:42PM -0700, Chris Larson wrote:
> > On Sun, Dec 23, 2012 at 1:22 PM, Martin Jansa <martin.jansa@gmail.com
> >wrote:
> >
> > > * sometimes it's useful for distro/builder to set
> EXCLUDE_FROM_WORLD_foo =
> > > "1"
> > >   to exclude recipes not supported by distro/builder in some include
> file
> > >
> > > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> > >
> >
> > EXCLUDE_FROM_WORLD_pn-foo = "1"
>
> I've used what LOCALCOUNT is using, but I can change it to _pn-foo if
> wanted.


The point was, you shouldn't need to patch anything in at all. pn-${PN} is
in OVERRIDES. The above line should work fine as is with no bitbake changes.
-- 
Christopher Larson

--bcaec554d9d6f876d604d18db8c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quo=
te">On Sun, Dec 23, 2012 at 1:45 PM, Martin Jansa <span dir=3D"ltr">&lt;<a =
href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail=
.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb adM"><div class=3D"im">=
On Sun, Dec 23, 2012 at 01:36:42PM -0700, Chris Larson wrote:<br>
&gt; On Sun, Dec 23, 2012 at 1:22 PM, Martin Jansa &lt;<a href=3D"mailto:ma=
rtin.jansa@gmail.com">martin.jansa@gmail.com</a>&gt;wrote:<br>
&gt;<br>
&gt; &gt; * sometimes it&#39;s useful for distro/builder to set EXCLUDE_FRO=
M_WORLD_foo =3D<br>
&gt; &gt; &quot;1&quot;<br>
&gt; &gt; =C2=A0 to exclude recipes not supported by distro/builder in some=
 include file<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gm=
ail.com">Martin.Jansa@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; EXCLUDE_FROM_WORLD_pn-foo =3D &quot;1&quot;<br>
<br>
</div></div>I&#39;ve used what LOCALCOUNT is using, but I can change it to =
_pn-foo if<br>
wanted.</blockquote></div><br>The point was, you shouldn&#39;t need to patc=
h anything in at all. pn-${PN} is in OVERRIDES. The above line should work =
fine as is with no bitbake changes.<br>-- <br>Christopher Larson</div>

</div>

--bcaec554d9d6f876d604d18db8c7--
