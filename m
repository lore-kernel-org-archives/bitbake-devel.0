Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC2C3271E
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 02:42:07 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4191.1720492923687932808
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 19:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7920ee7300=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4691Zpvb021577
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Jul 2024 19:42:03 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 407170j3v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 19:42:03 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4692g23n015101;
	Mon, 8 Jul 2024 19:42:02 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 407170j3v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 19:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJa5LCSdhPcmiQzerSH7oqz6JSmsvI2lFvmwyMxhDhEvd/82prSAQ5DNDr+8FeeKt8LT5O4ee9Wu4IFuiTcr5Gpqqp7WMBe6UA42GM1c1Wla8C84ps32l935eAz9GhTIGL4RzyfQZIEHBGJynBQZ/vo6HpSELJhzpVY1wvRkRNaxqRr1tul+HcaaqeMtjE3/AhIR/5ohz1vgqOX8584dMblT7eEAvAwYGy4s2XKkIEb0coVwq7ra9OZdV52MR15+ZpkzR1Ni6kPJ1xb4shu3vNWSAkFYmlVaKgsTQuU89ODdx2AiTSdgwo2jyj3GVQ8jUckSVZwEtcQreKBdkqVU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLlwBbxURQMhuOhZ6x6bn06RMBwM5Fh4lOB/0J6mMY4=;
 b=dGz1XA8ibvDV4LSqHoLVkkfqytSzJJyf/llihVzg7TmLJudOFOTYQcl+chaqL4JxUHC5wjbZx/qPi5TZCom/DNYGLT/sOnu3nzIXT5jlul1ODUiJ5whP6lgy0HWY/NKtISYrHI8Hb2l6uJsICz/PGRsXT656VZ4WVUkGlmyNv+bFioXxmbF8oCfLL5fYkTcKgJxdu+pHNaTkcPchtah6M2asB+6oXPVZF6RXiOOxRio8+bWkPw7H7AJ8pTSd2aboa308ORXlZwGW8/5JWNzw3Kkqomg5Dn7J6PjUyBn2DN11+Hcwp1RwawiObPP09PrJVwYukVCIwZ6HPGAQuMz28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 02:41:59 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:41:58 +0000
Content-Type: multipart/alternative;
 boundary="------------Xpa7xceWW6QCP8etCBz5tT3X"
