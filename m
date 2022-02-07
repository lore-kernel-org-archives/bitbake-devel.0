Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153CC433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 12:06:32 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web08.21166.1644235579899234065
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 04:06:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=ZsVql39p;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.71,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkUHQa71T5y2NQAv+EuUOuDW9/0c1ykG7NSLGpIQDq9PclHQdSzPaGk67d4/BWXutCL3P/gHb4kzorqPIMqF8EU8Mtf415uUXAFl82MYwwJrwdpD7H7t5HylUe/zUiC9F05e0vovkev/+X6EixXnOcoU6LWxrPwaFe0ZkDbCPFMMnNfGD3zdGHxpWDfnn/Ri+O+1XkP4Ej1fC4ufsQsAgnde4mBH98xPkWETH61HGsQ52oDXt3NvU4DJiiGjeKwEHnY2pSFWZ/GllJ/LfOAoY0gAzVD7mdY1M+Qm7ITdI7hCiauNgijBQPiTcHlGi4UshSjgdvCW+egvn2lFoYXsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnT700RHO9EvYVhMHGj+sPvoR7/OYJ7mZFPjmGFj3KQ=;
 b=Q7OIESOKxU1uM8WKCeMcsbhfRZx3jMg3+XjM+vSddVSDHryYLlmQc5F2iWDCkhOCLWGnQyUYDDBTbSa3ea9EYWRUf4dW+LPLN7LZZ4AoWwP74A+hK+1sV4HzcPS1ReEpEQjIArV/xnxflq3UUsp87NFQmiM8vIeoB2IJe3rrGPCiKc7PcSdeCObJsgrqUnkeItpUWmzlDm8BDPqRw25jyxQyqsk4WyqI5VzfiUyxT1WVftG2lIpUV++q6BZvhnwVnRD8Gbq+JFkd6JMw0IvBWIzR6icm5tpDPaPmCoInawNaydLtjjlxtToP3khI+DIG2M72ceBB/ZNgHrcbhTFQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnT700RHO9EvYVhMHGj+sPvoR7/OYJ7mZFPjmGFj3KQ=;
 b=ZsVql39p5/EMYn9kWY8RfiiTmHZavBxAoD500mrsJWLvsnA5zyYVU6qlLvx+mkMfTydxE/Hj/Ul/9OHo6Yy0/jqVkd0bHjkNtdvDK6bvLWd6OIZJmIJQ4jGpQsJz4JT8SLJKOVZuvwAGCNv/BBIJOOdg6+mK8RyVeEs71Ls88DQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VI1PR04MB5712.eurprd04.prod.outlook.com (2603:10a6:803:e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 12:06:16 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::b46d:11b:b0d3:3ac]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::b46d:11b:b0d3:3ac%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 12:06:16 +0000
Message-ID: <93495d4b-5a29-68d4-c426-8c82399e2c06@theobroma-systems.com>
Date: Mon, 7 Feb 2022 13:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH] fetch: Use git rev-parse if network is
 not available
