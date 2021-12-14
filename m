Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8CFC433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 08:08:04 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.69])
 by mx.groups.io with SMTP id smtpd.web11.23091.1639469274157243362
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 00:07:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=dhS6OGV6;
 spf=pass (domain: weidmueller.com, ip: 40.107.3.69,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeiQcq6mNjgkVEp16wAzvu597sCH9w+WUXJA/KwFBPELTOabOV+N9GXKNi4zVV11gXDivftyKjQzwtaDwCf9JXfrj/FkIk/zXybp2y4SGS1q6Y8ztOaqzh/MXQ65xfLIyEEf6ra01zZgiuzUkWNi9+z2dlP13LhAZuoXe4j85tj5Dko3bfECiDNsjmNys2G/EGFC2r8vy6+hUGdKG2YC3dXD8Sl3oGwD6Elz6ppE+9nDUN57KqqN2J0qAqrZf1uLpN4J+XNol8gymv9Z3hgZ+u5LPUoidFPHh2emUMsw+9r9b4EvWW/6gvegxM9I9HO66Sz8v+nS5BQthuIlUdC5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxv3Aoa1LKTonv+L+x+LvKWD3rwwZpzDQrEAJHkx2kE=;
 b=MbGJuJk7G0nt5d5I4RaC+x+K3S3ucPFy8Ua7vGey0igyt3dl4ir6HZHalLbrQV6SMwj93ux3fsrghb4Uj3jrlAX4MScew4R3aq9Fe0BfxwdG8ZFWzL+Ztfx39PSDoWH/Il8CbtSCJsHneDG2K4vH3jDNGYmnGh4NoLWVCvMkelpFkdXsMyfvmPI0QzMYbpliF4VJmKtU+CzmbeY8zlJ8gNz2CvQCjjzxYYKYaIjKByGoYTF+CWyK0n5WfRqkVlN74W+D5z72roXf/DfakYyOb34izHxj9CdOAElZUsOqN7bXfIv8K99g7Whv/yU0BNvdbzK8Jrb1uNC33JmY+16PkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxv3Aoa1LKTonv+L+x+LvKWD3rwwZpzDQrEAJHkx2kE=;
 b=dhS6OGV6vYVpkNE+DfC24fTxeqO0ejEwa2q4wQZC5Tc2mVazcUgqYdLTuZqJJxuMFk/9jehHY27wM4EWRKs57coXdDSs4zhLuK1g2OtQPNDAWhYbkCgPt2+2caoeyfBrmVzRg5SQ01DjMzrEQjZ6oLVGwg0Q+8pFQ5rPk6176hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR3PR08MB5577.eurprd08.prod.outlook.com (2603:10a6:102:81::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 08:07:52 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%8]) with mapi id 15.20.4734.032; Tue, 14 Dec 2021
 08:07:52 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 2/2] fetch: npm: Use temporary file for empty user config
Date: Tue, 14 Dec 2021 09:07:26 +0100
Message-ID: <20211214080726.958-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214080726.958-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20211214080726.958-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::23) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (94.134.94.40) by
 AM6P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 14 Dec 2021 08:07:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a5e48c-4efe-44d8-60b5-08d9bed8d345
