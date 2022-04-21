Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B723C83028
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.19194.1650532147235994210
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Apr 2022 02:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=egNpWnOg;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=1110cd4118=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 23L8i27r022270
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 02:09:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=wxV28rtNXQiKZ3EwRUd3LkyAsh25fK/schWkXDpAbQg=;
 b=egNpWnOgw7SSdkVDXx5LNqB3sy/Ks2qbzepyc4ZfJDbxQS0w156YTYGZ80KhyVJz4qSN
 59iKIqXCeCSQH9zViRneWX+KewpQL6q9/aT6plmCfsMBYYhm9p+Yi9WLdXfOfH4Twh7F
 zUQnAbMI+yQD6qGOxoTZzTdm9DmT4Yq9nE7I5i+G/37+2Wg17xkLpGhQ02cVYLZH67Ej
 KdiEMf12d9TzEn51FEgea9RkAAM+niUYWLzUmx4ElEiW86QysSnusQsg91uGA0xpSpv6
 kctNCgfuxRjbv/0ENLU9viZki0oMJjgTPJYdyJTDxCkANjn7DKKTkLrpoAl+0+ovklKG iQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fhmfc1vk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 02:09:06 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23L9966X020243
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 02:09:06 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fhmfc1vk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Apr 2022 02:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTJ3H3+zR+oxVxhERgXVtcgYddBC7gibfnlKhZ74iLLReTv+OynkIftI8qrCSOTzJEJzTe4Q/zCiPWJcsjyxzQORnuv+IlUwyJa3UjXhaTvDvlzGIpcMgKIamLgYfjGUyqpH3lIVsHK4Tuuo8YQb3OjZFT+wU35mA4KvEmPSQnh4BA80HFSKL4nwskdYxNpl55GPJnap95CMJub7M8ij2Oo0MJLn6VSbgDKty6sFSeQ281Ndt0nw1O6QpFNBY9XV5pfcoPg3PLQIkahZF8kiKAR1ESm/aQdFQtQAtWZC2l7jumZfLhxi+ArT6jsbAOS586OoGsMitIhQfa6zaiQBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxV28rtNXQiKZ3EwRUd3LkyAsh25fK/schWkXDpAbQg=;
 b=h38Ta9XwT6nbyNPMyIaACiIB0X45elDDTp5SLVnEvVNaBca0TIXDKYz//XQ68O1Q6w/YZ0rCNYIpBuCM++WLv5yYuCnWDBESP66GOZS2QrZGlS/AnvNzXJgodXY+WJg1UyvP3GJvc596gLq0uVTm2LuHkGxNRFOAJpGqtJ/LmJBeWl/WUPbJMjeJ0HYrrAcqZGpwoweXW/6NkE3JzEzllj9ka8NJqWVjM0HD3wGlf3ZBQeD6YBqjd8llCyFyIjiMMUXk1X/CbRXkqK9fJU/RNBrUPCR0f0F7x3nDWTrKcJI8kQYfNXK5+59Nd9D1IfpKcE5C5wkoBsYvOFpFSWWK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by MN2PR11MB4510.namprd11.prod.outlook.com (2603:10b6:208:17b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 09:09:02 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::952b:793c:c458:460e]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::952b:793c:c458:460e%3]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 09:09:02 +0000
Message-ID: <2f1bb2aa-7af3-1d26-7cc8-140d09f3f988@windriver.com>
Date: Thu, 21 Apr 2022 17:08:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bitbake-devel] [PATCH] fetch2/ssh.py: Fix url code for +
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20220419174243.44519-1-liezhi.yang@windriver.com>
 <9b14b32e88ecbe01e179e817d76d9de0e21018fc.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: 
 <9b14b32e88ecbe01e179e817d76d9de0e21018fc.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3b2c31-e64e-4497-4d46-08da237693a1
