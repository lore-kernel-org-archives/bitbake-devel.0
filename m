Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2887DCA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 11:49:28 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.7])
 by mx.groups.io with SMTP id smtpd.web11.75358.1756813763822015049
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 04:49:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=dGNpaxD7;
 spf=pass (domain: axis.com, ip: 52.101.69.7, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXp2JK20dR/H+gD13wfDdeYBmyAJL73R1oLECDNLPbNFzEGj+chrjnKBAciWoQnpnoNhDXt84R9JCOsJk1+TX15RsbOviEB0qfKpH0KL/pkv5GBHfxwq9ChgtQxNFXz3yXB1hTGJW8i00HZ5+IMx0RCeWJpYqvhsjUB6Qsuz5WgOLwqdhqlBTqPsR6vKvd9gPRvQ0LJzQ2eag8dD9MBzafAgtY4eacf3GgedK8aJpoRwHTuMihmStYOfW1XJvANSpjA2IPmyXt3EMSBPWvjqiyvQf25Tc9P/agWFCSuk3GXDGm2v6T3h1Fl/M2qr0LsSN4ggwn3V6ieNFWTZUwBjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0CLdtxLmwME3SefGVAkhz5d8/EIx29wYgUDCzy6zho=;
 b=VzT7UdR62vPN1BFGoZ3bjlNjrxFXqnJIQN4zL40Add7lB/A91qpxuECezsdXz+yZ8JeHgXthB0jfXmbr6uM17TFavalbpHA8BGNUDdUcQiFfnoH/CA0b1lZ7ALlheNO63/2O/tdBpsUy1Dv1VeMbZhDo8ffEDIsp+XP2gL+XN+yZFlGxm6RsJjemJaxuDxnlz1xEioadLM7kuujTGH8IkZcF7p66w8e+0eCGMbOw3Gb8ikNSfT7FzYs2EtWVGJliIx7+K8D9IWfUvu2GXPfXtjGymMaVum4Ei6rakgnQdnA/Uzukd81rkgu7QggM0S0SY1CVrdXip6Pc52MvpwI4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0CLdtxLmwME3SefGVAkhz5d8/EIx29wYgUDCzy6zho=;
 b=dGNpaxD748ulkdtZhilkJoBEOEdHQ+8rHHOXhVyuhByRWunpMb9ukX4IAHcxKK7Fmsw2xV0Lh+y7r/txhDx74AOOuT/pXsf6ZgQJoynNzv/Gu5+MmfcGQPB1fd94d+Db+BKlB0Tyj5YOp5UnSX3wMw9vPS6tVNoYtSAsFQuY9b8=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by VI0PR02MB11017.eurprd02.prod.outlook.com (2603:10a6:800:259::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:49:19 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:49:19 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Gyorgy Sarvari <skandigraun@gmail.com>
Subject: RE: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
Thread-Topic: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is
 always configured
Thread-Index: AQHcG0iiS3ohwr5HakWfT7tGdK+1ibR/wuPQ
Date: Tue, 2 Sep 2025 11:49:19 +0000
Message-ID: 
 <DB5PR02MB1021363CFCC9D5EDC1217D085EF06A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com>
In-Reply-To: <20250901135836.2927686-6-alex.kanavin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|VI0PR02MB11017:EE_
x-ms-office365-filtering-correlation-id: 54d89b44-4df2-498d-b327-08ddea16c094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VpCt0QT0SPs17tGp18v8bYKhq2JA1Rt/KwnGZLo8NtEmQCvX6X9AqwexWt9U?=
 =?us-ascii?Q?6px5AdNYLeeH44jI2W9L4G6ZpjK4Gb7qaygiVIt50vQ8zeBZHw9W3x3CPuqy?=
 =?us-ascii?Q?GtoZ+IYFwDJh8jIIs2Ud0IQUMtBB3EynpvWtgscn0tU0+lPh8OHsluPB28jK?=
 =?us-ascii?Q?B36i3cB4RtPX4Gluo3tXHPeci1HJg8F6UWaZyH3vR2aL/zMfE0Llesl/6Fq2?=
 =?us-ascii?Q?631OIS3mHmlc/nJUWtR7N9UJAjZQyXszgz6juoi6f9ODJZzAmZa6LxXrqI1l?=
 =?us-ascii?Q?WyuazjSr4poD+UsLOhMoXHmKqAB3W93ZzubuEaSbE3WoDfoavVWMhwPruC4x?=
 =?us-ascii?Q?gkO7dzYHDO4jAD9YtFQDPbN09pEOD/eQUbQb5BbfCl0/AP69MAJQkjH67a2R?=
 =?us-ascii?Q?f/ZqmbhpH8kmKc5nvdUbg9xAM4/xcsLaGdpYKnBBm2UGrSok1FfYsymykkIT?=
 =?us-ascii?Q?qTw0NAIdbRQLRR7T0+wWQnd/tYwe8MWQRnVByF4u+P3YVWaBe5b1EdLTCK33?=
 =?us-ascii?Q?FoNpGGUM7UYZzAplyve3Fa6mhb/Hb0TbrhL8cJAhYRf43yIDw9hP42CMMNQ+?=
 =?us-ascii?Q?UXHPI5dQUpsQN0CqchDWXHG9KL/rUs1AApXktwpULNIGG07JoxVYlFQwCnuq?=
 =?us-ascii?Q?7AMpmXhf6y7B6SsNLeQ7Jnxxa54SqkTSag77KTo6etk6wkQVQaoOKKU5xbs4?=
 =?us-ascii?Q?rVNZkKB3KWZhKL5E/pYSptRMWwJiDccCikxDmr0fpD/nZA9yzSejIusNrvjZ?=
 =?us-ascii?Q?vLRTn6ILYBcXOIaYqYhayXZCIPTPhr51EGbYYjEc2Xq0NIR/IyZ87XLq+QFX?=
 =?us-ascii?Q?z0FUngl3Fd7R9vsp22P32Y76UXuz1QyEdeOQFVN6q6cw3u8E0Hojr1/HNOI/?=
 =?us-ascii?Q?Nf+XnR045gZTCN/lt1W4Ft3ijSxsc21s3P7I9boUZlCuWh1mJy9WIx2rmfl+?=
 =?us-ascii?Q?T/+E8YuNtJPaT08tsMibxzMYnYxQMq6BOCAz+3RzVLhRXnlf31QiRh/JeNB0?=
 =?us-ascii?Q?L1/KmTCdGbfXaI/VKH7PyJDclbDuNZOwSDBRl6peOdwzQK+8v9IP5zs0jHiI?=
 =?us-ascii?Q?i9q3upkVjh2IzV2opDnF34ehtdmOjXEFbeNjzMAYOOz3a4frXBfVZUgsz7bg?=
 =?us-ascii?Q?CR469cY8WG0J0yODwLPoOSgjzisbXNQAWc3dP5hj+Y49cKLbgDx7ymSgM9ma?=
 =?us-ascii?Q?drkg55zmrGYDuCWhIW48/joVm7jnTAxNJU4uJ//IrqH0+xi6Q5ZdFpkip6NR?=
 =?us-ascii?Q?CM2gtzUA5f3+CfRchzUhTBTwV0db0JoOGz67kklfHmDaGXFqqn/FV6Qvfdwf?=
 =?us-ascii?Q?jiXZCr7HaW+AQIigKIqAtYUvwP0jpf3kWF6U7Md61LKRF8GOySXqOLmDilRg?=
 =?us-ascii?Q?SWgcC7gaeLAyzyvNsz1C4Z4T7t80u4iqlZvIBTBBMpPY5B07C2Pjb1rzGw6+?=
 =?us-ascii?Q?qJC4KB3v60N3GidFwIv2UWx+ek9zxX35BgyDQ8J4WNXlarhs0/tCPQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?VQMJ2SVBTEQ1RMCOCQUz5EFQYCMDVAYRVjhhnxM1CT/3MYmnZMJz6kPXwZ8k?=
 =?us-ascii?Q?oGrEYxON4U7+r5pf/u+mgpynuRTt1wgoYdaSBevQtphOSLpzcR114D+2LL50?=
 =?us-ascii?Q?fRyMunnaEpKUNCBdt3P4ciJ19oJlvKcRIvmyaXG4xuBGaFNWItlMg1szvuMa?=
 =?us-ascii?Q?RU1av+psi+8iB8sA3cW4zpQaWpEv1fQT7puMOfwMLkOu0LLb7XYUrzibU6bx?=
 =?us-ascii?Q?z85gNDBfc5KXCm/F7N8JyXqHo1vIN5SFcKBaBZ5HOKOt7Vo3Y5DGEkkfX553?=
 =?us-ascii?Q?1ubymgDq1XluYBv/ug0qh9JCfYQSQDOJOGPR2yR0pqo//A2OyJYf9hpe7tXG?=
 =?us-ascii?Q?Lq1V7jmytEFSML65km+vjWJythN3vmOhYPOqNdVH8VSa36U7i6hA9gVWPkNX?=
 =?us-ascii?Q?7RR6rO+4R85UWsQGn9gcRWXLI4IeGM8LlUKKROTPTr3EtLLi2PROpmqH1o/e?=
 =?us-ascii?Q?TWeKBXuQgXgtPP/I8zSUhKBKaEIq90awoLD4Qu4qjPeRvBfKi2ypiKyCOWHY?=
 =?us-ascii?Q?iD1zdzei9k6cvDLm6FcZhAG+qUnvAzCB2/f77NNRy3nbl9TnUTW8sjAEXv3k?=
 =?us-ascii?Q?RynHYzfF8SMlEHHE9bisdR4WeXRE+14O5YanZQxa5nH4mljfHhUJbwrUqELC?=
 =?us-ascii?Q?cVB1UiVAlGLPojdTo4h3EjR+PIfYLcqGLAlIx2xyLU8vSmLqrSGvhXqVsF+n?=
 =?us-ascii?Q?xos3YEL/Y0k4OiHcYHcOJmgSP/uuhYpwCM3EKhfCOBJgQ47EIJA2kALp1jp2?=
 =?us-ascii?Q?h7zv0vz2m8gQzxWUfCDZ+hGPDigE2AksuUtLQTVzhXbDqfkhgAG6vpb5U/X8?=
 =?us-ascii?Q?/1BDAnlPfZ8SNNqSdEZpyZ35DUVLcDj/uLFOyvqv8qEkaPDajK+bor0mHWQF?=
 =?us-ascii?Q?rkN9QuBMddNzj9r/R5llsWcy+AqIBOMiE9W58e8dFfUBKkbk6xTARC7bFjLz?=
 =?us-ascii?Q?rPZTn4HjZO9LtddrKIJAxQwIgkh9NfGEIwJljQ6SBp5rv5cDiafDLbUhEOYY?=
 =?us-ascii?Q?XM1DDqxyZJ9SxVbxCIIk3w3bupa4zOD4sO1UTO/3C0y6yyNsihZwCKbrplO9?=
 =?us-ascii?Q?nwP4P3PmiXAQ8LkZncFLV62P9LK56ua3D5Ss0dsjgckJ2p9iV+J8S31SF57u?=
 =?us-ascii?Q?qnyEorFEIDmayXeHFTWG825KM7CynUmInd10ntdzCJa3285Xv/0WNvhnnvCH?=
 =?us-ascii?Q?KGcH7tEjwICTOw8XWsvLgPNAFRJIaVAJNswun101u6Tp/QEcPKIB+PqkQei2?=
 =?us-ascii?Q?h5D2EccCDFyJX3bEdxkY/Y4MQyuhTzOVCrO+KGh9OStOk9VLfOYDDDz/Zt7a?=
 =?us-ascii?Q?amB/wxPO8zXulNI3G2/XN9qOQR3tBGtbNBl4qMJotQLPGEt/YVYQkAlrgTrF?=
 =?us-ascii?Q?xONCw5Qpr9odRCOjvLkl1eTaXA/a/EBd3G+cXjKZud63sOzpFJmCCjabB8T5?=
 =?us-ascii?Q?Fsd0wtoocndKe2sKZyNqV51aTh8HygUy+dsC3uvceUzX0v9Jgp3NaVXfhc6+?=
 =?us-ascii?Q?V9FdARtB3WPqIs6HmdSc+NEz4uRf6Vnuu6iTY5ObasIa5BEwWMwvL3nq1g?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d89b44-4df2-498d-b327-08ddea16c094
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 11:49:19.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMWo7blYoa5xhq0vU/XYO+RCgKdST432Rar/2AiFYtGLy7WXjI+n3m0+obwKPJNV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11017
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 11:49:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17942

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Alexander Kanavin via lists.openembedded.org
> Sent: den 1 september 2025 15:59
> To: bitbake-devel@lists.openembedded.org
> Cc: Gyorgy Sarvari <skandigraun@gmail.com>
> Subject: [bitbake-devel] [PATCH 6/6] bitbake-setup: make sure git user is=
 always configured
>=20
> From: Gyorgy Sarvari <skandigraun@gmail.com>
>=20
> In case a git username and email are not configured, then git errors
> out when commiting the initial and later the changed configuration
> of the setup. This can happen if bitbake-setup is running in a
> container, or for example if the user just doesn't use git for
> committing.
>=20
> To avoid this failure, configure a dummy user to be used with
> comitting the config changes.
>=20
> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
> ---
>  bin/bitbake-setup | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 7382dc8d2..67188891f 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -392,6 +392,9 @@ def init_config(settings, args, d):
>      os.makedirs(layerdir)
>=20
>      bb.process.run("git -C {} init -b main".format(confdir))
> +    # Make sure commiting doesn't fail if no default git user is configu=
red on the machine

commiting -> committing=20

> +    bb.process.run("git -C {} config user.name bitbake-setup".format(con=
fdir))
> +    bb.process.run("git -C {} config user.email bitbake-setup@not.set".f=
ormat(confdir))
>      bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".=
format(confdir))

Please only set the Git name and/or mail if they are not already set=20
(see, e.g., oe.patch.gitCommandUserOptions(), and check_git_config() in=20
utils.bbclass). We have a global Git hook that validates the name and=20
email of the committer and the above git commit command will fail in=20
our environment.

>=20
>      bb.event.register("bb.build.TaskProgress", handle_task_progress, dat=
a=3Dd)
> --
> 2.39.5

//Peter


