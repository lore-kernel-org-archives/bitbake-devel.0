Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46151CD37AC
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 02:44:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3400.1778640291565184718
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 19:44:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AS314T58;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=959349fd7a=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D277N6014771
	for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 02:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=U3W278xhlm9DhEEm4toVPNt8FbFDfdV5lNzigycY5bk=; b=
	AS314T584czhkpcDpuV7Rg6u96lkJA+JcM3CXJmTjrRt7BtyNkhiRPdhYANk9pwI
	wBV8YygBXVdE6mZOl5Dzy7tzsPg2TCRou9LCHvCaHofpHhr8b4hxDLu9Nl1jkoAI
	5Zn2L95Hels2VHYDrxf6D6YyulA+t7bFr0VtcuF2IuKuwnkZWVpA0NtT6S650ECq
	ywkH8xA7ss6sIr6ASTOap+/d3/UCxRe3xiA9iukYsABhfEmgSz1m4mdCf5HBU+1S
	t1Bv4TT0DC+D6PspI+oFB8AOOzi8+BplOElgmAxAnWhgZaPROEbu4QUws0+NMBld
	bwjjv2lQmVHuTq3AHnmSYA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4g7fg110-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 02:44:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLykMaIFzBsVnQCEAYe9gObdPoCmcNz4K+i/2BQoF1VvXPIAb2JS9qknMsfpFCtuNyVa/rpPL3um03rxV02hgZ692dRwbM6USk1V3SFxbY/D8ZPTdsZLGe+4VOvSRVxeP37tixIoXtrFmzFUUFxkfmx3ljok0dszVoBptsPUbBJFy9ZHhwr2iKurFBlOAl6J5ROhAZC/JDnBYhHpj4EwO0jS85JEnwecmsKrMw/CJnCCfDD7EQWL864B1CjaqGBR8i15l1YibCGOwPFE59NUfXU1NaTKVg4sn7YEAgPma0+GcFyCNW4/GqkWdVyyOGvs4b8lzZ38BGyPiTEpsWstbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3W278xhlm9DhEEm4toVPNt8FbFDfdV5lNzigycY5bk=;
 b=h33dxP0n/yZZHBzuq69SbwYRHUydafpcoK4QFiixL01qR1m62JvwcLf18gK5EpgUYV72H900yJpwYJZVTgJQBB4w4MtxF/h4dwd0idh8mLwxC/CHWM+MuJ2i+JL3YIUY/0n/PTxHJPYuiIsoY2x2OAvpTKUAOMa8LI+3aJDL/+SGUplrkArTG9pzHZkS9CkndIXrRS+UqWiDIdz0vSOeGVlFO3NkC9iLevtWvJBtm3cXjFlEselO+oVfdCqF4+eFmdjnNYFVXCDN67MjKmvF1eD9T7z9U1MdKhP/hYohDxIIvk9po/JgRbCfWs6jVNlsR8inr5fSEjyBoQ80enKBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:44:45 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 02:44:45 +0000
Message-ID: <25559c76-6f2b-4b3e-8f62-1bb7ff3ac305@windriver.com>
Date: Wed, 13 May 2026 10:44:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH V3 1/5] fetch2/git.py: add filter_regex
 parameter to latest_versionstring
