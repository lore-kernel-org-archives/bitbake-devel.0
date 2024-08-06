Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A39C49EA1
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 13:50:30 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.7756.1722952229129719225
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 06:50:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8948c99a11=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476525PO007305
	for <bitbake-devel@lists.openembedded.org>; Tue, 6 Aug 2024 13:50:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40s9ry2v1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 13:50:27 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476DoRPi006997;
	Tue, 6 Aug 2024 13:50:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40s9ry2v1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:50:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCNU+IAYemPvPei2T5F+5JD4ENmR6iJxEQ8UX+bqVvp/KvDV6HqK04rihsgXeghPhYnO6cxUFT6kuDq99Rw5tQwp8jCAter01TBtryAArWzdXMYIbre7pimIDHPMLuwkiebL1tziYg8iAShhjqRsjst6uGUeXNeQen1ii485wvKT78y2HYPzsT9E6QshKgeTpOBSANQc4OtUDAjDRgWyZv0KX/3QwxS4ZgJZ++xU+7I6tXCdM3HJ98jOPhdwsgMWrw1ReJBW2k0/KIcPSgoi4UX+M4DC4sTGgtUJtfv1peWJYKf0FCoOkFSGMck6Wm1CyAD3efIxymxdwD2mZscyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMwnmY/WPoNn/Dg7VBZ950DKq3uf8KdRKpLILYJy8OA=;
 b=uJ5xDckfaWru9MvoDKl0et38FhYlDajqyjaMo7vUj2MQMLW8pg3DLgdjt63Ta/lb3vQ9+5a0UIsDCOQpoo2EUrXt5Xob4YQPZeRQIjWmVqOFyApRt2JEmPxUCzMsI8TjIHDkiL97Lgpfje42HEHuhNYLXJUf5ZSP3Zh3d5G1yw7PCNoHPWmjGHnYdqnShQlcBJuz7/QwST5MZuT+po1hP9RBClFjEYORwKpfVrwOMhFKtkIo1a5qmH4z5uSyJrcZmXr2G+mYiUEs5IjNbpOQVIGN5SEVUQJxnhnyBcaQG2eXHbiVakBut+nnJpKFFo+iISVHhCxBgQDIq9czvPFbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:50:23 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%7]) with mapi id 15.20.7828.024; Tue, 6 Aug 2024
 13:50:23 +0000
