Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D140DC433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 12:03:00 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.75])
 by mx.groups.io with SMTP id smtpd.web08.71181.1656936173902345310
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Jul 2022 05:02:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=Nyj6lEyG;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.8.75,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3M0L0RmffPR2ADSOEvjBvNKxDlm5raG6ZehmFT+ck1v42fLWBOkXjoyhbafN0X2OK5Xib9bcVaNsIhqmD2a0CCQchZEwCvWOsMozy+IE4WWDUN9YYo+33q/vaCacJHMd5XVpAfdSGoU9WBeAWHVPpaUHQvJsqFTEXqC/4/akKB0QJdIrvHk1z8DeVJ5tDQTWDC372J67uWGU7wlxDAwy5ZWLgVt6K7HtVJVV+uRD9Ya1190ytvGEEQXb9o7YOOqRqPGeEZoYAx/xc0MG1W5LUs+ptiOZUz6VJ1jVl6L60niSGzCnUgdNGpihCaRiWYyHjGlJw+oQeEWyYYl8FSr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VncXMPAn105ee+KMi+BpgUrxm61BRrOgdrPcf6tUE58=;
 b=cHj6USw4gdDXtNBxxC4FpjlLMgQkfLWx5o2Lrs9+zz4kIPW9d5pbJ6jOTCHwH1OYk85AQs/epGiZMf3jgWd/Q59r3AZhOhoUTMaVTDcN61XSsnz2wYf7Jz+z8xTOXcJQtnjsz4kDzgIKfzanRzEUYEuU2ioMQDnLxvUjPOrmzNjrQRnNrnhZh7bx1erP1fF+IXkJxzHvEA6KtHZHEffBkW1W34mQteNrM5W+bYSCH3VdT0lm/hPRy1Yp7JNIjeRcN5TKlNJvV4Ic1mQiL44ITPcqiw3B1qfQQ7enivMkcKsVzXxJamfQQfiJKUhBDqElVADjXll2FvpfCrGI13QsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VncXMPAn105ee+KMi+BpgUrxm61BRrOgdrPcf6tUE58=;
 b=Nyj6lEyG/86p781V702KCuGxAdRyjdAasQobiY8Amv5CYy7+4pDgC5pUmlaLGxeG0iMH5trXpvIs3Kyu/nn/M7X+ME9Lk7FBdPfxaQVtQYLQYdWtgDtqAd2dWFxXXFlZi7IA7WaJ3X/3lVYyB0kfejNNDhkwJoeHt+yFcX9T1WE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DB6PR04MB2949.eurprd04.prod.outlook.com (2603:10a6:6:5::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.19; Mon, 4 Jul 2022 12:02:49 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::cc58:11a8:839f:895f%7]) with mapi id 15.20.5395.017; Mon, 4 Jul 2022
 12:02:49 +0000
Message-ID: <607a8e9c-ad17-bff5-7b65-b02dd698c891@theobroma-systems.com>
Date: Mon, 4 Jul 2022 14:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [docs] [PATCH v3] doc: bitbake-user-manual: document npm and
 npmsw fetchers
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org
References: <16FAE3D11A2CC1A6.16268@lists.openembedded.org>
 <20220622082623.2685946-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220622082623.2685946-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM5PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:203:68::12) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad0f07de-fa65-4c2f-d0df-08da5db51d75
