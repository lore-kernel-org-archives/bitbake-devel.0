Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133BE77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 22:49:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.72])
 by mx.groups.io with SMTP id smtpd.web11.24868.1733438988802267558
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 14:49:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=X3DpnoXk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.72, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAXLUGkUBz5A2hji7m24NWq7NQzyiu2qz2mHTnTVMBZnFySZnapHJuZ4A/aNbjLTQr/EQxNNltkA2qfkIE46gGxW4ZmlvLd7TG1GAUYavLFmMx7QvAYY0s1skZaJ4QR4girN5160nmMAqu9S0iB86DfA7Xh5cvrbizWlGtRa/iExvqDUz4mMXh+jNgziS2DCQrGJxjIhNEw5vgVilfB34OvvINeFMU6/kWBEVNCbOeiWHkR1LZGzmtroxyHZGJ8+Ci5joRBXOeVTfVUxwL0bo5XxlZMVRRmEyGyr3Y4s5DoZfGg4kYEMN3DdMpKXTQmG309z3fnELt+fJ69tAJhmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH9Sb+xbR3h2hc9MWjw2vYZWdQ9CWKc6lt/Ja5SDgi8=;
 b=qPtxv/vSufd2WW8wmudk0KBdzewPGAQZFqFGQIJhYuWXr9MVZt+8OHA7+X/vuK44fNnYQTlZGyLXvyZu9Y9r066eSJjcJm+yVCI+VeiSWFgzFRiMdH81qBxLyFPPw2XjcjvSCT5NrtO+k5eo3R5TRUmQi3Tfhd+18MyFvbyBH0BJaLd0Zff47Vnw6p0G5MVj109N5Sstxd15AA7XNjzubNmSyB9qd08eLW8pOOWsQM9lxsJFp2AQQMEDj4Ftffkk4mBfe0rNglFRhf9MmloQXhMfjDnvI+YEwe2j9XFH701Nuedf6PqzZJxKJ+KbfyZCULOSrZ1RbkjYna9fXcG9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH9Sb+xbR3h2hc9MWjw2vYZWdQ9CWKc6lt/Ja5SDgi8=;
 b=X3DpnoXk59Ayb8gQbkwBpHtJcIIe5HVCGDTZq0xdKxUW859iytD7T6eoF5I3KHmRtlVBZUmXF5j5S0K89dalOLGpKyuzURPH57XIwX7btrDjLR7iBIXlu82nyEFeoiAIyhMy6cO3inYrHUQOTn4+qgPUyEeqDwc5hx9nxi3SATSBj/+FeLBF9ugS0bi4xSPyV16ESpDe3Cf9g96n0ybGR+DOmkmrpxUlxWtZJCGF04PWyF56u/pVaYp6MvoxtAq63sRj0Ixa+uc4HKM4p0AKh32bGCrcrjdvbWh47DApCZ02rRB/qb9D3bZrU84iV6hUVkrARRbBlhnRhctdiLP6ZA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 22:49:38 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 22:49:37 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "JPEWhacker@gmail.com"
	<JPEWhacker@gmail.com>
CC: "dave_clouser@agilent.com" <dave_clouser@agilent.com>,
	"steven_kirk@agilent.com" <steven_kirk@agilent.com>
Subject: RE: Bug with SkipRecipe and multiconfig
Thread-Topic: Bug with SkipRecipe and multiconfig
Thread-Index: AdtHQz0+yx7PiPzVSNOEZrPjczrnLAAH7ocAAAEwC5A=
Date: Thu, 5 Dec 2024 22:49:37 +0000
Message-ID: 
 <DM8PR12MB543059D1B693AF74043148D78B302@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB5430DF7192F8D0BF7E6F2BE58B302@DM8PR12MB5430.namprd12.prod.outlook.com>
 <ece3d65d6094445cfcb834e18dffd62a472210ba.camel@linuxfoundation.org>
In-Reply-To: 
 <ece3d65d6094445cfcb834e18dffd62a472210ba.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=62650d5f-b7f8-43ff-a52f-17f8cd500173;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-12-05T22:47:52Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SJ2PR12MB8738:EE_
