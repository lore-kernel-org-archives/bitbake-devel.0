Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
	[209.85.167.68])
	by mail.openembedded.org (Postfix) with ESMTP id 3C70F7F322
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Aug 2019 21:34:51 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id c9so55228640lfh.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 03 Aug 2019 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=LDEH10ade2PCgXkQ3IHc+ZwD/To5/RFVhb9pjMcKSYM=;
	b=nvd766jZWkGPZdAYWOhE1mGW/SiGnnGdNsWKZpnSrvCwOOKa0GCZak7Xwg6tAaipVf
	BYf3fKPnQn7Aa2UvPZ3T0YeH4EAQe2ZmZcpacI7o/wld2/k/qKpgEwcGHrFwJiu4DKpP
	ybYHShdPBa7mAxvGw/+tmF1APqbjcRtgOYn5ZWHCKKPD/cXdP7CLv3UJf2+WRCqkfqXb
	kC4KysSEb9iAEccGSj0aaoD1L0OdDJ+SKtEIoUM+bW/efFfWirS3NFuTrgyv1mchzK+n
	PF+ieQQp/Nf/4cFrQ21SIDXZeIXCbEkv4P20YdKZXBN68shxvgiJ6cgM58/ORx5r8/K1
	CKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=LDEH10ade2PCgXkQ3IHc+ZwD/To5/RFVhb9pjMcKSYM=;
	b=ZtBlW5v/zlM/krp8UCTgez0LiPJWysfEq39JfwGolj0wyCKWpua7dj0SLJ8Eu/Fwe9
	+H0O6Ld7y1PznUva6adNRuBzr7lvrlMkNgDDcr2OhP+uLpr4SvO3v06RA9y0bgr9FPr/
	9mNc3tEzAJgkB+BNGhA3J+yYf2Ki1DZowoik7LIGKbLs5TsRoMlFguRJBy0IWyMXN6vn
	WFI1/dxWU9eqq7wXZiBDEjxUODKQVAgCnhJNrPIKYRElmCAXVZQGyEsPcsImkfVEKlDd
	0GmFlQbnJA9epojCl80iJL30WzzSNmm6NTgi8aLXP+PjPI8YLcWLI4rcIto4HEMhO3t5
	90hw==
X-Gm-Message-State: APjAAAUEaFXHZpqNmyRnFOLztr/n11jS93L8vHJMY87UTkKZyWamjvmF
	/bFfGD7N1iFHfVXdt+tr8DLVi/BmLYs8z5lSbeFcSndb
X-Google-Smtp-Source: APXvYqxo2IPfvIjZ/4vnzkGmMyx+fXkB/182g7u0A9tcQKi2RYKMrB6ZQNTMCuGk2CIgmH1kTGsOeEBrDacYBNKKY6Q=
X-Received: by 2002:a19:1d1:: with SMTP id 200mr67513270lfb.8.1564868091498;
	Sat, 03 Aug 2019 14:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
	<CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
	<9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
	<CADySD0E7eWVYfEtMk-6+KMnb+WKAMyTEuHLotGQBf8sefFysgg@mail.gmail.com>
	<CADySD0HXOc7RWpVs+nhD3810D3mQc62KiKdsZo0Q5FnEar27GQ@mail.gmail.com>
	<CADySD0EhCzQFTXb40wknh=Fr6VSBVocppVOe_ssuxS5U0vL3vQ@mail.gmail.com>
In-Reply-To: <CADySD0EhCzQFTXb40wknh=Fr6VSBVocppVOe_ssuxS5U0vL3vQ@mail.gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Sun, 4 Aug 2019 09:34:40 +1200
Message-ID: <CADySD0F_aEnNsQwjbgfdwet1x-NXNFMQZSYq=UNO+OuoFNLBeQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Sat, 03 Aug 2019 21:34:51 -0000
Content-Type: multipart/alternative; boundary="000000000000b6d58a058f3d3efa"

--000000000000b6d58a058f3d3efa
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

Any input on how it should be handled? I have identified the area like you
asked and some ways to fix it as well

Thanks
Ankur

On Sun, 28 Jul 2019, 9:15 p.m. Ankur Tyagi, <ankur.tyagi85@gmail.com> wrote:

> How about something like this:
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f6b5529b..fa1f9e27 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -380,6 +380,9 @@ def decodeurl(url):
>          user = ''
>          pswd = ''
>
> +    if type not in ['git']:
> +        path = urllib.parse.unquote(path)
> +
>      p = collections.OrderedDict()
>      if parm:
>          for s in parm.split(';'):
> @@ -389,7 +392,7 @@ def decodeurl(url):
>                  s1, s2 = s.split('=')
>                  p[s1] = s2
>
> -    return type, host, urllib.parse.unquote(path), user, pswd, p
> +    return type, host, path, user, pswd, p
>
>  def encodeurl(decoded):
>      """Encodes a URL from tokens (scheme, network location, path,
>
> regards
> Ankur
>
> On Fri, Jul 26, 2019 at 3:13 PM Ankur Tyagi <ankur.tyagi85@gmail.com>
> wrote:
> >
> > Hi,
> >
> > Previous idea is stupid, please discard that.
> > Just checked quote/unquote were added as part of commit
> > b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce
> >
> > So explaining the situation again --> when fecthing from repo url
> > https://tfs.local/repos/foo%bar
> >
> > During FetchData initialization, decodeurl(d.expand(url)) returns path
> > with %20 stripped
> >
> > [log][__init__][decodeurl] Path returned /repos/foo bar
> >
> > And when git method urldata_init() is called, it sets gitsrcname with
> > space instead of %20
> >
> > [log][git][urldata_init] gitsrcname is tfs.local.repos.foo bar
> >
> > And when git method _get_repo_url is called, it always returns Path
> > with space instead of %20
> >
> > [log][git][_get_repo_url] Path returned /repos/foo bar
> >
> > So I am bit confused now on how to handle it properly as unquote is
> > removing %20 and it cannot be added back in later stage.
> >
> > Regards
> > Ankur
> >
> >
> > On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi <ankur.tyagi85@gmail.com>
> wrote:
> > >
> > > Hi,
> > >
> > > Sorry for the late reply but I have figured out where %20 is being
> stripped out.
> > >
> > > File lib/bb/fetch2/__init__.py, method decodeurl(url) is returning
> > > path as urllib.parse.unquote(path) which strips out %20
> > > So if I return path as it is, then %20 is preserved and works as
> expected.
> > >
> > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > > index f6b5529b..97fd59e1 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -389,7 +389,7 @@ def decodeurl(url):
> > >                  s1, s2 = s.split('=')
> > >                  p[s1] = s2
> > >
> > > -    return type, host, urllib.parse.unquote(path), user, pswd, p
> > > +    return type, host, path, user, pswd, p
> > >
> > >
> > > Is above change acceptable?
> > >
> > > Regards
> > > Ankur
> > >
> > > On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie
> > > <richard.purdie@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
> > > > > Hi,
> > > > >
> > > > > Is there something else that needs to be done in this patch? Or
> > > > > perhaps there is a better to handle this?
> > > > > I am willing to learn and try it out if original patch is not good.
> > > >
> > > > I think Mark is right, we need to figure out where the %20 characters
> > > > are being stripped out and preserve them rather than injecting them
> > > > back in again.
> > > >
> > > > The question is therefore where they're being stripped out in the
> code?
> > > >
> > > > Cheers,
> > > >
> > > > Richard
> > > >
>

--000000000000b6d58a058f3d3efa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Richard,</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Any input on how it should be handled? I have identified the are=
a like you asked and some ways to fix it as well</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Thanks</div><div dir=3D"auto">Ankur<br><br><div cl=
ass=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On S=
un, 28 Jul 2019, 9:15 p.m. Ankur Tyagi, &lt;<a href=3D"mailto:ankur.tyagi85=
@gmail.com">ankur.tyagi85@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">How about something like this:<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index f6b5529b..fa1f9e27 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -380,6 +380,9 @@ def decodeurl(url):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user =3D &#39;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pswd =3D &#39;&#39;<br>
<br>
+=C2=A0 =C2=A0 if type not in [&#39;git&#39;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D urllib.parse.unquote(path)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0p =3D collections.OrderedDict()<br>
=C2=A0 =C2=A0 =C2=A0if parm:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for s in parm.split(&#39;;&#39;):<br>
@@ -389,7 +392,7 @@ def decodeurl(url):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s1, s2 =3D s.=
split(&#39;=3D&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p[s1] =3D s2<=
br>
<br>
-=C2=A0 =C2=A0 return type, host, urllib.parse.unquote(path), user, pswd, p=
<br>
+=C2=A0 =C2=A0 return type, host, path, user, pswd, p<br>
<br>
=C2=A0def encodeurl(decoded):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Encodes a URL from tokens (scheme, ne=
twork location, path,<br>
<br>
regards<br>
Ankur<br>
<br>
On Fri, Jul 26, 2019 at 3:13 PM Ankur Tyagi &lt;<a href=3D"mailto:ankur.tya=
gi85@gmail.com" target=3D"_blank" rel=3D"noreferrer">ankur.tyagi85@gmail.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Previous idea is stupid, please discard that.<br>
&gt; Just checked quote/unquote were added as part of commit<br>
&gt; b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce<br>
&gt;<br>
&gt; So explaining the situation again --&gt; when fecthing from repo url<b=
r>
&gt; <a href=3D"https://tfs.local/repos/foo%bar" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://tfs.local/repos/foo%bar</a><br>
&gt;<br>
&gt; During FetchData initialization, decodeurl(d.expand(url)) returns path=
<br>
&gt; with %20 stripped<br>
&gt;<br>
&gt; [log][__init__][decodeurl] Path returned /repos/foo bar<br>
&gt;<br>
&gt; And when git method urldata_init() is called, it sets gitsrcname with<=
br>
&gt; space instead of %20<br>
&gt;<br>
&gt; [log][git][urldata_init] gitsrcname is tfs.local.repos.foo bar<br>
&gt;<br>
&gt; And when git method _get_repo_url is called, it always returns Path<br=
>
&gt; with space instead of %20<br>
&gt;<br>
&gt; [log][git][_get_repo_url] Path returned /repos/foo bar<br>
&gt;<br>
&gt; So I am bit confused now on how to handle it properly as unquote is<br=
>
&gt; removing %20 and it cannot be added back in later stage.<br>
&gt;<br>
&gt; Regards<br>
&gt; Ankur<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi &lt;<a href=3D"mailto:anku=
r.tyagi85@gmail.com" target=3D"_blank" rel=3D"noreferrer">ankur.tyagi85@gma=
il.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; Sorry for the late reply but I have figured out where %20 is bein=
g stripped out.<br>
&gt; &gt;<br>
&gt; &gt; File lib/bb/fetch2/__init__.py, method decodeurl(url) is returnin=
g<br>
&gt; &gt; path as urllib.parse.unquote(path) which strips out %20<br>
&gt; &gt; So if I return path as it is, then %20 is preserved and works as =
expected.<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.p=
y<br>
&gt; &gt; index f6b5529b..97fd59e1 100644<br>
&gt; &gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; &gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; &gt; @@ -389,7 +389,7 @@ def decodeurl(url):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s1,=
 s2 =3D s.split(&#39;=3D&#39;)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[s=
1] =3D s2<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 return type, host, urllib.parse.unquote(path), use=
r, pswd, p<br>
&gt; &gt; +=C2=A0 =C2=A0 return type, host, path, user, pswd, p<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Is above change acceptable?<br>
&gt; &gt;<br>
&gt; &gt; Regards<br>
&gt; &gt; Ankur<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie<br>
&gt; &gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank" rel=3D"noreferrer">richard.purdie@linuxfoundation.org</a>&gt; w=
rote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:<br>
&gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Is there something else that needs to be done in this p=
atch? Or<br>
&gt; &gt; &gt; &gt; perhaps there is a better to handle this?<br>
&gt; &gt; &gt; &gt; I am willing to learn and try it out if original patch =
is not good.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I think Mark is right, we need to figure out where the %20 c=
haracters<br>
&gt; &gt; &gt; are being stripped out and preserve them rather than injecti=
ng them<br>
&gt; &gt; &gt; back in again.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The question is therefore where they&#39;re being stripped o=
ut in the code?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Cheers,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Richard<br>
&gt; &gt; &gt;<br>
</blockquote></div></div></div>

--000000000000b6d58a058f3d3efa--
