Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D562E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 07:12:38 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.131])
 by mx.groups.io with SMTP id smtpd.web11.13530.1736493151464049452
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 23:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=PepyCbki;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.131, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTAxi2nP2Jp1D89IRrIHo+7e3ljTKZ4V3oBZkY7+IgKgBgmIWM/qMqt/HPoqjnjUsPE3S2S5CLPQ/xcdfdps8KF6NoWkiB1SmvCTpA5HfrjNqEEFVdqPKtFpUw7k5m9JHRo6+LmEmnjwV6xR/0KWuwuyvUeqRT2K3xjqnhZgE0nfjyn9QDVJnhNkV+g7M34fvA+dS6IVoXu00EJGlu7TCIW4S8q/jy/nX66ifWJ04Mi3KoRxwUI4WiYfdTA6fiaF9QkXDE5XO9sh7cgzWyRmWF0C0rxXZSqv2o6K8qirkD5jPKUK0S9D6VMuLeVWTNrB+1zy0j/2V5Q0kfpoyhsgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/byYbK+t2xXsN7FUu5Oawtu6UICVnMtVLKc9/M6t7w=;
 b=HxLdC95grNhjjMW7oAgDG91NEKFGWf+/XRzxxwQv9Qt6m2GJFsl0kP0C1QBz8nWbXXeKpRTHSQB5cXswmLKa+sZ3JyxHnTyvl4oHQtOZdeBkAJGQ1/uSWdLmGZGGG0ooX1VSdH1E7NDzOuN+dfNoRYYAaT9tWsC3yJQnc/3qkilHvUQ8t+kJOCfaFId4y7RTbZLen1RpyH9cGLot+QL40pK1vuwgzF7Qa8artprZgbMHoH+7FbmaNMQrylSuhlZ0zFDJj2N+aNkQwsAOmac83mhOhohCQr+UDdA+C847/CEmsMYubfZIe5q8bGfd7NKqabuiG1Ov1kqxZUXExzuaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/byYbK+t2xXsN7FUu5Oawtu6UICVnMtVLKc9/M6t7w=;
 b=PepyCbkiNWz0AqO/xFMv+LFkOJRY36njQyvK7nb7mewjjA/5+lRjZNHmyAAmGPmIz0KJdP2NGA01rgiNLqqHkoIQ0kxKuG7U98k000egywQEvsktbLK/MXtWyKR18+9aW7uvt5ktAolJ8yXbQ/KbZgsSOBtXKdiEWQE4Wd4yhe8pIyZuqIHrA0WimdvvWJf9FzkyuGaqloF0y1taNP1fl/86UDhsL7bXVHLLXfUun5+35QsMQl6FBQ7nPmdIV+zduqaw7Sic7Eb4Tie0f+mCuwEJ7uH+v9vSnlex2y69rkfLrQRtlA5LSC29wbpjDNxVW8UCOmq0PAw9EVhgYLbUMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS8PR08MB6038.eurprd08.prod.outlook.com (2603:10a6:20b:23f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 07:12:28 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 07:12:28 +0000
Message-ID: <0af04dd5-1483-4245-b903-0a1679103bfe@weidmueller.com>
Date: Fri, 10 Jan 2025 08:12:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 06/21] fetch2: introduce common
 package manager metadata
