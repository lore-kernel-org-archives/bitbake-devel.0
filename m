Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
	[209.85.167.41])
	by mail.openembedded.org (Postfix) with ESMTP id 7046F7F3B8
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Aug 2019 00:24:59 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id c19so55393216lfm.10
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 03 Aug 2019 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mhVza1eegn8v/XWcW5lxdL096B/pQLrVxbfi98+7GcU=;
	b=Mj4y1kXI0ifH2v8AqqYT+Qx3BlxBXxPMfDlZFl/8u1hSeH1qz+VL4qitCb7ONynxuv
	jr3SPlPEfAGDE011rev+hS6HXICSbNUXjlXx6uuvK0Hy7L2kR0bgo7GkaC24+9PYAJEa
	9HPk7U8mC87fIuNvMDmerhGk/2TiaijY1kmnoOZsAW6FInrL6rjNHjvGq4TDaWJ2E/SP
	uewqgT7OJNHrMwSdjNNPAoZWQgoAuvyyK704GINEr1GoSyqgZ6/cQY+3Hp9e07x5KEYX
	C9zT124JCAE/hbrwIuuW0Z2aDsWX9Se/dd2pWJsGm7g7jkKKDSOC1M9gdEmyaP5UzJ3P
	8L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mhVza1eegn8v/XWcW5lxdL096B/pQLrVxbfi98+7GcU=;
	b=NYvJlDZbH2QxmMo2PhL41jm5OM1715/lIe3ODWeT9c/67ybC5VQe8xKiGE+cvc7uQN
	pL/b/OQ/LaH5yCpwUHU4awpvVV/fRMdEfGGo9MkXBQoEkkqR7qgg+B2B4fa0snjxCYlr
	plOjcBvZJfPaxPgm7oo4Zs/C1E9U/f8fPW7LQ3DMNUD0+PLVDIyRPQ4vyPZbyyvw15q3
	w5pBhER5K3V+D/5nQVNIhyR8tA8oX59Wb2vO7U+966Yra4J34mKJCyUP2Q9CpnMhN362
	LwIctZcd/7tLRjv9bWRO/7Ra+bKRrNKGTGeiQXN9vOfu58jTjpPumjhQijYiG9aOA/SV
	GeYw==
X-Gm-Message-State: APjAAAW6SWfcZgYDQ2/GjPwXUn7W8/ASbva9UdcGmRkfe0bmYLPxYpsf
	favicSWnS7wA4GxHOPuUXpDwZrAHNy4VTF0RSds=
X-Google-Smtp-Source: APXvYqwYcNY4JHiqd4iX36wABn8f1M3OfDwdyvMPCviQWiGWWkF2SU6k1XROB5oH+BXBlK4i8cgtaktwnBuOBlY63TU=
X-Received: by 2002:a19:f007:: with SMTP id p7mr7089041lfc.24.1564878299768;
	Sat, 03 Aug 2019 17:24:59 -0700 (PDT)
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
	<CADySD0F_aEnNsQwjbgfdwet1x-NXNFMQZSYq=UNO+OuoFNLBeQ@mail.gmail.com>
	<d7ddc728-1175-937b-b5ef-eeaab717a8ad@gmail.com>
In-Reply-To: <d7ddc728-1175-937b-b5ef-eeaab717a8ad@gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Sun, 4 Aug 2019 12:24:48 +1200
Message-ID: <CADySD0Hia9Zd+ZSUJrV9PHay_auNBMse-Zdik1VpToG-U0uFBQ@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Sun, 04 Aug 2019 00:24:59 -0000
Content-Type: multipart/alternative; boundary="0000000000002cad43058f3f9f4e"

--0000000000002cad43058f3f9f4e
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2019, 11:45 a.m. Khem Raj, <raj.khem@gmail.com> wrote:

> On 8/3/19 2:34 PM, Ankur Tyagi wrote:
> > Hi Richard,
> >
> > Any input on how it should be handled? I have identified the area like
> > you asked and some ways to fix it as well
> >
> > Thanks
> > Ankur
> >
> > On Sun, 28 Jul 2019, 9:15 p.m. Ankur Tyagi, <ankur.tyagi85@gmail.com
> > <mailto:ankur.tyagi85@gmail.com>> wrote:
> >
> >     How about something like this:
> >
> >     diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> >     index f6b5529b..fa1f9e27 100644
> >     --- a/lib/bb/fetch2/__init__.py
> >     +++ b/lib/bb/fetch2/__init__.py
> >     @@ -380,6 +380,9 @@ def decodeurl(url):
> >               user = ''
> >               pswd = ''
> >
> >     +    if type not in ['git']:
> >     +        path = urllib.parse.unquote(path)
> >     +
> >           p = collections.OrderedDict()
> >           if parm:
> >               for s in parm.split(';'):
> >     @@ -389,7 +392,7 @@ def decodeurl(url):
> >                       s1, s2 = s.split('=')
> >                       p[s1] = s2
> >
> >     -    return type, host, urllib.parse.unquote(path), user, pswd, p
> >     +    return type, host, path, user, pswd, p
>
> It would be good to add some self test for this case as well and patch
> needs to be formatted as per
> https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines
>
> I wanted to get nod on the fix so that I can send v3 of patch. I like your
> idea for self test , any reference on how to do it would be great. Thanks
>



