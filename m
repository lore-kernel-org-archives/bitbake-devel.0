Return-Path: <alex.kanavin@gmail.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id DDAAB7D69D
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 May 2019 14:42:34 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id c5so9912406wrs.11
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 May 2019 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=1UFmcQiXOpQi6nnVlkZxt9GS6vuK4GaM12bLFBKV5w4=;
	b=ryx/Rco3IYsERfx8fG30R81vRct3nLFZ2i2JF67hNBQagq12f/RuWnDyf5EdShiZE5
	g8ybnEgEoCj+S6ItN2BgH/9SP1WIa2f1BfjyzPJjk8g7fksNBuLkgTOfl2HUXfqsjeF2
	KI3ALA5ZsT+JdzDuEP19w07vnG5S+8E3a5u932J4QdCmdNuQ0Ojkuinn5EsKTSMQRSr8
	CG80Cg7Lq5bnvnqpuFrd0ZWJ04fbLubOR8II0vmDg1hqryV9uOuvoXu/pdNl7tTNpeav
	r522XlukYMNhtDmXgnGucpdq4iQXNYTjALJYquu2bEVRXp9SvnHx0ea582MQhHXmAkZO
	cIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=1UFmcQiXOpQi6nnVlkZxt9GS6vuK4GaM12bLFBKV5w4=;
	b=ojExCl9RfcTxxq41rBF+5Mo2NNteS+4TRwsjcDzDqLP40LtXe7ds4/25DGnmP+uR5v
	0T9d+L4q/+sxJ8AwLhVTlOXODV3EBZBVi0o7ZGdV53t05oSjpB/gdk58PQi4n/XOsnEP
	mGuJuubBzOFZtqbgeGux3PB2U4eKmguYfciapNy/upJmcTbxq0QwNxKjPxyRUssmzBwr
	oBseR0bD1+7yZrRzZhHd13Gj3pcXQWVQl4hZY4vXKLq0r6TfB5IQS12MTcrCfwqEEkvv
	ah3EvI2Wo0u3PQUHAIZScXGCzbsqpcAS0IXHeBVETDqz2wxiVwjW5P1Hj26wtZLb7xYC
	SjJg==
X-Gm-Message-State: APjAAAUoABhmMIGmoCFqrQvILHg8VWBnbnzWXHWqQSWxnIGxrANdSPL9
	yM34X4im++3u35YeMFS+/Be2n1hH7aU=
X-Google-Smtp-Source: APXvYqy3AbYZ9XPlQ0yaKlHBmuPQjVu8DNDUA5jZUuP867XaHgiLKAvh5ZBDVgM+Fhwi2vMnqfC0/g==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr29579914wrg.89.1558190555301; 
	Sat, 18 May 2019 07:42:35 -0700 (PDT)
Received: from ?IPv6:2a01:598:b009:c60f:a50e:7a8a:3325:b3b6?
	([2a01:598:b009:c60f:a50e:7a8a:3325:b3b6])
	by smtp.gmail.com with ESMTPSA id
	u15sm9480166wru.16.2019.05.18.07.42.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 07:42:33 -0700 (PDT)
Mime-Version: 1.0 (1.0)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <CAGW41X4-eci5jLF=is4zXyZ_S-09KAm3u6zRY7bZRm5-ZOBoNg@mail.gmail.com>
Date: Sat, 18 May 2019 16:42:31 +0200
Message-Id: <CD049A4B-65EC-4837-AF9B-9664647B6C8B@gmail.com>
References: <CAGW41X4-eci5jLF=is4zXyZ_S-09KAm3u6zRY7bZRm5-ZOBoNg@mail.gmail.com>
To: Andrew Featherstone <andrew.featherstone@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: BitBake release notes
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
X-List-Received-Date: Sat, 18 May 2019 14:42:35 -0000
Content-Type: multipart/alternative;
	boundary=Apple-Mail-6A74C37A-CDD3-40E6-A307-E55FF881DDC9
Content-Transfer-Encoding: 7bit

--Apple-Mail-6A74C37A-CDD3-40E6-A307-E55FF881DDC9
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

The short answer is no. Bitbake releases are actually tightly coupled to mat=
ching versions of layer metadata, so while you can try to use newer bitbake w=
ith older metadata, you are on your own with any issues.

Alex

> On 18 May 2019, at 11.04, Andrew Featherstone <andrew.featherstone@gmail.c=
om> wrote:
>=20
> Hi There,
>=20
> First apologies in advance if this is the wrong mailing list. If there's a=
 bitbake-users list, please let me know.
>=20
> I'm looking for some release notes for BitBake to help understand compatib=
ility of recipes and when new features were added. The changelog at https://=
git.openembedded.org/bitbake/tree/ChangeLog hasn't been touched in quite a f=
ew years, Yocto Project release notes include details of changes https://wik=
i.yoctoproject.org/wiki/Releases, but nothing about compatibility. Are all 1=
.x releases of BitBake backwards compatible?
>=20
> Regards,
> Andrew
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--Apple-Mail-6A74C37A-CDD3-40E6-A307-E55FF881DDC9
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">The short answer is no. Bitbake releases ar=
e actually tightly coupled to matching versions of layer metadata, so while y=
ou can try to use newer bitbake with older metadata, you are on your own wit=
h any issues.<br><br><div id=3D"AppleMailSignature" dir=3D"ltr">Alex</div><d=
iv dir=3D"ltr"><br>On 18 May 2019, at 11.04, Andrew Featherstone &lt;<a href=
=3D"mailto:andrew.featherstone@gmail.com">andrew.featherstone@gmail.com</a>&=
gt; wrote:<br><br></div><blockquote type=3D"cite"><div dir=3D"ltr"><div dir=3D=
"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi There,</div><div><br></div><=
div>First apologies in advance if this is the wrong mailing list. If there's=
 a bitbake-users list, please let me know.</div><div><br></div><div>I'm look=
ing for some release notes for BitBake to help understand compatibility of r=
ecipes and when new features were added. The changelog at <a href=3D"https:/=
/git.openembedded.org/bitbake/tree/ChangeLog">https://git.openembedded.org/b=
itbake/tree/ChangeLog</a> hasn't been touched in quite a few years, Yocto Pr=
oject release notes include details of changes <a href=3D"https://wiki.yocto=
project.org/wiki/Releases">https://wiki.yoctoproject.org/wiki/Releases</a>, b=
ut nothing about compatibility. Are all 1.x releases of BitBake backwards co=
mpatible?</div><div><br></div><div>Regards,</div><div>Andrew<br></div></div>=
</div></div>
</div></blockquote><blockquote type=3D"cite"><div dir=3D"ltr"><span>-- </spa=
n><br><span>_______________________________________________</span><br><span>=
bitbake-devel mailing list</span><br><span><a href=3D"mailto:bitbake-devel@l=
ists.openembedded.org">bitbake-devel@lists.openembedded.org</a></span><br><s=
pan><a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel"=
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a></span><br>=
</div></blockquote></body></html>=

--Apple-Mail-6A74C37A-CDD3-40E6-A307-E55FF881DDC9--
