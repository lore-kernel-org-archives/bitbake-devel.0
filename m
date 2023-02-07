Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A52C636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 13:45:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web10.83462.1675777540799707617
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 05:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@theobroma-systems.com header.s=selector1 header.b=b9eR8LQ3;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.76, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD2kvTEVOXl8zekiagFjT5IRJuA++k8FuuB7rOkU/W0/Rhy0PI7lQXQ5qm7SD0jGxlD6ihYdj3Em06S+H9dQRQCdGhcPl5sVqCrHe9W7mibxV9tNXJAwtabKhcEhXDY5WJ5hsM3lWTW9uqG0oG1W0vxSB7j2L3gPCQlBsQrxSip9WQpYRgVdiGaMc2NHwBHcnyUUP296NJkgubP5XBC7U4+NHM0GSJ3SYci1VvJkS3QnV4BRzUuJxbAAa1mlKf6DaNW/83UwYuTcKkNQVTHjYzK1phFdgD72BT+rh+2sm7vRV3La7PjoZte8LGpD5jTc/NcFOwjsBtW1rMVonfctqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEmsfZ60MBiDydEKWx1PYqkBC6RHYDV68nqgFfRa0Y0=;
 b=FkiY38Mxpu3cdbZ6YPownyKBoGUqPVbZSXIiVLK5jlxIkeVR2TRXVPhuwrRNwMCZS99H1C7JdnmhJuSd4zsNAcy13TT3wVszrzZ3EWQ574zymaRw0My2A8rnK8nGUbdamr04TPuh1cZn2nHMdYgATa7nsYFscCYJTAYGVifao6BoYhMeaoTXKj+X1OskpPD/ysH8ZTDLjTx7z/R57iIg3EwDXb+7IKf9Nwrd3gd4+hyOZAc006l9N8Ez3Y1pWGBNOvXJRB4F5JLlCkpL9p5QhRw81d+4RrN92EutbrtXWnyJsI6YIgIoxaGpWjzk7e+1GiK2qV0uqf/yInYoR9WESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEmsfZ60MBiDydEKWx1PYqkBC6RHYDV68nqgFfRa0Y0=;
 b=b9eR8LQ3s7gTmFGP0hFrK47OhFaZLyxwsecHzH4OJBJm89us/lIblLijHaoosnAVEF8O3LaU/HlzgLDfLXjhO8RanDeuQ5iQ5S5kGy7HoIihzex2vuunZWZGMrdrhEzvUoy6B1itxdygFYBbPH5pV71fCNyDRQrhunV83mQSCPZWEKMVAQYUVs9ZybKNqdthYAhPwvvyllre2h6sQI5hWWlQJ7vY38STSI/SYPlwzs3b7y2ePiZiaqfaikotEWSHWeRjt1uiLDM/ZWKFbzZIJItcnHksMRXy1VZ4TtpFguc77+7yN8hEhSci9CDCR53jExDe9PPIgx7vNTEAKgNXzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 13:45:37 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%8]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 13:45:37 +0000
Message-ID: <cc9c4e69-2afe-c92f-50dc-ee9684919d0b@theobroma-systems.com>
Date: Tue, 7 Feb 2023 14:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] [PATCH v3] fetch2: Add path control to
 BB_ALLOWED_NETWORKS #bitbake
