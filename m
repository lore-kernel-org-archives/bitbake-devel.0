Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C8E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 15:04:40 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.20511.1736521477889305228
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 07:04:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=7Ykxqk18;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIlP2bTOLlq9o5tUiBGzrkOcG2f8PV/dAfawXXZSxt7mKu8gELWDotmHcPXJTuWeMuiQ6pk1eJeB4ssdakGPjSQRlxyuqAGFkGIXujExwAs/kdEtiUTyBKbLWD9AtCQb9/NUjhgsv3GyYOu7ty9HkNmq1OEolhxu88F6nerTiBs2ktTsM6gM8vmeKUoZNBpl8qk93tcz5XNlghDLPh5R2WaUmUz0kp07adgGTsr5GCfCHWrudBLJ9Qgh1Y+Fst9K54k1NC2LlLym2gloBVK1rNHH2dMgficWG5zy/QG7E3qbBkF2Pp2WKduGq+Tz/UfaOOzSEu4ebK058y+dkS4Wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG0Ev74R9SE3hcsq0tnPZcVr5txCHPq1HrgxF1S+B1w=;
 b=jZ9PGCY6JO48Wz/rPv6qtHli5RgbnizJCpB4JllQTLsAfoDHnqHUvAndowl4FWnhb/YQRGgRDh7nzFLFmD4SgrhsSX0U/FOBFMx+rWTP35pKoQpx1HGwLPurw7cTUrvVHakcybuNrcrGkX8ZO06kmZK4MjS3MYhsqKI45sacR7q6fVrj6OTnZHQtrGnShQ9MYYv2KfAtL7W0LlkuiETvhurnlJjEasNUwx2gV9nruDsMTn0j9V2U3WpQZYkQ7mGfO69zNDsMmARDqRtyRhXYJ+OyrSoRDwAAhqtD/tVp1n7sJHIe4moNrAHMn5VCoVdbTFONEeybGgNhnU+WNIvO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG0Ev74R9SE3hcsq0tnPZcVr5txCHPq1HrgxF1S+B1w=;
 b=7Ykxqk185Y5dVP4t10eR3HknYbGjrydHnJIBtEkgXH+zdGJOp7rbuJVwUBv5WxUn8Z4eNg63aYO4BVFLXmYxXfMS8yqq5AOwU5jpOjW/6uDVmHidd33iX3EIe4oIUbzw5TrnGl2YwpsKceoflMBqNHijXGFNQwtYevkAen32WjiCmi0tg3CbLOHkgCiwhX0AHFUiefG2BY3bT2UtsP3NB22SVEyMzHihpe0TdzPlhcsUs/+/Tt78bL/pXO6vanid7KBIAhp5cxLYoGe0xAWNXG31IA8GYliTFTRaZB3Ap9Ea2abr5gpfjWPD8ocz8YFqhtbHnGnjvPeSqWA7MbJtbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DB9PR08MB9683.eurprd08.prod.outlook.com (2603:10a6:10:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 15:04:34 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:04:34 +0000
Content-Type: multipart/alternative;
 boundary="------------0gPaLWO00EbeoxdXIuAOckrk"
Message-ID: <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com>
Date: Fri, 10 Jan 2025 16:04:33 +0100
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
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com>
 <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com>
 <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DB9PR08MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: b89ea1e8-aa0b-4b55-a165-08dd318817df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Skt3ekpOZ1dkdjk3d01ldUFLUUhjQXdiWGI5NkVQWlhGeWs1UmlmNmZaa2tD?=
 =?utf-8?B?MUhXLzFlT2Zxem9oR2s0WXJtam9KVVRUb3pyMkdIUHdpM3B5amlQUkVhdUh3?=
 =?utf-8?B?eUY5WktZZmlmUkRmbTdhWjNiSG44dXZVcjN0WVM1eXhuNXk1RzBHb1dUcG9D?=
 =?utf-8?B?KzRJTXBHeHRjZmtaYUhKYTRhN2xOWndCa01WbFY0MUZUVlFSVWFYTGNadHR4?=
 =?utf-8?B?N1lpSDZ4UWxEck1QUEllRkhVWmlNa0JTRTNHZXhZMlkyTEc1TVptTkNPdHhO?=
 =?utf-8?B?TDRNZWlrcmZneEVLNGR6djdiVXczcThkTUgwYkgyUFgySXZZeXljdEUrOVpp?=
 =?utf-8?B?aDQ0UlJEYzRCemFQdHNZYVBsZk1Ed3Jqa0VIbnBNL2p6VkMzRzdHU3BQWVZu?=
 =?utf-8?B?clZ1TVBjU3B6dHJLQTc3QUphSnJJUCs5Vk45M1Z3d09EQkVIdkhBeWVHOFkw?=
 =?utf-8?B?eWxoeGlRN0hwTlZjaE1KbXhtZEpLQUpZcjFPdVh0Nk9kZ2tRdS9PRGV2Z0Ji?=
 =?utf-8?B?bkVzdE5JQjI5NlFhK0J6Qklta2NBY0tzMmw4R0syRG1hclJWVmR2cWpiaFRo?=
 =?utf-8?B?VWs3bVlTU3RYaVY2L2dqUVhBODZiMVM5cE9ReEtZWWVzREVML0QrQWtQa3FX?=
 =?utf-8?B?SlNFMGJDYVFqUEhvblBYWjluWTN0TGZ1L0ZGVllXcm5DaFZab0JNS05IVFYv?=
 =?utf-8?B?dVV0QTBiQlR0Z2FqQ3h5SDJmN2lYd3FLcWdvUUVxNGJLazFwQk43Ry9RUmh4?=
 =?utf-8?B?TWNEQUJyMzRUTEQwRHlreklzT2JobDZxQWRpcllzV3ZpZDhMUmhLK21kSEk4?=
 =?utf-8?B?d1M3TFpJVVFTcWUxd0VVWTNRMEMxbXBOZEdVbWFOYzZDRmc5YlAxVmtHaXpv?=
 =?utf-8?B?Znc4aWhlaGV2L2lwbllsV05MdnZ3RGU4RGVnYitkU1FEcTBoVnJ2SVZ1ZFk5?=
 =?utf-8?B?VDNLa3VFa0hDWjIyMHVSNGIwNC95TFhyMGd3VHFBc0F1WG5kcEtrVFo0Sm14?=
 =?utf-8?B?T1dkWEJxTXNCMWlvaEY0YXVXS1cxeDQyS2F5MUlmbVZmV1ZVakNmeW5wR0h1?=
 =?utf-8?B?NGVIRjhBQlF4QlZWNUg4cG10UlBaWWl0Mi9Rbk8zTHk4cjdhc01yc2ljOVpY?=
 =?utf-8?B?bUIybnNLRVBSeXY3UFFpb1FvR01NTUVmR2tFODhqR0JnemlqaDc4VWtCUDFm?=
 =?utf-8?B?YjVVcjJRTEVrM3loajR3TEI3ZEJtclk3RkwwM1IrZE8zcmdMbGh1aFMxTDl0?=
 =?utf-8?B?WlJUMEczL0VrYmpYdG9oMlNzYXlyWmg4MFRWclpLcFZ1bnVtNEZpR1R2MjUz?=
 =?utf-8?B?dWxDQXM1ZUNTWWRYQUhRd0tncUVBQnVPWlI0RTRnUm1qemp2d1hFMmhncGRK?=
 =?utf-8?B?ZGpQeGptTjZLaXdnTlg5cWVEaWg0VnlzdVltMVcrVmFtNnJIaGFiZVBoRlZp?=
 =?utf-8?B?Vm9PSCtvMFhlOUIyOUVZYlB3cERsQUxKZzR2Q0Z3Uk5GUTJRMStNaXBxT1Zm?=
 =?utf-8?B?eUkvNjNMLzdjSDh3a3hkdVFTUlJHNFNZKzNYV2swM1IyVmRnSkVVbzM1KzBC?=
 =?utf-8?B?bGVIb2x0VWdkbStxM3l0VDEvWHRKc205YTlRNzhqWVZBTkw1a05sRjBDbnBv?=
 =?utf-8?B?bWxsaFJqNUc2dVgzRkhDVUZGaUdKRlRFZ1ZGUGIyMFZXaHZsNkJQb3J6Q25h?=
 =?utf-8?B?ZjkrOS9aUmR6V1B2Um95WEZUTGJPdU1JU2ZBWDR1TE5rM05qWGRlOSs5V2Q3?=
 =?utf-8?B?NS9SRFJRN2xMdEZ2OWxnL1RzdlU4YzAxKzVkWjNmZjNwaHVhdUhtM3ZjTEMz?=
 =?utf-8?B?c2xSQlJyVk9BTXBkUWs5b2ZITEt3U2tXbjZid285M1NHVXhtbWN5TTFSVmw1?=
 =?utf-8?Q?y1u/agepRamYM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aW56aUxYTXpmM1N6eEpHandSOFA4VElZMHZCWThoTjQrZFVFVUs0WC9CaXRD?=
 =?utf-8?B?SVM4NGdYMGhjcTRoY0pSZ0pQNWdJMmxzdytSQm5vRmtpbGp2SmFYWmNwWHcy?=
 =?utf-8?B?MkgreEJqbExOWDJZVWxqRGhRWit0aDZBOTE4OGQ0TFJ4RlUzR1VJdGdiSTY1?=
 =?utf-8?B?WElCVHZ1andzU0hjcjdOUE9VV01nRzRhTGVrbzJMUnREVWlVNC9OeXVoRXkr?=
 =?utf-8?B?STFyeXBhcTY0RVQ3ajluaXduSDdPLytJU3dLQW55NE1WU0RQczlqa1hkU0hy?=
 =?utf-8?B?N3RRYmozWDBHWlpKMlZXYTVJYmlaSEFjS0dyZFhJbktwcGx4YWZ2YXlKd1Ew?=
 =?utf-8?B?UlBaK0taNGEyNjdhSmV3blh2OHM4SlBoQjgyZEl5dzN5NXhwdlFMT2dDdWxE?=
 =?utf-8?B?ZlNnZHVzemNVbGNMSVFLVXBFa3d5YVJ0eTdMbzhQcFE3VlgyUUFkbGwxeG0w?=
 =?utf-8?B?NDlqT1lYZTNET2xMWlhwWHdBNDN4dkR4WFY4MXB4bEdKclo0bHB6ZFNrMUZV?=
 =?utf-8?B?NDhLcDV1bytnYmFId0F0UkEvQlVIMFk4Zm9hRDNFOHYzS3pzK0NRUUlCQmc5?=
 =?utf-8?B?dVRyMzhzTlhHcHhkakdIL09lZ2tJQlh4czBHNTZJcnA0ai9FZERXZk5JemFv?=
 =?utf-8?B?cHgwU0ZpU2xsbWZELzVmcHA3RmlqWkk3ekpoVEVRNTJBbDJhaTNBMXFtRFlT?=
 =?utf-8?B?QWlqdWtrMm9DZGJpWE1jamNaSEI3Sm5rNHp6Mk9rd2tUclZ1K3hTRkpNMUY2?=
 =?utf-8?B?OHdLeVdHU0lUa2Yyd2ZIWjg1TE9IZ0FMQm9yYXhiekZ5b0FlcVZ1aGZOQzNn?=
 =?utf-8?B?dWdrTVYvc0NxM08xTWZzZDBidDcrZnYzQlJqdnpzcjZ3YmMydlVidVRiNUp4?=
 =?utf-8?B?elUyczVhdUltSDN2dEN4WnVrMDRWNHVCNThMQ0g2K0RPUVB0TU5vMFZoaWY5?=
 =?utf-8?B?Z09HNWcvQUM4dWhXdFBOWjFaTjloNWtxNFp6V0pGbHRHYlhHLzRaN3o3ODhW?=
 =?utf-8?B?eUk3WVI1TFpLakNodWdNNm00WGwwYXpRSGNTRjlTK3lSUms2dU9pUTZGZWNj?=
 =?utf-8?B?ZUJTOVBSS1hHVTRQejVnY29jb29pcjlUUkxJV1pSTE1MYnNJdWcrL3ovdnBR?=
 =?utf-8?B?U1ZPVXhpWUN0MXNWYkJHaUFDV0x3NWtlbjF2ZXd5VFRoU3VVUEJ3TWRVa1lV?=
 =?utf-8?B?RnpmelM4K09HZWxQcHhkM3lWT0VRQTJ4YjI3SmNGcm9Idi9aVnZwd2lnRHBn?=
 =?utf-8?B?WjluVE9PV3pMRWFKeWhpRWJDQThZb2M0NURHQnRpTkF4SG10OWw2c2pqS1JF?=
 =?utf-8?B?WC9qSlhpTFU4YXpsczlvelF4QkxGay9hWFRyaGN6L3VnbHNzRHhWTWVJNCtm?=
 =?utf-8?B?Smg2K0JJckR0dnhYTzc5QU5uSEFzbExRMUpZOVJYenQyNHZoS2tuQkVBYm5n?=
 =?utf-8?B?Q2VjWFlSR2poZVVBdDNlRXFzNUcxUHRMcE1SM0RoVy9YSzF5bnA2bEhGcWlo?=
 =?utf-8?B?M1poQW5kOCt5bDBsbzJjdGFVOHFBbVk5emFub2tLaDdiNnpLQ0dXR3phWHdj?=
 =?utf-8?B?TVVheWJLaitCZWN4U3REcWpWTm15WkpISnVNNWdYRW9hM3hzWTZVUHVsSzlr?=
 =?utf-8?B?QUNaK1BJQ1JabTdSb3FTaXlRN0t2c1BodnlKZS94aDBxMndnUmFlT0x1OW0r?=
 =?utf-8?B?eGpGd0dQWVVBbXJBdys0OXlqOVNvdzhHamIvcFdHM2pEdXJDTzNhbXp4NjB1?=
 =?utf-8?B?U1dYR0FIQkNoTEZpSlpMbjk1YXRaamxDOEU0cTlkelFYTENieGdwc053U1JR?=
 =?utf-8?B?MzhhcnZQeE82RFN4Uytka2huWWpmcDRkaU5rQVJxeTRtK1lTeUVpSEdLb3Ba?=
 =?utf-8?B?R09LK0FvQjJkRm1yeDE2K20xRlcxM1NwRkdlSmFsTXREU3dFRWx1aURYY1l2?=
 =?utf-8?B?NXZqOHpIZk9YdXFRODBNOWFVNFd3aTEzV0tVZStvc1F2VzRsYWVINis4cTNs?=
 =?utf-8?B?bUNaRGNSU2h6VFFCTTJpOGhFMUx0WGZLbW01bFJuZXhqQlZBYUVOOHZ3Q2Jt?=
 =?utf-8?B?OHNpb3pmc21mbEFSa084aERHUVc2OVJ5Nk13TFNhZUlXMHlOUVhJajdiWWpE?=
 =?utf-8?B?N1lEUUVNNEFtWmxCa1Fqd2JqTm5VMHBhbzNUTWpQYnhPTDl1MDArNi9xQTli?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89ea1e8-aa0b-4b55-a165-08dd318817df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:04:34.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXRSzQYwUDFzn7ZbODHczlVbu9vduKOLSYdZ44RO3CxwKSFio+h+bLZ3hm9gKfqxBT4yHKJxiai+NKhoJRbVLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9683
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 15:04:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17006

--------------0gPaLWO00EbeoxdXIuAOckrk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:
> On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>> What is your opinion regarding gitsm. Should we remove the bitbake fetcher and use a update task to generate a inc file with the source uris and source revisions?
> That ship has sailed. We can't remove gitsm, it has users, and they
> will be very angry.

This makes it impossible to fix wrong design decision or remove code 
with a low code quality.

>> Do you really review the changes of the inc file?
>> I understand the points but I have the feeling that they are more theoretically for package manager dependencies or could be solved in an other way (ex. caching)
> But do you? I have to restate the point: a solution that can be placed
> inside a layer is much more scalable and maintainable than adding code
> to bitbake. That's why I'm leaning towards drawing the line at
> existing fetchers that are wget/git convenience wrappers, and shifting
> dependency/lockfile management to layers. It's ultimately RP's call,
> but he does seek feedback :)
I'm working on it.