To: mathieu.dubois-briand@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
References: <20260509052950.1565384-1-Qi.Chen@windriver.com>
 <DIGO5WR624MA.H8CQYE00ZS00@bootlin.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <DIGO5WR624MA.H8CQYE00ZS00@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0180.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 174298ec-704c-46c9-bd8c-08deb099977c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	YuNyk+BvEggZViyUUTW1SC5/C6+XVWScbH749WMDE6RLyIgDDWPc9hnXYmDNnstNJldxGUVNw6ps+v8daAjAOn556Tg8GNZpzNGI+wet3pu/tyR+xyo4SHsMDZtj8IlablL1uztkXrEFu8o+TDLBK7saThr2Didak5wLhL8zfww4+R1fLWx6IKttWzK6wFsV3udYFI9yuyyv4FkoL0aiBQF/sxENr+TT180PJgnrmw7FBqdM0NStz2B9szUuddh7Y54VOXx+P/PHwyRI5/w3vf8a//PAVTUxE82LOhqJiNo56wbJoRhfaW+fvxH9RVF6EUpbvMEbfD1Wsa6mOk5fYbBPU8Qfb4VbGW/DX5oYzgvwVnHY0Ss6Dx8oXtoqyReJjYTdpOt8FB7ZKyyiV07aLo4eS72DGTctzXFxjgWQ4hPGbUd7xVX0QzXsO5j0hsyXVQYE6YxcuIBGcCjoPtuFHc6NZC0wj4TEnk+yjiIzkYN0eQE7ZQYB97cEQaKZr6JoEAECuU2HeXEReMQAcBdwT3LfqlVq2gfOr+QkBq/oWHxs8GUTtCTVMwLkq340gkv7YN4BynXITcUXZ+P8XNl1S/jufNbTZs5gQLOC5igTbJU2Fmg+3+WflXO8pW0Fjd6d0yQMovMguQ/OfHxMziasjQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cytvQ2gvbXhyUUhKS2VuWG1iNENWdjNYRlZuUUt6OC9wS3F6MkI1czhhVll2?=
 =?utf-8?B?dEtyaDhjSlBOT0cxclh5eCs4cGI4UHNkbEVZb3RYcWQrZGZTM0hDOGJmYUdB?=
 =?utf-8?B?aU0yd3A3YUhCQTV5aVBJNEVqSGZlWmV0OEc3QVhmd21DS2JtUm5KOE9haklE?=
 =?utf-8?B?UmVwZFFlb0toV0cwc1VVRWdzQmtFeXNzcDkwdElkSFRBc3dBbnpHRjRPSDdR?=
 =?utf-8?B?bjIyb1NidXNJcGVLdVU3YVUzZDk3a2Z4ZW1SN0VSQXkwM2pnQWJtcFZJM0R5?=
 =?utf-8?B?cFErK3RYRUxsaFZsSWVnOWxkNDlOZjlaZ1ErV2IyNEl6Z1p1RC8xUTZ3YXkz?=
 =?utf-8?B?MTFRcThmMTRJcU9yY3gvWWxtd2M2MFU2NWlyRmY0VGpHQVorcTNzRmFrTHB4?=
 =?utf-8?B?UXB3ZXBNZlFpTy8vSXhqT2tocXBIb2c1eTNNMUt0Q3hTdXRtVXNOVEpQYUc2?=
 =?utf-8?B?M0ZHM0VoZ0puNGRpT2xSNkVBbDcvdTNNbWJ5VFJIYTBsV21GcWJjVGp6MGt3?=
 =?utf-8?B?U2ZZcjNYVVZJZGFGRWJ3QU8vdVdOeFFkaG0ybGp5ZFg5K0RlWEpwak9qcTgr?=
 =?utf-8?B?OWRGY3M1dHdwNFhoMWR2ZXB4TGNMTmRNc0dlbTltWG5FRmw1M0w1L0ZteU90?=
 =?utf-8?B?MXRnanIzK0FLYVowVHVKYlF2TjU5TURQMFdOT1c0djUwbmxleTlGRVhUZVh5?=
 =?utf-8?B?S3NVMDhKVGtuejcyMW1tTUt5bzNaa0RwQWwyU1I1S1FBOHJMMWhJanpmSHF6?=
 =?utf-8?B?ays2WmJXMEs0VnBaUWdvQmdqM05xTmFoaUhmamFHQWVyL1Q3SWc1OU80UzQz?=
 =?utf-8?B?UnNiK3BSb3lqSDVHL2xodnM1Zk5HU2lTRWc0V0JmMFRmZUFGbjFkTTRmck1t?=
 =?utf-8?B?bi9xK1FEc1RKM2FHd0kvT1piejluSUpsSjcwbFVvMkZKZUZSZ2Q1L3YzZEp3?=
 =?utf-8?B?SFkyRXBoeHpTQ0lEVXVRbmh1YjB4b0xFL085U2RrTWhmU05CQzJEeGpoR2My?=
 =?utf-8?B?b1dxampGcWM2aFZUWHZzQndDMkc1ak4zSnlackdXYnd4S1JpbGdEcC9mMFAy?=
 =?utf-8?B?ckNLZzlNazVidmVOYjZ2ZG84VnhPMW54VmVrbDVNanUzZWJCN2hSUjdqNVM1?=
 =?utf-8?B?Qjk2bGhiY1RacVZJbmszbTVvWU1vRWxtRDVzK3lubmVJUUFpbFN0Z01kaWpB?=
 =?utf-8?B?RlMrd0NXRmx2Qm8yQjA0QllqSnF1aVlhSUtTUEdCbkh3cXB6OFllOVVMVkJz?=
 =?utf-8?B?eGpEcnFMZE01ak44SnViWGhZckhqdmY4bEpNUlZMa0cwMVp2S2tkbHRTajk2?=
 =?utf-8?B?UWVvcENnQ0pwNTZjZkZtMENZRFl2Qm8yV3MxT01nK1JoYnZiNis2SkYyR2Iv?=
 =?utf-8?B?RUJBdW9BSWxjZEU0cGpzUG03MU44ekZxMEhOUk01S1hVaTVzMEFxbGVOZ3Jt?=
 =?utf-8?B?MHN1bkV6ZWdMaVZsMFVrM2NuSmg2Sy92b2VoeDV4OFRZbkM5RjI0N1o3RUR0?=
 =?utf-8?B?T0VqVStFR1FjKzBHcUVPQnRoQy9JZHFRRHlvb0ZqV20vaGhQdGdaMlF4a0R2?=
 =?utf-8?B?RDFvUzA3SjNBRXg1Z0N2WEtqUlVHdTZ3aEJhT09UQXhZTmdPZjBRVHg1S3ov?=
 =?utf-8?B?dXo0RDFaTXBMeXRQSmJ0ZmEwdDRoRldPb3kwVmRJMW9Xc2Q1dzR3RjNxYy9N?=
 =?utf-8?B?eGpONFNWMmVLdE1DVWxFSVk5ejE4cFJqeXNwUUR3K3ZKVGRuU0xsYlZvcnhI?=
 =?utf-8?B?TG5IQTJTNC9JYVhZdExsVCtUb3lPOUFlMXViMm15eVlRTzl6T3NGcGozNVc2?=
 =?utf-8?B?NWhHeUdhZnowOStHZ2NYSjhyR3FHaG9hb1VZMzAxaWoxd05jM3RkTTY0RjlK?=
 =?utf-8?B?d2pUU3I4dXRkay9jc2E3UWJkdVkxek9qdENYb0FXOWhtYnJWSEFtT01Qa3Ja?=
 =?utf-8?B?QWVwRitEOGlUa3hpZG5UZ2I0b2UwUEZRL1lZR0U0VnRWbFNnNGRTY3FTNXA5?=
 =?utf-8?B?bC94OEVsenI5QVVXQVA4TUZmYnlFOTY5Y083T2V6dC94ZDYxVjAwNE5kRVZ2?=
 =?utf-8?B?NjZHRUNPLzZDK2x6cEZxRXB1OGk4SU9ERDRiL3BBaGJJakhXNVJYR2hpd0pm?=
 =?utf-8?B?NytJWlJSZzd6dlB1VFpwSzNkOFRTbU52cTR5Z05CZ0o0bVhSN1RQRHVMRk9O?=
 =?utf-8?B?NytZRmRWMEJISmlabVZHK2RCUmFtWGRzdVZMVFBxNmNhMm1GdlFqY0Z3elBM?=
 =?utf-8?B?OVBXOS9Da0VWTVNJdGMyWGNMWjJiUVJjQnRmeGM1Yk9OeE9xOW54MmZSZFNW?=
 =?utf-8?B?Nkpob0w1K3lxc0QxTW9rSnlCN3c2b0dNa1RxaDZ3cUZ5VXBGZlAvZz09?=
