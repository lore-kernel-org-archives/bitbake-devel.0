Received: from EUR03-AM5-obe.outbound.protection.outlook.com (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.102])
 by mx.groups.io with SMTP id smtpd.web11.13088.1600940811819741849
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 02:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=I2rADvJl;
 spf=pass (domain: klsmartin.com, ip: 40.107.3.102, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB0Rwu3b5JW/QEHHs98WAkrmbBUo70nFpY1dvjwmnUOl9oUhXgsKnJqhlJ1hCy+ZqJhkUvbtpvsI/CYlgZMZ9biO+ozbHpqWpKkEOIP6CSeKjlIn982XkeammWKgwDEaGLcdk/8n1aIU2Dyb9gWvXKmSUzpvpUu23QRXvk5tH0krOlhjGw9LEltPZCeHhB3jGZ1W4FmkMq85rtqFseih5dnm29l7Lc305YueBeBxn2QAKsABUqxX1bCoonTaosGx2GupdR+C8DgNUYmeiAsfo0jTYwX0CJelbmM7lnoeUD5lU3yhM8mSsFhsFFcVHxDWjZFCWdU0vMNwfGg6GnlVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Hj7PaRidyN9esQajVec74TDU7EBxX7SfZCBs+Dw/M=;
 b=BDSO0TyOAshROwIJWmBxxq40GanCjYCx7NE9JRE7HR9ofIrIepWmLW5/hYMS/kabwm1exHNODzzClXytgIzkTZ49q+2IGIqtTvlMWKymE0iEmky4HHLOC9INGpOZ0g2qRqfEA0+Y6fg+BFQLMRf3knyjk7punZi9sBQBcNPdjAAR+BWJV+ZLWWy8faznn/2yudhTgNJ22n/TtkVYGTAcVAi0j0/Nbu293mGhK8CXvvMjKOOwhT1gjuOV6WpE070U1v1yPAcYg5+HDOU11zkdEwDtotjG6GGL7+SGJcjjlZHDQ9vjx//Up6eBYxiNpfLPLdKldi+WUq13BG373FM3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Hj7PaRidyN9esQajVec74TDU7EBxX7SfZCBs+Dw/M=;
 b=I2rADvJlniKh1wZtTamq4n+nhYav/Mbr4PvkkfBmyHgLJdNEqPcNgy1GHiFjTg69d7RWcgwBCU24fjPvIBO2GGxcUSV1a3Vj4FxLfO+537/y7VOY5G3BVvZW/mIEICCqf63orKg3tTfJLqb+moObzmqO8GzZ969mzxZchrnNO16wjSYim6bo5jKKs0PXBYKpKNuii0KdcdkrpsF3bovRub9pN3gLQTVhZtC/rADH/f7GEd3qBKzdxSItWMkpp1qf6jxT8EpjP+ENzWXVvfRnfHAUefkKDRO52cCCmOSnvpqbR+fKndTguJBKmYxtFmEaLlqLm5apNdWDbKJjHeyvtA==
Received: from DB6PR0301CA0014.eurprd03.prod.outlook.com (2603:10a6:4:3e::24)
 by AM0PR0202MB3298.eurprd02.prod.outlook.com (2603:10a6:208:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 09:46:49 +0000
Received: from DB5EUR01FT041.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::1b) by DB6PR0301CA0014.outlook.office365.com
 (2603:10a6:4:3e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Thu, 24 Sep 2020 09:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT041.mail.protection.outlook.com (10.152.5.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 09:46:49 +0000
Received: from SKLSExchange01.KLS.zentral (172.20.10.199) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 11:46:48 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 11:46:48 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 11:46:48 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v3 2/2] tests/fetch: backslash support in file:// URIs
Date: Thu, 24 Sep 2020 11:46:26 +0200
Message-ID: <20200924094626.5635-2-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924094626.5635-1-leif.middelschulte@klsmartin.com>
References: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
 <20200924094626.5635-1-leif.middelschulte@klsmartin.com>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.09.2020 04:07:00
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b5ceb90-be17-483d-a049-08d8606ec21a
X-MS-TrafficTypeDiagnostic: AM0PR0202MB3298:
X-Microsoft-Antispam-PRVS: 
	<AM0PR0202MB329899BC38B232B13FF062AB99390@AM0PR0202MB3298.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lScj0KYBWVMUpkwkXiw+cyrI/MsGG46JF1UykIpboYROAJVX2skC563mX5t7Z+VcgNyq+nAlC0NR0sPnJaX8w6rTaY3KgcoCJgyW3AUYw0djDXRmsRGPjjVOrC1uPiEQIRvPAKxOnfTaxp+jyXUpQ6pgqPeDygGctSBpZHTVJVaxNMAt5kR9Du9ZC5c4J04CKTSVm/AqCNHkosBrFpWWontwd3q8KC0sjvU4xlpvzDYqIoeXEJDW6EyuvE1HQHNve1G7oNomtOGey5QWkLp6zQsolSHcq1Ih21r9n3o2ewilxEdm4oXbwJr2SO29tb5TTZ7GaLoOKe4S0HEo6YRqxHQmG+6a6U2uUFOsECNpSkXtoAp6kP+le1o+KcGQV1gA2V7djbbNm9yUmv7Pt9jOdx1RNK0UYsg/0UhOKUR5F6vOB8BMwGUybb5xmmue96AkIaKQN8AAIr+e2/GHYcbCcs/OnVqFFWEG7rFI7+VIbMc=
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39850400004)(346002)(46966005)(70206006)(336012)(1076003)(6666004)(186003)(4326008)(26005)(2616005)(2906002)(8676002)(44832011)(36756003)(16526019)(107886003)(8936002)(5660300002)(316002)(6916009)(82740400003)(36906005)(70586007)(81166007)(356005)(82310400003)(33310700002)(86362001)(478600001)(47076004);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 09:46:49.1210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5ceb90-be17-483d-a049-08d8606ec21a
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT041.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3298
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Implements backslashes in local filenames.
A typical usecase for such a filename is a systemd unit.

Example: `dev-disk-by\x2dpath-foo.device`
---
 lib/bb/tests/fetch.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0ecf044f..9030d6d9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -584,6 +584,7 @@ class FetcherLocalTest(FetcherTest):
         touch(os.path.join(self.localsrcdir, 'dir', 'd'))
         os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
+        touch(os.path.join(self.localsrcdir, 'backslash\\x2dsystemd-unit.d=
evice'))
         self.d.setVar("FILESPATH", self.localsrcdir)
=20
     def fetchUnpack(self, uris):
@@ -601,6 +602,10 @@ class FetcherLocalTest(FetcherTest):
         tree =3D self.fetchUnpack(['file://a', 'file://dir/c'])
         self.assertEqual(tree, ['a', 'dir/c'])
=20
+    def test_local_backslash(self):
+        tree =3D self.fetchUnpack(['file://backslash\\x2dsystemd-unit.devi=
ce'])
+        self.assertEqual(tree, ['backslash\\x2dsystemd-unit.device'])
+
     def test_local_wildcard(self):
         with self.assertRaises(bb.fetch2.ParameterError):
             tree =3D self.fetchUnpack(['file://a', 'file://dir/*'])
--=20
2.26.2

