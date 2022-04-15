Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2377C71127
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.65])
 by mx.groups.io with SMTP id smtpd.web11.6070.1650022323743107627
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 04:32:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=G34hmR9O;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.65,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdZhK9OETvP3wPSF1nMi1PQ5v8CLZx0zmlla93CvLbISM9U3RPlcBKlj2GoXydJFKa5ULCReSLqXUZ4wT/o9F8/GEmYiKlGEVp+Y1ZhcIXYYK1TeRSJYa0mI4PgPb9Pe+zSmZtjimebudJTGK6CEP/FUFqopdzF0ZLtsmmuU6ZjrAE5bSIWa2OQBgoOvCnDMm/rJJQqAsEiiqjA9EwsaLhDi4JwCyyA5/paLj7ydTN4ZiLBZPzBnBc9k4bJgTYvDOqBIFbQIOU+gMCs1u1Cq7VWpjea/q5nZcQVkGZImtCGq2lWtQdFoOdhgsdqZyWh4ciydYgj3MYq/YY749v1FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFOPXrrscem1HBXtjKNRKLCz03obXpBcIznUFor/xuE=;
 b=C3x9qnb2mAV5plR6cdrbdKgg5Vdnm7ENIptmAKYWPigLs63Wc+aHwHMmTWBWzxC4Q0/zkg+kFX8kC5bIptaDhdQMIP/Bp7Qy9/jR7j8KdeFtKbKuupohnA7pm+ldhHD/uFqV/6jLl4CX9uRQg6/5pLQ8Ynu7lRMFKFPQh2tzZs9qtMqEAFeJW7yd7LeOwawVcySFPYktp8Thn4OENdTYMg0rcjQh5aTAPEFGrzEsWg+oT9Kp/tb814MLGhNk+Os8OW7eYIA0nddb9vap4lVGYoIuPbT3fvZr5V3hoLBGyEOa48nqpA8AaCFVA3BmsRhdgYstbKlleuzDBnBpLIUCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFOPXrrscem1HBXtjKNRKLCz03obXpBcIznUFor/xuE=;
 b=G34hmR9ON+0LKpB/xXUECUnhUAxGxZmoS/3vWQni0NeFgveHhQGu2yVPZoItqIhpWbMdQO7uBDg5JUtHlTmhccYpWWZ8QLxT8PMp+yU6uSX2X95nPT6swxEpdRyPwG33D/bgEzl4ZvD2OnYNLhGXZnZhLjdPwp7whamBAdQENek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM0PR0402MB3683.eurprd04.prod.outlook.com (2603:10a6:208:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 11:31:54 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::bd4b:4dac:7747:3093]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::bd4b:4dac:7747:3093%8]) with mapi id 15.20.5144.027; Fri, 15 Apr 2022
 11:31:54 +0000
