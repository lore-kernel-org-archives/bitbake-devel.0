Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E3C55172
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 10:37:41 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13569.1785839857080706241
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2026 03:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=daZ0KGhx;
 spf=pass (domain: est.tech, ip: 52.101.72.5, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtY9YgGPtbpmE+BkSWjfPcRKBQrmbb88acAjSHRJL/hnXDLVDIdiyQIrMx7lxP8e/QbnCj5RSr/FYzm/f883ys4eI455HwJI7ybLS0WIcEeLjhazhp9YdE5hsfrFLlyYm+luNPA+mLF5i0bmdr+6MA0KfNOTJUjyP34Xmuya7HvoP4hwSvVss9c/NMkWnvKlH9gnI3c7rpM94/SgnJwloeTH1+t95TpAqjm4zdCUiisvAjRjOSO7PVVWR/EGgUEC7KjGLxrHghb+NO5FSbACSdBuBJV0lHOowuNWXFTqmZhfjr/SBJ+lvqsnzC17dUaAi1IdiBVwEXH1/eQelzjRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtAXPtUDPniaFqam+BqSDV1kw5rTZJutqhXBRxhCx0U=;
 b=QADpeNSwwUslZ82IjdA8+3pltWPAcgA+yzedo7CCF9cAvMZLQlSqdj90ROD+igWlrIYZ0wkA0jwhuLCtzDn0293vq7uwThjy2tYh9bqcLND3aCckT+HdBi98NgAUgv8RlXgthUPV2SEPkPiDK/Gy45ICgg7QGLOJfprxjLr5OjpG2L2x+154rHC7VA5nmcHyD3XfsuTm+CXYcdmPIHz7e9ec3SPMHYBYMM/rKArYHmFUHOylKprvuGnW76MF0K4Vqd9YNv4TXBfjLTTcD9hcq8etmh/YLcSRSN5O9Cx9NNx0gRSKiAj48M4DgnywvzB2DTQUAgx69jUsKwDcvqd22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtAXPtUDPniaFqam+BqSDV1kw5rTZJutqhXBRxhCx0U=;
 b=daZ0KGhxTgWD7iI/OGY4b40q3cYsuPLetJkgrLwtJ2f4YdOAF08Iu6C2gXZsMM24WIO/16ztMXiMqKwf6tqKoK/iiJSItvFr6/eusI6YEMbgKC26fPpup8hhGcQGkamTM/U3JXKvrLbyvKeCFkTl+VOL+7WJal93fEuqh3JSHQ3chiLbR/AVCUfvWfu8D65/FqBUXjbYqXPybcI0PHMF1ktuIgtGZKoesCyxsIb/2PC9eLJZy/yTC1EKKsIyIBf5NPz9ilUN9U5D0Seqhy4/p3PSOu26eDsKJ0K4w02SXzryot8wZxhP1d/tQu3V0u8ZOtfQ30YWjEE1vGX9VdXUPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by FRWP189MB3127.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:19d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 10:37:31 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85%7]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 10:37:31 +0000
Message-ID: <9a3bc50b-89a8-439c-aa44-1b2707a88ca4@est.tech>
Date: Tue, 4 Aug 2026 12:37:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] parse: warn on trailing whitespace after
 line continuation backslash
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
 <056c55ee98f7d48caa6bf45152cd63115b9d3132.camel@linuxfoundation.org>
