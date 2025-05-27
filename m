Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB9C54F30
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 09:59:18 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.34])
 by mx.groups.io with SMTP id smtpd.web10.48334.1748339957000147562
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 02:59:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=F7+FQlxd;
 spf=pass (domain: siemens.com, ip: 40.107.159.34, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBMsXTh/H3zhktFkRxkFp9uD368kT6yLSLmOg1caoDp+e2sLSB5W2ReM0dmCn1a+DwWnjLaE2X0K3sIq8x5Yi97NVkYKBLfL22ZaojlAIjCg9EFDEgC/BD95/CKyyw1JGWUBg1LnfUN0QY8g3ySkdBF+I/Rq8y5mBKOlINDbocYPq+GmVHEr84NkqUGPcWL4Wo6jZ4u6H2TMB6zoEAAeqKduAF/9BIuSyzC5FRsOSfiJ6OLh4aqVDU426ZyQKa+pqtt/8YaS3NBMObtOoLns1VZJGSaWd9cjOd8uoqgQ84hx1otgidakJambPTH9k/vwv0Om/81/nze9Z6+Z7hzCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxDHdSdnYuT1DENYZgqgHa5NFqQ0o/F23nheDjqbgHY=;
 b=v++ZSBQdLE+llx+O5qQFV2Xymyk38GUdp66IxsHOeq1kNL2Gx0pOBWLTOp6cfZQRivCditEgZBtp4yMtKI4RhZl7/V8R58Rn1XIrHNORwRs6qUSIfAzWaXyIxAO51c+RtJrvG7jGRijf/6XgwXcZ4qlFCcwpTRWeGh2wjcPDpLXNqCVSbPoqfSnrI2fn+5POgTvZcxtENTllFXdtZiR1+WBeTYmf3mY6VDthHjolZOmB6WyDwnA/MmNmw+pFYolxdeEAkYI1TjUqQy7hMKQ/BUqg+oivXSqV3qio6rlIqH9q3elcHuI+K7gzStsD825HnPbgk+L6FiOW+Beu/vYQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxDHdSdnYuT1DENYZgqgHa5NFqQ0o/F23nheDjqbgHY=;
 b=F7+FQlxdRBA5ltjUfhNvbrrtqs89vKwb4TGyjWhuKQK6KWB/MlaRjldM4xhAjGxz60fHgZSCAO1TpDCDds88w2sJlGwShB3JOuDu7tiwsPTYHiNYzc1lV842o7hv8F3ZfrzcGXJ4SkQDqPTnjQCMtL/EiMageJHMCIyMrkNBXUFOaXAk1i6VyuZhmgthEOSzT/bWRu+LcY0TfbhDmaEeu3luXq1kqKSyZC+S5fnaiGPd83l2+BVxIvHEkq25mgww8aeDtT6dQqMhWKPnB0iRJUqBZ7eGM0r/XAjIR+8wXou9yjRgGEgLgupX/xrkX9hxrrPGKQsB13XdOim1LxZiCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS4PR10MB5442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 09:59:11 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:59:11 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	richard.purdie@linuxfoundation.org,
	liezhi.yang@windriver.com,
	niqingliang2003@gmail.com,
	alex.kanavin@gmail.com,
	quentin.schulz@cherry.de,
	jan.kiszka@siemens.com
Subject: [PATCH v3 3/3] tests/fetch: Add test case to check shallow cloning using `PREMIRRORS`
Date: Tue, 27 May 2025 11:59:03 +0200
Message-ID: <20250527095903.2300556-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527095903.2300556-1-stefan-koch@siemens.com>
References: <20250527095903.2300556-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AS4PR10MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c58dd7d-38c8-4a2a-e357-08dd9d05211a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eFX/Mu7OzzhRitF7rv2FGlthSxrcyGcUlAVmnYLNORTPjueskayZ8F/EgG88?=
 =?us-ascii?Q?RV1a983F9AeHPNBMRGelQBG+cCMpNzPzfrxq35MUZAun8qaTCeoQ3auShM4T?=
 =?us-ascii?Q?0WWsX9HwXPaR9LewXP5PZ/pgV2+t/eqIfm/lQM8dsdaBF7ZwRECFfOEvdyqV?=
 =?us-ascii?Q?036TT2vEMhykHoM16JzlvF1KAWQVCOeyDptDsEo7dxvsYfK5N5gPoNLEc37i?=
 =?us-ascii?Q?hvMddPNA8PaCmP+4zcMNZ2dDui3OpgB2qconea1ma2cbIvDUw38Ydh6+KBDP?=
 =?us-ascii?Q?6S8I5vNLxqLO7OfLHdCnuqDB9bq0Ujdk2G7JA+z8x9K06ld2dRiEXbqeVDQd?=
 =?us-ascii?Q?dO4eFJN5n0c44ySIRTD7cGqvlBb64/rvnBfeTrUu4DDriv01GbKgSVEEKzeA?=
 =?us-ascii?Q?unERuAHrv4zDOIx4mX6wmxZi78SSodEdyRs/ujaz86P5+i34a/26rQoAz6SA?=
 =?us-ascii?Q?ByiPXNhhET1WtkzOXZ5CUxLGh56mGFEQzvcZnTFghwYXt8gFCXDi386SMsZP?=
 =?us-ascii?Q?7HHxib7iwPIVt5BT1HRT+qsaTpxu9uYgi2RNIZY1puGJpoSUAnz35h5WmozH?=
 =?us-ascii?Q?PBJ7Qo/MS60gYs4zx74HP42MiMEvQY4wxjF0ztCO6Hi2rkvlNAy4gXCLUZiP?=
 =?us-ascii?Q?xxso5tR4osi/gzml6E52lTc0hgbE1wb0KMeAr2ePMb2midmqU4uzEfNkSHot?=
 =?us-ascii?Q?B6jaNXPwgyR1SwSFIYo+uu/05EjUFJmktkIHZ4M+TErbVyP5mYew27ODoV7u?=
 =?us-ascii?Q?MrdjWkbT+w2OwziJH7iC9UZi5xfmaw5O0+TaJ7/XmR897sUO7KB3LywHe9Fk?=
 =?us-ascii?Q?QTGUXPn0oEx0nUx4nJnN1WCtU7fOYdBKAJ3mltmbAYXYeicAkjOyl/zeMRhQ?=
 =?us-ascii?Q?zVSTB31PFOr+waUGkDrxf8YCbXH3eQnqud+PjNaHSaunE1Go2bxSXUhGYA5n?=
 =?us-ascii?Q?NxCQAV5Z3b/Z7Y0bhb9SJJGsW64df1jyuBLFiUTTvvDkPa4R5K22NLVC/mME?=
 =?us-ascii?Q?jNe3yFX8QTBb94dlfmEJ5IYQDilVFacLc2ODDW1UKSljIaWaYG91B7K69sTx?=
 =?us-ascii?Q?57W5wmXoWCREaruxU4nYruib2sXd9u9WFxIU2xVVuLn4L2mrEgbyaUzsKWqW?=
 =?us-ascii?Q?Coskc17yt3bOMQi3scldDbEpNp0zpTFhtVfi+LyS5Q4odfuM2uIkW1g/r2h0?=
 =?us-ascii?Q?b29VxFK6D8qC44BFDAzWu4ueLILSkuxRBehSBOZjWRjdvUmInwiXDtxuAJSE?=
 =?us-ascii?Q?d6026J8aByc6ncuTQgWzln3acIxq7yf3O+mVKTQDZDXLnEkAgq1pGUQmq74H?=
 =?us-ascii?Q?zepvgTp+0n7O9AKs3f9JKcRSSTi2DwfMqOI4iCzMMxvhv+PubpOKu4v0IiPg?=
 =?us-ascii?Q?YcIk2swEi1AJ4kDtnAJipu811WQUqLTDm2azQK0Dpu5TRbohdeVPQeUs19k/?=
 =?us-ascii?Q?CuXTdCbDySQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+sQy+dDMgD0v14NzSd37w0esVxpHVDoFIRmmIFQcGmeIo4r7g297mR6GuU+B?=
 =?us-ascii?Q?epAqFqDoDJ4BC+sDXaoPqhYOxijUpRAh2eQpWFksA3vEHQsxq7IG8IsiIqLG?=
 =?us-ascii?Q?+H3ZmMHoMQzqolw3BCeOCZSP0TfiBqR3bSaBg5EDnZWe1y89JTup4beeqo9x?=
 =?us-ascii?Q?PR47cPwtY3kV+IxLLyBv9JrOmK5eigsRLeh4nIxY4jgVTLs4qQzWmsatFJZ6?=
 =?us-ascii?Q?D9bfrpBoOsS7NgObpIHXBoppBHa+p6uxHl0gT+qnzupeELdgPO6srIMCdZeK?=
 =?us-ascii?Q?DquGRf2nMuunZF6ND2cOXZCJv2E7PNYJxLzbTtouWRbCG9FQwWYUepXevhyr?=
 =?us-ascii?Q?j3XruX092u7AxsEY7cu7C4w82MhwSaDawjFxz164XX1pnnXa6fx7mznIrSXb?=
 =?us-ascii?Q?Fo7LfyUQGUkzHV4TfEX6y87yTLieqW/VJCLd0ynOd17YrXpZ9CScdHxG3O8d?=
 =?us-ascii?Q?foKB4gXJ7Znm9YluRTn37vIbhsxDHiPjb2TPSnbnieNnK2vXKNcGE4rHGjvu?=
 =?us-ascii?Q?f2rrIiDe8DTffyF/+6ZRvAz3HMJ3wKrd47wdhfRmErDpk1BMun9Lsc5ESY+O?=
 =?us-ascii?Q?cMmbM0rVSTa6kI3G/KysQhl/bW0oNUgzjE0fLx8oedz10KcHfuKE7+BCR1OR?=
 =?us-ascii?Q?i1MI8BFjGjBVasAP4eUrkX3JRnihJVPsHlk6wTY50jn1EUd+7Vu+9jmNEly1?=
 =?us-ascii?Q?jLI058GCa/04/cfSav68fowgMxoavAv799xDmouJE1CtBefYZ9VJ2scmnEYT?=
 =?us-ascii?Q?4OSGL0et+ctD/GTkaq/zfAh4FlDmywAd+wkWbybvOae4C39jv3HLCEHjtLiR?=
 =?us-ascii?Q?ZC908tOHs5q4cJu3CHNKvfxtQns0mDba6sAbXMFTL+aE9nlYeXaUtyd0MM2G?=
 =?us-ascii?Q?E/TTVWjmcip1wMP/XrZBQAg+ptroKD3lAAV5SBjVqU8bdjUxiD6nc7R+fKaF?=
 =?us-ascii?Q?SN6YlQQ7fpDTSx9rQrjTusAFGudNIs1kxcj0r0Tva7rtlmYg0oMpBZYrSxYK?=
 =?us-ascii?Q?L6rbMUZKg/NZN7sIXNe9Jv9U+sSbS9XBrKvkZaMMuYHgn8Vfo5JkwZXDaHnx?=
 =?us-ascii?Q?/BgyPAfkYmavzZHhniZbHMqRytUKJbVmSX5QOS4wzZm1dibC+6wW8q/UF79i?=
 =?us-ascii?Q?ELtZLfLFxc2Bn+NBY5tRV92PV4iQEct06uPtw0HluFVY0oRr/5EawY8VeSeC?=
 =?us-ascii?Q?j0joOpLOWLj2dpwhE6jTwIA6F6JJUXaQI5axtexjp6JUDmd+wWAKwk3wHn8H?=
 =?us-ascii?Q?fHOeb9bS74Mpa0yBQiRG84/fPosxbvFgNn4aCA1CilY7NgIpv4a+4wqVvdKc?=
 =?us-ascii?Q?qW5EjEgBkgxMWJWGwXC3rAgECUe9I+Dm7YxG2mqc8GVX/GVNklTLjLRUAaOQ?=
 =?us-ascii?Q?0RJWY0It0cmz7uZLqsy5yxgS+MmFUonLU/MQ7eM52TXpts9xz8dfM/v6q4ww?=
 =?us-ascii?Q?UbE5REsHuyWmpIS7c8mJapll+uuv0sbVGe33vLUJmCIjshbHvUFb68Sl3APw?=
 =?us-ascii?Q?eRoY4Y1TGKavE/mEOyKbhrwibu/h2ofpg1YGKaLwGxybBo6O4cdvt6s9hmdw?=
 =?us-ascii?Q?U3MXCqQp2onvfCOsHY8EtAVdbsXgohi3Ob291M7oqLjYIJ8W2T1E/4RlsvFd?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c58dd7d-38c8-4a2a-e357-08dd9d05211a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:59:11.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH7gNk3XVyKg3FIZuxodQI0xbMCVCTJhGtbr/lEXifRcMtsBjs05XylDDXYsNV1BwPfG+mm1I6QFWO80Xnx5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5442
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 09:59:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17647

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3f4233258..077472b8b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2237,6 +2237,33 @@ class GitShallowTest(FetcherTest):
             self.fetch_shallow()
         self.assertIn("Unable to find revision v0.0 even from upstream", c=
m.output[0])
=20
+    @skipIfNoNetwork()
+    def test_git_shallow_fetch_premirrors(self):
+        url =3D "git://git.openembedded.org/bitbake;branch=3Dmaster;protoc=
ol=3Dhttps"
+
+        # Create a separate premirror directory within tempdir
+        premirror =3D os.path.join(self.tempdir, "premirror")
+        os.mkdir(premirror)
+
+        # Fetch a non-shallow clone into the premirror subdir
+        self.d.setVar('BB_GIT_SHALLOW', '0')
+        self.d.setVar("DL_DIR", premirror)
+        fetcher, ud =3D self.fetch(url)
+
+        # Fetch a shallow clone from the premirror subdir with unpacking
+        # using the original recipe URL and the premirror mapping
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar("DL_DIR", self.dldir)
+        self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+        self.d.setVar('BB_NO_NETWORK', '1')
+        self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '0')
+        self.d.setVar("PREMIRRORS", "git://.*/.* git://{0};protocol=3Dfile=
".format(premirror + "/git2/" + ud.host + ud.path.replace("/", ".")))
+        fetcher =3D self.fetch_and_unpack(url)
+
+        # Verify that the unpacked sources are shallow clones
+        self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')=
)
+
     @skipIfNoNetwork()
     def test_bitbake(self):
         self.git('remote add --mirror=3Dfetch origin https://github.com/op=
enembedded/bitbake', cwd=3Dself.srcdir)
--=20
2.39.5


