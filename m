Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F3C4708E
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 14:33:54 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.50])
 by mx.groups.io with SMTP id smtpd.web11.36237.1672670024559621323
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jan 2023 06:33:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=TsXGVFmp;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.50, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOrvQs19YD+xM/bCRh984R2A2buEeHD+l+xLb/N5kK6ttAKW7paAw6ttvhdk/EfgXOZtf8Sqy13S9SNUsQC2OL9cAt1ba9D9aBVt2bUXASj7gL8AB+dlyE/FAYHKUJu1OYwjizgZyPd0qrn1Iw4D3HlWH7ZNJq0QdrjQxivFs5q+Wxf3LlojgtjWI11CObXvT3GDX8SOjL+yxPagthL2pvfDCq0ABSzsy213Afq6Vn2qWv+y4B9tQU1JWUSUSWHCCxpuctJog0Swyz+2w9saNWh7hwjayB3yWsmHMz1J5qSt5pdDdW/WXPgi3zTQKj9iZGBtXbcQDrRfAj9Hd6W0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiG4KvDykBlI2rPo7BATiGv95nMTo0ZgjRp2nOw/c6k=;
 b=ORpOb8PnEydYPGJjgQbIixJA8vSp8HMyd0DUINEUPPIWtDAbKCxwRWNqmq9HXmJ6VFmClnt4+OCeenQPPwaqGxWIBjNGOAw8F0AhtU8zdqZXxEfrmPYX3ENMJwkVjWf2mdbWLdKWKMRTTj3mXB/fp1qX3fnqITqxYc1Bj5dOQtSgoJw3gmulanKAdN8b+s/4GjJFCpd+Zy+C/oANiezYJ2ayJXzw0bxb9eHhjEBJyvikuxs03mgsCNTFiT/ooU92GgMjlYUv1Nbv3gw4QJsSzTQ7FYtUwQxelOPB+CXzw0kSechukseHfAwE7rx0iMK5tyvr2EJ7BtzdhkxzdlfevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiG4KvDykBlI2rPo7BATiGv95nMTo0ZgjRp2nOw/c6k=;
 b=TsXGVFmpMeeqBf2ShGO+ypTRctET+nawCPiH7WM9ziBJsGttYGX5HQoHH6PWbY962Ci04x4LBeikzceicTyzmvYF6WtYzCsg9ISOF/wbPWxdemq+hkqqUdE6lNtgXtaNmNQ/ZlrWQ8D5x0783FQAZgIn9t24Au/cmUTvOVqr1H3urrrd4Mw80edDZcQwFBJQdN34RA8q19wLSNT5tT8ViKpAc4jKdbfwYFsm6yGJ4KO7tdENfbNQtOKnUY4qwHEXOqiD0vDHB91sWKOVjLIrmFGiG/hb8blWLNck2SdmRwgLLO+2Ybqlzb8IWN5lxPLjkoz0sDT15JLuq/iXoe3Zow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 14:33:41 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:33:41 +0000
Message-ID: <0589dcb1-d55d-8ec8-035a-633ce59bd11f@theobroma-systems.com>
Date: Mon, 2 Jan 2023 15:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-layers: fix a typo
Content-Language: en-US
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
 bitbake-devel@lists.openembedded.org
