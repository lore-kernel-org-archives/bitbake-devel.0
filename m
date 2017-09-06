Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
	[209.85.213.67])
	by mail.openembedded.org (Postfix) with ESMTP id 6EFE771D97
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 15:50:00 +0000 (UTC)
Received: by mail-vk0-f67.google.com with SMTP id j189so2000135vka.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Sep 2017 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=J63Ubrc6249GfOhvgZjgmeBCpSfy/3eZU7TGgPpHsCo=;
	b=gaJK+NtXSY/ySkLe19GLGRscT5y9n0gDV5CO+lK1nZw5NXwHOR06SD1t5jpv7yP9m9
	OK4Pz/aa/jb1uNzCiQvd3RgwwN5Q5YBJ0Srff1Ct80l1x+1JePgfzDan+0ygw4DUD47I
	XqEvbIA583fNRA7sC4Qzpj0fuuoG/FjoiAhXBpWaT0uIeiDgWToYVkKZmWNx59p0ElPx
	u5+zmncvRUiQl03I6HQozDNxNRbpdPvliMTmYC6MKSVAhYh86qncsEZ3PVrujahlFj0X
	PgaIjUMo9Nkxx/GF/b7uinN+jjoa916Zdz0CQe0fSxW94S/QJS7c9D10CGUDaebrHJuk
	3/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=J63Ubrc6249GfOhvgZjgmeBCpSfy/3eZU7TGgPpHsCo=;
	b=rXWUZgZfrhXnrthUsnWIWfD8+pnRzLG4W7LkqZv+zGgcEgpQ9uBEjOczdDXA8rRl1G
	CaDPlsOGRQEs6nNwV22aUYKcTPVdxTeq1/92s/VX47e/QVoKYx2M109PYyQTai6ZdH6t
	8KWimJS7RR2j4QvSyfmDWWEspDodliM8AlqoGA7d7ArsyMAMoM50TxlaoCoB30If6Owj
	hMSex7u79Y7NkG/dD4JpwfcdA1cOWaZWYjPkTppLqP/0D9tPTvRnnr7WY/w+ay0OsIbU
	y0uRzSWtfFrBNrXyeI0T0b7SvLpzEBnE5wjHNzHnScTEz8320NQGePgJ5TYH+ICmLLT7
	Mqcw==
X-Gm-Message-State: AHPjjUhzNKKbnpXGIbgv9ghpKrOBPvnmKqMaL6jE5xGR8vdUP8efETPB
	JVJ4KOR8/boq9BWpsdwUdp8QSPcz2g==
X-Google-Smtp-Source: ADKCNb7buZNqDp07O/gu3V9OjNEYnldVp7h5ZpX/pN9biUZ8J56+LeZRIVZAzb72SRTilAOqmmoRqA8qwY2wCV6z8E4=
X-Received: by 10.31.227.70 with SMTP id a67mr1600005vkh.17.1504713002196;
	Wed, 06 Sep 2017 08:50:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.18.67 with HTTP; Wed, 6 Sep 2017 08:49:41 -0700 (PDT)
In-Reply-To: <20170906154506.sgehw2rtjdjhl5dk@hiutale>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
	<CABcZANk9n=tSdGFuWzJRJa8GRWBxLGFvugP_3vFW2HUVC7+=kA@mail.gmail.com>
	<20170906154506.sgehw2rtjdjhl5dk@hiutale>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 6 Sep 2017 08:49:41 -0700
Message-ID: <CABcZANnnzoeyFSBRVkfKmvYEgVtHD+gTJUwzjpmBhjp_ZWDUHw@mail.gmail.com>
To: Mikko Rapeli <Mikko.Rapeli@bmw.de>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 1/2] gitsm.py: use download cache for git submodules too
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
X-List-Received-Date: Wed, 06 Sep 2017 15:50:01 -0000
Content-Type: multipart/alternative; boundary="001a114da5f8fc23fe0558874bc4"

--001a114da5f8fc23fe0558874bc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2017 at 8:45 AM, <Mikko.Rapeli@bmw.de> wrote:

> Hi,
>
> On Wed, Sep 06, 2017 at 08:19:55AM -0700, Christopher Larson wrote:
> > On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli <mikko.rapeli@bmw.de>
> wrote:
> >
> > > Currently download caches for recipes using gitsm are filled also wit=
h
> > > the submodule repositories but when the git submodule tree is reused
> from
> > > cache, only the base repository is cloned. After a source URL rewrite=
,
> > > 'git submodule update --init --recursive' is called in the tree
> > > which downloads the needed submodules from upstream URL's.
> > > This wastes bandwidth since download cache already had the needed
> > > commits for the submodule repositories.
> > >
> > > With this change, also the submodule repositories are copied to the
> > > work space from download cache and the download from upstream can
> > > be avoided. Using plain 'cp -a' since git cloning doesn't work for th=
e
> > > submodule directories.
> > >
> >
> > This behavior is both already tracked by a yocto bug, and blindly copyi=
ng
> > will result in breakage when the branch changes in such a way that the
> > submodules change. I already submitted an equivalent patch a week or tw=
o
> > ago and then decided against its inclusion, as it just runs into other
> > failures, specifically there was an oe-selftest that fails if you had
> > previously fetched a different branch of the sources in question, as th=
e
> > upstream url of one of the submodules changes between branches, and we
> > don=E2=80=99t re-fetch existing submodules when their urls change. We d=
efinitely
> > need to fix this, but this fixes one problem and introduces others.
>
> In short: git submodules suck.
>
> git exposes all this yuckyness to users who are confused too if their loc=
al
> submodule repositories stop working between commits.
>

