Return-Path: <frieder.schrempf@kontron.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE9CD4F3C
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 07:34:10 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.104])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3460.1779089640593600729
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 00:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kontron.de header.s=selector1 header.b=HqLzZSA0;
 spf=pass (domain: kontron.de, ip: 52.101.66.104, mailfrom: frieder.schrempf@kontron.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymunjMcI7KXbMkgGp4xPfZOQc3te44EEUmM08yjJ3d2I7ZqrDJALTeD7eWIyi2uSZhYxb3m7c69KsDe0HscdiOgEkoUL7S1mI3OQId8Drs6WP8gmJLQQQCdnlHPx4y44M/lgvtj5FC1BfHh8sl8MbGjUmWOpkWOJwNEO15PeH/dbOAY+mPXWxg4zBGWZeaRYhRSmyV4/Si57X7SE8/bI+9lIkvP/wlCB+zHtJ4oeHdRpEnQizY4VCKbdPKmLLKIprhyf/qyEVsl4tPVp6ZSX+sTnL1qFGa1bMy2cEwxGGMPgiC5sd9DAgBQe/nhMgLvIwLnaz+hbjpa+Of2U+NjbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFLs+upE6u6/UtrJdnsZOS7IJb2kb1kL1VGbRQqkaDg=;
 b=MLy2CJHJOiKw4EB/OpRBl+LYYbSTKqPmpduB/Uf0BHzC5exNTcktHf6u3aLHu2WesbiirfuX6YqMQDnFFZmwra3XhQBO9wwdMTB+KVmKEJzLk9nJ6L/R6HvJFbl32zvki5clmKQpomoVqSFqIBiH7a0wylare6Hwb9JTZc7OYNoSou1MPRDOoXjyPNrps6QnwhAFl6tkVnAlVMHrA6+J5CsakTq2FtcCJVrsa5Pwm1o+NJNiLjrqoT3Vjs3kI7a/MP9aLG7sRFKHjJRbpw5C5XDz4yr4xNjTeV31tRyfbQGZyE8raGkIBmmYGcOysYAHzL/ObixwcUB+abGztEKntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFLs+upE6u6/UtrJdnsZOS7IJb2kb1kL1VGbRQqkaDg=;
 b=HqLzZSA0e8NgzP8xp5vdkhR25izf10QuQ4FDT8Er7SYK99oglgFIy9Q+FZFb8lcO4N3TqGYkf7SqvUUAVYuUoVVQB6lnA44F7Wr3eFWPwR7cRicc1fV77THQ/DQJHwpdJdWCG9mX8En7iZtoBV17QgEks1wl5ycwnh0CWc+rDhoDY0erDlTFGXjMpXiFpB5wzPo+OqPz/uKCF3PALPNrGhIu1k2LFoObPpgsPn1q0voi68LkNo3JQlSBMbZfR5NJeV2CLfpU9bVbkysv5jPbAwijf4pQG35LNBGX2GicC4k0H2oqgQ2L6BguyzQhfhlN6QAB+D7c3vf5K6wWiYOYvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by PA4PR10MB7963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:33:52 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:33:52 +0000
Message-ID: <94eea5ca-e805-4f12-8628-20d8360b72ea@kontron.de>
Date: Mon, 18 May 2026 09:33:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] contrib: hashserv: Dockerfile: Update base image
To: Paul Barker <paul@pbarker.dev>, Frieder Schrempf <frieder@fris.de>,
 bitbake-devel@lists.openembedded.org
