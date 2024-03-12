Return-Path: <pab@pabigot.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A4AC54E58
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 01:09:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.102])
 by mx.groups.io with SMTP id smtpd.web10.1492.1710205752278275752
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Mar 2024 18:09:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pabigot.com, ip: 40.107.243.102, mailfrom: pab@pabigot.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFUtNBFteygYeiycBkTJSSlH5IWp7+2RP8nfrN8toeBicqLxSG0vuIvEElWciXuTsyM5byN0ZWEMm+NNDLeP8/U13dyCpmLkLIrDAdRryhqfSUdx0v6GkJ0jBi5Q5B1vYhAE2CnlVdFNGvzRXWPiK6di1cIZ7hpl3SuQTmnjR9B3PcQ4TQGIv+jstCu85k2WoG41PcNfKxgNZcwEizTK9OvjTGn7b03aRWPvSITBcnENr0VgYsaKqZ9CcP8pGOUY0zIaVs65V+djNkRVaZ/sjyO0JNWyD93YOSGIrtRv0WSoZ2ekUqJwNTI453SUwTkv7m89bUnqMaT5bUCTSFsGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUi8oxRgoPwTzdHBV5vvfsQJk9W5/4zdJissDq/qOok=;
 b=V0wzJJDmJYCkYVS2RlOREZo4bxgRkLQjpK8jZ92PyPP9RGZvsH6cqAxo2WcFj45uWnAx9BjcN86GMbr3ccCLMRhgO2d0vjmrz3pH5cIxbxuaZeArohjOi+aQ7iiMZC8n0pq8qKgRaHlszwOWmKF2swg4svwdAEHMTs5jmb+i1jCgdp6p9DjWb9l7IMl0YwLWTIa/9ZMb6TSEfVcieeviA7lOpt5Es/60xyKPk0JPxr0zRWT/Gx9IfT/ZGpr8ptF9Yp2Be5/CUTsmHj+fuY5vQktQscQSNtuBdPdf09bhqB5XwpruN3Q6ReIUcUAa+LqtBP0pGSaG0yCgcLl75pcMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pabigot.com; dmarc=pass action=none header.from=pabigot.com;
 dkim=pass header.d=pabigot.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pabigot.com;
