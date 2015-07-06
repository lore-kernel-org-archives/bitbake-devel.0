Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id AF2BF75D83
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jul 2015 15:50:20 +0000 (UTC)
Received: by qkbp125 with SMTP id p125so119908676qkb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jul 2015 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=MFk2EIjNW3mDvNZtG+eV1jgwWteDu8gB8yvfTgLTKnQ=;
	b=M925h3i2wnmmovhHpNLLWMleOmn/1t/AXwCmxbI7S7kdjAebSdFD10I9Zg3NHB21kn
	vYslhyLrFwwEoCxwkZL2+MNwfeM4K2sFwIyI2BPdX7pm+Op8lFlEM7WFd4FCQYa71Cfh
	5fR2tZZLIDEAcm6M4zGv4PueilzHley91lMJU2VactO+axl0xRFIwrbJ3XUpMUzr1E90
	ymMYKUFzPP5fUMmtVoP8RHc3n6G5NzQHCti/lTfn5qmh9BeP592vbX1KV6r1Wl50Y3oi
	R/9mpI+gze6+vz0eGAjxUaJB5TQbQb3eErb6DeO2ST1pXTKsuFkEWq6ts676W73tFwKh
	RHBQ==
X-Received: by 10.55.31.17 with SMTP id f17mr96084085qkf.43.1436197820869;
	Mon, 06 Jul 2015 08:50:20 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.99 with HTTP; Mon, 6 Jul 2015 08:50:01 -0700 (PDT)
In-Reply-To: <CAGrhNMzdMS9ckWNHhKL1P=Uta4Q6VbJECzsGx085gDLjcXFCPQ@mail.gmail.com>
References: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
	<CABcZAN=QEu+w5Zv53kXLPgFTFhsFrfQb_jxJbvbCNuymJbKuqA@mail.gmail.com>
	<CAGrhNMzdMS9ckWNHhKL1P=Uta4Q6VbJECzsGx085gDLjcXFCPQ@mail.gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 6 Jul 2015 08:50:01 -0700
X-Google-Sender-Auth: QiYkVgr3as1Fo_B5ULkvOrvmCqk
Message-ID: <CABcZANmZ86Qv+TinMKmei+gHYKhHG3SRR+c9a2cbRocYmQsxrQ@mail.gmail.com>
To: Felipe Tonello <eu@felipetonello.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Remove unecessary code for git submodules
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
X-List-Received-Date: Mon, 06 Jul 2015 15:50:21 -0000
Content-Type: multipart/alternative; boundary=001a1147adeaf0cda5051a36dc0c

--001a1147adeaf0cda5051a36dc0c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2015 at 8:47 AM, Felipe Tonello <eu@felipetonello.com> wrote=
:

> On Mon, Jul 6, 2015 at 4:38 PM, Christopher Larson <clarson@kergoth.com>
> wrote:
> > On Mon, Jul 6, 2015 at 8:13 AM, <eu@felipetonello.com> wrote:
> >>
> >> From: "Felipe F. Tonello" <eu@felipetonello.com>
> >>
> >> Only do git submodule update after upack, otherwise the branch and
> commit
> >> id
> >> will be ignored, causing to run git submodules on a wrong ref.
> >>
> >> Since .gitmodules file is used to check if there is any submodule, we
> >> don't
> >> need to worry about copying .git/modules directory into the unpacked
> >> source
> >> tree.
> >>
> >> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> >
> >
> > We don=E2=80=99t want to be downloading from remote locations in do_unp=
ack, only
> > do_fetch. This patch will result in the opposite, which means the
> submodule
> > sources won=E2=80=99t be included in the git mirror tarball, and it=E2=
=80=99ll be
> impossible
> > to build with BB_NO_NETWORK=3D1. Also -c fetchall won=E2=80=99t result =
in all
> sources
> > having been fetched, which defeats its purpose.
>
> I understand. So Ideally we want to checkout to the right ref before
> doing the git submodule init && update? Because the way it is today it
> doesn't work if the .gitmodules is in a different branch rather then
> the default.
>
> The git submodule init && update was previously in the unpack()
> anyway. Should I remove it?


The init will set up .git/config, and the update will check out the modules
into their appropriate locations in the source tree, so afaik they=E2=80=99=
re still
needed to do that, even though they=E2=80=99re already fetched in .git/modu=
les.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1147adeaf0cda5051a36dc0c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Jul 6, 2015 at 8:47 AM, Felipe Tonello <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:eu@felipetonello.com" target=3D"_blank">eu@felipetonello.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On M=
on, Jul 6, 2015 at 4:38 PM, Christopher Larson &lt;<a href=3D"mailto:clarso=
n@kergoth.com">clarson@kergoth.com</a>&gt; wrote:<br>
&gt; On Mon, Jul 6, 2015 at 8:13 AM, &lt;<a href=3D"mailto:eu@felipetonello=
.com">eu@felipetonello.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: &quot;Felipe F. Tonello&quot; &lt;<a href=3D"mailto:eu@felip=
etonello.com">eu@felipetonello.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Only do git submodule update after upack, otherwise the branch and=
 commit<br>
&gt;&gt; id<br>
&gt;&gt; will be ignored, causing to run git submodules on a wrong ref.<br>
&gt;&gt;<br>
&gt;&gt; Since .gitmodules file is used to check if there is any submodule,=
 we<br>
&gt;&gt; don&#39;t<br>
&gt;&gt; need to worry about copying .git/modules directory into the unpack=
ed<br>
&gt;&gt; source<br>
&gt;&gt; tree.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Felipe F. Tonello &lt;<a href=3D"mailto:eu@felipeto=
nello.com">eu@felipetonello.com</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; We don=E2=80=99t want to be downloading from remote locations in do_un=
pack, only<br>
&gt; do_fetch. This patch will result in the opposite, which means the subm=
odule<br>
&gt; sources won=E2=80=99t be included in the git mirror tarball, and it=E2=
=80=99ll be impossible<br>
&gt; to build with BB_NO_NETWORK=3D1. Also -c fetchall won=E2=80=99t result=
 in all sources<br>
&gt; having been fetched, which defeats its purpose.<br>
<br>
</span>I understand. So Ideally we want to checkout to the right ref before=
<br>
doing the git submodule init &amp;&amp; update? Because the way it is today=
 it<br>
doesn&#39;t work if the .gitmodules is in a different branch rather then<br=
>
the default.<br>
<br>
The git submodule init &amp;&amp; update was previously in the unpack()<br>
anyway. Should I remove it?</blockquote></div><br>The init will set up .git=
/config, and the update will check out the modules into their appropriate l=
ocations in the source tree, so afaik they=E2=80=99re still needed to do th=
at, even though they=E2=80=99re already fetched in .git/modules.<br>-- <br>=
<div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot=
 com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<b=
r>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1147adeaf0cda5051a36dc0c--
