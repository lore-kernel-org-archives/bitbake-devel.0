Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3BBC021A0
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 16:33:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.93])
 by mx.groups.io with SMTP id smtpd.web10.531.1739464398129167171
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 08:33:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=TX1ynO0H;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.93, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHfyj700DmBYeKsvikc7D3nBryNJu7JLLluXhO7/jpNywUmY9VxobuO7LZyBfv/nx8KBPtW993m9icgdFGZ51jv55GNqkwjmEKvR6Oh0m9jVqb+CoWC0Wh+OKimUgM6jrJYwnWWU0XX8U0JNLreWtw6XrjF7qs9trO2mIIdujJ+uD/mOSxHkzQNP4hc5QFW2SWobXihITeniZJ5hpfyrfBNerVQrr6H7LTZ/nrMlrTcV35avfb2GrMYeCk46KCwSoOt1OZYiFcMyCIGTkv8L32o6a3KC6nqfk5Iu4lKH4WsJbA557LNVeKg93e91TwuwgxdTdCgn6TFL+yoxyzcQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoY+d3Ap9KuCiMj5X/IaOCr9DsbVWv31RGh+BJP4zok=;
 b=M9nJEiFQNO19fsXhau0K0M8wGRn24596RlMw541JH+P0wC3x81YXxg0dOD8rFE7SmHGqDb3FFszQPzNVSLTpLUHGIh2+ugI0PYaRWacPUB8xSo0MxJZwbHa7ajOOEaB5rMfcHimXO9kYCx1p1XVIvd5YmUGNB9gzQCqjp5ADKy/Bz9TNxI+uKTSrHUCrE6lY9d+DybAtKYC2vsOCINoOmWy7GCrHhmib4zZTtnGK9fBzBoW1CTrobVB92CY9Z0jAiikzLCoMNQY9Fj6gYzO+wctsj5C4c3zY6sNEpVewUmnsXF4Bxcz7SKozXdDSmsI9+qYzgnJJkORGkqp17DQfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoY+d3Ap9KuCiMj5X/IaOCr9DsbVWv31RGh+BJP4zok=;
 b=TX1ynO0Ht6EqJMeBR2fk+mJh8KkMKS6zHe7ZrYLDsMwaPM7BQcacd7jdrxJbfNWMdMiEUrRy8GkguljkBTueyHmjEHuI+J6vavLmj+RpmLgW9COis8csruBjwoLEOkTT4jZnHWBgl3c9k6NII3IeR99XtxYI4npNyTOWqfQ0mAu60IuwY+0qDOeT5LbzKzlyaFC+X5k3VEzxX0gmeKzy8FCpzHvMw7ZJYO0fwuh50TsxxCABf1sK09ZEcZBhTx8yUJ1+wPXd+footndljzRRDgj/xWveckgFgv8/kMlHw3L3+PJIbFvh3J0VnfzrKYJjFvCpIPDxYk3GsqFvweSeoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by VI0PR08MB10630.eurprd08.prod.outlook.com (2603:10a6:800:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:33:12 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::abe2:5846:76b8:9087]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::abe2:5846:76b8:9087%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:33:12 +0000
Content-Type: multipart/alternative;
 boundary="------------eGhfzkYW1FA0F4SUcQkrOxx5"
