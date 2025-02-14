Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFFBC021A6
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 12:46:19 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.105])
 by mx.groups.io with SMTP id smtpd.web10.20223.1739537168057516288
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 04:46:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=XEsktmK5;
 spf=pass (domain: weidmueller.com, ip: 40.107.105.105, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGBCtTs9MKCUh2afpVlpkaT8+IzG3PbGSHqqfDOf2oiYmASGM0Gob1Qnbicu2FeBi2kIIQQQYBTAqWgfSYjXIwQA8z9rJgFOwkqHuYe3X4hFmo35EC6WfxGszT+xe/s5oZLzVKPUvVQA5yKh8GUz8n3UA8UcSThoeMc4gYPVBWRhk8C4Y3vIO8UYuVyLCgelV+syF1ye23kfNfJKh5pl3T2n4PsriQ2SM8PUvNUJhrnsRhDESHalN1MqQOZAKBNOFtpRpTfCHwqRatiI6LS/7WmyQt3HZSMuU5aaQQsahMrsmpSBjR9i1mLGGadxnJdC4ZdyfFiZvLhNvy3yk66YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbi4HJRCyYDdyTaOC74pB2fO5kccwpOzh6tm1q36ND4=;
 b=ywZcgh7XnqZ3u7dcnRBcmpYvQdjc0F/WWG1HAR9zX1w7CRWHQaAwPJl94/6ITz9Mfi07G3S6BBbHjs7TQJEsdjK+lOVUD56dmVKCfvHCs1WD9sLcoeeSQ3rzKJPuMYi/rE3p1cxv7By58mSMYZqzyVmnO1bNnmb2gF+T2eIsM7fTgs2P1tYIfvTg8JzzNMr2UrI0KulcUMRJnOQMggTxbZ6As3QJQAl4ikit2oUAamzNG/SJzCB9ZiDA7lBWHhJZkr1fiWk5wyEzRZmftPW/r+QQsSJyJkUbCBjvQc6ze7GS2JLgURDVXQgddg1AyfGySbGFxdYNlXmtfmuhFP7lwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbi4HJRCyYDdyTaOC74pB2fO5kccwpOzh6tm1q36ND4=;
 b=XEsktmK5mVHt32HjAR6/EWEtM0mlcv6qhCta1eY9At5OMP6gzN9YPDxLvDHI5fymlOHo8bqaheVM8ws7wHDHNdrRLzTzsv7rEA3BNcT+iOM1jvYr3vNdzubaiWYmPIGcJbtenWPgAipbDp2OmtSfLLL45HnXejQOUYQWmm90E3JrlwtpgXt6DG8E2xroGj02MsvHCzQWXwkLCdJKV9atnv9jOA3no9Y2SQqiwRsrF+BCkJ0vbXjPFeliABLq1FjE4iV0AIgLdZJMPfhl5CS/6dWtjv2Ml7txmkYeNInILtzTbGkLomPHRYQJydpHfh1p4JvthJZU1+rL5sDBFhekOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6662.eurprd08.prod.outlook.com (2603:10a6:20b:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 12:46:04 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 12:46:03 +0000
Content-Type: multipart/alternative;
 boundary="------------1eM0NbsmtZUlHtdBfskn2Cb0"
Message-ID: <9174f6c9-eb19-402d-8ba5-8beacf701d2e@weidmueller.com>
Date: Fri, 14 Feb 2025 13:46:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: 'vendor' fetching discussion cont.
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-core@lists.openembedded.org,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: dea17285-f365-45dd-fa12-08dd4cf58aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SEh5Tmpja3NzTWg2dFZRRitIMEx6SWQwa3BZdjBnd1FsMy9zbDRnUHIzeTZi?=
 =?utf-8?B?Y20xdFd2aTJ6dDNMQTVxTHJaQlR6bitLTEhwNjFQRnRjYmxERlpqcFZlU2NH?=
 =?utf-8?B?b0lrMDBxTHNURTZ5U2xKQ2FhVnVkVUZJd0NhMHJpUFdJNmU4UlBUYlZMSlQ0?=
 =?utf-8?B?ajUveHo0dmVEU0NWeWhQbjFWKzNoNVZJT2dPMkh6Zi9acStHR2lQT2ZSUHRt?=
 =?utf-8?B?blAvYUFPYVZDcWJJQlNWRXF0MS9hK013ODhXUzJ1dzhYZjBHUTFHMERYY1Nx?=
 =?utf-8?B?RnJDNU9RNTNVNXY0Q3hxQldnQ2NKVkxJUi9heGVjUW1EU1FkU3NMc1k1YjNU?=
 =?utf-8?B?WE9ZMDNDand4cVVoR3ZPK1g2eXBrdEd4ZWJtT3BnZHhTNFZaOHIyT2tPTVM2?=
 =?utf-8?B?UlFOQXB2WnFKelUvZFNPUm1yYzRqY05yaUtmUDdZYVBmdURlY0NrZWRtaG03?=
 =?utf-8?B?UEJPR01IQk5mdXFsTkd6bExOZkl0cE9QdnlyZU5maTg1dXFPWURTcXRrQVFC?=
 =?utf-8?B?V3BWK2V4b2k4NVhPYWdvcTY2eFBRR2tmd21yVXVJTkNtczltYzhyTFEweFN5?=
 =?utf-8?B?SGNFYlVRQ1ppM0ZoK2h5TDVVMjdPUEZnYVdHaGVwSEhpWXFTV1gxdHZ0Qk93?=
 =?utf-8?B?Q25jVFFPQmlTNzJIaittYXRMSHdCUkY0OFl3Rlg2NGtmK3dsZXFUenhnaW1v?=
 =?utf-8?B?dzlxU2dWTGxlOXBJb2YrbC82S012RlZhcGVDRXhDM0tiWitpK2oyejRndDZa?=
 =?utf-8?B?dEYzRDNrTnZGZnJ2NThsWFBRY3VoZk1mcXVUYm5PM0U4WEtGUVpDc0V2bW16?=
 =?utf-8?B?am93d0JNODQzbXFsVmtVUUgxTkhwVVpSa1JDYjZ4emtyU0R2blNRWU9oU1BB?=
 =?utf-8?B?U0w0Y2RKR29MSU5UZnBNazZNUFk4TDNwT1IvNjhDZEdzdDR5cjdMQWxtYjRH?=
 =?utf-8?B?UE10b1RvU1E0dW1zMVcvOUlGMnZRVUV5WFNCQ09icFJLZEJneUIydFhkM2hM?=
 =?utf-8?B?dEhWTE1xaDVFaE5VcE4vNlN1cU4vYTdZN29Sc0tpZGRhaTlENk1lSURCQzdk?=
 =?utf-8?B?SjV6K2VjTUdabmR5WE9FeVNaeFF2S1lRQkFBc2wwdUEyeGtBUTQrbFhQUld1?=
 =?utf-8?B?SDcrWUo3OWZWcytRZDI3UWNHSTJYNERTMWhEd2Q4RlJtQ3N3eTJoRGVVblJL?=
 =?utf-8?B?SmNZTW1IQVMzUEM1U0d3R213bklXQTZpRmF6UGE5SEpHck43NUJ2dWJRUFp1?=
 =?utf-8?B?dUZrb1RtaCtnOG0wQ2pxaFRYY2I5aHlGeXlFOGhHQ2lQYXlYakh4R0owbjFS?=
 =?utf-8?B?Q0JzTzIvMXlhUGJKNzRiTTZveEpqcGkwa0g1VkdNb3JFa2U1eTFzd01EdExU?=
 =?utf-8?B?cG4vcnFXUVJzWFc1c1VvK2JqdjJvVlVKeW1YZFd6RWQrcUZHSFpBM0Yya0V6?=
 =?utf-8?B?eElveXh3d3NxZFBHWjBlR0ZxMHBmeCswQTVUUm5jc3hyYkNtRldRQ3NneTJu?=
 =?utf-8?B?WnhKN3BIZXliRkR6S2p5bHQ3UE96WkpkVEV2MU0zV3JHOWIvc3QvMXIxNGVH?=
 =?utf-8?B?RjBaZXBwNDRWVkRIMHpJSGlFclQ0bFkxVmhwb3dLV0t2TTQrZjZHL1FsZUZD?=
 =?utf-8?B?c0M5M0N6QVl1OUFYRk5XWGFrMC9IeC9zME03Z2FHQTJaQWt1bndUOHZrMHNk?=
 =?utf-8?B?aVQ0ZFY3SjVLekdxOGlETDI2NDJydW5XajQ3dm4remYvY1lQdTIrN0RwNkxz?=
 =?utf-8?B?bEFRQTQ0WGhJVmxkN2tyNW51WkJ3Mk84LzZBaUx4T2dlVDFhK21oakF1TlRG?=
 =?utf-8?B?Q1JLVFJxNTVYNHJRVXdHamRBOUpEZHd2bFhtUnZpWVpKMklLNmt2Q0pKZGFQ?=
 =?utf-8?Q?vlqRMspFkMh9S?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmxIWS8wUkhhbUV0WFhzT25lNUVabGx4cG4wZEZlT3dFMTU5MnRYdjhTQUZK?=
 =?utf-8?B?OWJEU3FWRDhHelVYYm1KR01iMHB1eFdobVM3OWJuRE9tdVh4UUhQcXhOMUUy?=
 =?utf-8?B?YXdGNUE1dzAvNmpsZGRLdUFNK1U3akUxQzJkcDZkbWFibzNVbSt0aGttcVNR?=
 =?utf-8?B?aHZVc3BXTk44SzlLT3l4dXkrMEdHWHIzdnN5dEtMZUUvT24wZkczTlJ2Q0x6?=
 =?utf-8?B?TUtnMkxnbkRadEdaQURZdXZJM3ZsWTRPWXljR01jTld5ZklPSXBKV0tNek5X?=
 =?utf-8?B?eDZkZkFiV3hsdkdKdTB1SmlmNEZQY29HZVU5azVzZ1Bac2FNVGxpYmFncHRl?=
 =?utf-8?B?bTVNYlh3ek1QVkI4K0NLTGlTajRtOHhYc3FHWEhNcmFyY1dHSW9rY0ZCbnR2?=
 =?utf-8?B?bEJDWjFRZ2s3M2hHVXVXQ0tqV0RxTWdTdDFGWHFJRWJ3Uk5wRldtbHladXBk?=
 =?utf-8?B?TEJUU2t0TGlvem5kMVRjMjVTVWEwQ05URS9UNFRsZE9YajUvRVk3VUdZK0hK?=
 =?utf-8?B?bGdpM0MweHptYTVUNkxaTDZ0R2ZCTUtwTit1Y3hMcDBsdjJoNVZsRlpaWHVI?=
 =?utf-8?B?OVNHM3RucWo5UURtSm1URi9neHllZ0g0NjlUdmp5dlRTNGJ0Um8zZFpDdEFT?=
 =?utf-8?B?MHpHR1czSVdsUkg5OGxTY0hpT1lEakxMUVBBZHBUS0c2NytVQUJ6VEtFZmFm?=
 =?utf-8?B?dTB5eExDeXh0ZDZsY3QwOVMvTU9pYUZnYnIyYnpwSUNrSTFlK2dzUnNyY3pi?=
 =?utf-8?B?L3R1TG1JbmV3ODNNU0RnR1lyQ09hN0VKMlVzZ0gvY3NRbzlIZGtmSTIwYVlW?=
 =?utf-8?B?ZWZDcU10ME5KdW9OUnhkcmxLSGxIN0dCTUhvcys4QWNrajBVVkwwVms2OWlC?=
 =?utf-8?B?b3ZLL3VaU2c0R3NUcm9vdG9oeVc5anAzQmpIOEZCUi9YV0s2NUhSTzFtUm10?=
 =?utf-8?B?ZnBXd25CSUtxN3dLUFE2bmtoeXEwWlFscmZuZUhDY1ZhRHpSNVlkOEtmRzVS?=
 =?utf-8?B?ZXFkQnRoUjVpdGRXTjZCV0dwZUZsK1FRcFVPaFl5eTJKOW9ES1kwQUp0bXJK?=
 =?utf-8?B?dnZmdWdIUDBVc1RkZzEzbU8wc0hMdXZyOTZWcTRHV0Q2RllzNGpYZ0JuQ24r?=
 =?utf-8?B?UVBqWjBRdW9LN1BJZFgrZDBleGJmaTY0QmRhZHBKbU5ZY1RpVFd4OXd1a0s2?=
 =?utf-8?B?TzNMY3drTVNrZ3VQMWl6UlV2elp3TjdxUGczSUFNcHM3Y3ZkSkIySHFpdktH?=
 =?utf-8?B?YVAxb21NcGprc1l3UE5pSlZYVjRvUEROeHlNMUpDU2M4UEJ3SlZCWG5EVE14?=
 =?utf-8?B?eFZZQ1lEcXpENlVuSUhKU3NlMXlkVlJtK3B0NDluYXluM0JXcTNZbDN5alVF?=
 =?utf-8?B?Rlh1ZnVMaXpBVHF2QXcwWEs4anBOOFVKU0t6MVl1bFBOY1pwbHZtKzU1K2Ny?=
 =?utf-8?B?aXVNTkplMStjZDVMRUFOYmVoTUtEcVQyQWJxb2E1K3lhbDA0WVppenpDTDRN?=
 =?utf-8?B?ZmNlQkdFTEJiTkNpSWJjTUR3VlR3U1JPRi9RUERNa0s0REc4cHpLQm9JV2F1?=
 =?utf-8?B?R3NOVzF2NHJsSkNzREM2dEswdmNpZmFsdCszTUxBYnZMbjA0U3FpNlVnby9J?=
 =?utf-8?B?cmxaREhiT0toekd5a0NBcktKTnloTWsyZ284U0k2ZFB0S1pjdWlPTXZRWFNE?=
 =?utf-8?B?R0ZyZ0tlWWNsbUVrbTFSVXpSYnlybEF5UVgwTkxOazJlSElVeHlURVRXeFA1?=
 =?utf-8?B?eTJEc0pVVy8zMC83NkhWZ1lLL0hKVTRiSHRWY1FRVzNwa2laR0paZnZJaFFS?=
 =?utf-8?B?L1ZZblZSeEJCM2J2OGtDUW5WdDV1ZjdsTVV0eE5FVU5GWnN6eFBMYzJQYmNw?=
 =?utf-8?B?VTJXdyt6dUd6NDdsNGtpbjZZWTZ1VjdJVGJMN0tpc0szYXVNY1ZHRWVRdGYr?=
 =?utf-8?B?bSsyaDB6RFdZaVRkYTRtT0Q2ZEcyOXh1TXZray9RaTVFZ0paamNNRlhCYWFB?=
 =?utf-8?B?YitWMFpqVEdwWDU4a1hibUFJUEZ0cmhOeGlQRTVKd1ZrbzJUR1hqUVhoTlB3?=
 =?utf-8?B?aDFQbHpOY3UvcGtOMTQ1ajBlNXZna3VWME83bHVtcEx4OHN4NiszSWdBd1Ey?=
 =?utf-8?B?c1FNNy9rWDAzWENlSlhvd1Z4QUFjT0VWWlUxb2RobjIvcXg0b1FnUnZWSHhE?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea17285-f365-45dd-fa12-08dd4cf58aa6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 12:46:03.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXmXJbJR2e70EK9mP9n7D4qWI8MP8nSvOIWMV8A5gyXSaLkdktbEzb5i4STvRKOaMUA25OuKuq6FO+m9gpbMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6662
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 12:46:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17220

--------------1eM0NbsmtZUlHtdBfskn2Cb0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.02.2025 um 18:34 schrieb Bruce Ashfield:
> I did some replies to the other threads before seeing this, we can feel
> free to let those other threads go unanswered, to unify things here.
Okay

> On Thu, Feb 13, 2025 at 5:43 AM Richard Purdie 
> <richard.purdie@linuxfoundation.org> wrote:
>
>     I've pulled this to a separate email/thread since I'd like to take a
>     slight step back and put some different ideas into the mix as well as
>     explain where my own thoughts are right now. I'm also doing this so
>     that we can focus the discussion and give others a place to catch up
>     from. For that reason I may restate some information below.
>
>     We have two fundamentally different approaches:
>
>     a) a single entry in SRC_URI with magic behind the scenes expanding
>     this into a list of dependencies
>
>     b) multiple entries in SRC_URI generated with tooling
>
>     gitsm is similar to a), partly because it can contain recursive
>     references to other submodules so the second approach wouldn't work.
>     crates are handled with the b) approach today.
>
>     Developers in general are more comfortable with b) since they can more
>     easily see what is going on but it is also the harder one since it
>     deviates most from the underlying tools and has two sets of data that
>     require to be in sync.
>
>     Some feel the .inc files enabling b) are effectively machine generated
>     and could be removed with the work happening transparently instead,
>     simplifying the recipes and commits. This allows easier use of the
>     underlying tooling too.
>
>     I think firstly, we need to document some key principles. Behind the
>     scenes, any given url should expand to a defined list of
>     components and
>     that list has to be deterministic and not "floating", i.e. always the
>     same regardless of changes in any registry or other upstream. If there
>     are changes, they need to be detected and there needs to be a hard
>     error. Also, if the code sees things declared in a way they could
>     vary,
>     that also needs to be a hard error.
>
>
> And of course be expanded into something that is compatible
> with our mirroring, but that was implied, I just wanted to say it :)
Therefore we need to fix the mirror regex. Otherwise we have to mimic 
the upstream layout in the download directory.

