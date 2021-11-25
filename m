Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCBC433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 13:00:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.53])
 by mx.groups.io with SMTP id smtpd.web12.11588.1637845220665090110
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 05:00:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=DsvKUkH8;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.53,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlGrvjuXG/XRfzhw5k217ZpFLNyUMj3ElzNjIL7OJEMwi7gUjhZLYym6TRcZiMVrh4+hcB0L+/fGrD8VaNut4mGchxNbkgjoEf3YQSoleQIsn+w/cDilpmYjRlshXI33ft8AKLv4Di+MVbRKfhCBenKvSiLv2mFzef+Qt1lTiMWr7AeqzjymAA/W2f6tTF0kejRL4ArPgd1xQnggCFWtZuZG04VFghwP8fqLqGhoU2HMhbxRD6V1QrIsbwGFJ+nvkabtZHUC2mCz7G/ZLfRhECQfNHlzDkoaGgTu7dCvvAHl1LZ4iVxyWAMGqdlyqPI64JgMQF1RwHVUwnsGU5iYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MtG/ZnaQYaC3LkXIwzROTukLBc03qwPzRwcyM2nAnY=;
 b=nIwy6dxrm2vJL+TxNRlUHcVION+7ovX2Q0Wz2+ertujfHLdU/aE7L/JZ9OJfXGMcIrd3D9RpFzEO8ME1h38O/h2mguIF4OuTNJZox2vfMqBKkIxXoeEQ2iiEalJOBiwLgA9UW/YN2wuRxMpv9LXTHnID2xq5iG2dij6lGzxz3q/HWJGoF5cHiXYQEDZJHeYbkYtW4h4BTs6KSqK1mztBGp5QPFHdaV3N+21J3obsxH9BDU3LstiQKf5dqHZEqvYyHb9Ey5HFBHWzVVmV00LBsOjx5CDrp3a4o6gJx7zRRRnPiRytrw84CctlMJmfX0w5ihXwGb0roVRI2+KltOtdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MtG/ZnaQYaC3LkXIwzROTukLBc03qwPzRwcyM2nAnY=;
 b=DsvKUkH8HPtyHqHWBWNh46T7vGNL0vO7/mt4tNR9hhsMuOPC3s0v2kYGNzfi4L6bsTe5Q4pfYzRtqqw886p0Fr1XOCYqlmhxOjGm9NDzJ34Ue9LQdjNt/wG7KxnyLL+Y1QEoFtUtKrg2ajXAGr5BZxILSK97p2VrolC5s4p6r90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR2PR08MB5228.eurprd08.prod.outlook.com (2603:10a6:101:21::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 13:00:17 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%7]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 13:00:17 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	Martin Koppehel <martin@mko.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 4/4] test/fetch: Add striplevel unpack parameter test