References: <20260511153632.299677-1-frieder@fris.de>
 <20260511153632.299677-2-frieder@fris.de>
 <3ef9bff03e994480804e680034b0cc4e721e7a88.camel@pbarker.dev>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <3ef9bff03e994480804e680034b0cc4e721e7a88.camel@pbarker.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|PA4PR10MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e559c5-80a2-4f67-67c8-08deb4afcf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	/BEuaTN9CNfejzse9Gtem1Fy2J2bxpxFL2y6zZE3pzHAdqrujHGaYJ8AMnDVQUTdHV3w5K0KNPPfpjzI0jzGM9prX9ci2Ujvg6y8t1NML2LVtitsJ9WwMPvsNf02hGjMYD/Oj4/IaFCPYXKHMT6U5qp6fXX1FDBji0f5GHEOD4ai+Qz2+em/k65JiIm/pKNycOGzk/M42c3zxQmlHRp8GGgK7BPIPBO0Mnf3JptpfDz4/6ffz/lSCDzh1UBuH83JedkvuSbWjMQZlKQa2WYF9Z2WhOrBSaEJvEI3qiNwOeO8Bvdy/GfINC7m4f66mzUsprelqsUWhOJHsRijReyvjuo2FleU2xE0EnSO1wk6YKNV5sIIjs1PXqGqn1lUDP3RadnMLr09ec5LLzHVHnkVfT74lrs2RMIdQ6SE/fcYkobtPyGe8VVOtUyDeYNy/haG16xF6hoSL0Qc4uuJ8oD3VBx3puUSKmY1DLzp6DQ68LqCQxomnGRPcHOk3WCKRvPWQAzDOozw5vIg5t1dGnrKfhV2u90jJ+FE498wUD0tq+Bb66u9v105R5WYaIk9ZbnBrWR5Wq3JoAAf1VgKrLqD1fcJSdYp6qgkwCRp6wFNr53L7uo5z/dXsS/YFNAYvdgnLOAKM40Qzeqp+OycW28Eqg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDNOOENLdnEvdlJ1Tlp6NS9kSktsL1hiNCtaSlBrRnREMVlPZHA2QWZoNkdq?=
 =?utf-8?B?d1I5S3VaTERqVUUvdDR1RW5XemIzL0w1OExEQVpDZEdTZ0UvWGQzN1VLOFVa?=
 =?utf-8?B?RWtmWDFkUnE3djUxVjVhdnIxUzEwUGNYb2VUSG5qTzd1cU4yOHg0NHFDWjlp?=
 =?utf-8?B?M2kvRXJqY0UySkptYUlUZ1c1S2FCcFlDS2o3MGNPYk1PanlxblNKWG5lMGpj?=
 =?utf-8?B?VTZQWDNXS3N3cy95WkU0NkJDOTVaOEU2MDJOQ01VRTZYMzR3dkFBM0tIZHg5?=
 =?utf-8?B?WnpscnZHQzhGUmRnaEQvZHpJZyt3UDIxbitpNSttNXIvVmV4M3ZKZ2F6K0Va?=
 =?utf-8?B?d3RVSGR4SDVmS2hkNEZ6WlpubVBLVGtjZWp2MmgxZ0dsNUl5L3ErcWNDOUk5?=
 =?utf-8?B?b0kvVmJtNTRrdjAwa2NQNmJtN0gxL0ZPSnU4Z2lTSGRKaUhUZWpCUjNjejAv?=
 =?utf-8?B?YjJnQ1kwT1FoK0gzZDIvKzEvVVFTOUlWazIxb29ZcUg0Y3pKU01NV1NqWCt1?=
 =?utf-8?B?dnpRQ3VHK2VWZWZFZ3huVk4yNEhYS0NMRWtBVy9ZblJjR0k5OFdqUVQrWC8v?=
 =?utf-8?B?R3pYOTY2ekRZellIWTNObUxqTTluNVdxTkpsQ1M3OW5RWFJpSDhRUkdQUi8x?=
 =?utf-8?B?TVZzUC9TQW1sMmFKM1hzRFlDdmhyNzhNZHkwYVhtNXl5SzdNM3NkQzYzM1dr?=
 =?utf-8?B?dHhyMHZIK0VhVkJlS2xJbG9la2kyTGYvN21UVkpab2xEZXVMUGdoOXZ4VUd5?=
 =?utf-8?B?VEdJRUk3S1kxUSthUzFXZWQwUVlvR2c2QTVvYkxsRzRrSUgrL3ZZdkpFNC96?=
 =?utf-8?B?TUk4a3hWYzdKMWMxV3hJblpnczFqQmtrR1BxZU9UQnkxSkw3b28yL09UNi9y?=
 =?utf-8?B?M01qR3d0bmhCT21TM0lxQWxVQWxHMmRlVGQ3MEt6Y2RNVDJzTWM3ekRzNmw2?=
 =?utf-8?B?MlFtbXhUSmRiQ2dWbloyU3pJQXRrUGk2ZVRxQTQ5YXBMSXpvMHNLZUd5WFN5?=
 =?utf-8?B?WjQ3Y1kxdWdhamZ2TkFOMFNqaTd6dDR5Ymp0TGZEcTY0VFJCVTdNaFZjcE1K?=
 =?utf-8?B?d2ZRemtYeE1PVTZjbk82a0taeXVzQ0szNnpaRVhpQmp4cmFOUzBGWFMxa0pi?=
 =?utf-8?B?QjhCZWRCYks1c3hpUW5OZzByNE5Ick5jNHhRSzkwK25YTmh3bitOMVplV3Zv?=
 =?utf-8?B?ZmV2WWhQV0FHTGdVMGJlNm01Qk1nQkFiZjVscWFXaTY0UHkxTUNJODdYd2lG?=
 =?utf-8?B?WGRFL3FBZFVWNmVJT2VCeVlQZ0owN2hVeHpCZkFRa3F0azJQRTQrdlE1Y0Js?=
 =?utf-8?B?bHhyamZTaUQ2MlpSYkZpZXNBeU04L2ROQzB3RlZWa3dSbW5FbGhCZm94Vldo?=
 =?utf-8?B?N3QyRm5nT3pha3NGNEkrZGZIdjlDMzIyQXQrYytST24zN1kwSEQ0cm1HTTRa?=
 =?utf-8?B?MVcyNkJVL2hoaDFPaStEMlBXRktadmFYMnJWc2E5WmdwTGlveEpCanJjbnpz?=
 =?utf-8?B?ZzJVazVQMGNIaEtsYTNZay9KajJyZW1ReXVDbVZ5UWgxZW4zNzF0YkpnM3VN?=
 =?utf-8?B?VE9qS2ljdUtSUHFaeGp6d3h3ak1tOU55UE12Nkk1V0ovVXZla0N2eU9SdUZh?=
 =?utf-8?B?SndlVU1GQzYvZnhaWnZSOE1CWVRyN05mRDYxdHlGa1V2ZW1ZY2VRb3NjQzNq?=
 =?utf-8?B?eDlLUXZOam16QmJXWGp0cHBmVjYzZzhrNDFQZXJDYysxNFY4SHZtVWU2bHNm?=
 =?utf-8?B?bUNaK3R5RTVOM0dpanJSWUJlNHlqRzVtTCtGWnNINjc5bUZwT2VzcVdaVTg5?=
 =?utf-8?B?R0tONnAxTlAzVzVCOE5sUjB3bXBETjhqYXVJeldCTVFnT3AwemRFVGdPZThv?=
 =?utf-8?B?T2xlM2NneEl0WVQ1QVVYbTlsYlVJVDh5SmlQbWJFQkpJTDdZZnlHUkVueTNi?=
 =?utf-8?B?ODNyZ1NMTC9UWm5DTGRyVFYzanBOdnFzc3RlcmpHNUFwbzNBMSsvSTh0NzdO?=
 =?utf-8?B?eFZ3b3B0WVZ6cFY0MWhnUlh0NWtMQ3FFTkVMamhoQkNHR1NVNjdCei94SlZn?=
 =?utf-8?B?dXFXUUo3VEdUYkFMM0I1aUV1NHM5QjJUSmhtRDdtaVdyNlY4OGd4bWdpbkt6?=
 =?utf-8?B?dVJIZ3dlZzdQM0FIVkdJQTJ6bGxSL2pZUU9tZmtaRmk1YXZ2MFJkd2h2N2ta?=
 =?utf-8?B?a1lmYWJ3NDZwaXhkU214SEdqVFpxWXZ0ZVBKSittWUM5dnQxMEcyR0k2SkZG?=
 =?utf-8?B?Z2FuUFBiVzMzZnRsejloRTZFelorWkRVVmNGYWtLSm9LSHdrWVFicCs1ME1E?=
 =?utf-8?B?bDFRQzJNZldtdjlXd2dkUU5UUlJiVFd6WFlwZWI2UHVIS3ZMSHBkY3hxY0wy?=
 =?utf-8?Q?BeBgiuXdYeXpiESY=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e559c5-80a2-4f67-67c8-08deb4afcf04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:33:51.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vUYYBtQxS6HNsQ/AFHv0S3OQllUfcNmWrl+BH7nMpVZp6bq0oQuxEOR4o5mKgnIWCCvesARvxew5W1o51Tmpwjmr3V13CV+v6HgYv0aDnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7963
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 07:34:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19532

