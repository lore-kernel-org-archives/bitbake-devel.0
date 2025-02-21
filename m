Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF8C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:26:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.78])
 by mx.groups.io with SMTP id smtpd.web11.29032.1740158767905191544
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:26:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PLnt7U72;
 spf=pass (domain: siemens.com, ip: 40.107.20.78, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+Tx4pBw4n8AiLefkjEl0jqv0FMgwksVb4yFmqIn2GpumhJQNoiJldawm5z2DLN248SYRlnmS3aYmsi3Qf0PhiD8VwtB1BeAbsI9spUI/iCAJpndebAsXw1O7k3WOq/UaVN/zfVHQpv1BdVw/q5KZux7+iumWFNUQ43rJQ0abG5KiyaejDiByraaFBMDtUPVMFNXu+f7Znbz5HfqAcCbmFDLyY9aCngibe1dPeZPeWuDuzLYikfFNuuKn3KZbz3fw81P3kwWybcc5rH+NaEzD3a7ebNOV4Icl3BzRYW4BjOHWrtlS7fFepqteXhGoBo0s36oI+HZBF2wbffdtAiVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep9gVdmoez24eqEvUdrVa5lIjDVPIIxFdg0UsYElOJ4=;
 b=awlCGPSnoCzf506LK1UTsrIsVQZzBu8hXktVRMMALnFgjq/bY7XLYtEjhG63KZDIl2SLUFOH24mkc2tn/icsyIeCmtFZ3mYyu+gZ6y48ioW/KckKG3mU0Cx3YlQsDCfTn05hluoVna1OUfux3GYL/ZoD1q35QGv89Y+SuwMZ+IN5T8EskEt+vwWpTI4ucD2y9wUwYkE6lI5LPG5yeXCziWb0RccGTMUDrxiMr2r44NRCX80aI70S9Tn041ahrJ+s4vvTXIEipY8VFkN8ys5KfiSg3O0UFa1uP3l/y+Ya9A6pxjmuVMXFzqUMJpx/bqLGRcbmp45fYf01Q7zUlNEklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep9gVdmoez24eqEvUdrVa5lIjDVPIIxFdg0UsYElOJ4=;
 b=PLnt7U72HXyy/uLNMEhNZKtFiXuFyUKSGTFniJ2Uv1MGjA7ISEB3dcbxb2ylJTrtOgMHivW7EPu/8wqxs6hb/MXqxkpsljpbWbeCUNaBWbY6Enjy68ftVsWaxsVQIgRWijuXEDPyFbCQogBz/iF1z3qFIEPXmzgzTobt0M9hboFfyY2gnBOJdRVopZoe49JLuUR8zfJCIc6W3cyIaQKAUoPa7nEA9kUHM9t/3kMenJ87KH6ypS2biIFtC9l+V9dBbzQJj7NAxSLnOgtuUDHjC/s4skwVCMDTbR0zQfucLI2CG8EUboLVRq8Rhh2ounqrrlH7aewBPK6rSOhfWNUL3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU4PR10MB8514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:26:05 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:26:05 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de
Subject: [PATCH v4 2/4] bitbake-user-manual: Update documentation for fast `BB_GIT_SHALLOW` and add documentation for `BB_GIT_SHALLOW_SKIP_FAST`
Date: Fri, 21 Feb 2025 18:26:00 +0100
Message-ID: <20250221172602.527924-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221172602.527924-1-stefan-koch@siemens.com>
References: <20250221172602.527924-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DU4PR10MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1bec3f-cb5d-4224-2a99-08dd529cd290
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X6PgI6/T08cL2hVGOiLsOxaH9BWCVvcIg41UZYZyrlYwUW4mjXUmXIocV4c9?=
 =?us-ascii?Q?eN6ViENtKOK2sY4m43dIiWbbyJlGSjxS6iS2wRlLSkDQcyR8hdmZ/D4/HIEy?=
 =?us-ascii?Q?JRhych6LOGbXTl/yP9LsZoBrwat4jVrk72rlNDgi/Iinjk3FSgU0C0+ti2bS?=
 =?us-ascii?Q?ySOAAsjtwKXls9KklK7mVCwQireGe0DMTrlvc2Xw0WUpIM4U3yF97L6Axygj?=
 =?us-ascii?Q?fUeWVVme0SK2SQbcS05fz3z/GlA3PUkWK7YNsaRjj22VjZRxy/7q9niuvEQr?=
 =?us-ascii?Q?SfrA4F7zcJeYwBvJkwsPLGxFWfGnMj+G674MSZjzSefe9ZwgqD/1UXL16NCr?=
 =?us-ascii?Q?uQZ6DH8ECMT6G9r4pcD9mPsAvosQZojEBNqCLZLAcKzX7E0SznPfRJzsG2pp?=
 =?us-ascii?Q?+8SY5ucvtzviqJFYmiKMKdKCGRcC5vDRTfpoRL46FyzBmMwahrG2OgjiOMfw?=
 =?us-ascii?Q?LgUquCA6sLtou3uvZeuElrAL5aDHlh+nVAnokR9ehnaqB8L8in691Bnh5y29?=
 =?us-ascii?Q?e9h3dFlkuL6l19zk/7c00VE2gFVxGCvTNKBsbughw8YuddTMGQN2XI5EgBAj?=
 =?us-ascii?Q?X5Hb+KUmKjUsv0mhtiH2ggLexCasXl0P8VzC3N0pVHBshc7kazxI2skDMZ3D?=
 =?us-ascii?Q?i2ZTONbuq3UpLtBGK3gjRtDCEeAZmkWcfa/J1WjisSA3TAQoNZ97aCrtfxRc?=
 =?us-ascii?Q?MnbvVhJD3RuchrpjCJqYsRrlRHpMPHo3mb6rc0WRuUyxXwaekJwhmZ8tHe1X?=
 =?us-ascii?Q?R26LCLqY9gYlYrxACYwCcHcl7RoTbbAuEyncEgPjzITH98Db0EqnwlBzF21z?=
 =?us-ascii?Q?4xO4cJ2E4oDey1d0XCbAQlG0P0cOrNTDCuVVVscibiSWD46FuS85cobGi72+?=
 =?us-ascii?Q?pW9Nv3bxCGJlKxKrbNS/3OeRe4kvfwPbM/OzByiRLzJxDBeK+izDBhAmpohM?=
 =?us-ascii?Q?0+0SbhGqO7MdWAhmd9QUnT+REpty3Sb5Z2xYh8RJdbCBuMDgcHlPT22lOUgK?=
 =?us-ascii?Q?bO11XOv4Q/pOkswXDRX2Led1wZUeoUCQxoNF3+NzXRYut4vVNJpZyvRo3OPG?=
 =?us-ascii?Q?eOozAluY+2jbzgMxuHrvap0vY5oLllzJy83MZUURbTG1cOin+RQBHbl2N/1/?=
 =?us-ascii?Q?T5o2/khRcOyVhNJrdd/ttZFT+pW9cvyz8hhnaB8doLH1nVZZ9dhni7f/RTn5?=
 =?us-ascii?Q?Vjq/eeEjgWnj981bOM8KgyWG98MDgmcCvcq2MiKZZjD6alyvtiad2yPSQp5A?=
 =?us-ascii?Q?fPVpPP0cfhQXdoVZQMNsFIxKinAME/wosoEEo1z6hfaCsDkCaSTgPLEQ8wCT?=
 =?us-ascii?Q?7jPvZ+cugbOY67xpRM1+qz20O14pOdz7PhoN/0UKqFFa+Z7Zr1ntFpddRzl/?=
 =?us-ascii?Q?z0yGjgtuK0clKok36jcDAPWl9uyq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JWPiwMDYUGbp3maPIG9IME1U14235oiK9OcTX2zmQaFcI3dPM+jOQYNrc2GV?=
 =?us-ascii?Q?80zYWHZFoBLrdYzhpMvXcl/Ynk+G7MDsu7M9k27nZwZmQnLKWhwW11gNzOYG?=
 =?us-ascii?Q?Gbiur9s4t0rdZXq40SpzMc7XnCrWwp3IBFbfP+ej9iGRSODgaSF1keEsik3Y?=
 =?us-ascii?Q?1K8zkSfauTvPg3AylqZIR1KYe8olUkNCLG0BhLpEHx8OtFVGtIpVnScLzXvY?=
 =?us-ascii?Q?2nZMmNcF5Rn8Al27wcyU6xBVVJJ/c93BY7NCSpQhx2atiEzDiR0NXsbO0Dqk?=
 =?us-ascii?Q?SmwzQvPRqbttBDu+11wp23oJvO1HyIUvVDSCGO4T791F9d5LX77WC0FuOw//?=
 =?us-ascii?Q?CeJy+8lboS8URAKwbJdyHd2RGAaDQEsQyZVgKehN0BboX66s/9TvM2JjsEBk?=
 =?us-ascii?Q?cRUsKZgrFGZkSC+L31NiEPpid/vaK2pPKfTuWCsp2bqXG0K8W/qKWVQbPowe?=
 =?us-ascii?Q?8V/A8lbsuvqpTNFkTy/Ml4iSPZq5BZ2n8qgisN5+o7FQ7AaOkfp+a+QX+jf4?=
 =?us-ascii?Q?4PcwqmgMKxXiQZJoA2Z/RKt6wav18uTLFpkQmGdmyYMeX8CSTSzD06U4ta0X?=
 =?us-ascii?Q?pt7YHY062b/rI+kFaN4VOyB8HZGES5qLNDW4rzuPhzN3Hn40T+wHm/KSxonx?=
 =?us-ascii?Q?wxQzsu7LpmBXM9Ph8jjdTqd1KtQOUt2MgrVzuVNeiAFVcx+LaTv5oPCWxWxN?=
 =?us-ascii?Q?eZO5qqWf/ZMrmf1CIzwgdfWEWgBjNW3XIRgONtPelwR9arYW2ChvFxR8yULL?=
 =?us-ascii?Q?Z0xY0uwsXfQdgkWyhoF+Up0M+UE4a8YrApXvqXTNF6kfoYFvWDQPVodXXH7V?=
 =?us-ascii?Q?UVKEk/gobf6J5zFqVOB9oO67rIHATRA1KlR+XKd0VdmVGPQhzhcHE2nYnUbJ?=
 =?us-ascii?Q?HfuFWI60gDMY/8A1qExBJHLB+BTqg5fYCY1+1xPDLypIADs4n9yzLxt/NsNJ?=
 =?us-ascii?Q?MxyMgeAnWODTvAy6ZQwUCVYWbn7ytGs6FnNQItnENS5tYKgm0LWXW5gJ6E31?=
 =?us-ascii?Q?j/X1Nsm7eSGDFGWqLMEpt17B3acwd1rnqIWUZvCz0J0kH5m3lMNwLqtwAtyA?=
 =?us-ascii?Q?TbKPl1167B/DHdAAlrXAvb4whcJFt9IIMr+kufDy9M3dpWZ1E8rahQrKreT5?=
 =?us-ascii?Q?J9ulVRkmzBlc+2Zb488K3BgHDm0UWJP/a+/9pSMU/hNenldFDs9c2AVB/XW/?=
 =?us-ascii?Q?lt85nKEkqxo+A85NyYvI8xn48m0CbK34dh1Xy7Z63P+RaSgRpaOOCGkI6NFs?=
 =?us-ascii?Q?Pwz68A3CNuiXqsiqyZkwpyrrhDqsb5l7UdlJo6jmg8YELXXhpkT18OZLl2K9?=
 =?us-ascii?Q?d/wTVOOJ6Jon2JU0JRwyn/uXltNDFvvkZPaabM8EHROw6WEUM6wsyUlqcElB?=
 =?us-ascii?Q?tTN+HXV7JOCd09kEsXECHARHbea6xOwsbH1/JGElF76njrLKIvon2z2W9Qgv?=
 =?us-ascii?Q?14471Fl1tODM52iQghV3xyLTpWN6Lp2TwNcsseTJxWpU1/LTjugy+0bwI897?=
 =?us-ascii?Q?HWvg4LpAMVcTS+lPLimOaONbdvAdR5w64Rb4e+5t2koPtldq2pJZFOfeUO6D?=
 =?us-ascii?Q?fJPFjT3ymWo+BdXJrwhFiQAX+1WdLWw1LS9huqT3h9IyLsugUK18Tc/wEvJ3?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1bec3f-cb5d-4224-2a99-08dd529cd290
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:26:05.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ksa/0wtM5XJGw5D9KiMWNmFwF4V/KuOPvCbnqs1cZ2sb2FwhxeS0wFqJ7J8rjVzfiDjP9t30ogs4ONDM0t1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8514
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:26:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17287

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index ad219b531..47e327277 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -315,11 +315,21 @@ overview of their function and contents.
       mirror tarball. If the shallow mirror tarball cannot be fetched, it =
will
       try to fetch the full mirror tarball and use that.
=20
-      When a mirror tarball is not available, a full git clone will be per=
formed
-      regardless of whether this variable is set or not. Support for shall=
ow
-      clones is not currently implemented as git does not directly support
-      shallow cloning a particular git commit hash (it only supports cloni=
ng
-      from a tag or branch reference).
+      This setting causes an initial shallow clone instead of an initial f=
ull bare clone.
+      The amount of data transferred during the initial clone will be sign=
ificantly reduced.
+
+      However, every time the source revision (referenced in :term:`SRCREV=
`)
+      changes, regardless of whether the cache within the download directo=
ry
+      (defined by :term:`DL_DIR`) has been cleaned up or not,
+      the data transfer may be significantly higher because entirely
+      new shallow clones are required for each source revision change.
+
+      Over time, numerous shallow clones may cumulatively transfer
+      the same amount of data as an initial full bare clone.
+      This is especially the case with very large repositories.
+
+      Existing initial full bare clones, created without this setting,
+      will still be utilized.
=20
       See also :term:`BB_GIT_SHALLOW_DEPTH` and
       :term:`BB_GENERATE_SHALLOW_TARBALLS`.
@@ -347,6 +357,13 @@ overview of their function and contents.
=20
       For example usage, see :term:`BB_GIT_SHALLOW`.
=20
+   :term:`BB_GIT_SHALLOW_SKIP_FAST`
+      Set to "1" to skip the fast initial shallow fetch.
+      This setting forces an initial full bare clone
+      instead of the default initial shallow clone.
+
+      For further details, see :term:`BB_GIT_SHALLOW`.
+
    :term:`BB_GLOBAL_PYMODULES`
       Specifies the list of Python modules to place in the global namespac=
e.
       It is intended that only the core layer should set this and it is me=
ant
--=20
2.39.5


