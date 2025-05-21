Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E62C2D0CD
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 16:34:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.58])
 by mx.groups.io with SMTP id smtpd.web11.3594.1747845288837584117
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 May 2025 09:34:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kI6uvIVu;
 spf=pass (domain: siemens.com, ip: 40.107.162.58, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfSCNLQTEu44+VpNCcOCbsD4DoGg+EWGdQCT/KYLtlrb0aGEEyccS1McA+cScOdSmkjaNp5hW3ywQoQvjuGnwbS4/0Tlkxrm9MddQwQttpN16URRcaZvef/m8JTHjS+fTaL52TF6XvPsL31MgTC4mWjFvUoBK2MOL9AhAfJbU8maJXafD8wG5R+pM9kunudlRBcib1eBqCULSPfnsc2raVk9k9af32OzhJilbYucjDbFmO1pFIJNnPsCKVnro/qp1BVU5s+17WIG77/1TQbL00zcrn2sDjL03N/xVP6rlsrw/77L71SbLsPI2J+rteI0F0pWMcom8jgs6fP6wZ8xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpt0OAvhjKrnkBDvG3vYNfZ4yaaCJ5oc4MFI9Gum5xo=;
 b=cm0vdXj8nBRxm3++7x87Ner6/xfEXUxp9RCuW2uHI8ZvWsq0Felr+ospWGGOZFceC/VMPidEUCYPLVUjbt/aWoFY+pdrf7wuUO4XmCmt0i4pqHU1o7IiYgU6OfR/eMFagqcfoEKwI3IzSjNNCcmEJ54tJF13bsn6nRvpvvgEsBM1Jg6Rv/qCMYkGK30WeB0aYsGBmPOUnszq5hfo+AZ9S9JHDGk7wpf4V66KgXvMxcnMFA2eaQw8LdRiQVkw29G6NquzqIQ14n+/GXbr5LjP0GHyGiBAwqokIQrKyTRKem7NMei1kHlMOQ9NNRTkfHlshkmYljP1b3jLdq4wNKnfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpt0OAvhjKrnkBDvG3vYNfZ4yaaCJ5oc4MFI9Gum5xo=;
 b=kI6uvIVu/K+l4+g8iP8xyvQylCMosdJZAKRmxjP8NfYLIoU4auwMh3Gl91Zh7NB8BcC0pQNNQb00J5EKb8TnlcrYhNe1Q4fYs7f9T4mjjHxNWcWU1I82+JMtXBeeoSd57zBis1t4XfUHdLEwU5aknKDVEP6aGAjhJUsxn47LtNE/xms/ZKtQRs2ozJzcPUZEwVmRmV7taHq0L05cMliVyK7+nWuCMfKvWzoGjrgN8ctA3eKa9j+eA4Wo5c7M1O/3865/d+Y24HoBAZDPdf2HRyb67MvZw2el3ddwVAy4xz8vpP82ksTQkzAv5N62GsoDf5EEmdPyJVnmTHmCz0wGZQ==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by PRAPR10MB5346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:298::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 16:34:45 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 16:34:45 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "mathieu.dubois-briand@bootlin.com"
	<mathieu.dubois-briand@bootlin.com>
CC: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	"docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
	"niqingliang2003@gmail.com" <niqingliang2003@gmail.com>, "Sudler, Simon"
	<simon.sudler@siemens.com>, "liezhi.yang@windriver.com"
	<liezhi.yang@windriver.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: Ensure a valid symlink in
 `PREMIRRORS` case when using shallow cloning
Thread-Topic: [bitbake-devel] [PATCH 1/1] fetch2: Ensure a valid symlink in
 `PREMIRRORS` case when using shallow cloning
Thread-Index: AQHbyjBr5uC9jnSOSEu7DMP/t/AL/LPdJyEAgAAhAgA=
Date: Wed, 21 May 2025 16:34:45 +0000
Message-ID: <cc92d501b9da487681b4c6195af90e97393ffb22.camel@siemens.com>
References: <20250521091153.2445853-1-stefan-koch@siemens.com>
	 <20250521091153.2445853-2-stefan-koch@siemens.com>
	 <DA1WXIN1ZNNJ.8GK9QFPZ4HKI@bootlin.com>
In-Reply-To: <DA1WXIN1ZNNJ.8GK9QFPZ4HKI@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|PRAPR10MB5346:EE_
x-ms-office365-filtering-correlation-id: fe5dd719-f648-475d-4fbd-08dd98856579
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|4022899009|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Ly9ZM3MzaU9sWExNUE5kQ0dCZUx1bGRJY1BSdlZYeStNRkpvaXZMb2c0bVV3?=
 =?utf-8?B?RVNQclJLTjVhVml3c2ZYcG5VZVJKTDJvMFBaNEk5S0pCSUl5QWplbkQyMGJp?=
 =?utf-8?B?dEFKUDFXZFRlUHgyd3U0VFAyWlN3OGlNMkk0Tm9nODdVdVBacFVRSzdycnoz?=
 =?utf-8?B?ZUNvTWZ0d1FjZ1JaVEtWMnNTZzFDNXozcW9nNGcxQ3M3SUFGQ0wrVmVKdDR4?=
 =?utf-8?B?ZGtEaUo3VWtMc0cvYlRGaXNlZnVsYXluajFvYVUreW9yMk5tMklwbnJMdVVW?=
 =?utf-8?B?eXBCTDhCTCthNFR2a3hjQzdPOVRhVmUyZGM1WGhjQTVycDhHekVPZUVmYXpG?=
 =?utf-8?B?ZkRCMkdpYjNuYUw4MmNQTy8ycFFFV1I4MG44ME9UTCs3aWlWK21rci9yK0lo?=
 =?utf-8?B?NmVMdElaVVlRNkwwRkJEblRzN243OEhORUJmcml2NHBCTW5tWCtpckRqc3px?=
 =?utf-8?B?YTlyVW14c1FEZ1dDWExUaGlVejVYMUE5TXVYWXBBdDZWTmhvVmhtVk5DcWFu?=
 =?utf-8?B?SmVTam5xbVhlSHF3T2dQU1pjZXVGdTAwd0NFcUhCNXBleGg1ZmxZbmxVVUl5?=
 =?utf-8?B?dDlrTE5Wbk1WRnR2TVd5eXRjNGJZRENqc0VBQk5HbE9PUEhkWmt1ekFza3dx?=
 =?utf-8?B?T1N0TjJ1MVBjd0dkWUlTcUl6WmFKTWx4YVVXZWdNRFZETDhFRkhxM2pzNzdr?=
 =?utf-8?B?bTlnS0dRQS9ONnYrWVB2RzFvTm1BaWhwenE3M0hmN3hqSzNvK1JtNDNTT1FX?=
 =?utf-8?B?YitaR1pRUCtmanh6aytoZ2h6ak51ZGQvdjhwNDFCaUVWc0VGYUxsekxRS1pz?=
 =?utf-8?B?ODUrL1VDSVRjbUM4NnBNZi90a3IxTENpYzBaZjRoODJuSXBWUTVtaHlSS3JQ?=
 =?utf-8?B?a0x2Vy9iVVg0ODBCaU5lN0h0MzdidzBhUXBWTkNSeWM1VEc0cFhwMFcyY3U0?=
 =?utf-8?B?REgzOFpSbWcxSVI1cERwYzVSVU9YUVc2ZUtpZzArZFAxcEkxc09IeFFMdTkv?=
 =?utf-8?B?Y3Erb1crMzhMMjJDV3RZRGtSZ1dkTnU2cmo3K3hlUVNVNVJlNzFHYzlXYWVK?=
 =?utf-8?B?R1IrY21QT2QzYTZJb0M1UjV6STZUUitVeWpVMkhVbTFLS0tHNUxlMWM4cVV2?=
 =?utf-8?B?S0UzOGdJT2RZT1Z2OE1OZ1FXVnZSb0pxVkNMMUl6cHVKOVJKU3R4OHFIeTVR?=
 =?utf-8?B?dEFOUVZqdnNuVFBvZ2hQMnBuTDlzckEraTZYdmZaT2E2L2dXazgvMy9DaWwy?=
 =?utf-8?B?Z3BKa2p5L3FEdis5N1Z4Slc4aVMvd1dsUEhsTU8vSVRCOFYvSEI0REFKUzdQ?=
 =?utf-8?B?aEZjZnV0MTBoSVFsenJxM3B0REdoM3Q1cVBDc1VGVHFUVVdqZVRPQlg5S0Ro?=
 =?utf-8?B?RGM5NlByYS9XcGNxUysybWttM1I4aVExSWY5ZTV6eUVOMXZLQ3FqTTdNSE1C?=
 =?utf-8?B?OTZwOEpoVDB2ankvWndsci9aM3ZmMTVIT2tGc3ovaHlKNVNQQ1JDQ0xEdHQw?=
 =?utf-8?B?THJndmMyUUtCQlZRTHNMdUU0djVTMlpiakt2dVNQWU1YUlRMQ3ZWSkh4d1ov?=
 =?utf-8?B?NzFoSEdlR3JWcExldVBnVUs4eGRLeFBGK0dhY0xpdEVncTJ5cCtOclVOTGoz?=
 =?utf-8?B?Z29jenVjZDljMkhBWUwzSDZhNnM4N1pjVXJLK1ZjVEVCeE1rdW5HRGNMTjdL?=
 =?utf-8?B?OEVXNFVTcDRzRm10ei9RUitVbGlaRnliQmNwUDduTitFV0ZMRXg2OGF6aldV?=
 =?utf-8?B?RkIzbGlLejZTS2N2NjNRV3pvUDUyMEF3RnFQR1VYOEM0TFNxdkRmaloxYWhM?=
 =?utf-8?B?UGl6R1lFdUdhVEh6WGFsaEtxclg2WGRVSExKSVowYU12MzhzcUUzeDBoazd0?=
 =?utf-8?B?dlRNKzBOZGJ2RnVjU3VIV0JVQ21uSTRxVkM1MlE3Z3M4ZkZYN3QrT2VnSjV4?=
 =?utf-8?Q?CDPIIKseQhA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4022899009)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eVpyN2M4dkFncEI4U0s3UVN5dzhEQUExZk0ycUFtRjk1MmpweFE4WmJpS1dn?=
 =?utf-8?B?UHQ4K2RKWmVLNUFQRXYwbmU2aG1ONzlzU0FWUnFPcmtuaEtjdFVNLzNLOSt5?=
 =?utf-8?B?VzQ1ZHJQTFU0c2c3ajVSTklzZE13QW9hcEFnMktpREZZcXZnL2RaTFk0aE9Y?=
 =?utf-8?B?MUxqTXNHMWpQUGFOa0lwZGJ6VmlRYXFleWI0Nk5ab2owRHNmYitJL0NwSU94?=
 =?utf-8?B?enRVOGJjYWg4SkNsa0RPWVdQdHNXcFFrRmtselFxclRlVEcxTUxDQVY2SGlh?=
 =?utf-8?B?L0wxVkhlS1hCWUt1YTNuOVdtbXhWa3MxVURoSHRmWnhSU3FrSnZXdVltWFRp?=
 =?utf-8?B?Y3lzZ2UzOE5BdXVXUXYwMkF3bWUzU2pXZGFIUDc1SWg5U05nTldQNmgwYzRz?=
 =?utf-8?B?OXJaaTU5R2xmalA5M0Z6Z1owb25NTXM4WTl5dEUwVjBQY012VFBhNG1qMWR6?=
 =?utf-8?B?SjJxWEFadSt4NXREVG5KeWdSZXF3dWVaSjlrSTdVQnFmR0dTWTUxTGVrZmpT?=
 =?utf-8?B?bWFXRy9CSUswcTRkMytPYmVtekVuNGllZHV2ZTYreHF0NHVjWk5xRTVvdk1y?=
 =?utf-8?B?SWJOM2RNc0NXeVdFK1ZGQ3hoektWYlFtUmJIVmlHVzc4LzVLMlF4RVJPMFlr?=
 =?utf-8?B?ak5Va2hKSkxtZnN4MFZ6NkxpNEk0RHV6dWVjZ1hUcXZ4UG00KzZ6N3lRbEZR?=
 =?utf-8?B?V2hFS0NUQjJ1OXlTVXhGanRJUURqM1pvSUg3YVI2c1Zja1p3Rm5zYStzdWlX?=
 =?utf-8?B?NmFKOUUxdUpFeUhFT0JqSTFGTER6dkZrQ2cvWFZzTDJlb1o0bjl5T1RKQUtq?=
 =?utf-8?B?LzVscEVHc3I3a2Q4TndUMmpmcXBOSlUzVndQU0Mxam1CcTJIOWZCbEx5U0o2?=
 =?utf-8?B?MjZQYVdEUnF6blRWK2h4N1NlOHhCS0dNWDFuTDE1bVNhMlV0ZDliQnNCeE53?=
 =?utf-8?B?dStqa1pYRUk4ZWFmU3l0TXExenJXSlNza3RGdTFqbTFOc3FIakE4bVo0Um8v?=
 =?utf-8?B?NzRET0k4TVduT3ZlM24rbzdIbDhya2s2NXlsOUxMS0M5bTlvR3NpbEl1c1ll?=
 =?utf-8?B?VDdEUm1lb05FeXV3dHowc3h1Rk9kVzNKN3Q3OEM0dFBURU5yY3lWVUtSSlNv?=
 =?utf-8?B?a3Q3UzZ4SmlNVkRXZGZsZlQ1NGJXV0lKREorbDRMZW9zL0VwbUhKUTlIK0xW?=
 =?utf-8?B?OHVBU0I4TzM5bm14azhGT3J1VHp2OFhUM3ZqcUdZeEt0MXNRdFV1V1BXZThH?=
 =?utf-8?B?TU5LZmhXQmk4N0hEbk1ZNnArSHRxMktoYlZ6L0drT1FQV2cybEQ4ei9TQTVU?=
 =?utf-8?B?WGprcHZySkZvSXVvVlVUaUpBU081Yk1McWRwL1JXM04rVTkvQXVBbUYrb0R3?=
 =?utf-8?B?YXU2NmZGQjlqV2gzODBKNFJncVlEdlJ0Rnk4MUE5ckVXWWhqU0NhU3ZUbzJI?=
 =?utf-8?B?NGN4THVBdEtnaXBaRERPTDNFcU51K1VKSWE0WUY4OXBXUTVGMzVHWE9kYklQ?=
 =?utf-8?B?VnhucXRLMWtuNm80eWdLdGg0U1U2N0dDemtGZ3graUFPU0g3cHlwUDMzUmly?=
 =?utf-8?B?eE5nRVhwLzdsSjQycWhZRThXcGRiL1RqMFdiTTZPbFJuZlZXS2ZTWFd0bXJk?=
 =?utf-8?B?TSs5b1paamlhMHVoTWI4K2FKYlAwL2ljL1N4MkY5Z1BUUGRzUmpKamQ5SjZs?=
 =?utf-8?B?K3dKek5CVUc4WjNvaU1LdmhsU2hWSm1BNmtBR2hOOFZyNkVrc09sSGh4b0g4?=
 =?utf-8?B?YmJqb01qcWh6UWxQd0sxanpFajMzNVdaQngrbEZrYjdvY0hHV25KYzVFVGMw?=
 =?utf-8?B?cFE1bGtBQ1RRK1ZJU0NKME8vZVZFcW1JWk9PMGhrS2Nyak1PTlY2MVVqVjZT?=
 =?utf-8?B?Z01ncXhidUdYQVl4QmFiQXRTS0ZrWWVJU2JkRk8vRUdkcjdmSldKT1gxaWpM?=
 =?utf-8?B?MEMxdXNPTm5XTFZPM1FXK0ZyMjFCS2lsOXBtREtzVkEzMnlGcit4MkovU0Zm?=
 =?utf-8?B?aHU3cDh1NFl4aDBWbTA0eWgwQ2Q5VTYyT0lFUTE1RTZuSGhDYlRPZS9oYWx3?=
 =?utf-8?B?V0hYTFVXYUcyd0V0QWZYN0xUMUlmYXZDZ3RiclJHYzM1U3hsTjU2NDZDZ0NZ?=
 =?utf-8?B?VUhHZ0JlWmZYdThJa1VwNkRmRGticnprUFZHMkhtU3FlZkx0NFU5MjlMelE5?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6191CCFA6D6D324BA9D9DB1264C83B44@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5dd719-f648-475d-4fbd-08dd98856579
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 16:34:45.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1RDL28ac0Z2JN1FY2crKOpDWLIWN6vF25abmgfWD6EcTvDAH1+HXNZD+pAdj74SJ2FcAh1dazH7Vz4UAoBy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5346
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 16:34:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17628