Content-Language: en-US
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
In-Reply-To: <056c55ee98f7d48caa6bf45152cd63115b9d3132.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|FRWP189MB3127:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cf9235-4631-4db5-b912-08def2146363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	s5hNhKLTN+XUATUSZqWlQzclca6i11L0i0Qd+Oy60os7emvOGzPEf+jE9YsxA9Mu7AXNScFQqka9TakMKbeCQVAagc+N4eOhrfEEqSY2Hj180akxijDCiRBU/21qrTIlaTiMRC3qoe8D5erIHTj5M8t/hayMWp8rFN35wObPxXDAMrnSli++n7D7mUcH3qVrX3SpwYpXOl8plGQevNaaYag0E6KoxKzkX2EE3k++XgGmnP9mEGmt49dLUBzac2C+BrUrGG38yHsZ8sY7OiAvRR9d4GqNSxhZgiUlkJ3co/dRBYdnreoc+ZxYDauXuMh4Ro3UZl2dNdCIeopY0/Uw2JRw1YW2IDvYaThZJUGx5c812eCsXSiBVhpdnYEHnLz4SS61ym8jbkDZ3TN/6WTwfhc0FLPfGur9lVgdbyg+7lhegcm2MYw/ZtuTWovUgDS6T6Uy23de/RVUE8tTkGk8sogkvrnvhoMhl6cA9T71Q0QkgVmpaAXxTbYtHBiuUokkjDKkoAudHd7C1mtltk+EHFxXdxY661+hWi4qmDjN6AM328UOrEXmLeG3fx35vAFs7J8SeVPx/E3z5U/8Bps47aiDlQI3Gh2pnh5A5k5R0xQDCtby2zN2Fe9cJWmlXv22BkYquxPIMvsBUesWBxCZ/TlE8aWOP1rxCz9Bn2qWBrQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c1YjgGoFhI+f7CAKfh6+ofU7qXF4xwwMSMPOnzCh6FEAo1qT0Zvu7AY3+DHB?=
 =?us-ascii?Q?9StgDgWRAK554RijgzQf1ejzkcRMdunzKBvQg2Ic+eJSFYJa7nz3dSpeaBp/?=
 =?us-ascii?Q?2C0CpLVmPfUS11iqU5i0bftqqiOirujAp7PeEPoRAE/wmnMZzsQohiGeLO5U?=
 =?us-ascii?Q?gOUxt48Ztn6qExLvqC/c+n+NNi2ksFp4PHL1kltBfo/JSzb5vit4gd/p0bUK?=
 =?us-ascii?Q?V/AgeIsx82vKpy/p09FkmyeDgW4Jdj+G6rTDEM1d3ET4XAz0pUtiDT+dJgOy?=
 =?us-ascii?Q?zDmXQ9BKXFQTNwOtCvM9+paDzAQQNRtfqCN6IWGisZZzqeH0QkaoppN2rGRo?=
 =?us-ascii?Q?iDB04Q73tMJJFAbDHbOQlWheMnwzhKmb/kW2jfx08Nxl6AjgGqq5bFf+VgLE?=
 =?us-ascii?Q?6L6OdksLAzqil947UUi6+eIye9IFiDDZgRMrt0V69M5qAdhLljwRt+IfARi1?=
 =?us-ascii?Q?RW/V/NEHRP1lN0xwxTzuBy/0duID43wgGhKIw/2pG1BJqB8RblxUF4e0hGnP?=
 =?us-ascii?Q?X2oYWh+MXUtgYoIio15Y3/XnVEcGbhVrMmPJYKn1iTdgD5JGs78y47jt6MxH?=
 =?us-ascii?Q?aADBKlOYx5MV1elrUmwRUtNc0iCCO88sAL1Uasu38n1BPuzOyvUEd2BGeUtU?=
 =?us-ascii?Q?ZE8Z/o2xGFF536ALHU9Ln7uB/cfWe+mukItoRLqFtEA8xJBAA7u5sytJ0isF?=
 =?us-ascii?Q?HmoNZCKfidWSbiiQjMPzG10tbqYbZTVxQwQyBozCZO6xFwCPPENPsFhX+Oi7?=
 =?us-ascii?Q?saZVzcP2wqr5fd/TIguVXafvUX8OExCyy2TyfPvambBt7KhxrM0v2vRlUijZ?=
 =?us-ascii?Q?Je6sQfIvpQ4BiXxoiQVEjICRKjvj4tclx8mfdBmX/0DQaIrfA8yqX1NI2jZR?=
 =?us-ascii?Q?eWgVm8/ix7IPY4IGa6frj+DCUuq/zyaR9GQraUbxGXT5VvC9pMt4JyD7mW96?=
 =?us-ascii?Q?QkBcWFPeDtoEkXiO1iw7QIOg4WBmjazjFrH0q8Jspa6mcKRatl3ITOiQAd/a?=
 =?us-ascii?Q?sVALgNCcDZQJwkCHOYHLEKnb3U+D15Al1yA/2pdv24eqgca+ieGFFartQ4kj?=
 =?us-ascii?Q?5E6Fftwm6VyFi9LL8a4cGBvl2fwyOfkpgZIafhpu013h8araYy0kQ/bElQsQ?=
 =?us-ascii?Q?uB/U9g7+o1+Izh5khsLL9adLVeDTMS/fLo6OYOODmSGe7E0s0SYVIFnRtCEj?=
 =?us-ascii?Q?IcOUUrB3Dr7XRIznLqn7ulhpyVAw2VnlRv/vLRyZ1bsaJTnU2XE5Lv8LZQEr?=
 =?us-ascii?Q?+tflR1RGzWt+EzJnOvp7+DXvDMOVTbz5XQZ2Ioi3+3Fzxm2LJD9mY6Mdqjnp?=
 =?us-ascii?Q?f/ivKVKb++I7jt6bjutpCjEgW/TgArmsf4dsQ/qAGXMqIr2cCrtWXadf4pSd?=
 =?us-ascii?Q?AXKk3IS0lUeQMP6Emsgg4xR3Ph2/fBLd7leYbWsTTtwEg0xjqDwKwxINJ+xw?=
 =?us-ascii?Q?gBub9jHRcSRuFPE+iNXUtPkCcI5i9+RK3jRM+gYAVkrCOkFmK/X0z0p77vA2?=
 =?us-ascii?Q?Cg1mxUdxC9WXBv5Bn14qvnm5+CXp8OdNZBviK2fKPAbIEKQEmGp60pGdJ4JV?=
 =?us-ascii?Q?UeuLjBchav5xTMEiCEOKdol4WsJXMpFNWErxePwVLn82kMt9uWw3sDWWf2j1?=
 =?us-ascii?Q?TYSTpgLwoATc5AxVU97SQiPdv9ravLbO9ij575SBoFdF5eg3iuiP1iHpRuDw?=
 =?us-ascii?Q?MO3bqQfpwmmVmYf+EzXNVek5gUSdtWTL/EbGFv39T9K7H/OmtlEbScPJBMqF?=
 =?us-ascii?Q?7RqCdUokV12WbzCLr2mUUa3N3sxETeQ=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cf9235-4631-4db5-b912-08def2146363
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 10:37:31.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHGB8549MmKo2FvT4gxv6WInn8qwoPvaxJVhPMTlMaQsj3oNPGwTjwWaTY/G3/ptZwztR3Oa3Ead8shKLFqXEtlmEFWgYFtIAw1SnS57uXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP189MB3127
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 10:37:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19899


