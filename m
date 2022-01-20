Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA9EC433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 13:55:50 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.88])
 by mx.groups.io with SMTP id smtpd.web12.11851.1642686947508715258
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 05:55:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=M56Csj98;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.15.88,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXJ8tKLuT+Dpn8QJe/aGmdE27Lvk61OkIPqzV6Es37Y38vdcKizvRYauPk8TADPMD9rTGDC9wQpaSVdQhXCUpFrUvsnbqagnubIAazztPqx36ZekFP2MJ/siE7kIewaRrfIHBJArP5OlAk+ipfWkwBBTt0VlnI7uNGVcz95SUgEPYmcLZxR4aZoT+ijGJthk3X/l6OUd9bPtpk+BI96ewCf3q4Ckt1nqLLploEe6QdLgQWW3L583HqvhzI+i+P74NoZBG62q74aAcHt7sBey/d/UHYpYs8qQeecbg1HCapsjB5gWSAEi8fnLKWWNnB1Cx2FdQYahpYESo7DAgPm03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EUW1v7P6VIeRBa1G761iSx4bpG9oBN7PIjqVORrNek=;
 b=lowM4ef9/ooUu1p/doNE0XjEll+KwrXBJirAVJSpIB6YDYxG43i6OH9n3Fyk+ll+fBGi04ord/WhQ7GG/mtlBW5Rapfr2PG7BO+ahomQW9vNuJKw65XHEjdXJ2Uc6bK+vKCdZp3Mo4eZczaV51qfZVmP1YXw/oAQC+Y4UblJr2MqSBYZaPoqGvwfBVZhLiwNLOBcD4QJy3XdOJVzkxkNrf/i1QgtLG3x1ByNj3i8Gwqlef4L30iio2VTDlcboIWkP+/4SwJP3UVXWNHId8JfUpYwQbBwmeM1Ro2mz95ySNqHl9qMIBnVGj7p96xoPGNyjbbYO0x2KeJ0MYD+vNY65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EUW1v7P6VIeRBa1G761iSx4bpG9oBN7PIjqVORrNek=;
 b=M56Csj98VDiEMrfSxm/6Owq5T+6T+D9pJzXO9ReQeOmsD9Rd+LzCEXHW+Za0vIqFbHfM1kdm+GVy1oCR20wzd2gG2gEzRCr0cM/Ga1Ww2cqEBHe0L04Tlck7cTzuLSjOSrzlSuqct6Twbv3dpKGAa/ckWFInmlzIV1HUKNuAyZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DB7PR04MB5578.eurprd04.prod.outlook.com (2603:10a6:10:87::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 13:55:44 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%8]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 13:55:44 +0000
Message-ID: <24786647-3cd2-d084-cc59-62ffa6cb241e@theobroma-systems.com>
Date: Thu, 20 Jan 2022 14:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: add "crate" fetcher
Content-Language: en-US
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220120105438.1212027-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220120105438.1212027-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0122.eurprd09.prod.outlook.com
 (2603:10a6:803:78::45) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b98f8326-d6e9-43f3-bf51-08d9dc1c8d90
