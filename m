Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5136CF9C69
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 14:36:04 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.36])
 by mx.groups.io with SMTP id smtpd.web10.38121.1727102157972388387
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 07:35:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=FAZgfVu0;
 spf=pass (domain: outlook.com, ip: 40.92.90.36, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfkZHLhMODiPcT9XEfiYMFCLQPVrjEhbbdp1rlc5wjGUBUQqAkx16PpWZxlq1twPn7SKlbrGv5GP+3AQVFlnbJMrvxzBmnVKo4aroePm8COcNzefZt6YfeTyPX145yg+DpiDm2lRY410SqZV04ojImMsFReNoyv0pAdDWf09vKiIOZmiqLsajWC7jWHf1CIabmNULekz1Wr883DrLfpm51NcvjCsM5C5mOd1PBqCm42yKWfFYBzZkgSadLuNkkbdrsce66j00o4+x767mISjriAiGq4S4atNCFaEFj59YuIYvDlJGMhA/PPeWFgvS8JWDcj3u5hmuzqlez8azkuxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE+XHjTuJP7cPSNiqywbsWfJS9LTvzvLz3CY8YSvelQ=;
 b=IlLZoVKThVK84wyIlh1i+jrhUYrCyk6b192ghNXFg5BmWc3MFrGGWjasPLZ2ERQOakfLViUfb/zGcuMvE6v+7HdVVEQHT97WiIPvgr2WCf4mHNvdAScda4qd+02JTQ1QAZmTqjvo/SO9sDovtxKKN8zn/TVl/FXxjcwA7HXDHRweP6HgINMJar5PpofYxeUD62A1JDqkHo1MzvHpSdvZGlLlIafcFAHrw4TCHkwi8loa3p5YCWuOsFFTwi40auLURceZZWj1SpeOjhWTgYLSv98WUWRmzT02PuR7T1DFwptRWLr00cnCOVxNDpJ2285jnm0381dlV8G5c9+PEEkCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE+XHjTuJP7cPSNiqywbsWfJS9LTvzvLz3CY8YSvelQ=;
 b=FAZgfVu0dMn4lMoJOXrfQQgd6qjqCFbENn99CCoafB6mQJJQtxB2cjdAxS2vKOoncp9SW9G4LNxZw7NJv47dADe72JBkMr0XWmgiqvoAfWzO5MUs2phhMlMB3J108gT5lRHVm4aKYiSUKeaG2076uuYOKhfO8SkQibqcYYw5VcCARuY3IOYPMymxCLkOrlSPmmsz+gCd+3L239UpYLFpkIZrgCLQKRbko9WOMzERtMtv5hzGftVVldwFtQLQDBm7WkGgx6lxoCrlpKfv2LIyFRaRbr2woaY6VyVv6Oy7hHv0K8ydIy26CMrSYGewFppDb9qWtjeX2xr6vkjcWS63Lg==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by PAXPR07MB7821.eurprd07.prod.outlook.com (2603:10a6:102:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 14:35:54 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 14:35:54 +0000
Message-ID: 
 <GV1PR07MB912070578293398A70DD8198A86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Mon, 23 Sep 2024 16:35:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
 <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
 <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
 <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
 <b69d0035-b4a2-420d-8ab3-d9df94f119d3@cherry.de>
Content-Language: en-US
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <b69d0035-b4a2-420d-8ab3-d9df94f119d3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::20) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <c43bf344-76fe-4ff8-b7f6-97fd5205ed20@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|PAXPR07MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: a21a1884-c3a1-43c1-0462-08dcdbdd0749
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|8060799006|19110799003|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	1dvDW8xmOTdY58V5n6uKMryQ3EITsPGulI+bZAeLSwyPqF4HnDCf5U3lRXQ3X9lvqYXBT4A5b5lUlQUqJSZyDrC83KWbsSGxqf11mm+IMtcjjjy0NQxz/2EmxOzWxbDE0zRWkogUiwEKG/Dtj/usHDvTnifKqGIiVZ4YujlVkl4+kZizo/8KtpFBfs9DoqTAyA4DJWaqB32qvbgWkH8OZTOhMTKokXJIQykyIRmRNjR8gBX+qDdPojj2R8aHP004ZibLaG7/a8qKBg4FluJbWrqvgT1+OVO9NZmqxJ43ZiNkGKtVS272ptcJkY4qMz9y8/AQ8uYUAmyC1zBXieVasKD0TQTNMAzuvW0o+aXNl1CCAC6G7zkN8GyLHR2UyG+q0j+wNjRBrdhJBz/s8Zau1FoGcAZBaRY3eZpj4H2rHGRJv78G8ZCMKL2oIaiI+NMDGNKqS5/Psa7O0KV++1imusQFVv4Daz++uprEFTrZKlbIEP7ew6BcQ+RnFlH5kGCR5ytIX5p0e8KDoXZZhPhnMlB1smuxT/O/UyKdK53if673aE3b+3oqCRQnd8MJcib/d3z9W3vunsV5abMQK3rKlPcTyLYga51gLVOxqRTtrfjk/OJuYFxkzYXL4XAW3XPWspj9/uhEJjcr+bqaC0RHBGVyPt/zyrtXZJQ+el3mt4I/cfjTRh+8ovJ2VLOR+y9fL/gc3ex4kx1uuvG4vM/NCgZ59x3ITW+zcvx4z+oGfTwHh09MjjsEGr4f+u1OzA9+tRlY4Yz/5LDvbAIOhj51Fw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejBIY3NWMm1Yd0VDRlZaMGYrWTdwK1owZFNTcE05TnRPZkk2UmFkdzRhcERj?=
 =?utf-8?B?NEVOekVVckFsSWdlTVFRS0UrT1RqL2U0dGkzQ1BZSndpWER1L2x3aTJGWUJk?=
 =?utf-8?B?UGd5YjR1eE5FSEh3UlZOU2RYbWM5R2hXRm8wNGxYcmhoVzdYT2dmNEphQVZk?=
 =?utf-8?B?NjRnR1JjS2ptZDdiQ0wyYUxNNHJaR2h4dXJwUnBSVmZLaDRLb2N1blNjcDJ6?=
 =?utf-8?B?WXNhbmxQSGh4UForUGk4VGJydm80dEdrSDJjay9JT2lzWkJXWnJXVHdRSEtl?=
 =?utf-8?B?QXIrNGU2bzB5VkRQSU0wQmJReFpKUHlHUndDMy9JbXltVVlWTDErUVc1cWhZ?=
 =?utf-8?B?Zy9nRzBVQk1NaEdCRisranA2QTYwQWRjY1RxZytObXU3d0x6TTFYZHU0bjZr?=
 =?utf-8?B?LzJOS1g4aktjOE5JckhwWWNQSHdRd1hkaFJwMWkyWHUxYjJsTHZsU2xMdnBx?=
 =?utf-8?B?YUdOb0tva1g2TUNjRXZ0QVE4aVYrR0dVSzdCZ2V5VGx2aEt0eXZiZEJGWDRh?=
 =?utf-8?B?SS9Pd0xCUjgvNmcyTTdlS2d5aWM0Wkd5T2lqYW9UMUZtbU94dVJ0OGtSVFM1?=
 =?utf-8?B?RTM3bktMQ0N5anRualkwNGJoSHpwL2dYamFtNDBSaGxWN3N3QlRCVDNKTDdU?=
 =?utf-8?B?OXZFQW14U3ZwQ2x0Y2RWR1RIb2ZBU0pHZVVWZmVJSTNJL1ptdWpJWlU3WmIw?=
 =?utf-8?B?L3BBeTkwc0dWNFRXeHE1ck9ZR1g4Q21taUNMenRCQ3F1aFZtaDFTQk0xbElB?=
 =?utf-8?B?RGovcm9SeWMzOXcxU25Dakg2MUR2UWZwSC9QeFVqblN1V0M0c2loL2srVEx2?=
 =?utf-8?B?dVM4N253d050V3RqcmRGcWIvWDRFcktsNzJtOVAzcTVxTy84cWZNU2VyMGVt?=
 =?utf-8?B?SFg5ZHprUENvc1dXM3dYNUp2MEF0L281Wm1jWXQwOHBIVjJTWEYvaDU1WlhK?=
 =?utf-8?B?a2x5TzEyR1lzQjhPTi84dklZeE5VMktuY3VpU3dVNkRtL0Y5U1hLa2s4dXJU?=
 =?utf-8?B?OUZtRjJteCtiRFhUamdhN2tlRTEzZ24rL0gxQlRyK0szNStRWDlPb0RFQmFM?=
 =?utf-8?B?QUdrcjFXU05jMkZRRFN4NVJ2bjdDQmVGNFFnRTVKN1RLUURaQ2xLVlVYdzkz?=
 =?utf-8?B?SnFwRmd2TWppaTFnVzZ1dnJmT3UzbkxNMTdCZmIzVXZNa0IwL3FyVWlNRDBa?=
 =?utf-8?B?NlN3T2sycmVHcHZhekdzQ1dPcitRYlpIUXl2cXRDOHVGYWIwYURySHgzdm9R?=
 =?utf-8?B?c2VGSjIrdWhUQ2tJR1hKWXEyamF1cDMrZTB5Q2tERlJqcUtScWZEbi8wNkZX?=
 =?utf-8?B?dEg0NXhKY1hKZ0w2RUJLZlhoSHdCcU1mTWFwa25PTUI5NzFvaE9yZFVFcER4?=
 =?utf-8?B?aGNIM2VuYlJYVmdpVTNWcERkdm9tR2ZCbndBUDVNYzE4VnUxdktlaEF6cWpW?=
 =?utf-8?B?dnpKLzdBU3dwZW1hdzQzbExJLzVkMzNsVCtYaFFsMkc2MTB0cHFmbXJOUnZ4?=
 =?utf-8?B?SXRNeEdaQlQrTXRwc3FIdnE5MitxVzhlbWQxMDYzWDBpeTBNVk1rVkNnVFlv?=
 =?utf-8?B?ditoaE1EZzBqRFdDWllrd0I3NUtkbFFpU3hzMlhXNzNFNDVhQ1Vvei8yOWMr?=
 =?utf-8?B?USthZWJ1TzduQ1drbFFqQk9jM1BvdjhoVW9ROWFFVGFmbFVpYnMrZXhhd3RN?=
 =?utf-8?B?NDZ6dUF1MjBua3MyeW1xYll5OEgydE1lTS95S1lrb0ZON0FjUEU5NHNwOTR3?=
 =?utf-8?Q?JCDiA2II9KxOtdQbrw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21a1884-c3a1-43c1-0462-08dcdbdd0749
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 14:35:53.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7821
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 14:36:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16591



On 23.09.24 12:56, Quentin Schulz wrote:
> 
> any(x in ("append", "prepend", "remove") for x in var.split("_"))

I ran a test with timeit (5 repetitions, 100000 runs).
with various ways to implement that check (not all of them perfect)

here's the code
----


import timeit

pattern = [
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and 
re.search(r"(_append|_prepend|_remove)(_|$)", var):
     pass
''',
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and re.search(pattern, var):
     pass
''',
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and (var.endswith("_append") or 
var.endswith("_prepend") or var.endswith("_remove")):
     pass
''',
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and (var.rfind("_append") != -1 or 
var.rfind("_prepend") != -1 or var.rfind("_remove") != -1):
     pass
''',
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and any(x in var for x in ["_append", 
"_prepend", "_remove"]):
     pass
''',
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and ("_append" in var or "_prepend" in 
var or "_remove" in var):
     pass
''',
'''
var = 'do_removesomething'
if not var.startswith("__anon_") and any(x in ("append", "prepend", 
"remove") for x in var.split("_")) :
     pass
''',
]
setup = '''
import re
pattern = re.compile(r"(_append|_prepend|_remove)(_|$)")
'''
res = []

import statistics

for index, pat in enumerate(pattern):
     print(f'Pattern {index} = {statistics.mean(timeit.repeat(pat, 
setup=setup, number=1000000))}')

---

and here are the results

Pattern 0 = 0.6844888394000008
Pattern 1 = 0.9764905843883753
Pattern 2 = 0.32475767740397715
Pattern 3 = 0.3955688206013292
Pattern 4 = 0.5456381111929659
Pattern 5 = 0.17395127240451985
Pattern 6 = 0.5362491855979897

"Pattern 5" being the current implementation.
"Pattern 6" your suggestion.

So I think the penalty of the split will be way too high

