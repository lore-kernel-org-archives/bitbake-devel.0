Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC18CAC584
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.84])
 by mx.groups.io with SMTP id smtpd.web10.14988.1757053280733913428
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=u4oF/xkW;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUFF826d8snpvsjdYgt3iKs4wkB/rH5vkascer8ZIRNQsUAfDMa8ADlWgKheI2rnkS+g4EAvpCGKnCogQu1+Q6OCuPIYWTpuzaWwGr3+07+z7VDLEDY6QB25XyR9lk34ZoePqrmcy7K36cysORCd02Q0hWyxymC7Bpi5crZH3Bi04KYYQsv2HTxWvrJ+M27FNn8BVyuwO8KwBUDbwhPNPFzqVNnNhJWwvpXnxftpfrXC3sLV7H/7RiFZlxwSstKSCL0MBK2Q0d0cVbDsz59wyF2Xt1v/UzK8SZoiNixYTaI9+bwRSDtKlT9+AZde2t3BAU50njWVUPTebZywr9G50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aRqpEakDOUppHJG2UqbRXwPk+fOBmNyOOHP7eGaEOw=;
 b=MjM+UKYtki81tT744y5U1dkSxS5iucvXy5nHtxmLkEq7f/lgDk51MYeKvycpEXHOdrCGc/45jh6i6ltwDszN7zqaoe/LFLGegqVbJGp4qtGO2wZwNoFI0qgmSWJQDXdqvaXXJ8ClckjaRjWKx209GlRs5M6jL69SJkdEqvocHh0J5TPY1ewUlHWhv5Z+MIRPLoLvA3C6nGUsCYVpxSbj1y6YDZ0B/aFo3e/zTNjqGr26j55gReFY5KqvLjjsY6tPiOo++FeGc8QQGWlaeRC+PRPuiIuhVpo2eM7hrI8EuRz+56U4NVtgvrmrDvjbKv7n4UgqtFVNZUPjAxm1mRewTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aRqpEakDOUppHJG2UqbRXwPk+fOBmNyOOHP7eGaEOw=;
 b=u4oF/xkW1isZ3RodU2SoPUuVDEBhPatYIZA95MKTZmkd5AF6uvTDDZYdp23QMNLAvRpBmOzPAvtQ2q7jodTx4CGIShQPVlwfD4XMZRCaJF5bPAAOEoq9b+hTFMJhA7R4+wDFCcRI5CldxHH9p4CJUHzhLhBlqcgrLDVoDZDDiO5aYV3nr0uGpcpJUEmtdnhiN5JhD7yrel51KDW/2oekfc0FSvTuNuVrspSozDfq3xN7VJCy4xhcUZbAKmTKQCXm8iHqkKi9g3PK2bjqtDPcwpzhqUJi/N/+rFA1kyy4PNFCIBrHCmNgndWRgN/w2H9IOm4mq3FeR9S4YkVQolvKeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:15 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:15 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 13/15] fetch2: gitsm: remove useless need_update check
