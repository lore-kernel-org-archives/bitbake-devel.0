Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F17DC38142
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 13:24:30 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.68])
 by mx.groups.io with SMTP id smtpd.web10.101738.1674825869605738454
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jan 2023 05:24:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@theobroma-systems.com header.s=selector1 header.b=Woodjn/B;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.68, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdIOx2x5RGtJjhyOCwEmhrylx59Tdo7AIIgUpoDP6fBIr73OjH8uP016wBrGH9Y4gAdPwIu8M6fHijtzPRhCHQqsZzi+8nkEFIzqfiiZi56MPwgEgM02E22cW69+8rOzM7lUdSAuzly575TGzyGCx0b3SjxBGZ+zj6xwu/v1OOW11h454jobVPUZWHH3TnM4vjXIzJLpysIquU0ykYZJD+67Y6ZOOlemnYb97gef++aEbx1mWV9bj8g1l2hedAk0ny7eN2dISqlh4Q1z40ydrcUP9CLSN49wuFY6ml5pyvCdMFTKmqKrSiWYVtTmlw4J8DeLXtRFbVUMKDF1vpii4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEpb/yiqj4OL44CJsTSfC16FunwDEeVTiR+hLYW3hOg=;
 b=F/FmoCKUZs8pI2miZuJuGUM/OxKdLS44pP0RMYyLyENZQf8oIJw6RUfD9aWMWsSLvd9x4RyqL9LrPV3GKFb0qSfr0IvY1M5YQlke4/aHKKGdbeBmyVH5LDN7ehkh5xFNacGs6tuzJqQKtAnXPN+FTgFRWYH2hAY6657SvsGAw15quFqKIRkenCip4pH0+NHAxEnViIsj6ZKaxX8HRMPBWeqjF0jlj5n7Ouj/slHQ39Ll2Pzy1YGieoSKEwsfVbNppmwzNXP6VlOr/OYZtNhjJxsdRABKKgSRKi6Of0C85jVywiv/ZA3U0c/I4bcNqrCch9FxO/ajdOcKIHgszdlcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEpb/yiqj4OL44CJsTSfC16FunwDEeVTiR+hLYW3hOg=;
 b=Woodjn/BohKludX220v0wL8/8cSjz+nrBaWI/EMnK5HWcy6qopmRYhtCXQijGaZni4cS+bYQ7Sj/a4Zo3BBOocpwPLDsw8MYl3Al2csqCaBkrx+LciHUxoVJqo6z4WCeiYkKkUNx1sQqTOmMBUPDCXvyxO5V3ITSlMWcBOtW0R28UXAFnzacUiO+54J0NmyImAC5G+G8KX7I9KjTXmniBk3qW0lYnHW5iL8jaWllWirJuEO/AcRfmpz3cGR+rC8RsXVNA7jnCkrPZiJW1cjUDuwUGSVCHAoUlS8bObjpnnFqwfDbwdZplVUIg9U7FpsGE/vvBLWJlB1cN2R6vU+zdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM7PR04MB6936.eurprd04.prod.outlook.com (2603:10a6:20b:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 13:24:26 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%6]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 13:24:26 +0000
Message-ID: <d2858712-723b-bb6a-d1a7-6e2a134ced97@theobroma-systems.com>
Date: Fri, 27 Jan 2023 14:24:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] Saving off warnings to a separate file with
 Python structured logging