>
>     Most of the concerns I've seen are about how easy it is to understand
>     what is going on behind the scenes. The move of code to OE and
>     splitting everything into multiple tasks/stages does do that to some
>     extent but it does it in a way which I think is going to create a new
>     and different set of problems.
>
>     I'm therefore wondering if there is a different way. The changes I'm
>     wondering about would be to:
>
>     a) embrace the single SRC_URI entry
>
>
> I still wonder how we'd be able to debug and/or override parts of
> the single SRC_URI entry.  Do you consider a lock file or a language
> dependency file that could be overwritten from recipe space as
> a single SRC_URI entry ? If so, I can get on board with that.
>
> I still prefer the expanded dependencies into some sort of base /
> simple fetch format, but a single file that describes all the dependencies
> is close enough. As long as there's a way to inspect what the file
> was processed into for fetching, then there is some visibility in times
> of need.
Do you mean a Cargo.lock, go.sum and package-lock.json file or a 
proprietary file?

We could save the generated SRC_URIs and a hash of the lock file in a 
file in the download directory. The file could be used for inspection 
and as cache to avoid a regeneration.

> The remaining question for me is .. how recursive are the dependencies
> in the file described on the SRC_URI ?
Go, Rust and NPM already resolve the recursive dependencies in its lock 
file. Only gitsm need to resolve the recursive dependencies.

