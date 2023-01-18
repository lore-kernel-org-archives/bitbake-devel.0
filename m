Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA6C38159
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 10:17:53 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.82])
 by mx.groups.io with SMTP id smtpd.web10.11863.1674037070031033713
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Jan 2023 02:17:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=XAF/WVZi;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.6.82, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPHPwkDqPmNzLlTdw9eqHIz7AaTusrwjAIPFtFo+V5nwNv1GG/6KyD1hP64teWi6BKr5tHYq7/jZLWuQLcdl3CBgahnsWKfP+7dBKlnfA5+KfjvmsEWlrQoVAnN+RPMrUaHI7jpeskK9DxTHojfszrfnzjnTEsCT9kfCzAgguvbLTf+HLvmnCdLsM5xQOIFjleURswl3bnykIiPf/8Y+9jCUMF37vQMQ1hdC0C4l/GFUFVf4h28dI1NjJP/Hlst8hgVKl0eagPXdiD3mzilr/l6rh6slGFemT6IG4ft2hLAOwc3k/AY2AHNkqpyjBWt/r5Gpd/M0PL1ckB1EjX+syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj9WYQyX6XA7prKVvoboBmxS7SsRbN3wGaEPVVRXJfw=;
 b=jlEnDjtmh6G971yAmoMbN8IRfx0rAesuSNHddbKO5wD+KPhWQqbUvaWouiRW16S3UbdxotHGoafIOg+xu1YMbQfI06pyIajIFzYJ7di5gtZUhopBwqkhiW78ZpRkPMrtZNi2OeYSsYIcpI/efphq5lRAHWIf5NqZzHY/Fp+zVPP7sXwxYYP9uYgMXGg+o8otnBdv43QVAu4SrPo1ArMsCJaPXXxFNAIPAJmkELgcQ7yBBd/pjb9x8DKgP4E2eyEs4NmojkIMvkgRsNJm/tP+w6YxdphofMEmsR3S5Fczq0B10W16etzVOEcKa2xmXao4DxXuX8tdtfZYT7rxOcMB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj9WYQyX6XA7prKVvoboBmxS7SsRbN3wGaEPVVRXJfw=;
 b=XAF/WVZi+SCzc91wcY4Z8PCcBLHbSuRDXivmzUi9z3A2EVrmd7czo4Wbbo7zIBxxlkmNBckjf6hSnaIgZlaG31+cGRSpPKGC1c3QN1weTP/viBdIizAllNj+QvA7RnevgdMOZtynE0KVGvSQ/bQQE/KaPFjEvMNgjiyPvMjNALoiBZRpidpqTHyUOr3lfoCzOUR4zevoXUnPiBtjgWYi4ixjawZAHMJB0Thq3JPGohhImm6iJWl7HhrDFGFLqzRhdKmsTrT5YIhnGWowU40BnlvCBL1kpXsLtbCOklEi06eRdOgbxwjTZlmnJsE/+goAcVOQ8jp3N3gEujvkOef03g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 10:17:47 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 10:17:47 +0000
