Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.103])
 by mx.groups.io with SMTP id smtpd.web12.14310.1600946168340525964
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 04:16:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=Wf4qGKZe;
 spf=pass (domain: klsmartin.com, ip: 40.107.20.103, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNf9YTxCg5MSA9IoxjzhNbjGLSROQmiGkLcq2Fe30dLnSDsMoQjFwxPxQOiWC3sK+Qy4JjrS5d4VGxxJPlBr3XZ83PxvSsHnfskd0Rh+1fl0SmZJw51GxSoJYnhcVDNczxqlbUWVNWgvHuzOxs5XyEvKlCEp0xtwSoC/V1+95KPZNO1K8M+8CnOC/2OKz/WO4wwWg3xbFskB9YB7ysJ7mjuu9HsYd072bI6TFbgx5KwZqz5tu9V0tHEG2hrNSsTBUGVvA0EEB3JV+D9d3DHTqB7ZR2C2KeFRC4wf0VjN0c+aRRbF2Eyl/ifMOl4XRx80xyq0+KYEf4r9cnj2HcGzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRKWRjbT8p9rdUd0ML3IrhUdvDBybbzExWlx0cDL6k4=;
 b=LRQt8vqhoDgr1Zljs6jIZDlXjGqfooMp/2BVeaFq7GSY9pP/MaOo+cT4h/kQAVyyry45SW+JCkPcLZask6mlqQS8JG9v21nvj793yAxpenEZfTNP8lhD16xW37l5da35aF1q2pckW02UH364nnd4J7mQc/xnrbTpbNkhnKYubFbVxQ/FA/5uyFcBYOpH2//38vD0N/XNCkupjJ4sMKO0Tv8qGqll8Ngi3A5JpRf9Caqtk8dNooLbTA+xtgvZF/snYxbVgb4sP3OsXSz5An+nAlCywkyULTwSh+fUen9TDStnqB6qHZrsKvImiWVDjuKF3yNyc3LjEemZLSay1JZJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRKWRjbT8p9rdUd0ML3IrhUdvDBybbzExWlx0cDL6k4=;
 b=Wf4qGKZeYBqYgGvU53j/yt3Dj5a8nF7JJEraFXqA/wvDXA03T9ircO4r0e7NMenz6sqW39DTMiv2+YlynDl+2nYiAQ2ElWG/6rYpP92+jdv/yfqWjD96eaI/pi0wA4omdODlgSgRwWNpfGlGbaoYGovVkfcHslJCVRh4BgOaIVSzkQDQTAkxE5kZPz3MrOWxuO5xTDRBNN+eqkZTiQUbzBXU5MFwAR9Yxim0qobmO2W7PC0TtdvOHTyWjrjypcBKXYwzHPtd1zvmZxO7+5xh2cWUkG4zYY9zRycgu1WNuzQwqXXJaN/nxY20UzW8TI6awkvvwY05MxaJEdZsisHgnw==
Received: from DB6PR0802CA0041.eurprd08.prod.outlook.com (2603:10a6:4:a3::27)
 by AM4PR0202MB2916.eurprd02.prod.outlook.com (2603:10a6:200:8f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:16:05 +0000
Received: from DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::18) by DB6PR0802CA0041.outlook.office365.com
 (2603:10a6:4:a3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 11:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT052.mail.protection.outlook.com (10.152.5.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 11:16:05 +0000
Received: from SKLSExchange01.KLS.zentral (172.20.10.199) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 13:16:04 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 13:16:04 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 13:16:04 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v4 1/2] fetch2: fix handling of `\` in file:// SRC_URI
Date: Thu, 24 Sep 2020 13:14:11 +0200
Message-ID: <20200924111411.21590-2-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
References: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.09.2020 09:09:00
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7e5865-27da-4f4b-f3f1-08d8607b3ad6
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2916:
X-Microsoft-Antispam-PRVS: 
	<AM4PR0202MB2916C58F27D7ECFF5D083A1399390@AM4PR0202MB2916.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ay4VcsxSnD41C/Xxd+LFeqe9Sr2gCiAa87zVegqKXj7DQKSXr6wACiEBeTMYBvtkyGuRwVJ166py+LSD/eB35btmiBASrQ6QBLJu3pC4dpiKZw7/uVSG+XudXlNfmxIqJjAdqWJ5CfOKfc3Dsqt4JEd1mMZz0obgpd7s13CqpGMWyGDX+K/MPS/eSb3Bxc+oDeVzm8KWVwxaHsqxClk2jo5t1gEMDQdrlZ6MMSxtR6l6sREtYzwkm96+4CYAYbh3IKV1mD/zsPrgSUXfNzDvlhhNEmN6WpUxCTIiOH5F0/TgMGCL0eecsKfH74lzXfFD/YjKDWYO0uU/aJB9lUUdRiEwzIykD7vzEvus43c1ZO1BmqJ/W3AhJ+ElcWETGfX7PtLHtMVr6Avkz4pjzwi2cCmU9NFqKL1tudMF53feFUd05rjfVn7lxP9VXzxv0NIyTw2qy8mm/2ladxmuD5BnNp9uX75nrYcktdlpkvAWsOQHbc0b2XivYapFExpKqP8C6jplVrJIL8+s+TRjg8XqDvzJOA4ySulWrqOiPtnqDVqLCql4rARDk67lEOH7qmOD
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(46966005)(107886003)(6666004)(316002)(2616005)(86362001)(2906002)(70586007)(5660300002)(44832011)(8676002)(1076003)(8936002)(36906005)(6916009)(70206006)(336012)(47076004)(966005)(16526019)(478600001)(26005)(82740400003)(186003)(33310700002)(4326008)(81166007)(83380400001)(82310400003)(36756003)(356005);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:16:05.6405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7e5865-27da-4f4b-f3f1-08d8607b3ad6
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2916
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Using backslashes in file:// URIs was broken.
Either the resolver would fail or the subsequent `cp` command.
Try to avoid this by putting the filenames into quotes.

Fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D8161

Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7ec1fea5..6bf70337 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -21,6 +21,7 @@ if 'git' not in urllib.parse.uses_netloc:
 import operator
 import collections
 import subprocess
+import glob
 import pickle
 import errno
 import bb.persist_data, bb.utils
@@ -1520,7 +1521,9 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd =3D 'cp -fpPRH %s %s' % (file, destdir)
+                # do not rely on Shell's glob expansion.
+                file =3D ' '.join("'{}'".format(file_path) for file_path i=
n glob.glob(file))
+                cmd =3D 'cp -fpPRH %s "%s"' % (file, destdir)
=20
         if not cmd:
             return
--=20
2.26.2

