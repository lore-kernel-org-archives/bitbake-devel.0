Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE0C0219B
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 17:19:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web11.75199.1738948780080747437
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 09:19:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=E8bHv9sc;
 spf=pass (domain: siemens.com, ip: 40.107.22.57, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/v89TOdmTmPLFoe5QUwGZtEpwBtsjusv5JkcTqgXSbmDwH5gicQ5OFbmj3iiTtcOP8Q67ZdSbL06Ejdg0L16fxwAbuyyM/u+m9NGVzUakJkACJ3njFH8/BxBQD6QvWcVjaibLfUIc5DJiHrczvt0SZdmmqsucCKylfEX3PID8FQEJMMzBqDAaenhFqDGd9CUB65kqgl54SJG8KJkWPRe9w3GnVx4tnAMTgrQWEqmhnoLImcQcH7w43wm436rFNon7ckILBkDv8d2eZTzlE8ABF3YRC/MAODKfEx3GGxPzoEPATjlbnIqYvVAEh732MyQTmdQDhtyC4HT3vZOMMXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc39JfW5/XZbB1FFzx6AjUe/f9IyLvOalghQ9QFX5/I=;
 b=x9iZDB2sUviRVrGQeswLTptg7o5sxugCvztsbDnZNtOxNrQdTPAko1iGLjXbbXZuiAX7tYYKs460UZ4yDrIbGg5IAjHMaorESzoxnEEcgq9pnPxtsYH7Q4xwasrYJ6BAm0F9xKk2AJfVPrYXVjFFwvsxyb3ktWLzpIkV6qxrImR2pAWWGkWK8yeZrL1lFBwtNLYwmy5vTssMqeAiKBpsQcXDxiJ1uTkLHIkdt8vD8UuQjwdmFG8dwds5LM6co579dToT97A000aG6AR1oW1Pn2zrskS9KLw6PH8Wer/ogWqNayYpjxekt65KGJ23BZMl3t6HkXqNKogaqexbEWcCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc39JfW5/XZbB1FFzx6AjUe/f9IyLvOalghQ9QFX5/I=;
 b=E8bHv9sckJeWk9YGg/YCc5C77mI1PZExxxDuPLOsDN9mNDN+r0mEvAr7GuBZn5BGBllM+w7v+JwCLck48VTGulZPNi2oenuQATVO7ghF3XG3TmZkxhUniEJQ5+PY0gAG9fVm+F5j8FrnoPEuicFmx+sGaNgYnudIoN9d2JsMD3k7DmlbGE1HYjFF5HZZMaYPIpG6gJV0pNAq/oEWWGWC/fI6xE4OPO5e6+4cJqlDoXzYOH5gssvkVYK1x6K7HhqYYVtN5nnfnNWFBmTuNOLVbO9tBrXe91kTbifa4R4HN6YEveCLkNG9oT4icA6kh8FenLVnnBjPVxTPGrCipr59Nw==
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PAXPR10MB5685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:244::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.5; Fri, 7 Feb
 2025 17:19:37 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%3]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 17:19:36 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
Thread-Topic: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build
 support for tags
Thread-Index: 
 AQHbckBcVUO+dTVsdky5SYefwCaJwLMtvIUAgAyJKoCAAYncPoAABwYAgAAFNoCAAEihAA==
Date: Fri, 7 Feb 2025 17:19:36 +0000
Message-ID: <3583b11ba1dd99203c4c9651a546d337a131d19b.camel@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
	 <20250129112406.1660522-3-stefan-koch@siemens.com>
	 <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
	 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
	 <1821E627D6FBF186.752@lists.openembedded.org>
	 <1821E75CA5CDE51A.18160@lists.openembedded.org>
	 <1821E95A02BB5E12.752@lists.openembedded.org>
	 <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
	 <07ed332ad4733a7a4d5160b390124eb3053266e6.camel@siemens.com>
	 <CANNYZj-aKm-A14gv3eAjbPUj0UpbqBecvb+o_xmFhW3DfoCtdQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-aKm-A14gv3eAjbPUj0UpbqBecvb+o_xmFhW3DfoCtdQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4953:EE_|PAXPR10MB5685:EE_
