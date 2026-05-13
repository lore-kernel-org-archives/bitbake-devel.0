Return-Path: <rasmus.villemoes@prevas.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3BACD4F35
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 10:56:00 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4756.1778669757352008572
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 03:55:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=AsQL/Oqd;
 spf=pass (domain: prevas.dk, ip: 40.107.162.21, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRxvkm7oef2DcVHhZDoXbOTtqu9LNHfJ63Dt09+yIoPUTcfyBAfcy1FFXz286qI/8Ht949iJQ2kLFyrEI5+zxc0Ov7Z1HtgQOrJbPmnhPuQyHBvCmvXLd7PMYweN4X2BDetYheAEIX8IBc01W3awzUmAINNwegpXPRIJq5pVQJLMaEX5Qj3qNuFtFnvxzRdBv/uKG/2xXPJqBY4UzIayXlyyD1zHx58NFSYeJ87mYcMTBZn5ojTWco1V2Z7sii37Lm3tcOHtdwdWg54BLcoeqRGHXqMeEozFM/wU9WP9koGPTGLJg31yao6DsZS06zR0sEE5fl+5Z2c8ZBGjGEMUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/akgXzTBfN7vv3HNATghr+clUfR2tq4oxHMudPJLdk=;
 b=b7QzttP+rOPS2teOxV0fZXKvS0OoMHHvAm4SqGEukFVKZH7mKhd8rz1l8EM3ZJa2SSel/VkiczjfoftwvM/F38bDhc9mYUardhvPP/lCcbu9mQ+aO+2iTpb+C/0AzpPmeNrs3Ytt0KlaqLcpptFAoFl4UBbsxzhBhTjA6RarfZniyEUZk1jQ7LC2RxfUBP47oPo5xCjprJF8KYZ63MFLSdD+ik4U6L+7yDdgo05aa//mZCTBdb5q86C54nntPUJpyOySMpLCiYuoHSn0SWpF4ROwQXB716f7yBuSUJvBi2Z1WMXyOcXCIBRrNIey3fuCYFgS7aiLuytFgHbhW00tnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/akgXzTBfN7vv3HNATghr+clUfR2tq4oxHMudPJLdk=;
 b=AsQL/Oqdj2fKMZ9dDaWjVK8SmT5gF+TaCQB08THRGbqhYesR1aC5YvDdoiAZxMSKBEn8Jgm9Li7tC8RdFn4TT+10Z4BNnx1eAQknvaqXxd1MoPpyQkFZuKslmHN5rYd409gl108HNQZ2XXpOom6IUwOvY5T9PxfnT6lQISx09Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 10:55:52 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:55:51 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: bitbake-devel@lists.openembedded.org
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] checksum: only split file-checksums entries at right-most colon
Date: Wed, 13 May 2026 12:55:49 +0200
Message-ID: <20260513105549.527210-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 83145c78-7074-4d3e-98ab-08deb0de32fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|18002099003|56012099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	FIO+VSeftxIcO69qZ4NgrpeNjTfilbD/ahg7yeEfd+R4oVWgyPsDWWfEH4SJnXi2l9sXL55HJpVa3lRSxfvx3OeEkoVr1JhaDWrtKMLGReW+qWKRasZiiowPsrPRLjrWJ0653CD81ap5Jr4kobkOpTCtmBVwlN0YZ+zsEM4oqGHSlCtGeTiggqXAWnsz1cMaHsPc0kMBPmpNPV56v7VWr68C0Rashjhm9yuiDn3MNDej7k8nCSxRSQDkWAItWJ1eOVBrsgS93VSW/M4lDBDQIca3vPjxKkPsmokHU6UApN36L6yax1gDdLiShUEnlJ6kgBbtkXCUR48wpxbyOaYnSijfBq7heCXXAArt8S1UVg3iE9qypS+hV7cZZXfNXnUOpjdWn5Fe658eJ3x8nw2Zoz7y66NroBd/SQTF2McUtXwTHkGkM/Tkd8Bh0yxneu28tKW1Gn2ihHlYtv5rkfGvU1qbHFgOlaRyo3xKT0fH9yq1RQPRE/27A/2xfTAS1Xjn0oALD1/RGnxXM/V3/AcEdNAU3nxNV/mHTkg//E3jNqB0MFrfFhK+U3bt6wOmBpm+EK7VMYWHPrYxNaCV4RuogCI+YpQQUMNgzsUGkbJYWYx5lE7ND5I+uSoNhIZucbrQrJK5pUYUhO2SF0g77hesl0iXFE7zqC/y39/+oV+m60++/7sDysyM/YdFnhxfde8vXqXpPPClyrRqpqXb1mSQWPc6Mt20PTYMDzBIO5e3bbLM36htKWo0TZDe7tP2FgS7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(18002099003)(56012099003)(11063799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IWLr3kvYRocfMdKuzV4lUu+KymYbDMZVORBBbXzwL5xzC+G2KPamxMDCJl7j?=
 =?us-ascii?Q?C35uu4nMtOFFf4f8sEc1CgjC0zvIUnVymtIe5IZCUQdkc7/e0JMvjTrHGYTc?=
 =?us-ascii?Q?qlvqTVl9cMZ/2bgCCOJmBZbnpGdcCvDcSOqHUU6y4JWFp8SbYvUE9XSzmbBg?=
 =?us-ascii?Q?h6cBUvrEIsTa41h3oE/04SRi6o+ElUIt55TYLeRyFJ4ach02a0CcP0DfnZVn?=
 =?us-ascii?Q?2bFC5OA8VEKW/jEF4oIGbvakfG71yykD7Abe6jYaX+JOKKQYB0YrGi/ULpF7?=
 =?us-ascii?Q?D+HSBOOBF8TFyRW3yuDR2vkvNh7Mb8e75WOERrAz8AAeZi6PdH9RZVZ7MAhf?=
 =?us-ascii?Q?k0+gKY12Amk8SLEVXJYmM3T6fuCc30AzBfe7NkmDH83OEhsFMl2ZoTuQecuS?=
 =?us-ascii?Q?3nP7E/yEOHeAX+GASlw2eeBxKe0aG8JgMDKgUR8J3uLk3GdY0RYa6kkB5h/c?=
 =?us-ascii?Q?2WZ3Ml/01EkhEVGR4gI8+4JiCNPrurnrPjB+awKlVNnTMjevOvUV8Hx9kubb?=
 =?us-ascii?Q?kdL8fTgiDTaCaSNpMcN4WIhcsTDQ6PLIQvyyhbEiMRMCx6nK11meLOfGmoZE?=
 =?us-ascii?Q?NToDmzA6TKhGmCk1FuEB6KTSBHO9sztAQLh75+CXqup4a0wl7vg+2VOha8Ov?=
 =?us-ascii?Q?u40oSZI5uJxY4Gmh7FBjVs9kiAJJPGjHijE/5Zb+pZkjyIt1ET+VEQFbJjnP?=
 =?us-ascii?Q?VMjRguYwj6430LmBJPA4h77MxQuEZ/hCEgc3aJ7EG6pedm4B73ST7bri6wh6?=
 =?us-ascii?Q?743IXOKOwov3Zv/FJ7hGOTcyFr+UqhmTkrO9GrQIDLO0AqiKNDuF18SyV7Q0?=
 =?us-ascii?Q?9f8RfLSeIaxvbh5iYdR7C+ePN2rCGixFtyj8h6DlLfT51Furpx3KiyIEy3ne?=
 =?us-ascii?Q?L+clUDi14421Y3kkfMKFWtdUT6nLqFAAlM/h/fjai5lQgVOb+3daMgA39h/e?=
 =?us-ascii?Q?PIILMIPmEb4zdyaXfvgtKXZE8Ccnl2keRj1ue08QWH4z6645x8cnhw2D707r?=
 =?us-ascii?Q?u94mHkk+ABHkD3/IiPczdsBajQDE6S5hvr9xjPUQo5CVTqqKR/TXp+LwcaHp?=
 =?us-ascii?Q?bTDHk5YMlYQHrEANtoIykbdkZpmj9Tv3ivT0Lw8wvgzkEckxRXmpT/7DCq4A?=
 =?us-ascii?Q?BdqTeJOtKrBUwbniLTl4+9XwEQosM9GVMdRgiYNtAI6nxo4Kqcn7zzm+WIZg?=
 =?us-ascii?Q?UZeZTsZy39TAEWHWOTiVSTSVgH1M3fjEY/3ud/sQtYymIylZ+lkyzKu3mUBf?=
 =?us-ascii?Q?xTseW1pQmlsvfAF6++CX5qDuXyJqPFSpTinIOna8C/xQMAEKx8LZ3/P7WtiS?=
 =?us-ascii?Q?9EjbW31H+bqkAk2azwF5aI8HAjDW6kBrmsUVgDKRvH0Wm1mQfYlnSHu3WkWP?=
 =?us-ascii?Q?Y/JDrtPNX/qF90LR8N4gSUwKzeKSoZY95l82bub+nqYxODegAkXkw6R45ClD?=
 =?us-ascii?Q?BWx+n0xeJTSg65OyU2rdwU43e4xx/deEAKF6FVQlz9MjRR/FHQWhfuQdCqJN?=
 =?us-ascii?Q?EGzHX8/g7B8FaCE7P6NpuM6nWfk110Pj0X+y/sFIMO948f6/iZlqDqqSD3T3?=
 =?us-ascii?Q?1zKx2DBOYx0fn2yA4iHsXOCOX9MHh0D/NTf2UuQeZS5Ho7gwSddl7LcPohef?=
 =?us-ascii?Q?hdAL7PWX+CFDTtdIAY8wk/FNId9DwXblfX7k44VtjIDtzUR+Rubh3ZhDlAOq?=
 =?us-ascii?Q?ez734xQZwfBVpjP7w9Wf7V3kmXo9VrFzwYQN/3egnVvcWKkxi2d+i9idRDRw?=
 =?us-ascii?Q?5eXXNfjKZjD6eIwO3fjspNDsKbJhCgE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 83145c78-7074-4d3e-98ab-08deb0de32fd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:55:51.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLzrHHUxxkfd1eGIm36uRk4nG+XETIz0EJxGx3ZrLhVhGka2uW2wlUTa+YSmNWRVz5u+MF1usYSR8+yyAHHTe/L3TYYxIA31dG76YMr+Dg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8759
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 10:56:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19508

