Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
	[209.85.220.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5CB84782FD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 21:54:58 +0000 (UTC)
Received: by mail-qk0-f169.google.com with SMTP id g6so63057766qkf.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=42mNLHi7uB5lzQJhJc9oX7GAIN8FS6Ds/lMvR/BF12U=;
	b=trbhAPPbC0LKeR/ezCVGAM+fdMT8K8S4p/zwjDnoUPlUcOkUx/1lG5sdSo5hvuhl5R
	BV/LGrgecQq18eSFrNBJUvED8zJezQ4NmoIp0U/9e++KA88wp1hGpLB4nXOzZuj5xQdG
	KS+7aOkstnDtxddVOrih7LKzg9BBAWTIFy0koFUFGCw+9zF0N4r5/QI9zy0Bdkzsfeew
	5BD9BtpSFViMoBSnPQd7k4b1CCkrNb5fH/IByKXLkKvLC9+QCp1TKx6ZaKyj6hpK8agc
	2sMqTsE44WJUcmAMTkDRm0D+4LKPgRq+lx3NW0i5fybTxQQgkt5uD7XWKe0bBIPI+2TT
	zAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=42mNLHi7uB5lzQJhJc9oX7GAIN8FS6Ds/lMvR/BF12U=;
	b=pfeEaPry0aE6B/YliiFerjtAGoTLHAdRz9X1v/eK2R0F/vg+49QbhfUl/H9zHF5GSr
	r6EBh0KMDBZn94ssOEVtbbi9VlFFKYvhKv3bGXU/88gtNfR0kj2+iy0XylTZftE1t/z6
	xU8/dMlfQtD2752O3Q0pRa4wdNznFr3x3ApdWw9KIqSFiZYOnJPXpqrWyV3tVKh/cJ1z
	jqwdFAgMYjgoxuSKlRe4g26R0CLZSZyhZLosSWew34DGgg+0SAxu228GaxizFQLcYNqQ
	4kgeX8dbjR1YKTXB72jGajyvYWJ+OpIfjG+hSHxBmZtVXobVBaNaDVLoTygCBas/1Zjx
	Y5LQ==
X-Gm-Message-State: AIVw1129qwMhl1CHMDrkZVVboz7pInlSMxwNG1xplqMkkqHgIAxareVF
	2GdtKgmXwIHM6VGT5WYscuQ2Wtuubg==
X-Received: by 10.55.22.166 with SMTP id 38mr22684896qkw.131.1500933300298;
	Mon, 24 Jul 2017 14:55:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.32.6 with HTTP; Mon, 24 Jul 2017 14:54:39 -0700 (PDT)
In-Reply-To: <CABcZAN=UWAbmzv7C5AOk93=O5gi5kfOprtWNWt37BOb50U-HXw@mail.gmail.com>
References: <1454516982-3788-1-git-send-email-eu@felipetonello.com>
	<CABcZAN=UWAbmzv7C5AOk93=O5gi5kfOprtWNWt37BOb50U-HXw@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 24 Jul 2017 14:54:39 -0700
Message-ID: <CABcZANnjQTPrp71dxtv3GKTyTeNPG8-S+b2jk02NfOYz0MCk1Q@mail.gmail.com>
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
X-List-Received-Date: Mon, 24 Jul 2017 21:54:59 -0000
Content-Type: multipart/alternative; boundary="001a11496cb83228a005551744c3"

--001a11496cb83228a005551744c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 2:43 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> On Wed, Feb 3, 2016 at 9:29 AM, Felipe F. Tonello <eu@felipetonello.com>
> wrote:
>
>> This fix a problem when checking out a commit that changes the submodule=
s
>> previously checkout.
>>
>> Example:
>> Recipe uses branch A and then it updates to use branch B, but branch B h=
as
>> different submodules dependencies then what branch A previously had.
>>
>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>>
>
> This completely broke the gitsm fetcher behavior. It no longer uses the
> previously fetched submodules from DL_DIR at all, instead the submodule
> update is re-cloning them from upstream in do_unpack, violating our
> conventions. Git checkout isn=E2=80=99t going to magically copy the exist=
ing
> fetched submodules from DL_DIR.
>

Apologies for the harsh tone here, but clearly we should fix this
differently. https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11830 has
been opened for this. It=E2=80=99ll be difficult to add a good unit test to=
 catch
this problem without using either a VM or containers to physically cut
network connectivity. I=E2=80=99m going to propose a future bitbake enhance=
ment to
use namespaces to prevent network connectivity from non-fetch tasks.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a11496cb83228a005551744c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Jul 24, 2017 at 2:43 PM, Christopher Larson <span dir=3D"ltr">&=
lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><span class=3D"=
gmail-">On Wed, Feb 3, 2016 at 9:29 AM, Felipe F. Tonello <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:eu@felipetonello.com" target=3D"_blank">eu@felipeton=
ello.com</a>&gt;</span> wrote:<br></span><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote"><span class=3D"gmail-"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">This fix a prob=
lem when checking out a commit that changes the submodules<br>
previously checkout.<br>
<br>
Example:<br>
Recipe uses branch A and then it updates to use branch B, but branch B has<=
br>
different submodules dependencies then what branch A previously had.<br>
<br>
Signed-off-by: Felipe F. Tonello &lt;<a href=3D"mailto:eu@felipetonello.com=
" target=3D"_blank">eu@felipetonello.com</a>&gt;<br></blockquote><div><br><=
/div></span><div>This completely broke the gitsm fetcher behavior. It no lo=
nger uses the previously fetched submodules from DL_DIR at all, instead the=
 submodule update is re-cloning them from upstream in do_unpack, violating =
our conventions. Git checkout isn=E2=80=99t going to magically copy the exi=
sting fetched submodules from DL_DIR.</div></div></div></div></blockquote><=
div><br></div><div>Apologies for the harsh tone here, but clearly we should=
 fix this differently.=C2=A0<a href=3D"https://bugzilla.yoctoproject.org/sh=
ow_bug.cgi?id=3D11830">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D=
11830</a>=C2=A0has been opened for this. It=E2=80=99ll be difficult to add =
a good unit test to catch this problem without using either a VM or contain=
ers to physically cut network connectivity. I=E2=80=99m going to propose a =
future bitbake enhancement to use namespaces to prevent network connectivit=
y from non-fetch tasks.</div></div>-- <br><div class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail=
 dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software =
Engineer, Mentor Graphics</div></div></div></div>
</div></div>

--001a11496cb83228a005551744c3--
