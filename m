Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D421C48BF6
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 00:38:36 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.50])
 by mx.groups.io with SMTP id smtpd.web11.31433.1708303109847851875
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 16:38:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=AAlGdCc0;
 spf=pass (domain: axis.com, ip: 40.107.15.50, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMGY7UVtYV0P91ndNNW3w7aLiUwbf3Hh1FBS/Zv6ebkO2TZR3jLC6BQw7hpme/pXUTDcrpWzuO428qQSEKgiHOqtPKbA1nQVowAIJVE/JPYoMFBuiLFrJQ8m3Wvqdpt5gLSqHW/HD3ifyR1xGmZi6b0+3/Qjjr2nUo69r+hgh5ouIeGVKNB4d4lNsOaQAUz6oTqp5rh3LsqNm200Q6MPO5NJ21qJQUIQUzMWC3h5Ic+cf5htdgNJ+K1dq9Umvu8myg2u8wfmvnwrWS8egg/7aGDfQLqW6BLw+uzy0mm1QT5/ABNGbyaoKHb62o4X8nUcFhSxV/bevHXN/HofrlOnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CycQONV7MZnIebn4w1kbEK3LvVusso+7d232uaF6ax4=;
 b=YohHjlv1WoWXeVSVfFAqznU4J+Zb4MyTFKvsqRmQsLcDkGX96nd2IhIbq7nqzLPLTGX/i/zFVIZNVN1WYMj5vKK9M96Vrr6h05lmKKAxAH6s/qLpL0gFt0aeHcg/z6OfY3gy6AIQuCwMf4mj09y6flytNPL/mS9vM/YErUpVoCEJoT9+/J0m6Zb40kRpPl5ZY2t/1B5z8kucx9ZEEWxSLYOBhWxRuQBJsOv8Zm8IdSGCATMAaLOcImXpkVMIEmXaDPG7KqPuqWrrmLDHdh/snB+7Gk+fAkXUmZQZfXbOijC9c9VaC2QyqlZ4g5BfOS3dFcrHgCYHsUCLY5AOR/bzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CycQONV7MZnIebn4w1kbEK3LvVusso+7d232uaF6ax4=;
 b=AAlGdCc0VZ5xXmbldN9MxxanB8ryHC0JMR11NxCFYgTwnkJiucKDTpKnvgXfNfHKEZTKUvbZwJQ+Wl2yc6oEAN3dxFtH05u3Plh8aBOat96a8XZs/r4VUEYeeSKalRpoYku7c72TBGSp3rYMYWg+113hSa1FvaiXoJ0bdLhgJuE=
Received: from AS9PR06CA0299.eurprd06.prod.outlook.com (2603:10a6:20b:45a::28)
 by PAWPR02MB9102.eurprd02.prod.outlook.com (2603:10a6:102:33a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 00:38:26 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::f4) by AS9PR06CA0299.outlook.office365.com
 (2603:10a6:20b:45a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 00:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 00:38:26 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Feb
 2024 01:38:24 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 19 Feb 2024 01:38:24 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id CFB9B14940
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:38:24 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 41J0cOfh3024937
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:38:24 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 41J0cOxK3024936
	for bitbake-devel@lists.openembedded.org; Mon, 19 Feb 2024 01:38:24 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/3] fetch2/git: Make latest_versionstring extract tags with slashes correctly
Date: Mon, 19 Feb 2024 01:38:05 +0100
Message-ID: <20240219003805.3024867-3-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219003805.3024867-1-pkj@axis.com>
References: <20240219003805.3024867-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|PAWPR02MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f4b254-4ab5-48e2-e397-08dc30e315d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jzw6j6AjfDAKnQh93AxbNLKsBvyP9jtoSQQ8da9GW/qmIsQ/nMD+5tmHJZqWNDH0Q8LqN4QFoWdamr4zE5ywZtXfp/YEnVLh0MMtCQytl2BWORXSAsncDgD3dyCq7JHHqeuIWcJRuDnnNKhTYhS9caThOgPiIWSd7hANm67S+YrM5kSuRHTpu4+H5cDCOyAAuv0JZyN5GkH11s4RHqJaq7tVZGvDLsriUBByaQmWsDLbX6u+vlaYZwhibTP16ROFuqjAfKR+WDzNgaU4ICL6iVZu1hJ6EPDBr8s/j1kVSyfHz/q54AgNoxdHOnfmWySLvnXyboIFXNudMyNA4VR4+1WMZMR0Ba/zWxrLwZ34KUujmp5E5ANgr1pyZCH31b7gaS/vaRYC+/56Cf5yplE4DEHX1+12DxsRGVIS9ZQwG3QXxyXJVdpu0u0FJ6VfhshW/8cwchItgdnlfSBm6iuMWbmQroooyxkpT31jil0pPjk2SBX7hNg+g7abiVyk0DPmtZsIyhQpxS5LnLigNv1Hcmr0gFH2pSwhPtEi0pLBgwGwjzBVOwYx+jhxDjYl3q9NsGCdrNENSpGWchyaoLqDBN4RzmUWDd9CtvM1B2LJN2GO0Sa9MJHFYl0C0VbZamfZy1D2+EA1706aHVdFsbRPP09onX4pO5erke2o2nHyYyc=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39850400004)(136003)(376002)(230922051799003)(82310400011)(36860700004)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(6666004)(42186006)(316002)(5660300002)(2906002)(6916009)(8936002)(70586007)(70206006)(8676002)(41300700001)(36756003)(2616005)(26005)(1076003)(478600001)(81166007)(83380400001)(426003)(336012)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 00:38:26.1765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f4b254-4ab5-48e2-e397-08dc30e315d9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9102
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 00:38:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15934