Received: from SJ0PR22MB2943.namprd22.prod.outlook.com (2603:10b6:a03:3e3::22)
 by SA1PR22MB4573.namprd22.prod.outlook.com (2603:10b6:806:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 01:09:10 +0000
Received: from SJ0PR22MB2943.namprd22.prod.outlook.com
 ([fe80::b463:94c2:e05b:edfa]) by SJ0PR22MB2943.namprd22.prod.outlook.com
 ([fe80::b463:94c2:e05b:edfa%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 01:09:10 +0000
From: "Peter A. Bigot" <pab@pabigot.com>
To: bitbake-devel@lists.openembedded.org
CC: "Peter A. Bigot" <pab@pabigot.com>
Subject: [PATCH] lib/bb: support NO_COLOR
Date: Mon, 11 Mar 2024 18:08:49 -0700
Message-ID: <20240312010849.943016-1-pab@pabigot.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To SJ0PR22MB2943.namprd22.prod.outlook.com
 (2603:10b6:a03:3e3::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR22MB2943:EE_|SA1PR22MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 972e7256-c251-4bde-de85-08dc4231060f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2yZPnNQVq446z+CxT+r0qyVsJ1sg01LCCnqX2CNOsY8ZkB4q6rw+lEb1vj18mmrodyvcOP8jnomESPgIFBao6M4eyAaOp3EnLha0S+U+M6L+93HutGIqOE8BdhKCBVnqYMOgg427tK0DjKUyy5aFHfi88ziLFsFHeEIba2K2zvMrBgOfeC1+YmAk7B+qcbPhO4PATWvtKUTBZ8ur6RjTTQ9OkZ7HgzKOJlQzRCpESSzAJk2AJ3v2zZ+RqZWxtDRsjZMA/UtEjq7tF8PsGq4FxM4HdZD0W5Qayx5I2pfNkOSdxfQxCBpAcDaAJXxCgphvoeSttGoY1Kfv34Trd6LO/L6iZn69ZRuEnJOKHJIMf51rNdIR6+ZB7o5tF6EUlwk0z/Y90XoE9qnYf7XgzBx9GJ2fcpsIqpgefayFZ/lt3zaxeZ+H2C8sEocjUNVpYYqq+sR+44mIIcuFp62xO20+hq7SUWE0PZ/rm9uPt2AxcsONUXF8v6Zr5CDX5q3leqUNDj+/cDKoY1rCYiUPWTj7gCqm2yk5ZlBg8xd0VGcW6gaWe+gynS9O+faWuaaA2vNqltaJuln6yn+wsM+Aw/9RH17S3dDJkHGRkPuK0jBHjsEinEQM6blklywhYQqvjpvI7SDAaqkEej/f00MwK9MT6M6+NutCtQOr2AxOMK0P7Bw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR22MB2943.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R0PZaMjamyFSASUaQ37cbrDTu+UnwUYt10qAhrIVVJL9+OZYSBVST8AFWQyY?=
 =?us-ascii?Q?jYQWEyrqJcCOv1woDBrbwaK1c8wjgUpJCTkjtiuXSlPsqHuASnE6jIVFGkmM?=
 =?us-ascii?Q?Gw1MiO7qLNK2MRClH/cW1yCpip65VAqAHrqEjhCJZyUI0jEB5XH+mvBNZEB+?=
 =?us-ascii?Q?vNKuOSMMKPTFsSeZQK4akBZPb29pm23lD2/aBB2Wzu9rawT9sGU3s/IRFgGq?=
 =?us-ascii?Q?60LhtLuaxbJBTcV3ueiYKZ9ZarVSl5QNQPWFJQ8q8VyUkbop9zF+O+H5/XyC?=
 =?us-ascii?Q?O6h/eiFsOX7DSVxmLgdOryB1M41dhCO/hzf7xJbA9cz7jsKCNvzWbHxHC5ny?=
 =?us-ascii?Q?l/khZX2xdD8WqMyWn3vuS1fPKkDdyPi7JH1malFnlzdYyIw/50S4/RksyFff?=
 =?us-ascii?Q?1Q8y421SjzUIM9vjMOGFZDxmC57QTguoXQx0N2d1yInNytVdkitCwzUhP9lI?=
 =?us-ascii?Q?vDjhpYw+eG+eNBX8YakKEphGUuwLKH8AeSHcdH6PoZQiJdQS7d+Tje5nlB7N?=
 =?us-ascii?Q?8ZhLhuypNrEMeb8Tyh6oYy8f0v77FlOfhtyRL1uL1rVwTpr8JopDvGMxMUDj?=
 =?us-ascii?Q?sOl88uaOLE9jEP562CY0sbPGFJW2bhsXZ0wSFdBYE+X3GDFBGQPGdwzy5pUk?=
 =?us-ascii?Q?+2TxL1uI150NyOpQTTjSwXQP+xB8CJ5Xs/7n5qKHF4uouFagw+HTqmb3rXOU?=
 =?us-ascii?Q?KwTXct+k7Oi8DEWRLzijxYKi+X/fnPeJoCdZrOHvGqKwvqXW8VUQ/OHmy8bn?=
 =?us-ascii?Q?tFfaDdM5PhfY0RMtQNmz/OULb5X/P/XGCydKcOuOfPtWV9lkf+lUtnHnCsGu?=
 =?us-ascii?Q?oiLbjG9VBwEyLDcsA4byqiXlgLOOYPiikzntISBIPFMGiALPJjb61l6O8wA/?=
 =?us-ascii?Q?UR1zsRqFSvO8pUh+AvXW9uSGtUVJsPm6Y3r0BbRtCj8+HRI5gWS7qKgBEhbF?=
 =?us-ascii?Q?uQZIyOzIjHIFhacIj55ayeKzaTYx27ZGPydalRP///3YkGiaGN6P1mt0h024?=
 =?us-ascii?Q?FdjYrtGqCfaKLL7EfUS5/4CTXgyiSMj5/1zaFU/3YoZd8cPdLrdyCI5rBENn?=
 =?us-ascii?Q?YKaHTI+ZN5OifxhcQ0hOtxtZjzFak5PKLxLmvekQk27IyDrS4EWnZUdQYPHb?=
 =?us-ascii?Q?/ejtIwirZJf6gmNINvtJeR72QPsfTaDUcRFfFUgSPmIqowNhWpdXpgOZgz7K?=
 =?us-ascii?Q?1PNOgvj31kAsJL4OdlNm/TGXRYUrDufYMkgkBh6CnyW++BmOd5AoE0BtKVlO?=
 =?us-ascii?Q?psL6M3vtzyfqYjEz9sLnrUenIO8r2Ov7Krf1GKBq23SpRIOCK39Jjpissovl?=
 =?us-ascii?Q?5Mum/bL6nEvorJJY+oIL31lj53TLVZ+TrO24sxL6X68fp6VX8EsVn55cBIBR?=
 =?us-ascii?Q?QxiZT8utvjjjP6LI7TG5GXPhxJrhGJERlG5OKpsuRe4kadhkK/ZX78DX0r//?=
 =?us-ascii?Q?pzC1jzTmAfD918WhiYnK9bXL6etv6SBt4vZLEjN4B5pjI3AKFMDmb96jCeOK?=
 =?us-ascii?Q?aagaPAJoXLiSrArbQqbTa9MAFZAFJofk0XBTNOQTs+3vtd2+Kr+D67Q9b4vD?=
 =?us-ascii?Q?noNngGR2G/H7Yq1quC/XIb6LY8t6O8D9KdiV/+Bv?=
X-OriginatorOrg: pabigot.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972e7256-c251-4bde-de85-08dc4231060f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2943.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 01:09:10.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 93ff3220-27ea-4632-aa49-46b51ff93a85
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjNNCp1myQxGbGFgzvDmcuw3lb8JTlxWY2gyvPIX+6yobh9TjresMIl9/AOOEaal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4573
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Mar 2024 01:09:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15997

Red text on a black background can make it difficult for people with
visual impairments to read the text of error messages.  Respect the
presence of a non-empty NO_COLOR environment variable as an indication
the user doesn't want colorization to be automatically enabled.

See: https://no-color.org/
Signed-off-by: Peter A. Bigot <pab@pabigot.com>
---
 lib/bb/msg.py       | 2 +-
 lib/bb/ui/knotty.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 93575d89..3e18596f 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -230,7 +230,7 @@ def logger_create(name, output=3Dsys.stderr, level=3Dlo=
gging.INFO, preserve_handlers
     console =3D logging.StreamHandler(output)
     console.addFilter(bb.msg.LogFilterShowOnce())
     format =3D bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-    if color =3D=3D 'always' or (color =3D=3D 'auto' and output.isatty()):
+    if color =3D=3D 'always' or (color =3D=3D 'auto' and output.isatty() a=
nd os.environ.get('NO_COLOR', '') =3D=3D ''):
         format.enable_color()
     console.setFormatter(format)
     if preserve_handlers:
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 5a97d040..f86999bb 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -179,7 +179,7 @@ class TerminalFilter(object):
             new[3] =3D new[3] & ~termios.ECHO
             termios.tcsetattr(fd, termios.TCSADRAIN, new)
             curses.setupterm()
-            if curses.tigetnum("colors") > 2:
+            if curses.tigetnum("colors") > 2 and os.environ.get('NO_COLOR'=
, '') =3D=3D '':
                 for h in handlers:
                     try:
                         h.formatter.enable_color()
--=20
2.34.1


