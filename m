Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF88CCFA18
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 03:18:04 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15604.1763003878001361800
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 19:17:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TlW7LQN+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3412d9047f=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACNxnra3247737
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 19:17:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DHB6MOnP5Vs8i75A7jwyo6/r9trMnEHdSbIf+PZNm2s=; b=
	TlW7LQN+z+uKKvXAgA7xEvvzNQnF/Ylv46GtWnGFw5NKIt6176Bp7KbGMaf/X+j6
	N3RDwFVWGcIm732oYMrDWgTS2IDcqUEsrpp+sCaDkd1yoE0vqlyFnFuR1fMQrGTn
	oKXr8BErOpFW+Xhacib2WYjfY6deV8zfZh98HZj2x3fNgvW0I8Mc5pnTEjlaGT5X
	3flNYSFNVPSw6xeyW8J8yWYNkH5i27xWWrhReyPYZo91jUuLX33VZ1VM976nSX3I
	EocNJp1hrWLY5uLl44GuddXllixnpJCTpbh6mCDN5lCQrx0HC6iAsTtwLL7NZ6cE
	OV62LcfWuPdtR1hXrgaO1Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa68jp9gp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 19:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9x2jo/0EY6G6HNEQ7RY0xIxEVLqFNbJ0o5cMnq+MfHp2GaG+qNrO1E9F3NB5SpOvnpuTPX9xCkpci4apj/TPo05NCy6UcbktVYL2mtteXimZX5k0Ya1zouLJ9ZkMjpqdwg89GcJY65aEx2TaG5wMLV+tvQ99gGzJXOgjyCUqEWhErKjD/8EMOJjNBAvHiB+/L6IdmBGtAOX4Y4NNDhU+PQeFrhr276NxPvaF3kCoEh3Ne+aGVryoTz3fH/iNDJtR9au58mGsKNCNNqE1OOU3IuABsSzoU8MRXbyoTy+RRPoiuBdjLNyDurmj55p1pKOAsVwcZ6QMdhUz8onP0UB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHB6MOnP5Vs8i75A7jwyo6/r9trMnEHdSbIf+PZNm2s=;
 b=icvDprcSEJ0TIt1mAkZBS+sS/OCudihhcWPF3GXnB8en48nbsD0e0Q7/szxu9YYRf7hIxAvkYzbHHQ7toLcJmorZWs4Ow/52jjz8P6+OEu92dzU01lIiCZxKmhTkH+irAA7bs2hv4HKIEu2QyOgo7thZCaQY6IDeyYDDffkVOvlJwobH4rFtd5ItnNdFqrDia1TcwZ/xr4on5Ky138875fyrhmwWC9XxSAR3YWdk9ErQ4U2o/UmEF9/tgDDul9E74wcwWFqP6W9+n0zFPqVOutP91cBYOvYpq05nS51/9xEOddvQhrFm+Ai6ZJMX1YBBMXQ7TIiAvHrKgKqoYYU43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ5PPF56FDAD370.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 03:17:54 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 03:17:53 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: RE: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal
 fragment setting as default value
Thread-Topic: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal
 fragment setting as default value
Thread-Index: AQHcU5lGjp1PmrECME+CscUBs1kjurTvNAAAgACzzXA=
Date: Thu, 13 Nov 2025 03:17:53 +0000
Message-ID: 
 <CO6PR11MB5602B41B30DBB7A223F58822EDCDA@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20251112055736.3078776-1-Qi.Chen@windriver.com>
 <df39c2e5ee59060f170ae7e4904a72acceb73e57.camel@linuxfoundation.org>
In-Reply-To: 
 <df39c2e5ee59060f170ae7e4904a72acceb73e57.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=565d15b8-1cbd-41bf-9e98-ee37e4b9383b;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-13T02:44:58Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SJ5PPF56FDAD370:EE_
