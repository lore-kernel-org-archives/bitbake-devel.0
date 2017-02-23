Return-Path: <kergoth@gmail.com>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id B15D67304A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2017 15:48:33 +0000 (UTC)
Received: by mail-ot0-f169.google.com with SMTP id w44so26370537otw.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2017 07:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=NyjEIVAnatc4q33JzSKt/hNqY/EreuwBSxq/RJzS+JU=;
	b=tZ2TpRkZ7c03weA55eJrlMvxtUemDPQdDJPy+dmESCtv7dZEalnohKTAGHeSwBMZ+k
	NWiSrPFZAeaVTUVFvneWiV6dJRou2Kbqd6Z+7BONSEubcSUi9VKFPkROqXWgS4NTBUPZ
	/sk4QDBvKRnYdknDncSBaWU/7Mp/WaDf2iCKP28o0+RVWdyYQz0zIpsXn4v/5rsrgGD0
	QTBo/PwTUSSBycOFYiABK+LGRsoKel24ndd/iGdp+Xr6Mhhl8fMgSS6C4ZyIOz8U2110
	vajb2F3J5B6zKad5I0rtY+wrJfTRJKpix/2fEh5xW59Em1h1Gz9hyb6WQ3CdPjMh3eQ3
	RaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=NyjEIVAnatc4q33JzSKt/hNqY/EreuwBSxq/RJzS+JU=;
	b=nxcZpTFIMJruADUIlgBUybGtWh/SThHOr1hAFAuVxfgsOqGp4Kf6farjhIcPO0F6GZ
	s3xOOR4fMIQZ+yBGIGDxnHc7KNAcik4SdF2esfvnkYx/wvjb9EfIHPGdP0iCGKlmoALu
	rbn4cK8b+pUaUDo9FaDEzj64xwW+j4wqySqgoQ8t+jgVqb4UWEQwoem89OJ7WZsBTexj
	uDktpoa0TjmcndtZrssiLFq4YDJbD4S8UHVnJwLcexZ8+bykAW8lxKat4gv1yf/3Bfx3
	0sE8SAQSl/0uAalVKD/Yr1u9nfrWVX1chU34cUxR33k7AyPLHp8WmWueIKVYIFUI73ym
	cC2w==
X-Gm-Message-State: AMke39k3vAYpxkFpMd7mR2TZxKgp86dnDxU9+FodBJNdRYaJ1LWbVAuU/mb4VCGi6riZLx5wj7Ppmh7MYIR+rQ==
X-Received: by 10.157.82.83 with SMTP id q19mr4485584otg.50.1487864914337;
	Thu, 23 Feb 2017 07:48:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.82.98 with HTTP; Thu, 23 Feb 2017 07:48:13 -0800 (PST)
In-Reply-To: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 23 Feb 2017 08:48:13 -0700
Message-ID: <CABcZANkj3nR3r6_uzWN+4RQcrRBZaumTpMORrac5_aUd7=U-VA@mail.gmail.com>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/3] Fix rpm signing with GPG v2.1
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
X-List-Received-Date: Thu, 23 Feb 2017 15:48:33 -0000
Content-Type: multipart/alternative; boundary=f403043c40e0b167bc0549348b4d

--f403043c40e0b167bc0549348b4d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 3:22 AM, Markus Lehtonen <
markus.lehtonen@linux.intel.com> wrote:

> This patchset makes signing work with all versions of GPG.  Previously, r=
pm
> package signing in oe-core was not working with GPG v2.1 (which is becomi=
ng
> more widespread). This was caused by a change in passphrase dialogue
> handling
> of GPG.
>
> [YOCTO #11054]
>
> Markus Lehtonen (3):
>   rpm: support customizing gpg command line
>   lib/oe/gpg_sign: make gpg version a property of the signer
>   lib/oe/gpg_sign: fix rpm signing with gpg > 2.1
>

This doesn=E2=80=99t belong on the bitbake list if it=E2=80=99s oe-core..
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--f403043c40e0b167bc0549348b4d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Feb 23, 2017 at 3:22 AM, Markus Lehtonen <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:markus.lehtonen@linux.intel.com" target=3D"_blank">markus.leh=
tonen@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div id=3D":m5" class=3D"a3s aXjCH m15a6a7e6ddf58b99">This patchset make=
s signing work with all versions of GPG.=C2=A0 Previously, rpm<br>
package signing in oe-core was not working with GPG v2.1 (which is becoming=
<br>
more widespread). This was caused by a change in passphrase dialogue handli=
ng<br>
of GPG.<br>
<br>
[YOCTO #11054]<br>
<br>
Markus Lehtonen (3):<br>
=C2=A0 rpm: support customizing gpg command line<br>
=C2=A0 lib/oe/gpg_sign: make gpg version a property of the signer<br>
=C2=A0 lib/oe/gpg_sign: fix rpm signing with gpg &gt; 2.1</div></blockquote=
></div><br>This doesn=E2=80=99t belong on the bitbake list if it=E2=80=99s =
oe-core..<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>ker=
goth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Sen=
ior Software Engineer, Mentor Graphics</div></div></div></div>
</div></div>

--f403043c40e0b167bc0549348b4d--