> If each line in the single file
> is being expanded into multiple different dependencies, then the
> visibility into the final list is low,

We have the fetcher.expanded_urldata function to receive the expanded 
SRC_URI list. Maybe we could make it easy accessible.

> the reproducibility
The generated SRC_URIs only depends on the lock file and some variables. 
We could reduce the variables if we depend on the PREMIRROR to configure 
a local proxy or registry.

> and mirroring of what
> eventually gets fetched need to be guaranteed as well. That of course
> isn't different from the issues which could arise with gitsm.
My last implementation are based on the wget and git fetcher. The 
mirroring will work as soon as we fix it.

>     b) require a checksum of the internal "URL list" that is included
>     in SRC_URI, much in the same way that we have checksums of tarballs.
>     For better or worse, we have low trust in the underlying tools to get
>     this right (they are getting better).
>
>
> This would be a checksum of the fully expanded dependencies of
> the SRC_URI entry ?
>
>
>     c) if the checksum doesn't match, we know something went wrong and
>     error
>
>     d) require the new modules to write the URL list into a known location
>     as part of unpack
>
>
> Aha. That answers the question that I had above.
>
>
>     e) add the ability to add custom hooks in the fetch process to handle
>     the cases of needing to alter the flow for patching the components
>     list
>
>
> Or potentially detect the output of d) being somehow supplied and not
> do the dependency resolution ?
I would focus on patch files for the lock file. It is always possible to 
remove the SRC_URI line and replace it with the desired dependency list. 
The list could be extracted from the cache file in the download 
directory or could be received via the expanded_urldata function. The 
function already returns the git