x-ms-office365-filtering-correlation-id: 249cbfac-bea7-40c1-3f53-08de22633c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a1RYWFFhZjY1VFFYbFg3dE1VakdmVGpWYmNwWFBBMkZ3bFBvNXFmWkYrUXZU?=
 =?utf-8?B?cHZDWFloUUVtTkwrZnVvV3VvYXFua0prb3QwWElEWjcwamNHUDZOVHhlSjVr?=
 =?utf-8?B?TjVBdGVia3VVb2FWYWM2amlJbTlvQ1lRL1Y1Z3RaUWFqT1RCZHFIbzN1eHBF?=
 =?utf-8?B?OEs5NVdDVVRueXByS1kyaGlSTm5VNndGSTJtaUVHRVdxZTZta295Wm1IUFB1?=
 =?utf-8?B?My9aS1JCOXMxTGhZT3p0bC9mcDVkbUw4MjJ4OTZjOURwTVdRWUV3aUxNNmxp?=
 =?utf-8?B?QXQ3TjVWSGVFaXRRRGFMdkxRYVVLN3hDYSt1ckk0RE5leHlvYTNlQTRIUGtP?=
 =?utf-8?B?U0FDR1N5ejQ5TWxTcXFqdHBXcEF2ZSs3eVpxZlBPZ295SlpJdnRWRllvcWYr?=
 =?utf-8?B?UGQ2Yktkc2wxRXBPaVlOYWtRSnJQeG8zNklUNXhmTzNBN1FDZzN5dGNiZDBG?=
 =?utf-8?B?c0UvYTZ2Qnk4NUEvVkZWNEVoMS8rQ2tCZUtQTFNjNlFLUWFvVmdKY2JlaHpy?=
 =?utf-8?B?dzZiZVFORi92dStvTXpWM3Ywd2xsem9hZUl3WE94aEZ6aTRnTzdmdkI4Y21h?=
 =?utf-8?B?RXlCa1Q1UVNGTm9aOVlXajFYRDBDNkpDcXB3RCtKNUJmZ2xOZU9ic0FXREF4?=
 =?utf-8?B?ckFySk8rRkoxMVZENzlPdjZmQ241aVlYUjBRL3pPRlRUdFd2Mk9sMTI2OTFj?=
 =?utf-8?B?dDJ1cFp6QTBrczJZd0ZSUUcrUGFLK0J1VnhBN21zVG1QVzRpZ2ljbVk4c1d4?=
 =?utf-8?B?SzU5YVNuZ0NEZFJFRDMzMkVwOUhUdzdiczFuY1NNTzhWUUM4TnB5OFlJeXpX?=
 =?utf-8?B?TTVDQkQ5eXNpOCtsZDIraGtQZGdkOElFT1NTVURBWjd5MUl0bllmdUNIV3hk?=
 =?utf-8?B?KzFSRVVVdHY0dWJwZ1FSdEdHTEhXT3VnbWp2a0dSdzNuRHc3blhlWFo2UVJF?=
 =?utf-8?B?U1FYbWZnVmNoNVN6dmtCSHhkZ0ExK0c2dkVvemFncmE5cEFKdnVzM2c4QWFP?=
 =?utf-8?B?aUJvRFF1VlQ3Mm9wZVNDQWZYenF1dTIvSkJtSjErb1htSklEVG1BR2RPTzZR?=
 =?utf-8?B?SU83UTU4TVJ0QWhueStjcjZCaVdOOXRVL1lnREJocEFhSEVoYjZTVVAxS0VO?=
 =?utf-8?B?Um9YSHNDbE9INzR6dnJQNFlnc0l6Z2dVM0RyaWQrVWJKcGQ1UllTQndjYkRC?=
 =?utf-8?B?dkNCTUxPOFo1TlVXYzhHc3Zmb1hTYW1wMVRkaGVyTjRrcllkUEdtcCs2SU50?=
 =?utf-8?B?dkJVRC9SM3dYdEVNQXJGd0M0OWd3QkhaMzFFVGgvS0xDR1NpSE5oYU1BRHNU?=
 =?utf-8?B?Zmd1NzdYWHlSUnI3VS9RUVBQYUZDb3plWncyenFoa2xZOVZpKzkrUkhPMUpK?=
 =?utf-8?B?bFpKRU5DVWhYWDA3bHdsblovTGw4MzVoQjgzaTFaUUpPYW8yTjA5b1huaUh0?=
 =?utf-8?B?Z3RCdmxhTHd5SXU0dm5Id2VVeVhKeXkrS0pYbnlXRzJXVklIam1RRDJVM2FY?=
 =?utf-8?B?T2xleExoRlhlbEF2YVloOTJEcnEvdyt6WndwS2U2YkpaUlAzUHMrNVRnKzRx?=
 =?utf-8?B?ZVVQWFpKRkJCM3dWa09oaVE5NDFzbDFUK0U5WndmWUhFeWNHZmNMeXBtb01M?=
 =?utf-8?B?TDE4RTVpTm9Jd0o0L1Nid05LVFcwUU14K3I0MW5lbndrVHYyZldsd21xYzJ0?=
 =?utf-8?B?NmtUS041RUYwQXBGdTJxYlRScHpVWGhVbFA1QTkwZ0RnUWZsSS9JMjExUDdF?=
 =?utf-8?B?bHF5emdPbXNybFJhYlhaVFRkeUF1RmZscGo3RGtpcVdxeDA0VzZLK1p0bWs3?=
 =?utf-8?B?V0VGcUU3UE9ESVhtTGN2dVFLUVNyRW5aZ09BdVFQVUtVOTlZbkU2L0ZxdW5p?=
 =?utf-8?B?MGlNanIya0lWclV4UFYycFl6Y1VCMEdLVjlucU9EQTRHMk5yREZmMUdqa3No?=
 =?utf-8?B?UmR1L1BnTEdZdFZiK0dsWnFJd1lNSTRMdU1ob3dKZElyTVZwbTU2UXF1MmhO?=
 =?utf-8?B?cTU1VUdDdWx2eXJZdEhaOElmMWc3eWJUcEpqeUFRZnZIZFk5RVJJRHBpbEE1?=
 =?utf-8?Q?B20tUg?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NmVhS0lQdS9hZ2lCb1FOUmE2RGRtMitKSkxZc2o4WDg5OVlLMU5TL0JIWTFw?=
 =?utf-8?B?WEpqV05pSDlzTktwN2ZTWUMvWS9LeWR0TWNPNTBsMm1ETnlSdjV1eXdaUmdr?=
 =?utf-8?B?d1Z3WVBUU055R05jcEdYK1ZnWE80aDJhMVg1b1duMEZCVytIeVVFR0haaVB6?=
 =?utf-8?B?ZUM5UVJnMFhUMW54YktlUkU2czlNSlczQlBSZlI2SXViNU8xeEd3ZHkwMlZE?=
 =?utf-8?B?SGk0QzdBNndRSGtKN3VnMHREV0pKdFVsTTdlR0pTOVVHeWdKRnhkeHZjNUpj?=
 =?utf-8?B?VTNrVUlvL2pyTkJaWkJHajc0UzYwVHdMRzBzQUQ0Y1gySzVZQjllOHJqSUJB?=
 =?utf-8?B?cVVDSnlHRUtxaU5OM0FlOXFpY1FDeHJ6MEVtenNoWlBkdHFUUzI4SjN4SEl3?=
 =?utf-8?B?cEkrb2F2Y3FENDJibU5FTTYyd0RWRUZtd1N3ZmNkbDZjVWp4YU05dlJETEtV?=
 =?utf-8?B?d2RvcUdvRXBZNElZRzVIanIzb1o3ZlVEeWJLY05KaVZBK2YyalVtcm9Xekxo?=
 =?utf-8?B?Y25nSitFNWdmVUNFaUFYbUFLZmVYdVNXSDN6MFM0Y0preVk0OEw5c01uR1gr?=
 =?utf-8?B?UXZqR0o3QWtXRG9mK0Q0UGNFZlo2TUlrT2NLSTVKMWI1bUhZeVM1QzdEQkdp?=
 =?utf-8?B?YkZNMTZic08zY1hrY2Y0cWRuK1ROQWQ3N2FhS2FIQi9MV0dqWG8wUXNONWtR?=
 =?utf-8?B?KzB0dnRtcWs0aFNtbmxLRXE4ZFB4bS80dDloaWNOWHVCSVV1NkxIa0VIOVJr?=
 =?utf-8?B?S2d2RlZITGxqUk4zRWN4RnRacThSc3pkTlloS05ROGp1OTBtOXZOSlpXTDR4?=
 =?utf-8?B?cFNKR2VMblZvdnpPRzlhZ056d0dhQldBMVh0VitzanAwZGZEV3RVb0dGSk44?=
 =?utf-8?B?ekw1QmZzQ2kzUWNTUHpNUWt1MnJOa2xHR0poWlZ1OTd6UlJhWmNveFNMc2pZ?=
 =?utf-8?B?Q1EzYndqaEt0MDg5R3ExcDFUUG8vZ293UVIvakc0V2VuQnp1dXlSbFZBbVZV?=
 =?utf-8?B?dXBVT0dCSW9jZFVTQ0RBMVlMY2pWckFaMTdvdWt0OFRybWlUdHJNZWU3b3hP?=
 =?utf-8?B?eDlkcnkrdWtYSXhtM1EyY3FOV3dabURVV1RNK1drSVNFTGtRNXl5N0ZzRkdm?=
 =?utf-8?B?WFAxRVZLUEdXZ1pYOUEyWnRKT254elRjenhMSE9pQStGaXlFbHVXS3p0RjZj?=
 =?utf-8?B?Z3M1QnVxVklLSlZpWG5ONzR3Y2V6UUZCOWpSMERHc2tOaCtyOUxOSk5Ra2Nj?=
 =?utf-8?B?NkZndVl1TWVmbnRSeXV6VDBLQVdOWTBQZU0veVVUNFd0d1lHU1hKMnIrMjVn?=
 =?utf-8?B?ZEcxQ2hMY2ZHTkorWGxrbURTQjRNNkdkYjVnaEFYYStidFJHMDdteDNncWhX?=
 =?utf-8?B?OS9GVWRJR29qbVJsaWxtdXlWbWxWS1lsZDN3L1plYk9rMmZ0MDZNeXVkZGtN?=
 =?utf-8?B?TTQxREhIenlvZTROUUF1Qk9aWXUramVxbng5ZTBFQlV5TkhuUzhDdjFGUGYr?=
 =?utf-8?B?UU4vbFN5L0ZjMVk1S1hnS093YVdCWC85Z1dobGdBcWFwSU12TVRndXhENnEy?=
 =?utf-8?B?UG93REJpRkhSYkRPMGppQnVQYkRoZDlLMjJTT2xjZ1dDa0tXQXQ1OVE5NDZm?=
 =?utf-8?B?ZG5xK2toTUFXMUVONXZ1MjlRVTE1ZlVybU50YnlTUk9yZWlKaDZqYzd2cDlK?=
 =?utf-8?B?a2Fja1lxbzYxUDk1aHYzOE96MmxnbzNSNklSeERhbnovSjRiVTErRkx2YmxU?=
 =?utf-8?B?VjdJQ2c4MXVwQmxhbm0rcFhyd2JIcndobEpKWTJsTWRIQXB2anFtckl1VFZO?=
 =?utf-8?B?NFpzUHQ5ZThIa0JEOWJ0QVdsWG9yclNZV1UzdzBOdDhuRWJYWURUMk51TG1v?=
 =?utf-8?B?S09BazAvUEpDZ0Q2Q2RMNkh2eElBOTBMWGl2Q3ErSzNxamJPdW5tTHJoREdt?=
 =?utf-8?B?dEgyNEw4MXNldk9hRnpMTS80eG9NOGpEcktxV3IrSWJxbmxTMGZ3Uks4QlV5?=
 =?utf-8?B?WEJXM2ZKTElJT3N2dEhqbEpzNXFYeTNSRzZWaDV3NHNUeUdVM0pkMkZNYzZT?=
 =?utf-8?B?WE50MTZ0YllYaFZWZnZKcXRIOFVXN2kybys5eFlwTHZpUEhLNE9RODlLZUpH?=
 =?utf-8?Q?clKKrekjogLrtwcs26WPOQKq0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249cbfac-bea7-40c1-3f53-08de22633c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 03:17:53.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcLi6XULKh3vQG2dnbhTZ+rfC9WyCviXEBadGAxcNxtUkNJ6ugQ1PWajmzpCK/V/0L/pWHMPJ2m10ZMhvmeKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF56FDAD370
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyMCBTYWx0ZWRfX8i1jSCCaIFgi
 Hk543DI4/HSBEc0/3uEqY9SgIO80yDbeRnrBs0PGl4x5L+KXQFwdqfE67dbFMa10V5WmXKJQekI
 jvLHwr43Y1LvUFalJ9HENitwVrcfa1KwVav0SB5KeaGMuZHJZ9oiJviVbJ79uIhKQ/SMjIFht8N
 mJhEC2U/fTcV78uRfvpWlO88EBDI8Swotabbv9+SipqPZJLKDVtF1iH2tFKXmauaCruIPzqBkba
 MMSUEPpwIv7vB9sU80cqcc2gx8MtjSuJBPEqjeInNS/qwPNu+4q1lvUKdl3FLqMBWp6XoONlUz6
 jpRUzCh5sXrvSMkkNnMkR53gSkMOGrxYGCNMxvzs6yW8VVEtRAmcvtfx2Pw4YOWxmHPXi92pkrk
 OciJrI2sqLf2rN8iIsdVYWtXiDVZBA==
