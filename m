Return-Path: <johan.anderholm@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB0FFF885A
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 14:04:04 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14230.1777385039649811179
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 07:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=WMmyPoH2;
 spf=pass (domain: axis.com, ip: 40.107.159.37, mailfrom: johan.anderholm@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA+6590dngeQdPMm3YNUCxCEZXWsn8LjL/Rcxrb/RfNJy3cn8n2TZhwLvkRoiOgRtk3F7L7/aDGhPgcJG2v6qEJ/uRnIKjgLMD51iMAHxBDByWq2hnsvW8fNxQeoXiC0Vsvv/CzS7dXu/JkKIHxQ3spVHS3gp8j47VO+ZDg3gnotM5Tv/YZhSq/b/wjKARmkYW63WZ0sb2bmeaHv/bli24WC9GlD4fEIAx26nsIK1qEI5y8NuqKIU7Z8ffVAzk9hcPVCXRNssnh5hXsS5ZJ0e5XgoS4Zv03LxBJmy2waigX5BV2zekSlyppzie4LD259cL09qoIRFJcXYgjss12Jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzkeWkRWlBzgMR0MEN9oayx0hDeAD+BK0tnKIcdk43A=;
 b=d+0EfPwkpYTmRl8RVwoiTJ+8TLdlkQx2MqiTlQcKSrN2/f19xNg8PEKOsUGEklz2Ol1TaNJbYtWjcKcRKHCKA9kY8E35kxYFECBhzJICCv3f2vGJUmftb15d7u8EJceneWM5WLndogRXymVyuBuEe8Lq0uFgC7IsGPwmUmzI6vszMvmZQgIUBQ9cr8w6urKAj9DgHBqTcJNTGkiRB5W+TQqaiPp5ynadk9MkOiFso25bEnId8Vu5FoBffGvv4ByxwYSWp33wx9i8hQ8tDIX8z8x2xIfSajS7IbeQQ1liPWFW3SnDy6Tcl+m4o0UYfWU6pb7IN9hls6f8+WjLWbKtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzkeWkRWlBzgMR0MEN9oayx0hDeAD+BK0tnKIcdk43A=;
 b=WMmyPoH2yp9o7IF1eQjI7XIYi/4gTgjo8GnhkizaqjSk9w2NZ7B7fRppjqa98A9AHLAv6iU3nRbWcm6Ah9jJbEi5d7Kld26EfOyuygPZ52NC9Hji7ByTgRuwhWPGFPJcUEAMdx8m3VtKNhKO29jVQryPgZ5eAkpfvc1dq9dhbpE=
Received: from CWLP123CA0261.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::6)
 by FRRPR02MB12376.eurprd02.prod.outlook.com (2603:10a6:d10:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:03:56 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::a1) by CWLP123CA0261.outlook.office365.com
 (2603:10a6:400:1d5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 14:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:03:55 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 28 Apr
 2026 16:03:45 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 28 Apr 2026 16:03:45 +0200
Received: from bldod238s600920-7.se.axis.com (bldod238s600920-7.se.axis.com [10.64.16.16])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 84936854
	for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 16:03:45 +0200 (CEST)
Received: by bldod238s600920-7.se.axis.com (Postfix, from userid 20481)
	id 81607609E493; Tue, 28 Apr 2026 16:03:45 +0200 (CEST)
From: Johan Anderholm <johanam@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] fetch2/crate: identify as bitbake to crates.io
Date: Tue, 28 Apr 2026 16:03:26 +0200
Message-ID: <20260428140325.3948844-3-johanam@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428140325.3948844-1-johanam@axis.com>
References: <20260428140325.3948844-1-johanam@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|FRRPR02MB12376:EE_
X-MS-Office365-Filtering-Correlation-Id: b354b918-f79f-4d78-4bbd-08dea52efca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	oHrbdKK4w52yd1f96cX+HXPTT3qpRl+7eM1zb/HAOT/5y6EFuJ0uUKxJ80Qm2jMcLxDe8V4DZ0UK/ehm/E9EGWVzmps5hexuPbA0y+oIU1OzGz546iuNSYvTok6WDfQHqNTbH0gNyyutlLtE4ocm1W/FjbgUCzsUjIWEAa6htuBF9C10czEzSz1NGWl6uUfsxe/48npJIGM+EIM9vOdkGia+L6JfKRSF5mzWqnLaCBHNUg/3tXeJT3pX9+4MluO26J/mk++Qv8I7l90vnyMuGEza0Dcgr+awmFv79HcztpljnrC3JyDWKDdGOdWZRtzlsdtzXHgcTqRLfv2XNB6X2iRjMwCBH0jlNbNJcL8I9rbqwkC3akD6liEGPv2kNhYLtmIFWrvDLlTly0CBun6Ul9HxxB7UaZb1pLBinJB3ObZrPxAhnmjhP1WhSH+23Xa7trla4XUWT1bfK0twV+pulhy3DM22y0hty29IrnbyNI2HRpyn7PJD7HSFhcgP8f0lITz8afL9TnUATNGf5Myn5h1GTqpBYrcztach7I5fgqUPrYJO2YCjO3bBlyafs8F02GwkxTDm7cGWjOcU1V3MC5XTbQh73pWG+lMnNwsCHCEK0TOmbfTTQn52Ryy6hXJFhoo8nEy9iI/IQMnwwuOJ07ap5NPkmkK/egCT0ifhwtuIatLHopVrNUnwhRiH41tCjb7/YdhASDgmVWJPDWdjsGAKnplLJgH40jnSk6afc80=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ge/2whxP53Et2egStL1fuKqWYfqqC7Q7xxhY71377myYP8vOIOyPGC5GkP+qtZ29x4esjFrIYQrZh86LlQS8dvMM3DCe32nKK4QtK9QMKhhV60kG+9AWUQKJK+GhNNbOujumD+oAc9M7XARq8Lz8RqR7+l6hc8R0yFI5RDgqg+k5RuwGJvTqqO48zOAY0oIxsL72KzmgptzcsIwXX1XGZm5rvNQeYuaLRrY5Blb2NbkIRL4OtHfWZMLuhFvWDHiU8cR9/TalA7JM8THofs9eL2fxCnK66GMgaClGK+6VlvTyx0iK0c12b0U5C7WrUNB9cWiVsqDZxEgX2FoPVXGb5G59f0akhioBdd33kLA/AhknsznVzosjSUvCX5Hdc667Hi2X7nikCZ1wD/LOBqU5PfO6ltxRGM/Ihsy+VAcgWkaU+I3CKzd8LdPYILmbDcjB
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:03:55.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b354b918-f79f-4d78-4bbd-08dea52efca1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR02MB12376
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 14:04:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19402

