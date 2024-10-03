Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3CCF857C
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 10:42:43 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.92.49.53])
 by mx.groups.io with SMTP id smtpd.web11.8341.1727952158801002526
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 03:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=CGQcCrfX;
 spf=pass (domain: outlook.com, ip: 40.92.49.53, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWh5eNd6uWLRbJ0GiKJzvG+xXZPCGp+3T6JWUJy1EDydJbjXSfvv8NMLZM7h75GpnszlGjgFFCWTeJ+Seee6wYj5uiTBTkyhI8F1/HlwqdBlgT9Jnk2KQHyaDZYfMo/3OS2eqVdSHnghsZp3WuMi+RUejQF73G81wp2moI0cS7H1RYGIyTbro9ANW1dGwqlG25Du+VAkPAWIGBQ9F6d1Gn9JdS268y4foDtAi3yn3BlpoGaXYE8LJ0okJnuqWdOxzJ2lIQEUjqsLPvFJsut/iAiQwl+++raYpLwQISeYTUduYcXaPIqdAQaGYRheAYRJ65iGsi8ty6oN+pegrkRG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/eug3OcTSzZX47f3oFs6ao1Se9c2rJqrK/vC4PSRG4=;
 b=MIjJ71MoQkUnaiJ+j+f1qtJVme0wSqKfaAgfHcv8jLavuEaicS12UwjI6ReqVqzHY2+RM0USaAmGNGpewIVdixZIExHfpP8VUk9SX7JdoCD8mOlCKxxybkcnzqu8rbS0gzTQ0EamlIVA5ywZBXW5vyN0Hp+e78pYexSh8t0UD9hYK2MgXyJDHKXip8UPFzV8smsCRZ3aZmfosUfGoEXWiog4lncYHDrlN2QbHh8XOpFMX87+pUDbV4QHIuZEOwjrvd/2UjXrV2KwLkfaIb4EVQmW65W/vYu1X0PjKGGTaK5f0rQ2wvEbMyWlM0B037NXsEg7sH0Nh0D8FAvHAtTWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/eug3OcTSzZX47f3oFs6ao1Se9c2rJqrK/vC4PSRG4=;
 b=CGQcCrfXE1FakO5yC8/N67fGP5EfmJ5FzZ3rkOdhbN7g0IfZSIQSkyePjlljxOnNBRDCcpWvk2YMV4JBLNJe88O41XDzbcA+WUlKHErCzpx4jLQE2G05wU8TGk4790yvOx4BXyfjQ6Fr0QKxSd5JWVz+BCN3wTrp50nc84P5+m1yGYRjJkGf19cUbuLrmngR/VPeV3L2X37FtKotuZWuxp3Xp20EZYE6bcs4YnYCH/ZWYLp3IUHjxtNh0KaelUgCsznFxDIBgrYdAUhkNIidYVgEBjtuVFTCfvlhaGYvxrn1XwjbYk9m9qz7iIpKTxCMHL2KlPhE1N3hIdprG5u/8g==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS8PR07MB8022.eurprd07.prod.outlook.com (2603:10a6:20b:39d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 10:42:35 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 10:42:35 +0000
Message-ID: 
 <GV1PR07MB91207EC212AD0BDAB41E9583A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Thu, 3 Oct 2024 12:42:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v4 2/3] bb/data_smart: fix override syntax
 warning
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <GV1PR07MB9120D47783B36E780C1BF012A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <DB5PR02MB10213CFBC40BA9DE6FD9320B3EF712@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <DB5PR02MB10213CFBC40BA9DE6FD9320B3EF712@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0460.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::21) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <2489bfd9-04bf-4490-b832-3001913b660c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS8PR07MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa7ed85-6c6b-499e-bd44-08dce3981769
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|8060799006|5072599009|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	3fq98KywlbkQvoYJuN2jYBKo9OvKjHgkYWy/4qDiLXioY99YLt8KHC/aZo9R+dCA1QxwdNxzNmN3yAtOX06ll/opXMCOJI3JBUvantwOzW1/wypx4pkmWtZy5SviXid2yx8DgJ1IAwUwcXsccsuVjkupmDpynrYDMwfmqoNMT0xYyEveR2iuJStzMMSW6ObDIdOH/r4QrrBoHg+S1/M/3aZxr8LNYEN7hibhK7w43qXd+cDoVFuP7Jl6e76QX6NSpzfS6i2efjlGVToq9Zmsvll2tnO+Dq8xV1KeIIt1nMG7QpUlEvPTtOA8JOsnEIAgNpFW2lfmuY2xj68tTUrnU2IoCPiHaZmzW1KS70A8x9wqOBkIsmTihlDHhaqsVFaXOfHWYhqnFHswt9XKB7eedME6i6wPwo2HVaJwdd0NGHP+nWaHq3cLvKmo50ShMjRA/aKwtGwAkmuVZdJF7NTVoFiw9GVHRraAeT6SrrS2jmL5dZ3xXyaNV+lz+faggKdXxWMb+BmBJPUS+DUfscJSy3QPFEoA5lZJOesx4NY6fBJG2BSesaPvTlLribkTIzWdlq3QXZiHZsnEZ+jCw4IKIbgZpRiJl8UNU5IetmhS7pAac7b8afqp5CohsTnj5l/GMWqjxHbyHXwt3gl/aSJ4pcRggmg2Tzaw0K8BtdT+4sw95aeBfCqgXGoQuvp19n+BudbcEemo8kYhCJaOD9F1dg4KUz9B8iCto1raNYqD4S4c1rt2WQHHchBsoiPP07fPd5xT7h9p+1VZ6inVpZqjbg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnUzc3ZsT2dVSkNsM2l1aityOThrZS9FNlU0K0M5QWFEb1VTSjJKU2dxbVp1?=
 =?utf-8?B?ZGQ0YXRrRnJNU1h2enA2NHFmNkJubmtuNXNqZXFBeXhOWm8wNDlYMXBweExP?=
 =?utf-8?B?d2NqNnlsczljM2h5Mm1zSXpxeFYzUGlEajhTVFEyMmJWS2VtY0NBaDg4TWs5?=
 =?utf-8?B?NkNCbW56Njd1SmFlYmhPRlZsNEMrcmJrR3YxcEFndDdNUkwrdHBBbm14b0xV?=
 =?utf-8?B?VldMcjkveVl2STZvbGZ1cmRDanhCdGlFT1UzeUJoeUlQSVRmWjdWaDlGR3E3?=
 =?utf-8?B?R3c2ZVlyWkl4TWZUeWtrSDNLdDluM3BrWGpvdyt2dDR0NzJ6WThCVWZpS2hB?=
 =?utf-8?B?ZUF3Y3Iwc3FXZXBlcHA5TzBsU05JbmRRdGhWZ1RneTdVUURvSTZ3eXdCMEVS?=
 =?utf-8?B?K3hoZVhiYlZWY3FBektyRDZ1WVQ1VUNDdGxVZTVJRVdmbGxaWWtLT0gxcC9O?=
 =?utf-8?B?N3Z6WDUrSHlzZS9MWWpjTzVPK1lLMm5vQmNPTnFRVTdZY0xMTzZTN2xmcmls?=
 =?utf-8?B?WDNaU2s1REJHc01wNGp1ZHFyZElNVUQyQmpQZzdaTWhZanM0MUV1SUtncUlY?=
 =?utf-8?B?M0NMK3FLdVdqYVE5TGEvd2Uzems1OVBlTFNId3ZVdGdlelg1MDYyblh6YVNM?=
 =?utf-8?B?ckJ4aXFIRy85YjFZUlY0ZUV4R2Z6VENZcjBSYUMvditOUXRLK2JEZm52SzBQ?=
 =?utf-8?B?Z0kraWhoazVMYjNNRXBESmsxR2NnSzVvVmFoanVjaXRqaGtmRUxmTnpDOENB?=
 =?utf-8?B?dHZMZXBsSVFZVHJFOWxhUDRtRGp0ZHkxTEEyMVdLV05OSFRvKzBKTUpuZFVI?=
 =?utf-8?B?ZVBCcmRkUk9OM2JRU1MvSUJ4VVhYblJBVWVYMzVzZVVneWFLR3FabWNGdTk0?=
 =?utf-8?B?NFZpSEh1Z1BFQ0h6NDFuVFRSMnVQT3dqeUJkc3VWVFppZXRjWVZFdU5UYUc3?=
 =?utf-8?B?Zi94YlRvcWFRZXNob01WcE9jelZnb0hvUzVKVnFrKzhROWVxbDh3MWJvVUpY?=
 =?utf-8?B?ZUZXeFNVTFp2OWp4MFhHdWxXcXJDOXdnUTEzRGVnTDdMakZZMDZZNUNHL2ZP?=
 =?utf-8?B?QjZ6aElwRmpXL1BETnNjSFJqK0h4RmdjOXBmVXdhMVJRTmdhWlBWSjdLaHNa?=
 =?utf-8?B?Y3NjS0dWMjZickh5dUdaV0VoZ2NYbHRDM1RKbmRJbTVpQUtQVk04VmEwM2ph?=
 =?utf-8?B?OVlhTTJQUjNtRnRmT3pqMVVDWmlSN3VIRExaZVBVT2ZrY0RnaThUMk0zQ0wx?=
 =?utf-8?B?dVZUZEJyM0VVdEJPV0JqSUlKckg2Wk9lZUR4L2F3ZTFqRnovSm5SeVdMWFR6?=
 =?utf-8?B?Nk1QeHF1WnNzQ1YzWGtROWIzWi9HVThmUWRrZXlubUtueXdrbEZselF0K29U?=
 =?utf-8?B?NzJReEcrTTBBa3lTYzhKQjlaaW80cjkxcEY5RUhSbkZ5aEdKajI4Z3hhczRx?=
 =?utf-8?B?aGgrZk4yWUhWeHJRVEwremNhLy9QenB6YmhNWlN0QmN2cElIRnA3bCtZRWdq?=
 =?utf-8?B?T2tYQ3o0YjJSL2I4T2ZSNHJKQStUaCs4aGJ0SElqazlSUmlTZkdya1YyOE02?=
 =?utf-8?B?V3JETlA5cmpxWXRxTGQ2VE02dDdqSmNBS0VJR0VYT21UUmNia2lDU2JXbU9H?=
 =?utf-8?B?eldJWlBYNHhkY0lTY3NEVzRjUXVWUnlsTzA5ZitIN05lelFrNjBHNWdQdzFp?=
 =?utf-8?B?eGcvSW5aRVdXMUVha3FKWGVyMW9KQmRMWWEvZVlyKzkwc014Ni96NUtOWU9s?=
 =?utf-8?Q?ozQq298V/vDK3O/YRE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa7ed85-6c6b-499e-bd44-08dce3981769
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 10:42:34.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 10:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16633



