Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F0C433FE
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 14:36:20 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web12.12839.1633530974766513842
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 07:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=H9FYP7Fh;
 spf=pass (domain: weidmueller.com, ip: 40.107.6.65,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBtykVXEk5aIH5ZJjeJi3FjdMDIQb4dzXdS7PoJ/hdiI0dJA/82Q7jlH3LnK5r6LwLK7pDssdgVFJs9aotyOYjHkb8+eDqefyp6RH2+RmuVhz48V4+mMvrlDl4CnX/PDXC4mZ5p+6cDGPAWb1jZZS0KMJud0aUM6s+86m6pdXn0rzBY0GhLdBAIelZKEdCl/C7OQdrmyZe0Ql5UlsQTtsBnPIw6gkW3cP0ftbtgrh80l1d5fnRnQCXqeTiycknx14XV1W6YwVzqhPoKoHPoimXhLDB7CqtJStGl8NJxHM+dpw3IS/cdnIWliip9RS4urttQtz4WKHrzASlJUYUKTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCLCpZHFZD47rQcMDoWwOWakoqM95mpob0P261CigJQ=;
 b=khvqyTxohJcAHgCTV4PxJ5yoUrGb3fJCJUnKueKvgZNpZfHwHYtHyItbeVNrzxKoVrjmuAb22xptJNmO0GhCc1j1+LHKYrKu3EZQxvX+zziqriBh/S74VKjyRnSQNrebOi2Qv6lPAR3eSUEJP1VDSJdKcRsdlRaCGlZ0F7/ExrFBzOyimdSTBO76pLHEnHNhfwVf+siKqM5JNHBVbaMFvT7O8cF+FDccAVkEeNC5knlEdVmYOWSbDWe9dg8AfC0tvj/7s5/U6SG+sIltOaER3xCUASstCHyv7Y9AlNLJXB05Z7ns0vTh+Z/U5zkInLZKqH1EX0I5MFbdvzu59lMfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCLCpZHFZD47rQcMDoWwOWakoqM95mpob0P261CigJQ=;
 b=H9FYP7Fhb9Ph2mTcRQ8+KHvLBJJc0bLBi3InOquuaN4YEJNDDyW+5nai068giFcdEeYpSgnSCwmoZ3I3es21GkSEjWPg+fZLzXearCchRx3wGS/cLUa7GXhYnLmhoCOrJGr2EQ6orpQP/Iso3hCrUJ4RVN5G6lUbXnUoC8Lewus=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PA4PR08MB6206.eurprd08.prod.outlook.com (2603:10a6:102:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 14:36:12 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0%4]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 14:36:12 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 3/3] fetch2: npmsw: Add support for local tarball and link
 sources
Date: Wed,  6 Oct 2021 16:35:54 +0200
Message-ID: <20211006143554.3734-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: 
 <20211006143554.3734-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20211006143554.3734-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0073.eurprd06.prod.outlook.com
 (2603:10a6:206::38) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (87.129.248.106) by
 AM5PR0601CA0073.eurprd06.prod.outlook.com (2603:10a6:206::38) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 14:36:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0e01b5-d311-4e25-7df7-08d988d6a53e
