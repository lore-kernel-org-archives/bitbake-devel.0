Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B714DCF64BB
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 05:21:03 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27806.1763616059544709410
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 21:20:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=l+IG40v8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3419979445=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4t10C071231
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 21:20:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ocVmLS5cl3mk2DJcbG+71Irj6KHYvKb9d/2pRaxWxkw=; b=
	l+IG40v85LedQHZOQEcCbr2JbrztrBal2ObfpUtT3WWIdoH4j3ZG4EszwKmexv0D
	h4T9q6FRQKW3PF7E5LqoBlOrT+6LSoAMFw+N0LcgxtN4j0U3YlLMD6yEFqdHKKLA
	4+Rg8Sz2cgqFoEfI839FGcAUQoO2+V4tsoBESqP0OR/EijHmi92DZ0TNxFQJDPpr
	ENjJVXuUwnfUoFq4/nOEEm2ICVHtVKE/K/ayQrQHvMz1gVCPtdt/VBaN8qz3w1Za
	J8hVoIxdD6fd8rWh4byYB56tovVNhWLjiYG/lQ1EQ7+fdG66qkST5FX0pQ+Zo9Bb
	yQXIxj+s+k+ZR8ni6yVMXA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aenp2wxbe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 21:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTbCtMEXb4+rrCuEH77EbIk9OY7q7aQfQLOuRjRjRG0xyif92GzTefNAEQJ+IbDxKzkJRu2oc22y13GgLWR0RtEToBToHDYbJM03ZTBMtb6iUOlcOUMObYVg4q1i6av8MzaQkOt5lLmSUrAU+LXzc38pn66LNIYXWhCk5KuNVtlKxE/ZZlR4OIHR5egP4go+ROuRGeH+Hw4PiilkFTc0NGiXMnCkTuqEOtZ6fjN5WAC0hWeCGpX+xNaXdOLL2tSuUMZGnAWD37CxiPALfJADJfuMOcjUjkNfuOjnoox3+VzTovvFFvy52xRLHhF9ynWoITUPZrDrZyunx7NHSFEkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocVmLS5cl3mk2DJcbG+71Irj6KHYvKb9d/2pRaxWxkw=;
 b=TXB3n47D1wzqLiJXlVF3yu5j2eaUydbgksotyMUuAyBEExtPXJni3NdWfPC9cU4ND+pbWwLL7/b5+K4lzaj62rd7Tre4ISuC+CW/RJC0CtRkv4AWiasKghPCX258T3D8QJo/FRnFgmzF5vy9BBlQ6jX5aM7yu9MEk7Z5D8tono+3vDScd13JYpknAog5zLfuP1R0xJBShMdnBUjo3ZzHRuKkrM01JR3B8E7+6N1f2zGKTpCpCfBSfBeYuXEjSzzxtMYA8VJoOV7XuABYz22X4rU4MMFBSVfG4BQ+jE1QNU46NI4A2OAbzZyQkoWB8wGCO+YAx2gkM8it4+pb0eXvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7269.namprd11.prod.outlook.com (2603:10b6:208:42b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 05:20:54 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 05:20:54 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: RE: [bitbake-devel][PATCH V3 1/2] bitbake: add SKIP_FRAGMENTS
 CookerFeature
Thread-Topic: [bitbake-devel][PATCH V3 1/2] bitbake: add SKIP_FRAGMENTS
 CookerFeature
Thread-Index: AQHcWTMJQuq7VYVm2kWlYP5sfTHa3rT6tREAgABRHrA=
Date: Thu, 20 Nov 2025 05:20:54 +0000
Message-ID: 
 <CO6PR11MB5602B69971A6CAE7656225E8EDD4A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20251119090045.107642-1-Qi.Chen@windriver.com>
 <ccf1083effb1ace096439c3acee7b867c88cad0b.camel@linuxfoundation.org>
In-Reply-To: 
 <ccf1083effb1ace096439c3acee7b867c88cad0b.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=ef8241f2-a27f-4c98-8bcc-229e90b02e31;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-20T05:12:39Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|IA1PR11MB7269:EE_
x-ms-office365-filtering-correlation-id: 23e0da4f-79fe-459a-f14d-08de27f4941d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?c2hYR0hRSGQ4NHVaTjE2MUlpZ1pHYkJBQ0RZRCt4dERMcnFlVFZ5Z2xZRE9X?=
 =?utf-8?B?NzVGRFMzWXpMYkRnL2pjVDhodEJOMm1kOUY4UTdkdk5qSU8zeFllSkhIVHFi?=
 =?utf-8?B?Q3F0a20wMVJmd3JoQTBIcml2b0l2UmFhcWVMYjRka29pMnFpcm9KbWpEenFy?=
 =?utf-8?B?WnU1TnpySjZEb2FSd2wyR1MwSGlwc3pwWER6YVJOR1lPWWZ1empDalNTU0NI?=
 =?utf-8?B?b2M2dUpIS3J6UDRGK3lFVmZhWW9ibVNxQ241bUdOK3RUYVlic1cvOUR2aHNy?=
 =?utf-8?B?VEFpb1EzVXZGN1BIRjVuRlFWdUtoS084OWNFUldZbWJPTmRCeW5TTXdGNVh0?=
 =?utf-8?B?SEtxUUpPbUxKVjdqMG1QaWFvQ2dnRUhGcUVGQVVJVXNqZjRDM1YvOVBrWFlC?=
 =?utf-8?B?NHpXWDRZUkdaY3hwSW0vbmpSTEc3QWNDb2psdjF3cTl5eGY0NmwwczFiWUlZ?=
 =?utf-8?B?K2J0VmJNalVnd0R4d0lxeGhVUytEY3Qrc2RXWkp2MTRSV2tlUHcxNnJ6OURi?=
 =?utf-8?B?VVVnY3U1VGZQcWhIZjQxZ29QR3oxalVvZUVndHlPWVJmL0ZDNnJOS1BmbWdm?=
 =?utf-8?B?dWxhdHhETVh3bnJUNEtWV2JyR3dJcGxCdU53U0NQWnJrRnUxNzZZcDVTc0NJ?=
 =?utf-8?B?K2RUY1RMdHE0TEVhZ1lTam5tK2ZDVC9IQnJJaGFiQU1jenJuZnBEUHdwaTlJ?=
 =?utf-8?B?bVVOWTViNnBGY3NsMmNDVkJkWHBYaTVwbmwrbnlYbmw0eDdoMk9aOXNaR2xz?=
 =?utf-8?B?WldPT0dyd1NQYXJ6QUdDcjliUkI0MGdDVmxCWTZtNzdkQzBGTlNXQVVLcDBO?=
 =?utf-8?B?MVBOek9XRytYa2piZXVNemszZ3ZnWjBUQlZPY2E1M3phVEM3ME5JUkRiQVBu?=
 =?utf-8?B?cE9JSVY4Wk1WMEVkWExzeFl3Rk5PSWYvL095UWc1Sm5SMHRQSmlYdVVKOGI4?=
 =?utf-8?B?SlBGWGJSOEFDeGFFVElNbFBEUGlaWFE5dTFnZGd3MmNhcFNMTlI5YjZtZ2xJ?=
 =?utf-8?B?VzRMbkxNMWRuYnplS1JNVkZsUVFVUXNPNmhESGlURWVnYUhLYndhZitsSVR4?=
 =?utf-8?B?MFdqUE5GNlFIQXR5M1I3WG5pL0JMS2JpMUc2QzhyRnBDMTlCYVBYY3lnK1Rm?=
 =?utf-8?B?Wmd3Nk80TkQwb1d3ZWExWHhsM01HVUlUcGg5aG5XVHFhVTVqbjhOUUlMUWRU?=
 =?utf-8?B?TDBxTVl2bTYvdlJoN1FlWWRwNldLSktIMnE3Tk9NaUVxb1BTK2J6dWRoTEpQ?=
 =?utf-8?B?dTg5b1hUS1dVQml1dXdRQ0lTUjI0SUFtUDVHZ2NhTG1CZmdqbkpHUHRvS0hJ?=
 =?utf-8?B?dHRaK3BvWktkMFpuek5abWEySWRrd1NFN0QyZzBsVzYrZ1E2SnB1OFdLb1lW?=
 =?utf-8?B?ankxbFZLTDYrcThLQXRRS295a2FDSlBNTmo0UVFLRTZCa0dQZFhGcmwyTXc1?=
 =?utf-8?B?ZlZmZXB5aFUrbkdVcFFHSFlLelltTTlXMUZIKzl3dlhPTnppVFd4eWVWT1BO?=
 =?utf-8?B?dUs2WGFubklYTklrdlNkb2twRWxKOStGazdNck5EV2dkTmNxa25naWhJNWl5?=
 =?utf-8?B?c0VreUZJaGsxaDRQWjFkUUh6ZDl6dWcrcXQxWDdUdVU1c0xqTzN5VU1Lbzk4?=
 =?utf-8?B?YlVWd3FqaXpkVWZRK3paajBXTjg1ZWFnbjluZldqRmlEWC9oaFhPNDc4Z21B?=
 =?utf-8?B?eEsrd2kwRUtvQ0RmTHVCOGhFY0hHNkRPWGxRajB2RGQ3aUZNbjlhajBSdDJY?=
 =?utf-8?B?OUtjSDFkaHZ1Y0hUSnphNFhoMG5OU3RHR0FqUDJHSi9wdGhoM1F6ZnVJWk4w?=
 =?utf-8?B?NWNOK2JqWTNYZ0E1QzF5MW9Md0V3QnA0blJpOUxnT3luSjdYSTFEVWM3U2Uv?=
 =?utf-8?B?RHJaOXR6TWZIRmcwWlNwMktHMHNmMXE0SVFwUE5BeEwxalNSeUE2all2SXhy?=
 =?utf-8?B?V2hYdUxGQWxsVHJQY1NWZ1VvN0FIcWwwNTZDRFd6TitRejByUWlIdzMzUXEy?=
 =?utf-8?B?VnEzQ0hzblR3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R3FUN2tsQlBJMm9DbjNEYTdOdHQyTzY0bjVrUXdLN3RHUDVXeDByNkd6VHVz?=
 =?utf-8?B?VmdNRUpLZUJBSXR5cGlkdzFBL3k2R2s3Z3FVc1QzUlliclRENTRCZlpjM2dh?=
 =?utf-8?B?SE5kOTBValRqZWhURDg3NnJ6MGh4Z1dWb25OSkF0eU9HVForL2p4andPb2hh?=
 =?utf-8?B?M2Q0SXFpcVNIdThCRnBobTRrclRGTVcxbGpJa3hUcmthU2FBWWJVSVZod1hQ?=
 =?utf-8?B?MFZQeWVFbTBXWlZzRFBFaXZUcThnOHdmK1JETElGNi9Hc0hTbERkWlVXUzRV?=
 =?utf-8?B?OGd5QjdDc0twWnRVRjNnWmM0NDhWTEI4WDJiU1lBYStnVEZsVFd4Skx3Qzd6?=
 =?utf-8?B?SjV1ZWJ5ZklFd0VocW80c2dQY1o2eURiYVZidEV2RWpNa0NCZ2hObUMxaWVu?=
 =?utf-8?B?bkJNWEJVVUpsL3Q0SzNkc1VCb3JTT214by9NN3hEWmZJczFmVUR4L1Z5K2JB?=
 =?utf-8?B?NHc2WWwwVE5WQzN2dDEzTjFkVDJ4VlpJNTNYTjYzRjE0OTJFNVlNWko5N0Vw?=
 =?utf-8?B?MXpDWFgrM05NMTI4c2xOdStyRm56byt4YzBvcWx2U3h4N3MvNFpLK1lVRDRB?=
 =?utf-8?B?bDdsU1E1TVFidWZjYVY2MHVYd0o3emJ6dEdjdWw5VUVoVVZDek02MjI5UHhQ?=
 =?utf-8?B?czZiUkdSTE5jcWVZRUg4cDJWbjNiMmQzQXNyOFl4M2xQbDFhNUdtMTNtK0pR?=
 =?utf-8?B?M2ExazgvRUh6UWhrYWxtbExZOEtkOTZyZ2JZSGE4OUZyamVzK1ZFUnprcEh6?=
 =?utf-8?B?Z3lmOGlxNXpJNEUyK01Ja0NDSWNLYzhralpxQWpkS2JFQ1JmK1ArbUhKVHlh?=
 =?utf-8?B?akJWOWZkamI5TjY2aGlXNzdJbGVFN1V2MFJHcWhoT0g1VytDZDcvRjFmQmZy?=
 =?utf-8?B?OGhBZGU1UUdOcS94UFFBb0FveS95amxIdEs2RERuRFc1OVFtZlNqZzNrQm5H?=
 =?utf-8?B?S0VGbjNVTkZ1cEVZRVNtSU9xTmFzdHM5TUZhUnI5REErMHpRL085ZzFYYTcv?=
 =?utf-8?B?UmtxaENJbGpMb25tcXlWbkpBK2hNRXdpdnRSeGtrQ1hRdVovUjZiR2Vpdk5Q?=
 =?utf-8?B?aXpEYVhxQVFnMWJ0cUNMTG1iMTRBeUlCSHJxS0NsVTNwUU82VEhka1M4OHpW?=
 =?utf-8?B?U2xXamVoRE4rM3pidnVqRGxmdXpZNXRab3BCOVQyMHV0NUczT2dqQ3lTZkxs?=
 =?utf-8?B?NXpDSG11QkI3cjlITzBtK1NXNzg1OGRKOWVBN2poMGZmWmV1Y1daRlhVa1RK?=
 =?utf-8?B?YjhJd3BUbzBFUmo4SU40Qk85YzIvZzRKV0R3eUR6eE5GNUZYanQweE5seTJ5?=
 =?utf-8?B?YTdPaDYwVStranhsYlVLUFpGYy9GSTdDOVpGa1hqdFNtMWhVbDk3ZDlwMUtY?=
 =?utf-8?B?c1k0NWFtMTZlT04rUlE0QUlsWmd3SmJCOG4wdUdvNHRyTUVOQVRFUDltRWl5?=
 =?utf-8?B?UUV0WUVEcFVsOWpOTzMxbEw2elYxWElQc2NXcnJGSFQrZk15UEdVUmJRdk8y?=
 =?utf-8?B?UGxnSGJrTVVRdjRKeTlHQTVNcXgyTE5FRzJEaWdObXZ1U0xHZnR0UlpQU3Ra?=
 =?utf-8?B?VTBrOE81MjJCQnNsbGpEQjJaOHU0UGVNUkNTeGtXcmVGVjZzcUJoVExoTEpP?=
 =?utf-8?B?UUovQmlIcHIrWDZVK1Avbml0eU9jazA4cWk2MU9kcFI0ZitlQWtSZ2JzQWpM?=
 =?utf-8?B?Rm1rMHZUNVlWeUlDSTZIMUN2RUl2NnNraGhsZDZIbmhFenhmV285SVM0Q25s?=
 =?utf-8?B?dEZOWDZCeENQWHorYTUrUnNTQjJXRmIxVFQwT3lEK1plOUlnSmhUMDU5VGFF?=
 =?utf-8?B?TllyN2RpZjVJM3k3ZFpDM1NncXdWWjlhczRKMSsvbkJZSUIwY2ZyU1hjQnpr?=
 =?utf-8?B?RGxmYVlWNnc5aysvM1Jwb1UwS2l5K1pWTzNad1VSL2pMK2tUeVBYd2pwRHFu?=
 =?utf-8?B?TVVnOUhZaE5PbWI3OHRwbWZ4VHl1UVZkMlA3bW1ycGRNV1Qzc1hEZG1OekxS?=
 =?utf-8?B?TnZIZUpadml3cDhXU0xKOWFIS29FRi8zN25sVkxPSlZhYnQwZWNiMzY5ZzB3?=
 =?utf-8?B?OTJuckhPdXB1U0gwdlhITkhQSG5iUFNYb3ZPelFhdHlZWTRvY1dRN05nYTdO?=
 =?utf-8?Q?jPDq3VBu+mC/66iJOFQL6VypW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0da4f-79fe-459a-f14d-08de27f4941d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 05:20:54.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d69oxI8GhOjtvn9okYgArxQ3kHCNE1tbyR1uKGk9dsf+dvgVyp+2RhR4JRDX27QZolT3RrZIOUWOuIZ/DBBXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7269
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAyOCBTYWx0ZWRfX8Hb4J31Bz9tM
 lmVhroIhBWClipwW7ZWWAMYM/WOKKCFL/L5JOkzT6rETuncL0VfSIKO+dFtQYCtMqMY8+LqufFe
 NDu3QcehloC70Jwd3xB7p8f2OMe2DfOPJ07i4mcldZ84MbrZOZgZ4euqDeB/hxlvDS85WZR3L2V
 rirz53Hx15lEe05WIyc/Zu67T4mrhjhEsbcc+ebuP7UhvZBosKqhiT3IsnSDy3NWSm1l3og3msN
 gF6zcf1U31sQpmnDzO/a7OsaqiAJ1PgSLCgDM8aaz69uJncLgSIxHhdMqJnQhaayUelg74hFh1A
 mYx1t81aYBBpDbIfukkUOyuWjKGzgdFSDxSEszYemBumG3vOQyevcwf75NjXbksrjwJTZ2MyWPt
 IW6PefnDMcSn0B0YfjtB+ESwHPyb8w==
X-Proofpoint-ORIG-GUID: YpMuLngdhK7s-iLA5dB19BtLFjMju6bU
X-Proofpoint-GUID: RiH92PxkpRHkNjUULzugcE0Wc9V5kafk
X-Authority-Analysis: v=2.4 cv=Z6Xh3XRA c=1 sm=1 tr=0 ts=691ea53a cx=c_pps
 a=MRNWLIXgA5QtCoQasNiLPg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8 a=pGLkceISAAAA:8 a=4XQ8ZmzKVQIhuAIa0egA:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200028
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 05:21:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18465

SGkgUmljaGFyZCwNCg0KVGhhbmtzIGZvciBpbmZvcm1hdGlvbi4NCg0KSSBjYW4gbm93IHJlcHJv
ZHVjZSB0aGUgaXNzdWUgd2l0aDoNCjEuIGV4cG9ydCBCQl9TRVJWRVJfVElNRU9VVD02MA0KMi4g
Yml0YmFrZS1jb25maWctYnVpbGQgLS1oZWxwICYmIGJpdGJha2UtZ2V0dmFyIE1BQ0hJTkUNCg0K
SXQgbG9va3MgbGlrZSB0aGF0IHRoZSBiaXRiYWtlIHNlcnZlciBpcyBub3QgZG9pbmcgYSByZS1w
YXJzaW5nIHdoZW4gcmUtY29ubmVjdGVkIHdpdGggYSByZW1vdmVkIGZlYXR1cmVzZXQuDQpJJ2xs
IGNoZWNrIG1vcmUgdG8gc2VlIGhvdyB0byBmaXggdGhpcy4NCg0KUmVnYXJkcywNClFpDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5w
dXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4gDQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjAs
IDIwMjUgODoyMiBBTQ0KVG86IENoZW4sIFFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+OyBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCkNjOiBhbGV4LmthbmF2aW5AZ21haWwu
Y29tDQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENIIFYzIDEvMl0gYml0YmFrZTog
YWRkIFNLSVBfRlJBR01FTlRTIENvb2tlckZlYXR1cmUNCg0KT24gV2VkLCAyMDI1LTExLTE5IGF0
IDE3OjAwICswODAwLCBRaS5DaGVuQHdpbmRyaXZlci5jb20gd3JvdGU6DQo+IEZyb206IENoZW4g
UWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkIGEgbmV3IENv
b2tlckZlYXR1cmUsIFNLSVBfRlJBR01FTlRTLCB3aGljaCB3aGVuIGVuYWJsZWQgDQo+IHdpbGwg
c2tpcCBmcmFnbWVudHMgcGFyc2luZy4NCj4gDQo+IFRoaXMgZmVhdHVyZSBpcyBtYWlubHkgdXNl
ZCBieSBiaXRiYWtlLWNvbmZpZy1idWlsZC4gSXQncyBhIHRvb2wgdG8gDQo+IG1hbmFnZSBmcmFn
ZW1lbnRzLiBTbyB3ZSB3YW50IHRvIHNraXAgZnJhZ21lbnQgcGFyc2luZyB0byBhdm9pZCANCj4g
dW5uZWNlc3NhcnkgZXJyb3JzLg0KPiANCj4gRml4ZXMgW1lPQ1RPICMxNjA2MF0NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENoZW4gUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+IMKg
YmluL2JpdGJha2UtbGF5ZXJzwqDCoCB8IDcgKysrKysrLQ0KPiDCoGxpYi9iYi9jb29rZXIucHnC
oMKgwqDCoCB8IDggKysrKysrKy0NCj4gwqBsaWIvYmIvY29va2VyZGF0YS5weSB8IDQgKysrKw0K
PiDCoGxpYi9iYi9wYXJzZS9hc3QucHnCoCB8IDMgKysrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpUaGUgcGF0Y2ggZG9lcyBsb29rIGxp
a2UgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGFuZCBJIGxpa2UgaXQgYSBsb3QsIHRoYW5rcyBmb3Ig
cHV0dGluZyBpdCB0b2dldGhlci4NCg0KVW5mb3J0dW5hdGVseSwgdGVzdGluZyBvbiB0aGUgYXV0
b2J1aWxkZXIgaXMgc2hvd2luZyBhbiBpc3N1ZSB3aGVyZSBmcmFnbWVudHMgYXJlIGRpc2FwcGVh
cmluZy4gSXQgaXMgd2hlbiBtZW1vcnkgcmVzaWRlbnQgYml0YmFrZSBpcyBpbiB1c2UsIGkuZS4g
QkJfU0VSVkVSX1RJTUVPVVQ9NjANCg0KRm9yIGV4YW1wbGU6DQoNCmh0dHBzOi8vYXV0b2J1aWxk
ZXIueW9jdG9wcm9qZWN0Lm9yZy92YWxreXJpZS8jL2J1aWxkZXJzLzIvYnVpbGRzLzI3NjANCg0K
d2hlcmUgTUFDSElORSBzZWVtcyB0byBiZSB1bnNldCBpbiBzb21lIGJ1aWxkcy4NCg0KSWYgdGhl
IHRpbWVvdXQgaGFwcGVucywgdGhlIHNlcnZlciBkb2VzIHByb3Blcmx5IHJlc2V0IGFuZCB0aGUg
YnVpbGRzIHdvcmsgc28gaXQgaXMgdGltaW5nIHNlbnNpdGl2ZS4NCg0KSSd2ZSBub3QgbWFuYWdl
ZCB0byBnZXQgdG8gdGhlIGJvdHRvbSBvZiBpdCB5ZXQgc28gSSB3YW50ZWQgdG8gYXQgbGVhc3Qg
c2hhcmUgdGhlIGlzc3VlIGJlZm9yZSBJIHNsZWVwIQ0KDQpDaGVlcnMsDQoNClJpY2hhcmQNCg==