> >
> >       def encodeurl(decoded):
> >           """Encodes a URL from tokens (scheme, network location, path,
> >
> >     regards
> >     Ankur
> >
> >     On Fri, Jul 26, 2019 at 3:13 PM Ankur Tyagi <ankur.tyagi85@gmail.com
> >     <mailto:ankur.tyagi85@gmail.com>> wrote:
> >      >
> >      > Hi,
> >      >
> >      > Previous idea is stupid, please discard that.
> >      > Just checked quote/unquote were added as part of commit
> >      > b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce
> >      >
> >      > So explaining the situation again --> when fecthing from repo url
> >      > https://tfs.local/repos/foo%bar
> >      >
> >      > During FetchData initialization, decodeurl(d.expand(url)) returns
> >     path
> >      > with %20 stripped
> >      >
> >      > [log][__init__][decodeurl] Path returned /repos/foo bar
> >      >
> >      > And when git method urldata_init() is called, it sets gitsrcname
> with
> >      > space instead of %20
> >      >
> >      > [log][git][urldata_init] gitsrcname is tfs.local.repos.foo bar
> >      >
> >      > And when git method _get_repo_url is called, it always returns
> Path
> >      > with space instead of %20
> >      >
> >      > [log][git][_get_repo_url] Path returned /repos/foo bar
> >      >
> >      > So I am bit confused now on how to handle it properly as unquote
> is
> >      > removing %20 and it cannot be added back in later stage.
> >      >
> >      > Regards
> >      > Ankur
> >      >
> >      >
> >      > On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi
> >     <ankur.tyagi85@gmail.com <mailto:ankur.tyagi85@gmail.com>> wrote:
> >      > >
> >      > > Hi,
> >      > >
> >      > > Sorry for the late reply but I have figured out where %20 is
> >     being stripped out.
> >      > >
> >      > > File lib/bb/fetch2/__init__.py, method decodeurl(url) is
> returning
> >      > > path as urllib.parse.unquote(path) which strips out %20
> >      > > So if I return path as it is, then %20 is preserved and works
> >     as expected.
> >      > >
> >      > > diff --git a/lib/bb/fetch2/__init__.py
> b/lib/bb/fetch2/__init__.py
> >      > > index f6b5529b..97fd59e1 100644
> >      > > --- a/lib/bb/fetch2/__init__.py
> >      > > +++ b/lib/bb/fetch2/__init__.py
> >      > > @@ -389,7 +389,7 @@ def decodeurl(url):
> >      > >                  s1, s2 = s.split('=')
> >      > >                  p[s1] = s2
> >      > >
> >      > > -    return type, host, urllib.parse.unquote(path), user, pswd,
> p
> >      > > +    return type, host, path, user, pswd, p
> >      > >
> >      > >
> >      > > Is above change acceptable?
> >      > >
> >      > > Regards
> >      > > Ankur
> >      > >
> >      > > On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie
> >      > > <richard.purdie@linuxfoundation.org
> >     <mailto:richard.purdie@linuxfoundation.org>> wrote:
> >      > > >
> >      > > > On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
> >      > > > > Hi,
> >      > > > >
> >      > > > > Is there something else that needs to be done in this
> patch? Or
> >      > > > > perhaps there is a better to handle this?
> >      > > > > I am willing to learn and try it out if original patch is
> >     not good.
> >      > > >
> >      > > > I think Mark is right, we need to figure out where the %20
> >     characters
> >      > > > are being stripped out and preserve them rather than
> >     injecting them
> >      > > > back in again.
> >      > > >
> >      > > > The question is therefore where they're being stripped out in
> >     the code?
> >      > > >
> >      > > > Cheers,
> >      > > >
> >      > > > Richard
> >      > > >
> >
> >
>
>

--0000000000002cad43058f3f9f4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sun, 4 Aug 2019, 11:45 a.m. Khem Raj, &lt;<a href=
=3D"mailto:raj.khem@gmail.com">raj.khem@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On 8/3/19 2:34 PM, Ankur Tyagi wrote:<br>
&gt; Hi Richard,<br>
&gt; <br>
&gt; Any input on how it should be handled? I have identified the area like=
 <br>
&gt; you asked and some ways to fix it as well<br>
&gt; <br>
&gt; Thanks<br>
&gt; Ankur<br>
&gt; <br>
&gt; On Sun, 28 Jul 2019, 9:15 p.m. Ankur Tyagi, &lt;<a href=3D"mailto:anku=
r.tyagi85@gmail.com" target=3D"_blank" rel=3D"noreferrer">ankur.tyagi85@gma=
il.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:ankur.tyagi85@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">ankur.tyagi85@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0How about something like this:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fet=
ch2/__init__.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0index f6b5529b..fa1f9e27 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/lib/bb/fetch2/__init__.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/lib/bb/fetch2/__init__.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -380,6 +380,9 @@ def decodeurl(url):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user =3D &#39;&#=
39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pswd =3D &#39;&#=
39;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if type not in [&#39;git&#39;]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D urllib.parse.=
unquote(path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D collections.OrderedDict(=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if parm:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for s in parm.sp=
lit(&#39;;&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -389,7 +392,7 @@ def decodeurl(url):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s1, s2 =3D s.split(&#39;=3D&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0p[s1] =3D s2<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 return type, host, urllib.parse.unqu=
ote(path), user, pswd, p<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return type, host, path, user, pswd,=
 p<br>
<br>
It would be good to add some self test for this case as well and patch <br>
needs to be formatted as per <br>
<a href=3D"https://www.openembedded.org/wiki/Commit_Patch_Message_Guideline=
s" rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.openembedded=
.org/wiki/Commit_Patch_Message_Guidelines</a><br>
<br>I wanted to get nod on the fix so that I can send v3 of patch. I like y=
our idea for self test , any reference on how to do it would be great. Than=
ks<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def encodeurl(decoded):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Encodes a UR=
L from tokens (scheme, network location, path,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ankur<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Fri, Jul 26, 2019 at 3:13 PM Ankur Tyagi &lt;<a =
href=3D"mailto:ankur.tyagi85@gmail.com" target=3D"_blank" rel=3D"noreferrer=
">ankur.tyagi85@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ankur.tyagi85@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">ankur.tyagi85@gmail.com</a>&gt;&gt;=
 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Previous idea is stupid, please discard that.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Just checked quote/unquote were added as part=
 of commit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; So explaining the situation again --&gt; when=
 fecthing from repo url<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://tfs.local/repos/foo%bar" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://tfs.local/repos/foo%=
bar</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; During FetchData initialization, decodeurl(d.=
expand(url)) returns<br>
&gt;=C2=A0 =C2=A0 =C2=A0path<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with %20 stripped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [log][__init__][decodeurl] Path returned /rep=
os/foo bar<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; And when git method urldata_init() is called,=
 it sets gitsrcname with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; space instead of %20<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [log][git][urldata_init] gitsrcname is tfs.lo=
cal.repos.foo bar<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; And when git method _get_repo_url is called, =
it always returns Path<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with space instead of %20<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [log][git][_get_repo_url] Path returned /repo=
s/foo bar<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; So I am bit confused now on how to handle it =
properly as unquote is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; removing %20 and it cannot be added back in l=
ater stage.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Ankur<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:ankur.tyagi85@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">ankur.tyagi85@gmail.com</a> &lt;mailto:<a =
href=3D"mailto:ankur.tyagi85@gmail.com" target=3D"_blank" rel=3D"noreferrer=
">ankur.tyagi85@gmail.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; Sorry for the late reply but I have figu=
red out where %20 is<br>
&gt;=C2=A0 =C2=A0 =C2=A0being stripped out.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; File lib/bb/fetch2/__init__.py, method d=
ecodeurl(url) is returning<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; path as urllib.parse.unquote(path) which=
 strips out %20<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; So if I return path as it is, then %20 i=
s preserved and works<br>
&gt;=C2=A0 =C2=A0 =C2=A0as expected.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; diff --git a/lib/bb/fetch2/__init__.py b=
/lib/bb/fetch2/__init__.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; index f6b5529b..97fd59e1 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; @@ -389,7 +389,7 @@ def decodeurl(url):<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 s1, s2 =3D s.split(&#39;=3D&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 p[s1] =3D s2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; -=C2=A0 =C2=A0 return type, host, urllib=
.parse.unquote(path), user, pswd, p<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; +=C2=A0 =C2=A0 return type, host, path, =
user, pswd, p<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; Is above change acceptable?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; Regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; Ankur<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; On Wed, Jul 10, 2019 at 4:33 AM Richard =
Purdie<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank" rel=3D"noreferrer">richard.purdie@linux=
foundation.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:richard.purdie@linuxfo=
undation.org" target=3D"_blank" rel=3D"noreferrer">richard.purdie@linuxfoun=
dation.org</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; On Wed, 2019-07-10 at 21:26 +1200, =
Ankur Tyagi wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; Is there something else that n=
eeds to be done in this patch? Or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; perhaps there is a better to h=
andle this?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; I am willing to learn and try =
it out if original patch is<br>
&gt;=C2=A0 =C2=A0 =C2=A0not good.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; I think Mark is right, we need to f=
igure out where the %20<br>
&gt;=C2=A0 =C2=A0 =C2=A0characters<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; are being stripped out and preserve=
 them rather than<br>
&gt;=C2=A0 =C2=A0 =C2=A0injecting them<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; back in again.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; The question is therefore where the=
y&#39;re being stripped out in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the code?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; Cheers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; Richard<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000002cad43058f3f9f4e--
