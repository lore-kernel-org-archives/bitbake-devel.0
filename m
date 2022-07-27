Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F81DC3F6B0
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 08:13:49 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.82])
 by mx.groups.io with SMTP id smtpd.web09.17330.1658909622122043498
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Jul 2022 01:13:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=mVN9njfn;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.104.82,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kknJPly3QRgn/d2tewcjRoymkW/8aSONQ7nS/SRs0zTWXOSYu9JP5olHZBklao8jWrDNZU8pt1rZIWzgnAI4fGMqKO/FLld/IvqJIouV8UMwThZkrGOlsvylJZrab4mMabxyK0LabJ7DMC6M/g+wB4kUlwVINlDxPnIGs2CjeuYnIKrPSOTUKpzuICD14+Hw6ZDymiqz5/o2+uMeq9cNDjHu/529XdQ6pF1kXBU6iVy4TdVWQVivR3tWHBE9+6JcsKxaYqanzxJdEpBe7Kut9lUPHKmUNiYiRyytjvY2xSaVtQIBrq+eX1a6cCZU373jBIbj07P/4kHqfydoiR+WMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WSC4v3kJc5UXmiS0Qv/75p9hZTtS4Vvh7KEambe5T8=;
 b=hIPnXT3gSbz7wR2T0adhuUC01qjp31/a8FxX0tvYYZLbdeISOXCqe9grjzPChPUbhKhjwDjNvuyQKErEzkvfKZ8nQRI6MmlW2O9HbWMJKQNUN2383Hs9r4UKHxZtMSw0IA0xMOxnkqqQGnQxBa988LaRMk+J0A97ciWV2XiTShPnyuoSVg4D/7npzCaZTBvhYS4rGwVTPUKflCunJuMnwuJHTkBnfMc5GjTohmMLzpEss501OikfVnn4cfq3GWDb2PU5dAE4JGrQrkR8VjMhrTgcki5Sb7UioMS1CEijAvowsTSoQ+h74sdohiX+3M6DsWb79t3BGQg1QywI5LNLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WSC4v3kJc5UXmiS0Qv/75p9hZTtS4Vvh7KEambe5T8=;
 b=mVN9njfnLmDKAW1it2YWKkb7Fuz+Hp2a1hpCDCMpBFubYbmoCYZaaaeqP5f3713hA6HF02gCR5KBQtmOZyJF+oVNtTCVxd/Msmc0vZyDs1JmylHQNR9s/kcXwim5K8V2AL5Yia45Oawi2shaXyxaGzaI5q3IiESnef40A3KRCSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 08:13:38 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4%9]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 08:13:38 +0000
Message-ID: <70454492-5bd8-3929-6197-25863518da33@theobroma-systems.com>
Date: Wed, 27 Jul 2022 10:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [docs] [PATCH] bitbake-user-manual: npm fetcher: improve
 description of SRC_URI format
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <607a8e9c-ad17-bff5-7b65-b02dd698c891@theobroma-systems.com>
 <20220726174545.1734501-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220726174545.1734501-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300d40a4-503a-4a4d-9c2e-08da6fa7e8aa