Message-ID: <5ebcc686-bae5-480a-8579-80faced243c7@windriver.com>
Date: Tue, 6 Aug 2024 21:50:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org,
        Ross Burton <ross.burton@arm.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
 <17E927848AD479BA.28314@lists.openembedded.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <17E927848AD479BA.28314@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cab43cf-be61-424e-3214-08dcb61eb80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SE9HNmNBckhuSkt1Y3NVV3R2Zjc2NWFtTnFhSlJ2ajJHSm1BbTVNNTVZRys2?=
 =?utf-8?B?d2lHUDhuWW9IU1VILzNpWm9sZ251Y1NzWllFNUNIeDhRUndpcFpnK3RYUHhX?=
 =?utf-8?B?K1B1VWtNZ0JRcXc5VTBUY2crYWZ5b3ZEOGRKcUJJSVMxTFVMNlZRZWZkRUN5?=
 =?utf-8?B?NCtZVzhxYnhYRUN4TEhyVXFuQzhza1RZcGRsQjNIQ0Nmc2JBbTBtdks5akxl?=
 =?utf-8?B?U1Z1RFEwaks2bFB0d05wUXVWOG8yTER6ZmlLMlRLNEp0VkdIbi9DSDJBNVli?=
 =?utf-8?B?aEV4OTBEdnRYcHEwYkEvMWJqbDgrYThhU0pzSWp1N2xnSUlZMzE0YmFRTjUy?=
 =?utf-8?B?S3gzUnl4aGgzYWVici8ya0d2VUEzVHZXcFl6bHR3SGI3T1VDY1ZPRFdSVVh3?=
 =?utf-8?B?bkFWMTc1M1RycUdJMHNjWDE3T1hRNHNrMGNRRWtCZ05yMXQ4Q0ZzNUNMM0I2?=
 =?utf-8?B?RC9RYWwxVUNWandrMzhWOVNEcERPNTBKakY2TXhxZFRWWUhTaGVUbjVpaU9t?=
 =?utf-8?B?Y1V0NFdQNkhqRGtpQ3lzYUJ0Tm9WZTBlWE5wUk5kZElOd1BGSk9Edzk0Vkcy?=
 =?utf-8?B?b3ZCZjl5eWlKK2NoaGRZU2JkQXRrQ0JkYTJhYXN6eGt0dTZrME5hdGRjUVRm?=
 =?utf-8?B?SEErWFZiSkdHR3A0OXVvd2JoSmwvWFg3VHRpYUhRR2k4WldidTNjVk4wUUM2?=
 =?utf-8?B?VCtmR1VnZGdMZDFxT00rVFNlbHJEZWZ4c3hpamN0dHloTnhteWt3T004RW5X?=
 =?utf-8?B?UDZER3BzTzFON2FON0pIR1NPd0U0bG42dldrelZOUHlPWGwzWXBPNkl1UFNJ?=
 =?utf-8?B?Smx0S2g3SDlnU2Rpcm9lcVUyanZiTUdidndSOExEWW5FbW5JTXNvZE8yQ09F?=
 =?utf-8?B?dklVeHVVQUIwbnZtdmw5VkNaNHNPaktnNk5CUnFIYVFmM1I2aUZSMDhaVE9x?=
 =?utf-8?B?TURuUk9hTHo4d3BBSDVKT2I2QkVMUXRGM2xnWFBvc3A2N0pDRWdkM2dxcWhO?=
 =?utf-8?B?d1liS09KV1FYRkJFUVRReG1KbXluUXpPWGJ4RnFWcG8rVFpUV3VEdm02VzJy?=
 =?utf-8?B?ZnNGdTZNWWUwVHo5cnlCcDdvWXE5RnoxdGp6Q3BXcGpzaEg0WEhSN1NuV1pO?=
 =?utf-8?B?SEJVeldWU0dycHZzaS9hR3JNcjVnNXd5LzFuZzJFbFVUTThoUjdwN3FyNGdu?=
 =?utf-8?B?WHI3YVVtMlkxWllBUXJLaWRmNlZjdXJWMVc0ZTJSdzVzaWlXOVZNWjg4dkRN?=
 =?utf-8?B?d3lwZ05mS09Cd0tESmNHM3JBUXQxSGo4ZHU4NGhYUHRzU0lHTWN5Wk5vRENk?=
 =?utf-8?B?NzN2MHBhTURGZkZ2Ui9RMy9hSVo4Sm9PdThqSENIaVFYbXJJUHNHN3ZCV0dP?=
 =?utf-8?B?MmlvUmNsV3VwSnltTkF4L0htcjVNbWtYZFdEUDhGWGZHbXA2UVpUL2x1M1JY?=
 =?utf-8?B?QWZ3SFJuWXd0dzM5UzA0Z1JYYU0yR2xpZEZkL09oZFVudFh1TGhSVHNRZnAv?=
 =?utf-8?B?Ull4UU5lVG5JT0FuTVdjYjZFZTNuajFPekg0cDRQOHNwc3JDVUt2dW53MFlX?=
 =?utf-8?B?SkJLSFVmNTE3T1luNGhHL0s0ZmJsSmhYZ1RHNThqQVVtNXhTYy9uejZuc2hK?=
 =?utf-8?B?Y0tNeHNPSngwSGRrUlV1QUVrWkkybGpFSUV6WDdscEswNE1URUdiUHZGdHhM?=
 =?utf-8?B?ZnlOeFBsZ3J1TGloWEoyUVN2dHR6aDh6N3Vvak11VjlNWCs1K1JTS2M5VC9p?=
 =?utf-8?Q?rhWtSMny27M26+3w6SRygXDgQifa/PMeDoGhgsr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1NlOFBoWWE4cUt4dm9aL2dQRVp4SWdZL1hOYXAyVUtCZ2o0OVp1L3JuQW5l?=
 =?utf-8?B?aXRlSW1GSndPakZXaXZtaFAwUEpZOFMvZnUyQ3hKS2FjK1pUUVBBbkIzdGpp?=
 =?utf-8?B?VytaRW94eitPK2VlcEp5a29uL1dCV1o5VGxXR0diREFCa2pvaWg1NG9MZGJh?=
 =?utf-8?B?dzBUR0xadjVlWC92Sk5pMlhNckxlellNNUFRN1FDSWg2bGVqSWpKWkpvTWlq?=
 =?utf-8?B?TElXZ0x3UEhoTy9NUC8vaFVHTEJnenNQUExOVkt4TzExZHJHTzJEV2ViNUEv?=
 =?utf-8?B?d1RLR0VxS3d6ZXROUVRHNjRsUFFZellYeml3RlNybzBHbjBUV0RkZGszNlU1?=
 =?utf-8?B?Y0xTNVdhbXJFQWlSVjEyZEdBUFRqUTdJTHRwampyS2RSY1lpcm1WaE1tbUhx?=
 =?utf-8?B?bUg2YitZTlJjaGV4YkhiSnY2cDhyNzRvanVWUDRySWFrbXg2N2t2c0dubDhB?=
 =?utf-8?B?MnBxbDhMVmYzeUo3dkhFMFlWZWJvQXpKSUtwQjJDYkhuT2RQVHFmN0d5OWw5?=
 =?utf-8?B?eTllVnNCNDdvRUloVkRXWU9JcGpqSk5PTkVQelNvdjR0Z016T01HVFZUaThN?=
 =?utf-8?B?anNXTk5kaDJ4QlZBTklCNlBmNHczTmlDRU85NGhLZ0hGQlpoQjFzLzVjMkYw?=
 =?utf-8?B?dlZPckhxSk5UNTFJUVQvanZldkpLVSt6akRFa0JNRmhDcnk5Z252b0sxYjhO?=
 =?utf-8?B?NHhIcXo2TXg5Yy9hZ2ZmYkJMK2JFdXZ5K3NvRGlpazRZRVo4bUlBZkhUcnY4?=
 =?utf-8?B?elVHMVNWNFcrTUlPZitSOExvaGFwLzlKMk1nUXNvZ1UzUkhrT1ZzRUFYV01w?=
 =?utf-8?B?ZW5nMngwekFscVBoWkRjSjZxV1lMYW5MVzM2WEh2NHZpdG5GQU9zaWh5YUJl?=
 =?utf-8?B?ZGNrQWNtVFhxMXpkbkdIWEh6c0RZY2VIcWJwYjNxY0VKcXJydUpWN0FLeE4r?=
 =?utf-8?B?dngzbmJTY3c1cXl2dmtVeTJSd1U2VHBONUlObTFJc1BGNGQ3SVV2ZTI2bkRM?=
 =?utf-8?B?UWQzdWJzWGNDbjZKWGhXNFBId3BpTmFiL2lsajk2QStOOFNZcTg1QytWajcw?=
 =?utf-8?B?cmRRTjd6Y0Q1Z2Z6ZElXNlhXbnYyNXVXcklwby9JeWxwM1Z0b2VZODZ3NkE0?=
 =?utf-8?B?VkJaS1QzWTJQczNGNENhK2hxSVNnZ084V2NNajFnNS8xRStiUG54K0c0dTdM?=
 =?utf-8?B?TFprMXhQK21iZGRuY2wrZCttR0tBNXRNTUpFSjVPQ0hyaDhqcU1LRGQ4VmpG?=
 =?utf-8?B?MEFEQStlbWovb2dMZmNaSnVBTnZPckxkWWFpYlg2SFp3VWhDT21VMGNjMWxj?=
 =?utf-8?B?Q2VJTlpzd2thWDF6MmRSQXZlN1RSSEg4TmhQR1RvVkxtK1lYY21JR0lENlZS?=
 =?utf-8?B?Mm9iYUs2T0R2QmxEQ2JTdnVpNkRrWkROZ3hVWCtnUi9NZjdzcVFPVXNlMEJM?=
 =?utf-8?B?d3B4dDlURm1rMjZtK2hDdXpLaVB1QWd1eWs4OWtYS1VVUlVJUzE5TjVzUXpB?=
 =?utf-8?B?Qm9VK2FPV3FjY1d1SHErWHNKTGhIYUtOQ2VLNXNDcERTa1N6SVVFcDlwUkc0?=
 =?utf-8?B?eVd5Y2E2ejJvemplWTdBemdwTVJhMWRsUncrK05qcmhBMmFibVhXa1V6eUhi?=
 =?utf-8?B?M2pOZmFhU0twVmRPczNkTkNzd1RBU0NLWWl5WlAreDU1SU5BeHpVYjZTQTNm?=
 =?utf-8?B?UFIxQnF5OGoyWm1ydXlWamFQN0ozNEl5bVhheXQwcDVtNmlialovNDJ1a1Rl?=
 =?utf-8?B?SXMwMkF1Z3NXSWVLOFRIYmhzYk94bGEvcEJEU3d5dzF2L2VDZWhjbFVmRVdm?=
 =?utf-8?B?Wm9KRHZoNFdEUUV0MVR4QWpOUGNXdHVrTEdvMC9kV1M3Y0YxVytFVE85SkxL?=
 =?utf-8?B?VXFKV1Vxd3pqeTJWRlZPTUJWbml6TmZwSzJidHlCZnpma2JBSjgwVXR2Qkxt?=
 =?utf-8?B?YXo0QUM2ZGJ2cDlXaktKOEtCOWpyUTZIczBaQnhYdmpON1dXMWNYRG4vb1NE?=
 =?utf-8?B?SVFZeVQ5TTZlQ2M0VUxRU2s5bnM0VjlJYlZobWlOQ0QzWDFZdWJpM1ZUZUJI?=
 =?utf-8?B?WTBlNlhtZ1lvbktoNi9qWmdtUU5VbUFHcVhBRG5mbnpZNURaejdFV0FVWm9m?=
 =?utf-8?B?LzE3VnRzcDhYazN5MDRjcnZxTGNMZ1FySEpBbTltRlpLMVM0bnoyaC9qd1Y1?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab43cf-be61-424e-3214-08dcb61eb80e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:23.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR39PaDhWi6fKdJlTCeZ/ujSxtLa9VHeNLRibMd4d9faSAE/TeBut1CgY4gqsl4KVjohMGINexX4AfRHqE3kWsn+oNLzFvAB8wFUN02Ulto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-Proofpoint-ORIG-GUID: F0n1q7WzE9bpfJe-8WwGegHhNrZwXFVk
