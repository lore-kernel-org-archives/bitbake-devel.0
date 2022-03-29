Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEAC433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 13:13:10 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.89])
 by mx.groups.io with SMTP id smtpd.web11.6310.1648559589681950996
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 06:13:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=eU5y7Ksg;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.1.89,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVIxhqLo/1UBJ/4LRpDWcyDlbvcq4Z3dsv4H0J6W7gFrdDkIz3Txi+H3ciVirT1/h+cyTm4mzsj7c6q9OTlkhtzYZl5cdQKEknWJ7BhRkzPilJkj9NBpRg1lIRIN69wapI/eeyy1DDz8Ys1mhaB7WE3/ysJgPfCRqIzmIvEVPoT2rymv4hXS3yKNAnw0zH3tlIXJpXnDB93oeSFnyTU8XDpAl4jULOu7rzzAvaEbHHgx1vwca52eAPJWVnIqr0vQXMyfxUfyf+jsYKKt1m79VWDOS9F3bDljtu4Yj2fIevbeda52DqTZDkBnSX9jSwhfFyRzj91NDnNrJwyc5fI55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYA9bHc/km2Zl6zLH/xoHnVMXnnb3kek1gtqlNL1HQA=;
 b=A+koLyc51tIFCgdC3F3J3Ky1O/w9uqgE0SqeYoak53BG0p2ex6BtopWp21ML8XhH2C49k7TQD/yR+GrzlZUb1ct1bHDtMYOEmsADSw2llAHuBWGUhRUxvNGXS4MlqdZu9+zhI/x6dmbzVsDSoHDBJ9ED/qJUdLV9l5NWKDs8k9hfElxulWEL2/m93PyuBiEyPWYu9YPA7IFUpGZ/mH5N+nUs3itPFp/xw8Z9Ro7Xx/kd4HylR5OlOPUfqIqltVq7hM1t160HQFD2wfE4I4SkZkmEpHgBFyuwV82MX80FGu2LcOQ+GOXlJP+rfPiR/WBbBQQI5RqohisrVt/vxVMN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYA9bHc/km2Zl6zLH/xoHnVMXnnb3kek1gtqlNL1HQA=;
 b=eU5y7Ksg3TmMqrWZ9b4I4NefOGMWB2vo4daGe1svSs7jf6t/Sgye9UrbVQHH5mOchjMtUlkiRuV/NCKEEXZ26bcGiONr5uIZ4O/342tFPG6rsHglFCp0wvWipGRtGQu33cay60VoD9qa17+EMSk2bhLBIgzZU8pQgzExMizHTDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM4PR0401MB2227.eurprd04.prod.outlook.com (2603:10a6:200:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 13:13:05 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 13:13:05 +0000
Message-ID: <5205d592-db48-f554-5c64-221dbcb7b774@theobroma-systems.com>
Date: Tue, 29 Mar 2022 14:13:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [docs] [PATCH] bitbake-user-manual: punctuation fixes
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0255.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::26) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 094d7f53-dedd-437f-0ee8-08da1185dc4b
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2227:EE_
X-Microsoft-Antispam-PRVS: 
	<AM4PR0401MB2227272A524D0EC949671E07C21E9@AM4PR0401MB2227.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4QT3eMHHjNfhg+8jqKyOHpEwe9WyEw2v4Y3vWvrRqHNGl0GoaISuibvT5o+LZ2bGJCmTaUEeVcGr3i+0udVCfocaIPSGcB94QUYv11GhkhmrHvvCbkf70FBVpc6Lf+deSvHf+uJtclhHKgH3sjE3uTPQRfBk4wKz1BmklsWm/gLhc01RtdH5ApKcGng55phemp5yHLRXoHSchOuVnWKYyS4fNjw+4myvUtuNm+4owWnC3ztYJ78rPOBSUenwmq0uP18n5087tE3XNWuIfPDzJBIFlFatUPJ3VHMUi+nvsxLCjUG2nL9EVt94t4iUrT2vtQ4AIPIio1F2f962P2PZteO61gozxjFQYEzTJX1JOXrY5iyuru2eDo86ThaMrNkCMpeHwc3+gOmBZ1//qQw8FjNOTz+KFPOwFxjXwau3IiHXjRcMdrKGfa18/Hq1CAumQsuIhBDP9rZYLn7Prs5wZcWUq1kkeZK7CeJvJhqv+JBdK9U8BcMzpyAf/5FhzF7EDwqJ0ntxfKzshMLSBix/gQpe3OFYlUNcdZq+w8PkL89kkntvRzoe9zkl4IdsN6eD/W225/vjg4WSnqdiNiMVi/OfLUH+GbpTo4CEqaVbtFUJ0cWFJaZrrHbkgqh4gXVgaCppJMO4Ze9HoBEJAUhEo5gwM8Pkkb0kkSLmpiAyLFj685ISqFkPUD6CGkAN3N6L9qPqRM9NyJ2qlN6LOvO/vwzezHQWTvnqzlqgEJJx9E0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6506007)(508600001)(86362001)(66556008)(66946007)(31696002)(316002)(66476007)(8676002)(4326008)(6486002)(186003)(6512007)(53546011)(66574015)(38100700002)(2616005)(5660300002)(26005)(2906002)(4744005)(44832011)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXQxYXZFTzFQRnl4VTNGRmxoT3g3ZXJ5UnNsRi81Zzdobm4vdThwUVNCK1Fx?=
 =?utf-8?B?SFE3SmJJWVNiS2hyQUh1RGI1SXQrRzNsMm5ILzAxSktBWWluNzJwOGxYTGt6?=
 =?utf-8?B?UjFRWHc1TVBtUUxNYjMydFNXSmdLNlk3cjIvOUQrckM2bjZRa2tUWDRwNHc4?=
 =?utf-8?B?MkZ6bG1aSnRIUUYwbEdyNHgyM3lRSGNBeFhWZFZXc2x6YVE4L1RmSTNYS2I4?=
 =?utf-8?B?YWJ4d00wN1RFa2N6YkoxYmJMMlVzTHpYVFEraFhabWtpaURyRlRhUHpIcDk3?=
 =?utf-8?B?TUx5S3JrcnFuUzVzSVlZOXNVRUdTY0xPb2liRVZCYkRObVBqSjVVVGpGU0dS?=
 =?utf-8?B?bCt6Yko3K2draEs3eE5mbFNna1lpMkVtL2lzeVgyWVBlcmc2bURra3htaTNC?=
 =?utf-8?B?bEJPV2krRU9YNjE3VHdDVTZWWkMwWUhFQll0UXlWTU5xK2dPTnkxUVJMUHBX?=
 =?utf-8?B?czBPUHNGQTgwSnYzVHpwSEROaXlpQ2QyUmRkeVYyVHkzVnlEOGtiTjljeGFF?=
 =?utf-8?B?MUtjRXZJR2FjYmdaaFhPZS9hQUNtTG4zSW9zVHA5Y0dsc0hMRHdId1ROdW9Y?=
 =?utf-8?B?YVhwTkJJUFNha0JJQlBES3lSakVLNGkxRlRJSnhnR0JUTlNIbUZ2aEk4UC95?=
 =?utf-8?B?RkdpVnFlU1ZlZElWa1c4WWJwRHoxYUJUQnJxbzAwaXpnODFNQjdvenNvUFVl?=
 =?utf-8?B?aVZJUnF0RlpnY2tNcXRaYkhOejNuZ3QwNnFocXJYSGROb1F1OUhkblk1ZVYv?=
 =?utf-8?B?UTFWaStQdWxlQ0VEbG8vR2VpNnd1eHBGUnREd1kzem0rZkJhZFhJQUFuQVNW?=
 =?utf-8?B?TmZWZjd2cmpvWjNhNDJZU1E1TFBGdTNkZVYzUUVEMWV0bUNIb1B2NDh2MVJI?=
 =?utf-8?B?V01ldHZiRTIybGtWU0d5dWQ0VVdQTDkvVk1RQUFwQ3lRWnMwajUzZlUvT0pi?=
 =?utf-8?B?eFlLU3p0U2NGYUxVeGZta1JBV29QMDM4NWpEblJSZHliOHhKalc2d1V6NFRC?=
 =?utf-8?B?ZmFCdGo2Y2t3blIzZnhqdmtEL2ZBN1RwK29YcmlrcGdEb2ZCV28xcUx3RXI0?=
 =?utf-8?B?a0dXQ09oKzJYNXpqZ1lLcTc4aTUwa0R3TXNHK2txUUsrUTZPcWZHanRyT01E?=
 =?utf-8?B?bnFLVHphcXlHRnozdU9rdUxEZkpVU01zRG9TN2J0QkRNVEJjVjEvUnhjRE1Y?=
 =?utf-8?B?OFVISW5XQ1pxY1VoQUxGb3FuRDR3endoVExNaG5tRG5IQmc4aU9xNlc1bGl5?=
 =?utf-8?B?M2h3ZldqVFI5eTlRSytEYnVSVVVkbVBaZkZSMHlreXpadGp0NmRubGlvdWRW?=
 =?utf-8?B?VEpidm5kb1NMc3NOUTJ6akVxTng5KzZKOHI2WnJzeHdVakRsdkEwK2xINnpB?=
 =?utf-8?B?c2FLZExzK1hkWlZiZWJSQ2FxdVRkdzNhampUQjB5aytpNmxUbFV4UjRkSEdG?=
 =?utf-8?B?ZlhWalQxc1RhUDV3cXp3UWFFQ0o0WFBkVkkrRktpcWVrWXlXYnNOTUNTRmxr?=
 =?utf-8?B?cGNZeDZoSjBrWTZGUXl5aHVObHorazk5cWdmYWZQYndISVNBQXRtOXlTREh1?=
 =?utf-8?B?cWtCQld0Nlh5WHlEaG9wR0tpRFc0bTRUUW1uRHJpazJIblZOekNDZ2ZOMVNH?=
 =?utf-8?B?ZGxhSE1TcmFJQ1RyblMyMm1GOW5URkpXU3lYdjkxejZOY1dyaEExZ2ljTndv?=
 =?utf-8?B?NHZOUWJlcTcwQXQ3V1RBaitvS2VJaUx5MmtjV3grR0Z0OWYxNjRXMjNVdjkx?=
 =?utf-8?B?OThPVE52cEtTM2txMjBIRHpoSnlhbFpNSGdFaTVGeExvVEhlQTFtallXTGZM?=
 =?utf-8?B?YUhPZC9OUHFVYzY4V2VYemo2cWNtN3pmT1RaWjl6TktsWkVuejZtNW4wd0Y0?=
 =?utf-8?B?Y2N6d1ZBK003R1lJNlVRN05icDJTQjdyMWpnQllWVFhTT3BaRGVBNDJnMmNI?=
 =?utf-8?B?ZU5oOVJkOGFJbEpFZTFpZWRESjJXU3ErazRTNXVkYUhNVldrNi9sbldWK2xx?=
 =?utf-8?B?NmtuY0p3YXMybU9GaVBKL0NSTnBEUlYvV2Y1eHVWekpBU1pSdmNyeGVvUDcx?=
 =?utf-8?B?ZW5iYXZZZUh1Si9nREk5c2dZWEMyTmVHeVFZWnd0NWhnYXdLQTkxYXI4dFJz?=
 =?utf-8?B?dFFJcGd3ZFZHUVpScFpMRko5OEo1aWU5ekQrTHg1dklQVnZXTzdtdGFkUDNv?=
 =?utf-8?B?bDVHbXY4elFTd1QwZ2l3NlN0OFlncUt6ekxsT1NNTTl1cjhSTjNoTUUycHA5?=
 =?utf-8?B?MlF1U1hmVVVsUkU5V3VCWWtsM2k5L3lRUXVDUjNQUko2NU44WFl4VkpScEFF?=
 =?utf-8?B?Z096ak1pcUN3cCtpbkU2MDZsTDJtMU4waXJyeGtwbnA2QmFCVlpoYkNYdlRI?=
 =?utf-8?Q?aQh4+ifbEcJD42GBcaoAnFEIRmqU0/3HQQgm2?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 094d7f53-dedd-437f-0ee8-08da1185dc4b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 13:13:05.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 0ENdXcXbLnV33Sfug2LRjUJTDtmnH5Hlae4jNswolFIcbjxpOY0dupEh0vALPMOKhaqTAnC141eUE99su9212O021RBitMot20Lqy4Ew/Zx+gNx/FPjNeuWYicX8iViq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2227
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 13:13:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13538

Hi Michael,

On 3/29/22 14:07, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> - Replace hyphens by em dashes when necessary

I seem to recall we ultimately decided to not go for em dashes because 
it wouldn't be matched by a search in the browser or in the sources?

Cheers,
Quentin