To: bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <1812DEFF37B8C65E.26783@lists.openembedded.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <1812DEFF37B8C65E.26783@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS8PR08MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 429b1522-3539-442c-9c10-08dd314623f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lwa5DQJ9q9taCHavBiWMBWg7qehM0SDjr7E47KRcr1VrBUK9OVrY/KopCjpF?=
 =?us-ascii?Q?MT9kCnqAZp/2VrKKMn9BMU7UORvPwtWiLoB121VO89BrcQnrGWEEaQOFCAtb?=
 =?us-ascii?Q?EjyPcxniL/wEunlFJ9LZtxh6gwGkKVtMFoci/ySvXB6xu6uOT+XgO0/sKol/?=
 =?us-ascii?Q?q+iqbjiP+Yu7wVdZv9krOJpAdidbOvdEDqte8r2Ptyl5oD+BaOVD44TnLe/Z?=
 =?us-ascii?Q?j+qVLKkExnXlRqK5EthbtvsYN64N9QDUk6XXaNVUovJB+9n6Ulpf0G5ZuK2z?=
 =?us-ascii?Q?seqXVglNaI94OscbcDKWlU/REatcFcBwBXnMiy70OvRkCykJnw09AQIBf8JR?=
 =?us-ascii?Q?+11nQQbwef4sMB+fM01TUhv5tJGa9RO2H76VxKWtbo6Au9/LScHGeO7/QPT+?=
 =?us-ascii?Q?OgNJV+y9SZ3fciSsicoyuIbLTD8GNC0DQD5e8R06Ae6he5hDtMtrsA3p8hlk?=
 =?us-ascii?Q?ZzFDtd11Ns0I/JDmHMSEWc+QOnhnHVpuMIA+ZBo6QeIcE1+0SltWqijwD3Tq?=
 =?us-ascii?Q?HSOODaV+kvFgKN3Cm2g7NNSIrcFvFnnoScKyt0r1QBfSG9PMPxFvASMkyvgS?=
 =?us-ascii?Q?HiKLdb5rTwzB6F3QuIIW9ukkLBIMkvknImXO9Q8I0NZlwCdKQ22gnpLUp8IQ?=
 =?us-ascii?Q?U3L8EDdE0LOpwJ9zl35EAa8yLF7RWYgv/T8SnjZqhSGaKeeqqu4f8sgYE/qN?=
 =?us-ascii?Q?gYMWuYXqD0L6vFO8njUntM4FmF5hK4EI0W8n7hq/0B4bcejkTQiIYBIywnJN?=
 =?us-ascii?Q?5DyQmZXaD/12vLMQZeXt9GT0ZaNFk8fL4DjGLdWNQj3hZZoeTuJ9i/uRPRtp?=
 =?us-ascii?Q?c6igqq4xQOa3kw6tps5s6Dvxt+EDM7rgaWYz8ZazPAiPwukrq1BTe3Alibjc?=
 =?us-ascii?Q?rxO/OZuyRO8O5TpD9b0KKq+VPm9ilwe0DluDgoFPeCwJkq+HVXKRBOmLwGKM?=
 =?us-ascii?Q?3/QAuAe2i4lZcn/6lcCXfUjcLW/2ZJGd/3JONwuzb/JUlo3A/oHusp1PQXZL?=
 =?us-ascii?Q?EN423hVcBsu0rBp7ZyyJnex9Qj8G9iMtJoZSC2Wqjl6D/57lbQD5YGwvBdtZ?=
 =?us-ascii?Q?hA30MnvIgz2yVskwK0DC3GcH/o0617o+DCBEodHwpgYIS53fMdn2b63BJx3O?=
 =?us-ascii?Q?BcoDsXfUy9iHa6gJ1Gae5blENChCeQG79Ggy8nRZ6mt5CczWuUAjDgXqm547?=
 =?us-ascii?Q?Ev2YeeGRXDxnRpWKg/d81OK2C4j3X4tr06f2RG+PswC7UibGRgLNgXXntN6N?=
 =?us-ascii?Q?YB6MNLY6QL/3V2qX/IsrP0j6rdgl/gd/p2PNh/eh1OdVrVZBxzr0KMFwBI/o?=
 =?us-ascii?Q?MbTD+YQkBXLd/EbDkcb0pRvNsblDzWtRIAKdpoOE706U9JBoHTdq0cIiXQaB?=
 =?us-ascii?Q?vlSeApQ3ux6aQPtR9Bck3jHTbyeV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o3Y3ow1alrN++tQ6ytXJ6euNI3KAsouUYXG2wZxbeXr4PB1lt+KjIei/pjwH?=
 =?us-ascii?Q?AgKAzaU9reArjtQPpO08IOrIS0Lghw+u+zcKBbD5KenWNU3zwpnzbXe1kGLa?=
 =?us-ascii?Q?reHrTLKavPdC5TNNCuYOUUlbRZinYmu+vdCrqkUv9Jh+4TkSpobase+CfhJm?=
 =?us-ascii?Q?EfDgqRwDRbZ88h2G5urRpeUHueCK1Zu4PtY5bsxcXeYo0d13utD1NVBFhM7h?=
 =?us-ascii?Q?9W7l7SDcdmTRc009Wch8zPef7lB2+RdhX4ojEwPz7J1g7ONc5ujjcEimfu38?=
 =?us-ascii?Q?A6NsAajYwhV3kL1uyWLoYiep0KvAW8mdrlwiJGyBHP1SzwdLyrWpM8Vj6etO?=
 =?us-ascii?Q?AtnBEXB9APPlJxwsrQkY3qizZDmaiGYIquUPtisarGRum9g6YKOLZjiKce9y?=
 =?us-ascii?Q?zVXXiSG9OzQZbZrEXCMaSqxjpH3YZmx5H4OkE/MfbE66en6Bprt1Euf13yYw?=
 =?us-ascii?Q?aYEZQIizNbm3WQ+gHEWaHDdVlC72WXesNelp0NWsxkYy3Fc4Ldt78GXe5aYg?=
 =?us-ascii?Q?iq5h7A5VCR7nOwKQeq2VuN2te8LjGwy1bKosvynVSOqvdRAVnFUlny3kOZpM?=
 =?us-ascii?Q?dbfacJS0+giHzmwGrWzDWX8zqEyh12/SvmPWRYcS0QxiFvUdgtDv8kGo1LKm?=
 =?us-ascii?Q?2OFUjKX/PQ7WML0m0HLWx0pjBCvOPJQ2eDxcNXOAIW53/xd7/rniRcbnsmMy?=
 =?us-ascii?Q?3OvKbt+4KSTQfSc7DgBAozCb0onJ4El6cn2NQQptQZ1n5Eovom3Bs2a9oHPm?=
 =?us-ascii?Q?odXbWaM/OSmYqtI1yPA670WVwySMN1OSWEXqGXbjTkOmBjUBE6Pd+aZ7jqi0?=
 =?us-ascii?Q?Iagkmnn7XjjGobxSi4r3Q1n/IvSNhmgR11n1GXgL9J4z7uhirKCTCkx8WaY4?=
 =?us-ascii?Q?5SS6Fodo9PFihg8HCjaZnlH5bSjXf4LA9vqxm1ZbwBNA1w4w5AXr/9DOuXhc?=
 =?us-ascii?Q?VKDydDF6nAPmhbZ+rClCiwk9oIa+tzzphM7hcml23ccYopYvdb5o0G554Flb?=
 =?us-ascii?Q?ueleK5telDamos24ehlpWMQoigLXQnsOrrCZZC3fWeY0Zym8mP4uKKppyeGx?=
 =?us-ascii?Q?nTajfeAjixzN4W7LoXEB9IBAtXRcealNfm4AtfdIfxka1nLWWjZTzNg4TNa6?=
 =?us-ascii?Q?tWvDRXuGtk3B1lIMXPIR32mNtcpNDzkabDJLIf5rK5x6FJq+Na4p/Fib9s4O?=
 =?us-ascii?Q?vK2DsdoSGwSggnY0dKzzaWXELbYdsQ0Kef3nxypdgglcbfy2nfLabAjmRNBG?=
 =?us-ascii?Q?mwcPj6+jFEYdnWhgXykubPnhcsRiGZC/3fDP1T5jHIm+/5Wy8rdPHwk4aF87?=
 =?us-ascii?Q?OIXoTzZa5KJYELgYJPqFp0YnnrZZuy0Vc+iL1I6c+zhe3yxkk2YIjqgeTSae?=
 =?us-ascii?Q?JosRTCFAY0/DKpp+4iRH+0aNJ32Zphwfp6BzNOd2RSxejZapJkgX85aieWTC?=
 =?us-ascii?Q?wbJzzlzH68St0c//xK/hh3GJ0UrWk7lxu6AS0Eoqy47ea4AWV55gwtwyqfbi?=
 =?us-ascii?Q?pePJ/yKolmqxvzKEHbD+dTwzUU+OZnQGljJQXcfGy0VdQ/d1Y/sVMTlLFRg8?=
 =?us-ascii?Q?1HQBGucXTVZb0Dy1pYTK+5c8kP9IaAb4vMzKNTnXCmkmV3ZzdzxiyZWWo+Bq?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429b1522-3539-442c-9c10-08dd314623f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 07:12:27.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YytwWB9hKgYg3GezyppyEtXK2uXVqnWZPYdNGTTnq4puYM7Hvi8lrBafgyYYDUTLgUQqR9EeExzYugQpPmpcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6038
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 07:12:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17001