X-MS-TrafficTypeDiagnostic: PR3PR08MB5577:EE_
X-Microsoft-Antispam-PRVS: 
	<PR3PR08MB557755B0362F54A626D4D7A2D7759@PR3PR08MB5577.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OvrxvJQOP7mVEEXL57HaQBWKNNbyrtWgLuEh9OFKEcgtR+NWEGh8VxaUbiAf4y9Qx+5hPIg9l8hJR5OdSgPRVnecGu9sqQlcV0vMpjjWXL20igmjr7VJQ71tV3RC+U8I3J3B4a7OzWNAB8TdWz6sqwSW7TZzGitCH5QAtlYd/e94XpvicMgKLXkBD0x87AEN31das9xVmKZBHaOCN2uSvm/vhb9pKFueV67m04pd3Dss6qc4HRPiPgnhC6guIUGSxgiAEKsyI+yRpkF7Rn1OSxg4ANOgEV7ZC/6rotLwGiw/2F7+dcXowRf9ih/2TeEEWM4SPvV3T00E9wVw4U8r/ZpvEraaqxDpVgq4glxPtXc2+iToxoeDkjtWenl4Z+wJYbTnlPpbFtibgKYlSsAna2RajdaBTZf7dCko9DET74ntN1BD/+GjwPMIoKSkIZNwbVLzRdoRw+1JUN1SaKdyx+KRsPc67c08CxeCjjeuurw9libkKUCI4gLy58iQdYV19bcd2HM9ciyS3z5lLjUt7pZC8AxhvYm83G95wnPLGSdQZhyupOpuTAWVicXjIvk/y2UzXWp6n78bH7Fe55RcmeC6uvvximQYrQzjhsYO6ix+2Wcpuryg8XNI+J7Wu4CI8F3ciNsomz8gUhTYyUPl+nyaA9emFR9h22kTLx+t3T8GDP9cbxAJrpeirk+5au6kpbW3fZlFAcQOAEyQg3JuMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(7696005)(52116002)(26005)(107886003)(6916009)(956004)(2616005)(508600001)(4326008)(186003)(83380400001)(86362001)(1076003)(2906002)(8676002)(8936002)(6666004)(38100700002)(38350700002)(5660300002)(316002)(66946007)(6486002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fMoCBs/WrOann4IrzczA3kYq2YOOtmVlK37aRexPfHmgpJy08XkWwlHc8iwf?=
 =?us-ascii?Q?6Ty8xbA+sc/3u/hP//hqDUrki0fS1+5ipK+EEBJFgf774LiufZuTJpWPAAFy?=
 =?us-ascii?Q?H4DtkuVO5UHlKT55hA0Gxf7uJwvyFcKLMYsMfpNOlqzAecZvbTDo6M7sOWP5?=
 =?us-ascii?Q?i+YRRjx35gnx75P5ydIGKvbFShmWNykw7GcLckyQY5W2a4F+wfd1tp/bIkM3?=
 =?us-ascii?Q?zFf46BBNBOkKZDc1srOOxD/194gTjw4zK43GYXlJzsU2Khmo9vslMUXwLItI?=
 =?us-ascii?Q?RJmvmUb2NM1PMVRLVN/fN97uFtKmo9rOgBv23zlWydoexagKvFc9xCBQHlwB?=
 =?us-ascii?Q?A1NyDNY9c4BX/uVqEBuNkJQwicpGqlhxNG2V2HjcIRWlhk+dfUAYk/OtJhXL?=
 =?us-ascii?Q?91/4CWb27PZtXGu1xAVqhjw7Py2HnwbMlvtRr7eZFmGb9+YvLRlVez1nzB0V?=
 =?us-ascii?Q?OUWngKWNeKXhkEo4/Ro67eBdDxoVi01y6DXGKyADa5rNb8uTrqZ4afIaAhlJ?=
 =?us-ascii?Q?wmgrAcpFigPzkaEb0+o3OKP7m08Swc3NBvP/bLguD4qp/JBmWLvFrdcgKXZJ?=
 =?us-ascii?Q?2jztGvvkzaIu7W2MHz6uwP0Q2ZaQduBwLbYN6wKar6jF5Pk9vbqnWSs2vXWm?=
 =?us-ascii?Q?aWeZ74XuSxoYYAEeKzsgT05pRBIEMChoef9kdtqaDdFlQ1Vsz6PYFLBi+K0u?=
 =?us-ascii?Q?bGstRB36Grd3TLBBYfxVD44rkGHzGyRY+vsn+Zkj9zMMoWWqG/sN9NUnIjwr?=
 =?us-ascii?Q?7sSNRDzoMyOjTMbLPHuogWt678w+vBoThYdiaMvLEapcm5h3bWKsIKKJPRle?=
 =?us-ascii?Q?vTawVtEDOr+2gR1zc6ZtjCdvY9paCP0dOnUBko1hVS1OPwJZ9KtGVZEAcNIr?=
 =?us-ascii?Q?/43vQWIUz8iznaOPIgLU79yjjNlYLKqfQVSL63ce8iBe27GdYrNQN6Ht0By0?=
 =?us-ascii?Q?nUYtxHiJgLDDizNYQfdmjc72CdKLJRXIr5D7j+8wqd1rH2hyBZMPxlBlpnrA?=
 =?us-ascii?Q?HSU4tvM0BTrL4p+ee4jBar6epVVXdLYPpL9xm75bWNxa1yV1a1LVLXA9nsMP?=
 =?us-ascii?Q?WVUcPrqVq8k1GjReS+vrb2HLeL2KD9rE4+rtvRZU9Lk6/5+n1MHOjExju857?=
 =?us-ascii?Q?s7UlUkABtWYg2L4afX/SqxnPZ1JYdEZrqXRRGSaZUw+WTtzgyLRDu6TCJUD4?=
 =?us-ascii?Q?BAi//QsnCc8We0theK926H1ikm1bgDNSkOa35UKb3XWrB7O/M9v9nxT+p8gW?=
 =?us-ascii?Q?+aoR3pf8DxbQtw+z8nQ+cbJW3AqvoASUimq2M87lrizzI6dtd+9ONC58JpPN?=
 =?us-ascii?Q?y3QPwqhVzV/EZW5poX2CjU68L4tNlYsb/0AXxCLm9piLsW0nIfcfIyBUtyl7?=
 =?us-ascii?Q?N8PM9RUHpCcrRbEcfVwd8iGRBQG86B1F6h+6qsQHK1ZYt8+H3m9Wem8umksB?=
 =?us-ascii?Q?Vc4K042I1BTTiddJ+T/jNmSKyvjohdqRX4BBlMDlsiVYtoaP/hZU6aYnPxiv?=
 =?us-ascii?Q?A0/rvlZ8Y5Xmt+lE1OPvlsplKJdiL+NYGwqUo/FECMk+/kxln2uWL+CaaVsQ?=
 =?us-ascii?Q?d1ew2oJZw+5S1G3zsRVxSLKI289t9WdEH+aVcvtoTnFX5b6v/8t4mZcxXycW?=
 =?us-ascii?Q?A4Dr3nb82P+duff5YWDGm7Y=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a9a5e48c-4efe-44d8-60b5-08d9bed8d345
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:07:51.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 0cFTxptDIMV/sGsles0CFfRV8nGz1/xKVsRfsaElT4v0iNr8rdxtGOQB584XN5tRTZRzbE2rf7lZaZe9mZ0QbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5577
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 08:08:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13156

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Always use a temporary file for the user config 'NPM_CONFIG_USERCONFIG'
because npm otherwise fails if configs and npmrc aren't set:

double-loading config "/dev/null" as "global", previously loaded as "user"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

Changes in v2:
- Fix spelling

 lib/bb/fetch2/npm.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index d9daec20..b3a3a444 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -79,16 +79,12 @@ class NpmEnvironment(object):
     Using a npm config file seems more reliable than using cli arguments.
     This class allows to create a controlled environment for npm commands.
     """
-    def __init__(self, d, configs=3DNone, npmrc=3DNone):
+    def __init__(self, d, configs=3D[], npmrc=3DNone):
         self.d =3D d
=20
-        if configs:
-            self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", b=
uffering=3D1)
-            self.user_config_name =3D self.user_config.name
-            for key, value in configs:
-                self.user_config.write("%s=3D%s\n" % (key, value))
-        else:
-            self.user_config_name =3D "/dev/null"
+        self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", buffe=
ring=3D1)
+        for key, value in configs:
+            self.user_config.write("%s=3D%s\n" % (key, value))
=20
         if npmrc:
             self.global_config_name =3D npmrc
@@ -109,7 +105,7 @@ class NpmEnvironment(object):
                 workdir =3D tmpdir
=20
             def _run(cmd):
-                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % (self.user_config_=
name) + cmd
+                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % (self.user_config.=
name) + cmd
                 cmd =3D "NPM_CONFIG_GLOBALCONFIG=3D%s " % (self.global_con=
fig_name) + cmd
                 return runfetchcmd(cmd, d, workdir=3Dworkdir)
=20
--=20
2.30.2