X-Proofpoint-GUID: St0nssvrinKqYOXeZfTdF_LDLi7MUFNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=804 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408060096
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 476525PO007305
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 13:50:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16448



On 8/6/24 21:42, Robert Yang via lists.openembedded.org wrote:
> Hi RP and Ross,

Sorry, correct Ross' email.

// Robert

>=20
> On 8/6/24 19:06, Richard Purdie wrote:
>> On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via lists.openembedded.=
org wrote:
>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>
>>> The previous code added local path to generated mirror tarball name w=
hich had
>>> two potential issues when fetch from local PREMIRROR, for exapmle:
>>>
>>> Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
>>> $ bitbake lsof -cfetch
>>>
>>> * There might be "Fix File name too long error" when the local path i=
s long
>>> =C2=A0=C2=A0 since the path is translated to filename and added to do=
wnloads/git2/ as:
>>> =C2=A0=C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
>>>
>>> * When enable BB_GENERATE_MIRROR_TARBALLS:
>>> =C2=A0=C2=A0 The tarball name will be:
>>> =C2=A0=C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.ta=
r.gz
>>>
>>> =C2=A0=C2=A0 The above tarball can't be re-used by do_fetch since bit=
bake looks for
>>> =C2=A0=C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.to=
.local.PREMIRROR' in
>>> =C2=A0=C2=A0 the file name breaks the match.
>>>
>>> Use os.path.basename(ud.path) as gitsrcname when ud.proto is file can=
 fix the
