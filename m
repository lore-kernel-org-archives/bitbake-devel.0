Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC6C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 14:41:59 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14110.1787755314274873406
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Aug 2026 07:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=fw3bY0FW;
 spf=pass (domain: axis.com, ip: 40.107.162.68, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBs3svdBLNqHOdP3JvhHZLKxOdBoQnwhy+KuHpFLzKSGObSVD0d9aNaq3v6kbCrVmAyFtJqm+KtU8GzEEh4CAuODXzJLwzDRgBhWBWXKPT4ENEbcZto9vyVWtiH3JXcyKbQUE6yyP2e0k11tBza3TP8zJ8tbpQy2c5ekiQvaB04Sm4LWZi9HiB71lUgxj7bx71tVpRp4re5zUOt8pbjZ8JRH9i/3KPapLUnFxemd8GpP3OfBg6IItvIVoRkYZTWy2PskK/aofhryN1UXmtY1ej0kTpbz6v+A4dqw2KElWVzVzkuiJxpeLrovykCY1P6FVkFWl3EtLtO3ESTzdyIsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FvIcRcyFiWYfPBQNQHiyqeo+MVBkXxUrFbC0h17Jjw=;
 b=yQNqICCzOe6oHzNDNg/jalqm3zipzUmXm7N1zC1CV+pfybWnqawyjm+9Upt0DXUaIwfJ6bFR0BccKBJFH7CgjaBqhxEN6HAfscTLLJKjWHtjym0BIJiEgu2DL26fVu6NcabYUe0sc7M/mk2EOj1xKvODOcU4vbPpZb5t0cxApy/3uVy8+5pVU5iWLT5Vpk5HshaKCAxUNl1EEve288QD+Ewhquo6sHLszrXxQvEF0g6vrixasYyst9nJ0PGq8qvpquE8caB8WoiwMZ7MHE3Y/NVskUVGRDDjTJp/8GxUaqi//1zBiwbdJU/GYTtgZs+Jspg+N33PauqwZhhSZ9mAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FvIcRcyFiWYfPBQNQHiyqeo+MVBkXxUrFbC0h17Jjw=;
 b=fw3bY0FWwoY/sbwt0N3O17npQtzIvVRlFATv0CiZNExDZPLNv83Xc/7FwPKoVcC5LN+ZiU9ov24tJmOrIfkI77uZHOSa+Atp0BFDrBVL8nVTnHgR1v5fZeA+U0N0LEOxfI8HCJXDeiF478lWNGApNcvdO24DVF09Za4Y1dLyypY=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAWPR02MB11166.eurprd02.prod.outlook.com (2603:10a6:102:4ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 14:41:49 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:41:49 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "WXbet@proton.me" <WXbet@proton.me>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: WXbet <wxbet.oe@gmail.com>
Subject: RE: [bitbake-devel] [PATCH] knotty: show elapsed time on the task
 progress bar
Thread-Topic: [bitbake-devel] [PATCH] knotty: show elapsed time on the task
 progress bar
Thread-Index: AQHdL0k9RSgb9jpjW06sUpw1s+zcnbakOBIAgADRPICAABOrgIALRzBA
Date: Wed, 26 Aug 2026 14:41:49 +0000
Message-ID: 
 <DB5PR02MB1021395256F54ECB1AC5FF3CBEFAE2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: 
 <CANNYZj9uDoKqqx_WV2CZ0-Q99AdRWzVUXD4idpcrZMf2Zpw28Q@mail.gmail.com>
 <20260819093321.3451-1-wxbet.oe@gmail.com>
In-Reply-To: <20260819093321.3451-1-wxbet.oe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAWPR02MB11166:EE_
x-ms-office365-filtering-correlation-id: b6845096-9b34-4164-dfa5-08df0380296a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 
 S1HXYKIDstdvGb87YlEQGgGyRuMVQstxmCFCHpzM6WCTbJweDucy1AC/Z9ivcU+/JCq50d8/Yx07C8fWRzZHbit3CwJx6yyROOmGSyRQBmb07Xjz5emw2bIQ9dvvpdIzCxKoi28smHzM6+YQlYwqy5kp+oIiohfm6tVYTM4UzskS8B6Skb1+0NMArTrMiW5fATuiHgepFu4MmcMhT1KTGXAXrVgZB4syOw+VrmrkFpHS8YV/nSdK9ACPLWW/zw/KK8GLqL5wbEcip22jPgkApq/BLNtNKtH84HCVO4AyfbKJ0WZaqgjJ4qVbe8Y2qmnil6od4Hp0cU4VrU91x0dts98EwsxV6IyRaOWCoZSS+JAxaTyjApgMECyrbDt7p1l64k7FlE2k5RLwEppgAHKr9QanIGsUMa9UpTYiUxNBIyvxyrFK2Qs6wYQIbnHTEevfhpOstiTKcdhwKKEcrRLmcChKj347JlmHdi1aj+JE6QdBLl0m5RidTLwqa2l5bsg8A0gvGkdmKqOMoQzLdw0ViFEO2gAZhsJwowkB9d17Ul1GXLnpbw7m6QF00eydoXDDQ1RCOmM19xkhhfd3Vd6txautrSEuE2Zb+hNi9lOiVfTzo22mfVbS+/2f2i6AMi/s1hNprhy05m6LukdDCzfGDo1LFoRNlQzoHlrDjM26IvyyPYNFi3SOYE+H1OFq7TryempKJvGCkfXdfRPS2knxgw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OPZAdZjhPVVY4/skI6aGtdrpVgsU8mWNZtDTcLJqnXNPefPbgSzCJRaasWAo?=
 =?us-ascii?Q?nSDAB83ApQcCRfg5msClcBxMTe4jyxEw6rEha+kAD7ZW/oE7zpHZLaPCOG1C?=
 =?us-ascii?Q?zEJSJ3G/zCoUg31FjaTL93hDiH0t9ohaoYmjbl1OiYJ7wyyK0XWIH2xgs/G5?=
 =?us-ascii?Q?sKgtV6qlwZWtOKAiiecRWWVqCDbJPdr7GA5Eao2o3chZACnyAF/nhFqfK6Ej?=
 =?us-ascii?Q?BosVAFw/NWCbcSWa3sz/E2TD4SIkJx8KV6JgVx3Zwr7MhCjv2sJ+0q9Otyed?=
 =?us-ascii?Q?MKF03LE0i1lf6s3yGynZt+pP/y6LAU/88rTrx9xK0a+rWU1Z1uHMI4dckH83?=
 =?us-ascii?Q?46Rt2yC3GornJPws1IkTsgql+zHLO9mmquAEDice4QVqo7TffokQNmzfAjyJ?=
 =?us-ascii?Q?Pam/4CUOzApoP/2epQDjBLLWWp4fKQc/MZNSV2LEhnYdgjJqZgL0vvWcrWWw?=
 =?us-ascii?Q?41S4KtvvjCA9di07tPRDt4S3LVhxu3Z7/RKeXKwoJxRm2zBz6lqCA2ql+RvR?=
 =?us-ascii?Q?uXHhFB7jH3RWWYJrc56Xv6Wa8zpfVMynMuqjkpKD5mWJ0hox0CZLVhIHnmfu?=
 =?us-ascii?Q?mrIiKpWaJ2mJZUbFBI2g6WbtSHoPVHI5UevDVitqaRHGUqFLDDen0j897ltk?=
 =?us-ascii?Q?ieecpHby8fetXZQreKfgRTwAgb98CpFl2sFkqpQ8R9l3nw7lPhJbs1unWhNw?=
 =?us-ascii?Q?FYS7p6+Qck4yTQYjGiau9iCnOR6XiNPF4JLhv0yCf4bSat95N7Y8/lcqfj/+?=
 =?us-ascii?Q?5VNQ+3kS6rN3cKlbL8YTYx2LdqCnzQujSMkMDus1m6Hwklz1LjFcFgYGH2yY?=
 =?us-ascii?Q?y845/i8ASY+Fg5sckcfntZNDHWW50qoteBgULqDVV3B0n5BhmA8D6vm2CxBt?=
 =?us-ascii?Q?JwT76H/wzZwtvV66usUiqjCkJ4YiTZktT+DLEMjYhJVGdVQGx0b5TmO5d9CB?=
 =?us-ascii?Q?KcYi2oOM2oBAvxKiu1gNFTsXrFbmHnPDG0DekNnJ0kTj8cxj23JSZDojNFvI?=
 =?us-ascii?Q?z9vBV6j0OCZl1YFDoSXNV/8p027ANPOdI/RmP+EtIGuVi7k05hUvpiEb+qEZ?=
 =?us-ascii?Q?qGPEdd4rIXHQg+7ZYmbIYGxPxj7ItRDIJoUSKZPsi85nLbhxw3TcTqjWqSPI?=
 =?us-ascii?Q?Mh6xjDfqHRpVOv6au3xgVsQ0hQ/HaL2MDeT3bP0ihX7uD3zlx6Ou4GlPb67q?=
 =?us-ascii?Q?qStgMkfLY3zMr2XlWEyK+LdlgUIYZu+7t56Z33h6uw16H6lkb0W6JGv/iBsO?=
 =?us-ascii?Q?osnDEKwUVEV/yFIj2hh7s4CFeat6D1koeL0pMS2bsxvBdeJQ6sy8vlQs4wsG?=
 =?us-ascii?Q?IGf8N9taxpoHPZvoGz7RiDk1saBL8AmwDF43inXBv7RRYGB7h8iwzAhTRda0?=
 =?us-ascii?Q?5lLim1+oVBo5yJu1Hw+ACiB73Pz+w4GgSbXjV8rVcTQ3seRtB9qpqQ1x22zD?=
 =?us-ascii?Q?rC3dO9bio/fr353TqMnidudLqlpP6Q/xA45fGqxFVJRj6w+KyL+P8Bcp1lxk?=
 =?us-ascii?Q?j0nq4tw8/4EtxImHpguxsH+kjXwpCen4bp/CX7GDG8zdGLo1+RwKHvFAo1oY?=
 =?us-ascii?Q?gndTXqwx4q/CEJugUa5Fx0aUCS8I0HkRMS/pFOZvxO9rH8OhvrCk6NoRzjAd?=
 =?us-ascii?Q?wcqLYG6/yJCQSCZTe2NC0/zH6wRyH/8edWImB0SYcjz8vk5sN0tsV4b2XfwX?=
 =?us-ascii?Q?rT2VqEzOwlh4nw/R7kMzQNK5swU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6845096-9b34-4164-dfa5-08df0380296a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 14:41:49.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0gTqaWI5tYjemzAV6EUMXtDh0zWdmriT+z4VyMen7oYW+45qSGl7jFnE1TaZEYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB11166
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 14:41:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20058

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of WXbet via lists.openembedded.org
> Sent: den 19 augusti 2026 11:33
> To: bitbake-devel@lists.openembedded.org
> Cc: WXbet <wxbet.oe@gmail.com>
> Subject: [bitbake-devel] [PATCH] knotty: show elapsed time on the task pr=
ogress bar
>=20
> The progress bar for the overall build shows a percentage and a bar but n=
o
> elapsed time, even though the individual running-task lines below it each
> show one.
>=20
> Add a Timer widget to the bar. The time formatting in
> TerminalFilter.elapsed() is hoisted to a module-level bb_elapsed() helper=
 and
> reused by a small progressbar.Timer subclass, so the bar prints the same
> "%dh%dm%ds" style as the rest of the UI.

On the other hand, the progress bars that are shown during the initial=20
phase before the build tasks starts all use Progressbar's own Timer=20
widget. I think it makes more sense to just use progressbar.Timer()=20
rather than BBTimer().

>=20
> Signed-off-by: WXbet <wxbet.oe@gmail.com>
> ---
>  lib/bb/ui/knotty.py | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 15025e8dd..343045881 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -37,6 +37,21 @@ featureSet =3D [bb.cooker.CookerFeatures.SEND_SANITYEV=
ENTS, bb.cooker.CookerFeatur
>  logger =3D logging.getLogger("BitBake")
>  interactive =3D sys.stdout.isatty()
>=20
> +def bb_elapsed(sec):
> +    hrs =3D int(sec / 3600.0)
> +    sec -=3D hrs * 3600
> +    min =3D int(sec / 60.0)
> +    sec -=3D min * 60
> +    if hrs > 0:
> +        return "%dh%dm%ds" % (hrs, min, sec)
> +    elif min > 0:
> +        return "%dm%ds" % (min, sec)
> +    else:
> +        return "%ds" % (sec)
> +
> +class BBTimer(progressbar.Timer):
> +    format_time =3D staticmethod(bb_elapsed)
> +
>  class BBProgress(progressbar.ProgressBar):
>      def __init__(self, msg, maxval, widgets=3DNone, extrapos=3D-1, resiz=
e_handler=3DNone):
>          self.id =3D msg
> @@ -250,16 +265,7 @@ class TerminalFilter(object):
>          self._footer_lines =3D None
>=20
>      def elapsed(self, sec):
> -        hrs =3D int(sec / 3600.0)
> -        sec -=3D hrs * 3600
> -        min =3D int(sec / 60.0)
> -        sec -=3D min * 60
> -        if hrs > 0:
> -            return "%dh%dm%ds" % (hrs, min, sec)
> -        elif min > 0:
> -            return "%dm%ds" % (min, sec)
> -        else:
> -            return "%ds" % (sec)
> +        return bb_elapsed(sec)
>=20
>      def keepAlive(self, t):
>          if not self.cuu:
> @@ -354,7 +360,7 @@ class TerminalFilter(object):
>                  msg =3D "Currently %2s running tasks (%s)" % (len(active=
tasks), cur_tasks)
>              maxtask =3D self.helper.tasknumber_total
>              if not self.main_progress or self.main_progress.maxval !=3D =
maxtask:
> -                widgets =3D [' ', progressbar.Percentage(), ' ', progres=
sbar.Bar()]
> +                widgets =3D [' ', progressbar.Percentage(), ' ', progres=
sbar.Bar(), ' ', BBTimer(format=3D'Elapsed: %s')]
>                  self.main_progress =3D BBProgress("Running tasks", maxta=
sk, widgets=3Dwidgets, resize_handler=3Dself.sigwinch_handle)
>                  self.main_progress.fd =3D self._footer_buf
>                  self.main_progress.start(False)
> --
> 2.53.0

//Peter