Date: Fri,  5 Sep 2025 08:20:56 +0200
Message-ID: <20250905062058.2563806-14-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: ff25cc81-6e82-47e0-82f4-08ddec446ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nL8Ich3LtVOyCcR8ilXWgL+Jw5qAY8Z+TpkjEHJL/2TUBAybtumBGxqkSb1S?=
 =?us-ascii?Q?VKMiGXv4UI1bCV4tEhQQ+ohwx0n3Z1xlwwH7Jbi47XdGiOAjoguolbJxBoF4?=
 =?us-ascii?Q?2DrIhrF42NfGBLzrzMfpZ1rHGitGxKDh4eYy+vV4ATYl00LCeOdRvIdPSFBP?=
 =?us-ascii?Q?vwHZd94lm8uHIkzH8guAdWYhgbIGPuvlrYCyFfdkE0/KfrYbYQ24jqO4T9Kf?=
 =?us-ascii?Q?d/Pr19BfmWlgvdDk3NmCh6RparUJCwpACEgNVLhz+kXzWFri+KH9PGWbBdzP?=
 =?us-ascii?Q?mLfxjrThh9UoQmw4RY0Kk27d7J81pzZRV0eIYLbEXk7DhZgwot58s2a7+6nc?=
 =?us-ascii?Q?u0Xy78DGfHWq6f30pNU+h7dyxPLMdn87cTmo0OZYDGDTSt5CXACJNvD+nmzV?=
 =?us-ascii?Q?KpMJWbPj1MGDmRQasWqIC36mEoVh8n0yPNb9BasRb++aVafvYX7puvNb4Lei?=
 =?us-ascii?Q?4tv/GjBX4YKe1LUKyR4CFuTb1cuezT1r4Z4pvn+0M0DHgKi3neGf1Mq02733?=
 =?us-ascii?Q?FyiMsERDs1Ddc89Xe8LlTjJPRVmiEFd+Ze5ZKnoUHsAJAR4JLpL0gUgul67v?=
 =?us-ascii?Q?Bl18kicKw3U5y4B/2Xo+Yznbof8FO1CGffuazvo9fCamRoGCxFlfdwxDiQcZ?=
 =?us-ascii?Q?SEmkWyUZRWZ27YjuczzEIYHvpgIgswpbZXSlQRD7iT5eQc1k/8BdRQ4QVBIH?=
 =?us-ascii?Q?haAm0g3WWfMlpMwRxcl1FVnxVQKc1UZC4X8rj1QtXuCkr2kwokI9TQjXkTRr?=
 =?us-ascii?Q?rXihctM9tLbKWpjEkdHs6FshmzYyT2EaJFfTByW+uC/1FadEd1byflP7ZxlC?=
 =?us-ascii?Q?T4zv1mDDM0nfNj9SlU5wbcEjt9DQtPpzR937ET0gB7t3P4VOZP/hI1NADHnE?=
 =?us-ascii?Q?qJ/xYr7urHqsjUben/6YyJBxsid3pZX/eftliKwPHjuxJy7QfMQcsn4KG4ie?=
 =?us-ascii?Q?FuK5DnlJR6Roz09RN2M+fwqZJIYWEeec3VicbLuPHzjyzhZ4No7xNE0Bt3OX?=
 =?us-ascii?Q?62GS1g3xWZEKNdXmjIs+3NRWrboyrnlwHbllBbLrvIgfp4AQ1uq5Kmr3e3JD?=
 =?us-ascii?Q?P5m8PN3B+m4u9ZJhPcpvnPJHBG23Lg0PLJQmBgO+HwKPzVMydeQ/kOjyu3sf?=
 =?us-ascii?Q?is4T7gZ9HxYOzd6ojZ3pwJuY4k23aBE/sSLRWlKxaWsJY2ia6ZtqRlePepX6?=
 =?us-ascii?Q?zzk+TC08xCz69s01HqSFUiy6DrJ2vTsRwXEQuAwvXNS44yHosjUk/W1iDVDJ?=
 =?us-ascii?Q?vDm9WfWIiVvkP0HTpv/JyoprEjpnFbO2AiRG6HAj5DbNHaboL6BZ5FinegHF?=
 =?us-ascii?Q?3lEUG4SoQeMpYx+BwLRVgATMFOo6oB+dklslI/J+ZVDM+epbescjLkzBCzT3?=
 =?us-ascii?Q?CKhE/8acdxkHn/cRRQfnciZQZvAW9eqi/64NMJFl+QBnCN6hGhIsPz/i3nNW?=
 =?us-ascii?Q?iAKaSPG0/E4nTIbiuXWNprV9vrx3FAyklggr8vVP78LRg4RzGMI5yQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5CO+IeUiDTnkMrcGlFiBt10GAvQ61MKiC1waWjppjSKDp201vKcnjGgyYWB7?=
 =?us-ascii?Q?Nsi7ETh/pEGH8DgEp5W1XvuQbDgTUwSf48jmj7UN3LA5PAqdHwJJc/bo+Om0?=
 =?us-ascii?Q?q7Ouw/ASinEw06jbe8w7T/aYr+11o6SbuLrhHhNx5FJjoWd7ijv6qe4lIWie?=
 =?us-ascii?Q?FDVkxku7oCbrXsGglhFRfbwnmHean9ngQCVE54BLOAGrJgyx54PGU+/ecyfc?=
 =?us-ascii?Q?w+FO9NCw4uN9NBdmamosH8AzuYNEW1aojjPys1arJRqLBKU/k435l/9vZigv?=
 =?us-ascii?Q?MxEbv2xbT+UhGbKqmdgfm+0T36pBMAMbAozVkxydr545K2Ojwdm5FURmg6de?=
 =?us-ascii?Q?LvhIgj6ZzYnrGuZre6tK+6phWmjVu/ZzEFe7IVueIF4LL4LDsPJgDOErGFWM?=
 =?us-ascii?Q?GdaNuiCOw6rbDMjwpXnQrfCAqHNqxejTMI6SDFYoAxj/4qwqYmJX6eMjrIEX?=
 =?us-ascii?Q?7gryNFZNgnNaJsD8Wr4ej2tdZHZ9xXXw4waipsEzyLb+t6bpvqPDTw1l+RtR?=
 =?us-ascii?Q?PZmX1od0NFA1xHP9T80kfuR+CTrIcqtCgo6GR2XAnbUrOdxs+Y8vPOtj5366?=
 =?us-ascii?Q?zCOhs+QZ57zUI8UgoDWVy6hD4l9fPvXvrGWi60Abc2MOOfyLh+9U5eV2SwM5?=
 =?us-ascii?Q?hc96ys5/9ZKFvERzRpGFdgHzmfEEfLbdTQZpX6h9aSVFHGOrKSdRhEnDavdM?=
 =?us-ascii?Q?/3qoUApVUEA+RrqKxC9E4qKYuRqiJXEcxWbWluntxQsazR+vkj5hbcdyu/27?=
 =?us-ascii?Q?WayYmvW0C/avAgk+LIwkICK7PJbnMFUYwlIcEFXATpXWrpFUbTXfsoyql5DE?=
 =?us-ascii?Q?Q2uaNWHpIu5QOdHA0cFGWEcJTCeUioNPtqdV/gQYyMVfEonVAOT7sgEKNSGS?=
 =?us-ascii?Q?747qIklL3ozmvdyHRC6roA9CzHRGa0oiN40hr/qx8nBjCEhxRl2wBl92e2f9?=
 =?us-ascii?Q?gygr/8BoA+DkmA/FaoTlsnQ+hrbD6+kNkcYojNXm2FziXsGIvQnoOFum6KG5?=
 =?us-ascii?Q?e0N0BUO8Co+lkehWZ9FnliU3T0x0+ZYS21ru2mODRnuUcrcf4F69pcLhFZnx?=
 =?us-ascii?Q?nMD7kDZuaIbKFjfTTJ6ZFZPppnnAW+QohPTc3BaT4aOTQxJd1QurbI9CuOXt?=
 =?us-ascii?Q?CdPdLziTsfMwkyMFJmQME8tD70GudwxnA6cQ78z//88VDloc4j6E9uuFRd7V?=
 =?us-ascii?Q?dcRUaPDiNGVib8Ew13NP4a8LSYP7tqrAycXheKWqc/MBRAPhbWQjNHsMIDjb?=
 =?us-ascii?Q?NRcWJut/4lE6p7CdNAYA1yclU7Fot8M86SlLGvFMsotdOY57sOxIB0b1G5sw?=
 =?us-ascii?Q?VfEnhRP0mcWgN9McJL49DsAwrNbfwxTtVpVRJQNeAENglCByNYiqG48ZnNPf?=
 =?us-ascii?Q?sAwTf6P+yKeh/LTEDqcoFQJ2XPBrspQEvkL83bNCpm/UycwYX+r2/t9QliaV?=
 =?us-ascii?Q?vZhIUxVHYbe51SKwvILnyLpxHdQqziEd1ImZ3HPNXEQQvMsMqNasjppkO/sa?=
 =?us-ascii?Q?vywOU5aNQrpPKEFSNvjwR2ArhEJg3knBI6WBp86JB0XsfGCV6ZktXf04TX3Z?=
 =?us-ascii?Q?1UcdmDD35pT0JQPCwE6J44AUefG6r3hE8IOB8awp+MI5oXGEgzoYs5YT17mA?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff25cc81-6e82-47e0-82f4-08ddec446ac6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:15.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58gj7uZOGwkAp12mvvN15yiabLNrRgeSd0zIXDpJfb0vl75Cupj90brbhHQVkHp/AIm3aN5ZrGBP5V3/qDVpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17970

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The need_update check is useless to decide if the clone directory or
temporary directory should be used to parse the submodules. If the git
repository needs an update, it does not help to unpack the git archive
and use it instead of the clone directory. Furthermore, it is useless
to call the function of the class itself because it bypasses the check
itself.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 9afdc8370..31460b19e 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -143,13 +143,14 @@ class GitSM(Git):
=20
         return submodules !=3D []
