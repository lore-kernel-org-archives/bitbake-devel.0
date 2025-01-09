Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA4E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 14:18:19 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.131])
 by mx.groups.io with SMTP id smtpd.web11.49293.1736432290748060314
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 06:18:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=Hc+EKHms;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.131, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqOlOzYqfjEWXaNrXufLt8z2UoGJHbmJK9YaCco4vff47UM3I1beCZXfYMevOOk+G4+KRxNgiTEoA7HL4CoHcfxpzIma9xOJmKUdei4LF/G9Bf7dmITSYDrXRl5IXBiVIewAbbG+9wWqKx8/NXDMypHLeUGTYgYM5RxNaAoy0BE5XDh+c5m2bt+a+K+8U7XdProMiBCFCHpIak0qpTqCeek5UHdYLjCcMF/qDgKDmlUP4Z0AerY52blUM1Zx4KS6zlhfMnO5avvXhtL5yWnMjP8m/tl2zCQlPsl3jGCbIUr5XdYfvRW1jMAXL+tyqXxHy4zPzi2eWGRdz8Sf4duEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU2Slwr5Wl1Xi8PpCqs4Bo97R65L8pF8ymbgY0kWakI=;
 b=EPkCyol/guRkQWkKEqFyhoD6KovzFEQxyUXj6wYRRvC+6YY66+Bk7pxux16c5/67aVG6jFyoE+/iemX9cKeXz8cRAlPkDnQLO488JTMEI8IgkOnlTh9USu0QxTvUIwBQOYlh6aQc9yTGaQjnIeFF9DoT9huEzIIJnMmIPZwWrNiivLCE7uqcYmrGyNGbCfU6Uzyj3Pxkd73RQ93XZ0j7XT0v2jTk+5KkLdRrSHVJyDu3P/HJpsuOtX7G/dRnbng1A3X5rd85MKQs1lciR+4UoksGfzQv64zD15OhKaDcWmIK9uSXNXUANNaExjhgxp8d83zMofOz9UzmQxw5YXRRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU2Slwr5Wl1Xi8PpCqs4Bo97R65L8pF8ymbgY0kWakI=;
 b=Hc+EKHms2BcKQv1IQdbHj9EPpcIFs6ICtB6R+Nh+/c2koMYHxrom+LFDgYOKaX+4eBbWlS1HvU5ib3hr7dZUXFzvPa/nzllfVtpTtrzBruegSHC+y0Q4xHMHfvqtE87QoPTW+Qoi01OtvG9ymA0fRwFW4nJbJmlT8hBs2WNrUwTVMjZ3HRSNE4vtNLH6rq4EiH9YRBBIxEhupQLse/a8ur8Uw98zcCrnmjReVyNqOoMP2euu98fJBFBXypVSE4aPSfYQYLm/wtwQ3qCUbXxIvOTxuxbcB+vq0BBwlf4l11K2kfzCg8YcwWINUcYxJNmysoeLY5xl5CBXRJwoJaFwQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS8PR08MB8900.eurprd08.prod.outlook.com (2603:10a6:20b:5b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 14:18:08 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 14:18:07 +0000
Content-Type: multipart/alternative;
 boundary="------------U1VgOBL0IM73pkIOU9ah8fUC"
Message-ID: <747a9b17-94c7-4568-9b3e-63812b976cae@weidmueller.com>
Date: Thu, 9 Jan 2025 15:18:07 +0100
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
 <18190013516DD62F.1999@lists.openembedded.org>
 <CANNYZj80Vphpyw5fe74RV5k1fxo=QxrGahbcGy+vDJiu+c1c9Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CANNYZj80Vphpyw5fe74RV5k1fxo=QxrGahbcGy+vDJiu+c1c9Q@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS8PR08MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 003dce36-065c-4f7d-cef2-08dd30b87091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YlEvT1lyVkxPODZSaXJMUFJTN28vekV0QjBvK2JnVURqTXNnMEZPRDlxdG1y?=
 =?utf-8?B?OTVVZ1N0b2NvRmR1VWtwUmF0Yjk2SjkxSXExYXJJZktCOTFHaDY1dlp4cm9z?=
 =?utf-8?B?K0c1Si9VcUc0SEdLRkVTaU40WVNtYkFYUmZuTUhCRVdRVGh4MVlLSXA0UlMv?=
 =?utf-8?B?S2pJVzE0T01McU03cDVkY1V1V08xWWVoY0N6cktBRlZZZUJ0ZHh6RlQ0R2R5?=
 =?utf-8?B?akxtQ3NyZ2VDN0NzbFRJbHNjMnd0NUtxbjN5NkhlWGc2Y2JsWlo4MEUrZ3g0?=
 =?utf-8?B?SmFFZVk5UW1zRFBQWWVzdlpUeGFJY0tRb1I0UjEvQUl4cEFxVktZRzFFSVZm?=
 =?utf-8?B?eHRLcUZST0VOSFAreTIzNW8zU1lmaEVCT0V4Qjgwc3RiN1ViVTNsdFZQc0Vq?=
 =?utf-8?B?VWF1dmREUDZwemZiRGx3ejVuQ2RXN0ZjT2pFbElJUWt6QkVPazNnMDQvT2tH?=
 =?utf-8?B?U0pTRVhvTW9CbGhWUDJNTFhsSyt1SURZSnpuU2dLTG5iYXVaRnlPZ0lZRXYz?=
 =?utf-8?B?WVMzYTJVM0Z5MFJXaWZqZU0wcXYrRUFtallMWjB0MHVpaWFBNStEcEFEcHM4?=
 =?utf-8?B?NHlMdnFxMDBmbFc2SWZwWFJSUUxKZmp6SW04bEdJWTJGOFF3cWQzdGNBdTNm?=
 =?utf-8?B?WjM0R1ZOaDd2ZTNrZGxOKzhjYkZRTG94SFFNR294cHQ2WEkxYm5IK0VtVzhn?=
 =?utf-8?B?RThEalNwNDV1Ulg3akRxL0pWZ2c4YmV6K0pVZTF4WkN4dXFCYWw4SHNrZ3V1?=
 =?utf-8?B?MEkwbHdVaDZ0cmhRejJxa2NHbnhBODgwSHdxaUxFYkFpNk1NZnFtRkN2OCth?=
 =?utf-8?B?alFQQmI5MkVialJHSkNpMDJxci82bFlUZk0xdEtBd0VNY0JWOWM3L0w0QkhF?=
 =?utf-8?B?UkRnaFo0bGRNUnBISDNNV05YWjhOenpnVDl5bFBPRDhXV1g3ZklOOVRPak9m?=
 =?utf-8?B?Nlo2MllFc0d0eVhFV2NYaGV3RUgrd0F1aDFDWFBVNWlmdUpKejNPQnphelQr?=
 =?utf-8?B?Y3Nsa2dRd3lxaFU4QTZ3a3NCeml1THM3UTdSU2RzVDMwOUc4Z1RUdXZPdUxy?=
 =?utf-8?B?azRSL3NPZ0piRFpJRXlpNGNSWHJWT0FKMGwyelk4bXBxK1V4dmUwRHd2dEZh?=
 =?utf-8?B?RlkxaWxvOWxNMG5ZUmNIamFJSjhkSDVYdGVYa2tONHhndmQyeDE2YnBVeEZt?=
 =?utf-8?B?TmJsUTdWYzdTc2drWlZtSzkyejlpbnRzZC8xVzQxdG92OVFZSjFTZmt5elpu?=
 =?utf-8?B?RU1SY1k0ZWswRXZkN3JaNUpWbDZDc0QzQ1BpUXFXWTFJV1RGZnZpM0Z2MHJs?=
 =?utf-8?B?VVhtN0x2WUx2NTAvcXJ3STFvOHdzdE90S05kUzdzamJNRjRLaTJmSlhSd0gy?=
 =?utf-8?B?QldLVVVlbFEvVldMWk1CTmlNSDI5SDZOSGVUSWo4bUVoU25kckZkTlJTTTdz?=
 =?utf-8?B?VE9jMm1JVTN0Q2tyS2VBUU9mU3B2Ky9GUk1DcVBCcWI1U0dTRFl1RDdNVzNy?=
 =?utf-8?B?ZFg3d0ZzNFJkbXhrYitMVTMwMmxuV1c0VzVkSkJiRUpuN1NSYzFHQ3NZTXkx?=
 =?utf-8?B?OHljaGRwTHZVNXp2NnE5eFk1YlZERi9pMlRPK1hzWks2MzM1RW9wMWljWXJW?=
 =?utf-8?B?cDRweXdSQ1ZUZTQzb0ZpTWdGV0l0VEkrUURpcGNlQXdYbmNKNEJnVU8xbUN0?=
 =?utf-8?B?Y1ltTFRVemduSDhuM3k0SFlUdkkvT21UNFJGV0V0bGp2Zkg1U1hSUW5CWnoz?=
 =?utf-8?B?YkUxRTlKWnV3V2xtSWp4WFBabEQ3OFFRNXhQNjdRbXllUGx2djU2Y2h0QWV0?=
 =?utf-8?B?ODhYZEFRakszbTNBYXVKdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dW95cVA3cHd1cFlXdHpGMUZ6Y0VnbzJrcHQzOGRLY21vMnJyZVlKZW1OdjQz?=
 =?utf-8?B?Y0xQREpQcXluN2pHM1lwaFB1Yk4yTjZ1all3OENtNEkvd2tLazU3L0NVK3lX?=
 =?utf-8?B?SUgxTHYweEhKTm9FUDlJRUFYN3N1SjQ0b2FwbjBpN28xdGVOdjdZUFE5c3dy?=
 =?utf-8?B?eHk1emdUZndNMjFwNWZkQUp3OHphU1hvQVI2UU5GUzQ5QnE0cVBwcDhyV2Ji?=
 =?utf-8?B?dWl5anRLTFFLdEp5VHZJTGRCdEhYUXVIQ3AvdDA2OWRFaW5LVy9HeURXbFdm?=
 =?utf-8?B?YTlxRWQ4QnpJUk9KK2ZWNzNldlNMNjZaNVlRRlZRZk9nZHowOHVxS25yZ3NP?=
 =?utf-8?B?SE5rZmx1TW9kd21ESktvZVROaVZBWmN0Uk1xK2F2YjF2NHVzNFNweHVNQ3RE?=
 =?utf-8?B?czZHUmpqRENqNW9ZdWZMdXkvVlR4ZVlua2ZuOFVWbjRXLzlxQ3FLMWtXV3hm?=
 =?utf-8?B?ZDBjcFVPT1M2azE0R0UwM2lOTFlBL2QwRnJyaDYxQmJjWUt0aWN4MkFGUVV3?=
 =?utf-8?B?T0liY1A4eENsenFFZS85a1hHejRYa0JxOVk5TWo5TFJBemd6am1RY2ZlTzJ4?=
 =?utf-8?B?ZW1vbUxKbUZHMi9MakpOVmdtYmRHeXVYUFpqM1ZHZXo4ZEp0SndWVU51S2FF?=
 =?utf-8?B?WlQxNjgzRkNrYTZ0RVdXYkgrdzFwRzhBYjBEQTBQT1VpdlNYMEkwdjRqVGJz?=
 =?utf-8?B?bnptK0FTbTFZaG83QVVhdDBra2hWekhPQktSbzJwa2tVYUYwK2lCU0dDT2wz?=
 =?utf-8?B?cEVOK1FJN2xublV2M0dMRWYrYkwxdEhoQUxnWGtadGV2aWEzNG9zODBxMDBy?=
 =?utf-8?B?UkNnb1VlMitGTkQwQnowM2pscnVZR0NQc3lCVUtiMVBaekFtUGFCb1pFbHJT?=
 =?utf-8?B?OXJUU0UvdUR1dlgxN2VaWkZFN3IzUGlaNDY0aTY5TTBCRUdzejE5T2RYNitt?=
 =?utf-8?B?K0dqUDV2M2JvSWNVVGRlK3VReE81OHhMQ1hrOW96c0I4NmVpTUdmODkrV2lv?=
 =?utf-8?B?dlZ6Zk1jK1M0UWhGNXFpZStIQUR4dlV1VmxLNk53Vm56SVI4WWxuU2NpeDE4?=
 =?utf-8?B?MEdIUmx2VEtkZVVkRUJjMU1jYzh6Tjd2UFp4OStrOEluNTJaQU1UMSt0VnE0?=
 =?utf-8?B?WkhCdG5IMGhZdlk1QjROTVNtZ0Z3VW1vUi9DM01EM3NDN0pSbVBHeWlJWXB6?=
 =?utf-8?B?eVpCMlhlTWIzRFY4SnUxYmpuL3BQbWZFamVlYW5nSlR4RjdJZHk1dm9TbzNL?=
 =?utf-8?B?YnExYjdVL09iMmlHQm5xb2grOUNIeS9EampsNnVMYlJRMi9aSzRvU25jVTIv?=
 =?utf-8?B?TVhEUjcvRFFSdkcwMUdsM2xZcC9Qbm5JU0ZZdGMyb0JFamVpOXNHRTFNYXRO?=
 =?utf-8?B?R0xLc1cwSU96dHlWZTFQbWxBRzlFbU9pa3BkQWZkcFphRXlYTm9QUjE2cS9K?=
 =?utf-8?B?cEN3SW82Q2I0a1lUaU1SWFpCcEFxU1NlZm1rUEZFR2FRcitmeFRmbndkZGFM?=
 =?utf-8?B?L0FYUTV1NHA0VDl2aGNFeXpGYVVpckdxWENGWDAxWkx5a0VFVmJ3U0tIallR?=
 =?utf-8?B?dkFxOWJ5eTVuZXlqOWJPa0ZRUmg5Ym1RTXBGTks1aHNNQjIxUm1FbG81YlJQ?=
 =?utf-8?B?bVh0eittZWxLRkVOZXdnejdiSTUrMHluWFUyakdIN2ZBU1dDV2ZZMnB0bldR?=
 =?utf-8?B?MFhBdUdHKzNtSWhHNkF2dFB0TXptQ3RVWWk1R0p0amczcTkrWkx5Wm9Nb2I3?=
 =?utf-8?B?SjEzaW5PdWN3cXlTenEvWVdwMTVsWjJRTjA5Sm0yaU1DSmVNa0g0amhXcUQz?=
 =?utf-8?B?bVh5YnVlQ3k2R2txTDNiLzMyZXUwKy9WVFoxYzNUZlkxeWRZN2FwRGtrYk5Q?=
 =?utf-8?B?Q0QrYjk1VldNcDFYTEw0RE1YWWoyVWhvUnBSbEdLbWc3WGQ2ZlVrTGVvWnJh?=
 =?utf-8?B?K043QWtUTzMxTlJXZHFWNXpoWXZueGE4VXdxd0xQT2U5d2FwWjRVczZpMUtL?=
 =?utf-8?B?Wi83QjB4bklSUzdENC96cDFkcndxdTBYQXBCZUV6RHJGT0ZyVmhuK2ZWL2cy?=
 =?utf-8?B?UUJSNHFiTXdEdE5oLzlVNGFGdW4wWExMbGcrQ25lYmxOMTFkS1RBOURXOWky?=
 =?utf-8?B?QlJHN29SckYrQXEybUtPNzlpQlBMRXJWYTFrNUxyQXlOcjdYZFkvQVBsSzh0?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003dce36-065c-4f7d-cef2-08dd30b87091
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:18:07.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijENKCrtkNC3srobxzc412xPtNBK4W1jR67MpJbE8GQ0+hUYViDC0WoPPrTYzseNxJKE6DtT4Pn40B8HUkzeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8900
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 14:18:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16997

--------------U1VgOBL0IM73pkIOU9ah8fUC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 09.01.2025 um 11:50 schrieb Alexander Kanavin:

> On Thu, 9 Jan 2025 at 11:40, Alexander Kanavin via
> lists.openembedded.org<alex.kanavin=gmail.com@lists.openembedded.org>
> wrote:
>> This is not a theoretical concern, I'm thinking specifically of
>> log4j-like vulnerabilities, and how one would check that their product
>> doesn't contain them:
>> https://lwn.net/Articles/878570/
> I meant to say 'yocto layer' here, not product. And ideally it should
> be possible with 'static analysis', e.g. just by looking at the layer
> content.

What is the motivation for that requirement ("just by looking at the 
layer content")? Why can't we use a SBOM for the vulnerability check?Do 
be really safe you have to scan the code because of embedded packages 
(vendoring) or git submodules.

--------------U1VgOBL0IM73pkIOU9ah8fUC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Am 09.01.2025 um 11:50 schrieb Alexander Kanavin:</p>
    <blockquote type="cite" cite="mid:CANNYZj80Vphpyw5fe74RV5k1fxo=QxrGahbcGy+vDJiu+c1c9Q@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, 9 Jan 2025 at 11:40, Alexander Kanavin via
lists.openembedded.org <a class="moz-txt-link-rfc2396E" href="mailto:alex.kanavin=gmail.com@lists.openembedded.org">&lt;alex.kanavin=gmail.com@lists.openembedded.org&gt;</a>
wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This is not a theoretical concern, I'm thinking specifically of
log4j-like vulnerabilities, and how one would check that their product
doesn't contain them:
<a class="moz-txt-link-freetext" href="https://lwn.net/Articles/878570/">https://lwn.net/Articles/878570/</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I meant to say 'yocto layer' here, not product. And ideally it should
be possible with 'static analysis', e.g. just by looking at the layer
content.
</pre>
    </blockquote>
    <p>What is the motivation for that requirement (&quot;just by looking at
      the layer content&quot;)? Why can't we use a SBOM for the vulnerability
      check?<span style="white-space: pre-wrap"> Do be really safe you have to scan the code because of embedded packages (vendoring) or git submodules.
</span></p>
  </body>
</html>

--------------U1VgOBL0IM73pkIOU9ah8fUC--

