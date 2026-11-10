Received: from iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.216.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.927.1794326788367896636
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2026 08:06:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lab126.com header.s=amazoncorp2 header.b=nYSV0HVd;
 spf=pass (domain: lab126.com, ip: 3.216.221.67, mailfrom: prvs=7673f2358=kpoduval@lab126.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1794326788; x=1825862788;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=IvSzI6eU3f9X2BifYJOyU7EXMY2sOOBszNNbYQGEyZQ=;
  b=nYSV0HVdEDLSobynd1DV5W8I3XCEmLbzHQxfSdwEM4jVTbRRX21upFNG
   Czj1yxxPc5IdoKVCXIQRzVHZRrxNcRVponMoMBtqCtC5G47H/P+y8JSI/
   Gc3339mWUoZjq5NeupFA02tV0Ct5BnKeTy+YD21QC2nrqWB2oR77NBpWa
   Vh+hGqFQ1GMIDPF9dQ+SCaxI35R16Icny/kOqoJpjmK3mlhOHeGxr251f
   SjFQOAi3yHMsy6SIEeBDLUTCFW9pOI/NZ5vcwe6c0Y8CQhImyGKd+KLij
   kkSQS/ZI6P4JFS86C58QrlHy/f9FBE+rIT9e6iu2c/He0GfmdjN/nv9yG
   g==;
X-CSE-ConnectionGUID: +ocLqcZtRxm5+QNaULoulA==
X-CSE-MsgGUID: wHB65+7rRUiGdeSii7yLHA==
X-IronPort-AV: E=Sophos;i="6.27,206,1787011200"; 
   d="scan'208";a="31606009"
Subject: RE: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by default,
 falling back to the AWS CLI
Thread-Topic: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by default,
 falling back to the AWS CLI
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 16:06:25 +0000
Received: from EX19MTAUEB002.ant.amazon.com [72.21.198.67:5158]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.92.155:2525] with esmtp (Farcaster)
 id 2d72d5eb-4920-40cc-ad73-73f1822a1410; Tue, 10 Nov 2026 16:06:25 +0000 (UTC)
X-Farcaster-Flow-ID: 2d72d5eb-4920-40cc-ad73-73f1822a1410
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 16:06:24 +0000
Received: from DM5PR08CU004.outbound.protection.outlook.com (10.252.135.42) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Tue, 10 Nov 2026 16:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrRqFLqrmOrrHAR0BeHHt+QDW6SxE1w/onkH4gpZcGkX5gZkjOIGKVO8/Al3yEoCkYM3uuA8Eqk0AllEG4WMoTw8GqOYVV7s+dKDGMImGv2JTyUGhQ/LGXl4VqdtSkDkS43p/329nXg7RYCEGXRo6+iwiKi0hRyfE1Kzvo+36fXsfya8c4dQHaVpJQueeRRvG1FvJjU2/i3+IoeNEbUL5H8HQI+Cuw3R5Feq39MqM6cHuAD33Yv8YK9rqCxtHaWwPuJWHxhnNHt6noKXkU5oBryP9AjEp7nruo4kcGzsspWhEnMh++DNlYgROS/ogzH9RQxWq97uFYpEP3VaDzTb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvSzI6eU3f9X2BifYJOyU7EXMY2sOOBszNNbYQGEyZQ=;
 b=gVXnltWfrH56cT7ppuc1K66N+vJ3dhpikO415jdfMOgR1Rqm0TNLzpr26FSFo2tEQ46h1IK04NAeqontvQlhpWZQmBM1MrxuB3WPMgIAe1S8R99Te1I1IiYr3qj7FCEb9ind2zPYNdRljfqKfKThe5gob+/JHQ9Ug73d6v5WFr2db5l0MvR+K3Pnp5w2L3P2E96ckpTOqhD1mPtUP/KQhZrNGrSAr5ApjvaLuBiAc7LVdQ3J3T4TPKAayg40qV6pfYn8RY2u9v+bVwny8RFQba5VYHiInFkEqDUNMgQt0o9Saq65dL+uWbK14Fj7+VkGiM+/b9vNO0w5Csa2DO28nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lab126.com; dmarc=pass action=none header.from=lab126.com;
 dkim=pass header.d=lab126.com; arc=none
