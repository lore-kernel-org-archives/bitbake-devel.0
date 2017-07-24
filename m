Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id D2A3E71AC1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 21:43:57 +0000 (UTC)
Received: by mail-qk0-f179.google.com with SMTP id k2so20894572qkf.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=NKMRxcALq+QJjsI0+yKaEWMRMTiJesFsVgJTUPTAgnM=;
	b=RXMNM6998jH+SzZDDe84WywgYoVo6noCEeAsSapzW0Uf7nMUvlz5SEJYLpEXs2l+bm
	LO4BWtlstDSiG/9jtzHxRBxBeoQ7CgsaV28GM+nK37IgcyL9dZfHe1uIrDoXrwUU/v28
	S0aHK+8V58wfCu0n2zQFBOt+muMw6VodxHClSsrC/wk6keOWRH4J14Fp9JaJRxsXg0fP
	rMF5fyMWP5jJZ46nh/S53+4xpwiVJGwiQFype6rUrNf6gOhXLBU/t2U0NLpwiLGJ/w8O
	KwnPHu8Z5cUs5N1tiaNcxjNZtDD+ruQZ7RIy60vRNGwx6YjhDjJ3gsz1T2nprTgadM0l
	CYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=NKMRxcALq+QJjsI0+yKaEWMRMTiJesFsVgJTUPTAgnM=;
	b=qo0pFxa2tuEfCXWzVrMXNVdWUHNQ+x35p4yir4Cud01JSHhdjOg2MS1z0Oi6PGn6jy
	WIdf4W4Gr4PM+zVKaSzn/PBRO2yB31JZcpXwehun5t8jB6aNnuGUbTg11HuP5t56cvpa
	TjxoEBeKGa5xL8ok0TSY1NVfR2EbwSYaQbV7J5+a1omBYLCQHx6qtFDdw3GY4ko7cOfp
	Zsc0uXEEzjUAQzvikPuTFGHWk09CHYgrCis3k5nEPERmOpPwxnARmOoQFoTWzLeyJKjU
	XLrmOogEHoqIoX5EqP5rKKtj6viYsng2bNfvVANbLXif6TTOIB7OfDaKqi8NpsD7htVu
	407A==
X-Gm-Message-State: AIVw111FvqofZWKhWYHxWwlb3JFJ+LGYi54saRPDUJUvVhRq0HghJfsb
	J96d26qWByqb76P2s1nrrBNys/npOQ==
X-Received: by 10.55.22.166 with SMTP id 38mr22653192qkw.131.1500932638617;
	Mon, 24 Jul 2017 14:43:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.32.6 with HTTP; Mon, 24 Jul 2017 14:43:38 -0700 (PDT)
In-Reply-To: <1454516982-3788-1-git-send-email-eu@felipetonello.com>
References: <1454516982-3788-1-git-send-email-eu@felipetonello.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 24 Jul 2017 14:43:38 -0700
Message-ID: <CABcZAN=UWAbmzv7C5AOk93=O5gi5kfOprtWNWt37BOb50U-HXw@mail.gmail.com>
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/gitsm: Fix when repository change submodules
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
X-List-Received-Date: Mon, 24 Jul 2017 21:43:58 -0000
Content-Type: multipart/alternative; boundary="001a11496cb8c1b6550555171c49"

--001a11496cb8c1b6550555171c49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 3, 2016 at 9:29 AM, Felipe F. Tonello <eu@felipetonello.com>
wrote:

> This fix a problem when checking out a commit that changes the submodules
> previously checkout.
>
> Example:
> Recipe uses branch A and then it updates to use branch B, but branch B ha=
s
> different submodules dependencies then what branch A previously had.
>
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>

This completely broke the gitsm fetcher behavior. It no longer uses the
previously fetched submodules from DL_DIR at all, instead the submodule
update is re-cloning them from upstream in do_unpack, violating our
conventions. Git checkout isn=E2=80=99t going to magically copy the existin=
g
fetched submodules from DL_DIR.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a11496cb8c1b6550555171c49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Feb 3, 2016 at 9:29 AM, Felipe F. Tonello <span di=
r=3D"ltr">&lt;<a href=3D"mailto:eu@felipetonello.com" target=3D"_blank">eu@=
felipetonello.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This fix a problem whe=
n checking out a commit that changes the submodules<br>
previously checkout.<br>
<br>
Example:<br>
Recipe uses branch A and then it updates to use branch B, but branch B has<=
br>
different submodules dependencies then what branch A previously had.<br>
<br>
Signed-off-by: Felipe F. Tonello &lt;<a href=3D"mailto:eu@felipetonello.com=
">eu@felipetonello.com</a>&gt;<br></blockquote><div><br></div><div>This com=
pletely broke the gitsm fetcher behavior. It no longer uses the previously =
fetched submodules from DL_DIR at all, instead the submodule update is re-c=
loning them from upstream in do_unpack, violating our conventions. Git chec=
kout isn=E2=80=99t going to magically copy the existing fetched submodules =
from DL_DIR.</div></div>-- <br><div class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher La=
rson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZa=
urus<br>Senior Software Engineer, Mentor Graphics</div></div></div></div>
</div></div>

--001a11496cb8c1b6550555171c49--
