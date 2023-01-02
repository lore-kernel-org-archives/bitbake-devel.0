Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72914C46467
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 10:01:43 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.44])
 by mx.groups.io with SMTP id smtpd.web11.32260.1672653702244401077
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jan 2023 02:01:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=JAjcDDfk;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.44, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb5O2NzbYmKDGPMsWhtpskwD6IdemdFDkq+TLZLB7gZhHGrlyzEQMeiCdPXXaEZeIPlnZJBzTgQ2pcuqKBzuH1+rENKNU0DFF6/4SQjRXKGdGZvVDuHrP1VBRXdCKX1ZP5QFAwGu9yBHRI1hOvvkNc56SpVc16s1QgLmBvWetiadVSVWMuLXXLUWh4PmWnS3bqCgLEsCcpLX6jnKZpTQmUeghtoap/sUnTmeOzWyb7XAv6b4scS6V4mPJn1Ds0IkWDxA9eL5WzM+AKGXXsEbIksW9TYes0AmIaH9Lx1V113IvEF9mCFkdnJ9cn2/p/pQjOodtZYqqEut5lfik1l7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D94ZaBAxTwSCn7pAsWk8MXU0vfcsHRJV0822TdLd6CI=;
 b=h6ZeIcpiydXJHjFgr/TGD7CUI60V674XrT71ILIJhE/M1gMINYJ+fOgCbLPbYdUmbgMkqDHjX0Gu4BNmV1fjY8FGA+bNw6XY1ot6j8xMdEnOADkwcSPmKgwFshverwMuuay2cn8rg118GB3TWgTq32dLcP/Na+kYqZCzcKDKtpMppRpJIeVcsG+DBspRWGreXCrymqYFPls7GgTsyCB3PYPZOihYtYNPj+Yc7OyRoLArE2iLlz2W2VLt0jcFiJ8viAEKQCPL8zlJ9Wj5NtYuSanQYgFv6D7Xd3L13ne8qMPyVicYgJFJyh6Ec2wtwJgPr8+E2bbH7Q1F9zlUXx3J9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D94ZaBAxTwSCn7pAsWk8MXU0vfcsHRJV0822TdLd6CI=;
 b=JAjcDDfkWYuf0uKmonIda+f1pZMOr54w1kV4ZZvOaZ2pvlkuwILltymqM5PelvdvAkBMASjYfR3X66dzZMQjlqihnxurnzUou3Oa90XevO8dAYeFuaoF+PbOIZoWo09szsJqkXPILhDOlquDByyreviBGn7Xu6daZAlQBfOrrxdHszUJbq4wyLbI7vFP+z9N7w/D9WcUb43qrb9Yn3fmRkY84iZ9Ad3xQZaN/m3PkPqjlko8eIfaICvlHx4eFg23T+X4aFPWGn1oqrtPBmC0EMLe3GHDHYvpAJeeFrbNVpzYnoxEqDOZanyyc6Gt2VqYBS8/UokItkHSeafx7rFzLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM0PR04MB6996.eurprd04.prod.outlook.com (2603:10a6:208:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 10:01:37 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 10:01:37 +0000
Message-ID: <b660011a-3526-3016-c3a9-0f7a6868f4ab@theobroma-systems.com>
Date: Mon, 2 Jan 2023 11:01:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Fix cache/reparsing issue
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Christopher Larson <kergoth@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20230101142509.1022073-1-richard.purdie@linuxfoundation.org>
 <59224516-17d8-4c43-9f2b-38c5034cfdba@Spark>
 <9d512b49ed3254cc9ef67f21cc1a0facdaff9479.camel@linuxfoundation.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <9d512b49ed3254cc9ef67f21cc1a0facdaff9479.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0261.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::34) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM0PR04MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea9c77c-2c8b-481f-5e33-08daeca85619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d5CYqDq2DVWocYXe80OSR3l3rjoGrwjdrLlM+dNRZsCUpz5u8C0mR1BTqmkReRy/Vi1wJ7GhDWNmCFxctg3YDi/ZnYDUoc23TesbSUcNeAjvMtiIT3oyyh2xOGMbSfSFtXLF08uXic+TWzgqJOixeOdcV+hXxY0A3sQKIwVMcozi4/p+z7Vh4b95qaPwDUmV+yoiQUaUmWxip4m3OdEQpE3uuohW9Bxb01jIjCXCEvO3dxulqDQF+cqSqgryBUUtrs3fzY8E3yqphLmdXVYA/wmTV/79ugYmaq7Q5kfV7aBaGtvZXwWECfWXIvtOj47yT548hys36a/G6DFrQzd1/r0yNh5m4AeA9SIEcWy+0gEEOxJ1Tx6pI1Q36MJOzO6PG07ZfeXvQkCpG10+8rEWTENJ619Hb7PkqpRe/XS0sRefD61qH01jlZTCOA2C9LnsaaIafj6tQOrIHPzwNRXDUCKmMCMnNIpP0IfsdlFDNbVdL5qJ/gXBTpjfzKV098s29Kr+6T6vsXz8i7rhO5zRldwixUbZ5vwJyX9r+itiR3KWjEcme4QuLP30qqPewflibH+M1qtzLwv7vTMKo8DyP9zVQqENaZwxEyheTq28HKaVSAmxmMcUSrtgjmshRS1BOXtJ8PWUTR4zl9IY+We+vzeqY0M0fogtptnJoPmuLZAmJhvJkeslL2pLZGFQ8z9EMZ1uvmeAPjrCi/GOljXxAz8za2IuCJ9pDbFyCTOYDcnw+3vGmRwzZKC93L8cBrfneUbaIRbmZlIT922vPp6aID3yQBxReY1mnODRv9vR8zs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39840400004)(136003)(376002)(346002)(451199015)(83380400001)(186003)(6512007)(53546011)(6506007)(6666004)(86362001)(31696002)(36756003)(38100700002)(2616005)(31686004)(8676002)(41300700001)(2906002)(5660300002)(8936002)(44832011)(6486002)(966005)(66556008)(478600001)(66946007)(66476007)(316002)(110136005)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nk9waUMrVmlubUJXeko4ajl5azJkVmdOUkN4SUFlR2llYVA2V3lBa0lFcHZn?=
 =?utf-8?B?NlJrd292c0EzQ29Udk5DWFAyWnExQTB4SkdJUWVkdWtFNWorRzBtejN2dU9V?=
 =?utf-8?B?L3gzTHZTWjJXZ1NKc3FPUlFHRy9xNFJNM1NwZXMrajh3Z0tNQ0V1WGJJQ0ps?=
 =?utf-8?B?aFQyUkZySHpMY2toc3VJZmJnQ1d5ckIwZWoxRzF2ZktRQUdUekZmVDBlU1d4?=
 =?utf-8?B?dFNPNVgyczlxVmFWWlJLRzVNUGVqbTFNT242enFia3czdmozZ1JtMXdOV0tv?=
 =?utf-8?B?TE42ZTA4SGRqU21nUVpqaUFyZEdSMGFSbEsyOWh0cU9JQW81WExxZmFEQkNL?=
 =?utf-8?B?MGpxRTJrc3EzL1F3R1U0TjFTZ0RQcFFXKzBQUXRHWGlXeHF5ZUtwK0FUeWRy?=
 =?utf-8?B?NndmdE5uM3lQcVZRakhEb0RwRzlxZkV6T3Rtb1kzQlEySWZNSG5maEF5cEFx?=
 =?utf-8?B?anJpcFhpM0k5d3lqdFhQRllXcFZmMXZPczF2QjE1UzdTeVRURGI2a0xORGNj?=
 =?utf-8?B?bFgxTnN3QmFWTCtPci8xVnNGcXphdDNEVmZhNE1LYlkwamZjbnh2a1JMQWJu?=
 =?utf-8?B?dUJkc1RoaWUwMXBKYlZ5MmZTSzJ4TVVrejBkbTZySkphNHJ6UDNZRktlTnRs?=
 =?utf-8?B?RUg1UjJmZTdURkRUYTBBeVhVRXVJNzRHQ2NKaktwTGhTOERRTkhJL0tKQjRI?=
 =?utf-8?B?MTN5NlpOS3U2MGE0Q1llT0NNRmkvL2dja29CUkdER2NUSnpndHFSa2JyakdH?=
 =?utf-8?B?Y0d1T09RVzIwbzJmK3hPV0g1SkNSMGV5bDhoU0xrbkRVZFllMzRpUjhKYWNI?=
 =?utf-8?B?K1JWcEVYY0MvYlBaelVlQjdrZDRSQVFHczg1M2hZazUrT3Y5bnJWV09PbTR3?=
 =?utf-8?B?cWlFaDNxWWhZaEdQU0M1Tk0xeVNKZkQ4UDhjSVVKNzBkWmk5enVBaEthOTdJ?=
 =?utf-8?B?QldXUVYyNHpKSVZSNXBYMFlydlNmNzJyMVlKYTg1KzhNS1k2aDZPY3VRSlpw?=
 =?utf-8?B?QndDcTFoY1ZCL2NFWmxRb2ZyaGxPRE9Cc2dheWt6aDJJa0pxSUhMWjBqOCs2?=
 =?utf-8?B?TFpyZ2JiWVpWVXhGc2Q1dmxGd09pNjhQVVZ2cW9BcjdMSG1qYzVDQjdmRHk1?=
 =?utf-8?B?ZkJRTTIxTEg1WGlMTHRoMnAwWFJPVExyQmNUSEc0Y0VyYncrY2V2ZWh4TkVY?=
 =?utf-8?B?OEFPcXI0OC9pTWM2R0xUYzlEeEpRUDJsWlFBeFN0dnJ2dFJBdTZLUWJLSkIr?=
 =?utf-8?B?b3pQNEhEalBRUmY0bEhnNFRWWkgvS2M0VDZXTG80QU5vQ28yUG45WU00K055?=
 =?utf-8?B?YnVBTjhjSUZOL3QrdDFCaEd6M3cvSWl6ZW9vMzlCWS9IOVhpL1Y5RUtyZ2Q5?=
 =?utf-8?B?eTZEeHFUQWZ2WTYvUTZVV0VZM1MzWkNlcUFWeVl5TncxUytPcDkvVnlFOVRX?=
 =?utf-8?B?dVNSV0lzM1VOckw5dlV0QlFIcEs2bktqTENETUNyNlgxb1lISTJobUZ3R25z?=
 =?utf-8?B?bkt4T3lvZ2tXVVAvQUI2RmV4b3A0QXhvNlE5dVh5WXliSUJ0Y2tJV2YwRnk1?=
 =?utf-8?B?SExLdlBxTnpRVGx2YmhvTnV6cTBqQWhzQzZZMEFvWmNTV0M4MC9lQmxUaklh?=
 =?utf-8?B?OVRWSGZTa1labTlKWHcrYVFDeWZEYlpBWTJGMlhuT3Q5b3hzZmpkT0pvYlFU?=
 =?utf-8?B?MFVxanJBQ3NxZFprZUVPZ0hTTVlJYmZOU3NKUHdjRFh4cXdOWitmMWoyRHly?=
 =?utf-8?B?WGgzbmJaU2tBeS9xNmZNWjV0bW5nRkhkVk1KWmNBdzJKWW51VHorSUdZazhx?=
 =?utf-8?B?THBTK0hZNEtKbkV5NVh5QWFQNU85dldFRnJRNUhQV25adm4weG1ZMDR1azZQ?=
 =?utf-8?B?S29LUkYwOEJxLzRtaU4vMG9iNEppeFdLaldKbVVYUW11eUF4SmdnaTVUY1ly?=
 =?utf-8?B?ZDF3Tys3OVFUN012alNTa1hxamRqZXNmS25SYlBiOFV2MlIvNTQ0RlFaSWZY?=
 =?utf-8?B?ZmFhZUtlMi9QMWRsWEtaSW1VQXdHMFZrTy95ZWgrZTV4bmhObzZPSmNLQXJn?=
 =?utf-8?B?MlNYc1F3MHA0eW51bWwway91VU1tZDdWR2ZMTVM5d0JmYUMrcndmWlpsVllz?=
 =?utf-8?B?aGFnbWpWWC9WV0NMcXArTFpQY1R5dVUwS0NDVDRMMWFxM0dwTGgwc2RBVWVF?=
 =?utf-8?B?ZFhlMGJtSitPSHVGcGlURThGNFVjV1pKT3JtN0poRnhMS01NSDI3WXpDZ2VI?=
 =?utf-8?B?T3FjQWNBOTlORmVqUmZyVUcvK2R3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea9c77c-2c8b-481f-5e33-08daeca85619
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 10:01:37.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buPLRvpMdePfagYvqmIUNWuStorTnqyqwj3VspkAYVfn+6EyjpyrNl9mBI3JA8GDpG9AN5vH0oOrbAAFfNp63XgcGSxqYLPGM+m1g8O+EWd1GcJrWr0L/qOzrWnD9XRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6996
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 10:01:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14276

