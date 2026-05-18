Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A970CD4F3C
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 10:28:37 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5584.1779100112079819571
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 03:28:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EMAytTTI;
 spf=pass (domain: cherry.de, ip: 52.101.70.47, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1DyWB6Qc9+E42QoFe1JVLl+q3V/Ku/CBWD6RhkwtKBzItWNa3EAzZS4E3TaI2BWbyEInUGALPszyWzp9AMaivmVsWwbPXRTEhZrjTWpT5ijNXYeFdRVG/grv2BDnJsNUW4i9bCieW/239B56bWN3ZUjAaH7ipneKAemAsWerM1vt5kH7zH7joYx3lmgpyWui9FpdmgWd1ALTwpvpsGgVIMiWLxid4dGJxe4Oh6ZvFhOqO8Gs3nA4Uf60dIjmIienQEZCMSeLIQ5OlrwmlIdjOq7GvmZkcDl3ERCXqL+lx5ug5bZoFfv2orIh5NK1xx5u/De1tLns8/6TP406AESBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtUuinG4r6YjcK2YCLdhrPBEF2EOP7MUzRnlOboQNQs=;
 b=m6kH/xXJLI7kLTjF9Jxn8ngDR0YHm8J7lVNErJe4ddDy37g34WPDN7hOF+KGzU1fsYvD3oH9rZ5+tB2tPbzjp4ehcp/qXoGkRPyHy6TQxTiO99SJF7HKL6Tk/OnN2aBakEqQhqsfZmf+w9IOCwMmm8yFrKk1aEAThEU4neZgfjo5YJ3FBrNp7iEdzw5/xyAQZt02KAnjnHfgoCzaXxS+eHop+w8SYRg9kKMoeJErPJOcwnPAL7cLbT0LHb+NfewMXWWSersZFCuaDnk8IwNUrGv5OP7rmJVTgPIGgmRdd3gFTOiTm+uPyta83/YsfUg//RtkUy6EjHSyQF6JH31piA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtUuinG4r6YjcK2YCLdhrPBEF2EOP7MUzRnlOboQNQs=;
 b=EMAytTTIGyVIWvUMOhrfkmf9b0VeJZ7uSnCGgCvn+CMdIQ3FA/pHBdvyiyzFVDashShvzCthgxCL2aHiJf25u5wIRFfhhgI7HN73e7VV2jtcz0qtfl4tnf0z3KxB/oRklt1bQ9b79t4KGK+K3hHiHowxap7m0fLlZp/eWqb7UFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:28:24 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 10:28:24 +0000
Message-ID: <b3f4a0e2-7ea1-49c4-9825-377b94e3b788@cherry.de>
Date: Mon, 18 May 2026 12:28:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] prserv/Dockerfile: Update to Alpine 3.23
To: paul@pbarker.dev, bitbake-devel@lists.openembedded.org
References: <20260518-prserv-v1-1-9625c3239954@pbarker.dev>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260518-prserv-v1-1-9625c3239954@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: e305cb56-9c0f-4fb9-f613-08deb4c8311f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	ZQowkipro0/PdQwwTcIF5g3oNZFmelgqK7yk9f7LKO6Uivk7iPJ/ziwb5ItpCVonqgXQojvJCCqnKhGW6UpnUFdKFLePygqVhodP0eN/IV5v7+K6OEu7ZklowciBpPkjTDNRHWnZA5PKfz71+NBIV8aQSvR1V85Ox8mN13nnoXpOfXkNSoPutik9u9ZGp7W6hB7gEaVNvA4BJ3FGYmjwYAdw6E21xTyCAzJnPXlCLytBsr5clfoHL0OAOr6lF1eywAy3T06aoru7k6YlIGk4rR11B1BqxuK+8rtIY6/xemxCN7/BD5i7A0BCs85qBjK2jPhKF8Pp1m+tgCuuH1ZF9iahoHBkzklE2+cyjhXvcRPvb1KAn40W9ajdVAz3RN+AfaLm0IZkv6BYBWjV6icOo54RUO0+o9b/aqTqJc1PhU+NIrEKG1ZimxSt0U2Vn1KR1k9n6IDs9+YfSfebsF0ZtmWhiVXJCq4MiYK0Y0QUO0JlvTOexd9DWtRTwYh5e3I4Lmr6M7CDZGeZPNUCLU5qiRNtQ0XNMLTzMjTBznguv2VsEE0shFG78rGa+f3nI9Nh+Um21/IOfozYbPCjrbHTFuUD+zFqCNEKYgc9flon738D/6z/Jk9X9l+JQ74XnmDwNstvOZKujuvgRTRX/77vdCzkxTjaYZOn/7Sz19plbAFg4eh0RXMp4NlsZ3Kt/cbA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEFLV1Zrc2orbmlYMm1rbUROeU1HSHVyWk5rRFg2czQ3dWNRelpJYUZxZWZj?=
 =?utf-8?B?YjhMa1U5V2c4c0lvK3hzK21ueTkzMU1NaHVlM1o0bW8xdkpSa2tpajRqZG5o?=
 =?utf-8?B?dEE3dFgzMDRjbGFQc3RPU1dkQksydk9VMDlUYkxyVW9IWjJFTzJDc3JBcENW?=
 =?utf-8?B?NWd4K0hFWkVpWk9mejhIaFVMeVkzNVhodFcrUVk4UU9GRnBweUpEVzNsL3I2?=
 =?utf-8?B?UlVRWXNZaFVpQm9qdjFDbTZnajBBbWRQMEUvYnEzWCtVU2pWKzVYMng3YVFv?=
 =?utf-8?B?UHRldENCRnA4alNFcXRxcXBmMGJQRVhPK1dGcDdNcmpzVTgwVEYxM3l0bC81?=
 =?utf-8?B?OXhhRnF6K0FpTllEREkyTW9FNDFXUTAraU1QcXAzbnhtUDVKSmdTaVFXcXVj?=
 =?utf-8?B?ekNGWmx4cWgyVWFSbWU0SVJ6TytkQlZlbGViZWZJeDc3SEVGZTZ4UGRxbUNp?=
 =?utf-8?B?SXZmbXkySnlUS3hhWGZWMGZ0NWMwNWRzbklPYnBYYVRHbG1HRkh2YjVwMkh0?=
 =?utf-8?B?Z3dmWnhBaEVBbnJwZEthNmE0K0cydWtKcEpKSWhuY0lNQ0szQVlvYXltZlZq?=
 =?utf-8?B?UWhEeEduUjYxNW5PaElrZGRJMG1NeUlaSmNmMno3d3hETjlVL21kL3RBVTg4?=
 =?utf-8?B?YlRHUlkvU2w1c1JmN2VVRjJ3dC82T3NEQkRmQ2NTSTNpWCtQY0YrNVFDUTZ4?=
 =?utf-8?B?czN4VUd2Mks2WENySmtMVGNCdGFwZTZSR015ck9lSGFwQng2dEg3ZSsxYWsv?=
 =?utf-8?B?N3NGTGVHTU5rTEZuQXFqVUNGcmxIT2ZjcFdQWUZiUzhodGQyc0RINlphV2Vp?=
 =?utf-8?B?b2RxL2txZllXNzdoWE5GWkl5QmhlTC81TkYxTHgxZDhBbW80UGV6MFdKajJh?=
 =?utf-8?B?SytKdW4zckpQN3p6K3d3TEptdGY5VFowUjVKamUrTVlCK1JkR0h6Uks1ZnNZ?=
 =?utf-8?B?ajA1VCtaQjVHRGQyNHFEbHNzNitOV1ZMTmwzSHBOcjdvMThidmlsWS8vNGF1?=
 =?utf-8?B?cWZEQlRvcUtIS0lCb2t6QlR3RVFmRG9hK3Q0b0tERHM0ZDZJcnl5dXl2M2Uy?=
 =?utf-8?B?c3Zob3BlNlhMTnBFS2FUOU44eXJmZmY3OUhlZC9UTG5xcTh4c2E1THFWMzMr?=
 =?utf-8?B?V1dwU0JVSWZYTVB5NFM1TjBWZVh6Y0Z1MUdWSDd4OVZpa0ZndnEwU1NMcG5I?=
 =?utf-8?B?ZE13YW16L2tNSS9yd2VwQ1p5Tmg2TmxqZGxINFl0TEg2dG9kWVNoN29Bb0JM?=
 =?utf-8?B?TXFpK0Erem0rSXlTZXl3R0gzZTI1TWYzcXpDZHRZYkpnMktOM0xpeGlvWVBs?=
 =?utf-8?B?Q2tGT3RLMWhhcVB6UmlnODFzZWk1akFPb0lEenA0dnRETEtIdjgvMDhBUndq?=
 =?utf-8?B?QktoamdienM3a01jVWdqdzh5bjFWYS9ISExMWEh0QTlVZGNIaUFENThWVGlk?=
 =?utf-8?B?VFM4RWxZN3lqWjRPanV1VjNHay9uMjVTb0NlQkI1ZGNFOU1DQnoyOXRkTXk2?=
 =?utf-8?B?KzdwOXBiN2VPWkVPWENFNXpuRUNEU1dVdkluVGhQTFpNSlNTY1dmOS83T1hP?=
 =?utf-8?B?U3BYcTJVMlNYdmlqeHRFbzJJTWxVQ0R1Umd2VEJFQjJMS1NGMXkycWNmWE1r?=
 =?utf-8?B?bWdVRExMU2pNaDMzS0t1MlF4NHQwWUt0dkhMbXF4aUU1enY3eFZzZlZmNkRO?=
 =?utf-8?B?NmVRODZYYTcwdlQzN0NoUkJJUzdSVjNOMngwUERDY1p0NnAxSXMwUXE1SlRE?=
 =?utf-8?B?d1R2RVlVYmdjYzFFN2hIclg0M3J2dGhQU3NLaXF1Q2xPYlVwd0k0dDNQM0dv?=
 =?utf-8?B?TGVaeDRwTXdXVWlpM1VHWnQ5ZnJ3ZjNLUTFJMkV1U3VWVk9VMDJRc214cmwv?=
 =?utf-8?B?c1YvazZVNm1VQno4R0UycDZvN1hTaEdmdWUza0RZaGs0L2w5OHNTYW1SRG10?=
 =?utf-8?B?VjBhWFo1TDFnQnBmQlozWTJuMGFoZ0JOU1J3RXNlRXg5QWJrR2kvUUtEZW41?=
 =?utf-8?B?bk9TRTBOU3ZpZkpkMEdiMUN6Z2VnL1JoZldMMlJMVUNTbkRvcUI1Nnpyckh2?=
 =?utf-8?B?VzYvWEZNRzkxRkllWXFLVWRiQXorN3lKSmVEclpFSzZkT1BMTWM3Y0JlNlNx?=
 =?utf-8?B?OVRlb0NFakFzeFBocEFmZkFjVXBRYXB2ZSthZ2pocm5Ra1lSemZpTHpTaC9C?=
 =?utf-8?B?NElCSVZsZERmWml0RHdBcG1IZitjdGJCWm94cm9Sc1JEazFhVHUvUVJYU1B4?=
 =?utf-8?B?VlFJUU1KMVR5UHVCbU1wQTJ0UHBPQjNaY1g2QUJJWUVKYXBVdk0wUUZya0Q2?=
 =?utf-8?B?ZW95dnpMOFJNWGt4RlhVOEt1N3BldlNRc3E1WjVoNUpJNm9PTGpRQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e305cb56-9c0f-4fb9-f613-08deb4c8311f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:28:24.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7boXMDaIw0SiF2KK5zesMwohX958fe4CjVaFhBuHPs8YlXkZXto2uxOXtdeBybL1fR6v1SI3jbfqAgXnRs37wS9iscKCMAU8K3LUNYQ/YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 10:28:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19535

Hi Paul,

On 5/18/26 11:15 AM, Paul Barker via lists.openembedded.org wrote:
> Alpine 3.13 is long obsolete, update to use the current version of
> Alpine as our base image
> 
> Signed-off-by: Paul Barker <paul@pbarker.dev>
> ---
>   contrib/prserv/Dockerfile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/prserv/Dockerfile b/contrib/prserv/Dockerfile
> index 9585fe3f076c..c630ce99722f 100644
> --- a/contrib/prserv/Dockerfile
> +++ b/contrib/prserv/Dockerfile
> @@ -28,7 +28,7 @@
>   # prserv
>   #
>   
> -FROM alpine:3.14.4
> +FROM alpine:3.23
>   

FYI, these are "tags" but they have the same meaning as in git. They 
aren't immutable and they actually are very often changed to point to a 
different layer.

e.g. 3.23 currently points at the same layer as 3.23.4, but a month ago 
it very likely was pointing at 3.23.3.

The only way to work around this limitation (if desired) is to use the 
digest value of the tag as argument, this guarantees that alpine:3.23 is 
the same from any machine and does not depend on when it was first 
pulled or whether --pull=always was passed.

I'm not sure this is a necessity here but wanted to bring this up :)

Cheers,
Quentin