Content-Language: en-US
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>
References: <20220207115322.28209-1-pavel@zhukoff.net>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220207115322.28209-1-pavel@zhukoff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0185.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::15) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d31c42-cf0f-4a79-3816-08d9ea323df1
X-MS-TrafficTypeDiagnostic: VI1PR04MB5712:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR04MB5712B8C944AA64183878B66FC22C9@VI1PR04MB5712.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gwsXXF7hXeBEr4qS+W8CfqNZ9g3H/Ak7c19hy56JtJ0761ZAusvUrKfVV/FZp3McoBKKAH7my8Y3h4/0HbBL2xfFn/Zn9uR+Drs7/72t76LyAuUo/p9sLgcg2g/C8eUpECa3oFFpd/4pOM4XFAqjLa5kgD4IosH8DnhJiVun6ZcBDnW757t+HPaV67ND7rQ+6tkctMPtCGnmYewoVkJQ9isqpy5bwAFux2zfvA/b2Vu+WxTcRsjPT52S3b/SRDzTk/meYMALGzqXegNotrjf8OH58XC1sh0o7QLt8267L4HdGiLsoqHDXmuYl4Z7Rpxyk3WD+j/MkCvzyANEsjJrqWCfEz9DFkgjVBpK9Pcv9cn7XfDfyOp2xv5Ov8tvE+ATDESKTUi2LJ2bMhIB1AdkWC1DU59NOai9QKG1y2xIBN4fHEDcdSKuApzddC8t4aW8uGPv5VsoxhIciJyJ1P5xQh38HC9Ny9zpjo5pvavVH3U+/kiFzwd6CEhMKbmh+FS9e8KRkKkWtjPL5pkoAToj/whmgttIjf2sjHW5Q9hnKCcVuDIu0Lut8GVVFUNPwTX2vBYaoevD01RmKgO/fGJHLgLdWhph2ypee2MD5EPmZU25e3Z/ZLFITYfFvj0oDR7nqfDKTKdq8jdtZNOhtVznQQxhsiiFHxATPWeXn5Al9EYmtZUeVgyhSB/FYvfyRiDcpHiwXflLIt3CY801QNWoi3IhEVcBMBvu/zPlh0d28UJ3m8Xj7v9bSpXT/3aXlJuerbC3lQaxpzLl8bwXhyGrhlGbl2CdAcenegJrJmnsqruumoxrQqvhXJnOF9fFGkL+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2616005)(2906002)(966005)(6486002)(4326008)(38100700002)(86362001)(44832011)(5660300002)(31696002)(31686004)(6666004)(6512007)(36756003)(66946007)(8936002)(8676002)(83380400001)(53546011)(186003)(66556008)(66476007)(6506007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NE5JY2ZINGdmVnhqOWg5NlRGRDVYMWNXYWlxNEpSQWRBK2J3RWVQTjZnYTJX?=
 =?utf-8?B?MUROMHhIbjRRUWJwa243ZHpObnkydFBiNEk1YzUxdVE2Uk4xVUtiY2JKL2Fr?=
 =?utf-8?B?d3pNKzlWbHQyS3g2WFFqaGZLK0FiZTV2dCs2Ynp3SWw3aCtzSldWcUhPQUll?=
 =?utf-8?B?aXhWdjFMU0JkWnVIQ0RSWmo0akRLWEZUeXRkemJkY1duMFFzMW5raVduTU9K?=
 =?utf-8?B?clR3SjJKbklIOXJkdEN2dlJ4VHFsWVpxb1p6RmFmcU9NL3J1QXh3QWcxckJx?=
 =?utf-8?B?MC9SaitkLzNoN0Z3Mk9COElUYU1iYS83RmloWHJoaVIveThYdjV2TEdZWGtT?=
 =?utf-8?B?Zm9MUTdaQllzeVEvUkVqazQ2a3VQdmNzU0dndHU2YURENUllMVZPTW5XTnlq?=
 =?utf-8?B?MnhrdlEzTnZVRE5DekhsbHVQY0R1N2xTSmtwQjlPODFVM3RvUmtlUzlOY2wy?=
 =?utf-8?B?MXd4MG1wK2xzUWN3cjFLWDlYTUExanNiRG5RK0tXVkNzeDZLTThhd1FQV0ZM?=
 =?utf-8?B?ZjJMOXhiL0haOVJwdjUrQ2l2VVhwZnkyd1Riblp0U0ZQcTdsS3lqVldmTjI5?=
 =?utf-8?B?VVQxRHVsRmJBamYxcFRuWXc0SXVabHhwdzdiY3ZaTU42RnFOc21IcitGOWNY?=
 =?utf-8?B?SHNzRm1iT3pIS1VUS05uM2t0YkVWbzVLaUsxMTNRRzZKVWZ2YmxPdFgwS0Vx?=
 =?utf-8?B?cUkwVU1xd0IvcDNCUTZZSTZXa3F6cTFpYzl1cmtkU1J3RDd6VWdvc2tWVk55?=
 =?utf-8?B?c0xxQUZ6akdhNnFINUFVMHBtOHlnRUx0Q2RRV0lZeUhPUXpoTU1YZnZtdHJD?=
 =?utf-8?B?V2JBUXNITk16bjR1dUZBdTlFL0pCUzM2cFdzUkNmRHBGU2t4T2pBRVA4UnB1?=
 =?utf-8?B?WjFyQ05EWXExQ24xRytVRkRsL2RhRGlJQjRqbXJ2d0JTY2RPR2Vwb0FobU9I?=
 =?utf-8?B?NGJPYlVNMVV0YjZSWHEwZTBRNXd6ZVVjakllNnNDOW5obmJaMGlMOGhieUNq?=
 =?utf-8?B?Z29lT3AvRHN0SWJLdkZialVDVWl3Z1RMWk1hTFZjSy9Gc0dIUmY0UVZOVDBT?=
 =?utf-8?B?KzhhL0RHRWdheGtxYTMzakdDSGNmZUl5L0lScnlDcjBYRjhib2xBVm9sQnZl?=
 =?utf-8?B?MlNrMThiTEU5Z09sMjg3eVY2VnFQWitFN3BhV1gzZGdGSGFZSFFXMG5wUFhZ?=
 =?utf-8?B?Y2NQSVFic0lvaml5cUtSS2hKZDlxSWJBSThQYzRWTFVrK1hFU0VETXlhZXdt?=
 =?utf-8?B?cmdrUVFmWUhMZXNPdEFRTEx1MVNlYmF3Y2loZXlUbVlyRjA4bEpMbFdMZVpz?=
 =?utf-8?B?TU1Yenc0ZW56eU5WNUk5QUhzbHdrdkZSZzQxRmQrSFFQWGhFZmZJYzVkTlF3?=
 =?utf-8?B?TjFjNVY5ZUplOWFTU0swQXBrcmZpKytmOXdWU0hzSjMrc2hmOFlHNkYydDBV?=
 =?utf-8?B?TnRwTkZzUmwvKy9BNnFLWXFkQWVqVVVnNnZDcEdLTk5YODI3bjZMU0FTZ2ZU?=
 =?utf-8?B?dWl3OWFKZXYwVjl6cTFXM1lYWXJsVVpJRGE0SitaSGtncWJ4UVdhN2Q2YmdL?=
 =?utf-8?B?b2hHZHBKZzQ1bXpXMHltTlFWaU1xVDFrZnN6dEJ5V2pneUtjM1ZQZUZFRHh5?=
 =?utf-8?B?Y2lpSUp4QXV5R1puVlFxMlpwQkRGTkpMM0tNdUd4TDZtaVVWVjZxU1lZRVFZ?=
 =?utf-8?B?WkswK0FJOFRkd1ZvaGprWUZIeEczbmUya3BTSWVmbEtUTkxoL3lWTkdaQlF1?=
 =?utf-8?B?YnRJTmZ0Z2RGdjE1ZW1FSUUxOWJ3RVJKa3BEV0N3aDZxdkszT3RQWTNCbHNj?=
 =?utf-8?B?MXlRT3JUOHhLZ0YyM1dCQngvc2hYaS9KR2NleTc3VDgyMlY2TGdsZzNNaFE5?=
 =?utf-8?B?ZFpCUmxQMkFFTkFSNkhYVE9tNGFKaVo4Tk1xclFKdXVhMGVBOVFCMjNiYXFG?=
 =?utf-8?B?RUFjRitUTzBPc1pWZzAyT2RuWklmZFhSVkR6aEJTZGdrUG5JTGtpbFlqbVM5?=
 =?utf-8?B?cEt4cnBkaGlRYkNNS1NScFBmZXJWY1pOWTRDajVMOTNmMkFNVEhOdnJZMWdy?=
 =?utf-8?B?WHB4TmludVhRdFhUR0pocmVDRmpOdGt0VEM5bVV0Zy9zbFhneTY2OFlGd3Iw?=
 =?utf-8?B?Y1Zxc0YvVzd4ci9jcXRnQXBuQTY3MUppbGRnbi9kdWRLV2NISVBWSVJLWFpR?=
 =?utf-8?B?bUlnWW13TGl1ZzdsR2FPSWlKK2tCQ1FyYXVPRHhodkRHcXNCRjJrcjlkNDFs?=
 =?utf-8?B?aEdxT3ZqOUtmYjhDZjlGaGJ6aTFlcEt6Z1d0c0pNTGJ1UmtnSFZwb2pja3l0?=
 =?utf-8?B?NHBPS0xXTFMrWVkySmowL0VSTGh1RUJyQlgycHUzZ1VLTU45TlE2Rld0STk0?=
 =?utf-8?Q?V+ziANoDNekfhBRo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 18d31c42-cf0f-4a79-3816-08d9ea323df1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 12:06:15.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 2YmnraJ4bCtRdtXet1EpKBo8aAspUm7/d0Ri+GA/0a9sOz9ugBE2k4gvX9MlAty2yT1VqOFdde3wxiBBnxq/epWx25DG1D2mnMdrCkCnITWiGGqtDXAhGElpZwllihSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5712
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Feb 2022 12:06:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13318

Hi Pavel,

On 2/7/22 12:53, Pavel Zhukov wrote:
> Sometimes Fetcher is initialized while network is disabled (unpack() is
> one of such cases) and Fetcher fails to map non SHA1 SRCREV to SHA1 one.
> In such cases git ls-remote cannot be used to determinate latest
> revision and git rev-parse can be used instead. This approach doesn't
> work with rebaseable repos so exception will occur for such repos.
> 
> See [YOCTO #14707] for more details. Note: the issue doesn't occur each
> time in unpack() because in normal flow (fetch->unpack in one build)
> URI_HEADREVs are cached.
> 
> Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
> ---
>   lib/bb/fetch2/git.py  | 61 +++++++++++++++++++++++++++++++++----------
>   lib/bb/tests/fetch.py | 43 ++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 30da8e95..5f56d9fe 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -122,6 +122,10 @@ class Git(FetchMethod):
>       def init(self, d):
>           pass
>   
> +    @staticmethod
> +    def _is_sha1(name):
> +        return len(name) == 40  and (True in [c in "abcdef0123456789" for c in name])
> +

return re.fullmatch(r'[a-f0-9]{40}', name) is not None

should actually do the trick. Might even want to include uppercase 
letters with A-F.

Maybe we want this to be a compiled re pattern too since it's probably 
going to be used "a bit" :)

(also pretty sure it should have been "and not(False in..)" because here 
if only ONE character is hex but not the rest, it still returns True 
AFAICT?)

Cheers,
Quentin

>       def supports(self, ud, d):
>           """
>           Check to see if a given url can be fetched with git.
> @@ -135,6 +139,8 @@ class Git(FetchMethod):
>           """
>           init git specific variable within url data
>           so that the git method like latest_revision() can work
> +        NOTE: This function may be called from do_unpack and in that case network is not available
> +        avoid using network operations here or guard them properly.
>           """
>           if 'protocol' in ud.parm:
>               ud.proto = ud.parm['protocol']
> @@ -248,28 +254,33 @@ class Git(FetchMethod):
>   
>           ud.setup_revisions(d)
>   
> -        for name in ud.names:
> -            # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
> -            if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
> -                if ud.revisions[name]:
> -                    ud.unresolvedrev[name] = ud.revisions[name]
> -                ud.revisions[name] = self.latest_revision(ud, d, name)
> -
>           gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_'))
>           if gitsrcname.startswith('.'):
>               gitsrcname = gitsrcname[1:]
>   
> -        # for rebaseable git repo, it is necessary to keep mirror tar ball
> -        # per revision, so that even the revision disappears from the
> -        # upstream repo in the future, the mirror will remain intact and still
> -        # contains the revision
> -        if ud.rebaseable:
> -            for name in ud.names:
> -                gitsrcname = gitsrcname + '_' + ud.revisions[name]
>   
>           dl_dir = d.getVar("DL_DIR")
>           gitdir = d.getVar("GITDIR") or (dl_dir + "/git2")
> +
> +
> +        ## We need clonedir to be defined before latest_revision call for unpack routine to use rev-parse instead of ls-remote
>           ud.clonedir = os.path.join(gitdir, gitsrcname)
> +
> +        for name in ud.names:
> +            # Ensure anything that doesn't look like a sha1 checksum/revision is translated into one
> +            if not ud.revisions[name] or not self._is_sha1(ud.revisions[name]):
> +                if ud.revisions[name]:
> +                    ud.unresolvedrev[name] = ud.revisions[name]
> +                ud.revisions[name] = self.latest_revision(ud, d, name)
> +            if ud.rebaseable:
> +                # for rebaseable git repo, it is necessary to keep mirror tar ball
> +                # per revision, so that even the revision disappears from the
> +                # upstream repo in the future, the mirror will remain intact and still
> +                # contains the revision
> +                gitsrcname = gitsrcname + '_' + ud.revisions[name]
> +        if ud.rebaseable:
> +            ud.clonedir = os.path.join(gitdir, gitsrcname)
> +
>           ud.localfile = ud.clonedir
>   
>           mirrortarball = 'git2_%s.tar.gz' % gitsrcname
> @@ -697,6 +708,14 @@ class Git(FetchMethod):
>           slash_re = re.compile(r"/+")
>           return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unresolvedrev[name]
>   
> +    def _revparse(self, ud, d, rev):
> +        """
> +        Return latest revision (SHA) for the refs specified by branch/tag/etc
> +        """
> +        cmd = '{basecmd} rev-parse -q --verify {rev}'.format(basecmd = ud.basecmd, rev = rev)
> +        output = runfetchcmd(cmd, d, quiet=True, workdir = ud.clonedir)
> +        return output.strip()
> +
>       def _lsremote(self, ud, d, search):
>           """
>           Run git ls-remote with the specified search string
> @@ -727,6 +746,20 @@ class Git(FetchMethod):
>           """
>           Compute the HEAD revision for the url
>           """
> +
> +        ## Network is not availble and we missed the cache. Try rev-parse
> +        if d.getVar("BB_NO_NETWORK"):
> +            if ud.rebaseable:
> +                raise bb.fetch.UnpackError("Unable to map revision \"{name}\" to SHA1 revision without a network. "  \
> +                                           "SHA1 revision must be specified for rebaseable repos "\
> +                                           "or \"BB_SRCREV_POLICY\" set to \"cache\". ".format(name=ud.unresolvedrev[name]),ud.host+ud.path)
> +            rev = self._revparse(ud, d, ud.unresolvedrev[name])
> +            if rev is None:
> +                raise bb.fetch2.FetchError("Unable to resolve '%s' in local clone of repository in git rev-parse output for %s" % \
> +                                           (ud.unresolvedrev[name], ud.host+ud.path))
> +            return rev
> +
> +
>           output = self._lsremote(ud, d, "")
>           # Tags of the form ^{} may not work, need to fallback to other form
>           if ud.unresolvedrev[name][:5] == "refs/" or ud.usehead:
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index ec7d83c9..1fcf3466 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2776,3 +2776,46 @@ class GitSharedTest(FetcherTest):
>           fetcher.unpack(self.unpackdir)
>           alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
>           self.assertFalse(os.path.exists(alt))
> +
> +class GitUnpackOfflineTest(FetcherTest):
> +
> +    def setUp(self):
> +        super(GitUnpackOfflineTest, self).setUp()
> +        self.tempdir = self.tempdir
> +        self.persistdir = os.path.join(self.tempdir, "persistdata")
> +
> +    def setData(self):
> +        self.recipe_url = "git://github.com/lz4/lz4.git;branch=release;protocol=https;"
> +        self.d.setVar('SRCREV', 'v1.9.0')
> +        self.d.setVar("PERSISTENT_DIR", self.persistdir)
> +        self.d.setVar("DL_DIR", self.dldir)
> +
> +    @skipIfNoNetwork()
> +    def test_unpack_offline(self):
> +        self.setData()
> +        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
> +        bb.fetch.fetcher_init(self.d)
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +
> +        ## emulate do_unpack (disable network)
> +        self.d.setVar("BB_NO_NETWORK", "1")
> +        unpacker = bb.fetch.Fetch([self.recipe_url], self.d)
> +        bb.fetch.fetcher_init(self.d)
> +        unpacker.unpack(self.unpackdir)
> +
> +    @skipIfNoNetwork()
> +    def test_unpack_rebaseable(self):
> +        self.setData()
> +        self.recipe_url += "rebaseable=1;"
> +
> +        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
> +        bb.fetch.fetcher_init(self.d)
> +        fetcher.download()
> +
> +        ## emulate do_unpack (disable network)
> +        self.d.setVar("BB_NO_NETWORK", "1")
> +        with self.assertRaises(bb.fetch2.UnpackError):
> +            unpacker = bb.fetch.Fetch([self.recipe_url], self.d)
> +            bb.fetch.fetcher_init(self.d)
> +            fetcher.unpack()
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13317): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_13317&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=TAHnwIUCuZPQ7vBGmkvVBkcWKm3prVlA6UFcViaqYEScF_lgqMYpoqeboKd-qJeH&s=kNFDHQIcWkeZ-Ld6-oALgJMeOKvcmoWJh12dcki4Tg4&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_mt_88969671_6293953&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=TAHnwIUCuZPQ7vBGmkvVBkcWKm3prVlA6UFcViaqYEScF_lgqMYpoqeboKd-qJeH&s=G2M6sBkCY4DYUNyfIHrwHZ6ZewTA8ayM1rPtPsE2w-Q&e=
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=TAHnwIUCuZPQ7vBGmkvVBkcWKm3prVlA6UFcViaqYEScF_lgqMYpoqeboKd-qJeH&s=disYGNo9s0vbsx-5RloToeQhYcZwV84Oy_dSYrIttAM&e=  [quentin.schulz@theobroma-systems.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