=20
-    def call_process_submodules(self, ud, d, extra_check, subfunc):
+    def call_process_submodules(self, ud, d, subfunc):
         # If we're using a shallow mirror tarball it needs to be
         # unpacked temporarily so that we can examine the .gitmodules file
         # Unpack even when ud.clonedir is not available,
         # which may occur during a fast shallow clone
-        unpack =3D extra_check or not os.path.exists(ud.clonedir)
-        if ud.shallow and os.path.exists(ud.fullshallow) and unpack:
+        if os.path.exists(ud.clonedir):
+            self.process_submodules(ud, ud.clonedir, subfunc, d)
+        elif ud.shallow and os.path.exists(ud.fullshallow):
             tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar("DL_DIR"))
             try:
                 runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=3Dt=
mpdir)
@@ -157,7 +158,7 @@ class GitSM(Git):
             finally:
                 shutil.rmtree(tmpdir)
         else:
-            self.process_submodules(ud, ud.clonedir, subfunc, d)
+            raise bb.fetch2.FetchError("Submodule source not available.")
=20
     def need_update(self, ud, d):
         if Git.need_update(self, ud, d):
@@ -174,7 +175,7 @@ class GitSM(Git):
                 logger.error('gitsm: submodule update check failed: %s %s'=
 % (type(e).__name__, str(e)))
                 need_update_result =3D True