Message-ID: <c62b6145-f781-45d3-bb5b-3bc5f3551d41@theobroma-systems.com>
Date: Wed, 18 Jan 2023 11:17:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] [PATCH] fetch2/tests: Add parameter to recipe_uri
Content-Language: en-US
To: pavel@zhukoff.net
Cc: bitbake-devel@lists.openembedded.org
References: <20230118072808.5895-1-pavel@zhukoff.net>
 <9d9e3eaa-92fe-2365-ab8c-352dee0af03c@theobroma-systems.com>
 <87cz7c2m2a.fsf@desktop.zhukoff.net> <878ri02lpi.fsf@desktop.zhukoff.net>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <878ri02lpi.fsf@desktop.zhukoff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 437914ab-912c-4cf4-355f-08daf93d3ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mG1+9cDgctekyT9o8GtWdkPByr3BVdI/gliNeOELiLm5hT82Rq4UzGg+sHFooc0EjpCpb9QIShg/qgb3KALq2c/ae6eYg7pk6iaERyD02nei+hVfGwfCSVDGLhvSI5IumP87uOMLh5oqX9cieTQTnF0zcPuwizYHRY0REY/bKR4cCCvtciBCuINJ56yuEnfBUKrvM7tvnuA4DyIcNE7pg6P02QuLLBlNc1cIRV+wrbCRvrP+zoc1sSbcY8bpHOdA7UXSo8Ufte31OM8ugEpv9pW+v7AVVfTq1ah23/OaViZJUcO+OMttuYYBuk/i9hZ1ay4UNpFjWAP33vuM/68kExsEc/MZeGk9gc6TswUlGx3yrHYkSiYUVMIgGs1+NK4vgbaHi7REd86lOIlGsbE3iOMz/s6HBPv3QupagERAgKxkrWcqaJJrw0J7iJ8MfZuNdulKfyMFtbG3YMR8exZWLlOmwybgv2JifC6EQArvT0mB4hecBD4vDg+nu+bPcwiLN1Sf+vjp4I571rsgxZoWAfh/BsbiWF3/ELovmZivuCIrCJxowwPhMHDXszH9wz0xBNMv7+fm5gcCGyHgMVXJ9Cnagz5M6X1j1uvXgyBFDNfJYr5meZxGFHu1t7KI0/OcHZrVhrac3ciLIGero6h9MYhqddcz6SHuXjxVCj4ABMNC3Rq8Ya00pnhup3gWB7ZGL8RdKTuQldcekdbBzwPMV7X2T7c96vNxre0MNFJhcwI67YI6oj5TwtkKVLZXn0fqFIuJRdTwFrUC0XPYEaruxA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39840400004)(396003)(346002)(366004)(451199015)(31686004)(86362001)(2906002)(44832011)(66556008)(66476007)(66946007)(8936002)(5660300002)(31696002)(38100700002)(316002)(53546011)(966005)(6506007)(6486002)(36756003)(478600001)(6916009)(8676002)(4326008)(41300700001)(26005)(186003)(6512007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dm9tZ3d4WEhyazBOQXVmcExmQStoWmwyVGI0SHVCQlMwU3g3aGVES3o2Mk1u?=
 =?utf-8?B?U0ErVWR0MjN4d3FYNjNXK2pBU0tzQmgzU0lxMG1NU3oveU55YXp5RURYTUh1?=
 =?utf-8?B?VXFhWlBjL0RTa1ZYZjRheXNzb1MySjVFY3VucnhzMlhRb0pBNThGaThaUjN5?=
 =?utf-8?B?d2l6VHRCd0ZMQUVaSHBKalhZaW9mb3R1QUJKWkFBdW12QTJEUDFuZUwvQ2pP?=
 =?utf-8?B?YytBTWxiamdTVVJEL040N0s3cVRHWjEyMzBFYjF0ZTBjSDhUYTFoRjNYci8z?=
 =?utf-8?B?UFFMMXVNN1VyUDhwTGgwOFEwM1VleDc2MWdqaEQ4c0NFZjJVdTZXRnc0V0Jk?=
 =?utf-8?B?VldEV2EzWENPRkVBOThtL0xRdVdVS3FqNmgrRm54NlROWjkxMGxpUWZzS2hk?=
 =?utf-8?B?UDJWZWIxalpUbS9LK2FpRDhIQ29GdkhKWWFQdWdWdmVuMzFWRVcxb2o1Qllo?=
 =?utf-8?B?RnhqbXNuQ1pWWW93enA4dDNCakd6MWQ0QzNKS01aRm1VOTN1WFQvNHJWYjZa?=
 =?utf-8?B?ZDRYdmpkY3c1Wk5nZFY1MHAwRDFiQkRYbHg3bXJUeEdpZlFrZGZ3U1lGNHd5?=
 =?utf-8?B?bzRDWVdQTGdFSWoxak9vSHdzSWlSMzRHK2IvMlVwNTVrSXk5NjBMUGQxUDJ5?=
 =?utf-8?B?VEJYVm9weDB1M1YvVHFpczVvUXIrTVN3dWhWMUpuRUw3STR2Y1Y5RE9iaWM4?=
 =?utf-8?B?b0sxNzJZamwrUVVCSWxPS0E1UXl1UFpEWWwvTDJyeS9KSzdHWVdHTUNpWFI0?=
 =?utf-8?B?TVdqU092VUEyWGppdDBWMzRidldya1pLM25WQSt6L1R3ckcwamFEWjI3QlBr?=
 =?utf-8?B?QXhMQWpJdkF4RGl6SEo3TjBYaFR0RndCSWFJRWNJKzlRaWtDNFNobW55MzRF?=
 =?utf-8?B?aDZyeS8wY1daS241eGxVMEE3T1lxT3AzWElhSTNUUFI0QlpvV1FNdGp0Z3Av?=
 =?utf-8?B?TFlnaDJhc1JkeUt2ejFyUkdQNHpRVWFPV0E2NnBkOE1lN2FXbjl4TmpISzBx?=
 =?utf-8?B?alIzQ2ZnZkd3dk52MUJpMG9US0pJdEd0WTdlREJIanFJckpzZWJ2T1F3bUpN?=
 =?utf-8?B?MlhRWGlKSjQ3VUZlc09QY0lmNktiM2JrZ1M0dUxkelQyVzd4N29NU0pHZ2Zi?=
 =?utf-8?B?ZzdwclhxMXpla25RbjdWWnZxYzNVdU5hQUN5N1NYL29MMDdwVkJQZkdkNXN1?=
 =?utf-8?B?amUwTVRMYlhxOUplN0JYTHhsUFBCTkNuSDREM1hRRm5rbFdiaEFJWHNpRmZU?=
 =?utf-8?B?ZU8vK245eFhCNzNtUVJ2MmxPejgwa2FWVVpLd3JNMjBlSlRac0J2VnZwVVRQ?=
 =?utf-8?B?WGZpZXYrNGo2VC9Mb2k1eWxtSXNCcVR1aXg3dU82NFdjSEhUa1daQTJ1MVJw?=
 =?utf-8?B?WnBNNGdudUNrUzYwL0c1d0Z0ak9PRVk4NTJ5dWZHT0dXTnFBTUx1bDIzbUpo?=
 =?utf-8?B?dnJoYTVJcEFpdDIvL09mTEV4RVBKNUlDRFl0cFU1U09JNkZkSWpsZTZjeTV2?=
 =?utf-8?B?ZU82OVNJa1krT1JIMCtTekl2R0tLVUphcWFuTnlKaExlWDBIaHVMTVFEMnNQ?=
 =?utf-8?B?ZXZEeFE4RnFRQUhwa3ErWW1zbXR0WWNtL1FNaWx4Zm0rcGpYdjA3RE9iOHJi?=
 =?utf-8?B?eVpNUndDVzdSQk1zSHM2cHNQK3N3V3hyL1lHck93TEEzY2JMUHJlQlEyZ04x?=
 =?utf-8?B?MitXNVpVaHc5WlhodlUzMUVsM0RqU1JHQ0VXMG5WbjBQa0NWQlAvZHpQdWxu?=
 =?utf-8?B?QnU5RlA3cXVPdTNtVmdZeEJreEh4L0x0a3lDV0dlTHNxMGxOc25nMy9vK0JJ?=
 =?utf-8?B?cU9JbjVEbWxzcWV1UVFpN1FrdmVNbk1MT3JabnlaVHpDRFRYTGM5dExHbHV2?=
 =?utf-8?B?MElvSlRsdGZrYWhoeXN4OUsvenIxOE51M3lDWjFDbzZ6Ylg0OWxJcFhGaERP?=
 =?utf-8?B?aU1iREZOTmtNVWxKeEVDMUFmZDdCbWh2WFZWb3VmdGV5aGZKZUFIMGhxRkpH?=
 =?utf-8?B?dUlFQ2Fkb1Z4RTBKb0xwK0l5YkdsSzh2dTNUOTh0Unl4bXkrVUE3ZFA1a2Vw?=
 =?utf-8?B?TUEzR0F4clA5ZHFRWDA2SmFEaFJnWVJxUldzdUVpYWoyRkpDOElJSGdBQnlH?=
 =?utf-8?B?am56dkxuZFpGNVlGSXZrTG9JTXorRnEwVEp6STZobXJ1b3AxazNCSXdOdW1R?=
 =?utf-8?Q?lFqzJe8VhawcrmIoBcr8oJM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437914ab-912c-4cf4-355f-08daf93d3ef0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 10:17:47.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYcnNgQvyYnUqo/biS7k1/O8ZSXlBnxhCae7Ayj08a9h8qgHKobEE+XOsDABXRGrhXSh0VIBBGn+1B6dCzY5EBIOs25R0GLD1IraM/KL4c8k+Szp7z55xViqEhY0tqOQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jan 2023 10:17:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14326

Hi Pavel,

On 1/18/23 11:13, Pavel Zhukov wrote:
> 
> Pavel Zhukov <pavel@zhukoff.net> writes:
> 
>> Quentin Schulz <quentin.schulz@theobroma-systems.com> writes:
>>
>>> Hi Pavel,
>> Hi Quentin!
>>>
>>> On 1/18/23 08:28, Pavel Zhukov wrote:
>>>> While the parameter is not required it allows testing of possible
>>>
>>> I was convinced it was required for a year already but no :)
>>>
>>> I see Richard added a warning in Bitbake when the branch parameter is
>>> missing and nobranch is not set to 1,
>>> c.f. https://urldefense.com/v3/__https://git.openembedded.org/bitbake/commit/?id=86a9c26828479be55865bcce72bcc7e12b93caa7__;!!OOPJP91ZZw!jDJyOLMmDaxwKpz9hULAvJ2SOX6mIeqJ0lI-Wx73AiRQkXmRq-Y26SLMuRJbgJ-haBjaDrky_IAHx26NmhnzxYWsE0S6qwA$
>> Right, I saw this warning in the past but not this time... Anyway at the
>> scope of this patch branch parameter can be changed with any other
>> (rebaseable,bareclone etc) parameter git fetcher accpes.
>> branch one is just first that came into my mind
>> :) .
> Well. The warning is there but it's diplayed only if test failed:
> Stdout:
> URL: git://git.fake.repo/bitbake does not set any branch parameter. The future default branch used by tools and repositories is uncertain and we will therefore soon require this is set in all git urls.
> 
> So yes, we don't fail test if it's missed. And even more, test will fail
> if it's specified and premirror is used in current bitbake
> 

Sorry I wasn't clear. It's not a comment on your patch. If something 
needs to be done, it's in bitbake fetcher to make this a fail, unrelated 
to your patch. I was just raising this so that someone can/should have a 
look at it (and add a test with the missing branch parameter).

Cheers,
Quentin

