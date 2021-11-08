Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22992C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 08:01:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web09.42191.1636358494089732151
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 00:01:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=BrfvRHwb;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.52,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM8MLjgAdYgaghgmvetkKi2wOQC5KnNsTe8sZW+J1iRsbtXC8sljCv5hdjhVyt4LzObS9EZbI/NGH2rE1BVGxCp6zmlXAqIb68rFiDrqJmZ3oMSM5VQwsGC3JUQQLWEjhG/D0QzUaacpSj43rFksMzZOn1yijd7EExn6hEhENkGre1yCqGlwjG3aWGYHtJ8a8qEyHVJZyKcAKTco3IwAXOwl4HdQYxemhhIWwASprEcIlF1cmX3H1h09CEKZlEiYwVm7MqMirNvd22mMNK3U5ng64Dado0Lh4kRHGIFKu1VXtHqmAL16hJNIOExCowVHT2knCwqGB4CYAsspKbo3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i92aXDu8+o9L06p3qduSQPTdoKDRl7YuAzDBwwuWO6c=;
 b=IU/Of75LDOOvTM+M0TDbuIRGHtGsbRgPqPwNo/Zu5KlooH8XhTEAP2GdieIEBAFDmo8FmIvxcZHRJBSQFkXedbdmNhMnFdbmfkoCnrgadaoIclDmfrq6i7yGdzEbzJ/hKuoCunMX+11VOFejRrvWeH7bh6wdXAlkzwdG/KuHUApM5FJaMJk7196N+lZvCDGu9WZG0M7ihAsUIE94UCFsRwjXrGiwOVt0TDbawcDNu/SwO9kEwc+E1tXhldftcQ4680lW4VSRPuU3TSw+jih/VVSMSck/DIu/seHdrT119dq+mu/LDaG37yDJOnqsQJ0Kk0I+z4+uG0IcKXcmRTpiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i92aXDu8+o9L06p3qduSQPTdoKDRl7YuAzDBwwuWO6c=;
 b=BrfvRHwb6+cVsXTgrQAOE0tvV8ynldEzzFqzfnubr6sO7V6wOu6B4MLNUVZlbFKwx7hq5DHqLGb4LyTVI97J2CFDjSgNSUIyDO+AvBZYebGRYrGo9bpUUPQVh/PHLthaL5CJJ86TVpG7fMtZcq9ERKgKw5zANWJjyat5ZXuDWTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR2PR08MB4889.eurprd08.prod.outlook.com (2603:10a6:101:1d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 08:01:30 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 08:01:30 +0000
Message-ID: <b9029131-1a0e-99e5-01fb-183930a36c87@weidmueller.com>
Date: Mon, 8 Nov 2021 09:01:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Content-Language: en-US
To: Mike Crowe <mac@mcrowe.com>, Alexander Kanavin <alex.kanavin@gmail.com>,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
 Caner Altinbasak <cal@brightsign.biz>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <CANNYZj_0U_Yk4TPVxS4hQ5zdeSvZ1LZkFQ+8fv8-x9ieZ4AH7g@mail.gmail.com>
 <YYa0NeCHOjBXYsxA@mcrowe.com>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <YYa0NeCHOjBXYsxA@mcrowe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::32) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from [192.168.178.36] (94.134.94.8) by
 AM6P194CA0019.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 08:01:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c730ac1-bb58-4e9e-4881-08d9a28df94a
