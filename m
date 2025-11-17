Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25290CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 18:01:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16038.1763402505305309512
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 10:01:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ITEkEAKQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=341632825e=david.reyna@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH5T9V73287144
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 18:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:date:from:message-id:mime-version:subject:to; s=
	PPS06212021; bh=b99ExQrKLPxp1jlE3Ls3dvh+T+BvPssaHwvsOwU7Ll4=; b=
	ITEkEAKQ3RVyefxtt9Vtj9c93YT+vlXAq0z4hUO8iYJM8iQVBRioBPb/O0XzYbr/
	MwYum+/mATymQBNpf+spn2Fyc2HQVCQgieKIi+XbcjgdcmEyEvdcrK2rSqLIl4qk
	9rbh+IediTmWtkfJjiE9rqGZ25b9i+qAjVIVczPpmGquqJFnkZefAk/YP7tI/+g1
	CR5O6x3b9G9O8GDkkRkQ2lC2bkUNo7hiRoBqCk5t0HsOXZzt56pF16jw65qj0A13
	cG4vhh53py8ZZIQSSqyeiY1ZQnm6s5mq/hZsnWyf0Lq+bkSSMPUGtidjUs/6kzB7
	EmxrwB49GKWpG+sRpKX8JA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aeeqwj8t4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 18:01:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXCRKCUANT3Im4tdKulFcG1VXqZk4iXZmOWJuwflQQIO65oB5dpo75vo4YkvoB3yZyo4azoInfr/hM7Vjaj5fNxur6qMpluqkdjz0dLAsUN4xW7FZlqs34qBI2qvzN96xJ8bqId2Vs3LQJUEkza3Vy3H5V917MA5m/wWSoVQEY/kWscZTpZutbU6FHo6y3mz/lfJIK7+WgZwU2nMr31/cahFBtL1jUXnVUTA5BNA8el6yHN2A5D2Jzgf+QEmOw2x8Y+vrJaVexjQDhNiFye/JpVsskEcaPbeUhkdm143MGeGjV68vpEveUxqtT+7sYrt1egoC8Dz7eQrlFLHtyAxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b99ExQrKLPxp1jlE3Ls3dvh+T+BvPssaHwvsOwU7Ll4=;
 b=PT5eXS5mWof175RronDtn3M7wiII4/8m/mAe+kj8SHvBWwB9GKz+OK0JA3J5hKFDENkCp6CthGiYtT3QOJF/cMX/QBpr4XC9l/wJ+wR0rxIiVbJEUR7ihqqtCkKXizu6iuYLMTKbrVuXHh+1dYYlanDjNUC5f7K26a3Pgxkwmay+sCjSZf3Qf9RpKYZTHMQ6lUNm19LKMgCUIF/sMC5b0abNBxu8wAA2WJlT0shQCFUnSv5/FGm/d5BrFhjG4NnksFyyshXRujMQxIg/Wm8KAfWZmNWSolOAzj/1wGMkE14mgKf75g1DozZzyUNT/ZSQ2pWX5jkqeDhZwm1E0qcv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 18:01:37 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::bad7:2979:d07b:ccd8]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::bad7:2979:d07b:ccd8%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:01:36 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel] [PATCH] toaster: remove styhead
Thread-Topic: [bitbake-devel] [PATCH] toaster: remove styhead
Thread-Index: AdxX69Y2tyBIguNZSeyEtDT24IdfjA==
Date: Mon, 17 Nov 2025 18:01:36 +0000
Message-ID: 
 <IA1PR11MB76771BF4DF707E156B0504C5EAC9A@IA1PR11MB7677.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=6a40025f-da76-4738-960b-bdd1e9e4bf48;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-17T17:56:22Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|PH0PR11MB7166:EE_
