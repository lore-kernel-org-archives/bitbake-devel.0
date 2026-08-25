Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64544C61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 18:12:13 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28822.1787681524754160834
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 11:12:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=ocKeEpcp;
 spf=pass (domain: axis.com, ip: 40.107.130.60, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEfp602jUXFNR1BTWNZ+L15VIzGJK4HuIUGyB3bkNzmh8Jbd+IuTbwM2YQxnZsLy2iAEaHSzZsjHRgW8853q0m3yDtxxFPTyyKrlZaAmogNgxQpsomA1RFvGkyN15pODDFff37Ed5+9+/GVtxdRS7kaLa+lTEJt0HDBqNV9qB/xkZPDv9wn6fYCuaub0UJggBSSKTmGByaQeJDhchoSVIQGnpH1ZMtS3nRi8RpIrOZIBrhRZwVAP7avnfzIUrJeZnZTkvOoefp38+8IIdxZzj9vXIjxMRtlZuf6Gs0HsA42AMOr8IxEMOHKwsw6j8pUm1acuZjzQj2weVRyKM+bLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w30N7JFmD1ufB3CxmU1ro2JxhzThcRl74zU8eC67KE=;
 b=ZYMtM7/0KCo6wPnddKz1Ah7Oeo3ynZUGsEBL6aEH7NsXCzO9JiH066Pi5vc1/L3mOWVOEwyfZNRLfJmrtxkW7ku8QWdzVAhCGEyEgXKo/AkmKXsL0V2EIwTHkmfKXUMSHV8lOXI6RbvB+ks8i22tVBr3A2Ocg27XfqEdxvRG27eVTm2Ekk/GDzirDrm7vyonkuDAxvPnVxXAIjWThgVC/enlRH07G2GpAPjMiG3TYuN/9FzgL/Sx1I4vcPOSQvYIsUx/yWfZG4k71fA1L5f1J6YAEt4gt+fJWtEY4z8s23wyG1pRfreJVv6GJmiui6xYsH+uyt/iDamULJg78fqQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w30N7JFmD1ufB3CxmU1ro2JxhzThcRl74zU8eC67KE=;
 b=ocKeEpcpvzdCP/LeSIlOgbxD7G6WJQ/whYGIhYHJz/HHFIeiB2vPj89oIjYen/d7zfI7I4EF+grJukTJV08p0lXnJ2POqbSzDWd6jZuJvZbi/hhdR706aIRSm1ExepRp1DY38VJaLqT2ClR+jhu8WK8GoiUx1aQ1IhzW0H2if3o=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS4PR02MB8286.eurprd02.prod.outlook.com (2603:10a6:20b:506::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 18:12:00 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%4]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 18:12:00 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Topic: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Index: AQHdMY+BJ8eJHMnwC0K06s/Mz4icqravFuHA
Date: Tue, 25 Aug 2026 18:12:00 +0000
Message-ID: 
 <DB5PR02MB102134543E3418DA8C1C06E4FEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
 <20260821170624.436725-4-chris.laplante@agilent.com>
In-Reply-To: <20260821170624.436725-4-chris.laplante@agilent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS4PR02MB8286:EE_
x-ms-office365-filtering-correlation-id: 9386f2d8-3776-4ea2-f298-08df02d45b83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 
 yqMDV+fvvtCUW7Omu4QW6AOBN37cLME2uVjhQLAbksDuJy83phQ8ITLtuooZ2ilp+48G3py9P8CDpmdYRHOc+k0ScLgm2UBjGT1AD3ZjfUROkXJYQPGp7aueJ6XmoxZ35ildcpbcuOtANopE+lyBh3sEoVgJxsc+5D0v6wSC7qC1KoGWE/MDAplfiebDdXlsZ2S0wuEtvuVIU+e2xBUdgYXC2Z6s+0claWK/DcZL+PCgRbb3Xyy4H1bRDUBP03AtkX6hIYU1A21IT9A1vNok/8snpCVHZQbQsWaD/XuEvFK37nOEHb6O1Nl09G6mG2QWcrvwkj+sRtlN5wwahf2ED63odXTWLRE7hL7k6fsT99ii+FbV4p2h5VW6s6FKVlca9iedLLRzfuzL3Xxx1Dxr7aGpZ7Yli51CTMQi6CWpV9mO4x/D+2Ygy1a7h+BmcKViEr6e+djPgCpEXDvZm7GWNnFP4mtju1j9oH9/4qTK/T/ExUNj5ylCRrpvuT0f+duLCgyO33j1ji9quuHkLJ0ANjmylCiV9go9tdFMt8F3SwcqKs7WHYT+gKoPPvZX0iRVfj6FcT9gUOF6PFqIELfG4AtwBCn/FUf8kGoEilS1LIiqsvJ6Lmn7tLubKDoa4zo/Ia0U6T0b5YOHqXQfk0ItQ6PJyDxqMfT91YXVLm91RvO8nnPC7uyJIyC8Q6IB95WddIvwpTdbntgLDOAtp2oP2qbFhpNmyYkqGOzeuiALwp4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?I2VUE935opmdbl4nvqgkCEFTxtp7irNuS7gyU8+MOO30ZmVccKKsiSDl7Xpy?=
 =?us-ascii?Q?CuvK7y/r6/OgpiCRi4BM39c7iK/7a6tIX7AxFE2F9/flKvsAmGZyssaZobSi?=
 =?us-ascii?Q?u8HS2qhQoy17E9GmQNsGcBlHAO3zPceXpeNZWTcDIeG4fJKV8TqGgiyynkwy?=
 =?us-ascii?Q?nKspeodK7ktAQSAEu7nCmxV80NJH40Hn0meCj+BRALfVJ6eGml1bd/ZZwDq8?=
 =?us-ascii?Q?5CJ138R5PR6CnYMiqUbJGtvA220wP58fR4FFnAlntAmTabymab6vxHrB92EC?=
 =?us-ascii?Q?HojeKxPOT3bfTCqt5ah/959S5HhtjzGOhptt/S3hPaGQuMfCE8IkB0Qbpt/x?=
 =?us-ascii?Q?Wv6AKFRl7asI7aV7A6aORqpdg7S6XE5yj8noXgnHVUdmsOY6DGe/gxqUnrnt?=
 =?us-ascii?Q?fPFuh6TMaENxyH+cvGkTKBHetdYss0e4b6nlytCHaUKFcEN0Fig1RfeXqijw?=
 =?us-ascii?Q?k5H6y5gMsCbfeCo06BRJvOgGOnv8TbOIXyT9qZRkz5rJUKHSN8JwBXubdtrV?=
 =?us-ascii?Q?M6FaG+2jzx6vMPFjYFjahVL9Gw7AjZ2ybbeR/uxojzw7WQxeC7DDS2ycW341?=
 =?us-ascii?Q?46ED9MRCQ7PCRIsCdyIh+vgpyarLR3MFZ2gkmtM9SmxaU1Dhh/4gvSBIgeNF?=
 =?us-ascii?Q?3/2gUf3xncuJZjBqQ9XmA+oFcZOk/Qg2MbzF2Bol44k0+IWw6TxLyydgiKTL?=
 =?us-ascii?Q?5h8fhUTuUFC3dCeJtj00WBjTqepGDLZ3bnkBwCBUc0gvzuY7pYBlDhEnFVwx?=
 =?us-ascii?Q?gd5lJGNRu6LMSnMh7G13GZhtMJ3JY3Ee0ibbDqga2cCEFwq8x27tcMv1AA2C?=
 =?us-ascii?Q?W66Eyy9xZZEEEw+udTKAORPGHT1VrnANRySfQqTKb2IWjfvZYOpJI62rvlmd?=
 =?us-ascii?Q?ZoWHXHMaL+i5CR6ZAL/tfGkqJhUuRmM75Jxv7ldh21cLS35//0Z3mgy4qE5u?=
 =?us-ascii?Q?sWenXYefi6sKHEuM+1Y6r83p8R0z4Sd9MhIaitTdpKDbYqNYAL5LxJXg+6IR?=
 =?us-ascii?Q?lCbkB/eZaeFH2nzSFUF+k161BeWGadNnK2CU6xFk9m20JJVCDQXOUqtf9lXD?=
 =?us-ascii?Q?gaxmKsCoq4a9il6OvCHK3sFoccn2N6PFG5L0DAzc7Ol6F1ems0OIAa3biVLS?=
 =?us-ascii?Q?D+uXUw1nX1uMtdVOwFmRt4O+HvUYLjmNUMABemNti7ZdN+Vv1pi11ngC3iNJ?=
 =?us-ascii?Q?lFwJDm4s4e4gRhB1FPdQ5slYKHb5FcMif8+TSEss4A4o9xNVjfVeU6lGNlbj?=
 =?us-ascii?Q?42oLOZew2BC2KB8Pnxnu1UOjwU9+ew22KPg2r0XBSul+6ZRXkgfDFVKz1sHS?=
 =?us-ascii?Q?ywDdYp4vS/af2Sbt2vNDlNN0spadWq8EkaZwrb9GfwjZad+VphQRCGGXKKP3?=
 =?us-ascii?Q?f9ueD+3yb/P3TwNLy4XM8WOGumrUSpU+EOY38yemESQEiBYjcwj8FxUM86+l?=
 =?us-ascii?Q?rJSN8AIjSy2KLYmImhJGym+DBbZaEfwesMBpvCtYz9pQHaF/faACR7e9OjeV?=
 =?us-ascii?Q?Py0m8fJR5wAMn3gqjBiXUct9R2tlFiCS0ZTnMoLxEHMcPw43SvzFOuzk8n4j?=
 =?us-ascii?Q?y+NVwStUgyTS6uHV1vIACbtd+nDf4tVFd7/x0MPEnfG2KjFYE2lPvXfbzrSm?=
 =?us-ascii?Q?qb758UnE8DBd77LYTnztXw3DawnyZZIZ77HTh5f9pW0BN1E7FxYPLHtA5Mu9?=
 =?us-ascii?Q?lMgkpvmlNJ8y27Bq2pLFn0WFiew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9386f2d8-3776-4ea2-f298-08df02d45b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 18:12:00.1369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+9dUWKFIfGBkgoYCtObhtqZP6jZeZvAw/+H9FYjqmoq2+zzO5dWRIAYA5LDJGMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8286
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 18:12:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20039

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Chris Laplante via lists.openembedded.org
> Sent: den 21 augusti 2026 19:06
> To: bitbake-devel@lists.openembedded.org
> Cc: Chris Laplante <chris.laplante@agilent.com>
> Subject: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
> cleanup fallout
>=20
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> fetch2 replaced fetch a long time ago (2012) so I argue it is time to
> say goodbye the bb.fetch shim.
>=20
> In doing so, we reveal and cleanup a few circular imports and transitive
> imports that must now be explicit.
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/__init__.py   |  4 +---
>  lib/bb/build.py      |  2 +-
>  lib/bb/cookerdata.py | 11 +++++++++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index bc5e9d82b..049c87ef0 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -90,6 +90,7 @@ class BBLoggerMixin(object):
>          return self.bbdebug(3, *args, **kwargs)
>=20
>      def bbdebug(self, level, msg, *args, **kwargs):
> +        import bb.event
>          loglevel =3D logging.DEBUG - level + 1
>          if not bb.event.worker_pid:
>              if self.name in bb.msg.loggerDefaultDomains and loglevel > (=
bb.msg.loggerDefaultDomains[self.name]):
> @@ -152,9 +153,6 @@ class PrefixLoggerAdapter(logging.LoggerAdapter):
>  # can result in construction of the various loggers.
>  import bb.msg
>=20
> -from bb import fetch2 as fetch
> -sys.modules['bb.fetch'] =3D sys.modules['bb.fetch2']
> -
>  # Messaging convenience functions
>  def plain(*args):
>      """
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 40839a81b..8b49721d6 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -24,7 +24,6 @@ import datetime
>  import bb
>  import bb.msg
>  import bb.process
> -import bb.progress
>  from io import StringIO
>  from bb import data, event, utils
>=20
> @@ -387,6 +386,7 @@ esac
>  '''
>=20
>  def create_progress_handler(func, progress, logfile, d):
> +    import bb.progress
>      if progress =3D=3D 'percent':
>          # Use default regex
>          return bb.progress.BasicProgressHandler(d, outfile=3Dlogfile)
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index c5fcd71be..eedfd5406 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -16,9 +16,16 @@ import re
>  import sys
>  import hashlib
>  from functools import wraps
> -import bb
> -from bb import data
> +
> +import bb.cache
> +import bb.codeparser
> +import bb.data
> +import bb.data

Double import of bb.data.

> +import bb.data_smart
> +import bb.event
> +import bb.fetch2
>  import bb.parse
> +import bb.utils
>=20
>  logger      =3D logging.getLogger("BitBake")
>  parselog    =3D logging.getLogger("BitBake.Parsing")
> --
> 2.43.0

//Peter


