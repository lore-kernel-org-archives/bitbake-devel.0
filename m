Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B394C433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 09:07:36 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.49])
 by mx.groups.io with SMTP id smtpd.web09.2868.1636103253966330215
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 02:07:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=h8VUhqLw;
 spf=pass (domain: weidmueller.com, ip: 40.107.8.49,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnWJ7YOYj4rsmgkZX7/dR29AHBq5wDZPD0xKbDKMQz56plvMParLDiJZhyTIkdUPQBXIwkoBwKSCwt9ze8m8Lmf5HMGcdRyVs5/uVU4Fd9e2XLbjFIeVi/12+OqGljHnxHmouNgTPN4uAxW7HeyYoNzZak6qSBRA7ZZH7ZUPJQv3k2mdt0GMrU8nvQ2Nd71gPJqIb3mzC/PTOKR4ujnVJiXGbvRtk9klRYywOx1bwlbJjpWwR9+asAuCd26O/7/vFBRR3NZTpthqdH/MWbyGhO4VUM4kE485XGVkFODpEm86SOn8Y4mgOvi5qlCohUHSgea6PciUlmQrd28DHSc+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHfFR1w04vw1CNYDoWtNtssxBrkOC5BoVpmRht5z3c0=;
 b=LHim1YdiKQHYpGdrk/AS1noyXO+7v3Rr5oO1b+O81ubJY/MidvSWiFknOYVTd1+zsYhLpg8p8th2W945pQ1mIoced7OxClAzht2EJQFpLN2e2oPs0yMSWeB8ibBKuvomOxfacH9KOlO3zmyDbs1O3TSLmjDPvgUQUPWiVGCqLKR6Spo3MXg03fuoz75GTrsiOKOkm0JmHA3rwav4CWbz/4COlbmTlFNDe/emrX42o4lYB4SmtNRRwjpUbDgG9Amv6QEMkeRHB/HeiRepQLje8UaNlxW3zmnJmFEz3REA0eNDrn3w+mN/2NoQePCphVxDeTdpBQ4AwlanKi5Mke8+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHfFR1w04vw1CNYDoWtNtssxBrkOC5BoVpmRht5z3c0=;
 b=h8VUhqLw/ebR8HrsmcxtB+aMK3dhZqs/yB4f1f8uldYp5ai5S7D/JJFOSb9XKfNN1bHYotIt2Ee2cDpLfXXN91tudLjriU19l1vqnusgiJTHs54wCLXXHCKd/OoGOrF1km2LeTtCAMPoKqBVMhw5yDRCl2RzRtmeRIad7J5nV6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR2PR08MB4761.eurprd08.prod.outlook.com (2603:10a6:101:17::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 09:07:31 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 09:07:30 +0000
Message-ID: <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
Date: Fri, 5 Nov 2021 10:07:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Content-Language: en-US
To: richard.purdie@linuxfoundation.org,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Cc: "martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: 
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0202CA0061.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::38) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from [192.168.178.36] (89.247.126.158) by
 AM6PR0202CA0061.eurprd02.prod.outlook.com (2603:10a6:20b:3a::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 09:07:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75baa3f-7d40-410d-8667-08d9a03bb26a
X-MS-TrafficTypeDiagnostic: PR2PR08MB4761:
X-Microsoft-Antispam-PRVS: 
	<PR2PR08MB4761BE11A411AFF6EC0045A8D78E9@PR2PR08MB4761.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XhtmAY/lvCPmDIlZgB1hz2sqdcNG3HjHSPsb8G2tUXcK8opriaM+DOUvSl4bqnc3uYjL4vgRK9uHiBQZc7x7CBATZoj+MQa0jC+Usok0o2/55ibEvaNVIprFdb5VqdLdN8wN68rMrOSSA2pSND8lnbD/fwWpflN5XCN8eW3YR/IdaHpepdYqkwm0+tMizXX7BZnMQy7whaW9sLmvXDRkj4FnANWVD3hd5YBvpTpPWN/6ztd2Q9FoikZgbh2Ycko4Evxvtkbokzl3D7NCTjGN6ovnd+UgoFC04Wt1hfW/QCl2rf9OAnzjwjJCr4l01Y2UyHb84Z+Sumk3mXpndY0NcFfqGPXCXTtWPjXajsCaqjqoIy88dqvEurEVpm4MB5i+jB4gkuYBEp4pNAVFEU+SbTkaw4qwYDswNXMeK9DBXnT4v9o06WjaHzhAKNxcTP0oNXpb887UcGcbKd6rVDcK+K/0awpXuGYSiFPFYh1CfJ6E2tT7ToWeOujL4Mq6Ve1uyCuPDVCY95rzddOzl/BnE/it9Fq7uwBCecyupl4p7jp4SXACaocbf+ufcqBXPxRLjlEOrkS/ubZ/5Kk/F1NjCHQXh1JHKfN79AAN9n6mUDkLH3SkMdw6lzxLrcVd7BSZDtSkbLP5zQrFlDObnWeiVbWp1pNHNcbtg2P4EwZwttk/PrsVB48JlAc2CV2wYZH0RX5qAmALbEINUB5LL54BIWPE4iLXPeiN1QMNaWUjx8DN8cKlsABVi1Aw23Pr2XwsuicJlIFoGxA6c91KfY6Yyr8HWuC/wbxrXE/75SbwhCu+1oK2tztSkKQnt0bQffJNMzsl0vJulZCizryo0vcilBzc0z+CJn/MgEejvfbOXuGtAOnWC/PMVeDJLIyH5cEm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(26005)(8676002)(38350700002)(66556008)(86362001)(4326008)(5660300002)(6486002)(66476007)(38100700002)(2616005)(83380400001)(2906002)(36756003)(31686004)(508600001)(956004)(52116002)(31696002)(8936002)(16576012)(186003)(316002)(110136005)(54906003)(966005)(45980500001)(547064002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3VFZGFXc3JTaldEc2oyQmNPU3FSOTJZYlh2M25WOGcwNDMyUkJpU0ZrbS94?=
 =?utf-8?B?UkNUTWh6ZlNWTURRbmEybFd1Y0RLZUxhb3A4RVRDK3hOSnN2VHdLN0VPeHNQ?=
 =?utf-8?B?amY0N3hFZHJ2SW5DMXZGZ3Qydkoyd0RKdzFIWTdtMXFMRUlhNGtMT09yVWlw?=
 =?utf-8?B?Lzg3d3M0YTByZVNOUjFMcTZXWUxKcUpFNm50S0pMMEZhakF1TXJTQTZWQysx?=
 =?utf-8?B?Y3Y4aVZwTGs0bFZKNUltN1VlMFRzVkZTSjU0TXM2VU9SS0FyRmhxaVMrZ0xO?=
 =?utf-8?B?ckh6blRqdm5hVjMzSlR2TUxYUmdYdjUzNElaVEhwbWxHS2xmejhtM2VaZ3NU?=
 =?utf-8?B?ZjVKQVM4M1BpZTJBeDNwbkY2cFV2WFhOUGI3Y0VJMGUrSnEyTEtEdE9vNDNn?=
 =?utf-8?B?Y2N6YlkxK29TYVhTOUJFOURUMk5FMXhpM1c3aG5XZDk2bFRJR3E0NEp5WlR1?=
 =?utf-8?B?L2FGQzkyREQ3U2I1REI3WklpVzIyTXBkTzZuL0FUT3NPNGJTWnN0MjdoUE42?=
 =?utf-8?B?N2hzYTBiZzJtZWVYUmVaRTliYXJibWp5SFpKeWtYNWVybEpLK3pBWk9xbGJN?=
 =?utf-8?B?WGtSZCs5VXNBYXJteGhSS3F5TTFKQ05Ed1NwZlBpdHY4WUlDRE5lYXhreGJH?=
 =?utf-8?B?dmpwNDZSa1dobFJVY2dqaVNuSGoxYk13VjNabEdwb0ltZUN6S1llNExsNGdk?=
 =?utf-8?B?bGRDZ2Q5RTRIYUFDKzVSdWl0dmxLM3d1dVhhMG8ydXZvdjlHcEY3MkRUZTNk?=
 =?utf-8?B?NytscHRqT0xyWGlrK3dQdWl4QStDRzlndGJrMDh0dVlmMGU3cmY4cFRYWnFq?=
 =?utf-8?B?azdTby9wWXc3djNmZnJESjJRZUhxb2VUOFhBZkNXZkNiMlVFbExtY2tFb3RX?=
 =?utf-8?B?dUxsWU00TGJZUHJ1OUlYRWFwVVNpdy83aDBkbkwxa2ZKalV2eXVJZUF6M2Zt?=
 =?utf-8?B?cjRaZDdEcGpDSi94NDRQcnoyVFloTWUvNWo5cmtXYzhUYlRocTQrOUE5SCtV?=
 =?utf-8?B?Rzd5SEl6Qk1MUGN2am5QcDlEaFZiVGt4RFBYMWlKVllMQ1hlVjY1MWhsb1JW?=
 =?utf-8?B?emdudzJLa3FZUENCdnNSeFp2b2E4b0pRYlJyRGZOWjVxV0ZZOCtlVWtwZkFF?=
 =?utf-8?B?alJ4RWpJa2t5ck03dlBSKzdjRjVISTcyUHJEa0lib2NLZnZmQVRsYTRRZUpt?=
 =?utf-8?B?S1VaREFlaHI4bkVVMDNCVkxnNGdzbDBlbXEwYjF3L1ZXTnJFeDJYTmxhdEMz?=
 =?utf-8?B?Z2d6SVdMc1k0YVBtWkZ4Y0tLV3djcWVwQXBaUWdNaU5MdUh2di9vOWVSejU1?=
 =?utf-8?B?OE9HdGljaG9XeHF6WGZzdDBpbjc0YjYrQ0FKeUpVZUNHb1dKK3VuVWVoZXlu?=
 =?utf-8?B?d2VaWFVuSkJZYjFuM01DbFhsSDYxbEM5bWJTL0NOTENtTDhxd3R1aXBpUEln?=
 =?utf-8?B?Z0Fvb0VEc3JNNnRKaVFEUktxaWFlYWtFQy9rbTVnaDQxOUpmQWdvYjEzRjJr?=
 =?utf-8?B?RkV2ak5QaVN4cEh5ek13VXJQUnpoMFhGamZkWjl4SUhINVZFQ0VwM0RiSGwx?=
 =?utf-8?B?NTJjRDhKUm5KWDZ4UlFZLzE1Nm5WeXBuWkpITFpJeWJmK1hWL3pldCtGZE03?=
 =?utf-8?B?ZWFESEFURllnejhzemI5aU9ESW1CazVQUlowNGhOWDN0cFVUbjUxNmVjMGJM?=
 =?utf-8?B?bHRJekFPU3Q5ZDlsSEhxWFhiMFF6WW9FUjVpd2dkUWw2a2R5U1owOWdCU1U5?=
 =?utf-8?B?TUtObm5RZ0VSYjBEVXBrcEVUTW1yNlRuVzFOZzRaYnBPZEpKZTlmNmNnYWJN?=
 =?utf-8?B?YWlsbEVYa0RWSDA4U0xZT3hhcmIwb2hYQXZIWHBacjhOaVlkUUhEcm5ld3BE?=
 =?utf-8?B?YkMzVk9oN1FJTU83YXFnQlpPZy9jSnF0cmRIMkdMT1NhZzA3OVF2bTlValpy?=
 =?utf-8?B?MERRV2hIK3Z1QnBidzZrRHZQSHdzM1lyY3g0WmlhUUJNbHhkUVZZNjZmU3Fa?=
 =?utf-8?B?elpIMFlic2tUQlpnYXc1a2dTemRtSlh4Zm03bE1WM2JpSFpmdHg3ald0eDU4?=
 =?utf-8?B?VUcwL3ZJRm50RGtpZVVCbFlPSWxLVHNoRVhPbk1DcG5pQ0gwUW42dWZqcXpM?=
 =?utf-8?B?aU96aHF0M0dURTIrQXRpV041L1BnazN4YkRPdDh0dUUycFRMKzI1bVRybVVU?=
 =?utf-8?Q?JK7OLGAfTayxBwxE0JhFP/M=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b75baa3f-7d40-410d-8667-08d9a03bb26a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 09:07:30.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 EN9YytGdcG/XgpQlGwM/pEiUGGgRYcDPZPgg3ONkaJWgeTTdzoECyi4ycKGBH7c5Ccfp9cHCw6j7+MwxxuYX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4761
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 09:07:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12885

Hi Jasper and Richard,

Am 05.11.2021 um 00:15 schrieb Richard Purdie via lists.openembedded.org:
> On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:
>> Dear Bitbake developers,
>>
>> recently we have been looking at the npmsw fetcher and discovered some
>> challenges regarding the integration into the developer workflow as
>> well as the build times within Bitbake. We believe that we found a
>> mechanism which would integrate well into Bitbake's existing project
>> structure and drastically improve the situation.
>>
>>
>> But first, what are the issues with the current npmsw fetcher?
>>
>> 1. Let's have a look at a typical npm-based project. You'd typically
>> have your package-lock.json (aka shrinkwrap file) stored within the git
>> repository containing your source code. Developers will rely on this
>> package-lock file on a daily basis during the development cycle.
>> Unfortunately, the current npmsw fetcher only supports shrinkwrap files
>> stored within the meta layer or within an npm registry. This is not
>> ideal, as changes to the file might be made within the project repo,
>> which then need to be manually applied to the lock file within the meta
>> repo. An ideal npmsw fetcher therefore would support using the lock
>> file directly from the source code repo.

The package-lock.json and npm-shrinkwrap.json are identical. The only 
difference is that the npm-shrinkwrap.json could be published with the 
package.

>> 2. The current implementation of the npm class uses multiple shellouts
>> per npm module in order to add these to the npm cache. This is done, as
>> the `npm install` command is not called within the do_fetch, but at the
>> end of the do_configure step. This drastically increases the time
>> Bitbake spends in the do_configure step for a npm based recipe. In our
>> case (we have a relatively small project with approx. 600 npm packages
>> in total, including recursive packages) this takes ~100 minutes to
>> complete. What makes things worse, every change to the recipe and/or
>> lock file will cause a complete rerun of the do_configure job.

This is a problem of the sequential setup of the cache. I have a 
prototype to do this in a special bb task and use multiple parallel 
process task inside the bb task. But I have also a prototype which 
remove the complete cache and speed up the build significant.

>> As a result, the npm fetcher currently is not really usable for
>> production workloads.

Ack.

>> So how can we address these issues?
>>
>> We plan to implement a "sub-fetcher" for npmsw (a concept which might
>> also be recyclable for similar use-cases). This would take the
>> form of e.g.:
>>
>> SRC_URI = "npmsw+git://git-uri.git;npm-topdir=path_to_npm_project;..."
>>
>> The idea is, that the npsw fetcher would then call an arbitrary sub-
>> fetcher (in this case git, however any fetcher will be supported) and
>> after the sub-fetcher has extracted the source code into the DL_DIR,
>> the npm fetcher will create a secondary download folder as a copy of
>> the sub-fetchers download folder. Within this copy, the npm fetcher
>> will call `npm ci`, effectively downloading the npm packages by doing a
>> clean-install on the basis of the package.json and the package-
>> lock.json files within the npmsw download dir. This results in a much
>> faster build, as it removes the need for seperate handling of the
>> individual node packages, as well as streamlining the developers
>> workflow with the build process within Bitbake.

How should this support the download proxy? The npm ci command need a 
repository or a cache to work.

Furthermore you need a patch step in between the fetch steps to support 
tuning / fixing of the configuration before the second fetch step.

>> As this fetcher would be implemented separately from the current npmsw
>> fetcher, this will not cause any breaking changes for existing setups.
>>
>> Additionally, we plan on writing a separate npmsw.bbclass, which will
>> parse the package.json for each node module for an automated Bitbake
>> license manifest generation, which will resolve the current challenge
>> of having to maintain these manually, as currently described at
>> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#npm-using-the-registry-modules-method
>> .

This licenses will be generated by the recipetool and you could provide 
checksums to detect the correct licenses.

The license inside the package.json is only a hint and you need a 
license file to fulfill the license compliance. Because of this I remove 
the package.json from LIC_FILES_CHKSUM because it is useless for the 
license compliance.


>> If this is something you see as a worthwhile goal, we will provide a
>> set of patch files within the coming weeks.

I think you mixed the unusable npm implementation with your special use 
case.

The problem is that the current npm implementation isn't really usable. 
I'm working on this and have already a prototype that could install, 
build and *test* a proprietary angular project and node-red as well as 
koa/examples from github.

If I understand you correct you like to build a npm recipe that could 
change it dependencies without update the recipe except the SRCREV of 
the repositories.

> At a first read it sounds reasonable but I don't know the answers to a few
> questions which make or break things from an OE/bitbake perspective. Those
> questions are:
> 
> a) Once DL_DIR has been populated by this fetch mechanism, can a subsequent
> build run with just the data from there without accessing the network?
> 
> b) Is the information encoded into SRC_URI enough to give a deterministic build
> result, i.e. if we run this build at some later date, will we get the same
> result?
> 
> c) Is fetching only happening during the do_fetch task and not in any subsequent
> step?
> 
> 
> I'd love for some of the other people who're worked on this code to jump in as I
> don't use it or understand it in detail. I am worried about how we maintain this
> longer term as different people seem to have different use cases which sees the
> code changing in different directions and we're starting to look like we may end
> up with multiple ways of doing things which I really dislike.

This leads to the questions what is the desired way to integrate a 
package / dependency manager. Nowadays any language (even C/C++) has a 
package manager available and more and more build systems (ex. Meson, 
CMake) support automatic download of dependencies. The common 
integration into OE is a script (recipetool) that generate a recipe 
from the foreign configuration. The current npm implementation is 
special because it reuse a foreign configuration and translate it into 
fetch commands on-the-fly. This leads to the problem that common tweaks 
like override a dependency or share configuration between recipes via 
include file isn't possible. We could fix it by removing the foreign 
configuration and do the translation during recipe creation. But this 
means you have to recreate the recipe after every dependency change.

Is it a valid use case for OE to support foreign dependency 
configurations like npm-shrinkwrap.json, go.sum or conan.lock?

Regards
   Stefan