x-ms-office365-filtering-correlation-id: fdb1b0a7-9c3c-4448-b623-08de260359f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|8096899003|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gf/GNuObvHWPtzDR67wGcmEoa974yX3XYUr1NuwFkOfzDEhYXksIESYxcM+G?=
 =?us-ascii?Q?AwduZtBSExUv2OwyeaqQcI3PBCfj/BMlWxR4qWxcKy7lWP8qZ3qxIL87gaDI?=
 =?us-ascii?Q?upV8tDy0Kf8+gE4JBBLZmEsZbxcQxaicN4TCNruNA1qQzUazYXc5N/40d2jX?=
 =?us-ascii?Q?Kx8bB6NgoUUGoMiiGcVnAqkeVs25v0r2QG749EBBnvlOXygeFYIJuzhjnwkR?=
 =?us-ascii?Q?/zg5PCzUZb0AjqCxRoFWwLlOzl6JEThhPZiHk05Yu+p26GirGeP4O/l4Ba0f?=
 =?us-ascii?Q?lWJbJ4AtX6Ltg3+wTTJtCZGHXHYv9FZjgpDdtGXJQAfL9ezU+1xGlTqj67n6?=
 =?us-ascii?Q?Dle3ermeQkHevuH/hxEXWiEceN4hOYbsP9amQRBIMTvUavy9fygzTIb9Gi24?=
 =?us-ascii?Q?pXZNs+uO1gxPq4la+C5l39xJMbTMGxh8fI5ovJzMB/0Pzcdde0PYAnJY05QC?=
 =?us-ascii?Q?8bXkm82FcqsXml+mOC657CydTGuaVX+VSWiAAhHw6ctFXF3++BZD4di+r5nO?=
 =?us-ascii?Q?XwMucI9jPELaAXd+ZB2h2YlSP89sYGE4kZ8Wls8LrYRkdUYD/BM/HWYoNuS8?=
 =?us-ascii?Q?3A46VPBRLwMPVvQzllA45HIihbdHCQHHSSzReq/axNzZJ6mONoxv5/M8fUXY?=
 =?us-ascii?Q?RJdzqHwnXCgN0O+Ky1WtWNzQ0zzcPnqCQtA8NtZlWKvHeKr7NuHOXkTFQWYH?=
 =?us-ascii?Q?cRdZRVE24h6IEJAu2ZoIooC5gD+wRHCr5WgJNKKNJbutpe4RyGVyMEI25RDS?=
 =?us-ascii?Q?VGSCK4ff9p5/Zh2bndVa/lkCry+IEweK1+5uRvtyZg5ocUfk1zk9Cgu1Z6tA?=
 =?us-ascii?Q?vyUlfNxdQBDlqPD6ycTbS8pnnbzHryFTD5uE5jGvz2JkrjJN2XaWOSLE9ccE?=
 =?us-ascii?Q?6uMcvy5lUNgJzaZY935AMCDZi0h006iiA5VakyndXJhH8pYUvqGRHu03ZGQI?=
 =?us-ascii?Q?/mIpRpq3cLBwHv9TpzZhRZdrKR7Otx6GVydt1q5yH7fQdSUHlXv1N7Whuom7?=
 =?us-ascii?Q?cKK/ODrYs3nzGUQOxWq2b8U4pV34/HYxsyyEtMkxjZAMXbrrvBN2duhsgM7Z?=
 =?us-ascii?Q?TmqiwCqevr+m7aCtqJzzS3TeYH44mMp2EMSZ6fHD5sK2WTYrr2qS7WpYlAOu?=
 =?us-ascii?Q?bATOqrPWszwj76wGCH/CNvEbpSULGWwgGx87NmXcYI85p6jkc99RHhDaS1Bx?=
 =?us-ascii?Q?QK5TW5qyoIP/uOQ0R3G1PEXgbMnc72I/3Z33ZPu/U13MxaM4ctVLmB15E/7M?=
 =?us-ascii?Q?1FsVarOc9cTPCK3CCLC3xb63XhQbcKHqxdlsqoHjQS03zj+wQb0ebOweKmgs?=
 =?us-ascii?Q?5Brr0D6OvHnSn6nwFeHgZ0tR2O1RblpB6Qwi6kodOnlpNHPzsQco2HRThQyv?=
 =?us-ascii?Q?SoNcRHixFHJ4JLOp2T+gtFb+rSmD6ZWPMGixPdetT6z/1iV7gwv/+2MrvDW/?=
 =?us-ascii?Q?1QVtEM+a3xdw0ZejfO7kifG8TfuuQMdKTeIInTAdR/P0ztzulqg/zQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(8096899003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HAGEYMcCFFba4UD+0Zf4fcCnXFcr0YYy9kIHwBvdilKj28SXy2POD7+AacbC?=
 =?us-ascii?Q?+cOSRTH+hGElWdkItsZGCgziHCjl1E2ZoFbMSvrNGeCHSUB1ZRcwXCqtU4ZM?=
 =?us-ascii?Q?8Y2SmerBEnDUmx00jGpLn0rpaOa9UzAtj6EiMA7G40fpRUvnfwcGmbrVqvnU?=
 =?us-ascii?Q?tDX5BRuX+jhCw87hoe0XgEFlQIrxDDwkOOPcldDF0j7uhlfziWATRIQWShFz?=
 =?us-ascii?Q?MdcAlez+gxKRlpj3IiAbaiO/giPV+a5fTaRs1SuAlFDFvR5GD0URlQtyP+fN?=
 =?us-ascii?Q?YObE8B1+BloM+h2E+Xl/vXyMTYvR9O5N9jaXQ1Viri5OOTddF578ear+erje?=
 =?us-ascii?Q?sDbhidtohTRWHw72EiSIibGnwoIvJNJJUnwCrSoC1Ai5d70uVGd3UkbSna4n?=
 =?us-ascii?Q?858z5/wSSX8PuicfE9V6P6PE34EzsOIs43T1TPUW2TegPMXS2d+OGlKOK+q3?=
 =?us-ascii?Q?vML1NkHJwskwvemqvSEvb/nq7SjZPVRZq1j8yrqRLUZiSjFh5GtWvhy+p2rb?=
 =?us-ascii?Q?6G8oUKjbGfML7N0kMb1RUM+QuN/v7rlTaYgO4SJR/h9IbdMfvlEk2Y/iFkls?=
 =?us-ascii?Q?Oxv5TYRLuhWE4glg33Dy9jjMH7hYfFFnTvHBX+AYj4QGsrrHtPirfFaBnYuy?=
 =?us-ascii?Q?2DdRTX8/nvwynQOEoqui1sUygM7lV9HvlI0VZWyFNAhQOBhgNx5l30tGVmal?=
 =?us-ascii?Q?+fQM0x+DEMTZGHqi9Z5/26k4GY4R/nna2rEonDbeI784dDLAVQzdDHeoysXM?=
 =?us-ascii?Q?zoBazZrPpF1iiDzYY68RWSiYAhoyvZ//VCOnGS5CxS5OXAJmYGGIO3ZU9ig1?=
 =?us-ascii?Q?WtFnX2NG+gCM+rckjjSsUKyhudvjcr/D7HPp6YOd7CmKeiqdJp9s2eO4KwJH?=
 =?us-ascii?Q?4BMDuGvBdSig7/SM+dTtsk7iIQ5O8yC3Kg6OTAkxtxaUsKImR/sgmqf5C/sC?=
 =?us-ascii?Q?g6MVc/5eKou/wlPCR1qSHTAUBndD+XIj1874D25kWAPf1VjYZJoNU1zmDep2?=
 =?us-ascii?Q?XDZPyBRZMbisfM6fmgWlT6jsb2MUlYxZExNT4yD3FfwPa8QSjeKAVtXwVGvf?=
 =?us-ascii?Q?Et/N1twlWiX+KhcQWeFlDVOxlcaC5owaPbndozJXkEK21pklSJigLvgEHlrA?=
 =?us-ascii?Q?aOgzjQ+kdnmweDZFb5n8VW0PYxWrQT69cdN3fNSdO9SDd34ob66YxD1yDreQ?=
 =?us-ascii?Q?S0sODgejpiBXt3SeeImLcgYPfcL/1513ZHFlsMP0G0XyDurYkzeTLMk173R1?=
 =?us-ascii?Q?i0r/vKTyVeoWbQYyqo9QtKniUliCdqt2tohJ4+liWlXRyMEVffioToNIcbiN?=
 =?us-ascii?Q?MMhf7C7rIlZNcN+vSUrEHf8pFvEJJOYUJSwHgqO5A7zBw9Oj4+Ltat+JjshZ?=
 =?us-ascii?Q?ytmEOx28VvWsLvpW1Y2GMKtHR/VAW0nKSdKO0+YTWfgbNVM/tqi8eEsQDCZ4?=
 =?us-ascii?Q?C3HjyCmwM40vLgfqyjwX8KjpOjZzqU1DKxzcrd5+hpAAFm+h1rL+sCCJn66/?=
 =?us-ascii?Q?C64KJxsmyWvyVR095qsuyoSN3BA2XQkpbVWTwZmujcq1J70OvJu9dzK1+TES?=
 =?us-ascii?Q?qfFWKG3VCvJ8DHPmh04OsLRjdrzOupGvM0zgsX7XhP7h2LzD3vHMiEAwC10c?=
 =?us-ascii?Q?xAo4ZOm2Pg/t4gBAfyi8M4W5I6Cut9kkDouMoq5oHh0k?=
Content-Type: multipart/alternative;
	boundary="_000_IA1PR11MB76771BF4DF707E156B0504C5EAC9AIA1PR11MB7677namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb1b0a7-9c3c-4448-b623-08de260359f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 18:01:36.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gR1NUCOX9Q4e/0xd7DU1nYCxuvS6d/xV8Wu3ARITmiSzFo+bPmUcRv7jSElJ+hg5Vk3WkDLjZSS2oCl3Hy7SUJKX20eHAleaEk/uX5xA/Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE1MyBTYWx0ZWRfX2AedAhxqhCym
 Bk9f84jPIO+O3eKthuFqkUqd/NbVFeCxJDuEDeB66t6yBTGA7evtpAD3TiZQgqrrO4xUyXbQgHc
 juoAkEdXXHXedrnqpR8E6m2qPIaD0/ku5m72AIG8nx4t9onRvzFkiMJvVULvKBmogmq/z+8jous
 sek6GfFIFZANdkvFFFo4f5Kfj834TE6YrSsPwNcH8W1ubeJEKRB7CDrG69mp/FyJhUysNi3HqUX
 pZQIiL579TZ5iz7wCrEyKCGmOPueFOnkH3gce7qPRXbSaWU69e/2LKClnUxxFKooVXQJ9G8iMBQ
 dGUKXZMrTK21EPzTv8LtqaIs9RP9RbdA/yVeEzNwmEwFT774sBX7AVQGGxh01+SQZVmPFdGsS/w
 iKBXsuvNIs/N0wJ07NaXZOFXKV7WBQ==
X-Proofpoint-GUID: -eNmH1Rza9w4Ma1D0YHXc1wHf7ceearB
X-Authority-Analysis: v=2.4 cv=OuxCCi/t c=1 sm=1 tr=0 ts=691b6307 cx=c_pps
 a=NjM7+/ez9qG7m02rljsF/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8
 a=TBKf15HZaxtC29_0q7oA:9 a=JJGvc4k4ZWPfz15s:21 a=lqcHg5cX4UMA:10
 a=r-HJ9bD__24A:10 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8
 a=am1mdD1kBiNplcXmpa0A:9 a=Jt3NCVMrH_YEEKmc:21 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=8DJy0ENz141agDM1nwP5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=HU0fDaCwXjt_grxVC7RF:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-ORIG-GUID: -eNmH1Rza9w4Ma1D0YHXc1wHf7ceearB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170153
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 18:01:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18432

--_000_IA1PR11MB76771BF4DF707E156B0504C5EAC9AIA1PR11MB7677namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From d977e6eca7d6fb094b862b9a78472191f31d182a Mon Sep 17 00:00:00 2001
From: David Reyna David.Reyna@windriver.com<mailto:David.Reyna@windriver.co=
m>
Date: Mon, 17 Nov 2025 09:51:35 -0800
Subject: [PATCH] toaster: remove styhead

Remove the now-unsupported Styhead release, move 'Kirkstone' into its place=
 in the table.

[YOCTO #16065]

Signed-off-by: David Reyna David.Reyna@windriver.com<mailto:David.Reyna@win=
driver.com>
---
lib/toaster/orm/fixtures/gen_fixtures.py |  2 +-
lib/toaster/orm/fixtures/oe-core.xml     | 18 +-----
lib/toaster/orm/fixtures/poky.xml        | 72 +++++-------------------
3 files changed, 15 insertions(+), 77 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fix=
tures/gen_fixtures.py
index c5b0ab7a7..4b87ba0ba 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -43,7 +43,7 @@ current_releases =3D [
     # Release slot #4
     ['Whinlatter','5.3','October 2025','5.3.0 (October 2024)','Support for=
 7 months (until May 2026)','','2.14'],
     ['Walnascar','5.2','April 2025','5.2.0 (April 2025)','Support for 7 mo=
nths (until October 2025)','','2.12'],
-    ['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for =
7 months (until May 2025)','','2.10'],
+    #['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for=
 7 months (until May 2025)','','2.10'],
     #['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support fo=
r 7 months (until May 2024)','','2.6'],
     #['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 =
months (until October 2023)','','2.4'],
     #['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for =
7 months (until May 2023)','','2.2'],
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixture=
s/oe-core.xml
index 264231d13..7c758400c 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -33,11 +33,6 @@
     <field type=3D"CharField" name=3D"branch">2.12</field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"6">
-    <field type=3D"CharField" name=3D"name">styhead</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
-    <field type=3D"CharField" name=3D"branch">2.10</field>
-  </object>
-  <object model=3D"orm.bitbakeversion" pk=3D"7">
     <field type=3D"CharField" name=3D"name">kirkstone</field>
     <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
     <field type=3D"CharField" name=3D"branch">2.0</field>
@@ -80,16 +75,9 @@
     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\https://cgit.openembedded.org/openemb=
edded-core/log/?h=3Dwalnascar\&gt;OpenEmbedded Walnascar&lt;/a&gt; branch.<=
/field>
   </object>
   <object model=3D"orm.release" pk=3D"6">
-    <field type=3D"CharField" name=3D"name">styhead</field>
-    <field type=3D"CharField" name=3D"description">Openembedded Styhead</f=
ield>
-    <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">6</field>
-    <field type=3D"CharField" name=3D"branch_name">styhead</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\https://cgit.openembedded.org/openemb=
edded-core/log/?h=3Dstyhead\&gt;OpenEmbedded Styhead&lt;/a&gt; branch.</fie=
ld>
-  </object>
-  <object model=3D"orm.release" pk=3D"7">
     <field type=3D"CharField" name=3D"name">kirkstone</field>
     <field type=3D"CharField" name=3D"description">Openembedded Kirkstone<=
/field>
-    <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">7</field>
+    <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">6</field>
     <field type=3D"CharField" name=3D"branch_name">kirkstone</field>
     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\https://cgit.openembedded.org/openemb=
edded-core/log/?h=3Dkirkstone\&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.<=
/field>
   </object>
@@ -119,10 +107,6 @@
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">6</fie=
ld>
     <field type=3D"CharField" name=3D"layer_name">openembedded-core</field=
>
   </object>
-  <object model=3D"orm.releasedefaultlayer" pk=3D"7">
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
-    <field type=3D"CharField" name=3D"layer_name">openembedded-core</field=
>
-  </object>

   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/p=
oky.xml
index 34b83e971..a8a5a7aeb 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -38,12 +38,6 @@
     <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"6">
-    <field type=3D"CharField" name=3D"name">styhead</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
-    <field type=3D"CharField" name=3D"branch">2.10</field>
-    <field type=3D"CharField" name=3D"dirpath"></field>
-  </object>
-  <object model=3D"orm.bitbakeversion" pk=3D"7">
     <field type=3D"CharField" name=3D"name">kirkstone</field>
     <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
     <field type=3D"CharField" name=3D"branch">2.0</field>
@@ -88,16 +82,9 @@
     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3Dhttps://git.yoctoproject.org/cgit/cgit=
.cgi/poky/log/?h=3Dwalnascar&gt;Yocto Project Walnascar branch&lt;/a&gt;.</=
field>
   </object>
   <object model=3D"orm.release" pk=3D"6">
-    <field type=3D"CharField" name=3D"name">styhead</field>
-    <field type=3D"CharField" name=3D"description">Yocto Project 5.1 "Styh=
ead"</field>
-    <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">6</field>
-    <field type=3D"CharField" name=3D"branch_name">styhead</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3Dhttps://git.yoctoproject.org/cgit/cgit=
.cgi/poky/log/?h=3Dstyhead&gt;Yocto Project Styhead branch&lt;/a&gt;.</fiel=
d>
-  </object>
-  <object model=3D"orm.release" pk=3D"7">
     <field type=3D"CharField" name=3D"name">kirkstone</field>
     <field type=3D"CharField" name=3D"description">Yocto Project 4.0 "Kirk=
stone"</field>
-    <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">7</field>
+    <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">6</field>
     <field type=3D"CharField" name=3D"branch_name">kirkstone</field>
     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3Dhttps://git.yoctoproject.org/cgit/cgit=
.cgi/poky/log/?h=3Dkirkstone&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</=
field>
   </object>
@@ -175,18 +162,6 @@
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">6</fie=
ld>
     <field type=3D"CharField" name=3D"layer_name">meta-yocto-bsp</field>
   </object>
-  <object model=3D"orm.releasedefaultlayer" pk=3D"19">
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
-    <field type=3D"CharField" name=3D"layer_name">openembedded-core</field=
>
-  </object>
-  <object model=3D"orm.releasedefaultlayer" pk=3D"20">
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
-    <field type=3D"CharField" name=3D"layer_name">meta-poky</field>
-  </object>
-  <object model=3D"orm.releasedefaultlayer" pk=3D"21">
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
-    <field type=3D"CharField" name=3D"layer_name">meta-yocto-bsp</field>
-  </object>
   <!-- Default layers provided by poky
        openembedded-core
@@ -241,13 +216,6 @@
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">1</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">6</fie=
ld>
-    <field type=3D"CharField" name=3D"branch">styhead</field>
-    <field type=3D"CharField" name=3D"dirpath">meta</field>
-  </object>
-  <object model=3D"orm.layer_version" pk=3D"7">
-    <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">1</field>
-    <field type=3D"IntegerField" name=3D"layer_source">0</field>
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
     <field type=3D"CharField" name=3D"branch">kirkstone</field>
     <field type=3D"CharField" name=3D"dirpath">meta</field>
   </object>
@@ -260,14 +228,14 @@
     <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field<https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field>>
     <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field<https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field>>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"8">
+  <object model=3D"orm.layer_version" pk=3D"7">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">1</fie=
ld>
     <field type=3D"CharField" name=3D"branch">scarthgap</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"9">
+  <object model=3D"orm.layer_version" pk=3D"8">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">2</fie=
ld>
@@ -275,38 +243,31 @@
     <field type=3D"CharField" name=3D"commit">HEAD</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"10">
+  <object model=3D"orm.layer_version" pk=3D"9">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">3</fie=
ld>
     <field type=3D"CharField" name=3D"branch">master</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"11">
+  <object model=3D"orm.layer_version" pk=3D"10">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">4</fie=
ld>
     <field type=3D"CharField" name=3D"branch">whinlatter</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"12">
+  <object model=3D"orm.layer_version" pk=3D"11">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">5</fie=
ld>
     <field type=3D"CharField" name=3D"branch">walnascar</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"13">
+  <object model=3D"orm.layer_version" pk=3D"12">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">6</fie=
ld>
-    <field type=3D"CharField" name=3D"branch">styhead</field>
-    <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
-  </object>
-  <object model=3D"orm.layer_version" pk=3D"14">
-    <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
-    <field type=3D"IntegerField" name=3D"layer_source">0</field>
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
     <field type=3D"CharField" name=3D"branch">kirkstone</field>
     <field type=3D"CharField" name=3D"dirpath">meta-poky</field>
   </object>
@@ -319,14 +280,14 @@
     <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field<https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field>>
     <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field<https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field>>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"15">
+  <object model=3D"orm.layer_version" pk=3D"13">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">1</fie=
ld>
     <field type=3D"CharField" name=3D"branch">scarthgap</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"16">
+  <object model=3D"orm.layer_version" pk=3D"14">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">2</fie=
ld>
@@ -334,38 +295,31 @@
     <field type=3D"CharField" name=3D"commit">HEAD</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"17">
+  <object model=3D"orm.layer_version" pk=3D"15">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">3</fie=
ld>
     <field type=3D"CharField" name=3D"branch">master</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"18">
+  <object model=3D"orm.layer_version" pk=3D"16">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">4</fie=
ld>
     <field type=3D"CharField" name=3D"branch">whinlatter</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"19">
+  <object model=3D"orm.layer_version" pk=3D"17">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">5</fie=
ld>
     <field type=3D"CharField" name=3D"branch">walnascar</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
-  <object model=3D"orm.layer_version" pk=3D"20">
+  <object model=3D"orm.layer_version" pk=3D"18">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
     <field type=3D"IntegerField" name=3D"layer_source">0</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">6</fie=
ld>
-    <field type=3D"CharField" name=3D"branch">styhead</field>
-    <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
-  </object>
-  <object model=3D"orm.layer_version" pk=3D"21">
-    <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
-    <field type=3D"IntegerField" name=3D"layer_source">0</field>
-    <field rel=3D"ManyToOneRel" to=3D"orm.release" name=3D"release">7</fie=
ld>
     <field type=3D"CharField" name=3D"branch">kirkstone</field>
     <field type=3D"CharField" name=3D"dirpath">meta-yocto-bsp</field>
   </object>
--
2.43.0


--_000_IA1PR11MB76771BF4DF707E156B0504C5EAC9AIA1PR11MB7677namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From d977e6eca7d6fb094b862b9a78472191f31d182a Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: David Reyna <a href=3D"mailto:David.Reyna@wind=
river.com">
David.Reyna@windriver.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Date: Mon, 17 Nov 2025 09:51:35 -0800<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH] toaster: remove styhead<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Remove the now-unsupported Styhead release, move &#8=
216;Kirkstone&#8217; into its place in the table.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[YOCTO #16065]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: David Reyna <a href=3D"mailto:David.R=
eyna@windriver.com">
David.Reyna@windriver.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">lib/toaster/orm/fixtures/gen_fixtures.py |&nbsp; 2 +=
-<o:p></o:p></p>
<p class=3D"MsoNormal">lib/toaster/orm/fixtures/oe-core.xml&nbsp;&nbsp;&nbs=
p;&nbsp; | 18 +-----<o:p></o:p></p>
<p class=3D"MsoNormal">lib/toaster/orm/fixtures/poky.xml&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; | 72 +++++-------------------<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 15 insertions(+), 77 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/lib/toaster/orm/fixtures/gen_fixtures.p=
y b/lib/toaster/orm/fixtures/gen_fixtures.py<o:p></o:p></p>
<p class=3D"MsoNormal">index c5b0ab7a7..4b87ba0ba 100755<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/lib/toaster/orm/fixtures/gen_fixtures.py<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/lib/toaster/orm/fixtures/gen_fixtures.py<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -43,7 +43,7 @@ current_releases =3D [<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; # Release slot #4<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; ['Whinlatter','5.3','Octobe=
r 2025','5.3.0 (October 2024)','Support for 7 months (until May 2026)','','=
2.14'],<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; ['Walnascar','5.2','April 2=
025','5.2.0 (April 2025)','Support for 7 months (until October 2025)','','2=
.12'],<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; ['Styhead','5.1','November 2024'=
,'5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10']=
,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; #['Styhead','5.1','November 2024=
','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'=
],<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; #['Nanbield','4.3','Novembe=
r 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','',=
'2.6'],<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; #['Mickledore','4.2','April=
 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','',=
'2.4'],<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; #['Langdale','4.1','October=
 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2=
.2'],<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/=
lib/toaster/orm/fixtures/oe-core.xml<o:p></o:p></p>
<p class=3D"MsoNormal">index 264231d13..7c758400c 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/lib/toaster/orm/fixtures/oe-core.xml<o:p></o:p=
></p>
<p class=3D"MsoNormal">+++ b/lib/toaster/orm/fixtures/oe-core.xml<o:p></o:p=
></p>
<p class=3D"MsoNormal">@@ -33,11 +33,6 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;2.12&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;object model=3D&quot;orm.bitbakever=
sion&quot; pk=3D&quot;6&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;name&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;giturl&quot;&gt;git://git.openembedded.org/bitbake&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch&quot;&gt;2.10&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.bitbakeversion&=
quot; pk=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;name&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;giturl&quot;&gt;git://git.openembedded.org/bitbake=
&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;2.0&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -80,16 +75,9 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Text=
Field&quot; name=3D&quot;helptext&quot;&gt;Toaster will run your builds usi=
ng the tip of the &amp;lt;a href=3D\<a href=3D"https://cgit.openembedded.or=
g/openembedded-core/log/?h=3Dwalnascar\">https://cgit.openembedded.org/open=
embedded-core/log/?h=3Dwalnascar\</a>&amp;gt;OpenEmbedded
 Walnascar&amp;lt;/a&amp;gt; branch.&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;object model=3D&quot;orm.release&qu=
ot; pk=3D&quot;6&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;name&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;description&quot;&gt;Openembedded Styhead&lt;/field&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.bitbakeversion&quot; name=3D&quot;bitbake_version&q=
uot;&gt;6&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch_name&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;TextField=
&quot; name=3D&quot;helptext&quot;&gt;Toaster will run your builds using th=
e tip of the &amp;lt;a href=3D\<a href=3D"https://cgit.openembedded.org/ope=
nembedded-core/log/?h=3Dstyhead\">https://cgit.openembedded.org/openembedde=
d-core/log/?h=3Dstyhead\</a>&amp;gt;OpenEmbedded
 Styhead&amp;lt;/a&amp;gt; branch.&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.release&quot; p=
k=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;name&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;description&quot;&gt;Openembedded Kirkstone&lt;/fi=
eld&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.bitbakeversion&quot; name=3D&quot;bitbake_version&q=
uot;&gt;7&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.bitbakeversion&quot; name=3D&quot;bitbake_version&q=
uot;&gt;6&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch_name&quot;&gt;kirkstone&lt;/field&gt;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Text=
Field&quot; name=3D&quot;helptext&quot;&gt;Toaster will run your builds usi=
ng the tip of the &amp;lt;a href=3D\<a href=3D"https://cgit.openembedded.or=
g/openembedded-core/log/?h=3Dkirkstone\">https://cgit.openembedded.org/open=
embedded-core/log/?h=3Dkirkstone\</a>&amp;gt;OpenEmbedded
 Kirkstone&amp;lt;/a&amp;gt; branch.&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -119,10 +107,6 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;6&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;layer_name&quot;&gt;openembedded-core&lt;/field&gt=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.releasedefaultl=
ayer&quot; pk=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;layer_name&quot;&gt;openembedded-core&lt;/field&gt;<o:p=
></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&lt;!-- Layer for the Local releas=
e --&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib=
/toaster/orm/fixtures/poky.xml<o:p></o:p></p>
<p class=3D"MsoNormal">index 34b83e971..a8a5a7aeb 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/lib/toaster/orm/fixtures/poky.xml<o:p></o:p></=
p>
<p class=3D"MsoNormal">+++ b/lib/toaster/orm/fixtures/poky.xml<o:p></o:p></=
p>
<p class=3D"MsoNormal">@@ -38,12 +38,6 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;object model=3D&quot;orm.bitbakever=
sion&quot; pk=3D&quot;6&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;name&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;giturl&quot;&gt;git://git.openembedded.org/bitbake&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch&quot;&gt;2.10&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;dirpath&quot;&gt;&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.bitbakeversion&=
quot; pk=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;name&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;giturl&quot;&gt;git://git.openembedded.org/bitbake=
&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;2.0&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -88,16 +82,9 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Text=
Field&quot; name=3D&quot;helptext&quot;&gt;Toaster will run your builds usi=
ng the tip of the &amp;lt;a href=3D<a href=3D"https://git.yoctoproject.org/=
cgit/cgit.cgi/poky/log/?h=3Dwalnascar">https://git.yoctoproject.org/cgit/cg=
it.cgi/poky/log/?h=3Dwalnascar</a>&amp;gt;Yocto
 Project Walnascar branch&amp;lt;/a&amp;gt;.&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;object model=3D&quot;orm.release&qu=
ot; pk=3D&quot;6&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;name&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;description&quot;&gt;Yocto Project 5.1 &quot;Styhead&qu=
ot;&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.bitbakeversion&quot; name=3D&quot;bitbake_version&q=
uot;&gt;6&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch_name&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;TextField=
&quot; name=3D&quot;helptext&quot;&gt;Toaster will run your builds using th=
e tip of the &amp;lt;a href=3D<a href=3D"https://git.yoctoproject.org/cgit/=
cgit.cgi/poky/log/?h=3Dstyhead">https://git.yoctoproject.org/cgit/cgit.cgi/=
poky/log/?h=3Dstyhead</a>&amp;gt;Yocto
 Project Styhead branch&amp;lt;/a&amp;gt;.&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.release&quot; p=
k=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;name&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;description&quot;&gt;Yocto Project 4.0 &quot;Kirks=
tone&quot;&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.bitbakeversion&quot; name=3D&quot;bitbake_version&q=
uot;&gt;7&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.bitbakeversion&quot; name=3D&quot;bitbake_version&q=
uot;&gt;6&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch_name&quot;&gt;kirkstone&lt;/field&gt;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Text=
Field&quot; name=3D&quot;helptext&quot;&gt;Toaster will run your builds usi=
ng the tip of the &amp;lt;a href=3D<a href=3D"https://git.yoctoproject.org/=
cgit/cgit.cgi/poky/log/?h=3Dkirkstone">https://git.yoctoproject.org/cgit/cg=
it.cgi/poky/log/?h=3Dkirkstone</a>&amp;gt;Yocto
 Project Kirkstone branch&amp;lt;/a&amp;gt;.&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -175,18 +162,6 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;6&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;layer_name&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.releasedefaultl=
ayer&quot; pk=3D&quot;19&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;layer_name&quot;&gt;openembedded-core&lt;/field&gt;<o:p=
></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.releasedefaultl=
ayer&quot; pk=3D&quot;20&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;layer_name&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.releasedefaultl=
ayer&quot; pk=3D&quot;21&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;layer_name&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p></=
o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&lt;!-- Default layers provided by=
 poky<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openembed=
ded-core<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -241,13 +216,6 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;1&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;6&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;dirpath&quot;&gt;meta&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;1&lt;/field=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;IntegerFi=
eld&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -260,14 +228,14 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;vcs_web_tree_base_url&quot;&gt;<a href=3D"https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%br=
anch%&lt;/field</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;vcs_web_file_base_url&quot;&gt;<a href=3D"https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%br=
anch%&lt;/field</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;8&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;7&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;1&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;scarthgap&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;9&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;8&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;2&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -275,38 +243,31 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;commit&quot;&gt;HEAD&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;10&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;9&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;3&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;master&lt;/field&gt;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;11&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;10&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;4&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;whinlatter&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;12&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;11&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;5&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;walnascar&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;13&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;12&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;6&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;14&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;2&lt;/field=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;IntegerFi=
eld&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-poky&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -319,14 +280,14 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;vcs_web_tree_base_url&quot;&gt;<a href=3D"https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%br=
anch%&lt;/field</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;vcs_web_file_base_url&quot;&gt;<a href=3D"https://=
git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%25path%25?h=3D%25branch%25%3c=
/field">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%br=
anch%&lt;/field</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;15&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;13&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;1&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;scarthgap&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;16&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;14&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;2&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -334,38 +295,31 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;commit&quot;&gt;HEAD&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;17&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;15&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;3&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;master&lt;/field&gt;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;18&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;16&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;4&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;whinlatter&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;19&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;17&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;5&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;walnascar&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;20&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;18&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/=
field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Inte=
gerField&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyT=
oOneRel&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;6&=
lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;branch&quot;&gt;styhead&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;CharField=
&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p></o:p=
></p>
<p class=3D"MsoNormal">-&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; &lt;object model=3D&quot;orm.layer_version&q=
uot; pk=3D&quot;21&quot;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.layer&quot; name=3D&quot;layer&quot;&gt;3&lt;/field=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;IntegerFi=
eld&quot; name=3D&quot;layer_source&quot;&gt;0&lt;/field&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &lt;field rel=3D&quot;ManyToOneR=
el&quot; to=3D&quot;orm.release&quot; name=3D&quot;release&quot;&gt;7&lt;/f=
ield&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;branch&quot;&gt;kirkstone&lt;/field&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; &lt;field type=3D&quot;Char=
Field&quot; name=3D&quot;dirpath&quot;&gt;meta-yocto-bsp&lt;/field&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; &lt;/object&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.43.0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_IA1PR11MB76771BF4DF707E156B0504C5EAC9AIA1PR11MB7677namp_--

