Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D66C021A1
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=ZeBFuDed;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL7jZ6wpxth6aRIPc9ji9V+TVi/pEZjzp+kCu1ZG9vSw2iCwoJAj2rvBwTwkDAYuEzt2CmuU6oYutpR9ZqtX52i6p8uMjbraKhjskbErLyexz5SyVLJ9Vs4oV59Xx1uehp4aLxPnl27OIHhmHvtJKPe08W0B0cb4G6NNZYD+B5+PFCg/D5MuC1TAb+tjsO9mcHRZ4znTChsI+LGNcmquSuda0Mw/ea4ZQKaLzEMPqIoZDORg9EgN0/O+48CFHkqNb16zIZq5pqVezuKFIWzGX9XR11+oC2ebBi90HwbICEt2RFY3E1LPL5cM5eCfW2QOtRSiGbKBwhN3qxhOvG7MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmv7hksz5Sqvz1EDeLwsF0l2sciZXa/WU57kAW17UzQ=;
 b=a8B2avTSXpnBNJDk3dl34xwtVg0AHRL0DSSbZjuGnVlRqLd++igTomGkO4Zk/CAOCcG0DMTbnpAnE/7+rYRPJogfFVENVdPXJM6l2ivqqHP9oORwLddpSqX8/UEUP5OcvAOHs+YI25QVcH5F3tm+PluuhNZLX+botWBP5ObSMCDcokR5fr83AGuYLWbrlwWo+SOaNkePWsVqRNOKxfQEAc7J93AMsWZ1lePWITHbsVfI3dt6rsAUoilK2wnm+V7GMKnLbi6TH4w8EvIb6G13wN03rKrE40yqVF1ht2kDiGX9DVRRIT6rQ5c4/WnIxPuVp1eFxAeck1Hkgbp57J1uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmv7hksz5Sqvz1EDeLwsF0l2sciZXa/WU57kAW17UzQ=;
 b=ZeBFuDedKrpKJ8bmkWrM+fsmOtQj8L60ntq/LWSxkYjjfp8V8CVIKPNDvmmRM6rz/6QkXaQbidED6h2pqzWS2jY9527NAspGXv/ano3abz1rMuXdzrO+UldAH4ArtO0V6/Y7vU/ZU+UuPhLgU8Z2SvHDNWHP4WZDsu4RkbhS9MErREg8sfByE1QhZIT0FgwYN+2qXcLAtOVMKxOa3wZeq66SLGF3amR91gCtuSKczAO1AXDsoSiChUDbnM5DtWrCEybm5BQHUFXaTegDZnn6vQpEssstkocBKv8CCbUcy6h+dhDShpxjC46YqkNTUc2jRhlTkXjx1PJDynoh97LfMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:53 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:53 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 08/15] fetch2: use localpath instead of localfile
