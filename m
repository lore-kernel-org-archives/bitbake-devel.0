Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2780AC02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 12:46:25 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.32])
 by mx.groups.io with SMTP id smtpd.web10.39771.1738845974457010662
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Feb 2025 04:46:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vs6EBRsw;
 spf=pass (domain: siemens.com, ip: 40.107.159.32, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JACm8qp+f2Yccr3hUDHDSGlVqeRDBhIE6HTMINDAZEng13CLzivedQ7kL3v7uRn/791MtPz/bC7sb/DYzp2AmTx+1/Ko3Uu0rUTfjOKJ5bSNWk9xIM+DxRUH7YjXQxZ6suBRcRh4095+zWKlY2uuMXj6p8s5T96VNbkkx9WwryFH64HmiyVChRyKBScoGRQqg9pGVMdTsDCNr7F7ljtFfGbhnxLObzgP+BzgJGszmdzMzw33EPcY/16mZpsYQqGCiK7idMyMNF7gOoQ7VVKhojbSPk5wYAK40CP8NrqXl8VF1VowG9Y0j8lmReE6K2GzqnJaDN2tj3MSjpSf3Whdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey2uxsYvQ9XOFFZtwG1+FgggVmCWtD3e0Jp+77dwY3s=;
 b=lzQZ0ALN6l9BKHQfou3KWC0UVtzMEWxqhZYnW9OpUuO+qdQhEG9DZMTFPfiCpnrGUENPseqkiJUzjzC+ifvM2cBYFaJKuSlNBOhEbaWrYky4ND5ZwEqF7OSQ7UJQt5ntdksBdRK2B1ferR/vJOUPMptHmUpIwLmVs/W7njMTMP6V6sX5s6j4HHPvYq96D+8zPOpFgvOOF65h1zqneP6VJ1Agfz/iutACSty+00syKQ5bBBtIQkvfHgwB6cqt1m0jfVpAZg1ezAeKengvQZ9b0R2X+5qaop8YOb3BUONiuEVyrvmTjo9G/LzP+AcEOyeA+x0QXywk2xUzVzayz9vZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey2uxsYvQ9XOFFZtwG1+FgggVmCWtD3e0Jp+77dwY3s=;
 b=Vs6EBRswxuCc7Ksyz5oZyjvS5y8Q8+jLpBeZ06CekUymEKkEooqEwJkyMVDMbHBgRRslaonQIRRUAlRnO9BT0nTgz5wQPKgO4iNRj7I05RMR1p0BCakUg3g706g/vmGMRZw/nsi6KBMOWdF2t6zqZ1maZmA3/jtObhthqTRY0R72qvIStwzrY/nzgA7hb+cDEWl14K56TDibzJqRB4svvjWgtnEfEVu8FhRfUV4EFHGgv+WZqgsk3e1Y+HVH3vF0S4fGU4Sge/XcBFlK8IPHZNA9ZoeC+lGMBXr5ZRjrI8T9oWcy8vLE3KyyQLhEwKjoY0iVHrMQLtrNnErj7yk0FQ==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS8PR10MB7897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Thu, 6 Feb
 2025 12:46:10 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8445.005; Thu, 6 Feb 2025
 12:46:10 +0000
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
Thread-Index: AQHbckBcVUO+dTVsdky5SYefwCaJwLMtvIUAgAyJKoA=
Date: Thu, 6 Feb 2025 12:46:10 +0000
Message-ID: <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
	 <20250129112406.1660522-3-stefan-koch@siemens.com>
	 <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS8PR10MB7897:EE_
x-ms-office365-filtering-correlation-id: b48cfea3-d016-45e6-d63c-08dd46ac3bb3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SjFScFR4eURHazF0bDNLZ0VJRlZjQ21kMzk4RG8zalVPWjJWbTdyQjRjVC9J?=
 =?utf-8?B?SkhrTDlpZG1nbmkvQ3hRT251Y2F1S3ZOQXBlMmJyOTQ2dElLUXI2SmJUTmVo?=
 =?utf-8?B?bkRqdnNGK0w4S29URVd6d2tlRHFGQTB4Z013UjlQUllOOXlETHJ1WktkWUVu?=
 =?utf-8?B?SllPS2FVZmZ1aW10SE54aWNQS1RSSkRZb2M2STdJQ3FneEJITDJHcFVDdmlj?=
 =?utf-8?B?eG81NTlDV0VKQkxVTXkyUjZYSzBQMWVzSEI2eUF3V2gvUFdDTWFkUkY5MzFT?=
 =?utf-8?B?bXlJNXdRczNjM2ozaWdIT2R0dHF0V2ovQzhmY2hidlkwaHE3U0ZEU3BxSWZj?=
 =?utf-8?B?MmcwOGxTK2F4VVlRR01aeGI2dXZQclVUVHliTC9SNXY2Zk1BcUdxV3FodUVW?=
 =?utf-8?B?RlUyUG5TcmFwMyt6NDhpM1JEYUd1NkMvWENXWEk0aFJNZ2JpN1JPZ1pDdEJn?=
 =?utf-8?B?aUo0cGNaN1Eyb2RWNnVoMDhOVE0zSTFXU2xvdUNMdWZWbkRMMWxvQU8rc294?=
 =?utf-8?B?NlhYQ09BWFcrTjRGdnB2ZU5ER0Nud3poSjNBa3BFRXhFbjhOYzkvYjMzYkhl?=
 =?utf-8?B?bVBYZDZ1RExwaDdrUTVNSmhINFBaZTkxbHBCMVZnWEtRdy9UaFJGMm5rcnBL?=
 =?utf-8?B?bXhNaEk2MnAvTHdXT1RLZzZlVTFKdFY5N2h4OGlLUWdhZGZDNVFtSG5UdXI2?=
 =?utf-8?B?MmEvTnQyNCt6NzBCa3h6aGNrcjl5QkR5VDFVZmE0VVQxVm1RdEZIbm9FdHlH?=
 =?utf-8?B?bUt4SU53TnhBTGc0YTRjYUxKbVB5WUhkck82b0R4VjR3bDRhbE5XZkFkSTlC?=
 =?utf-8?B?ZXpCTWJhVVN4dFBFMWtGS2pYVUdnZVFQdGN0RmtFdFFkMzdhSHlMcW9pK2dE?=
 =?utf-8?B?azQwZ2NScTd1NS83OU9lUHBISEF1WGM3c2o2WlJBd05CWEZjSjgwYXZkNEo3?=
 =?utf-8?B?NEJmeWgrTVdQbFMwNGh1Z0JsV1gwZHVOb0JvcUZ2cklHUjdkZVJRdTJTME1v?=
 =?utf-8?B?b3dUTUdIbXBXZEpIeUVDWXNDdnF0RjU4K3VTbjk2cVkvZ05Pd0FYTy9Ka3BQ?=
 =?utf-8?B?WjlkOHNiTlFqTGxjUjZYQWNPeC9BUzBvN29POHRmTWZZRmx4dE5NWnVIaUps?=
 =?utf-8?B?aXgzM08wejNGS21lNTQ2UVVWUG9xZ3NSajVGenBueW1RMUNpQWRkVVlQSklP?=
 =?utf-8?B?Q2dCSlRXVURBdzJNUjF6SGVOZHhSU0JVTG91b0tOaHpNRjF3UmRyT21IVmUx?=
 =?utf-8?B?NlRZbjd6T1o5WWhEcm5pMGkxQU1XdUdyTEoyb0YxUVhhd2lmOC9ya2xNQjY1?=
 =?utf-8?B?Tm1CUGVITU1UTWptM1FlWWZVUlQ0TURuakcrTlo3bW9iRVZsa21PVG0vUUFG?=
 =?utf-8?B?d2ZEb1pWcUdaYTVaM3lFdElhREkrVUV5cVNFWXNVdVY3Z3A3K3pPd0VmdThD?=
 =?utf-8?B?ZE5oZkRhR3RkNG9OL0cvdUNpTDhVWmFXQTFEclBNYm5kbU9MOUVQR0JrTzc5?=
 =?utf-8?B?UEFYWnBXZkxtVGxaZVk2WUVIZXU1dEs0Z1BENlR6VnJIY2Y3QlM3eDBqcmZK?=
 =?utf-8?B?MUFIWS81ZjdWWE9WQVB2L2NoZlNFVEhHaGtTeXBUM1lPUjJBL0hzeWZXMk9E?=
 =?utf-8?B?ZmpUZ1ZrSVZYVExuRzZCQ2hGQnY0cS9vbkwxV05YVUwwdHV1NzNsSzdWVHIv?=
 =?utf-8?B?amxNVEgyUHJIVlpydzRkcFpEQjNoRTBtSUdLUXFZeWNzQ1FvQ0NYanJoMHIr?=
 =?utf-8?B?VkJPVGJFL3FTWjhlRnRaL0l2SmpManZrZVlYdnhwM04wK3dhN0hpaGJlblpV?=
 =?utf-8?B?cS90N2pUaTdGT1hLa291RWNjL0hTMGZOQWQwRlFVUlh6SmRIa1I0Smh3UXRN?=
 =?utf-8?Q?Mx+uoZw7ecTj8?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V252S0Z4ZVNPUGNDSnlYcnVWdXp2bnFBZnhHZ3BRSUdBd2FqellURGJ0RDMr?=
 =?utf-8?B?akwrcERUc28zejdCUm9LMmR4bjZrZGRBTUovZGtzSi8xNU5GWUJ4SElWdU1r?=
 =?utf-8?B?ZDE0YmY3Z3FjSU9SaDFpb2lVZGltTFg3Z05iY0Z3aHllTERsSlhtWCs5SU1w?=
 =?utf-8?B?NFZNQjZ3dFN5dGg1eERyczhZTUJJdnp3cmo4YTU4NTQ3VDI2YitFSzR4Wmgx?=
 =?utf-8?B?SXhpMW5GVE10ZkM1TEJkeVlHaTBrWjQwYXFQejlKdW44enlVclBlTzhIN3Fv?=
 =?utf-8?B?VGE3cGphTUtaVlhxYkZURXA4UDdpeGFLcE5XNXVib2x5S3d0UWZrVUxIcFlr?=
 =?utf-8?B?SmtnbkZmejdaNjFpcThoTTViS0ZIQVpwV1FvTXNjWHNwYjFDc2RRNlB2T0hp?=
 =?utf-8?B?SWlaWXZrZFZXSWRWZ0RHRXM4c1dCS2o3ZjhZYVhzL3FBSUR1R1VETFljZU5T?=
 =?utf-8?B?YzlSRDgzRFRydi9Ha1FTRW90aFVROGgrQytkQXd1SnU5b2NxQWNTU0N3ell1?=
 =?utf-8?B?bGI3ZXZ2RS9BR2M5eTRpeFg3SmdSNWdySUlIRkRpclZHdXlvdU1pSWF1d3Qx?=
 =?utf-8?B?QTI2TTJhbTZMTGorQVdpVytlYWN0WlBxOFNrKyttd24xRTJXekw2T2dERE5j?=
 =?utf-8?B?WlZoRlYwNnVpTzlKLzdMNzhLd2o2MnhQLzdPdXd4dGhSNll6UEZDZzhlM3RK?=
 =?utf-8?B?c0ZtTGZYKzdaY3VOMDJQOWpXdmlkTkdkRmU1eTl1ZjVFVzR6ZHdXdTRzWmRR?=
 =?utf-8?B?VkwxYklQVHRqU1BML0FzMWZZdzdvYXpJVnZrSGxSdEVueVZhU0lkS2FLQmhy?=
 =?utf-8?B?bm1ONStDejMrOFhRZC9KQlVrRE9ZQWYxd21OMnplWkVsNW5OYmxvT3VhVDQ1?=
 =?utf-8?B?bnNRKzdlN0pqTVFwUDV6RWpmYmhCVE9rQmhQcjVoaUdNT3hvZW52akR1amY1?=
 =?utf-8?B?ZzkyNVl2eUxaUG1WdE9ZOEtPbHRLMklOYzFCUDhxWVF1Z0xwMVJ5TUlUSlZm?=
 =?utf-8?B?V1kxb2FZaUE0MkJDcTQ3YkluQnpON3pERjF4blFxN092M1p4dlNrN3pENStm?=
 =?utf-8?B?UXlramtpcEhvOVhuL21rUkl0QWV2QzBrM2xIaWdGOU1XZ3JLYW03N2M5a2Zv?=
 =?utf-8?B?cmZGcGNDa1h5ZmRSOFVad29DRURkNERYZnVVaDkwRk5hSGljZzRZOURCM3J0?=
 =?utf-8?B?UnhTQkpXUk9FQmI2NHRGWEY4cWFuajV6MWpEdmJjaUtrMXN1SFIwMFdFNytU?=
 =?utf-8?B?VnEycHhaekh4c1BRRGhJWVpqNk9qZG5ZNFB1UkQyQXRoeTRQREJhcmV3RTFa?=
 =?utf-8?B?UW1UZW5PMVNaN0NlaWphYjlDaE9xRlNSaWg5OHdBTGFjbndPaXBnRnNpNGo0?=
 =?utf-8?B?eG11NWFjWjJGUXdTNjU3OGxCRE5YSDkyMXIwbVVDZHJSSm0rRXNySk1NbEht?=
 =?utf-8?B?bnFXdHo0SFk1TGtJbGYvY0QySm9aMnJISGlvbldkaGYvQUROYy9XQXdzY2da?=
 =?utf-8?B?Rld3MzFqZW5HeFoxbFJoLzExUjR3R01jZ2NkSDdyRnoyVTcxNWJRcjRvNHls?=
 =?utf-8?B?RzBhRmtFSW1RUVNCY1hhNEovLzdVZmlESWpyaWV4QjJOY3NLVnZUUWk2SWpX?=
 =?utf-8?B?S0Y4eFczSFpQdlFyN0V6MmN1SlVKOHg3aU5KdzFtazI1RVVUTEJZSzQwSDhW?=
 =?utf-8?B?RzJ0ay9QdXFKZWhEcW1TRUd4bDNvdW5TQm9zZnFaYVJjTk5qWFhDYlBaRENW?=
 =?utf-8?B?eTY1MjhRMVMvdDhjZzExeWhKZzVmNlRUQldBRENnWHRkLzdobzFlYktRU2hU?=
 =?utf-8?B?KzhzMXFHNndxTm9UbzlZd0dyMHZEcmNRSllwMTBnUXlFc25oOVhucTR4STQx?=
 =?utf-8?B?MTAvSUdLTE1IbVhrQ2V0R05yOTU5ZGRORWU5WXlFTGpHYmtFR1IrcUpDT0tV?=
 =?utf-8?B?eW8xbWEzMWx1N2RHMWFPSWc3NDRLdlFHdERYTGIxZitDNklhUXlVOWpPZDAr?=
 =?utf-8?B?dk9CNHdRY1g0VWxUdWpaWWMwWmI3QnFQWE8wdkcyNFd2TWtWTnF1NWl0QkVF?=
 =?utf-8?B?WHEzenVoRmtKeEFhdCtNVHIvUWprSDlhZ25UOUpTOWNhYVkwUzh0amxxOE5D?=
 =?utf-8?B?UzF0YmJrSE1leWJZbTVLd24xMmRBeEoyTG8zRWkxS29FTE5WUW11alNtVkE0?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9D8EC435C5AF04399E2F1E3A9B1A565@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cfea3-d016-45e6-d63c-08dd46ac3bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:46:10.6066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SrnFqugek4yvwxNeCCU0yO2FD/AK8k/HBokt3GMc0UbFFzGESAYUdJFqW52sWVVL0tLiLe4ZpHmFN0bKk6ufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7897
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Feb 2025 12:46:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17159

SW5pdGlhbCBmZXRjaCAoYml0YmFrZSBldmVudG1ncik6DQpCQl9TUkNSRVZfUE9MSUNZID0gImNh
Y2hlIg0KRVZFTlRNR1JfVVJJID0gImdpdDovL2dpdC5zZXJ2ZXIvZXZlbnRtYW5hZ2VyIg0KU1JD
X1VSSSA9ICIke0VWRU5UTUdSX1VSSX07cHJvdG9jb2w9c3NoO25vYnJhbmNoPTEiDQpTUkNSRVYg
PSAidjEuMC4xMC10ZXN0Ig0KU1JDUFYgPSAidjEuMC4xMC10ZXN0Ig0KUFYgPSAiMS4wLjEwLSR7
U1JDUFZ9Ig0KDQpTZWNvbmQgZmV0Y2ggKGFmdGVyIGJpdGJha2UgLWMgY2xlYW4gZXZlbnRtZ3Ip
IHdpdGggYWRkaXRpb25hbDoNCkJCX05PX05FVFdPUksgPSAiMSINCg0KV2l0aCB0aGF0IHBhdGNo
IGl0IHNlZW1zIHRvIGJlIHdvcmtpbmcgZXZlbiB3aXRob3V0IHRoYXQNCkJCX1NSQ1JFVl9QT0xJ
Q1kgdmFyaWFibGUuDQoNCldpdGhvdXQgdGhhdCBwYXRjaCBpdCBzZWVtcyBub3QgdG8gYmUgd29y
a2luZyBldmVuIHdpdGgNCkJCX1NSQ1JFVl9QT0xJQ1kgc2V0IHRvIGNhY2hlOg0KDQpXQVJOSU5H
OiAvYnVpbGQvLi4vcmVwby9yZWNpcGVzLWFwcC9ldmVudG1nci9ldmVudG1nci5iYjogRXhjZXB0
aW9uDQpkdXJpbmcgYnVpbGRfZGVwZW5kZW5jaWVzIGZvciBQViB8IEVUQTogLS06LS06LS0NCldB
Uk5JTkc6IC9idWlsZC8uLi9yZXBvL3JlY2lwZXMtYXBwL2V2ZW50bWdyL2V2ZW50bWdyLmJiOiBF
cnJvciBkdXJpbmcNCmZpbmFsaXNlIG9mIC9idWlsZC8uLi9yZXBvL3JlY2lwZXMtYXBwL2V2ZW50
bWdyL2V2ZW50bWdyLmJiDQpFUlJPUjogRXhwYW5zaW9uRXJyb3IgZHVyaW5nIHBhcnNpbmcgL2J1
aWxkLy4uL3JlcG8vcmVjaXBlcy0NCmFwcC9ldmVudG1nci9ldmVudG1nci5iYg0KVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KIEZpbGUgIi93b3JrL2lzYXIvYml0YmFrZS9saWIv
YmIvZmV0Y2gyL2dpdC5weSIsIGxpbmUgMjc4LCBpbg0KR2l0LnVybGRhdGFfaW5pdCh1ZD08YmIu
ZmV0Y2gyLkZldGNoRGF0YSBvYmplY3QgYXQgMHg3Zjg3M2YwNmViOTA+LA0KZD08YmIuZGF0YV9z
bWFydC5EYXRhU21hcnQgb2JqZWN0IGF0IDB4N2Y4NzNmY2U5NTkwPik6DQogdWQudW5yZXNvbHZl
ZHJldltuYW1lXSA9IHVkLnJldmlzaW9uc1tuYW1lXQ0KID4gdWQucmV2aXNpb25zW25hbWVdID0g
c2VsZi5sYXRlc3RfcmV2aXNpb24odWQsIGQsIG5hbWUpDQogRmlsZSAiL3dvcmsvaXNhci9iaXRi
YWtlL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkiLCBsaW5lIDE2NzAsIGluDQpHaXQubGF0ZXN0
X3JldmlzaW9uKHVkPTxiYi5mZXRjaDIuRmV0Y2hEYXRhIG9iamVjdCBhdCAweDdmODczZjA2ZWI5
MD4sDQpkPTxiYi5kYXRhX3NtYXJ0LkRhdGFTbWFydCBvYmplY3QgYXQgMHg3Zjg3M2ZjZTk1OTA+
LCBuYW1lPSdkZWZhdWx0Jyk6DQogZXhjZXB0IEtleUVycm9yOg0KID4gcmV2c1trZXldID0gcmV2
ID0gc2VsZi5fbGF0ZXN0X3JldmlzaW9uKHVkLCBkLCBuYW1lKQ0KIHJldHVybiByZXYNCiBGaWxl
ICIvd29yay9pc2FyL2JpdGJha2UvbGliL2JiL2ZldGNoMi9naXQucHkiLCBsaW5lIDg1MCwgaW4N
CkdpdC5fbGF0ZXN0X3JldmlzaW9uKHVkPTxiYi5mZXRjaDIuRmV0Y2hEYXRhIG9iamVjdCBhdCAw
eDdmODczZjA2ZWI5MD4sDQpkPTxiYi5kYXRhX3NtYXJ0LkRhdGFTbWFydCBvYmplY3QgYXQgMHg3
Zjg3M2ZjZTk1OTA+LCBuYW1lPSdkZWZhdWx0Jyk6DQogPiBvdXRwdXQgPSBzZWxmLl9sc3JlbW90
ZSh1ZCwgZCwgIiIpDQogIyBUYWdzIG9mIHRoZSBmb3JtIF57fSBtYXkgbm90IHdvcmssIG5lZWQg
dG8gZmFsbGJhY2sgdG8gb3RoZXIgZm9ybQ0KIEZpbGUgIi93b3JrL2lzYXIvYml0YmFrZS9saWIv
YmIvZmV0Y2gyL2dpdC5weSIsIGxpbmUgODMyLCBpbg0KR2l0Ll9sc3JlbW90ZSh1ZD08YmIuZmV0
Y2gyLkZldGNoRGF0YSBvYmplY3QgYXQgMHg3Zjg3M2YwNmViOTA+LA0KZD08YmIuZGF0YV9zbWFy
dC5EYXRhU21hcnQgb2JqZWN0IGF0IDB4N2Y4NzNmY2U5NTkwPiwgc2VhcmNoPScnKToNCiBpZiB1
ZC5wcm90by5sb3dlcigpICE9ICdmaWxlJzoNCiA+IGJiLmZldGNoMi5jaGVja19uZXR3b3JrX2Fj
Y2VzcyhkLCBjbWQsIHJlcG91cmwpDQogb3V0cHV0ID0gcnVuZmV0Y2hjbWQoY21kLCBkLCBUcnVl
KQ0KIEZpbGUgIi93b3JrL2lzYXIvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5Iiwg
bGluZSA5NzAsIGluDQpjaGVja19uZXR3b3JrX2FjY2VzcyhkPTxiYi5kYXRhX3NtYXJ0LkRhdGFT
bWFydCBvYmplY3QgYXQNCjB4N2Y4NzNmY2U5NTkwPiwgaW5mbz0nZ2l0IC1jIGdjLmF1dG9EZXRh
Y2g9ZmFsc2UgLWMgY29yZS5wYWdlcj1jYXQgLWMNCnNhZmUuYmFyZVJlcG9zaXRvcnk9YWxsIGxz
LXJlbW90ZSBzc2g6Ly9naXQuc2VydmVyL2V2ZW50bWFuYWdlciAnLA0KdXJsPSdzc2g6Ly9naXQu
c2VydmVyL2V2ZW50bWFuYWdlcicpOg0KIGlmIGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRWYXIo
IkJCX05PX05FVFdPUksiKSk6DQogPiByYWlzZSBOZXR3b3JrQWNjZXNzKHVybCwgaW5mbykNCiBl
bGlmIG5vdCB0cnVzdGVkX25ldHdvcmsoZCwgdXJsKToNCmJiLmRhdGFfc21hcnQuRXhwYW5zaW9u
RXJyb3I6IEZhaWx1cmUgZXhwYW5kaW5nIHZhcmlhYmxlIFNSQ1BWLA0KZXhwcmVzc2lvbiB3YXMg
JHtAYmIuZmV0Y2gyLmdldF9zcmNyZXYoZCl9IHdoaWNoIHRyaWdnZXJlZCBleGNlcHRpb24NCk5l
dHdvcmtBY2Nlc3M6IE5ldHdvcmsgYWNjZXNzIGRpc2FibGVkIHRocm91Z2ggQkJfTk9fTkVUV09S
SyAob3Igc2V0DQppbmRpcmVjdGx5IGR1ZSB0byB1c2Ugb2YgQkJfRkVUQ0hfUFJFTUlSUk9ST05M
WSkgYnV0IGFjY2VzcyByZXF1ZXN0ZWQNCndpdGggY29tbWFuZCBnaXQgLWMgZ2MuYXV0b0RldGFj
aD1mYWxzZSAtYyBjb3JlLnBhZ2VyPWNhdCAtYw0Kc2FmZS5iYXJlUmVwb3NpdG9yeT1hbGwgbHMt
cmVtb3RlIHNzaDovL2dpdC5zZXJ2ZXIvZXZlbnRtYW5hZ2VyIChmb3INCnVybCBzc2g6Ly9naXQu
c2VydmVyL2V2ZW50bWFuYWdlcikNClRoZSB2YXJpYWJsZSBkZXBlbmRlbmN5IGNoYWluIGZvciB0
aGUgZmFpbHVyZSBpczogU1JDUFYgLT4gUFYgLT4NClBWW3ZhcmRlcHZhbHVlXQ0KDQpFUlJPUjog
ZXZlbnRtZ3ItMS4wLjEwLXYxLjAuMTAtdGVzdC1yMCBkb19mZXRjaDogRmV0Y2hlciBmYWlsdXJl
Og0KUmVjaXBlIHVzZXMgYSBmbG9hdGluZyB0YWcvYnJhbmNoICd2MS4wLjEwLXRlc3QnIGZvciBy
ZXBvDQonLi4uZXZlbnRtYW5hZ2VyJyB3aXRob3V0IGEgZml4ZWQgU1JDUkVWIHlldCBkb2Vzbid0
IGNhbGwNCmJiLmZldGNoMi5nZXRfc3JjcmV2KCkgKHVzZSBTUkNQViBpbiBQViBmb3IgT0UpLg0K
DQoNCk9uIFdlZCwgMjAyNS0wMS0yOSBhdCAxNDoyMCArMDEwMCwgQWxleGFuZGVyIEthbmF2aW4g
d3JvdGU6DQo+ID4gT24gV2VkLCAyOSBKYW4gMjAyNSBhdCAxMjoyNCwgS29jaCwgU3RlZmFuIHZp
YQ0KPiA+IGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPiA8c3RlZmFuLWtvY2g9c2llbWVucy5j
b21AbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlz
IGFkZHMgc3VwcG9ydCBmb3Igb2ZmbGluZSBidWlsZHMgd2hlbiB0YWdzIGFyZSB1c2VkIHdpdGhp
bg0KPiA+ID4gPiBgU1JDUkVWYC4NCj4gPiA+ID4gT2ZmbGluZSBidWlsZGluZyBpcyBlbmFibGVk
IHdoZW4gYEJCX05PX05FVFdPUksgPSAiMSJgIGlzIHNldC4NCj4gPiANCj4gPiBJIGFsc28gZm9y
Z290IHRvIG1lbnRpb24gdGhlcmUgaXMgdGhpcyB2YXJpYWJsZSBmb3IgdGhlIG9mZmxpbmUNCj4g
PiBidWlsZHMNCj4gPiBzaXR1YXRpb246DQo+ID4gDQo+ID4gwqDCoCA6dGVybTpgQkJfU1JDUkVW
X1BPTElDWWANCj4gPiDCoMKgwqDCoMKgIERlZmluZXMgdGhlIGJlaGF2aW9yIG9mIHRoZSBmZXRj
aGVyIHdoZW4gaXQgaW50ZXJhY3RzIHdpdGgNCj4gPiBzb3VyY2UNCj4gPiDCoMKgwqDCoMKgIGNv
bnRyb2wgc3lzdGVtcyBhbmQgZHluYW1pYyBzb3VyY2UgcmV2aXNpb25zLiBUaGUNCj4gPiDCoMKg
wqDCoMKgIDp0ZXJtOmBCQl9TUkNSRVZfUE9MSUNZYCB2YXJpYWJsZSBpcyB1c2VmdWwgd2hlbiB3
b3JraW5nDQo+ID4gd2l0aG91dCBhDQo+ID4gwqDCoMKgwqDCoCBuZXR3b3JrLg0KPiA+IA0KPiA+
IMKgwqDCoMKgwqAgVGhlIHZhcmlhYmxlIGNhbiBiZSBzZXQgdXNpbmcgb25lIG9mIHR3byBwb2xp
Y2llczoNCj4gPiANCj4gPiDCoMKgwqDCoMKgIC3CoCAqY2FjaGUqIC0tLSByZXRhaW5zIHRoZSB2
YWx1ZSB0aGUgc3lzdGVtIG9idGFpbmVkDQo+ID4gcHJldmlvdXNseQ0KPiA+IHJhdGhlcg0KPiA+
IMKgwqDCoMKgwqDCoMKgwqAgdGhhbiBxdWVyeWluZyB0aGUgc291cmNlIGNvbnRyb2wgc3lzdGVt
IGVhY2ggdGltZS4NCj4gPiANCj4gPiDCoMKgwqDCoMKgIC3CoCAqY2xlYXIqIC0tLSBxdWVyaWVz
IHRoZSBzb3VyY2UgY29udHJvbHMgc3lzdGVtIGV2ZXJ5IHRpbWUuDQo+ID4gV2l0aCB0aGlzDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoCBwb2xpY3ksIHRoZXJlIGlzIG5vIGNhY2hlLiBUaGUgImNsZWFy
IiBwb2xpY3kgaXMgdGhlDQo+ID4gZGVmYXVsdC4NCj4gPiANCj4gPiBEb2VzIGl0IG5vdCB3b3Jr
IGZvciB5b3U/IEhvdz8NCj4gPiANCj4gPiBBbGV4DQoNCi0tIA0KU3RlZmFuIEtvY2gNClNpZW1l
bnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0KDQotLSANClN0ZWZhbiBLb2NoDQpTaWVtZW5zIEFHDQp3
d3cuc2llbWVucy5jb20NCg==