> I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
> new versions. And since you asked, no, no one looks at them, they're
> auto-generated noise that we learned to block out, just as we learned
> to quickly skim over recipe patch changes that are just line number
> churn and similar non-functional changes.

Instead of an inc file the generated SRC_URIs could be saved inside the 
work directory of the recipe. This will eliminate the noise and avoid a 
manual run of an update task after a recipe changes.

>> Even if we put all license information inside the inc file. Who should review the changes ? What tooling is used to review the change (license content)? If we blindly trust the inc file generator, the inc file is useless and we can generate the information on-the-fly.
> We won't blindly trust a generator. There are multiple gate-keeping
> steps, some of which already work, and some should still be
> implemented:
>
> - when creating a recipe with devtool, devtool should discover all
> licenses and generate appropriate recipe metadata. For classic unix-y
> components this has to rely on 'guessing', but things like crates have
> deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
> files if I remember right). We can also propose adding such
> determinism upstream if it's not currently good enough.
>
> - when updating a recipe with devtool to a new upstream release, it
> uses thefile:// entries in LIC_FILES_CHKSUM to generate a diff of
> previous license texts and the new ones, and writes that as a comment
> into the updated recipe. The diff is reviewed by a human performing
> the update, and condensed into an update to the LICENSE field (if
> needed), and an explanation of what changed in the License-Update tag
> in the commit message. This could be further automated if upstream has
> deterministic ways to specify licenses, e.g. LICENSE =
> "&".join(all_license_ids).
>
> - when sending the resulting patch for review, there's a mailing list
> bot (patchtest), which will check that any update in license checksums
> is accompanied by an explanation in License-Update tag. There are also
> humans which will check that the licensing changes are sensible.
> Otherwise we do trust that submitters spot important changes in
> licensing (from the diff in the previous step or by manual comparison,
> if they want) and summarise them in LICENSE correctly.
>
> - finally there are various license checks that run in recipe_qa task
> and implemented in insane.bbclass. They could be extended to verify
> that every dependency has a matching license entry in the recipe and
> so on. Anything that can be caught by looking at the source tree and
> the license metadata.
This works for individual project but become complicated for 
dependencies because you have to handle the same change multiple times. 
But lets stop the discussion for now because license is out of scope of 
this series.

