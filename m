Return-Path: <prvs=02875de3f=Ulf.Magnusson@bmw.de>
X-Greylist: delayed 579 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Aug 2016 15:07:47 UTC
Received: from esa3.bmw.c3s2.iphmx.com (esa3.bmw.c3s2.iphmx.com
	[68.232.133.150])
	by mail.openembedded.org (Postfix) with ESMTP id 4ED1376420
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 15:07:46 +0000 (UTC)
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
	esa3.bmw.c3s2.iphmx.com with ESMTP/TLS; 15 Aug 2016 16:58:08 +0200
Received: from unknown (HELO esabb2.muc) ([160.50.100.34]) by esagw3.muc with
	ESMTP/TLS; 15 Aug 2016 16:58:08 +0200
Received: from smuch54b.muc (HELO SMUCH54B.europe.bmw.corp) ([160.46.137.112])
	by esabb2.muc with ESMTP/TLS; 15 Aug 2016 16:58:07 +0200
Received: from SMUCM59B.europe.bmw.corp ([160.46.136.59]) by
	SMUCH54B.europe.bmw.corp ([160.46.137.112]) with mapi id 14.03.0279.002;
	Mon, 15 Aug 2016 16:58:07 +0200
From: <Ulf.Magnusson@bmw.de>
To: <peter.kjellerstedt@axis.com>, <jeremy.rosen@enst-bretagne.fr>,
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] add a syntax to clear variable
Thread-Index: AQHR41xEQfPEbASBmEa0nxMYyx5wQ6BKHuWAgAAjCo4=
Date: Mon, 15 Aug 2016 14:58:06 +0000
Message-ID: <91CC97698835684980CD15EFCBE86BDC26D002B4@smucm59b>
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
	<1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>,
	<14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
In-Reply-To: <14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [160.48.96.23]
MIME-Version: 1.0
Cc: jeremy.rosen@openwide.fr
Subject: Re: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Mon, 15 Aug 2016 15:07:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,=0A=
=0A=
> -----Original Message-----=0A=
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-=0A=
> devel-bounces@lists.openembedded.org] On Behalf Of J=E9r=E9my Rosen=0A=
> Sent: den 21 juli 2016 12:56=0A=
> To: bitbake-devel@lists.openembedded.org=0A=
> Cc: J=E9r=E9my Rosen=0A=
> Subject: [bitbake-devel] [PATCH 1/1] add a syntax to clear variable=0A=
>=0A=
> From: J=E9r=E9my Rosen <jeremy.rosen@openwide.fr>=0A=
>=0A=
> unset VAR=0A=
> will clear variable VAR=0A=
> unset VAR[flag]=0A=
> will clear flag "flag" from var VAR=0A=
>=0A=
> Signed-off-by: J=E9r=E9my Rosen <jeremy.rosen@openwide.fr>=0A=
> ---=0A=
>  .../bitbake-user-manual-metadata.xml               | 17 +++++++++++=0A=
>  bitbake/lib/bb/parse/ast.py                        | 33=0A=
> ++++++++++++++++++++++=0A=
>  bitbake/lib/bb/parse/parse_py/ConfHandler.py       | 12 ++++++++=0A=
>  3 files changed, 62 insertions(+)=0A=
>=0A=
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-=0A=
> metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-=0A=
> metadata.xml=0A=
> index 6329cd6..c42907e 100644=0A=
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml=0A=
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml=0A=
> @@ -333,6 +333,23 @@=0A=
>              </para>=0A=
>          </section>=0A=
>=0A=
> +        <section id=3D'unseting-variables'>=0A=
=0A=
"Unsetting" is spelled with two t's.=0A=
=0A=
> +            <title>Unseting variables</title>=0A=
> +=0A=
> +            <para>=0A=
> +                It is possible to completely remove a variable or a=0A=
> variable flag=0A=
> +                from BitBake's internal data dictionary using the=0A=
> "unset" keyword=0A=
=0A=
There's a missing period at the end of this sentence, and "by using"=0A=
sounds a bit better.=0A=
=0A=
> +                Here is an example:=0A=
> +                <literallayout class=3D'monospaced'>=0A=
> +        unset DATE=0A=
> +        unset do_fetch[noexec]=0A=
> +                </literallayout>=0A=
> +                This example results in the <filename>DATE</filename>=0A=
> being unset and the flag=0A=
> +                <filename>do_fetch[noexec]</filename> to be cleared=0A=
=0A=
"These two statements remove the DATE variable and the do_fetch[noexec]=0A=
variable flag" is better. "...results in... to be cleared" sounds weird.=0A=
=0A=
Cheers,=0A=
Ulf=

