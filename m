Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8CC61DC2
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 13:29:05 +0000 (UTC)
Received: from mx08-0040c702.pphosted.com (mx08-0040c702.pphosted.com [185.183.31.154])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36311.1787836972419017096
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 06:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@karlstorz.com header.s=S-DKIM-20210427 header.b=meezHSFH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: karlstorz.com, ip: 185.183.31.154, mailfrom: prvs=26993c4956=rouven.rastetter.ext@karlstorz.com)
Received: from pps.filterd (m0267678.ppops.net [127.0.0.1])
	by mx07-0040c702.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCE7ar3625291;
	Thu, 27 Aug 2026 13:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlstorz.com;
	 h=content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S-DKIM-20210427; bh=6XMXNKTyUOvuK4kob3
	a0EmH/rgRsuFVtzu4hZ9H/oX4=; b=meezHSFHpssRdlXxhf2G77FFkFSSPvzn9w
	GG73r2lnc/B91Gxxcnrc5ZEXjv+PpmcmhR1bDJcw/D7XPf6YiClGoa63eLLsZbyR
	3KfiHyxGxTgJzm+MPKfgP4MhZ0NzRwFS4ZcWaVC8XkdcV2Yj1ofKt8I1hs70giji
	l27g5rOtPl7x2HvgcYKWjIR3x5DnxTGzDYCQfTLqUUnHuvXpzaVMkrWQaZZctFqu
	pb7LNX0D0iUH1LOM/bZ4FZQVDH/wesSnHLssgm5t6+Ae1FsCHhzM1H1P+SUJ0TEE
	zjaBPuLvszFUVLI641oACXraSU8tYD8hK8J6evsJ9NdLvWGbae0g==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	by mx07-0040c702.pphosted.com (PPS) with ESMTPS id 4g9e0hguhv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:22:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urBSipL4PWNlQnvWrp5lrkVXid7kL6+YUQEaGzvi1LBBQll2nCu7uszox1zULtkpwH8oRevDjTKONUTrXLS4e4cyIbnhQjNq1n/oRux7+dnaPfk3Sx+gy/Fl6KMypsDSsVUFVHAT6A3QxcllgIhMBgBWyZyj2oSzgtzC48qNxPZKeIM8+/yc5DujE1a3fkLe2limcQG4uNeEdKE0cemdQaXPVfWPHCm/4DlSu+Tgc3wS2+eZCjUpcQmAIAEu5osXQZfnI5N8w8OqBHt0Q9OlExFqj2TssxV01ZIDZMbhUEcuRuz7ulgtwVbta5kdlb/jYSkUxmqlcon39cWSq35WvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRkBmHIEEQBJiJusPzMwt4mBqmG0Nec1F3ksPmhWwh0=;
 b=m09UE+KuJAne3qrhxwOadqXE+D/SEQa7f3dr2tHIyRAcSEuz1DFY3UscAcZoCm7vnaclOOz84rOSniyN90/Fi4LjYczbAuYbohJ+AkrDhm710Z7ZIbb2Py7M+XMt5+WSZErhQfuaNITg1xvAdxus/GTyZev1YoZnYCQ029ByA+AancZUPscbO1mYFBsfJ8lBseXzoX00YXvUWCvbctOPKIQ2Y8aKAHxkyV0I9BZlEqRBHOuQaM6bDVKe85hNa41F0oR0dm46PvjQoz9wzQaGj2812CQ1SrvC1iAgZ0muLjAxtBM2ZledJtbM/QQ+/JRat6dQ8aDG8T2u/HUtAeeo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=karlstorz.com; dmarc=pass action=none
 header.from=karlstorz.com; dkim=pass header.d=karlstorz.com; arc=none