Date: Wed,  5 Feb 2025 08:15:31 +0100
Message-ID: <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cbca3b-eb18-4ddc-2a08-08dd45b4ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/6UZ90eFdSHzEk+MWrCF0OY1CfibY/o2FupTmHleo8+g0d4K9m/qG1A3GmD3?=
 =?us-ascii?Q?FggNJ+d7uejqQfo3xxgtUy+sLzCErJMFcQHSeaAbzNIKpf15xTUUR8HEpQFY?=
 =?us-ascii?Q?b6Nk9NyY6fFSaFMFFe5gA8zxLYlv2ACTDvS2eGqyUv2N9kbGEYKc3ucEbe3L?=
 =?us-ascii?Q?Nc0TRURW1RzTKe+A2cKeW3v4kfJK6KJ7bUb7eUJ77uDvSVbphbqJ2k3pLsbO?=
 =?us-ascii?Q?RWlsCjq5Zf3S8xcduee05ecBABZHZfW5G4IcTSsnXQ+Zs4PNBR2RPP1PQdYH?=
 =?us-ascii?Q?yP6OCtJHKU7Azp7Pf/UBoZBoRu7Gab7sKfPcgToxlgAku7i3/jGOyQuHEZsJ?=
 =?us-ascii?Q?sV5Wi0eK6S+n3+tR7pMEuXj4C9pghStbTxjPi2VObB74Geg3b9afD1lyAulB?=
 =?us-ascii?Q?sHIcUnRna8siuJHEQWTHmCPBEaIIu/ENw51U59m24+s6YBNIXpWmHVloaifh?=
 =?us-ascii?Q?3ShBwsy9Pch59BUERzNmVaatn52E4ahBs5tvxZjb4YDhzsXxsV0xmpqMBBGj?=
 =?us-ascii?Q?k72Ks69gCJiw0Y0Hv4oRF0KbFi5ZIR0+5fAOkEDdM8We5MShWE0vanOs9Clg?=
 =?us-ascii?Q?hJeJFLdX5bxvA6XIry86ZSr38qK4lKDwfrwvtV4rdFrSvcErNrXRE9hi7qgS?=
 =?us-ascii?Q?QHLd9HePkThYfuDyDwCR6rbXe+GNV2R1okB4rehiVn7vPf6pvOVN0vlFBwJr?=
 =?us-ascii?Q?FSP97EsUO9wxXtTnacA5g9NGh2bm6HJm5vi0TKLsUeZGDMlSoe1PwZTqs309?=
 =?us-ascii?Q?UsaftpIz7tRF6beBxBvBLtiYrHhY9x4XEgGXgZOf2+3OUq4NgX2Kv0wKQaX2?=
 =?us-ascii?Q?xGg+AwYy3fXnRc6Im7Yg4EYPljWxF42cVdCu4YAyXnG+wSNjZmvIgz6a6StG?=
 =?us-ascii?Q?04SnD6wtxPTA9ooYTe4cbta3pWPNaQ3zLCw/sqsr3IoguJQBIdNo1DFVXPfA?=
 =?us-ascii?Q?Gv81flbcLywbg7CjyVHhx2IzDDWauNonXriXKwUPBn7jh/gmgw0iRweoypwW?=
 =?us-ascii?Q?nD9WkqbLS5TGZAF1nMTivVVOZtCHpWZhfruXYk6FZ/u1fl/QneAlCKx96Tdu?=
 =?us-ascii?Q?9BjrHxAMhY8ncQxrd54Wv0uZVmz3wJ/msi7fFU+2xnwjKdlWA49oJOVXXbr+?=
 =?us-ascii?Q?pZN5Ag3nRX0S2CBYcq9hzaKwMvkTjboggGBHZK7TbNEnDTyysGOGE4UT7Mca?=
 =?us-ascii?Q?qOuvqLrKP9bEtxAMq0lIkHv5O/N5T4YSCvjgRbMFAZ8SDfspk3FTQK5nxA91?=
 =?us-ascii?Q?t/m0fHFvFlMKVGCpjcsVWwMuYgNVIuW00UM2QtRT8vgXc4W4hA+hZuL76OHe?=
 =?us-ascii?Q?zUpYuGRGitvt8f46gkdOLrezhP/8KMUThc6J2McM68lLRszvxSxv3Lawi2VA?=
 =?us-ascii?Q?RjngPAdoHhrMgfRx69RU9q1uMDf5AVopdKsQgFgBKjDlIMuK4gmX6QYWkFjv?=
 =?us-ascii?Q?j06uUw0iQ0cNbmEYKSyE2Uf6hLCMIFmj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j0vrhLnBIzuAtY9ul1+OXchrUUPXFqoTFMIVWL/ofsTn+by1cZUrKJD13Nv3?=
 =?us-ascii?Q?yfFJijB3+CQjOez8kI0Vbwc3ZZco607kqDrdHwUkDlrwHamUFTx2ujiojmaE?=
 =?us-ascii?Q?ds2WEQ7br+hI8nnM5NNoUITeAewa5xRpkJFP7svP9MqbtV65HKavXx8JgHW7?=
 =?us-ascii?Q?X248QjKN7XBscESaOYLmsRYOuJGgFMfc0EJrrXtdUBuIgN5FXa55JzNpJTtT?=
 =?us-ascii?Q?3YM+N6Qko6twhbfqCkq18WJSepVA839AEZV21pfglEzF7Sr6wBLZKtX04d3T?=
 =?us-ascii?Q?xyZkLnqrSsuxuwHjlpCU/0RQYQJsRQlpCKjXaS/76fQgqLIv0T0soJiCjN1L?=
 =?us-ascii?Q?xNEH7WQJ6KDdOmfcTld/ZQaMVet2D85X5SpeZVKIydi5d3MUVPbQSOfb5KVW?=
 =?us-ascii?Q?T7nafXTgubpedCiGGszCPcIwJHsDEPfvWayUXTPfXt6zfbaVdP/NTKmB8SGa?=
 =?us-ascii?Q?7iLOQW9wkVuRKjZPfkn0j48NkOU4TG1v1vG9ahAsCePOZo/RVUkAqqtIl5x3?=
 =?us-ascii?Q?V3VOaKk78nb1tevYpivobgXg8pIBXv0woVZF78vf/CBKbQXwhwmwKqJ6nICj?=
 =?us-ascii?Q?8ccDmjTbPkvnxvhiGuPldo4+qiZ6L//BwqL4zGTzLN635KJHSaekl3qirZna?=
 =?us-ascii?Q?NdJ4FpTxVfxHF6+W14obFwZoCYZXyUprYyX7GKJWzjtEnZhtbgKjIhXeuUWG?=
 =?us-ascii?Q?3GL7RwkOX1yEHK/0jyZBJtAovbYAsimIjtaDAuCjmUl351nJIJaF7CMINj/H?=
 =?us-ascii?Q?duygXzGiVRx1vIpXJai3rFpqN2Gey8aQ5O7rk4PT5bnM9V6hgGXcW/rJoXut?=
 =?us-ascii?Q?Z8du+fiOi6hB7IGwzXhotLvcQOX3ocfT1lWG/kdjcJpdKCmJrMQ4+NEXVrj3?=
 =?us-ascii?Q?bjm74AGJ5+b5qsBzqR29urAttT/aV1U5mFUjA8Pq+suESynmstv5gfFz7Ckd?=
 =?us-ascii?Q?WtfmdcZU15Vd4YIoDWGK/d4bqJmtdM7stv5Df4QDDsfS4+5UZlOzw7iIq5/d?=
 =?us-ascii?Q?gTCADkrMsfBr2YRbQd5WWnbYoPVKIUmPwvI8Bqjj93tq/vPN6xaNPUfi3R17?=
 =?us-ascii?Q?/gGiBn6IzKCR6qzwUYm+RxPhEErLOjoOAle319TLblEFvvEavT1gr6b5UFa2?=
 =?us-ascii?Q?xdVkKpngBGVEdsPSChPmA8VG5Qjinb+lGpltV/uHqnj4dws5Bp+Ro8CuQ7TI?=
 =?us-ascii?Q?2jEdUCke6dLBfv1XBioyV6gRRNZQ9nMCwEsJ0/IIeQ58e9cixY+8R2V1+rCZ?=
 =?us-ascii?Q?lnCocUsl/bib3hXULoBltS+08gTKwvMG/0fTyX0aXN4CwjUu5+PatXtlsoi7?=
 =?us-ascii?Q?RkVEBPchS07TbCwbbayt2V20Tl6SiayKgkqIDIb2usZwYFYbzLLGMfULCRca?=
 =?us-ascii?Q?JNFlgCzMhamUtu5dShSzSz3LheqXFHkhysNeJzq7zHIwXQY77maoAzIfAEtX?=
 =?us-ascii?Q?lQmvwjldU3xRjQ4llyd/CBbu6LQzP7WCPrSBJHsqFH9c3MegQUmmLQPJqqSN?=
 =?us-ascii?Q?/UKHCQd99bT39rZyTPZbfe+4DBClsI2xoRWbZjdm5/sLGKvKrXLVB5MskziF?=
 =?us-ascii?Q?soiXVZ6USRGVf97HyS4eNIT17VFdLFxuQXmEyhvpUn1srwqYiB1NCKfkbj/V?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cbca3b-eb18-4ddc-2a08-08dd45b4ed1a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:53.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIk13i2FgSdiqYrxjmv6SAWyJOhI/r3AJ9uze7/9z6P46SfTdGhXOGxi+Xv31hhjAp6CJ6jAnllUkytj8W1jkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17141

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use localpath variable instead of localfile and DL_DIR variable.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/az.py   | 3 +--
 lib/bb/fetch2/repo.py | 2 +-
 lib/bb/fetch2/sftp.py | 3 +--
 lib/bb/fetch2/wget.py | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 346124a8b..1f0f1337a 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -49,8 +49,7 @@ class Az(Wget):
         fetchcmd =3D self.basecmd + ' --retry-connrefused --waitretry=3D5'