Message-ID: <f0f37aa4-8a69-4340-87ad-18f39bb4f43d@weidmueller.com>
Date: Thu, 13 Feb 2025 17:33:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: richard.purdie@linuxfoundation.org,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|VI0PR08MB10630:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d58d1c3-1257-49d3-7862-08dd4c4c1b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WStIRXFadkE3OUVjWXh6ZTFKVFJOSzc1cjF3a0FBRW9aNnY0Q3R2WnZCbitS?=
 =?utf-8?B?dW0wbHUvQlJrQXhQMTA1S2RZSjFnbWVpbTlRWVRQZkYzMnNlVFJQTzNSRkdY?=
 =?utf-8?B?aDB0SW5UeEo4K2swRU4vMlNKa2hCVFpETFdHaEU0ZkVZN3A0aWpGQXVEQkFj?=
 =?utf-8?B?dHhuNU9xaFBiV2t0b0JOc1RoRWp3Tk9vVk5UY1grQk1DZVh4WG1BZGNwcjgy?=
 =?utf-8?B?Wi9JNTd6TGt0UmloUzdsUHZSSlhxQlBtVm43YmtkUVYyL2lzNDNMU1Z1dWhW?=
 =?utf-8?B?NlZDL2E3MFJpNVkxeEQ3Y0hUM0cyL0pDR0I2blMraWxtM09pZlF4Y3dwTFF5?=
 =?utf-8?B?b0w1QmplaHJ4Z0krRG5QcHFLN0VoK0hpVVFlTEZqSERCQnJ4TEF2amVycXpu?=
 =?utf-8?B?ZldxSHlkem1mdzVQTmtoY3hKZnJmU01LK3RQaDlOTk4xVUQrOHBDbE5qL2Q5?=
 =?utf-8?B?TmcrYTNMNm1YTjZTVWM5bjF2c0tadFFtYm1kZlVYcnBKVStXcnRnSms0am1v?=
 =?utf-8?B?VlhhSjU2b3pvZlp2TVNRYWVXTFFMRzdQWmJKVVZYQ1BTaUlzOGkvZE0zejZO?=
 =?utf-8?B?RmlmakVrK3p1UnR4aGNiSGRRRFYzelF0ZGRvbWladFZpRmQwUTQzRTc2OEJU?=
 =?utf-8?B?N3dNTnRWZTc1NFJZdU9uTWJsRHdldEFoTkQ0QzJHMXNoOHFwTDVNWFFMVU91?=
 =?utf-8?B?NUN3SERjN2VwMnd0ZWswaUUyU2tXU3hRYU52Uk5kNVpRb0RidU5jbnczU2Nt?=
 =?utf-8?B?SmNmVlhqTUxpU1BFVm5HUXcvVGd2RzBTbEZEeHJVT0VMbHNHajdGTGlpbGtQ?=
 =?utf-8?B?ZW02TzZ5OURuSmdSeWJUbVZoa0UzZFZKUk5WM3lUODBxZkR2SkFFODZYa2xk?=
 =?utf-8?B?eUREOUI2bWs4VUx2SHZ5ZVh0THZGOGxzSjZsWVJ6MUZsR0RIbG9QNlJ4KzNE?=
 =?utf-8?B?RjZWdHNNRHNSWlF2enlXYkZVR3lGa2NIai9QZGVPMjJ2TGlzbnRhK21yVWt3?=
 =?utf-8?B?Zi83b0lDeTBuK0UvYjZzN3ovdkdudFZsa0hQd2lPWnA2QUtmTXBmYjNsdEg2?=
 =?utf-8?B?Z1cxTFlXTmZ2ZFRER05NU3d5R0J3TzJhRHU3YjJwRGtnMjNMSmM2azlDWGpR?=
 =?utf-8?B?OVhhbjV0Z2pNb1EvTlkxaWc1N1dFVjdwVENZRGhoVWRNSUhtQ0lIR3BQQkdj?=
 =?utf-8?B?eU9oQ3N5NE1KR3o5THZoVm1USWRrUlRZYklXL3MxYXI4K3BCUVlHR09icGJ4?=
 =?utf-8?B?T1ozY2k0VXVtMEFteitZa2p0UDF3c0IwZUNKeHFnOFlKcDI1MjNyR2pPVzUw?=
 =?utf-8?B?SVZONkNTem03WEF3Z0tFaTNueldKOUZYazlTZHhRYVRVcU5lYlJIVGlucEk3?=
 =?utf-8?B?RjNOT01namY1c0tTanFDd3pOMjd5QWQ0Z2FvanczeDkvMjNKOHQ0NU1PRTl5?=
 =?utf-8?B?b2xrN0lQbGRNU3JaWG81cmVSdCt1M0dzN0YwTlRMbEhndkFFUFR0bSs2SzhQ?=
 =?utf-8?B?UVIwY3lPTmZGb0F6Z3gyUExmVVgrWTgvWlFwUHJRU0drYm95eW1zM1lUOVNw?=
 =?utf-8?B?SVI5N1pFUnB6WmRRMGl5S1B2WUpnVHVmYkFnZjhsQ1VrSjZKNkJwVVpyWUl0?=
 =?utf-8?B?U2dXK1owODFUcENNYk1Sd1JHRjM0VjhOQmdkQ004b0xlR25DZUJhQk56Vy8z?=
 =?utf-8?B?UWtJOXRGM1NJY0hKd1VFcDRWRXhNZkNKTW9hUng2QmVWN3NjRDdhbFkvK0lw?=
 =?utf-8?B?MVhZMEcrQnB4SlBjU2o3UE5NZ1ZaZW51WGFGeHJwa3pTZFNKdTdIM0QxM0lQ?=
 =?utf-8?B?Q254Y2phYTVKSmVJU0pONCtMc0JSbDhSV09GcXBLa2dyMWxOMmZyR01yWGhv?=
 =?utf-8?Q?qrdZgAULnFShj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0ZtK0djVkRGOCs2L2svcFlodjBrbkViWUVkSmhiS3JXWVBxUVpMNVJORmVS?=
 =?utf-8?B?Y2psV0FFMGlMbk56WXdqS21vUi9kOUtYeHJSYXA4emhMTG1GRHlQVE04QkN5?=
 =?utf-8?B?bzVZa1pUSFU1bHA2YXNrQzEyL2g5MGo5Q1RwaXpEdFVlcVBKbVI3NkYrN0dy?=
 =?utf-8?B?ZHJuRjJqZlRHcWYwbVU3RGdaUHE3bVlLVFk3aGxkSkVvano5UWtDMVRxeTZo?=
 =?utf-8?B?OFVZdGQ5Y2FrMytsdWF2dEtUSnBUZXUzKzBBaVZpdzF4ZUJHWVFzSU42eGJi?=
 =?utf-8?B?NkNWZUZvZ3Nsam5vWHI2ZTkvRnlDN2F6TjQ5ZUpJV29xZlMzSDV3OWhEa1Vz?=
 =?utf-8?B?aDAxN05zSm1LUlpjeEFaNUVJUS9NcUFnZm1zaWRxV2M2TnVVVDZVUUxkbVdK?=
 =?utf-8?B?WU1sdmZ5VVZiT3ZWRDN4OERXc3BBd3dTZW54WkRpOFZVcW0yRG1wR3pHL3Ev?=
 =?utf-8?B?VFdMSUxRSW9YSWtseWxzTVc3dVBpNE4vYzlzR2hDMStSRy9XcVJsQmtHVmFh?=
 =?utf-8?B?UjdvT2RHdnlwQzVVdXp5ZFhETDdrR0tuV1V5RHcrbFdXZEtPcEU0eUdZZkxK?=
 =?utf-8?B?TXFrNWlRVGxjU2pkcFRDVXJYTzVacjdyalUyVTNqbnhNQS91VEo0ODc1OGs3?=
 =?utf-8?B?OGJ1UkQ3YmhsYWNGQ295dHFxUVZtN0Q2aWplbTZuTkswa29jSTZaNlExWGFz?=
 =?utf-8?B?WjRTZTVlY1E4SFpFNjVsY2NONDlXNjZxbTNPN1pzekFlWlhvcnN4Vi9oOGNN?=
 =?utf-8?B?MnJ2WGcvSlJzRkhJUVJRMnlNMnBmKzcxSmpsTXdEVW53V2tKTmZua2pxa2px?=
 =?utf-8?B?bTRBeW82OE9UeWxDZnlHWWxKazNSQmVVNVYwU0NPZHRqSmRScFo4V1ZnTDhu?=
 =?utf-8?B?VVAvdTlnbVVnbXNYRitGUWRpL2g5Q2xVTW50WjVzNzdTMXNIalZSc3lyWGti?=
 =?utf-8?B?RUkrdWNsaFkvTHowRHlsU2k4WmR5cnBqZkhBVjlFdjFMVCt3VmxON2FGK1VF?=
 =?utf-8?B?ZGJSQWNpeVgxZkNzRCtHNm9Yc1ZhUFUzRDhJa1U3KzRCK2JrTlkwRStKVDJq?=
 =?utf-8?B?T0lrcXE3T1NDNDdWZmFSeEdtNFp2TzhNcnlCRWZqY1ZmVnZsdGNFaHZESHVs?=
 =?utf-8?B?cUtvYXRmVFMvUzZIZ2pleEIyTGdTY2hWUGMyYXZON1hnSWdGTVdwQSt0TEhN?=
 =?utf-8?B?dWRUbjB4dER6dHJRaFBpcHVmaVYwZCtIUkxSbWo2M1dXUU0rZER2YVJBamti?=
 =?utf-8?B?d3VjVHpvTno4Mzd2ZmFuS00zWklYdDNlVnlHdjB2RERNSlFINGwrQzcyRHJQ?=
 =?utf-8?B?bHJGU2RUWDFZNHZ1UDlwN3pHenphUFd1VVVZdzkvK1hsbWw5b3luNysxSWJl?=
 =?utf-8?B?aFlRaTlsQjNVOVhSUTIvZWNraE9rNmlzbk9td3lmaWR4dXBwQXNYVnlReld4?=
 =?utf-8?B?ek1BM3VXSlMxa0ExOENkS2Z0aUlnQ0FNSUVYUjBjRmh6Rnc1QXpucFh3eEdI?=
 =?utf-8?B?QUFXVnJFUHpjbXpycUtDeHp6eXNPNnNNTHZSYXR1MEtpTVhtOFBJTENPQi9G?=
 =?utf-8?B?bi9pcVF4RmNucnFBazc4bW1ST21oN3NYc0llaGxhT0FXSUhYYmFwTnNNQ2pV?=
 =?utf-8?B?OUxGaVZtMlJzM2tsNEZqRWxJTkd4T2pyNXAxWjUzTmFIMUFZcHJBRWZKOTN6?=
 =?utf-8?B?eUtocW5VZGhCdWlMdXRIS2NFYVplM2p4SzRnNDdpODVEU2FjWlhLc2lyRzJt?=
 =?utf-8?B?TWZ5Tkg3bDI1M0pYMW51ckRCQjlqN2ZXbDVtUkJGeVdUSzNibmxJV015Q3lq?=
 =?utf-8?B?R1crR0JZNktUYmdnK3FUUHlvODlteW52a2FzUE83cU9Bd3VRQitQYWxsanZR?=
 =?utf-8?B?V1VNcUttZ0RISVMvSFYxNjlLelFoOG9Dekp1S1ZoMGJCZkNsRlF0ZXNDdFlC?=
 =?utf-8?B?TDFTKzMrN01KR3dDTUUrR29RNkRLcytrb2hUbk1mUjVEbW9ES1hqYitGQU1G?=
 =?utf-8?B?ZWVJZWk3OVpLMGU2NVRQV01xNWhKRzd3NzlOdHBYcEd4VGt4K09INEVEcENm?=
 =?utf-8?B?NDVvM1MyWTU1YXUvTzNDdllrVXJsNXkzb3RCSWFOb1oyaDVhVXE4VlVKN2t0?=
 =?utf-8?B?dW5aa3BqT25FdlpzLzRDM3dvRHlkSkNETnhwTlFNUDQ5ZDZ1amJNRFpuK1hI?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d58d1c3-1257-49d3-7862-08dd4c4c1b3c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:33:12.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+/wvkA5S/TtWczMV9F5rjv4qTqvbfLwEZj5z1hFirUmSPm3AIB6ppJRQppZ7ATN+K23T573Pqs2szzGwLJnlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 16:33:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17216

