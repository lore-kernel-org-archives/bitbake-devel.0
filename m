Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFEDC27C53
	for <webhook@archiver.kernel.org>; Sat, 22 Jun 2024 05:21:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.92145.1719033710802187005
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jun 2024 22:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6903ff9387=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M5AUIm004920
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 22:21:50 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmr1ewf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 22:21:50 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45M5LnXW021518;
	Fri, 21 Jun 2024 22:21:49 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmr1ewe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 22:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhH2J7AmLCMV1CBAY5OHqcNT78KVTFHoL0COBCoKQWWTGyiyslabBEzOWHly8Wi4frMY23HFRqNJhdEdme9wGWdzCXZ1joGzbUGqTCGJWL7BMO1teiSl8JbbINt3arNmC17a9Z0aoqywd7qCRn/aZER3PVTqawblWTtpSaOEihPftg/QjNUeThgiGs8VJQrDVAkfZw4RnU1awAjKrqJDwrLxd1Rjs2qzBfGoDhpwVB6tygJNRX8rMab3dgo3asNmfwRgcl1rmFW8/j56Ahi9y853G4nXYXDruywOKHj5kUMBR5QgXe9oFx3pP5RjaXFbWFGjyPS+/Jva3hwZu/+SNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk05opoCabhGSCNaGkgwk7VUmAyfZtDxUnpVTMt43N0=;
 b=Fmd0aKuvMtGXhJflE/aih21/KzxUl9AHIVPAXA29is/3Ts7fq1L8/nP3ZQZrfywDCJaT6CnpIvZW4cVyYF9Nr75Fqo/WVxROvYETEeZpdgi9LNO1ldMPXh98wJ2RVry/yEPLXr7WOmLllZqPCpoGhQ3lbPhcTP8Kp2QS5D1XY3o6BVlG+JOMmiNkDbMuQImghNCJ/oN/ZEgcnbQf/GFPonIiE4iykjINYw7pnx1vUaDUPurVoDNNOdJIBRoKLqTtCzYT/mspLhlviJ1GIhTf8Yz6AvurfyKmjqZZ7JwCpsCm+VkLHVkKAN8RQI2cJMQAJqfJHCGZf8XCPKl6ptbAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Sat, 22 Jun
 2024 05:21:46 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%4]) with mapi id 15.20.7698.020; Sat, 22 Jun 2024
 05:21:45 +0000