On 2026-08-04 12:27, Richard Purdie wrote:
> On Tue, 2026-08-04 at 11:08 +0200, Jaipaul Cheernam via lists.openembedde=
d.org wrote:
>> rstrip() is called before checking for backslash, so trailing spaces or
>> tabs after "\" go unnoticed. For example:
>>
>>  =C2=A0=C2=A0=C2=A0 file://foo.patch=C2=A0\<TAB>
>>  =C2=A0=C2=A0=C2=A0 file://bar.patch=C2=A0\
>>
>> The first line has a trailing tab after the backslash that is invisible
>> but ends up in patch context, causing patches to fail to apply on trees
>> where it was cleaned up.
>>
>> Emit a warning when this is detected so developers can fix it early.
>>
>> Tested with bitbake-selftest:
>>  =C2=A0 $ python3 -m unittest lib.bb.tests.parse.ParseTest.test_parse_tr=
ailing_whitespace_continuation -v
>>  =C2=A0 $ python3 -m unittest lib.bb.tests.parse.ParseTest.test_parse_cl=
ean_continuation_no_warning -v
>>
>>  =C2=A0 2 tests OK
>>
>> Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
>> ---
>> Problem:
>> Ran into this while submitting libssh2 CVE patches to both master and
>> wrynose. The libssh2_1.11.1.bb on master has a stray tab after the
>> backslash on the CVE-2025-15661-3.patch line. Patches adding new file://
>> lines below it applied fine on master but git-am refused them on wrynose
>> because that branch doesn't have the trailing tab =E2=80=94 context mism=
atch.
> This seems like a lot of code and complexity for what is in reality quite=
 a minor issue which
> whilst annoying, doesn't actually break anything?
>
> Cheers,
>
> Richard


 =C2=A0Hi Richard,

 =C2=A0 Fair point =E2=80=94 it doesn't break parsing itself and the code c=
hurn is=20
larger than ideal for a warning.

 =C2=A0 Would you prefer if I just submitted the oe-core fixes to clean up=
=20
the affected recipes instead and dropped this bitbake change? That=20
solves the immediate problem without adding complexity to the parser.

 =C2=A0 Alternatively, I could reduce this to a bb.note() (debug-level) so=
=20
it's only visible with -v, keeping it minimal.

 =C2=A0 Happy to go either way.

Thanks



