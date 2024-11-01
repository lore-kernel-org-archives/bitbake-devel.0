Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5653E6B244
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 11:36:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.35735.1730460976807916471
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Nov 2024 04:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1035258c17=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1AFoHa029722
	for <bitbake-devel@lists.openembedded.org>; Fri, 1 Nov 2024 11:36:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42mf15gv4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 01 Nov 2024 11:36:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ2BWSCLXZ3vNs5CPmIo/9r/VoHnxNRmWoGUUBwovwgq/Jhz/udBSHRGxbhVqf4w5cWszH95UTyCc8hM1rgBPLzwb4wQ5quoI3KVUfKweVkk2tA1xO2yRtMi1YepphelWXPleC/HeKizxeN4raRrvZ83wx8YBjFXxlz7uzwRFbyPlMLoxpRQWnDPYiiRxoDvYDsa2Tl6nL6dSkHC4r1Xo5neAuS+pEWVVuR4tRQcqrv3lE8OFT8yU/AlCaVHy/UCxrDgf4pbkm5MSvoDR+LXikC+/OjQd2mHC+J3+JqIIdWvKHr6yXbM/lLUhHDghVpbbOErdzBMlGusYE+cuTGAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWYijblnDYTbMymB1cQ7MWumCRv4VdzfvD8VlAEYqaw=;
 b=yeehXUvuT8IUrvLvgh5jUPu9BSObIIzjM3scBfuFpY2/oU7A1ZPHhUidFrHc76qHQdW6ByAzVPipFkXJEllgm/IS3SmcvwHh6QFQWwwju/Z7YkRmz1JY1dxczp2roG3AmaULOcn7FzNYuCHrheFEROZ1w1uausfCukndUJlltyreY9BlDOqej2OfYqV10wrhWESjXKPcajp7Rv7mbUrpeIdqNv6/StpFBNJ5eSb7ll4hOQMrbkZnwyJTaYnbjpaH5dkIOy1QVgG8r6th8YBF+jLBQaxEm4U8nEhHG3fszIut62clzwIIGlis93a4YoH+gxoKfLZtQGs0OAEKF5sNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 11:36:10 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:36:10 +0000