Message-ID: <ed73411a-a88b-4b4f-8f24-6881b9b296bd@windriver.com>
Date: Sat, 22 Jun 2024 13:21:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Fix File name too long
 error
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1712565610.git.liezhi.yang@windriver.com>
 <02074341b8914bf7d1bf44291ec50a77853a4c5b.1712565610.git.liezhi.yang@windriver.com>
 <202404101701466483c16e@mail.local>
 <17DB38D5908AF9B5.21660@lists.openembedded.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <17DB38D5908AF9B5.21660@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|SA1PR11MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb82144-48e3-45cb-802d-08dc927b355b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|4022899006|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?STl1ZUMvY0pTY1VtbDVXSmg2RUViZ1BiUzY5ZVZYZ3ZidHRIcHk5emdpVEZK?=
 =?utf-8?B?cSt1ZlVUeFlpaVRyWWtvSDhic3JLc3U0RmsvN0N5eTJpdjMxSEdJRzltN3FI?=
 =?utf-8?B?d0Y3WHFUWnN0WUZTN0k0LzZtVEw3TlM2ZkM1WXlxRWlvNENaTmpYTG1xVGJ5?=
 =?utf-8?B?VmxFeHpxS1lYcWEzdTlnSDFqOUF2emowVTdMQyt2UDVHeHZWWEhZMnNDNk1V?=
 =?utf-8?B?WjlwOEwwODJ5R3cwZ3c4V1FjUkVCZ0cvNnhMK1NJMGM1dldHM0dBbU5QQTBG?=
 =?utf-8?B?TWtTSjhaUndqQ2pObGpKYTdZU0RkdFBtUTlibzh3WmZJSzR0WU9QdHlaeXF4?=
 =?utf-8?B?NjNYOFEwWDM5b1d2MHFxZEFyWjhlWlJqbkJCYW9KeXA2d050dGg0WmZWZDdS?=
 =?utf-8?B?T1ZmVjZsc2pXblFLU1NLSlVzUXFGUXNBTTByMTl3bEFieThLTFA1d0cxN2ZP?=
 =?utf-8?B?Zll5b3psMCtXTjZnU2NGc0V5VWNTWGZkNEJpNTFUTHlGTWtsUnhBNWJvQmxR?=
 =?utf-8?B?bW4rdzBndUR1UGkySnhiT1JOZHZXNmlhNDF0anpGdEFtRFE2dEhkblRBWFVC?=
 =?utf-8?B?VnlVaTdUSDdwazl4cU51aklYVno3dU9STE9YMG9SS0VnQ0FBMDc4THErVXBZ?=
 =?utf-8?B?WlBCNjBtNlRqWXRBcXgxK2RzV3diVGg4cUFOenhxZkZLU3RrZEF6YzJGcDRB?=
 =?utf-8?B?VTNpdDVZdHhBRlpnSGpXMzJMKzB3NmJjV04zTm5sMytROEJUWTg1RXZYMTNL?=
 =?utf-8?B?N0o0RWRaWU0vZnRSVWVIbGtOTHgrUERGUmhQZ2x4Z3ZFazVBMnQ4RzgyYWx5?=
 =?utf-8?B?YmpLT3ZMK0pXNWJuWjd3bHUwOHk4NjJWbEhBR3lrK3UzQ1V5OE1aWFU3V3lS?=
 =?utf-8?B?SU9YRHFQYzhkNko3MitmN2daQ0M1aDRmQS9CckpTZlFzZUNuQ3g0ZnRNQmhp?=
 =?utf-8?B?a0hqMGFIMmVVelJJRnlhMHMyWkdscHl3VDlmWWJCaXFkWC9nbU91ZERoS2JR?=
 =?utf-8?B?UXA5L1BCd1FETkdnNTdpS21tRXhoUGRxMzM5cFo0Vm5tRGZyY1ZOVEgrQVRj?=
 =?utf-8?B?UmxTSi93Zmt0YlorN0JWYnlEVXdjYnNYQStNTGJZRVNaRURmdXRmNEdiZk9p?=
 =?utf-8?B?TCtMWXZXYVl6Yktjb21UdGtBT0FPOGRQRlo0T2FyR3R6TDhWWjlIRHlrSkdG?=
 =?utf-8?B?QTd0WVdjcFBjbG1QTy9YTXc2aDdKU253Y25EUmJ2cHFmYlN0dG5ZZXd0R0ts?=
 =?utf-8?B?UDVtRlIrdUU1cDRQYjhqMm1BY3ZGZ2VTUkgzVVp5TUZ6emNGS3ZyZURDMzlZ?=
 =?utf-8?B?Z1BnRXR5UlZoK05VR2RnS3pTVG1sVWUxdVRMR3RlWWk5Z2dITDh5OXBvbzdz?=
 =?utf-8?B?dGVzbWwxdy9Wc0lvQ0c2SE03eVN3c3plR2VwcFRCL3FhTWZYTThGdEl1YTlm?=
 =?utf-8?B?NkF0ZmR6QlM3YktLUUFvV2lQL0lPNXp2WjVOTzcrVG9CQjcwbXlaZGxLdEpq?=
 =?utf-8?B?MExYbHNzdVdBb2V3VXg5b3JhcWNWL29uUXRiYmFuVkcrMVF2eUdoWDhKanVw?=
 =?utf-8?B?L1o1THlZVUNLanlxVFI0Q0liNDRzQVZnN3doOHoreWZ0VElFMnh6dEJyWEln?=
 =?utf-8?B?R0prZGdyN25vcGJ2TCtpN0o2YWhYZzZUcE00QS9JODV6bitsa2hjVzdBVFNI?=
 =?utf-8?B?K0k3UFV3UE5iTjB5clB3SmlwRUZKV09vak03MG9CS1lmdHY1LzNGR1pnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(4022899006)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXVtSUFnY2hyMEdxbHZvaUZ5YTAyTmRIdmd1RnkvRFFxd2NBVmN4V2VFZEp5?=
 =?utf-8?B?L0tuMmtJRWZ5VjVNaExpU0gxRmRTK3l4clAzT2tiZmNwSVo0eE5rcVVPZDY5?=
 =?utf-8?B?cHcxczMwVTlPMTlESGt2Z1lmc0FTOHFnVmd6ZlI2SmNXL1hvNm1RRWtlUkR3?=
 =?utf-8?B?U0VDdmJ4cGNPTTcyZ3pWSUVUUDBDZm5BSEJGQTNDdENkRFUrbW1kVXJTNC9R?=
 =?utf-8?B?dCtteDhDRlVGYVpZUEorVFpjdWFNcm1wdzN2VUlMVjJLYTRUSGkrcUdMNGZm?=
 =?utf-8?B?cVJ0UDZ3bFdmSmdDUG93VVFvYlhIcllBT25oQytaV09qaEJNVFlRSUNId28w?=
 =?utf-8?B?V3BXNTVlYU9RTEY3cjhXTVZIMkcvTXhVaGFjejJsN0RZMUJFcVFlMjErNUFU?=
 =?utf-8?B?OXFkd3VScFFqbjNWbkFDc2JWNEpzSHFCOTh0cEVkdnBDUnZ1NER5SzdsSitm?=
 =?utf-8?B?UHZBVWlPeVhLL25CK1p4cXJzTitSNmRGVThWRGdlbXYvNC8yZzBNYjBXcFBG?=
 =?utf-8?B?YVRGUTdxcXRKQ3R4bXBmWFVmOVZZQVMxbDgySElIN0RIS2hZSEtvUS84OE9X?=
 =?utf-8?B?M0szVDdKa3hmdldhTGt3MUh3dTBueCtxRmwwR0ViS3NkRnA1TEgyNk5tQUc1?=
 =?utf-8?B?WTJNdkRiRjhOQ01WWFJSaGZ6Vnh3RnBxZnJIZDBybWwwRXFPWnhRazBEcmQv?=
 =?utf-8?B?Rnl6ZEtxNU9RQXkyelNBK0dmWnJJT09XNytKN0NWYm1GREs3WlRaYVl4U3Mw?=
 =?utf-8?B?Y0ZCRlFPVm9oemRZSE92MDJ5UkFXVTRvVTFGeTBxUWxPdjZZdXlaNE5ibU1I?=
 =?utf-8?B?Y1loRkVjaHNNUzI1anpZQndRaGRUVWlJZVl0YmhCck9QS3FGYzVrN01OQUlu?=
 =?utf-8?B?ZmkrcnBkSGJhdEtGakI0cDBaMkQ2MWFmZ1hXc0l2QkdNMzM4SnpnRURicFZO?=
 =?utf-8?B?WThrcDFHemJvUEhEeTR4QkpHVjA5WWF3YXQwOWcvREo4UGVsL3MyM3BXdW1F?=
 =?utf-8?B?a2pRbXJiUjg0dHNSMGUzWkd5QUJuemttSkc1QW9Rbmh6QUlqQksrOHVZNlBG?=
 =?utf-8?B?YUJqM29zOUxSZk4xcUVtd042L015ZVVqTFI3NWFhNzRva2RUWXJXSVZYRFZJ?=
 =?utf-8?B?OUlIeUdDNFZydUQybElZbGNUVWFkSGU1MzFNZCtwcGY0MXVzaWMySm12clNY?=
 =?utf-8?B?SkNuMUFCdTliKytueThGbEpnOUZ4a0RsUEZSdHp1b3I5d1prVTJ0SklsZC85?=
 =?utf-8?B?dWNBWTFPZnlnN0NjNkFaMEJic1pVMkVraGhTSE9lL043c3paM1A2TjU2QSt3?=
 =?utf-8?B?TmRaUExMWGl0SGU2dWFieTVZZDRBN2hWaDQ1di9rMWxvNEdqMVJwbFhUcUZq?=
 =?utf-8?B?Z0hFNllWMlZXT1JEUWJwWXJVZlNyeWdMT2wvTUw4UlhlOVROR2RLOGk4OVhw?=
 =?utf-8?B?TmpUZU1GVmN2WExxZHBVVHdtZ1RJUUV3V0U3S0tJbmVzdGs2QjgvR0JuWE00?=
 =?utf-8?B?b3FhSy83L3pIbCtKVldOVWIrdjlZS01oS1pMU1NiY0xiRjVrSXB6dExISjdB?=
 =?utf-8?B?UXpabVlXVDkvWFZwc2l2TEtmYkxMYjdUcmZZa2pTam5CdytQQ2cyTXl1bFBy?=
 =?utf-8?B?VlBhWGhvQUJab25JbXlwUGdOanYzamJROURHMjZ4cnNEcFBJTzdHandqUEsy?=
 =?utf-8?B?dkZQNXQwbVlGT0lndzhOSi8vYktVOFNGaytLVHk3dDJlQ0FQdXB6ZWtiUFJ5?=
 =?utf-8?B?MFFtc2JOdEpIMVdDTUlOSyt4WTRRaXkyNlVCQ1JIL09kWHEvcmRyQWNMZFFW?=
 =?utf-8?B?WUVjTkxYUGNNcjROdVBEU3lkZ1M1Ry9XMDNDS1FnZDc1WG4zWXovd05FVExZ?=
 =?utf-8?B?OTFwL0t1VXVGQXdSamhjOFhTSHFOM2xXOXhjRVkxa1d4UnIwU2ZMcmhkejlP?=
 =?utf-8?B?aFc2VkZVQUxpZWdIYlVYa0lDTVV2MmpYMVZEaDdOLysvVmVMNUdWRjZJczZ6?=
 =?utf-8?B?TGFkZ2w1YjlScW44aWUvNWJtVTVlN1FOS05qODJMdkFWVk5oZWpNRFZuSDhU?=
 =?utf-8?B?L1VBU0grMldIV1kwa3YxUXFNdm9sSHFHdTFaQkR2Y2YwdEZXcEl2UzdnTmo2?=
 =?utf-8?B?Z1B1NE96STQ5aHNka1BYK05EWGpmaTdIcE1FSU0reWZlYnNnd1poVmJQaHBO?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb82144-48e3-45cb-802d-08dc927b355b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 05:21:45.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RM+C1me0JkV0iPuvGDsZ5k98DqJ5ci5Q/ogr/R8cuu7/Un5HC76y4LbW6pT69AEIzKdRIA7OP8XG7TM1UoAUPHAvSub7iFN+vbhd9PSZLtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-Proofpoint-GUID: ijStYkLfNYwY17lV2NrXCoAUDvsr1OiH