Received: from EA3PR18MB205973.namprd18.prod.outlook.com
 (2603:10b6:303:308::11) by MW3PR18MB3641.namprd18.prod.outlook.com
 (2603:10b6:303:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 16:06:16 +0000
Received: from EA3PR18MB205973.namprd18.prod.outlook.com
 ([fe80::96e8:4cd0:9d02:dd88]) by EA3PR18MB205973.namprd18.prod.outlook.com
 ([fe80::96e8:4cd0:9d02:dd88%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 16:06:16 +0000
From: "Poduval, Karthik" <kpoduval@lab126.com>
To: "rob.woolleywr@gmail.com" <rob.woolleywr@gmail.com>
CC: "ross.burton@arm.com" <ross.burton@arm.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "armccurdy@gmail.com"
	<armccurdy@gmail.com>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>,
	"stefan.herbrechtsmeier@weidmueller.com"
	<stefan.herbrechtsmeier@weidmueller.com>
Thread-Index: AQHdbMSObm9hFVVmlEGd0nQvB3eQuLcfgQqAgADOMHCAALA+gIAGfmzQ
Date: Tue, 10 Nov 2026 16:06:16 +0000
Message-ID: <EA3PR18MB205973D907BBF182C49DD35648F1722@EA3PR18MB205973.namprd18.prod.outlook.com>
References: <20261105012522.878275-1-kpoduval@lab126.com>
 <20261105012522.878275-2-kpoduval@lab126.com>
 <A62B91DA-FE71-4D0B-9672-1AFCF0C0A2CA@arm.com>
 <EA3PR18MB205973294DDF2131E43CC49172F1762@EA3PR18MB205973.namprd18.prod.outlook.com>
 <CAGAhMBx_oCwz24qzoJUjbD3EwKVndyUdfN0gfCHsQx=_KecZmg@mail.gmail.com>
In-Reply-To: <CAGAhMBx_oCwz24qzoJUjbD3EwKVndyUdfN0gfCHsQx=_KecZmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lab126.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA3PR18MB205973:EE_|MW3PR18MB3641:EE_
x-ms-office365-filtering-correlation-id: 7ba2b625-55db-4244-4b23-08df3f448cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|6133799003|38070700021|11063799006|261102123227099003|261021121427099003|261022075727099003|4143699003|261028144727099003|261026121527099003|261009223027099003|261022105027099003|56012099006|261026140227099003;
x-microsoft-antispam-message-info: 8B6oO+QbDn71jWCUk9c0Y05lV1uZNokMas87Y6lgfQYFgHD5Rt9aGLtjvHjn7WR8R2nmIsVFD3eZM/JvjMhEvb/WJBBycAJ24Ovr3fWmJa8gixcwkzgMaqV7WZwJK1KU6M9b1+paTsVcVWUp5iHoDt15Zo4NyiUQtZnNu3X4hVNrvquPhAzMItuJNJQGD9nGYUYWnlul6sOYV6aBjIwFg1wH3PyJBol4W4DZejJ6HV9m1decPQEuDku3X5u/vZfOcHqZ4AUnSteua+tV4Z9nTCm4R0ZdWdSWkWXeqQCAPkNC3nJseR3cLJS5gc+ADjU/HDCfgvJOeBdsolH3LTEgEMy+CHqzCLX6HT7tuMRaLSF2gCul0+4by27JHkp1YJmGQQRM///ZZuDRjOvJ3+3GSwWK7ndWWOD0mhj18co7lAVw4HkE5iXM5XCO0mO42GPzCbJJpZ7Yj2GIRIJUPn1tKt5kg0b3C+D9MTg94kmL4bPXpwFGMqtt8/I0cdKVGL5up/Xeq+EeEKxQmERkswh5j+tSK5om2AXlgY3JXQPrPd7vJtN19l1ILQfCQsrEcrmcJ8SGPfjKWzxR0auWbfzv8HU3YrzCev6oc+ya2Hn7bmnG+RwiiUV0/mzm7XSOaDcsH7KdE/MRZ2irEuRAmASbKEuGcD6oYwincnfX4sGATqS50rjDGu/KVQidlNYpeKld9d9eR50Eu++xoU2h9xXYMZHt4H2A42wpk/6pt013vnw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EA3PR18MB205973.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(6133799003)(38070700021)(11063799006)(261102123227099003)(261021121427099003)(261022075727099003)(4143699003)(261028144727099003)(261026121527099003)(261009223027099003)(261022105027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzdvUklQS2tnSDNmQjJiQS9FSGYwV0EyRlBWdjZ1QjUrNWxHYjd0M0pKWlBG?=
 =?utf-8?B?QjZIemtJVHIyTkl4K2N5ZUxRUnZPV0NqWk9CVkpyQjFDSllaN1hqV3ZKRjd2?=
 =?utf-8?B?eEo5ZHpWWko0TzBYazZhV3BMMnc3dFlWSC81T2JRemVhUXRoZG01Z2NJZWVp?=
 =?utf-8?B?dzVWVGFMelArQ1N6OXFrV3hoUXB6SzRKb3BKUW5xZng3M05CQnJGZzIyTkxm?=
 =?utf-8?B?S3BXY2dUMjFzVS9tMGJPU2NIaWlxTlJtY3pVQTQ4UlJaa0lzNnlEWTNNeHhW?=
 =?utf-8?B?SHlWNHlmWE5hbi82QjFFZkd1enJnRUNGd1dpVWVMTXZlRnZXZmh0NVhxQjJ2?=
 =?utf-8?B?NkRXb2t3WGF6WmlEMElLVDFHdS9OZ2NhWS9NMmlsNkJGRFJ2SmV0bzRHSHhh?=
 =?utf-8?B?dUxhWnlPZEp5VXVsV3NSVm54UlZXcVZodWxMS2dmZUFmN2srVERHN1FiOU91?=
 =?utf-8?B?dERpRDAzdm9mSEZXMWJOVzVDdHdyT3J2Z3Z0SE02ZnpaZ2g5aUQvYXZRMjZQ?=
 =?utf-8?B?WTdWSHZMa3dDZlltT3lWcVd5K3FnVSt5WkZjc1BGSTQxQWErMHUrdlM0OVlL?=
 =?utf-8?B?WjRIM2NORFpLMHhXT2gyREM3dVowQ1VrenZvREcxM1hHQzdwUkhtTnNBYVc2?=
 =?utf-8?B?OEhScS9aYWt3UDMvWVlNYS9kU24zdFVUREc1YnRYak1DNWpjY2J2K1dYS1M4?=
 =?utf-8?B?ODRpZWh5ZS9MQUxXUzVzbDFNVEQwSXhWWXFJWVJINjFLRzFNLzZFQUF5YStU?=
 =?utf-8?B?Z3kxVXF5OFRTTTlYVC9Va1RNWlk4QklxMU95dWx2bzMwUTNVQlZ4aVJhZnZH?=
 =?utf-8?B?QlRWSDh3TjcyckNHNnV1dzhWaVFvdVNwN0ltZzdFdlJHMTFBRlRBWFpMRkZi?=
 =?utf-8?B?Q0tZM09WNUVoUUcwUU9iNWM3cmhmV2FiZjVZREdjRWtnd0VLaEY2RFMzYUk5?=
 =?utf-8?B?S0lXRjZBR0t0aEpPVkdLQ2xwRGtUQkFIb043b1hhVFR5NlQvWUlOUUNqOHJV?=
 =?utf-8?B?OVVQdGROSE95ZFZ1TE9pVU15T1FCTGpURGFybUtXeWowZjlkTmpOWXhFOXYv?=
 =?utf-8?B?QjFob0VqSUFMaU0yTWpUVXRuZk82QUIzcG9Edi8veTVxdWljb2FPbk8yVXM3?=
 =?utf-8?B?YmRSaVNPUktRV2VDMnJjUTJUSXpablBGTUQyd1pFNUxTTkg1SVBSVWZGbUdQ?=
 =?utf-8?B?cGgwMUY3M0tvU3RWMFR1T1JEOGJxTURDZUhaeXNHUXNybHlLQmxMUUhjVjZp?=
 =?utf-8?B?UHJRc2ZydmNRREpMVHdlejhQVlA2bTR5dUxsTTJYczhXeWRuT0FSQk12Tk13?=
 =?utf-8?B?NitNN1UzZWt3NTFaTWZuTXVvNmtFNVFwdm9vYUhaWElCSlkvZDlwWXFiNm1H?=
 =?utf-8?B?S1JlTENVdytrYkw3VnVQZ3pwNTBISHNJaDVvZlVybnBqM1Z2d1NqUW8rV2Jl?=
 =?utf-8?B?aXZzLzhyWEY4d3ZQN0I2YkZyUkswT21qcWlJUnR0bFdoTWc0djlEUGVlVE1s?=
 =?utf-8?B?Z09BZUtBNkpuUUR4eUZtTC8wOVBxb3FzM3c5Z1VSUjFjL2dXT0cwcDg5SHcw?=
 =?utf-8?B?dGZWa3ZReUhFRmxLUkd6ZDBQQ3ZLR3Jka1A5VWx2KzlNRVdFaXkvZkdyNGhT?=
 =?utf-8?B?bVorVnJMdGh2b2RPa0RyZmk4alZSc3FGR2IySUFCM0tTOUNPWnkvU29wbTNo?=
 =?utf-8?B?WTY4bmJvNUxkdnJRdmZHNUNjM2xTSzFZelZKdXQreWFEOVkwUkQ0dHFaNGxl?=
 =?utf-8?B?dmpTWmxBejZzVWNKWjRmUDdMR1UzaFBNR2JKeTh5NU1ZY1JRYldXaEhWL244?=
 =?utf-8?B?blVvbUpNQWRoZG1UUnF5WXBzNkd3aW9jZW0ySk91SnVDNkdzakU3UTZad0pK?=
 =?utf-8?B?L3J4STVoZUNGVmR4a2NybVNBTVFkdWNiY0YycVBIVFZoeVZUWlFORGd4NHVQ?=
 =?utf-8?B?R0k2RHcxVVY0RTVnZ25TVVZURjJpWXAyK0l0MTg1SjRCRkN0OG1mZ2tGOHhC?=
 =?utf-8?B?ZENYNEFmaTdIdTZUejluTWQxMEZXVFhINm5Pd2MwVFlpU2QyeXh5RGc3Zndq?=
 =?utf-8?B?RUd0RmpmZlhpZXpFWGVqQ2pkenhiSTRsdWhZODYrNU9mNjR1SWxCR3grSHJ2?=
 =?utf-8?B?WC9qV2FyZ2dHbk9HQW5iTmJHWnpCSFB6SHpJOUhQU0tmVzNYWm1NaGR1S280?=
 =?utf-8?B?cmU4d05aVlY0M2pNSTlBd2ljZExFdHp1bU9GNjFXckJNMkFGMG5ORVhWVlpa?=
 =?utf-8?B?OFNReTQxMW5vNk5JSlp6OTdyaXhtYW5JcDBJWHhYSG9ZNWFDQUxkYXlhdExR?=
 =?utf-8?Q?MTZhcHmxtoSc+hDUzh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MdTRLSkcodcgZqcmeziih6YVt+O/DdTXR/0GvaZl+SyWf9LnIC06qxQEbL6tmJKI97HoIdr1pS+qaaYLPPL5inu8m67q+Tg/8qkC9V1KCaGB25nsRew+cTkfLK8dWqGmdVkWqA9PtE8DxX0zuNkjrsuggvu+fCaiOn2ZfzdfXGjW3cKuLQHc8RxA85IFojGQnmyiKlR9EhCi47Ly62oNR1sDOZvg8/Zg5o5v+ZsGeeMcMRG/u3E9Q9KcIXPNyx7eeegIpTDr11XNnipaY6OCoBvJP+1lC5zxC55JXTSTyGPW4oJ5FoGLPgWhvVZU30jC0rOfcF9GGI43hRp2vt0GdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EA3PR18MB205973.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba2b625-55db-4244-4b23-08df3f448cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 16:06:16.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCaxO3F4ax7aJYukSB21XIMsw7PxN5JWu1o95WB/Y3+lsNUAtlavKgvdyieVPXWF94+s5cHDDRnu5JRW7wLuRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3641
Return-Path: kpoduval@lab126.com
X-OriginatorOrg: lab126.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 16:06:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20413

VGhhbmtzLCBSb2IuIEJldHdlZW4geW91ciBtZXNzYWdlLCB0aGUgT0U0VCByZWZlcmVuY2VzLCBh
bmQgc29tZSBjb252ZXJzYXRpb25zIHdpdGggY29sbGVhZ3VlcyBpbnRlcm5hbGx5LCBpdCdzIGNs
ZWFyIHRoZSBib3RvMy1iYXNlZCBmZXRjaGVyIGdpdmVzIGEgc29saWQgcGVyZm9ybWFuY2UgZ2Fp
biBvdmVyIHRoZSBDTEktYmFzZWQgcGF0aC4NCg0KVGhlIG1pcnJvci11cGxvYWQgc2lkZSBpbiBP
RTRUIGlzIGludGVyZXN0aW5nIGhvd2V2ZXIgSSdtIG5vdCBzdXJlIGl0J3MgaW4gc2NvcGUgZm9y
IHRoZXNlIHBhdGNoZXMsIHdoaWNoIGZvY3VzIG9uIHRoZSBmZXRjaCBwYXRoLCBidXQgaXQncyB3
b3J0aCBkaXNjdXNzaW5nIHNlcGFyYXRlbHkgb24gYSBzcGVyYXRlIHRocmVhZC4NCg0KVGVzdGlu
ZyBhbmQgZmVlZGJhY2sgZnJvbSB5b3Ugd291bGQgYmUgdmVyeSB3ZWxjb21lLiBJJ20gdGVzdGlu
ZyB2MiBvbiBteSBzaWRlIGFscmVhZHksIGJ1dCBhbiBleHRlcm5hbCBkYXRhIHBvaW50IGFsd2F5
cyBoZWxwcy4gSSdtIGFsbW9zdCByZWFkeSB0byBzdWJtaXQgdjIsIHdoaWNoIGFkZHJlc3NlcyBS
b3NzJ3MgY29tbWVudHMuDQoNCi0tDQpSZWdhcmRzLA0KS2FydGhpayBQb2R1dmFsDQoNCkZyb206
IFJvYiBXb29sbGV5IHZpYSBiaXRiYWtlLWRldmVsIDxyb2Iud29vbGxleXdyPWdtYWlsLmNvbUBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNiwgMjAyNiA0
OjQ0IEFNDQpUbzogUG9kdXZhbCwgS2FydGhpayA8a3BvZHV2YWxAbGFiMTI2LmNvbT4NCkNjOiBy
b3NzLmJ1cnRvbkBhcm0uY29tOyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc7
IGFybWNjdXJkeUBnbWFpbC5jb207IHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc7
IHN0ZWZhbi5oZXJicmVjaHRzbWVpZXJAd2VpZG11ZWxsZXIuY29tDQpTdWJqZWN0OiBSRTogW0VY
VEVSTkFMXSBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDEvMV0gZmV0Y2gvczM6IGZldGNoIHZpYSBi
b3RvMyBieSBkZWZhdWx0LCBmYWxsaW5nIGJhY2sgdG8gdGhlIEFXUyBDTEkNCg0KQ0FVVElPTjog
VGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25m
aXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KR2xhZCB0byBz
ZWUgd29yayBiZWluZyBkb25lIGluIHRoaXMgYXJlYS4gDQoNCkkgaGF2ZSBiZWVuIHVzaW5nIHRo
ZSBTMyBib3RvMyB3b3JrIGRvbmUgYnkgT0U0VC7CoCBBcmUgeW91IGF3YXJlIG9mIHRoZWlyIHdv
cms/wqBodHRwczovL2dpdGh1Yi5jb20vT0U0VC90ZWdyYS1kZW1vLWRpc3Ryby90cmVlL21hc3Rl
ci9sYXllcnMvbWV0YS1kZW1vLWNpL2xpYi9vZWF3cw0KDQpPbmUgb2YgdGhlIGJlbmVmaXRzIG9m
IHRoZWlyIGFwcHJvYWNoIGlzIHRoYXQgcmVzdWx0cyBnZXQgbWlycm9yZWQgaW5jcmVtZW50YWxs
eSByYXRoZXIgdGhhbiBhdCB0aGUgZW5kIHNvIHlvdSBjYW4gdXNlIGl0IHdpdGggc3BvdCBpbnN0
YW5jZXMgdGhhdCBnZXQgcmVjbGFpbWVkIGluIHRoZSBtaWRkbGUgb2YgYSBidWlsZC4NCkxldCBt
ZSBrbm93IGlmIEkgY2FuIGhlbHAgdGVzdCBpdC4NCg0KUmVnYXJkcywNClJvYg0KDQpPbiBUaHUs
IE5vdiA1LCAyMDI2IGF0IDk6MTTigK9QTSBLYXJ0aGlrIFBvZHV2YWwgdmlhIGJpdGJha2UtZGV2
ZWwgPGtwb2R1dmFsPW1haWx0bzpsYWIxMjYuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdy
b3RlOg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMgUm9zcywgbGV0IG1lIHJld29yayB0aGUgcGF0
Y2ggYXMgeW91IHN1Z2dlc3RlZC4NCg0KLS0NClJlZ2FyZHMsDQpLYXJ0aGlrIFBvZHV2YWwNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJvc3MgQnVydG9uIHZpYSBiaXRiYWtl
LWRldmVsIDxyb3NzLmJ1cnRvbj1tYWlsdG86YXJtLmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
PiANClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA1LCAyMDI2IDU6NTUgQU0NClRvOiBQb2R1dmFs
LCBLYXJ0aGlrIDxtYWlsdG86a3BvZHV2YWxAbGFiMTI2LmNvbT4NCkNjOiBtYWlsdG86Yml0YmFr
ZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnOyBtYWlsdG86YXJtY2N1cmR5QGdtYWlsLmNv
bTsgbWFpbHRvOnJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc7IG1haWx0bzpzdGVm
YW4uaGVyYnJlY2h0c21laWVyQHdlaWRtdWVsbGVyLmNvbQ0KU3ViamVjdDogUkU6IFtFWFRFUk5B
TF0gW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAxLzFdIGZldGNoL3MzOiBmZXRjaCB2aWEgYm90bzMg
YnkgZGVmYXVsdCwgZmFsbGluZyBiYWNrIHRvIHRoZSBBV1MgQ0xJDQoNCkNBVVRJT046IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0
aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KDQpIaSBLYXJ0aGlr
LA0KDQpJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoZSBjaG9pY2Ugb2YgdXNpbmcgYm90byBvdmVy
IHRoZSBDTEkswqAgdGhlIHBlcmZvcm1hbmNlIGdhaW5zIHlvdeKAmXJlIHNob3duIGFyZSBub3Qg
aW5zaWduaWZpY2FudC4gSG93ZXZlcuKApg0KDQpPbiA1IE5vdiAyMDI2LCBhdCAwMToyNSwgS2Fy
dGhpayBQb2R1dmFsIHZpYSBiaXRiYWtlLWRldmVsIDxrcG9kdXZhbD1tYWlsdG86bGFiMTI2LmNv
bUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiB3cm90ZToNCj4gK3RyeToNCj4gK8KgIMKgIGltcG9y
dCBib3RvMw0KPiArwqAgwqAgaW1wb3J0IGJvdG9jb3JlDQo+ICvCoCDCoCBIQVZFX0JPVE8zID0g
VHJ1ZQ0KPiArZXhjZXB0IEltcG9ydEVycm9yOg0KPiArwqAgwqAgSEFWRV9CT1RPMyA9IEZhbHNl
DQoNCkluc3RlYWQgb2YgcmVzcGVjdGluZyBIQVZFX0JPVE8zIGluIGVhY2ggb2YgdGhlIGZ1bmN0
aW9ucywgcmVzdWx0aW5nIGluIHF1aXRlIGEgbG90IG9mIGNvbXBsZXggY29kZSwgSSBzdWdnZXN0
IGEgc2xpZ2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoLsKgIEluc3RlYWQgb2YgaGF2aW5nIHRoZSBj
b25kaXRpb25hbCBpbiB0aGUgbWV0aG9kcywgaGF2ZSB0d28gaW1wbGVtZW50YXRpb25zIG9mIHRo
ZSBTMyBmZXRjaGVyIChzaGFyaW5nIGNvZGUgdmlhIGEgY29tbW9uIHBhcmVudCwgaWYgbmVlZGVk
KSwgYW5kIHRoZW4gcGljayB3aGF0IG9uZSBpcyB1c2VkIG9uIHRoZSBmbHkuwqAgU29tZXRoaW5n
IGxpa2UgdGhpczoNCg0KY2xhc3MgUzNDb21tb24oRmV0Y2hNZXRob2QpOg0KwqAgIyBjb21tb24g
bWV0aG9kcyBjYW4gZ28gaW4gdGhpcyBjbGFzcw0KwqAgZGVmIHN1cHBvcnRzKHNlbGYsIHVkLCBk
KToNCsKgIMKgIHJldHVybiB1ZC50eXBlIGluIFsnczPigJldDQrCoCAjIGV0Yw0KDQpjbGFzcyBT
M0NMSShTM0NvbW1vbik6DQrCoCAjIGNvbmNyZXRlIGltcGxlbWVudGF0aW9uIHVzaW5nIHRoZSBD
TEkNCsKgIGRlZiBkb3dubG9hZChzZWxmLCB1ZCwgZCk6DQrCoCDCoCAjIGRvd25sb2FkIHVzaW5n
IHRoZSBjbGkNCg0KY2xhc3MgUzNCb3RvKFMzQ29tbW9uKToNCsKgICMgY29uY3JldGUgaW1wbGVt
ZW50YXRpb24gdXNpbmcgYm90bw0KwqAgZGVmIGRvd25sb2FkKHNlbGYsIHVkLCBkKToNCsKgIMKg
ICMgZG93bmxvYWQgdXNpbmcgYm90bw0KDQp0cnk6DQrCoCBpbXBvcnQgYm90bzMNCsKgIFMzID0g
UzNCb3RvDQpleGNlcHQgSW1wb3J0RXJyb3I6DQrCoCBTMyA9IFMzQ0xJDQoNClRoaXMgc2hvdWxk
IHJlc3VsdCBpbiBuZWF0ZXIgY29kZSBhcyB0aGVyZeKAmXMgYSBjbGVhciBzcGxpdCBiZXR3ZWVu
IHRoZSB0d28gYmFja2VuZCBpbXBsZW1lbnRhdGlvbnMuDQoNCkNoZWVycywNClJvc3MNCg0KDQo=
