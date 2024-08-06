Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95DC49EA1
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 13:43:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.7540.1722951782394515745
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 06:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8948c99a11=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4766t3mv005948
	for <bitbake-devel@lists.openembedded.org>; Tue, 6 Aug 2024 13:43:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40s9ry2usy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 13:43:00 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476Dh0Lq028471;
	Tue, 6 Aug 2024 13:43:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40s9ry2usw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:43:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8vtGcfU5uNKggOIZ1FC33FWrqz+cjyt8TlNI7qhcAAfBvGdn7paA9l2FtcO7OLUQOUkhdbOAG3/ltJCfXvwuSogcxWP9zgHUYsJL5WJufvhKF9avzZEIC59JitcKPqrUTREsP8MWydeZAKXgQvXC+t8JFduDAqMFdyrD0qUZh2WVwutV5e40cmAEc6OouDvyNqdRFFwl6LqBtUlaYMcUeLPuNxDfrKsCCymU27IEPK4fjJhK8m2Gkkm12KbrBH+ZV6+90qW3ynIkw+WenGciNPB0Q9rhSHez6pm7xUH5AzG4QNbBYyfUTWFxNRgn6sYvo+vn0JtIAjIreccmx03xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP++4utcqVxqAyPTsV1nWIhIlYE3kUMJ2E6QccGcTgs=;
 b=H8OrUpFAltw0xcm7JoPYVRDDMGw0zMayJ0zVXzJOPCusFZHvR10ZvD7g8ZLxBnRvP6/thk5Ebp2CyZk/PR3QHkZWHoWWpiqf0Ue5HRh5Eawtm0GfIrn9Cr3hjxvgC0EXs8GCqMIe5a8BdSipqjhBDqPwd/qxtF6bZGJYaSKSCN4aFnK0fb+7UbLR/qtAHYttQ3S32H/3t0/zwqbpdX3o3Jyg/o5FriKK/2Dy251x6HsIkBJVI7VZmNYIxm9+qYbS1RLWVYdW3liBsqZQgsRgCtQSmWD75d9y27rIDPR137CR/T1SS5HhPC5Eclf00b5LDhG18k562pfdWbuVzwN/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:42:56 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%7]) with mapi id 15.20.7828.024; Tue, 6 Aug 2024
 13:42:56 +0000
