Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB574C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 11:52:34 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.2])
 by mx.groups.io with SMTP id smtpd.web11.9841.1742298744894258975
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 04:52:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vU/N4Cfx;
 spf=pass (domain: siemens.com, ip: 40.107.162.2, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bboqTYtbHn1mmp2H4JfUIDgyHPZM926kU9Uj6aZhMZ6zMxmu4nTAyWK7tr3e4nlhPjxpSgO6OacmK9c7OYgjPOs8NtNZlOYXU2YuAM7IvIVTF+xB4k2IOIYCAUujB+CgYKoIzOr+e7smuDBHW5iNqUIozDJwGpUY7/vbDoYHE+oTYGp3khwMEgZ0jvBVV9XAyZrbDRyEVMZ/iqIMqqpr5miS/u9HvW+bQ/RaUDWxwH3Osei2xLtnTKHej3K0w2wIt/2YW6/vvNpEaJNq3uLuYCJefqDyLGLaFKbflvU60WzMX5W92STGtEC5nsz+0R1CDSa7x7xslMdl04DxpUOsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKlvPdw4hMVmjxwJot0m7W3lhWM899bIv3yDHFb6Zfw=;
 b=oqo1r9qPYqK0iP0XockjGOxexPn4t+oEh9H0x9l/aAOzJsuyaSIM7pmv93P+dOKmkEW1P5kdncbp1fkEdNzNhWrYiYMcLky5n2EHFsBtRmkzqx7za5GW5nJUCqlxcwOOd6uppbV5rejUT3p9gFZ8o9b500/nyuoY/JSusnKbWQ108IShdfTl3LQJT6m4i7+5dUqjS8SRFplRh2yasJQEGsCNs44Mo+IWBOF06C0mEYQA5Y956FA1LDQ4Xm6vu0eZj3rzztDu1ULZB04GHCZUrBczoZTYPykMcg747IcaRt5iXmKrcUEg4L5/iYswP36yrKqaf2KXpB0kb47YJGId6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKlvPdw4hMVmjxwJot0m7W3lhWM899bIv3yDHFb6Zfw=;
 b=vU/N4Cfxm+CJ5YpElLYEfgnpstxNdbaanq9+yKEdQemwqxSIVmP/H1emMLG6ICTalcG1s+nEuAFJ4Wf0Fpbrm0mR6sn2PSwtERipRs+Y5pxrWxKyU97b4AzczeFreZcJfeqrEf4QPHoqsgGCD+7/GAwx5MVb5bEvM2b51JWTqzFbHBsY/iI0oRt9xvRCm0Hb56ytS7vkQL9hcVoHvFruvf+S06yvROTCzDn3OPP+LNKjGE20AEfoYoD7+bqhaSNEVdXs1eYmGwWh5MW2j8pX0VAkiMxJsaExhIbyFVfSZ8eIqVRXMfEaIZ6kfBKX5LHW7VLiQhNjc5ot3ys/jzUEtg==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS1PR10MB5699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:52:21 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:52:21 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch/get: Rework tag parameter handling
Thread-Topic: [bitbake-devel] [PATCH] fetch/get: Rework tag parameter handling
Thread-Index: AQHbl/X/TtmiXj01fUe2463nynHh+LN4wn/Q
Date: Tue, 18 Mar 2025 11:52:21 +0000
Message-ID: 
 <AS1PR10MB5697EA94CD905C93AF76CD38FDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250318110743.3936601-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250318110743.3936601-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=719c9d38-2b88-4285-9e4f-6e882b2ee410;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-18T11:30:54Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS1PR10MB5699:EE_
x-ms-office365-filtering-correlation-id: 719ce2d9-38dc-4648-813d-08dd6613576a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?WOD4r5Q69MNNpHiFAtF9heLkiJ+gXvWxmdD6mmN3OIdi/5c8D3VBgSEVdRJO?=
 =?us-ascii?Q?rwFoVCvGtvP+/89qYxYJ9N3qSfpuLvOfhsx4KOWSGpsFd7oYJpTOkmmzgJ+d?=
 =?us-ascii?Q?hGSOz15akAXB5CJxfnTnba/xLEMl7CIha5DQ6koME1avlZABxy22N+1qnEvT?=
 =?us-ascii?Q?DONyTjxvtZU9s99ER6M3ArfUpZK4jdUuySAv7C7WO0QWsAUU0LZJWgLnQV51?=
 =?us-ascii?Q?IZ9LwSgVfT+v307lyfnWU82oFwQV+QYrEcu5L0ao46GRDkOAhH6t2zgxi/jk?=
 =?us-ascii?Q?sxVYAMcfUdTsBsjv8qrX9BP6PTTaRLqywjCH+7citAMxjWQ54R9fvOrrdyxs?=
 =?us-ascii?Q?YMuqZVExVCq0QTHn5oKGHRU9SXTrXIZe8P08cheOyuvhv9H1/rhfowtMEUqx?=
 =?us-ascii?Q?2X8gaTZ2JZiURB1bQ1tLR0yR0GNi7K6Os3R9hRS0Aic1mqkFvhFSCi3toRwg?=
 =?us-ascii?Q?sMQ0adVFB19fBmIvms91J0uB4FPlC8L1C6vM1Q6RKAl0aO88ooq8lY1SHSZZ?=
 =?us-ascii?Q?3TqbqfSkxPY7qLmW0OqcUx1gtK9L8SDLcEVTXQZNdj/NrFharaoqHZm84qCX?=
 =?us-ascii?Q?Va0BWc3pMQD89drivf+TDmaMsYbX0mJKP5jgdSmfpDrqeKNQ0bAdp/MFQr8x?=
 =?us-ascii?Q?imfMj6cc7dNPIeycd8QMRZXHoWUC85mnqT8QZc2cyC/OvdaD6cDI6/un2b5H?=
 =?us-ascii?Q?89ydN1Ey8xzVQOre7bTdcnkLp5qnrd1EGGoYoUVQ8eWBpqlHFNMKJue/vsUx?=
 =?us-ascii?Q?e4UV26PmxZQINYQZ38FPvmdsMcd76sLwfIeAUv5JPZ+mphEJ46bvEn2iZoxS?=
 =?us-ascii?Q?VO1lb+C2zcXcuaBM15BxJg+Mpy4kfo1Z19uHV2Z2lUvweyqpvSQMC022dNXz?=
 =?us-ascii?Q?C9Y1SSV3XhkiFFjbSkBhAwfYY6D33mHOcv27GLop24pRp4+VqN6DSDhWAmj0?=
 =?us-ascii?Q?R6ykoCP0nDbdGY8ArZvleAqT4h0en9g1i2ClqidMCzqaGXTnnMYpLiXu9Lm4?=
 =?us-ascii?Q?hReo6RWn8feBmkfE0LZL3sHGWu+oUymYt2b+BQFk0HWT7NafCeHbCyo3T1iW?=
 =?us-ascii?Q?XQtBLB1WNOCvmFdBYtaCrJteiYSyGVUqKmf/idVCwG2NorxUpe0uofhZFaN7?=
 =?us-ascii?Q?omdRxlPGCsQ/BWMeQdbzZIAiDXFpGuOmHpW0mpu/vIwWfcT8w6Zxtn7Gq816?=
 =?us-ascii?Q?IUx5f4Ut3JYIsvXRnffREi5XEMbLK342TV5q/S8HEi5NcuSU4X10+B1/OmJ4?=
 =?us-ascii?Q?Wwsp5JCCFjy6bwU6mIVHOY+ieptI7HW0hwn1dQ/QRk9wPgHcLMcbgHxnsgYB?=
 =?us-ascii?Q?/VamaW54rh8KK8RxU0ckq0lU/DoGrz1gltVEYisIEz6WYPJgXcQzxTJwld6F?=
 =?us-ascii?Q?D/dO0cxjDZpDqAT9zae1zAuxW2ThivZkoB7qmLXzwYKFCzbOLzlQa93vY0hY?=
 =?us-ascii?Q?mduIpvFKA12YWbIbtCoIpwy8sU00Wp14?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xtiLJWtQeOysSfKG5IQV5jOqCYExlj57Id+n9LSY01djszvJGzhz6HR9/fXL?=
 =?us-ascii?Q?1bSxZxnJXbESzbF/qFKOQ4rTgi5Xh4pxDpe8l2LsNtHkobHGhrsA+vtZVUzq?=
 =?us-ascii?Q?CZAL9a5S5jFoOLY3qpbztYV8uJ+n0pXzhxds01KimHVubVIDNbeLCWUWikcv?=
 =?us-ascii?Q?UCic8sZb/w/pQC7GM3TCrEQZHoJjPXcXUWEIBzysPRZ/r5Zpq6OLg2TU0aqd?=
 =?us-ascii?Q?7OQ0DtYTVjtyxZaL+wwygY14G6b4tlCvDZDUGq5Np9tFVmetCD+p2h0458Ru?=
 =?us-ascii?Q?SKjqE375FIRHeDIQ8Eu2xc45ybfSEpeOXe7l70VP3wtMx1UazsemPi2qOoB9?=
 =?us-ascii?Q?iCqb0urcaDz//6JjuHB5Le6g8QjNhKkUsrSa8GwrBEGf9fNGaOCnjzSE6AKs?=
 =?us-ascii?Q?YV/qIWdB0sYqkLykHfr9X8ek3Hy32/kUsCeLeMXD6Z8C5NU9wH/VBmng4BXL?=
 =?us-ascii?Q?3sOSJNwdE2AN7zpmJoqt0su5SvVh/Es7TFVeVrzpLjhlf0YKLCiPTfGvjTyN?=
 =?us-ascii?Q?KAlc61Fuf2uf5adZwulUhyLgxyFGE6BcRz8/rWzkdyR0C2+5mGO6S3odIbIy?=
 =?us-ascii?Q?fyVfH+akdxhTA75HRIDx2oULs3gjudIc4FrdxYBSgbgfTGRttMUiiKlYbWR3?=
 =?us-ascii?Q?b0HMneljnS20uwPMliNH8vshEo0S2EeKHZMn7tYzC5rdWyFlYfhJmT6omSIb?=
 =?us-ascii?Q?HueD9NFKbryHw1dCyG9088Rp+4iR25pWYZoKSGM9sU+T1QAV+TOTP1oUEoKG?=
 =?us-ascii?Q?2R5dcZIQchjSZJD/yAhDZXGETLu/VycWIsxJDycp8RiApn4TeSm/4tQRYkqP?=
 =?us-ascii?Q?dJkzw/vrtDuXzcLz+hlfo5uVooIU+sDcH9LucAMWQ1eebPtWrQDtT4F4EaiM?=
 =?us-ascii?Q?Kr3fqVaWcvCaDdY3jlFI7A6ZYb8q+mjUZ8sSInW8WsICm5gAdMNUsf130Pq9?=
 =?us-ascii?Q?TRCCammNgrXzwAD5I6OWrh8PmyIWCGzus65tjnVGe6oCJnI6oI3vEkYZfnY2?=
 =?us-ascii?Q?+WQe2J7gMzjQMOzZGrDFe5zGVgxR5R/07pjXKkzvN4Ut058GaUwS7d4jtfyU?=
 =?us-ascii?Q?iIwcs+D0jbMs4zlfZFBXdcDfNiicQ21IyUdBXa7luMsgHFSSN9B/DHG5Z3IF?=
 =?us-ascii?Q?pR7w0HR37QMBR3ML4EXY+DgChZfsgUYiAfgUf7C1LweJqfsocSDgWAu7Fh7K?=
 =?us-ascii?Q?wORrCzEMsdRSHjCoHAi3lp1xttmxtEVdEeuV4DLJ6BU5362Vbq512Xu2Ft7j?=
 =?us-ascii?Q?DlowMlLYgLl03Ziosdmnolj1l4qylsridoxY6jZkqvkYYXddFWMDF6k1Od36?=
 =?us-ascii?Q?kL7O/Va7YH2TA/i67Yeerp14zUnPDRicutm9zmMnFGdS4+A2+Q+Rg4uaw42q?=
 =?us-ascii?Q?tdVAXAOxGkk0goZDcpEsXSWbnDfEh55JJJsIDmHk6JyCtnU1EDqzmfcl21NA?=
 =?us-ascii?Q?GBuYuoh6JQVHQYRYOjE76wnIhwzeYNidr5Mf2tCZz6u2uHevCVWT9u4H5oNS?=
 =?us-ascii?Q?1aNbje1rv72JsDZEXpzU4UvVyZNyz55n8eD0KvkPJVnsC83LEeZtKoeAZLFU?=
 =?us-ascii?Q?bUdnlRRNFUMmmZj7O+7Oy+Hl66ifFXp58CALgcKM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ce2d9-38dc-4648-813d-08dd6613576a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 11:52:21.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZY2yQwAAZDt+/U2EiYMgzXtUKLntwNV1doejiB52Q+1539ebvZeLHYOiKLREQg+ttL8Y9vU1G895Ld1OxL6cfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5699
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 11:52:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17453

Hello Richard,

I think this will break git shallow tarballs.
Those (at least in scarthgap) don't contain tags so the check will fail dur=
ing unpack.

Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> lists.openembedded.org
> Sent: Tuesday, March 18, 2025 12:08
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] fetch/get: Rework tag parameter handling
>=20
> Currently bitbake disallows tag parameters along with revision parameters=
.
> This isn't great since quite often, we'd like to verify that a given revi=
sion
> does match some tag. At the same time we don't want to or need to access
> the network to verify this, which normally a tag would require.
>=20
> Rework the code so that tag and revisions can both be specified together.
> Verify that any tag specified matches the revision in use at unpack time.
>=20
> This means we can start requiring people to put tags in git SRC_URIs
> when revisions are used, making review a little easier that it isn't
> some random revision.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/__init__.py | 13 +++++--------
>  lib/bb/fetch2/git.py      | 12 ++++++++++++
>  2 files changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5aa67accc3..cfbbce5288 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1248,20 +1248,17 @@ def srcrev_internal_helper(ud, d, name):
>          if srcrev and srcrev !=3D "INVALID":
>              break
>=20
> -    if 'rev' in ud.parm and 'tag' in ud.parm:
> -        raise FetchError("Please specify a ;rev=3D parameter or a ;tag=
=3D parameter in
> the url %s but not both." % (ud.url))
> -
> -    if 'rev' in ud.parm or 'tag' in ud.parm:
> -        if 'rev' in ud.parm:
> -            parmrev =3D ud.parm['rev']
> -        else:
> -            parmrev =3D ud.parm['tag']
> +    if 'rev' in ud.parm:
> +        parmrev =3D ud.parm['rev']
>          if srcrev =3D=3D "INVALID" or not srcrev:
>              return parmrev
>          if srcrev !=3D parmrev:
>              raise FetchError("Conflicting revisions (%s from SRCREV and =
%s from
> the url) found, please specify one valid value" % (srcrev, parmrev))
>          return parmrev
>=20
> +    if 'tag' in ud.parm and (srcrev =3D=3D "INVALID" or not srcrev):
> +        return ud.parm['tag']
> +
>      if srcrev =3D=3D "INVALID" or not srcrev:
>          raise FetchError("Please set a valid SRCREV for url %s (possible=
 key names
> are %s, or use a ;rev=3DX URL parameter)" % (str(attempts), ud.url), ud.u=
rl)
>      if srcrev =3D=3D "AUTOINC":
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index a73fb79ac8..53fdc4c3df 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -279,6 +279,10 @@ class Git(FetchMethod):
>                      ud.unresolvedrev[name] =3D ud.revisions[name]
>                  ud.revisions[name] =3D self.latest_revision(ud, d, name)
>=20
> +        if 'tag' in ud.parm:
> +            if len(ud.revisions) !=3D 1:
> +                raise bb.fetch2.ParameterError("Git fetcher support for =
multiple tagged
> revisions not implemented", ud.url)
> +
>          gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.repl=
ace('/',
> '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_=
'))
>          if gitsrcname.startswith('.'):
>              gitsrcname =3D gitsrcname[1:]
> @@ -747,6 +751,14 @@ class Git(FetchMethod):
>          if not source_found:
>              raise bb.fetch2.UnpackError("No up to date source found: " +=
 ";
> ".join(source_error), ud.url)
>=20
> +        # If there is a tag parameter in the url and we also have a fixe=
d srcrev, check
> the tag
> +        # matches the revision
> +        if 'tag' in ud.parm and sha1_re.match(ud.revision):
> +            output =3D runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd,
> ud.parm['tag']), d, workdir=3Ddestdir)
> +            output =3D output.strip()
> +            if output !=3D ud.revision:
> +                raise bb.fetch2.FetchError("The revision the git tag '%s=
' resolved to
> didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'], output,
> ud.revision), ud.url)
> +
>          repourl =3D self._get_repo_url(ud)
>          runfetchcmd("%s remote set-url origin %s" % (ud.basecmd,
> shlex.quote(repourl)), d, workdir=3Ddestdir)
>=20