X-MS-TrafficTypeDiagnostic: DB7PR04MB5578:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR04MB5578CAFEADD6D3A54CECB4E0C25A9@DB7PR04MB5578.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gDEGAMrJLJSV6Pc+h1/LtBm5gatSJgmAc5vlZTjG0DkFEXxN6odoVZO5NXmGxVCDW0bjjyNpziBOOKCumJD0ZkU/1d+W0KlkcoGGG/K8MGsmBAZXSw62ri3Gxs/vR+yOhTuw90sSCbttMhBxxRH0Be94+/KyQ5MhE6sBcYJQyIWBoG/ahjnLSR1UTBFCpTOWa5b4wR3qWoz/iddBpPnHqVA3NdxwLD5hFdtle7rzUuYcLu1UQx6MSmzPMrGMaZH2TF/9shH5A9mhrl48gM5IIkRorrAietrYMNp4iEaqzapGj26f8fRS7jeSuvkVbi82FsiKTPxF9zHoncWJzMgSbaL/ixCPBVyh3eYS0iYjHwQbkqiEG9uNYCrmp54aqVuKbUgwLUIO1IBJj5CoWjnZQs1OeMWTFaaGC4DJ2/nhuYByNEcPcxGg58tiJ/T7x987xvbD0d8ShfvfG0xgXjemI43uvlHs4ulz6Hkx0oMM32ie+wEZTcLG5OAtQWtaY2Ro68nwjQs1l4rmMvKRyPjs4oms/KeArxS3MyIaLoFFR5Ur28MEh0NM3Um8pOzG2qs2LinQbXYbr7/FWi9ggMMItVkm0qyOshhs/C0Uaq1eN3jaR6r/xSMRBOsdVL07SDu2ozVsdwwOEyFSPRapOpILN0qoyF1x+bjr6Kv4vFuUH5pPf2f0wnfl94sdhzw/TYap8xfDfZZuC5TKMGkgITbvyrHUL7ufMNWHa0plUdWoTwP2QsLPeIbKMXwQT2MhN06r+Nr/27LPdb6OjPH0KWV+S+0PyxDv+rZT0bTR7gHuJ0RXK/b3vd8ls+UBMqrRgsmU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(6506007)(316002)(6512007)(8676002)(508600001)(31686004)(31696002)(86362001)(6486002)(4326008)(8936002)(83380400001)(186003)(45080400002)(66476007)(66556008)(2616005)(44832011)(38100700002)(5660300002)(2906002)(66946007)(966005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVh4Q2d2aEZXUG1tVllIdlRxY3RhN2V2d3dhbGdrS1BjdUlGZUsyYnhhbU1w?=
 =?utf-8?B?WlU0amd5V215WGdvczQra2V1aUlwbW1EVUZYanZneHhNZ0dqOGViV2V6Qi96?=
 =?utf-8?B?TFVTclpBVUdBOExCc0ppckhyYzJINnRBcDB5S1FoaC8rNmRvK3E5UVk0eE9I?=
 =?utf-8?B?UHJPaDFoN05raWU0bkhmbWJpMmRVN3VPOG5pOGNEZ1NzM0pNMWhCUy9ud1cz?=
 =?utf-8?B?bFF0SDVvNXRsNWt4Wmtwby9tTkgzR25IeTVCVHNGT3ViRUdIVnd3SDAzbzdH?=
 =?utf-8?B?Z1BjdXRGVFEyWTdMTFVtSUJuZiswYThFQ1hrZXdZakgvZHJzUkpzWkdrL3dX?=
 =?utf-8?B?aW5CTTlFUU9YZUpPTGhCWEdmdnZHL21UMTB1VjJVSzNGWi83UnptbjBFVTUz?=
 =?utf-8?B?ZUtIOWVmMHUzOEJYVGxyNC8yZWk3YnZTNUZ6VldFWGc4SUxxeE1GM3dmeTNh?=
 =?utf-8?B?YnN3NjlMdDhJQ244ZzRvWnd2bTYrck5oeTZ2UlZTeXkxVTZ3WjNVN0VQeTJC?=
 =?utf-8?B?VmlHbkZoSUd2QkpYVDZOQ0JTL3l6dFBlMU50YXVxcmxVdWZQUmw4OVdXMzh5?=
 =?utf-8?B?MDc2UGJONHNQY0s1d0hnclo2UkM4Y1M1YzdvN0lDazFBekRidW54alVWVVRl?=
 =?utf-8?B?bXAvbE41T2VINjJPcjVmU1dtdnNNWkVmTXJzV1BBZkxRSlB3aFBDSytaZk1V?=
 =?utf-8?B?R2RCVUprOHZKRzdNaDRRd3dTR3BKWlp1NStYTm1vMDRGMUlPRXZMRnQvKzVI?=
 =?utf-8?B?S2FoSHFLRkwxdFNiYXdlYUg1VWlWd0E4NCtENm1TdXJmMHVLVXVIMkE3Ym0v?=
 =?utf-8?B?akpGWDNkVzFOWHh6K2MxQXdBd1V5d2RmbXZ1S0psRTNsOG9oSS9MMWVqcmlY?=
 =?utf-8?B?aG1sRXV0RzN3WFNKTFUyS1RTOG82R0dFYTBzbFViT2didnlKNlg5UmhzYTJ1?=
 =?utf-8?B?bThyRkNFQ0V2QmNZbzVzemEvTkV3YlhZeVUxNnJxTDFjcnB2WVJoSkhrVEs2?=
 =?utf-8?B?ZW5NNmJwWjhGcUo1UGd6dXlxN2gwcDM2Rm1Gdmhua1FSKzM5aVdTdjA3Wk01?=
 =?utf-8?B?c01mbGhMc3lkL0dBZVVpYWpUWHErNC9TU2JJNTNjdm9lU1loR1kyemJieHBl?=
 =?utf-8?B?YkF6SUpWbUsxUXBNNkNpVjkxYi9NZ1NldkN5bElXcUF2WVh5d2w5Yi9adU5F?=
 =?utf-8?B?MnB3aGFsZjdpejNBRkRxRnlwTnRoejh3NWU2cVkzYkxTdDVjVHMvSXpaTU8y?=
 =?utf-8?B?cGw5TlhoNGtndldmWUJOZWluanlkRTJRQVlDNlo3dktGN2grLzNpMTVhYnNo?=
 =?utf-8?B?T0MyUExkcEw3YndLUU5CN3NERTRqRGVybVFPU25DR3hrUTczeXJhVVZTMzRo?=
 =?utf-8?B?eUFIMHJDdng3YndFYTcyK2IveGNsMHpkbDFobHFRdlVWa25VN0NGZjk3MFhJ?=
 =?utf-8?B?ZS9YaWtTRjgzVUJUT3Z2RFVjK252RXI0RElzbkNYaHNBaGpKTUEvbWN3MzFL?=
 =?utf-8?B?SW5xeVJSOEJzVXNYaWRuTXpSSnQwYzdBTXlKUGFjbEIvc2J2NThyMHl0VkJU?=
 =?utf-8?B?ejJ0V09FWmZLVU1qd054a1Rva0ZMZldzOSttMnZ5R2cza2FkYlYwSXNEYVQ3?=
 =?utf-8?B?VU03a2hYdlgySmNhMWdJNUhtK3FBSWNObnRGVERMcUFvOG9Uek5aU3paL2ky?=
 =?utf-8?B?K3p5TFE3T0RHYkcwZXkvRjY2ejJyd2NkVFNERjN5am5YY0hJSk1DaVY5b1ph?=
 =?utf-8?B?QXRpc3NuVitrb0ZCM1NycVFzOS9weDl4Wkpxb0tBbU82OCs0K3JXQ1RKYzUx?=
 =?utf-8?B?U0M0b3NEL1lSVjlGaG9oYkhBWUwrMXJQcGNxNHlNVXBTOXJWN2ZNWHdjQ294?=
 =?utf-8?B?dVNnekZKVzFneWlmZE9MNW9zSXJzR0lvTG5aMjlndjlqNTRXUDh5SGIwemEy?=
 =?utf-8?B?Mmd2NHh1bVFmVlJTS0Zyb3Rsa1Y2MGplcnBjaFB5Y1grWmE5ZU5aRmc0SE9p?=
 =?utf-8?B?VnNmOXVDbXdZQThCODJTZmwzT29NdVNGZ04xY2dTUWRKWGdZNHhkWE13cTlm?=
 =?utf-8?B?UEhYS05kenBKaFVIdDhKcG93QUVpQVZmck9senVpMHgwTFlFV0ljYWllV0dC?=
 =?utf-8?B?S2l2Smh2ZDMwbXNnTEtPTSs3NlZxdUZHamQ3NnpIZ3ExRm5yNjlhYWEzTm96?=
 =?utf-8?B?ZUlNRzMxMVhRNnd1NXpTYW42Rk1UQkV3dmpZMzZRbEVVdlE3R1laeElpbXgz?=
 =?utf-8?B?LzlCVE16cGJjbm9GaWxBZ1N4cytIK0IveTN6L1N5S256TEhlWmM2dUxTaVBE?=
 =?utf-8?B?UjNxOTBUZVZhWE84V2pYUE8wMVdtOEtsRUl1REpuOVlNbWZ5b1VyVDhiK2k5?=
 =?utf-8?Q?tEfgLpy2wUaODv0w=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b98f8326-d6e9-43f3-bf51-08d9dc1c8d90
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 13:55:44.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 fzb08iNUy7YlwAB/zf7SCLo3WTr5YR6LkN4ayEHAO7jn7qxlommLB5c0iqzO0AU8DTqIPjgUh4mssy/MioW7D00jJHFI2h/AjdmJ8XkTSqOEt3H9TOq+og8hZaiU3xjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5578
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 13:55:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13256

Hi Michael,

On 1/20/22 11:54, Michael Opdenacker wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>   ...itbake-user-manual-add-crate-fetcher.patch | 40 +++++++++++++++++++

This file shouldn't have made it to the patch :)

>   .../bitbake-user-manual-fetching.rst          | 16 ++++++++
>   2 files changed, 56 insertions(+)
>   create mode 100644 doc/0001-bitbake-user-manual-add-crate-fetcher.patch
> 
> diff --git a/doc/0001-bitbake-user-manual-add-crate-fetcher.patch b/doc/0001-bitbake-user-manual-add-crate-fetcher.patch
> new file mode 100644
> index 00000000..db26cd80
> --- /dev/null
> +++ b/doc/0001-bitbake-user-manual-add-crate-fetcher.patch
> @@ -0,0 +1,40 @@
> +From 9959a987ae3def8ea4fed41df4c890fb8856bae5 Mon Sep 17 00:00:00 2001
> +From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> +Date: Thu, 20 Jan 2022 11:52:53 +0100
> +Subject: [PATCH] bitbake-user-manual: add "crate" fetcher
> +
> +Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> +---
> + .../bitbake-user-manual-fetching.rst             | 16 ++++++++++++++++
> + 1 file changed, 16 insertions(+)
> +
> +diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +index 77384cfd..4a18c076 100644
> +--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> ++++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +@@ -688,6 +688,22 @@ Here is an example URL::
> +
> + It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
> +
> ++Crate Fetcher (``crate://``)
> ++----------------------------
> ++
> ++This submodule fetches code for
> ++`Rust language "crates" <https://urldefense.proofpoint.com/v2/url?u=https-3A__doc.rust-2Dlang.org_reference_glossary.html-3Fhighlight-3Dcrate-23crate&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=voX-MQd60MDlvVkYFzAidn-531SxV5qD1XuuDN2gYvA&e= >`__
> ++corresponding to Rust libraries and programs to compile. Such crates are typically shared
> ++on https://urldefense.proofpoint.com/v2/url?u=https-3A__crates.io_&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=lJNZ5TpoVpkjKcSdv6agIg0u3XUw54RE0ELn_CF9nJo&e=  but this fetchers supports other servers too.

s/fetchers/fetcher/

Sorry for the rewritten URLs. I hate Microsoft.

> ++
> ++The format for the :term:`SRC_URI` setting must be::
> ++
> ++   SRC_URI = "crate://HOST/NAME/VERSION"
> ++

Nitpick: above you say "fetcher supports other servers" and here you 
mention "HOST", maybe we can write SERVER instead? or what is the proper 
rustlang term?

cheers,
quentin

> ++Here is an example URL::
> ++
> ++   SRC_URI = "crate://crates.io/glob/0.2.11"
> ++
> + Other Fetchers
> + --------------
> +
> +--
> +2.25.1
> +
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index 77384cfd..2c15ad7d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -688,6 +688,22 @@ Here is an example URL::
>   
>   It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
>   
> +Crate Fetcher (``crate://``)
> +----------------------------
> +
> +This submodule fetches code for
> +`Rust language "crates" <https://urldefense.proofpoint.com/v2/url?u=https-3A__doc.rust-2Dlang.org_reference_glossary.html-3Fhighlight-3Dcrate-23crate&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=voX-MQd60MDlvVkYFzAidn-531SxV5qD1XuuDN2gYvA&e= >`__
> +corresponding to Rust libraries and programs to compile. Such crates are typically shared
> +on https://urldefense.proofpoint.com/v2/url?u=https-3A__crates.io_&d=DwIDAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=lJNZ5TpoVpkjKcSdv6agIg0u3XUw54RE0ELn_CF9nJo&e=  but this fetcher supports other servers too.
> +
> +The format for the :term:`SRC_URI` setting must be::
> +
> +   SRC_URI = "crate://HOST/NAME/VERSION"
> +
> +Here is an example URL::
> +
> +   SRC_URI = "crate://crates.io/glob/0.2.11"
> +
>   Other Fetchers
>   --------------
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13254): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_13254&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=EGmspyiMAZLNporqOaddHgukGUMVbXS71vTMcCEUpdU&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_mt_88556264_6293953&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=Ar467842MtbGsDaRuAqMmf-B81guKIda34KjKtcmN24&e=
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=CHJ0aMuvquHpaEHy6W1mCt8cQmLCOjcbuG6o4kHVhcjP7jasS5ECYt9CRze7wfTx&s=PDSdxeqqw5NYpwUkOLNQhWtEF6vUhltKgkv-DqtB3Rg&e=  [quentin.schulz@theobroma-systems.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

