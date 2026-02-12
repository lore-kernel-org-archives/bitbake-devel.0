Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64008EB491D
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 12:50:44 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44637.1770900637199166093
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 04:50:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=cwCi51OC;
 spf=pass (domain: cherry.de, ip: 52.101.66.71, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiEGbJT9nO27tKA9Be9hUslVSnqe2wD/HtYdv05kWpLP7PKvktRgL8Wkr+H2ryuewiabV0xbUfnAh+EnNgkctVi5bytwIPdHkSLCElEInwRvrWq1FlwXl8A7wTduRPIKaSa1WsAi6SzJRI1jB6X32HdzrF5hmWoF9/E9GY3njdNydGlmpHv5Ibz8B7Aul7lbe3cyb9X/rXyXuilL6lup/CmHH7SimCipxeqfI/Vc8x5lsUnx/bL/X7dFn8JV7JUi39x8Zj8YeFZ7OWAY1C/nG0h8EOixQtnj75aJmMbBMVLhkfJ7xRadzeB6iNIJWEW1C/UoL1vCdp/mbhHPjMx+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZG3OvW6uNxWt4XbnmqCycitnGIlRKsI9lXt7L3qiPM=;
 b=ABKmf1x311urzuuEHRozmXlME8okB81Hb/1NwcymXM700WczltXdoRZJj4aDsJjxxuTgFTwSBszVbrIsMo9h6hpjVEBVpsbYNb/MBKCr5fTFWdgq0zXRPh/3eQ7uTd10gmRbgndoYNB514wFybgqWqhVIRczd9BEOoKyFnFwRTAiOp3F1crERvKJsTC6kSNwdM99kmCQdlfG6LRtaSW7nR6sGbQemK3ao/Z0juvMRat/BN0hxae/XGs0qgLeCNv0zcWWKhOCyyeOv1IDXgukEgYVFKB25yKAWc6UUNioV3PqYOKepw4+qh6IW7Qqu4KgzYvAjPlJCRz4oQDZC+A0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZG3OvW6uNxWt4XbnmqCycitnGIlRKsI9lXt7L3qiPM=;
 b=cwCi51OCRbMrv5DIfa93bF/Sevxee5djAc+gCZ98fmt220hgefOqKBMqND+NUverYFqwXfzvpQrF8MC8Y1Xikd79UNWaFI8oL9ygi3HZ4mPFdIcKTh4w4/sYUQRkMLeDtD2rxTclHxgUm6MgONpOSQA0ozGTCvfgcyyzawUW72E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB11864.eurprd04.prod.outlook.com (2603:10a6:150:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 12:50:31 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:50:31 +0000
Message-ID: <9d7c24f3-3061-44e8-a2d4-9c41835c5403@cherry.de>
Date: Thu, 12 Feb 2026 13:50:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 Rob Woolley <rob.woolleywr@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 Alexander Kanavin <alex@linutronix.de>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com>
 <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
 <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de>
 <CAGAhMBwAGcAqT+m0+XOC=KCEgxXAj=86Lqt35wD4f5JmozXJMQ@mail.gmail.com>
 <CANNYZj-cqAEQ77PHOUd48RcNq3LYJiw_tPTxnABLe2+y+XXh=w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANNYZj-cqAEQ77PHOUd48RcNq3LYJiw_tPTxnABLe2+y+XXh=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB11864:EE_
X-MS-Office365-Filtering-Correlation-Id: eee57bcd-ac33-4a8f-8aec-08de6a354e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K0FoWDlzZEF2YmMwUngvUm50alRyeENlUFErUGZLUWROcy9kTjFkMHdUQnEz?=
 =?utf-8?B?b1BQNnlCVG9lcTZNdmI3UW1tR3duemtObjRTdFJYTGdiNlpnTlBzemZCSExq?=
 =?utf-8?B?Z0F3ZmpBS1lycnRuQUVEMlV6N2V6Zk5vOHFBaHVMS3AxbXU0MzBXNEdBUEh2?=
 =?utf-8?B?T2k4MXg3UHY3OWNRMlFkT0Q0d2NVUFpEcVFpRFhJKzZQcWVSNDR4aXlOa1Jj?=
 =?utf-8?B?V0FRdEZZYUxlT2o0cmpKZ3ljSnVJUU15SHZFYStuZm9VY09wRUZxeDc4Sy9M?=
 =?utf-8?B?U2RXalFGUjBUcmdsR3lmNEFXeUlseWJKckY4OFBQWVk5UEgvUWhBL1pFanpY?=
 =?utf-8?B?Vk13akV1UGFxbUFHSXdHRUNnc3dHUWRLaGM4aTVvdnhNdXFvWmRSbGp1Z3JU?=
 =?utf-8?B?N1BVd2F5MUo0a2VSeDNVNXJ4aG1DZmEvNmh2UGQ3V2M3WTZBZDhrbzU3UE56?=
 =?utf-8?B?Njluc3M4STlmUUVudjZZc0s4cVVmWnJtSXBCc04wZkVES3VQOVRtM2YweGRI?=
 =?utf-8?B?V09KN2xISGFtWDRPRlFFUWJSbDhlMkg5MGV0RU1CbFhnTzJRZkd5eVBvR0sx?=
 =?utf-8?B?akZnSWoxb3EyTDh5VDA3VVJjekxkT0QrM25HMk9yQXhYRlhzMWtqQXllUGxs?=
 =?utf-8?B?MzVBL1diQTNXMkE5ZE8rejZ5NHFTd3VUZzZodmhUNWduTkU0Um9FR0luMDNw?=
 =?utf-8?B?dnNhM0pxbkkvd2ZuYWU1bmpIem1URHFGNzdjakhYdjBuUUYvMis1RTk3V0F3?=
 =?utf-8?B?UlF3SVhwWFRtUHpyNkpHZHdhMFd3N3dSNmVNNXcyQ01ha05yam9mSHlDNzIy?=
 =?utf-8?B?QjlRN2UvZDRNRGIxSVlFOFA3OWFBa1NORnZJa3dlRkdieTRRK0h1T3pzTWFB?=
 =?utf-8?B?ZFpGVFlsRGRqbWdwQnN2cnlVRmJLYlRYUytuWGhzb2xaVGxCcE1CRVlNYktP?=
 =?utf-8?B?azNJNlJTNWFkMXVwN1lrdklMQ1lqUnpCaDJzSGFkdC9NRGZram9KOC91bTlZ?=
 =?utf-8?B?bitib0NKaGxYb0EzV2hBalFMcWgvMGN3USt1TFQzOVU5dTJQZVg2UHE5bUJs?=
 =?utf-8?B?dk5Od0hHMmNseU5aT0FYYk1sVXptWVhEVVUvRFA4Vkxmd1FMQW8rT2UyT3pn?=
 =?utf-8?B?ZHlBWVIzTGJSTVJIQ0c1a0IrNFl1b0JPUUVYU0FWVzNPbmJmb3NubXdyY1lz?=
 =?utf-8?B?TVBTQXdTMXJ6VUNyaGpqOVM2M2FCcC9Jb3lEVmJuaDNtWXRmNFZyTUdGYXVs?=
 =?utf-8?B?YXhpTFdwNHdDVTJ0eEFkSFBpMWpqVHliQ2Nkb0xBMmNiSTNlSWZyUkhhOTk5?=
 =?utf-8?B?c0ZRMDVlVjB0M0FibUNja1RaRElxeXF0WnJYaW1xMGdOVi9JQkRCbWZtVWRj?=
 =?utf-8?B?ZHVEalFOeUVWZUlRU0VQeGlsSEJIT3hsMlZjWmhJaWM1aDlyZWpqMkFYNjFL?=
 =?utf-8?B?aDdEdmFqRktSVVJhOVNaUDUwcVpiVlhMTS9MUzBJekdPSFFHR1VpMUlFdHdR?=
 =?utf-8?B?emFkTjZCWDZyRjhxMWczR0FVMHFuR2ZZM2liYi9iSGxhR2Y4dDRLZXpDTkVl?=
 =?utf-8?B?WXJncWYzZC91MkhONGhTb1B5bzF1WUMwOW5zRTVjeDNRWTJOUUI4bUM0NjhN?=
 =?utf-8?B?RkpJM05STWs1aThBeStuMEM2Qms0NXBZR29CS2VLclgxMU90cVRYcXl0L2pm?=
 =?utf-8?B?MWdXOFdMTzBNdUFwTStWUWNBVVRqUkJRM3NTVlVmR3JoSkdESEk2QjBtVzlH?=
 =?utf-8?B?aHFnelkvYWJFQ2pZS3MrMkpMaDlzUGdKRlpjak9UYkxwMjFqNjlESnRWL1Qv?=
 =?utf-8?B?Mmw4dHJxY2pPQ3BtMkpyeXhQU2FQdzBYRUovLzkwVjBhY0lUYW5tYzl4ZWJN?=
 =?utf-8?B?VTJIL3BYNzE2Mi9OZHRrMXhFU2d1S2hyaXFpQ1Z5Q2xUNnBFT2JyTU56TWxh?=
 =?utf-8?B?Kzhlb2hMcE5EMW5UWVNZWlJZNFZZTndvQ0F4cXFweWN5VFZQUGw5Y3pxUWRa?=
 =?utf-8?B?V0dMUEdoQWQvd0tubHdsUm1QOWxuSXg3UU43MWUxbmplYTFHeGUxUGdwczNG?=
 =?utf-8?Q?9TeF4R?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEZPRFh5M2xSQ0pmOVZveXAxMkRNU2QwWXc1bHRJSmZHR2g1R3FKY1pIbC9o?=
 =?utf-8?B?dnJzZ0tGUllCMEtKU1JmdTIwVlA2d0ptbXI4RERoM2ExYWk5TytEcEhiYk4y?=
 =?utf-8?B?Q09URitkN29tQXBWdWI5Z0Q2RzVKMVNVODVYSG5DSkxGaWZqOS9oKzhIYUVJ?=
 =?utf-8?B?TThSa3BlZUsvU1huZmVHZHRoc21ZNFZxSFlCR2pmYkc4K3AwZHQ1L0xpZSt3?=
 =?utf-8?B?NFhpa25NWUs0eVBKZjZzK3ZocWhOUXV3TjhZalNsend3QXRWdCtSbzZRMk5K?=
 =?utf-8?B?bVg2U3BtYi9iWnQ1VkpGYVYvdlN4WjhOU3FjZGZCQ2d4S25rVEgwK2VJVDRP?=
 =?utf-8?B?aXlWVlZyK3lxTERvTE9XcWNUQitOSlhtdXh0anUxRjVjMEJzM3ZCQjZYNUFW?=
 =?utf-8?B?L0pvWWJ6MGN3czh0cjY0VGtOb3ZuT3FhWUV0aStKYmpJT2RXb3BIOE1kSWd6?=
 =?utf-8?B?QjVTWUZvWXJiNFY2emgrN2FuOUs4YmV3T201b2JsTG1URGg2cGlldHorQ1hM?=
 =?utf-8?B?QndpelMyQVhFMjRaTU5IZm4yRTBmU29hbVV2VGNBL2NVOVJSdnRha3VqRThX?=
 =?utf-8?B?RmYzazViOUVCM1JKWnZKZmhVQVhRN3lJL2x2YVBSdXZ4K21xTjEyNEI0WmR1?=
 =?utf-8?B?VDF5TERZZlJROFIyY3RUVk11Z0JUL0NqWm13aEUvRVJVbFlGa0h1NmpGWU1n?=
 =?utf-8?B?YUxEc0paRytDbFl1RHlOejNhU01kQTU1UzJNcHRDS2pGWUc3OE5ZYXpQeXBn?=
 =?utf-8?B?cm02a0p4Q1M5TUxJQzY0cjdKZEladjRDYzhkMmM1YVZGeHFtd0d3OXRSTExo?=
 =?utf-8?B?T09QanZPZ1IvbzBoRklHdHZmc0FPS0dYTzlOcjRtVkVnMGk4dEF6QkgzRmpU?=
 =?utf-8?B?dUIvelk0V0RVSG1Fc1Rpb3BJeGZrbTZNcGFjUnAyenk3NFlUczRzRCtNams3?=
 =?utf-8?B?a3FtM3lLeHFvNHF1enZCSG1kM3Rya3lBcDNCMHJzRnRhYnVyWlN2NDJCNnRI?=
 =?utf-8?B?L09iVEhFQnoySmRGVDJzMG5rdGsvbzBFSERHT0w5eU5lSGNRbFN4QWhHdWk2?=
 =?utf-8?B?SUYxenZGZlMzQnRMdEczQSsweXRzZEpidmJzSjdKdFU1MkVPdllSVkdhU3Vy?=
 =?utf-8?B?QnhlUFpObGpWSk9GRWN3bzg2RlBwRUtZSzBIYzRKTUJDQ1Y4RXpVdEtGejV0?=
 =?utf-8?B?dHhkT2JDMTl1QVpoU0M1b1ArM1NmdU1INGJiVmdyOUxpQ0xMNVFvaUkxQVJK?=
 =?utf-8?B?cEUyRmlSSGFydFpvMGFWZXhOTXRPZEVOcVp4QmNqQVIyME0zd1NydEpIWWli?=
 =?utf-8?B?UERVaUFqaDFveXdWOWVUQmVraUtzV2RZdHBWaS8wNmUwNDRTYlVyN2ROMVdo?=
 =?utf-8?B?bTE4QS9xMGdLdjdCQlJxMFY3TVJxZFR2N241TnFZVld2SWR4RUp3OXF1MzhM?=
 =?utf-8?B?Q0ZxRjNaWjU3RGN2T0lKVkZhVnRwMDF6SWpZUEwvSVg2MlpTb0llVlFWeGRM?=
 =?utf-8?B?dXpMMnhIcVY1aE1OSWIzZW9IM085K3dlVm9wMjJJZ1cwdktvcExPSlZISmR2?=
 =?utf-8?B?V1I5UzkzaFE5TWdJNmFNS3pzcXdjZVR3WVFtbDhMQmdPSjh3d1pReVRKcnBt?=
 =?utf-8?B?VG85L1hQTlJZbzhITElKMDk4M2tFSFVNd3FucytHNHRuSDgzVzd6VC8rN3Rh?=
 =?utf-8?B?TlBnaktCeTJTbVNGNmYrWGRiM1V6R0R3ODE3RFRDSDRzUzFYVC9lS3o4R29r?=
 =?utf-8?B?U2V5RUthQXZqNHNqTlhYZEQ1T1hpY3ZtbkZvZGF2U0YrVGlNVml5N0pjYnU0?=
 =?utf-8?B?VUJqMitKSFRZQ1JuYXl1aTIxSFdPZUIzbFVpdEFCczBjZTErNnJYQW5ucldZ?=
 =?utf-8?B?VDBockNQbEtZcVB6a29od2dzZkFnVFo1RkVhWngxNFdXck9pdkllb3Vub1c4?=
 =?utf-8?B?azk0NkQrTkQxRkxKdXVrdlB1VjNVdlFxQ0U2eWsrdFZzYzhFV1YxcDU0YmI4?=
 =?utf-8?B?YjRpRUdZclR2YnJHRVFISmdPcTlwVk1YeU9xdVJQVXc5VTYvSE53QjlMR3ln?=
 =?utf-8?B?cFpETUVMM3lQa1RQZ0txTFVjSUJ4ekNpTDdkd1RlMkhtQkNxdnVQQUtMSTBs?=
 =?utf-8?B?MVg2YWlleWZlbXJ1ZWdrQjdkRGFNZ2dNUXkrYW5pOW5wZFRnMkhOcXl1N1V4?=
 =?utf-8?B?SmlWNWdQK0ZZTUxLN29PSkdWYjNKelhIRHp0TVVVSEdoWFRZcW1Oc25IZFNL?=
 =?utf-8?B?a09ZblBmSXZMS3pEclYxdTIvbU9HNDBaZHExTTZrdzhxM3B3MVBaVCtVQXlN?=
 =?utf-8?B?MFpIZTFLeWU1SE5KcEk2SUQ4N294TjNNMnNLdEc4dkRDUWZBZEYvZVBnVkox?=
 =?utf-8?Q?zr+CluALm7ymU5vTLd53/f2ryds+7MbTiKU5t?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eee57bcd-ac33-4a8f-8aec-08de6a354e52
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:50:31.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdPbh+8d3IlUfSmb+ZuR0of176O8poe94uAoa/sE7Ehg4dh0/yp3ba0lvqk/NQvxfH6TX6/pmPysz5O2RkGfg+8+AYP4PiuNOWD8kMaJig0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11864
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 12:50:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19019

SGkgQWxleCwNCg0KT24gMi8xMi8yNiAxMjozOCBQTSwgQWxleGFuZGVyIEthbmF2aW4gd3JvdGU6
DQo+IE9uIFdlZCwgMTEgRmViIDIwMjYgYXQgMTU6NDEsIFJvYiBXb29sbGV5IDxyb2Iud29vbGxl
eXdyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gQXJlIHdlIG9rYXkgd2l0aCBwaW5uaW5nIHRo
ZSB0ZW1wb3Jhcnkgc3RhZ2luZyBkaXJlY3RvcnkgaW5zaWRlIHRoZSBnaXQgcmVwb3NpdG9yeT8g
IElmIHNvLCBkbyB5b3UgaGF2ZSBhIHByZWZlcmVuY2UgYXMgdG8gd2hhdCB0aGF0IGRpcmVjdG9y
eSBpcyBjYWxsZWQgYW5kIHdoZXJlIGl0IGlzIGxvY2F0ZWQ/DQo+IA0KPiBJIGFtIG9rYXkgYW5k
IEkgaGF2ZSBubyBwYXJ0aWN1bGFyIHByZWZlcmVuY2UuIEFzIGxvbmcgYXMgaXQncyBpbiAuZ2l0
aWdub3JlLg0KPiANCj4+IFRoZSBzZXR1cHRvb2xzX3NjbSB1c2VzIGdpdCB0YWdzIHJhdGhlciB0
aGFuIGJyYW5jaGVzLiAgV2UgbWF5IHdhbnQgdG8gY29uc2lkZXIgdXBkYXRpbmcgb3VyIHRhZ2dp
bmcgc3RyYXRlZ3kgaWYgd2Ugd2FudCB0byB1c2UgaXQgdG8gYXV0b21hdGljYWxseSBkZXNjcmli
ZSB0aGUgY29tbWl0IGZvciBwYWNrYWdlcyBidWlsdCBvbiBtYXN0ZXIuICBPbmUgb3B0aW9uIHdl
IGhhdmUgaXMgdG8gc2V0IHRhZ19yZWdleCBpbiBweXByb2plY3QudG9tbCB0byBhIGN1c3RvbSBw
YXR0ZXJuLiAgVGh1cyB3ZSBjb3VsZCBjcmVhdGUgdGFncyBsaWtlIGJpdGJha2UtdjIuMTYuMCBv
ciBiaXRiYWtlLXNldHVwLXYyLjE2LjAgdG8gcHJvdmlkZSBhIHJlZmVyZW5jZSBwb2ludCBmb3Ig
cmVzdWx0cyBsaWtlIGJpdGJha2Utc2V0dXAtMi4xNi4xLmRldjArZ2QyZTE1OWQ4NS5kMjAyNjAy
MTEgb3Igc29tZXRoaW5nIHNpbXBsZXIgbGlrZSBiaXRiYWtlLXNldHVwLTIuMTYuMi5kZXYxIChz
ZWUgaHR0cHM6Ly9zZXR1cHRvb2xzLXNjbS5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvZXh0ZW5k
aW5nLyN2ZXJzaW9uLW51bWJlci1jb25zdHJ1Y3Rpb24pDQo+IA0KPiBUaGUgdGFncyBhdmFpbGFi
bGUgaW4gbWFzdGVyIGJyYW5jaCBjYW4gYmUgc2VlIHdpdGggJ2dpdCB0YWcgLS1tZXJnZWQNCj4g
bWFzdGVyJy4gSXQgc2VlbXMgdGhhdCB0aGUgdHdvIG1vc3Qgc3VpdGFibGUgc2V0cyBhcmUgYXQg
dGhlIGVuZDoNCj4gDQo+IDIwMjQtMDQtc2NhcnRoZ2FwDQo+IDIwMjQtMTAtc3R5aGVhZA0KPiAy
MDI1LTA0LXdhbG5hc2Nhcg0KPiAyMDI1LTA0LjEtd2FsbmFzY2FyDQo+IDIwMjUtMTAtd2hpbmxh
dHRlcg0KPiAuLi4NCj4geW9jdG8tNS4wDQo+IHlvY3RvLTUuMQ0KPiB5b2N0by01LjINCj4geW9j
dG8tNS4yLjENCj4geW9jdG8tNS4zDQo+IA0KPiBTbyB3ZSBjb3VsZCBzaW1wbHkgdXNlIG9uZSBv
ZiB0aGVzZSB2ZXJzaW9ucyAodGhleSBtYXRjaCBleGFjdCByZWxlYXNlDQo+IHBvaW50cyksIGFu
ZCB0aGVuIGFkZCBhIC5yZWxOK2hhc2ggaWYgdGhhdCBjYW4gYmUgZG9uZSBhdXRvbWF0aWNhbGx5
Lg0KPiBBbmQgdGhlbiB0aGVyZSdzIG5vIG5lZWQgdG8gaW50cm9kdWNlIG5ldyB0YWcgc2NoZW1l
cyBvciBleHRyYSB3b3JrDQo+IGZvciBSUC4gSSBsaWtlIHRoZSBvbmUgd2l0aCB0aGUgeWVhciBh
bmQgcmVsZWFzZSBuYW1lIGEgYml0IG1vcmUsDQo+IGJlY2F1c2UgaXQncyBtb3JlIGluZm9ybWF0
aXZlIHRvIHRoZSB1c2Vycy4NCj4gDQoNClJlYWQgDQpodHRwczovL3BhY2thZ2luZy5weXRob24u
b3JnL2VuL2xhdGVzdC9zcGVjaWZpY2F0aW9ucy92ZXJzaW9uLXNwZWNpZmllcnMvIA0KYW5kIGh0
dHBzOi8vcGVwcy5weXRob24ub3JnL3BlcC0wNDQwLy4NCg0KU3BlY2lmaWNhbGx5Og0KDQoiIiIN
CkxvY2FsIHZlcnNpb24gaWRlbnRpZmllcnMgU0hPVUxEIE5PVCBiZSB1c2VkIHdoZW4gcHVibGlz
aGluZyB1cHN0cmVhbSANCnByb2plY3RzIHRvIGEgcHVibGljIGluZGV4IHNlcnZlcg0KIiIiDQoN
ClRoZSBsb2NhbCB2ZXJzaW9uIGlzIHdoYXRldmVyJ3MgYWZ0ZXIgYSArLiBTbyB0aGlzIGlzbid0
IGFuIG9wdGlvbi4NCg0KQWxzbywgbm8geW9jdG8tIG9yIC08eW9jdG8tcmVsZWFzZT4gc3RyaW5n
IHBvc3NpYmxlLiBTZWUgDQpodHRwczovL3BhY2thZ2luZy5weXRob24ub3JnL2VuL2xhdGVzdC9z
cGVjaWZpY2F0aW9ucy92ZXJzaW9uLXNwZWNpZmllcnMvI3B1YmxpYy12ZXJzaW9uLWlkZW50aWZp
ZXJzDQoNCjIwMjUtMDQuMSB3aWxsIGFsc28gbm90IGJlIGEgdmFsaWQgcHVibGljIHZlcnNpb24g
aWRlbnRpZmllci4gSXQgbmVlZHMgDQp0byBiZSAyMDI1LjA0LjEuDQoNClNvIHRoZSBvbmx5IHZp
YWJsZSBvcHRpb24gd291bGQgYmUgNS4zIGZvciBleGFtcGxlICh5b3UgY2FuIHN0cmlwIHlvY3Rv
LSANCmF1dG9tYXRpY2FsbHkgaW4gdmVyc2lvbmluZ2l0IGZvciBleGFtcGxlKS4NCg0KTm93IHRo
ZSBpc3N1ZSBmb3IgQml0QmFrZSByZXBvIGlzIHRoYXQgd2UgaGF2ZSB0aGUgaW5pdGlhbCByZWxl
YXNlIHRhZyANCm9uIHRoZSBtYXN0ZXIgYnJhbmNoLiBUaGlzIG1lYW5zIHRoYXQgdGhlIHRhZyBp
cyBwcmVzZW50IGJvdGggb24gbWFzdGVyIA0KYW5kIDIuMTYgYnJhbmNoIGZvciBleGFtcGxlLiBU
aGlzIGFsc28gbWVhbnMgdGhhdCBYLlkuWi5kZXZOIG1heSBwb2ludCANCnRvIHR3byBkaWZmZXJl
bnQgY29tbWl0cywgdGhlIE4tdGggb25lIGFmdGVyIFguWS5aIHJlbGVhc2UgaW4gdGhlIA0KcmVs
ZWFzZSBicmFuY2gsIG9yIHRoZSBOLXRoIG9uZSBpbiBtYXN0ZXIuIFRoaXMgaXMgb2YgY291cnNl
IGlsbGVnYWwgb24gDQpQeVBJIHNvIHdlJ2xsIG5lZWQgdG8gc2VwYXJhdGUgdGhlbS4NCg0KSSdt
IHN1Z2dlc3RpbmcgdG8gdXNlIC5kZXZOIGZvciBtYXN0ZXIgYW5kIC5wb3N0TiBmb3IgcmVsZWFz
ZSBicmFuY2hlcy4gDQpIb3cgdG8gbWFrZSB0aGlzIHdvcmsgd2l0aCB0aGUgcGFja2FnaW5nIHRv
b2wuLi4gSSBkb24ndCBrbm93Lg0KSSBzZWUgdGhhdCB2ZXJzaW9uaW5naXQgaGFzIGN1c3RvbWl6
YWJsZSBob29rcyBzbyBtYXliZSB0aGF0IGNvdWxkIGJlIGFuIA0KYW5zd2VyIG9uIGRvaW5nIHRo
aXMgbWFudWFsbHkgaW4gc29tZSB3YXkuIFNlZSANCmh0dHBzOi8vdmVyc2lvbmluZ2l0LnJlYWR0
aGVkb2NzLmlvL2VuL3N0YWJsZS9jb25maWd1cmF0aW9uLmh0bWwgYW5kIA0KaHR0cHM6Ly92ZXJz
aW9uaW5naXQucmVhZHRoZWRvY3MuaW8vZW4vc3RhYmxlL3dyaXRpbmctbWV0aG9kcy5odG1sDQoN
CkNoZWVycywNClF1ZW50aW4NCg==