>> Nevertheless I will move my implementation to oe-core and add a task to generate an inc file as starting point.
> That would be much appreciated. The more I think about it the more I'm
> convinced we should have it standardized in core.
What do you mean by standardized?

--------------0gPaLWO00EbeoxdXIuAOckrk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 10.01.2025 um 14:26 schrieb
      Alexander Kanavin:<br>
    </div>
    <blockquote type="cite" cite="mid:CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
<a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier-oss@weidmueller.com">&lt;stefan.herbrechtsmeier-oss@weidmueller.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">What is your opinion regarding gitsm. Should we remove the bitbake fetcher and use a update task to generate a inc file with the source uris and source revisions?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That ship has sailed. We can't remove gitsm, it has users, and they
will be very angry.</pre>
    </blockquote>
    <p>This makes it impossible to fix wrong design decision or remove
      code with a low code quality.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Do you really review the changes of the inc file?
I understand the points but I have the feeling that they are more theoretically for package manager dependencies or could be solved in an other way (ex. caching)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
But do you? I have to restate the point: a solution that can be placed
inside a layer is much more scalable and maintainable than adding code
to bitbake. That's why I'm leaning towards drawing the line at
existing fetchers that are wget/git convenience wrappers, and shifting
dependency/lockfile management to layers. It's ultimately RP's call,
but he does seek feedback :)</pre>
    </blockquote>
    I'm working on it.<br>
    <br>
    <blockquote type="cite" cite="mid:CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
