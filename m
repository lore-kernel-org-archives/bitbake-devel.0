Return-Path: <ross.burton@intel.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175])
	by mail.openembedded.org (Postfix) with ESMTP id 35B28601A4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Feb 2016 09:32:07 +0000 (UTC)
Received: by mail-ig0-f175.google.com with SMTP id xg9so69049982igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Feb 2016 01:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=Pp8/YINm0gPBhJNJGApAdSm9NgdKxU13CR+w5kzSO0w=;
	b=QKeCiB3jZbuZdJkNNdC7vvKTz4Etxp38Rbu7/TeGLimTs2qLItsQNqZntgERd/+ir3
	8W2wZtvr7iJvlxJ2psCiI9zAOxXxBl6LtrlUhUOHlHYSRQZ/hcpqbQ15Y/eNc2/5ZYDm
	DE8sUrm8jh2Zm+ZEjwug3CEcuGdrH7UfVxqpyFbDACxAVYF9pNYD3JZzuL+am4UIbiU4
	RaYx53qi7cxf8eawPqqpjSDMHAzVjKKMVMYt7AvmGvg2Vj5H2Vt44L2cfnmcofKY7860
	1AQ3fDpFPEYZt3AA/QSmsmANOL44aMEVbDRtbKLCb7AUJ5TNpfJd70HNB1VsAeJQkGIq
	U9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=Pp8/YINm0gPBhJNJGApAdSm9NgdKxU13CR+w5kzSO0w=;
	b=KjKbSV4mol70UChp+bYFeArtncdmNTiC+yH+vKCPAJR5dXPQPOahwaAmV4T5T03x6o
	M9uflYqCUMLJozUYHRplDLu328/IYA7pD+uxIB43Xgs/le9XDv5bI8w24tPkkeQC1mQi
	Nlf99e+m+sO5rnTGSO769zQRc2BDpScg51IDhrBeg4dzx7k0nI9/k/IdEh6BV8GGDnYS
	Rhy8UU2NKt8I4QvSaHe+Ac/wSFmR+PQzmjYxmX9VuoMtyNgbWaNVIvnzTKo+/5RllBqf
	k4iX29XAQyYFlrKDz1jAQjMukplQnZQgllVm08fDypUj20mCsq0ChHs9ZOMRJ6q4X+qE
	3dRg==
X-Gm-Message-State: AG10YOS7sxUkAIJ5zK2llJyDDMW7jq37WO8yjms+yrAMBXK4gf1DCK/azfh9eeCJM2gu14u5pE4MkGeBmC6VZrKW
X-Received: by 10.50.126.8 with SMTP id mu8mr16444146igb.52.1455615128572;
	Tue, 16 Feb 2016 01:32:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.162.70 with HTTP; Tue, 16 Feb 2016 01:31:49 -0800 (PST)
In-Reply-To: <AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0@AM3PR05MB546.eurprd05.prod.outlook.com>
References: <AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0@AM3PR05MB546.eurprd05.prod.outlook.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 16 Feb 2016 09:31:49 +0000
Message-ID: <CAJTo0LbSJ6dLjSaR48aOw4VXV01GJtjOt1sPNPbQ8tSESVoMFQ@mail.gmail.com>
To: RIDET Aurelien <aurelien.ridet@preciamolen.fr>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: can't get xserver-xorg to compile librecord.so
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
X-List-Received-Date: Tue, 16 Feb 2016 09:32:08 -0000
Content-Type: multipart/alternative; boundary=047d7b1635bfab304f052bdfce5b

--047d7b1635bfab304f052bdfce5b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15 February 2016 at 15:14, RIDET Aurelien <aurelien.ridet@preciamolen.fr=
>
wrote:

> For x11vnc, I need librecord.so embedded on my image device, but I can=E2=
=80=99t
> get it in any way. Tried to force =E2=80=93enable-record in EXTRA_OECONF,=
 tried to
> append xserver-xorg-extension-record in IMAGE_INSTALL, tried to upgrade
> xorg-server to 1.18.0, it compile but doesn=E2=80=99t provide the file I =
need. And
> tried to downgrade to 1.11.2 as it was the last version where lib were
> shipped without particular configuration, but couldn=E2=80=99t compile it=
 (due to
> too much dep).
>
>
Note that the bitbake list is for bitbake development, whereas this is a OE
support question so best sent to the yocto@ mailing list.

In general modern xserver doesn't ship external modules but integrates them
directly, so you won't see a specific package but the module will be
integrated into the xserver (also note that record is optional for x11vnc).

Ross

--047d7b1635bfab304f052bdfce5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 15 February 2016 at 15:14, RIDET Aurelien <span dir=3D"ltr">&lt;<a href=
=3D"mailto:aurelien.ridet@preciamolen.fr" target=3D"_blank">aurelien.ridet@=
preciamolen.fr</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p c=
lass=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,&quot;sans-serif&quot;;color:#1f497d">For x11vnc, I need librecord.so=
 embedded on my image device, but I can=E2=80=99t get it in any way. Tried =
to force =E2=80=93enable-record in EXTRA_OECONF, tried to append xserver-xo=
rg-extension-record
 in IMAGE_INSTALL, tried to upgrade xorg-server to 1.18.0, it compile but d=
oesn=E2=80=99t provide the file I need. And tried to downgrade to 1.11.2 as=
 it was the last version where lib were shipped without particular configur=
ation, but couldn=E2=80=99t compile it (due to too
 much dep).<u></u><u></u></span></p>
<p class=3D"MsoNormal"></p></blockquote></div><br>Note that the bitbake lis=
t is for bitbake development, whereas this is a OE support question so best=
 sent to the yocto@ mailing list.</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">In general modern xserver doesn&#39;t ship exte=
rnal modules but integrates them directly, so you won&#39;t see a specific =
package but the module will be integrated into the xserver (also note that =
record is optional for x11vnc).</div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">Ross</div></div>

--047d7b1635bfab304f052bdfce5b--