x-ms-office365-filtering-correlation-id: 138a35dd-2e58-4a63-a5a1-08dd157f18e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SXRyTVR4cmlPaUppSHRJdjJBM3FDRGxTUTdUU2VoNmVZTC8yOUFsRUxNV3BT?=
 =?utf-8?B?RStDdTY3Qkw0eG5sSGZ1bkNFbGhtS05LeXRiUWQwL2Rwbk9tQ1hWbEd6WUdB?=
 =?utf-8?B?VENGRHlmdS91Umw1cTYxYkN6N3dtcGxNR1Bpd2hXMTJoUkhYbXlBbXVSeVVv?=
 =?utf-8?B?NnM1cUcwQjhuR0swVHAzSExJTVJEMnFITktPSlFUOHFPWXRUd1QyVVNkTVlz?=
 =?utf-8?B?dVFVQ1Y1Um1xUTNveHh2cDltUFdLU09PbGNBdHJiTkhVa293T2QzelMvQXYv?=
 =?utf-8?B?NGFCck5IcnFNR0FSa2RZNjhUNHRIRmlYemRLY0kzdjlvMW1lZVkxaldtL2gv?=
 =?utf-8?B?NExyY0pFRy9FT2JPc2lQV2hVeVFKZEltUzlXTmRpdk9JVXdWbmZUNzh3SDN0?=
 =?utf-8?B?bjR3UTBXUnNOL1Nib015clJFSnB3eU1LeHZlQ01VL0JhZXpMb3orbGxEb2po?=
 =?utf-8?B?YllqMUE4MmpQbzhTK3h2Yk5TK1NmR2tsQkJxc2grd3MyOUNCeERWcXJ0OVdR?=
 =?utf-8?B?TCtZRDJEdWE2d3NublpQQ0N0d2cxK1VZUE1ldHRSR3JRakZTdzQremhXSlhJ?=
 =?utf-8?B?bGFGbHIrVmRDeTBkNHJWMDhSZUhoVDVYcDFyalVudmpEaW5TWlQ1SFh4R3FU?=
 =?utf-8?B?cUFzTEZ0TlFPVkQyUGFaanB6VlM4TjlYd3JxTGw2aVpwNVcrTlVDNTZQMzd5?=
 =?utf-8?B?djF6aGtmUVlkTkZ2Tk01cFNnZ25oN014YUlENnVhb0RWc3BoTXg2OVU3elZ0?=
 =?utf-8?B?NVdpSThZNlJwZGlVamtJM0dxOCt0OW1wQzVXNS9yZW5GNGRpS0RaSHlMbDBN?=
 =?utf-8?B?dGZZMnhzWm5vaTdzcWU2TmVVM2lFRUxYVENzT0U3cUN6SDdkT3Q0c005Yzl5?=
 =?utf-8?B?SlRkYmU2TGVvcW9NMjRac3VGQ0hnWjBucWdqSmd0TUV0b1NpL3hlQ2FEK1Zh?=
 =?utf-8?B?SXpBd21XbHJqTy84QW1FZSs0L3Z6RU4ycG9FV0ZLUnQ5alQwdkcrVGgzOFJm?=
 =?utf-8?B?eHVlemNMUHBnZ1dnUVRPMUxpeGpueW5ySjVicEw3MXlUdzJZQVplbnpsT280?=
 =?utf-8?B?NEdydno1eWVvRlBya1ZTb254ajJPV29uY2ZPY3Y1ZkFPVTJwb0NicXBuaHNp?=
 =?utf-8?B?T1pzQ2JhNWplZG9lMFJlaU9iZ1ZjaUg4ajRHb2VFMkdGU1IwRkh0RWFHcFV3?=
 =?utf-8?B?Myt1VGVsVXJPNll4ekc1VEJFd0RFOWdZU2I0SVZJOWtsY2VyTEJTbTJuVjls?=
 =?utf-8?B?TEFpTVM4ZDRpcUMrQmc4eko1cDFDU1RkUGlzY21tUldTanhOS0tUYzFlSTA5?=
 =?utf-8?B?Y1dmRmRpYnhYZzhST1ZacU9PSGNSSDRoT1ljQ2xMblhndlU0T3VUNDFGMDFn?=
 =?utf-8?B?c21Mam9DVWhmYldISFkxSGVLZStJbzBVUWFUeW1keC81M216c21VYWNHS3Zr?=
 =?utf-8?B?ZDNEWVduY1RmTThtMisxcDRhOEtxUjYwRzdYSElvN25lZ1NnNERtZm9GY2t3?=
 =?utf-8?B?WnZTV1c0T1FoaWduWGFLMlc3d3p4ZnFLSmpnbzNBdHp4RzlpUVpUNU1nN2xl?=
 =?utf-8?B?ZGhQWUtXSGI1WXVxMEdvVlJldEt0ci9LRitpUm5oSTJMWndubnpycHVSb0ZH?=
 =?utf-8?B?Vk4zd1lpdjZOOWtXSC9MdVFRUzgyMGt4Ly9TbG9YaG9nVmcyWTFUNHVzbmdE?=
 =?utf-8?B?VUtmT1NtTXAzaE5rYmtHVWRXWlYyM2xGVFdVUHNza3IzY25acHhUUXV6MlEz?=
 =?utf-8?B?RXhsQUh5MkNQSW5rNk0zZUNZMmhtaWhLY2xBWWtxUEdEL2YzWExUNkpzM3dK?=
 =?utf-8?B?eVR3a3cyMFN4N2ZYb3hZa3JONGhDUHYwOVNBd2VOa1NocUd1TTFwS0pWb3BT?=
 =?utf-8?B?TjZSOEZKTWp3WVFmTTZlczF4UjhoYmw5VjBXdFR0b3dsNkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R0xvVk1CU0FRT2NBNlZHWUFoR3Z5SnR3WS94N0N3R1JuSFRjTTNpQ0tUZjlB?=
 =?utf-8?B?bk1WSXBmUTFYUGZQNG1kZm1XU2lTcmlNZHV2ZHVtem5NdWVhNy9Hand5dDlj?=
 =?utf-8?B?N0g2b2FZS2VmNUxRWkR1NmhlUXdsMU1pS2NHUTNnL0p1ZzEvZEpsTTc2WFlp?=
 =?utf-8?B?aTBvbHZjZTdtb2ZVSzBiSVcwV0UwUWoyNER5WG1USk1qWFE5d290TUhrRnJ4?=
 =?utf-8?B?czNid0V1ejRMbFVVbXcraERDRTFCcUxUZTNSY1JkeVBYZnJBMFo4RTRVb2l3?=
 =?utf-8?B?dll1cHJrOVh1RFAvVElYQzYwbkhFWjNQem9QQUo4dVBvV2hCTU9KNEpiYUY5?=
 =?utf-8?B?VWUyZGlsUnFWbnNIaUJKWThSdi9sL3RLWFVzRkp2SC9JMFI0S2FqTlpJbUxW?=
 =?utf-8?B?L2Z4cVFTNTc0TmdaM0FCcnJlYUpLUnRrL1lOcEpwYm00M1JCSGt4bTlTTGZl?=
 =?utf-8?B?UEdNeFpHbTI0U0hKRy9rNlUxa3h2ZWhtS2IrQ2l2czR4MmFJeXhBMStZVlJ6?=
 =?utf-8?B?ODJEYUJwN3VXNFBGMVQvZ1hLZHE1YTcvVmE1dDhWR1dzeFVGU0ZkOFNnZFA1?=
 =?utf-8?B?Q2kvazZVWHlsT0M3U1NXR3AzWHBPdllndlF6YS95ejB0REM2d0tySzRFM1Ni?=
 =?utf-8?B?Lys3dE1nZDZJTXUzQ3psZkVCUkVsb2xlcWxhb25WK2EvNERBRThXM1FoUVlZ?=
 =?utf-8?B?aVJaYWIzQjZISWxLT0FPZ2tOZitZYm0wTDc4Q2hyWTBQNWxHUGVMN3NPV2lX?=
 =?utf-8?B?aFVxaTRPSWI0N0xSbVVRYUdYb2JFQmdxdFN4S05yR2lDZk1JdUFWNS9IVkhU?=
 =?utf-8?B?SldUcjZ0THdCcG1IU3hHb3VBTDJKcjN6ZDFRWWJiYzYrV3NwbEtla3BLK2VC?=
 =?utf-8?B?S210eXFVOHQ5SmlKYU1INU1oZ3gyVmxuVXNBNnFCNnBpQStBZWloMkJqSHVE?=
 =?utf-8?B?WHNiRmFJVXBWM3daQjk5dnRhRW16M3V4MkdEdW1NV1J6UEdWckRJVldLYlBN?=
 =?utf-8?B?UnVobmNtR1kwT296MkV3Q3FrT3Vmc2FIa1VBbC9kZTAvWUpCMzdRcmFsdDNQ?=
 =?utf-8?B?VHRlQzY2ajZCS2J1bnJsaGp3T3d0WldaRFRiNEZCL2YrSDdwemt1MVRsYnBC?=
 =?utf-8?B?R3dmZTJ3MThkVExJM3hOb0xYTzVZcytKTkQ2Z1dMZGhQZndrNnduQzNDVklD?=
 =?utf-8?B?clZmMi9CWlRnb1dIdW9CQW94eDI1QXpKZVNnZUl1WHZ2RmpXWC96TTdTaTFt?=
 =?utf-8?B?KzNDUzYvcC9KTHh1OTdIaFZZam9uOEF1UUU3MVd5WmFiUEM3cW90YjhBUU92?=
 =?utf-8?B?RkIrclFCbFljSHMwbUhLS1lsb3llWEZoSkVteE1IMWV5bXVJNVoyMXlHYzFY?=
 =?utf-8?B?dVZVczRaYi8wUGFBd0k1akE2aHJCazVFNWZ2UmY0NkxEUlZNRmhycTV1amZt?=
 =?utf-8?B?T2xIZ3BPdGNyd3lETjhPbUxUZThhZzQ5UkU3VUt1UER0ekVTVnRteXV6TU4y?=
 =?utf-8?B?bU1kTkozRG5OM3lneWVpS1pZVkhCUTNZenp5NnRiSVhFTXdNczZkc0pJZExO?=
 =?utf-8?B?Y055R3dRTkpQczByRWJhQW1CcXhqNlRmQVdCNkJYMm5jVFJvZitUQU4waEMy?=
 =?utf-8?B?bHUzRVR4NHpFR3BoT2ZDTTI0RFB0cHFGVXlVNENmSXhhM1VFVi8wYXExeEtH?=
 =?utf-8?B?VmJ3VEVORUFUQS9qUlgvdGtUc1l4ODZ1Z1hya2RONEFnUUFsaTQ0cFpzTjNW?=
 =?utf-8?B?aGpmQkt1K3FPYXVlak9uMmt0ek9zdGIrR0VYY0NXSlBWZittRDVURk54YmIw?=
 =?utf-8?B?M09CUXNPdmxBQWtOZDRKanh6RXRVbDJZeUd1VHA5cXFTTW1Qbk45a2tMV0xB?=
 =?utf-8?B?ZHgvMDU5S0xoS2dVcmhEUW5QMERRVklkTmU3RkNYRmRFYmFpR2hZejJiSDFC?=
 =?utf-8?B?YWtiY2kwVXpKN0pOdXdGejM0NEdBMnhmd0QxajhJYkhiZzlvZ1NQTkNlNG5r?=
 =?utf-8?B?UHFxN0x1TCtvWEkyS3M0ZWtNWUIrYjNHNTdtTFhRcnBSZ3dpdHRITzh3eUdl?=
 =?utf-8?B?L1FXVEFXd3dwWjdHRWVYWTlNeUhzMFIvVzd3T3U1RHRhZGtQNDh6YzdTN3FL?=
 =?utf-8?Q?OOYXZA1AnddV0CtWCblrAFX1t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a35dd-2e58-4a63-a5a1-08dd157f18e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 22:49:37.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEsS7kb+gDgrwcPQ2k6xx7p1edncNQP6+vW+76bSvfGR1uSuboQjnP/H4N5BMQsrOmpr7Ttk0zOWPdh4/aXrM8uHC1uk5edCs1s8iZH9eKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 22:49:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16890

