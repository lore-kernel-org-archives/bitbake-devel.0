Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26179C5B543
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 09:35:08 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.63])
 by mx.groups.io with SMTP id smtpd.web10.47526.1748338503454777263
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 02:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DoDD/gxt;
 spf=pass (domain: siemens.com, ip: 52.101.71.63, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaHmumiVs9bVu/VnRyztQkM/8TtPixvJcrlfWhRrMMi9SoVquMsNhFtvYkl6upaVKyV+q0DLPrXdhuCXdgbMLCfo57Dr2vNtzBEpzXtnY/7SIEeOVPG5t8+2Cx6KP7uBhyVeZnODu2QUgvnUSNddLI2GgSvt6WusWluVD0By9CwhQ9FADkEUJ1acFqM+N8g8S9HDPHqzuShIG1pFJZ2Rzg1N9GoTUzf4GgY1iL3LMNssqEbpGG+U/1WYaMsPkq/hf8QJWRAL6RIyrPoz9Edok1JtDkII+X030TcgZAcIuqugseHp1fsvDx1afDyx3+9uehdZJW5n9x8ej1zb8LTzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/i4erJIyPRu3j3s0v31PVdJrH/6F4VbjgREygqEHXE=;
 b=YiSOnH5xPYDeQP0k8ZkqR3DpaQMXAx57pmgvEL4X+Cz2dI3UcUmvvE64p6QhFuuQgZcTKRn5IBsHvroMj7Nh81Ku7hCMCNcSO5VDFGDhEI4xIEM5atBkvGwNTU9kt6jMEepKK2FcgNGTNFaqbAtFJzFyeGyxiCQlJddb4fJ9tOoaMADV6xEhCif8eYiC2ESIObcOhkRoyms6LkqCOOoqUGq/vIoXf0k+ixefZp5QpUvXOU3TTqUEmdSZlhPc8PIWwYoWgEarTp40kzE1JD6OlGqH7dRWOrVQjqnQE5j1V/eRtQSmMbtGayafMOfQYt79ILTmDLxZcN7wwCGJ1GWEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/i4erJIyPRu3j3s0v31PVdJrH/6F4VbjgREygqEHXE=;
 b=DoDD/gxtfwsht4/W/Eu/G9iRR8H6RCZJlkQ7AOAG31xg6dZR6iKjE6sqQ/T67FyiBLUANzTkcj7O7ZUD9985gvzFMCilboXgT6dpgU+lHgyswXFEploXBsiLZLfk+YFylj+FkYi0J5eOGAE1DMqYChX/LgsQMizOe53wrXMeYxDTE++hpHGdbxnsU9uw0LUFG1pZvNIwgPrkF+9oewah8wRnnenxP1UaBzH88L9kF6qcJzWwijoRXORE3Afsa5HXPHEsji5Ty/KStfYbjTdP9FzCWGA1uW9/Wfh2QlJxJejbPFCPUyBNSNh3DPAEcuXLL6h4dB9fezve8Nkyl+vR2g==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by PA1PR10MB9149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 09:35:00 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:35:00 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "docs@lists.yoctoproject.org"
	<docs@lists.yoctoproject.org>, "liezhi.yang@windriver.com"
	<liezhi.yang@windriver.com>, "niqingliang2003@gmail.com"
	<niqingliang2003@gmail.com>
Subject: Re: [PATCH v2] fetch2: Ensure a valid symlink in `PREMIRRORS` case
 when using shallow cloning
Thread-Topic: [PATCH v2] fetch2: Ensure a valid symlink in `PREMIRRORS` case
 when using shallow cloning
Thread-Index: AQHbym4MNXQj5I4yFkqN2OOw428z9LPef9UAgAADigCAAAI6AIAHusSA
Date: Tue, 27 May 2025 09:35:00 +0000
Message-ID: <fa330d16540aefb4bc011849a5cdfb75ef1b20cc.camel@siemens.com>
References: <20250521163311.2745308-1-stefan-koch@siemens.com>
	 <d11158333f8ac0f2d6525e593ba7dd0ce6a57369.camel@linuxfoundation.org>
	 <52082b629ebcc83f94f2768620a2867a1f027059.camel@siemens.com>
	 <b1e217227e179aa3789e0fd3263da04e14966c0d.camel@linuxfoundation.org>
In-Reply-To: 
 <b1e217227e179aa3789e0fd3263da04e14966c0d.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|PA1PR10MB9149:EE_
x-ms-office365-filtering-correlation-id: 1426b136-8660-465c-8b8e-08dd9d01c02c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cWlTczBZeXZQRUhCQVRnb3ZXRERXSHNCT0FPVmRrczhORkVhUEFtWkpSOUpQ?=
 =?utf-8?B?TTUwQ2RGR1FBWGxscGVvYTBYd2JlWmxBVEU4SHd0YWJjamdKL2hEdDZwMGN1?=
 =?utf-8?B?TUM4VUF4NGEvN2lnQysxVVFVK0kyTFh1Ry9xVzhxTkk4aERRQzVUMFNzM3Ey?=
 =?utf-8?B?NjM2TWw0ZGlxdC93dW40Vnd0OGczNG5PUm45Rkd2VzlvWnJrZDZ5WFVkbUJP?=
 =?utf-8?B?SUM4MXJza2Q1V0VLOFYyQzArVFFSU054SlVjVGh4WGJhYUlYSEhBYTNWcXpr?=
 =?utf-8?B?RGw2ZnhHdVlCdHpPV2xWcnFaQ1RHSnNjUFgxQU5WZ256Q2NtOWd4VFpreDBq?=
 =?utf-8?B?ekNrTlptenVSL3JySGIwWjdqSURpRk83VCtGeDdtSHBFdmp6Q1pWTmdla1Ur?=
 =?utf-8?B?M1d4MmJhcDIvY0gxd3UxaVFHVGdLeVZHTzMvK1VLbERKYVgwVmJTMFE1aTFr?=
 =?utf-8?B?ZllIRERRWmpudC8rYkVtUVdQSzh0Y0FGWi9rWWdIbmIrd1FtY01teFUreXF0?=
 =?utf-8?B?MUtnNXV4ek9OWWliSDZ0dFk3RFNqNHBhN09YR0FLdUEzKytDdXhiU2Flc0ow?=
 =?utf-8?B?NG02N0lMekErbG02QmdUZ08ydW9XSlppMjRvdTNCV0liMkFscXYwNjUwZk5W?=
 =?utf-8?B?d1YvNUxrSGNpWWQ1ZjBHL1UvdGtFcDNVVHZ0a3V0Rk9SdlIyV1lVTFZrazRH?=
 =?utf-8?B?RWtQMm5WUE1IRzk5TkJJZ3BHbDlGNTBUM2Y5d1dCQm04bjRDZEcwMmViZGxF?=
 =?utf-8?B?WmZ5cjQxTzNYY2RaVk41Ky80b3QwVVlsVU41RnZlNVl1MVptZFBia1FydzVu?=
 =?utf-8?B?SlVIS0Exd2orZFZKbExYeG9hc2RYOWkyd0FtcnNLV21RNGxPOGR0YVpqdTdI?=
 =?utf-8?B?YktUem9wMHdBTjdWdGcyRTJ1ajhJUDRZQmNLU0p2SzhiUVh2WWx5WWtibVc3?=
 =?utf-8?B?M2NjRUZzR3NUcHJXQjVCNGgwdmE3d0MzVFNKTjlZd3Mza2ZrQ3JJbmk1TlI2?=
 =?utf-8?B?bmFnUHd6K3N1blR0TUZJV0FXVVliNnVFT1lQcVpyWmE2alBYY1h3cU9iaDhM?=
 =?utf-8?B?azRBcDRNVThjbzNDWU44SGpNY09ZZGg2Y0c4azdvbmVYWVpZbXZHdGdna1Q2?=
 =?utf-8?B?bVorbWc5L01SVHBUOGE4eXlwYUlIaHlxSHZyemVjekxGdEhhajlXeC9hMFVs?=
 =?utf-8?B?SGZNMW5JVGd6SlJRTXBnVFdBR1ZySHZLV0VSZ3FPKy9BZUhBamdhcjZIOXlC?=
 =?utf-8?B?ZnUyd3NxalZ5azgrSGkzbDVtNFpwenUzMVoxSjBDVDBzRlNFam5FS001MmtV?=
 =?utf-8?B?eFF4cnIybHEvL1RYV21laHZyMmJ1ZStHRGhiTDA3Sm5iVUEzOHc3TXdrWjhS?=
 =?utf-8?B?SnNLSWVhaWlFck1qTHl6NW15Mm0zSWZGV1JVMG1UUnFYQXhSWjUzQTB4TFZ6?=
 =?utf-8?B?TnB6V0NhYjRlMjdRR29IRXh0QmtZV3VBZUp3dGYwbUttNGdBUDdoV2l0cWh2?=
 =?utf-8?B?akVZM3JTOUpPSGtwOERjTHJlYnN4ZEhqVGluaCsydjlnK2tsL0NIV1prdHMz?=
 =?utf-8?B?QU5qbHg5dTQ5dVJVR2JiM20zZGxWWHFLbklnZnZ2Ry9pY0I5WDVOR1RtWWd5?=
 =?utf-8?B?OGpQQ3k4T0dFam85U0IzcnZTbnNBb0orQmR2UHBWSWg1YURPL3RvSEc2TWE3?=
 =?utf-8?B?L3JyYXlHcm9zTWk0aGlIZFQwRGdueGwyQjQzdHdLdHhlNkdVVHR6Znk5bzhS?=
 =?utf-8?B?Y3g2SU81N0V4ZXNiaW9rRnFPRXFGUFZ1NE1PbWZLdDVTUDBybmU4SmpIdUFq?=
 =?utf-8?B?V0VHemxOQWVmY2FuWXYvWno2NGpvRVd5SWpkbi9FaXJMc0xWZ3ZGT3MvYkpQ?=
 =?utf-8?B?ZjNsUlFqcWh4bUx1aXd1UE9kcUVVWjJBMUF2Z2NINU14bnRFQ3gwcW5OWXMz?=
 =?utf-8?Q?riJwh6AES/Y=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UlJCOTFGUWt1WDBMNmltTC9iUkpKdm1TSkZwVkIxWE13ZjBhblZSREF2ZWls?=
 =?utf-8?B?R1FVMFBKdjRaSzdHczlKNW1YaE8wUnBOS3RyK1FGZVBoanRYaTU3bWlqdXdU?=
 =?utf-8?B?bFFsOWwvZ0NqMDhwdkFQakt4UzRJR3BDNFZHLzBlS05zT2Z6UHBMMjVsK1JO?=
 =?utf-8?B?cG9pYlZlOVRIc2h3MXRUUnh1RmlJWFVDakNJS2huM2VlWGxJMFg0dUlqcnZ5?=
 =?utf-8?B?N2I2bWMvQnpwQ3BPZS9oSmY0NWhyMXlibDBmVkNzS2psVW8rdXRsZHBhMDNV?=
 =?utf-8?B?QjNVR0t4WXRtTFpySXNQeGlrVjEvV0ZIZ1hGRTczdWpha2IzWjhxc29KQ1FM?=
 =?utf-8?B?cTdOOU1zRE5FUHVPT0dnYlJ0T0QrblU4Qy9IcERxMkRXSHppUWR3QWFKYTBs?=
 =?utf-8?B?RncxU2J3NkVSamxnNGFTS2E1TFM2cGgwODZIQ0lRcWcvTkdHbUltUmdrWXJJ?=
 =?utf-8?B?b25od3RtVE83S3QxZURkT0ZpRkM2WnJLcWhxaVErdExXV3hsWXA5V1Z4aXZM?=
 =?utf-8?B?dXlkZkpzc0QzY21qTFp5RDhSTkYrMVpodVJHazVWOTRDOFptaCs0SFhpZFZN?=
 =?utf-8?B?N3FwbGx6MTBqVjk1L3pvR3BQNHlldVpDOUVNd0E3RWhEUDJjem00SytLOG9E?=
 =?utf-8?B?NnJsaHN1VVRWa2VlNVdRUWtTRnk0N0J0alRuaWNicXhyZ3NyZ3ZjOXBuRzZn?=
 =?utf-8?B?TlA1WmdDdG95UE9vK2dMVVdGb1RNMUpjSTJaUS9ybjNwbW1CdUc0NkQ0ZEVG?=
 =?utf-8?B?VXcrMitZYnhWOE83Qit6Z1Bqdlc5SEhwY0VzUjlEdXJTdTVacHJ0UnlTaXJm?=
 =?utf-8?B?bnVYQ0ljV202REJkaGVQQjh5M3pubi9WeFFRbVM1aWUzbWZTcmxhU3ZpV0FH?=
 =?utf-8?B?UXh2V080YlZXTHJONVNtdlp1UmFIZ1p3Y1lyd2pWQVI0TGtoRFBjUXA1Q0px?=
 =?utf-8?B?dnBqNEV6aUs0cFd2cG51am5XS3JUVVJCRWRweDVpUUVIbE0waE9aOGR2Q1NV?=
 =?utf-8?B?QUZHbnp6WVhrMWpmaEt2cWR0SmszNzRPc21ENjdVK3FnM05oMWg4bFVkbFZj?=
 =?utf-8?B?Q0ZOcVVkRkVvaHVFRzBiL2JTR0c0RlhsMjJYY2p5a041RVV6Q1FQZ0hlYkZL?=
 =?utf-8?B?OTRmNmM2ckZxV3JXSGlNZzBkTytya1hLSHJpTW5veDJGSmJXUVBDTUl0OWFV?=
 =?utf-8?B?SnYzRHVFSlNlNW1kRFJxVXVwTllBcVpkTDJUdHphV09XNGErMEJZa0JGWExw?=
 =?utf-8?B?M3lOWXRTcEtNZ1R4cmlLS2g3VXFJVnJGTHRPRVFiUVNKMklzVFBiUXN0bThu?=
 =?utf-8?B?dFRVa0htR3lacE93ek5pQUVrYlRvTVllVTZrQ1M2OCsvbU5GMUdlWEhoeFFD?=
 =?utf-8?B?K2puMUd1c0tCOCtFR3RJNUxDYzNWc0xnK1lyMVE1NUhsRENMYjR0Zk50ZEVu?=
 =?utf-8?B?L0NzdVA5cVdkV2dTNTl5SXVrSEJYQjhVQm00Y284dFhBeUx5cmFyNnpGWjdn?=
 =?utf-8?B?RWVaLzVBbkZHZ205RnFtem5kQTF4WkE5S1lETytSL2ROMEpIM0ZyRXVNbkV3?=
 =?utf-8?B?UmRmZ1crYkMyOXlKT1VvMFB6NzJYcTBPM0l3LzRBMGY2VmhhK3luK3ByTUZl?=
 =?utf-8?B?VTEwNU91ZkZlMUR2ODRxcVdQejhZNFczYnBEOHBRVHgxQThxYW9Bbi9zeEtU?=
 =?utf-8?B?WnpSUE9JRU5kNm9sTDJuWXJPaW5ZQzFwRFhRQ3dqUEVjU0lsVFk2WVlUbHdI?=
 =?utf-8?B?NXJoTUxqYVNRL3FmaFVYSVMvT3hma3hnSE5idWtuTzJpMXBDQkcwakNxaVBQ?=
 =?utf-8?B?YWJoSE42U2MyWGl3ZzdvNzdqbnZ4TG91cVRDY3czOWdGeU4rOUMvNjZhZVpI?=
 =?utf-8?B?SXpkUUFYUHpicHRCZmJRWml3ZEFBclBENjBBSHNOMG1SSVVpOVREa0RtWnJx?=
 =?utf-8?B?U1ZJNkJWUFBGdG54amNuQTFPVHloUW1OU1ZaUDJobGh4WGNRTmtvR2lsSU52?=
 =?utf-8?B?NGZHWmRoR0RRNllIOG5MMEFTdm1NYlBvRC9mN2JvYk0rS2FlR1dOc1AySWxS?=
 =?utf-8?B?eU9jWS9hNHpocTFCU1paM1NjNWJuazkyL0dsQTB0eTd2S2ROOW5MMFg3MkR4?=
 =?utf-8?B?YUZwdzc1K1JiQ2c1UnpsTXZ4bFdRRnY3NThWS2Q1MnMvQlNOVEs2ZlgwK1Ra?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57371B76500CC349A454E49392E6C28A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1426b136-8660-465c-8b8e-08dd9d01c02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 09:35:00.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/xVhI0fbcabQ3/66yrKimnQ5/2D5EZAuU4f1dY1iUwLukXcugepvPWT9sRpcPgu8Ut1wKTmYXDdkduc3vT+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9149
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 09:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17644

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDEyOjMyICswMTAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gPiBPbiBUaHUsIDIwMjUtMDUtMjIgYXQgMTE6MjQgKzAwMDAsIEtvY2gsIFN0ZWZhbiB3cm90
ZToNCj4gPiA+ID4gT24gVGh1LCAyMDI1LTA1LTIyIGF0IDEyOjEyICswMTAwLCBSaWNoYXJkIFB1
cmRpZSB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwgMjAyNS0wNS0yMSBhdCAxODozMyArMDIw
MCwgU3RlZmFuIEtvY2ggd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gLSBTaW5jZSBgdWQucGF0aGAg
Y29udGFpbnMgaW4gdGhhdCBjYXNlIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGBQUkVNSVJST1JTYCBw
cmVmaXgNCj4gPiA+ID4gPiA+ID4gPiBwYXRoLA0KPiA+ID4gPiA+ID4gPiA+IMKgIHRoaXMgY2hh
bmdlIGVuc3VyZXMgdGhhdCBhIGNvcnJlY3Qgc3ltbGluayBpcyBzZXQgdXAuDQo+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEtvY2ggPHN0ZWZh
bi1rb2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+
IMKgbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8IDUgKysrKysNCj4gPiA+ID4gPiA+ID4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiA+ID4g
PiA+ID4gPiA+IGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiA+ID4gPiA+ID4gPiA+IGlu
ZGV4IDJkZTRmNGY4Yy4uMDUyNTA1NDU2IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2xp
Yi9iYi9mZXRjaDIvX19pbml0X18ucHkNCj4gPiA+ID4gPiA+ID4gPiArKysgYi9saWIvYmIvZmV0
Y2gyL19faW5pdF9fLnB5DQo+ID4gPiA+ID4gPiA+ID4gQEAgLTExMTcsNyArMTExNywxMiBAQCBk
ZWYgdHJ5X21pcnJvcl91cmwoZmV0Y2gsDQo+ID4gPiA+ID4gPiA+ID4gb3JpZ3VkLCB1ZCwNCj4g
PiA+ID4gPiA+ID4gPiBsZCwNCj4gPiA+ID4gPiA+ID4gPiBjaGVjayA9IEZhbHNlKToNCj4gPiA+
ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4g
PiA+ID4gPiA+ID4gb3JpZ3VkLm1ldGhvZC5idWlsZF9taXJyb3JfZGF0YShvcmlndWQsDQo+ID4g
PiA+ID4gPiA+ID4gbGQpDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBvcmlndWQubG9jYWxwYXRoDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oCAjIE90aGVyd2lzZSB0aGUgcmVzdWx0IGlzIGEgbG9jYWwgZmlsZTovLyBhbmQNCj4gPiA+ID4g
PiA+ID4gPiB3ZQ0KPiA+ID4gPiA+ID4gPiA+IHN5bWxpbmsNCj4gPiA+ID4gPiA+ID4gPiB0byBp
dA0KPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAjIFRoaXMgY291bGQgYWxzbyBiZSBh
IGxpbmsgdG8gYSBzaGFsbG93DQo+ID4gPiA+ID4gPiA+ID4gYXJjaGl2ZQ0KPiA+ID4gPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqAgZW5zdXJlX3N5bWxpbmsodWQubG9jYWxwYXRoLCBvcmlndWQu
bG9jYWxwYXRoKQ0KPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAjIFdoZW4gdXNpbmcg
c2hhbGxvdyBtb2RlLCBhZGQgYSBzeW1saW5rIHRvDQo+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4g
PiA+ID4gPiA+ID4gb3JpZ2luYWwNCj4gPiA+ID4gPiA+ID4gPiBmdWxsc2hhbGxvdw0KPiA+ID4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAjIHBhdGggdG8gZW5zdXJlIGEgdmFsaWQgc3ltbGlu
ayBldmVuIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGBQUkVNSVJST1JTYA0KPiA+ID4gPiA+ID4g
PiA+IGNhc2UNCj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgaWYgZ2V0YXR0cih1ZCwg
J3NoYWxsb3cnLCBGYWxzZSkgYW5kIG5vdA0KPiA+ID4gPiA+ID4gPiA+IG9zLnBhdGguZXhpc3Rz
KG9yaWd1ZC5mdWxsc2hhbGxvdyk6DQo+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZW5zdXJlX3N5bWxpbmsodWQubG9jYWxwYXRoLA0KPiA+ID4gPiA+ID4gPiA+IG9yaWd1
ZC5mdWxsc2hhbGxvdykNCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHVwZGF0ZV9z
dGFtcChvcmlndWQsIGxkKQ0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHVkLmxvY2FscGF0aA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIGd1ZXNzIHRoZSBvbmUg
cHJvYmxlbSBoZXJlIGlzIHRoYXQgd2UncmUgdGVhY2hpbmcgYQ0KPiA+ID4gPiA+ID4gZ2VuZXJh
bA0KPiA+ID4gPiA+ID4gZnVuY3Rpb24NCj4gPiA+ID4gPiA+IGluIF9faW5pdF9fIGEgZmV0Y2hl
ciBzcGVjaWZpYyBpc3N1ZSA6Ly4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiBJIHRob3VnaHQgc28s
IHRvby4NCj4gPiA+ID4gDQo+ID4gPiA+IEFueXdheSwgSSBoYXZlIGRlY2lkZWQgZm9yIHRoZSBz
eW1saW5rIHNvbHV0aW9uIGZvciB0d28NCj4gPiA+ID4gcmVhc29uczoNCj4gPiA+ID4gLSB0aGUg
UFJFTUlSUk9SUyBsb2dpYyBpcyBoYW5kbGVkIG92ZXJhbGwgd2l0aGluIF9faW5pdF9fDQo+ID4g
PiA+IC0gdGhlcmUgaXMgYWxyZWFkeSBvbmUgc3ltbGluayBjcmVhdGVkDQo+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gSWRlYWxseSB3ZSBwcm9iYWJseSBzaG91bGQgaGF2ZSBzb21lIGZldGNoZXIgc3Bl
Y2lmaWMNCj4gPiA+ID4gPiA+IGZ1bmN0aW9uDQo+ID4gPiA+ID4gPiBjYWxscw0KPiA+ID4gPiA+
ID4gZm9yIHRoaXMgdG8gcHJlc2VydmUgdGhlIGluZGVwZW5kZW5jZSBvZiB0aGUgcGFyZW50DQo+
ID4gPiA+ID4gPiBtZXRob2RzLi4uDQo+ID4gPiA+IEFub3RoZXIgb3B0aW9uIEkgaGFkIHRob3Vn
aHQgYWJvdXQgaXMgdG8gc3RvcmUgdGhlIG9yaWd1ZC5wYXRoDQo+ID4gPiA+IHNvbWV3aGVyZSBh
bmQgcmV1c2UgaXQgaW4gdGhlIGdpdCBmZXRjaGVyLiBUaGVuIHRoZSBhcmNoaXZlDQo+ID4gPiA+
IGNvdWxkDQo+ID4gPiA+IGJlDQo+ID4gPiA+IHNhdmVkIHdpdGggdGhlIGNvcnJlY3QgbmFtZSBp
bnN0ZWFkIG9mIGFkZGluZyBhbiBhZGRpdGlvbmFsDQo+ID4gPiA+IHN5bWxpbmsuDQo+ID4gPiA+
IA0KPiA+ID4gPiBRdWVzdGlvbiBoZXJlOiBJcyB0aGlzIGZyZWUgb2YgYW5vdGhlciBzaWRlLWVm
ZmVjdHM/DQo+ID4gPiA+IA0KPiA+IA0KPiA+IFRoZSB0cm91YmxlIGlzIHRoYXQgZG9lc24ndCBu
ZXN0LCB5b3UgY2FuIGhhdmUgbWlycm9ycyBvZiBtaXJyb3JzDQo+ID4gb3INCj4gPiBtaXJyb3Jz
LiBUaGF0IGNhbiBiZSBoYW5kbGVkIHdpdGggYSBjaGFpbiBvZiBzeW1saW5rcy4NCj4gPiANCj4g
PiBJIHRoaW5rIHRoZSByaWdodCBzb2x1dGlvbiBoZXJlIGlzIGEgc3BlY2lmaWMgbmV3IG1ldGhv
ZCBmb3INCj4gPiBmZXRjaGVycw0KPiA+IHdoaWNoIGlzIGNhbGxlZCBhZnRlciBwcmVtaXJyb3Jz
IHRvIHB1dCBsaW5rcyBpbiBwbGFjZS4NCj4gPiANCj4gPiBUaGUgZGVmYXVsdCB3b3VsZCBiZToN
Cj4gPiANCj4gPiBlbnN1cmVfc3ltbGluayh1ZC5sb2NhbHBhdGgsIG9yaWd1ZC5sb2NhbHBhdGgp
DQo+ID4gDQo+ID4gaG93ZXZlciB0aGUgZ2l0IGZldGNoZXIgd291bGQgYXBwZW5kIHRoZSBzaGFs
bG93IGxvZ2ljLg0KPiA+IA0KPiA+IFNvbWV0aGluZyBsaWtlOg0KPiA+IA0KPiA+IEZldGNoTWV0
aG9kKCkNCj4gPiDCoMKgwqAgZGVmIHVwZGF0ZV9taXJyb3JfbGlua3ModWQsIG9yaWd1ZCk6DQo+
ID4gwqDCoMKgwqDCoMKgwqAgZW5zdXJlX3N5bWxpbmsodWQubG9jYWxwYXRoLCBvcmlndWQubG9j
YWxwYXRoKQ0KPiA+IA0KPiA+IEdpdChGZXRjaE1ldGhvZCk6DQo+ID4gwqDCoMKgIGRlZiB1cGRh
dGVfbWlycm9yX2xpbmtzKHVkLCBvcmlndWQpOg0KPiA+IMKgwqDCoMKgwqDCoMKgIHN1cGVyKCku
dXBkYXRlX21pcnJvcl9saW5rcyh1ZCwgb3JpZ3VkKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmIHVk
LHNoYWxsb3cgYW5kIG5vdCBvcy5wYXRoLmV4aXN0cyhvcmlndWQuZnVsbHNoYWxsb3cpOg0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5zdXJlX3N5bWxpbmsodWQubG9jYWxwYXRoLCBvcmln
dWQuZnVsbHNoYWxsb3cpDQo+ID4gDQo+ID4gDQpJJ2xsIHNlbmQgdGhlIHBhdGNoc2V0IGluIHZl
cnNpb24gMy4gVGhhdCB3aWxsIGNvbnRhaW4gYSBzaW1pbGFyIGxvZ2ljDQphbmQgYSBzZWxmdGVz
dCBjYXNlLg0KDQpBcyBleHBlY3RlZDogV2hlbiBhcHBseWluZyB0aGF0IHBhdGNoIHRvIHRoZSBj
dXJyZW50IGBtYXN0ZXJgIHdpdGhvdXQNCmFwcGx5aW5nIHRoZSBvdGhlciBwYXRjaGVzIG9mIHRo
ZSBwYXRjaHNldCBpdCB3aWxsIGZhaWwuIFdoZW4gYXBwbHlpbmcNCmFsbCBwYXRjaGVzIGl0IHdp
bGwgc3VjY2VlZC4NCj4gPiBDaGVlcnMsDQo+ID4gDQo+ID4gUmljaGFyZA0KUmVnYXJkcw0KLS0g
DQpTdGVmYW4gS29jaA0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQoNCi0tIA0KU3RlZmFu
IEtvY2gNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

