Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6207ED25B5D
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:21:42 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12701.1769606498453297802
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 05:21:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=NXwFDJtZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6488bb3565=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SCVvJH914927
	for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 13:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=qm8Nleq0EYsTeiATtUVwcK
	YzTdIIylgc4fcvc1wJEoU=; b=NXwFDJtZwhBRtN7wEBCcDiWjqTTk+QAaUleEXr
	xS7FbfAd2pfBeLZ2UTGOu/btZXlF/vWafCAeJoHH6xjd3beiiLAS6Sbxor6OQP/W
	EFMaWVp4XUS5vcYd/eMAxSqaOcexIxfwDpnGtAFzvYjYJquQ+mJEWSfi+KkF8Cjp
	W7sNDEVgBBqpfM/z+TUr51khxoCwE4B4sxaaKHExwALP/3GkbA+6RPreDMJZrZNU
	CA0j9RvK4NeD7HvY+sT1j2mTPgg/ejsl2G2wcq95NXmhzpHqRMtMKw4COylJ0nKo
	fpd3pErSimk9O/pya2xneA1jfpxjOJt/h9LQQ9Rcvz16DB/g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvn28d29t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:21:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0GYitA7u/nUxChAyhr9YpfbeXZE+Y73S8m2plJq7zprQW3w4FomTyqjvL1CcYtxU9+DhOvv9tHQgsL7xUFOU5y4MUXClVnmYDbxwlRPcNj/fYd7HW6nlQ3Xi8VOPl+WUkDHCHviMByr4lQ6ZrYsjYZ4JGEKUTpNImEO4PaXYObx+UKsoa49F43kOVw7vPXnUrDlWbq/F+h42FkMU3xr1Yph8uxb7s86YxEhf7QGYqftNsi2G4vrAubtkezMDtdkB1NXbOdXo/uI/T0bXY5WntuT1kOH9lILluwBesPSEUeFAkyepYBUsxtbrQ+qzJ1+DYgIs2Is6ASWed9t9RlWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm8Nleq0EYsTeiATtUVwcKYzTdIIylgc4fcvc1wJEoU=;
 b=SouBrLPeZzK0IuA5c+I62B5rWM9GPFUfmFhCHNHowERqtnm9gMXbrydzllmRg/pRQUv5pFyxrxSza7kDsm2fNvGoGyFoAmqYDEVy3+4uLQO4Zred0DYH0X7uRBxl+LRZZM2Pgg6RqEcm3TYDlMyF+0maqRISJqy5NG0zhBQNQZ2tK2sqIyu7qpA0FY/z0ErcD/jrFsPoc4HLmFvRzZagK9XpBmrjAn4u2pFpDaTYS/SFLOLNdJ8Q33aWo+GrWnXtFPlTEJb+GobalrMCJdFLpNyGx36U+ZgKgRusYIJP3+T0WsQrhhUQ8aqig6UY8ffw9hP/zaHRiXm2UJGWnZXrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Wed, 28 Jan 2026 13:21:34 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 13:21:34 +0000
From: "Woolley, Rob" <Rob.Woolley@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 07/10] bitbake-setup: Remove unused
 stdout variable
Thread-Topic: [bitbake-devel] [PATCH v2 07/10] bitbake-setup: Remove unused
 stdout variable
Thread-Index: AQHckE+7YUvH1uLWF0eNGCBdEyvFOrVnkLZ3
Date: Wed, 28 Jan 2026 13:21:34 +0000
Message-ID: 
 <DM8PR11MB56552B52B2ABE9C43DC32AA2E191A@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-8-rob.woolley@windriver.com>
 <CANNYZj9+7rLoDbtyujAu1S=WQE6Hd2eBRAo6Evy8osHvF7ww+w@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9+7rLoDbtyujAu1S=WQE6Hd2eBRAo6Evy8osHvF7ww+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-01-28T13:19:00.9182901Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|SA2PR11MB4793:EE_