SGkgUmljaGFyZCwNCg0KPiA+IFRoZSBpc3N1ZSBJIG9ic2VydmVkIGlzIHRoYXQgd2hlbiB5b3Ug
aGF2ZSBhIHJlY2lwZSB0aGF0IGlzDQo+ID4gaW5jb21wYXRpYmxlIChlLmcuIGR1ZSB0byBDT01Q
QVRJQkxFX01BQ0hJTkUpIHdpdGggbW9yZSB0aGFuIG9uZQ0KPiA+IGFjdGl2ZSBtdWx0aWNvbmZp
ZywgaW5jbHVkaW5nICdkZWZhdWx0JywgdGhlbiBCaXRCYWtlIHdpbGwNCj4gPiBpbmNvbnNpc3Rl
bnRseSByZXBvcnQgd2h5IHRoZSByZWNpcGUgaXMgdW5hdmFpbGFibGUuDQo+ID4NCj4gWy4uXQ0K
PiANCj4gPg0KPiA+DQo+ID4gRG9lcyB0aGlzIHNvdW5kIHJlYXNvbmFibGU/DQo+IA0KPiBTaG9y
dCBzdW1tYXJ5IGlzIHllcywgaXQgZG9lcy4gV2UgcmV0cm9maXR0ZWQgbXVsdGljb25maWcgdG8g
Yml0YmFrZSBzbyB0aGlzDQo+IGxvb2tzIGxpa2Ugc29tZXRoaW5nIHdlIGp1c3QgbWlzc2VkIGF0
IHRoZSB0aW1lLg0KDQpPSywgZ3JlYXQuIEknbGwgd29yayBvbiBhIHBhdGNoICsgc2VsZnRlc3Qg
b2Ygc29tZSBzb3J0IDopLg0KDQpUaGFua3MsDQpDaHJpcw0K

