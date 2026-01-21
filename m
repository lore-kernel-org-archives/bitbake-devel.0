Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D207DD262B7
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:39:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3748.1768963155077882100
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:39:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XuDl+exT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5481a237ce=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1i7qB1578667
	for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 18:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=95OoubISE/0ydHmIuxQpADhjadxgzmV3iZ+IVMf95BQ=; b=XuDl+exTU4GX
	i5q7Imeoy3ePXkETJALdxh/O0CqZGJRXXIWZ1LZExUgc8tFFvH5aQze35V7MNqea
	qje+w7upPE5i/Xm31zEB+g+BVLlXboPEPo5ZH5NhDEwvnkafhdDOELLr8mWHMFOQ
	p8U23adBgLU1oSrvf8JjGGKgjcdGwpdLUq8wYILHdaODqUZWJI7c/pUYWHa89KqC
	sE2MAbJWSSxTiZZnKDnTOlHFHSvO8p9vqx/5BY6HDFUgs/Ln30Tb20wBLAb8kCLI
	MjajAxoU2Ck1nys4ufZJ+p7xoSO7MM95NQ4oQWfTSJKpoy3c0HE92k25DQwCq8ot
	ZklovU0Rgw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btnd701ab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 18:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t55QDsHnYKXls+1Yusa24keVxv8xRWdodJyR/9+hfbI93ZJe8CHDasuI1oHsG/9LPbralyrQpAViWkUqcnrrmbIuKuLmjIVm+AD9XDX9tuYJ7ayuJy8U0io6rb9lnucriryDC0A7cF0SuiFodC5vX5iZAD8By1zjY1hO2F1swqbYjuWcQChWdZqJdYbDnjhkwD22OY/o8TETndCBE1b4LOFotc9u3SluW+c4h4P1P9qmDpKWNv+o2Gl+Ed0mLil/2L3sVforb4kroJ3UVsnwhPXl/G1H0yl5DTT5RTQVFLIRtnQI8FSebTdzMzAGtvyOol+g/cXR5Dy8W9hTEHrmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95OoubISE/0ydHmIuxQpADhjadxgzmV3iZ+IVMf95BQ=;
 b=rGWpS1A9ZHtLEaoXwi9IgZbb9suhG62Cv3MxQCxdhm+GK82FleDuHcFhuwpj7Jdjqcq95lORbJZBmvt877N5YujTps9WfJlrLTjqHozwGJBfNbsTj/FKb/UJcQ2r8AnLkr+nm/3X9Oa/6B57EnaBanVUwNPaDkUSCXW7mPNRp/TUNLJ4u2ZBCew5XQp1Kj9m9KnJoWPLGl1HAvufTYKtThQdYX71CnyGqsdx5PJygdMAnw8XFoc1FWLqQdoG1EAMneonur7YKWpnkIfhdPk2VfOWeUTG9+oE8TUtIT1y5CiHgldAheyyU5QJVyTOsD7LT2rGjxFMUjFHxhks3tQ/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Wed, 21 Jan
 2026 02:39:11 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 02:39:11 +0000
