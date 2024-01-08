Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0813FC3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 10:23:34 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.3796.1704709406991893111
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 02:23:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nXM3V6Mu;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=173720cdb8=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4089UKYO013106
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Jan 2024 02:23:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=xKYy/jUYDrp3yw+AITFo8d2e+7BO0xYPM+KsqrBrGq0=; b=
	nXM3V6MumZcAuQsJ/N8YfNrCUVNPP9C/hCOgU4ycp3rpK/0cTfZXSDC6sk6rvcCK
	qTOsAxPcsEZ5alPEw94/lpTvoWTGRn0ix4/HekM3hKwNUU8EnWghaSpPuT+akyhd
	FelT6iy30dqW1wIJ1rKBkBEVp9fPAiKGcMs8V0ShHPCk0kLJh0PSLdJGtrySJUW/
	/7icOeidIjhKkZ0Qhn2aYPdufeXnhRO3zrmHI7udstEoIjxdy1wTY2izb7GGYKKs
	VOJPL5nu8IUAg4q+tedrDwe+pfK6SUhkYcGy11JfJXbQrMsJQcrFIelTaS6lwdlR
	QHD/dWyG6nDqpi0HpAlDew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vf313hng9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 02:23:26 -0800 (PST)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 408ANQs3007331;
	Mon, 8 Jan 2024 02:23:26 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vf313hng8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 02:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDnHZI+oHnuIlIS8mMeTXRwfCH2ffua2LGPzKhpSwDqUxrcTOKFQyk126ZU6wD7ehMhhDMHny2YtiiBERM+oDMttIMxti6vaiDhmb0MXvtOJnVjE5Y9EpkP02U5NdqkXbsSKztnSOwOcZVlNcaVcBhqeMGWG5iJS5Gq/mBYs/+ud70a5eo3L5bOdw3VhuEZA+ujQ4f3wn2lf7/j1afJK92chcHKr9V9IGqlAZwoiuqPpzpXgTd6xisCkJXPKLIlsP0OEZ3ezl4V5PKXFxwG7w4Y1g38tGHxvNTAGsK/O8Y0eM8pyPjYFx5/uyd4IAE6LGgKZ/EK0738pteZmiyTwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKYy/jUYDrp3yw+AITFo8d2e+7BO0xYPM+KsqrBrGq0=;
 b=eEk2s7rhmpIWyDwiUZHgRDkU0JuMkJGyzbWspGscDvGB8KY1vkawBwFTAbr2gwr0LeWmh/rvZPKeBaD5CdMy3BAMvQ1Idrx4cPnISHqRGmtskbwCu+0lPbb1kIVWSgZH6vVjSEw+Dcb2O6icsOPrRIoOr2zhlbgGu7w+fYnDBntgPdHq8jaF+mszhfKeO0Jc24Z1fQn35E9OyCRCcTQRuRLiifWwOLFlr16Bfu0/wB2e2fp2C1qeci1O0OYF2urmfDVSx5DwWE/HAJxm4L4ZQOeb5+dVt4ZtYRz4yRrp260OD/qKzhQd/S6CmJVdXIka1r9gff17RUdgzo7CMSYOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 10:23:23 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::50dd:9a9d:180:df89]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::50dd:9a9d:180:df89%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 10:23:23 +0000