SGkgTWF0aGlldSwNCg0KY2FuIHlvdSB0cnkgUEFUQ0ggdjIsIGFnYWluPyBUaGFua3MuDQoNClJl
Z2FyZHMNCg0KU3RlZmFuDQoNCk9uIFdlZCwgMjAyNS0wNS0yMSBhdCAxNjozNiArMDIwMCwgTWF0
aGlldSBEdWJvaXMtQnJpYW5kIHZpYQ0KbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToNCj4g
T24gV2VkIE1heSAyMSwgMjAyNSBhdCAxMToxMSBBTSBDRVNULCBTdGVmYW4gdmlhDQo+IGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgS29jaCB3cm90ZToNCj4gPiAtIFNpbmNlIGB1ZC5wYXRoYCBjb250
YWlucyBpbiB0aGF0IGNhc2UgdGhlIGBQUkVNSVJST1JTYCBwcmVmaXgNCj4gPiBwYXRoLA0KPiA+
ICAgdGhpcyBjaGFuZ2UgZW5zdXJlcyB0aGF0IGEgY29ycmVjdCBzeW1saW5rIGlzIHNldCB1cC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBLb2NoIDxzdGVmYW4ta29jaEBzaWVtZW5z
LmNvbT4NCj4gPiAtLS0NCj4NCj4gSGkgU3RlZmFuLA0KPg0KPiBUaGFua3MgZm9yIHlvdXIgcGF0
Y2guDQo+DQo+IEl0IGxvb2tzIGxpa2UgdGhlc2UgbW9kaWZpY2F0aW9ucyB3aWxsIHRyaWdnZXIg
YW4gZXhjZXB0aW9uIGluIHNvbWUNCj4gY2FzZXM6DQo+DQo+IE5PVEU6IEZldGNoaW5nIHVuaW5h
dGl2ZSBiaW5hcnkgc2hpbQ0KPiBodHRwOi8vZG93bmxvYWRzLnlvY3RvcHJvamVjdC5vcmcvcmVs
ZWFzZXMvdW5pbmF0aXZlLzQuNy94ODZfNjQtbmF0aXZlc2RrLWxpYmMtNC43LnRhci54ejtzaGEy
NTZzdW09NTgwMGQ0ZTlhMTI5ZDFiZTA5Y2Y1NDg5MThkMjVmNzRlOTFhN2MxMTkzYWU1MjM5ZDVi
MGM5MjQ2YzQ4NmQyYw0KPiAgKHdpbGwgY2hlY2sgUFJFTUlSUk9SUyBmaXJzdCkNCj4gRVJST1I6
IEV4ZWN1dGlvbiBvZiBldmVudCBoYW5kbGVyICd1bmluYXRpdmVfZXZlbnRfZmV0Y2hsb2FkZXIn
DQo+IGZhaWxlZA0KPiBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQo+ICAgRmls
ZSAiL3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL2J1aWxkLQ0KPiBhcHBsaWFuY2UvYnVpbGQv
bWV0YS9jbGFzc2VzLWdsb2JhbC91bmluYXRpdmUuYmJjbGFzcyIsIGxpbmUgODAsIGluDQo+IHVu
aW5hdGl2ZV9ldmVudF9mZXRjaGxvYWRlcg0KPiAgICAgZmV0Y2hlci5kb3dubG9hZCgpDQo+ICAg
RmlsZSAiL3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL2J1aWxkLQ0KPiBhcHBsaWFuY2UvYnVp
bGQvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IiwgbGluZSAxODc1LCBpbg0KPiBk
b3dubG9hZA0KPiAgICAgZG9uZSA9IG0udHJ5X21pcnJvcnMoc2VsZiwgdWQsIHNlbGYuZCwgbWly
cm9ycykNCj4gICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eDQo+ICAgRmlsZSAiL3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL2J1aWxkLQ0KPiBhcHBs
aWFuY2UvYnVpbGQvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IiwgbGluZSAxNjcy
LCBpbg0KPiB0cnlfbWlycm9ycw0KPiAgICAgcmV0dXJuIGJvb2wodHJ5X21pcnJvcnMoZmV0Y2gs
IGQsIHVybGRhdGEsIG1pcnJvcnMsIGNoZWNrKSkNCj4gICAgICAgICAgICAgICAgIF5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gICBGaWxlICIvc3J2L3Bv
a3lidWlsZC95b2N0by13b3JrZXIvYnVpbGQtDQo+IGFwcGxpYW5jZS9idWlsZC9iaXRiYWtlL2xp
Yi9iYi9mZXRjaDIvX19pbml0X18ucHkiLCBsaW5lIDExOTIsIGluDQo+IHRyeV9taXJyb3JzDQo+
ICAgICByZXQgPSB0cnlfbWlycm9yX3VybChmZXRjaCwgb3JpZ3VkLCB1ZHNbaW5kZXhdLCBsZCwg
Y2hlY2spDQo+ICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eDQo+ICAgRmlsZSAiL3Nydi9wb2t5YnVpbGQveW9jdG8td29ya2VyL2J1
aWxkLQ0KPiBhcHBsaWFuY2UvYnVpbGQvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5
IiwgbGluZSAxMTI0LCBpbg0KPiB0cnlfbWlycm9yX3VybA0KPiAgICAgaWYgdWQuc2hhbGxvdyBh
bmQgbm90IG9zLnBhdGguZXhpc3RzKG9yaWd1ZC5mdWxsc2hhbGxvdyk6DQo+ICAgICAgICBeXl5e
Xl5eXl5eDQo+IEF0dHJpYnV0ZUVycm9yOiAnRmV0Y2hEYXRhJyBvYmplY3QgaGFzIG5vIGF0dHJp
YnV0ZSAnc2hhbGxvdycNCj4NCj4gaHR0cHM6Ly9hdXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3Jn
L3ZhbGt5cmllLyMvYnVpbGRlcnMvNzgvYnVpbGRzLzE2OTgNCj4NCj4NCj4gLT0tPS09LT0tPS09
LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRo
aXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTc2MjYpOg0KPiBodHRwczovL2xpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTc2MjYNCj4gTXV0ZSBU
aGlzIFRvcGljOiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbXQvMTEzMjI2MjAyLzc3
Njc3ODgNCj4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3duZXJAbGlzdHMub3BlbmVtYmVk
ZGVkLm9yZw0KPiBVbnN1YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3Jn
L2cvYml0YmFrZS1kZXZlbC91bnN1YiBbc3RlZmFuLWtvY2hAc2llbWVucy5jb20NCj4gXQ0KPiAt
PS09LT0tPS09LT0tPS09LT0tPS09LQ0KPg0KDQotLQ0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcN
Cmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo=

