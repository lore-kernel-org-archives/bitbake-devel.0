Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B1C04A68
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 14:50:51 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.65])
 by mx.groups.io with SMTP id smtpd.web08.20810.1658933443075619530
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Jul 2022 07:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=DNv/uD1t;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.0.65,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je8KIHUWajzR8hq0rXEqFFhKTvpj+rURahrL94nYVVxgioanb1u+tBRhgfDoZbZdem786Mfn52DARAPClGkLZyFX9HrD7vYz3ZkYlSxLCqCt+mTabWOUFIEHnQhVp0gqZ88X1FzKcpSWJ+xRXPKwPC7ISS5ECxs8Lw43WVfJS8+gxHeatQUZx5tWO5UlvevxzfDWrtHnrjZ03Hj2rKL6TZiIASayZLp1WbzipL2NxvQnFwFjb1xEovxojUdOXqeedeq9ZE85An/43Xava5+j5Ju4TOjJg2wnapJKHv0Sxdb7vQtx+rQn6usBF6VNrBs9q4f++ku1VpJgytGfpcWEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5qM8dh60LQozjGabGhN+PwFx+zj3+5TYI/A5LJk420=;
 b=ibneVbchj58b95o2UlBb6SkryoDCJsTaeSywv/dyePCdV92/YA4nUFhjOYfNr+h2Zzabd9sTEiKSaTaMKoHd0p8byByrz+k4sRBfNgnp3ALWjcrgRooTdGiVGXWrjzjvyOrWYSHk5usjdFpc3/bbG3pLpZ6T9UKZ3fQTO+dMZnCH7pCLFkRDwVTeAWbRAPfdTaytJn6JeVdEEQaNPzrKWGrXiRfYJ0F30SN0mi+KW99jBYmtw/hthx8aNChwHyRY+A8Im00hy6otMn3QOsgmvHYARrJhR2dbcNWSI/vJz5iD+HYZmL0FuEmJjFZ9ouGryDoArPbMkJwWtCn4vdmWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5qM8dh60LQozjGabGhN+PwFx+zj3+5TYI/A5LJk420=;
 b=DNv/uD1tAw1lRHBf3dUcz1hFi9VSofNrSOz0lIRnMOpdAj+aEvxslNMcaPZpmCmFXzcxMHFjLAJbvtBajexx1BXrVDm/6h28OUA6GqkFWxIY82cSxp0Qc9T+wKgsOyeiXAvx4plx9eYUaRb7bdN3bnjTWjepzjvF7IEuMpZZLA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 14:50:39 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4%9]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 14:50:39 +0000
Message-ID: <f3f31635-e216-d11a-d30d-dbedb6ed3335@theobroma-systems.com>
Date: Wed, 27 Jul 2022 16:50:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
Content-Language: en-US
To: Patrick Williams <patrick@stwcx.xyz>,
 Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Paulo Neves <ptsneves@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
 <CANNYZj99t0x08TYJ6JmZC9uT7VderpqjPCdKRp-QNzJAS2s6Qw@mail.gmail.com>
 <YuAPBJrwSDriYmTZ@heinlein.stwcx.org.github.beta.tailscale.net>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <YuAPBJrwSDriYmTZ@heinlein.stwcx.org.github.beta.tailscale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0129.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::7) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9505a983-5253-439f-07ff-08da6fdf5efd