Date: Thu, 25 Nov 2021 13:59:54 +0100
Message-ID: 
 <20211125125954.15890-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::27) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (94.134.181.29) by
 AS8PR04CA0172.eurprd04.prod.outlook.com (2603:10a6:20b:331::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 13:00:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b49b5e9-94f5-49dd-1fe2-08d9b01386f3
X-MS-TrafficTypeDiagnostic: PR2PR08MB5228:
X-Microsoft-Antispam-PRVS: 
	<PR2PR08MB522886A8C41187E1782AF7A8D7629@PR2PR08MB5228.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TsO6w1YeifYqxtdD/qjrNGjhTRVFPF26MHFDa9DadxKV/kXAdkEo/0saR5yJZBBx2EH5D08IC7LG8GkSO3vifDBkWsycgmfYJSaXvtDYyhX3e6V0nMwPGVJUV7eDIByErRGherUkr79W4aMT8D0/LmawHkSXYwVMxIJed+31pDM3+uorgzCCiD3THhAjE37tnqegV9EzJYz7Blb1xnPcaFmjM1yT9OcKBIHeyHwmgxPMQRdOgOJyYD/9I3EVafSrD5p2W3QiaM3lC1tQsd4VnXRIWH0+bHXGk1dKSVoUYOyDcIqcQPmfpP2GOEpiTrCkxJ45C5RQEWlSMaIhAodWLYCupF9Qdh1W9ouDhjn7V8zbUogWecz7uDnv9A8q6xtCmhaCnsZRtTPqQDINNE1ZWvq/BGVIg7rz5wFR1ekFXILD9s0fe5p9tb0ANL37Ld05oefeHqRFnnoHKVwrfgpdje1Oda7c64rORgZZUEFWkKGIN35z5IFfyeFIojvza8JDD7nSIbpyEhdQp1MD1opMpFzAxILw2ZVlc26nArWIfzGE2OxgYmRAa8FGlEgfsqB18Jk6Qvxq6bQZ4nwPq4eEOV/RropiuRT5yELEoomp8Nug1q6GbqNlMVnjH6GhgtLPGt26KZGjZOC62n9JB5uQfpLjv3MHFJYLT5y3MYvfvnL6JzKd6cSrbuXUDh+3IkeiTNOpz9xYreu3EX7u7hEvnA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4326008)(1076003)(26005)(316002)(66946007)(6486002)(8676002)(8936002)(956004)(110136005)(38100700002)(107886003)(2906002)(38350700002)(7696005)(508600001)(36756003)(52116002)(66476007)(66556008)(5660300002)(2616005)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?koUMqalYrJEh3rvVuTB1ni8ROTcDIK24tZ15h7IluDkW+uqdCGFDolzLQFLz?=
 =?us-ascii?Q?+sfM5hTG5krIkenKbmbJWmrMeum/RqDvJqSSjkMVtzXCRR1o6rK6q3j8dRMu?=
 =?us-ascii?Q?3LKnSlDipr90Np9YliquA67Q8kzkFatAPolgKWpmc1u0LGBdCvxreeB0MB2W?=
 =?us-ascii?Q?zrPwh7sd0mia50Mx5i8Ug05M4u8hn3ImpDjhcy7S25yjMqi3JZIRR0c5alrS?=
 =?us-ascii?Q?pXnGnQEzfadKR+6iKBiHYXvkxYvcstE5aEBv7YPYtLMb0c6gkQ6O3LiERHSo?=
 =?us-ascii?Q?isQDNlGIfSj05rFYTR7WH+H+mN8PvWkB9xH726JThLrHYf3PKLTFi9Eb7O7Y?=
 =?us-ascii?Q?pPKxj9Q2kH8Fn9+cPtgDDpz5jIWILHe1l9rT8xQo5v3B4dh4XRj3femYHsqy?=
 =?us-ascii?Q?3BtFbc6wkz+0eLrS/stLGTiqqLjaKBlMi+caLVub8y8wlzTHsl1z8ucVHGwB?=
 =?us-ascii?Q?XR6H2Cu8rzcbRTqR65KsUDfUttlEQdCd5hrLGVQZFUgQByjuQXKRlK65DaHd?=
 =?us-ascii?Q?sxJOIfZ0DI6g0h3a1N10RL2omn3iKoPB5LivGVP/Zujb7irAQi5qxsC6HOc/?=
 =?us-ascii?Q?tqH3e+Vwh3KubiVsXaIqgorxzLPp6Ws5Y4RUFRqAHhW1RwXT3wiR6aV7q2fT?=
 =?us-ascii?Q?u/n0tv+jbmFtm7GEAMvgZcETk1tiYTmjtvsfzsMW7HMRaXlOkYP9d9Nrs57O?=
 =?us-ascii?Q?4Fj1g+L0KyjhJW76KXPyN83MGi8Jo5oz7U7RZVIxt8LJuQmiwKjuFE5cSfxS?=
 =?us-ascii?Q?lV5LFPz1MTFtu7suNGrZM6NlmyXpqwnYwJNXxNxPXPqGNiVCZncrdVYsNyPq?=
 =?us-ascii?Q?X2dlhKc15mPAFJiN42wQPG+nNC7pnPqkZndRD5CuZY9uaGuXf3a4NofO4/JC?=
 =?us-ascii?Q?bN9rveeJtvpOib/I2XQqZ3Uk270MQ7LjY59GT6UQ6t6R8o4B52I6dZXYvb5s?=
 =?us-ascii?Q?3SsEPQ8tf78l+ukttIo8EV93idqu3xD9sun2OsPPnVBWHgCTwUuJifQH3FoU?=
 =?us-ascii?Q?EorqFLIrsEo0oR27GHsQl8xQmNAp7NdMqOAjrKRoDnvrxHeHP2Xy2kMV4XNO?=
 =?us-ascii?Q?DeMPSJGIiBNUH38EUsUds+kqBIwxIy/mid0sMKbAMBoF2+Vo2sMObyvz1211?=
 =?us-ascii?Q?mwwsG/V8nbJEMJus87jtQ46b7E6DQAsOZUE6iPkvqPdGmxIipDlGC+0JsYNk?=
 =?us-ascii?Q?TDGKqnE1/ruqC1Ff8GfdCD2wtBSEgfjiQZTWDf+OCgnGZre4tD/IxTcjCx3G?=
 =?us-ascii?Q?2S2ar6Cg2PwIin0g7ejG5AFB/1sgz4E+GReLpOXFe59vcBEqq73Trn3Iyghi?=
 =?us-ascii?Q?Zzc5See5rCvpHx202fA4rqBv2CHxwGyy3zqMD/AMDmCCdBzm6+H82sFOwyJT?=
 =?us-ascii?Q?/kx/WNBWN+Cm3jF2JKICUeliNSF4LFQLQX/ms9BXZX5vXOluufH9j/NF67tA?=
 =?us-ascii?Q?9ppQo4aj+mSEKvJrevwEld9ON5KYDS3zESQs43HtmkGpNbb9GQc+a7MDwdtF?=
 =?us-ascii?Q?z+PS1vwxFI6SdJhMT4rg62T9pXRaQZv8Qtzf/rvaXo7HyvJQO5mVb7rND8qf?=
 =?us-ascii?Q?IM4EzDyKEiho5iRrru2jqGEZ3tKBd4Jt2qyTBulKiIfSxQ0ma55+eLzUW1KH?=
 =?us-ascii?Q?RMALKIDFIe1s4ANFStyaLUg=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2b49b5e9-94f5-49dd-1fe2-08d9b01386f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:00:17.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 HHsqHQHaLhc6QZZNgLSzxCCLtPAQ4Ewj+XuZST9veWFbZBPLuJ2CcsELct7kf559VB65/C1XoiWbPX7r7gtdlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB5228
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 13:00:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13108

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/tests/fetch.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d6c0af78..dc45eb2e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -626,6 +626,9 @@ class FetcherLocalTest(FetcherTest):
         os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
         touch(os.path.join(self.localsrcdir, r'backslash\x2dsystemd-unit.d=
evice'))
+        bb.process.run('tar cf archive.tar -C dir .', cwd=3Dself.localsrcd=
ir)
+        bb.process.run('tar czf archive.tar.gz -C dir .', cwd=3Dself.local=
srcdir)
+        bb.process.run('tar cjf archive.tar.bz2 -C dir .', cwd=3Dself.loca=
lsrcdir)
         self.d.setVar("FILESPATH", self.localsrcdir)
=20
     def fetchUnpack(self, uris):
@@ -680,6 +683,18 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=3D/bin/sh'])
=20
+    def test_local_striplevel(self):
+        tree =3D self.fetchUnpack(['file://archive.tar;subdir=3Dbar;stripl=
evel=3D1'])
+        self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
+
+    def test_local_striplevel_gzip(self):
+        tree =3D self.fetchUnpack(['file://archive.tar.gz;subdir=3Dbar;str=
iplevel=3D1'])
+        self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
+
+    def test_local_striplevel_bzip2(self):
+        tree =3D self.fetchUnpack(['file://archive.tar.bz2;subdir=3Dbar;st=
riplevel=3D1'])
+        self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir =3D tempfile.mkdtemp(dir=3Dself.tempdir,
--=20
2.20.1


