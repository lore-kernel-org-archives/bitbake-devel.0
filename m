Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B48D44C7E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 16:25:34 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39974.1768494332127815708
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 08:25:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=CwaMFG78;
 spf=pass (domain: cherry.de, ip: 52.101.70.29, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpdoFRuvQlPSFGzT0v1UbQ6EFb7SwVYiVrRLPiusIYOM6OT84flPbzsifyTXY/X5rNFbEfnUqRgeLPmojHcDc2/ckzCl7IVbA0rLwtZJISmFS2TkYfQwownQYe3N0TPf+xVmJCkV2vUa40J0uO8lfZFC++8aPLzwJq9B6/sY5eDK8aclqtpBJcOvJ+ePHZGVCi4eVYVPsvlTGCqVy0Pe1su9JwfQyMgBWjAnLRKS7A/SEzZKzYGbPhif/aNrMwgcO77Ej9by8L2+zCAQ7bUMqCuiO7wtd2Laxr11r34McSD3Rn6JYwT9cS3w7tXd19jv6D5UoFDG5gXeMXC9pfO05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyun1AtvU5Iw+Iecmy5gnnF3DxZsBBKzO8ZQcyDn0xc=;
 b=HUb2xowbbysbx97W6o9EO0KtmSku9fOWtgKvK1begbOOgtbVD4hC1sfizxBDoyt95ZGPpjYd8OgY6hxx2ZIQ6LBKq19CJxg/8oSodPFm/TSBSDzze83TtDBFb0m9pOulpG1uHbraF+A7ZC2CjwEhgXCSzfi+VctYVRCD11zNCnUP5v1ErvNgiNVzEvRiWHmlZ1UFzjGTzKT0VRx4etWWROp6w6bG6aeaRp4Fx3U9eaKZr2QWuTW8XtH7K+oZprRn8n3cTGgM2DXnDrmq/ZBH1MePLgd8+udT0PUy9OPfZJSusYTX0ZO0TRaKLFWVb0Q/qy1+CP9wn3l1tSuLqhZIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyun1AtvU5Iw+Iecmy5gnnF3DxZsBBKzO8ZQcyDn0xc=;
 b=CwaMFG78TW7fcwtrfBsRGmYNtzdpwU+Uv6/x5p4NZ9Te1kqthOwdpT8fKwqnV9ljaww5t7j68E/s9nPmL04nyVno4tkGhWKwH4KOOjlg18uziv1vVfOFlB2pSDnhgVwXoLQcdoJED9iZxfQj7Iiz6m0D41C6n2kvj1GT4hFMsno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB10018.eurprd04.prod.outlook.com (2603:10a6:20b:67e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:25:27 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 16:25:27 +0000
Message-ID: <9747fdda-10d3-4e1d-99ba-285f27b63397@cherry.de>
Date: Thu, 15 Jan 2026 17:25:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc: remove problematic '_' in reference that
 breaks the build
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <71d0ad79-44f1-9e46-90e1-d0aff599905f@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <71d0ad79-44f1-9e46-90e1-d0aff599905f@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB10018:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d72800-916a-44b2-3701-08de5452b19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Uk5IdGNxZFgrMmVhbjVCc2lPSTRKNnVyTWdnS3FENUlCUE5lSUw0NUdFWHR3?=
 =?utf-8?B?eTdubGJ1cHllWWdTQ1RrNFl5SS9INzB0WEpWazhYQitqWk1hSlNpZHhzZkVW?=
 =?utf-8?B?Z2hOMnRpSENVYzJRdmJ6eEJPZzl1bDd0RHI4emQ0eFZZTDgyM2c5K01NTWFM?=
 =?utf-8?B?ai90cFNsZVY0VmJaNHNsN1JabkM4VE12OVU4N05oUnRaUnRuR1NXSTduNkty?=
 =?utf-8?B?NmI1M3MrWmNKRU93bmV3NjgzQ25yV3BXUVFyRGFEaXpMaGRBa1MrclhleU1v?=
 =?utf-8?B?TktCRmY5c2w0dDlXN2l1SUdCd1JINDdlcDZOZjh5a1NTb1NVY0ZvSTNOYVBk?=
 =?utf-8?B?OWllNXNrQmNDbUJ3cjluL2VweUkwVG5rK1lKNVZsb3M5WCtodEhyRFlneXA4?=
 =?utf-8?B?dUdnUzA3SDlqL1hTMGcwclJOb2kyTTd0WitMbkxlQS9iZkpuK3ZkNXVPdk8r?=
 =?utf-8?B?TWZTK212SmtmaEs4dmIyZXc4T1Y2UXRtTnNrYU5xaHdKamhzcHlVYXNORFM1?=
 =?utf-8?B?enpmWHZtcnU5dnpHUGFodzlxVHNtVnVVSHRIY0hkTjEyVSs0MWRUWTdEelJI?=
 =?utf-8?B?eDZobE1FQmVYdmNtdlVDQWV6YnVkdWdLSWFyRVlqNTlNT0s3aVNiM3lvcGEz?=
 =?utf-8?B?UzZsc3hUcUdlTkJHVDlMeitxbkNQZTNlTDIzRjRsYVoxeGthM241Nm8yVGlK?=
 =?utf-8?B?RjhqOXQrVkxPczhVTFlvS0lJbUl3cmR6YUV2STlRR0hkRlhPYWlnYkRmNTZs?=
 =?utf-8?B?QWdGYnJjT21LR1ZvY3oxOUhsMGdiZWJHR3V4eGt6YnBObFRFeWtETHhEaTNw?=
 =?utf-8?B?eGpBNWUydDNsM3p0d2Q1OWgxaWtOMFpDS25lL2R2NytrbVBZUmJvTzZ1aXVt?=
 =?utf-8?B?VkM5T0Z6enJZeFBUeCtoWEhwWW1wcVlYQmJOTFV2dGVXSmFidHk3TklReTRV?=
 =?utf-8?B?UC9ocXdxSmVCNXhPUEI2ZmNhczlOYkZHOUZ4d28wRVVaU09OUzRLdURNVFgy?=
 =?utf-8?B?bS85Nmo4Tk1zVmdoSWNkMjBuOGhVRE5YeUNpYzNtcDcwSE1ZU2VjMWg4M2hI?=
 =?utf-8?B?ZCtsZlNmUmMxa2RmcWxuRG0vLzB1ZDFlcHhwY01MTVk3N0NYUWY1WVlOd2FO?=
 =?utf-8?B?azJsOUhtSjVQcjFLOFM0VURPdDZJMnN2VkdiTWpaWFA4SXdlUExuSWo0UmZ5?=
 =?utf-8?B?SWsvMVdMdE43NjNUQlUxZk1mbDh6dDlsdXltbGNiREhmSnJmeXlOWnZ3d2RR?=
 =?utf-8?B?Y1RRT01tblY4ZFhoQ2FncFdjNHl4UHRpcmNkMldwRVYycFV4QnJYb01mb0ZV?=
 =?utf-8?B?dTdXcENJTXR5R3ZrQThtc0xYbG5nenZ5N05YU1JlYWR6UFYxSmc1RHZUWnNL?=
 =?utf-8?B?dFVTWC9NdXdaTkU1RHpUR2FFSHBZMUdVRmdXSXBpQmtOM0wvOU5KL1liMXhw?=
 =?utf-8?B?Z2JTendYT2owbC9MdXdaZ2dGSlJsTW5PRDArWnVuNzBMYzQzMWc2eERVblZY?=
 =?utf-8?B?Qm5NSWdtMm8vY1BCMi9xa0pwa05ZK0RLSUl5RUNEQk1rNTRaMjR1bU5YVjNK?=
 =?utf-8?B?YjdXZnozeU45MFFaVCt6QlgwVHdlRFc1R0V4M3ZwblJadmZmWnppMkJhU2RS?=
 =?utf-8?B?VjlGUit5bTRFTFoxRU92MDlGUU9ycFJ2RjhudTF1eVYwRWxic25reFVJOGhy?=
 =?utf-8?B?K1ZvUE1lNjJIK2RIYlpWeDNTNGFyZ0Z1R2lXNXgxdkVVcnZieDN5K0JlcFFp?=
 =?utf-8?B?alo5My9rdXRrRGJ4WmM5bVA2d2dZZ3NRcVl4LzROV01uRFlzUzNlL0FVMFFT?=
 =?utf-8?B?UjVTa2MwNEV0T2RNTzZXQ21yc3BqQnhSbzM4azRxSXNSWUJlU0w4NHkxVUwv?=
 =?utf-8?B?QnBuYldBeVJxMHd3dFlpQUpZSnhMR0hwalJ2cUV2MjV5S2JXZUF1L2U4aUFj?=
 =?utf-8?B?VWpLNTl3Z3ZZMW9ZbDZOTkxLQmhSOGtqUjNBdzh5T3MrUXhYaHNkTjBGWHVQ?=
 =?utf-8?B?ZmV6clRjSmVQTGJleC9yNG51NWQ2YTB5UUNOS2N6MWJyTnVkalB3R1JvRzQ3?=
 =?utf-8?B?TXhKWnBWVkpJY1kzQm1iN3p6NGNPZE9sd1p3d21iVUo0MmFPNU5iYlJIRmRE?=
 =?utf-8?Q?sMbo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXFxR3pYaXY4NGtUaEdVUVZ6NDZJRURuei9ZTFg1UXp6bkVpelZHMFcwY3pC?=
 =?utf-8?B?WURXZVB1aXNvS1RwNkdVSGk1T2JYYjM1QWczaDY5RWFublNpZ3h5TnE1MmZK?=
 =?utf-8?B?N1crKzdVcHBCU29saEwzdUJrblo4OHZ4Q3JrTGorQVFMY2xkNG83Zll1cWIz?=
 =?utf-8?B?b1dBQ014ZW5vSkdJSWhDcEV0NUlRVmFQcXpRMFFrQ3Rqc2drT3YxU2NVeG9u?=
 =?utf-8?B?bVhDNGl3TUpJamZlY1VkeVpHbmZTZG41V3R1UWFWQUswS05tMTNvek14NTRk?=
 =?utf-8?B?d29UK3hnNzhUL1hrUkh5RDJ4aTkvcEYzSERVWk9GYk9RV3VXUVBOTzlGZU1q?=
 =?utf-8?B?VldQbC9GaUpFS0FIM0hERmRaRDJQQkE0dlptVGZnelBHclF6NTFBcW5JYTd5?=
 =?utf-8?B?U09BRDdKSkd5eFQxMTNzbW8yVFhieHBiR2YxbzNJbS9xK0U4U0pvTmlRUVhW?=
 =?utf-8?B?RVQ4bkdBYk5EejBjNjRsVHpGQVFGOFM2NklNU0E1TTFrcDV2UnA0ODZmWUhW?=
 =?utf-8?B?YXZyaTNHbWsrWGdCUmMxOHpKOE00NzVySTZzTm5pZmdFNUIxWkRldzlXeE5U?=
 =?utf-8?B?MFBlbHJSWjlmRjJxMTVCSmJPTHhIZXo4Z01RYldqbDJKa2wzbjBIVS9aNEdF?=
 =?utf-8?B?d1VrUnExY2IxeVcyeTJPbmI5OWpjOWJDQWtJTjE1SGVSbFZzdGQrYWtRamNq?=
 =?utf-8?B?WGtmbk0zajFzY2R4YWZWdlY5K1BrcjNYdnpnanBoVDBCZitPMjcva1BYbTlh?=
 =?utf-8?B?MlBueWxTOHRQN3F4eFVKYWNWYVNJNFVkYjlmUWdQL0dLYXUvR3Fmc2MwbTZ5?=
 =?utf-8?B?dUtBakR1Q0pSVHN5WjdwbWdjNldzdTIvYWVoOEdxdFYxRnhCS1VVWUJFWnRy?=
 =?utf-8?B?VFBqWUlmOEthVEpaZUQ0MDVCS2svOVVOWSs2bDU4UXd2M05zRDFnSmNOSDNP?=
 =?utf-8?B?RE5FLzRZWHVBNnJiMTVlOEN4QngrS3JYbXhPYWswckRNMTdQQlNlMys5ZkNo?=
 =?utf-8?B?b1JuZi96S2R5cGdwU2w0cGpDdC9RMThPL2hmU2dYNm9YdU9OVVJTUjdXNVRy?=
 =?utf-8?B?a3hWSkdKUjJraHAwaEZibm5wN1BtZ0FEZlN3RkVIT0pUUlNUK2NnMWl3UDJQ?=
 =?utf-8?B?aDVtYVFreFdLS2RBR3cwL0hwdldsNTdEekVHWFB1VXA5MUIxVEIxbzU1UC9X?=
 =?utf-8?B?SGNQYWJOWjlndXVSMTNOc1VURkNueUp0d3RqZ2RSeTRiUnBaSXY5cnh5OEo3?=
 =?utf-8?B?NDdiRTh5Zk45bXdEalhsb0NlWUhibUV1czg1cy9sellLK0dRT0M0c0hMNHNN?=
 =?utf-8?B?QUxWTmczMDNidGhPeGRqYWJocmdrZmJBVm51ei80VzVnb2l2QUlaQXVmQkNw?=
 =?utf-8?B?UVFPWmMrRlBIK0YrOGRQU2dvWEVxZDJwR0x5S3Q1MnNYV2VMWUs5Tkt0aTFK?=
 =?utf-8?B?dzBiL0dTOUZjbE5iZ2ZNQmNhdDFFOElhRmdjcWtwbkI3eWNDb2JZY2xKYlZG?=
 =?utf-8?B?eHFSUTJzNW9HRmptZzQ5TkpkVTczMzZ2UDR5MmIrTzlXdzJIc0FmaWRJK3pk?=
 =?utf-8?B?RGZyZzZhWmk3MjRTVkhOWVBZNXhTU2xCRDd4NkpkUFFLcm1scXNycDR4SWF2?=
 =?utf-8?B?bDk5OHV4em5FODA1WXVwdUpHb2h2MWlmcHRSdkc1S1FDVDJJOHdKTDdNd3FZ?=
 =?utf-8?B?RW1mM2o3WDZzQXFLcXFTQUFTNGp5NXdBWjNWZHkrN3JZZ3Evbk14eGxPMEFJ?=
 =?utf-8?B?MWIrSm9OYzVETG5DZGN3cXkxS1lFT2g5MkluQzQ3MFhUREx3QWVlemFSZEoy?=
 =?utf-8?B?ZlA2a0w4UGliK0RTMnpvK3pqSmU4UVNwUnRvUXBvOWhKMCtCand2RWdMOWY3?=
 =?utf-8?B?Um9DSzBQTmRCWVM5VmFjM1JMclNXb2ZsT1NMTGE0YWxtY0tqNFh0RWtSc3lm?=
 =?utf-8?B?QWpudVFXMDB3alMwZ0RVMklaK1hRVndiVE9YYXM3OFZBMlhIMnAvN3orVTFh?=
 =?utf-8?B?S0NWb1lHVjFwYnZwYWJhYmI4L0REY3Y0elB3a3lBSEhRTE5wQkpHbVQ3d1dG?=
 =?utf-8?B?SzVCZ1hVY09sQmN2N2o4ZVIxQmE2RURVS0Q4eVRZQjZRdmdkQ21TUlhSeEcr?=
 =?utf-8?B?bU5YMS9Pb2k2K1BSd0hidmdjaTF6OS9VSnVzMjBHUnVjelF0bTRBSUNsYzht?=
 =?utf-8?B?SmFnUlJkanNiMDdtS0p0OUViaCtyQjdWeE96Zld3TG95eGVBcUgxZk1henpz?=
 =?utf-8?B?YTBCempnL1Q4TG5BZUUxdmlRM0FSaDlCQnVDMS9PbGpMM0NBY2dmakxURlJD?=
 =?utf-8?B?Y2dueG9XSnZOYnh0MlIza0wrOG5DbUE1U2RXZXNRMVg4bWZrbmR5QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d72800-916a-44b2-3701-08de5452b19c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:25:27.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXzjelcqtLfp4WrISZDbFLEaOC6LrLvvyKF0hCWQ5Lnd1ne1soyiEwcNyDhk5fHyff1ReZf8v1bA65WyorydRCY5pwjq8II9zIDlwh3yVCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10018
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 16:25:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18787

Hi Robert,

On 1/15/26 5:23 PM, Robert P. J. Day via lists.yoctoproject.org wrote:
> 
> Delete pesky underscore in :ref:`_ref-bbsetup-source-overrides`
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 

Fixes: ef807662f663 ("doc: document fixed revisions override in 
bitbake-setup manual")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

