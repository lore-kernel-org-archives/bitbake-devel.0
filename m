Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AB2E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 14:00:49 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.136])
 by mx.groups.io with SMTP id smtpd.web10.48217.1736431244371113689
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 06:00:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=jd6pDH/I;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.136, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/iPVIkGn84W6c64sqRDVMoUFe7HUd3l4SEPn8FugKlKNeGn25gN6GiBS0Uqb2ZCgZhb4GOK9fUxDZQGvcYlAR8IjofvXSNr5thZRg08DCJxgcQVtGhJCkU5ELYxaZZUrx19DldvHMnW7sfO3cVifOKCznwrj97Yn22RnI/FsFV7mA0AlZWmg3Q7Q6ScYTArHbsFqZoSLVmNa0iULkS+3gwCVXSk2fGiNMEVCHO782L8TJvqg9Iwp4DcJQvKxXEvOCY6h7jJ5GyzGS6K1QICTmrHSwGn5dkZuwIl8w1JjArKOrKD27xpshQ8i3vN0WMd8+hVUb4KmRJFVYCwMbyNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVpkgBiWxDd3KdcS+ZPe21xGOOc6ITwYnt2GnQRdTNI=;
 b=Gx8MTXVS5vNvJ+H4r5SeiYY1sIBbOh88Xw5bXZPxt8aHggeU9ErB4nfzvXH2HQCOSYlPBoYiyFCJSdXZNF/+ECU2BbeLUB+nM+qTlk7NT0RwbPMiwgNfpRPlx4vZCfUuAg3vR4w2Y+FnHDLvPPO+XCBMrQq0d5YtXeDQroLDLOAFhIUPKJUuW9NdewY3bgaOW5u/DQ5g06bG2myCv9OPPVE/jO7qw4TqubU7AoI3KHcMD3dy47BDg6/Eu9iCXGDulchN4kOJJgIj5b5omakhxTlK1A3yt7xQbeKejjQHedaGRvjFipWR+Re6u2iYmxxxZfsbhU/MpxcO2yQW473Lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVpkgBiWxDd3KdcS+ZPe21xGOOc6ITwYnt2GnQRdTNI=;
 b=jd6pDH/IHQftjEtMl9HnXLa60IkklyFfEOpZS00eO84vDXcbhR8YitCEHMoeBlMk0A5312Ccsl53Mg9XkUF+hGwj+UXArE4qG6qyKPBG6essjlDuYSWVdMFO8qa0O7uV2Hsa68WqSHFmb5CnUdhVbVJmffVboy8nNTG1tDZI31nc39pVwOD/aBhZnK8Bs+0un5JWC3G0m1yX0qu7fbowsBzvjKNoqQAM+9haJkxA5ALOcv06DN/mn0GTIQNLxZBw2wd5V3G0ksqtli29Aj/Mhqec/m6Qr0Kw+miP0hooMNan3HSy32Iv+RBAcGjXNwTBwKyrkjSuYVLRxBEmL0j69g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PA4PR08MB7409.eurprd08.prod.outlook.com (2603:10a6:102:2a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 14:00:40 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 14:00:40 +0000
Message-ID: <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com>
Date: Thu, 9 Jan 2025 15:00:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com>
 <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|PA4PR08MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: d088c3e0-c1e7-4b70-5539-08dd30b6006b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MlY1ZWpUUnY3R3NxbmVDbWlaN0xXdnNtd1VGbzh1UnZPUW5DcTg4ZzhUNml5?=
 =?utf-8?B?K0xsYUZMdlFnRjNGazh4SFQvNTJRcDFoUEh4YkNoSW1LcUtYMElFWk5NTks2?=
 =?utf-8?B?dWg3T0tZUjNkT3RDOUwrVGQrbHhNQXlEcGxmdS9RV0tQa2M2MkJKZG5DaTBF?=
 =?utf-8?B?ckNiM0o1QWJ0VkJjMmVUTXJCYVBXZDZQd2x2OHFCeFc1VnJva3piU3hzK3BG?=
 =?utf-8?B?Tzc5REFMNkh1NytEcGdBVWVPYXl3VlFGQVJsT0JXZDFVQUdKZlR6V0kybjhK?=
 =?utf-8?B?c2dEZTJHYU9vNnh4Zk9GY1VNc3M5Z0dZZWNNTXdsNytZd3Q3VFhTTDI4Q2F2?=
 =?utf-8?B?RDRzYnhiOHNsSWREZTFicDhYVzA2S2NRbGNlY1BpWllhbWpXdWU3dWkwcDJE?=
 =?utf-8?B?WDBBMHVDOUphaVdPb1VsQkM3aG1Pa21WNURZeDQyc3JGRzBhZ0JieXdWWGQr?=
 =?utf-8?B?b2ZwZnRhOGN3OE5LdmliS3lwNHptUkNHTENkaUxSWFE0SndYNTJKTzJBUGZ4?=
 =?utf-8?B?RzVkN09KMUFVKzRDWHJhWWpZU1EyeDhqU1NuKzR5Um4rOTZQTm50L2M0dnhN?=
 =?utf-8?B?QXl6Y05rdDZPb1V5VlJTZ2hLTi9HcXBvUzhTZjh2MitYL3h5OXBMS0dMRTFF?=
 =?utf-8?B?azRxcjBpcTRNd3JwRVhudjBnN2t3L0ZQMW9saS80V2c2N3hlWGlXVG9EL08v?=
 =?utf-8?B?cDBUZUlwUVJqMzNOWkRrSWQ5WTYwaVc0bzNhMk41OWdyQ1ptR2w2d0FkdGpi?=
 =?utf-8?B?TEV1ZldwbDJFdXhWOW80RzV5YjNGNW52T2ZkWThsZzYzTHdEU200bnpwb0w0?=
 =?utf-8?B?ejNxdS9FZVhmTzhWOUhzNkk1QnI0NnlyMTNlOFZkc3drOTQyMFhiQSs4d0tl?=
 =?utf-8?B?UFZCZDVSNXVHS2FnS1hkYlRlcWUzeldOWlZaMVdoTzE1REhaSzZIZ1htSDlq?=
 =?utf-8?B?dlRmUTh2RnFxMnoxT2dwcmdxSVh2TE5jMTFrVVRqSzVSZnk5cExaa2R3bldl?=
 =?utf-8?B?NElOOUwrRURXZUtiSTZ3MkpIS2doNUpvL2U2ejlnSERCYUZFWm5qeVY1MUV0?=
 =?utf-8?B?RlQ2eVk5UEJiWmpIYUlYbkZVWXR2cDVGeG04akliV3hlQ1J1TzFGMUNyNXVS?=
 =?utf-8?B?NVVJUmFQenlob0VyUzgwSEVmdXN3NEZVRXpXRHJOOFloV0paMlhRTnJlbXN4?=
 =?utf-8?B?U0x5MVdhYjlTN01VeFpIODhiVmVidGVSakFUbDJKcW5JVU5sNXdKbHVCMmls?=
 =?utf-8?B?V3YrMm1XcktDM0kreVZ5a1RiUHlWdEpzZWtwckxEQjB3Y2diU2YvZjhBV0x4?=
 =?utf-8?B?a2lmK3VwTnc3UURVdkdwbE5zbXpKNTdpNHI1U24zUXN0Ky96REQ2WGxaUUpT?=
 =?utf-8?B?d29XUzg1N0RhVU93YXM4eEk4SHdhRjcxYk9EV1lvNWdIT3NCNHVQWk45R0Z5?=
 =?utf-8?B?elluN0NGZllXT0hjdjR2OGl1ZFF2eWtQWXNlYnlRN3Zaa1dobldGWll1ZmZF?=
 =?utf-8?B?RS9vRk93QW45a3NiVGNhb3NJdkhMSUVlSXpKNitXTi81K1dCU1poOXQwV21k?=
 =?utf-8?B?b09QcVJXamhOWm04dVVZV2VZWEkwcjZmaTNPdmZYY2lWQjJzT2N0Zml4akVC?=
 =?utf-8?B?bzBhTitLT05ZckZUR0VjZDR2bjJvOWZ0eXBOenBDbkQ5Qks0RGx6ZVpuTUlG?=
 =?utf-8?B?bXF0Z3labFNUa1dqdDYzUWtSV2xxZHBGSTZSL3hxRkxtV2I2RWhpVkJrWFNm?=
 =?utf-8?B?UWE2Q1NsQXlkSC9uK2VYS0xScmNGWXIvRWJwM3c0YkFJMHc0Zmh3SlJJbGRw?=
 =?utf-8?B?RE5DZUVlZnI4SFN1ZUoxUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXBYeVh1aDVpN2liaW1ZcnN2a3V4WEp6SmZzRGdiUm1yR29COUZlY2oxQlB3?=
 =?utf-8?B?Rmd0TTl6VjhjazVLNVZNSDRUVVFRai9SSHVmbUdWMlpQQVBNdmlSSDBlUFJS?=
 =?utf-8?B?SnB5WStmOVlyVW5GU3B6b2Jkc1lBM0pwR0NEUDFqejdQMDdkdHBZeG10SU41?=
 =?utf-8?B?ZzgxcndzMmRSSEszSkpxMHo0aTUvVklGekU5b2NMWnQ1US9neUdJL3NTdmlK?=
 =?utf-8?B?WnFvUitaZTg1MisvMFQrL29CandnMHJGa0NTTDIyWHNHbmVKR1RFOC8xYUEy?=
 =?utf-8?B?Ui9vR1VMRHo2aWZmMGZQU3d3TG1SdVRhZUVRdEV6VXkyNHdTVXZ6dHJHelFQ?=
 =?utf-8?B?eXhVQTBkL3VJcXZJcStPbFUyZ2lwTjFmNEN6K0FlRHEvbVE3VlNOLytHZ3Nn?=
 =?utf-8?B?U244eHhSOThvUkVxSGE2dERoSGJEbXVSeU01eVJVV1ZtcFZrMUNBcVJ6TEtX?=
 =?utf-8?B?OHdmLzNxbkZqUEZWVmUwZ2tDRCt5ZVhYYXpBdVRDbmpoSTFxbkVFM256WnNZ?=
 =?utf-8?B?dHVzSUhNaTZoczRvNmxaTFRZTzE5ejNaejF6akVjNEhmbXNLOXZHaGJZVTlk?=
 =?utf-8?B?eVBCbk1qajBHeGE3eTd4UDloRHN2dHY0ZUZJb2lBTEc5Mjk2ZkhINEs4ZDA3?=
 =?utf-8?B?aGNqdUdVWlg3Tk44S0JYRDZ0WHpScDROMk4rMTJpeWZVTzNoa2dCNFRhMzhr?=
 =?utf-8?B?TkFMMHhrUURPdkI2REk2NkEyTlJ1ZVEvbnVHT0xEYUl0Z2NoenVUbmFTYmho?=
 =?utf-8?B?NnVwWG1vVXJ6S0M1aWo4bUd0NEtUUEFhd3FBQUtFdzlzd0YzRThkblVteFJ5?=
 =?utf-8?B?NExCOUhiaTkycm1nRGJuV05HUkdjM0t4Wnd4THRyMG0vNVRTRU9yNzhLQ0hr?=
 =?utf-8?B?ZG5SZmcrcmhPSWY3WTdBVCs4S2NveEdMOXh4N2UxdEZyZjFud2M1aWJsY3oy?=
 =?utf-8?B?OXFpTmVpZGdzejBwWEJOMzRRcmRFYlpLRUR3ZU1SdVRHT1RxRFpsYkRxNk11?=
 =?utf-8?B?UVBWVmxQK2ZPcThRVHorYTRmVThBWDVCNnBaM0cyWmRWOUpmSkN4bUd4c0NP?=
 =?utf-8?B?LzZrNnFIWk4zKzR0OGw3cnJ5Z0F0Y1ZjQklqZ3Z5cWdBMlk0Y01PSUdKajRs?=
 =?utf-8?B?ODRDd3A0TDJEeWYwcGVBSC82d3RaVlZoN2l5VG9zVDREeDV3R0pab2FuM0Fy?=
 =?utf-8?B?VDFZN2RTejdzZ2RUVjRFc2ZGUDVKTDFFc0I1eG5zQVUyd3V3Uy9rRVlscTFp?=
 =?utf-8?B?K1dHU1UwZW9wcDNBMmtGYUVNUml1Y2taNWtNNEtIUWVYSUh4RC9lNnRXTDFl?=
 =?utf-8?B?TSsrZHErRmNGMXpVUE05U2FxdG1WRkIrUG5PNjJQeUdPY1pHeHIyZDdORzcx?=
 =?utf-8?B?b2dmUUNDeVFoWGZWbmxoTngxNDZJNExRSkQyblJRay9MdFg3akdyOFdwblF3?=
 =?utf-8?B?ZWd6ODZpRnA3bkhOM3ZSalJ4Vmk5R0JDa1JJcjllRytjRG9Rc3M0SncvVCtz?=
 =?utf-8?B?bmdKZEV2bWNHT3lLaW11b0VQTjc3NHlTQU9OVThpUmdzOUhFS3RRNzlodkFr?=
 =?utf-8?B?NnF6RkxhRC9adVBVMU9RNDdqdWwwVTQ2Yno5Y2NMa2p3Sm4zeWJkbzVmK2hE?=
 =?utf-8?B?OGovcmpkVkNObVdGWk8wcWt6cVhKTGpJdGphV1NwZDRBTmRwZmhPNkdLcVBR?=
 =?utf-8?B?MSs4bzlHTzRkeEZsdys2ODUyTEo0dmpORUlhWHByeDJ3Vk1NbUpJalhTTkdm?=
 =?utf-8?B?UTZycGdJSzR5K1pHa015VW8yOXRrTFVvSHgzQlE3dHBqY2V6bkt3SzV2ZGZq?=
 =?utf-8?B?WGQ2TnFZVVN0WHBVc09iZmRPcldpeUlWTHp0QVVWa2plOWVVVzBNNmh3Q2wv?=
 =?utf-8?B?VGFlcEhPeUs1eWdOZjgxL2MrdmtpUjAxWVMvMDFJVjJxTTY0dG1qZTJScE5t?=
 =?utf-8?B?YXJ3cDJlWjNqWUYwOFQwN1ZDbUhhNXQwQjNjS2xVdG1MN21YN3FCaTFuS21h?=
 =?utf-8?B?eTdaVCtMZHdjWlJxUGpjYXdUekdIRGQ1ME5MY2l3Qml2Wm5nWC9KSklncFB0?=
 =?utf-8?B?ekxYMEJaZk1NQWIxMzFoSTI0VGpNbGhWWmgrNUtlT0RxbjJhQkhxWjJJby9Q?=
 =?utf-8?B?SFllNm5ic1JERkcySGdlalJ4TW9aWXJsN2htcldIQVJYaU1DcDIyRE53QzlS?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d088c3e0-c1e7-4b70-5539-08dd30b6006b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:00:40.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d34CwtxYt4CXXg/3/B8qP5xJRvWCZeCJfPSTxjBFSyEXH3NF+vVxjb44Y2bfzxtqKXiwqhZ3qhTn7g39rG1hTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7409
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 14:00:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16996

Am 09.01.2025 um 11:40 schrieb Alexander Kanavin:
> On Mon, 6 Jan 2025 at 15:43, Stefan Herbrechtsmeier
> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>> https://github.com/yoctoproject/poky/compare/master...weidmueller:poky:feature/dependency-fetcher
>>
>> I have migrate the crate recipes to the new fetcher and improve the spdx
>> 2.2 class to include the name and version of the crate dependencies.
>>
>> You have to inherit the create-spdx-2.2 class and build the librsvg
>> recipe to test the new fetcher.
> Thanks, I checked out the branch and run bitbake -c patch librsvg with
> the default build/conf/ config. It works and the recipe is short and
> neat.
Thanks for your test.

> I'm not sure what create-spdx-2.2 is needed for? I didn't use
> it, and there were no errors.

The change is needed to add the dependencies and their names and 
versions to the SBOM.

> Like others, I'm torn on two things:
> - visibility
> - control
>
> When a recipe explicitly lists what goes into a build, this can be
> easily seen, audited, and adjusted directly in the recipe. With the
> new fetchers, you need to actually run a build to produce that list,
> and it isn't clear where the list is placed, in which format, and what
> to do if something needs to deviate from versions prescribed by
> upstream.

I missed the appropriate function in the dependency mixin in this 
series. The list is created on demand (see archiver or spdx patch). 
Every derivation need to be handled in a package manager lock file. 
Therefore you could place a lock file beside the recipe. You could use 
an editor or the language specific tools to manipulate the lock file.

> This is not a theoretical concern, I'm thinking specifically of
> log4j-like vulnerabilities, and how one would check that their product
> doesn't contain them:
> https://lwn.net/Articles/878570/

Do you have any tools to check it at the moment?

I proposed a common style for the package name and version parameter of 
a package manager fetch URI (ex. crate). The information can be included 
in the SBOM and used outside of bitbake. As a follow up we could use the 
information to create a CPE and add the dependencies to the cve check.