Message-ID: <c109be1f-43b5-4078-9218-60e0c0db8c6b@windriver.com>
Date: Mon, 8 Jan 2024 18:23:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 1/1] bitbake: event: Inject empty lines
 to make code match lineno in filename
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <cover.1703829627.git.liezhi.yang@windriver.com>
 <b64c2496383eb263e6fd2d636ec7a2d88b424db6.1703829627.git.liezhi.yang@windriver.com>
 <35a13b43c34c7159be6ddc3e00266e01d7ba712a.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <35a13b43c34c7159be6ddc3e00266e01d7ba712a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0202.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::10) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0e03c3-a0cd-4f75-fcfc-08dc1033d7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	miWbtle6JJHWOKlaYwPOlGEwa7mdBI+h41HpPABnpklggM2e4r5eq9WpTLQY4HYIoSZRoiVN47x/lzcjzF7IlEt7A5HsZxuOq2Qyfzu+GxfGcoIwnMJq2yt0eOTeQ4tL08CZBQGyy4ddLHlAKx4tRqQ6mGseKC7ICS4RiVbLwbCbgTsc9hrM6isQbqgwGNfpdeAa1FK9ogIArSonR2hcH8YpNA4jlgfkA+WfVZx9KG8fy+yKURerSi4oRXVxWkCOFFZaKESX62HjiLMzq7xxBPuRobivyZNzuZIK6hy08cHCxYsEToyyTv8YzdxChzJgve4utUHIaY4YvSav6ipTHTP0plz7wUmJb0LReMFtYtW9GDU/f/GsQdRyjsy1h5X5o4OPzhfmRzkEBasavpNLuKNSTHp2jJxl0RsAY8B1nuGRKSBUOeG+I0sP1MgQWL2ZTQHBncZ43s0I8U9Iwx2rQb3Nx2dgidpF6+M5piWfxAIx49L4fPU6qkJnqhuNvyF3TXidV4JqspfENpTyvaK/KmtClTh3F9FLHfSNACMZq20/UU9UBGQ608eCz03rirdfj1nRMwWaDxJtKaoCXul7gcbYV5rxEguLA5ObBgpWzEaLxW/XtyJOdx6onZA4D+I3CtC98t3HVzrYq70dnwuKPQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(86362001)(8936002)(8676002)(6486002)(31686004)(31696002)(2906002)(5660300002)(2616005)(26005)(36756003)(66556008)(66476007)(316002)(66946007)(478600001)(6512007)(83380400001)(53546011)(6506007)(6666004)(4001150100001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXhqV3MvM3BDNUl5MWU1V2I1eHBUVWp6bkJncVJ3cDNlS3FpNnJEak1OTlBF?=
 =?utf-8?B?bC85N0V3ZHlpS1h5RlhyVkszbzZYYnhxRklOQ2doc1NzZnprZXUxRkdWRG5y?=
 =?utf-8?B?MVNmTFlqWGhFU09TdGxsSFJvcjA0NFZzQ2ZWWElIRDhoSUVzU1FjeGtMY0Zh?=
 =?utf-8?B?aVV6Skd6VFlrd3FGVG9sQmZoTXp5eXRzTHlMRTd5blhaeFIrMUM4RmRSc1Z3?=
 =?utf-8?B?NEJYcExDM2xzSTB4UnpWNDVZQmVyQkNac3AxUnpvdDU2RERYeTFnOWlqc1hk?=
 =?utf-8?B?WVlZYjVEaWljeUhheFZWaGRVNTNZVkZWdjlBSmNvUy9IdlEyUzcya1IwQ1lp?=
 =?utf-8?B?QXZ3d3ZzMXp3S1BGNGVKcVRhMVZIai9pcnpZb3FTNVpNdElrMGVNL1I4V2tV?=
 =?utf-8?B?ak5EN2lrRkhwa3U2UUthamlLYnl0MUhUUUxpRmh3eEdzbEFObGRBVFZNeHo2?=
 =?utf-8?B?MUlvaW1IVVNScnRzZVlXRjRyeHdLTlpWU0ZGTlUyZzBOR3V0R3NJRTdNQUVs?=
 =?utf-8?B?dXBTYXQwM0toTW0yT1BPQnQvTkJzZmduWlgxa1h3UitDT3FZeVJVREV4TEV4?=
 =?utf-8?B?SGEvdDlYQVlRVHRacW1reWRIdVNQZlZYOS8rNlVMU29qWXdOc3cxdDNMb1hw?=
 =?utf-8?B?aUFzNHlnbFVNbWFiZlB4em1malJxa2RINlNLRVUvTENzVXZxVFhCa2NSMU5X?=
 =?utf-8?B?SS9BNVZiN0JjTFFOOUdSYWpXQ2lmdFhkM2RkS0xTMk03RVh5YlBYUDNsZjJB?=
 =?utf-8?B?THNzUDdNVXVPZEJ3N3dVSEtNM2FxQTA4VVlKaTJ4TWNIZlNyT1dOWUxKQnQr?=
 =?utf-8?B?ek9QZWxLS0N6QjFFM2tZSUNnMFZpZStZaEE4Vm1qUmIrQjR1WnM2ZVU4eHRJ?=
 =?utf-8?B?RHo3SkhUS1ZJWEdXMnl2QnZSS3ZKZ2ZIMmtySGNaU0lhZVhYYjBHeGJKa0xD?=
 =?utf-8?B?ZURZWUlzc2RCUTFtVDRjSGZ1cUt2Q2RkSkxFYUtLRnB0RkRzV3UxYVpEajgx?=
 =?utf-8?B?NzIwZSt1TGsyb1o2U3RGTS9uS0ZkZXVnZkhNZ0R6VE9yU3RaR1Q1RzNHUE1W?=
 =?utf-8?B?YmZCMytvWGdEcTFUQnE1UE85bE43VXRMU1U1MDREcUcxdktWYWhZMDU2SGJO?=
 =?utf-8?B?ZXVVNkw0ZEwvVHZwek9za3cybG5hOUpmb0p5TU54T2FFNFU3K0ZNT2NVZVlN?=
 =?utf-8?B?WjZFNlAxejFBa2JrVzNYR0tBTXY1MzgvaC9RaGZOMk5LVmY3aTNGM3EzRFZY?=
 =?utf-8?B?TjNZOG00QzFZTXYxNUdIVXhXM0ZHdU5tVkw0MnFidWpVK29tWklFSEZ1M21r?=
 =?utf-8?B?RFVqWld0dWZjMDRnd0QvTmtBQjc5OUFjTjhHcFRVUmhwTWRTbk5XMTJhVkow?=
 =?utf-8?B?SEc2YjRPV0RZRGY1YklBS2ZiUDNkK2hYbFhUMG1KN1NPVzFVTXp2TENPQmNC?=
 =?utf-8?B?ajZGdnFYek1ZWTBiUXE2YnZTM2psTWw5TG45Ylg5WmpOcFJIdjN6VTR6NXhR?=
 =?utf-8?B?Wk9DTWdjNys5TU9pRlNqSUNnT3N2YlY1REg3aCtkTEs0OUFHclAzRHpmUlp1?=
 =?utf-8?B?OVArWDYwMzZMeEVvRzNFK2R4N2NSMFhMd3RzRkhZQnR5czBoYVdJYm50WjZx?=
 =?utf-8?B?UkppTVdab1kra1lRdnp0RTlRSTNGMWlXeFpWcWxYU2FSR2dCbHoySGxSVTJ2?=
 =?utf-8?B?bkZnTjZQYlEvb3NYaTB4V1ZWUVdRMm1MSldvR3hJV1RZSTh6T01wZmZDWHV3?=
 =?utf-8?B?R3U0d3MxL3ZqRzBvNHNHTVpFQTNxWkRXTWtHN0NtM21kWVFzTkFscDNUcnBx?=
 =?utf-8?B?UG1MRTlINjhGaGx4K1llTDFpMFNyMU5Wek5TdS90TEhBQzFzN0JHT3cvYWpD?=
 =?utf-8?B?SzY0S2lvTW52WVVxdlkxTnNoUCtKZ3JTaGw0THNsTjlwM1NBQ1Y4ay9xZzZK?=
 =?utf-8?B?NUJiNmNDdng1ZE5vK1dzUGtFcEhJT1daRWxnNGk5aHIzb0RvOUFuUlBJdnNZ?=
 =?utf-8?B?UTd2MDQxWVdadDNIeGpsMlBsSyt5c3JIVHBPcld2REVwNjhPOWxrQ3d5MWJ5?=
 =?utf-8?B?aEVTWFB0QndwMmIxYk0yYWxubWM0M1BrRGdXdzczbDNuWTJPRkFrYS9LTmxj?=
 =?utf-8?B?eG5pd2NlWWVkR1ErWC9JbnAxbFdrSFJwM2ZWaUJCaEd3SDhZbEk1SGdGOCtM?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0e03c3-a0cd-4f75-fcfc-08dc1033d7f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:23:23.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kct1Z1s7G/muWbbguHXyLODhGddPiXq+Fu9MjA1krjEqXwRwUDieNgqnC+EkgaIGLCg9q4ltGnPCFFJdUePKZHgbU3yxptJ0N12bXvA4Q+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-Proofpoint-ORIG-GUID: Xl-tUjfYq5q7UjCGnzSd2vn21Syc7zRq
X-Proofpoint-GUID: RJDNYXAZE-D_BQMpY7iQ6VbV3aUFBvPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401080088
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 10:23:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15748



On 12/29/23 7:16 PM, Richard Purdie wrote:
> On Thu, 2023-12-28 at 22:06 -0800, Robert Yang via
> lists.openembedded.org wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> So that we can get the correct error messages.
>>
>> * In python 3.10.9, the error message was:
>>    ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>      File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>>        # SPDX-License-Identifier: MIT
>>               ^^^^^
>>    SyntaxError: invalid syntax
>>
>>    This is hard to debug since the error line number 4 is incorrect, but nothing
>>    is wrong with the code in line 4.
>>
>> * Now the error message and lineno is correct:
>>    ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>      File "/path/to/poky/meta/classes-global/base.bbclass", line 256
>>        an error line
>>           ^^^^^
>>    SyntaxError: invalid syntax
>>
>> And no impact on parsing time:
>> * Before:
>> $ rm -fr cache tmp; time bitbake -p
>> real    0m27.254s
>>
>> * Now:
>> $ rm -fr cache tmp; time bitbake -p
>> real    0m27.200s
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/event.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
>> index f8acacd80d1..7722258b7e8 100644
>> --- a/bitbake/lib/bb/event.py
>> +++ b/bitbake/lib/bb/event.py
>> @@ -257,6 +257,8 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
>>           # handle string containing python code
>>           if isinstance(handler, str):
>>               tmp = "def %s(e, d):\n%s" % (name, handler)
>> +            # Inject empty lines to make code match lineno in filename
>> +            tmp = "\n" * (lineno-1) + tmp
>>               try:
>>                   code = bb.methodpool.compile_cache(tmp)
>>                   if not code:
> 
> Looks good but don't you need remove the ast line number adjustment a
> few lines later as well?

Yes, you're right, the code has incremented the lineno by '\n', so the
following line isn't needed:

ast.increment_lineno(code, lineno-1)

Now the patch is: (Check lineno is not None to fix bitbake-selftest error)
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -257,14 +257,15 @@ def register(name, handler, mask=None, filename=None, 
lineno=None, data=None):
          # handle string containing python code
          if isinstance(handler, str):
              tmp = "def %s(e, d):\n%s" % (name, handler)
+            # Inject empty lines to make code match lineno in filename
+            if lineno is not None:
+                tmp = "\n" * (lineno-1) + tmp
              try:
                  code = bb.methodpool.compile_cache(tmp)
                  if not code:
                      if filename is None:
                          filename = "%s(e, d)" % name
                      code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
-                    if lineno is not None:
-                        ast.increment_lineno(code, lineno-1)
                      code = compile(code, filename, "exec")
                      bb.methodpool.compile_cache_add(tmp, code)
              except SyntaxError:

I will send a V4 add with a testcase for it.

// Robert

> 
> Should we put some tests into bitbake-selftest for this?
> 
> Cheers,
> 
> Richard

