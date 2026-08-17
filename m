Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5C8C5DF66
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 19:51:38 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3447.1786996290529118211
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 12:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=HQ0/of6y;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.17, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie1oU+LZmdjHdjRn6wI1rnfAkio13X6YZMSQ1gBMAWGAqF4qCJqyprlLRftzv6J/l/Gqlf3c0bfvC+754pp4I+6idXxywfp6wjn9tR5OIMY+I0ZZcoTtwh0CTTAGLpPF+1HjiKgsJoZtFTndNJgn22QHWXSCmDUaPhUM5KuY3lk/nLSQHE1ZAqsQSjrFOZT59/62/cBWBFW0z3hnxKBeMAB8Hrzlc5Scd5yXBSEvju0ZASomoud+aOanDiB36DQZQtapDqRtdfIU20zB/8UJZYSPmlsj7B8dqr0e0GVvcUPsD2M1Z8+VcmMVaCa+vpFtGP5V9cmCRoZa/o/zNOHwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRLuxIGwSRZ31PpADlCektJWbMLWeQnSOdFqfsJuCHw=;
 b=M3zJZRYo/loQcUlmhnF7jTWedlOt85wht5KBWo356fD0enTJ5Dxjn4njxq6ThBk0YtedjW426yhet0scpELG47FBLnVZVCIDd9Jro5FpFSOn5rYEO32z/bK66WbwRfQrgkX3DfCu0FKCzhOUsuBk53An3wa8kqYwWwttSogXSRAKv3JP9iN1CO8+k1RSQV0fsn5i7vJcNEt6rHQD3sXnQWqaTBSqgU27QtV7kyoT8kgwQnNq6gr+4uX6P0PW2VHgALdBclpSQfTPLOsFzQgrWw0wB7Dc/Z2Ubbhw6GMctOYg1j+Ea+PvU66/ZjxeED0vTcPMkgPoIExWmL2lQiSXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRLuxIGwSRZ31PpADlCektJWbMLWeQnSOdFqfsJuCHw=;
 b=HQ0/of6y2ohPMDODjlDXBrlEEI+4euw10KmBRQRChCUXGr8ww+9IbGpcPSf+rlllFRIx+KmwWty24mdgwd/zVv3q7w8ZCgJhfGs7c8OypdIXK5H0uZrMexbWIJpLHhMHYAAqJ3KNIXX1urdv2aKkM32TswHuZm/prwpx0erdjcX0y5duMAfhm59K3RZhi6wEBrPISa1hgPvgVtIFnVpH74vQoonuoZkWY0gurWdcjWNbLrjZ4BVsTb4txHZZ4DoDjBe4ZNuuf3S9oW+dbptEHADEFH/p/PC3yDjSo0tt+CPL2tYngEeQ2jRPUWI3vKTc0INQS6KaHm3polaO3tSDlg==
Received: from CYZPR10CA0014.namprd10.prod.outlook.com (2603:10b6:930:8a::22)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:51:22 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::92) by CYZPR10CA0014.outlook.office365.com
 (2603:10b6:930:8a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 19:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 19:51:22 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 17 Aug 2026 13:51:14 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <svsvenss@cisco.com>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] fetch2/wget: cache SSL context instead of recreating every time
