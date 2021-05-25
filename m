Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by mx.groups.io with SMTP id smtpd.web08.8434.1621941904559214084
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 04:25:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: nod.at, ip: 195.201.40.130, mailfrom: richard@nod.at)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2F4E16083271;
	Tue, 25 May 2021 13:24:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5lp8w8pR4sMp; Tue, 25 May 2021 13:24:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CB746616B584;
	Tue, 25 May 2021 13:24:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5VhBtQHUj15i; Tue, 25 May 2021 13:24:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A363C60A3597;
	Tue, 25 May 2021 13:24:52 +0200 (CEST)
Date: Tue, 25 May 2021 13:24:52 +0200 (CEST)
From: "Richard Weinberger" <richard@nod.at>
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: openembedded-core <openembedded-core@lists.openembedded.org>, 
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Message-ID: <1307355474.37816.1621941892565.JavaMail.zimbra@nod.at>
In-Reply-To: <AM9PR09MB46426BCB13C172A8FBB3DF94A8259@AM9PR09MB4642.eurprd09.prod.outlook.com>
References: <20210525110429.738-1-richard@nod.at> <AM9PR09MB46426BCB13C172A8FBB3DF94A8259@AM9PR09MB4642.eurprd09.prod.outlook.com>
Subject: Re: [bitbake-devel] [OE-core][PATCH] Add support for erofs filesystems
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add support for erofs filesystems
Thread-Index: RWacFjlA4zutskXbiWxMXbgz/5E9eg==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Konrad,

----- Urspr=C3=BCngliche Mail -----
> Von: "Konrad Weihmann" <kweihmann@outlook.com>
>> +EXTRA_OECONF =3D "--enable-lz4 --disable-fuse"
>=20
> In the commit message it's mentioned that compression is optional, still
> here lz4 is enabled by default - I would rather see these compression
> switches configurable via PACKAGECONFIG

Good point! Will send a v2 in a jiffy.

Thanks,
//richard