Message-ID: <75e09aed-e62e-f596-32ea-c2ac76d9b186@theobroma-systems.com>
Date: Fri, 15 Apr 2022 13:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bitbake-devel] Branch switch doesn't work on openembedded.org
Content-Language: en-US
To: michael.opdenacker@bootlin.com,
 Marius Kriegerowski <marius.kriegerowski@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <D247F1F9-1C2C-4B53-828A-ABB4D29800DF@gmail.com>
 <91312f6a-5758-3758-0896-e7dcd438cd90@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <91312f6a-5758-3758-0896-e7dcd438cd90@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::17) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2881ea67-5200-488e-061f-08da1ed38a8a
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3683:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR0402MB3683A750BE059D689A888FC9C2EE9@AM0PR0402MB3683.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IfSoEkm/Gemeh6NLPlgYldzPH9QE1ym0QNBB+wDNqoEusd8K5FW/Pci/paqEMBy511Ca9MQ7DCS6yXSSmQxcThKNN0jyfEfd1BforICV7dPgXcik9+8GUYjtBUgp0YLcQcf3aQI9teHSWUxc+A2/eLtqUC+oJsfh12oiTFrTlSDwydw6It7lDLvI8BBS2+ECTDLzrfPXJPLMvGEv9nlWA+djhxXVMjL/zmCztjwKu0NUjQnTPYu7I5thpG5zA9cMV0EDIGa1cblH+sgc3ckaX8mwIiMYoxjA3nJBM9egci/IvaaQdvdGskmzG/MpQD+AF3E3+lNj9pVE5qDBiPwZfkztRKZPHrlfYXIy+LV/57sPk23zCDsdLfFXnJXP4DQreE8KwcRVTUGfeNuLtPkQtXpchJDihZNOMc7c2AakCxlqJlaZ7G+VobwuPjGx/rueT+1PxwG0B4nv5L68RE2QPK1ImxTRgQpHtPw/jRU5NuBWe/fumoT19PbYR8QG7ciV/ws6VnmWiRQBKf44DQxAae3HCIeTtELF0KoN9Y7WZdsgsEfxKVLP099CoKpeOdZSIeRi6kA3JFNNbfC40WYaHPbHZoXGKwUnKi2GxxsxswIDltr35fYlwnQfknLTt3ioEj9tVNFbIJWncAWbuuOxoNQS+1Nv+dUiirBYwjeQxOj3QAhmOR1na2BSdtwueUNpEgejUP7fJOMR8WdMdvPaXnfs2pLcBdQGBZXa2nH5BbWbzTnteHclvquS7CNuxIhSE5LgbgIm05ZMA5XSoXESnxL4OsaXZP0/bgYOBzVrJXNc+70w6fnM5CD90uc2V+v8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6512007)(5660300002)(26005)(36756003)(8676002)(316002)(6506007)(66476007)(66556008)(66946007)(2616005)(8936002)(44832011)(508600001)(31696002)(110136005)(4744005)(966005)(6486002)(31686004)(186003)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEhNK09DNGNQRkw3VXYwaWszR0paejZLLzUvTDE1dG54UjlneVM5VDN4QjVp?=
 =?utf-8?B?U3lMVStkelVzQkNjQW1MK3gydXhpcmRqYnNtS2VJU2x1bnNMNmNldGh3TEVx?=
 =?utf-8?B?ZGQ3T2xOaTVhTHQyTUZGcmVqUVJZSDRCSEdyUXFRdWg1VFZQUzBJNXUvczBV?=
 =?utf-8?B?R1hPU21KUHVwS1RjMjNsdWgzbDhRdlVYOG5manJma1VCRURia21KZzROOGlL?=
 =?utf-8?B?UFBxVkhpbG9oQm05QTI5SnNrUkd4K2xTM0tldHR5bnAyWHVUWklhRXVRbGpu?=
 =?utf-8?B?cGpPei9JTStUUDd2YnlOR2g4UHNYQkk4Y045MVVrV0NEa3BWNDJ5N2dXb1hi?=
 =?utf-8?B?K1dkd09RaXFZN1R3Wm9FNk5mMXhKQ2RTVlBDcE4wNHg0RTVxZkNwdFpzUDk4?=
 =?utf-8?B?Q1llZzZnNG9FMHNadUYwU2RGeEpWUExUc1UrK1ROUWQrVWZYT2dDMThOZmhU?=
 =?utf-8?B?cGVDMmE5RUN0d2Q4OFZmQ2JlbDB2cFcyanIrRHYwMmhHOGJHeE90aDJyU010?=
 =?utf-8?B?UlhXTUozMXMwQ04rMGZEdTFDbjlJK29CUGRoR28xdUJwRkloL0pvZFpHOTlu?=
 =?utf-8?B?Wlk0V25ZMDZkNXUvbVVackRaQUdpSUNFNGt3Nm0zTWNTQ2VHbVB5OTFYMjNj?=
 =?utf-8?B?Y1g4ZTY4WWhlMEFBeG1qZ2hIa2I0MnhYNmI4VmhFMkcrSnRVTFJQZEV3aWdY?=
 =?utf-8?B?QTVRdmJGY2VHbXVIMDZZMmJ2MEJZVjY2ejVlZ2Q2RzVER29wQnhSQ3FjSk1r?=
 =?utf-8?B?QWdhbjRQTU82b09qSlYwdkRES1FzRGZ1bklWc3FlT2plN1dob20rOThYS2w1?=
 =?utf-8?B?SXJpd2dGOGxxbEFDeXdaWkxGZ3krZzh6NVFVQkJxeTVuRUoyNFFLM053ckdk?=
 =?utf-8?B?TUlYNlR6YW1uMEZWR0l4TEV5aE1Nd1hqSG1GVy9DRW5FU2NkM1QrM3k3eDh5?=
 =?utf-8?B?Q0Z4MEhOd3h4SE1JejlnYkErL1hSU0gvSjg0aWQxdGFCWmdrK1NGdVQ4cjZF?=
 =?utf-8?B?N25aYTluRGVaRitudUpnK2Jja0dnbi8wbFdhRmhSazVMSmliblAyUXk3eDBp?=
 =?utf-8?B?RzFPd3BXaGZnaFB0Skw3UmQyUWZ0MUZGQmhtTDJQcFppUW9WQkpvVTk2aFhv?=
 =?utf-8?B?SlBCUk8xWHNpeWVyMnF6bjkwa3BiZ2hIcFI5OFRwMjg5V0F6L0RUOXo0VEVq?=
 =?utf-8?B?MDlyTm1RQ0lJSzY3NkUzT3JhaVNERDg1engvbnpYVUFZV1Q4MkcrbHBWTERW?=
 =?utf-8?B?R3M1aGRrNUxpWjRjTGJxYlJZMXozb2dtdXdhMWlKNnZFeDFPVU5CV3BBb3Bj?=
 =?utf-8?B?eXRqaGpMWlhCSkpGSWVlS09iUDZXS3pPM0pBTS81elo4V3pNRTBDcDRiSGZv?=
 =?utf-8?B?NW1qUkdUc3lkWmJTSUdhU3h5bFpkWTF6VkZmY0VnNytqb2JjYVdtcWZERnd2?=
 =?utf-8?B?V0FlVCtJMkh3SHkwOVZWcHByVGYyQ1F5YWgrU2xYSnhibE1Tak9IME9sdmdT?=
 =?utf-8?B?VVd4L0tsQ3Z3UU1UVk1ScEVBRUNQdXBMbnB2QTFpVHpoSGMrck9CK281bHc3?=
 =?utf-8?B?bmZZWis4R1VGREQwK25CTjg2aUNwSU4wTWpjUUtUSFIrVFRaOGhWS3J0N1ZR?=
 =?utf-8?B?Y2xHWHY5akpwUEgxVFdkbVFvVE5XVlRoYm9oNnpRbDgvaThsdm45bkhPRWFS?=
 =?utf-8?B?WUlZV2duQTJwRzQ1ZFNBMDVnendvSE5ObnB5Z2FiaFlxWm52YlFyZ3BnRFkr?=
 =?utf-8?B?cGo5dnhBWlBJa0krcFNxV2JuaFVQeWp4cTdQeTNnbU1uYmxtSzVpUXRDVjZu?=
 =?utf-8?B?UXhuVjlvYXNEcFFUZjFUVUkwZ3BjYkUzTk9OcStMcTZXS01YODRmYmR0YWpq?=
 =?utf-8?B?S0Njb2loRHlXU1RwTzMwWUJuTDcxWklzNFdZeThTUlRxSWVRdlNJY1pFejVq?=
 =?utf-8?B?SVFvVzl6MWNmUmpuNVJUM1JEcG5YRjgzSklSb0E0RHJXd2xSbUd4bEtKTEJv?=
 =?utf-8?B?UmJqREsweS9SMGVUMGxsL2pmYkhtbHFnZVZiby9qanRrclNjbmxkQldEaEZ4?=
 =?utf-8?B?VnJnNWx1S0dSdExvOFVVQVcwbVh2Ulh4MVI0UU5TNWpaeGRkMXN0R1FBUHdQ?=
 =?utf-8?B?RzJhRGlQVUpmS2E0bEFSdFpvVEZ6b2cyQXg5OU1SbDI2RHdYcWNGbWM2OHN0?=
 =?utf-8?B?Q0VqTTlLK0xMOXZvUHUycEsyUFd6MGR4RjRPc1JQVnNjemVVVWdrdEh3WGdG?=
 =?utf-8?B?NXJOUFdNNGtLZm9GbS9xNTQzZnpPT1Btc2Z3aGtqRVpGekVJT1ZGdVlmNlpZ?=
 =?utf-8?B?ck5iQTRxbFZ2R2t4U2RsbUkrVThHTEhmb0d6M0J4ckpVb2VIU3lnQUVHNXI2?=
 =?utf-8?Q?lMLmcxdYmmC9hDEtAfT6jE2jB7WiX7dc4OWH5?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2881ea67-5200-488e-061f-08da1ed38a8a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 11:31:54.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 jIzD64nP0vYAnf6MohSgXSnK7KrlMAbQ62rg4Mha3+pg4WmLHAYWnawxxtTD8C521I/2pAebj/1LxlFzm/DRpHmdVRefX9EP+FdQwMzRpwaZasOpWB5TRcg0S9VSJi1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3683
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13631

Hi Marius,

http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-devtools/python/python3-pybind11_2.6.2.bb?id=82b80e6ab10a0cf678428ff11832dc9b90f9d5a6&h=master

is actually going to show you the state of the file at the given commit 
hash passed in the id argument and the branch (h argument) will be ignored.

I assume we'd like to remove the id argument when the dropdown menu for 
versions is used to switch between branches.

I don't know where to do this so I'll let the competent people do it or 
guide us :)

Cheers,
Quentin