While paths generally do not contain :, it is not forbidden. Even when
ordinary files do not contain : anywhere in the path, there is a
real-world example where the current code ends up emitting a false
warning:

meta-rauc's bundle.bbclass [*] expects the user to set RAUC_KEY_FILE
and RAUC_CERT_FILE to point at the key/certificate used for signing a
RAUC bundle. Since those files are not in SRC_URI but are used
directly in the do_bundle task, they set

do_bundle[file-checksums] +=3D "${RAUC_CERT_FILE}:False ${RAUC_KEY_FILE}:Fa=
lse"

The :False is because they also allow these variables to be pkcs#11
uris. However, in that case, it will be something like

  RAUC_KEY_FILE =3D "pkcs11:object=3Dsome-id"

and the file-checksums entry ends up being
"pkcs11:object=3Dsome-id:False". So the python code ends up seeing
"object=3Dsome-id" as the [1] entry in the split and "pkcs11" as the [0]
entry, and the whole thing ends up doing

WARNING: Unable to get checksum for system-bundle SRC_URI entry pkcs11: [Er=
rno 2] No such file or directory: 'pkcs11'

The code really just wants the right-most, colon-delimited field, with
anything before being the path. So change to use .rsplit(":", 1)
instead. This should make no functional change for items that contain
exactly one :, and matches the change done in a70a7376a ("cache:
correctly handle file names containing colons").

[*] https://github.com/rauc/meta-rauc/blob/master/classes-recipe/bundle.bbc=
lass

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

Note: I'm not really sure meta-rauc's use of [file-checksums] in this
way is correct; it seems that the flag should reflect whether the file
actually exists, not whether it is guaranteed to exist. But
regardless, this patch should be correct.

 lib/bb/checksum.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 3fb39a303..9490199d4 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -118,10 +118,10 @@ class FileChecksumCache(MultiProcessCache):
             pth =3D pth.strip()
             if not pth:
                 continue
-            exist =3D pth.split(":")[1]
+            exist =3D pth.rsplit(":", 1)[1]
             if exist =3D=3D "False":
                 continue
-            pth =3D pth.split(":")[0]
+            pth =3D pth.rsplit(":", 1)[0]
             if '*' in pth:
                 # Handle globs
                 for f in glob.glob(pth):
--=20
2.54.0