In order to adhere to the data access policy of crates.io, a user-agent
header that identifies the application must be used.

Reference: https://github.com/rust-lang/crates.io/issues/13482
Reference: https://crates.io/data-access
Signed-off-by: Johan Anderholm <johanam@axis.com>
---
 lib/bb/fetch2/crate.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 2d3078899..5b6c715a3 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -22,10 +22,25 @@ from   bb.fetch2.wget import Wget
 class Crate(Wget):
=20
     """Class to fetch crates via wget"""
+    using_crates_io =3D False
=20
     def _cargo_bitbake_path(self, rootdir):
         return os.path.join(rootdir, "cargo_home", "bitbake")
=20
+    def identify_as_bitbake(self):
+        """
+        Should wget identify as bitbake?
+        """
+        # In order to comply with the data access policy of crates.io, a
+        # user-agent with application and contact information should be us=
ed:
+        #
+        # https://crates.io/data-access
+        if self.using_crates_io:
+            return True
+        else:
+            # Default to whatever Wget think is proper
+            return super(Crate, self).identify_as_bitbake()
+
     def supports(self, ud, d):
         """
         Check to see if a given url is for this fetcher
@@ -65,10 +80,11 @@ class Crate(Wget):
         # host (this is to allow custom crate registries to be specified
         host =3D '/'.join(parts[2:-2])
=20
-        # if using upstream just fix it up nicely
+        # if using upstream fix it up nicely and make sure user-agent is s=
et
         if host =3D=3D 'crates.io':
             host =3D 'crates.io/api/v1/crates'
             cdn_host =3D 'static.crates.io/crates'
+            self.using_crates_io =3D True
         else:
             cdn_host =3D host
=20
--=20
2.34.1