Message-ID: <3394eada-559d-4996-a65c-41640d09fafc@windriver.com>
Date: Wed, 21 Jan 2026 10:39:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
To: bitbake-devel@lists.openembedded.org
References: <1885DEB2FD4F0640.2047557@lists.openembedded.org>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <1885DEB2FD4F0640.2047557@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe21b1b-1708-4266-ce93-08de58964248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|4022899009|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NWJVWko4VS91cDIzMnVmcndZeStxd1FVZlRmQkwydXNRMTlDTTBVZVI5MTZO?=
 =?utf-8?B?U2ZXaUR1ZHBpSisxSnBkQnBXKzMzclBtSkF6cC9Xak05Tk9nQzBSVDN3ZXo4?=
 =?utf-8?B?TVRzTkFkSDhydXk3eFVUOFd2NnBhTEV5WEcyU0J3b1k3MzZWSS81STdPeWRN?=
 =?utf-8?B?KzhubXhPR0Rjdm56RWZxb3h4Y1k0Q2RxTG03TytzUHkwcUtQM3lTdCs1NTI3?=
 =?utf-8?B?WExWcDh1YlY4SW9jWllyTXlRRjVZQmREaHJoa1FZYnRKZ3dwN1JaSWZiSUZY?=
 =?utf-8?B?NStBbjJ4N0tpZHpML1RXODBaVTRINHNYYTNzeDZBeUxFbUN6a2J5ZlJOZVV0?=
 =?utf-8?B?MmxkdVVLeWYxS3JXT2lGRW5VaXZHZkRpVWhVMWkvZE5DQk5zZENoSXlxbVRZ?=
 =?utf-8?B?VEgyTnROekVVNXI2OGNDdWhtcTRrdW5lTFRmY1oreHh6KzNvV3BVby9TNVRC?=
 =?utf-8?B?MjFrTmdwQWhkMWZqdDNXaTNJZnBTZUVmY1NGMjhDcUkrUUFFekZXRmR4clEv?=
 =?utf-8?B?K2VFSEhtUVZFV3U0K2src1hUMkNMK1RUcENTN0U1dmdwK1RhTTJsSmlsUXRw?=
 =?utf-8?B?Z1VjRGtTTDhsRGxMY0ZvbXpEUDFjWGo1Y0NQOXRWc29PYlhnQzErdWVzemw2?=
 =?utf-8?B?OHl0eUo4dUdrUGF3ZUtXNEFpc2pxWmhlbk5iV21CaVY0MnVYU0x3Vkt5R0RL?=
 =?utf-8?B?NGpqRnlDSU9peG9hcTR5bytrK1FmZFRSTEFCSHRoVklZb1hDQkRZZ0pQbkZz?=
 =?utf-8?B?dmFFR2QvVVdMMFlkdlNpczdkK1A3R2VTdmdvci96MXlFRVQ5VjJqWjFxNldM?=
 =?utf-8?B?b3R6VTFCc2FQNHFSSlBWS3N0QlhkZlpZSlIwQ1FCd3JTUWh5dEJFOE9HUDIy?=
 =?utf-8?B?TW43NW5sVXpxNHpsWEErQVN5cmh0WWNuWU1BVjluODBNSjJHT1JKUE1NMlg4?=
 =?utf-8?B?WjdmcE5Ick0wNk00bUNoVlNTVWpaU1RHQTRuTXVlMFdxSVBWVzdkdjd3bHh6?=
 =?utf-8?B?dGl2S0dmTjhhQXdZeURwR0tyYy9DK081WjJWckVodExPMmN1WmFqT3IraTBq?=
 =?utf-8?B?Yk5UQ0Q4YmFGYytVSXVPNi9oeUdyaWc1SkxPM0U1VDFYQitGUm9wNnQxWTdz?=
 =?utf-8?B?QmVLVmZROUhvRk84KzBncTgySEFJK3EzNGxZVlJ3S1VtZ3FXSlZWVytVRkth?=
 =?utf-8?B?VlI2UWE0SFBLQmpra1djVXRjLzdKMlNablMwaW5QMXBveWF3OVFYTGlEbThM?=
 =?utf-8?B?RWVOTU05bUlZRzlxQ1JyUmlDK3JWYjcvOHNLRTNIUHZ0NmEzYjBLZklzSnNN?=
 =?utf-8?B?WE1RdHJJTjhVOGlLMFFpa255cUtjdmltK3dJaXZRSS8rM3VwNWsxK0g1cDJo?=
 =?utf-8?B?ZVBTQllBY3JSYmEvcDhhRzhtRC9tQkZ2dngzYkRFREJkRWlIdHVDZUpMMFlK?=
 =?utf-8?B?cmFUcGtrbnpWNGxDbEZ2bXd3YkNNdi94WlJmM1dNVW9rOFcrR3JRQ1phOHV4?=
 =?utf-8?B?d3RsR3VGQlVjejZXZjRFQXVWVzJacVV1ZmsxVk8wOENXY1ZEWkpFdHNzT3Ar?=
 =?utf-8?B?STJqWFlFOXZ5MUhVcTU4QnltRG11WVJYc3FPVnBTMXY2K2hMdElSOTRKR01p?=
 =?utf-8?B?cFdySUxqUkFJTXFDNlpUcDZYNXJuWURBdVRNQkcwaXRVNmJVOFk1azNuM28w?=
 =?utf-8?B?NTk3Q1VWWjhQQmllNGRNLzBETWZ5S0VGL0pTQmdxRkJ1dUdCaThNZFBkVWhY?=
 =?utf-8?B?LzJZN1lSczZCd2FianJtZFZhQ1g4NHIwcFU2dFd4aG9ydEZIV0tneTY2WlMy?=
 =?utf-8?B?Ukhmb1V2OG50b1VqUHFZY2kvY1VzcXVzUm4ra2ZHQWxWazFGQUlaeUpLM0ZJ?=
 =?utf-8?B?RDVPNm1zMmRBbjJVTzJZNXZEVHBhd0QzeUZhS0pLMTYyWEh4NmQ2aWF2cjJI?=
 =?utf-8?B?aUhVSWxNTURZSmZNeFdZaGMrMy92WXhDbHJ2ZGY0OExTYit3QmJ4ZXU0N1Zx?=
 =?utf-8?B?K2orK0xqbkN4dzZtSC8yb0lqd3IzRmhZd0hPL29RZmpVVDcva3VjTTluRmNj?=
 =?utf-8?B?SDhLTnFraE4yNkllK0hsWXNhSXhQd1kxOUswT0ZCTDdlamZ2amVxaHFvUmQ2?=
 =?utf-8?Q?eHe4m/DYiIHgf/KzpXY9dCh7w?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnNmRjJkR0lmdVd0M2JYTFBEWTJSY1dWNFptanNwTjRSNm1mSlVqMkNhTVhL?=
 =?utf-8?B?WmpGYWJ4VzFXNkxBWEpzVnN0MVBUNi9OMm5PWEoxUXN3aFRXR2pmbVd5d3dj?=
 =?utf-8?B?UUkwazkyQUltN3grOWFyM2RWYkRmS3ZWSWNPa2ZwdlB0Y0VibjA4c2hyUzZw?=
 =?utf-8?B?R0s4WkFpZ0xHTHFrVk9ySHlaMDlqNXFKbC90eHFocnlrUXZtVFVoOElBRVlE?=
 =?utf-8?B?VFpNZXkxcW1ORWtNRnh2MnRjSHJ3RVdxeDBmcGpFM2p5dU1CVzdRNVZQc1RF?=
 =?utf-8?B?eXRyUzNpK2dSMTdSaERtdEgxcFpkczUvMk9Ya3J3OUI0OW1nc1c1SUJnZTlv?=
 =?utf-8?B?VUsxaW1Ga1hva2V3NUg0OFphKzlHM0FaT3JuaU5MODZoaXptM3VMV1Yyazlw?=
 =?utf-8?B?ZjROaHQ5djM5VEFZRHBqZlBsYUVFbWdoY2NmOE9ENVU3Sy82TkhvRTFkYkRo?=
 =?utf-8?B?eSs0c0tJbU9VYXF0R2NYOHFrZmV0YWhPanJabXVpSDRNNkFNa0FBbnNKOHh0?=
 =?utf-8?B?Q1BYS3VRc0VHdmVDZTdFMlcwaXpEbjlHYXV6WEFYc2pFdWMyT0JuU3gzZVFh?=
 =?utf-8?B?NThmejdLQzFSb0gwZjNmbVlKakp6UkdvSFBZbG9UelpNYnNhckxFVEkzQVlJ?=
 =?utf-8?B?RlRyZ1hSM3RKY0VkakRpc0NhT0JnT0hjRkRHZUg2dFRwSDdReDdxVnphOUhT?=
 =?utf-8?B?NExQU0NyUVJZODRFZURhSmRPYXNCd1JXY0tiZ1ZhYTc0WEhtdm55cGszVi9h?=
 =?utf-8?B?b3Z3YkZGS1VjYTZLQWlpbm9PR2FabHZaOFdkMlEvNjRvcmpVcmI2YVdTMFBh?=
 =?utf-8?B?OVdkM2Q2SklHaWczRHA3Mm9vSTZ4cHpTYmd5OTBZNWRZMVZJMEdGc20zMDJr?=
 =?utf-8?B?Y0MwRHB2eER4NmFlWXNrRStPcmNqSjMvZlBCZHJxS3VqYmVsc0xVZG8zZHlE?=
 =?utf-8?B?ODJZN0VncmFxUlg2QkM1OXNrLyt5UGZDeVRnNTk5UTYyeGs5ZzRkSTdjNXRL?=
 =?utf-8?B?NU5admQxZ0MzU3k3RUpvd05mZWI4bUI0a1J3VW01NytRcm5ZTDZLbGNzYyt4?=
 =?utf-8?B?TnQ2d0pPWStsQ0JJeU5QZmpmbVhQVnV0RElOZ1M2ZUJ0NWg4WkNoa21rdUdZ?=
 =?utf-8?B?YjVRb1VEeHFsdnFxUjBTRFBLNzE1aU0rdkFoZzVKQ0lGRjlJVXpGZ3NnbFZv?=
 =?utf-8?B?eXZMd0t5a2xXcldFUWpYOU9nMXJuR2pLZFc3SEZRdnpYKzJtWitxbFB1Vkdm?=
 =?utf-8?B?OEFnVXdOd25MNlNON2hPNDduaWRRZld5VmdYZCtNTk5reVIrZ1V3a3JzMXJL?=
 =?utf-8?B?Wno4cXU1b09aakxTaGlUSmh5V3RjRHJ3cFlwMmh5b2VwUnJ2SURzZ3o4eElU?=
 =?utf-8?B?QzVtc3U5eFAzWXAzbTZLazh1ZG0zUHJ4L2tLaVp2dk82aFh0SnlZTTh6N3hW?=
 =?utf-8?B?VnNLbFdmUXRFa01SZHhaOTNZNUVDeEhwQmVsamwzUGxYK2FCMVRPZjZBZmsw?=
 =?utf-8?B?dElWSnJlb2hwRUxDNGx5NHMwUUg2elA2YkhURzB2R3pWYjk4QWh4dkRISUxj?=
 =?utf-8?B?bW54a21RbVlBOE1BSGtnY1RncXZQdzJhZWxHeUJJaHFWNXR6emo1eHZ5MHN6?=
 =?utf-8?B?MkU4TlBTd2M5b3NpK2J5TmJicmEyUHF0dDV5Z01BOFJSOGJzeWdENHhnYm5Y?=
 =?utf-8?B?UzBCT0xJbFBuSnNNRDJaTXJQbWVzVGZQVjVyOCtuM2lIekV3a3RUT21pN2Vp?=
 =?utf-8?B?Yk5vQkRaWmFUdCs4WVJkYUVxRko3bERhd3V3WjVqT0RqYVZiQzdmODVLYmQ2?=
 =?utf-8?B?YU9uVWFhaGxwS0x6VHQ1dk11U0ZJZmFVRDdXc0o2b3g1NzNXdG5ZdTNOcXU3?=
 =?utf-8?B?d2QwRmNsdFc5c2ZQNG5VL004T1UrRjBCVnBxQXZIZUtQbndIOWllQUhiWm80?=
 =?utf-8?B?Q2FHV0g4RFhucC8rNHhFSVBKVDVVc0ZXNFlQbHdyelpPd24zWjFZSlhpWjQ0?=
 =?utf-8?B?SDVkZUVmVCs0OVA1S1F2dngyVnJJNGFaQU1HT0wrZWVacnp3clg0VVdqMnZE?=
 =?utf-8?B?Q0lvTzU1REtuTHAxcUcwUm5GYjA1aHFsNnZZNWNvYVFNVEE3RjYwU0UwbzBP?=
 =?utf-8?B?T3NGSDNvWVQ0THhtcWRuZmdhSHQzMldZWXNva1J0Y2Z4aHBpUWpSUDlpYlV2?=
 =?utf-8?B?d1lubmg4SzQ5Z2tQUFhjdDVHUzA4a3hlejU5TEFkdFkrSWhqQzlIUzZlL3Rt?=
 =?utf-8?B?UDFjUHZLSEsydDBDb1NXYmZJOWhtTFNVNXpVOFI0S0J0NkxtUmllWFNITFpJ?=
 =?utf-8?B?V3JhY3N0VTJiZ2NIK2IxRjJWdHpwTWJLdXFsRUhadW8zbGNVbFNDdz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe21b1b-1708-4266-ce93-08de58964248
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 02:39:11.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk4ythQZImA7Ys9rCz341VMK+BlzCPwwqDFcHdjKpvC0OnX6mnXwSJt59fj46t/ge8JGhufYyUGkxxaZg0+XSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-Proofpoint-ORIG-GUID: Ls5uW2DgwDW1Iy6x0j0W19Lhnlmm9J5i
X-Proofpoint-GUID: Ls5uW2DgwDW1Iy6x0j0W19Lhnlmm9J5i
X-Authority-Analysis: v=2.4 cv=U++fzOru c=1 sm=1 tr=0 ts=69703c52 cx=c_pps
 a=5QB7A90Jg1Mn+JdiV6um6w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=HRx0GrTwVZuFjjfo-f8A:9 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMSBTYWx0ZWRfX3OOEYAArAtLF
 AEwcBBRNUWcXxGszoQZn6PH4V4NHHcT/b7msVU+aS+9LyZuoTyfCnTQoGMALDZcMnBdB4DG/ncW
 BSqKx8+KVhgBLGvtzLceKc4XjmuiOewe1Z+cwmqY5gYy2g7tMYMgNKmVrWNUY+tudS4UfFn+hfP
 vlK91kS4z3Cj71OrNxZQmLkK6o3HfEa0l53NoD/jyllP0VrqM9wrgaljVkGbDUvvUQRF4qLC6yE
 CT1y/V3UR1rlg12k0fQIboZ188lY0MKuKjcXsB0XkF7YknjKcDO7yW4jAHPycsYIqqT2MEz8Hhj
 hOWHF5KrKU2fWIlBeI5I/28C+YgRRmsBtjZxR4rSEN7xUaTESm4eabWBTvbHTfaDAtFt99GgDxc
 cCpRi2dp7sa8M/sB97EwZaAbLOLU2gCOPw0lU4Yi7P0mZVXhuuh6+QlZj++m4KMXmffOyMX7rzM
 WM/kkRnplXz9dtM2Hhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210021
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:39:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18823