=20
         # We need to provide a localpath to avoid wget using the SAS
-        # ud.localfile either has the downloadfilename or ud.path
-        localpath =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
+        localpath =3D ud.localpath
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd +=3D " -O %s" % shlex.quote(localpath)
=20
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fa4cb8149..5c0edf1f2 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -46,7 +46,7 @@ class Repo(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
=20
-        if os.access(os.path.join(d.getVar("DL_DIR"), ud.localfile), os.R_=
OK):
+        if os.access(ud.localpath, os.R_OK):
             logger.debug("%s already exists (or was stashed). Skipping rep=
o init / sync.", ud.localpath)
             return
=20
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 2a2a70a1b..b88dc5a28 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -82,8 +82,7 @@ class SFTP(FetchMethod):
             port =3D '-P %d' % urlo.port
             urlo.port =3D None
=20
-        dldir =3D d.getVar('DL_DIR')
-        lpath =3D os.path.join(dldir, ud.localfile)
+        lpath =3D ud.localpath
=20
         user =3D ''
         if urlo.userinfo:
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 161c66bea..1194f0e7a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -95,7 +95,7 @@ class Wget(FetchMethod):
         fetchcmd =3D self.basecmd
=20
         dldir =3D os.path.realpath(d.getVar("DL_DIR"))
-        localpath =3D os.path.join(dldir, ud.localfile) + ".tmp"
+        localpath =3D ud.localpath + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd +=3D " -O %s" % shlex.quote(localpath)
=20
--=20
2.39.5