--------------eGhfzkYW1FA0F4SUcQkrOxx5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
> I've pulled this to a separate email/thread since I'd like to take a
> slight step back and put some different ideas into the mix as well as
> explain where my own thoughts are right now. I'm also doing this so
> that we can focus the discussion and give others a place to catch up
> from. For that reason I may restate some information below.
Thanks for the restate.

> We have two fundamentally different approaches:
>
> a) a single entry in SRC_URI with magic behind the scenes expanding
> this into a list of dependencies
>
> b) multiple entries in SRC_URI generated with tooling
>
> gitsm is similar to a), partly because it can contain recursive
> references to other submodules so the second approach wouldn't work.
The second approach works. The only difference is that a lock file of a 
package manager already resolves the recursive references / inter 
dependencies. In case of gitsm you have to handle the dependencies 
inside the tool and fetch a dependency to resolve it dependencies. In 
both cases a change of a single dependency could influence the other 
dependencies.

> crates are handled with the b) approach today.
>
> Developers in general are more comfortable with b) since they can more
> easily see what is going on but it is also the harder one since it
> deviates most from the underlying tools and has two sets of data that
> require to be in sync.
>
> Some feel the .inc files enabling b) are effectively machine generated
> and could be removed with the work happening transparently instead,
> simplifying the recipes and commits. This allows easier use of the
> underlying tooling too.
>
> I think firstly, we need to document some key principles. Behind the
> scenes, any given url should expand to a defined list of components and
> that list has to be deterministic and not "floating", i.e. always the
> same regardless of changes in any registry or other upstream. If there
> are changes, they need to be detected and there needs to be a hard
> error. Also, if the code sees things declared in a way they could vary,
> that also needs to be a hard error.
The purpose of the lock file is to lock the source of a package to be 
reproducible.