X-Proofpoint-ORIG-GUID: vrJ3ZAZCKznefWCuDQ83KD80vt3Dn7mM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_02,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406220032
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 45M5AUIm004920
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 05:21:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16373



On 6/22/24 12:22, Robert Yang via lists.openembedded.org wrote:
>=20
>=20
> On 4/11/24 01:01, Alexandre Belloni wrote:
>>
>> I believe this causes the following error:
>=20
> Sorry, after more thoughts, there are two issues:
> * The generated mirror tarball can't be used since the local path is ad=
ded to
>  =C2=A0 to the tarball name.
>=20
> * There might be file name too long error when the local path is too lo=
ng.
>=20
> It doesn't make sense to add local path to the generated mirror tarball=
 name,
> but causes the above two issue, use basename can fix both of them.
>=20
> I will send a V2 for it.

I've sent a new version rather than V2 since the subject is changed:

[bitbake-devel] [PATCH 0/1] fetch2/git: Use basename for gitsrcname when=20
ud.proto is file

// Robert

>=20
> // Robert
>=20
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> FAIL: test_shallow_submodules=20
>> (bb.tests.fetch.GitShallowTest.test_shallow_submodules)
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>> =C2=A0=C2=A0 File=20
>> "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/=
tests/fetch.py", line 1946, in test_shallow_submodules
>> =C2=A0=C2=A0=C2=A0=C2=A0 self.assertRevCount(1, cwd=3Dos.path.join(sel=
f.gitdir, 'gitsubmodule'))
>> =C2=A0=C2=A0 File=20
>> "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/=
tests/fetch.py", line 1728, in assertRevCount
>> =C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(expected_count, actual_count=
, msg=3D'Object count `%d` is=20
>> not the expected `%d`' % (actual_count, expected_count))
>> AssertionError: 1 !=3D 2 : Object count `2` is not the expected `1`
>>
>> https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/6634=
/steps/11/logs/stdio
>>
>> On 08/04/2024 01:42:58-0700, Robert Yang via lists.openembedded.org wr=
ote:
>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>
>>> There are "File name too long" errors when local PREMIRROR/MIRROR
>>> is in a deep directory (len(path) > 255 (The NAME_MAX)).
>>>
>>> This is becuase ud.path.replace() changes the path to filename, and
>>> the errors when happens when len(path) > 255.
>>>
>>> Use hashlib.md5(ud.path.encode('utf-8')).hexdigest() can fix the prob=
lem and
>>> avoid potential file name conflicts, now the files are like:
>>>
>>> $ bitbake mtd-utils-native -cfetch
>>> $ ls downloads/git2
>>> 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
>>> git.infradead.org.mtd-utils.git ->=20
>>> /path/to/build/downloads/git2/1625d71bc771b3c4d479337faeef324f.git.in=
fradead.org.mtd-utils.git
>>> git.infradead.org.mtd-utils.git.done
>>>
>>> The 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git =
is=20
>>> gitsrcname.
>>>
>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>> ---
>>> =C2=A0 bitbake/lib/bb/fetch2/git.py | 6 +++++-
>>> =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git=
.py
>>> index c7ff769fdfe..7ed51af336d 100644
>>> --- a/bitbake/lib/bb/fetch2/git.py
>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>> @@ -83,6 +83,7 @@ import subprocess
>>> =C2=A0 import tempfile
>>> =C2=A0 import bb
>>> =C2=A0 import bb.progress
>>> +import hashlib
>>> =C2=A0 from contextlib import contextmanager
>>> =C2=A0 from=C2=A0=C2=A0 bb.fetch2 import FetchMethod
>>> =C2=A0 from=C2=A0=C2=A0 bb.fetch2 import runfetchcmd
>>> @@ -277,7 +278,10 @@ class Git(FetchMethod):
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
itsrcname =3D '%s.%s' %=20
>>> (hashlib.md5(ud.path.encode('utf-8')).hexdigest(), os.path.basename(u=
d.path))
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
>>> --=20
>>> 2.42.0
>>>
>>
>>>
>>>
>>>
>>
>>
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16370): https://lists.openembedded.org/g/bitbake-de=
vel/message/16370
> Mute This Topic: https://lists.openembedded.org/mt/105397591/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liez=
hi.yang@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