x-ms-office365-filtering-correlation-id: bad395ab-22c4-446f-264a-08de5e7028b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007|8096899003|13003099007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?S/idn0SLj6/XEcn5UAEr9PUx+8pBnXx2IRdqJeAcZdpnWU0m1djPpO9BJfGL?=
 =?us-ascii?Q?RbHQfz1OgDKRdoA7KmMBG7Ain7awSe0B8XiwCgIKcQXYDlReL8A4KyfljJ9v?=
 =?us-ascii?Q?WROowFWbeKzr1HhDxnbwyq8t+83wxvE5ucyihY9+8pBgKqOHKf6LgG4xql/Z?=
 =?us-ascii?Q?v6FGmZCx5pUEIQQa94hRFo/P9IRzsrlciF5UUcmoJopettoqhIQK0hJ7eHaO?=
 =?us-ascii?Q?gE97UnrYSRAd0QUGFoAs/bY7JrJAGWSFF4Z9gUsMyubiVzaPZpvIh0VedAN0?=
 =?us-ascii?Q?/p2M9IEFpvdqcs/4Jv2PEyDs+zRPgXhH0kTeR2UH+aa/q906p3fZ5n8uulKG?=
 =?us-ascii?Q?tUniSZPkEkrdbupmeZFMHJC7BNDDFaQ9WO74KpyGIaN2FUOi+YoyO2UloxCV?=
 =?us-ascii?Q?PNDNsBkkBk9TEedPirg37lEPWCBCSyL08YM48EgYX9PSW/ywrkhxH4XpZr8Y?=
 =?us-ascii?Q?yzxNo7jU4EKWoF34GMkOpva48E1kIsi/x8/Uvb+Ln+27VzLz5GRezJzvxNA5?=
 =?us-ascii?Q?8M2q1D21jjIyHEX8MiB5ERQdcWPTCZBgv7tDnTB91W5vZMr3BZt/UK7Fu2qR?=
 =?us-ascii?Q?6RbxZSoqlj/RsweOJDDNeqQwDP4ANMx70Xmr6EsVHcbfq1yZX7rRgc1wVsZx?=
 =?us-ascii?Q?9reIzEZQjndYfDzcXhgi5i7ONf4QSJFAPK90eshV8BbdVTVdfizjmkOQcgW1?=
 =?us-ascii?Q?tPXfRwN0SXSu5/wXL4qHuqGbTQl/b/pbZqEds6n611w2JCPbApX9Rq/1OYqA?=
 =?us-ascii?Q?uPdanb2K2Z+aA98/yONTfuEueoP8oaAlW7gWE1kTyW618o+H+uKTYbcvfCZV?=
 =?us-ascii?Q?9HfsxXbvBwT52qZWAMHPv0HalLujx9Eq5lL5T/2tZEXnbfg9L3uvlPI8UolU?=
 =?us-ascii?Q?7hwf1yZ/St76qvKozSS+g4N8SqH8qhsmaHo8t7KynawNFdxHq9RsyKr6WZEp?=
 =?us-ascii?Q?hTUXqdZ5Q3Y8RLvOW3X0v4XxYnA4Q3OBKJ33oi8Yk7PeK0sYr8Aa+w1DX8nq?=
 =?us-ascii?Q?s/h4wQtlnjWiOKbROfHurY4yxSl+5gqvddOYsTFDfikpgn7cGTmFHgx2NWKd?=
 =?us-ascii?Q?S+ztTuI16FTjpVaDN/PTUZwOIMT9HPxIEsmfmJUpBvXbbhF28ncE7ngw6+ZV?=
 =?us-ascii?Q?5YWRJgGi+3WtZKxcxoQZ/CiKe06dftmuZVOKn7JhmgNIwlvsKBVSqIjgLP9g?=
 =?us-ascii?Q?3M0qIvcwL/nXYcX32Nmm9+Ij6pOLv4hhckSIupmHsPNlOoCOQwjIwxvT1flZ?=
 =?us-ascii?Q?jRwB58lXcv945deCRlhGaTLUy9OoqpH6OP+wMv+eO9KZIStZ4FYUGrGuq5HU?=
 =?us-ascii?Q?RZzDyG1koWOdNh23u3mNeRhCy/0jxJblUaeJkEztj90vHS6LaRno6tQUCVy2?=
 =?us-ascii?Q?+I956KlYqEUkF/I1KUXlVfsDp8tN6L0vfs6vDXCfD8/ONtt+eL1t+y4mrdYR?=
 =?us-ascii?Q?WIomw+fY7wgq6relNBfgwS4JrNdG56HwGGNk7Bn4u3tIyQTDzBEjEW1Rb2ze?=
 =?us-ascii?Q?nZbeWbWoGbeFERc4nVg0s6xpfUwGMQ3vHPa+K0GhmRDZd7nGrSnB/AI0Msd/?=
 =?us-ascii?Q?g4UHMxd/1/aiRogRTJEiAlrghACRbZC8zNjAqSXk?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(8096899003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0dytfi5b6fLV75Nf7xrtT3epnLPppamLz9bH32YddUHY1fotcZLUzTQBG/m1?=
 =?us-ascii?Q?mA9LL5Pci3L5+y98G+Nd5nDdnjBnceB85jgz5/3tF3WpvRV2UkRanxpPFBNX?=
 =?us-ascii?Q?tDAzV12I642M9orqMFRHdNOOED7A1q8QBqupjnC0VLQVDWg3HMdojMU/P5uF?=
 =?us-ascii?Q?f3wWA4uQLUe5R+mBtCY2jPWttc264tXKAzx6NY0y6PHWkl75QY+/Rrt243xf?=
 =?us-ascii?Q?Tz/PWOO6Kv7NFml2W7BEOrK3tU8bKxTCmL8wwpAGIvaMy6WmG0O6He4FfLE7?=
 =?us-ascii?Q?L0sjHbGWqZBAQMINZTmDOZITgLYjBtR93JwXL6ORSfHM0c5QFDNa3PiF648x?=
 =?us-ascii?Q?aJjLVNvs4Rjv9xKoPYpMwdaPm/ByNqu+XhFwSSLbKWW/mF7qdbtQMsbm9dsQ?=
 =?us-ascii?Q?HLDb4Gn8vFBMQLuvNr7FPcH7wrA0ELcaeUJfT0LcsiWDF+DZ+YWY84W4ND7C?=
 =?us-ascii?Q?QAN1Gg3KrJf9T+0aD3s/Bjwpz1/k3TIejb6ag8U6v5kZ1SymMydrC+IGXEZw?=
 =?us-ascii?Q?YgV0r89joPmxGhwFzTXyFHeSXKxAUA9dMd4yAARUPyQvqakfKo033Mh1bVEO?=
 =?us-ascii?Q?7iCsxTSqMrlQu56P/FyXsMbISmDlB3L53GtroLtyRWLn+xBdlaxRWfdt0un6?=
 =?us-ascii?Q?BFs5Y9bHA+Vphn5Cy2x3m2bLO/3y/DeoZf78aV1KGno0ANHsgcjKdrGgUxst?=
 =?us-ascii?Q?+hrytgntklDEJLcY8wnpjkDLu8JAJ9AkTsWVIjzgOV2I82XaVVANvh/l7n3I?=
 =?us-ascii?Q?E+1lB15nXnwIvESIklRbKgXYIwufVaGbBQjojh62rkH6Ofq6MMZRMESgyg/F?=
 =?us-ascii?Q?QReoG/70yc15Vm0HhcNlFKgUlvtPAYShi20pHUufN/qYSMIGcqF3NZRTuBCI?=
 =?us-ascii?Q?UesQWZ0g5O0tdJXAbwwqEctrZVjpLQjfOka0NBx/YYr37qDc8Ds4iZEe/wSz?=
 =?us-ascii?Q?xo897vqZtEB14Re/U6kR2szIQWst/SpUFVx6RMckWqv8//naG/pg0pIZngay?=
 =?us-ascii?Q?HVrIyj+KG97ROMsXQ1U3NW3hm9lDgvE+mk86SfWQW5FvCMcAMYjkLpD8fJur?=
 =?us-ascii?Q?l4uMjkSzvXCsqlfxnG6v8qx8nU2euF+0OM+oKyN+UQa1npr6M0kTU6ByZuF4?=
 =?us-ascii?Q?g7Jpk6P4NFzd7x1JtM8pKDjiMoY7c4NGToYZ2SlULs5DTNDDZBm8xbkrscl4?=
 =?us-ascii?Q?36RBtiD1aNv8UNqouk2N0g+idDyr1mnj8QXKXqraNel8ervy3tsCFnMzND4/?=
 =?us-ascii?Q?krq2y8h+gHFXZq2ajA+aoDC4/N9+NvrhTtaf+J+g9/xyn8lA963/jNlqCFda?=
 =?us-ascii?Q?2iQYX5TJZURUwmSG+KshjLCxXL6CdxJ7OJkntnm0tTNudsVyv5zswExjJTO+?=
 =?us-ascii?Q?SfkpNTuN3o2UbdljgPYf9TozP9nkcS8ScCe97LvuGdxtNzjb8iU6zgZadISc?=
 =?us-ascii?Q?lIhQZndkPGTQx/4D5MzWraiktK5+uYbErYC6XsuzDnH8wx8Cgw5DpXhMR1qP?=
 =?us-ascii?Q?awyzJ15k4xXI8sD9sEwexgV9/3fnGN2uhIPLRqaJIgp0Nh2zZfFHPsk60Jyg?=
 =?us-ascii?Q?v3IZUfoHUXHSPbK4wolXaz5aw8giUo686H6KCk8kLVU9tL0TyAZK/4fGpQB/?=
 =?us-ascii?Q?VaOfLdSR/Jou7jPpQ7D0DQooRRQZFb2K2bbgcwJxeEbMFvsBVk9TCj1nxEOd?=
 =?us-ascii?Q?ARKP3GUmsTBZEpXDSdPaWoY5R9zt/s3aEkG3mYX2yjchJ7HCbckzRO5elVku?=
 =?us-ascii?Q?Utn3w5j7+z6rCQgOUmbR12yqpEY/byQ=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR11MB56552B52B2ABE9C43DC32AA2E191ADM8PR11MB5655namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad395ab-22c4-446f-264a-08de5e7028b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 13:21:34.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0U8ng4COvyM0GlgWslCazF9RK1WCchJblmNwasOREy0tjQR8y2YOC7RHHWQYO15/Hp2r6pJEZ+8vnImfdzyGK3wsFcAvQBVq0ztaasfo+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwOSBTYWx0ZWRfX8q6r22gKWvZc
 aYg85yNG/TWVoukJgJuKsgsooSg9+ykxF0B1UyEQuyG2emO38BSyvzEwP3reQqu6pk39/31N8VF
 8h8x91el+8NXqE2bWPNfSHO7MS8UkpAPyWy9SX9TxI3J6UMwa7x3w1wZKmoWHjxbrrgLTJ9Xzv/
 aHMbwt2XkwdjX2xgteOkSCpSSQlE46CoD/p/OgukQek9v3m12c8cGIk8OChljkYjlIItmTPgbfr
 AeQstKXs4tfYQQeSDIWx4RbEHkwV551CArLSUDcnCrSESYj/V13IFC7OthbsQ8Q+gzw7CHJ2yXF
 yTlt2mVYnAeGacs9kAfybvbAGNbuxzeERqnKySzsEChITmWHMHvegaaeeqr/ZCGhXfwk7aodIk6
 /8OtctR1AZPRmTVauxST6M7OjX41FS6w++QZxQI9oOZXXJ53fiTa6xQAn4nK5DjkmDZNBMwyy1y
 33Eu/lRm3YoiqB5BViQ==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=697a0d61 cx=c_pps
 a=yf4wneJBeBA4fm5+j3KMTA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WfHZuIUsAAAA:20 a=_EeEMxcBAAAA:8 a=pGLkceISAAAA:8
 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8 a=yj-aMKAYKbz0kkd27lYA:9 a=CjuIK1q_8ugA:10
 a=i-k3ZtTku7v2TIHx:21 a=_W_S_7VecoQA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: mw7JTRMXlstqkLKeNUwc3t5rCJ0yTjIC
X-Proofpoint-GUID: ElDJ8enFHXMe6clqgrj_PA30dT9ENURr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280109
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 13:21:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18913

--_000_DM8PR11MB56552B52B2ABE9C43DC32AA2E191ADM8PR11MB5655namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex

That's cool.  We can drop the patch.

I checked upstream and don't see the line you mentioned on the master branc=
h:         https://github.com/openembedded/bitbake/blob/master/bin%2Fbitbak=
e-setup#L583

Should I be looking at a development repo or -next branch?  I want to make =
sure to rebase any future patches against that.

Cheers,
Rob

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Alexander Kanavin <alex.kanavin@gmail.com>
Sent: Wednesday, January 28, 2026 7:14:45 AM
To: Woolley, Rob <Rob.Woolley@windriver.com>
Cc: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.=
org>
Subject: Re: [bitbake-devel] [PATCH v2 07/10] bitbake-setup: Remove unused =
stdout variable

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org
<rob.woolley=3Dwindriver.com@lists.openembedded.org> wrote:
>
> The ruff lint tool reported that stdout was never used:
>
>     F841 Local variable `stdout` is assigned to but never used
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 59412588..e3e577e9 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -583,7 +583,7 @@ def init_config(top_dir, settings, args):
>      create_siteconf(top_dir, args.non_interactive, settings)
>
>      d =3D init_bb_cache(top_dir, settings, args)
> -    stdout =3D sys.stdout
> +
>      def handle_task_progress(event, d):
>          rate =3D event.rate if event.rate else ''
>          progress =3D event.progress if event.progress > 0 else 0

The next line is
        print("{}% {}                ".format(progress, rate),
file=3Dstdout, end=3D'\r')

So stdout is used. We can't simply supply sys.stdout, as do_fetch does
tricks with it to redirect the logs into a file (otherwise they would
clutter the console).

Alex

--_000_DM8PR11MB56552B52B2ABE9C43DC32AA2E191ADM8PR11MB5655namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Hi Alex&nbsp;</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
That's cool.&nbsp; We can drop the patch.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<span style=3D"color: rgb(33, 33, 33);">I checked upstream and don't see th=
e line you mentioned on the master branch:
</span><span style=3D"color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; <a =
href=3D"https://github.com/openembedded/bitbake/blob/master/bin%2Fbitbake-s=
etup#L583">
https://github.com/openembedded/bitbake/blob/master/bin%2Fbitbake-setup#L58=
3</a></span></div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Should I be looking at a development repo or -next branch?&nbsp; I want to =
make sure to rebase any future patches against that.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Cheers,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Rob</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div dir=3D"auto" style=3D"font-family:Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif;font-size:12pt" id=3D"ms-outloo=
k-mobile-signature">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt;">Get
<a href=3D"https://aka.ms/AAb9ysg">Outlook for Android</a></span></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alexander Kanavin &lt=
;alex.kanavin@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 28, 2026 7:14:45 AM<br>
<b>To:</b> Woolley, Rob &lt;Rob.Woolley@windriver.com&gt;<br>
<b>Cc:</b> bitbake-devel@lists.openembedded.org &lt;bitbake-devel@lists.ope=
nembedded.org&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH v2 07/10] bitbake-setup: Remove =
unused stdout variable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CAUTION: This email comes from a non Wind River em=
ail account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org<br>
&lt;rob.woolley=3Dwindriver.com@lists.openembedded.org&gt; wrote:<br>
&gt;<br>
&gt; The ruff lint tool reported that stdout was never used:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; F841 Local variable `stdout` is assigned to bu=
t never used<br>
&gt;<br>
&gt; Signed-off-by: Rob Woolley &lt;rob.woolley@windriver.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; bin/bitbake-setup | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
&gt; index 59412588..e3e577e9 100755<br>
&gt; --- a/bin/bitbake-setup<br>
&gt; +++ b/bin/bitbake-setup<br>
&gt; @@ -583,7 +583,7 @@ def init_config(top_dir, settings, args):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_siteconf(top_dir, args.non_intera=
ctive, settings)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d =3D init_bb_cache(top_dir, settings, a=
rgs)<br>
&gt; -&nbsp;&nbsp;&nbsp; stdout =3D sys.stdout<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def handle_task_progress(event, d):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rate =3D event.r=
ate if event.rate else ''<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; progress =3D eve=
nt.progress if event.progress &gt; 0 else 0<br>
<br>
The next line is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print(&quot;{}% {}&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &quot;.format(progress, rate),<br>
file=3Dstdout, end=3D'\r')<br>
<br>
So stdout is used. We can't simply supply sys.stdout, as do_fetch does<br>
tricks with it to redirect the logs into a file (otherwise they would<br>
clutter the console).<br>
<br>
Alex<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM8PR11MB56552B52B2ABE9C43DC32AA2E191ADM8PR11MB5655namp_--