X-MS-TrafficTypeDiagnostic: GV1PR04MB9133:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G9W46Sgo7nthM2NTmJa3Yve/CUnA49JGqjfr+RJzlAPOGGxJbiagxZO++Kug6LDO/U67xKefYA8va83PabAGno2blc+Ujdzk0mSvTBreVTOmeG7HsxioP5Wl6AYL5tUYuyHCtYfaGrs+B5rdhVWAh1mGliSt9yzGtKOrzkbv9b708E7N6PM987RSP2lhzYRP1go2bpySVNiKWBH4K+Cixjv08TVCFso1EcGq6UDOgbbseTkUyiIINznb3FGLlJPiooafqzYRW3un0xKB2cg+GieC353cylAqOE3KtF88aiWEm6pRO1eStf1ENOmbPGTDP8wrcyms0dxLmJlem8L5Fj+QZOB83vIAzoDXUsu93fms+9nBopnBJMQL/IQpIO8lDN4QwpYs1lDQ0RtZ+RshTSuQCh7NO5I8WT3kYCBDfnPpnwEQYPdGisCq5+O6x5HtOB2yeekTRBT3DW8bhUK+3f6yvc1ktE3leY3AcHgd9vFD3+g/CILmX4967WR5lVTAULQNrQ0eXNSzZvH7DaI01r7kbgNyYnyPESbxyZVRp68X/Le2RDsnx6gw4VkBEuQoBokVo4Lbs4v9/iLM7FW5XwMAhzwv8UZmxzw0Ye1VW8ppzP1QLl4sM9CUT59ncM2fwZJs8wLlsL77EbphbKdPA0uWYbKJX/SFnUoo59rXSyrRmer4KTkRuoKvZ5J5pQm/bHsUlzHuHmTJ17O9rbGI+WH7JBhJG6VlkZHqgOltP0CrB8webA46fQW+utb2ZIjs+EZUInA4Z46SZ1iIvIQHgBdnDir+puRfuotAUQLLd5dKp9h6uruVZO2qm40y0Q0yERKN2SnVV4aZtRQm5dtxRmV2zC4CgPScPfeoY4hV6hY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(346002)(136003)(366004)(396003)(376002)(54906003)(41300700001)(31686004)(2616005)(4326008)(38100700002)(2906002)(36756003)(110136005)(86362001)(31696002)(316002)(6506007)(186003)(66556008)(966005)(66476007)(44832011)(53546011)(66946007)(8676002)(6486002)(478600001)(26005)(5660300002)(8936002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L01PSEhRU2UrMlZPU1Z4a1k4eTZJeW9JUWNuWUxEb0Ftb3BrbGJhQ2VPZHcw?=
 =?utf-8?B?azRRYldzL0dvRFE0SzY0cHZkNzdnYUp3YXJwOGZleGJoTWtLc0JqTmVjejdp?=
 =?utf-8?B?ekRYenFWb25SR052TWdWNG5BZWZIZm85V01mRTNhOUFNamorb0pFVTBRSlV5?=
 =?utf-8?B?U2ZDNkdMWVVCNklGY3VtZ0tSNTNsbUJ1VkoxS3ZlNjNSbzNLL0tmWjh4UmxZ?=
 =?utf-8?B?KzVmQXI1VGovWHRhMXFsaGdZRGQ0WEdzRU5iLzc5bFMrblFhbk9FMXRxQVdL?=
 =?utf-8?B?MnN2aTVyZ3FDc24xdWRTNVJQZVltdVQ3NXhCNzltL3AvYVhNUUg1WGlmZEhZ?=
 =?utf-8?B?aDZXdXBmc09OaXJLVHE5azhTNStTcHRvZk94bnNFSG5xdi9yT2pVeVpDdmp5?=
 =?utf-8?B?RzZ2a291RjJWYnZqYVVtUHZ5YkVJWFJCc0pPN1lWRWlCbW8yZmo4c0NUTDFT?=
 =?utf-8?B?M1FsNkZ3QXFrTlVYSlV0eTZQbmNqNHFyNXNwRlgyYkNGV1lTQVh0OTRaZXFT?=
 =?utf-8?B?elFtYUdlYU5NWGU3RzZlN2l0MUJGdUQvZUFjY2FvY1lTTFN2QUx4ZFduTytu?=
 =?utf-8?B?NnhRaWhNWnhtTk1wblAzOXo0V1cyU3RyYnkvMUc4V2JyQ2djZHI0NE91NVVT?=
 =?utf-8?B?Q3pFZlZ1V3Fwcy9LQW5HQ2dBN0tiSmJnREtSVy9raTVWNEtlYjhMdW0xeW5P?=
 =?utf-8?B?NnpCV0FOOCtuakE4c1JuODFqTHFmRXRsNWVrQW1XV1hLTVhXU3pRTTdJQ0h0?=
 =?utf-8?B?QlVROCt4T0xIcGhSOGVxR01KcDVtUm1kOXU2a0VOeXRpQjBvWis4WlQzQ0VK?=
 =?utf-8?B?S3RIamV2ekVBRlFOeC9PQ3JDN0dncDdsZEhkRFZnYjdqc3Zqa0llU2tRY0tx?=
 =?utf-8?B?TFNIVGh2V3YzWml1WTRkNzhWcUVjSzVjb01ISVJodndRRUpXUU5lWFhaeFFn?=
 =?utf-8?B?ZlE4NDNhMXZzeUtrTkdUS05RWkVKQWtiUTVEZFVpb1RlNGxwc09yQlBQcDhq?=
 =?utf-8?B?c2toUUZBcEtKbURQOE5FVE11SGt0MjdxSmNhTG1MS2VvWWxsd0ZOMmJhMFpV?=
 =?utf-8?B?aURJeDhHOEl1c2s0Mjc1SGphTDRnUUpaQVJjbFErZnNDS0RTVUt1MEIxREQ3?=
 =?utf-8?B?anVFN1R6aldxOFgxd2MxMS8yd211ZHo2UzZPL3NIaGZYVzdwZ3JZeTQ0UHh0?=
 =?utf-8?B?eVlQanhDUFNXYWc4aXFkbkpJZnk4VW5pdnBRMEZna0JONTJhaVVER2phRHVH?=
 =?utf-8?B?TkFTU0JxcklpQTR5YXVWcmg4bkVUWXpGNG5hTnZ6UEFFV0RGdlFPbTQ3M1JJ?=
 =?utf-8?B?SjVzcXVYcUtQV1BqVnVIUVVjRFpNdSttRE1MWm1JdWJPcmtyT3d6WkdWYmQw?=
 =?utf-8?B?RlY3N0xkN2lsa0lpOWxIbGxlOEsxLzNndDhldk5JRGtGYVg2cnp2a0sxMkZp?=
 =?utf-8?B?M0gwZDZCTGtUSUhKRjZUR2lwWFhMQ29IVmtHUEMza1VqY0J3MXpQWlBlbkZN?=
 =?utf-8?B?NmdMY1lvbGdJZjNOVStkYkVCVTVDMk4wVHdPZmhGMUVKVEtpNVE4Z2IyM0p0?=
 =?utf-8?B?ekVvd014SStnM0hBS2U1NnhSZ1BGWnZOTTN0czZIcEYvQmZidi95OGtGYndB?=
 =?utf-8?B?SlZSL0xxV2cwdElndnNONCtZdTlweERXQWxKKzBvZ09TYWRBS0wyai9zWnN2?=
 =?utf-8?B?bkhRN0ozdlRjdUJrdlA3alE1cW1WdmFPQnhSWEdWNU5NcmljcllkRjF3Y21H?=
 =?utf-8?B?T25iMzR1ajB0TG85eFNPSlphUkgrVnI1SW5vSUQ5aUxkSGt2WGJPQXpyTkRE?=
 =?utf-8?B?SjZOVVhYMkY2Mmp2Qy9TNkhJeVdXMTFpSE5LSVBvNHFob1N1SUxKNnF0a2Y1?=
 =?utf-8?B?aGw3S3NnMVdlYm5WbElLVUVJeGZINTE0TGN3U3JBU3A4QXMyOTczc2prSjZp?=
 =?utf-8?B?bkFaNFBpRHBuNlBWQ2FSZXBFTG9WNmZtRTNjYytBd0VXVVJUZHJZMkFVbVF2?=
 =?utf-8?B?VHZDSUVSL1d1MjQ0Q3JaOStVb3pJVWNIejBHa2Y5VWtFVmdoOUVXZFlmMENZ?=
 =?utf-8?B?MkVzbWxLdElCa0t5cEU5WVA3WGQ2U0MxUTBYZFlzOGRZOUhmVVBLT25Kc0lQ?=
 =?utf-8?B?Z0IzcE1COWhWMnBHRWNuTTNUQ0xzOFNrYXBjditBSS9TdmhoRDlOMURNTEdG?=
 =?utf-8?Q?jAXfWeeYhNbkFCq3OSv//cQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9505a983-5253-439f-07ff-08da6fdf5efd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 14:50:38.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 QkTboBqMPkzxoCloTUpYLUAtNxLzosDeRG/0iz08OvatC0H+Sc1ht+7kaTEO7lNCMyNfZpCKYUsuk+3R1i4tkwJGtNHrKmfRRzGCXjNxFR7nxYfV3EGHXsqD5qj3xslf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Jul 2022 14:50:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13858

Hi Patrick,

On 7/26/22 17:57, Patrick Williams wrote:
> On Tue, Jul 26, 2022 at 07:35:21AM +0200, Alexander Kanavin wrote:
>> On Tue, 26 Jul 2022 at 06:09, Patrick Williams <patrick@stwcx.xyz> wrote:
>>> There are some more complex examples, but one easy example is a recipe
>>> which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].  Any machine
>>> which didn't provide this file, even if it never intended to use the
>>> recipe, now fails when we picked up this change.
>>
>> This is not how machine-specific versions of the same file are
>> supposed to be listed. Just use `file://eeprom.h`, and bitbake will
>> look for it in subdirectories that include $MACHINE, and if not found
>> there, a default version will be picked (which you can make bogus, so
>> builds will fail at recipe build stage instead of parsing stage).
>>
>> Example:
>> https://git.yoctoproject.org/poky/tree/meta/recipes-graphics/xorg-xserver/xserver-xf86-config?h=master-next
> 
> I agree.  The person who originally wrote the recipe didn't know about
> the automatic addition of overrides with the FILESEXTRAPATHS.  As I
> wrote this was just one easy example.  I fixed this one to both use the
> override implicitly (as you also suggested) and put a default 'eeprom.h'
> with a `#error`[1].
> 
> A seriously more complex example we have is that we have our own u-boot
> recipes and used the same `u-boot-foo.inc` file names as are present in
> `meta/`.  It happens that the recipes in `meta/recipes-bsp/u-boot` end
> up, even though we'd never use them, using our `u-boot-foo.inc` files
> and ending up with totally bogus SRC_URIs in the parsing phase (and
> thus failing).  Essentially, whenever there is a new version of u-boot
> in `meta` we're going to end up having to make some bogus empty
> files[2].
> 

Alexander already suggested to use a slightly different recipe name (and 
then you can pick which recipe you want from a configuration file with 
PREFERRED_PROVIDER_u-boot = "" IIRC), but I'm actually surprised by the 
behavior you mention seeing.

The original u-boot recipe uses "require" with just the filename, c.f. 
https://cgit.openembedded.org/openembedded-core/tree/meta/recipes-bsp/u-boot/u-boot_2022.07.bb?h=master, 
etc... there's not a single recipes-bsp/u-boot returned by git grep in 
openembedded-core... My understanding of the require mechanism so far is 
that if you pass it a filename, it'll only look into the current 
directory (where the recipe is located) and if it has a path, it'll look 
for that path in all layers (well, BBPATH, which in the majority of 
cases should be LAYERDIR, the root of the layer). Since there is no path 
in require for the u-boot recipes in openmebedded-core, I don't 
understand what you're saying happens happens. c.f. 
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#require-directive 
for the doc on require directive.

This highlights one of the following:
  - a rogue bbappend or some weird configuration in one the layers in use,
  - a bug/corner-case in require directive,

Maybe there's something to fix or document, hence why I'm writing this 
mail, it'd be good to actually be able to reproduce this and understand 
why it happens.

Cheers,
Quentin

