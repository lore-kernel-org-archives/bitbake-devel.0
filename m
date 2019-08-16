Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id C8A027F325
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 10:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 70F8D18579
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:51 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id fb6kPA3FSxcH for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:50 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 74A4818523
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:50 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5576F1A0A5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:50 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A49E1A0A4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:50 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:50 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by seth.se.axis.com (Postfix) with ESMTP id 3E8741704
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:47:50 +0200 (CEST)
Received: from xbox12.axis.com (10.0.5.26) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Fri, 16 Aug 2019 12:47:50 +0200
Received: from xbox06.axis.com (10.0.15.176) by xbox12.axis.com (10.0.5.26)
	with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Fri, 16 Aug 2019 12:47:49 +0200
Received: from xbox06.axis.com ([fe80::59d2:4cb0:3900:3c35]) by
	xbox06.axis.com ([fe80::59d2:4cb0:3900:3c35%12]) with mapi id
	15.00.1395.000; Fri, 16 Aug 2019 12:47:49 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] runqueue: Add a progress meter for
	checking	the task stamps
Thread-Index: AQHVVB9IQ68hA77ohka6YFJ1foYg76b9lwjg
Date: Fri, 16 Aug 2019 10:47:49 +0000
Message-ID: <08b2a48fd58544eab65392088f279ab4@xbox06.axis.com>
References: <20190816104159.30560-1-pkj@axis.com>
In-Reply-To: <20190816104159.30560-1-pkj@axis.com>
Accept-Language: en-US, sv-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] runqueue: Add a progress meter for checking	the task stamps
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
X-List-Received-Date: Fri, 16 Aug 2019 10:47:51 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces=
@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 16 augusti 2019 12:42
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] runqueue: Add a progress meter for check=
ing the task stamps
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/runqueue.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 7fa074f679..61ef864649 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -2672,9 +2672,16 @@ def build_scenequeue_data(sqdata, rqdata, rq, cook=
er, stampcache, sqrq):
>          stamppresent =3D []
>          tocheck =3D set()
>=20
> +        msg =3D "Check task stamps"

I do not know if this message makes sense. The commit message is=20
also on the short side. Feel free to modify them or suggest=20
improvements.

> +        bb.event.fire(bb.event.ProcessStarted(msg, len(sqdata.sq_revdeps=
)), cooker.data)
> +
> +        checked =3D 0
>          for tid in sorted(sqdata.sq_revdeps):
>              (mc, fn, taskname, taskfn) =3D split_tid_mcfn(tid)
>=20
> +            checked =3D checked + 1
> +            bb.event.fire(bb.event.ProcessProgress(msg, checked), cooker=
.data)
> +
>              taskdep =3D rqdata.dataCaches[mc].task_deps[taskfn]
>=20
>              if 'noexec' in taskdep and taskname in taskdep['noexec']:
> @@ -2696,6 +2703,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooke=
r, stampcache, sqrq):
>                  continue
>=20
>              tocheck.add(tid)
> +        bb.event.fire(bb.event.ProcessFinished(msg), cooker.data)
>=20
>          valid =3D rq.validate_hashes(tocheck, cooker.data, len(stamppres=
ent), False)
>=20
> --
> 2.21.0

//Peter