Message-ID: <606179c9-ac1d-4f23-adea-17afe8cffe3e@windriver.com>
Date: Fri, 1 Nov 2024 19:36:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] cooker: Sort pn-buildlist
To: bitbake-devel@lists.openembedded.org
References: <cover.1730455481.git.liezhi.yang@windriver.com>
 <1e929963b51ca2f66bb2b35c550627da70fd7f3c.1730455481.git.liezhi.yang@windriver.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <1e929963b51ca2f66bb2b35c550627da70fd7f3c.1730455481.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:404:15::20) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8251bf65-25e2-4cb7-1b98-08dcfa6961ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WTFPRVltb3dqWDZmSkMzd0tqTlN0M29vVGR5NmFWQVFOYXRzY04zdWc1Zkp2?=
 =?utf-8?B?STRDR1M5NVAxQkpHMkh1NFhWamJOUVJRN1Y2R083K0pyTFpNWWVocUp6M2ZS?=
 =?utf-8?B?dHU2eXF6aTJzdGtHRkxKRlFubHVPcHBZc1Q2VUtlQUE1RlhFUkJORENPcTlL?=
 =?utf-8?B?bFU2UDVyL2tsRXJqa3pTUndxQngxRjJMYlY0NmsyQThzelhDaVFWeTZaeDRF?=
 =?utf-8?B?aUdGYzFXOG5OZ1ZxcEE5RGovZVFxelJIMWVHU2J0TDVFK2RCUmNkc3NBUmU2?=
 =?utf-8?B?anFyc3lpTFYwZWlrYkk2WFRVRC9GdENvRUswVWlFMk1ZZ3RRMnY0cm91YVpG?=
 =?utf-8?B?MHZaVWVaNUt3Y2gxZi9FWFo3U2w0eThCWmxBc0JiTHpoRjZhL1Y0QnJteXZz?=
 =?utf-8?B?OHU1MkVmTkw3TlNuVityNWNSLzhPMHdMRy80alZ0aXVhVmRkWVJ0clB1SUtm?=
 =?utf-8?B?U0NVNzZNcy9BMHJZTWhKcnlVL2svN1VvNnhYL2oyYWdkdjNnb01qaWlNRzEr?=
 =?utf-8?B?STFhNFBiU0tvU3VkZ0tuSklwNEZWcDNNNUlPemU2ei9UOXRlTnJhOXdPVTYx?=
 =?utf-8?B?OHdFeVZNVnpHdUNwZGVOSWhOKzc3Um5aNFFoOTh1UGY2RUxpeEdyVzBsV0N0?=
 =?utf-8?B?ZU5JK2swZHVFckR3ZDNRTVFSN2JXSUxrMWQwMUJDdlM2NU8wMVk2aFJhTXRn?=
 =?utf-8?B?U2VnNVo3Q3NhcDRHalFScm9sRkM0UmVyTjJqRlpLWVZ3dm42TWtlR2VkSkd3?=
 =?utf-8?B?NXNqQ3RMRGNBTytHRDgrYllJMWh0YVpueVVCa2FqajFIVm5ENWsxVFcxTm95?=
 =?utf-8?B?N3NjVHZDTHdXZUlJQmdvR3FNS2dKbUFpUlk2ckpVT3kvcjc3UW5pbWgyT0k3?=
 =?utf-8?B?bU95WCtjOEQxSVhjWEtuNklTTllnTG4yNjN6Z2tmSm5jMkg3djl3VllNcGpT?=
 =?utf-8?B?TGJXQUdKK1hzb1c1VUMwUXBKM0kzc1FBcnhUeFVrUGpnbG1sdStERzhmVDhC?=
 =?utf-8?B?eEJUT3NVS3JaZE9qTVFYcXBJT1RMQm56VU4xeDducGcxZ1Via1RnMUZyenpn?=
 =?utf-8?B?WmRrck83akZDZUNXejl2UjkrVG0vS01vRndrejJzU3lGcHZEYWxqNCtDbTMy?=
 =?utf-8?B?VDg3ZTc1eFBNVGRMbEtPa21QTC9WejB2cGczdEhFdDdSNE5TbU5JeG1zZ2k4?=
 =?utf-8?B?d2trSERyZkhrdSttS3ZRcytxNFBBS2dNQmk5Um9GS1piK3dENk9tdGxTaWRa?=
 =?utf-8?B?Y1V5YVFNTnFnUHZubEhGUkxtUmV1enV3TlQvZ2RldUhxblQ0RWFPUHhDUW0v?=
 =?utf-8?B?OTZnSzdObTFEZEQxZzBaZFdtV0NSK2QzOGZ0S0lhcnZKSXhyODFkRStac1A1?=
 =?utf-8?B?QWRZcnplSEwrWGxadmhtZElybDRyWHRUMUlEbVRKc3dmdGJsZnFFYjVFYXlH?=
 =?utf-8?B?RzdGdGRVS3poaENCUWxRcTVwQ21tNUNQbGdJVHdHOXZxaksvVUgrcWxEa3BT?=
 =?utf-8?B?TWxWMXkyd1RERzllbGRWQURoNTlIdzExYTYrZTdrZWN4ZmJ1Yk5mWUlDOHNX?=
 =?utf-8?B?czZEd2lsenliRTFKOUFQY043N1pPRGdMVnJyeDZUK1E1akF1M25YSWlyZUFJ?=
 =?utf-8?B?ek11N0E2VWNUeS92VHZvNVhCN29sRC9ZNFVsbW9SbjV4REwvSU1nUkhacFN1?=
 =?utf-8?B?SllISGVVTHBrTmV1OVBUNVdScSsrSm5DVHQ3dUVVZCtPalUzdkFSQXdpREZu?=
 =?utf-8?Q?iii+f/JjHpXcP7jHawB1vJhVzBXhcbs9n/kIwQF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmhVeGlQS3R1NnBuOWdZcnU0aDMvdUxWdkxicDlzQzJrYk9VeEgzNzNVZ2l6?=
 =?utf-8?B?bWpBSnk0bU1tMG5FZ2wwdjBSUlY5SlNyKzJVZmljMnA0VjRJVDluWVF5aWx3?=
 =?utf-8?B?ai9CVGlvbFhTYkdtQnNsZkZLSFdxRDFiOHFGUjBZaTlZdlFCTVkzcitOK0Nz?=
 =?utf-8?B?SWZuTXJpU0ZXRHR3dDQybWVyaGNLVThvaHRVb0dYQktEZ3hrempWSXpBdk1R?=
 =?utf-8?B?dDU3TXY2UEVPTHB4MGEzeWNndHhqZkxCSnpaL0Z3emMrcExIVmFHbGE1dFZu?=
 =?utf-8?B?VUp4WXFIRmxoSXk4SDZRWFd2UjNYVmk4U0crYTIrbEZBTGdrcXBXb3E0VWs5?=
 =?utf-8?B?bE5OSnJtRXV3TVo4L0NqQTg4d0FQNE8vYm1uc09Dbmc3NldKMFNURi9NQmhi?=
 =?utf-8?B?a01obnRxSWJYTlZMdmtSYnBKNTVtMU5JSUJ1MWNRUERnUXBpZUZIT3p1eGQx?=
 =?utf-8?B?WEtzcjBwU0l1MitWbzhyZTJqR21PREFJYktlMjExOExOVTNQUTdRK2dUMkdo?=
 =?utf-8?B?LzFDQWthdWRaMzhUcXl4c2taS0syT0EzZmdtOTd0cTFNYlhMd1JQT2Z3NTRL?=
 =?utf-8?B?MFJlaFgwTFh3UWVHNURXSHdEMjduMUNnNXVMaEZRM1cxNnJNNjU4VmFBcWdJ?=
 =?utf-8?B?V3F3cFM4QkovVFEvcXJjL0g4bEQzSm5qLzQrTzh5bDloczhHVWZpWGZScjNr?=
 =?utf-8?B?QlpDbmgzekJsRnNtVXY5ZlllNzR0MUlKbitLTllIWEpIS3ZBa2piL0Rkajlh?=
 =?utf-8?B?WVg5T3IvUGNGcUh6d045QVJZamFLaCtiZm1MdWJUeU93REkxR2hYK2svTjhQ?=
 =?utf-8?B?LzBTZ3lGM3lHY3FuTUJ0aW0xb1F5aWE4LzVmcUJtZzllL000Zjk5S1ptUVN5?=
 =?utf-8?B?M2FGMjNkWm9TYmxpaFUyY1l2SC9zRVlEdmJPeTNuRFQ5WDA0VUFndWJlTG1C?=
 =?utf-8?B?Q0x1QTFVc0tvazRUMWY5bEhScERZVVFpM3FlVUJMdE9zQVRXeWt5emFEdnhs?=
 =?utf-8?B?MFJTQ29rM1NNRUtiWFN6MkZaTVlhQXZxTytmcTV1aW81VkNjcUJsbkZTeUdz?=
 =?utf-8?B?dXh1WDFLcjBYb0JHVXJha0NDMjQ3UGVqVkVsMU5Td2I0MjlkalJtOHA1U3pq?=
 =?utf-8?B?cGUyY1V2SExOdC9uemJ3SzhZU1BucTh1RUNrcXFkMVAxUlo4UmtiSWhGdkJD?=
 =?utf-8?B?OS9WSDg0WWphSjB3THF0V3FzTVE1QXFZcDRuQTdUc241SzRETkZjTHVab04y?=
 =?utf-8?B?WDdrSUdIZWIwNWZqaXNSelJjdFJVL29kZUR3VGtmaW1iaXQrL01wQmZ6MHhY?=
 =?utf-8?B?MmRESGJIVVV3OFJWUzBOLzJabEkzUENuSUM0cnFSVGVxNkd0RitySUMvdDJS?=
 =?utf-8?B?TTdJOTZOYlZPRkt4Y09La2lIeUNCalJqamVyUk9aaXRWQnZ0NmU0RG1FVG0w?=
 =?utf-8?B?K05iZUV6VTNjMU41bEcwS09HRmhRY09DYzdtMmlnYkVkbzBYSitwN0pJWk9S?=
 =?utf-8?B?MlY3NGtGeW1nWUdURVF5d1VjK2Z1bTRUbjZFbThZOGtWRHVkc0dqZHBsWk9s?=
 =?utf-8?B?ODZjSENWb1dWek1YbHNiTzVOLzVMekEzWVM1MmNtdkFzWk5WM3lpSW1sZ0ov?=
 =?utf-8?B?V2hrc3lzMEhIeW1CMmxIRlk4ampteGNIelZiZ3BBcjM4djBvVEFheWlkd3By?=
 =?utf-8?B?VXJLa3RaY2NoWm1pWlZyNUhTaUJGWjV0VVFiZXFTd251WHA0WGQwVW9laXNj?=
 =?utf-8?B?eFhydGlZcEpFWGQ1S2tidmZhRkRUdHNUcjd0V2RqdW41SEx1cldLVW14R1k1?=
 =?utf-8?B?ZTM3STdXdmdwR3V1Y2E5bU1OekFOb1VqanBuZ2gwQ29URWpLWWFyWitpa2Nv?=
 =?utf-8?B?SEJ6VzVZS0NZNkdMSEVkSzl5OFFDdVRDWG1JRWpmU0c2ZlR1VG9mTnNnbjJV?=
 =?utf-8?B?TFhoOU9CVDhrOE5oNGFONTJWUGtTNytOcFljUzRRMFhhZWxSRDUwR3A4ZEtE?=
 =?utf-8?B?dGRTN0Q4YWMxaW9YeEwrbUpqem9Obm1Qc1Z6Q3RWdERvbTQvK3E5RzNxOXNa?=
 =?utf-8?B?WGtNZGpWWDU4VTJqVy9oTjdRZUcza1JqdnY1alFQRHg2cFdNWU51MzFtMWZN?=
 =?utf-8?B?QkhWRzJBVUllREpQQjM2aXU1VzFickFRRU5sWjFteEYrRnRSUitPRWcySTh4?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8251bf65-25e2-4cb7-1b98-08dcfa6961ee
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:36:10.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsyYj9qeOkIpBMHy9iMN2TR/bKvXUHIc3P/XfkBgQYDw6W7tHrES0K/11aZt22juQV+mPk9GUdJZtuJ8d3ihBbHRogdv3vuZ7Q2nwytnTV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-Authority-Analysis: v=2.4 cv=PeqthThd c=1 sm=1 tr=0 ts=6724bd2f cx=c_pps a=R19XVbJ/69TrMGWtO/A4Aw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=2V6DY6BgAAAA:8 a=u288mnPNWsXWklupNOsA:9 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-ORIG-GUID: aCodJH21s9jViA8IgT_OdFj1NbSRa_ai
X-Proofpoint-GUID: aCodJH21s9jViA8IgT_OdFj1NbSRa_ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_06,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=410 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411010083
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Nov 2024 11:36:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16766



On 11/1/24 18:05, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> So that we can compare the different pn-buildlist easily.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>   lib/bb/cooker.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 2e80986640..37a5cada28 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -900,10 +900,11 @@ class BBCooker:
>   
>           depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
>   
> -        with open('pn-buildlist', 'w') as f:
> -            for pn in depgraph["pn"]:
> -                f.write(pn + "\n")
> -        logger.info("PN build list saved to 'pn-buildlist'")
> +        pns = depgraph["pn"].keys()
> +        if pns:
> +            with open('pn-buildlist', 'w') as f:
> +                f.write("\n".join(sorted(pns)))

Sorry, the above line missed a '\n' in the eol, I will send a V2 for it.

// Robert

> +            logger.info("PN build list saved to 'pn-buildlist'")
>   
>           # Remove old format output files to ensure no confusion with stale data
>           try:
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16765): https://lists.openembedded.org/g/bitbake-devel/message/16765
> Mute This Topic: https://lists.openembedded.org/mt/109330363/7304958
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

