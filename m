Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6808FE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 13:50:29 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.101])
 by mx.groups.io with SMTP id smtpd.web11.8047.1735825826340231364
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 05:50:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=mArZmlo8;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4xtfQoHsoLlSh7US7v0zfNVu4/zWVdKO7OK6OOM9b6Jzo0CaklcOPgpEoCgtcenNWxnFTJmutxQK8HjnqhkvIp+SUBhMGCaOMvjmJuEERsI9qaKfmxBfQsp1YkkNzowRD/z9RliflmFJ9SntQbKxNQNPw7cfVnD5DewrfQYwFknhr7gkbLrURI2qVaSzUEyNsKApAzwfSruYi+Vr1Fg6bL6fUENGnGQeIggMGxAXTHgakV+xV24HKJK8IkQw+0drgu04AIjXLrlwX7q7rVXk7v6TWqEyI1mgyJpjRvVWupx9dzTE0CIE/fJCo1DgiA3j10DC+RsZlrqZFvX5BdryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuLR51g7W/tFdrCk7etHdu7INoJKfWiHCQYqT31n3Qo=;
 b=wqd1R4S1hVQ6OI/+5HBptaZG8pIMbV0wMAlnobVGRhpIdjYEkEy5Z+aZTFAeIzmDRr7MnFdAAQ1hsrN1Nw6k13awFhU6N5J7pqyFxDGbWJkHHVNMdFA/wtR813KC+WmHUwA9p0lnlbF0l/ZMt0bzU5KPFXnSBZ/jqJxFfqiKHIr00mtoSNiaspNE3bYMkz9d4JmQf+2iDsH62e+X39T6lyeBPW4xT8pjP3yGTFZ7F6K5tWDXKI/XRijsKAcFLBFBu7HKWJfk4Tdd0z5i9RMf1Hx3y0XVAh7tAueoZxhfnAxJjAwOcQyRcAQNsSlgPjvOQ9k98l2I52f4tJ0UTIuaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuLR51g7W/tFdrCk7etHdu7INoJKfWiHCQYqT31n3Qo=;
 b=mArZmlo8FqzVFxR1lxND/WZqgNH9XoZed0T0ov7+HW9sBYNMMGHUBtrYMpoDJbsvHEGIl4fRf9JQR/RBVP1poW0SIiiwii/GbaTC6ygLmkw4t4Y7XdtNThbnH5dTWanxkHACcuRw5Kwzg5j6Y9OjCaz5RR3iWSKyXuiiPvIAOHn8Y8hpy3jY7u1a4wfX5UGDGHMl9kXAxGVuRUYDR4V1TV446L9ZWG0Vy0jlkqN7FR5nfJSGDzZ0Hn6ugTHNVZLutV/WnSDgwMh5pRZn9yQ0AQ67qJy42lUPmucHTdztyyNMCMbui4eaFed6lPLesPN2jJ123YKLAnin8SGdvIPQdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAVPR08MB9860.eurprd08.prod.outlook.com (2603:10a6:102:2f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 13:50:18 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 13:50:18 +0000
Content-Type: multipart/alternative;
 boundary="------------Ghlx0f0Cm7REGA9HIW3sVmKk"
Message-ID: <f5aaf9dc-6c1e-44c1-afce-33c6beac0290@weidmueller.com>
Date: Thu, 2 Jan 2025 14:50:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <347682f4-d1ce-4f8b-9665-3a3490235d1e@weidmueller.com>
 <7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|PAVPR08MB9860:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbab514-059d-4e3b-3a1b-08dd2b346489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UWhneGRncVVGRUxKaWEybkI1UkZnUkhkeVJ2dUtCQTlISWl3UngwSWgxUks3?=
 =?utf-8?B?L1BCM2I0RFZKSjh0c0lTNzQzNkxzWE44WW9oZUR5TVRONGdOcUYxQ2dqbHpt?=
 =?utf-8?B?Y2FML3VSTzdUa0ZPcDZvSkVUL2hYc0d6b1pLelM2USt4YysycWtjb2gvczUr?=
 =?utf-8?B?aTg5OXRVMlZCc3VuOWZmRVgvVTJJN1EreHI2SDBTVnRPdHNPVlppWm1OZ1Zt?=
 =?utf-8?B?eVRSbjJDUVZNVmJkYThYSlVrL2V4dDBOOStKeE1JS2d3cEMrVkFSbGJqaXVj?=
 =?utf-8?B?cXhZYXp1NHZWc28yaUYzQ1hMMHBOeGF6bktSNE5nbWJ4anRJb3VHZXRxV1N5?=
 =?utf-8?B?UUdYMlR5QmNrZ3puV3RyRGdEZDF1TTVjeUdoMGRUZ210VlpGN0RWMnQreW95?=
 =?utf-8?B?SUhpU20vbDZMODFVVFMva0lIeVlzaGhZVWhZQmJBN1NCSWtDMEV3eElNWVFi?=
 =?utf-8?B?aktmbUdKbUtvUUw1Q0FjZVViQktQWTVPSmFvYW5HTzl3Y0ZRekdWaDhHd3R3?=
 =?utf-8?B?ZWJXZlpIVGpQR29CcUVndFVvTWx2T1ZJYmorMlRDWVRVa29zOTZnVlg4WFJR?=
 =?utf-8?B?ckN6SGJlVjE1d2JqSTNSVGV2QUFlM0lRcU9JUG4ybkxDVWdnYXgxZ1J5cFNj?=
 =?utf-8?B?SkhUcWM4UlNES1JjT2VWUTJmVGdJUGpsZFo3VldEY3F0ZGRnMEpZdFBZOTBI?=
 =?utf-8?B?ek5LVjlHdlllTTFzanJ3cERaL3NvUGlyOWpYOXVYcS9OTzFiQllYbk9XWFhI?=
 =?utf-8?B?enNVWmFrVDhVb29FT2NJYjlqd1RNQUdXQnc3NUI3eEpZMmFsdnA0U2tuZmE0?=
 =?utf-8?B?QmNNdWhHVWJIVHJaQ2k1N29idmtnNjdNamdidDh4NFB5NDYzMzhZRlhRSVRo?=
 =?utf-8?B?aXYvRFA5d0J3QThEc3IzT3ZrYXFyK1hNRUZ0a2kvZUQ3N1RZZU9IS1hXYVFK?=
 =?utf-8?B?UHVLcHg4UjRJQWp2dmVPcHNUMUJPOEt0TjhqZzhXNkFQa0NHM1E5bG9qOERY?=
 =?utf-8?B?YUw3dEhqcXJqYzllQThZU3hzTXNrVE1TYnZBajJNaG43VFllbFdtS2F5UWc4?=
 =?utf-8?B?bDBHMFpjbmIvQ0ZFck0rSVFHd2EzRmtlMnB2bkxlOERSTTZzSkpGRnJ2Z283?=
 =?utf-8?B?aGRXVWExdkMwMUxyazR6aVFvMkJac3ZMaGVZV1VvamM2WDNaT2ZMbkQ2N1Fl?=
 =?utf-8?B?SlRVUmx3R1ZsZnpqUmhrWkpoRVlybGxzbFNMazNHOVY1ZHRLYVhlb0paUE4y?=
 =?utf-8?B?UEd4ZmRMOVRYaEdUcDJocmFXYzlLTjZ0dDVVdlNLQnA5UkVqYW51TkIrRWVW?=
 =?utf-8?B?cGVYV3RRaWsvRWVKdlRHWXZQZlBHazJyWnh6MFFrWk5mKzl4di9UNEkzSUVD?=
 =?utf-8?B?cy9hcVlmNnA1bXVGcmk2eVlwVXJGZm81d2FHbTVqTTRxTVQydGk3Mzdjc2Q4?=
 =?utf-8?B?QkdYUW9ybUZ0Y21HMStHZVluMDNFMmtrdzhIcGhIcEhOYXBnKzg0YjZFWVB3?=
 =?utf-8?B?MTJyWUtRSG9UWHhkS3JwcTlnblRZMVllWkowM0xWVXlGQWFxQzF1a3lLaTUx?=
 =?utf-8?B?WjFJMFhvYU1xZ1ZWdG0rbmk2Z2FkTFg1cWNvcGJIMVpSTlRMMWw4cmsyelRU?=
 =?utf-8?B?VUh4MVlWUDIwRjk4emVBN3VYa0h1eHFDZDhqcW5CS1dnZFd2RytITXo2ZEtE?=
 =?utf-8?B?VE5pa1pSRnJGVmxPT2tsOFJESlRtL3QvcUp6TjdqZy9hR202Q2dlb1RPNTAz?=
 =?utf-8?B?dHplSFgxZUtuL01wUkJBN25yZUl5YktsUkZIUUZoN056YUlsYWVYUll0cjhQ?=
 =?utf-8?B?RWlzK01lbHU5WjhpZjR4Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUo1TjduVjg1dUovVmRUanBocUVRc3VCdDZtNUJQcUZTa2ZTQmpvWkpnUzlJ?=
 =?utf-8?B?ZmNPc0w5b2cyMmVnN0IrNWFxOTVlV3BYSW9wN1ljejlZdHhJWEF6Vk03aEhy?=
 =?utf-8?B?dnduaHFLK3NETzJXdlExdlpmdDRsSkdTRVVhdXpDSjJUN1NNT3dlaXIxeEtZ?=
 =?utf-8?B?akFUUituWU5rWTJSMldjYTJQMXNoV1ZJbmxKV0w0REY3eUpmZFhqejhKcHZV?=
 =?utf-8?B?SnF5bFpTUTFPOExueHFJaWVqNVRDK1daN1lVSmxuaExTTEQ4V1kxV1hBTXVK?=
 =?utf-8?B?V05rcjVzblJQS3lWYVY5Z2RWOERTaEZ4RnU0T1RiNmlMWDZzSllsNW1STitj?=
 =?utf-8?B?UjltbzlRa1gxaHFaYkZROVZhOVhwZ2xlNEFMWnJ2RGdrOGdSSUJiMElNSDJZ?=
 =?utf-8?B?bWlxL29uZ0htWEJ5SjV6akc4ME03bmIrZXhDRjFvZDBYTDdrOFU0MTdOeXRt?=
 =?utf-8?B?QWIxSUNQUEUxZzFvTGhrSElCcEhXcmRZaGt0QSs1VTdGaXFFY3J2T3ZqR2V1?=
 =?utf-8?B?cVI0VWFDTUF0TWQycm9pZyt4N0ZjSGdtdXdLcnZzcGg0REU2VWs0Z3hmRkFM?=
 =?utf-8?B?TytSYitNY3RhV3VkVm42YjdGUjRjNDVEK1NmSFpHenBtaGNPbCtkR2lHRU1W?=
 =?utf-8?B?RFd4TFZIN25jUkluaE9OSGJFbllEeDlRNmg0ZGx3bTZpaGZXUTFkQkRINHFx?=
 =?utf-8?B?WkF1M0pUS2ZUVHhPaG9qbm5kelBNMUV3dFNYUXVSZTdoZDVDUlZObW1JV3pI?=
 =?utf-8?B?eFlXT1Nsd3VOczllcjlsb29sN3dDMUg0MnRRVG5wa3VMdVpZdXUyMElHWTFn?=
 =?utf-8?B?UTBGM1lVVmdIMnh4VXE5aHZ2dCtlVjVlKzFUWDlQalJJOGtodjRVdEZWSWdW?=
 =?utf-8?B?S2VScTJzU2d4RldGblFqWjk1d3RWTnFPM05Pek9MM2g4OWVIVHZFRW55OUp3?=
 =?utf-8?B?bi93TG1nR1ovSDhNYmxGeUNUYWJBN0NMQXptYWJoNmJBbGVhbXpQRTlRQUVD?=
 =?utf-8?B?dlhRWXA1bWF5VENlWGY5TzRNQjZGdFNpb3B3K25kUEp0MnJ6S2VLV00zUzVm?=
 =?utf-8?B?R0JoSTdBUFJuREpuWHMwdG5QcXI1cEV3L2V1dmRZRGkxK0ExN28yOUk5bU9L?=
 =?utf-8?B?TktaS2MwenQ1SGk1Z1VHOW5YRzZXTTNyb1lnWURsMUM1cnpKajFpUDhKZzQr?=
 =?utf-8?B?RG5XUnZSdHBiNGV1SzlyMmlablNKUVBnSUhqSDhNOGszWTV2R2pDS1A5bVZM?=
 =?utf-8?B?aVluQnQrVEhIdjl6aElvaWpWbUhrZ3lTVUlUa0Q1VUVzSHhaVHllRExpdGRH?=
 =?utf-8?B?ZlNZUHQycEZPVkZ2UkRndDd6dW9wL0F0ak1LRFRyaW5ucXVPNkhDUFg2WWJT?=
 =?utf-8?B?RnN6SW9pYUoxUGNtVjFhejNJM3lyR0tUMDlkV1BHV241UmhNS1dwZGhlend0?=
 =?utf-8?B?TWtsaWlnUXZDekVjdmlYOUExbXJMZGkzemtTUksyT0VZN3dFa1Z3cHVDczlp?=
 =?utf-8?B?QlVPV3VhT1M5UUdtVVhWNnRLS293WTJrTjlOTGhWWU13YlJiMmllUzVBNzFQ?=
 =?utf-8?B?VzA3eExqNVhZNy9TSHR0MHJlNWRqaVFmM3NWcE1IWi9PVGZabmtDdTN6TmhM?=
 =?utf-8?B?b3RLa21jamwvUVJEMzR4dU9jTkRaOTlkTVZUNHJ0eUZmVUtOMENlREgvSWp3?=
 =?utf-8?B?OHhDQUVNTFhUTHNhZFIxVUlLOEh4OTBqTUJpdndQNUE4Nk1aaWVqNUJyVGR4?=
 =?utf-8?B?aUdFeXRIVkJGcGpMbkZUVmVQaEYwT2VJRWJnY21zSkZ1YXFKTk1JcUxDL2ZG?=
 =?utf-8?B?N3NMNk02MWpFY003aXZGdEEzUVZObUplZkZCU1lycU1ORkdWemJremtIWEc4?=
 =?utf-8?B?cTFhQk5hQlZpdG5PRUpuL3NsOVphc0lFZ0ljZU5XYnF6REJxTVV3VzlocDcr?=
 =?utf-8?B?NUdQUnd1aVVka3pvam1YcitxQm9NVW5RSEFSYWQ0eVJJWXp5VSszVG5uUmNu?=
 =?utf-8?B?VTExUWNkU2h2S0Z0bzlvK2pmU2RpSWs2TXZKOG16RXFGcEZDLzhha3FpMDBE?=
 =?utf-8?B?blZudHVZNU8yeGZNVWl1MkYvQkc0SGlqTnpyMXhqdDVLMXhkTXYwR1psYXBT?=
 =?utf-8?B?SlV0dk9kWUVDOFluak9IMjdOcEN3cnV2QW1tdk15YUpha0sweEtlRGpMMnYw?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbab514-059d-4e3b-3a1b-08dd2b346489
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 13:50:18.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWEnTSPQpRU43cvLlMKnJaUJfKPYCYRznVfthF9y6ztHcT3oxK7BmrObeMuViBl62JwgHW/WJsFPfY7nxhqUtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9860
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 13:50:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16959

--------------Ghlx0f0Cm7REGA9HIW3sVmKk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 02.01.2025 um 10:32 schrieb Richard Purdie:
> On Thu, 2025-01-02 at 09:55 +0100, Stefan Herbrechtsmeier wrote:
>> Am 23.12.2024 um 11:03 schrieb Richard Purdie via lists.openembedded.org:
>>> On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>>>
>>>> The patch series improves the fetcher support for tightly coupled
>>>> package manager (npm, go and cargo). It adds support for embedded
>>>> dependency fetcher via a common dependency mixin. The patch series
>>>> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
>>>> fetcher for go.sum and cargo.lock files. The dependency mixin contains
>>>> two stages. The first stage locates a local specification file or
>>>> fetches an archive or git repository with a specification file. The
>>>> second stage resolves the dependency URLs from the specification file
>>>> and fetches the dependencies.
>>>>
>>>> SRC_URI = "<type>://npm-shrinkwrap.json"
>>>> SRC_URI = "<type>+http://example.com/ npm-shrinkwrap.json"
>>>> SRC_URI = "<type>+http://example.com/${BP}.tar.gz;striplevel=1;subdir=${BP}"
>>>> SRC_URI = "<type>+git://example.com/${BPN}.git;protocol=https"
>>>>
>>>> Additionally, the patch series reworks the npm fetcher to work without a
>>>> npm binary and external package repository. It adds support for a common
>>>> dependency name and version schema to integrate the dependencies into
>>>> the SBOM.

[SNIP]

> I'm trying to aid the review process by asking
> those questions, it will just take longer if I have to work this out
> myself.

Maybe we are able to discuss some design decision without code to 
simplify the review:

The dependency fetcher need to know the path of the dependency 
specification file. In case of the local fetcher the path is the uri. In 
case of the git fetcher the path depends on the subdir and destsuffix 
parameter. In case of the wget the path is unknown. This series requires 
the parameters striplevel=1 and subdir=${BP} to work. Additionally it 
doesn't support specification files inside sub directories. Therefore I 
plan to add a srcdir parameter. Should this parameter be mandatory for 
the wget fetcher or should the fetcher use the PN or S variable to 
determine a default value?

--------------Ghlx0f0Cm7REGA9HIW3sVmKk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 02.01.2025 um 10:32 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Thu, 2025-01-02 at 09:55 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Am 23.12.2024 um 11:03 schrieb Richard Purdie via lists.openembedded.org:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

The patch series improves the fetcher support for tightly coupled
package manager (npm, go and cargo). It adds support for embedded
dependency fetcher via a common dependency mixin. The patch series
reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
fetcher for go.sum and cargo.lock files. The dependency mixin contains
two stages. The first stage locates a local specification file or
fetches an archive or git repository with a specification file. The
second stage resolves the dependency URLs from the specification file
and fetches the dependencies.

SRC_URI = &quot;&lt;type&gt;://npm-shrinkwrap.json&quot;
SRC_URI = &quot;&lt;type&gt;+http://example.com/&nbsp;npm-shrinkwrap.json&quot;
SRC_URI = &quot;&lt;type&gt;+http://example.com/${BP}.tar.gz;striplevel=1;subdir=${BP}&quot;
SRC_URI = &quot;&lt;type&gt;+git://example.com/${BPN}.git;protocol=https&quot;

Additionally, the patch series reworks the npm fetcher to work without a
npm binary and external package repository. It adds support for a common
dependency name and version schema to integrate the dependencies into
the SBOM.
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>[SNIP]<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
I'm trying to aid the review process by asking
those questions, it will just take longer if I have to work this out
myself.</pre>
    </blockquote>
    <p>Maybe we are able to discuss some design decision without code to
      simplify the review:<br>
      <br>
      The dependency fetcher need to know the path of the dependency
      specification file. In case of the local fetcher the path is the
      uri. In case of the git fetcher the path depends on the subdir and
      destsuffix parameter. In case of the wget the path is unknown.
      This series requires the parameters&nbsp;striplevel=1 and subdir=${BP}
      to work. Additionally it doesn't support specification files
      inside sub directories. Therefore I plan to add a srcdir
      parameter. Should this parameter be mandatory for the wget fetcher
      or should the fetcher use the PN or S variable to determine a
      default value?</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------Ghlx0f0Cm7REGA9HIW3sVmKk--