X-Exchange-RoutingPolicyChecked: 
	vFPf5gFrGSqUFdCRRSELpVJbOyI2o70m+Yz76D0in2otSX7WnbXAFVeex8NaH29D6eOvZ84YLZRu2Ds8C/fU4wLWvptzzzmGrAM12vo2LP7rcHImEs4gf2H7TsL1+Cs+am7MFgnuBYfWTQfz30ARlhGrFdhHQG+jfVKIcRA5fbBkQ73wXIrXI2bnA9nwUx5UcSpUbx0SkKmwMp8KvjI6azMqPOuNOuyNZO+//ZBx3RAFDs684xO72aOsysd4aip31jyUO3Ei7u8pQUGSSD717cpqLulai7KEPGHyUeTqGKW/efktm805WRL5cmxQW5YhU5R016kE5CLjryvqjsX2YA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174298ec-704c-46c9-bd8c-08deb099977c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:44:45.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aop7W7t4i0E1yuXXvo5Q8G+7i3q8wCurf3al02mVQ+ere7XnvrWWpZrHN+3CI9PEAzg7inidMZV0TPaaQoEtZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7h3r4JlT008PvPxQ0uF4feu18yy-eM-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDAyNSBTYWx0ZWRfXxhMwRxZOaa0a
 YnTUCB6VTFkRI2EeQcij7GW6b1/wiqngy/xv1AFd29dcGyfqfYkd4ZaOW+/MtoHJ64yl1SSY6/2
 bqcnw+h7k7rvRGvGCx+UoVUKJpOrhbZNlqe2PYGlJteNQzWB6qU02JL6bHvXmeyejEHjzcF1vYf
 f8BQZ9nPa5FDsnKhmXGwHmovY6ygmqg2Yx9E+LS0ymWXqJ18bVzCvYJSjwxq1Sk5pOtw4TSn/cs
 niqaMVOqijruWPhjsqPJHuFBGQoNK5OyHWMlLaFxEVwkFZEgiai28qvWIQ0dvN8fG0R6DAwMZ23
 KndhYDEv5SP25kNfpg0qUm/lU8eC36r5Ug8+J+WC3KLsAoHWdAzS/Ndxsld3KevBQmeKgijHxPJ
 LTrRL/A0pacTNAEd/XXJPXtVXJoYc4xeXPVtKrrU1djahX8i41UVQPk/bFSZnPVT3TTs0Qey3De
 Q3WCLQS+TQ3Azg+QDwQ==