X-MS-TrafficTypeDiagnostic: DB6PR04MB2949:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9FSvy7LpuwAk+6lXuK4S6kjgEXcwA2EIGiXe8Z+SfBJGZXSCVpJoJmKFAIco+mwgwpoCHDY0wzGnerFoE8hNo1a1MCwdIc3dLElO4speRTr9K1OiiAaJ1i7R3CmlwZ52us+ENmHWM8HBrsMXOA+Byyg/GqylZxMIlrveNQQhIBNZEpQs4MBpN55JW2ZTH8h0W6LDDGHi7IJZzbIOkDlYBcmd1PfKOqyp50XlUT41W1yR2UE6bU7WDxze04AEy0pl0qlK4RuL5M+hSgpmFHCBURV5iZB9uksxkQKiLWPFXYBJwXVEnAMh8l16BZQleFm7tMv0EXMUr0UV+oHp6vUQuPVDxG3kFf/moZJbpaD3Qd1gxecWel4aE7RcOGLiuMDsFrXWcvNsMXtxhdSTmWKd1tSTXkchkqTtsK1uDeoEVEnKli25KiYkmkIzHezSOAHXgrZzdwm2TVvgapXrfznzs6MQySFDZqjLeyUGeQHgBqGNsbpBPUEgeWp2cgHyGpLSEJSvP7FG3ZzAYGiQbNcM9WyQ7h7kbwCOnFSqnpScBaajaFqTMRSIFVsjBXq3KXcJ2pA35Febg/P00YZenvOAW+PvDMdPl63qmr9FcMEjlwc21Fmh0ftDSjKFs2M7DiJBjNZbKo+FTe4jUE7PCyWuQP6omyhh8YS9Bu3kppw+cRC4SmkhOd9NOvze2Fr6A0MXEwYrSTBayAz3OmlNEAeQ3sCACKK9Y7P1257AABPpCR9sB/SH0iYsobpVI064rbnm1FUDnnZHwzWwa/7hzwVqiVtzYTpyTJtEQ/vsJ5vDmMk932qrHVpj9Y2GhOSLn6tnGqmF1MLLgn8JjP0vA1+lyxxsCPZw/FErlFO1Chf1xDTlUTJeox8uTpy7cIaSrKhaUpW71ghn8vXAMKB++AfO0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39840400004)(366004)(346002)(396003)(6512007)(86362001)(38100700002)(31696002)(41300700001)(6486002)(6506007)(26005)(53546011)(36756003)(478600001)(31686004)(8936002)(966005)(5660300002)(44832011)(2616005)(2906002)(316002)(83380400001)(66574015)(8676002)(4326008)(186003)(66946007)(66476007)(66556008)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SBsi694Ga0J+5zRWHQYpax36JPzTANCxTXxKE/O8iH8DrVxaA6bDMvYfKjFJ?=
 =?us-ascii?Q?li1tZGq9T1WvHMPysdAOBENBeqkevRjHKbufYbxT5TO5qFsfPxim4hBnfT93?=
 =?us-ascii?Q?nYubkwNAFcMewsEa1E/y+V0PrP1pV3tHRlBpO3Sng1Pc2p/W6C/4tGvhKL2i?=
 =?us-ascii?Q?K3kZGtS2QLsk33zHQTORypJb0g4K0hX+HWt8NtceoqjH5EE48txpNQGS7XNp?=
 =?us-ascii?Q?+xpTj8JNOOBYL+80PGtM93WRbXcyJ8qT7iV7Okik1s0qTN7FjxlY9dvL7RB2?=
 =?us-ascii?Q?iNXjFZNI/pSbRhYj/eIAnhA+m+m0sY4u/6yEwGWtXsYrKZ8CDt0bqdgMjW/R?=
 =?us-ascii?Q?36CFs+/YzEiLraLU6coDxaiWB4puuhHq/d+tQygdowS/oLyvwE4a6SnuOdoj?=
 =?us-ascii?Q?nhU29xfg6xFKxsBWsBVLCxpn+70dt4pCi1x+LZcaqLSgIboqqPSgEPeiBK39?=
 =?us-ascii?Q?xwUbbatVoc0aCGhtKDK78XNCMZM2bWKweff9me1s6US4Fn1eVBR+lADwnfSx?=
 =?us-ascii?Q?xPowh7Q34Yb2nfkDrSaCGL0XY/5MiwgQRf7JeXHlncbB3bCM1W5feGHGudDp?=
 =?us-ascii?Q?YxPZwFxSXUA6+8V/X17sehEDk8tS2b2bb7ymVkTWRXephgYzrp17pcFbGjsl?=
 =?us-ascii?Q?MAZVx6q4RLvylNJHKcWD8FVyPIMya/VLIBGCyr5s/ORe+bHvcBmuJe6Sx8By?=
 =?us-ascii?Q?r58u2VnamcNdlVAV2T8gaFw53EfWLMrwjiQF0sJLbG+kWVeT7XKSmmNiz3jt?=
 =?us-ascii?Q?1Pw8aYRlA4IkLKhC6cxAs4nlkKvvrHXJgmroQn+nO+rD/tMrB+NG0sEcLE2u?=
 =?us-ascii?Q?et+qGBxbrucgmdoECtAQ69sxLFtXCFuRW5r1r8/mN51ObgGlgpENjqsPNHCP?=
 =?us-ascii?Q?/Q37LhyUtpEZZnyRh9il18qyi6pzaLaEgX7kBaKWSFnmI2OtQOZbKZS+SvVY?=
 =?us-ascii?Q?b0GRbPw+d8ZQ84keE62XfEvfNmWODV7kuFvA2H9mXVKTnXgcE0ugwsIGI5g9?=
 =?us-ascii?Q?s84cgDzH+MKSipba0x1bVo9MDcYIisJU/3hp4072ikvZrh3KRpzmIuHkTmw7?=
 =?us-ascii?Q?8df20sAIfl8ETDfblTLL0xModo+VwJQx96JevyhB+N6ZSZ1mP4fL5NqAIGc2?=
 =?us-ascii?Q?uyX8uLcHM0GtZ+icXChHWJFhG3PPdJ1rQyUX4JpNUT1B2G06EEEDRy8S1hGe?=
 =?us-ascii?Q?BrxrVxzoJ0Fp2/bjqGCijAkJP6lIUOpZW2nC/mA5FE392Ocojg681n9Q0i3/?=
 =?us-ascii?Q?Pwfa9N+wtmdP0BlA9E1UP/pYJK6q3Av3gohjMi4iFKM3E8cUzj7AaZq1aM1M?=
 =?us-ascii?Q?A3/zhK6VQTBSAx5+1pbl96vJYs5qX6lq7ogujqtfqsTC8dSExpcYKgANP7eJ?=
 =?us-ascii?Q?KkGMr2cRNk9IvH1tY9HZkihNixo00GSz8wZaEsZQMh/OJ5WfBGjpu7DXQpoh?=
 =?us-ascii?Q?qo4ICaxWSQdZXlgOiwX5fNXdvk+erZHkfO658gUS6KP+PTtjX57WHxXGbXqw?=
 =?us-ascii?Q?JCy+E+G8zd/UZNScM/12ewxV4po5lhF2GkLfmpGJpIPon8WWdQK7MRXv5c/H?=
 =?us-ascii?Q?DujBGXQyrgbwFCdJSfE0aWr4W7MIUBesZSDdgHYKwkmCIFdeXo4vtV+Yg0Xt?=
 =?us-ascii?Q?huGAHL417pH0HVxNFowlxxk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ad0f07de-fa65-4c2f-d0df-08da5db51d75
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 12:02:49.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Z1MHXuuRllDehd8NPUUOFG7rASHzxSfDPFOmkLk+sc9oFFA+AckJNTrS9MZoeG4/snIxtVp1QTOcZvjnbBXi0R5t6jxIwnRztsjugFPCUvBW289xTpTA/V4lCx0SezLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2949
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Jul 2022 12:03:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13796