Before, everything up to the last slash was removed when extracting the
names of the tags. This would lead to that a tag such as "agent/11.0.0"
would be incorrectly identified as "11.0.0", which would then be treated
as a correct version matching "^(?P<pver>\d+(\.\d+)+)".

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/git.py  | 9 +++++++--
 bitbake/lib/bb/tests/fetch.py | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index a69371a57e..9e09678494 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -818,6 +818,7 @@ class Git(FetchMethod):
             bb.note("Could not list remote: %s" % str(e))
             return pupver
=20
+        rev_tag_re =3D re.compile(r"([0-9a-f]{40})\s+refs/tags/(.*)")
         pver_re =3D re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or r=
"(?P<pver>([0-9][\.|_]?)+)")
         nonrel_re =3D re.compile(r"(alpha|beta|rc|final)+")
=20
@@ -826,7 +827,12 @@ class Git(FetchMethod):
             if not line:
                 break
=20
-            tag =3D line.split("/")[-1]
+            m =3D rev_tag_re.match(line)
+            if not m:
+                continue
+
+            (revision, tag) =3D m.groups()
+
             # Ignore non-released branches
             if nonrel_re.search(tag):
                 continue
@@ -842,7 +848,6 @@ class Git(FetchMethod):
                 continue
=20
             verstring =3D pver
-            revision =3D line.split()[0]
             pupver =3D (verstring, revision)
=20
         return pupver
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 7e7f26d003..832ae4d627 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1401,6 +1401,8 @@ class FetchLatestVersionTest(FetcherTest):
             : "1.3.59",
         ("remake", "git://github.com/rocky/remake.git;protocol=3Dhttps;bra=
nch=3Dmaster", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\=
.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))", "")
             : "3.82+dbg0.9",
+        ("sysdig", "git://github.com/draios/sysdig.git;branch=3Ddev;protoc=
ol=3Dhttps", "4fb6288275f567f63515df0ff0a6518043ecfa9b", r"^(?P<pver>\d+(\.=
\d+)+)", "10.0.0")
+            : "0.28.0",
     }
=20
     test_wget_uris =3D {