>
> Most of the concerns I've seen are about how easy it is to understand
> what is going on behind the scenes. The move of code to OE and
> splitting everything into multiple tasks/stages does do that to some
> extent but it does it in a way which I think is going to create a new
> and different set of problems.
Okay, but please keep in mind that some of my oe patches are reasonable 
independent of the native bitbake fetcher and it is possible to 
integrate the steps from the early class into the fetch task.

> I'm therefore wondering if there is a different way. The changes I'm
> wondering about would be to:
>
> a) embrace the single SRC_URI entry
>
> b) require a checksum of the internal "URL list" that is included
> in SRC_URI, much in the same way that we have checksums of tarballs.
The list isn't fix because it depends on the configured package manager 
proxy or registry. We have to remove this feature. But the user could 
use a PREMIRROR to redirect the upstream proxy to its private proxy.

> For better or worse, we have low trust in the underlying tools to get
> this right (they are getting better).

We don't need to trust the tools. We parse the lock file and enrich it 
with fix values. The resolve is deterministic. The output only depends 
on the resolve function, variable values and lock file content.

> c) if the checksum doesn't match, we know something went wrong and
> error

Can you please elaborate this point. We already check the integrity of 
the lock file and we have deterministically resolve the SRC_URIs.

> d) require the new modules to write the URL list into a known location
> as part of unpack
Why is this needed? The generated SRC_URIs could be resolved via 
fetcher.expanded_urldata().