>     f) create new tools that allow the fetcher to be stepped through and
>     for example partially run, or run with clear debug output showing what
>     was happening at each stage (show the list of components?). This
>     may be
>     standalone tools, maybe a devtool module, I don't know. We may want to
>     make the fetch/unpack logs more useful in general as right now you
>     don't get much useful data about what it is doing.
>
>
>     If we do those things, where does that get us? How much buy in do our
>     different stakeholders have?
>
>
> I think it is getting closer!
>
> If there's a way to see all of the individual fetches, and change 
> those fetches,
> then it solves most of the issues that I've been using git:// fetches 
> for in my
> go recipes.
>
> Bruce
>
>
>     FWIW I am leaning towards having this code in the bitbake fetcher as a
>     first class citizen as to do otherwise is going to create layers of
>     abstraction and we probably have enough of those already.
>
>     Cheers,
>
>     Richard
>
>
>
>
>
>
>
>
>
>
> -- 
> - Thou shalt not follow the NULL pointer, for chaos and madness await 
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II
>
--------------1eM0NbsmtZUlHtdBfskn2Cb0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 13.02.2025 um 18:34 schrieb Bruce
      Ashfield:<br>
    </div>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">I did some
            replies to the other threads before seeing this, we can feel</div>
          <div class="gmail_default" style="font-size:small">free to let
            those other threads go unanswered, to unify things here.</div>
        </div>
      </div>
    </blockquote>
    Okay<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Thu, Feb 13, 2025 at
            5:43 AM Richard Purdie &lt;<a href="mailto:richard.purdie@linuxfoundation.org" moz-do-not-send="true" class="moz-txt-link-freetext">richard.purdie@linuxfoundation.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I've
            pulled this to a separate email/thread since I'd like to
            take a<br>
            slight step back and put some different ideas into the mix
            as well as<br>
            explain where my own thoughts are right now. I'm also doing
            this so<br>
            that we can focus the discussion and give others a place to
            catch up<br>
            from. For that reason I may restate some information below.<br>
            <br>
            We have two fundamentally different approaches:<br>
            <br>
            a) a single entry in SRC_URI with magic behind the scenes
            expanding<br>
            this into a list of dependencies<br>
            <br>
            b) multiple entries in SRC_URI generated with tooling<br>
            <br>
            gitsm is similar to a), partly because it can contain
            recursive<br>
            references to other submodules so the second approach
            wouldn't work.<br>
            crates are handled with the b) approach today.<br>
            <br>
            Developers in general are more comfortable with b) since
            they can more<br>
            easily see what is going on but it is also the harder one
            since it<br>
            deviates most from the underlying tools and has two sets of
            data that<br>
            require to be in sync.<br>
            <br>
            Some feel the .inc files enabling b) are effectively machine
            generated<br>
            and could be removed with the work happening transparently
            instead,<br>
            simplifying the recipes and commits. This allows easier use
            of the<br>
            underlying tooling too.<br>
            <br>
            I think firstly, we need to document some key principles.
            Behind the<br>
            scenes, any given url should expand to a defined list of
            components and<br>
            that list has to be deterministic and not &quot;floating&quot;, i.e.
            always the<br>
            same regardless of changes in any registry or other
            upstream. If there<br>
            are changes, they need to be detected and there needs to be
            a hard<br>
            error. Also, if the code sees things declared in a way they
            could vary,<br>
            that also needs to be a hard error.<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">And of
              course be expanded into something that is compatible</div>
            <div class="gmail_default" style="font-size:small">with our
              mirroring, but that was implied, I just wanted to say it
              :)<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Therefore we need to fix the mirror regex. Otherwise we have to
    mimic the upstream layout in the download directory.<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            Most of the concerns I've seen are about how easy it is to
            understand<br>
            what is going on behind the scenes. The move of code to OE
            and<br>
            splitting everything into multiple tasks/stages does do that
            to some<br>
            extent but it does it in a way which I think is going to
            create a new<br>
            and different set of problems.<br>
            <br>
            I'm therefore wondering if there is a different way. The
            changes I'm<br>
            wondering about would be to:<br>
            <br>
            a) embrace the single SRC_URI entry<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">I still
              wonder how we'd be able to debug and/or override parts of</div>
            <div class="gmail_default" style="font-size:small">the
              single SRC_URI entry.&nbsp; Do you consider a lock file or a
              language</div>
            <div class="gmail_default" style="font-size:small">dependency
              file that could be overwritten from recipe space as</div>
            <div class="gmail_default" style="font-size:small">a single
              SRC_URI entry ? If so, I can get on board with that.</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">I still
              prefer the expanded dependencies into some sort of base /</div>
            <div class="gmail_default" style="font-size:small">simple
              fetch format, but a single file that describes all the
              dependencies</div>
            <div class="gmail_default" style="font-size:small">is close
              enough. As long as there's a way to inspect what the file</div>
            <div class="gmail_default" style="font-size:small">was
              processed into for fetching, then there is some visibility
              in times</div>
            <div class="gmail_default" style="font-size:small">of need.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Do you mean a Cargo.lock, go.sum and package-lock.json file or a
    proprietary file?<br>
    <br>
    We could save the generated SRC_URIs and a hash of the lock file in
    a file in the download directory. The file could be used for
    inspection and as cache to avoid a regeneration.<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small">The
              remaining question for me is .. how recursive are the
              dependencies</div>
            <div class="gmail_default" style="font-size:small">in the
              file described on the SRC_URI ?<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Go, Rust and NPM already resolve the recursive dependencies in its
    lock file. Only gitsm need to resolve the&nbsp;recursive dependencies.<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small">If each
              line in the single file</div>
            <div class="gmail_default" style="font-size:small">is being
              expanded into multiple different dependencies, then the</div>
            <div class="gmail_default" style="font-size:small">visibility
              into the final list is low,<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>We have the fetcher.expanded_urldata function to receive the
      expanded SRC_URI list. Maybe we could make it easy accessible.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small">the
              reproducibility</div>
          </div>
        </div>
      </div>
    </blockquote>
    The generated SRC_URIs only depends on the lock file and some
    variables. We could reduce the variables if we depend on the
    PREMIRROR to configure a local proxy or registry.<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small"> and
              mirroring of what</div>
            <div class="gmail_default" style="font-size:small">eventually
              gets fetched need to be guaranteed as well. That of course</div>
            <div class="gmail_default" style="font-size:small">isn't
              different from the issues which could arise with gitsm.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    My last implementation are based on the wget and git fetcher. The
    mirroring will work as soon as we fix it.<br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            b) require a checksum of the internal &quot;URL list&quot; that is
            included<br>
            in&nbsp;SRC_URI, much in the same way that we have checksums of
            tarballs.<br>
            For better or worse, we have low trust in the underlying
            tools to get<br>
            this right (they are getting better).<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">This
              would be a checksum of the fully expanded dependencies of</div>
            <div class="gmail_default" style="font-size:small">the
              SRC_URI entry ?<br>
              <br>
            </div>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            c) if the checksum doesn't match, we know something went
            wrong and<br>
            error<br>
            <br>
            d) require the new modules to write the URL list into a
            known location<br>
            as part of unpack<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Aha. That
              answers the question that I had above.</div>
          </div>
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            e) add the ability to add custom hooks in the fetch process
            to handle<br>
            the cases of needing to alter the flow for patching the
            components list<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Or
              potentially detect the output of d) being somehow supplied
              and not</div>
            <div class="gmail_default" style="font-size:small">do the
              dependency resolution ?<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    I would focus on patch files for the lock file. It is always
    possible to remove the SRC_URI line and replace it with the desired
    dependency list. The list could be extracted from the cache file in
    the download directory or could be received via the expanded_urldata
    function. The function already returns the git <br>
    <br>
    <blockquote type="cite" cite="mid:CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">f)
            create new tools that allow the fetcher to be stepped
            through and<br>
            for example partially run, or run with clear debug output
            showing what<br>
            was happening at each stage (show the list of components?).
            This may be<br>
            standalone tools, maybe a devtool module, I don't know. We
            may want to<br>
            make the fetch/unpack logs more useful in general as right
            now you<br>
            don't get much useful data about what it is doing.<br>
            <br>
            <br>
            If we do those things, where does that get us? How much buy
            in do our<br>
            different stakeholders have?<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">I think
              it is getting closer!</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">If
              there's a way to see all of the individual fetches, and
              change those fetches,</div>
            <div class="gmail_default" style="font-size:small">then it
              solves most of the issues that I've been using git://
              fetches for in my</div>
            <div class="gmail_default" style="font-size:small">go
              recipes.</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">Bruce</div>
            <br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            FWIW I am leaning towards having this code in the bitbake
            fetcher as a<br>
            first class citizen as to do otherwise is going to create
            layers of<br>
            abstraction and we probably have enough of those already.<br>
            <br>
            Cheers,<br>
            <br>
            Richard<br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
          </blockquote>
        </div>
        <div><br clear="all">
        </div>
        <div><br>
        </div>
        <span class="gmail_signature_prefix">-- </span><br>
        <div dir="ltr" class="gmail_signature">- Thou shalt not follow
          the NULL pointer, for chaos and madness await thee at its end<br>
          - &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br>
          <br>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------1eM0NbsmtZUlHtdBfskn2Cb0--

