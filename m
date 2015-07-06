Return-Path: <kergoth@gmail.com>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
	[209.85.192.53])
	by mail.openembedded.org (Postfix) with ESMTP id E21FD75D8C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jul 2015 15:38:30 +0000 (UTC)
Received: by qget71 with SMTP id t71so70761545qge.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jul 2015 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=NBj5g3nnJXo3qcrtkXxlanYDTxwlpTul+xMP9TgvmcM=;
	b=YknCGlNekJ07qr/Pk3SaM+QzJiNJnq4Pj+WGJbzvVh+3Z1oX8WBNsamMbGf5Plkd0S
	Wjki25gVi8EEeLtgt0aV6WU+BJ2CQM4q4BqkpkoDLyGR7Bo7W/1/pEBuLoORVzrBDk0B
	Lfij/tBNyLhx1mmd0ArqzeXsrR6ZINko1Va/DRAXV2Jix7lzsNB6O5/mWLw05Y/VHOkX
	VajV8Br41GGdeujA6NwKp869aDZO/jw2b4rYpisPg9kxqRrwkIypK67gUIHM3hCg65q8
	Vskead2mz1thgyFFBSTCRyTXL4eX9fCEOL819+QbEeigcXckcvOTN84/FhwtBRfq4RGd
	UHtQ==
X-Received: by 10.140.81.135 with SMTP id f7mr50244854qgd.38.1436197110713;
	Mon, 06 Jul 2015 08:38:30 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.99 with HTTP; Mon, 6 Jul 2015 08:38:11 -0700 (PDT)
In-Reply-To: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
References: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 6 Jul 2015 08:38:11 -0700
X-Google-Sender-Auth: 5ECsbAvjX2l-Js8XGdh8FXSQMrk
Message-ID: <CABcZAN=QEu+w5Zv53kXLPgFTFhsFrfQb_jxJbvbCNuymJbKuqA@mail.gmail.com>
To: eu@felipetonello.com
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
X-List-Received-Date: Mon, 06 Jul 2015 15:38:34 -0000
Content-Type: multipart/alternative; boundary=001a11c12ae69c95a7051a36b2f8

--001a11c12ae69c95a7051a36b2f8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2015 at 8:13 AM, <eu@felipetonello.com> wrote:

> From: "Felipe F. Tonello" <eu@felipetonello.com>
>
> Only do git submodule update after upack, otherwise the branch and commit
> id
> will be ignored, causing to run git submodules on a wrong ref.
>
> Since .gitmodules file is used to check if there is any submodule, we don=
't
> need to worry about copying .git/modules directory into the unpacked sour=
ce
> tree.
>
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>

We don=E2=80=99t want to be downloading from remote locations in do_unpack,=
 only
do_fetch. This patch will result in the opposite, which means the submodule
sources won=E2=80=99t be included in the git mirror tarball, and it=E2=80=
=99ll be
impossible to build with BB_NO_NETWORK=3D1. Also -c fetchall won=E2=80=99t =
result in
all sources having been fetched, which defeats its purpose.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c12ae69c95a7051a36b2f8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Mon, Jul 6, 2015 at 8:13 AM,=
  <span dir=3D"ltr">&lt;<a href=3D"mailto:eu@felipetonello.com" target=3D"_=
blank">eu@felipetonello.com</a>&gt;</span> wrote:<br><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div id=3D":1vq" class=3D"a3s" style=3D=
"overflow:hidden">From: &quot;Felipe F. Tonello&quot; &lt;<a href=3D"mailto=
:eu@felipetonello.com">eu@felipetonello.com</a>&gt;<br>
<br>
Only do git submodule update after upack, otherwise the branch and commit i=
d<br>
will be ignored, causing to run git submodules on a wrong ref.<br>
<br>
Since .gitmodules file is used to check if there is any submodule, we don&#=
39;t<br>
need to worry about copying .git/modules directory into the unpacked source=
<br>
tree.<br>
<br>
Signed-off-by: Felipe F. Tonello &lt;<a href=3D"mailto:eu@felipetonello.com=
">eu@felipetonello.com</a>&gt;</div></blockquote></div><br>We don=E2=80=99t=
 want to be downloading from remote locations in do_unpack, only do_fetch. =
This patch will result in the opposite, which means the submodule sources w=
on=E2=80=99t be included in the git mirror tarball, and it=E2=80=99ll be im=
possible to build with BB_NO_NETWORK=3D1. Also -c fetchall won=E2=80=99t re=
sult in all sources having been fetched, which defeats its purpose.<br>-- <=
br><div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth =
dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tsli=
b<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a11c12ae69c95a7051a36b2f8--
