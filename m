Received: from iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.10.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11941.1793931276961033769
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2026 18:14:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lab126.com header.s=amazoncorp2 header.b=MwQEAixA;
 spf=pass (domain: lab126.com, ip: 34.197.10.50, mailfrom: prvs=7633aa874=kpoduval@lab126.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1793931277; x=1825467277;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=tnMYllbh7hdhVAOznr/ts+qfUncENBQ3RTd1esL1ELI=;
  b=MwQEAixAmffpuCZ8OZ17TRSs6RvkHVug/pDm2c08M42fV/PkThhTs+zD
   FWuLCV8Hnutl7vWXkrCxaEPzNSdQDUo9uY8LjE4UpGsWOfLhVicSVmyn8
   hcr0hKcNThuzMffB0lFOPaceY/WgUqENp9g4vAU8mdzK+1rDuVkNKlgSb
   q843QrYoCGR0MtXHTjGLIDWOo/CkECMKU+CBvtf7xF13+TZog0/P0DRLv
   jkz0JdmwFV7OJ0GUqUm9cP6AB5Tc34N2R9XQPdpCuhIcntB1Voz/gvDNJ
   nVYv5jVuAHCec+VhHdzjPfLrZ4cdPo94+OfAi3Z3k8OFQRncEjlA8HPa0
   g==;
X-CSE-ConnectionGUID: GgqXwzoCRTmLw6FLxAd1UQ==
X-CSE-MsgGUID: hVuZXXkhTAqaNXbsnccezg==
X-IronPort-AV: E=Sophos;i="6.27,197,1787011200"; 
   d="scan'208";a="31022392"
Subject: RE: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by default,
 falling back to the AWS CLI
Thread-Topic: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by default,
 falling back to the AWS CLI
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 02:14:35 +0000
Received: from EX19MTAUEA002.ant.amazon.com [72.21.196.65:28371]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.29.208:2525] with esmtp (Farcaster)
 id 5cfee72e-6a70-4f42-aa25-8f3b7d9fd10a; Fri, 6 Nov 2026 02:14:35 +0000 (UTC)
X-Farcaster-Flow-ID: 5cfee72e-6a70-4f42-aa25-8f3b7d9fd10a
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 02:14:35 +0000
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 02:14:34 +0000
Received: from BL2PR08CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Fri, 6 Nov 2026 02:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMUlAGZvyC167L86GJmLLo9t/GTU3K+IhVjzLofhw+A3GeF6VtXtEQLh4pLcg8NP1NDMbUKJp2H7bwRv59V+cXNkqut5Q10MjsaA6GWDjq9plZRlI0sjP8IaZxL/ebOiFT8HMXok0UwfP66PVl6da6uWLMMZ/2db0YtN+tV9og2yAgh5MsAXdvtRR2D4xK6r8Hijcklt1XhQQJFObx8dlEnkiDLPIMueSG+a7PldEXckNnRs1oYiPjAiUe497/J/EfrrSDNhlHq/rPD6UZhBoJAwboeLInbgLoQ48ATXrdAl0YP811t8BiZgiB72zcv+9lJJeXYZb6DpJuatrBZUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnMYllbh7hdhVAOznr/ts+qfUncENBQ3RTd1esL1ELI=;
 b=Yx/lBsAP62sjMu915p+A0a14ZkLzNGijqNRiX4udsrtSZAwz8sF8iPypsrdBUfaGfS6jW0vxhwgpYeERKMyQ7jE/9/rb518juRBWm/ZmXcOaGfMiBrwHBEtxoDocyEyKUuw7Uj4znGWbybKOMR6dmdrwD1xs54BJ6DoLYoaG6MHIdI1l/s4Y/a5nOljPgnmSVFXJUr47WVhhs1OfqgKxbdcaXbIaak1iJq1iVwAXBwVj21yBCO1sOSZJefZDaU7u54MElFu8cglSZMSJGJt3njWBK+YvsNhueSDOY9uDc3s0e4uZs5OcH+GDF7zbrz6Imu+HYBkXSnBX7JNuP5q3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lab126.com; dmarc=pass action=none header.from=lab126.com;
 dkim=pass header.d=lab126.com; arc=none
