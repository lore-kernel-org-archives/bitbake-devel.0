Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 9EC56731C2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 15:10:56 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id n202so576580oig.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=GCZDi0fM2Bv8+fKTfwixlMcGL7nNs00Ezyx7I0gjwRI=;
	b=otz0ayDELzil+RlzoDNKnN0w2EgFNUSYyGfRtOQvIGG0wTLAtKyAGG34XcZlPeN9Qq
	PIavBp2k8ewrYeeaCSs8LNd2KSxK+09UQ9LP5QAewuHQPuci7j266zN3tpH5J5vhwaew
	VQ6w0ipAm+JyHiilox+xJSX9UIP6MjdpX0m21Qf/thEilVJNdhrB7bnqRi8MhBYy9Ito
	GJMXDb4VtdBYcUVZ2pRZpOL8gTbErCPx9oJCrF9jEJoZNoFvPnqIwT5XeLGjiqkRxBi6
	ot+xj1ei5PN4mPqWXARZiCouijRQE+hhLgi67isu0jAhnwSeQMuwuh0Xn/82DKF+Vt+a
	M1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=GCZDi0fM2Bv8+fKTfwixlMcGL7nNs00Ezyx7I0gjwRI=;
	b=OERJl2rhRmCLAkoonfEk1zcyfOgiZ6TqPp67rLXbexgGCWyjDeLpFamKWcd+a1QxEp
	c8YcVJOKLFHYdxjBq6jzdjpDN/04GLvILSpWsCINwmgg2X3Rbgv4O4yuQ1kIVXeVbuTt
	tGNG9f7lhJMsGgFfZ3I1nceWdYHXov2/0s9qfWoQV8H/RK0/I6EYAaXCS6Wnx/PPBmGm
	rmed6nAyrV5ZeU3UcaBWI3S0KagYtGoBGkJM/4ux+/8ZWP8xNF3lPtDzYWCh/BlDhwQP
	CRgeHmVDjJumSIi1+SYU/aiDtBuwKt8UDeMMpcRI+QYI2k1ffSagbAb2Ouzq1XZCvuGw
	XPgA==
X-Gm-Message-State: AE9vXwMmha/+hmHRVlQ133y+D3IKNn7WWdh2pO+gcJjmIsK0kAKDXC1sw8Pbsc8t2Bb6dDOECVdW8EMpusAcvQ==
X-Received: by 10.202.197.148 with SMTP id v142mr32604376oif.110.1474297857438;
	Mon, 19 Sep 2016 08:10:57 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Mon, 19 Sep 2016 08:10:37 -0700 (PDT)
In-Reply-To: <508fb644-1ed9-8c92-e6ed-e09f52c03e00@siemens.com>
References: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
	<CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
	<508fb644-1ed9-8c92-e6ed-e09f52c03e00@siemens.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 19 Sep 2016 08:10:37 -0700
X-Google-Sender-Auth: a-JMsnzdk6NaK8naXpLMt1VDK9w
Message-ID: <CABcZANn4D8Qog6ukM_7XM65ZY+OymnmD2K8DeipxoVOOaY1FcA@mail.gmail.com>
To: Pascal Bach <pascal.bach@siemens.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: always use premirror first if update is required
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
X-List-Received-Date: Mon, 19 Sep 2016 15:10:57 -0000
Content-Type: multipart/alternative; boundary=001a1134fd2e15ff09053cddb89e

--001a1134fd2e15ff09053cddb89e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2016 at 12:22 AM, Pascal Bach <pascal.bach@siemens.com>
wrote:

