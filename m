Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE7C54EE9
	for <webhook@archiver.kernel.org>; Mon,  5 Sep 2022 13:54:23 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.47])
 by mx.groups.io with SMTP id smtpd.web12.25058.1662386054015144373
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Sep 2022 06:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=hzKdS8xR;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.47,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH8vldcPF+7y2DGg8nNJgjdJaSeFhEM/UhIUodNZWFXaMbxbO8nxuRvPB9uZiOSmdIaDGxTZ2hqh31Au1lJymMAjXtoSecgTJd1ERLo95Dq7CGdx6Q1J2fDOkXo6erEHc8u4RBFIMTwdQVjL6g1303QlRop+PZNzJMhV3rCekTmeuAGyUlVikInUK2eUIyyCT79gZMJo6Ox0bx8J6QCvuacor/XhEtP/fzUtak8We8TSAKany4L4kJpohxtekpu55Co1sXYg+0wMNoX5rC/5a2UvEf9TYFz49kQ266cxQpFs34Gk3y7Pg+hBpNrlnWLG9i5qTKnzLPEjk4P19S6B/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WzhhDeLw5FBHvB2x6q1VoZ3XmYWRm1at4SZjL38Df8=;
 b=V+3SV76/59ziCH4lUwgsCOdC3yl45OvFkvC3TInn+oG58+1iSCRF+83VyvNDdH6i5XvoWREcXYqJ/i7dE761w+XOMdfgwV9Ux/Lbb4NIXnBXPwE78Kp5VI1V7MoaSQRAEkYl3HN/DMrpbDSL9KNfdwUWcVq+wQlUX3f5lTDo7wFAWe77iIG5zimbZKYQUjE7uF5JNtYv+U+0mOcADLzDuFkE5LBCMvmWyNpBKQcNzKJcNvnPu4lMnconz+OsyhVat44y8iFybI5cE74ydT0wB4MCbmqXTBvhes6inheMrSS7dbDQioUlGI23rZ20J9rdTb67I9WxS6PVxiFzvXzX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WzhhDeLw5FBHvB2x6q1VoZ3XmYWRm1at4SZjL38Df8=;
 b=hzKdS8xRenA+ho6oZ7kwBJRWKb3X7ReeP1tNzf/Hk9/dK16DNcVyLJ35e/6Zrsr/U1tZS3yzkPs7LjYAsZFGFK6Mw70qDTpllZuwFeiQ9SiD5hom52EYPJKdWAL6Z3GcSIjcuP3ZCHC/yyxncwDXiPN9/Tc/VOkG8dBC1PwUfOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB5677.eurprd04.prod.outlook.com (2603:10a6:803:ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 13:54:07 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::84e1:275d:69db:1748]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::84e1:275d:69db:1748%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:54:07 +0000
Message-ID: <676e32d5-7341-a389-206f-ac515ab37c50@theobroma-systems.com>
Date: Mon, 5 Sep 2022 15:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [bitbake-devel] [PATCH v3] doc: bitbake-user-manual: Add
 definition for BB_PRESSURE_MAX variables
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Aryaman Gupta <aryaman.gupta@windriver.com>,
 Randy Macleod <Randy.Macleod@windriver.com>
References: 
 <832988652fd0646394de3145564a068ba6c59b51.camel@linuxfoundation.org>
 <20220902173550.89987-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220902173550.89987-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dea5afa-c43d-4fe6-41fa-08da8f4619cf