Message-ID: <e089ca2e-5834-42bb-998b-3515b2fccaed@windriver.com>
Date: Tue, 6 Aug 2024 21:42:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org,
        "Burton, Ross" <ross.burton@intel.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::16) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b53713-334d-4c46-311b-08dcb61dad7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WkdPQU9DTVRHRGVXdnFBdHA0VVdRaVVlMXplY0ZsWGtXc1g5N0ZvdDVOUmtw?=
 =?utf-8?B?ampYekdtSDNhS05Ga2xuWUQ0UnRYZGJJRWRFT3IvdXhmeElkQStVR0VzRXBG?=
 =?utf-8?B?d3ZaQTZIcTVQM0doMmJvWkNQaXdzTHgyMThJMDFNYmxTT2k1VUVoN01RcWh5?=
 =?utf-8?B?TEUxTjA4K0ZtaHdRejZ6cHlRQVc1NUowdjJQcUtpY01FSzl0U0lkZElyYWJx?=
 =?utf-8?B?MTkzaEoxS0c1RU5CUVRTOXdBUFBQeGRueGs5ZW9QUHJ5TWk1N1ZzVk1MMHBP?=
 =?utf-8?B?RVBZQVhUeXZIdVRJYmNyOWgyM2EzMFBsR3JkQ1VJKzhiM2cyMkgvUTZaREZ4?=
 =?utf-8?B?cFhMb0hvRk1wUjk1UW9DcnFQbkl4NTFYQys2Mlpsa0orYU1nc0R0aW5TOW14?=
 =?utf-8?B?SFYrVkhoTUlIMGFqMGpHTlZjblpjalZCV25DbHl2enRkSytRbjJZamdVdGsw?=
 =?utf-8?B?dSsrejRRM1NuT1hBMFV4V1JKQWdib3dZenpCeG16NjBhNkJROUM0bFEzZ1Fn?=
 =?utf-8?B?b014Nmw5aWVmcUtmeHlob1U2RDJxVnNRakkvZmFDcHEzNlpLR1BuSFVoa3Iw?=
 =?utf-8?B?ME12ZGFMOTRzQ2hEUG1kT3JOWDBsMWhlV1h2TDc4Wmcwdk5QT3FoQnJacnNG?=
 =?utf-8?B?eGFhdDhlS1dBSCtPOHBvVmoxT1ZHNzlwaDRiU1ZYMUNNK3NlMGNkSHNFOUxQ?=
 =?utf-8?B?Ky9xS25rVzRTT1NOeGlaNnBZcTh6aDZOdUhYS2ZkWXlVbEFCT2s0UVE1aXRC?=
 =?utf-8?B?d3lSeWhaejNPQVdlTnZpUXlBaXg1WFNkWDBEZTJQT3FDdDJpSWRmMU9NWmMv?=
 =?utf-8?B?bGcxUWRCWlNvU2c4b3dYTENyeXFJUWtqQisxbFlrNE1QQmNYcjFsZ1kxNHRE?=
 =?utf-8?B?TnM5c1dxU3lzQkhpcjc5MFFlTDgybHg3TUo4VVFGTnd2REVoTG1aRWRCbmZq?=
 =?utf-8?B?aHM1TDJpYnJFRGZXRGZpYm54OVkyU25uMWFZYVlhWnl5M09tb3pZZjd6bktS?=
 =?utf-8?B?VnVZYUNBTUNkTUE4eG9SbXpHVE56ZUZIRWgwWUtWdjJMd2cyL0RuNkVIb3F4?=
 =?utf-8?B?NGlSUFdZOHlQR3dJWENjcm9JNW5iN1ljUURUNDNZV0JycjRnNHUyc0NUZXJN?=
 =?utf-8?B?MGZ3dmZ2eVdVTDEyaGlXdmN2cXRKZVd4OGFsQVRFN3lxSXdWREIvMkI5SEp0?=
 =?utf-8?B?MHNCb1VSUHBkZG1jSkxkTGxUS0J3d3l0OWp3bUNKYXE4bjdJVEtic0I3REdF?=
 =?utf-8?B?ZGxpc0czU3E5WlQyamZoZUVKQXFJYzduNDVMTXhsUVlLVllFd3hXd1dNQUgx?=
 =?utf-8?B?SEZHSGFHaENEWU1WTFB6b1ZaQWFMSGNaK0o3b003SjdEZndlVHY2QkExQ3BK?=
 =?utf-8?B?OFRBQlJSU3dFZ011QnB2VVZNcnA5WTRyQ3d4Vkd5UXFQNlh1NDdXelBGWG5S?=
 =?utf-8?B?bnpRWVE2RUlnTUVNdHEvV3FUZmVtbW5Kbkk4VXR2K25ZTGQwMjljMTdsQVdH?=
 =?utf-8?B?Qit6cUREUldlWFdNdU1qOTRQRjluZ1kzM050ZnlwVWQ2VGpsRGpaOWg3SVow?=
 =?utf-8?B?Vi8rVUE3a245ZVJhRjNwMXlKbGxScFYwNEFmMDJKVS9UajBIWWg1NjdBUnFF?=
 =?utf-8?B?bFhteGdzUzZwZ1J4enk2ZXArN1pDTER6ZlJNOWpzUDRSejRjNlZLY01nSTE1?=
 =?utf-8?B?ZlRNQXJHRHRrbEJ5VWJndG9tNFRxTGowNnJaTGJnemRQdzJmZHFIZFlPVG5v?=
 =?utf-8?B?OElIbkFaeVp5eGZnUS91RERSbTlXSkYzMXFQZ1ZJSmpBNzZjYmtzRVlEWlZz?=
 =?utf-8?B?K05VOUdIbExiSWtXZ1B6Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXIzS1RSeXhnL2p1Mjd5MXExT0VMTXZJRWszbEJmcVJTTmoyKytZU0dXdHNR?=
 =?utf-8?B?b1BxZ24yYmg4cUtiRzB1SGdWU2swcVI3dVNacUV5eHZwZlBxM3o4enlTZWVQ?=
 =?utf-8?B?UWRxWSt5TUd1RHY3OXNNYktabkw0dGwzRmFXZjR5K3lCNTNYTE04M05uN1po?=
 =?utf-8?B?YUU1KzNFVEJScmtxL1c1ekllWlk4aE8zQlI2ZnEvZEluNDM5UVc3RXVudjUx?=
 =?utf-8?B?aWF0UHYvVUdWSmZrTnlxWkZWT0J3VjJKR0VJV0RYbndtUmdHVEw2cVNBdWo0?=
 =?utf-8?B?d1RlbDk0bFVRYlBTU01zRk83MGFoN2k2bWVESnlMbGUxYm94clpVaDR2UUxr?=
 =?utf-8?B?ajM0dUpLY0E5OThtVUt6cDJiRC8rY0ZheDZ4bTRud1kxVTVveWVCMmJzdkRI?=
 =?utf-8?B?SThKSFhEeU1RZ0FhUmpoaEVzY3FlV00zVjQzUGVvbzl0SUJBREtZdEZDSlRV?=
 =?utf-8?B?YzNTN3RySjVVMkd6cXJyQXhUdWJ6Z29KWGE2TWxRRnZOdDJDNWplZ0dXbTVH?=
 =?utf-8?B?S3NFbVNBQldoeXRQMWQ4L2lucjJTSUNxMUlBalhndm91Ylo2clYvaUFFSE5y?=
 =?utf-8?B?YjJNdnphM2lKc01TbWtTV3lUc0dMQWlXbkltS0wwZVlVTTdSU2k0V1o1SXgy?=
 =?utf-8?B?bVg5N3JEaGxmSXh5NURCcS9odUdSWCtCOXNQRW9kTzQ0dCtzelRMUDNKT1NK?=
 =?utf-8?B?M0xBQ1gyVWtiRUJON3l6SEFWeGN0cUZ0N0p5Mm1VbkpLYll6QkRHNkF1VUNR?=
 =?utf-8?B?VHhwQi9IdFhneEpoVnRTU0tUNWd0eDMrMmZGZnBpbGFVVVA3NzBXUFBMNFhT?=
 =?utf-8?B?S2REbENxT3B3UVY1ZjFpdnljdHg5UXZaZVNReVBWSzdGZmJ0c3crVFlEUGVO?=
 =?utf-8?B?UDZaL01uNVVVUDBnVlJKZ2w0akNxTnJWbktrRVQvY1ZtbjQ1OGhSRlF3TTJC?=
 =?utf-8?B?Y3hDTW1Kc3NlSmZjY3JmTW92OXlkYkNkRllmQnJrRktZeEFQZFpCcVFXcndy?=
 =?utf-8?B?THMrWWIrdEROd28ydWtDYUhtemJySmd0NDRrQ29Ed3dIWTBQaEd6cTU3cWpu?=
 =?utf-8?B?b1IyVS9aUG1mM3lxK0JCUGdtc3E2RWF5WEpjZzZYYUp1QVd5MGFhb2dxZ2do?=
 =?utf-8?B?QVRnV0svVjgwcWhQTGpFb290VjUwakg1QTN3cFlranh5bjU0QXR1dlgrYnJK?=
 =?utf-8?B?L1N3Q1dNR0lwZjgzOFB2NEE4VWhmQ2ZDb05RM20yQWlVVDhSSWw2eFlqSm9W?=
 =?utf-8?B?OWszRy9WekJldHY3Um82MkZjWEc0RC9jVEtvZC93SXFQV0ZlbG9veEV6T09l?=
 =?utf-8?B?ZEl5NmhCZTR4TzZSUGJtRytqbksrdjd4SFRVNVlMN21Ya1ZaeXl6d0FQVlRX?=
 =?utf-8?B?N3dhR25zTFFoVmhjODlycEI5RG53SnovTjI3SEx0RnByRHpoRlZJTUY1NmxQ?=
 =?utf-8?B?dVdkcEVyeFc5WUN2ZEI4VEpZVWFyMFBwQ2tmTUxUN2UrTDdLbTBKOHorcWxG?=
 =?utf-8?B?V09vaGgwcmx1eGh1YVdnRytIbDdzOGpBWkFOTWVUSUxTUGY0ZGlUNWdGVWJ2?=
 =?utf-8?B?UW9ScVIvaGJRUzI3OHZEQzhqWWtpUzUvMElzamJUUXJOYTNHUFY5aEJmTTll?=
 =?utf-8?B?RFhmemp4UnNQYW5ENWwwWHExU3dTWGQvVzBlRUhCaE1QVHFtbTVTbUYvSEVS?=
 =?utf-8?B?THBvYTRIR1ROUmtwNENHZUVnRnRlUUdSQkZ4ZXpZKzh6cXI5aHkzcWZmNkpY?=
 =?utf-8?B?QjZacGRZakhXNm1wdUw2M0xxWEpPUXR3blE5dkdNVG5TYTNUeHRDTmQyQ3FF?=
 =?utf-8?B?VlBkNU5vMGxFV0M5OHdZbEF0Vy9lTDRYRkVpMGthZTkrSHN2ZFBxRHZFTFZR?=
 =?utf-8?B?eEkvVVZ5YlJxMjdMVHJjdkE5RFkrWktkdm5LaFlLbkVQM3J3eTVkYmRoMG55?=
 =?utf-8?B?QUtETHN2citHcExqY1hqNHpKVXVXSmswRU1OMnVlUjZCQXpGMHNzVEs2ZVd5?=
 =?utf-8?B?bjAwcmdDZDNEd2ZIeUR0V2tpVWJwNkovSGpOdmhHb01kM0dERWZrQVU0ekVr?=
 =?utf-8?B?KzgwV3g4NUxyTHdjQTJwcDZDQkw3cnpLMytncElERXNaVHkrWHlzZk5tdjhu?=
 =?utf-8?B?dWhtbjdIdytyeGRuQlFFWlNiZWc2QWZJR05wbjI3R3ovOUpsQVd0ZmxDUzhi?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b53713-334d-4c46-311b-08dcb61dad7b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:42:56.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z38/JPmNCQfe14+TKf65FP9EDQU68ZzCxSuUjV76d09whu7/5OG90ecN9eWf6LkB37DQxZAD3CNhmLLlfHTWTcmajOyBr2mhP99jRXK5sx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-Proofpoint-ORIG-GUID: bX6vHyBKPTJ-CSc-drjyEqpCBwDHZZwM
