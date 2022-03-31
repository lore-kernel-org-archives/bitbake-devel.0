Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D754C433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 08:24:18 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.50])
 by mx.groups.io with SMTP id smtpd.web12.4731.1648715056317801303
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 01:24:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=grAMctzi;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.3.50,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjYtmqUZVzg8Txw6PQDOPui1RxzKH41SnwFWyLX7Ds918GQxyDZZEqlfnWyL4S8vfOwZQeevUvEjAetwPf2vUFZ9CTYORaRk6yt5f/28Zi8RRBL0wM0zcBHurj52MtIVU4ZcYXfac0ojDW+vLOniPKtq8RaEnI/F1Dyc7olZC/G+i8VirIS8R62eFaXnW2XQ+/vANO1dl/Phe8mBZLDVzMPCxL0uPmWmBAQTlEeOuxYGT/BGI7v4QWsIkBCnITYYGHSsc8JrWEj/ssXtFx5rJpHpn+J/sZhekZ2VCWHE/WZHS2HNYrsGDxAJlpxHmLKrxOZiUDqhrpwQ5y08rBKbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDspASYKNUByZ4ItM8lyY3MAsA8OvAlckbM3+S/aPNk=;
 b=kfxlgPygV5j1xlQ/dANQmt3yAdMxEuFDVeImq36f5zyEnrQB1QJaZQx5p4Ru27hD+la3gqLrUDZd06SoyNuRl422DoSNsA6NOYl90XxzjsZmgfntBEY9Mgdr1eT6FWEMH349sdWowyTRuYhq+3G4Qvnbont5HW0zjUnhkOxebsUlxg0YFhCqVnR7nfk3G12RnBw8sS+89HwA6SIbPIfKGeDSALGf1cxBFONW6NomT02d9klgqPLPzFMR+hr5eNVfzflNSIEf8F0EHhwLDEfH1gg/OisFMDHY7MtXNvMx/Ovr/rOn2hxbubZxLAazXldALYaUY7n6PREjnWLWDfUzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDspASYKNUByZ4ItM8lyY3MAsA8OvAlckbM3+S/aPNk=;
 b=grAMctziQLA1/BIAbepIJJoXB0pYq3giuL3JVqDoCr1JSH5yN+I65gclPb9dsrfgIGuiNBpW8GBBSLsGYWmrK8s9sIJwWmU0b3Z1QNkrScQkVre1Q08Z9hs0fJOa8nGYliiohMuPkwqUXJ+tCYUEvDVDUDYo0uccplyMZ/iQz/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VE1PR04MB6512.eurprd04.prod.outlook.com (2603:10a6:803:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Thu, 31 Mar
 2022 08:24:11 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 08:24:11 +0000
Message-ID: <6a58f3eb-7140-b6aa-6b9f-a0372b7311fa@theobroma-systems.com>
Date: Thu, 31 Mar 2022 10:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [docs] [PATCH] bitbake-user-manual: punctuation fixes
Content-Language: en-US
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
 <5205d592-db48-f554-5c64-221dbcb7b774@theobroma-systems.com>
 <119c048f-010d-f9d2-2e74-da470b1d043d@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <119c048f-010d-f9d2-2e74-da470b1d043d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd7a176b-2dee-4b0f-baa3-08da12efd53b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6512:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR04MB6512374A327AD39E3AA77F7AC2E19@VE1PR04MB6512.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YyJRR/si/Oec+G31f/frXde65RP0z8kesRjUXPWXOMlZ2ON3AGL1C1TFcHjHmtfj2TVYLOrTl23b1JlJLA/S4ig08pGf+izloxjlOSZvdJhSoH97BqO4czGnoSd9uLyja81C+377QwJJbSK3CaMazkbyhZTSdKlt64JmZeg5oiOoDvQuRg0xRviJdPFhfcewlLzGZvtBfQwc5AG6S+S6pWwYSr34gg7trT8qc7cn3ahcz784cvtfzUlNxjQ1nrrYc2sRniNEazhlsyJdVitJlWV/TR0kwNy/PabUp40lZaD6v+ozAqfwPjw1u1OIuI7skzvyJtquE88LrRQl25RlEtYqtox+g4c1B3hUDyqpIN7LeKM5TawayXPtnEFi1x7RQ589NaRVfB2uD/8AbDpliLKu7MfOFpqB2MWDpRVX1SDAOrMh9tc5SzYfsN6WbzVhIig0TAYJemTSA7xyY1EXP5nw9rjIpVBBU+F6WVfxYoQagOA4xpLdy0NJH8Dj+DW1eiMpyoukRhP4fO6vmOWpcX+KvrEThxQAXI5J1hJ8gXId8GQsUz6t9JnEeAGTsEwKwgKBfXXcOFwU3ZnSHPI8YKSNql9d3NrunMSZ9Nc/YcStTDWQh7kH2hKTb/6i95K8W0VUZAMZg3LCKdgnGdIQMUwjahxTPEhz3b/XircStltnV1Wlf0pyRiRJ2yqa/ajgvVS9JA2I7PywW1/NI40HcVlCCFJZXNP6QKXs2I+4iJbg2KR/z6fml/d0OigJAlYLlwMdFd6jo3pWGByawv9Eu4xQjeQA4uKgc1xsg55UwW2sKCMHna7DXH2AtdvUIBV0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(2906002)(6486002)(53546011)(83380400001)(508600001)(316002)(36756003)(31686004)(966005)(44832011)(6512007)(38100700002)(4326008)(186003)(31696002)(66946007)(2616005)(26005)(86362001)(66476007)(6506007)(8676002)(66574015)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzlRZnVOUFlYM3cxMVNrc2ltVERybURtYlJlTThhK2ljcmhLckZtZVZDakdF?=
 =?utf-8?B?TDVLV3dLTXkwTkFETVkzNFRMVWMzREN0Y3RLUGMxZHNKWWtTN3pnaFdHTzZs?=
 =?utf-8?B?WVZGUXNtdWVLcFdJVjRNd1pOZEQrelhETGJnUmVCM1JzMksvakRQQVUrVXBI?=
 =?utf-8?B?QnB4cU1PRHRPSVJxMityL1V3bGpyVjRGZ2pyS2NoNGhSemFpd1JBeWFDNXB5?=
 =?utf-8?B?WkRPT1VWMjUxeFB2QXYrWk5BNjJseFhFQkpYMUVWMmw4Ym9Ldm4zMlIyNnc2?=
 =?utf-8?B?VFBUWHoxdWMyZlU1VXpJWkVaWXZZalNML3l4MW54K0ZtUWlFS2h5RTFTWDBG?=
 =?utf-8?B?NVN4Tk8wL2t5TjhuYWlsNjNxMTc1dGFING95ZTNrTTI4T3pvbXlVRzhEd2Fn?=
 =?utf-8?B?VG8xT29ENHp1VTNnWmNwTnd1U054TGhGTmtCVVpxVitmVVNpVEl4UlRTUUpV?=
 =?utf-8?B?eGdobVU5d3EvZGN0SWhuVzZoaHpoZGNBNXp2OVRucTNYMW9NbUdDZVZQVHIr?=
 =?utf-8?B?MnRnMUgybTRyV1dGQnh2bDRZcUlvc2psSnFzV1F1QmR2ZGtERUdYSXJNVzVO?=
 =?utf-8?B?THFsd1BaWFpjdnNOaSt5dFVoamdiS0xGMzBjS3JIeHdOM1N1UVBsQ0FoM0NO?=
 =?utf-8?B?aGI4MkJoNnVVWEg4OXhPbktVdzdsZkJCZjgvcEl2Mk1NeWp2Zm54VTZKeDh1?=
 =?utf-8?B?OXh6SlB0OGpkNmc4VElFRDM0dzFTUVp0VWx2RGlZOW1WeXZzUlU2ZXpiRGpY?=
 =?utf-8?B?RHEreFJnSW1lZGlZemFFRUNzRTY5bGllZzZ6TjVGS2N4NGtNcFYydHAxWmJG?=
 =?utf-8?B?NjFtMjBWUExtS0tTamdxQ25LTmVuV3U5eE5Sbm90K1cxOEFEbUhTcjgySVlC?=
 =?utf-8?B?VnpHSlR1MWhCQ2x3MnhoREM0dDIzOEdrNXE0S2QyTk5pK0pxUTlLK01WREFx?=
 =?utf-8?B?MzR2K0h0ZlNiU3RmZytqaEp3ZjhYd3JOWGFTU0xPM1RRc2JVWGZzejhaN2Fk?=
 =?utf-8?B?WUoveXNtT0hhRjNabnBpVURoVHJqTG44dEJ3RzF4YkVweGp6azVnWk9zREln?=
 =?utf-8?B?Z3BhRE1wRHVuN0t4eW9id0JzSUVYcGJQZHUzTFpESUZobEp0WXcyN3crZXdo?=
 =?utf-8?B?dGo1NkQxdWJXZ0lWNGlWdlZBZXJZWHVRNDF2NHQ2SHRIQ0NxK1lhVjk3dFFN?=
 =?utf-8?B?VUZtMjM3TmpvcUhNajBmSlozMDJNNFhHNGJYMHdTWFJOdFM3Nlpma2VmSGRz?=
 =?utf-8?B?Mjc3eW1aeFV1NGNJVkhRaTU3c1I4ZGFUVnRXdjhKMDdGRGFIdzQ0T2c2ZnZq?=
 =?utf-8?B?QTlSZU9zMmR1V0xpMHRyYnhiY2FCemxEcjJVMHBzbEQ4Z1BjbWhsZ2tCMjBV?=
 =?utf-8?B?YmtDdmFwVEFhdlQzK3FMckU3dWtEc2pnSVBncUJGM1dHK0dIek9aWDFaTnl4?=
 =?utf-8?B?RHBhVEZzZlp0cXUvZnN3Q0ljVVh2cGVhQUx2SXVIRy9Yd21MSTkxY1FuVndU?=
 =?utf-8?B?S1JTM2tudGFDenJSV1RFb3B6OS9zZ2VkRmdHblJQR1REZndScFhTTXJPMzRt?=
 =?utf-8?B?SUZubGNrdzc4TVFWZ3N0L0ZYQ0tSQTFHcnQ0NFhUR3VOc1Z2eUR6WjFTYjRF?=
 =?utf-8?B?cnBiZ04rUFJjMFM2c2pCc3R5bnhrdkdRY3RHNDhvaXMyb3VxTlpmaGE2cktH?=
 =?utf-8?B?V3RKMHJSMllIZjlnY200ZXZ6YzAwTTRYejU3aHgwN00wMkJFb1ErbHdybG1N?=
 =?utf-8?B?TFIwdEVFbG1tWkJ2ano0WDJGUmRDM3lLeUJUVHlUZVluUlJCNDA3UCs3bWcy?=
 =?utf-8?B?RkUzdnE3M1hGZjg1UENkbXdZbjVsT1pWUWwyM1hMOFFZUGNrNnEyZTk0bEZO?=
 =?utf-8?B?MDhEbFB0RHEzRFlxa0RkbzNUc2VPUzBYd0lHN2JvRHpwak95ZFNNUEFiSE9S?=
 =?utf-8?B?cWpEYUtoRWxxYWErVi9pdlYyRE1KOENYZzNvSEhhaTB2NFBsL2VEbHFVb1Qw?=
 =?utf-8?B?WUsvVzZhTFg0UEV4MlMxa1BWcjlCazIxNEtIajZWRVFRVVJQd0tTV3EySXkr?=
 =?utf-8?B?SnhheWxMbE5uVjJGbHE4aUdFYnE4bkIzVGRyKytsNGc3bkZqTXNGbXdXRGJ4?=
 =?utf-8?B?ejFpRmlJUzUzbW9Ydm0xb2d5VzRuWVpYTzNrR0dCZ3JoU3NCNUJGeEdJaHFl?=
 =?utf-8?B?Rm1Xc1RrdXU4eWlEU09tTXNNYytmWitxVDlBOGUrbGMzRnBjNGJYcDFzc3dP?=
 =?utf-8?B?S24xVDFhb09NWHU3Z0wxdWQwNzRqZG9zSDJzMFg4KzdDNXQ1d0o3SUU1VENi?=
 =?utf-8?B?bWRYeUowdDFHVlM3N0FmUytKWVo4R2taelVwR2t1ekFSMVlodEE4aWY3VjV2?=
 =?utf-8?Q?spu2nvK2WkPCssRY/uIAE83hJO6vGoprzt6V4?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bd7a176b-2dee-4b0f-baa3-08da12efd53b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:24:11.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 oZL4cLVx//ZOfhnxa+NmfXTL4bQV5s1C/nRcqW/F630lxpZh2nYjSxGAjoPlpagPTkbTTjgqEIgUQGLptzhp/WiORuWBDHscWrDYmQA9J9hPxsynGBbNgUrIdawLqtUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6512
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 08:24:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13554

Hi Michael,

On 3/29/22 18:33, Michael Opdenacker wrote:
> Hi Quentin,
> 
> Thanks for the review!
> 
> On 3/29/22 15:13, Quentin Schulz wrote:
>> Hi Michael,
>>
>> On 3/29/22 14:07, Michael Opdenacker via lists.yoctoproject.org wrote:
>>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>
>>> - Replace hyphens by em dashes when necessary
>>
>> I seem to recall we ultimately decided to not go for em dashes because
>> it wouldn't be matched by a search in the browser or in the sources?
> 

c.f. https://lists.yoctoproject.org/g/docs/topic/85211078#1731

for the original discussion around em dashes. Didn't decide anything at 
that time though but you have all the arguments there.

> 
> Ouch, this is frustrating. I'd rather not deviate from English writing
> rules, so that we don't have to keep a list of exceptions to them, or
> worse keep them in the back of our heads.
> 
> And why would one need to look for an em dash in the browser or in the
> sources? As a reader, I'd avoid special characters in my searches, and
> as a developer, I would do the same, but if I really want to look for a
> specific em dash, I'll quickly find what the corresponding characters
> are in the sources, thanks to the surrounding context.
> 

You just gave the example as to why I think we shouldn't use em dashes: 
to "avoid special characters in my searches".

No more arguments since the discussion Robert started last August, so... 
up to you.

Cheers,
Quentin