X-Proofpoint-ORIG-GUID: H5O6fEUDX25bdNRSkH_mhq-lf_H8OLgb
X-Authority-Analysis: v=2.4 cv=V81NF+ni c=1 sm=1 tr=0 ts=6a03e5a2 cx=c_pps
 a=uvnHr/yu0CVMxYA77rd9og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=UdUQvWyo37pHmja_-aYA:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130025
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 02:44:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19500

On 5/12/26 19:42, Mathieu Dubois-Briand via lists.openembedded.org wrote:
> On Sat May 9, 2026 at 7:29 AM CEST, Chen Qi via lists.openembedded.org wrote:
>> From: Chen Qi <Qi.Chen@windriver.com>
>>
>> We want to be able to do stable version upgrade for recipes. For
>> example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.
>>
>> To to this, we need an extra paramter to latest_versionstring
>> so that we are able to filter out the versions we need. Using regex
>> has the advantage of adapting to different version schemes.
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
> Hi Chen,
>
> Thanks for your patch.
>
> This is conflicting with some patches that were merged yesterday. I
> tried to solve these conflicts, but I get some bitbake-selftest error:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3936
>
> Either I didn't fix the conflicts correctly or your patch has issues.
>
> Can you rebase on top of master and make sure bitbake-selftest runs
> successfully?

Yes, of course. I'll do it and send out V4.

Regards,
Qi

>
> Thanks,
> Mathieu
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19499): https://lists.openembedded.org/g/bitbake-devel/message/19499
> Mute This Topic: https://lists.openembedded.org/mt/119226364/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