=20
-        self.call_process_submodules(ud, d, True, need_update_submodule)
+        self.call_process_submodules(ud, d, need_update_submodule)
=20
         if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.j=
oin(need_update_list)))
@@ -195,7 +196,7 @@ class GitSM(Git):
                 raise
=20
         Git.download(self, ud, d)
-        self.call_process_submodules(ud, d, self.need_update(ud, d), downl=
oad_submodule)
+        self.call_process_submodules(ud, d, download_submodule)
=20
     def unpack(self, ud, destdir, d):
         fulldestdir =3D self.destdir(ud, destdir, d)
@@ -247,7 +248,7 @@ class GitSM(Git):
             except Exception as e:
                 logger.warning('gitsm: submodule clean failed: %s %s' % (t=
ype(e).__name__, str(e)))
=20
-        self.call_process_submodules(ud, d, True, clean_submodule)
+        self.call_process_submodules(ud, d, clean_submodule)
=20
         # Clean top git dir
         Git.clean(self, ud, d)
@@ -260,6 +261,6 @@ class GitSM(Git):
             newfetch =3D Fetch([url], d, cache=3DFalse)
             urldata.extend(newfetch.expanded_urldata())
=20
-        self.call_process_submodules(ud, d, ud.method.need_update(ud, d), =
add_submodule)
+        self.call_process_submodules(ud, d, add_submodule)
=20
         return urldata
--=20
2.39.5