>>> the above two issues, now the file name in downloads/git2/ is:
>>> github.com.lsof-org.lsof
>>>
>>> And the generated tarball is:
>>> git2_github.com.lsof-org.lsof.tar.gz
>>>
>>> Or when BB_GIT_SHALLOW is enabled:
>>> gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz
>>>
>>> And the tarballs can be re-used by do_fetch.
>>>
>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>> ---
>>> =C2=A0=C2=A0bitbake/lib/bb/fetch2/git.py | 5 ++++-
>>> =C2=A0=C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git=
.py
>>> index c7ff769fdf..89d3268f7f 100644
>>> --- a/bitbake/lib/bb/fetch2/git.py
>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>> @@ -277,7 +277,10 @@ class Git(FetchMethod):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedre=
v[name] =3D ud.revisions[name]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revi=
sion(ud, d, name)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % (=
ud.host.replace(':', '.'),=20
>>> ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace(=
'(',=20
>>> '_').replace(')', '_'))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file"=
:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
itsrcname =3D '%s' % os.path.basename(ud.path)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
itsrcname =3D '%s%s' % (ud.host.replace(':', '.'),=20
>>> ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace(=
'(',=20
>>> '_').replace(')', '_'))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcname.=
startswith('.'):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 gitsrcname =3D gitsrcname[1:]
>>
>>
>> I did look at this patch again. I'm still not convinced about the
>> original use case but ignoring that, the patch itself isn't too safe.
>=20
> Thanks for looking into this, the main problem is that we need a way to=
 fix the
> filename too long error as described in the commit message above.
>=20
>> If you have two repositories with the same name, this can break since
>> basename() on the URI is not a unique value.
>=20
> If the two repos are identical, then it isn't a problem since bitbake
> can handle them correctly, if the two local repos with the same
> name but have different contents, I think that the user should fix thei=
r repos.
>=20
>>
>> Just as a note, '%s' % x is also poor code as you can just assign the
>> value.
>=20
> Yes, absolutely, that's my mistake.
>=20
> // Robert
>=20
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16447): https://lists.openembedded.org/g/bitbake-de=
vel/message/16447
> Mute This Topic: https://lists.openembedded.org/mt/106812686/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liez=
hi.yang@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

