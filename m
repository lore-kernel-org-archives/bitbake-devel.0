Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D1CF9C6B
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 09:10:22 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.92.59.44])
 by mx.groups.io with SMTP id smtpd.web10.9396.1727169018699167179
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Sep 2024 02:10:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=Zr+FMbbw;
 spf=pass (domain: outlook.com, ip: 40.92.59.44, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyD3PJYEaEd5WZQvFQ/G0tZJN1dTASv7ZBgu8gURTH/npCVBb7sft5wugakmseZ4qOLR8ZtgKPSAyXC8o/jK0a1d55Hlp9kvqjUde+eEasa7rCzqKQpRnn7w/zNAtNxhk5uzgvC+f/H39/k7+D2f6TAUkFvbBP0I0de8UXpK/UV4MnXnPN0ggwtduNFBt1Bno5CmS2lNHtbpUmumMLzxkB9jFz1WFJCIcQzMt9jVCcjp4Xr1inUwsEqt0FbBYayFAnMhefNKm76r+Qz7Ps7H89Y1C19k4rgPwbp2nf9SkF6f7M7wqXMtGuf4mT401AFBJDvdHhieUhn64WrXTrRfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj7pXqVYI+BgcrdgnHCdTQdtZbqDW5clkupcytuLKrQ=;
 b=ls9jfM3gngfNQf597zWPOlUbs7RyFFsfAfabGuRVQj9VuglxsvKqd9kG2WewmmAH5OiuHR2zPJ3EbPCVszEvaLbGIlaSgFpt38gOiOjBCw68b8aoZpclsaNJHWp3NsgMfgjobM+2FmVRIaQAgC+zDpHHyY0fzNV2HDyUYqgATEb//SeY22h9OPDwhYXRheYYDUJ39JxKqVNNWn8ALJJCv0PwQIjTdctRc29R3n95IunWhdujtVTaFgdwng38oh7R0m363D0/lP88mYy1eP4Unl5Jjh/mshfjzAc6h5DiZATEFnQ9apsfK4yglfg0kC8yITc1gWxGl0UTAW5iq9NTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj7pXqVYI+BgcrdgnHCdTQdtZbqDW5clkupcytuLKrQ=;
 b=Zr+FMbbwq6ml5kjC34tmplQWegKBlA3s1WUWzkyWxspPZCj3VpVTTbD1OmGsKfjxrRvbknZzoZURUW0esvNnQAi8P4mkQc9ritiJyqtWmAfNWAalXcyDaZ09/OaL3t5Ic0HAcfvUv/SlL5Z/Q5sIOGKemmkDNBeCIW2r3nOJuYKR4Mp8i7lE5xSQdH6hffCI+Hb3OPYQqiqfJEGlu7xk9ePCjxbTA/d2UIyGcNUPdgJgeNnpqzISCWfQxhcBATCBg5D6YxQvBxiJO2SSn0ZiABJ1j8loPX5o4Sax09YfPuIbci293ApyJHAEZKCgDoY47BGmyBnPQgwiz4ntSjSEGg==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS2PR07MB9491.eurprd07.prod.outlook.com (2603:10a6:20b:642::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 09:10:16 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:10:16 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [RFC PATCH 4/3 v2] data_smart: remove old override syntax check
Date: Tue, 24 Sep 2024 09:09:08 +0000
Message-ID: <GV1PR07MB912042E2A43F852836D065DBA8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924090905.4097-1-kweihmann@outlook.com>
References: <20240924090905.4097-1-kweihmann@outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240924090905.4097-3-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS2PR07MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6de2e5-0126-4de2-0c2c-08dcdc78b499
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|7092599003|15080799006|5072599009|461199028|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: 
	4VyK1Jh/wl2X8QMdJslLZakx9OS8jR0LJySzp0kFYu52/jZb38NRiflpCxyT1qDEpp4BszZReaJ+bnOoRDSepg4NUgC5HzpcSGmPdFwpi/ynLE8ItILwVHxNcKDVmA6GkpJ8Akb2c3yj4MDZRFV1fCvUCRh2017k4wOkBNXDCF+gzhNaRHghibMpKC/rFp7GrctNI2V/bYcaSLwGTOsoU9mnfqIJUrxhnXndlc6c8rxorxaHcXitqcLsslGqkweN8CP6bSu+jC8YEU4Jx05o/Mh75pgLgsDdgAhCM1tN0Hw0xXn2XfImRCMylAYtMBMl1r+LI5Vk+t9L3HH5P4iUIXr1eoUf32GvTfvB6ljGhVLU88RoJsyByrRegUAIofKuCGX4hZrowuEmq6yOHo3OitJBHSaJbXSEdjpRb/ML+lpDZnkSzPPPBya3KrUR6aFjrrSkAfpzOMtoHERs+I+YGjnRq8nWt4JDaO0Q9lkTZ9ImIht+H/4I1oTNEXO4Cj2mFuSTmQsoGdwMk5KRfNivZMYx848v9LI3hHq295eFrHaBHJa7/i+Lu03QARTno8D7DkRhI6EihDyGhpECA2fbNlWJHdzzq4Rt1nSKdbUk6J1Y0oBY32O0GrIijtAF4Q8TzZjEaG7YqtL8e1KAiYPpX7P9h03u+ftgeQJ2phh9+uAjTy9Hins9DeRVBnwOFd+Pd1Xg0OS+RGW1UkaNHbsZCGXT8sF2tYIjX/wgu8EP+ZbVF536atZj6OCjOyFOXLTyRlrmnCH5jABbZBsJSRlOjQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s75j40zT2oicSDMkO4mFxkiGPl6N/ajijHpxNjWr5TBZHe+xAffEuMpChVAp?=
 =?us-ascii?Q?1II11q95AdvcwIE85A4wcBIjevAGeRlXHrjxzyUDV6LidBB4O3/ORa4v2VpJ?=
 =?us-ascii?Q?ZMOjjOHiFySzeY9sF78AsSkZsmI7kGhEp7DbtfHkv1begp7WGaVkfbel+bKe?=
 =?us-ascii?Q?KulV0Ado8YAkRZ3VZhD6BCRHI/XesutGcNdgHk1FiImT/zxe/pRChb9rtlHI?=
 =?us-ascii?Q?uE36bo7m3nrQIDfHWfux1utU7/3L4Lg+4DmGnDw2CttWxNJWfd7kliZTf2ZU?=
 =?us-ascii?Q?S8GsRLH6HOLH5DLROJKE/53ns3htfLGSLy1K85wnaY6/kQNDVri0yRmgcG9X?=
 =?us-ascii?Q?fNFeXu42MLtyAH7s0z2gF7fhsrK7GO4q51vFB4YYffi1RbUmiFI3qZeFcXoa?=
 =?us-ascii?Q?dZaczkFzwwTwfNp6qd6AjPwXbpxIb7VLhtEyopqX5OGWpaqKmKkiLs5/M86i?=
 =?us-ascii?Q?VHseoMKUqq2QxLAjcjBQFgdtbq5GHBNQmm4ZfnJgHCfseyB39RSx/vM91eyp?=
 =?us-ascii?Q?muCWxyw7i4ooscXd+7W3EmkBrpfTJCKrLm96m66gabfKp4rHgRGK9uUJS9cN?=
 =?us-ascii?Q?r61V/V2leypHgAIoyyxp/FOR3lAFK4eIznn6UxEF/3F5332QZAdIAp1hTFvM?=
 =?us-ascii?Q?kec6ilURmpfkj+2i61diQpZqr0qyIDhkFW0Nvw4VPJ7et0RXgKIIHdiO8haz?=
 =?us-ascii?Q?AN/Pv9D7C+CTarybAPKtlESbgt06cvcqM6tYWB04aKFNGsrPJ8gNRjqbfL5B?=
 =?us-ascii?Q?l/J1FrZoAkmneTJPGgXE96p7Ih19KBCChRj0wEgeOVyY88MyctA3DqlaC9WT?=
 =?us-ascii?Q?wgqOdz6PPOd014048etmjR47ZfDpRravZ2UX1pVTlZjq+LyfK7x68+Snnu4o?=
 =?us-ascii?Q?1T2IT4XEMZUrSulbeaalKjg2X0HNJnrHc6JlVlLCNNoNNjMS5UhJyzUk/Tcv?=
 =?us-ascii?Q?3luhEx3tWidv46y/Cft7OzQBv4N8ew6m+OPgwYqzYp2b6cFQD8QhbtAr17Tf?=
 =?us-ascii?Q?PfzjMKimGjj9R8pd/lg2eHIo4FvlhTQUzUAvI/hvuaFv/UpAB0LHfW7LXzsT?=
 =?us-ascii?Q?13otUIMRyq0ikKgM+YElSIFb7BSwxjYkju46khlsbuPkn9UB6/zHJe3qMwHG?=
 =?us-ascii?Q?vrw+sY0vnQtMobYrW3LMIIYaDd7OO59kLPCEoY5N4+HLfMlACgWIKqlCahFY?=
 =?us-ascii?Q?uw2z/AiRyc5hETG/935p3/gv8aSnmi6K6HVEQ/hfcysrV31JeWabZ2ich3g6?=
 =?us-ascii?Q?PVcW/qFS7dgV2ckhTCd6fU3zrtoJH6UCNH02giQW707mDCPPbv5WjXxbZSMY?=
 =?us-ascii?Q?4Vk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6de2e5-0126-4de2-0c2c-08dcdc78b499
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:10:16.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9491
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 09:10:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16598

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
index 0523744de..fe4c50740 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -539,15 +539,6 @@ class DataSmart(MutableMapping):
         return var in self.overridedata
=20
     def setVar(self, var, value, **loginfo):
-        if not var.startswith("__anon_") and ("_append" in var or "_prepen=
d" in var or "_remove" in var):
-            if re.search(r"(_append|_prepend|_remove)(_|$)", var) is not N=
one:
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