Message-ID: <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
Date: Tue, 9 Jul 2024 10:41:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
To: Alexander Kanavin <alex.kanavin@gmail.com>, ChenQi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20240708081034.1474312-1-changqing.li@windriver.com>
 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
 <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
 <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SA1PR11MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a3dfbc-a22f-4192-0ec7-08dc9fc0b421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aVJ0Zk1Ga0FXL09JR3BMVURKanY1VEZyNHRjVGNrUEsrT09HcldzYWhQZzRW?=
 =?utf-8?B?d05KamlyeXVRdGRnbkJyUUdadnNZeVh3K3lHZ0t5VEw4aE5PWVZuTU9WRFE4?=
 =?utf-8?B?STRhT280ZE5mYXIvVUdXdFU5bHB5Qll1T1FaZ3ArK3ZNVlA0MDIvS2VMalo3?=
 =?utf-8?B?RGFDZWpYL2ZVeG81ZVRaVzZ3UEpHWUFnY25HdDJTeGFranVSa2xxTk9RdTI1?=
 =?utf-8?B?SDM1NFhXWUtOa0M3MFJYTGxnbW5WZEtxampISHVpOFJOeWdqMVBYeGdZOHVk?=
 =?utf-8?B?YTJqQkJaRTVsYUVGM0VhL3JoUzIyMFQwYUwzeW1BMzJBekhxMERnaGQvR0JO?=
 =?utf-8?B?anp5NDVud3d0MitjdXJMZHRraVRmOWVJcWJuM0JudGJvVDFBNWN4Wk9aaTk0?=
 =?utf-8?B?dkdGR2s2UnRnNTluU1htemV1V1FuMExJbmI0Q0Z2Ni9TYmx0MzVvV2gzOVN6?=
 =?utf-8?B?cCtNR1NlYWI3QW1JZHN1MXBwWnQ0cmNqbEFISDMvV3ZBRTVBME5sZ2V5aCsr?=
 =?utf-8?B?VVdMVlRoWFFQUHFrejg1K2FpcE5PaWRwZ2ZPR3FzMHpyNWJBcjVPZnVjKzAw?=
 =?utf-8?B?OGo5bmxMMmdwd3gwRGZWTndQKzNmYVo1SlB4VDd3dzlHSnZQalE0OTNoL3FM?=
 =?utf-8?B?WjRMemhtbUdvMXkxSzlsWjJueWRPcTVlWE5nU3NQdVpaTGYxa1F0UVFCZW9X?=
 =?utf-8?B?bGQxcVQ3Y1BIaUZNOWFWVStjMW1mL1dheCs0Z2NxdkFkcmx2eHBDUlJpVW5J?=
 =?utf-8?B?TnlxTjBUU0RrNmVVdURrTWwxNVc0YWUybWpvVkpqLzd2aHViYkFvZnkzS0x1?=
 =?utf-8?B?YUs1RDBMem9ITXlIWnAxcEJFWXN6YlhQdlVsQVJ5cGk2VDZGd09McU9VNmtX?=
 =?utf-8?B?UHJGZ3VxNjJqZmRVTVFvSTRkcjhLVVllclZCQlgySnlvamVIc1FzUzZrZzdL?=
 =?utf-8?B?Q0NUSGVpSkU2eFBiZW9uNTdmR1Y5TjVLdit2MjllNjFXdDQvWDNCQ1pxQUFa?=
 =?utf-8?B?aGdvWDJmV1VpaWpkRGlTZ0w1QzJ4blNmTldwa0l0UTR0NHNTUEgzcUxRZlpw?=
 =?utf-8?B?Nzg2L3IyRXhzUnlsZnM4Tmt4ZzF0QkJZakc4NEZBZElXN2kzbEFNbjRqNVNE?=
 =?utf-8?B?SXBVTnc0S1RjSGVOd1dQM1dZYlJhZ1h1S003UCtPYWpBQ2FVNGRocVM5L0xm?=
 =?utf-8?B?YXFIR0RIRXR5Ry9CK3dIL09iWHJaUlg3dUJSVnpVNnllRGlzTWRxN05jY3FT?=
 =?utf-8?B?azFES0Z5YXk1TVNRVkxHTzBlRGFmT05YNlNCY3k2U05yY3dkZ3BXbnZydSt1?=
 =?utf-8?B?QWxaWGNsUnRsRDU2cWM3M3RVeXJQVXVibFRVNTNyQUJtSnRMNGJRVC9BQWc5?=
 =?utf-8?B?aTVyeU9lSC8wZ3ArWkdTeWkrOVV2ODBmSEdWeThXSFlyQktKTEcwMXBxYU5P?=
 =?utf-8?B?dWxMV2ZmWWZYaEJEcXU0eWI4YTNPdjhSTklra2FIdlkyb2paZXNsMHJBSkhj?=
 =?utf-8?B?dUI2ankzWlpwVi9HckZ2SnNFTWtGTWRxeDF5bVc2YWw2R0tDUSt4cTZEcnBm?=
 =?utf-8?B?Y0xwMWIvV212Y3llcHRHMUVGaGZZVm93UEpiYUYvWC9aWGNZMXNNcU5xSzV6?=
 =?utf-8?B?R3VYbGxQOTVrTU1SNzhJbVZCOWFwWFljbWNia3pRZVZKL1RTT0lMS25DdHNo?=
 =?utf-8?B?NzlhY3FhM1lpUGNGMHdkUm5ncTBXZ1pxZjVvOUdCVzRLaHMyZWVXWXZ1YS9y?=
 =?utf-8?Q?fq2YOtHGmzHe0q6fgk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjFRUG1HSW5qbmtrRkRnYkZWbHRaMnk0dEFQVWo5OHdXdE5nZjc0S2p6WDdD?=
 =?utf-8?B?dWhtQUhPVVQxcTF5a0R4SHd3QUFiZmhXbkJSSWk1eSs5bm40QnEzeUltcG1V?=
 =?utf-8?B?UngvdmhBazVaaVJZVGpKNEVaU2xUaWwzck5DWDNDM0tKaEl1QWtHeW1LcnhT?=
 =?utf-8?B?Q2I3MFBOM2g3MWF5RUx5Y3VUeVFiVHVucW5MNE00aGlHWHZBZGc3YzNzNU1T?=
 =?utf-8?B?bW5jWEFvWUlYbERNSUFIUnFydWNCcWREYWJsNmVaNjZ5dFVHQjlTUVBzeUFI?=
 =?utf-8?B?V2o3YkJ4ZVJLMGNuYkliQlZDTHkzbkcxUjNDL1FZU3lqQUNmWE8ybjRHSjhh?=
 =?utf-8?B?KzRURmFsR0N6NmJkc2hpTVJFaDdJWFdGTW84bHVwRWt6cmlSMjFCSFFGYlRE?=
 =?utf-8?B?dEtJamQ2VkhxOUcvUFpJK1BBYUxMN09EcVpQVWZ6S3RJdjRPajFKQ1EvNFQ3?=
 =?utf-8?B?R0RyR0twenRnM2FCYm5nU2MybXo1cUZnaFdrUE9zaElLK3ltYW50WHprRHlM?=
 =?utf-8?B?QjU0bnJMbXVsbGV1SzRtMmF6RmJOL0xCUHZyZi9vZGIzSHRLZ3dDdDJERGp5?=
 =?utf-8?B?VWdseEF3bnNzUTNwQ2tEekNXOWZrV0pLaU5NOFRndVNGVjRhSWgweklIemZi?=
 =?utf-8?B?ZFZ5ZlV3citmVzVJcVl5NEZVOHBjRFFPMWsyVDFNaUxaL1RZdENEaWdGNjIz?=
 =?utf-8?B?b2FaSnQxS0V5ZUdSK3FIQmdlT3NXempONWVia0pRdVNNZlEzcU9BbDF5S0pH?=
 =?utf-8?B?dTh5SkQ3VFN0QWJpMmNycEI2UDhKeG52NU83ckFQOWozTUJQeitjMDRNSlJR?=
 =?utf-8?B?bFVHNktWMDRRMk9aZUdFNGZOYkpPRnI2S09VRjJ4VzluMUUwanNDeG1pekFp?=
 =?utf-8?B?R3BiYTJyek9HZjJBdFlZYWVQdVA1R0FoQktjekdxcXZWODNCYUo2UEUrZmh0?=
 =?utf-8?B?eDFESHJhcVBxVkgzUGhhM01ycUVoSGxGYzZjY2xxVEtjNmR1UEdBWU4xWEV6?=
 =?utf-8?B?d2Jma2IxeTlHNHVuR2JPbTVQVXBwdUh2NXJxUS9aR3pjTkpVT1krSmhlVTJS?=
 =?utf-8?B?MFBjeGlNd0JuOWV0WE9SZkJYVTE2eE85T25xbktwU1o4VjhVV3VXa2RnTmZs?=
 =?utf-8?B?TS9yVU9uU3FFUlY1VDd5d0dhK3pqWFljY3dqenFVUkVRb2F3WEx4WE1Zd05V?=
 =?utf-8?B?M2VSVHh3d0FtUkNSSEZLSkFyUzVuYmR0cllUUUR1amsyeWZiVVU2WXVQUy9o?=
 =?utf-8?B?bVVWZjQ3dlpDWGcxWmtzRlpGendpVjBVRE1Ia0g0cUtDb1FTSDdtYzBnTnli?=
 =?utf-8?B?QjRZVmhSRVFzZ3VDMTI0cEZGMlpwWU1wa1ZROTFmWitybW1KMHFSYXVMRU1M?=
 =?utf-8?B?OVJBTGV6Uzl5eG9xUTdvVjg5ZTl0RitaN1NVVFpEK3NyMUxDTHJoMDlYc3U2?=
 =?utf-8?B?dDUrcVJBZWlzK05nTXJ6dldxY3lOZDdWeG1DNC9BbkZ5V2xYNHZlOTJwSnl1?=
 =?utf-8?B?SXlyYStneW12MlZhbEdUMndpT3dMb3pBNU9NL0s4Mk1mbXNleEphbnJyc1BR?=
 =?utf-8?B?WERqWDROU01rMnNxTThVSnJnUlFvZnhjWDFwck1GZzZmZS9EamtUeHNWNGxx?=
 =?utf-8?B?VlA3cjMveEwyTHZIbUNBYTJoNjBVcWtJeWNlNHl4OEswYjZXc3hyc2pjT242?=
 =?utf-8?B?akFXTHBCUVpTQy9kaXRrbGhtOU4wQlhtcENiTFhOQnpKNUFXK2VHVVpHY1p5?=
 =?utf-8?B?M3laOXhkM05pOVZPTk9KeC9JemxVbk1lRUxZdi9hcVdjdEpjbzBwM2hvSUVz?=
 =?utf-8?B?N09pZCtmVVF6THJ5bmFCUlF0SDBocEtOS09rYm9zcTJLeWRPS1pmZGI0bjdM?=
 =?utf-8?B?RXZXYXBnR0k4eENXc2Y5ZkxDR09FV1RSdXFqMktOSlZGMi9GcEZFTHA2SWZE?=
 =?utf-8?B?eW9tQkJra1dyZjBGU0V5T1lkeGU3c3hkSFpyYjVLYnR3bnhCOW5ZV29iSDhQ?=
 =?utf-8?B?Q2E3YW5wZFpHZ0RGT250eE1CRHF3S2l3WENES2Q5Z0lBL2lUUlJlQU9ja0ZF?=
 =?utf-8?B?MHN6bVJrNmRUVExqSVhtYUdvWitBRFVKYWxYb08yY3VmS01ZcnBKU09NTVNY?=
 =?utf-8?B?N0tXS0hVTy9hMUlOSmV3QWJyRWdyUGI5SFAwS2d3SzF5SWkwR2dkdWRzaDRD?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a3dfbc-a22f-4192-0ec7-08dc9fc0b421
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 02:41:58.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t2S++JZEnas3YSc79lX7dTCEb1olbIros1bbzGLhS+m203pB6kAi9UxxAt7GRtqgSiwiSXgxnAS/smkt4EstGzStSi4+e5+STVCrf38uy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
X-Proofpoint-GUID: J8Hb1feh9AjfpvZ-bUBvVnghARksyTVM
X-Proofpoint-ORIG-GUID: u67YjXNrzl4Aug-AwNrMGVjHyEiwDk3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407090015
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 02:42:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16406