Received: from EA3PR18MB205973.namprd18.prod.outlook.com
 (2603:10b6:303:308::11) by CO6PR18MB3906.namprd18.prod.outlook.com
 (2603:10b6:5:34c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:14:27 +0000
Received: from EA3PR18MB205973.namprd18.prod.outlook.com
 ([fe80::96e8:4cd0:9d02:dd88]) by EA3PR18MB205973.namprd18.prod.outlook.com
 ([fe80::96e8:4cd0:9d02:dd88%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:14:27 +0000
From: "Poduval, Karthik" <kpoduval@lab126.com>
To: "ross.burton@arm.com" <ross.burton@arm.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "armccurdy@gmail.com"
	<armccurdy@gmail.com>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>,
	"stefan.herbrechtsmeier@weidmueller.com"
	<stefan.herbrechtsmeier@weidmueller.com>
Thread-Index: AQHdbMSObm9hFVVmlEGd0nQvB3eQuLcfgQqAgADOMHA=
Date: Fri, 6 Nov 2026 02:14:27 +0000
Message-ID: <EA3PR18MB205973294DDF2131E43CC49172F1762@EA3PR18MB205973.namprd18.prod.outlook.com>
References: <20261105012522.878275-1-kpoduval@lab126.com>
 <20261105012522.878275-2-kpoduval@lab126.com>
 <A62B91DA-FE71-4D0B-9672-1AFCF0C0A2CA@arm.com>
In-Reply-To: <A62B91DA-FE71-4D0B-9672-1AFCF0C0A2CA@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lab126.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA3PR18MB205973:EE_|CO6PR18MB3906:EE_
x-ms-office365-filtering-correlation-id: 6475f2ed-b2b1-4b82-e598-08df3babaf71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|6133799003|22082099003|11063799006|38070700021|56012099006|261022105027099003|261102123227099003|4143699003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003;
x-microsoft-antispam-message-info: AlpRE4UUUeMRJzMYfGgGZQZmtEqjG/vPguHlG0NpFmkj64VicS3lvyiatLEmXvmmwa7r1W6PsetbkO8lvGgu5bu5s/sgc1Wgullu2vZnHzeid9MK7aTOuihRAJdVswOvN3LNTqw+Io4SE8thGd2Qk3l+pNKraltCGpv/YAeYcO8kgHtbjYwpuk8BEPPbMVXHg6u+EuE73jFwqncXyxc3OK+fEXjkECJOFYOVQDRHUfjGQQQUWA3iLgDvzQBEGCAnlVXduiJMlV06vooA6CLh79Hx9XaGyPRgZ1Vc3YeyxPYdUwj/7L1AK2bYd4kPT6l7suvBk0O7Ny2FCr4w8a/+dGfTHEx59kx3wVvVXmJV9JfLARoqulizXXkxgpS907pcxl34zwhyCs99yg3kpiRxAED6Di6Aaw1hWgSlg47DzitsZCMxwGfpeR/nTEpxUXRnNCm4HMKiS4KfqY9MA5F3XPkajybghq6Wg07MbssX5jkvOm8Rm265cs49dMjvhMMu3lEHcf8Lk3Z2mEvKgW1++lezdn0zF6axN8O/H5Lsl8ZcpTXNihGkOFaAANve3XhoOU8Aek9M3yf46CdcTb+FSmkep/dA+ViP9hkPoDhGO3PtpXvSb6v5T4+xp+auovWZthaZRBGqhWGtxnWKRATz4ogxjzgR41RSee1Al+zYXW5IdD9SVPPLpj5JMK2JvMJj+IMw+/hg4L9z9IO2qZKLre1JmjoCotU5Yy7qIYeC82k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EA3PR18MB205973.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(6133799003)(22082099003)(11063799006)(38070700021)(56012099006)(261022105027099003)(261102123227099003)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmc5VWg0WjhHU1lheUVyS1hpVW1LS0VYank3RUR2NGk4UVJlNGQyL2JmL3B1?=
 =?utf-8?B?WStmN0wwb1U3MHNHM2pldDcwRFBySFFwYkw1Tjc4TmNLZHkwanVVaURqTDZS?=
 =?utf-8?B?N0pzYjJVN0E4OFBYcFgydElHRTFVenB6cVpqb2NBUXh3MmQxQWJpUzdMekkz?=
 =?utf-8?B?L2dtZkpHZ3cyb0pJd0ZadEJVb25EbUMyYnpRa0pPNGRLbFhiZTFMZTBkbEJv?=
 =?utf-8?B?bGltVGgrL2xGckZibXdQMGpUaVNmQTNpUTliTG8xOHRNMmxCZWxBbmVCaDhn?=
 =?utf-8?B?dHpCZEduVkVFLzkzZXZoU3B3NGlCZW94M0lhT25acko5amRBMm9vVWI1MmFs?=
 =?utf-8?B?VnRlaTlhQUJuOFdiWCtqaENqVUxlV2ZXTEt3Mi94TGZDdERtQ3VJL0lVdS9Q?=
 =?utf-8?B?TEJNQ1Q5U1gzVXovbTQxU285RlhGMXZuVFIwcFhlMnNURnhWRHRORXdUU2N4?=
 =?utf-8?B?Qk5EMzdrMUtVaDRvN0xHODNnZ3pLcjhyQVAvZW5aQmR6citTbkFuSEpid1NG?=
 =?utf-8?B?NURzWGpqQXg5L21pL1ZocjdsWjR6UlZLUjdpM2JlWnlWS2Y2U0xOWHNsYnhz?=
 =?utf-8?B?QlEzVytsN3ZlbGo4YWpWeUFaaUVaalJEMnRTK2pWL0ZFRCtUcDZPWFBHVVNo?=
 =?utf-8?B?U0JiclpoSk9sZ2pjNnhhZnN5UFpqN01FWTMxRktmM3llUEV3eEJjZ053UExE?=
 =?utf-8?B?UHU1Z2pqTkVUdEszWEtacUhLdG1ybGZOZGV1SnNEazl4UFg2dVZNdzFzUU8y?=
 =?utf-8?B?V280OXNTYUo1cG9pWU5IWjJnWERCMHV0Qy9lbnBQQWIvMUVSMGlyVVlTdTM0?=
 =?utf-8?B?Q2ZlNURUK1Bvend0bWJHV05FVjMwQlJsOExvMHVtWGViNHpicGY1UkNlbERw?=
 =?utf-8?B?RHJaRitXQ0EzWC9zYm94YjBuc1dpYllZdUxyeE5kbGRnV2hYTVRPUDFmNzh3?=
 =?utf-8?B?b0htS1Y2ZUluSDVqZjVmRmJpc1EvVTA5VXhvRXI2enZFaUswVzZNd2R3UERH?=
 =?utf-8?B?SWFYY2E0VWpRMWZRYTdHVlFhdkVOMjN4MGI3WndCSndObWk5QlNqOGVBSTNh?=
 =?utf-8?B?dXNENEtMQ1pxYS82V3lFYXlqMU9sUUtnT3VoRGZwR2NZM0dlRitJQWZLODN6?=
 =?utf-8?B?TVRVL3FCTGRxcEF5RjdneHdyb2hTNEZoTXlNVUpvNkV3blc1ZjQyRGU4RUpS?=
 =?utf-8?B?MEZWNmlhR0VTRmlMUE1DaDJSeld6RndqK1U0VHdrbEVKb2lKOTJmeU4wR2lu?=
 =?utf-8?B?WmcvRUNoWVdCV3drVHhPWVlsOUhiT2RyZGFPRmRIdVl5NVptTHV6b0JDamN2?=
 =?utf-8?B?ckJQOHgrZjIzWDBFQ2VKMWpncVVLeVVuQWNRWEs0UW96V0VRaWVKb2xoZlE1?=
 =?utf-8?B?Wjl0WDFzcTdRNEVBYlpNRElIVTREUzQ3bkF4OHB5ZHJ1L3JzYU9PaHBscC9h?=
 =?utf-8?B?T2V3ZGFJVWpsbDViemVnTEU4dEo0ZXNsOHAybjNoRTJuVWhCQWRKa2RRMjZ2?=
 =?utf-8?B?YnZ4dVdaSVpNTXI2cVdzOWdSWlpoT29PQW1iN3FObktJUnRTSzJPakUzS29S?=
 =?utf-8?B?Q085SDQ1VGpiWEdVakM0b1JlQnYwTzRvN3RLYXA3OEtnTmxpNWZ1UXZwYmJK?=
 =?utf-8?B?SjlQQnBoYk0zVW16TFF1aHNEY1BNQkMrVFUvWGQ4UTZhTHFldlJrV0tZOUpu?=
 =?utf-8?B?WVdIWmRCZHpzVDFLOWswRGNWTlFKMnpia2lINmNQOFZiZzZkMEgrb1dKN0NG?=
 =?utf-8?B?RjFaTFpSR0F6R2FvaHpzbW5lYnlLd1BJMm1EeDh2M0NRbEdQZHQ0WDZ4SEMr?=
 =?utf-8?B?TmJyUnhyMjJCWE1qblVPc0Q2azdleW15N25TWFpQZEVZMUxwRTlDV3ZQMHBG?=
 =?utf-8?B?eWNkZHpUOEMxemVybE1kYzJsMDRkbHBGZndxNFU2clNoMHlrOHR4RDVUZVJU?=
 =?utf-8?B?Y1hQaytSNkRmS1BVNXd1dXNZa0hqS0VxV2lYemRjWWtrWThlSkRBL1d1cU5o?=
 =?utf-8?B?WDIxV1F0bmJoTVhpbUJrQjR1UkVOb1R3dWNFUWF2amZLbFI3b0ZxeVB4dWJv?=
 =?utf-8?B?YmE0TGVVQUpSdUpJb3VEc1dZNTZPWEtVV3RXNjk3OTVNR0NtM2hvUWlBN3ZD?=
 =?utf-8?B?aXA3bnJZM0piTUJtQnU1YmdSVndBc3FkaFNxaXI0cWxuOXNURjg3UFQ0QjFG?=
 =?utf-8?B?R3VjNGxBR001UzlzaG1NOVJFblJTaFJ2SmpUemYvRWdhbms1d1VmY0hEVmVK?=
 =?utf-8?B?bkhKMUxNRUtEYXlJOUV5ZFduY0RDZnR1WW9jMmJmenpiMVN4UVl5Ky9NMEtl?=
 =?utf-8?Q?6rMpMXNCeDqIeoa8v6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hzagq02f9nwUt5jvhV24VUgHcBIBmfLinY0ULzS8Eizl6iSXYKHmyEE88TNHikgcSG6aq01HlUAbF+Hc/9eAKusx8TyHT66vBql86QL6N3GQij0Ieq2mGDxKbpeDRmgTVMy4Aqn1fxsCgPpCT/SJZ0PheUrJnriDRA4bk4kWr12idtums6RvFpbnK8Ix517MljWQ7wjISOBh/VApIYQ6RMrWV7l2tNzWRdqXJO8cKE4rqZl6rj22k4j9JzxGy/fWL5VWgYQHE4Ub2eKQj8X2MeZVctOthPsu9jgsjrohfSg7x4irPBgAQKUPSylOlKL41rYeDju49QQFMRySN0uVQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EA3PR18MB205973.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6475f2ed-b2b1-4b82-e598-08df3babaf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 02:14:27.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caSHP1lbglE7DVCJRpLF6wqIfY6NxSt1YVm4HeoDAfGWYuOF4T9DcZJh9IreeqVmyeiOuOaJ43fN6TCPT7CtTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3906
Return-Path: kpoduval@lab126.com
X-OriginatorOrg: lab126.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 02:14:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20401

VGhhbmtzIGZvciB0aGUgY29tbWVudHMgUm9zcywgbGV0IG1lIHJld29yayB0aGUgcGF0Y2ggYXMg
eW91IHN1Z2dlc3RlZC4NCg0KLS0NClJlZ2FyZHMsDQpLYXJ0aGlrIFBvZHV2YWwNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJvc3MgQnVydG9uIHZpYSBiaXRiYWtlLWRldmVs
IDxyb3NzLmJ1cnRvbj1hcm0uY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IA0KU2VudDogVGh1
cnNkYXksIE5vdmVtYmVyIDUsIDIwMjYgNTo1NSBBTQ0KVG86IFBvZHV2YWwsIEthcnRoaWsgPGtw
b2R1dmFsQGxhYjEyNi5jb20+DQpDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnOyBhcm1jY3VyZHlAZ21haWwuY29tOyByaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24u
b3JnOyBzdGVmYW4uaGVyYnJlY2h0c21laWVyQHdlaWRtdWVsbGVyLmNvbQ0KU3ViamVjdDogUkU6
IFtFWFRFUk5BTF0gW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAxLzFdIGZldGNoL3MzOiBmZXRjaCB2
aWEgYm90bzMgYnkgZGVmYXVsdCwgZmFsbGluZyBiYWNrIHRvIHRoZSBBV1MgQ0xJDQoNCkNBVVRJ
T046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlv
bi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4g
Y29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KDQpI
aSBLYXJ0aGlrLA0KDQpJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoZSBjaG9pY2Ugb2YgdXNpbmcg
Ym90byBvdmVyIHRoZSBDTEksICB0aGUgcGVyZm9ybWFuY2UgZ2FpbnMgeW914oCZcmUgc2hvd24g
YXJlIG5vdCBpbnNpZ25pZmljYW50LiBIb3dldmVy4oCmDQoNCk9uIDUgTm92IDIwMjYsIGF0IDAx
OjI1LCBLYXJ0aGlrIFBvZHV2YWwgdmlhIGJpdGJha2UtZGV2ZWwgPGtwb2R1dmFsPWxhYjEyNi5j
b21AbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+ICt0cnk6DQo+ICsgICAgaW1wb3J0
IGJvdG8zDQo+ICsgICAgaW1wb3J0IGJvdG9jb3JlDQo+ICsgICAgSEFWRV9CT1RPMyA9IFRydWUN
Cj4gK2V4Y2VwdCBJbXBvcnRFcnJvcjoNCj4gKyAgICBIQVZFX0JPVE8zID0gRmFsc2UNCg0KSW5z
dGVhZCBvZiByZXNwZWN0aW5nIEhBVkVfQk9UTzMgaW4gZWFjaCBvZiB0aGUgZnVuY3Rpb25zLCBy
ZXN1bHRpbmcgaW4gcXVpdGUgYSBsb3Qgb2YgY29tcGxleCBjb2RlLCBJIHN1Z2dlc3QgYSBzbGln
aHRseSBkaWZmZXJlbnQgYXBwcm9hY2guICBJbnN0ZWFkIG9mIGhhdmluZyB0aGUgY29uZGl0aW9u
YWwgaW4gdGhlIG1ldGhvZHMsIGhhdmUgdHdvIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgUzMgZmV0
Y2hlciAoc2hhcmluZyBjb2RlIHZpYSBhIGNvbW1vbiBwYXJlbnQsIGlmIG5lZWRlZCksIGFuZCB0
aGVuIHBpY2sgd2hhdCBvbmUgaXMgdXNlZCBvbiB0aGUgZmx5LiAgU29tZXRoaW5nIGxpa2UgdGhp
czoNCg0KY2xhc3MgUzNDb21tb24oRmV0Y2hNZXRob2QpOg0KICAjIGNvbW1vbiBtZXRob2RzIGNh
biBnbyBpbiB0aGlzIGNsYXNzDQogIGRlZiBzdXBwb3J0cyhzZWxmLCB1ZCwgZCk6DQogICAgcmV0
dXJuIHVkLnR5cGUgaW4gWydzM+KAmV0NCiAgIyBldGMNCg0KY2xhc3MgUzNDTEkoUzNDb21tb24p
Og0KICAjIGNvbmNyZXRlIGltcGxlbWVudGF0aW9uIHVzaW5nIHRoZSBDTEkNCiAgZGVmIGRvd25s
b2FkKHNlbGYsIHVkLCBkKToNCiAgICAjIGRvd25sb2FkIHVzaW5nIHRoZSBjbGkNCg0KY2xhc3Mg
UzNCb3RvKFMzQ29tbW9uKToNCiAgIyBjb25jcmV0ZSBpbXBsZW1lbnRhdGlvbiB1c2luZyBib3Rv
DQogIGRlZiBkb3dubG9hZChzZWxmLCB1ZCwgZCk6DQogICAgIyBkb3dubG9hZCB1c2luZyBib3Rv
DQoNCnRyeToNCiAgaW1wb3J0IGJvdG8zDQogIFMzID0gUzNCb3RvDQpleGNlcHQgSW1wb3J0RXJy
b3I6DQogIFMzID0gUzNDTEkNCg0KVGhpcyBzaG91bGQgcmVzdWx0IGluIG5lYXRlciBjb2RlIGFz
IHRoZXJl4oCZcyBhIGNsZWFyIHNwbGl0IGJldHdlZW4gdGhlIHR3byBiYWNrZW5kIGltcGxlbWVu
dGF0aW9ucy4NCg0KQ2hlZXJzLA0KUm9zcw0K
