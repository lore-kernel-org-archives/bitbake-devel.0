Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6503BC433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 10:28:07 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.53])
 by mx.groups.io with SMTP id smtpd.web12.8073.1646908086460780357
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 02:28:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=FReTplxH;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.53,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THBLQk+6t3G3wURFFnSJkmMF7Zg32Buifp0HcZ30MXidHpPkRhSv1LQ1KXww4dKJiWa2tEMQObFTd29PVbWNoihwKlwQ0ZdDNqcdRkeJ0yi7eSDnbAk0m48r0W2dJehC43fuHZ01uL+aYtFRrT03sMjpDfOUUUS6cWjKXCf+XKCtk9tupUmOhGoSIuEASJmO3es9iqrPnbr6OhO7iGT1tYp+/AT6xh52p0KCaqECr/c5J7VoxygEyQOzZUT5fPAo23+PRxDmtmVTBvvjsISrHFzhaIALbx8GpdhhuPM857R9y+wS+IoTXMNERJOZ49/oaR7tV6P1D11AACbJuPS1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iITfxkDLqXS1Kkm7ZjeC60Hc6+mKyCepSb3WSDy26ww=;
 b=fSK98/9YofDjLIydYuJBi4caS5IUlsUnH7Cl/ZN8991ey/9pECSkj8iMmHUvFwGJMI9p0gx+hVdU+FekvPxWXTceP+DPhljvaPyRLS3olzr7ubWoANMv1WjPm3pFlaGV7SNv9Rj3fKjlm/By1SxKyvGI5NchQMyYGGIQWsZV4qjERQIURSwtMN8JkFdusoykhC07Fru8JME70y/XUrL5DMBYnYdYVKbTXmfjb+eZXUATyADFYaoUPtK4o0ODPiBOjviqyE3H3+qonXx73Om5tUEq3/vDywLvdlmV+QUYQZbXJ2J4hlwWhvAgJEzsvAzsYRqKg9c4JGG3DrU4Ln8Cig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iITfxkDLqXS1Kkm7ZjeC60Hc6+mKyCepSb3WSDy26ww=;
 b=FReTplxHytb4BHz5iXGQyV/8wvvPlqvOT30q6his+oUi6885B9J2dWIIihOMqnd1qHRil6k+PEdWQR/v4VTzsJe5hP68Le/coHGqAAaQbYsFhcfZwqdbxoJruiJRz54ws5ib6ejQQIN4wel4uvvZ31tvBny6LCrfUnbR1nJKI7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM6PR0402MB3622.eurprd04.prod.outlook.com (2603:10a6:209:7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Thu, 10 Mar
 2022 10:28:04 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3%9]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 10:28:04 +0000