Received: from GV1PR01MB11204.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:201::18) by AS1PR01MB9592.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 13:22:46 +0000
Received: from GV1PR01MB11204.eurprd01.prod.exchangelabs.com
 ([fe80::8b67:2dbb:eea9:9c64]) by
 GV1PR01MB11204.eurprd01.prod.exchangelabs.com ([fe80::8b67:2dbb:eea9:9c64%4])
 with mapi id 15.21.0360.008; Thu, 27 Aug 2026 13:22:45 +0000
From: "Rouven Rastetter" <rouven.rastetter.ext@karlstorz.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Thread-Topic: [Ext] Re: [bitbake-devel] [PATCH] knotty: Hide 'Bitbake still
 alive' message with quiet>2
Thread-Index: AQHdNiExtvW7u6SzHkG+bG3BKe7cWrax3QYAgAAA6Vk=
Date: Thu, 27 Aug 2026 13:22:45 +0000
Message-ID: 
 <GV1PR01MB112041AB716790A16BDF8E3BEDBAD2@GV1PR01MB11204.eurprd01.prod.exchangelabs.com>
References: <20260827123925.633743-1-rouven.rastetter.ext@karlstorz.com>
 <d96b6f1d53837a5ca7cc66c4570a20f7011a8947.camel@linuxfoundation.org>
In-Reply-To: 
 <d96b6f1d53837a5ca7cc66c4570a20f7011a8947.camel@linuxfoundation.org>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR01MB11204:EE_|AS1PR01MB9592:EE_
