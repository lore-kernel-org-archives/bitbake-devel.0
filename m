Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FBCC6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 15:25:31 +0000 (UTC)
Subject: Re: [PATCH] fetch2: Add checksum capability for crate fetcher
To: bitbake-devel@lists.openembedded.org
From: "Frederic Martinsons" <frederic.martinsons@gmail.com>
X-Originating-Location: Toulouse, Occitanie, FR (88.163.87.27)
X-Originating-Platform: Linux Chrome 111
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 15 Mar 2023 08:25:24 -0700
References: <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
In-Reply-To: <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
Message-ID: <19361.1678893924708828189@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="s8wUT3r0DBZOt9idWjNs"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 15:25:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14566

--s8wUT3r0DBZOt9idWjNs
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 04:03 PM, Alex Kiernan wrote:

>
> On Wed, Mar 15, 2023 at 1:15=E2=80=AFPM Frederic Martinsons
> <frederic.martinsons@gmail.com> wrote:
> >
> > From: Frederic Martinsons <frederic.martinsons@gmail.com>
> >
> > This change brings checksum verification of each crate
> > in a recipe, e.g
> >
> > | SRC_URI +=3D " \
> > |     crate://crates.io/aho-corasick/0.7.20 \
> > |     crate://crates.io/atomic-waker/1.1.0 \
> > |     crate://crates.io/cc/1.0.79 \
> > | "
> > |
> > | SRC_URI[aho-corasick.sha256sum] =3D
> "cc936419f96fa211c1b9166887b38e5e40b19958e5b895be7c1f93adec7071ac"
> > | SRC_URI[atomic-waker.sha256sum] =3D
> "debc29dde2e69f9e47506b525f639ed42300fc014a3e007832592448fa8e4599"
> > | SRC_URI[cc.sha256sum] =3D
> "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
> >
> > That will require to move the checksum initialization
> > after the possible call to urldata_init method in order
> > for the crate fetcher to parse the url.
> >
> > Another way of doing could have been implementing a decodeurl
> > method that would have been specific for each fetcher class.
> >
> > Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
>=20
> I really don't think this is the right direction, at least not by
> default. If a crate is your primary build artefact then this is
> useful:
>=20
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012
>=20
> But doing this for all the dependency crates we're just repeating
> what's in the Cargo.lock which should always be part of the primary
> artefact.
>=20

I see what you mean, but will not be useful for library crate which doesn't=
 have
a Cargo.lock ? As you said in another thread, this use case should not be v=
ery=20
current though (except maybe to run test on it ...).

Another thing I see is that the checkum verification by cargo happen late (=
build step)
comparing to other fetcher which do this during the fetch.

Anyway, it's your call, I don't mind not having this merged... the dev I le=
ad today
allow me to better understand bitbake fetcher and unit tests.

--s8wUT3r0DBZOt9idWjNs
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>On Wed, Mar 15, 2023 at 04:03 PM, Alex Kiernan wrote:</p>

<blockquote>
<p>On Wed, Mar 15, 2023 at 1:15=E2=80=AFPM Frederic Martinsons
<a href=3D"mailto:frederic.martinsons@gmail.com" target=3D"_blank">frederic=
.martinsons@gmail.com</a> wrote:
&gt;
&gt; From: Frederic Martinsons <a href=3D"mailto:frederic.martinsons@gmail.=
com" target=3D"_blank">frederic.martinsons@gmail.com</a>
&gt;
&gt; This change brings checksum verification of each crate
&gt; in a recipe, e.g
&gt;
&gt; | SRC_URI +=3D &quot; \
&gt; |     crate://crates.io/aho-corasick/0.7.20 \
&gt; |     crate://crates.io/atomic-waker/1.1.0 \
&gt; |     crate://crates.io/cc/1.0.79 \
&gt; | &quot;
&gt; |
&gt; | SRC_URI[aho-corasick.sha256sum] =3D
&quot;cc936419f96fa211c1b9166887b38e5e40b19958e5b895be7c1f93adec7071ac&quot=
;
&gt; | SRC_URI[atomic-waker.sha256sum] =3D
&quot;debc29dde2e69f9e47506b525f639ed42300fc014a3e007832592448fa8e4599&quot=
;
&gt; | SRC_URI[cc.sha256sum] =3D
&quot;50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f&quot=
;
&gt;
&gt; That will require to move the checksum initialization
&gt; after the possible call to urldata_init method in order
&gt; for the crate fetcher to parse the url.
&gt;
&gt; Another way of doing could have been implementing a decodeurl
&gt; method that would have been specific for each fetcher class.
&gt;
&gt; Signed-off-by: Frederic Martinsons <a href=3D"mailto:frederic.martinso=
ns@gmail.com" target=3D"_blank">frederic.martinsons@gmail.com</a></p>

<p>I really don't think this is the right direction, at least not by
default. If a crate is your primary build artefact then this is
useful:</p>

<p><a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012" ta=
rget=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012</=
a></p>

<p>But doing this for all the dependency crates we're just repeating
what's in the Cargo.lock which should always be part of the primary
artefact.</p>
</blockquote>

<p>I see what you mean, but will not be useful for library crate which does=
n't have
a Cargo.lock ? As you said in another thread, this use case should not be v=
ery
current though (except maybe to run test on it ...).</p>

<p>Another thing I see is that the checkum verification by cargo happen lat=
e (build step)
comparing to other fetcher which do this during the fetch.</p>

<p>Anyway, it's your call, I don't mind not having this merged... the dev I=
 lead today
allow me to better understand bitbake fetcher and unit tests.</p>

--s8wUT3r0DBZOt9idWjNs--