Cc: alex@linutronix.de, richard.purdie@linuxfoundation.org
References: <20230102142339.37005-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230102142339.37005-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::17) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: c389275d-1dfd-4443-7319-08daecce57d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SNQ9E9kiH03GFp3pzqLIcGPaofld9sb2ZIw9xYySkXgQuv9I131WviqRQjiqCyp4giTkI5fk9pCi5frx5x4UOAe5HToVHiV6cDIRvlqqok6zaNOyxfBkWZd6yszeqg27zL4T+9tbzKGscI8ypLk0fzzzO0L92nNtHwatJut/2HLq6hNd6qc33YEfN+a04iWgVHKwn2Jqh4wmqv7mjktS6C4au25xio5PGY3e3/TqshKo04Ahs7HpQnczp5ZHS+HPRc5kaM+MDJqROgB6rcs3UlI1qzeg47TKvoDJF2PFu8U1rdYlWHXkp89hOMPJXjZ8V+WRtCyBRJMX3Nnoq1m2q/dTg1iuNAsFSBKIa/vtDPXj5Cu6WpqnU+90da93wFDsERPAhJXoWjGsoW356oV02S1kefN8a9DUwHBHI7ZSej23WWdMcF6QCo6c7ZUStCXIX+Hwhkodh73OTVGzlORVMINuQK1zrGMCJ7u5dujPZX7RIi2Mse3Cxh55IE2D6STdMMXjmuxo+g40TdpAXJUllKihXGhhlySTSsIXbjT5kgI0da4VFvyszsKsdkvS2Z+Alc2+vTF5QQLjifthDrvSwUeE1H16wLI6xZUJSYwcIXYpCg9/9zSHQJrmnlhQyucJowJ3bKGeTLmKILEEFIQG+D/nefvFRinReHxv3ULIc0Kt4bxS345a/xCSipsJlZ5bIJB5U/VVdCb8ivv2Oye6ic1TfvCgnjKwB6UdXEleh/NP85WgO8E6NPjoE8CpLIdT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(451199015)(6512007)(53546011)(6506007)(6666004)(86362001)(558084003)(31696002)(36756003)(38100700002)(2616005)(186003)(8676002)(41300700001)(4326008)(2906002)(5660300002)(44832011)(8936002)(6486002)(66556008)(31686004)(478600001)(66946007)(66476007)(316002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXVZc1M1eUxoc0ZSd3NzejhIeE01Ni9aK2pwc0cxVFVTQXpCditCeW1PMm1K?=
 =?utf-8?B?cnM5azJicU1TTHUwaDNHQ2YwYlN6dWpsYitIK3lLb2wrd05vaGdCMVRiZ0Vk?=
 =?utf-8?B?Mkdzci8xcE4wcVlicjNLa3NOZlcrZkxtQ3lZTU5PRkJlbkp4ODEvZitBYzhz?=
 =?utf-8?B?bXpTMHg0RUZUQVRaMFBDbzArWlVOUmpMc1ZoQm9tSUpzUmovTGFYOGRicWQ3?=
 =?utf-8?B?S1dSQ2pkL0I3cG43RGk3cUZSbDJWR0wveG8yK1VtK0NHUWRzUWhMcVhSTnRm?=
 =?utf-8?B?NWtDaVpzZW81K3NvS2dsdXgzSWJadUp2dGZnMlI2V083NXpUSEFtZ2JYdS9v?=
 =?utf-8?B?ejhKL0F3RnMyYW9KUTNxS3Zib1pPNnZ2YkU0OFViTVA0aTZwbEJxalhHbUlC?=
 =?utf-8?B?S0pWVFlaTTJLbmNONjlOUUZnLy9yWVhJZDBvMGJ4WGdBNG5QQUFtYzUyd2xS?=
 =?utf-8?B?aVY4OE5pbHNkc2wzYUtPQTlIdU9ld1BncG5DUmpVMkVkRjhrOGZWSFRrR2Rr?=
 =?utf-8?B?SHJGWmN6ZnErWW0vMDRzNWN5MDhmVUdaK082cUszZWk1MVBhc3c0N014Y2R6?=
 =?utf-8?B?TDJEUDYxMW91RCtRSkZ1NnFadXUzZjQzS2xrdTlPY2RqV2pyZ1NoczJSb3Vq?=
 =?utf-8?B?SjU1TXZOb2N6SGtJVWcyb094K0tmWEp3d0F4b1lYbUpqOVZKYXhmM3hPQW9N?=
 =?utf-8?B?VXJQQlZXdTk0WFZoWHdjcW1sbWpPRDNoV0pYOHZtc1dEUDlzZEFWQlhwZzZQ?=
 =?utf-8?B?V2xuVEo4QzJCenB4aFVNQ2c4dGlvTGF4UVJEU2phNmNGUzlqajR0akNQSDBj?=
 =?utf-8?B?L1BKN0pFbkJ4YW9IcG5LTlJUK3FuOUtkbW1RMTJNcGMwUTZvbjJkTEVOZzFl?=
 =?utf-8?B?eE1zWEJjdDRuWTgxbHpvSER1WnpHS2s3aXVlVHFGSG5qVG5tUyt1WTZWQU1u?=
 =?utf-8?B?RXo0OG5reUdpMlJnZkR2SCs5cmtmQTV5ZzF2NE5ibVI4Wkcwb0NkdStSU3FS?=
 =?utf-8?B?bWtwVmIyZWg5UUpEUW9tc3lBekxJMHE1ZlRGRzJxRmF5RGJiZDI1eFptZnd2?=
 =?utf-8?B?bGlFcmU1citQck5CRks4SGNjNTlPanpnQlpVdm9uYkkxSjFJM3ZCbEZETDVq?=
 =?utf-8?B?OGdsUWxqeEppcDZHVjBTN3F4OHRabWNKY0w0N2d6VjJTRVN1K2gvc0RTMGgz?=
 =?utf-8?B?ank5YmNINTVSeWlPME5RTE14UDJRRmNTRFFXWVVtV1g3MytUdTE0aGFFb2hL?=
 =?utf-8?B?L3dweGdVa2s5UE9mem5OdEVnNkR0ZWFaQmdrRlJkWjA2eVVaT3hRdUZzc3A0?=
 =?utf-8?B?aEtkNUJGUkNVWkR1bEFCMVZ0T201UERTZVRvSmdVcDFtSDJGZFJVS2V4dnE5?=
 =?utf-8?B?WHhZVFF4dyswWlBmTmVjUFk2cW5kQWczTmNHejFyc0RIWW9QT3djMEVjQ08x?=
 =?utf-8?B?dHJCVlBseWlvM1BhWGxsOVhGK0NnbzVRd3VEVTZIaUh3M2hIWmhsMHNvS01K?=
 =?utf-8?B?Tm4vY0huMVphZThYeWNkaHQ3Z2MyczJwdWQxYWhDMWh4dys0QS81SE5xTnNT?=
 =?utf-8?B?U2tPdnVnWUlsaVBBYjJYUUhMZVBkME1QR3Q0U0l4Z1V2MjFRQ0o2bHlhZlpM?=
 =?utf-8?B?MmlMUW5nSjdVRXdCK3V5Nk9YQ0F0emk0OWEvTEpnc0tnZ3lkdXZPbHQvMkdV?=
 =?utf-8?B?eGRRZE1zTmw0aUNCVDVQdmJFcDJtZTE0RWQ3OGVqT0grUE1LcEUxVzhSTGFx?=
 =?utf-8?B?eWRBcFM3VDRKcW1MalpDNnc3QmVMUVBNZnExZUlmU3JySnJ0N1lTZDljdnFi?=
 =?utf-8?B?REJCb0MxZjI3SzBxaXhPdnFoa0RqQTIyQ3p2SlFycC8rME1uZUpoaHhHMlBx?=
 =?utf-8?B?ZHFuMDNVdUtvL3hNR09YZE5iK0tPaEplVDArSGxGK054UVZsbHRnUEp6TzBm?=
 =?utf-8?B?NlJFZW9LN2dQVXFZMzRrZGNsN0tPRHVxeC9NdGxDa0N1Q2Vyby9teFBhOGJn?=
 =?utf-8?B?YURscU1JNVp0N2gzb3hGR0lJQXNsQmJsZUhPd2hXSWNkenF6bTNzc1dYYTJY?=
 =?utf-8?B?UVdrSitPQUEvc0RVUUN1a0EzK0lFdHhjbnFQOXhiTHZKUEd0QW5BNnd1dVND?=
 =?utf-8?B?UVdGalg2SGtCNjNzajBDMGIyRFVubGY4MWNwSTBteXZQUDQvTDZvUzFzS3U5?=
 =?utf-8?B?SE5adndIcGtIQzllSFMrejJ1aGFZeWxGWnFubytUNDJCNXpwTUkwNlF0SUw2?=
 =?utf-8?B?aW9OYWVwSlUyRzVPa1NWb0twT1FnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c389275d-1dfd-4443-7319-08daecce57d0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 14:33:40.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhpBBVq++jwT/wjb6yeqL6qiSP5Azzf4EFrH9YsOXupca0zIqrV+3F7Ue073Lqf8RfMqkOniRvB7zvyZcNFCRKwvW6Ad5euDOZwnMPsgaEigQPa5M5Bq5E9ZnAmI8lRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 14:33:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14279

Hi Enguerrand,

On 1/2/23 15:23, Enguerrand de Ribaucourt wrote:
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks,
Quentin