ping

On 12/30/25 10:54, Chen Qi via lists.openembedded.org wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> We cannot assume ud has the same fetcher with origud. For example,
> if we set map git:// to file:// in PREMIRRORS, ud is using local fetcher
> and origud is using git fetcher. In such case, the ud does have the
> 'shallow' attribute. And we'll see the following error:
>
>    Exception: AttributeError: 'FetchData' object has no attribute 'shallow'
>
> Looking at the logic of this function, I think it's the origud's shallow
> that should be checked. So the logic becomes: if origud is using shallow
> and its full shallow tarball does not exist yet, symlink to ensure it
> exists. This should make more sense.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   lib/bb/fetch2/git.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 709c692a8..f288afb51 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -359,7 +359,7 @@ class Git(FetchMethod):
>           super().update_mirror_links(ud, origud)
>           # When using shallow mode, add a symlink to the original fullshallow
>           # path to ensure a valid symlink even in the `PREMIRRORS` case
> -        if ud.shallow and not os.path.exists(origud.fullshallow):
> +        if origud.shallow and not os.path.exists(origud.fullshallow):
>               self.ensure_symlink(ud.localpath, origud.fullshallow)
>   
>       def try_premirror(self, ud, d):
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18656): https://lists.openembedded.org/g/bitbake-devel/message/18656
> Mute This Topic: https://lists.openembedded.org/mt/116993661/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


