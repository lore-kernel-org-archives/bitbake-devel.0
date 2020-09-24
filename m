Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.107])
 by mx.groups.io with SMTP id smtpd.web11.13090.1600940813148058823
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 02:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=2ko1SESI;
 spf=pass (domain: klsmartin.com, ip: 40.107.14.107, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k94Oen5lu2bT8qGkFUKBEOZz3yGHHGVv3d247LQdc7PrmN2ABC5FXlRI3GJYbwf/O8xNJMeWvWbl9E7iLykiIrHS+xDDh714XzIDBNzW1fJXuqbI3GLJ1o1KFfvZ9RiRZjn7xJgSCkib2C8I7slR41/1Qikn/75pcglgqEotJRwBQMMleeFHNt9TTS2+tj9aJIGLXijKS6k5aAlOEceGjOIoCQXe6C/uYeGrM9Y+ywZEO2IzxQVidqSFWNxd9nWqdPRgzzV0SEVFxKLEFAJjDEYV3qdGm+r1nZhX7wr9hhJ1loS3Ihy4Bo8cv4xlJ7idkauLbE8Zcchda2EcZNfP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRKWRjbT8p9rdUd0ML3IrhUdvDBybbzExWlx0cDL6k4=;
 b=HgPTlcEdN0VPx+7ZBUqfuvDz6FJ14cKtMexBivX+R2amw0W0quyA0GCgjI9BtEWhjOeqA7+4+++XuRwA1bAgMIiPMPSb/dNRaexdf0jJo6KV9rL92b+JO14Ra7IVf8NXXRFQNk51YOblyZ79oQvdtbaagBh3KjdBTIygvItzPSESectiDPaaE/8SL+KtONUVqpP+3PJ9RsPQ5urzy3b6YIHg6C8bu5xo77WKaNNS4EKHSY2DEI6fv1J0B/SUMHdhkkbZaBpMpVKVdIoG0uAG++sTGp8jJuA9lq666usBLBEh+lQqb6SKx8R1+TK6/SHKjqJ3nZCKkg5BJE9bYQIlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRKWRjbT8p9rdUd0ML3IrhUdvDBybbzExWlx0cDL6k4=;
 b=2ko1SESI6htXoCJLr3Bkr1qUyRLX0hZPRzXiogs+L5LuZTFBOZdT36geIX1s9g9Zq++k6wi794SUSsl4YYB4QwQKojh4pT7dezBGcjXxFwaKQsSkKD4LI12d6IrT3zN4ohoKCAB58ZSTF2Ljc8BMfAavZVUAJKR0BbbhipkJcCYqXHdxfqdxE/+99bGvy82Xs++DmTCjkyiljAcqDlOYsVS7qqYvNIXXmHy136TDZ8QbQXEezjqxpjIL58MO371wKNrCglqQ8RxEcLqXInXPdiNRjAgyPWEISaR6t3YYN5YVhrq6mEldUbJBWrKjU59SEPP96MDp6oMgD5kJ26Awpw==
Received: from AM4PR07CA0031.eurprd07.prod.outlook.com (2603:10a6:205:1::44)
 by AM0PR02MB5250.eurprd02.prod.outlook.com (2603:10a6:208:104::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 09:46:49 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:205:1:cafe::85) by AM4PR07CA0031.outlook.office365.com
 (2603:10a6:205:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.8 via Frontend
 Transport; Thu, 24 Sep 2020 09:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 09:46:48 +0000
Received: from SKLSExchange02.KLS.zentral (172.20.10.200) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 11:46:48 +0200
Received: from ELARA.TUT.KLS.zentral (172.20.10.63) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 11:46:48 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 ELARA.TUT.KLS.zentral (172.20.10.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 11:46:47 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 11:46:41 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v3 1/2] fetch2: fix handling of `\` in file:// SRC_URI
Date: Thu, 24 Sep 2020 11:46:25 +0200
Message-ID: <20200924094626.5635-1-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
References: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.09.2020 04:07:00
X-CI-MailPolicy-Key: 799fa7ce75121f1048cd13cb371bfd40;14a292ec-8aac-468b-966f-fd25295d3700;ELARA
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7df83660-418a-428a-3e9c-08d8606ec1fb
X-MS-TrafficTypeDiagnostic: AM0PR02MB5250:
X-Microsoft-Antispam-PRVS: 
	<AM0PR02MB5250984E83E025A2E7EDE5B599390@AM0PR02MB5250.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+vqt0AyU5apHZdeQd70TATk6BeBJwFMw2KLDO6aMSPfRnO5adY0j2m/0pybCh5PJq/7WyHI4FxlekBhniNRdrvad9DsfmHR07rgoZiTMom1yKuz1QRUXXb+KP4hBGp2ClV/cnkmh63U5gO972fKD+zYZqbamuivG8pWTvvDMSN+C5G63kCzD0A+k3wioQ2IPYu+nrx2NxLiY7+L247Ik3zla1zBKW4HJK5RyIORiXGPD7aAHrYKXubK2d6HQxgRwki4nZ8z51WSDHr+aL7vZdVP9YunyEwv1x/IOrGiPgM34CPOEvA8ZHOkI6jUw6QdZ0I7XffIelcty6nkr28YvWGrWXVDcohFbgKs++XcW9NtF6Jj/q23SvTDKDzTKWggzswbuDX+auKMKvJmLE4b+lBs+fBzAKy89WgW8ftz9y3GN4GafvF4z6gaN7tSPpsS/nc2CP3faa3N95KpAxgV4SdUqyjD13IVO6RIzcvuUP9oCfAX4XnQvicFaKYx+9p7PqzjW60HE1ZpR97hnr0jo2XYpSl6VAyQxkb7gRsytMrNN8n/IUFV/LJO3Kurm7daI
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(46966005)(478600001)(16526019)(186003)(5660300002)(336012)(2616005)(44832011)(6666004)(36756003)(6916009)(26005)(82310400003)(70586007)(70206006)(1076003)(36906005)(8936002)(966005)(316002)(107886003)(356005)(2906002)(81166007)(86362001)(47076004)(83380400001)(8676002)(4326008)(33310700002)(82740400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 09:46:48.9162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df83660-418a-428a-3e9c-08d8606ec1fb
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5250
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

