Return-Path: <gerard.b@tekmagic.net>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id D39FF60670
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 21:30:46 +0000 (UTC)
Received: by mail-qk0-f179.google.com with SMTP id t145so26967474qke.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tekmagic-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=vDFRJMEi3zcTMOt3ZAWmat8Ua6XBtTiSTJNxEl4GTCE=;
	b=KLbViSFZOdQlxiuxhkU8r6Kw2HqKkWFr5Bkts49ksbcOzvQEH2RMxdh8zM9F5CGQtY
	cUF4wZseRL8gKwlBLu+3k9eLdRW7G7dXP5bzhGy6xMvkWhzVjJEjSIfNdQAjLf/+2S2Q
	58Bh3FALbe4dnc3cgSxDqrR3v48zDjQZp5eDyI7w5jJ5gWrMTZC4uYTUcby0oSUayQle
	i8EiVd3wvqiZ060t5+X5OftYe34A6Mxg+JQ8td/7xJCF+TfCmgSNWTP3ZbeXfTlnFT6/
	TGAAyiPy4FrDeTohfeQC1NX5QEfxAVskM5yiLbt/sNq/XTMJhA7lvbVc0sxjawIGaMNI
	6hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=vDFRJMEi3zcTMOt3ZAWmat8Ua6XBtTiSTJNxEl4GTCE=;
	b=O5HqwliOMi+clDPN8l51TKlsn0nlMGyNFWA1c/F4EGSLvZ9KfFebOTU4swjKPQ97NX
	PjUXYLGF8EiYaiUCtjMZ/qrFo50IRNcO7OGU5bsq4DYwOuCeWJkWcRJ4OYpYVZEXuepP
	wDBnziwqPX6AL4AYwHN6M0c/wte6S36TQnpD2Zf4cO+0V+Lc4AjoEVNvSa8urboOjtO7
	zEY7sKJ2hmFdB2KPjkTTio0Mf+jYISgOFcg2oSnFOmewoWwqBQjUZoLyb/0fWZtxDZNO
	79Wea9VRJ8YgiAKKp9ZMk0MTatnnEbNYNeWI9JJO8H0UbCC1AWG+QEDbBeRX7Nu4ONwL
	W77Q==
X-Gm-Message-State: ALyK8tJQxtdXOsiBEC+4gMX94rLwBk4UeL9154WTkprpWTO91a0142zdSWbbw9F2Fkwvvw==
X-Received: by 10.200.49.119 with SMTP id h52mr1059037qtb.80.1464039046904;
	Mon, 23 May 2016 14:30:46 -0700 (PDT)
Received: from [10.148.215.202] (mobile-166-171-056-012.mycingular.net.
	[166.171.56.12]) by smtp.gmail.com with ESMTPSA id
	c35sm1795186qga.14.2016.05.23.14.30.45
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 23 May 2016 14:30:45 -0700 (PDT)
Mime-Version: 1.0 (1.0)
From: Gerard Bucas <gerard.b@tekmagic.net>
X-Mailer: iPhone Mail (13F69)
In-Reply-To: <CAJTo0LaT2gdqyv+XkUPofOj+NYsmGT0eqKN6XQEtPpkwqb_gqg@mail.gmail.com>
Date: Mon, 23 May 2016 17:30:44 -0400
Message-Id: <122C9769-19EB-4196-861A-25948215D75F@tekmagic.net>
References: <03d601d1b528$7bca9b90$735fd2b0$@tekmagic.net>
	<03e401d1b529$3aaa2210$affe6630$@tekmagic.net>
	<03f101d1b529$74cdb560$5e692020$@tekmagic.net>
	<CAJTo0LaT2gdqyv+XkUPofOj+NYsmGT0eqKN6XQEtPpkwqb_gqg@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: Denis Carikli <denis@eukrea.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	=?utf-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>,
	Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: libsoup build error in master (missing gssapi/gssapi.h ?)
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
X-List-Received-Date: Mon, 23 May 2016 21:30:47 -0000
Content-Type: multipart/alternative;
	boundary=Apple-Mail-9C458636-E550-450B-9B0E-3DE91AA5D931
Content-Transfer-Encoding: 7bit

--Apple-Mail-9C458636-E550-450B-9B0E-3DE91AA5D931
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Ross - will do!!

> On May 23, 2016, at 4:09 PM, Burton, Ross <ross.burton@intel.com> wrote:
>=20
>=20
>> On 23 May 2016 at 20:29, Gerard Bucas <gerard.b@tekmagic.net> wrote:
>> I have been trying to build yocto with chromium but keep on getting a lib=
soup error that I can=E2=80=99t seem to resolve.
>>=20
>> =20
>>=20
>> Looks like: fatal error: gssapi/gssapi.h: No such file or directory
>>=20
>=20
> Update to current master, this has just been fixed.
>=20
> Also for support like this for recipe in oe-core, please stick to yocto@ o=
r oe-core@.
>=20
> Ross

--Apple-Mail-9C458636-E550-450B-9B0E-3DE91AA5D931
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div></div><div>Thanks Ross - will do!!</di=
v><div><br>On May 23, 2016, at 4:09 PM, Burton, Ross &lt;<a href=3D"mailto:r=
oss.burton@intel.com">ross.burton@intel.com</a>&gt; wrote:<br><br></div><blo=
ckquote type=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On 23 May 2016 at 20:29, Gerard Bucas <span dir=3D=
"ltr">&lt;<a href=3D"mailto:gerard.b@tekmagic.net" target=3D"_blank">gerard.=
b@tekmagic.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p cla=
ss=3D"MsoNormal"><b><span style=3D"font-size:14.0pt">I have been trying to b=
uild yocto with chromium but keep on getting a libsoup error that I can=E2=80=
=99t seem to resolve.<u></u><u></u></span></b></p><p class=3D"MsoNormal"><b>=
<span style=3D"font-size:14.0pt"><u></u>&nbsp;<u></u></span></b></p><p class=
=3D"MsoNormal"><b><span style=3D"font-size:14.0pt">Looks like: </span></b><c=
ode><span style=3D"font-size:10.0pt">fatal error: gssapi/gssapi.h: No such f=
ile or directory<u></u><u></u></span></code></p><p class=3D"MsoNormal"></p><=
/blockquote></div><br>Update to current master, this has just been fixed.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Also for s=
upport like this for recipe in oe-core, please stick to yocto@ or oe-core@.<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</d=
iv></div>
</div></blockquote></body></html>=

--Apple-Mail-9C458636-E550-450B-9B0E-3DE91AA5D931--