--------------Xpa7xceWW6QCP8etCBz5tT3X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4691Zpvb021577


On 7/8/24 17:25, Alexander Kanavin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> On Mon, 8 Jul 2024 at 11:12, ChenQi<Qi.Chen@windriver.com>  wrote:
>> This problem has reported to Ubuntu for 4 months. It was discussed on
>> the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not
>> very optimistic about getting a solution from Ubuntu.
> I do not agree. The last comment  (#10, added two weeks ago) in
> https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555  shows
> how to create an apparmor profile specifically for bitbake, so once
> this is added to apparmor upstream and makes its way into Ubuntu the
> problem will be solved. At that point the forced network disabling
> will become unnecessary and damaging. Ubuntu release notes imply
> they've done it for things like Chrome and Discord, but they expect
> more to be added:
>
> https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-no=
tes/39890#security-improvements

I think applications like Chrome, thunderbird etc are commonly used=20
applications by user, so they are might in

ubuntu's package repo,=C2=A0 so they will support it and add profile for =
it=20
by default.=C2=A0 But for bitbake,=C2=A0 it is mostly

for developer and and not support by ubuntu.=C2=A0 And considering there=20
might be many other softwares meet this issue,

so I am not optimistic that ubuntu will add default profile for all=20
these softwares.=C2=A0 so maybe we are still on our own.

One option is using this patch,=C2=A0 so users don't have to struggle on =
this=20
problem, don't need sudo, don't need an apparmor profile etc,

but have the side effect that skip disable network,=C2=A0 we need to bala=
nce=20
which to choose.

One option is document or=C2=A0 notice message in oe-init-build-env,=C2=A0=
 suggest=20
user to disable unprivileged_userns or write a profile for bitbake.


Regards

Changqing

>
> Alex
--------------Xpa7xceWW6QCP8etCBz5tT3X
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/8/24 17:25, Alexander Kanavin
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

On Mon, 8 Jul 2024 at 11:12, ChenQi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This problem has reported to Ubuntu for 4 months. It was discussed on
the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not
very optimistic about getting a solution from Ubuntu.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I do not agree. The last comment  (#10, added two weeks ago) in
<a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555">https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555</a> shows
how to create an apparmor profile specifically for bitbake, so once
this is added to apparmor upstream and makes its way into Ubuntu the
problem will be solved. At that point the forced network disabling
will become unnecessary and damaging. Ubuntu release notes imply
they've done it for things like Chrome and Discord, but they expect
more to be added:

<a class="moz-txt-link-freetext" href="https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements">https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements</a></pre>
    </blockquote>
    <p>I think applications like Chrome, thunderbird etc are commonly
      used applications by user, so they are might in</p>
    <p>ubuntu's package repo,&nbsp; so they will support it and add profile
      for it by default.&nbsp; But for bitbake,&nbsp; it is mostly</p>
    <p>for developer and and not support by ubuntu.&nbsp; And considering&nbsp;
      there might be many other softwares meet this issue,</p>
    <p>so I am not optimistic that ubuntu will add default profile for
      all these softwares.&nbsp; so maybe we are still on our own.</p>
    <p>One option is using this patch,&nbsp; so users don't have to&nbsp;<span class="HwtZe" lang="en"><span class="jCAhz JxVs2d ChMk0b"><span class="ryNqvb">struggle on</span></span></span> this
      problem, don't need sudo, don't need an apparmor profile etc, <br>
    </p>
    <p>but have the side effect that skip disable network,&nbsp; we need to <span class="HwtZe" lang="en"><span class="jCAhz JxVs2d ChMk0b"><span class="ryNqvb">balance which to choose.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz JxVs2d ChMk0b"><span class="ryNqvb">One option is document or&nbsp; notice message in
            oe-init-build-env,&nbsp; suggest user to disable
            unprivileged_userns or write a profile for bitbake.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz JxVs2d ChMk0b"><span class="ryNqvb"><br>
          </span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz JxVs2d ChMk0b"><span class="ryNqvb">Regards</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz JxVs2d ChMk0b"><span class="ryNqvb">Changqing<br>
          </span></span></span></p>
    <blockquote type="cite" cite="mid:CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Alex
</pre>
    </blockquote>
  </body>
</html>

--------------Xpa7xceWW6QCP8etCBz5tT3X--