Message-ID: <87d40229-21c7-f7c0-1b10-7386825ef690@theobroma-systems.com>
Date: Thu, 10 Mar 2022 11:28:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [docs] [PATCH] bitbake-user-manual: yet another overrides syntax
 update
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220307165036.532204-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220307165036.532204-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0111.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::26) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bb9444-0c59-4467-3bf0-08da0280a8eb
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3622:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR0402MB3622480BCAB4149D511132CAC20B9@AM6PR0402MB3622.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ig9AMfvKTv4JPqpPY0ge283/KXMn983Yz471zAiPESzawrK/SEOMdtihYs1FAVbbx9aMm3tMSP3fXXGjGpEDWHZ0nwCkEWy8obFbEvDf+RQHFt5eYtXhnSj3lcxwhvXzyKZ+lFqFfZJ1LqNVD7lBDehPF0fhX8hp9tKxCLHb1VZ6MiUJF2bJlY9AS6tkf9gL2Ad1SqjMT58S24TEHISqfSV8o+IcaFC304xxwPvkyJD7jb2826U5BiVopPFMdiBAQsq/nwa1AZyvH3eC2RlfF7rVG0Se9UC9HDTzxN+xoUgO3g1ZIsFIZy4z9lgVMLnJ+21a3PJN1lslxIFakpUnHxd/M+4IVSwuXHJSJMLxPMQgJwWf+kEZl/uC3ggIKbS0bcL6Qtqbg38qeL6DI192r/eowGeIjwpUecR592oYSvi7HRVI52M4MvPY17+uAKBLNMpLMsciwzNm+a9xidEsxiAKwp4erIGkHhfZNGeU1YeuJYKHp4L9bAIZlmMDOyks8idgCtkGO7pbyMQ0WmeNV4uwhtbgCNtvZd+J97kRkgwy3GPofZVbt2Z7LV/3q44dX7EA3FFdz3A7eO2umcmh1ztx88A84ODz6l22y1uiAqFwEr8r6euPQQ2WG8Eg+ct+NjzZXl/+bTpcjFLBJA3ziHhVfuZFAMMYubVTpGW4bTUUzawiWv+VZ58jiitKvcQZEqRsMM5rRbyrdUVJR5F7qEJLCWUxYqBVLjMWlJ0gN5k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(8676002)(31686004)(44832011)(66556008)(5660300002)(66476007)(4326008)(38100700002)(8936002)(2906002)(316002)(53546011)(6486002)(558084003)(31696002)(86362001)(508600001)(2616005)(26005)(6512007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1pzTEVxbEo1UEs3WmU4QXRXSzR4TXVwNzRVd2thclNHWUlkaVBrUWJWVVJx?=
 =?utf-8?B?M1hLaHRNemU2Z0N6Q3E2RXdDNWpXdjFURTg4SFk2WElVNDBkbjQ3SnR6L1dR?=
 =?utf-8?B?dWFmMWZtY21ZNFpUTFdrYjdyUmtzTTVwTkp1SUhyYU1FQWh1RDRsd3I0Tjl6?=
 =?utf-8?B?ZkVnZ0pmY1M4M3lMbWZIS3d5OHlSd1dwWHFlWDhIaFJmQ2xiakZOWVJtZ1ZR?=
 =?utf-8?B?L2tkS2JiTEl0eERxdklwUWxBcUtyUkRpaWFEc0tKdWVaV0lPMjdNUVNpQndp?=
 =?utf-8?B?SDM2N3Nxc2xMdXNFT0lNUXJvMTZ2WXN6Q0lVbEMydWZYaWV6OGkxUmNLZFF2?=
 =?utf-8?B?OUk1MnVJUklWM05jMEIyVU9hMTZYaWhPMjNkMzh1ckhzMTVmNDNJMHM5MEZT?=
 =?utf-8?B?bElJOEJ1eTJsZ0Z6QVN4RkNBWG9zd2tRMVFiZ09JZUVzNk1UM0pHUW41S2RD?=
 =?utf-8?B?QjBBODNuOW4rZzhTNzdIMk1PUGREVzM4VE5qaGFBVTlySFJwRW8rTm9lWUJD?=
 =?utf-8?B?c1Z3RFpBdWMxK01nRUlQSnpLajdzc0s3ZGJHdnVrdWJVRU0xWjVZSnVzU0hh?=
 =?utf-8?B?Tzd2OW9Ma2c1SW9VSFJyUXA3ZjhNUWlDVmdCNVZDcitmb3pFYlR3bHVJRjg5?=
 =?utf-8?B?aDlSbEdBZzlCNGRQZFZLU1p4YmxMaXpTcUw0U09OYWx2MjVXYTgrTHdBTzQz?=
 =?utf-8?B?V1ZveHV2QldqOE9uK2hKNUxKTHBIZktOMDd6Z3ZWOUUrNUlOaVE3RE5UellI?=
 =?utf-8?B?emREdjFWRUZmbSttSXdFWFBjdU5MSG1GNzBjQytWUlB0VnVyQ3F4L3orM3Nj?=
 =?utf-8?B?MVZad2pDVlFVcjBIZUtNY2RxL0loOHlESkQwQiszd1RGZDRRTFdJOVAreTl2?=
 =?utf-8?B?WktHbU1MUnQrazhHdHpOaWIzVG1SWnByZU9MKzFSM1ZTSmZ4SllQbkJKZjYy?=
 =?utf-8?B?MHVDREprOXVGRERBR3BKWGl4VFlDdWE5eXdUN2Jtdkh4bytlbWJhZ2krNHdD?=
 =?utf-8?B?aXBYeTJwSnJnaGRLOTZwcXg4K2RqZFFFcEVKZllQQ29ON1JLRHQrNWk2Y1h5?=
 =?utf-8?B?QnYrU1JoTGVUOXVqY2RHTjc2c1FZMXFaRlhYZlRiWHdXczRNby8wc1VzbFhv?=
 =?utf-8?B?c0RRcEljSmY5MlJBYy9zbUNnZWc4bDYyQ2JRbHFoYWZ2TERUbG9kT0tlalpS?=
 =?utf-8?B?VWRGUldjY3RnMjhyTWliSHFjRkZZYlZxVDlWb0s2UVAxUHhJTEpNb0puYlls?=
 =?utf-8?B?OHl6M24yVVJ3VkRMN1ZzUk85SldFZklyYVdEbVBEdjUrY2dWSnJnbGl5RHhk?=
 =?utf-8?B?ZWpKSEZzRWZ2RjZhZlFFekV0MThIUERHdlQ0dUkrQnM5blhscnJzTTY3cU9N?=
 =?utf-8?B?NlVuZzhlQStlSUFSYS9aT00rQWRPTmZPTUlBb1laczJiRWJtQjdnZnJHUkY2?=
 =?utf-8?B?U3Vqak8vdmNFbmM4QjZZNXBuOGtPdUZxdW5UNG5Xd0xVbzJPWGFlNVJQZHpK?=
 =?utf-8?B?YkhZRDMrOXJreTM0VXorZjJHL1JSRWYwSkhBRGM1ZDFCQmtHMUpvYTEwTTdr?=
 =?utf-8?B?QWsrY25jczFIZ2VWOVdSTUhMZmsyMytrNS92eGRSTDdkOGFrM1M4VEZwNU9x?=
 =?utf-8?B?bTlLek1iSWpXU1d1R2hsY252VG1qRG1LTFE0THRSMmREVVFVcit0NEhHQ0VC?=
 =?utf-8?B?WmpFZ1ZYOHgzR2tyemNwazhab05aT1BsSXMvaEg0YnhqM1U1NVlWOWhjMjVT?=
 =?utf-8?B?NTlubEJ3WllLNUNUKzZ2bUpQUEdyemFwYjVka1l1MXBxdk9pTVgxMmxWdENz?=
 =?utf-8?B?TTFyNVFVREkwY2x1bG1YekJTaHl1ZzRCOVNldFpkZFhrYXRnYnlNUHN5NXI4?=
 =?utf-8?B?dEVMajlGUExIeUFpQlJNMUlKeEw1MWkrSys4UzRPc3d3a0VleWIzOUZHNjlk?=
 =?utf-8?B?dDB3cWtrMjlIZmNPdVJ1eUw5SFovVFExUGxYelROeGJuQ3RXdHp4bVJZbjg0?=
 =?utf-8?B?S2RLMDgwRURqVFV1YUFPTmJ2ZHMvUjVwMmpFWmVZV0JTbFM1MFg2cVVLdWxa?=
 =?utf-8?B?bjVyRDdubUFVSVIzakIrQUZvbW5CemhqckNlNzZqdVlqUEVyVERJRkZ3alJo?=
 =?utf-8?B?MkxMQnYwclNQQWwvamNTV1dCMjlSYWFwc3dwRFYvUC9hLzBvOVB0ZHRzNVcz?=
 =?utf-8?B?UmFNc284RlVGV080RnR3SzRjb2Y3cktFY2Ntc0JGQktxUnZIemsrank1QXQ2?=
 =?utf-8?B?K3ZHVm45VVcrQ0QrOHBSMGprWlp6L2tpU0ZWTG5zcVVkaHZuSEViUmhMbHZ1?=
 =?utf-8?B?ZDZrWk11YkdkZGQvUGNYV1laL0VXVTMreUlrQ3BrVUpLUGhZZi9GUT09?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a0bb9444-0c59-4467-3bf0-08da0280a8eb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 10:28:04.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 OIJN4xl3vWkC9/GUqYvV8wIK5x7vkfhr3o0o3J0tds35WbbLsMnvWY6Cy76l/okglowxGDYeI14mYobW24wzXXp9YNkM4fhHOUdXVKIcwSF2v/hKRCrJRdKeuIBD5u6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 10:28:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13458

Hi Michael,

On 3/7/22 17:50, Michael Opdenacker via lists.yoctoproject.org wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks!
Quentin