X-Proofpoint-GUID: bBk6kOtJR1LJfkMmlPPv23qWllNuVb6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 mlxlogscore=858 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408060095
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4766t3mv005948
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 13:43:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16447

Hi RP and Ross,

On 8/6/24 19:06, Richard Purdie wrote:
> On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via lists.openembedded.o=
rg wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> The previous code added local path to generated mirror tarball name wh=
ich had
>> two potential issues when fetch from local PREMIRROR, for exapmle:
>>
>> Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
>> $ bitbake lsof -cfetch
>>
>> * There might be "Fix File name too long error" when the local path is=
 long
>>  =C2=A0 since the path is translated to filename and added to download=
s/git2/ as:
>>  =C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
>>
>> * When enable BB_GENERATE_MIRROR_TARBALLS:
>>  =C2=A0 The tarball name will be:
>>  =C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.tar.gz
>>
>>  =C2=A0 The above tarball can't be re-used by do_fetch since bitbake l=
ooks for
>>  =C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.to.local=
.PREMIRROR' in
>>  =C2=A0 the file name breaks the match.
>>
>> Use os.path.basename(ud.path) as gitsrcname when ud.proto is file can =
fix the
>> the above two issues, now the file name in downloads/git2/ is:
>> github.com.lsof-org.lsof
>>
>> And the generated tarball is:
>> git2_github.com.lsof-org.lsof.tar.gz
>>
>> Or when BB_GIT_SHALLOW is enabled:
>> gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz
>>
>> And the tarballs can be re-used by do_fetch.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  =C2=A0bitbake/lib/bb/fetch2/git.py | 5 ++++-
>>  =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.=
py
>> index c7ff769fdf..89d3268f7f 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -277,7 +277,10 @@ class Git(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedrev[name=
] =3D ud.revisions[name]
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revision(u=
d, d, name)
>>  =20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % (u=
d.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').rep=
lace(' ','_').replace('(', '_').replace(')', '_'))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gi=
tsrcname =3D '%s' % os.path.basename(ud.path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gi=
tsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.=
').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_')=
)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcname.starts=
with('.'):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 gitsrcname =3D gitsrcname[1:]
>=20
>=20
> I did look at this patch again. I'm still not convinced about the
> original use case but ignoring that, the patch itself isn't too safe.

Thanks for looking into this, the main problem is that we need a way to f=
ix the
filename too long error as described in the commit message above.

> If you have two repositories with the same name, this can break since
> basename() on the URI is not a unique value.

If the two repos are identical, then it isn't a problem since bitbake
can handle them correctly, if the two local repos with the same
name but have different contents, I think that the user should fix their =
repos.

>=20
> Just as a note, '%s' % x is also poor code as you can just assign the
> value.

Yes, absolutely, that's my mistake.

// Robert

>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20

