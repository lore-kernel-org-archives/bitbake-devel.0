Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29114C433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 13:16:34 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.44])
 by mx.groups.io with SMTP id smtpd.web09.5289.1636118191644872080
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 06:16:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=m8nzOiOB;
 spf=pass (domain: weidmueller.com, ip: 40.107.0.44,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6UrdNwSgFQNKbW7HEZAnJrztJu4lDR9ygMHUGZSKdgUqJWrPXMWyKcMONfxBw+CK6TO4g2KwiKdy31dLk4/xtQMTmzDJKpjtFBKrUG5SVcrhD2Efznvx6U0C/dvQ07lqgl0cSRtUeQnbfL6v5SDaGejgNL/+xsybt3zzi+oPvB+wC8qZ440mHYV29kCFCIExa4fhh6YAzBoWf62OCVFPByfH8Sokdv155GTTpG6pdK3tyL4LM2+lSlDppslmEiCaCAhc7zXnH+AaAnFQHdw/5LZ3y2HY8748lxnrPkKbvCp/EasAIQs+olF+DgZPO21LqcW8Nvds/FI6QQprNZAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlsZ1Ocf3U3AzTb+SX18So0n0dRac7OsHFlY6vj2cCg=;
 b=CrtXxGeQkCyTSlejCljlEL96U0WM/9neBHufKDxZFGqx/PtW5RZS/LDwkKM+UhoLM81nlWkMm9TeFIgMiW+G7u3+Q17RyQaVd2Q0BUh2/a6OoyvqUPJetpeqZ1qbrKWl29ZOAVR4Pz4ZhijYMRXK2PGzeo/dG5mSKIquGqz0mnuPmaWcWm8o/2bxvP88e7XXlQ7dLxNb2ZoZOBlQ4wzoFJncbED70JKaQ+4TvK8cUFZh7ZNz+aBK62O/CYNhEiptr5XOFgiDQga7LyF9J9GKhb05aY3wnVt7mtfOoSg2FU/n/9mEVJiazuHJtOGyjvwlgU9CiXkDLA4qC0SFG1N93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlsZ1Ocf3U3AzTb+SX18So0n0dRac7OsHFlY6vj2cCg=;
 b=m8nzOiOBJPMDP/6+cUkXw0y/gpWXElrA3FOYSH8+s2aZjswgYGOsvwDbGloZ+nEIM1rd1JOznX5C8UIcsAu+JVUpGffGbR3PwNJzmFxfzwILVqiagehuh0OROUcEdlUO7nPUNoB3ZJ3Ru8mz0SOOOuD9ouyZaHw2+CP1t+e2JCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PA4PR08MB6205.eurprd08.prod.outlook.com (2603:10a6:102:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 13:16:23 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 13:16:23 +0000
Message-ID: <4d2e6c3c-b1f8-01e7-76b3-557201755a87@weidmueller.com>
Date: Fri, 5 Nov 2021 14:16:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Content-Language: en-US
To: Martin Koppehel <martin@mko.dev>, richard.purdie@linuxfoundation.org,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Cc: Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
 <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
 <4106f9ef-5b2e-5276-f1bb-c80a989d7fdf@mko.dev>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <4106f9ef-5b2e-5276-f1bb-c80a989d7fdf@mko.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5P194CA0024.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::34) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from [192.168.178.36] (89.247.126.158) by
 AM5P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 13:16:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cadfd88-fd80-4122-ce72-08d9a05e76d8
X-MS-TrafficTypeDiagnostic: PA4PR08MB6205:
X-Microsoft-Antispam-PRVS: 
	<PA4PR08MB6205587CE34E18E014AD6009D78E9@PA4PR08MB6205.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WbzJ+Baw1nKH5tHSa8T1/jPI0I9PqOIGbA1g4MBdaSiz0aY6ZKXjC7I1ITXRepJxAuFGKaAvH8S53RpiGgPdoeXyz7u8FrJJxPcVgIVxqYOGEEiqDzWVYeTFUgYOm3HbtddIXtcQf9FGYqluLYQ7jSsg3xTuhiH1fS0zDhjsnvfnjutuz1wgfFpwYBC7nBHf7fNf0BNp/aWYsW4j0MDVW5Xf2Vtp8Upnbfokx0Hw09PGqA/220HFzueClZ3dnwPDVV4cTS4LTE1wvbL2SCpT6we0rRwD0L7aKdim6zDFCvyRqAS6atD6XAQZ8juHqs4v0WmlrvfGiQSIMsLpaG5m+wu4uuGSf+hQnSK2T16CoSchbRlTZ+wdWLPFq3wEpytPjM9KBL9RRd0P4PpaoSKwjd2Rp/ja1hO2tlSdlerd3vul/BxfXP49M2mMK9QZFufbJ73FmcsIMhV5AzAkjnN0KxpdvIGex0r7Hkt7PKYykEbFdrR2zLeKvl4BW5+TCimmvxfaqWSJhlq4BOC0ulqiZcsfrvo7LjqaW02ic76DJfM3qIad796/9aSziIaOoim7bi3ZDQ/GqHVrX0ey3yCbSFWe2BcC9GkSJCY8X1x/wtX8aEm6W0DFMylT8GclK49cuEP6BmoSL/Xur+7/KrQKeUJM+FtRpuLIBjn9oq6Uo4NML0V9MY7biLDiL53U1IOUMV252/HDpnIrgA+E1SgxK0JAaClPE6UUYXAiOWUwX1smmlthXBUNsJaIfHQHmSm2dh/UoL1wTPaERZer5u17OAhyz1npLm0rLX4vBq37bSBfG60vbgMaOyXompl/1lVuzqWlpiaHSnE0V7RabLQhfmRBX9R0hH5IUXky3FpkDlI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(31696002)(31686004)(36756003)(86362001)(66574015)(186003)(5660300002)(66556008)(8936002)(956004)(2616005)(66476007)(16576012)(2906002)(4326008)(110136005)(26005)(6486002)(966005)(53546011)(38350700002)(38100700002)(8676002)(316002)(508600001)(52116002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2E3cUtPRG55WnlhT2lSZlV1QXJ1MjR6dEVLSHcvVkhTVVFRL240c2VWN2wv?=
 =?utf-8?B?aWxRNGEvWlQwUTcrWWRLbFNEYWdwZFl1ODN2aWhSd2VNcmRYc3cxQzRLQ3g5?=
 =?utf-8?B?MTN5MnpIWGRSRDQyZlJvYU56dG1WRGFsMkRaN0M3UDNzR2h4UEc0NTNxcDB6?=
 =?utf-8?B?Ny9DT1M4N0tJM2RtM1ZjMU1kNUtzdTMxc0JOTTF5NU9tQUVIb3BFQy9ja096?=
 =?utf-8?B?WUJuMTFycmVEZmM1Rm1GRzRDT0lEWVk1MVV3d0RlUHVLRjhYVXdZY1lTREtY?=
 =?utf-8?B?U0JMM29XVGt3THlSaEMzMWMrS0dWZ2RoOFo2L2pFZklNWHlmL0p0aXI3UWRP?=
 =?utf-8?B?K2NKbm1mRkJ3cC9mUm5HNmg2eFlaKzVxYzhaZ0F6NUhKRSsvN2oxd2VGcURz?=
 =?utf-8?B?cThobVZUMXdrMS9HbzJHRTRyMytIcUk1N3ZET1hiZDZZMk5OUlZkeDJBaFlR?=
 =?utf-8?B?eFVDcG1WeGUvWXVGajE2VG5BUmNDOXFGWG1BTVNXcjFpNXU2NDk5YUdQRWxy?=
 =?utf-8?B?WmtZMHBCdUw2cXVKSnlDMXJvWC8rTDR6UW1RZXhneCtVUVZJeVJYaGVCWWZS?=
 =?utf-8?B?ZFJhYmVaVnJPcXlNSjVLbk1aRitCbVdoUE1SN1VYcXFmclhCeU84Und1aFlC?=
 =?utf-8?B?SC9oZ280RkZncnJMVERMQ0Q3M0FwY0F2b1RGcEc4THMxbktINFNORThLSnVi?=
 =?utf-8?B?U3FsbEpqaS9GYXpnbUJzSGgzSlVxUFJRNk1qZVlsQjVXTDJRVFpuQVZXZGx6?=
 =?utf-8?B?RjNNOHVDL1FKUXZlb2tzeDJOVGlBOFNnd0c3bEpWb3RONmo3MVphWWQrWkc5?=
 =?utf-8?B?TUVIUTBLTDF2YjNGbkpWQ0Z0WXkxbXFIVm42VmRzZzA5R0JGMC81RTlLQmoy?=
 =?utf-8?B?MWdKeG14blZqS3ZYVnhFRXQ5dExwMXhGbEl0bXFCVGdCcXVFRkFpSjVMN2xr?=
 =?utf-8?B?OWp5b3h5MHFydXh2TlIyeExHSWpGdHJJU2VsYytpamtyR0hoSUJXTDdtSWtq?=
 =?utf-8?B?cDVhZU9BS3lockFzUHpBMVQxTEMwVHVtaDRPR0VYN0JsVUtKNi8rck5SNDhY?=
 =?utf-8?B?ZytXSGtMRSswRXd5KzliS3A4ZGRWdzZBUk1GQmdrOXE3THpUQTdkK2l5R3Zw?=
 =?utf-8?B?ZWxkejUvMjhnQTJOb25IZjFJRzBzc3J2UDFPU3hOekkwUTVNdnE5ZG5nVE1C?=
 =?utf-8?B?RklWL1pjenEzbUJmeHplaHl4WkovUlpxT0xNZytXbThZMzVSMFBxMGpXOG8x?=
 =?utf-8?B?V0pJWHBTVFVNUFYwdTJMNTlPQUZQdUc2WlhtZVZiT3M5RVhyVmxvSTFXdFA2?=
 =?utf-8?B?TzRJVWtDZFRTWThkMDlzelpEWXdBWDI3cS9nMlFOR1E3T1NCM3QvRVV6YXFn?=
 =?utf-8?B?WlFLbFRKc1UrdmRaa3NtNUJtd0xyWko1YTZ1c1ZNSjB2TlRzZDg1NWg5Nk5u?=
 =?utf-8?B?VWxxOEh5MHc3azVsUWQ0YlhFWG4wNzZlaVh1SFdtOVVBOTU0dThtY0U5K2lG?=
 =?utf-8?B?VGw2Tjh0VzE0MnA0SUhRekZUZWVScTRpd29Vbk1YWGszaU0rRnNTTTlkV2dv?=
 =?utf-8?B?a1B3YXMweWZjUkRKdWxQSFNrdVVjcGlxeFlZRVp6dEpQakQxTmQ0UEx2Y0Ns?=
 =?utf-8?B?c3dEazJPeHB5WFN5K1V1d3ZaWWMrRHQxQi85MTJ0dGlaZlhheUJQV1RSU2RF?=
 =?utf-8?B?aXRhUms3M0hRVkFQTCtneUtndWVjOXhPZnlKWmNhSWkwQ2ZPeHZJeHBYdDlD?=
 =?utf-8?B?TE82c29DR29HWmNPUHlWL3NrQXA3Wkt1UVdVSllFZFBySjRHMnloZytWdG40?=
 =?utf-8?B?MEhwM05hbGtpQ2ZMcGlyc0VwcUxuVlVYWStnNTk4ZFVyUkhUdTdaWlM3cEk0?=
 =?utf-8?B?VUVxbGdWQlpCRlBmN3FIbXRGelkyS2wrbU1IVkJIMnMweHltQnI4VUIvclhS?=
 =?utf-8?B?aDByaEhpNDQ2R1NHMUhzb0xudk94VjRrV0NEc0FRMFk3SitlYnh6QzYvL3hI?=
 =?utf-8?B?VXFXY21uM2djK0pWU1NIYStYbTUrbDh3NjBsc001ZEZnell0SERmYllPS2FJ?=
 =?utf-8?B?Y256V3ZuQ2czREZjRXBpaFhKZjh6TVYycnZReGdFcVB4UHV1bkNPRTZTYUpS?=
 =?utf-8?B?Z3lDWityMktKS0lOOTBCZDFqaldwc0RBc2xhN2hJb093VGMrWGVVaTc1bUpW?=
 =?utf-8?Q?9LwH2mEzgKmx8u8Gj0pVTFg=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2cadfd88-fd80-4122-ce72-08d9a05e76d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:16:23.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 nJJM6UuI6GqbAbcU+DUJAhbzzoXWey7pckfHaUTZbULnt+EnPtlOBdld8P/BduCTaJC8KXQOKW1yl/ieJ+cBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6205
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 13:16:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12890

Hi,

Am 05.11.2021 um 12:10 schrieb Martin Koppehel:
> On 11/5/21 10:07, Stefan Herbrechtsmeier wrote:
>> Am 05.11.2021 um 00:15 schrieb Richard Purdie via lists.openembedded.org:
>>> On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:
>>>> Dear Bitbake developers,

[snip]

>>>> So how can we address these issues?
>>>>
>>>> We plan to implement a "sub-fetcher" for npmsw (a concept which might
>>>> also be recyclable for similar use-cases). This would take the
>>>> form of e.g.:
>>>>
>>>> SRC_URI = "npmsw+git://git-uri.git;npm-topdir=path_to_npm_project;..."
>>>>
>>>> The idea is, that the npsw fetcher would then call an arbitrary sub-
>>>> fetcher (in this case git, however any fetcher will be supported) and
>>>> after the sub-fetcher has extracted the source code into the DL_DIR,
>>>> the npm fetcher will create a secondary download folder as a copy of
>>>> the sub-fetchers download folder. Within this copy, the npm fetcher
>>>> will call `npm ci`, effectively downloading the npm packages by doing a
>>>> clean-install on the basis of the package.json and the package-
>>>> lock.json files within the npmsw download dir. This results in a much
>>>> faster build, as it removes the need for seperate handling of the
>>>> individual node packages, as well as streamlining the developers
>>>> workflow with the build process within Bitbake.
>>
>> How should this support the download proxy? The npm ci command need a 
>> repository or a cache to work.
> The npm ci command can utilize a private registry and/or http proxy if 
> that's required. We didn't consider that case yet, but I think we could 
> add a call to npm to configure a proxy according to e.g. a set of 
> environment variables.

With proxy I mean the yocto http download proxy not a private npm registry:
https://downloads.yoctoproject.org/mirror/sources/

>> Furthermore you need a patch step in between the fetch steps to 
>> support tuning / fixing of the configuration before the second fetch 
>> step.
> Our idea was to build a completely checked out and installed repository 
> and archive this in the DL_DIR, which then can be used in the do_patch 
> phase.

This makes the download recipe specific and you can't share npm packages 
between recipes.

> Are we missing some important use-case here? Whenever it is necessary to 
> patch the package.json/package-lock.json this should ideally be done in 
> your upstream repository.

Yes but what if your upstream repository doesn't exist anymore or the 
upstream repo doesn't accept your change.


> Our primary motivation behind leaving the package-lock within the source 
> repository was to have a single source of truth for the dependency 
> versions.

What happens if you have a CVE in a common dependency. You have to wait 
for every project to integrate the update and have to check the external 
sources to know if the package was updated.

The problems are the different requirements between a developer and 
distribution point of view.

>>>> As this fetcher would be implemented separately from the current npmsw
>>>> fetcher, this will not cause any breaking changes for existing setups.
>>>>
>>>> Additionally, we plan on writing a separate npmsw.bbclass, which will
>>>> parse the package.json for each node module for an automated Bitbake
>>>> license manifest generation, which will resolve the current challenge
>>>> of having to maintain these manually, as currently described at
>>>> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#npm-using-the-registry-modules-method 
>>>>
>>>> .
>>
>> This licenses will be generated by the recipetool and you could 
>> provide checksums to detect the correct licenses.
>>
>> The license inside the package.json is only a hint and you need a 
>> license file to fulfill the license compliance. Because of this I 
>> remove the package.json from LIC_FILES_CHKSUM because it is useless 
>> for the license compliance.
> You're right here that there's a need to have the full license file. In 
> this case, a license crawler would need to traverse node_modules and 
> scan for LICENSE[.md,.txt,] files and then generate the checksums.
>>
>>>> If this is something you see as a worthwhile goal, we will provide a
>>>> set of patch files within the coming weeks.
>>
>> I think you mixed the unusable npm implementation with your special 
>> use case.
>>
>> The problem is that the current npm implementation isn't really 
>> usable. I'm working on this and have already a prototype that could 
>> install, build and *test* a proprietary angular project and node-red 
>> as well as koa/examples from github.
> You make a very interesting point here, primarily because you cover two 
> very different use-cases. I think we have to distinguish between 
> something like a webinterface that only uses nodejs and npm at 
> compile-time for dependency management and bundling, where NodeJS itself 
> is not even required on the target (this is our use case). The second 
> class of use cases is running software like node-red directly on the 
> target, where the current approach of the npm fetcher works quite well. 
> Our thoughts primarily focused on the webinterface use case, but I agree 
> with you that we should keep an eye on supporting all use cases.
>>
>> If I understand you correct you like to build a npm recipe that could 
>> change it dependencies without update the recipe except the SRCREV of 
>> the repositories.
> 
> That is true, and I believe keeping the package-lock file directly in 
> the source repository is something worth pursuing not only for us.
> Do you have a strong preference for keeping the dependencies outside of 
> the source repository?

The problem is the different focus between a project and a distribution. 
If you use the dependencies direct you relay on the policy of the 
project and its dependencies. It must be possible to override the 
decision of an individual project or dependency if it doesn't match your 
requirements.

My question is if we really need a fetcher for the content of a 
package-lock or if we should create a recipe from a package-lock.

>>> At a first read it sounds reasonable but I don't know the answers to 
>>> a few
>>> questions which make or break things from an OE/bitbake perspective. 
>>> Those
>>> questions are:
>>>
>>> a) Once DL_DIR has been populated by this fetch mechanism, can a 
>>> subsequent
>>> build run with just the data from there without accessing the network?
> This does hold for well-built packages that only use code out of 
> node_modules.
> We can not guarantee this because the package could execute arbitrary JS 
> code during its build time, including fetching content from the internet.
>>>
>>> b) Is the information encoded into SRC_URI enough to give a 
>>> deterministic build
>>> result, i.e. if we run this build at some later date, will we get the 
>>> same
>>> result?
> The package-lock.json should be checked into the source repository, so 
> pinning down SRCREV guarantees a 100% reproducible dependency installation.
>>>
>>> c) Is fetching only happening during the do_fetch task and not in any 
>>> subsequent
>>> step?
> Yes, we want to perform a full fetch directly in do_fetch and then 
> archive the result of this operation within the DL_DIR, so subsequent 
> builds can be done directly from the DL_DIR.
>>>
>>> I'd love for some of the other people who're worked on this code to 
>>> jump in as I
>>> don't use it or understand it in detail. I am worried about how we 
>>> maintain this
>>> longer term as different people seem to have different use cases 
>>> which sees the
>>> code changing in different directions and we're starting to look like 
>>> we may end
>>> up with multiple ways of doing things which I really dislike.
>>
>> This leads to the questions what is the desired way to integrate a 
>> package / dependency manager. Nowadays any language (even C/C++) has a 
>> package manager available and more and more build systems (ex. Meson, 
>> CMake) support automatic download of dependencies. The common 
>> integration into OE is a script (recipetool) that generate a recipe 
>> from the foreign configuration. The current npm implementation is 
>> special because it reuse a foreign configuration and translate it into 
>> fetch commands on-the-fly. This leads to the problem that common 
>> tweaks like override a dependency or share configuration between 
>> recipes via include file isn't possible. We could fix it by removing 
>> the foreign configuration and do the translation during recipe 
>> creation. But this means you have to recreate the recipe after every 
>> dependency change.
>>
>> Is it a valid use case for OE to support foreign dependency 
>> configurations like npm-shrinkwrap.json, go.sum or conan.lock?
> Agreed. Especially for cases like Javascript/Go/Rust where the 
> dependency management is a core part of the language and ecosystem, we 
> should support these.

What is the advantage of a package manager specific fetcher instead of a 
package manager specific recipe generator? Does this advantages overcome 
the loss of common OE features?

Regards
   Stefan