Hi Richard,

On 1/2/23 01:50, Richard Purdie wrote:
> On Sun, 2023-01-01 at 09:55 -0700, Christopher Larson wrote:
>> On Jan 1, 2023 at 7:25 AM -0700, Richard Purdie
>> <richard.purdie@linuxfoundation.org>, wrote:
>>> When setting the LAYERSERIES_COMPAT and LAYERSERIES_CORENAMES
>>> variables,
>>> we need to be deterministic. The random ordering from the sets was
>>> causing
>>> unexpected reparses.
>>>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> ---
>>> lib/bb/cookerdata.py | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
>>> index b4e0c4216b..8198f509e2 100644
>>> --- a/lib/bb/cookerdata.py
>>> +++ b/lib/bb/cookerdata.py
>>> @@ -425,7 +425,7 @@ class CookerDataBuilder(object):
>>> data.delVar('LAYERDIR_RE')
>>> data.delVar('LAYERDIR')
>>> for c in compat_entries:
>>> - data.setVar("LAYERSERIES_COMPAT_%s" % c, compat_entries[c])
>>> + data.setVar("LAYERSERIES_COMPAT_%s" % c,
>>> sorted(compat_entries[c]))
>>

compat_entries and layerseries are sets set just a few lines above. 
Would it make sense to actually have them sorted directly there instead 
of only when they are used?

https://git.openembedded.org/bitbake/tree/lib/bb/cookerdata.py#n418
https://git.openembedded.org/bitbake/tree/lib/bb/cookerdata.py#n421

Cheers,
Quentin