Content-Language: en-US
To: Joshua Watt <JPEWhacker@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <3c606d49-77d9-d89f-4d8d-96cb0a36f620@gmail.com>
CC: YP docs mailing list <docs@lists.yoctoproject.org>,
 Michael Opdenacker <michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <3c606d49-77d9-d89f-4d8d-96cb0a36f620@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR0901CA0088.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::14) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM7PR04MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 29effb8f-cc27-4a29-b2ae-08db0069cff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nTXs+FnmCWkmye+sD+9nWYMmF5Xs78fd+BFQQJoVIAa25/MEmc+M/FIdrvgsZKqLadppfrSlyTWjvZzSyYWG5WT8pwPdqykzdQdZIIaU/D8wajWzbkoo7y1dJxZXYteg9Dy8fi9pA91ktx8OpqYAtph4/cSueFa2eaJ1VskSnDen12BpJuofV0v1M7j6gOFP1tnfxxkiCRHLKIYwyrmj16bWhKIrOLTdVu3sXcFkzt7IA71Mc+kGgapyXlZUBacpUjOm0z8zZkDA0YIXu9jnojShc+2kc7wxcC415I3ygNiuQyUEKUtMHTSuZEscylqvaNM2/wZ7BhKRPpyIdHrFBHqxeKR7oOkO3/63+TpVUOLo6imPK9gfok2ECtuWJB+j5tcYfELwCBAJjWjG7wbo363At6UUyBwKXRnPTeD6IWZlBtlv8L3d22OnHZNpAz0re5MxRv65EQtzeo+cQCp2rz4nBkdQWAdByAIkrjoO/P8iXZAZ1lfPRMihxHvC/w8DXxel9T/tq5fMoze4b2YqevMpVtkQX6RJSIKOdb7L2bGaGtcz4w6aps2ks327jiNLJWV/1MZ02HDdMP+4b8BkqFizhBpkgtJGCdF6RBud3ZxBJ+OFp7DvLJ5JCPTPJZj5IMLBe0kZT9uKrkl2P74qBv3RvK4txTjMFlBsoHpxVAx6mf8uiOj1xrhvqFcDusGn2PlhtfYRLUZxrwkM+VhS/SnRhLkezi/CzHAIfEYZIVRrnX7Vx4AA4EYmfjwAQY69YohS+Sj/LxVWG7EIm6V3eQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(451199018)(66946007)(66476007)(41300700001)(83380400001)(4326008)(8676002)(66556008)(6512007)(31696002)(478600001)(38100700002)(6486002)(966005)(54906003)(110136005)(316002)(2616005)(86362001)(6506007)(186003)(53546011)(26005)(36756003)(2906002)(66899018)(31686004)(44832011)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iwf92P7RG+cldUOXnV21seDV3AAo0cNZ4gBYNYZUdtQkV2UhLMzPEZsZcSEf?=
 =?us-ascii?Q?9/l9lm3fhF7V5Usn6gUuuI6+oW0wBkBUzVd74w/lTKpONfuZTSx7aAI8YAo3?=
 =?us-ascii?Q?eDt2+KtBFQqJCOcRky8D5FDkZT8hfjZ0Q3onJX8+M1VUEVDw46vcVMix9DJh?=
 =?us-ascii?Q?Sx19xqaIfS+TafyxHoWveVSvkiOawCg2zcynu7CiuPqc3KAPZvDIfSO11gxW?=
 =?us-ascii?Q?GwRHl/RCrPtnRguSBg2iFlLs4VQSyFDXTq9hYkX5N2gDvXx4ZPWzovOVgfHb?=
 =?us-ascii?Q?1poRSXWY3n22hE4Lb3jH9ewZwJjoE/3ISMglYyWB1+FkWbwSQsujEO7ccc5E?=
 =?us-ascii?Q?lGjI8COjcd6U/38US4gE4jKTD9JzF9FFz8uuz1ico6U0adzpqR67J2z4ZQ8C?=
 =?us-ascii?Q?yYU7/hVnW7OB6y1gmmoA0Nz3dN9rmx52+LnuOiJ4ezeFejjUON387AhrSqfg?=
 =?us-ascii?Q?iAwCzSSJPToTWsSjsWkEkeZ2KxMHiUkHDzBeFrFAvkhlJnzpTs0QT2tF010X?=
 =?us-ascii?Q?q3CTUVDfTftFx/mvVCx2CRMdsiQ+ttPEh4iC5Y1dap5aczFZtrARR61V3KAW?=
 =?us-ascii?Q?EdKk50FgoIMhSwvKVBBR0JloFEVKl73/4V1alUNAv8fk1Sv4odpvgdrSwFPK?=
 =?us-ascii?Q?gj126zaw4KR9CoL38C6v+0lqN8AEdwkLZeLO42iKgC/m5XbbTYe0WUouPf+1?=
 =?us-ascii?Q?hna2UKLd8EOpgkjWFhiU3GVaf/fHPeIFhKfI+S5cWlW8Abg/Bs2GjmxzRKzM?=
 =?us-ascii?Q?nSdaK3y8VQZ5M2Z4qvoPLHNzKAvEtaOHYx55BEGvRePoLWv4YO0LZHrYfoe4?=
 =?us-ascii?Q?phPf7S7GlePalJE8UAWMp9JPQH9fWnFkGb9wz0W3nnhIkOlrIzGSCpuupHxb?=
 =?us-ascii?Q?GmQwQ3TticjRCsqPVOMW7fo1Bi5cFARnX9wfOALI58OwpvwIh7UZEqXtUtrv?=
 =?us-ascii?Q?g5kvnYJK5AME09m2mTvzdGBoMmwo+UANs/xF0lDCey8disYodQjKNiU76AAE?=
 =?us-ascii?Q?S2KTVhaNSeJrcCP/GMSizKUYP6n/rjYjUTiDPxbk+bNsjtm49UUlrYOccUYT?=
 =?us-ascii?Q?7o74wOTnb9QIRH2ymJKASasgzo0xjYKP/ZWaoMSePmb8acAc6w6ZAs+Km5hL?=
 =?us-ascii?Q?xXEhWA9MchvRlE/gye9hdkOvcVQbVYzA/iPpV5CtApglyQKif6vjJp+hcAla?=
 =?us-ascii?Q?AGCZrZAvvWwHORSGdmymhSdx4ZDPGY8AzyKVFkC2pOCdkd7vmkJrYeLN44zR?=
 =?us-ascii?Q?C9gu6wJzcXI8lgQmc8HReHILpdeXb8g/tuLXvcYTTpi2PWNUNwP4a/n9xobz?=
 =?us-ascii?Q?oMSP7di7cD8mxwEZZl1IuO0x5nSPNiKJz1RPvvr8Vv2EUaRY/nSxHtPXeJK3?=
 =?us-ascii?Q?w26ghOlT6wCqMsmbndMxzMlkLm9Z/FkM2kuW6fSLRHuDNDBL6TKApwSCORWo?=
 =?us-ascii?Q?mjboWDlzY5mmaoTF48c7o9xyGrjhtiU9R5ud22iR/pdX7mcRYQe3YXtCNwhu?=
 =?us-ascii?Q?QBbUbMXVVUkph8u4hv+1QwKzVQ99iekr0cf7AApi0r8hXfxUgL0jO2mRNmPc?=
 =?us-ascii?Q?9k2ky2C6AmLyjv8UyLf2TeHPXnXClJdaVDo17uyeEq5jFl3dj5Tka1h4cTjO?=
 =?us-ascii?Q?/WCXhHettjcLvaayWGwksCg/3y4GmvOdu0QzjBgB6Tij?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29effb8f-cc27-4a29-b2ae-08db0069cff1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 13:24:26.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTkYG8r0dmlnOQkGpphYUrlyZ6QH9uJ4estg1gKyQlKUfiOR/NaPZPpnZUtoXLqY8EHnSKFN0GC2xnrSoswOfA4/qqlt1e+WQoioXrglt9+/rw/RxNCaLNgroiRzfDso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6936
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 13:24:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14358