Yeah, submodules are a mess all around, for a number of reasons, but most
of the alternatives have their own idiosyncrasies :)


> > See https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11830 and
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11831 for reference=
.
>
> Ok. I'll use my patch for now until something better comes along
> which avoids cloning tens of repositories on every build.
>
> As for testing, it's possible to setup fake http_proxy environment variab=
le
> and break e.g. http connections to github.com, or in containers to break
> DNS resolution using /etc/hosts or all network connectivity.
>
> Thanks for pushing to fix this issue.
>

No problem. Thinking about it again, I=E2=80=99d support merging your patch=
es as a
workaround for now. It introduces other issues, but those other issues are
likely more minor than re-fetching everything in do_unpack. So we can merge
this and use it until the rewritten fetcher gets merged.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a114da5f8fc23fe0558874bc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Sep 6, 2017 at 8:45 AM,  <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:Mikko.Rapeli@bmw.de" target=3D"_blank">Mikko.Rapeli@bmw.de</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Wed, Sep 06, 2017 at 08:19:55AM -0700, Christopher Larson wrote:<br>
&gt; On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli &lt;<a href=3D"mailto:mik=
ko.rapeli@bmw.de">mikko.rapeli@bmw.de</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Currently download caches for recipes using gitsm are filled also=
 with<br>
&gt; &gt; the submodule repositories but when the git submodule tree is reu=
sed from<br>
&gt; &gt; cache, only the base repository is cloned. After a source URL rew=
rite,<br>
&gt; &gt; &#39;git submodule update --init --recursive&#39; is called in th=
e tree<br>
&gt; &gt; which downloads the needed submodules from upstream URL&#39;s.<br=
>
&gt; &gt; This wastes bandwidth since download cache already had the needed=
<br>
&gt; &gt; commits for the submodule repositories.<br>
&gt; &gt;<br>
&gt; &gt; With this change, also the submodule repositories are copied to t=
he<br>
&gt; &gt; work space from download cache and the download from upstream can=
<br>
&gt; &gt; be avoided. Using plain &#39;cp -a&#39; since git cloning doesn&#=
39;t work for the<br>
&gt; &gt; submodule directories.<br>
&gt; &gt;<br>
&gt;<br>
&gt; This behavior is both already tracked by a yocto bug, and blindly copy=
ing<br>
&gt; will result in breakage when the branch changes in such a way that the=
<br>
&gt; submodules change. I already submitted an equivalent patch a week or t=
wo<br>
&gt; ago and then decided against its inclusion, as it just runs into other=
<br>
&gt; failures, specifically there was an oe-selftest that fails if you had<=
br>
&gt; previously fetched a different branch of the sources in question, as t=
he<br>
&gt; upstream url of one of the submodules changes between branches, and we=
<br>
&gt; don=E2=80=99t re-fetch existing submodules when their urls change. We =
definitely<br>
&gt; need to fix this, but this fixes one problem and introduces others.<br=
>
<br>
</span>In short: git submodules suck.<br>
<br>
git exposes all this yuckyness to users who are confused too if their local=
<br>
submodule repositories stop working between commits.<br></blockquote><div><=
br></div><div>Yeah, submodules are a mess all around, for a number of reaso=
ns, but most of the alternatives have their own idiosyncrasies :)</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt; See <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D118=
30" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.<wbr=
>org/show_bug.cgi?id=3D11830</a> and<br>
&gt; <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11831" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.<wbr>org=
/show_bug.cgi?id=3D11831</a> for reference.<br>
<br>
</span>Ok. I&#39;ll use my patch for now until something better comes along=
<br>
which avoids cloning tens of repositories on every build.<br>
<br>
As for testing, it&#39;s possible to setup fake http_proxy environment vari=
able<br>
and break e.g. http connections to <a href=3D"http://github.com" rel=3D"nor=
eferrer" target=3D"_blank">github.com</a>, or in containers to break<br>
DNS resolution using /etc/hosts or all network connectivity.<br>
<br>
Thanks for pushing to fix this issue.<br></blockquote><div><br></div><div>N=
o problem. Thinking about it again, I=E2=80=99d support merging your patche=
s as a workaround for now. It introduces other issues, but those other issu=
es are likely more minor than re-fetching everything in do_unpack. So we ca=
n merge this and use it until the rewritten fetcher gets merged.=C2=A0</div=
></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth a=
t gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior So=
ftware Engineer, Mentor Graphics</div></div></div></div>
</div></div>

--001a114da5f8fc23fe0558874bc4--
