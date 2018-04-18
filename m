Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id DAF5160103
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2018 22:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 5439418450
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ZpRbAuh-pUtC for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:40 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 664681842A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:40 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C4941E081
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:40 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D2D61E080
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:40 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:40 +0200 (CEST)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by seth.se.axis.com (Postfix) with ESMTP id 30C5E1798
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Apr 2018 00:54:40 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Thu, 19 Apr 2018 00:54:39 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1263.000; Thu, 19 Apr 2018 00:54:39 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] lib/bb/utils: prevent movefile from
	changing dest dir permissions
Thread-Index: AQHT0NqGmX8Lv6CQCUy3c32ovfYzCaQHLnSg
Date: Wed, 18 Apr 2018 22:54:39 +0000
Message-ID: <2546e2aa64f34330895c465a45232889@XBOX02.axis.com>
References: <20180410144451.8539-1-pkj@axis.com>
In-Reply-To: <20180410144451.8539-1-pkj@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] lib/bb/utils: prevent movefile from	changing dest dir permissions
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
X-List-Received-Date: Wed, 18 Apr 2018 22:54:41 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Any chance of this making it into Sumo?

//Peter

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Peter Kjellerstedt
> Sent: den 10 april 2018 16:45
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] lib/bb/utils: prevent movefile from
> changing dest dir permissions
>=20
> From: Mattias Hansson <mattias.hansson@axis.com>
>=20
> Prevent movefile from falsely setting the source file's owner and
> permissions on the destination directory instead of the destination
> file when moving between devices.
>=20
> This bug caused the last file moved into a directory to dictate the
> directory's owner and permissions.
>=20
> Signed-off-by: Mattias Hansson <mattias.hansson@axis.com>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/utils.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 8b739d7849..378e699e0c 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -807,8 +807,8 @@ def movefile(src, dest, newmtime =3D None, sstat =3D
> None):
>                  return None # failure
>          try:
>              if didcopy:
> -                os.lchown(dest, sstat[stat.ST_UID],
> sstat[stat.ST_GID])
> -                os.chmod(dest, stat.S_IMODE(sstat[stat.ST_MODE])) #
> Sticky is reset on chown
> +                os.lchown(destpath, sstat[stat.ST_UID],
> sstat[stat.ST_GID])
> +                os.chmod(destpath, stat.S_IMODE(sstat[stat.ST_MODE]))
> # Sticky is reset on chown
>                  os.unlink(src)
>          except Exception as e:
>              print("movefile: Failed to chown/chmod/unlink", dest, e)
> --
> 2.12.0
>=20
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