X-MS-TrafficTypeDiagnostic: PA4PR08MB6206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<PA4PR08MB62065AB48EB06A3115CFB9A5D7B09@PA4PR08MB6206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VMJknuiOGe0S6UJttP+VY9APhhk4ZXMqCcgR2Rn4tFdYiUn/f1aiF8oBAJJzdIieC8LEMh9MdtgcuH5EN3l2Hp+3KZp7oPDLYZDfj6NUhk4eaOen41lyE0RorrlEDQU7cyTHVFJ4nYe0MHcAtrijCwBJiDRteqHuM9zdFBt0tjYu/zzwvwHXnBH4vxOh+tJC4VXsrluF4XjhDGFDhyVxQSXoakzoWlVdGVQhdpBa0402y73J7gF4/xcg0QLA/FGf03WWszqHWTBmHcf4o/Z0C2yKs2b1rJa8QIwRoWL+oQqbWkt7lUmsLmQqnDuoAQhI7kalpmxJkqv+ntSJSsUsZThc61FJzHrhBoudDREcKBLgfoVwZvwn84hAy5yEyAoexZc3B2Rti/Tfz84DfwDGy0/7pU7f1GrT01YcbLTdBJ0KFq13IzkBOvj41ZVobkaBvXcdGXsaY2hxFSwkzwKYlyjtMSZPIwGQPhoEcz1XdVauMgR38ojCl50DiaIdO1QWqP2+Gas8Zm6Ds+rbffEU0gXU6F7Y/FExQs/9hcrbeRPtEwBIiVOIreesX5HlSjoV++A9ZgcDyUudO9D5NBnkT+VlrDbq4k/T1R9SczU0xEdX60RouNUijO/gfUuwLCxMepuCUvfnb+y+QVXapg5fnXa01fuR6PO5xnzTQ1sFZYQ07559EfidI9aZiIVkefAajZyz2RERnykQQJ+SFxZ5dg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(2906002)(83380400001)(5660300002)(6666004)(6486002)(316002)(107886003)(52116002)(956004)(2616005)(38100700002)(38350700002)(186003)(1076003)(6916009)(4326008)(36756003)(508600001)(86362001)(66946007)(66476007)(66556008)(8676002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xXrjBN7+EB4lutdl3MSvJsnAzViU+C38FK+UqklZuBhjQC6BxTX+WszdZupi?=
 =?us-ascii?Q?4eGCjlIlNmZKBNvpz8rS8ipbpg4yrdDspNXW0B9S88tDSxNl2JtEPYI3BtBc?=
 =?us-ascii?Q?Jn4xl6BJ2x4w1MlResH+oPGtly7T94Cc7SoDVuQ0pqeAMdWXr9tbWUDMGsKx?=
 =?us-ascii?Q?eBUfbGbPgmgah4eIqqvBsDAkCC45Cr0P8k4AKhP5UzbqQ2F3EjH8Xkk7FbSh?=
 =?us-ascii?Q?MC53zuYY6H0eXMUCYSUxGdszTlHa9HdEj3w468CYPvX4llgjEZZCRjsxnUtX?=
 =?us-ascii?Q?+LfPDS3YV4YKGDbtuTRrRexION/o5H9gZZtl3FpAnU6nSUPtK1bQSbVUfzoA?=
 =?us-ascii?Q?BkU0DmwaOrQ0E0z17eY99tF5axFdVgPQKBI2roFUWoSZGf6rglGv6bplAVoj?=
 =?us-ascii?Q?GnnsmnLt3cA/HgFdECfw4DxrGSMrv2CmAzb5IWVna1m/F2CvJDBViAqg4ood?=
 =?us-ascii?Q?yMkNUeNHo71aQGOH7dMZ1XYv5xhsjocbtws2QOhvd3U0YT81yqp7PdnT6Npv?=
 =?us-ascii?Q?P/iuz7mZ36WkWSFHOkGZ+VoHFFCgmkCYsmiMVqRB8+Ec20rgAWI/31W2I+kd?=
 =?us-ascii?Q?by79F7y00u2moedV+BTRCHAtu3W6z0saGT1jIGrH4I/pD1+kUhH1e4tX7wLE?=
 =?us-ascii?Q?UW7ect7QBp/kmbRkz8/po0rmf8uINh0asumolVNiY+zRbTMvqKXBtHUvXBS1?=
 =?us-ascii?Q?OP1VbzJHiULAKhUvPg80cwAUMj8Dw3y6JOmGXS6y26oqzlpnzHUqQpQfceLE?=
 =?us-ascii?Q?m3qU8DnPP4kYhqYfE4tgJiZyXihBQuEgONZMQp8KCXpTaGGUVFA/1YB0v7DB?=
 =?us-ascii?Q?trECYTlpaLXe5GHr9iLQe3Fp1lTXXh5j8qnkQ2aqBz+EMaNLUlfCVwJ/ftcV?=
 =?us-ascii?Q?6uzhQWsMcSNduxF98SEdgzdHo1WolC8E48+sx9IWwBPl+ndnp/c0j85C6XE2?=
 =?us-ascii?Q?9Dr0YaZpmArRPXLitFfmAF8IafLzNDehXb+TExNoUXlzpnIso71tAQQR5UjQ?=
 =?us-ascii?Q?YmHTPmnJAPyYiXtcJL622vMdQC0hEcNALwhfN5MEsRuGGftrveAUHrcF4P9r?=
 =?us-ascii?Q?Lvo5zHExVFvy0ZCMSejlFAdivDqr3/3iEAPsZlaTR3zQy9pFWxEw4woEeWsm?=
 =?us-ascii?Q?aPR6GVHAHInKGpYiKSG5mIUboP5OUP3Uh0KebkJF9TbSBMoYi+qcpI4nP4Gn?=
 =?us-ascii?Q?KdXKyCrif8XtmFEX/74Z1bjStGB2Bh6ev6KoiPKcWZpOIiV4Cxnwx1VJVESj?=
 =?us-ascii?Q?fc9LfaLRAQLGblk2qZjfZ515bIkxS32nvB8XFPaQRXw3BD0+3Pd6/bNRms1h?=
 =?us-ascii?Q?cWbVzScppsDSXmuLJfa3c1KG?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6c0e01b5-d311-4e25-7df7-08d988d6a53e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:36:12.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 QBZwh8NS4kkxlaz0jvGK3+QDmKdIv3Z4mOlQF+nTdQQRA19inGGQJVmEiLYlHBbqUTglD/B4v7zDh0HsbT+f5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6206
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Oct 2021 14:36:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12731

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/fetch2/npmsw.py | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 0c3511d8..9523cece 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -24,6 +24,7 @@ import bb
 from bb.fetch2 import Fetch
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import ParameterError
+from bb.fetch2 import runfetchcmd
 from bb.fetch2 import URI
 from bb.fetch2.npm import npm_integrity
 from bb.fetch2.npm import npm_localfile
@@ -78,6 +79,7 @@ class NpmShrinkWrap(FetchMethod):
             extrapaths =3D []
             destsubdirs =3D [os.path.join("node_modules", dep) for dep in =
deptree]
             destsuffix =3D os.path.join(*destsubdirs)
+            unpack =3D True
=20
             integrity =3D params.get("integrity", None)
             resolved =3D params.get("resolved", None)
@@ -148,7 +150,12 @@ class NpmShrinkWrap(FetchMethod):
=20
                 url =3D str(uri)
=20
-            # local tarball sources and local link sources are unsupported
+            # Handle local tarball and link sources
+            elif version.startswith("file"):
+                localpath =3D version[5:]
+                if not version.endswith(".tgz"):
+                    unpack =3D False
+
             else:
                 raise ParameterError("Unsupported dependency: %s" % name, =
ud.url)
=20
@@ -157,6 +164,7 @@ class NpmShrinkWrap(FetchMethod):
                 "localpath": localpath,
                 "extrapaths": extrapaths,
                 "destsuffix": destsuffix,
+                "unpack": unpack,
             })
