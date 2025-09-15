Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E077CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 14:47:42 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.65])
 by mx.groups.io with SMTP id smtpd.web11.35855.1757947658776670914
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 07:47:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=BvyQQI8p;
 spf=pass (domain: cherry.de, ip: 40.107.130.65, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf5qp3i0mf75+7Ex65mkX6h0DVpRiwbsXCIGe0+Fkr5ooB6NWnKFz6zpkrazTD7dN4slMwWL2L/4HDKIM4CyIxeDxpv+B4LZb7weFjRIQ4BZ6C9j/1XO+w9/6EKYgGtuelomNsb7ytJ7EK6ccCY17jFJBK9y+rlcekGb+8r48Q06l6gYebbR57wyGKAzl0ZIMOHEnUiRY77yohd9HTnyRph4S9Sljvsoo3PfEVIDePZuL/oEIMOn6tGF044NkICqiqVivQzdZkMzXDYxi+44nZ+u5v1vjLMa4AVx6EHfyW5YsSUMwGq67C9dsQCh4XlOUj21u2fr4DToI+Q/JYAlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b6iHzuy90Lt2T9BSmpavGYJ4fGJB4odX82eoiiWxlE=;
 b=xQsR3F9QCNQ23ZN9Gu+k8WvRTIf3dwpRFHq7mkVAKzbmRl2NVQD1DkZj6WipJedTyn4iyrnInhqyYJBquzFEHx2g0Oeo3UkykZdSpy664RzVybEEDTVGeZXw+JBsSEqk3uAY5smTjbinSXdy9Ijf4b0BBjUOiWE+L+LgbcOI1VjatPY/h0owARb+reMODU8e96TCULeFT8lGZ1D+qp60p7k+6apVa/oiiLb/Hwy60usr/JmiWvjBB3T0V24ouU18b0+OXjfZblKoSER4l69o8aOzdCZYjKFeCGrC+L6okRlm4CajoLAL6OWz8HD6uVDaH/7+4ofsV7Pe+fInA298YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b6iHzuy90Lt2T9BSmpavGYJ4fGJB4odX82eoiiWxlE=;
 b=BvyQQI8pKQ7CQk8zGhDQh99AakLJAntHiDKdO0sCc4Gn5qFhOVUkN0A+y8medVGKU36s/9+ak7mx8+lt/2czJLGILhJkSt6cYoiPhm+5aTdKW7zFwExQM5h6GQap7tYmvSY+OUoQTPba/CC3+cBN4uzEK83SwzHOwAj/fykxO9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV2PR04MB11633.eurprd04.prod.outlook.com (2603:10a6:150:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:47:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:47:32 +0000
Message-ID: <34ae5ed2-9d08-460d-829c-86741bf4587c@cherry.de>
Date: Mon, 15 Sep 2025 16:47:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [docs] [PATCH 2/2] doc/conf.py: get current
 version from env
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
 <20250915-fix-switchers-js-v1-2-523ef53fe802@bootlin.com>
 <049595e6-2dc2-437e-b0ab-322f6b943b7f@cherry.de>
 <DCTFDO5WYLXJ.3N9UZ6MKHGPZ2@bootlin.com>
 <b3df67bb-dcb0-48cd-94d9-31d5e82849e4@cherry.de>
 <DCTG2SWBNYXV.2UL0VUXG7KZV4@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DCTG2SWBNYXV.2UL0VUXG7KZV4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV2PR04MB11633:EE_
X-MS-Office365-Filtering-Correlation-Id: 422bbec6-2b68-4819-1275-08ddf466cd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZElKRHU1ejN1ekU5dEdhNmJWT0RvdlJOTjd1QndnV2FxRmRHcEtrbHF5QUwx?=
 =?utf-8?B?dWRZUUFuMEhFUE15am8ybFBLajU3aXl5MkpWT0Zoc1dlS2R0MWp4d2tpMU1D?=
 =?utf-8?B?MWlKblJzc0pjejlSU0JGUXZnU3Vzb3NUOHBMUFI0enp4SVhoZTNPMTVFQm1y?=
 =?utf-8?B?NkdsaUNmd0tnY2hjZytVQUZ1aEJyTGppTFArSXVTQXVhRDBjWjF5OU9qbE9a?=
 =?utf-8?B?aFhadmxkbjR2RmR0aE9sM2UvcHNHdURiYlZlR2wvSFRKL2tLeFNCVXN3aHdY?=
 =?utf-8?B?YUJhMVJOMDZ1MDZHTXBGN3lpMmtiMktZUVRGWGwveGY3Mk15M2tERHNLU29J?=
 =?utf-8?B?WTAvWFMyaUlJRWhoMmRxVkdLMEtTcXZzQzVmcDlDbnJLVVBWMDRrVFM2Yi92?=
 =?utf-8?B?VTY2dkhJa1VqQVl2QUtOQ2lrOFJuNDgzU1MvSXF3TGZ4U2NDREVnbE9oWHZ2?=
 =?utf-8?B?NWdCVFlRZXdnclFqR2lJY3lxVVh3ZFNxZzB3REFHc3Jqb01jM05NU2FzMkN0?=
 =?utf-8?B?bEZ4ek1DcG9PYXFlNllYaEE0aHd1ZUxEWFRMSmJHMG1UUGUrS0QrZmJnRmtH?=
 =?utf-8?B?WWdmQk02MXhOVTJON215L1FQWllEVElLdnVqMnJjRktLZG5HVHViUHlXaS81?=
 =?utf-8?B?MjZTenlMWG1Id3JOeXU1REd6RVorK2ZaL1pqcGk3a3ZnN2lnd0ZyZzdvQmhv?=
 =?utf-8?B?eUNjWTRPb1FVb2dSSnNPT1JsUDRqWXlWeHBPQjloUjNCWHZvNWs4T2F6eGhP?=
 =?utf-8?B?cWVERVZQeFZnSjNCRHUycUlrNnNYM1hQQ29uaW8wallQbmpiRWVZYVdPK053?=
 =?utf-8?B?RDRUQ3UxYm0zZjFYTGpGZUVZKzBqWkNmOFIwS2xqSGx6VGptQmg2b2VEelF1?=
 =?utf-8?B?eDlneVVBbDM1NmRaa3ZLUlc5WHJtNzFpcUZxN3JRRFdRV0l2VE9ZMWRham53?=
 =?utf-8?B?dUNLWkZqR051V1FSZHB0cFJ1eFZUVXFIMDJvTFF1bUlFMkx3MVQ4WHR6NjZk?=
 =?utf-8?B?M1pLQUY5OFd0OXRKUTV5VVhGdzhnRXFjQ0pkNlVZWFk5d1dMeWRoSUNnY25o?=
 =?utf-8?B?N2FXTHg0TmRWRjJDeWlnSWVJdGVFSDhYNFhNeXdHelRZTU9FUmhPeGwxc3dw?=
 =?utf-8?B?Zi9CcGFEY2pxbVlPZWpiUTR6eW11TDRXU1REcVJPdFdzeGEwSW1tMGoyRE9t?=
 =?utf-8?B?VjRjUVdFNXJOZVdVZkJ4dHlGZXdCdDhVQjdjcmlDeGYrTjBtbTRRTlpsV3Aw?=
 =?utf-8?B?Q0Z5alExV2ZTSHZkTkZnOFZ6UXZKODBmeGI0Yi8xVzlIUm9uQm44bzJnUjhh?=
 =?utf-8?B?T09qTXJBRlRTSmc5ZEZaSmZhdnMvbXVEMzRVZ1Ixekw1V25uSXhXenJKQnBa?=
 =?utf-8?B?UmNhU0ViM1FYS2F4Q1Q5S0U0UU1EendINEhqcmUrWDFXWDlCY0k1Q0RaVWRx?=
 =?utf-8?B?cVd1T3JVaEFpTTF2VDlGdEc0b2hkRlcreFZUaHpjd3dQQzZsQWx2TXZhNWpx?=
 =?utf-8?B?NWdhcThUMlhwcjU2QXRkY3J0WG5JUXMzK2Ivd1EwSEVPdnlqdlFDbVNFbWZD?=
 =?utf-8?B?ZmdTSk1Xd21CSVd5emtYdGlUUVY2Sjgrb1ZlbVkvd0tucXl6bnFPdXkzcmk5?=
 =?utf-8?B?WjU4V2lEOHlIMm1jUU1uMmRmQmtrR0xsWVh5TkJ3OUwveEl1NlBpTWMzdEd3?=
 =?utf-8?B?TWdIYlRCV3RHdW52YVVXSWYzUEFYYW9oU2EwemlwMVdra1hIYnRRZElvd29J?=
 =?utf-8?B?d1kwcGlweEJoYlBqS2lmL0ZVRGxvYWZkbDlIYzFZTGJUVmY0TlAyWHpPdytm?=
 =?utf-8?Q?iyBUEMBL+QLsQcKusWkOKehWxlF2HE5nQRzKQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1BSa2QrS2NhaU5HNUlJVWVMWE8yRzc4SzZjTjJaYmFiUklpNC9Dcm5kZEZh?=
 =?utf-8?B?aFdQWmZaRVJSdEFOaDdjUzJUcE85WS9CcjVDR2Q1Zjd4YlIzLzlDWFY1YnRC?=
 =?utf-8?B?U1ZCMlNJZm9nWHBzSXpmbFBIbW9DRmhJOXZkOXNpckhxcFhPYWw5eE44aTdE?=
 =?utf-8?B?RHhhN0sxT0t5QzU4RGRwT2RrdW42WEdPYVNBRnFyeGJsMHhya3pVNTFma1Fm?=
 =?utf-8?B?czNxYXRUUFNCa3RYcWZmK2dzdk5NaUtQMWVDejFrS3ZCRTgyZzhiTENoZnRm?=
 =?utf-8?B?dkpYZHlqaDNOQld2QnFnc0x3YzFjTlJyaFFlNXp6amp6QkRTVmxPWnN2Z2F0?=
 =?utf-8?B?aVpkRVlnOE4wYStjZGZpZFdoNStCSG9OV3RDTmU5ay9LZG9CNjIvTUx3WU5q?=
 =?utf-8?B?bUZXUTF1MlhGRFN4MUZVRnp0NnRXUjRrVytncU0zM3g4K0lST2Y5U2paR1Bh?=
 =?utf-8?B?b3o5Y3RreisvRkJSb0lndk9rc2tFYVB0NWI4VDV2SzNGY1JHTzl3UFBYQjFx?=
 =?utf-8?B?Z001SHY0MjVua200TEI1a2xhaTRVZTNoeG03Mm9hL1VvYlB5NCtCRGRkeFht?=
 =?utf-8?B?eGVodzNGOXRrK2NGTEFSV1gxdWo4NzZqNUZoYkM2QTZSRFRwK2s4V3dGN2hm?=
 =?utf-8?B?b1NNT1lVOUlOOXh2Z1RlU21hQTBseXBrUWwrNXgvN00xMENpTm1HeE5ldmxD?=
 =?utf-8?B?YUtVSXNnZnJPQTdvODljSU5BUmMxTEtCM3kveWVNZFpvSjRvRFc2OEl6ekhx?=
 =?utf-8?B?N21BM3REOWtqeHErclNnVWpwbnBpVURiQkMyQ0IxcFB1anBkZkw1TlMwNFNL?=
 =?utf-8?B?NHd5YnFKZnFzKzI4eDNid1lDL2NCelRvZVFxaWkwdlMzOWdPVGdrS2NGazVw?=
 =?utf-8?B?RUFYK2FpRmhLaXM5SFBvdGt2eXppZDdQMTdOcDhDakFhQk1IcERhaEtvalk3?=
 =?utf-8?B?RWFiUFRvRU55MVhSYkxjNlJTYzVXbWdhdzFvdFZLay9WU2ErVkZTcmRuaktP?=
 =?utf-8?B?SjBPQlI2aXVHNDAyNzNmRlljT2ZFNzRMZ2FXdk9GQncrcER4SktZeEJ1bDBS?=
 =?utf-8?B?NnZYOHVuTlI3eUtKc0NWWVlISHJwdU9IcXg2b2swYTlYS1k2TGRaRU9BTmNF?=
 =?utf-8?B?a2lMdFY4M0FJRlN3RDBjbHhGV1ZxZXFyYWNycS9uaGM2WmxoRWs2S042aXox?=
 =?utf-8?B?OTRVQlFDUmJHK0Q5VzhBNUtmZ1BCTGdpWlRYUXE1WXRaOXlFeG1PMlJpdlcy?=
 =?utf-8?B?SmNURHJXczYzdVM5eVBqQU9XZGV0ZlRUc1VWaVBHc0c4QkVDMzBJRytncU5t?=
 =?utf-8?B?Qzk4RkJiRFFZcXVKeFVuWU5WLzRNcUtNZzlmRitHQzdFVk9Sd2lwS28zMFFY?=
 =?utf-8?B?Y3FESGpxeDRyMFlUdE1RSmFQU24xbVpjNUxiamxsYkxqUXp3RE1zdDBYcnhE?=
 =?utf-8?B?TkZVYWVMSDFiTXV2aUdPSEZQcEJtK1BxdWZVYy9vclkydTlHZjFJb0FVaGpD?=
 =?utf-8?B?MFZ4Q1BFVHBqVFNQb1NqcnJWMWwzR2lNNzlOU0FYSTBCanp2eUkrNnU3TlVP?=
 =?utf-8?B?cHJEWm9yWFc1WXl1K3UveHJ6RElLRmZWaXRzSXBTQnEzMlBnK2dXUlRqbXhB?=
 =?utf-8?B?Y1FEL1FIQ3R1SVZud0VWRzN1enArUEJVR2EwRWsrampxQTVDTGRvRitITENo?=
 =?utf-8?B?RFBtL3BpRncxcU1jTHhwMVp1RmZmU3F0dXc5WGNvWWhHdWREMlE0bTdnd0pn?=
 =?utf-8?B?RERraDlNM1VTbUl4R1FjYjRhWHNBNUpOZ2RmMGpvbUxSRFg1bWgybmZiLzJk?=
 =?utf-8?B?cEkrWWx4YUJ5OHhUV241ajRUanluRGlUOTg2NGpnRllEeEJ6cTRXUjZLY1lj?=
 =?utf-8?B?dmlCbEhtTWgzaTkzTDFIdzczM1ZYQVZaRjJXV3JDVUwrSW9EajBuTHUxNVNn?=
 =?utf-8?B?K3ZLS3lNMSt6R25rYXhPcmRZUXppS0xHVkJEQkREOEo0UStPZ1NEMkxvMUVX?=
 =?utf-8?B?YTRnWktNOXZzUGp6VStYWldYcGJDSDk0YngvVG5Ickc4U3cvWEdSNTAxSS9D?=
 =?utf-8?B?RTZUTXBvQjcrWGd5Y0pxNVNMU0xHT24xbm5nOVkrdDFwNlhuMjZUWFJCSkhO?=
 =?utf-8?B?QTNic09WclBUaE1VcXYwVHYrdTd0eU93OEtDRXRWUFBVUVMrd1o5SDNGUTFG?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 422bbec6-2b68-4819-1275-08ddf466cd3e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:47:32.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4S4qghP7ctIMc0d1Gw4yyyxHnzyZ6PMh2hHK3pYO59JwIHJQf1TE3mleNwHcPZm24cgnXsLqX0QD6d/OEWmg0rn/dOJR84yFQ4Tjq9cWlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11633
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 14:47:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18035

On 9/15/25 4:30 PM, Antonin Godard wrote:
> On Mon Sep 15, 2025 at 4:19 PM CEST, Quentin Schulz wrote:
>> Hi Antonin,
>>
>> On 9/15/25 3:57 PM, Antonin Godard wrote:
>>> On Mon Sep 15, 2025 at 3:24 PM CEST, Quentin Schulz via lists.openembedded.org wrote:
>>>> Hi Antonin,
>>>>
>>>> On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
>>>>> The Autobuilder can also give this information from the run-docs-build
>>>>> script. Fallback on "dev" if we can't find the information, so we can
>>>>> still build.
>>>>>
>>>>
>>>> How about following the exact same mechanism as on yocto-docs?
>>>>
>>>> Read this info from poky.yaml file which is automatically generated by
>>>> set_versions.py?
>>>
>>> The idea was to maintain the active releases in one location (yocto-docs), thus
>>
>> Having a OE component depend on a YP component isn't usually the things
>> are done in both projects though, rather the opposite.
> 
> I see. We do explicitely state the compatible YP version in doc/releases.rst, so
> I didn't think this could be a problem.
> 
> [...]

/me shrugs

I just don't like the idea of making projects even more interdependent, 
but I personally don't care about the relationship between OE and YP but 
I've heard it is very important to some. I'm not sure this would make 
them unhappy though.

>> I would avoid the need for BITBAKE_CURRENT_RELEASE environment variable
>> which is currently set from set_versions.py from YP-docs. I guess it
>> could be acceptable if somehow the build system of BitBake docs provides
>> this info?
> 
> I'm thinking this whole switcher implementation should be revised to only
> consider Bitbake tags and maintain the active releases here, and have YP/Bitbake
> docs completely independent - considering your latest comments.
> 

We could. The issue is that people probably aren't too familiar with 
which version of BitBake is for which YP release :/ We do have a page 
(https://wiki.yoctoproject.org/wiki/Releases) where it is mentioned though.

Quentin