On 14.05.26 12:18, Paul Barker wrote:
> On Mon, 2026-05-11 at 17:36 +0200, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Alpine 3.13 is out-of-date and doesn't provide a Python version that
>> is comaptible with the current version of bitbake master. Fix this
>> by upgrading the alpine base image and installing the missing
>> websockets module.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  contrib/hashserv/Dockerfile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
>> index fe7e091ec..5c8b8dd11 100644
>> --- a/contrib/hashserv/Dockerfile
>> +++ b/contrib/hashserv/Dockerfile
>> @@ -9,9 +9,9 @@
>>  #   docker build -f contrib/hashserv/Dockerfile .
>>  #
>>  
>> -FROM alpine:3.13.1
>> +FROM alpine:3.23
>>  
>> -RUN apk add --no-cache python3 libgcc
>> +RUN apk add --no-cache python3 py3-websockets libgcc
>>  
>>  COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
>>  COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
> 
> Thanks for sending this! Alpine 3.13 was end-of-life 3.5 years
> ago [1]...
> 
> We also need to update the Dockerfile for prserv. I wonder if we should
> just use alpine:latest in both of them.
> 
> [1]: https://endoflife.date/alpine-linux
Yes, alpine:latest would also work for me. The downside would be that
image builds could break silently if compatibility issues between
bitbake and the latest alpine release occur.

The more stable solution would be to pin the alpine version and have CI
builds and tests for the image.

Anyway, for me this was just a drive-by fix while I was building a
hashserv image from the official Dockerfile and I don't have any strong
opinions here.