X-MS-TrafficTypeDiagnostic: VI1PR04MB5677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VJ1ZJRYm+k9PRL2Akkr0m7qDrgmEBz7VfYHXx4M82tWIZC4BrydFjYChl3odvSJ9Yls/6UyEqyVv4Rmn6fYzg5Jd0xhoiwttMfL0D5E+rZv5QfxNqZwrcsV0wd4YecI6IS9Noj8RKCrNXewblXFo5JVZfXp31rO1k3yx36TzqWfDEOCLEvLlbtwniEM7S5A4/rJLmBhCq4wqfcjGMKvUvtTjHghJFRIAmzb7dveW3cgYty+VKN1M4WkvgYq1PhLfcxIkWUUIgxuELFt6IiHc0Djnm7sB3dIEDJw9xS4JBUJdc5h98ZwWA+5O4mWXcYCLmY4cXKFeuNRQ9ySAD6meXPpIK56kgdX9YIpos6mpnsJfnmj6nfKnHq1rCNsTy38aYIdkGZlNxgZZYPhASYczIjJzXlCzFNvFKJu4+7XitYSTwYYlFgyJ8tPir06ETPqUwgC6lSpFcAaMEIDHGYrfFle4JxeBYzjYUBJIKERi4KkSGWDQ4tonCXeQ4mEG07hzv0EBJAfM9fG1HTTCpjRibyXPBkTO8zLDQr8bx2KazqZVUqFd1Hz75UZ7d1M1qzV6uF4Q71X1pxZiXzEHTOflaArQ56b4KSxf+ANesKq95Rr9ehI7/Lbzexxk9OmXw+ED6HVirWyM0Em9hyxdnpW9owui73rkPsggViRRJCheCsOaxL8y6xyU2kM0He2RoD4DhoXpQuuT0zA4lnVGVzrlxzNM54cB7peCeX0hQnXAoMHzd5jpF0pjoClOAW6JEmyMpAk0jkb5Ong5c9oTvAGK9g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(136003)(366004)(346002)(376002)(54906003)(316002)(31686004)(38100700002)(5660300002)(53546011)(36756003)(41300700001)(6486002)(8936002)(2616005)(86362001)(186003)(6506007)(31696002)(26005)(66946007)(2906002)(6512007)(8676002)(4326008)(478600001)(44832011)(4744005)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHNaOGxOUTFoWXYzbW1uR0pSTDRiaXlUamJzcGI1MEE3ZEU1R0kxa1BtcFJ5?=
 =?utf-8?B?d0ltSDduR3c1ZjV2V3hHL3U5Y21QS1c5aTFrZ3NtMEp6YjNlb1lVZVloWUJ5?=
 =?utf-8?B?YThTdXM4SitFakV2c1BGUnlyY1dmTWFuaEZIeFl1ZGFyVFE2cTM1TzZZcXNy?=
 =?utf-8?B?WXY5ZVlScWtXZ1FjK0JqWFZTZ3krVWZ5SVJuclBWY1NtNXJaN3d0ODRUeEdH?=
 =?utf-8?B?bml6ekxycTdKbXFuR0dLSWc5ZGlld1ZlMnNyRENYZU4xY1haRVRzM0VudHov?=
 =?utf-8?B?NU8zNjFJanhpLzRmS21NNDRLR1crZmxBd2hUTUVmZ1F6bXlGaDBRenlqaWlG?=
 =?utf-8?B?cG45ZTVwOFVOMHNZeDBYTFdwRnhKcVB1b1JDVEJ5SjBHeHM4UUpMMlVLZEk3?=
 =?utf-8?B?Smp4cU9UaG9sNGRzbVFFLzZZbDdhWEZnRVlPUDJDSmkvNjBiQkd6c2pIQWkv?=
 =?utf-8?B?RWk4VG81MWRHYjU5MlloWFFHSlNOZnpHL0ZEdTVhMy9OKzRLTm1tZ2hiNVI4?=
 =?utf-8?B?c295MGY4dFpXTmxYTDAyRVhtMkRib3FCVlBwUnZmbk1CT2xDRXVWYkZzMzNJ?=
 =?utf-8?B?NFdNRTV4RXk1ei9PakMxMEdzK3JSV3VKbmZKRDh0czFGREhFVTJycVQ4b01L?=
 =?utf-8?B?MkxkZElGa210WW95UmZla08wSEpldXQ1VmpqS3JYY1VWWlByZlpOTStRMm52?=
 =?utf-8?B?eTY4OThsUEJXMlRYZ3Y4MG91RGFUNlVqaEk1dDZFQTl0QW9NbXZqaTFFbHBH?=
 =?utf-8?B?TStVS01zdldQajBXdWtKampTb25rZUJSQ3g2Wkd3R0hnRmJyQ0pHam14b1Yw?=
 =?utf-8?B?VGhXKzlMSU1oeDYwTHJiVkQwMTZYdU0xUy9UMStKRU00d3EzM0gyMHIrMnlB?=
 =?utf-8?B?T2VuN1VEMVVRVzltaVEzbnFPSms4WGtTa3d1bG0yeHlwb1lIdHYyV0MyZFlv?=
 =?utf-8?B?ejh2VmRTK2ZLeFZvMW5BdHZhSk90RThJdFdGRjZGNzZqMUtsUWRVVDZLSytX?=
 =?utf-8?B?UGxPaHpBekR0OWlVcDg2czhWUlEzYVNNMkU3bGx2RmpTOWJjeU9VOHpXcWt1?=
 =?utf-8?B?K3BBTGk3Wlk1RlR5MXErSGdUcXRtZzVESzN1d3dCQmkyWVRXanNNRXU4M0cx?=
 =?utf-8?B?bzF1bHZUU3ZvZUd6M3JhWFdjSXIrMVdTVU9YK2N4VlRKcEFKWGJrSkFsdm5y?=
 =?utf-8?B?RHEyVENDLzYwNUtESTZBNk5rUGpadUF1TGJ3VTNGTXBaVWN2aDl2dnZ4anRT?=
 =?utf-8?B?TzkwNWpiTW1lUVowazRiTHdvcnVnQWs2NEUzU1VXcExPREpsVW9GT2xvZlRi?=
 =?utf-8?B?a0VSYzhGc0g5WEtXQ1l1Z3kwaGw3ZzFuVXJyTWI4YXdFU0JWM3VBb0RHNXZv?=
 =?utf-8?B?REV0eW5hM2VmcGxyaExuSGJzU0x6dTJSVGdXZE5zYUc0Zm83SUJ2akovTkVp?=
 =?utf-8?B?TFRJN2hFa1JWT0dLVEJpVW43Tk84S3Q0N3Qwb0FvMmUyMUhNU3g1dUNkL1da?=
 =?utf-8?B?Yjg3NlZSU2F0b0duZGNlUlptb3pseFcyYlE0T2VVUFFCQXdCLzMrVi9RcWs4?=
 =?utf-8?B?RUxCZTFDN1hjRTRtMm1Tb2p1ZEp0VmJzU2Z5ZUhMREVFd0Y0WXBnNjFGK1U3?=
 =?utf-8?B?azlhTDNZV1oxNXpHeDl3aUVXSTZKd1k5KzhISlFjQVhESmNKT3p6dkVJaHBU?=
 =?utf-8?B?RHRWOFdYb2dja2xyUXRSZEdSQXF1MlRCZHlRWmtacW14RTVzMWhNajFBTmVB?=
 =?utf-8?B?N0NGUEFDNDA2VVVOUzE2VTY5V3hVaXIvQ2ZINHFvaDV5dHZUdUVDT2owVTlK?=
 =?utf-8?B?OHMwVCtuT2ZWaWp1NWJBdmJHdHU2Q1dPamwwQm8wWEhGcUtGckxaZGlONU5M?=
 =?utf-8?B?UnZyaWllRUREY1JLWk5FWjlTZi9qSWNGYktVelExSmNLWFk1TnU5MGpvWGQ3?=
 =?utf-8?B?VXVvZnRBUXpncERJZDBkVlE2a2xaSFVpWjUwRkZycTB0T0I4YjBZZGpwVW1k?=
 =?utf-8?B?NnRVeEFyd0ltcndaU2c4enBKaExwcjlJallsZDZraU8xR25ucW42Q2lXcy9j?=
 =?utf-8?B?dmZUR28zT25tTDY2RENjOU5WdVc4L2lSMDhJeWRJOUgyTGpmNTErMWhlS205?=
 =?utf-8?B?eVB4MkNXdXJzVGpyOHIydkZpTXg1R3NrVnBobDRpV0xpS3VYQmdzRldxRHFY?=
 =?utf-8?Q?wuODBajPqxSGWLT73EoIdaw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8dea5afa-c43d-4fe6-41fa-08da8f4619cf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:54:07.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 zLJZo7zYvz53fD4PtVHk3/DMdyeVw56aXWufpDnqzFeBA9f6yN/QyZ0jyPUX+1awcMucAxPbVOfP7H5MB4uXaAh0PY0dPR192D2OXGvko7hY+iXSC+v6cw6ju3lywZ52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5677
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Sep 2022 13:54:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13958

Hi Michael,

On 9/2/22 19:35, Michael Opdenacker via lists.openembedded.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> From: Aryaman Gupta <aryaman.gupta@windriver.com>
> 
> Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
> bitbake varibales glossary. Further information on how to determine a good
> threshold will be added to the Yocto reference manual in a later commit.
> 
> Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
> Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>

IIRC you're supposed to add your SoB when you're sending a patch even if 
it comes from someone else.

Otherwwise, looks good.

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks Aryaman, Michael,
Quentin

