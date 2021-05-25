Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by mx.groups.io with SMTP id smtpd.web09.4105.1621977758792279907
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 14:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: nod.at, ip: 195.201.40.130, mailfrom: richard@nod.at)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0BBB3616B582;
	Tue, 25 May 2021 23:22:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KBdM4SAMNl3n; Tue, 25 May 2021 23:22:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6C2A7606BA3F;
	Tue, 25 May 2021 23:22:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x355FojlK5TO; Tue, 25 May 2021 23:22:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 475BB606BA3A;
	Tue, 25 May 2021 23:22:36 +0200 (CEST)
Date: Tue, 25 May 2021 23:22:36 +0200 (CEST)
From: "Richard Weinberger" <richard@nod.at>
To: Quentin Schulz <foss@0leil.net>
Cc: docs <docs@lists.yoctoproject.org>, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <952941855.40427.1621977756153.JavaMail.zimbra@nod.at>
In-Reply-To: <34B9CE63-084A-48A5-9386-862E48760070@0leil.net>
References: <20210525110429.738-1-richard@nod.at> <34B9CE63-084A-48A5-9386-862E48760070@0leil.net>
Subject: Re: [docs] [OE-core][PATCH] Add support for erofs filesystems
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add support for erofs filesystems
Thread-Index: oVZaG82W2Un0V1PKMZ3hp6vJelhsfQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Quentin,

----- Urspr=C3=BCngliche Mail -----
> Von: "Quentin Schulz" <foss@0leil.net>
>> IMAGE_TYPES =3D " \
>>@@ -261,6 +269,7 @@ IMAGE_TYPES =3D " \
>>     wic wic.gz wic.bz2 wic.lzma wic.zst \
>>     container \
>>     f2fs \
>>+    erofs \
>=20
> I think you're supposed to have erofs erofs-lz4 erofs-lz4hc here.

Oh yes. You're right.
=20
>> "
>>=20
>> # Compression is a special case of conversion. The old variable
>>diff --git a/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
>>b/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
>>new file mode 100644
>>index 000000000000..6d35d3f2fa6d
>>--- /dev/null
>>+++ b/meta/recipes-devtools/erofs-utils/erofs-utils_git.bb
>=20
> Any reason for using _git over _1.2.1?

TBH, I used meta/recipes-devtools/squashfs-tools/squashfs-tools_git.bb as t=
emplate. :-)
It fetches also via git and sets PV.

>>@@ -0,0 +1,18 @@
>>+SUMMARY =3D "Tools for erofs filesystems"
>>+LICENSE =3D "GPLv2"
>=20
> GPL-2.0-or-later actually.

Will fix!

Thanks,
//richard