On 03.10.24 12:30, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Konrad Weihmann
>> Sent: den 3 oktober 2024 10:13
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH v4 2/3] bb/data_smart: fix override syntax warning
>>
>> when defining a function do_removesomething,
>> the parser warned about
>>
>> Variable do_removesomething contains an operation using the
>> old override syntax. Please convert this layer/metadata before
>> attempting to use with a newer bitbake
>>
>> correct it would be to search for a override operator at the end
>> of the string or for the next operator.
>>
>> To avoid running the expensive regex search on every setVar call
>> the current "cheap" check would be have to be triggered,
>> before the more precise check is run.
>>
>> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
>> ---
>>    lib/bb/data_smart.py | 15 ++++++++-------
>>    1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>> index 4e15a43c2..bd2716b2b 100644
>> --- a/lib/bb/data_smart.py
>> +++ b/lib/bb/data_smart.py
>> @@ -35,6 +35,7 @@ __expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+?}")
>>    __expand_python_regexp__ = re.compile(r"\${@(?:{.*?}|.)+?}")
>>    __whitespace_split__ = re.compile(r'(\s)')
>>    __override_regexp__ = re.compile(r'[a-z0-9]+')
>> +__old_override_detailed_regexp__ = re.compile(r"(_append|_prepend|_remove)(_|$)")
> 
> While the patch is no longer line broken, there is still something
> weird happening. All context lines seem to have an extra space at
> the start of the line. This of course prevents the patches from
> being applied. I tried to apply this patch using:
> 
> b4 shazam -p bitbake-devel GV1PR07MB9120D47783B36E780C1BF012A8712@GV1PR07MB9120.eurprd07.prod.outlook.com

:-( - I'm officially given up.

Someone else can pick up the pieces, all that is simply not worth the effort anymore on my side.
Will continue to use my out-of-tree patches.

> 
> //Peter
> 
>>
>>    bitbake_renamed_vars = {
>>        "BB_ENV_WHITELIST": "BB_ENV_PASSTHROUGH",
>> @@ -539,14 +540,14 @@ class DataSmart(MutableMapping):
>>            return var in self.overridedata
>>
>>        def setVar(self, var, value, **loginfo):
>> -
>>            if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
>> -            info = "%s" % var
>> -            if "file" in loginfo:
>> -                info += " file: %s" % loginfo["file"]
>> -            if "line" in loginfo:
>> -                info += " line: %s" % loginfo["line"]
>> -            bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
>> +            if re.search(__old_override_detailed_regexp__, var) is not None:
>> +                info = "%s" % var
>> +                if "file" in loginfo:
>> +                    info += " file: %s" % loginfo["file"]
>> +                if "line" in loginfo:
>> +                    info += " line: %s" % loginfo["line"]
>> +                bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
>>
>>            shortvar = var.split(":", 1)[0]
>>            if shortvar in self._var_renames:
>> --
>> 2.34.1