Am 20.12.2024 um 12:25 schrieb Stefan Herbrechtsmeier via=20
lists.openembedded.org:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>
> Downloads from package manager repositories are identified via registry,
> name, and version. The fetchers use individual styles to define the
> download metadata:
>
> npm://<REGISTRY>;package=3D<NAME>;version=3D<VERSION>
>
> crate://<REGISTRY>/<NAME>/<VERSION>
>
> GO_MOD_PROXY =3D =E2=80=9C<REGISTRY>=E2=80=9D
> gomod://<NAME>;version=3D<VERSION>
> gomodgit://<NAME>;version=3D<VERSION>;repo=3D <REPOSITORY>
>
> The name and version are important for the SBOM to add usable name,
> version, and CPE to the SBOM entries for the downloaded dependencies.
> Introduce a common style and check the existence of the parameters:
>
> <TYPE>://<REGISTRY | REPOSITORY>;dn=3D<NAME>;dv=3D<VERSION>
>
> The style clearly separates the metadata and supports slashes and @
> in the name.
>
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>
>   lib/bb/fetch2/__init__.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index d2a30c18f..4b7c01d6a 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1356,6 +1356,12 @@ class FetchData(object):
>           if hasattr(self.method, "urldata_init"):
>               self.method.urldata_init(self, d)
>  =20
> +        if self.method.require_download_metadata():
> +            if "dn" not in self.parm:
> +                raise MissingParameterError("dn", self.url)
> +            if "dv" not in self.parm:
> +                raise MissingParameterError("dv", self.url)
> +

Alternative to the short name (dn, dv) we could add an optional version=20
to the resolution of the checksum and source revision and remove the=20
version value from the name parameter:

configure_checksum:
 =C2=A0=C2=A0=C2=A0 if all(key in self.parm for key in ["name", "version"])=
:
 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 checksum_name =3D "%s@%s.%ssum" % (=
self.parm["name"],=20
self.parm["version"], checksum_id)

srcrev_internal_helper:
 =C2=A0=C2=A0=C2=A0 if name and version:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attempts.append("SRCREV_%s@%s" =
% (name, version))

>           for checksum_id in CHECKSUM_LIST:
>               configure_checksum(checksum_id)
>  =20
> @@ -1711,6 +1717,12 @@ class FetchMethod(object):
>           """
>           return []
>  =20
> +    def require_download_metadata(self):
> +        """
> +        The fetcher requires download name (dn) und version (dv) paramet=
er.
> +        """
> +        return False
> +
>  =20
>   class DummyUnpackTracer(object):
>       """