Hi Michael,

On 6/22/22 10:26, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
> This addresses bug [YOCTO #10098]
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
> ---
>=20
> * Changes in V3:
>    - Fix typos reported by Ulrich =C3=96lmann
>=20
> * Changes in V2:
>    - Fix typos in the names of explicit targets ("nmp" instead of "npm")
>    - Simplify the reference to the "nmpsw" section:
>      no need to use a complex reference when you can directly use
>      a target ("`target`_" as defined in ".. _target:")
> ---
>   .../bitbake-user-manual-fetching.rst          | 76 ++++++++++++++++++-
>   1 file changed, 74 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index f9d9e617..a2d5dc9e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -704,6 +704,80 @@ Here is an example URL::
>  =20
>      SRC_URI =3D "crate://crates.io/glob/0.2.11"
>  =20
> +.. _npm-fetcher:
> +
> +NPM Fetcher (``npm://``)
> +------------------------
> +
> +This submodule fetches source code from an
> +`NPM <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__en.wikipedi=
a.org_wiki_Npm-5F-28software-29&d=3DDwIDaQ&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DL=
YjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3D6jfs2SP=
cK6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9MMlRRLE3wLZdeN6W&s=3DWcYU-cB0-HVFY=
ar75YxpK_jUOrlJLotZTtXzDBVTisQ&e=3D >`__
> +Javascript package registry.
> +
> +The format for the :term:`SRC_URI` setting must be::
> +
> +   SRC_URI =3D "npm://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..."
> +

Nitpick: here you say OptionA but you use the word "parameter" in the=20
list below. For consistency I'd just do a s/Option/Parameter/ here and=20
same for the NPM shrinkwrap.

What do you think? I know it's already merged but we could send a=20
follow-up patch to "fix" this.

Cheers,
Quentin

> +This fetcher supports the following parameters:
> +
> +-  *"package":* The NPM package name. This is a mandatory parameter.
> +
> +-  *"version":* The NPM package version. This is a mandatory parameter.
> +
> +-  *"downloadfilename":* Specifies the filename used when storing the do=
wnloaded file.
> +
> +-  *"destsuffix":* Specifies the directory to use to unpack the package =
(default: ``npm``).
> +
> +Note that NPM fetcher only fetches the package source itself. The depend=
encies
> +can be fetched through the `npmsw-fetcher`_.
> +
> +Here is an example URL with both fetchers::
> +
> +   SRC_URI =3D " \
> +       npm://registry.npmjs.org/;package=3Dcute-files;version=3D${PV} \
> +       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
> +       "
> +
> +See :yocto_docs:`Creating Node Package Manager (NPM) Packages
> +</dev-manual/common-tasks.html#creating-node-package-manager-npm-package=
s>`
> +in the Yocto Project manual for details about using
> +:yocto_docs:`devtool <https://urldefense.proofpoint.com/v2/url?u=3Dhttps=
-3A__docs.yoctoproject.org_ref-2Dmanual_devtool-2Dreference.html&d=3DDwIDaQ=
&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4=
njZguQhZhkI_-172IIy1t&m=3D6jfs2SPcK6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9M=
MlRRLE3wLZdeN6W&s=3DWZN8VHjrTvZOsYaUrtzruMGbthalXahWckP5bF9dzdc&e=3D >`
> +to automatically create a recipe from an NPM URL.
> +
> +.. _npmsw-fetcher:
> +
> +NPM shrinkwrap Fetcher (``npmsw://``)
> +-------------------------------------
> +
> +This submodule fetches source code from an
> +`NPM shrinkwrap <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
docs.npmjs.com_cli_v8_commands_npm-2Dshrinkwrap&d=3DDwIDaQ&c=3D_sEr5x9kUWhu=
k4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172I=
Iy1t&m=3D6jfs2SPcK6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9MMlRRLE3wLZdeN6W&s=
=3Dtn-14IgatAsb4UxaOE9WHyr2SDmpLwq6kdd4fdeew6A&e=3D >`__
> +description file, which lists the dependencies
> +of an NPM package while locking their versions.
> +
> +The format for the :term:`SRC_URI` setting must be::
> +
> +   SRC_URI =3D "npmsw://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..=
."
> +
> +This fetcher supports the following parameters:
> +
> +-  *"dev":* Set this parameter to ``1`` to install "devDependencies".
> +
> +-  *"destsuffix":* Specifies the directory to use to unpack the dependen=
cies
> +   (``${S}`` by default).
> +
> +Note that the shrinkwrap file can also be provided by the recipe for
> +the package which has such dependencies, for example::
> +
> +   SRC_URI =3D " \
> +       npm://registry.npmjs.org/;package=3Dcute-files;version=3D${PV} \
> +       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
> +       "
> +
> +Such a file can automatically be generated using
> +:yocto_docs:`devtool <https://urldefense.proofpoint.com/v2/url?u=3Dhttps=
-3A__docs.yoctoproject.org_ref-2Dmanual_devtool-2Dreference.html&d=3DDwIDaQ=
&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4=
njZguQhZhkI_-172IIy1t&m=3D6jfs2SPcK6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9M=
MlRRLE3wLZdeN6W&s=3DWZN8VHjrTvZOsYaUrtzruMGbthalXahWckP5bF9dzdc&e=3D >`
> +as described in the :yocto_docs:`Creating Node Package Manager (NPM) Pac=
kages
> +</dev-manual/common-tasks.html#creating-node-package-manager-npm-package=
s>`
> +section of the Yocto Project.
> +
>   Other Fetchers
>   --------------
>  =20
> @@ -713,8 +787,6 @@ Fetch submodules also exist for the following:
>  =20
>   -  Mercurial (``hg://``)
>  =20
> --  npm (``npm://``)
> -
>   -  OSC (``osc://``)
>  =20
>   -  Secure FTP (``sftp://``)
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3017): https://urldefense.proofpoint.com/v2/url?u=3Dh=
ttps-3A__lists.yoctoproject.org_g_docs_message_3017&d=3DDwIFaQ&c=3D_sEr5x9k=
UWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-=
172IIy1t&m=3D6jfs2SPcK6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9MMlRRLE3wLZdeN=
6W&s=3DU-oDJ6f7AxQVn7Hu-iPX2eqtmmGau2B3g_rb_waPFMA&e=3D
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__l=
ists.yoctoproject.org_mt_91917725_6293953&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFw=
jJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=
=3D6jfs2SPcK6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9MMlRRLE3wLZdeN6W&s=3DFsb=
eoZkUIfzevApQ_qlmLYrBREoNQsYFpGls7XxZhxw&e=3D
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists=
.yoctoproject.org_g_docs_unsub&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLY=
jLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3D6jfs2SPc=
K6ODjoy9Rx1f1FwJ0XIpcaSmxNFOVz8Q09Z9tjd9MMlRRLE3wLZdeN6W&s=3D_HwyPc3o-uWBbq=
PaJ9CYJdLtpGA9MA7JTGm7Am8EMWU&e=3D  [quentin.schulz@theobroma-systems.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

