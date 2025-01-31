Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF7C0218F
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 20:40:24 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.6])
 by mx.groups.io with SMTP id smtpd.web11.29300.1738356015753553974
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jan 2025 12:40:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=dRXYMuk4;
 spf=pass (domain: axis.com, ip: 40.107.162.6, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msl2fnabmU8O285N1E/iLhxBZi/kACbEB84Ntap4mT0dLaEdMIKB23DXtXNBG8BiZOwO80wOBlPLuyEfz8C+AaOtuQMXuW+BFpGeBjPiW3eAAdEwpWcHSxzkxZc16BoVvLwOas0Cwl+hX1Vm1VUODTYh6pIYe4LxSrkoSMRxtn82ksiLzyE9ipYkLnVqX0VTB57SzIC6rQDFu8Yjwv2YR/OqNLqs0WOs4POivXQ1BAmz/r/I7Qq9CAtdCK8Vxt7j31bkqnr89fe9FYX60uAAv8i0vVQC791PskpxahFQN/gKCYvMyMrw0jCVRbdrOOws1KcMt6QNED6kcrf1nilcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPCsW8u+l1L+u7WcrJPztSDpUu79n2pKpokMtyhD2lg=;
 b=fx05a+DAtHAZu/TJ5RXKuSd64kVmaah2pHYXEbnuWtkNqW+Tj5x2g3m6T4NdMQDsZqdFxUXueI97OSjR4FoA1leqZe7NTFAj8quhNiULFi4xyk2gYiWN8HU8/Ad769BizIi71NDEKUrUsyvjNOyCpJkUqRFkoe4Oqa68LYiBPOOQ8id3ki8NR/MXNCqYvDh69PYkoa4o3XpPZTfgCCVQs1EnZbxmZCgEsAdLaJL3BPMob/51dCmyeOczPyW/7PAXx1rGdYYC0BXcVTTB0tV/JRtW9D2WCjbdThdiKHl0KCrjhCpBrYTIpeuwwb3jJXnpDwSGTTJgljP1xNFhZOoEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPCsW8u+l1L+u7WcrJPztSDpUu79n2pKpokMtyhD2lg=;
 b=dRXYMuk4Dogcpj39OfkQXbUBWhycWM1vSXqnvs+Ppkj3dP1MmmiFJWh7nvcc5EeIj4HOnk41zu9uqxX1+N57IcVoiRqsKMSvP/SCaNwoBrEGXK3hgWTlYz3A7VlbiHtElqFSOcy+CAeoUPK352FAv7VPNB/bDSYxyQOFZ2UyzhU=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by GVXPR02MB11013.eurprd02.prod.outlook.com (2603:10a6:150:21c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 20:40:12 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%4]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 20:40:12 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "n.merinov@inango-systems.com" <n.merinov@inango-systems.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to
 ${.}, ${+}, and ${:} variables
Thread-Topic: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to
 ${.}, ${+}, and ${:} variables
Thread-Index: AQHbcn97V6EQTSVoVkG9CsTLqTeRcrMxETNg
Date: Fri, 31 Jan 2025 20:40:12 +0000
Message-ID: 
 <DB5PR02MB10213AFB411A607B11EAB0B62EFE82@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250129185531.3752682-1-n.merinov@inango-systems.com>
In-Reply-To: <20250129185531.3752682-1-n.merinov@inango-systems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|GVXPR02MB11013:EE_
x-ms-office365-filtering-correlation-id: 3644ab8d-3a00-4a1d-b450-08dd423775ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?K/Al5HdmG5gyVtJW30cwer306IUFxjuN4JOAJOWdNCHwhI6ezxwuicUozuT6?=
 =?us-ascii?Q?6wq5Wxm7m60Ia1rJhRTtuMAbB/qDGOtc83KC4l9/BjbMKiKjot0Db20cT5wz?=
 =?us-ascii?Q?2oF80CIb5L/3XGTyvFcELFn5iU94cqlUv3K1WN0dU3BNzVCxG0zd5aRgoOPf?=
 =?us-ascii?Q?0D2M9/aAVxJ51uWmLjbBCRORIequUjpielqVpApIQlxPDk6KGRCjhixn01Qr?=
 =?us-ascii?Q?k73DJMw3eyQPI3XtKAG4plp7nURmVGlbcT6odZnGV5dwLivJCJiw7ycxEB0e?=
 =?us-ascii?Q?FPxhQhsZ6vpa8P+VwNP4mM9r1H0RDA48tDd87cRRwGukuxjZOajhekAfcIiC?=
 =?us-ascii?Q?bAO55GjCQrI0ZmUZ4NvkXfhXq6G56Z02814DctBqEjlJ3LQAyCKEER6835JQ?=
 =?us-ascii?Q?SXxJYe6iBV0ZsPV4UdI51yKLzAxJoR9/wKcu31pim1CLrE1GqSj1d0Rptsq4?=
 =?us-ascii?Q?CXnR7EX6dABh9FmYSnCV4yd7lxNzzEqQ/h3pzkni/fctO2978GLZOy4uM2hs?=
 =?us-ascii?Q?eSgpoVZrUyyJ5zAfsUY4iGUYAqfCFXTJyu47k3AV4DhUaREMPT7YxgctXr/q?=
 =?us-ascii?Q?G29e4z208tj74S7E1PnUtRfobrq4YSkCZS+nCju4jkSrjOlXC0BhoUaWbY9O?=
 =?us-ascii?Q?iSrycIrta3ECh4yEa28dXNirVNebM6gC7W3zIc+kvVNlfyMi34st4q37poGU?=
 =?us-ascii?Q?58MzQM2ZygTag6jY4CgMKV4zp32H8u//hqSCLeyzNEMlUd9reNYBPxzbRgYG?=
 =?us-ascii?Q?0FtVkOj9/Fy1yH/xap6bHMw5qHgodho5rhswN6/aoys8xUjGXRZjU/S16U7n?=
 =?us-ascii?Q?CaNM5q+B4q7gnUJRx4KAFb0StA4fCbF+I/5mCKzjLS9QfKsh55ewAIIPsnUw?=
 =?us-ascii?Q?fl7NkB+BgBRhOwGrNAYqa5R++PzgejmepLwqKnm+OSKOSoJ2ZxVCSFE7SESK?=
 =?us-ascii?Q?SNu+Fc7+/ry2DNnfs78WgVRxcIe+YFvjLgVIPtoINoHAFLsflesNdBUwt+JO?=
 =?us-ascii?Q?BaE3uY8U+bNCg+Gm2jBa2wU6IlAticoSS5g2VdUv+E9HE6VrXipC9LukT5Gm?=
 =?us-ascii?Q?TJrwNtPDeB5JPuaKXuyB65tbNKm8xQ2U1csACjhISNA6xo7h3DiBbIokySSg?=
 =?us-ascii?Q?X+dWng2/1YGj4q+eHLEOhoDNasx0iLNKIQ9lpYbkOOLmDiyJGmcbv/zq8nLB?=
 =?us-ascii?Q?hgBawUCw2XSPl1/QOB10oVCsXVavjKZ+aKE0bbclWRg7tvbmmKKhx3KnSkZy?=
 =?us-ascii?Q?HQb0JQGVKJp/46zZd0GgiBtq2CddSRPmScYyG4xR+RxNTNTZyM6NXEx2FwkR?=
 =?us-ascii?Q?Pa0KHegnFCBzSahoMDDww1y3j7Z427dBIHOO9tXokQWg1v/rvX+hrnFcs+Y5?=
 =?us-ascii?Q?hVuLTzKKgubthLPHep7e/sYOTOnB62057pRltLeYptarFQDopic09NRlyRRE?=
 =?us-ascii?Q?4n0TETBY/EP1IXJPXGoBQDnX4e0SDNXQ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HTmpyZyp6VY6yOco56EJhtlymFXryHK600sF33xd85DphAcBfuxe4KGNaWYB?=
 =?us-ascii?Q?mXbPzi3kw5YIhnX2ancYEoa6LIHiOTDC1uX/Qgd8LaoZjSEo53p/XnsRz9Bq?=
 =?us-ascii?Q?3t4H8ckuA7nlrNeRVymyvJ9v053Szz0WNY904DQnQeV0s1zUEhLa7xOgwELT?=
 =?us-ascii?Q?mHtloOp98Rn/eaP9u4UGl7jT84kxS1ZzZt2HU0LkN70wpiufhKEzNXt0WphZ?=
 =?us-ascii?Q?kdFDoWMg2WeU1u0CzkvwyGdNO3dMzC7YeAY15UQKIpiUtGSJ/4mRJCCoRFpn?=
 =?us-ascii?Q?z4rpY/JIHI3zJ02ZH6Zu9P1WWTDXtrqb/B0WdymvKoozaUIr6edHVpuQ29TK?=
 =?us-ascii?Q?plHKJ36LdSj3Gb91tAJvjnWYFQ5IMjlSUaxg+x8AGs4oTL2xzVZ2sudT+7Ry?=
 =?us-ascii?Q?7qRJoIcU3K99Sho3aXvAcxp2xicTGa9ZkZ61SS7XLAJzhsOS3GUxLoKdBOar?=
 =?us-ascii?Q?XovKJhatA0nkoVgMMXGjpVexsjWx4vBg2UA+xVlXb/vR0HrbZsZLTszwWHH4?=
 =?us-ascii?Q?VukrAJLhHMkgI5fPj1SchPa01wrGmtUJepdqx2Z8lCVETBRAAhvPtIWW+PJ7?=
 =?us-ascii?Q?m0ctAQltRInHEh46CEe6NXEVdnq4aFBl4KXrkGT1gGTcJ5byWC7k+k1KXX2C?=
 =?us-ascii?Q?qU63Yd3OudKT/ooLPAzYNQBakUPwjZtBMctfQAdfaFLjsQa3JTThiwKgvV/o?=
 =?us-ascii?Q?RbVLNFTN0VGfbf+kMF1WyLCSlQuafkvBW8JNHtZ1idzYIr1nc8b43klJGGUj?=
 =?us-ascii?Q?NE4hRwk4QoYUedhw5IavN+UwcskiliWvGJ0Z71lkgaGM3qr+XIV7HbRGs0z5?=
 =?us-ascii?Q?2NG1iEfBYgYGDSZoQKEDU845ixKKm3CtSDdP2Drw5+CZJuOfKfeBIDl/CjXv?=
 =?us-ascii?Q?abacO5bwDhneIRKpww4ebIeX+ZCMSojdvGVkJ8IT+Zh/ZR2W3Z3YmQ/GCOxR?=
 =?us-ascii?Q?uBDyK6ZuFKLEI6CH44EgvA7/ejI1+PurrJ30KLrwiFNyYnPrLYcqhESPa7S8?=
 =?us-ascii?Q?OtKd1qNlpAP8pRxzvGuHO04Yoh0saQtT+8SzdMGYr4cTlxF3xWfPYR42pWsl?=
 =?us-ascii?Q?wMLng/7/6DKbRr1I/eJy0XhhvG+TkRoLcVRVB3yJBqAA9kboqdfZPGj6Ensx?=
 =?us-ascii?Q?PYwI9AKYrg8fpCdsny/2VjYgA2HImz7KxFnyKDHRzZL8ax2S6GmHX2+sSklK?=
 =?us-ascii?Q?PeDIKeAlYcUOKcUswwP/aGElUer8jYM/qBtwUnQaAYDqg4abZBmbSrayaqVR?=
 =?us-ascii?Q?X2R+eelQhrXbfLd+8vHz+hUW3eZOiGorjCn8806uurpX8EP4a/Q8d51j/VbK?=
 =?us-ascii?Q?Fr/k6Xk4mloNVboooYG5nIVYLxYdbEq1OWLnAA2srl9MRQeMsbDdCGSe6BWH?=
 =?us-ascii?Q?qnrm8/J4MPeHj6vEooWVqeEx1pSJ0gksyrwqpPMv6So7X535Eu1KPQuQJAkI?=
 =?us-ascii?Q?o0lQlt2d3nQ7k7HtFQbNAALYb9o7kaZYGooVCUZhUt8Fpsz4zQQgT7CjxrkH?=
 =?us-ascii?Q?7j6fNS0NZvRa3x1SuTOsd2B5bbOjDWlv49YGgqiFPtZQw7kSVjwEc8Jns0pw?=
 =?us-ascii?Q?OsKoSd2Vk02vF6HE2Bw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3644ab8d-3a00-4a1d-b450-08dd423775ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 20:40:12.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBzHuoZ526deZPqi5MDz9ZdR9PkZV8B6IBaXndrZ8KAR7z2o7+TGU1dOTqzuXqli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11013
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Jan 2025 20:40:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17120

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Nikolay Merinov via lists.openembedded.org
> Sent: den 29 januari 2025 19:56
> To: bitbake-devel@lists.openembedded.org
> Cc: Nikolai Merinov <n.merinov@inango-systems.com>
> Subject: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to $=
{.}, ${+}, and ${:} variables
>=20
> Old code that parse variable names in assignment commands behave differnt=
ly for

differntly -> differently=20

> variables that ends with special symbol for single-character variable nam=
es and
> multi-character variable names. For example:
>=20
>   A+=3D"1"   # Change variable ${A}, '+' glued to '=3D'
>   A+ =3D "1" # Change variable ${A+}
>=20
>   +=3D"1"    # Change variable ${+}, the '+' symbol not part of assignmen=
t operator
>   + =3D "1"  # Change variable ${+}
>=20
> New code would always assume that '.=3D', '+=3D', and ':=3D' is assignmen=
t operator.
> As result code like the following would raise parsing error
>=20
>   +=3D"value"
>=20
> While code with extra spaces would work as before
>=20
>   + =3D "value" # Change variable ${+}
>=20
> This change allow to catch issues in code that generate bitbake configura=
tion
> files in a manner like "echo ${VARNAME}+=3D${VALUE} >> conf/local.conf"
>=20
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> ---
>  lib/bb/parse/parse_py/ConfHandler.py                       | 2 +-
>  lib/toaster/toastermain/management/commands/buildimport.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py=
/ConfHandler.py
> index 24f81f7e9..bdac66004 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -20,7 +20,7 @@ from bb.parse import ParseError, resolve_file, ast, log=
ger, handle
>  __config_regexp__  =3D re.compile( r"""
>      ^
>      (?P<exp>export\s+)?
> -    (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
> +    (?P<var>([a-zA-Z0-9\-_${}/~] | [+.:](?!=3D))+?)
>      (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
>=20
>      \s* (
> diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b=
/lib/toaster/toastermain/management/commands/buildimport.py
> index f7139aa04..37d27a445 100644
> --- a/lib/toaster/toastermain/management/commands/buildimport.py
> +++ b/lib/toaster/toastermain/management/commands/buildimport.py
> @@ -60,7 +60,7 @@ def _log(msg):
>  __config_regexp__  =3D re.compile( r"""
>      ^
>      (?P<exp>export\s+)?
> -    (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
> +    (?P<var>([a-zA-Z0-9\-_${}/~] | [.+](?!=3D))+?)
>      (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
>=20
>      \s* (
> --
> 2.34.1
>=20

The above made me ponder on the existence of $, { and } in the regular=20
expression for the variable name and what that can be (ab)used for. I=20
realized that it allows you do define really odd variables such as:

${} =3D "foobar"
} =3D "foobar"
$ =3D "foobar"

And while you cannot access them directly using, e.g., "${$}", you can=20
access them using, e.g., "${@d.getVar('$')"...

This also allows defining variables that do not match the syntax at all,=20
e.g.:

EQUAL =3D "=3D"
${EQUAL} =3D "bar"

which will define the variable "=3D" and where "${@d.getVar('=3D')}" then
returns "bar" as expected...

I am not sure this is a problem or working as intended, but it is a bit=20
odd.

//Peter