X-MS-TrafficTypeDiagnostic: MN2PR11MB4510:EE_
X-Microsoft-Antispam-PRVS: 
	<MN2PR11MB451003B86214B7BF985D77C4FFF49@MN2PR11MB4510.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YKjNSOZ8SaeWrMOdyP3PXrHlJmX1rYUWxG5vGHjPODZzW3b+OyhLImqUrabs9WvoH5/n7oG1bryPBDrLstXf2N+dHypiLz+QsSb4XOCqoOqyiZPNkeI+IwQWjVURtCvX3j4Ynqou84fgfheUhG+0tpzIq+DUM9VkpEsJC85pCfTS7V6Urp+wU0VB9/2wlpth9RQDSHUU6W2rfYFAT7p358xvasNuS20A7yyWw9QTA8J6xM2/oeVKgOhnpsH5DP9seXt59IsZTiAeOEZX+YCyXMfK4EH3eTvUVRUU3G3ZsWtajEfpWykmaAB17VYZhLf4uZSzFSZaFEwiv5aJffTkq/l53/rpBORRiwKD1Qgm1oJpV3FERakSCKQx9KZPByltngEND8sXXp3c3FSsdoMcxd1Auiwm4jmnxpQe+On+Y8L8Uky9GbUQg7UmuRWH7FvFxMThTotWVGgOFVIkTTsJIWN3yH3mq2M24hMGFhF00MMywOKWKB+bgWryoCHKjfEJg/oUIaJMbVOroLuVylNlYsjMTFkrSxLZrwd6cyCEslq43QHAcEd1PsrSR10AKPKy3vnKy388Ze0hxVI6nPjGFi6EYNyWByb9pX3Zg9OK7a2ihS8NsyWNhSS0yPusqKYJ3WeL3GXPek7aKw4EgY5DxTTnMZUm+xbKf9dDM7Un7MQeMmLV++SRiGsyKlskJueuyxygCzYmIVin0d9vg4gef/PwftTWVXFvNlpSWlw0Kh+h9z0zby6hZrpKvxbOAHgoHcbdUC6C+JR5dcYJUucWzQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6486002)(36756003)(186003)(316002)(508600001)(6506007)(26005)(6666004)(2616005)(5660300002)(31686004)(53546011)(2906002)(83380400001)(8936002)(66476007)(66946007)(66556008)(8676002)(86362001)(6512007)(31696002)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjhuWi9uUm9RM2VTSWhVaWJqcll3RjVjSnIyMG5DU3p3djRlNElaQWpoVklV?=
 =?utf-8?B?MkJuTkdiN2grOXhlR0hYVUxxeStqNUNtK2pybzEwNU9JZlQ3czNGayt3dUs0?=
 =?utf-8?B?ZG1ZV0wxeU5oV2xUa1lkdHEzYUVDZ3Jlc1ZMRkFYSXB4UkIrRmFGbG9XeEVK?=
 =?utf-8?B?c2lncVBFWXF1eWc4dlI3QVY4Nm5lakJyNmdKelkyNjhWdVlkRnpWdmFmdmdV?=
 =?utf-8?B?UzZXSFl1STZlRHdJa296eEN1eTNIelYrQzYxVW92NzJ3UzF4Mm5NUUh2aWZv?=
 =?utf-8?B?UW5mVFFOcUY0T1ozc2JyU1FvazRNbENnR09idFFTL0l5ckUwTEE1MmxxbDlF?=
 =?utf-8?B?R0lOM1BtRElCa0RJZkhnc0pCdUhzY3VyQ0tKQUhaSFNRdXhvN0hna0w2S3hh?=
 =?utf-8?B?UmJ6S0dFTWRQSU9ZRDJDZ29aRUVaQWU3WFNSdFY0bmxlZVE5VGZkVjdqTldJ?=
 =?utf-8?B?MkVHZmJEMWdveG9JTWw3UDBMWEJjeXFST0F3d0N5Vzk0N3RJekhvMDJKaysw?=
 =?utf-8?B?dlhxaERZUzArYTJDbnlER0hYc0xTT1dNTjdYaXFUeUtLcUVLOWJvaHpyNjYz?=
 =?utf-8?B?Q25tYmNBNlFsZ0hEY0tsZThSSU8yT0tHdEFKcEFsNm1DS3N0VExIQ0JIbDlY?=
 =?utf-8?B?ZG1nUkNNQ3pBZ05OeWNXTE9uVC9vMHNDRUFPMFhrMUhkK09jTi9LcWVRR1NZ?=
 =?utf-8?B?RWtWNnRwQlBaMEppRGQyeUVKaVE3TGUrLzhsK0RHbktabUpQc0xFd29aS05R?=
 =?utf-8?B?YzRESXpwZ1hGOU1DcUwzYzVsaHN1VTQ2RHVrTjBacUNzQWpabXZQNXVLVnFM?=
 =?utf-8?B?WDV2NFc1MXphOWVGZDdqU1FWUlRidEY1U0x3SzFFNDNLdDE5VVdVaFdMSTl6?=
 =?utf-8?B?MjZRM01aeXRYSkhLMmY2UlNLMHFHQ3NHSTlXc0ZDQVZDY2JEOTRWSytyU3BN?=
 =?utf-8?B?OGVZek1MaEhxSjN6b0F0MHJJZHd4VXFTa2dEMHVoSEdRVkJlQnNLUTZhaVI1?=
 =?utf-8?B?MnBBUVFGYmEySHZJaERjQi9RUElmYkZDanlmclB3Y2FvTml4eVpjN0g5YUVF?=
 =?utf-8?B?WjIyanNENTk4aG02aWFXLzBNZnhqWlE4NUhGWkpyMXB6ZGhhYk1RMGF4Y0hR?=
 =?utf-8?B?MTc5MEU4Q2s0NENJb1Zmb2xUUTREMEN4ak95SjY3MGJKcVNBNFp4RlFhaUds?=
 =?utf-8?B?dXIyekhwRk5od2c1bUlBYng2T0ttcks5VVU0Y1FqUFQrMk1xeVg5ZEp1REZu?=
 =?utf-8?B?OFNyd1ZKRGtLZ0t5ZVRRTXVMK292amhRRCtJUi9IdmtWOEpqRFV3dStNL29q?=
 =?utf-8?B?NTVuVUxDSnBPZ0lYZEtTS1pmbTQ2WDAzS2Z2SmhNc0hXQW1DVWdTNFJjL2lm?=
 =?utf-8?B?VGxDS3VKdTk5WmpnbXpLOU1NQkk2WFN1dVlhSFlXai94NVE2YWFoKzZOU0dT?=
 =?utf-8?B?NWxkYlZJek8vdXNNdHMrajZtNXR3QlZ1N25yRW5nK0liTG85S0I5enFmdGU1?=
 =?utf-8?B?NDJtTEl2VmZYNGxhSU1iR3pSNVRFZjNTeTllNzJLVzRhU01ta0NweEpOVlJQ?=
 =?utf-8?B?L3JPVEsvcmNVZk5LM0JDcW5LZENwTDJqYWFFQm8ycjBLUFllSUtpN24zOEZO?=
 =?utf-8?B?R3Y2Szc5L1Z5R3BILytiZTd6MXloKzA4MENTamcyK0pVYk9ZZmR3UzhUdGdH?=
 =?utf-8?B?TmNjdDFYUGkwdDczNUZFSEdHcWdTbkNROURmMmtPUFZBWCt3V1BPUElqOWU1?=
 =?utf-8?B?azJ0YUIxOWJQamNKMWFidWpqcitxTU8wQzFrRnZ5eVNvblI2VzlMOHduNUFx?=
 =?utf-8?B?YUN5Q1NUaHM3KzlhMW12NnUwdVFWZXc3ejlydjZCTENTNU51RnpzRjEvVjV6?=
 =?utf-8?B?Y1FoQitHTU9ZWFVwNXBMaGJWY0FWRXRneFZ0VlR3clZzcXN1ZDdhTlh0cUZV?=
 =?utf-8?B?TFdEUmJwaFUxbWVCZE4wbkIrdTBpYS9DNXR6WFFqRzFreGpTQVZObnlQZDVn?=
 =?utf-8?B?SmdTYmk2bytKVW9ZR0hmTzB6YldIVnl2OUdabjJucis3YndHZzZRQXNMU3pt?=
 =?utf-8?B?QjdtbjhGZXlaOHZtL1Zodi81U1R5SFFTTjViU3VESG96Y3NEa3M0L1dHUjVl?=
 =?utf-8?B?b0xvNzJiakNMN2J2TC85K2k3QzBSY3pxNVdjWHlhdjBSNjFVTTEyNVpCdXU0?=
 =?utf-8?B?T0lidmFhYnBoY2REU3VxYVNidEVxMDVHOXJwQnJydjcxSC9ySDZ3ck9mTEk2?=
 =?utf-8?B?VnRBbzVORm9KRCtJV0hJMmJqTVg4Y1dTODFqQ3hmWDNqOGlEb3IraldYYjBi?=
 =?utf-8?B?UGppQVpVdytJRWkwdDFMQnV0SG0xcnZTRHpmNWN2OWJkbzBJZXRieWlJVE9J?=
 =?utf-8?Q?3GYI05DZKLVNYDIw=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3b3b2c31-e64e-4497-4d46-08da237693a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 09:09:01.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 60rHFqGmcEKDA3KzylyLLsBr32SRFeK6uKQXqHzJcvF1AMUxopFqumxjAZGhXApQOQEWmZiZ2Oe4RKVknqXkvqcssOP5HyPJxbluYTvAcQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4510
