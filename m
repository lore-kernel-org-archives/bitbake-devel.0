Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39604C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 16:52:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.40])
 by mx.groups.io with SMTP id smtpd.web11.15692.1740675123984228284
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 08:52:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZVTA2QIB;
 spf=pass (domain: siemens.com, ip: 40.107.22.40, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmO+mBZUocvpiia4YGs74fYh9BFdW8Aj4Rob8HwclmCob6xyWWbnt5PAylo6cMO4P3VwlR27NgZ0wzRTencrJbIIMtN0oSR04bcp0QlCMqjS+YZPe7L7vTGWRHi1PuaaAZSqoMvnvCm8hmdYRdn01oGpaRpru/hwHnjS2sPYy8MBsAIBNyB+g2ORBxWHaT5tgHv+xzVy/GV4c6KBO3pniKlTFQ823NgCIoy6NxKM6ZwQjcQh8GiG26TAhgB1V5ZWE9VebEyz0gymy7BePmE+4zJpvLJBNRh1UHFZesxDIWcqtkYLgKlboMnsSzjiyorGs9qVjFfX78AR1JAOfGOG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYG7jS+5G6/RlLnTvr8IzcuarpTWSnXWfVwiJGoR8Vg=;
 b=Kw7c2dNYFArQaB/2zqgLxpuEMDYib9ywbNfIlv5klOk6qE6U8MXCXRIwZMM87TGVuNzpsNyJ6UxrhCHEE8rOw3BC54nhDB4O4DdNcGagmXl2z6YxMjbq0oS/ImAzUlLIBAQjNqEY3qdeeBe/SAGAmkx23D/ejpESTax2DmN8IZsmP7tfoyXJerpCTgCenLwkh+o3pCSCJeGVVuOuo8IK6Qdb5stufxq/wlhXmNGkbnRKKETZ7/W+iK38F8HgBCUyK/eWKa30Lr8AlEPpLCvdd9+G+jzY/3JGnt+DFjqiew1E6A4KOemhWl89EBNtD9oTgricO9CIRZSZVShXvAMwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYG7jS+5G6/RlLnTvr8IzcuarpTWSnXWfVwiJGoR8Vg=;
 b=ZVTA2QIBg5DdeW0msUaAX/ho3YMRk9v7angUMPiVhxQREQD18/ma2e5LgwBlaAZA/pYEZqyDKEAN+GBgrZhEnsG+5nZjcQGpRHKb5XssSfeITrWSAPumh+L4ckz/zuNiwXSHYtD8rOBjveRyt+WiGyniX9cOtzvN0zo64tM9VlEbhMjPrx9yVvWRcwuSh1lxSJoJ9slJI+iJXl9sDLxomKirU9bc/lUaAwvxxo1pTpgXm/OzfcGy5Gou+BBZRC+vSDw8JMcli0vlCFCIsQEyh9ZTUTiSOqX/6QaB+Kp5sKKrkTyIoCx8l10CGHhKOa7GXX8C9IIc+ZG+SiLH1as29A==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM0PR10MB3620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 16:52:01 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:52:01 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "mathieu.dubois-briand@bootlin.com"
	<mathieu.dubois-briand@bootlin.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Topic: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Index: 
 AQHbg7ywZJqt9JvQhESFPikUXBi+bLNWX0eAgAAQGoCAAARbAIAAQsQAgAGQ0gCAAQUEAIAABYUAgAIWggA=
Date: Thu, 27 Feb 2025 16:52:01 +0000
Message-ID: <58893f3ee1cdfd9d9769f4c0d3b5eaa19adad1d6.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
	 <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
	 <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
	 <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
	 <06ab9baa1ee1d5e22403f63b6074789412f7d501.camel@siemens.com>
	 <D828Q3C1GEJQ.22EIS7ZR8OKI3@bootlin.com>
	 <71d9ba0fa4b44a27f3e221b69039b816a882f522.camel@linuxfoundation.org>
In-Reply-To: 
 <71d9ba0fa4b44a27f3e221b69039b816a882f522.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AM0PR10MB3620:EE_
x-ms-office365-filtering-correlation-id: 9e8190b5-5ec1-43f3-a53a-08dd574f0e72
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cURNK0R0blYvMVhiUWRGTFQ3Y3FLblR0WkhQanl6L2NxWVFEU0tQTDI4UmlT?=
 =?utf-8?B?djlvdDRtUkZRZmxNSE1BMlB5VlBXS3JNR3VMcE0yK0NhTlU3dGZOdkRwQStz?=
 =?utf-8?B?bGNEVVhHN3BXYXlTYko4ZHZCeElZdENIOFJ4SEpPQmlDeXZZdE5yR2dJRHR6?=
 =?utf-8?B?NDdhS2F3SmVnZ1RPZkcwVWVuWFkvWUVDSUhzekR1RmVoMFF4MmdBT0JrMC9X?=
 =?utf-8?B?U2FmZk0zQmJGcUhXNGpzMjRPd1dzMC82c25nK3psdjlmTXUzb3VMNXREME41?=
 =?utf-8?B?OVpxUklqcVlqT1NRR0dnZk14K0FGT0V5UGw3dnJyLy9Jd0VTMjNicmtpeXlk?=
 =?utf-8?B?aVFTeDNwYURYdHN4N3lxd3FOMEduakJnQlF3dVRkbjZpS3ZLYkdGSSs3bHdw?=
 =?utf-8?B?ci9VNnhXS3UyZ1R0d2xMaklxSUhiTXRFUmZOUUpsNlYwckdQZzVMelJXaWNz?=
 =?utf-8?B?a1g1T2VEdmlqWnNqZXBYOVB5dXUwRzdOdHRPeVBKOHJkK21DY3pnWHAxU3Va?=
 =?utf-8?B?YytyemdUVlVZZHpmNDMwMlJ4Szd3L0RNeXdhYmx0cVd0TFdCYlF3MjA4S211?=
 =?utf-8?B?ZStTRnpqMjRVdERlZzhWRHNBNHpEQ1lDK2lOd3BZcVk3UlhlQ2loYWpGZ2xV?=
 =?utf-8?B?b0pHVC9lc3pxOHZ2SWNUTlBidFpMK29tcU9aNUFlVFNmNUlabEl0UzFzWW1Q?=
 =?utf-8?B?RzZHYmNKRHFxdVl0Y0IrTk5xQW9iRnd5OFo3SHAwamhwSHJsb3dPcVBOSDhR?=
 =?utf-8?B?UHZJTUpabHpOSzZ1UVlIR1ZuMEZuZldvYnRZRkx4ZjM3OFJlajV5NGlxNFJH?=
 =?utf-8?B?VnA4TzRBQkd4V3JNK2dMdTQ1NTFKWFpSNFZ6ekp6SXdnVWFUS3JQQklUOU93?=
 =?utf-8?B?WVl1U0tiNlZUTDZETU8wbkpZWXR6M2dnczFvb1p4cDJ1SzRMTXZZMGJFT2Rn?=
 =?utf-8?B?RE5Fa3dSdklKMFI5TXZWMUM5UXRvN1ArMExxd1NQNGpQeXZYYzFxUjlPV2lM?=
 =?utf-8?B?MWdMeVlDcW9HVnF2WGI3T3hZaXNVSlUvZ2R2WDhxU1lZQzZkZ3ZvZzZBRjRx?=
 =?utf-8?B?MWp0YXZvcEd4YjI1RFlLelpaeXVHVWZxNGN6NjEwZEZSbTZQZ2x6dGpBbmN2?=
 =?utf-8?B?K1dzMzlKZVlGNHNudldtMWNmaWZMV09PeURUR2V1NUJ2bGdBZnI4bU1lM1dU?=
 =?utf-8?B?OGlDZEsxSGVQOG5ZbVA0OTdrVElHR1lVR1EyMkJYWnBNajVEV3dTY0RUK251?=
 =?utf-8?B?YitSVDJEK2VyZElTZjNNMWRTY2gvK2FXOERDR0VhRWF0NGtSNjNlKzhWaW9p?=
 =?utf-8?B?V2pIWUlHZkowMGRHM054bXdxMnluckpETXpsSmMzaklOVGYxZHc3Rk0zS1d2?=
 =?utf-8?B?K1llWTlpem1hUzcxRVFubEc2UUJCM29CODdhMlRpSnViSHpqZE1qZk1ycU5j?=
 =?utf-8?B?L2FKTnUzNEx6YW5wd1A5czMwT0RZdlN4N05MSWdFMVJ2blJjYWdCWU52aDVn?=
 =?utf-8?B?Ny8zZ0xDQmRoeGEvMzhaZ0t3QVdoNXVDNHhSazNjZ1BEeGVzeCthQkplSHRm?=
 =?utf-8?B?aDY2NEtiVXJ3MG5tYXdJeEVxRmZib0ZjM1QvdCtLK2czNG1yejNhTTc0bFJI?=
 =?utf-8?B?d3BpUU1zQ0wxMW10dSttSmk5NlRGSXB4aFdQcmxZUldWcWVNWVhoMS95TmJC?=
 =?utf-8?B?ZE5wa1gzbno5anc4NXA3RmNkMHlGSXYrNTgyTWE4TU9lZVVEREZPZzkydjFr?=
 =?utf-8?B?ZUcybGR1a09COVV3ZHJvK29kd2VRN0RDZXdsWCtCOGVNZHpDZTYzUGZPNUZh?=
 =?utf-8?B?ZW1JcitTWFJhLzhnYjA2NEt0dGJZbjI1WHpzZG5mOFJwTC9tZDRzQTBxWk43?=
 =?utf-8?Q?0nOn2vmF/5xoW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UzF0WmNCbm1rQ0ZmQ1VPMmdnbG52UmVwY1BQL0tLd3VuVnhxNkxMQi9KeDJX?=
 =?utf-8?B?NkJXTTVCcW1KUm56Q1ZmUHFqYzNrQnhXTHl5eXdERG13Z2VtT0ZLdjFiRGFS?=
 =?utf-8?B?cCtnQmdqdndwaElyYVZmOUt6eXBkbjZFbkh6a21GUmxlRW04aFRnY2FZdzRy?=
 =?utf-8?B?V3F1V21XUjBreldVZjNKNWxOVW5SdjlWMURkYVlCUHZsNDJtbmdUZ3lJcW5n?=
 =?utf-8?B?RjdUcU5QVDNJa3NPZlM5RmFpZzd6SlMrMk42VkQ5ZnVYM204TDhvRHUwVWl6?=
 =?utf-8?B?cUZrQVJTNUZEd0NYc2FhQmdHMll4dVB0MXFYamtYenc3S0VxNGxubS9RbTVC?=
 =?utf-8?B?c1NTVDVlMzVKTGY4c0NnVGlXbTF5ZnROZkhkeGhpVXFwSVRnUEtmV25GcjFr?=
 =?utf-8?B?b3V3NDE4bEdKaDdXaTZJK09ObXZvL3p5dzZQZ3lJRDUxWW9CQm5QdktSS1g3?=
 =?utf-8?B?NzV2UksrNkxHZGhoR1ZNSXFVU0J0bER5L0xlSFVHdzFDaGJDYmJjSEpFV2VC?=
 =?utf-8?B?ZlA3di9mWG5tTjVhYWRpVjRQODhZVXBxL3NnNDJFR1BZeUs4MVE1VnFuSDlD?=
 =?utf-8?B?UW9ObzBodEpMY2VlTnFkbTRJVWFoWlRoR2JqUWxCcXRDZmNtMllKNnoreWdW?=
 =?utf-8?B?MEJTR2hIbW85MzdJQ0trSFVWYW5GL2lSSnFJaWN1SFNhenVoZmloc3FLQW1I?=
 =?utf-8?B?TjVQTEpFYnF1QmpKWDVJZTU4MWQ5a00wTkFJdGtKUEM1S01jMW00SnVSYXJV?=
 =?utf-8?B?UmxTbDZ2cmFveG1reHc4S0FrM0NuaVVHWFRUeWNJT2JuNHVoUWs4TjFtS2xU?=
 =?utf-8?B?NHNzL3dpS1BpYzJoNG5vbkRzMWhYbjRXRlUvYlh5RnRhd2tHa24wTzMxN2Jt?=
 =?utf-8?B?aER6N05CZjBVMjE1ci9oVTJXL0RNMlVlYVR2Ni9DUzNFVmxlVU81NUJ2cjJh?=
 =?utf-8?B?VEV5T1VQakhQM3BjdjFZWWxVd2M1QU91b0JoR1RrMXg4S3NwODZSRFQyQ09U?=
 =?utf-8?B?RjNMS3RFOXdDMGx3N2tFdDJDOFAzVnN1Z0NxLysrYVRHRGo5NnlHM2VTejRN?=
 =?utf-8?B?TUI2VXpmNmNOMFo5S1BPSEhqSDRFeUpYR1BkVzhjTHpRV0w2Qm1CQXFRL3NT?=
 =?utf-8?B?Wm83V2JqVURWRjZSMTZPUnY1NDlYeENHdVBpdTd4bzNpa2xGNnAxQmJmcmRV?=
 =?utf-8?B?Q3Q3cGpwTGFmL2JBQ3NtVGhHN3RqUXZiOG1KWVVMNGcxM0lOWHhqdS9raXF4?=
 =?utf-8?B?VW5ZbHAwQUZ6b2xSZ1lNeGFLWW9haFNuL1NNUFhTa2JoUnRpVHFDNEVXVFhx?=
 =?utf-8?B?K2VzNitacy9BSDcyOHJhS0pWUkVPcnowSVpwSEJlQzdkZHdlZmJPQlcrSTJB?=
 =?utf-8?B?K3VWMkxIMFZyalRaTG5BU1ZCc2hQL3d2RGJTQ3FVSG5sZjBZckRvSEVveHZ1?=
 =?utf-8?B?RkNCWTFRaExCTXF1SXNvditqdjdSWmxrcklNSy8rVFZZL0MrOGE5QnFtbXFm?=
 =?utf-8?B?ckJycmhYM0tuSXVTNG5OUkEzRGJhd24yWjFTN01SSUdWSzJXbnA2MHNnanBZ?=
 =?utf-8?B?cGloUjB0blVNdmJwMzdRV2UxdFljMFdxemx1QVp3TUFWT3QvMnI4NU1FRi9D?=
 =?utf-8?B?ZnBuNjdSOVZJWndFczJXMFl2R0R5ZTZMTytVdzFHNVlDbFJxQWZDZDR5U0Q0?=
 =?utf-8?B?dWtwRHd3OHZLZnF6eHIyMlJZOUFIS1QydzVLblVnaHRiSTh2Yk4xQmpwNTVL?=
 =?utf-8?B?TXFsTytEbDFpV1RYS3l3Yzlpb25pVG52andYSU5vK0JFZUlINVAweDhvTkVm?=
 =?utf-8?B?SUF2clR4U3NUZHFTajVEWlFpUmpCOFllQ25FY09yVERiZ0Jwc3gyK2F4RnVi?=
 =?utf-8?B?SVE3TkE4ZXhHSFJhc0JUQTkyN0lkTHBMbkpld3h4WXQ1NUhncVdQZEJQRHFC?=
 =?utf-8?B?cnYzU2xDRHA1VFhsUWZ6cFNETzlWK2FvalNxRFZRUlovU3VqekYyWVdMTXZu?=
 =?utf-8?B?V1lwVEFHSW1VamlHQXlhTWM2RUliSk1LUWRCMDloV3NnRVd6ZVJSVXZCVElM?=
 =?utf-8?B?aWdmbGUzdHlkN1NXSWQ0VldtNUtZd0wycjlIWVZKNCtJT0FGVzhBdDJSYmNn?=
 =?utf-8?B?VWlDcXJneWwwb3VCdkdGNFVYYXVTZmRnaDBER09QRzhMVnNLTlFOZGp3TUlH?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ECE7C4BE33AEE49BD5563F95F67F5C9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8190b5-5ec1-43f3-a53a-08dd574f0e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 16:52:01.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgPoZxu9NXqlg29TFvcb/HlrvDlGo5cn0LkuW8z/nCTkxJM8YA1ix4cCg0Y2aRLc6hlWk6UKFXuBwjgOQKk8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3620
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 16:52:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17348

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDA4OjU4ICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDI1LTAyLTI2IGF0IDA5OjM5ICswMTAwLCBNYXRoaWV1IER1Ym9pcy1Ccmlh
bmQgd3JvdGU6DQo+ID4gT24gVHVlIEZlYiAyNSwgMjAyNSBhdCA2OjA0IFBNIENFVCwgU3RlZmFu
IEtvY2ggd3JvdGU6DQo+ID4gPiBTbyBmYXIsIEkgY2FuJ3QgcmVwcm9kdWNlIHRoZSBpc3N1ZSB1
c2luZyBhIHVidW50dSAyMC4wNA0KPiA+ID4gY29udGFpbmVyLg0KPiA+ID4gZ2l0IGNsb25lIGdp
dDovL2dpdC55b2N0b3Byb2plY3Qub3JnL3Bva3kNCj4gPiA+IFBhdGNoaW5nIHN1YmRpciBiaXRi
YWtlLw0KPiA+ID4gb2Utc2VsZnRlc3QgLXINCj4gPiA+IGRldnRvb2wuRGV2dG9vbFVwZGF0ZVRl
c3RzLnRlc3RfZGV2dG9vbF9naXRfc3VibW9kdWxlcw0KPiA+ID4gYml0YmFrZSBnaXQtc3VibW9k
dWxlLXRlc3QNCj4gPiA+DQo+ID4gPiBUaGUgY3VycmVudCBtYXN0ZXItbmV4dCBicmFuY2ggZnJv
bSBiaXRiYWtlIGNvbnRhaW5zIHRoZSB2NA0KPiA+ID4gcGF0Y2hlcywNCj4gPiA+IG5vdy4gRG8g
eW91IHN0aWxsIGhhdmUgdGhlIGlzc3VlPw0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IC0tDQo+ID4g
PiBTdGVmYW4gS29jaA0KPiA+ID4gU2llbWVucyBBRw0KPiA+ID4gaHR0cDovL3d3dy5zaWVtZW5z
LmNvbS8NCj4gPg0KPiA+DQo+ID4gSGkgU3RlZmFuLA0KPiA+DQo+ID4gWWVzLCBpdCBkb2VzIGxv
b2sgbGlrZSBSaWNoYXJkIGhhZCB0aGUgc2FtZSBpc3N1ZSBvbiBoaXMgYnJhbmNoOg0KPiA+IGh0
dHBzOi8vYXV0b2J1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy92YWxreXJpZS8jL2J1aWxkZXJzLzU0
L2J1aWxkcy8xMDQ1L3N0ZXBzLzE0L2xvZ3Mvc3RkaW8NCj4gPg0KPiA+IEkgd2lsbCB0cnkgdG8g
cHJvdmlkZSB5b3Ugd2l0aCBhbiBlYXN5IHdheSB0byByZXByb2R1Y2UgdGhpcw0KPiA+IGZhaWx1
cmUuDQo+DQo+IFRoZSBwcm9ibGVtIGhhcyBub3cgbW92ZWQgaW50byBhbiBpc3N1ZSB3aXRoIHRo
ZSBnaXRzbSBmZXRjaGVyIHdoaWNoDQo+IHdyYXBzIHRoZSBnaXQgZmV0Y2hlci4NCj4NCj4gb2Ut
c2VsdGVzdCAtcg0KPiBhcmNoaXZlci5BcmNoaXZlci50ZXN0X2FyY2hpdmVyX21vZGVfbWlycm9y
X2dpdHNtX3NoYWxsb3cNClRoYW5rcywgY2FuIHJlcHJvZHVjZSBpdCB3aXRoIHRoYXQgY21kLg0K
Pg0KPiB3b3VsZCBiZSB0aGUgY29tbWFuZCB0byBydW4gdGhhdCBzcGVjaWZpYyB0ZXN0LiBJIHN1
c3BlY3QgdGhlIHJldHJ5DQo+IG9uDQo+IGZhaWx1cmUgbG9naWMgaXNuJ3Qgd29ya2luZyBpbiBn
aXRzbS4NCj4NCj4gSSdtIGFsc28gc3RpbGwgdGhpbmtpbmcgd2Ugc2hvdWxkbid0IGV4cG9zZSB0
aGF0IHNraXAgdmFyaWFibGUgdG8NCj4gdXNlcnMNCj4gYXMgd2UncmUgY3JlYXRpbmcgcHJvYmxl
bWF0aWMgQVBJIHdlJ2xsIHRoZW4ganVzdCBoYXZlIHRvIG1haW50YWluLiBJDQo+IGFncmVlIHdl
IHByb2JhYmx5IG5lZWQgdGhlIGZhbGxiYWNrIGxvZ2ljIGp1c3QgaW4gY2FzZSB0aGVyZSBhcmUN
Cj4gb2xkZXINCj4gc2VydmVycyBvdXQgdGhlcmUuDQo+DQo+IENoZWVycywNCj4NCj4gUmljaGFy
ZA0KDQotLQ0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20v
DQo=

