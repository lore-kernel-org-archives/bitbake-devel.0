Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 3515E60125
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 17:15:01 +0000 (UTC)
Received: by iodv127 with SMTP id v127so143271771iod.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=6eUQiB5wOOhrZaOi/FvEr675w2d3aR/+wi8rVtgo/z4=;
	b=xD4e8RR3RsCZSsh9bCm9QNI4zWyNSdTFY+wDa1PIgPcw4LFj7ajT1Kd979foLA8pQX
	ZvHyS9mCj/Yu0DmA4GRF8B+K+Babb22OXa7TgwPETpn5I4NL4M9aG1Eszt33XWOPOZUf
	Vw/rGgP6bNclOJb0jNwq72vqo7Dg1nby2BNMRR7PLJy0BiFbsVw/sTOsTu4SmCSeftfc
	xr4W+jizfZhlKSwjq7n8l59gdPQlJb8BiQAJY98kOksFzPyPvW0oG5PYZaQitBGvAMY+
	FrklBhzisy1SqVHYySS86Yo2iFHxx0JflCAzGlKr3EcftCI+yIAVpAb0NqFbzCB1qgqi
	8U0w==
X-Received: by 10.107.128.152 with SMTP id k24mr2357761ioi.74.1439831701539;
	Mon, 17 Aug 2015 10:15:01 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.118.150 with HTTP; Mon, 17 Aug 2015 10:14:42 -0700 (PDT)
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 17 Aug 2015 10:14:42 -0700
X-Google-Sender-Auth: lP6B6Xfa-hom0I2zcSChetJA3dE
Message-ID: <CABcZANmRiwsaJkKMorX9eyBup2g2q=0bjdfnZ8OrEN9bwQMBLQ@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/13] Fixes and refactoring
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
X-List-Received-Date: Mon, 17 Aug 2015 17:15:03 -0000
Content-Type: multipart/alternative; boundary=001a113f8efa1b525a051d84f18b

--001a113f8efa1b525a051d84f18b
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 17, 2015 at 4:12 AM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> Here are a bunch of bugfixes and refactoring patches that I was going to
> send as part of reworking tinfoil. Unfortunately that reworking isn't
> complete and I don't have time to finish it right now; here is what I do
> have that can stand on its own. Most of it relates to memory resident
> mode or tidying up code that calls into cooker.
>
>
> The following changes since commit
> 04e896d7fb170271fb09dae5c2a42acb4b68f513:
>
>   toastergui: Added IDs to elements used in testing (2015-08-17 08:47:51
> +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib paule/tinfoil2-pre
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil2-pre
>
> Paul Eggleton (11):
>   Fix default function parameter assignment to a list
>   command: intercept SystemExit to avoid trashing the server
>   cooker: further limit inotify watches
>   cooker: ensure prefile/postfile can work in memory resident mode
>   Fix -m handling if cannot connect to server
>   lib/bb/main: consolidate UI/server extension listing and loading
>   cooker: drop appliedappendlist
>   cooker: drop appendlist
>   bitbake-layers: refactor show-appends to stop using cooker bbappends list
>   bitbake-layers: use "with open" consistently
>   lib/bb/parse: properly handle OSError when updating mtime cache
>
> Richard Purdie (2):
>   command: ensure sync commands that read configuration see updates
>   bitbake-layers: Convert flatten to use collections.bbappends
>

For what it's worth, these all look sane to me.

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113f8efa1b525a051d84f18b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 17, 2015 at 4:12 AM, Paul Eggleton <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@=
linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v id=3D":47r" class=3D"a3s" style=3D"overflow:hidden">Here are a bunch of b=
ugfixes and refactoring patches that I was going to<br>
send as part of reworking tinfoil. Unfortunately that reworking isn&#39;t<b=
r>
complete and I don&#39;t have time to finish it right now; here is what I d=
o<br>
have that can stand on its own. Most of it relates to memory resident<br>
mode or tidying up code that calls into cooker.<br>
<br>
<br>
The following changes since commit 04e896d7fb170271fb09dae5c2a42acb4b68f513=
:<br>
<br>
=C2=A0 toastergui: Added IDs to elements used in testing (2015-08-17 08:47:=
51 +0100)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" rel=3D"no=
referrer" target=3D"_blank">git.yoctoproject.org/poky-contrib</a> paule/tin=
foil2-pre<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dpaule/tinfoil2-pre" rel=3D"noreferrer" target=3D"_blank">http://git.yoct=
oproject.org/cgit.cgi/poky-contrib/log/?h=3Dpaule/tinfoil2-pre</a><br>
<br>
Paul Eggleton (11):<br>
=C2=A0 Fix default function parameter assignment to a list<br>
=C2=A0 command: intercept SystemExit to avoid trashing the server<br>
=C2=A0 cooker: further limit inotify watches<br>
=C2=A0 cooker: ensure prefile/postfile can work in memory resident mode<br>
=C2=A0 Fix -m handling if cannot connect to server<br>
=C2=A0 lib/bb/main: consolidate UI/server extension listing and loading<br>
=C2=A0 cooker: drop appliedappendlist<br>
=C2=A0 cooker: drop appendlist<br>
=C2=A0 bitbake-layers: refactor show-appends to stop using cooker bbappends=
 list<br>
=C2=A0 bitbake-layers: use &quot;with open&quot; consistently<br>
=C2=A0 lib/bb/parse: properly handle OSError when updating mtime cache<br>
<br>
Richard Purdie (2):<br>
=C2=A0 command: ensure sync commands that read configuration see updates<br=
>
=C2=A0 bitbake-layers: Convert flatten to use collections.bbappends</div></=
blockquote></div><br>For what it&#39;s worth, these all look sane to me.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Acked-by=
: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com">chris_l=
arson@mentor.com</a>&gt;<br>-- <br><div class=3D"gmail_signature">Christoph=
er Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded,=
 OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graph=
ics</div>
</div></div>

--001a113f8efa1b525a051d84f18b--
