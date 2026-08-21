Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12DC5DF94
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 17:06:58 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (SJ2PR03CU001.outbound.protection.outlook.com [52.101.43.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11.1787332013544301972
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 10:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=lHl2Hxc3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.43.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmQiphr1s9xViUWEVTjj/o97lvpB1VorgVpSl2GN/z71v5k1XjYdKfaCWtvaZyFGO3sQ6/EAA0W1WSGShjeqdya4bWlt1iwZOO3C4sJfK8CLBGvw1EYWtOPRWDRLsOwstURrEstx25vlvQoALBuFukbT96H8lzI3qpraUdsIy1AIz2QqLAOQnW3zELY7FN9rHdWmDDoVmANUbCHipvPmKDTaLg/E2IsSiZOiY7L98EBpoCSGESazKsXFZtmDDorcnp3h+qxkarSAzXTR0gur93ozoXPGecskEEQFqcSe3IMA7SimnhtbYr8N9dOBplWeJ0s1xscfkQCDsEo/o5yUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmckgNDx9luX8PPiO3GaYgxodPBHqmLORxv+7ISK4Nk=;
 b=pO1hnbRMEy+hEcJjT/Klwr0ZMKPmWxzhtSLaxLMlw+3Z1f9ARX7MpnWf+o+XcaVUZS0IUxaUDuGwCez/aMV8mD+3MMBMdxptRKY+54iNjjSyzNhZ8txnhXhQ+2F9/wRReyo0+AsGpgF3J6JaogmUmrZD83bnhjcYwIMMT2IBmoHDBbfGmaSMrbooXo+GkmXumG8896owAYmTRDUHRDWmaeo1yJ/V5kCsrl8GZUNicgcYpCWVU1IsepY00DwPWTu29FcNHVKOy11R9J4eO803uBc3qY/FfhLp4Ss1NVdJhA0DUqsTnAmqL8W2+J2u42mkvb3xmPlMHReDGTLMNlVg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmckgNDx9luX8PPiO3GaYgxodPBHqmLORxv+7ISK4Nk=;
 b=lHl2Hxc36cDKkyUE5POrgrtd4Qek6XgbAPORIfmh+1XVsezvQYVsAjGXvClLXpqw+hnC8VGk0oW3wITdEOm4DfwNbOgKxCjOBGMZpKkx4L8efxGDlfwntEM97258RsPWGYq69SP4Y+KDQ55joobEBsWaDiVA31oevycj95AOfyFa22PVOcGHHf2CH9G9DKCTgQGo+rbnNR5DuCtgVe6/NFbK6KZgqKXNR+QHqYh7p8Z+k/KgqZDbuzwa0FeQIJWXLbVuhymlJMIUJoZ7CYEB/2yB6LZaIjcceLJC1YwARvQy5U8lzYqCb2i1Vi2AegeDH3MlK4XSCpCXXsgp+Jck9Q==
Received: from BN9PR03CA0626.namprd03.prod.outlook.com (2603:10b6:408:106::31)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 17:06:49 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::56) by BN9PR03CA0626.outlook.office365.com
 (2603:10b6:408:106::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 17:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:06:48 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 21 Aug 2026 11:06:40 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/3] bin/bitbake-setup: use bb.fetch2, not bb.fetch
Date: Fri, 21 Aug 2026 13:06:22 -0400
Message-ID: <20260821170624.436725-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821170624.436725-1-chris.laplante@agilent.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5bbd50-3721-4a2c-9235-08deffa696a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	IvsRVf+L0ghCPkiPGaPYpA0YDfDRc0LDXBsuiOBUpbQlrotV6XO+7+UwA+xnBXuqaNRlhcBkeptJdVBdKK319JFaZjvJEGzJ2JoYJTh7fjtkTlwLy2jojTfksgSOmozwn8bgGrG7ej4yfDUulBXprJf5yTu+fd2Tv56G6Axaubw7xcWGFGZ9BirbCk6qTQZGpoItY9cdDsNPIuS4tlmPraXQZ952inQ8Dj6zw8Qw3dV9h5YNhZ3/D5UUqkxtqClV0abpCQKaalEWhGVCw4E5ft6DbGAvFJZlnOXKGjH6KrKgTmAg6IyyQ75FiQAWllgVYWoD++m0uzcv//wSe0zt1qOLb4/Qu/6q8Vz2gBGeQErRY+NpazuFHgS6x+mz+ERbpOXnwnWqo7WgXhAXjkEeK6gNEqjSue8x5ZAkNIDCIcvlPDHTf5k652WYWQcqr2eDEyLJjObd9S73MAJrCqGesYACLuMOT1p4FY2YLXHDE5hwkxl9VK261eH492/nGOjm31YDAdxACJ1ZpWK03lmnTeOhN77slSmTDMttQ3uhgq83i2o+uyny4tfVwRM9ha28VqKZn0A8ggrOtcEFqxSu0pETAYeJNKe05EiQ6PJ+b1vd2kCF33LGgAOeRN3Rkt8aDvtYUn/j0/uj51AvJwYZiEZ2Yte/ZBy3h2iDbm3l2PhkMhfe8aiq6AR7VqjhOG7rAh3L6GBQ8ZBY5pKCYKffiA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	OtWqPFycFp6+M7Gv7wu3GQd1tjS2yfHwDkE6MBpWkj9mpyNnvFtXVsR9RVMAOntZFWK7ku+/7DwY6F83GWOfftFMNlmYMi8NQbKoSYeIMt5rED1CezZ6x6EgZGJXARn7vPiXa3y8hfQjHbsbjGrxuwdJDMOyuMkbtf3dJOtj+lk55DUPgIfWlVGihmlKJqa5J45nRZv1Z91S4v95gg0B2CvD+4BQcuiqJNFxIx9xQlY0W/dXtBqvaROG8AsP5kPIxApsWZ/9Ty2sR7OTYErZhrfoiBcrQ8vZkuuyqM728ilpAxs69/QxD7jUfCR4yOwbHCvo0p0NYdf0r1hzjS26MZAqVjoJZ6aqM6G7FLVQsmSI9FozvZxTO9aEcacrhbaCPjPTT4DuwVNmwrIKuD8iiPEa/2iVZD89LNDDditEeoFxiDyWnzaetC24p8yMSD5i
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:06:48.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5bbd50-3721-4a2c-9235-08deffa696a8
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 17:06:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20009

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-setup | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 92ed563c2..3d349663f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -104,7 +104,7 @@ def init_bb_cache(top_dir, settings, args):
     d.setVar("__BBSRCREV_SEEN", "1")
     if args.no_network:
         d.setVar("BB_SRCREV_POLICY", "cache")
-    bb.fetch.fetcher_init(d)
+    bb.fetch2.fetcher_init(d)
     return d
=20
 def save_bb_cache():
@@ -181,14 +181,14 @@ def checkout_layers(layers, confdir, layerdir, d, reb=
ase_conflicts_strategy=3D'abo
         remotes =3D _get_remotes(r_remote)
=20
         for remote in remotes:
-            prot,host,path,user,pswd,params =3D bb.fetch.decodeurl(remote)
-            fetchuri =3D bb.fetch.encodeurl(('git',host,path,user,pswd,par=
ams))
+            prot,host,path,user,pswd,params =3D bb.fetch2.decodeurl(remote=
)
+            fetchuri =3D bb.fetch2.encodeurl(('git',host,path,user,pswd,pa=
rams))
             logger.plain("    {}".format(r_name))
             if branch:
                 src_uri =3D f"{fetchuri};protocol=3D{prot};rev=3D{rev};bra=
nch=3D{branch};destsuffix=3D{repodir}"
             else:
                 src_uri =3D f"{fetchuri};protocol=3D{prot};rev=3D{rev};nob=
ranch=3D1;destsuffix=3D{repodir}"
-            fetcher =3D bb.fetch.Fetch([src_uri], d)
+            fetcher =3D bb.fetch2.Fetch([src_uri], d)
             repodir_path =3D os.path.join(layerdir, repodir)
             try:
                 do_fetch(fetcher, layerdir)
@@ -909,12 +909,12 @@ def are_layers_changed(layers, layerdir, d):
         remotes =3D _get_remotes(r_remote)
         changed =3D False
         for remote in remotes:
-            type,host,path,user,pswd,params =3D bb.fetch.decodeurl(remote)
-            fetchuri =3D bb.fetch.encodeurl(('git',host,path,user,pswd,par=
ams))
+            type,host,path,user,pswd,params =3D bb.fetch2.decodeurl(remote=
)
+            fetchuri =3D bb.fetch2.encodeurl(('git',host,path,user,pswd,pa=
rams))
             if branch:
-                fetcher =3D bb.fetch.FetchData("{};protocol=3D{};rev=3D{};=
branch=3D{};destsuffix=3D{}".format(fetchuri,type,rev,branch,repodir), d)
+                fetcher =3D bb.fetch2.FetchData("{};protocol=3D{};rev=3D{}=
;branch=3D{};destsuffix=3D{}".format(fetchuri,type,rev,branch,repodir), d)
             else:
-                fetcher =3D bb.fetch.FetchData("{};protocol=3D{};rev=3D{};=
nobranch=3D1;destsuffix=3D{}".format(fetchuri,type,rev,repodir), d)
+                fetcher =3D bb.fetch2.FetchData("{};protocol=3D{};rev=3D{}=
;nobranch=3D1;destsuffix=3D{}".format(fetchuri,type,rev,repodir), d)
             upstream_revision =3D fetcher.method.latest_revision(fetcher, =
d, 'default')
             if upstream_revision !=3D local_revision:
                 changed =3D True
@@ -995,7 +995,7 @@ def update_registry(registry, cachedir, d):
     else:
         full_registrydir =3D os.path.join(cachedir, registrydir)
         logger.info("Fetching configuration registry\n    {}\ninto\n    {}=
".format(registry, full_registrydir))
-        fetcher =3D bb.fetch.Fetch(["{};destsuffix=3D{}".format(registry, =
registrydir)], d)
+        fetcher =3D bb.fetch2.Fetch(["{};destsuffix=3D{}".format(registry,=
 registrydir)], d)
         do_fetch(fetcher, cachedir)
     return full_registrydir
=20
@@ -1105,7 +1105,7 @@ def install_buildtools(top_dir, settings, args, d):
     logger.plain("Fetching buildtools installer using bitbake fetcher")
     logger.plain("    {}".format(url))
=20
-    fetcher =3D bb.fetch.Fetch([src_uri], d)
+    fetcher =3D bb.fetch2.Fetch([src_uri], d)
     try:
         fetcher.download()
     except bb.fetch2.ChecksumError as e:
--=20
2.43.0