Content-Language: en-US
To: anders.joergensen@advent.energy, bitbake-devel@lists.openembedded.org
References: <2D8Y.1675772137721512677.cmXP@lists.openembedded.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <2D8Y.1675772137721512677.cmXP@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f6b36a-a582-474e-16e2-08db091197a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5POEz85YeEV+0kia1Tt9TOG854wzsxnW8EchZiF1ZzlzOyiZ1Mr55sU1V9UsZwoITp4AVEY16eCifjCc/l9tzTGlipPdxOE93X+hKxeV2YKBtJWbwfGumrKGjDkfvq9fE4U1sVH8NBAsjoHDdwyxL7i7racl3J1/ZP8+Ot3ZijFieJPNzJaTS2zwSbSNQr50MYdy+FKlQmS5kdLpfqnJRn0Y6L0zlgDsYp1UjuyfHk4Mbr2MyPBuApVfHgX14nUEUGNBcVavWoW8sDSMW5j4FDKZTG2Y2P5SUEjXyuZyCAiCrpqgM1+JatYLYKoDscng/K5ffIFPpT5ZmTt1k0xh5YfyGXO/ugpJd9rhJvps2r/m5A2FCcfqI2ruKMT+2bqD/R7XUzRcEhEhLxV8L0wH52xsHnHfeHMXWWzmZD/R+qshEmrtkrznywjjLppkZIAQLg+Fl+cZ3ldkGylKe62ImbNG9TSccoPPSkHvirVk1Cs1zA6C2BB6afVosN0/lBehjzx/Xqb0lx2pW+uIf0T4IfoodOOCNSEG8cvouwnUSKR00ATuOaT4uiffr2TaqzsJ4lGb5P4+ZmbtyEmvDBwoWfQCPQkaNVwuAdeuF8VEya5c47cz6GBCjMKU0KeoB0uiCOlhhJ2zFJCSEBpmOvis33ywIo2dQNg8khmIeCldCx2n4hh+2Py0Vep6EfIYCPkgpkJXnGkqni9dx9DLGHXeVtJ6Pn+4JLqdpAkuoOBYcYwKCyhtzPyzFRrnN/DziFwaRvgGeMx/6g0Bm8LtClFTLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39850400004)(366004)(396003)(346002)(451199018)(31686004)(84970400001)(41300700001)(66556008)(38100700002)(66476007)(66946007)(8936002)(8676002)(53546011)(36756003)(31696002)(86362001)(186003)(6506007)(966005)(26005)(6512007)(316002)(6666004)(44832011)(66574015)(5660300002)(2616005)(478600001)(2906002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ec9VvJQoNMkewL3wrgjwW44G3BlIrHS03vHA7f87QZiTgTrmcMbjyacM5i86?=
 =?us-ascii?Q?CkyTUtLgyPBW4Ui4T2wB6tc60lVMcS8YkKBLpo0x7x92hB6cJwlzhdEZmA2j?=
 =?us-ascii?Q?PNMWzH30aNze/zz8XGo1rS81h8EY7KhIm72MLmFoUkwWuqaEVjNPZswgPjgg?=
 =?us-ascii?Q?0eReMDb6umEFkCewwfaQBZ/TwrrF1YP42FpqWEHiVH8jNnlTmFU+7ZbpIB7Q?=
 =?us-ascii?Q?WIpYbrlkrE47hG0Irztx3WXhBdeEBAx/XR0P7K4B0QxAQ+gj+MQEqaOfcFgO?=
 =?us-ascii?Q?BxFoyn4ptM024W/X+F7t8756USe3sXwfH8gHSdxulBtzBdtIo6AQSASB7ZTN?=
 =?us-ascii?Q?/RoEBx/TJPU1RfNZgbNdZbNT1O7ErrPVDaOBVkMw7vfnDHZj3Yf31i4Skeiy?=
 =?us-ascii?Q?12Wi9lEEne4j7d3kxT7FuhFbwzszPsZXaeeDSICqsuHm4K2QJyb0U9UUxP7l?=
 =?us-ascii?Q?JuGVfingbg66/hL4QIHaf7+0TVJBRKmigXkDt7fyVdwYCeP+1v+H7Ae8fGGG?=
 =?us-ascii?Q?ANUBKCah3vro8z/D1kRwWFEKcdV2jLzBrjHkWLUf5EbiiJC89pUtxFn5dTLq?=
 =?us-ascii?Q?6b4umle7vrLBvbP0uyxYdhD1+olsCy+g1ex5oVpniEekLNFW0SeuSlEQC3+V?=
 =?us-ascii?Q?q9o2hllHNGT2lMeTrkDJRUzatQvsspgckC16k/P3GQJoXHW4J5YGxZyxLuic?=
 =?us-ascii?Q?72sNTQIaEVn7XDJ9OrdPNpxmj76SfvebAN6vDUT0AGSHesDTiatO2kSKuFw4?=
 =?us-ascii?Q?UCM3rrF44wnRL2fBKypVjDJey4rxcUiHVpXiIFZMrtB4HjmD6xIbyU18/hNB?=
 =?us-ascii?Q?hBRPqFKyMQyNNwJzqrtXIEVBuYwxeata70Sg2jvtJab2ZbMBrixlVtcS1t99?=
 =?us-ascii?Q?+wH0tPpgnaBfUQEBZsBbBNrS4rbfgSAB3K7B0/oAdOmG/IgVysRr600qYiEf?=
 =?us-ascii?Q?IbHVnVA8mQe4e1Yb5Xf/9pDRl7UcRgvpPyChbYRlZg/kCMCA69wmnQykMMud?=
 =?us-ascii?Q?5MhtYwKZTzBm+OxSmqw7kyTDcpb3CsU6zbelmch7MCEjxnxFnnGFg6Z3Dkeg?=
 =?us-ascii?Q?XCVJ4nZ5pycRn2EWKIPQ7jbzUVycXXzo9CrvmrEXDl1UDjMonWKPDYAnMJQY?=
 =?us-ascii?Q?oMKZVzGKoewL3rpYrFYk1B9VxpzgLSfHSIbqyCHxwbTDBOi9ekdw0TmkLOk0?=
 =?us-ascii?Q?HR02AFQr+soo21ARTWkYUWTwTg4BILUvTiFXqs8s+qgPlHRSj5BFfvxe1xpf?=
 =?us-ascii?Q?EtxuO2bejHMeKa7O9dSf8EEV+fDXixmJNYGoUhco0BVVjErkHu69+eBLHrVK?=
 =?us-ascii?Q?xgh+USHS3eCqw8LLoIYYololbetCiEOCduY0P3/YuSwR2A7FBNyVes4THoLy?=
 =?us-ascii?Q?rDabTLmTIoGfYFEZ6Wdb7UwpWxCLeLWdMgJIY0TE/3d085VhyMyEQopj1OJI?=
 =?us-ascii?Q?qjsee2DrS7K9F3mDegOmAihk5WPGa06ZkRTMf9WRszpmIY8/33Xggk4cbrOg?=
 =?us-ascii?Q?0v/ew0jMSky28B/c0MJN+K8QiguTII003+C79d5e33jNASeJCn2zYM946eGH?=
 =?us-ascii?Q?DrmAQNSzBqEa4pf8D/hAAvsFT6XGATgVIWdPUSzJsK7lxNr5ccEhOJJuM7KW?=
 =?us-ascii?Q?PIkulCvUHoeufuDkSjMb4wI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f6b36a-a582-474e-16e2-08db091197a7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 13:45:36.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnSlWZKFuTyYaaCxbkaScoNYjgycQ2NM4vtU8TxZqElqmHFznElcWzJLa28X5Zxt37taw3KduymbmzilGCpufzBYZAJC0134zFX6LpYhe/hvGNk5gBak2NmikzSa/YAB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 13:45:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14379

Hi Anders,

On 2/7/23 13:15, Anders J=C3=B8rgensen via lists.openembedded.org wrote:
>  From 2ec3567b1a7a765b7047140fd35dc885872cc376 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D <anders.joergensen@ad=
vent.energy>
> Date: Wed, 1 Feb 2023 13:08:11 +0100
> Subject: [PATCH] fetch2: Add path control to BB_ALLOWED_NETWORKS
>=20
> Make it able to add path control to the allowed network, so e.g. it is on=
ly possible to access own repositories at a given host
>=20
> Eg.
> BB_ALLOWED_NETWORKS=3D"bitbucket.org/your_company"
> The fetcher will be able to download from bitbucket.org/your_company but =
not from bitbucket.org/other_company
>=20
> Signed-off-by: Anders Joergensen <anders.joergensen@advent.energy>
> ---
> .../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++=
++
> lib/bb/fetch2/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 +++++++++++++++----
> lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++++
> 3 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 09d09a8d..7d370668 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -79,6 +79,10 @@ overview of their function and contents.
> For example, ``*.foo.bar`` is supported, while ``*aa.foo.bar``
> is not.
>=20
> +=C2=A0 =C2=A0 =C2=A0 -=C2=A0 Limited path control is also possible like.=
 ::

Can you explain what the example is supposed to do here?

e.g. a few line above we have:
"""
For example, the following setting matches ``git.gnu.org``,=20
``ftp.gnu.org``, and ``foo.git.gnu.org``. ::
"""
So I'm expecting something more explicit here too.

> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BB_ALLOWED_NETWORKS =3D "githu=
b.com/your_project bitbucket.org/your_company"

Then indentation seems a bit odd here, the previous code-block in the=20
paragraph just above has a three-space indent and here you have way more.

> +
> -=C2=A0 Mirrors not in the host list are skipped and logged in debug.
>=20
> -=C2=A0 Attempts to access networks not in the host list cause a failure.
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5a7a6024..d90d9cc9 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1165,12 +1165,27 @@ def trusted_network(d, url):
>=20
> network =3D network.split(':')[0]
> network =3D network.lower()
> +=C2=A0 =C2=A0 path =3D path.lower()
> +

Something's not right here. Python won't allow this indent in the middle=20
of the code without actually being in an if, for-loop, while-loop,=20
try-catch, function definition, class definition.

How are you sending the patch? Usually one is supposed to create the=20
patch locally, commit it, then use git send-email (with possibly git=20
format-patch before as an optional step). https://git-send-email.io/=20
should help you figure the details out. I believe this should fix the=20
odd indentation here (if the original commit was properly created of=20
course).

You can also use git-send-email to send the mail to yourself and then=20
try to apply it yourself locally on master branch and see if it works.

Cheers,
Quentin

