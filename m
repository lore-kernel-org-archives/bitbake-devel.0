Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4705FC54E90
	for <webhook@archiver.kernel.org>; Thu, 22 May 2025 11:24:59 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.71])
 by mx.groups.io with SMTP id smtpd.web10.21525.1747913090926061873
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 May 2025 04:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VeUY45A6;
 spf=pass (domain: siemens.com, ip: 40.107.20.71, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE9nG/aK16462tXmvMYf2jLnoKxY/ppGmIv7Civ3EaZfozJCmWKAqCSnbnd+3vs0555yWDE+zx4NNC7mn9gqXd10eHS7oZmkVRitpo7ioixBvJTbl4K09bVvm/DvVTN363DeoybUAb+Ggt7bCIxq6wnXmFE7Foqvn8UFXCoEcFhhuJZLVsFJw8SQ7BFAHZP2+UKc3DXapWD56SLdX9ftKBvTLgNH9h7idLzd0hPmiulvhzF2wHl1CZz+Hr4nY1zD4iEbSluNuPRdpLKIqZPc4IvCyKvuBuAwHir1ALoVCtz8nelq7u+Ooog0OcKHT8dJJIQA8i4zXDLEKby8fpw+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHPoxIOfMgXm6zpuMcRtm3KVagHidkkRwJkCqAlsbrU=;
 b=ffq5/N+6ROvIC2lmaJOJyvIj2VPtPz80aI/mDHbHDsGxCuzTjNTju+N5oFeLPdSHvwmExRa5Uq6wBiM2e4vXEdvCytCs5opWIFJHcfH2n2TPlWql9aX5s2npjj7hMxS62JAfegrpJX6W7KwR9EQ1OSVHSdN8L8X3wkE8b/yJsRR/KaUxZEiK1MUnjr8Jwtta8BzLH4XWvsUd1AVfu6I9s4YzHyx/w4VC8Mn2+Z5DIlZHniCl9Av5pytzYUcoOJX4S/LnPM7Z/GwMZnEpGOi4fxyQ67c4WrVEO9P7OxasO5y1bZKMaLooQsBlg/vroR/jm5OZfalhbffALCeQ8PA3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHPoxIOfMgXm6zpuMcRtm3KVagHidkkRwJkCqAlsbrU=;
 b=VeUY45A6yJtcacu5mOrikEbJ7ot6Vs8c9NQw/pxgh1X9MfkIrrkZ9qJq++Y0e5vu1dwPOdbuAt2al4c1DDRy0bMMi/0PvTot3hRWGm6j3PCIXLvVozB9sZDOJSJ4Sac6V5D4NGSD8wJevRoscwIbo0Bq0cP8VA9fqjxoSZn4GJ+lKqjEdQrTBTyD4vIvrkhIGlO/yMO0pt5crOHwgCzsT1almZhHeH5pOuMwvZdjjGl0GVyTxFZ92/DtUmAxwq515jK+YSBjB0zJhR8jze2cj664KD9AsVO+un08sNK45h6GIxXrlblxI1q96u3DbNpbOOuTTU9dYwwK+nb9FVEfOw==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU0PR10MB7190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 11:24:46 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 11:24:46 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "docs@lists.yoctoproject.org"
	<docs@lists.yoctoproject.org>, "liezhi.yang@windriver.com"
	<liezhi.yang@windriver.com>, "niqingliang2003@gmail.com"
	<niqingliang2003@gmail.com>, "alex.kanavin@gmail.com"
	<alex.kanavin@gmail.com>
Subject: Re: [PATCH v2] fetch2: Ensure a valid symlink in `PREMIRRORS` case
 when using shallow cloning
Thread-Topic: [PATCH v2] fetch2: Ensure a valid symlink in `PREMIRRORS` case
 when using shallow cloning
Thread-Index: AQHbym4MNXQj5I4yFkqN2OOw428z9LPef9UAgAADigA=
Date: Thu, 22 May 2025 11:24:46 +0000
Message-ID: <52082b629ebcc83f94f2768620a2867a1f027059.camel@siemens.com>
References: <20250521163311.2745308-1-stefan-koch@siemens.com>
	 <d11158333f8ac0f2d6525e593ba7dd0ce6a57369.camel@linuxfoundation.org>
In-Reply-To: 
 <d11158333f8ac0f2d6525e593ba7dd0ce6a57369.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|DU0PR10MB7190:EE_
x-ms-office365-filtering-correlation-id: a45539f5-5429-410e-f377-08dd992341e0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WkxGMHpFM3AwZjBFY2loOHFrK2JlY0ZqOFBNZUt3emEyK1J0ZklWUjlkbXI4?=
 =?utf-8?B?Z1Y2a3JLRG5PWlQreENjS29NbTVuZXowTldkbG9JRzE2Z1RtY0RvRXdHR1hQ?=
 =?utf-8?B?TnVQc0RNVTUzdEtIY1pDeldzdW0wMnpLeSs3dDY3MWhCV2lOa3dld1EzUDFz?=
 =?utf-8?B?N2UzbjZka1E0MGpUOXVJQmh1R0RDTlh3M0R5V0VNaTV1SGdhcEJUbjR2WWd4?=
 =?utf-8?B?Z0VVMkdlUXVsZ0o2eE5aWmtEOW1kTnU5a05DVFppODBjYTRTRmJUNFlmYkRn?=
 =?utf-8?B?aHhIN2xOdno5WG1yTitKWVhYYVpDbC9VRDRabUFiMHkzNyt3SU5jZnR2UG5U?=
 =?utf-8?B?MTk0V2Z6OG9YS0xnc0t6RWJtZC94T3NnNmo0aUJmbUlhZ1hSTjltb1dUVlNZ?=
 =?utf-8?B?TkFMWlF1MG1GVFFGYkQ1ZXN4NHZxOFJLa3A2ZHM0TVJra3B3Q3hjWW4rb2I3?=
 =?utf-8?B?MVNMRlFNOWNCems0TEh4ZFExcGFEOEhaNFdFVDhwNlNWd2tuakZUWUp2Y1RG?=
 =?utf-8?B?bzd3TUIxMjViRXV3amlZbnJhWmJwd2RxTlNOS1ZRbkpFR291MG52ZW81N3Nm?=
 =?utf-8?B?ZEFydTVBNk43K0xpWGM2c2h1cEE1WmdQNzhxZHA3WnpEdW5rb2txSWkrU09P?=
 =?utf-8?B?aHk2ckdYTjRudWd0MXV4ZmFsbTJqRnIwOXFtZHRSbldUd2k2WlAvc1d0cS9D?=
 =?utf-8?B?SlhPRnVuWVE1Q3IvS0tWampsb2EycWs5L0xlRWNNak9wa2ZaRHg4ZkRGb3Y4?=
 =?utf-8?B?anJ1aldhMmJpN0lqaFVjZDkxK1EwWXd2ZjdxbnhzU0dNcCt0amxnVGNxUFBE?=
 =?utf-8?B?RFFUQVYvSWs1YlBuL29NOVJKT0w1NUp4K0JJNk5neXM3VEVETGlXZ2x6YWND?=
 =?utf-8?B?a3l1V1hrV2VRZU00NXpRNUZxU1JNSC9ndi8rTTVUdHNwQUpBd0RCU3FGcGRz?=
 =?utf-8?B?OTBTWGVxMmt5WlRNSXM5M0xHcnFidkdjL3ZBdzljUlUxRUw0azR5UUdzRTBI?=
 =?utf-8?B?RnUrSUlTVngvNW9vdnhWQnN1YURIaWtqdEdJTXNsR0dOK3RqYlkvSUlia3FH?=
 =?utf-8?B?ZmtqNVExb2ZOZnZmbGN1VmZHekgxQjlQdUIxLzd3NUhUNHR1RjV1STZMdUJ1?=
 =?utf-8?B?ZlA5TGR5dGt3MFZrQlR2azdmL1VsRUdPOEtoZHBiTnFnR2dIc3V3UStYVGtk?=
 =?utf-8?B?UDc1UHBNZkpEOFdzNG1CSmJiVjgzVW9oNWhzR1dyaWxTODd6K2xCMGFMaFBq?=
 =?utf-8?B?TmJrVFFNT3VDMDRURm5KZFJRZXVocVNpWHFRS3VSUWtsVURoN2JrUnovRWxD?=
 =?utf-8?B?eVEzM3NEZjE2Nk1KdW5RdEVqclZsaTZGRHpxMVRsc2pBYUFKNFp3TG1OVGpM?=
 =?utf-8?B?Z3MzSlFoTUhYcHBhVTAzTC9sZmQyc0drc0UxbU1jSUlJYXh1RW9xN1ludWZj?=
 =?utf-8?B?TEZydkNEd0ZDVmh0YlQ0VlNTdVVBbG1lMHpoZnhZUURvT2Q4bEhZYXBvRG1w?=
 =?utf-8?B?Y0R2VG90Wm9CRUM3Q3dZRk5QdUNFUzl6WU8zRll2TkVyMlZjeXZZRFQvQ1pv?=
 =?utf-8?B?NjJpSVY3MW55MTU0eTNLb3JKM3dhM0YrTGk4cmN5RWQvMytEWmZIMlplT2RS?=
 =?utf-8?B?Nm53Um9kaFcyeE9IUU50OFo5cUlVM29uT1YwUlhzek9VZFlXYmY5Q3F0R2JF?=
 =?utf-8?B?V2lwSkluajNwUnp2emh0WC9hL0RkeWlKU3JwOS9NU1VIZ0dUb044RWhQNGpy?=
 =?utf-8?B?a2wwL2xmWCtQdFlVbCt1bi9heUF3VlJpM2FEdzVsOWgwZkxEeStHT0JmOHFX?=
 =?utf-8?B?cGlrWmR0TnlWd1ZBOVdxUlpIQkRtdDNhbTBMa2JySHNQV1F4SE9YanJTNHRy?=
 =?utf-8?B?d2JJNzYyRGw0cjdXMW1EMGc2S0QxY2E1NlNJb0YxeTJPRnMvWkN1L0E0REJY?=
 =?utf-8?B?NVFIYnE5dVRiclBZNmQzQUdSZWpXZ2p2OVdUVVN3M2pJUTk1dVIybkNvY3l3?=
 =?utf-8?B?UDV3MGRXZTN3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVBGeDZFQWxLWDFWNkt5bVlvMGJ0TkE5LzNDZFZud1Y0SkJzZWhoVWRza0k1?=
 =?utf-8?B?eUNxUzlFYkx6UEo4cjBDY1NSa1Vhd215amN5Znl2U2hCbEJHTTdQMEplN1Uw?=
 =?utf-8?B?OGVnNExCMWw1VzB0NzIvSWhTOUlmWkpIS1V0VnpCd2RweXNiVlNqOGgwdVBI?=
 =?utf-8?B?UnlLbVYxVFRsdHBGemw2TU1jWDVCWHMwYXVMTUZ0YUNZMHdYcjgrbW9TdC9s?=
 =?utf-8?B?ZEM3Y1ZiQ2w4T3dpMU9rYlo4QkVJdHdzZ3h1QzNEWlpIZnFBcFhnejdFMlpp?=
 =?utf-8?B?d1pKdnZuNlZKbFY5UjFBMS9pc1NxSGM5K3U4SERSdnVPeTg3cWpQRms5SFVv?=
 =?utf-8?B?QVNXS3NZbmdSRnk0emJ6VitTell0aFpqbCtlOVBhMTE3WEtOYTJIM2dkMk9Q?=
 =?utf-8?B?VmZ0eW82SWZ3TGxSNDVWT1p4MkdDciswbXdlMExHT05DUzNzN2NUYXNLVWMx?=
 =?utf-8?B?ZFlqamVJd0pvRzNZVElpZDE0bEl6OFZNbXFkNXFENy9Jc1Z3KzVLWnpJaXBP?=
 =?utf-8?B?a1VQcm5Wc2lsSWZHYWNWSUJHMVJhemp6QWtxTlVWOHFuRjU4MDIzUGJMY0tL?=
 =?utf-8?B?ckpGTGlXZGpLQmNpdkVvRFk5WFlMcjNJeGlLTFc3MHJJUWgzd2VmMVZya1dF?=
 =?utf-8?B?T3ltcEwrK3BEcitGREQxQm45SVp6ZDdQWDdoK0cvY1dSbTlKVG1PU1c5Y25v?=
 =?utf-8?B?YlV6QjB5KzlkdktDc1U1N0ppVS92eTJxL2wzc1R5cTVHODVJSEloYW1iUVV0?=
 =?utf-8?B?SEdURVFmOTZsTnkvV2VGVWFGdUFXWnA5TGMrOXZCQzVzOW5ac29pL1FsYzg3?=
 =?utf-8?B?Wlp6RlpqemU4M0Vhak5SM01EODhxSGhpOHdhMFgxRVZhVnJLbGxWcGFLdUd3?=
 =?utf-8?B?Ny92Y3FTbkVTUXlldnRFa1hXbC9zN05FTUlSL2VBdU9EVGkxTE1rZWE2Kzda?=
 =?utf-8?B?V2V1S3pDMmRYTlJ6ekV4NmRNUzFZbmc3MWV4ZUNZU3NaR3l1U0pjMXh1Qm56?=
 =?utf-8?B?RDFCLytxeGVkMzJISG5yOC9wWW1ucTR5OVcxM2FpbUJ3UHA3bVdoNHM0b280?=
 =?utf-8?B?cHhLTTZ3MDRYRkdoVTNHWWo0K3ZRSmM4Ymx2SzBRYndoV1pueFFHcHBFK2Nz?=
 =?utf-8?B?dnQ5WFFoUWpMUndwaHQweWg3TGUyejZPSlgva0hpdk1Sb1RLQTJHOWtOVFcr?=
 =?utf-8?B?WDVtd1lQSWJ1L2ZUYlc3ZmlwTitQdEZKdks2Q0M3TW1PL091YkhWaEEzMXp0?=
 =?utf-8?B?b3FYMFV5c2IrL3FpSmFzTlpTOGlQL2JnUUlvUjJnWm9GUXVxK25KbGtMUzRN?=
 =?utf-8?B?dm1DUllWUENPbTNSTm5FeCtWNzFwdlNjM0docnZOVUp1SWN4R0lCLzlPSHRw?=
 =?utf-8?B?ZVRmc2plc09qZmg5RFNaSnlMcWtGSStFZldyRElPL1pVWjZ6bmtRL1Z6STJ6?=
 =?utf-8?B?eDRobGZiN2FYcGVrM0NsK0FQaWNPS2s0bFZySHlsaTR3cjBxUzRhL1FUWGhh?=
 =?utf-8?B?NWl3dzlkZ1ZUeUtiZDUrNm9iUWZlSmlJUGh6NWZ2RXlFcktqYTNTcVV5QVhm?=
 =?utf-8?B?SGEvcVlzdXJOU2gwWlJIaXpjQ1ArWTNkV3EreDQrZlkyNGNIbWt3S25lTm81?=
 =?utf-8?B?RHJEei92aGZwKytVSGJ6L2ozUm1GUlV2YSs5UWRFRlI5TEhLdjMwaUYyVVRT?=
 =?utf-8?B?RG5wVHg0T2NxYmhkNkJ1bE5FNHN1ckRNVE5TNHVWMmtsK0lhL1hnR0kyTjVS?=
 =?utf-8?B?MEZpWWQweFNRTVZkVFRreVNnZ0tNRGtVajR1NkdhSS9DVmZtNjFxK3N3Uysr?=
 =?utf-8?B?ZStsc3Q4OGd1ZWRRa2xJTFNTK0lnZ3lsK2NuYUgvTzVDYWVOQUVSOEJjcEhn?=
 =?utf-8?B?WTRFdmJUelU1VHlaV1duVnVHRTZ0NU9vcHZTUFlWYjllNGZIV1duejVJUkN4?=
 =?utf-8?B?QXFZUkxNZnMxN3dOMUFQNkxLeFdHMWVEMEpVRmJ3U2o4VnNzbC9GbUFGOC96?=
 =?utf-8?B?VUp2QmY2cjdJdHlZTlFQMXJPUlBDSzBabjhrNVNnaWh4OGozR05ZUDgzV1Ur?=
 =?utf-8?B?ZUg1OUdORGpXT1JtK0ZvUHA2RmJwaHE4ZFIzcndsMTBKd0xOYUNwd0ljalAy?=
 =?utf-8?B?NUhWSE5xVXNia3ZYbEw4OW9KdzhBWnJValBEQ0ZHM1hkWmpQanZiTlFabTJ2?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6D1698AFA4C4245A60E48408415BE2E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a45539f5-5429-410e-f377-08dd992341e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 11:24:46.4364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIOOZ7KRK8t3MMKrzjFc3pw20RvDdENzlq0s94qOfUKBKJis1nxwjohWgp8iiSqU5OLRd3UJsPepbotM3YGCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7190
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 May 2025 11:24:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17630

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDEyOjEyICswMTAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDI1LTA1LTIxIGF0IDE4OjMzICswMjAwLCBTdGVmYW4gS29jaCB3cm90ZToN
Cj4gPiAtIFNpbmNlIGB1ZC5wYXRoYCBjb250YWlucyBpbiB0aGF0IGNhc2UgdGhlIGBQUkVNSVJS
T1JTYCBwcmVmaXgNCj4gPiBwYXRoLA0KPiA+IMKgIHRoaXMgY2hhbmdlIGVuc3VyZXMgdGhhdCBh
IGNvcnJlY3Qgc3ltbGluayBpcyBzZXQgdXAuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU3Rl
ZmFuIEtvY2ggPHN0ZWZhbi1rb2NoQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgbGliL2Ji
L2ZldGNoMi9fX2luaXRfXy5weSB8IDUgKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9fX2luaXRf
Xy5weSBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCj4gPiBpbmRleCAyZGU0ZjRmOGMuLjA1
MjUwNTQ1NiAxMDA2NDQNCj4gPiAtLS0gYS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+ID4g
KysrIGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiA+IEBAIC0xMTE3LDcgKzExMTcsMTIg
QEAgZGVmIHRyeV9taXJyb3JfdXJsKGZldGNoLCBvcmlndWQsIHVkLCBsZCwNCj4gPiBjaGVjayA9
IEZhbHNlKToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9y
aWd1ZC5tZXRob2QuYnVpbGRfbWlycm9yX2RhdGEob3JpZ3VkLCBsZCkNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIG9yaWd1ZC5sb2NhbHBhdGgNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgICMgT3RoZXJ3aXNlIHRoZSByZXN1bHQgaXMgYSBsb2NhbCBmaWxlOi8vIGFuZCB3ZSBzeW1s
aW5rDQo+ID4gdG8gaXQNCj4gPiArwqDCoMKgwqDCoMKgwqAgIyBUaGlzIGNvdWxkIGFsc28gYmUg
YSBsaW5rIHRvIGEgc2hhbGxvdyBhcmNoaXZlDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBlbnN1cmVf
c3ltbGluayh1ZC5sb2NhbHBhdGgsIG9yaWd1ZC5sb2NhbHBhdGgpDQo+ID4gK8KgwqDCoMKgwqDC
oMKgICMgV2hlbiB1c2luZyBzaGFsbG93IG1vZGUsIGFkZCBhIHN5bWxpbmsgdG8gdGhlIG9yaWdp
bmFsDQo+ID4gZnVsbHNoYWxsb3cNCj4gPiArwqDCoMKgwqDCoMKgwqAgIyBwYXRoIHRvIGVuc3Vy
ZSBhIHZhbGlkIHN5bWxpbmsgZXZlbiBpbiB0aGUgYFBSRU1JUlJPUlNgDQo+ID4gY2FzZQ0KPiA+
ICvCoMKgwqDCoMKgwqDCoCBpZiBnZXRhdHRyKHVkLCAnc2hhbGxvdycsIEZhbHNlKSBhbmQgbm90
DQo+ID4gb3MucGF0aC5leGlzdHMob3JpZ3VkLmZ1bGxzaGFsbG93KToNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnN1cmVfc3ltbGluayh1ZC5sb2NhbHBhdGgsIG9yaWd1ZC5mdWxsc2hh
bGxvdykNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHVwZGF0ZV9zdGFtcChvcmlndWQsIGxkKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHVkLmxvY2FscGF0aA0KPiANCj4gSSBndWVzcyB0aGUg
b25lIHByb2JsZW0gaGVyZSBpcyB0aGF0IHdlJ3JlIHRlYWNoaW5nIGEgZ2VuZXJhbA0KPiBmdW5j
dGlvbg0KPiBpbiBfX2luaXRfXyBhIGZldGNoZXIgc3BlY2lmaWMgaXNzdWUgOi8uDQo+IA0KSSB0
aG91Z2h0IHNvLCB0b28uDQoNCkFueXdheSwgSSBoYXZlIGRlY2lkZWQgZm9yIHRoZSBzeW1saW5r
IHNvbHV0aW9uIGZvciB0d28gcmVhc29uczoNCi0gdGhlIFBSRU1JUlJPUlMgbG9naWMgaXMgaGFu
ZGxlZCBvdmVyYWxsIHdpdGhpbiBfX2luaXRfXw0KLSB0aGVyZSBpcyBhbHJlYWR5IG9uZSBzeW1s
aW5rIGNyZWF0ZWQNCg0KPiBJZGVhbGx5IHdlIHByb2JhYmx5IHNob3VsZCBoYXZlIHNvbWUgZmV0
Y2hlciBzcGVjaWZpYyBmdW5jdGlvbiBjYWxscw0KPiBmb3IgdGhpcyB0byBwcmVzZXJ2ZSB0aGUg
aW5kZXBlbmRlbmNlIG9mIHRoZSBwYXJlbnQgbWV0aG9kcy4uLg0KQW5vdGhlciBvcHRpb24gSSBo
YWQgdGhvdWdodCBhYm91dCBpcyB0byBzdG9yZSB0aGUgb3JpZ3VkLnBhdGgNCnNvbWV3aGVyZSBh
bmQgcmV1c2UgaXQgaW4gdGhlIGdpdCBmZXRjaGVyLiBUaGVuIHRoZSBhcmNoaXZlIGNvdWxkIGJl
DQpzYXZlZCB3aXRoIHRoZSBjb3JyZWN0IG5hbWUgaW5zdGVhZCBvZiBhZGRpbmcgYW4gYWRkaXRp
b25hbCBzeW1saW5rLg0KDQpRdWVzdGlvbiBoZXJlOiBJcyB0aGlzIGZyZWUgb2YgYW5vdGhlciBz
aWRlLWVmZmVjdHM/DQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBSaWNoYXJkDQoNClJlZ2FyZHMNCg0K
U3RlZmFuDQo=