X-MS-TrafficTypeDiagnostic: PR2PR08MB4889:
X-Microsoft-Antispam-PRVS: 
	<PR2PR08MB48895E37B24A5C104448B20CD7919@PR2PR08MB4889.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KfL3ccE1D0wwEYvrNz4guZayvHe9ksaD0Hxmp1VAXMIJ3EXehZoMY5TdWyj5sRkZTTIA4oGghqzJWIdPmXPNIY8ok7P7yCFpzqRfIJSLtNdNCgVDkEB44vSal8xM7zPG+XD9GeeeJrl87pOS3FLZuAlEeAjELQ3dXCQt8iVEOWq70awIIyA+yyYuap4irWq3ho21wjtbsByj/XARkNz0Pe8tJYFd6LLAbJjlLsn/93mPuhbYO+dejMvBWPL6HXytl/hJRb5GPD4usI9Ucl+VjF31E05MhneTsiS/4Umhc9Ru0BY6SRgJYchNF/2LVEfZh8TYWvkLnPv5cYxQw6krK8y0WoBfc4U2qfDk9GWLhgfAXjv8VzDoOr3YmwQYoYobaaxWefe0U402TeMKL/j54nMMBlwyQCR75cDRCGUGAH2ihYS+pYZHLvx+RgL42lREOaNaCc5DNVRyEb9edWaEaDJAci9ZD5Dgn+JvnLUJZe/N4H8oUoD3REI5aYyg3cLyShAz/hwW9OjeNRa4j8TNS5Wh/UiNYuSh8E3CNneOu67gJozKsWZ6TJyAtUv4uvVdR9vooGh3AL0nSB00lqAD+v+7QfC7eoxh3aJvS2GRy5xj0tmlgmvmttmyCVKKCUP2dCgLS+Puh6v6ty5527GNm9ju0YIxx8l2XyRZ9cAiVBl6SgXw2AUc5piduBiMSC8A7ySuhwq5JhnHAOPzVUN1iiyiCyA0bCRY8IY42PCxge91fVjm3j7KNezLUJ0A9w3/YnVCwmOrHQoytwHNKeGLXuSz+i3hihz8/Ds0jq38AiEz9T+x0HRQtIH+WDyCwGRzl7xU9shh/uboUn4aRvFTlTC30usubqv0tjSVQUPIyd8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(66476007)(86362001)(316002)(8676002)(8936002)(966005)(2616005)(508600001)(52116002)(83380400001)(956004)(110136005)(186003)(16576012)(38100700002)(31686004)(26005)(2906002)(38350700002)(31696002)(6486002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDhDeGYyRWJ4VnVUQXBJdFJUVVBSa2hIandFSTFvUHlub0lsNjFhTUVrWXFC?=
 =?utf-8?B?Q0p1cXNUMUVuYWNoaFdnakRBZVdBeUI5NjRTTER4TzV4UW1CRGpQYk5TZUNT?=
 =?utf-8?B?cFZNcDk5eTRpZlRvQnB3ZElEWDdRRzhNMGJuMVlYRG5IQlppZWlPWk5IanBP?=
 =?utf-8?B?SVY1VjBtNDJFemJqeTdFU3I2Z1h2bURtb2FZdU1BOExHajQ4ZithUHczZzM4?=
 =?utf-8?B?TmRTMjdhUjJKT29uV1RQQ2p4c29VN3M4MklsL3d1SHQrL1hyTjhiQ2QzZWF2?=
 =?utf-8?B?ajlXZS9ydDg5ckpLUUV5NVRCZ3ppUkp0M2pNcExzdlM4MHlGbllnVXNwWUNz?=
 =?utf-8?B?N003QjdXSlc0YlloeWVhdmV2SzZTYWNQaXprQisyTVp2OFpPRjhCdTNSdHhG?=
 =?utf-8?B?N1p5VGpGRURxVTlIc3JDUWY4WlpvQ0s3bTRxY09jdy9jTFprajJ6N3AzYm5Z?=
 =?utf-8?B?MENsTS85N2kvNjlkMENkcHRJNDhyT05zVmNKVkpCM0krNmFMME1SdHN3a3la?=
 =?utf-8?B?dW9ZMGxWUjNra0RHd3dtUllWRWJiS2lQSmtWVVk2MnF1aTg4SzZhMVJ3WWlO?=
 =?utf-8?B?L0J6SlRoVnI2V0JVWkNFRG5ZVlUxeGpXamdENkRJaTlDcllYUWJ5R3M0ay9V?=
 =?utf-8?B?WXlYOWU3TUNZRUpYcWNYWVBTM09IOGhpb0hSaXBRNXZUN2dvUXczOWl0Tis3?=
 =?utf-8?B?eFBxY3Q3cEhVKzNkVUhEZWlyN1V4N0xvQUgyMjQ1MjdLbzh0aldWSHBBVExx?=
 =?utf-8?B?bmlBd1lyUXlLa3F0UzlaRXY0Uit2bUZURkkvaFo1SGliYXNjTEY2S1grRnlG?=
 =?utf-8?B?L0dadGZOUWhNOTU4K1lVMUhmMEVIek1Fd29YQUxUbHo4TUZIT05BV3daa2tr?=
 =?utf-8?B?cExOVEVBdnE1R1lDcEtFOEZmNm81V0ZmZlpMblFTdkJzZi9sR2dpZEFBYkZ3?=
 =?utf-8?B?MXZuZnFrbXBxSWpGMyt4K0tYM2xOMnpBK0Q5b2grWElsOTI0aGtBUVNGQTJW?=
 =?utf-8?B?SmRpNmFtR2FvbDNGTElEQk15NjFTb29zd0xZTExMY1ErZG41YTNqNXVHbEZC?=
 =?utf-8?B?M0lrM0UvY2tRS1gvcTNEQ1BWcDE5OCt5Z29KM3JpeFFkSHY4KzNkM2d1YzlB?=
 =?utf-8?B?TkdTNXdKVXJrbmZzSGtzS1d4TFFuNkh5eTd0QzhzeFJBMEtnN3FZRXFZQjJ2?=
 =?utf-8?B?VXI5Y1Z6SEY2am1WcVo1UVNrS0xFejRtWGVRaW5TQnBJb2FpVHl4SnZIbDBR?=
 =?utf-8?B?MXpmQ2d0cnI0ODVtVzFJbHRsMkRhdXQrVXU4L0ZlUTVrTWtoa2J4VXZ0dGR3?=
 =?utf-8?B?cjhROGpjb2Nua3ZyU3U1Y3JGS2NlNS9DeXNubm5uaGlwTWpNM1o1M1RKYWhM?=
 =?utf-8?B?YTZWRVA5NUhIY2V2RW5Td2drNEVGV2hCd09QUmROWmdSNmk2Uk5zQkJQWTky?=
 =?utf-8?B?aEtqa3ZMd2JlNW56dFo5ak9jaWpiMkhXTjd4NVRGNnZsQUM4VnFJNElRMGxs?=
 =?utf-8?B?Zjc0VXA1SnVTOFdZcE85cWZ5MDVGWVF3TkxSK0c3Q05MOFF6K1ZLc0R3SGtt?=
 =?utf-8?B?elowbU1kSllTMTdQMXBaSEF2YkFzYWRzSXc1NjNDVC9TcDFQQnJ1bjZ2U0FD?=
 =?utf-8?B?Tk9sMHkySjFSS1VIRTFIR1RFajN4Vk1QZTRaWWJIUjFCSnJsT2xOQlZsazk3?=
 =?utf-8?B?NjNQQ1p2TlZnenR6Qy8zRHNNdU5EanVTMDFZOFhtZzFyOHVUeStwamRORHFI?=
 =?utf-8?B?SjVwcDZqcVZxVmZPd1MxVit1Y3I1d1BYQ2JmejZsbGR2elB3TStrYStpSWtH?=
 =?utf-8?B?aE1pMFRqVWlwdEh5VHVxaS9lV00yMlhITHFhb0k1d2d6QVpYWUNTTy9KMFJj?=
 =?utf-8?B?eVdqSnQwYjBCaGlqaExrZVcrTllVWmFvNUdkbEl1ZkRTYjVSdGtRQ0cvc3hZ?=
 =?utf-8?B?aE5ocndKaElUazdpRFRzZzVzMlMzN3BqSE9ndUVnM09WR2Fzd0lqN3lPeGxy?=
 =?utf-8?B?b1d5RFJ5elBxK0NEUTc5UXJHZkYwT3ZGeEJoWWg2bGZtREFhZHBSOWFkRW91?=
 =?utf-8?B?SlBzOWtOYStIVEZjNFJFeXZVOWVTelQ5dTFnNTZZWmVQTGVHclBkTzAzZ29L?=
 =?utf-8?B?ZGlyTTg4NVBsVVVoRmVXNlorU2NYZkY2NHZITFlEYTQvTEFTS0dRRHR5Mklo?=
 =?utf-8?Q?P/7sUrNsr8/ma3o9PcmE7RA=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6c730ac1-bb58-4e9e-4881-08d9a28df94a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 08:01:30.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 K5bcqhs+CIc1kkixBPjTrV9oTiZNSttx+wimV4PROMoIU2bso2UamCyRk05CtojZJK/S4xA3d4r98YwmhHdE/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4889
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 08:01:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12931

Am 06.11.2021 um 17:58 schrieb Mike Crowe:
> On Thursday 04 November 2021 at 14:09:42 +0100, Alexander Kanavin wrote:
>> To the best of my knowledge, no other companies at the moment are using
>> Yocto to integrate npm-based items into a product.
> 
> We make light use of npm in the production of the rootfs for our products.
> The upgrade to Dunfell was a bit painful, and the slowness is annoying too,
> but I think that we've ended up with things being better in the end because
> we can now be sure that all the sources are captured correctly.

We have a similar problem.

> We did run into a few bugs and some of our fixes for those have landed. The
> npm fetcher seems to be fighting with the usual way that Bitbake expects
> fetchers to work that I don't really understand enough (from either side)
> to know how to fix. (e.g.
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14383 which doesn't
> directly affect us, but the underlying cause meant that our usual method
> for capture sources needed some extra workarounds.)

The npmsw fetcher is the only one that fetch multiple sources from one 
foreign configuration file. Therefore it parse the configuration file 
and translate it into multiple fetch commands.

I think this is a wrong approach and makes more problems as it solve. I 
suggest to move the logic to the recipetool and direct use the npm 
fetcher per npm package (dependency). Even the npm fetcher could be 
avoid if we doesn't require an autorev feature for an npm package.

This solution has the advantage that you could manipulate the 
dependencies inside a recipe and you could replace a npm package with an 
other oe package (DEPENDS / RDEPENDS).

The disadvantage is a big recipe instead of a big foreign configuration 
file and it is impossible to use a foreign configuration file direct 
from a git repository. But I think this use case doesn't match with the 
oe requirements and we should improve the recipe generation so that this 
could be done automatically.

Regards
   Stefan

