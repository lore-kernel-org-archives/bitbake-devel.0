Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A794E7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 15:50:43 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.54])
 by mx.groups.io with SMTP id smtpd.web11.104815.1733759432622436209
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 07:50:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=B/d2QQmu;
 spf=pass (domain: cherry.de, ip: 40.107.249.54, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf+trR/xoAgDUVwoHY4bLB2W2uZ9abkXXissxEL6imn4vy3G8z431uvcvucR9cwdeD72S0BPDHvVznp+GgSxaS0m4LEuQNuplThRZSQfTI04R4wzQ7gut/I78THUaJw+Up15O3FQSZVo0OtNogBToHc2l8mQRML/xEh9LfsD013Mi5Xfd//QEMIob+EpaivISx2ofsmcZAOtm1nN6jwE7uIouqpApO0Jh6Od+HzFaUavP57CFstxbCJJ9LwxEailNjA6EkjPuIg1Gv5K1PfYC8AIJfKT7t2vV+3rWtnzBWQgLMR9ho6qMFv1T4xWcSF+YdBm/m8Ot8iOb2etx66PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXu4dMKGH3Z906IgZFES+y5lHYVdpiYokRyFQbTAiRQ=;
 b=dHhrargs/oWEHaF+ucQYny0m2ziaiz+h5gtkQXYOCR3ns4I+KDJGvng19csRe6z73wsA+7UPLn5kn0sjMKJxqSnCIYW9jpJYVeJNgAZOvqR+/TsQBca0q6+W547zxM4O8N3GV0Z+IehNfHMNK6XBXhHUjoZyu5lqyF2/erd4FMs3Rj7JNS4CrO9/YU80RO3rUcttOE0auzqRBappPTwYV121jHZNfAcYU7h0lQmwZgsa8B79f8W3xlHIIdQT+ZMhbfFW7L21irjMFjpyEZUEhen7eCxbjIxZx6EEFJAsjQL28b6p6U+WFiDk29aPrU1VoHrvdLV0KUmE5alll0rvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXu4dMKGH3Z906IgZFES+y5lHYVdpiYokRyFQbTAiRQ=;
 b=B/d2QQmuCQv0Gt3OYthXo1f9p0ysQSua3d9+EdDYQXdjkSOhRM8Lv8kmQJhB70idVHSnPawpTo0dNh4hQsnSbvs9BErDde16/EeJOl5VsQAMJLL2vtQ/8E/2sMJqtuLDIYvyTpO4xZE1QNvvmaQXz2kU8U0wQv+kbadi+hi82g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:50:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:50:26 +0000
Message-ID: <36c6cab2-e348-4ad6-9ceb-4692f177aeef@cherry.de>
Date: Mon, 9 Dec 2024 16:50:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual-metadata: add
 a section about 'addfragments`
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org,
 Alexander Kanavin <alex@linutronix.de>
References: <20241209133053.2494088-1-alex.kanavin@gmail.com>
 <e0d3f4c1-f252-44f4-9e45-dbfa13b41996@cherry.de>
 <CANNYZj-LziSwSdKMCTkRQgwzHBM_TFoZhkKbx9Tvcf943zBS8Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANNYZj-LziSwSdKMCTkRQgwzHBM_TFoZhkKbx9Tvcf943zBS8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VE1PR04MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 8277b905-6a33-4dbd-9dc6-08dd1869331e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SXBZOXFnVlEwbCtPZ1dUeVQrODZyTWFoV1lNelg2WVVyYkVlYlBMNFB5Z0pk?=
 =?utf-8?B?MEw0TGJseWhUbDMrNS9KNGhJbFVaakVXNHAzenFuTDQvazVNaUxTbE8zbmg4?=
 =?utf-8?B?R21iT2NZTSs1VkxuODdpa0o0dlR4dklzTHdhSUhzVzlRUHhQbXJITHV3M3NT?=
 =?utf-8?B?ZHYyRklLSzREN3l3TjNKWmg1aHYzdEFJaTVkL29oN0ZFbGN1QWpOc1Bta2V5?=
 =?utf-8?B?eTRRQ213RCtmQWtHaGJjSW9hUDd1NkZyc25zejZrOXVldWVWR29YUXFZZzY1?=
 =?utf-8?B?YjJoYThHME9PSU90elgxSmkwQTVWdWp2SEVRbW5XVFk3ZThjSWNYRHFSeXlF?=
 =?utf-8?B?Rk5Jd0Zrb2RIL25ZM3Y2czhSRkJWNDd1Wm9sbk50WWRYOUxZQkp4YmNiMHVC?=
 =?utf-8?B?ZFVZbXpZLzNQMmg2cnV1dXNqWnpJUGVJTWlPWDFRYUdKWHNuT3Ava3BsT2Jk?=
 =?utf-8?B?czZ0UW0rYzRpR0NKNjRpVGRlamFmd1VBTnY3VjNoVDBUeTAyMENmbVMrRFNH?=
 =?utf-8?B?ZjRUVzZQZDdCbS9pcUdoT1NsVEtSa1BsOTR3YjJrVWoybGw4dnpzakxKNEh2?=
 =?utf-8?B?VkF1akkxdUZoNm5ZRlJrMXo5UldzelhPSnNFUVBsR05DT1hOdDRuS25nb2Ez?=
 =?utf-8?B?WEgzSStFMFd0OG1lVmxvNzkyeTNsNW1nczhSYkR0YVlFUTBQTlhPaXdUdG1V?=
 =?utf-8?B?Z3RkbzJWN2c4Tnc5SWt3cDdiM01kYnFaY1BUc29ydEdzS0IyL0JSazZibHR0?=
 =?utf-8?B?aU1ZR3NJcmg5RVBLNnpqNy9HVnJ3czhQeWxaSjhJenVQcjlYSnp0dFVpcjR1?=
 =?utf-8?B?KzhKUTViNmN2TlhYRFhoVDVablpsSDkwekZTcEZ6U21GM1JoVW1nT1M5NFJ4?=
 =?utf-8?B?Um40UEN3YytWVkFxdGU3N0Y2ZTBBUG1KbmVGbFVKUGlWMVAwdVV2cW94UUZw?=
 =?utf-8?B?TENjc2lnVklyWVhMSG5CVzJaT0Z6U01oRkJJb1ZYbERBOUt6YkhDYVFDaUdO?=
 =?utf-8?B?OUhKcDFtZXA3Y2c1WGE2L2lmd1lkZS92QWxjTW50M0JYN1R0OS9sanExcWpF?=
 =?utf-8?B?Y2FKYnpwQnlQRlZFV21pUkdnR216K2JISkIzbnowSGt4ajBWUjVOQkRBK0hR?=
 =?utf-8?B?OVlNQVVJdkxQRmF0Q1dvWlNVRXplRm12SFg4bmFQUEdYZVM4NkJIbmwwVW5y?=
 =?utf-8?B?Ui9reCtBc0x0RVdPMDhjL252OVlNUmpLR0xSQmM0RXc4NjU3UWp6OFBGZWdq?=
 =?utf-8?B?UXRleFlpR3ZBb28waVBCd3lTcXZMaEJjWm1zd3NyZjljM21Va1prUytWSDNE?=
 =?utf-8?B?U0trQVVoenVVd2xhQzJlNTZMdGVIUU8rKzVrQUYzeUdaNzRKZEtWVUFWdlE1?=
 =?utf-8?B?TlBjMllNcGNkd0tYQnZETlAvdUkxWWtHdU12ZXc3dzRMK2tUQ0N1dkhFeXBq?=
 =?utf-8?B?d0l2TXljdERqWDNwQWEycEdVdy9CL1J3MjZ3RCs3QUxpckhkeVdkRVpBVHpI?=
 =?utf-8?B?eEc3bEgyWUdFcFY0b3M1L2xiSEYzWGFZQXNqQjBFc3JSOTl3TUpKMzhyWlNk?=
 =?utf-8?B?VXZCc245MDB6b3JPeGNNTldmWWplTXFPcVpPZ0QvL0xIeDlMOXNyaW1EM2VK?=
 =?utf-8?B?WjN1Z0wrb1AwQStMTUxtdlU5c2dZazdaeWdEaVQ5RER1WU12M3VOelNsc1Zq?=
 =?utf-8?B?eC9OUUlVUWl4TDVWb09MdTcyaCtKQ05yZWJ6MzlIM3RZbXp4NXo2WXpaZkJY?=
 =?utf-8?B?UFdycytMRUVXTEJ5TUdOWFpBSVNrdkFDUWdteS9TWWxyQWhlVzZoN0Z4VlBD?=
 =?utf-8?B?WDViS0Q0UTlvN3RPUG56dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVlGOFlRR3FDZFZHTVRXT2hGRE5iMWxoSGkzSDFCRGtaNnBRMm5yNlQvMyt0?=
 =?utf-8?B?anJldGpzQzR4Nk1Pc2lQWHByRDM1V2djNDh1ODR2OHdSSlNIWHZMMUk2QmVQ?=
 =?utf-8?B?QVdmamdyc3BTK0dmb2ljcVdpMDVQOVlnbnc5dlpxQm1sMkZFY0ZEbzliSm1R?=
 =?utf-8?B?ejNWVGFiSFN6a09mMFBhSDh4RHN2Qmk2cU1kN0lwTGxBbzdubDdSWXFFZlg1?=
 =?utf-8?B?c1oxWnRRWUQ3dnFMWDZGc3UvaXlGMlFqTU11bGczZnNIckg0cXhRMW5zUWlp?=
 =?utf-8?B?QVA2K2doLzF0ZnRKMVJKL2Jvd3k0WEVCSTl4Z1lVNHAxdGJIc3BxZUhveWpq?=
 =?utf-8?B?V2tudHA1dFdTaTk2VkdlUmdyWndpVWdtSVVna1M4aE5ONTBQUWFmVnExMDRa?=
 =?utf-8?B?NVJ1d2xtL3Nib0RScUZCR0dDVi9pL0hNMk8wSzArQjRqZFBLczV3MVFNb2VQ?=
 =?utf-8?B?VC90UEdBdXZDdnRvUEZaQmR0WEFFcmRyY2xtSmhqUUlyOWhQQjFqZk44ZUhF?=
 =?utf-8?B?Wm1icFVaUGZQdFR1dGNGeW9HeHlobENFZEVhejlmUW1yNHRhbTIwU3MyNUJP?=
 =?utf-8?B?Q3JhZDRyc2MvbjVSbjEvanNoUmFaN0hxdmx5c0NzbmxuOVRBMGJNK3NGOUJH?=
 =?utf-8?B?bisza1FiNXh1T2RScW5TSVEzQ3BSWEJiVTZoMXJ2enAwSmsrR1BSQ1Q0WWdn?=
 =?utf-8?B?K2xaOFlyMFRhU3lSeDRGNkJFZXYyc0JOc1ZIR3VzRkFUcU1WMkVsdEQ1LzQr?=
 =?utf-8?B?bkdNYXlSemJTMFlsUlkzTEI4Q3A3cWxSYWJ3aUtqOEo2V2RmU1NxTjhFUTFa?=
 =?utf-8?B?QjI5UVloS2EvUTEzM2ZHTUtnU2JURVZUa1FSemNJakY1ZVVQd2lMWnpvRUYw?=
 =?utf-8?B?dTdkcUs3U1N2amQyOThmY1E2Y2JWV0FsK3JrdVMzZ2REUlhKeVlqVnUvNnNk?=
 =?utf-8?B?OHQxUnpBZU5VVkpMOU96aXAvQndNMVN0YTJXR2JxOUs2b0I2Mjd0QkRkd3ZJ?=
 =?utf-8?B?ZkhzVFphMFh2MnJhVk9OT0twSU5SaTlab1d1bmovbk9keUdOdW9TSmVibDRt?=
 =?utf-8?B?Y1k0Y2FiSXJWQ3JKVk1YSG9udzFUazRMYjV0dERXMmdJb3ByZXRwRVZSakJK?=
 =?utf-8?B?czV0VWp3eXh3VnRjRFpoenljbkFQS1Z4UmViVXVyRXBhUWFWSC9nM1RqelBo?=
 =?utf-8?B?V2hLWmpUVjNsMlRzK0hPR3pIemxlRng2ZVNHZzZOYXBVNi90UlVOYzRnSVdG?=
 =?utf-8?B?VGp0RUZja0kxWVZvMmo2OUwyUm5NZHN2UUJyMUNjQUFES2IyOEo1ZXJkWUtK?=
 =?utf-8?B?Tklidm9UZ25aWDY0c1ErSVF1UU5PUEFyODhXMVU5REtHMVVlVlVMc3ZmZDhI?=
 =?utf-8?B?czdCdlBhOWZiTmdMK2lCU1Y0akg0SlIrYnpPTkxYdTlzaU1aZDZkbFVnV2Zy?=
 =?utf-8?B?SEtlR2pBUHZNMDFPcWN1aWZ3cmVOdXJzWE5qbWl0TVFlUzRxSjBLRUxlOXdJ?=
 =?utf-8?B?QUJUeVFxczIwZnZqTGNjUlk2dkV3WXdSZjVtenVINDExaTU3K3RNRGM4TkJF?=
 =?utf-8?B?bE5xQU1jdGx2R29CeGxpNi9UemhKWENaWlNpaHpWWVZVOEJuNWhJN1JmdkxG?=
 =?utf-8?B?Ukovb0wvbmIzK0Q4QVVYQkFKWXR1eDBmUm9GVUhmTkhvKzBVVHlrU2hJeElR?=
 =?utf-8?B?Y2lHeWFWMUIxQ1NRMXhJYkVRaHJ5Z2lEVysrYm9paWlqWUVRd2FyQVNOay8x?=
 =?utf-8?B?aTBNK3Z6aEt1Q0JaZncrWldvQ0U5a0krc2ZMUGVzbElNOTZ4OGROS2tSL25H?=
 =?utf-8?B?VTc0Ujd4aWRRNHNKR2RTNWNFSjlvanlqOGVKS2Vkcmo4VXhRamxuY3NwS1lD?=
 =?utf-8?B?UUtpeUUwNmdGSnpNcE43ang1NjFWMlJuYWJIK1hNM21wbVZOejg2UWpPSGlP?=
 =?utf-8?B?eThYdEp4MWxnWkplR21jbHZCWmN5VzlWUE1ucE93TGUrUExrUUIvTVVRM2FD?=
 =?utf-8?B?SzRHalNXOVh0RkF3WjJiWFlEWE9JMTlHNVg5WkUrcFlCdkp1Rys0YlRaNURP?=
 =?utf-8?B?b3E2OTlRSGtneFRlY1FyaEpuQ01ObGw4MXVYTmwvRm13N09OLzhHWGNJcGJ2?=
 =?utf-8?B?RVp2UUorM2crS0ovNFJiVU5DLzVJeUdXSlNqRVFkTmsyR3luczNzcnBZNWg5?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277b905-6a33-4dbd-9dc6-08dd1869331e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:50:26.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ratVYa8NPFdjJ2vjNY+Ot1O666Qpq6+Lrq3THmwqZuf7mLCxWnjiOqKTdx6+KRNn5ArvZ0IFURzft6Zh3/Wxdzbvzm/E+FSuITNf76y8slg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 15:50:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16901

Hi Alex,

On 12/9/24 3:59 PM, Alexander Kanavin via lists.yoctoproject.org wrote:
> On Mon, 9 Dec 2024 at 15:35, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>> +
>>> +   addfragments conf/fragments OE_FRAGMENTS
>>> +
>>> +``addfragments`` takes two parameters:
>>> +
>>> +-  path prefix for fragment files inside the layer file tree
>>> +
>>
>> I assume you can addfragments a fragment from another layer? So that
>> would mean this is a path relative to any layer's LAYER_DIR dir?
> 
> addfragments in itself does not add fragments to a currently active
> build. It declares two things:
> 
> - what is the variable name whose value contains enabled fragments in
> an active build
> - where to find the fragment files in layers when bitbake is going
> over items in that variable and transforming them into require
> directives
> 

I'm suggesting to make the explanation a bit more thorough about what 
the "path prefix" actually is. My understanding is that it is the path 
relative to the root of any layer, i.e. relative to any LAYER_DIR.

This answers the question of "where should I put my fragment in my own 
layer so it can be used with addfragments directive". I could have a 
repo with multiple layers for example, where do I put it? Is it impacted 
by BBPATH?

> There's an example below that shows how the transformation from
> fragment names to require directives happens.
> 
> addfragments is not something users of fragments need to worry about.
> It's set just once in bitbake.conf, and the overwhelming majority of
> yocto users would be using bitbake.conf from oe-core. But it needs to
> be documented as a bitbake syntax item.
> 

But it's a directive, so it can be used anywhere if someone feels like 
it? Today there's only one user, bitbake.conf. If no other file is 
allowed to contain this directive or that only a specific kind of file 
is allowed to, we should document it. If it's usable in any file... a 
usecase would be most welcome.

>>> +   require /path/to/core-layer/conf/fragments/domain/somefragment.conf
>>> +   require /path/to/core-layer/conf/fragments/someotherfragment.conf
>>> +   require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
>>> +
>>
>> Can you tell us about a typical case this would be useful? I assume
>> there's a reason this was implemented :)
> 
> This has been discussed on various mailing lists many times, you can
> search for fragments to find those dicsussions. In bitbake docs I'm
> only saying 'This directive allows fine-tuning local configurations
> with configuration snippets contained in layers in a structured,
> controlled way. ' and not more. The actual user-facing documentation
> for fragments will go into yocto manuals, once the remaining pieces
> (tools and tests for them) merge into oe-core.
> 

Can't we have nice things in the BitBake docs as well? It is technically 
usable on its own without OE-Core even.

I don't understand why we should actively not document something in 
BitBake user manual only to have it in YP manual. Not my place to push 
for anything so will let maintainers decide for themselves.

Cheers,
Quentin