> e) add the ability to add custom hooks in the fetch process to handle
> the cases of needing to alter the flow for patching the components list
I'm afraid this will be complicated since PATCH is applied in S and not 
in UNPACKDIR.

> f) create new tools that allow the fetcher to be stepped through and
> for example partially run, or run with clear debug output showing what
> was happening at each stage (show the list of components?). This may be
> standalone tools, maybe a devtool module, I don't know. We may want to
> make the fetch/unpack logs more useful in general as right now you
> don't get much useful data about what it is doing.
>
>
> If we do those things, where does that get us? How much buy in do our
> different stakeholders have?
>
> FWIW I am leaning towards having this code in the bitbake fetcher as a
> first class citizen as to do otherwise is going to create layers of
> abstraction and we probably have enough of those already.

The advantage is that the SRC_URI still contains the dependencies if you 
expand the urldata. On the other side the integration of the patches in 
the fetcher sounds complicated.

--------------eGhfzkYW1FA0F4SUcQkrOxx5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 13.02.2025 um 11:43 schrieb Richard
      Purdie via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I've pulled this to a separate email/thread since I'd like to take a
slight step back and put some different ideas into the mix as well as
explain where my own thoughts are right now. I'm also doing this so
that we can focus the discussion and give others a place to catch up
from. For that reason I may restate some information below.</pre>
    </blockquote>
    Thanks for the restate.<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">We have two fundamentally different approaches:

a) a single entry in SRC_URI with magic behind the scenes expanding
this into a list of dependencies