new versions. And since you asked, no, no one looks at them, they're
auto-generated noise that we learned to block out, just as we learned
to quickly skim over recipe patch changes that are just line number
churn and similar non-functional changes.</pre>
    </blockquote>
    <p> Instead of an inc file the generated SRC_URIs could be saved
      inside the work directory of the recipe. This will eliminate the
      noise and avoid a manual run of an update task after a recipe
      changes.<br>
      <span style="white-space: pre-wrap">

</span></p>
    <blockquote type="cite" cite="mid:CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Even if we put all license information inside the inc file. Who should review the changes ? What tooling is used to review the change (license content)? If we blindly trust the inc file generator, the inc file is useless and we can generate the information on-the-fly.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We won't blindly trust a generator. There are multiple gate-keeping
steps, some of which already work, and some should still be
implemented:

- when creating a recipe with devtool, devtool should discover all
licenses and generate appropriate recipe metadata. For classic unix-y
components this has to rely on 'guessing', but things like crates have
deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
files if I remember right). We can also propose adding such
determinism upstream if it's not currently good enough.

- when updating a recipe with devtool to a new upstream release, it
uses the <a class="moz-txt-link-freetext" href="file://">file://</a> entries in LIC_FILES_CHKSUM to generate a diff of
previous license texts and the new ones, and writes that as a comment
into the updated recipe. The diff is reviewed by a human performing
the update, and condensed into an update to the LICENSE field (if
needed), and an explanation of what changed in the License-Update tag
in the commit message. This could be further automated if upstream has
deterministic ways to specify licenses, e.g. LICENSE =
&quot;&amp;&quot;.join(all_license_ids).

- when sending the resulting patch for review, there's a mailing list
bot (patchtest), which will check that any update in license checksums
is accompanied by an explanation in License-Update tag. There are also
humans which will check that the licensing changes are sensible.
Otherwise we do trust that submitters spot important changes in
licensing (from the diff in the previous step or by manual comparison,
if they want) and summarise them in LICENSE correctly.

- finally there are various license checks that run in recipe_qa task
and implemented in insane.bbclass. They could be extended to verify
that every dependency has a matching license entry in the recipe and
so on. Anything that can be caught by looking at the source tree and
the license metadata.</pre>
    </blockquote>
    This works for individual project but become complicated for
    dependencies because you have to handle the same change multiple
    times. But lets stop the discussion for now because license is out
    of scope of this series.<br>
    <br>
    <blockquote type="cite" cite="mid:CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Nevertheless I will move my implementation to oe-core and add a task to generate an inc file as starting point.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That would be much appreciated. The more I think about it the more I'm
convinced we should have it standardized in core.</pre>
    </blockquote>
    What do you mean by standardized?<br>
    <br>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------0gPaLWO00EbeoxdXIuAOckrk--

