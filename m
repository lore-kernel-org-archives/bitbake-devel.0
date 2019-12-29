Return-Path: <persaur@gmail.com>
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com
	[209.85.219.195])
	by mail.openembedded.org (Postfix) with ESMTP id 1D65C7F363
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 29 Dec 2019 02:04:09 +0000 (UTC)
Received: by mail-yb1-f195.google.com with SMTP id l7so4917925ybp.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 18:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
	:date:message-id:references:to;
	bh=JugsxEHN6zC4l4RDa9CLOklXZ+xAaapS0nN8pIUS1BA=;
	b=pd05lrL3fhHlFJprXmSrXzHxJ3QLm/eLBp6j31L0SW3y4nEvhXy9nFaRX72BrPxex1
	C1MrumEZ/UZr66lWecSeK/kK4pfOQtrAISbVtO+BuW6rlGfKuqjNSbUZiXoqRmQmr6uy
	nM6sOLz8czxorDeflUrFJ8AKiEkxlzRgVdpOvDG4xFavube8rBb0L8sfh7s6ga3IW4o7
	9j8UJcbj9RxPwzcOr8yhqzyotYEfxo4yj71c5yZ/u4QWzWRyW3JtPPe1SkW54vbCZqoq
	hoF08NBeC1vbOJTmvSuSZyXa7gs+WeGvH/EYBeE04oFT8ezwWdUgefrl3Q29JE0k4n5g
	5mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:content-transfer-encoding:mime-version:subject
	:from:in-reply-to:cc:date:message-id:references:to;
	bh=JugsxEHN6zC4l4RDa9CLOklXZ+xAaapS0nN8pIUS1BA=;
	b=VsMDt4NRyY5xsznp1CEENxJJMBE1kCM1C+4t3Eq3wDkUgJt/J0eKt0qH4o2obc5tgJ
	wA6TtJkmKt5cmKeNY+qbSXV9w8dRHI3OA9BaatDhYQQydhtkUak6rn5eNkilTl7bK7YM
	YQ3pR0bzBtiKVMagfKht3OJ+HY958ivB9aA5j2+0XLUOsR5r2XVLOoQBOIvkdr8bI5Tt
	c2o6spNyam/rGQpErlh3Y482J55ozrM6vlVvEU1DZRq1tT9X0HBfyump9sAzvSUMxiNh
	rc8uq8GIwieNQ2QQnrGoFEGqVP1rTdRw8OrzD1KXuCzKEPKbSfTdRAqbXeRmBuBpK3fD
	ePyg==
X-Gm-Message-State: APjAAAVxlTP+MGBFdUIZKrU0XSOxTsSNfXQnLLPAa/tWILT9ENXETU7D
	YrsBeNJJPx6kvF5IE72Y09y/zp/g
X-Google-Smtp-Source: APXvYqxpEuoa6NBlUDa9as7JjxepmF1AwO5uhgO5V00OIuGwToRYvgOgbQpMrLWLSYp34zmpp1VgNw==
X-Received: by 2002:a25:c584:: with SMTP id
	v126mr43819384ybe.171.1577585050669; 
	Sat, 28 Dec 2019 18:04:10 -0800 (PST)
Received: from [100.64.72.6] ([173.245.215.240])
	by smtp.gmail.com with ESMTPSA id
	o2sm12294111ywe.98.2019.12.28.18.04.09
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Sat, 28 Dec 2019 18:04:10 -0800 (PST)
Mime-Version: 1.0 (1.0)
From: Rich Persaud <persaur@gmail.com>
In-Reply-To: <20191204091540.28005-1-pascal.huerst@gmail.com>
Date: Sat, 28 Dec 2019 21:04:09 -0500
Message-Id: <53A94A50-42DF-469F-8372-62BF68789262@gmail.com>
References: <20191204091540.28005-1-pascal.huerst@gmail.com>
To: pascal.huerst@gmail.com
X-Mailer: iPad Mail (17C54)
X-Mailman-Approved-At: Mon, 30 Dec 2019 11:01:04 +0000
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v1] bitbake: fetch2/git: add SRC_URI option versiontag
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
X-List-Received-Date: Sun, 29 Dec 2019 02:04:10 -0000
Content-Type: multipart/alternative;
	boundary=Apple-Mail-A15E3EA7-CA38-4347-95CB-522D1B5F3CD6
Content-Transfer-Encoding: 7bit

--Apple-Mail-A15E3EA7-CA38-4347-95CB-522D1B5F3CD6
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Dec 4, 2019, at 04:16, pascal.huerst@gmail.com wrote:
> =EF=BB=BFFrom: Pascal Huerst <pascal.huerst@gmail.com>
>=20
> Use latest_versionstring() to find the latest tagged release for use with
> AUTOREV. This can be useful, if you want to build the latest tagged releas=
e
> instead of a branch. UPSTREAM_CHECK_GITTAGREGEX can be used to specify a
> version format.

Have you seen this approach?
https://code.ossystems.com.br/gitweb?p=3Dmeta-ossystems-base.git;a=3Dblob;f=3D=
classes/ossystems-srcrev-handler.bbclass

For development workflows, it would be useful to override a recipe-specific b=
ranch/tag via bitbake CLI.  For production/stable release workflows, it woul=
d be useful to override a layer-specific branch/tag via bitbake CLI, which c=
ould be propagated to all recipes within the layer.   This would help when m=
aintaining multiple versions of a layer, corresponding to multiple OE versio=
ns.

Rich

--Apple-Mail-A15E3EA7-CA38-4347-95CB-522D1B5F3CD6
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div dir=3D"ltr"><meta http-equiv=3D"conten=
t-type" content=3D"text/html; charset=3Dutf-8"><div dir=3D"ltr">On Dec 4, 20=
19, at 04:16, pascal.huerst@gmail.com wrote:</div><div dir=3D"ltr"><blockquo=
te type=3D"cite"><br></blockquote></div><blockquote type=3D"cite"><div dir=3D=
"ltr">=EF=BB=BF<span>From: Pascal Huerst &lt;pascal.huerst@gmail.com&gt;</sp=
an><br><span></span><br><span>Use latest_versionstring() to find the latest t=
agged release for use with</span><br><span>AUTOREV. This can be useful, if y=
ou want to build the latest tagged release</span><br><span>instead of a bran=
ch. UPSTREAM_CHECK_GITTAGREGEX can be used to specify a</span><br><span>vers=
ion format.</span><br></div></blockquote><div><br></div><div>Have you seen t=
his approach?</div><div><a href=3D"https://code.ossystems.com.br/gitweb?p=3D=
meta-ossystems-base.git;a=3Dblob;f=3Dclasses/ossystems-srcrev-handler.bbclas=
s">https://code.ossystems.com.br/gitweb?p=3Dmeta-ossystems-base.git;a=3Dblob=
;f=3Dclasses/ossystems-srcrev-handler.bbclass</a></div><div><br></div><div>Fo=
r development workflows, it would be useful to override a recipe-specific br=
anch/tag via bitbake CLI. &nbsp;For production/stable release workflows, it w=
ould be useful to override a layer-specific branch/tag via bitbake CLI, whic=
h could be propagated to all recipes within the layer. &nbsp; This would hel=
p when maintaining multiple versions of a layer, corresponding to multiple O=
E versions.</div><div><br></div><div>Rich</div><div></div></div></body></htm=
l>=

--Apple-Mail-A15E3EA7-CA38-4347-95CB-522D1B5F3CD6--