b) multiple entries in SRC_URI generated with tooling

gitsm is similar to a), partly because it can contain recursive
references to other submodules so the second approach wouldn't work.
</pre>
    </blockquote>
    The second approach works. The only difference is that a lock file
    of a package manager already resolves the recursive references /
    inter dependencies. In case of gitsm you have to handle the
    dependencies inside the tool and fetch a dependency to resolve it
    dependencies. In both cases a change of a single dependency could
    influence the other dependencies.<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">crates are handled with the b) approach today.

Developers in general are more comfortable with b) since they can more
easily see what is going on but it is also the harder one since it
deviates most from the underlying tools and has two sets of data that
require to be in sync.

Some feel the .inc files enabling b) are effectively machine generated
and could be removed with the work happening transparently instead,
simplifying the recipes and commits. This allows easier use of the
underlying tooling too.

I think firstly, we need to document some key principles. Behind the
scenes, any given url should expand to a defined list of components and
that list has to be deterministic and not &quot;floating&quot;, i.e. always the
same regardless of changes in any registry or other upstream. If there
are changes, they need to be detected and there needs to be a hard
error. Also, if the code sees things declared in a way they could vary,
that also needs to be a hard error.</pre>
    </blockquote>
    The purpose of the lock file is to lock the source of a package to
    be reproducible.<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">

Most of the concerns I've seen are about how easy it is to understand
what is going on behind the scenes. The move of code to OE and
splitting everything into multiple tasks/stages does do that to some
extent but it does it in a way which I think is going to create a new
and different set of problems.
</pre>
    </blockquote>
    Okay, but please keep in mind that some of my oe patches are
    reasonable independent of the native bitbake fetcher and it is
    possible to integrate the steps from the early class into the fetch
    task.<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I'm therefore wondering if there is a different way. The changes I'm
wondering about would be to:

a) embrace the single SRC_URI entry

b) require a checksum of the internal &quot;URL list&quot; that is included
in&nbsp;SRC_URI, much in the same way that we have checksums of tarballs.</pre>
    </blockquote>
    The list isn't fix because it depends on the configured package
    manager proxy or registry. We have to remove this feature. But the
    user could use a PREMIRROR to redirect the upstream proxy to its
    private proxy.<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">For better or worse, we have low trust in the underlying tools to get
this right (they are getting better).
</pre>
    </blockquote>
    <p>We don't need to trust the tools. We parse the lock file and
      enrich it with fix values. The resolve is deterministic. The
      output only depends on the resolve function, variable values and
      lock file content.<br>
      <br style="white-space: pre-wrap;"></p>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">c) if the checksum doesn't match, we know something went wrong and
error
</pre>
    </blockquote>
    <p>Can you please elaborate this point. We already check the
      integrity of the lock file and we have deterministically resolve
      the SRC_URIs.<br>
      <br style="white-space: pre-wrap;"></p>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">d) require the new modules to write the URL list into a known location
as part of unpack
</pre>
    </blockquote>
    Why is this needed? The generated SRC_URIs could be resolved via
    fetcher.expanded_urldata().<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">e) add the ability to add custom hooks in the fetch process to handle
the cases of needing to alter the flow for patching the components list</pre>
    </blockquote>
    I'm afraid this will be complicated since PATCH is applied in S and
    not in UNPACKDIR.<br>
    <br>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">f) create new tools that allow the fetcher to be stepped through and
for example partially run, or run with clear debug output showing what
was happening at each stage (show the list of components?). This may be
standalone tools, maybe a devtool module, I don't know. We may want to
make the fetch/unpack logs more useful in general as right now you
don't get much useful data about what it is doing.


If we do those things, where does that get us? How much buy in do our
different stakeholders have?

FWIW I am leaning towards having this code in the bitbake fetcher as a
first class citizen as to do otherwise is going to create layers of
abstraction and we probably have enough of those already.
</pre>
    </blockquote>
    <p>The advantage is that the SRC_URI still contains the dependencies
      <span style="white-space: pre-wrap">if you expand the urldata. On the other side the integration of the patches in the fetcher sounds complicated.

</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------eGhfzkYW1FA0F4SUcQkrOxx5--

