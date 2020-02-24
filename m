Return-Path: <kergoth@gmail.com>
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
	[209.85.210.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1AA5D606F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 23:06:10 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id r16so10366205otd.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 15:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vqzcJfI+ttKK+jegKE9f/oKfsXizvWc6988ngvcAeLQ=;
	b=CgzpCPVgD9h8NQLPotbuUhHfMWG3xRlCR7oQ2QiVikfoknWHJPRBYVlwTn4RaLGaEn
	WbSvVMVATnUNSzpqxBty6mKKmR7PzvuTcAuR126h1cZ4aCyWk6wGNpVcSbkb7DfxWtmL
	+sYKePVMtEPm8RpFuwGOk7IYuNJXkbrES4CLgF7nwqd20oxOeheJrX9La0nzwVszuXFL
	ODcOGqaytqNJ4kel1A1Yx99z4ZlxkMcjfF3IzuQMWGpZ7BuNS+nOlL5NPDi4xeZ27Ilu
	FLWehp5Edc5RoShge1v52ttQqfBQpOmAx08CEgevtPbe/JU5NnWiQE4JkwT/QCXu3puU
	FN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vqzcJfI+ttKK+jegKE9f/oKfsXizvWc6988ngvcAeLQ=;
	b=S/pqzcje19Istf1t4sJWE6jDv8obwGGshx8I495Lv96OkkB76gIYsU0NmgbuFxAbER
	9zkUN2A5jcs5t24EJ0N37u61fy38nQIgrJbeluFGL3zQadkbAMHgvBJTN5/p+VP10sMZ
	KFgHMOx3Ps5f2LP+XkXZv20uTawnrKDFlEwBwkS7Kw81XFBVkeRXucChp3IXiMc/AIJ8
	El3zNVpFJPY5pfWltJrtOkVnJXfE/D7zjOtoLFhexMz19n18QI8oT1YTIaMZAia3h4Rf
	uEZyJ+vbhal7Ou1RW85vJQu57Kdt/t8G+4JuJRnvb0ZgGFqnw3cZv3aufyYHedyefugb
	BmRQ==
X-Gm-Message-State: APjAAAWuC51F/8TWlMac2+Jhib6CqYpggNQX/Viq4v26gHg95Q9sRdLk
	/4Vf+6K8xSmJUkNpqfWYmvmG8TMwuR5+F/S09mw=
X-Google-Smtp-Source: APXvYqxGm89+hxpEtsazAP4dwLP2gycC+7kh8fXqcetmofL1pDC/YGj7g4QccD8hIoElVWMOupXr/saW2FP5FbHCodA=
X-Received: by 2002:a9d:7:: with SMTP id 7mr40204187ota.26.1582585571593; Mon,
	24 Feb 2020 15:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20200224201629.13774-1-pbarker@konsulko.com>
	<ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
	<CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
	<d79eb8997dcf6635856e574d407c9c805e14326c.camel@linuxfoundation.org>
	<CAM9ZRVtRhBeAdYSeODrxkPOpen3y-7NsJ-jvM5JN+mTO1A+ymA@mail.gmail.com>
In-Reply-To: <CAM9ZRVtRhBeAdYSeODrxkPOpen3y-7NsJ-jvM5JN+mTO1A+ymA@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 24 Feb 2020 16:06:00 -0700
Message-ID: <CABcZANms9EhTWSe=5WfnONjFjx2bTtVgYqx8YTc-MjJDYz7Q9Q@mail.gmail.com>
To: Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/gitsm: Unpack shallow mirror tarballs
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
X-List-Received-Date: Mon, 24 Feb 2020 23:06:11 -0000
Content-Type: multipart/alternative; boundary="000000000000d2543c059f5a6aad"

--000000000000d2543c059f5a6aad
Content-Type: text/plain; charset="UTF-8"

I don't think this is right. This unpacks the shallow tarball into
ud.clonedir. The fetcher is specifically done the way it is to avoid
ud.clonedir ever being shallow so as to avoid having to maintain that state
and convert it when necessary.

On Mon, Feb 24, 2020 at 3:29 PM Paul Barker <pbarker@konsulko.com> wrote:

> On Mon, 24 Feb 2020 at 22:10, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >
> > On Mon, 2020-02-24 at 21:46 +0000, Paul Barker wrote:
> > > On Mon, 24 Feb 2020 at 21:32, Richard Purdie
> > > <richard.purdie@linuxfoundation.org> wrote:
> > > > On Mon, 2020-02-24 at 20:16 +0000, Paul Barker wrote:
> > > > > When a shallow mirror tarball is used to satisfy a gitsm URI it
> > > > > needs to
> > > > > be unpacked so that the .gitmodules file can be examined.
> > > > >
> > > > > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > > > > ---
> > > > >  lib/bb/fetch2/gitsm.py | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > > > > index aa121cbe..98f5dae5 100644
> > > > > --- a/lib/bb/fetch2/gitsm.py
> > > > > +++ b/lib/bb/fetch2/gitsm.py
> > > > > @@ -169,6 +169,12 @@ class GitSM(Git):
> > > > >                  raise
> > > > >
> > > > >          Git.download(self, ud, d)
> > > > > +
> > > > > +        # If we're using a shallow mirror tarball it needs to be
> > > > > unpacked so
> > > > > +        # that we can examine the .gitmodules file
> > > > > +        if ud.shallow and os.path.exists(ud.fullshallow) and
> > > > > Git.need_update(self, ud, d):
> > > > > +            bb.utils.mkdirhier(ud.clonedir)
> > > > > +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d,
> > > > > workdir=ud.clonedir)
> > > > >          self.process_submodules(ud, ud.clonedir,
> > > > > download_submodule, d)
> > > > >
> > > > >      def unpack(self, ud, destdir, d):
> > > >
> > > > Does this mean we're missing a test?
> > >
> > > Possibly. Maybe a two step test with a recipe using a `gitsm://` URL:
> > > 1) Fetch the recipe with BB_GENERATE_MIRROR_TARBALLS,
> > > BB_GENERATE_SHALLOW_TARBALLS and BB_GIT_SHALLOW set. Copy the mirror
> > > tarballs out of the downloads directory to a local mirror directory.
> > > Throw away DL_DIR, SSTATE_DIR and TMPDIR.
> > > 2) Using the mirror generated in step 1 try to fetch and unpack the
> > > recipe.
> > >
> > > Does that sound like a sensible test? I think it would have to go in
> > > oeqa rather than the bitbake tests if we do it that way.
> >
> > It sounds like it might be reasonable, I'm not sure why we can't do
> > that in lib/bb/tests/fetch.py though? There are other tests which do
> > similar sequences of commands.
> >
> > You'd do it with calls to the fetch and unpack Fetcerh APIs and alter a
> > datastore and files in between but I can't see why it would need to be
> > in oeqa?
>
> Ok, I've looked more closely at GitMakeShallowTest in
> lib/bb/tests/fetch.py. We could write a new
> test_shallow_submodule_mirrors function based on
> test_shallow_submodules and test_shallow_mirrors.
>
> The case I would want to catch is do_unpack failing. I guess we could
> check that fetcher.unpack() works as a proxy for that.
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000d2543c059f5a6aad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t think this is right. This unpacks the shallow =
tarball into ud.clonedir. The fetcher is specifically done the way it is to=
 avoid ud.clonedir=C2=A0ever being shallow so as to avoid having to maintai=