X-Proofpoint-GUID: kzSmAbyQ8WaMJuvRYuEpJ6m4zStnX4Bo
X-Proofpoint-ORIG-GUID: SwTeu_6lep1Gu3HgPcxTlgRzGJtWR8pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=910 suspectscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13655



On 4/20/22 10:11 PM, Richard Purdie wrote:
> On Tue, 2022-04-19 at 10:42 -0700, Robert Yang wrote:
>> Fixed when fetch from PREMIRRORS via ssh:
>> $ bitbake bonnie++ libsigc++-2.0 -cfetch
>>
>> scp: /paht/to/downloads/libsigc%2B%2B-2.10.7.tar.xz: No such file or directory
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   lib/bb/fetch2/ssh.py | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
>> index 484453088f..2836d7c884 100644
>> --- a/lib/bb/fetch2/ssh.py
>> +++ b/lib/bb/fetch2/ssh.py
>> @@ -70,6 +70,7 @@ class SSH(FetchMethod):
>>                   "git:// prefix with protocol=ssh", urldata.url)
>>           m = __pattern__.match(urldata.url)
>>           path = m.group('path')
>> +        path = path.replace("%3A", ":").replace("%2B", "+")
>>           host = m.group('host')
>>           urldata.localpath = os.path.join(d.getVar('DL_DIR'),
>>                   os.path.basename(os.path.normpath(path)))
>> @@ -99,7 +100,7 @@ class SSH(FetchMethod):
>>   
>>           if path[0] != '~':
>>               path = '/%s' % path
>> -        path = path.replace("%3A", ":")
>> +        path = path.replace("%3A", ":").replace("%2B", "+")
>>   
>>           fr += ':%s' % path
>>   
>> @@ -139,7 +140,7 @@ class SSH(FetchMethod):
>>   
>>           if path[0] != '~':
>>               path = '/%s' % path
>> -        path = path.replace("%3A", ":")
>> +        path = path.replace("%3A", ":").replace("%2B", "+")
>>   
>>           cmd = 'ssh -o BatchMode=true %s %s [ -f %s ]' % (
>>               portarg,
> 
> Do we need to be doing some kind of url decode on this?

Yes, I think that's better, I've done a world fetch build after 
urllib.parse.unquote(path).

V2 is coming.

// Robert

> 
> Cheers,
> 
> Richard
> 