> On 16.09.2016 18:20, Christopher Larson wrote:
>
> >
> > On Fri, Sep 16, 2016 at 1:58 AM, Pascal Bach <pascal.bach@siemens.com
> <mailto:pascal.bach@siemens.com>> wrote:
> >
> >     When an update of the local copy is required always try to fetch th=
e
> update
> >     from a premirror first.
> >     The premirror should always have precedence over the upstream
> repository
> >     as updating from there might not work if BB_FETCH_PREMIRRORONLY,
> >     BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.
> >
> >     This also gets rid of the special case for BB_FETCH_PREMIRRORONLY.
> >
> >     Signed-off-by: Pascal Bach <pascal.bach@siemens.com <mailto:
> pascal.bach@siemens.com>>
> >     ---
> >      lib/bb/fetch2/git.py | 9 ++-------
> >      1 file changed, 2 insertions(+), 7 deletions(-)
> >
> >     diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> >     index 1bec60a..cac2a87 100644
> >     --- a/lib/bb/fetch2/git.py
> >     +++ b/lib/bb/fetch2/git.py
> >     @@ -227,13 +227,8 @@ class Git(FetchMethod):
> >              return False
> >
> >          def try_premirror(self, ud, d):
> >     -        # If we don't do this, updating an existing checkout with
> only premirrors
> >     -        # is not possible
> >     -        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
> >     -            return True
> >     -        if os.path.exists(ud.clonedir):
> >     -            return False
> >     -        return True
> >     +        # Always try premirror if an update is required
> >     +        return self.need_update(ud, d)
> >
> >
> > Will this result in fetching a mirror tarball even if you already have =
a
> clone in ud.clonedir? The previous logic always returned False if the
> clonedir existed..
> The tarball should only be fetched if the local ud.clonedir is out of
> date, this means the revision that is requested via SRCREV is not in the
> local repository.
> In the case the revision is present the tarball should not be fetched
> again, at least that was the intention and my local tests didn't indicate
> otherwise.
>

Yes, but it=E2=80=99s better to run =E2=80=98git fetch=E2=80=99 in an out o=
f date clone than to
re-download a 1gb mirror tarball which may well be out of date too.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134fd2e15ff09053cddb89e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Sep 19, 2016 at 12:22 AM, Pascal Bach <span dir=3D"ltr">&lt;<a href=
=3D"mailto:pascal.bach@siemens.com" target=3D"_blank">pascal.bach@siemens.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1mi"=
 class=3D"a3s aXjCH m157415341d53978d">On 16.09.2016 18:20, Christopher Lar=
son wrote:<br>
<span class=3D""><br>
&gt;<br>
&gt; On Fri, Sep 16, 2016 at 1:58 AM, Pascal Bach &lt;<a href=3D"mailto:pas=
cal.bach@siemens.com">pascal.bach@siemens.com</a> &lt;mailto:<a href=3D"mai=
lto:pascal.bach@siemens.com">pascal.bach@siemens.<wbr>com</a>&gt;&gt; wrote=
:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0When an update of the local copy is required always=
 try to fetch the update<br>
&gt;=C2=A0 =C2=A0 =C2=A0from a premirror first.<br>
&gt;=C2=A0 =C2=A0 =C2=A0The premirror should always have precedence over th=
e upstream repository<br>
&gt;=C2=A0 =C2=A0 =C2=A0as updating from there might not work if BB_FETCH_P=
REMIRRORONLY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This also gets rid of the special case for BB_FETCH=
_PREMIRRORONLY.<br>
&gt;<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Pascal Bach &lt;<a href=3D"ma=
ilto:pascal.bach@siemens.com">pascal.bach@siemens.com</a> &lt;mailto:<a hre=
f=3D"mailto:pascal.bach@siemens.com">pascal.bach@siemens.<wbr>com</a>&gt;&g=
t;<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 lib/bb/fetch2/git.py | 9 ++-------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 1 file changed, 2 insertions(+), 7 deletions(-)<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/g=
it.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 1bec60a..cac2a87 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/lib/bb/fetch2/git.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/lib/bb/fetch2/git.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -227,13 +227,8 @@ class Git(FetchMethod):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def try_premirror(self, ud, d):<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we don&#39;t do t=
his, updating an existing checkout with only premirrors<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # is not possible<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;BB_F=
ETCH_<wbr>PREMIRRORONLY&quot;, True) is not None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return T=
rue<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(ud.c=
lonedir):<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return F=
alse<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Always try premirror=
 if an update is required<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.need_updat=
e(ud, d)<br>
&gt;<br>
&gt;<br>
&gt; Will this result in fetching a mirror tarball even if you already have=
 a clone in ud.clonedir? The previous logic always returned False if the cl=
onedir existed..<br>
</span>The tarball should only be fetched if the local ud.clonedir is out o=
f date, this means the revision that is requested via SRCREV is not in the =
local repository.<br>
In the case the revision is present the tarball should not be fetched again=
, at least that was the intention and my local tests didn&#39;t indicate ot=
herwise.<br></div></blockquote><div><br></div><div>Yes, but it=E2=80=99s be=
tter to run =E2=80=98git fetch=E2=80=99 in an out of date clone than to re-=
download a 1gb mirror tarball which may well be out of date too.</div></div=
>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">C=
hristopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenE=
mbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Ment=
or Graphics</div>
</div></div>

--001a1134fd2e15ff09053cddb89e--