Hi Joshua,

This seems to be too valuable information to be lost in the mailing list=20
archives. Any chance of having this somewhere in the bitbake/yocto docs?

Cc'ing Michael and the docs mailing list on this.

Thanks for the tip!

Cheers,
Quentin

On 1/26/23 22:27, Joshua Watt wrote:
> It has been asked how to configure bitbake to save off WARNING messages=20
> (and higher) to a separate file when running bitbake. With python=20
> structured logging, this can be done relatively easily without having to=
=20
> modify any code.
>=20
> First, create the structured config file (we'll call it warn.json for=20
> this example). This file should contain:
>=20
> {
>=20
>  =C2=A0 =C2=A0 "version": 1,
>=20
>  =C2=A0 =C2=A0 "formatters": {
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 "warnlogFormatter": {
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "()": "bb.msg.BBLogFormatter",
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "format": "%(levelname)s: %(me=
ssage)s"
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
>  =C2=A0 =C2=A0 },
>=20
>  =C2=A0 =C2=A0 "handlers": {
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 "warnlog": {
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "class": "logging.FileHandler"=
,
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "formatter": "warnlogFormatter=
",
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "level": "WARNING",
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "filename": "warn.log"
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
>  =C2=A0 =C2=A0 },
>=20
>  =C2=A0 =C2=A0 "loggers": {
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 "BitBake": {
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "handlers": ["warnlog"]
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
>  =C2=A0 =C2=A0 },
>=20
>  =C2=A0 =C2=A0 "@disable_existing_loggers": false
>=20
> }
>=20
> After this, you need to point bitbake at this configuration file by=20
> adding to the path to it in BB_LOGCONFIG, for example:
>=20
> BB_LOGCONFIG =3D "warn.json"
>=20
>=20
> After doing this, bitbake should write all WARNING and higher messages=20
> to the file warn.log.
>=20
> For more information on Python structured logging, see=20
> https://urldefense.com/v3/__https://docs.python.org/3/howto/logging-cookb=
ook.html__;!!OOPJP91ZZw!iQrFYknjFg5zSdxaIH5idDius4IExGVkAMWKZo1EEHAl1ggvC5n=
3_HMrHn3tOmbSpVNIPPLepZqB53Daq9uen6TNsTnPSRsiUg$ .
>=20
> Note that bitbake implements several helper classes for structured=20
> logging in lib/bb/msg.py
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14355): https://urldefense.com/v3/__https://lists.ope=
nembedded.org/g/bitbake-devel/message/14355__;!!OOPJP91ZZw!iQrFYknjFg5zSdxa=
IH5idDius4IExGVkAMWKZo1EEHAl1ggvC5n3_HMrHn3tOmbSpVNIPPLepZqB53Daq9uen6TNsTl=
K7G8NjQ$
> Mute This Topic: https://urldefense.com/v3/__https://lists.openembedded.o=
rg/mt/96553269/6293953__;!!OOPJP91ZZw!iQrFYknjFg5zSdxaIH5idDius4IExGVkAMWKZ=
o1EEHAl1ggvC5n3_HMrHn3tOmbSpVNIPPLepZqB53Daq9uen6TNsTl2pVuArw$
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.com/v3/__https://lists.openembedded.org/g=
/bitbake-devel/unsub__;!!OOPJP91ZZw!iQrFYknjFg5zSdxaIH5idDius4IExGVkAMWKZo1=
EEHAl1ggvC5n3_HMrHn3tOmbSpVNIPPLepZqB53Daq9uen6TNsTne92m1xw$  [quentin.schu=
lz@theobroma-systems.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