X-MS-TrafficTypeDiagnostic: AM7PR04MB6887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rpF7goiRuRvS+x0LQiWbwmAOfpkQA9dgxvY4SywSAUoEak1LWAAmJU57/NRtjX9W+9tW1EYkRhX8Zyh/N2NS1xow2whmzPWVxRwG5wcdahrYT+YrbBeu+5f+UjXmgEClEHVeBxcMvWcmpIlZLBs70ZOWTf/tEYxXtaCf8K43uSME9grP/CiOTNcKiCm++c9k8b6Xn14Z/6BFH2XUGrdkhx4pOLre3iynJOii5d3qjudFvhAzxikXTnzp5sb5HNL8hOiPs+vHM1BE03vKsxe1v/hlicViVpjsdK/HIX/NvGMyyGxqKoI4MI41adLTIy53nxhq9/Ix0M1/wmbNnWIlnVwdsg28gyS3bCCJI4DTLU9RlpUmlkSFdlyXtc+UxHHQ0ltll/etsRH7kqXya2dtNH131QE8WYwEXXFGv8gE3SdwJhuPCIWFmYl7SjUwC0Q4jec6QRxAD8PDzmuz3K2mKen0FJANcwCOQt/kCSkLiF5WrptqmjCgk68+Tey56iKJ9Hkx7aVX2Cje19pOa4F7TcU+8F880H6dcaz3GODc/PtCmGpW9eOzQBv1m4U4OdAW6ZjDhneG42z7qlC+D1lM7HMGkxw0Z7fM0bJnJ5Tp+MZlvsWTHNcfy/GLbpFbaJtYkAFOgJuKD7miG8q9utwE3v8BPXS/fCmgCcDfk3segXR30n9Yno07VDakPMQRnb9gzfZHC6Fv5lHzWYgwouJ5l4SueyDC5vbOvbiTz8d3ZjafEvN4ClXb2+WGcFvevHI0uTNkV06Dl0FK/hR8Ccv3SnfZ3ECKsoLQ4sMEMKk8EMDnvxoqbs6fy0alWdy/wRYWaJIysiStM7kT+1qZ7v2F7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39840400004)(396003)(478600001)(38100700002)(6506007)(2616005)(31686004)(26005)(53546011)(36756003)(86362001)(316002)(8936002)(2906002)(6486002)(44832011)(4744005)(66476007)(4326008)(6512007)(31696002)(5660300002)(66946007)(66556008)(186003)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkVPV0tERVA2ZDlCajhWOENrZTlRcFlqdExiQ1RoNnFoMktUV2d4Y3V2eW90?=
 =?utf-8?B?Sy9zbTN5S0VQUEUrNEJYZ0p2NWpjYkVTRUVNMVRBZlp4YXdFakp4WGg4Q0hv?=
 =?utf-8?B?SDFyZWoxQmhGelJIaVFPS0VNbHpNalF0UHkyVS83V2hjeFp3c2xKL0ZYQ0Rz?=
 =?utf-8?B?TnFLV3VIbC9YNi9HQS82M0draUltVEYrSE0yY2g5TVFDTDBiNTg0ZzhhRTQw?=
 =?utf-8?B?MXRJRTNWbHY3RXZvakVxVkR6N25jV21Wb0VFOXpFS3ZIc2FNVFhHKy9xTzBB?=
 =?utf-8?B?WGlSOWZTL1NjS1F3YWh6YW8rZmtNSXVlMDI5c3hwVUhwRVQ5d0h1dm5PQVlx?=
 =?utf-8?B?MmlMNFVTTDNKOVJPYXpzbS9jWE5DWWdnREQvOWFMeTQ2Uk1va3NWSVZxbWVs?=
 =?utf-8?B?aGZTNjdaMHpuTHZwVFNjMCtjUkRrL0ExYmNGYk4vZ1oySVJHOTN1UVRNMncv?=
 =?utf-8?B?THcyQzNXdDlDUWdwTDVtYTY5bHV1a3JrY3JaaW1kNE1tcXpBd0hDcEhDNlQw?=
 =?utf-8?B?NDhsNzRKdWdXNHhsTUhIaFcwSk9tVEpBNkpFZjgxS3F0QjJEYVI3eXhUNW9K?=
 =?utf-8?B?T3FFQ3RJWVBlN0Q2Ry9pWVhCNTVsSWRRTlY1T1ZMWUxqSjZycDBnR2FlTjQr?=
 =?utf-8?B?MkpqRnBZelVYekh6Yk1LbDJ6M0hLUTYxS0NWd3hvbmgxQ2JvaVR3eE45UHo5?=
 =?utf-8?B?dXZldzBxMGoxeU1FTElGVlErSllCNVltV3FMS3N4TlFBZDFYNHBvMUtPN2tN?=
 =?utf-8?B?blRVRWR0aXBHUUFTb0JQUUZ3eDNPLzFQRkFyd3J0Nk4xVDFVd3lhTWFsd3Mz?=
 =?utf-8?B?d1Y2Z0NHaEJUZC9panU0b3R1dFQ0TkhnTUU2eG83bDRucmRhRzNUaFVlRVpT?=
 =?utf-8?B?MExYU2pNU3lVQ3lSZFpKdEhpNzZWbFEybkhKc3FUckRGdWdyWnpGZXVuQXhU?=
 =?utf-8?B?enFEVHFkQk5YVURQZlFoRzRVNHFuMHlucGdMaXJBQUwxc3RQR3hqd2I5bGFE?=
 =?utf-8?B?SnI3TW9XZWZZYnVBbDBMajRpN2VBRGNFWHRVQ09HcG4yT3NqQWNIS3JDMTV3?=
 =?utf-8?B?bC82N28rL0gxVURsMWorL1NQaHFaV2MvQVdBUGtVZlZwNWhSUGtkTDYxMjBm?=
 =?utf-8?B?MjVMRExubWZ1aDRQRWgyL1JCSE9meGYvZ3hUOTEwcWdmbFRvRkZYS0JhS284?=
 =?utf-8?B?QzBSWi9KMENUNldxK0tEUFE0c09NZktLSS84blNpS1MvdGxmVDNYd1dJWUFu?=
 =?utf-8?B?L01JU0cvbUNpQStoNEZ6bHFHeGdsTXVaNXpTZm9QOVFMTDlHejEyYno3OHJL?=
 =?utf-8?B?a1ZsVDVkY1NJUUs3OW9VTjlHT00wYlpvWXVBVnlKNTFWUTJYMDhPUjRUR1VW?=
 =?utf-8?B?UHVJbGhqeVN2b0x4SGJoUVJEZDFSWVhlSE00M05GYUlva3BmTGE1bTcxWlNL?=
 =?utf-8?B?VVJxaDQ2aU4weHJtOG9vR1pxSjZDMzJJUkNTclkxR3V4SkxUb055SGlrbmFV?=
 =?utf-8?B?cXF6N3Y2b3RTYVVwUEhkTEtWeTQwanY3bnVZbEw0MHlRVC9ndTBMeldsZ0Fj?=
 =?utf-8?B?aFJHVk42RWIwdkZEWlczYnJldUgycFAwc2Q2Y2orZmdQTHN2cFRWcU1mcjlv?=
 =?utf-8?B?TzFNcnhvRUpGUVd0TnVZRTRvc3BoanU5TlBIYXlYSlZiUWR5Zit6Zzk0VjNx?=
 =?utf-8?B?b2s2TncySTNGbE1uS1ZVc3lVTk1TMVM1QzFzUFRJNTBtamh0UUpsOFhVUWlx?=
 =?utf-8?B?bUJOaUw0ZUJja2dKUTJXaGRuOUZiWVBEWEVOU1dqY3o2elRtYjBKWG9qWmlU?=
 =?utf-8?B?czFBNXRHZXVQK21GWFVwRHVWVTErQW5xY25JT2lDcVA2WFZSOWRRam5sYzB5?=
 =?utf-8?B?U1pZY3RrK1hOcko5WElYRkdUMytCb2IweWRTWHBkUTVDLzlmMG4yOVJlQ09v?=
 =?utf-8?B?OVE5dlRRenByRlc3ZWh3anRXNEMvcjlSM0JQMG5xZXlmQm00STJNQWw1Y2xO?=
 =?utf-8?B?TjZaaVJWSHhOZEJxZzVUR2luZC90YkVEd1N1ZUdHSktNV2NyV0tDMzYvakN0?=
 =?utf-8?B?Y0pvQ2JiRGUvMzJzTTJJbUtBdVVJT0Z6SnVHT2R4RWxpQVpKTmppbjlwYWtS?=
 =?utf-8?B?K29iN1RyUThzUXlERHdwM25DdHBWZUc1UGx2WXdMdEhuY0VTTlUzbFdQQURq?=
 =?utf-8?Q?miW8RWwM80navOeVlvfSmuE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 300d40a4-503a-4a4d-9c2e-08da6fa7e8aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 08:13:38.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ud+8dxALO6LVf6oVJlmmZCaDpminX/hs+uQPhQ098dbfhCoC8iRHkDN79f82be6tY/WOTG3zAffFNdXJxOq0op/o9NECyB89+9NaU5qmgXgi9Na+GGbcoYB83XxinNhh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Jul 2022 08:13:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13856

Hi Michael,

On 7/26/22 19:45, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Using the term "Parameter" which is consistent with the
> description of SRC_URI parameters in the following text.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Reported-by: Quentin Schulz <foss@0leil.net>
> ---

/me is happy :)

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks!
Quentin

