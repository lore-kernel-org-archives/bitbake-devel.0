Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 482 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 21 Oct 2015 08:48:26 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 60FB8766F3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Oct 2015 08:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 7A30F1822B;
	Wed, 21 Oct 2015 10:40:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id BJKHbXgxnDb8; Wed, 21 Oct 2015 10:40:20 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id A2CC018238;
	Wed, 21 Oct 2015 10:40:20 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 8970715DF;
	Wed, 21 Oct 2015 10:40:20 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 7D4631432;
	Wed, 21 Oct 2015 10:40:20 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id 7B1A23404A;
	Wed, 21 Oct 2015 10:40:20 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Wed, 21 Oct 2015 10:40:19 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: brian avery <avery.brian@gmail.com>
Date: Wed, 21 Oct 2015 10:40:16 +0200
Thread-Topic: [bitbake-devel] [PATCH 1/1] toaster: orm Fix restrictive
	LogMessage	message length
Thread-Index: AdEKxNGioUCED+1mS1KI3jO8DGrkYQBFtrtQ
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7C58C5F15EA@xmail3.se.axis.com>
References: <cover.1445296793.git.avery.brian@gmail.com>
	<ec87576fce927732d3a9ac0270a16c70f6c91083.1445296793.git.avery.brian@gmail.com>
In-Reply-To: <ec87576fce927732d3a9ac0270a16c70f6c91083.1445296793.git.avery.brian@gmail.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] toaster: orm Fix restrictive LogMessage	message length
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
X-List-Received-Date: Wed, 21 Oct 2015 08:48:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of brian avery
> Sent: den 20 oktober 2015 01:23
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/1] toaster: orm Fix restrictive
> LogMessage message length
>=20
> From: Michael Wood <michael.g.wood@intel.com>
>=20
> Log messages can be quite log so use a TextField rather than a char
                            ^^^
long

> field with max length of 240. mySQL is especially picky about field
> lengths and will cause an exception of the log is too long.
                                      ^^
if

> [YOCTO #8475]
>=20
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> ---
>  .../0028_auto__chg_field_logmessage_message.py     | 345
> +++++++++++++++++++++
>  lib/toaster/orm/models.py                          |   2 +-
>  2 files changed, 346 insertions(+), 1 deletion(-)

[cut]

> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index a784b1b..0bbdbc5 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -1296,7 +1296,7 @@ class LogMessage(models.Model):
>      build =3D models.ForeignKey(Build)
>      task  =3D models.ForeignKey(Task, blank =3D True, null=3DTrue)
>      level =3D models.IntegerField(choices=3DLOG_LEVEL, default=3DINFO)
> -    message =3D models.CharField(max_length=3D240)
> +    message=3Dmodels.TextField(blank=3DTrue, null=3DTrue)

Why remove the spaces?

>      pathname =3D models.FilePathField(max_length=3D255, blank=3DTrue)
>      lineno =3D models.IntegerField(null=3DTrue)
>=20
> --
> 1.9.1

//Peter