n that state and convert it when necessary.</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 24, 2020 at 3:29 PM =
Paul Barker &lt;<a href=3D"mailto:pbarker@konsulko.com">pbarker@konsulko.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Mon, 24 Feb 2020 at 22:10, Richard Purdie<br>
&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank"=
>richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, 2020-02-24 at 21:46 +0000, Paul Barker wrote:<br>
&gt; &gt; On Mon, 24 Feb 2020 at 21:32, Richard Purdie<br>
&gt; &gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt; &gt; On Mon, 2020-02-24 at 20:16 +0000, Paul Barker wrote:<br>
&gt; &gt; &gt; &gt; When a shallow mirror tarball is used to satisfy a gits=
m URI it<br>
&gt; &gt; &gt; &gt; needs to<br>
&gt; &gt; &gt; &gt; be unpacked so that the .gitmodules file can be examine=
d.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Paul Barker &lt;<a href=3D"mailto:pbarke=
r@konsulko.com" target=3D"_blank">pbarker@konsulko.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 lib/bb/fetch2/gitsm.py | 6 ++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/git=
sm.py<br>
&gt; &gt; &gt; &gt; index aa121cbe..98f5dae5 100644<br>
&gt; &gt; &gt; &gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt; &gt; &gt; &gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt; &gt; &gt; &gt; @@ -169,6 +169,12 @@ class GitSM(Git):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 raise<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Git.download(self, ud=
, d)<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we&#39;re using a sha=
llow mirror tarball it needs to be<br>
&gt; &gt; &gt; &gt; unpacked so<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # that we can examine the =
.gitmodules file<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.shallow and os.path.=
exists(ud.fullshallow) and<br>
&gt; &gt; &gt; &gt; Git.need_update(self, ud, d):<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkd=
irhier(ud.clonedir)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(=
&quot;tar -xzf %s&quot; % ud.fullshallow, d,<br>
&gt; &gt; &gt; &gt; workdir=3Dud.clonedir)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_submodul=
es(ud, ud.clonedir,<br>
&gt; &gt; &gt; &gt; download_submodule, d)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 def unpack(self, ud, destdir, d):<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Does this mean we&#39;re missing a test?<br>
&gt; &gt;<br>
&gt; &gt; Possibly. Maybe a two step test with a recipe using a `gitsm://` =
URL:<br>
&gt; &gt; 1) Fetch the recipe with BB_GENERATE_MIRROR_TARBALLS,<br>
&gt; &gt; BB_GENERATE_SHALLOW_TARBALLS and BB_GIT_SHALLOW set. Copy the mir=
ror<br>
&gt; &gt; tarballs out of the downloads directory to a local mirror directo=
ry.<br>
&gt; &gt; Throw away DL_DIR, SSTATE_DIR and TMPDIR.<br>
&gt; &gt; 2) Using the mirror generated in step 1 try to fetch and unpack t=
he<br>
&gt; &gt; recipe.<br>
&gt; &gt;<br>
&gt; &gt; Does that sound like a sensible test? I think it would have to go=
 in<br>
&gt; &gt; oeqa rather than the bitbake tests if we do it that way.<br>
&gt;<br>
&gt; It sounds like it might be reasonable, I&#39;m not sure why we can&#39=
;t do<br>
&gt; that in lib/bb/tests/fetch.py though? There are other tests which do<b=
r>
&gt; similar sequences of commands.<br>
&gt;<br>
&gt; You&#39;d do it with calls to the fetch and unpack Fetcerh APIs and al=
ter a<br>
&gt; datastore and files in between but I can&#39;t see why it would need t=
o be<br>
&gt; in oeqa?<br>
<br>
Ok, I&#39;ve looked more closely at GitMakeShallowTest in<br>
lib/bb/tests/fetch.py. We could write a new<br>
test_shallow_submodule_mirrors function based on<br>
test_shallow_submodules and test_shallow_mirrors.<br>
<br>
The case I would want to catch is do_unpack failing. I guess we could<br>
check that fetcher.unpack() works as a proxy for that.<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--000000000000d2543c059f5a6aad--