=20
         try:
@@ -177,7 +185,7 @@ class NpmShrinkWrap(FetchMethod):
         # This fetcher resolves multiple URIs from a shrinkwrap file and t=
hen
         # forwards it to a proxy fetcher. The management of the donestamp =
file,
         # the lockfile and the checksums are forwarded to the proxy fetche=
r.
-        ud.proxy =3D Fetch([dep["url"] for dep in ud.deps], data)
+        ud.proxy =3D Fetch([dep["url"] for dep in ud.deps if dep["url"]], =
data)
         ud.needdonestamp =3D False
=20
     @staticmethod
@@ -237,7 +245,16 @@ class NpmShrinkWrap(FetchMethod):
=20
         for dep in manual:
             depdestdir =3D os.path.join(destdir, dep["destsuffix"])
-            npm_unpack(dep["localpath"], depdestdir, d)
+            if dep["url"]:
+                npm_unpack(dep["localpath"], depdestdir, d)
+            else:
+                depsrcdir=3D os.path.join(destdir, dep["localpath"])
+                if dep["unpack"]:
+                    npm_unpack(depsrcdir, depdestdir, d)
+                else:
+                    bb.utils.mkdirhier(depdestdir)
+                    cmd =3D 'cp -fpPRH "%s/." .' % (depsrcdir)
+                    runfetchcmd(cmd, d, workdir=3Ddepdestdir)
=20
     def clean(self, ud, d):
         """Clean any existing full or partial download"""
--=20
2.20.1


