Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF69ACF9C71
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 06:53:21 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.92.50.15])
 by mx.groups.io with SMTP id smtpd.web10.7968.1727160792357487736
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 23:53:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=Vi/Ou3GU;
 spf=pass (domain: outlook.com, ip: 40.92.50.15, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3SgwGuovX2/famwvzGEiuvtIy1QhmtUHMjRu9WyB1Lj9GXz+GknuHpJCv9WiBYK43FhNHiXlsz/h4AkIOyhktTD2SPVrWG1xBKA1GbkjasYlzv92Ng8PV74AYC0v0w4HUVl7tmGxH0iZ4DF1F+akr12KO5mJLW3PTXZjFo31p+s1di8SsMxisQaW2JmVUzEhW/5/lEnbdRsPyiCNcFXLeIi+g4QR1LB4Er1KqlE9RfQoxtA/Ok/ZtfT9wI1BSHIAzAhxVyx6b2PPBCsLJc4097RRFDHYFG0dW/r4KoBL98VqE5XtfiSt2Lr1NHJqAxwonPT/zKMYmKAMYnaul+sVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK7Dn2CN3/UNPW++FBh4GOYGRXYyWrgOlisLexQRLfY=;
 b=AxO+2OMgqyoAdyGkuxCx0dl0+oct0kZmN9xQU8HIh5BEcii+PR56G78zRx5AVGQCEpbLCp5GEKrjcWumyfCv5aYyL9Y+ofGcAmJT9yR0kiLSwc/h9alZHgAEEKG8n9nOmpEXeC4Y6Y6P+War7uwoGTiKdvVqNYvE2dVd50gji68DNJ2SFICwrilahjRuGY2IcS8Srv39iuPpQ0bhLbSC4Masbi5BWFpnkHSwszONONlT+K+14E7xEGJzsnJY1IFSvqiZJEHCqiQI7Op4zYK4WCZm8klvdb2oCfi49/OaxIWCb50No8EFl/MctQMHtKOXzlcFdYHySsKEWSyOOxxBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK7Dn2CN3/UNPW++FBh4GOYGRXYyWrgOlisLexQRLfY=;
 b=Vi/Ou3GU5yyMZOx3kBEV4ZwmneOr+pq30kb4w1zspTVeuBlHOh2cAizFJnd7mMvIyVUKFfvblGuFxpC71Y12zGJM2ac504bthBH4mYw/gNXOOpr4zMsdx0PKZw6SI4XQWaOBLseZ8OuovGIrbccIRwOTSLaAm70qzkE+X7NYrsEKIXUKrvY2EaWs8AQuTYDQAO0H7kPYV90Mn3mEvLfdhMkzcowtS5blVYAPKTLxvKaiXBLqLFXCbFnncQumK4Cs+l3MnPgKh87VkVnrKVltb1jr0XP+w+GHqqQHW93qgEfrPHs8P8/LfrrQlQm9HrUeX685pTsypBs63BnszHvDtA==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by DB8PR07MB6217.eurprd07.prod.outlook.com (2603:10a6:10:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 24 Sep
 2024 06:53:09 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:53:09 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [RFC PATCH 4/3] data_smart: remove old override syntax check
Date: Tue, 24 Sep 2024 06:52:51 +0000
Message-ID: <GV1PR07MB9120FC24D85ECE5A38069B0CA8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240924065251.1854249-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|DB8PR07MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 401cab49-97ab-407c-10d7-08dcdc658cc9
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|5072599009|5062599005|7092599003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: 
	52piIzSDrFYIkxyJMwCr68umTPm8LK0Y0t97OyyUJ9r4+Q0kPQoFX+of9j4PEzCIdS0MQohf4h/jXNttok5x1Xx35jgat3X+Xi0nOMHC7PiXiF0muYtS3G2WfPtMaDYdCWA1b2ECOmsjEZZd9pV9quqmNbFweUkyJsEHArAdK6kDH7gwBpOj7KB5IIy5pbL0kYs2bmjJNQhhBoeDOMXBv7IG2M184kxFL3/niUvI3BK+aVkQQzLTMDR0F/EJbc+yQzNSBaUi1ZL6XVluYk4qY2Nk0haKrN+8jUx9u9P10w8JJnNldsR341bEtKnbHMUofQ2HHLcLSzsZ3QemIbY6A1/0yVOx8bkhttPtoxNPQjSlhEnH7+B62f68W8AU4tg86btVg31YFNROJCKlp4AmktcC3psJOV8QRI8jEIqo4QiwH13nnbtcQHWxRpf/178j/GIug/U2N/sIwaydJNSG43G/BOZXqBZjYdMBSM8us/eDLaPixrG/JZgc/fKvLEkPzDfxJd0LxivOeq6pT8Dd1LVkvk9ozKxc4H02Kr/koSuLlj4QYRcMkbeCl/9EyhYFEZbUB46xOsoNPK0Mzx//3t5TWh+Eg4zCtfWdLkePNxEd5+lRTWimbtoW4y2kzX8QNez8QxgrzD6uzNmbg8ahoX6vOJnzr/1GWyQKmEpic4HoRFXXRKYWALPqyiLeLM/T6joiVwx4Z0U7rNf8TKtNrkc+wzjlnTmbXq38pcjSwuLXJ3ho1QJv1sK1+L+4RCgiGKIcnbw8D6Ri+QLKrZcBb7J1YIpStPfsXHkgLWMQgwc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xtzaKh4Iy48MeWj2feAe8Tho/4Lxn4OgIzEPVQmhUIZEFAy9ViLO2K9iHKn9?=
 =?us-ascii?Q?OeecHLuUCOQ9MVoqtaMAe0GZ8kraJJS330qYoc3igpym80DfaCQvE757TsVO?=
 =?us-ascii?Q?0DyFlwDh5Esc/5SSAKUJg6NWZcV8tN4VmHw236MLvxjJOH4SxIFzP4kEOCcp?=
 =?us-ascii?Q?zFcTlYIVsPTLwQUo9wbD+sXJB2M3egRmjeSoI8A1GspCyEPUtS6RCMOPYhX6?=
 =?us-ascii?Q?vmwx0KrhAPalV2bQlrnRFjpOR/cBCnUXau7JLNWTZKsz1b+MuOKZDwR3zWkR?=
 =?us-ascii?Q?1N8I7bii1FIMjp3GX/+AuQZxyKxW8k7TjPvSMPKrAEKdFjoJJq14CrqIhU7i?=
 =?us-ascii?Q?YGaUq72opHUmw1ECozjJPR8Rd3cxtZYNwiG5K0XCG1QuxYMccIvhRqnjfuCF?=
 =?us-ascii?Q?SjIjoPmD7A46NNRjE0WuIB3n2yS3ZvrDLn+6a0/R4OqQTjhFgpy9H4GoMseB?=
 =?us-ascii?Q?AcSxO+q1O1IcZ3iHUVLarcZPJaf+QycGNmFGr1C/lSNL/JH7okD6q81nDpo8?=
 =?us-ascii?Q?i90KRFRFeB3gw7X4TVLhFyatMk/YQT1EQmPFMAqdlqnz4bFdzRZzrxdd3MUS?=
 =?us-ascii?Q?dHypjNmFtcQOteg0JRJ2YmbRsT9nJw5dHLHqAWOIHCuBgHl03HApbn0rK/g2?=
 =?us-ascii?Q?9AO7YftMco+J816i6oG6wFjv9yaHdQZov3b8WjwZ8Bsj5M6Wj/JGqdT5lu1Y?=
 =?us-ascii?Q?TZlcxeLFmrBz1L4iuelV7Z9JnpartK/EFaWSJyz5vsrk3n2YtZYf54tl//Ep?=
 =?us-ascii?Q?bwsQ35M4KlU+lsrg6DHvq45WwJDrRdvP2jnGr+HvUE46pQbrDueI7TCk0ahf?=
 =?us-ascii?Q?z4X+WqewxqjJB5cS9HRBHMDta2VpMZiHEpZUMJ2eBAbCHzZxC+0En7fJ+UVN?=
 =?us-ascii?Q?muYjC9nx7Coa22z41flQangfbO7mIhegoPA4F91NSlhxPo7JaAqx9Fh01pgX?=
 =?us-ascii?Q?JxMEsIS3a6TpyJ92JIhGAwoLVLpuvRh8wkR/q78cUvLbA6SxCjBnW/wVt9A2?=
 =?us-ascii?Q?aXFRzh4+r1JQ1GqPmNUVcL97TBi500rlASbF5gFN0NNBuMWner/W8JXQ97RP?=
 =?us-ascii?Q?rUXYvTvmM+DspnkFRJntAmEATFYshb2nprF7X17mLh2ugpZdv9ZtkQ+y6Lh0?=
 =?us-ascii?Q?NkQ3OBbankqsV/Xgiuo964rOdsigb2ya9tArxhTTiWMkASk/mbabIyCvbbtn?=
 =?us-ascii?Q?+hauy8vhJMc+C9oUW0jvH+Z83tBfhfAdIBLUiRN/jKRiDiWNAbecXy3Qo/5S?=
 =?us-ascii?Q?TAUvx8p0wnG7NTP+qHC9KcDvyHKXyzQjuqddIyJhK5TJdU3xDtohIJIMG5KP?=
 =?us-ascii?Q?6Lw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401cab49-97ab-407c-10d7-08dcdc658cc9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:53:09.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6217
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 06:53:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16594

after the override syntax change is now out in the field for
a longer time, the expensive check for the old syntax can be
removed.

This will save time while parsing, and should be side effect free,
as variables in the old syntax are simply rendered into
unapplicable variables.

A more complete check (e.g. RDEPENDS_${PN} checks) could be implemented els=
ewhere. as part of a sanity check

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/data_smart.py  |  9 ---------
 lib/bb/tests/parse.py | 35 -----------------------------------
 2 files changed, 44 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8344981fc..fe4c50740 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -539,15 +539,6 @@ class DataSmart(MutableMapping):
         return var in self.overridedata
=20
     def setVar(self, var, value, **loginfo):
-        if not var.startswith("__anon_") and ("_append" in var or "_prepen=
d" in var or "_remove" in var):
-            if re.search(r"(_append|_prepend|_remove)(_|$)", var) is None:
-                info =3D "%s" % var
-                if "file" in loginfo:
-                    info +=3D " file: %s" % loginfo["file"]
-                if "line" in loginfo:
-                    info +=3D " line: %s" % loginfo["line"]
-                bb.fatal("Variable %s contains an operation using the old =
override syntax. Please convert this layer/metadata before attempting to us=
e with a newer bitbake." % info)
-
         shortvar =3D var.split(":", 1)[0]
         if shortvar in self._var_renames:
             _print_rename_error(shortvar, loginfo, self._var_renames, full=
var=3Dvar)
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 2da3a2a22..6832952f8 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -132,41 +132,6 @@ DESCRIPTION:${PN}-dev =3D "${DESCRIPTION} B"
 PN =3D "bc"
 """
=20
-    override_old_append =3D """
-EXTRA_OECONF_append =3D " c"
-"""
-
-    def test_parse_old_override_syntax_append(self):
-        f =3D self.parsehelper(self.override_old_append)
-        try:
-            bb.parse.handle(f.name, self.d)['']
-            self.fail('Pattern should have raised bb.BBHandledException')
-        except bb.BBHandledException:
-            pass
-
-    override_old_prepend =3D """
-EXTRA_OECONF_prepend =3D " c"
-"""
-
-    def test_parse_old_override_syntax_prepend(self):
-        f =3D self.parsehelper(self.override_old_prepend)
-        try:
-            bb.parse.handle(f.name, self.d)['']
-            self.fail('Pattern should have raised bb.BBHandledException')
-        except bb.BBHandledException:
-            pass
-
-    override_old_remove =3D """
-EXTRA_OECONF_remove =3D " c"
-"""
-
-    def test_parse_old_override_syntax_remove(self):
-        f =3D self.parsehelper(self.override_old_remove)
-        try:
-            bb.parse.handle(f.name, self.d)['']
-            self.fail('Pattern should have raised bb.BBHandledException')
-        except bb.BBHandledException:
-            pass
=20
     override_old_valid_append =3D """
 do_appendsomething () {
--=20
2.34.1


