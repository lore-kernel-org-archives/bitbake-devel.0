Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web12.4091.1621977437091483587
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 14:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.178.232, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id E157D200004;
	Tue, 25 May 2021 21:17:13 +0000 (UTC)
Date: Tue, 25 May 2021 21:17:11 +0000
From: "Quentin Schulz" <foss@0leil.net>
To: docs@lists.yoctoproject.org, Richard Weinberger <richard@nod.at>,
 openembedded-core@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [yocto-docs][PATCH] Document erofs filesystem targets
In-Reply-To: <20210525110429.738-3-richard@nod.at>
References: <20210525110429.738-1-richard@nod.at> <20210525110429.738-3-richard@nod.at>
Message-ID: <749C5928-6F5C-4E97-B643-A939A31B393D@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On May 25, 2021 11:04:29 AM UTC, Richard Weinberger <richard@nod=2Eat> wro=
te:
>Signed-off-by: Richard Weinberger <richard@nod=2Eat>
>---
> documentation/ref-manual/kickstart=2Erst | 2 ++
> documentation/ref-manual/variables=2Erst | 3 +++
> 2 files changed, 5 insertions(+)
>
>diff --git a/documentation/ref-manual/kickstart=2Erst b/documentation/ref=
-manual/kickstart=2Erst
>index 8308ffff5b72=2E=2E2c8b724ff9ac 100644
>--- a/documentation/ref-manual/kickstart=2Erst
>+++ b/documentation/ref-manual/kickstart=2Erst
>@@ -116,6 +116,8 @@ the ``part`` and ``partition`` commands:
>=20
>    -  ``squashfs``
>=20
>+   -  ``erofs``
>+
>    -  ``swap``
>=20

Please order alphabetically=2E

> -  ``--fsoptions``: Specifies a free-form string of options to be used
>diff --git a/documentation/ref-manual/variables=2Erst b/documentation/ref=
-manual/variables=2Erst
>index df6413b68ae9=2E=2Ed4ea4f399921 100644
>--- a/documentation/ref-manual/variables=2Erst
>+++ b/documentation/ref-manual/variables=2Erst
>@@ -3293,6 +3293,9 @@ system and gives an overview of their function and =
contents=2E
>       - jffs2
>       - jffs2=2Esum
>       - multiubi
>+      - erofs
>+      - erofs-lz4
>+      - erofs-lz4hc

Ditto=2E

Thanks for the patch,
Cheers,
Quentin

>       - squashfs
>       - squashfs-lz4
>       - squashfs-lzo
>--=20
>2=2E26=2E2
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
