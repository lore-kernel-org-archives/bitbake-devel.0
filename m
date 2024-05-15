Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB5C25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 09:35:31 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.134])
 by mx.groups.io with SMTP id smtpd.web10.10545.1715765724607967543
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 May 2024 02:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QNt0WHxb;
 spf=pass (domain: cherry.de, ip: 40.107.104.134, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg0N1YJksNeGaauGUNVZQcf12zZ45g1MfQ5O7cGWPcOegPJk4zKfJ7l9KYKqDeu0+zhzuUkUp/e9cUh+76w5vWpukHZvXqmOsoGa0xxzIFW9/1DtrscctyBECSeJEzLQFR+wyvFk9WuwB2eFCdRM46hqedHyLppQxN826C+cXzvZNLs1q8SGnPKRzLwx68fRdnjR6yqfivEkNFbvsX09c934bb7Y/xyz/14DFJQEL7tq71/eUgLLucRtbsvKgp/ihi303BfaTM/nshkt1II1dJElf3BLnvexhSBmSd8ZedeiI6n3gfJaY+JweWFfCYycXDZyUtBSxgrR5ORbQSLUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THgWIq3oTXoCqOntltXYMywwAy4LtjZqp5BVLeC1jTg=;
 b=AQwTFwWTG5mS+wQW/sV13EVZsMaLwj74QW0fFUl2lcPvwIlg1qHL4nwHqL4c2Rdg5Y1XRIM2uVcqQABKb4LC/Y51pdcq7bFu2IG7cqz1//aSUHV4YgykoUct9CFQnLoX4GdPhNwX/1oM8MzQ45+U9MMten9gtLCwRZnszplma9SLLsj5ymXPiQ/oivLcKWWjiYSYFOwltYX/V27Dj3lPvE7K80CIWnVR/WH/oW6L+55deq7NHoUQ0nIdfR7eZQ8iUQwGyI9PLSB+nPSQd0GIl+hDny0S5CH3mqqzQAnrf+5v1NDzqKvEY+E2gOja+8bqOeoM69DgFmw4osixak84eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THgWIq3oTXoCqOntltXYMywwAy4LtjZqp5BVLeC1jTg=;
 b=QNt0WHxbX94ayzQBU6AmAjHlw5xGI45cfoJTfHV3iC8krw6t+HOy6/RoThqPFG6yZkE885h3QRAz+J8Kz+ow/27QkWQnCjUou3D2QxjK1FLV592K7wO2lGUn3RAY0XhmaSl2I0W5nYC8p0iUTC1emxsqRunJueAtITW43S1gEls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by VI2PR04MB10716.eurprd04.prod.outlook.com (2603:10a6:800:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 15 May
 2024 09:35:19 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 09:35:19 +0000
Message-ID: <367b25fc-4d5a-4a1f-a259-55e2325e1a34@cherry.de>
Date: Wed, 15 May 2024 11:35:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git.py: Try without '.git'
 suffix firstly
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
References: <cover.1715765153.git.liezhi.yang@windriver.com>
 <4a7647c4169ffc0c70858a4a1f1b2eb18ffcfb70.1715765153.git.liezhi.yang@windriver.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <4a7647c4169ffc0c70858a4a1f1b2eb18ffcfb70.1715765153.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: e695dc07-ed2f-490d-b0d6-08dc74c255eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RXB1YUV3d0pLTVNIN203bkhzVmZFbVdtWlU5NDhwZmQzTzUzV2YyVWtMMXBj?=
 =?utf-8?B?TXd1UkVucWIvT3B0U2toQTIvNVRHSHZhckdpWlBXQUpUR3ZkRzdVZTZ1MVVr?=
 =?utf-8?B?dXRqV3ZLUnBUSlk5RC9MbWNBdExYS1dJVUVYRExDUi94cWFMRk0yVy85WHBF?=
 =?utf-8?B?QmlMQmR3K1B0QnN4L0NiV0QxbWRLYmd3VFJ4WkNHRGlINVJ3Y0lZUWNpY1FS?=
 =?utf-8?B?b0hqRGpYSHFpcW50RVU4UHdoUEtzMlVOMUVNWis2Z1RqTit6TUNhV1NlaVY1?=
 =?utf-8?B?Y28zbkFVUUIvZlBnNUo2bjNKMW84TUlDcXVFWC85TzZJd2tnbTR5V29tSTg3?=
 =?utf-8?B?dmFsZUloaUVqbmNZT0ZZMEY4WkNlbEc0bEM0Y0xzb1U5YThtbVlrcVZ4WElN?=
 =?utf-8?B?bERqZ3JITVpkblRvd2QyQ1FmL1hsYkx3QWg0RklkMXkxRzF3alpKdWxhVWEy?=
 =?utf-8?B?dUU5ZENLcUhBeDZUODM3WVIvSnZoSnJSUjVLa2oreXgyU3dUN0E1ZmZ0c2pq?=
 =?utf-8?B?ZnhIMkduY1ZXUG9QRVc2Y0lLWUZuMkdIRGJ2Nkh3Y2hvZEFabUhvU3M1UGpq?=
 =?utf-8?B?c1BxdzBPU0YyUUJHTmhac2hCVHp2ZVJSMnRlOGt4cUk5K0hkMGY2bUQ1czRD?=
 =?utf-8?B?MndYb2VMaXZOMXY2UDRLK0N6VHc3M3M4SXBVK3FEcWtXazFxcWo3bnBQaXo1?=
 =?utf-8?B?d1hYL3ZPc1pwQkFaQ3BiU1BuZnUvVGd1NmIzWnVUckcwMkN2MEJpU2NqaDZG?=
 =?utf-8?B?VEJxTkZIZExwU0NnRXdMeGlOWjk5Z0tFdE11eVZEaUdmTmdERm9OLzRZbHZm?=
 =?utf-8?B?cGo0UmJHcUJxTFRlbmdFU0lkV1JlWUx5Ky9tUWlpN3dpdkVuaTc5THZ4ek5n?=
 =?utf-8?B?aExWUGcxWUNOa3FKQlR5c3BEc2VMcGpGRkE1eXBWRHhWdFpNRWNYTGQvUkxF?=
 =?utf-8?B?UmxRc0U4QVJGcWFFa3E5Ky9YblhETzc4a05ZRnRsMmtYNEp6bjY5ZWp2Nmxt?=
 =?utf-8?B?ZHkxbmFvbW5RMUlDSldwN21OeTArZTZaWkxlbW8vc05nL3NFQWRSVi9TWkxL?=
 =?utf-8?B?RHNveEpDMGNYdmxVZUJEUDhVbHNWb2dPaWdoQ1BhV3NqTFZwekducXpzZFBr?=
 =?utf-8?B?a0RDd2ppM2dSRGY5YTNZZXA3OExyRTBmSTBWbU9IVG1XdHVKUFEwWUtVQkRt?=
 =?utf-8?B?cUZEOXlWQXIzVXM2TFByOTQrREVBZzhLNFVXRGhSWmNJYTZqcVdxTmdXeTBi?=
 =?utf-8?B?bUJBU0gxWi9Kd0NnKys4anNnOHhiRmp3aGlkbDR5eGw2MmhZalJBY1VMam5u?=
 =?utf-8?B?UGo2aE1OenQwcHFJaktvaEVDajhISW5NOWRxZXhSNmgzNVJBbVlqaW1OSTR2?=
 =?utf-8?B?QWVQWXFxYzV6dFMwT05DelZreFZCMkFEMnZhUWJTR3hLVXFudGpmN3htZDFS?=
 =?utf-8?B?V1lRODZwRmoxTE54SjVoeW13eU9NQ1NUZldoaGFndGZzNTlvOEpWNlhVck9o?=
 =?utf-8?B?QStVazNBa3BoUHE1bFFaYUl1OUFUdDRYNUdBTzV6T3ZDajBPcm5qMm9QL3VK?=
 =?utf-8?B?S2JuR2tVaWZsVzh6L0pXNmdNdDhYS1ZSZWt5YiszUUJEUnNIYzUxeXJVY3o4?=
 =?utf-8?B?NDdFOUFMQ2JnSlROVFd4OFFrM29QZG13bXZic1gyRDZFWWYvbFVLNGVvWjJs?=
 =?utf-8?B?SXRtUXYrTVlxaWo5SDUxL2JaVEdoRS8xZ1ovMlJhdU0xeEl6Q1VtQ3FnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnNreDk0VVB3N0VVbTR0cUlNWkxieHlSdVh1RWl3Y3pFdzNqY2N4OUMzenZj?=
 =?utf-8?B?M1UvTmRNcEd1OXF2dzYrVnJHSlR0VENvU3RMcUttcUFIbnNXeUpJNmJXZmE0?=
 =?utf-8?B?bUFEZy9tOGlEWUpLTnRGTnFxbFptdjI3K01WYzJnZnlwV1Fpai9DWVlQajJL?=
 =?utf-8?B?VS9MVStoQUMyajg4dXhKb1dlTkYwUG1Hd0lxUVVsMy84a3BkRzd2aWdBeWw1?=
 =?utf-8?B?VkExS0wyZ05lN0xBUUFRQjIxYUx5K04zNmgzUDB5OXFYOUdWTXpQZW1ncXp3?=
 =?utf-8?B?ZFZmRXBlZzR6RFVEY3E2d3hVV2pUcXZBQitJamJxNm5oVlZMTEloLzNMeDFa?=
 =?utf-8?B?bXBueVl0MmFEbmV3TXJWanM2M1NLc3pjVUs1a3NacmhScDErK3hUY2xjYzhF?=
 =?utf-8?B?d1NDRkp4cTZ4TkR5L2tOdmNBc2ZMdUoxVDMzYmt5S2Q1MEZPMCtpQmZvdzZa?=
 =?utf-8?B?b21rQU4zamQxb2ozT1hmRG55anI3am5BSkFlT25xVGY2cTdjdkl2cWUvVHBH?=
 =?utf-8?B?VGZrMVMzRUloWmNaTXExeXpxMkhTYzJLbjVIUk5EdjQxVmRqRUhBS0REYTRz?=
 =?utf-8?B?dzJmVEVCL2pVS3dqQ2NiRXBLZ2tZdnIzNDA0Z3NFbVRXdHVQQUV0RENCUXEz?=
 =?utf-8?B?cHp3enMwRHBhQ2VpV3pPa3A1STcrSlM4TjRxbW9RVHhhUmFmaVZJd2NFS29J?=
 =?utf-8?B?K0lRMjAxMG5rTkxTUnNjMVlQeWdENnFGVHcvaW9mUnF3KzFFeE1UT01TUVFK?=
 =?utf-8?B?Y2YzN3BaKzhhWnRzYWtpZCtQVW1rVTUvN1hlMUNPdXh2WjVBeXpjY2RPWUw5?=
 =?utf-8?B?cTlvZmJvTGtLWFdMMTdmd2Z2WDFueEI4Z0tINHpKUmZydTVoL2tFcHlvanpO?=
 =?utf-8?B?RjRxU3ZIN0tQWkE2cGliSEhrK0xEWUV1T3dNeU5IUE9YRGRHa2xVNTh6b0Fu?=
 =?utf-8?B?Q1FlcmJNNFFDTDBhb0E3U0ZBajZEZzVuWFE5eGtvS0w0dWRkMmo4SnZEOGdP?=
 =?utf-8?B?MVFDMG1va1VhaHBvaVM0Rmd0dXV1YzNyRlNDUCtFbWdMNGFhOFBVc2N3aWJo?=
 =?utf-8?B?aVU2TWdIN2VjN2VKRlJxdXN3MmJ0WWpkbDhxZ3loRUJCSnI1UnZLZ0VlSXZD?=
 =?utf-8?B?cDNySEVCRitualo4d0E4cWxhNE9QUUhIcHUrQmQzRElHSDNtVVFPSGU0aG5p?=
 =?utf-8?B?S3ExN2N6NjdYK1hYRU10ekFhcXpkSFpNYXkrWi9rSEhGQ0RtSmFDY3pDM3JK?=
 =?utf-8?B?U3ZDRkJDWEtCWEFtYlExT1RzL2dnKy9EcTRDdkVpb1ZocHlTZkd2U2FYS0xr?=
 =?utf-8?B?OU9PcWlnVGtrajZoZ3VlZStQc3poNWFJdkVoUE1Ma3VqWVgwaUk4M3lPbVVG?=
 =?utf-8?B?N3hGdFFSbEJpWksyeHpPOXdYaXRURUpsN3UxcC96djhHV1luQTh5emVxSlo0?=
 =?utf-8?B?MFRKWWlPKzNwZWdtUncyNW1vcUZFUnhZZ1AxMlFESjBmUXllNE1WZkJ4dCtX?=
 =?utf-8?B?a0RFVGlDUWlpRzlGM2FLa3JBSEJMZkF3aWZnR3VmZ0F6TlZRbjB4cWpaNDhl?=
 =?utf-8?B?SDNoNFY0dlJIWENtSEF3VFJLQ3JPY0xJS0JFK0RJZE1WYnI1OGJ0MUJVM2Rh?=
 =?utf-8?B?UHNUYkFiTTRTTmNocXdSbVZmZDB0L2lvcVVhSlRJb0svUDEyTXYxcEs2U0to?=
 =?utf-8?B?U1hFZnVabURvK1kyZTZoNGZ2RDhpZitzbURSWDJsQnF1U0VzOHBRQzVTcVpE?=
 =?utf-8?B?aXBCQjlvbEZsK0RFWGtkNDZIclNqcXpCM2laZTkrSTV1R2FreG5MWEhudTN2?=
 =?utf-8?B?cDJyeWNPb3JPNk9yS1VsNFJwWCttTTVvV2d3Y3N1ejdxK1VuT1Vxa3hEZzBC?=
 =?utf-8?B?QVNSbEFiZHQxeWN0Z0hOcGk3V3owRzN2MktOTlZnMzRCbEppa2N2RGRJWTQw?=
 =?utf-8?B?S1BvQmRrSEE4d0lpWlNjWHNjWjhESlV1RkwxNUZHUEZtMkpoOFNaZnh5cytZ?=
 =?utf-8?B?NDl1cGNGZnJQTkVwTVA4d05HamVLajBoeUE1MDNJRHh0TFBlS2VobVZZS1A4?=
 =?utf-8?B?cERnb3UxSVp5eDlFL3ptc2FMRzIzbnVNamNzVW91blFiRUNjY1VsUXMxV1o5?=
 =?utf-8?B?OWp6MDJENHE3Vnp2VHZMcS9BZUd4QngxMldHOUxBTTdDWnMrSkF0eWRkZFVL?=
 =?utf-8?Q?zBLt15PZU+WwsD/cnSXkV5Y=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e695dc07-ed2f-490d-b0d6-08dc74c255eb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:35:19.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE6J2FPb9DABz/508cFWKjcXqS2Rgi6qyMdUtYnNxBEFc6mXl/flVx6PybboQ5q6WsD6+OxwMiymNAGxX+9rn8EtRymh1m0nEy8OmK1dTxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 09:35:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16221

Hi Robert,

On 5/15/24 11:26 AM, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> If the repo on server is foo.git, both of the following commands
> will work:
> 1) $ git clone <url>/foo.git
> 2) $ git clone <url>/foo
> But only the second command works if the repo server is foo
> (without .git suffix), so try without '.git' suffix firstly.
> 

Shouldn't the SRC_URI in the recipe be fixed instead of the git fetcher? 
Which use case do we need to support here? Something to do with 
mirroring maybe?

Cheers,
Quentin