Date: Mon, 17 Aug 2026 15:50:57 -0400
Message-ID: <20260817195057.2485364-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817195057.2485364-1-chris.laplante@agilent.com>
References: <20260817195057.2485364-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: ca91b3f9-db57-416c-91ae-08defc98e9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	oQsz8OsZgFSLckAvbAKAN6+H3BQm0JCP1Yq+JKpWFyumVGJO0ivFDT6FHXkRuBnnFQxiuXnJKeaFBiA2YCjZM3RFvBlG5RjdzfxSJzNzOi7izxFrV/22V/ftS1jHNTimdBXMPyKpJBnbmSuKSDNZBQfmWrD8AYm/JL0sGPTpwhwx/O2BAOaTqMicSwdb/PuC1DIzvDZnDjKYl/ZNgnfaeh0oQ6g+nP8sznrN3PXbiYBd+pLr0bhnK/BtdeIhcqtcdzwxGin8ZAC5rdjDB0QPIBne7kA6q3B439Uv2+n4u44fbC9iu1iimK/7/AKdQscsQDBdmRaMOAnLe8oX1MeoRy3QYQmMC0OlB/EXOhavZ0/AlqvPIrjLpDWqdsxG1d8T62YX7FcwKWDYGzAunThA/QdnzP19kF23eGXSbbKxdzENz3ilXg9WBi42VbK4H9XGvWo0pM5Z4OhZjXCHrKo2WAjeOYmHvs72NWEap4Uhb5ffqGp5JDlkE4D6a+c4lAJ0264hRXrSvWv9rRT7v7gJJQexmW3d+89K0IfzUCFX4R6CWxvtCnanrPKSRXSKisUIa+RJAFdeYVKfnuUd+cY2UAYbcV9oGOqo8VRasxwm0pZJzoRu5/dcI/wkOhHYTue04zQOOCNNAZmfx1mKe+LYFA2JmZGySadmuMH/QEPyAT82vIdQEggJkQHp/QoRI3VVLAGIo9s02ftO5GUKbcXp1A==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XatII1hdU3umngYHvfeKSFRBW2Q1cBMW0lOO2s9qIG+LV8IIJJpvgLCnfKLSUbZVTwEfGw+4HmbbF0rjE/N63kq3XDD0BYgqIIqHuMzayv2SNhg/bwEhOfztLIt50103/E4Suf1GciR0DfRQtQZdKT+IxvG55fDguMRzfgw5X/QMVUzooz3DN9Ph754Z80wMc17DxRIms4dgLTfSMgIjTuGi1xhueJMyy6DguNMQ25fWtQa2eUh4Gd0a5z3wQTA0E9qWP6Z2MX88+GlByy2bBszfRRgoaq/pbMeEuAJS2ItsoDu+VlOiRTbp+YU/VXZLd0t8MYmEeRhn7ZeVQSc6V+i7jqbY+slnkhfnj6yiWav2+5Rq6pyVEMHS34/ptu0mD8TP8tBn6J+qKBJePGAm5f3K7fEDRs9fsMAjtJUpjQKZHCUuLV5DT6Vc9UQpv2+e
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:51:22.2200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca91b3f9-db57-416c-91ae-08defc98e9e4
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 19:51:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19977

From: Chris Laplante <chris.laplante@agilent.com>

On my system, ssl.create_default_context() takes between 100-200ms,
presumably because it has to load all the certs in /etc/ssl/.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/wget.py | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 94a1ec973..0d2b7f5c8 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -54,12 +54,34 @@ class WgetProgressHandler(bb.progress.LineFilterProgres=
sHandler):
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
=20
+    def __init__(self):
+        super().__init__()
+        self._unverified_ssl_context =3D None
+        self._verified_ssl_context =3D None
+
     def check_certs(self, d):
         """
         Should certificates be checked?
         """
         return (d.getVar("BB_CHECK_SSL_CERTS") or "1") !=3D "0"
=20
+    def ssl_context(self, d):
+        """
+        Get an SSL context, caching it to avoid creating every time.
+        """
+        if self.check_certs(d):
+            # Cache verified SSL context
+            if self._verified_ssl_context is None:
+                import ssl
+                self._verified_ssl_context =3D ssl.create_default_context(=
)
+            return self._verified_ssl_context
+
+        # Cache unverified SSL context
+        if self._unverified_ssl_context is None:
+            import ssl
+            self._unverified_ssl_context =3D ssl._create_unverified_contex=
t()
+        return self._unverified_ssl_context
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with wget.
@@ -412,13 +434,7 @@ class Wget(FetchMethod):
         # to scope the changes to the build_opener request, which is when =
the
         # environment lookups happen.
         with bb.utils.environment(**newenv):
-            import ssl
-
-            if check_certs:
-                context =3D ssl.create_default_context()
-            else:
-                context =3D ssl._create_unverified_context()
-
+            context =3D self.ssl_context(d)
             handlers =3D [FixedHTTPRedirectHandler,
                         HTTPMethodFallback,
                         urllib.request.ProxyHandler(),
--=20
2.43.0