x-ms-office365-filtering-correlation-id: 8a0f1c09-db71-442a-a2b2-08dd479b98f9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SFpJbmNhWllPL29PaHRja1pja202UU0yeVRDb2NidlBNKzNpRWxCb2VxeGxi?=
 =?utf-8?B?OEMxdndBeldlb2lIa1JDMHpqd3hPWlgyaCt2UnpsU1VxZkswcG1ERnZVa0tX?=
 =?utf-8?B?RUgyRnRCQjcxNHJqSFRLTFRCUy8wOVNKTkdhVGk5RlR3RWNkM1lwaFl4UExN?=
 =?utf-8?B?ZEdQVFY0UXVzOENGNnhEbWt6dkk5R05reDdJLzZOM3Y3MlBGWXZWeW9xL0tE?=
 =?utf-8?B?TnFTRk51N1VmaitGOElzZlYvMWZFRkNVOC9BdythQ0JUZFZ3K1JnNEFqMzZU?=
 =?utf-8?B?LzdDcmRDT0JYYk1ZRWNNRUp6ZWZUY3RuTjZ4N1Y5eVUycGo4azB6Vkh1TE1B?=
 =?utf-8?B?aEZkWG84VkE0WnN6c29DUVBvNGxUVXBzS3o4MjRJS3VjVUx1L0llVis3anpT?=
 =?utf-8?B?WjZOa1pscGxZVHo0MkNTZ2JIVm9qY29OcEZvbWRRLzRIOEY2c3RGOWRKYjBK?=
 =?utf-8?B?cUtCWVUzZExiL1JnM3JUSnpsdFdLSjRQUUJyRGt4czZhbndMSEh5akZCL2k2?=
 =?utf-8?B?SEQ2ejVrazY1ZGNtVGNjV2NnL1pmZG92MzNuZmFFK05rNmFDWFA2ZER2OVN1?=
 =?utf-8?B?ekdlaGo4OHhVdDAzVC84dm5HTDFTajBzTHhVTG5paFBCcWI1RWNaWEpXb1Rn?=
 =?utf-8?B?S29aRHc5aUE4VGtlbHVZN1NHZDFGbXhYak1CTGZrMERzcVdkTzhqRzJGbzM3?=
 =?utf-8?B?eENSczRzaWhjREkvY3g1WUg4RkhNb2pTVVZoRzhVN01kM2l2eXd2NzNpbisy?=
 =?utf-8?B?RUVQS05Td1VlVStiaC9lcFZlancrM1pYVTBLaS9PcS9yZCs5cHlqaTIxOUlB?=
 =?utf-8?B?bm1QQWxwc3crVzZ3WWFSUnVJdXBIMTRpOWp6elJuQVp1aTdmQVByYUhLVU1G?=
 =?utf-8?B?eE1RUGJIK1V0Uy9mMG1jM1YxbFo3WkFldHdPdUd3M2VPSDduY3dxNkRaSkNN?=
 =?utf-8?B?TUIyYXVmSVVUWUh6YnRRZkF6SXVRb1BJK1VLQ0d5TVBGck00dSs3V2kyN0xE?=
 =?utf-8?B?a0h2Q2UxcXFVWTNoekZPT2tqcnhJdk90WXN2TXVWTzRwSFhiYzFDZ2lkTzFV?=
 =?utf-8?B?aXBKTmJoM21TbExGZm91L3FkWDg1OUhhcnV2MUhWaGswK0V3SzJEcml4WEhl?=
 =?utf-8?B?RVByU3prUTBKVkxHcTN2V0lBWDdTQjFxMWhLNGUxTDFoMzNDZ2c5Y25uQllR?=
 =?utf-8?B?azAyNEVQUldQV211WXRZSlp3Vy9yL0ptS0ZMakxzcXYyTHZQTTZ5VjJlUHFC?=
 =?utf-8?B?UEJOWEpCclF3ZXZnc2ozUUJiVTlGTGJnNmpjeC9jeGRxZzUzUmllZWpaS2pU?=
 =?utf-8?B?RVg3T1dYVkpWcVZTZ0duMUhibXE4b0JwYW1KUGVBVlg2YW42U1UveDluMTM0?=
 =?utf-8?B?K1pwWU9GWnlMS2o0ckhQVlRSdEFqcy9ISVFiQndWcFlqL24rYkdnOTQzdTdZ?=
 =?utf-8?B?aHJadi9FaVE1dG1Za3dMT1NmUGdlVzZGbHBjSlJLS2duSmlTSitmRjR2dkY0?=
 =?utf-8?B?YjIxZGdRMkJ4bGFVVEkvdXp0QkkzTm9IdEw1b1VsNWMyeFpHeGdIVGJ1WGhH?=
 =?utf-8?B?bmNDSG9lOGFkWC9jUjF3SXh5eFJlSUZMV3Z5U3RKanV0VncwSEJPNWozbm8w?=
 =?utf-8?B?NGlCbmFrSWlaZDNOb0hvb3RzZVZKZ0pFYU5EYlRPdEducjhocGtObTltUWtT?=
 =?utf-8?B?NmRnUHRzSG0wbStuc3dFL050WWNTT25Fdmt2Y3NnMDYzRGZwMzRMendFb0h1?=
 =?utf-8?B?YnBGb2VzdTlrVk55TFBPSyt3L05WM2J1NjhmQVg4UGRsbjB5QTJ1QmhGekdk?=
 =?utf-8?B?L05OT0ovUFV6MUc2SE8rYlR1bXVZcHplVHRIL3lPb3B0WExWWDFXU2ljTXVh?=
 =?utf-8?Q?QZLlmiA3rTtn4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ejZjY2h6cVBSanY5Z29KVHQ4aHYrdVc0V3JxWHVjS2dlMXRDcVIvazVPQlg2?=
 =?utf-8?B?NzhNTFR6aWVMVjBJYUNES0NPbkovcGFhZTZ0SzdEK0c4K2FOb2QySFBWeExm?=
 =?utf-8?B?bm53ZEpoR3p6TmpuOFYra1hpYm14Vk1QYm5GSmN0SkZTcHVZSlR4R1NZaXY2?=
 =?utf-8?B?cU53dUI4QkZPR2gxU1hrR3BBeDI2eUFUVmFOT1hxejB2Q25vdFZncDhYbXpG?=
 =?utf-8?B?amR2V1hjZ3FHeDFVZVQ0M0pqN2NYU2swaUIyMkF0MkdmalRlekJabXFPU1JE?=
 =?utf-8?B?V3dqVmVpMFE1VzVoMTU4OGRRcC9oQnUxTkhhWkF4VVpJWGtZS2VodnhnalRN?=
 =?utf-8?B?dHBIaDFBTUxReWI4MzVtQVprWDRhZFVtRldhcURhanM1VHkyMUxqdWN5ZlRv?=
 =?utf-8?B?V2REa1c5cmtuZTdySGVjR1dGTnhLOUFTSjZ4NnNwSjJoL1NDVXFWL3ZWc3F3?=
 =?utf-8?B?ZjNCK29QVDhjTWJicElxMXYrR1h1Z3BzeGVZVDFpR2VNVk5nckFCMTJYbUk3?=
 =?utf-8?B?c3NOb1NnM1R1ZkNYUkk2elR3R0xVZ3V1RzJIeGRrTjVQSGcyVWF6SGl6ZnFr?=
 =?utf-8?B?SndnQlRBS1pmSVVxaUp1Y2k3ZEhVUzB0d0Q3VjQxK1I4bEtGSVVsOHEzM3pT?=
 =?utf-8?B?T21HTHJMOEozVGloQVRnRVV4TGVvTVdMTzE0cU1xdDI5UDZFUkhoVmVCeEpk?=
 =?utf-8?B?QmtRQ2NHck1jMVlHc0FXN2pFYUxWbDdHZlRaZy8wZUs3STBsajhMbE85TnN2?=
 =?utf-8?B?SUU4Y3d4MkVqdTdUajIzWDZIalZkT1JmcU9JaDJ6K1F2WmhMMzd5MXJ5WFpU?=
 =?utf-8?B?ZHM3SUhhOHpLL0JnSm0zOU1VUDh4YlRPa1d3UHlHUW1KQUljZkJZMjlMSmRP?=
 =?utf-8?B?UEdTRFk0eWVxRVhZNUZqQ0VFNWVmbEpKT2JnSGpOVU5hZWdGNGJvM1RmKzNV?=
 =?utf-8?B?T3FmK1JBK3BOaTlXYTgveW5MNkNYQmwvdk1NWkRVT0c5N2RwUjVFQ1Y3WnI2?=
 =?utf-8?B?MGs1ZDRvcUJubVJraHpLeDBHZlNnVDNDQXJPMjF0bTc5dVhkVjF0UUZJa09T?=
 =?utf-8?B?d1NramtkNS80c09QU3ZRbjE4U0prTXAxcGFUZHRSS0VHRDdzM2NwNmViaG9n?=
 =?utf-8?B?allHVEdCdmZiQTNFZ2doTEZHa1RwL0dxbXNPcWRJSDd2dzJYcXlBanVHNVZU?=
 =?utf-8?B?Z3g2cEFLNWx5SENlQmcwSzRtNFVDcEVtdkpPN2N1N2VOY2hUZkRBTmFjeWlJ?=
 =?utf-8?B?NjlVS3pnTzN2VnJrZTFJRk5XamRPS0QzSG91VG5JaDZEejluNTRIdm9ZRnNs?=
 =?utf-8?B?U0NVYzZHclVlVzc5bDBZVnIyL01GaTlHZWJic3JuSmhkeUMxY09EVndwMHpi?=
 =?utf-8?B?SnZzcC8rd1Z6VW5LSkhmUGFJS0YwVGVFaGVrZ1ozR3ZhQ2RXbmFRVUo2MnNJ?=
 =?utf-8?B?V01kM3IycWNFbTlzaWk5TXdaUGptSlZQL0pOV0t1VStoWFB3S3VSVGRuT2U1?=
 =?utf-8?B?Mk1maXdoY241UWpMWDd2ZzUvbGU4Z1p2L0QrTkNjc0xZV2c3a1NSNU1FZGVJ?=
 =?utf-8?B?ajFIaFJ2SDNaNjhVZGcvVkovTjF2RnlZd3psK0tBZGhEM2ZRcWVZdy8wTHJP?=
 =?utf-8?B?cVU5bGFRd0J3aFBFRmd6c0tlMWM4ZlJaeWZkN2hBVEhmdmxtUDkzTEpoRUQ1?=
 =?utf-8?B?NWx2OWc2WnZxRVVGYTdzalRkVlk2Tm1jTTdBOXV4bXVuWmsvSTJVSW81a3hU?=
 =?utf-8?B?UWpFbjRqbGtIMTlob1ZvV3dCbERLYVNCcUEvMHRkaDR6Mkx3WTZnc2ZKc2dw?=
 =?utf-8?B?eEFhNTFZeFVCUDJZZ2dhUTVSMVMzWmpKSFp4TEtiQ2lrciszdUFyK2huSHIx?=
 =?utf-8?B?V1RocVQrVEV3MW00VlV4L2cvR1FTU2xsdElmc2RhQUtadFFLaWFaUEl5Qy80?=
 =?utf-8?B?citOYStrQkZsTHNoTDZxa2xkZkhCSFZPMUhIR3Jsc2xMazFkeVBUdjlLOStM?=
 =?utf-8?B?djBLSFJhMGdpcU9TZEYyVm92WnltSzNJeTZFcFdqZUhwZVJ5TThmL1BqMWwx?=
 =?utf-8?B?cFlJZUpBOUJYRmZZeDBqOUcvZERBSnF2Tk9SdEtQQU9ZNTVBbjZlR1BXZWhC?=
 =?utf-8?B?L0NRWElrQTdlUXhLUE9rQzNPdW9ycXZSYk1yQkl5TU5UZ1pKWnZyZjg5Z2Nr?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CF77427C0813D448BFE7CD760F0D506@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0f1c09-db71-442a-a2b2-08dd479b98f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 17:19:36.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCbmUSIbwbasb74BYTXtJut3jgarR/yb5RzPyvpXx4bRZE294LYvQfNX7qw45RcK29cAM4HMeg7CEbgCCwiTLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5685
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 17:19:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17186