x-ms-office365-filtering-correlation-id: 34b8bc8e-45b4-46fd-1548-08df043e4848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|13003099007|38070700021|4133799003|3023799007|10067099003|56012099006|11063799006|4143699003|8096899003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 hFuDAT8+6JYgz0ieEVA8i6MrtqS1Do5p5ngC7uabXnkxMrrZuQWGKDEKGzOjOLT5x37/iO0qEFKmQo6YEcM7Kl4CFqNY01+pYFOvprpbKy91tZlOLNW7d1yxgJ8Ib+OtplkK+cypzUSj1gq58rJGUJB1ldL55eAEbtogLZsu/6Vl3P65WCxV2t3x4J/kwaR7p4Ih3xzQs4LG32W/Li3ok+YolATEKxyocsrO3sK+74LZFJ40gZqWbjoky/kASmZIB3nKQuHHIjGnTtqoDsh2+Qw12ESlv938CMtILc4VmF0dH4XXGSRPD8DR2ZLxUWgA/2esGP7F/aBWiILtaPtTPvEcP2COFgccY2JHimm9gfuWuPmwe0ssW1ihW0gf0CHHccmOAVLCBfXeJ0GUoV8IabkgU/93JBAs9BuGCa5tr09zIu6bw9AWKngcmWtIal7aKzwuCjDxdXv7vTLu93US0o6U041P1rcmCPZta5JQiXju8AuF4EEFek5KKJnE24cghnctc93VHGaE/0boy4AHdCR3naIwIlfzs8YN+wCtFnLA6TybN2P8AgaKALpajcgzqBv+2ziTy7Fm09J8EhzTTDYRJALuyvvUStHxVft7OjTa1hrEF2R8YRUku6BRTDmHLjXlscQ8Yvl5wTThKc5bI441vwYspRBrq17z5iRE7UA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR01MB11204.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(13003099007)(38070700021)(4133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(8096899003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RlNiVkU3WnM3OTZsUVhrMjREK1EvNm1hbGViMDZrMExyV2VHZVlPTkR3ek8w?=
 =?utf-8?B?bjcrVWlMNXJnZ2hpREttYUw4RENxcE1YdGxFZ1JnazBqV0c5MVhYUk5BS25k?=
 =?utf-8?B?WFJISVVUSktJUzZjZFR1b3RWV1oralBiekZaWUNuZmpzaVJyajFoN25reXV4?=
 =?utf-8?B?eHlneWtxR2lScDFIUTQ5RjkyRnZjTDFGNFQwQ25UOW42elNrWktzZCtwMTRM?=
 =?utf-8?B?NWhtcVRPeU9CcmREZWJ2clFqS2VUa1FCSUVPd1VCc3h1MFZGamd3SXNJcXdm?=
 =?utf-8?B?RE1ZNmozYy9jZTl2SjJ1ZlN4TGR6VkdFUVZObTlwVWlwU0tWenlJTU84d2k3?=
 =?utf-8?B?WGEyWUUxWGFHLzM5bGdkMDZQYmc3bmYyaW5TMlZGY3RmUlVZY1RxcjBHTnJa?=
 =?utf-8?B?dFF6S2pna2RCL3Z2Wlh2L0U2dytZeG1qNFQ5M3UxVnk0Q1JUdGRlVGdkUFY5?=
 =?utf-8?B?WmoySUVUVnk3VnlvWjBtTEVBR0U0YWJsTmFia3dyT2ZhRUg3d3pwSDJYMTFk?=
 =?utf-8?B?eFpjNzlBcE5CaEdMV3RuYy9BYW92bC9sdndjdmFwYzkvNmY3K0g2WGlESmdG?=
 =?utf-8?B?a1FYM3F5QXJOYTBNRFZBNHBwMmsrR3F4VWJWWlBnK2hGNTRCTEpwZWRVTG1m?=
 =?utf-8?B?S3J1cnlIM0V6Q0tUUE9pNWpPMzFzNXdadm1mWWllN1ArK0FkaitldURFaHVl?=
 =?utf-8?B?N3U2VU5HNXNqUUtOOFdpTk5FMmFoS0FBYlR5M1VEbFE3Y3pFa09lRXVOLzZK?=
 =?utf-8?B?R2xSaGdIc1hlbVlnVTFEeW5VYTg5bldqM05TWGd3QlJvdkJkcCtaNks4T0Fx?=
 =?utf-8?B?SmwwY25GYlZiVWFEZGZ4bzBhM0hSRGhJM0lLems3MkRvdFJ5cmlhWnhpdnVS?=
 =?utf-8?B?clRKa1JrMW0rcnpLUUhaMlYyUkZWU1c5T0YvcUxCQmExME9YTVk1bURIcWlh?=
 =?utf-8?B?UXVPTHFsdm1hWHhxK1dlTExlMFRmZE11TmFmY0lJZllTcFh3SFNFR095WUlT?=
 =?utf-8?B?aTg3cjUyV1laRTBUS3VFMWxHK1AvUitQK0FneW95NFRlb25yS0hMd3ZzbzFk?=
 =?utf-8?B?V25yT1NiTm1wdEJFWFc1MGJQeXB1YkhZbGNXQ3dDQmZoL0l4K1pBWU40cUp1?=
 =?utf-8?B?YmVjMENNMko3TEhBUHExTFdqUGV2UndKV0FHSmtKM2xyMExaaU9reHpWdnpR?=
 =?utf-8?B?Zll1eTU3RTgzSGFJdGswTVhKWUxaaVBNanJnc1JuUzE2amNudlViMVNCMjRm?=
 =?utf-8?B?Q3QySWEzbmphTEJwaUdkNnR0R2pTalBRWUVjRzJ1Y3M3dzdqZUZRUEtZYW03?=
 =?utf-8?B?NTg3MDljZkJEZEdQNG1sQ3hOMDVkKzhCTmt0SkQ5QXVqQzdoak5xbEo5N1E3?=
 =?utf-8?B?OGRYeGxYRWY5L2tSRmFHQ3JubFUvUHF0UUVFZ2R5aXlQWHp6SCtkbXRtZmRt?=
 =?utf-8?B?RTFsZ3JwM3craEdPQ0Y2ZFAyYm13MytzZ3dOcUxRUE1mUG9hWDJwZzZ5Z25k?=
 =?utf-8?B?dDVYb2tvSTNQRVU1ZnVKUE9NNGUzZzh5aUJ0ckt1WVkzbS9pbTlQbW1OOWtN?=
 =?utf-8?B?TXlwb0Y0Nmp1OTJObk12K1YzeTcyYmswVWJNd0NTUWM2K2JZV0hlN1JKK2Vz?=
 =?utf-8?B?VW9hWCtFQU1KTUMrWS9KbHJDZUZ1YWVNcTBhZFlQSXVpc2Z0ZnI1WXFBVkNz?=
 =?utf-8?B?c0VQMHROamd2UTJRWTY4OGNwRjZHa3d1QmNvc1E1T1VQUEdGZjdpSmpNU2xE?=
 =?utf-8?B?WDVWQ3o1L05YeVYzWU5CQ01jTFA0RzEwdG8veEpQNXlvZHoyNU4xbUUyUW1G?=
 =?utf-8?B?NkozWjAvLzZzZ0RVVjNncmZUQmtwVEVmN3hxVmVVSXJSNFJXSFNaRTRPU2E3?=
 =?utf-8?B?b0dlbk5kd1lYZjJTOUtlS2hXa1VRYzNPRmF1ZUhRenRFS3VZcGJ5WTlmc0Yv?=
 =?utf-8?B?d00yTnlXWWk1bTUzOTRBVDBCVXQ4YVFBQ3g5N0lnOWNCbkJXYmlGUFlIWkdm?=
 =?utf-8?B?UEJabkxBaGN1SXRSbkI5ZVR0SjIxVFdFc2FQMW5VRDFQRGtjUWhMQjdUUTVI?=
 =?utf-8?B?R25oVktxeTQyZGlQWmhwQ2JEL2JubUdBRGs1OVkrS29TSFFjL0N1SEg2RFhB?=
 =?utf-8?B?Q0hPYlBHNUJvS2tjRkJ4RnppQ3J1M2k0cGVMa2ZPRjdDT1dkRG9HTE5qZDZs?=
 =?utf-8?B?bSsrelJKQXp0SHY3Tm13MUdFTXNlbVZaTnJsbjhCaXRiSis1MlNPYW9XSjhl?=
 =?utf-8?B?Vnh3N0pZbWh1MXBXQzRjVFdyRlh4RXRtQXNkRGNPYitzdlpITzdFb2plenhI?=
 =?utf-8?B?dGxWN3JFTzFsZCsxaGhmcmxiOW5ReC82RGR0cGhHSi9zVUtzNGorNC84YUxs?=
 =?utf-8?Q?8tOWDCxYN1LjHT6M=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	AptdBcUd6LEJTSqeK/5d1TaqTzI8XxHZCLy1CuRvGq/hOiZdT//RAPPZjEWU8/ekwlVG20QBW5Z2lJBWfi8nkOi6Ef3dGQidpuAJblfyMhPnpvHhZ2nODaZZN4m2IqtDlsoO5xxTOeJlDpZd/iV9WZp6tAJqS/VXIBe5WsrfUps27Q7DPWIMtVFT+geNSDkeJ/L44aIbLGz17+EIAKpXwpWEh67zLWFRykZdG60rOVJnwzipAQApTvMW+8iF57wugm/h5tUui4Mk3Ds2cSg/auijEJOukFRSH/nlvnxatVVP21JiWhgcDLMUk2EVKmVRm40i9Du07MwYmMSUT96R5Q==
X-OriginatorOrg: karlstorz.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR01MB11204.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b8bc8e-45b4-46fd-1548-08df043e4848
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 13:22:45.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a0b6f21-e6e1-4ed6-9dcf-e60e7190f648
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3gcE8FynJV6GbTZ7qYaplSs6tCMYh6guhEAaE9OFdp5UU89mkktqYFo3qDEWKgieg9dtJnxqernIqEAND/TzzgjPMQq1b8+pV1JerMLUJigErMeRcXpkDfDMXydelWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR01MB9592
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMiBTYWx0ZWRfX5gZsvA8aU6sE
 6X6XVCTSGuUhFFSr0OhP36UCs7XtHKYWEcIj9eb7w+CEtKbLux9LTcQKnxrjQkLzZ1brcQDQWIm
 6YErDb9uDaeRHGEHWr9jD4lt0gkDG47bPmfR0J01EnOADB6Sr36Q
X-Proofpoint-ORIG-GUID: G71iY6ftm-DYVBD4o-OIdXSTLTPrYa6e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMiBTYWx0ZWRfX4MLbaEbTuC7W
 kL5VksRm9OXdSe0edGigQ1VsO35ZHPP8dTOE/d/S6oItqz3r+sya8FlU4jnpUG0WF3zhiclOasI
 USM/Uu1ygu7zAKfwGUIkLqOyzw0HxkKOKK3EmulW6JQBdubinzl2/g7x0KyCUMgN9wIc963XbrS
 cYh55kTvvob+Wg6dY06UhGtKDgy+spwwmmsVu7fmE1r8xsFfVriPoFuWbXcRLRMQbR+O7hzyxw5
 xyKsP0fAL9A07sVM/qwwnZ2a+RoAANdIRdo8oXXN4blAADecL4X+lu36HJytPxGxxqI3aGjImI3
 fTJQmvKELG6Gr45KIiXwnO9OsIiDx5FI9ibDYffLdXzRpUSXzzR6Av018i1g/H0H5YgwJOnFi2y
 HUZYnNmaeKnThdoqvKV7tH+uyb7Jq1iQCcIYqOTzkqXFWXvLKUxjOtoPWppPIvtaWWZtdTQuJZq
 yIHdm2/uZW/dUGUwq+g==
X-Proofpoint-GUID: G71iY6ftm-DYVBD4o-OIdXSTLTPrYa6e
X-Authority-Analysis: v=2.4 cv=QJxYgALL c=1 sm=1 tr=0 ts=6a903a29 cx=c_pps
 a=Kb+jYgIXhKC87qzND7NMaw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DBWTBMGyQNCzyBkTEoZL:22 a=-VCclSYHLTda9MBvNMHz:22
 a=RpNjiQI2AAAA:8 a=Q4-j1AaZAAAA:8 a=3i8N8xUJAAAA:8 a=uherdBYGAAAA:8
 a=ag1SF4gXAAAA:8 a=n9SCklZpAAAA:8 a=KIlYIF5nTyWDZtuEQc8A:9 a=PRpDppDLrCsA:10
 a=QEXdDO2ut3YA:10 a=ucpkqg4cPW7bb8dVSaEA:9 a=2q4O/K3rjNU7EHYdBHB6dYyilSc=:19
 a=PZboZpb1Wqd2Kmo2:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=prs92wXX3CXN_MxtVv14:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=MDYma9B3dblYkEs0OMj2:22
Subject: Re: [bitbake-devel] [PATCH] knotty: Hide 'Bitbake still alive' message with quiet>2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_GV1PR01MB112041AB716790A16BDF8E3BEDBAD2GV1PR01MB11204eu_"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 13:29:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20068

--_000_GV1PR01MB112041AB716790A16BDF8E3BEDBAD2GV1PR01MB11204eu_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

we are still investigating why it hangs that long on our CI machines someti=
mes. I agree that it is strange.

The reason why I contributed this is because I think a --quiet flag of a co=
mmand line tool should be respected no matter what. Maybe it should be chan=
ged in bitbake-getvar instead, but that would be a bigger change i think.

If you disagree with that it's also fine, I just thought it doesn't hurt to=
 ask =F0=9F=99=82

Thanks,

Rouven

________________________________
Von: Richard Purdie <richard.purdie@linuxfoundation.org>
Gesendet: Donnerstag, 27. August 2026 15:04
An: Rastetter, Rouven.ext <Rouven.Rastetter.ext@karlstorz.com>; bitbake-dev=
el@lists.openembedded.org <bitbake-devel@lists.openembedded.org>
Betreff: [Ext] Re: [bitbake-devel] [PATCH] knotty: Hide 'Bitbake still aliv=
e' message with quiet>2

On Thu, 2026-08-27 at 14:=E2=80=8A39 +0200, Rouven Rastetter via https:=E2=
=80=8A//urldefense.=E2=80=8Acom/v3/__http:=E2=80=8A//lists.=E2=80=8Aopenemb=
edded.=E2=80=8Aorg__;!!Lw1uGqvHvtJ_psGG2Et-1voSwbo!ceHoquRhWhj7YikvgigUH0Pz=
v2O1_VHumBSV90EyacZX4ZeOSKB96T3HpbQDQmuxrtAbB99BFvfPHGaRt957LW0CZOoFhfb-ZUV=
K5ftt-_gdFw$


On Thu, 2026-08-27 at 14:39 +0200, Rouven Rastetter via https://urldefense.=
com/v3/__http://lists.openembedded.org__;!!Lw1uGqvHvtJ_psGG2Et-1voSwbo!ceHo=
quRhWhj7YikvgigUH0Pzv2O1_VHumBSV90EyacZX4ZeOSKB96T3HpbQDQmuxrtAbB99BFvfPHGa=
Rt957LW0CZOoFhfb-ZUVK5ftt-_gdFw$ wrote:
> It can happen that bitbake-getvar takes a very long time, probably due
> to NFS locking. But even with the `--quiet` flag (which equals
> `self.quiet=3D3` in `TerminalFilter`) the 'Bitbake still alive' message is
> still printed, causing errors when using the output of `bitbake-getvar`
> in scripts.
>
> This change silences the 'Bitbake still alive' message for `self.quiet>2`.
> ---
>  lib/bb/ui/https://urldefense.com/v3/__http://knotty.py__;!!Lw1uGqvHvtJ_p=
sGG2Et-1voSwbo!ceHoquRhWhj7YikvgigUH0Pzv2O1_VHumBSV90EyacZX4ZeOSKB96T3HpbQD=
QmuxrtAbB99BFvfPHGaRt957LW0CZOoFhfb-ZUVK5fuzQGn3RA$ | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The "still alive" messages only happen after 10 minutes. Under what
circumstances does bitbake-getvar take 10 minutes?

This message is really designed more as debug - to give an idea of
where the system is hanging, or an idea of things being alive in very
long running builds. bitbake-getvar shouldn't be hanging on NFS
locking?

I'm just surprised/concerned this patch is even necessary...

Cheers,

Richard


--_000_GV1PR01MB112041AB716790A16BDF8E3BEDBAD2GV1PR01MB11204eu_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Richard,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
we are still investigating why it hangs that long on our CI machines someti=
mes. I agree that it is strange.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The reason why I contributed this is because I think a --quiet flag of a co=
mmand line tool should be respected no matter what. Maybe it should be chan=
ged in bitbake-getvar instead, but that would be a bigger change i think.</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
If you disagree with that it's also fine, I just thought it doesn't hurt to=
 ask =F0=9F=99=82</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Rouven</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Richard Purdie &lt;ric=
hard.purdie@linuxfoundation.org&gt;<br>
<b>Gesendet:</b> Donnerstag, 27. August 2026 15:04<br>
<b>An:</b> Rastetter, Rouven.ext &lt;Rouven.Rastetter.ext@karlstorz.com&gt;=
; bitbake-devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded=
.org&gt;<br>
<b>Betreff:</b> [Ext] Re: [bitbake-devel] [PATCH] knotty: Hide 'Bitbake sti=
ll alive' message with quiet&gt;2</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"display:none!important; display:none; visibility:hidden; font=
-size:1px; color:#ffffff; line-height:1px; max-height:0px; opacity:0; overf=
low:hidden">
On Thu, 2026-08-27 at 14:=E2=80=8A39 +0200, Rouven Rastetter via https:=E2=
=80=8A//urldefense.=E2=80=8Acom/v3/__http:=E2=80=8A//lists.=E2=80=8Aopenemb=
edded.=E2=80=8Aorg__;!!Lw1uGqvHvtJ_psGG2Et-1voSwbo!ceHoquRhWhj7YikvgigUH0Pz=
v2O1_VHumBSV90EyacZX4ZeOSKB96T3HpbQDQmuxrtAbB99BFvfPHGaRt957LW0CZOoFhfb-ZUV=
K5ftt-_gdFw$</div>
<div style=3D"display:none!important; display:none; visibility:hidden; font=
-size:1px; color:#ffffff; line-height:1px; max-height:0px; opacity:0; overf=
low:hidden">
</div>
<style>
<!--
#x_pfptBannerxuiyjtb
	{display:block!important;
	visibility:visible!important;
	opacity:1!important;
	background-color:#fadf9b!important;
	max-width:none!important;
	max-height:none!important}
html:root, html:root > div
	{display:block!important;
	visibility:visible!important;
	opacity:1!important}
-->
</style>
<pre style=3D"font-family:sans-serif; font-size:100%; white-space:pre-wrap;=
 word-wrap:break-word">On Thu, 2026-08-27 at 14:39 +0200, Rouven Rastetter =
via <a href=3D"https://urldefense.com/v3/__http://lists.openembedded.org__;=
!!Lw1uGqvHvtJ_psGG2Et-1voSwbo!ceHoquRhWhj7YikvgigUH0Pzv2O1_VHumBSV90EyacZX4=
ZeOSKB96T3HpbQDQmuxrtAbB99BFvfPHGaRt957LW0CZOoFhfb-ZUVK5ftt-_gdFw$">https:/=
/urldefense.com/v3/__http://lists.openembedded.org__;!!Lw1uGqvHvtJ_psGG2Et-=
1voSwbo!ceHoquRhWhj7YikvgigUH0Pzv2O1_VHumBSV90EyacZX4ZeOSKB96T3HpbQDQmuxrtA=
bB99BFvfPHGaRt957LW0CZOoFhfb-ZUVK5ftt-_gdFw$</a> wrote:
&gt; It can happen that bitbake-getvar takes a very long time, probably due
&gt; to NFS locking. But even with the `--quiet` flag (which equals
&gt; `self.quiet=3D3` in `TerminalFilter`) the 'Bitbake still alive' messag=
e is
&gt; still printed, causing errors when using the output of `bitbake-getvar`
&gt; in scripts.
&gt;=20
&gt; This change silences the 'Bitbake still alive' message for `self.quiet=
&gt;2`.
&gt; ---
&gt; &nbsp;lib/bb/ui/<a href=3D"https://urldefense.com/v3/__http://knotty.p=
y__;!!Lw1uGqvHvtJ_psGG2Et-1voSwbo!ceHoquRhWhj7YikvgigUH0Pzv2O1_VHumBSV90Eya=
cZX4ZeOSKB96T3HpbQDQmuxrtAbB99BFvfPHGaRt957LW0CZOoFhfb-ZUVK5fuzQGn3RA$">htt=
ps://urldefense.com/v3/__http://knotty.py__;!!Lw1uGqvHvtJ_psGG2Et-1voSwbo!c=
eHoquRhWhj7YikvgigUH0Pzv2O1_VHumBSV90EyacZX4ZeOSKB96T3HpbQDQmuxrtAbB99BFvfP=
HGaRt957LW0CZOoFhfb-ZUVK5fuzQGn3RA$</a> | 2 +-
&gt; &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)

The &quot;still alive&quot; messages only happen after 10 minutes. Under wh=
at
circumstances does bitbake-getvar take 10 minutes?

This message is really designed more as debug - to give an idea of
where the system is hanging, or an idea of things being alive in very
long running builds. bitbake-getvar shouldn't be hanging on NFS
locking?

I'm just surprised/concerned this patch is even necessary...

Cheers,

Richard
</pre>
</div>
</body>
</html>

--_000_GV1PR01MB112041AB716790A16BDF8E3BEDBAD2GV1PR01MB11204eu_--

