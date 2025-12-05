Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA329D32D96
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:59:32 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7662.1764946767073554975
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Dec 2025 06:59:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=jEQSkKRg;
 spf=pass (domain: axis.com, ip: 52.101.66.40, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL4WGCcWszf+axvavdKEnVlJLhxpKxZhqF9YOd0LPoIXBPOk8coy+vOkK063z66ff8Dj3c9+K7CEkcN4CABZmT2nk371iJCpTJSPrIeIWTinPH5NjUtP0itCjEDxGOg3ezh94nz4ZMh3JuHFl/rY6JhjEmMSSCOg/JxqW+T2fV1KX0lZtr+7Ba3aK6/ABgAb92hCXt6Npa6d+dtb3VauFIz2Ke/SXawTA8PCC0Ru+FHABqohRfdV5i2WsveuJoTBNlTh2Ko71szv6iXBSqraRcwuIstLVZfMXd+UXHI4x9YY+GXAKLjWGa6vqFxgK2wmGGV/sjDO1g/Ij9slw4TYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQgZGS4NBmcaq7hQj+jJUKdcBULwbDPQwYD43tyG9kc=;
 b=BPB6hxI5W4MBpLyluTHaxFxHiakD1+cqsu9HTzoaLHCibGZeQlryREFxd/59IooDGzJn9sqSfPVwEtkYeorNnZ1IppFFrDYSWQVA8qjabI8MJq9KvkKMTeZIjOcyE2NMHkGGQX5WQz+ec4T1QAXWbdJLRBsb3n+oGcRbFpqp+59gR8i/ENOC8C70tuPMCSWLmu+JKLAVVUE74HoJeAlBQ/k19+pv8Fj1VSiaegMM3/7G/cI78Y9GYMy+t2oi3Hx1ZeHqHMTkWe+soXzL6ivHftpouHW0dHFGH4/hGGAW14ACFRIOvhuyogE7AJQ+hpHC9pVjLOiHS4keD0DkfpnfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQgZGS4NBmcaq7hQj+jJUKdcBULwbDPQwYD43tyG9kc=;
 b=jEQSkKRgD6MzDRneWu1ak6ve8+w6tI2Nq9GzjxytrarwCw2jJkIR/zeNxDpf95NJ2esKW2Sl1tcxclAbqg1q6VsA49vZNpFpBT6z23d/9SXkmgSJRITUfX/emwPrzrI0PGNz64gR9UTlGjdk4rjXM2MiEeQZ54NIV9LTzCIq0Fg=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by GV1PR02MB8756.eurprd02.prod.outlook.com (2603:10a6:150:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 14:59:22 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 14:59:22 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "swami310@gmail.com" <swami310@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "docs@lists.yoctoproject.org"
	<docs@lists.yoctoproject.org>
CC: "michael.opdenacker@rootcommit.com" <michael.opdenacker@rootcommit.com>
Subject: RE: [bitbake-devel] [PATCH v6] bitbake-user-manual: Documenting
 BB_CMDLINE
Thread-Topic: [bitbake-devel] [PATCH v6] bitbake-user-manual: Documenting
 BB_CMDLINE
Thread-Index: AQHcZbc8iCeev6kqoEuIpcvF7zlHAbUTIpkg
Date: Fri, 5 Dec 2025 14:59:21 +0000
Message-ID: 
 <DB5PR02MB10213E66C93F68B28A07DDC6FEFA7A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251204234240.7224-1-swami310@gmail.com>
In-Reply-To: <20251204234240.7224-1-swami310@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|GV1PR02MB8756:EE_
x-ms-office365-filtering-correlation-id: 8f52d8a9-f267-4806-6aae-08de340edfa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?3utLDN/bSJ0eoU1aX/sfafSSZaCID8kxJqvXX6wzQm1tYiDWR57fkyPi+nlt?=
 =?us-ascii?Q?0zQ7C336m7FtsF44rUhsf2HHjkUsNyDZ1/XQTltHobF6EWf0rBEJtbe026WU?=
 =?us-ascii?Q?HejxTVavpQw6HS443+6Ty0zQ7Ph5KAoWumgbI4LiyXHic+SIifPNXq2M/k8p?=
 =?us-ascii?Q?vI/CWrwf3+Uep9gqeYD2V7hKj94jQsQR5PG2O0WdvkRmN5C/jSKZc6eImetI?=
 =?us-ascii?Q?4SHlE/2fjMJxONszi9NWz7SXOBcHvfkl3j1orPcBMXFKVrqEmjZJs1iPQW+m?=
 =?us-ascii?Q?QKT2XFfoYU10u8hBPS48m8GEtQ45CwIConltnWv/IbX5GB0RkzWtEBgXXmJD?=
 =?us-ascii?Q?MCOzk7bSoCI8lqnYcXmA+7fyfwNv93n2boTMEz9LQFqxh2XN5qLmCBmavhgM?=
 =?us-ascii?Q?OC0msuHLfjPfrj6fidJy2nL8K4Rq3e7VOIHzk1462JbqZvafGOpJ6Vqe46up?=
 =?us-ascii?Q?w0WnvPO2IneoEq8qwtmFHuRl3u5O0Jlz+u2/ETxoICBwLCmrf3c240wc+qyU?=
 =?us-ascii?Q?gu8Gp+FMcfSnwDHlT1mZBAscGt/ktNq4ZSe/65gsfsXVWTqexoZHB061cj7M?=
 =?us-ascii?Q?UCMJzZdY5g28UWV9MOYkd8PBQ9cKtQ7Vw3roCOIzCfPXahyNAI2b3KQH51cR?=
 =?us-ascii?Q?oiJvEHjSWfX3fqbGY2SXPEgMibBBC+8kDxHSdW7A1BpjRd1vJQ10b2Qmtr6y?=
 =?us-ascii?Q?tWWDfGn6Gq3SAfte3pOmeyrajARSfxkG7LLau7KQBcsbGa/f6HxPUzKKYgy1?=
 =?us-ascii?Q?KO+/JsT4J1URkSFx/rvEPBhnOJiJiNw4MXgBuznQCtI0Qk7Cdbm6tGjoxPEv?=
 =?us-ascii?Q?e70MvMcveS2opfpiLxVCHbQKMqoQ0O08KcJJkQVhGwEyZMYDLV+MGSasUx5Z?=
 =?us-ascii?Q?yVdigMb3myK7cijTpiRt1PMcPPXwX3F5M0/1PaIgrq4/F4Mntzf581V9Cxtc?=
 =?us-ascii?Q?LWA5kU+lmIBgBXEKKzu5Ud/WWBMnFYq4jvGwGWnZyIjdEj6nHDP5ZyP1FuTT?=
 =?us-ascii?Q?VRqrCIfCi6UZmU/KOE1c/kBrgPlxx9BA6uVeHk5xfJPZqKEue2kVsyQ5mWoc?=
 =?us-ascii?Q?u+DI9VWv0fu0bf9GtAoIM9cowyMyR7C62LCJ+HUr0Wtuuo41FKRvbQNGlF7n?=
 =?us-ascii?Q?4tysuWJ7Jvsjz8F3AMq4EG9gzlNZF2yfit3PNHC4ev06nYz6q5FsxvbPRX51?=
 =?us-ascii?Q?yHE+0j44vCEaGEzZ2IPreMCsUkNXRjl6prn42xfDdjHo9LpdlbuNqwwH8wrw?=
 =?us-ascii?Q?6T0+uZQDKsDSyYXqSj4M8MiHlM/RTtQt8ljv9RDxvehBl8KQ/lNFTQzj2t+c?=
 =?us-ascii?Q?pewlGwxN0nt8j1+JiRBkIZN1zVQGAlee2el/bUYAt4MLxu7xodDkkZQJjVuL?=
 =?us-ascii?Q?ALQFvxkin7Bl4HuEECohojcPTjTnZODl716vFVEU9fgVTB000XOQneEgZv95?=
 =?us-ascii?Q?7Ug7QEB2laOtuCWZGHYQxjzhVRHn8l7N2y38Lhj9ROlj9RwViKtoZuVmdhaJ?=
 =?us-ascii?Q?xvJMaJACSt+UHluF/LHCpqef4nzF0put0UGg?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qbnY1UqgdzrWIx0X0A8oRFc34OA/Y1Zi7Kul7z7jh/RGHcf3FJO3KUJctQIe?=
 =?us-ascii?Q?PoTO7ku4dZU4PuF8/NpUR1Km7DWC0glGHSOYxUCOyPJu0qnDRXPgJHB/7dm1?=
 =?us-ascii?Q?dUlHZMu3SndxvN+gCeXbdbyocBQDMd2oxHNqIqglb1a62//D/x3fbBVvi9jr?=
 =?us-ascii?Q?YRnCAugs97JOPAFIXJSV9ZfoWf2Xi6mDSIPiFfPwCmxNBDBnCb6KLXadKfDq?=
 =?us-ascii?Q?Wp6TaEwZNXIZIQIddcGbUSnG+VwVo6zf5soJkLWOhpyqxmQhh1/P4HFSVrSE?=
 =?us-ascii?Q?pnj3jvnY5CDDgNtzW2AsQYE6OxqB468CyWPKlbjF26aLLPZLOp5srmveoSkH?=
 =?us-ascii?Q?6oNqi2/1Ng8uZRMx8XiL0UjvXMh16hVDB3fqe1QAHmCz3/6GsEasCN4/GIkw?=
 =?us-ascii?Q?yOclnMG3g3pMZGR71jruLOJ7OyMa270I7g10BLQJJPI/PD8QTHlAb8KorI1S?=
 =?us-ascii?Q?WtH6QSw7ieJngbUsEL2TO9f0SsUb0oqFweLNlvRuru8mMcgnhN5St4ITwe/m?=
 =?us-ascii?Q?lc80pNmXngUvmgY+i4jroC4OIBOQkYqLMQJp03oYGGP6gfxzrp9N05hroUIN?=
 =?us-ascii?Q?fzTLhXoKWdjut2Lx/ng0RFIV28QaT4iPJjjV4Qb7ClwYyRMISHFku0ABCdmt?=
 =?us-ascii?Q?bXFaxDhpJ2t9BfH4l8hEygZU6hlkK2kJjLllHQFjQoBdRYegpQWoY0dmGDBv?=
 =?us-ascii?Q?RsLxUzWSHtkDTEjLeg4oRotpwwKl4Ipg3nXiiiqIDQp+cSHfZCZWeR6N8V1c?=
 =?us-ascii?Q?bHth7nZ38uUu1LDQGn0V9doSOHb38e/wU1Rz46OmyFDpMG+KBrHUDAZSR6UW?=
 =?us-ascii?Q?EpxmwDmMv6KcavgfujImJPNBIXeQ/QPxaM6lm2qExUSlHAFRseCIZIaFyrNS?=
 =?us-ascii?Q?U3AEWGOI27MIhzm/UaJtZPi3ChNFpFpopAS/7VMgr2Xb8FpIZsQ0LihwmKJ0?=
 =?us-ascii?Q?5BPs1LTxbgdlA7QLOL0vjLoxXgqBEB2N9RGw6Itaby6TIW5O6txbvx1B9i/5?=
 =?us-ascii?Q?Sa+TxpS4wIHO48LCWwh1jVp6oDEfJDF13hg4JnZjFSQBSbD4JwXPCVhJUnId?=
 =?us-ascii?Q?1tH/S/cpL1Mqk63XBOdm9cM/a5YoJSyiez/Cp0S4QGr/CJDyyC+5szqnCocU?=
 =?us-ascii?Q?dGZ88k2m+fuNZIkPnjSdw/7tuyQXDEGgpQJLgXBfEbKcPrIp0KrwiGG8Vysq?=
 =?us-ascii?Q?BlkRdEH87Y4HVtHyf9PoFf4E0Sct4pIdxkA8JhsQPnS/Yw4meSNHzeDkbc9S?=
 =?us-ascii?Q?hfo/lwx4AxPMkXaKLmNYsr5MI2SMfVgycTHqjTIO+sm371vL96rC3KkAnfcG?=
 =?us-ascii?Q?wzhDAkkC4EHuma2EsdSegYpxWmkY6aC8KuzG61bXjw9y46/b7puEXM7tJGhA?=
 =?us-ascii?Q?wbe25uJ0FcYh3BlaKa/OW3GPWcFa2VRujI0k9M9xf3UNscsCtV2HqiAvchQR?=
 =?us-ascii?Q?YC6ebHt9NU1V2gslheqCNP72i8OfpwdQR+vwSq6QLr6PisemdVx4zSPFQ3Im?=
 =?us-ascii?Q?VrpwV3Q2yz2SFMv+vvwHKLTotQUOn9r8Yiaz6Vd8yEdnaTKMa0QqmwbEgg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f52d8a9-f267-4806-6aae-08de340edfa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 14:59:21.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfoXPS5448iH5Vc86Ka5sfu1DjOrp6UPwqhUYZ7WaN/N1l/P8FjCNsHU4NLpMbQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8756
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Dec 2025 14:59:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18548

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Swami via lists.openembedded.org
> Sent: den 5 december 2025 00:43
> To: bitbake-devel@lists.openembedded.org; docs@lists.yoctoproject.org
> Cc: michael.opdenacker@rootcommit.com; Swami <swami310@gmail.com>
> Subject: [bitbake-devel] [PATCH v6] bitbake-user-manual: Documenting BB_C=
MDLINE

Change "Documenting" to "Document".

>=20
> Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
> Fixes [YOCTO #15746]
> Signed-off-by: Swaminathan K <swami310@gmail.com>

Git trailers (like Signed-off-by above) are expected to be separated from=20
the rest of the body by an empty line. I would also suggest adding an=20
empty line before the Fixes line.

> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..32860ec0c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>        Specifies if SSL certificates should be checked when fetching. The
> default
>        value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
>=20
> +   :term:`BB_CMDLINE`
> +      :term:`BB_CMDLINE` is an internal variable and is read-only. It ca=
ptures
> +      the exact command line used for the current invocation of BitBake.
> +
>     :term:`BB_HASH_CODEPARSER_VALS`
>        Specifies values for variables to use when populating the codepars=
er cache.
>        This can be used selectively to set dummy values for variables to =
avoid

//Peter