VGhlcmUgaXMgbm90IHZlcnkgbXVjaCBpbiB0aGF0IGRhdGFiYXNlOg0KDQpnaXQ6Z2l0LnNlcnZl
ci5lYnN5LmRlYmlhbi5lYnN5LXFhLQ0Kc3VpdGVzLmdpdG5leHQJZTlhOThmZmI3ZGYwMzNiNTIw
NDYxNDQ3N2I4ZDNlZmFjY2ZjOTIwYg0KZ2l0OmdpdC5zZXJ2ZXIvZXZlbnRtYW5hZ2VydjEuMC4x
MC0NCnRlc3QJZjU2ZTY2M2VjMDk4MmU4YjMwMGMwM2IxNGE5NWNiNjdhYjJmZWFkNQ0KDQojU1JD
UkVWID0gImY1NmU2NjNlYzA5ODJlOGIzMDBjMDNiMTRhOTVjYjY3YWIyZmVhZDUiDQpTUkNSRVYg
PSAidjEuMC4xMC10ZXN0Ig0KU1JDUFYgPSAidjEuMC4xMC10ZXN0Ig0KDQpTbyBvbmx5IHRoZSBT
UkNSRVYgYXMgaGFzaC4gQnV0IG5vIHRhZy4NCg0KT25lIGN1cmlvdXMgdGhpbmc6DQotIFdpdGhv
dXQgdGhpcyBQQVRDSCAyLzMgYnVpbGQgd2l0aG91dCBCQl9OT19ORVRXT1JLID0gIjEiIHdvcmtz
DQotIEl0IGZhaWxzIGFmdGVyIGJpdGJha2UgLWMgY2xlYW4sIHdpdGggdXNlZCBCQl9OT19ORVRX
T1JLID0gIjEiDQotIEJ1dCB3aGVuIGFwcGx5aW5nIHRoaXMgUEFUQ0ggMi8zIGFnYWluLCBhbmQg
bGV0IEJCX05PX05FVFdPUksgPSAiMSIsDQppdCB3b3Jrcw0KDQpPbiBGcmksIDIwMjUtMDItMDcg
YXQgMTM6NTkgKzAxMDAsIEFsZXhhbmRlciBLYW5hdmluIHdyb3RlOg0KPiBPbiBGcmksIDcgRmVi
IDIwMjUgYXQgMTM6NDEsIEtvY2gsIFN0ZWZhbiA8c3RlZmFuLWtvY2hAc2llbWVucy5jb20+DQo+
IHdyb3RlOg0KPiA+IEkgaGF2ZSBtYWRlIHRoZSB0ZXN0IHdpdGggQml0QmFrZSAyLjguDQo+ID4g
DQo+ID4gU28gdGhlIGNvbW1pdA0KPiA+IGZkYzU1YmI2NDljYjc3NDU2ZDBhYzQ4YTk2MDBlZjI4
OWE1MmFmMTg6IGNoZWNrc3VtL2ZldGNoMjogU3dpdGNoDQo+ID4gZnJvbQ0KPiA+IHBlcnNpc3Rf
ZGF0YSB0byBhIHN0YW5kYXJkIGNhY2hlIGZpbGUNCj4gPiANCj4gPiBpcyBub3QgcHJlc2VudCwg
dGhlcmUuLi4NCj4gDQo+IFRoZW4geW91IGNvdWxkIGNoZWNrIHdoYXQgdGhlIHNxbGl0ZSBkYXRh
YmFzZSBmaWxlIGluIGNhY2hlLw0KPiBjb250YWlucywNCj4gYW5kIGlmIHRoZSBuZWVkZWQgcmV2
aXNpb24gaXMgcmVjb3JkZWQgdGhlcmUuDQo+IA0KPiBBbGV4DQoNCi0tIA0KU3RlZmFuIEtvY2gN
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