X-Proofpoint-GUID: sCJrySNWlToRRK3FtBIyXBbl0RCKMjbn
X-Proofpoint-ORIG-GUID: 7BmE2Tenk6Erp_zFYGuHwE3JH2fgpdfZ
X-Authority-Analysis: v=2.4 cv=ef0wvrEH c=1 sm=1 tr=0 ts=69154de5 cx=c_pps
 a=dVriaH61pmWkicxGRshTTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8
 a=Q4-j1AaZAAAA:8 a=pGLkceISAAAA:8 a=Uo1QdN99Ig-ebCMGyBYA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 03:18:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18366

VGhhbmsgeW91IGZvciB0aGUgZXhwbGFuYXRpb24uIA0KDQpNeSBtYWpvciBjb25jZXJuIGlzIGFi
b3V0IHRoZSBiZWhhdmlvcmFsIGNoYW5nZSBpbiBhIHByb2plY3Qgc2V0dXAgYnkgYml0YmFrZS1z
ZXR1cC4NCg0KV2hlbiBJIHdhcyB0cnlpbmcgb3V0IGJpdGJha2Utc2V0dXAsIHRoZSBPRV9GUkFH
TUVOVFMgYXJlIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGluIGNvbmYvdG9vbGNmZy5jb25mLiBB
bmQgSSBnb3QgYW4gImVtcHR5IiBsb2NhbC5jb25mLiBTbyBhdCB0aGF0IHRpbWUsIEkgZmVsdCBp
dCBuYXR1cmFsIHRoYXQgdXNlciBjb25maWd1cmF0aW9uIChsb2NhbC5jb25mKSBzaG91bGQgdGFr
ZSBwcmlvcml0eSBvdmVyIHRoZSBhdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBvbmUgKHRvb2xjZmcu
Y29uZikuIFRoZSBsb2dpYyBpcyBsaWtlIC9ldGMgYW5kIC91c3IgaW4gTGludXggc3lzdGVtcy4N
Cg0KSXQncyBhIGxpdHRsZSBjb3VudGVyLWludHVpdGl2ZSB0aGF0IGxvY2FsLmNvbmYgZG9lcyBu
b3Qgb3ZlcnJpZGUgc2V0dGluZ3MgaW4gdG9vbGNmZy5jb25mLiBJIG1lYW4sIHBlb3BsZSBoYXZl
IHRvICBlZGl0IHRvb2xjZmcuY29uZiB0byBjaGFuZ2UgTUFDSElORSBpbiBhIHByb2plY3Qgc2V0
dXAgYnkgYml0YmFrZS1zZXR1cC4gQW5kIHRoZXkgY2FuJ3QgdXNlICJNQUNISU5FPXh4eCBiaXRi
YWtlIDxwa2c+Ii4NCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9y
Zz4gDQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTMsIDIwMjUgMTI6MDEgQU0NClRvOiBDaGVu
LCBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1i
ZWRkZWQub3JnDQpDYzogYWxleC5rYW5hdmluQGdtYWlsLmNvbQ0KU3ViamVjdDogUmU6IFtiaXRi
YWtlLWRldmVsXVtQQVRDSF0gbGliL2JiL3BhcnNlL2FzdC5weTogdHJlYXQgaW50ZXJuYWwgZnJh
Z21lbnQgc2V0dGluZyBhcyBkZWZhdWx0IHZhbHVlDQoNCk9uIFdlZCwgMjAyNS0xMS0xMiBhdCAx
Mzo1NyArMDgwMCwgQ2hlbiBRaSB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToNCj4g
RnJvbTogQ2hlbiBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0KPiANCj4gSW4gdGhpcyB3YXks
IHVzZXJzIGNhbiBjb250aW51ZSB0byBvdmVycmlkZSBzZXR0aW5ncyBzdWNoIGFzIE1BQ0hJTkUg
DQo+IHZpYSBsb2NhbC5jb25mIGFuZCBlbnYgdmFycyB3aXRoIHBsYWluICc9JyBzZXR0aW5nLg0K
PiANCj4gRml4ZXMgW1lPQ1RPICMxNjA2MF0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoZW4gUWkg
PFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+IMKgbGliL2JiL3BhcnNlL2FzdC5weSB8
IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9saWIvYmIvcGFyc2UvYXN0LnB5IGIvbGliL2JiL3BhcnNlL2Fz
dC5weSBpbmRleCANCj4gZTZmZjFmZjc2Li5mOWQ5M2FhMGYgMTAwNjQ0DQo+IC0tLSBhL2xpYi9i
Yi9wYXJzZS9hc3QucHkNCj4gKysrIGIvbGliL2JiL3BhcnNlL2FzdC5weQ0KPiBAQCAtMzczLDcg
KzM3Myw3IEBAIGNsYXNzIEFkZEZyYWdtZW50c05vZGUoQXN0Tm9kZSk6DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2dpbmZvWyJkZXRhaWwiXSA9
IGYie3ZhbHVlfSAoe3NlbGYuZnJhZ21lbnRzX3ZhcmlhYmxlfSBjb250YWlucyBcIntmcmFnbWVu
dH1cIikiDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBicmVhaw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIHBhcnNpbmc9VHJ1
ZSBzaW5jZSB3ZSB3YW50IHRvIGVtdWxhdGUgWD1ZIGFuZCBhbGxvdyANCj4gWDpvdmVycmlkZT1a
IHRvIGNvbnRpbnVlIHRvIGV4aXN0DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGF0YS5zZXRWYXIoYnVpbHRpbl9mcmFnbWVudHNbcHJlZml4XSwgdmFsdWUsIA0KPiBwYXJzaW5n
PVRydWUsICoqbG9naW5mbykNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRh
LnNldFZhckZsYWcoYnVpbHRpbl9mcmFnbWVudHNbcHJlZml4XSwgDQo+ICsnX2RlZmF1bHR2YWwn
LCB2YWx1ZSwgcGFyc2luZz1UcnVlLCAqKmxvZ2luZm8pDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBUcnVlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gRmFsc2UNCj4gDQoNCg0KVGhpcyBpcyBhIHRvdWdoIG9uZS7CoEkndmUgdGhvdWdodCBhYm91
dCB0aGUgdHdvIHNpZGVzIHRvIHRoaXMgYW5kIHlvdSBjYW4gYXJndWUgaXQgYm90aCB3YXlzLg0K
DQpJZiB3ZSBkbyB0aGlzLCB3ZSB3aWxsIGdldCBxdWVzdGlvbnMgb2YgIkkgc2V0IHRoaXMgZnJh
Z21lbnQsIHdoeSBkaWRuJ3QgaXQgYWN0dWFsbHkgZG8gdGhhdD8iLg0KDQpJIHRoaW5rIGlmIHlv
dSBzcGVjaWZ5IGEgZnJhZ21lbnQgYW5kIGl0IHNob3VsZCBvdmVycmlkZSB0aGUgY29uZiBmaWxl
cy4uLg0KDQpDaGVlcnMsDQoNClJpY2hhcmQNCg0KDQoNCg0K

