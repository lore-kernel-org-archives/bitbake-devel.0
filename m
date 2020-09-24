Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.103])
 by mx.groups.io with SMTP id smtpd.web11.16381.1600952869775714023
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 06:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=Nd+YqCka;
 spf=pass (domain: klsmartin.com, ip: 40.107.20.103, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZRfeLfLc7ersmpJsHBkBfnN2pmSM5BruIEK7SLJgzZ6LmCeCQQ25BAf7EYhWHDcKBKhTfz5PofCsY5O+9aVTMWjbiWcYnuBPd/6iY434diTVutOvIZw4v/52GOKg/3FpT1RbaiZCa1CX0m5lRlJOF4It9aL98ysCRnzTTJi5rj89r6GtZrs8tAOnevULgf+ZB/Fk0RD4G2Qkisllqdd6n37iUl6/HXhUR/gALZ5ZNmF6UNx/ThSz1pu3dncq09Z3biKfE3D+VQVCxH/B/UBBMJJr+fZjKjOMxSgh/Yy342k2aTtzOkn8KhbtnmRSH65/LKgaF4McNtM1Jfd70gnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHEDT8Wf1HM7gHM2ZUOXGNN+CMcRvGqxw0d2qNCtz7c=;
 b=BnjkkZIf03U4PDwrfPaelfR01oFVohNqcvNzb4dQQ5PrJ7zStPFeLSMQi7DUnm4OEBy137djxi6MGg4XBi6aiw+VQkU6jYvm3rUAMFqtrLf77WJBaVJ62jk5SZGyLUZzzo3kaf9pCmce+Dt02T2Nxa1aLv6OU96KFZJRmYbd3uR1Qt3DZDLOLn5dpW6LbmeRiPvwmROcqEqbe4amtbX8y4w+/0u2xPNaZmFwkXsPXPEbjEkhkuas4BZVoSo/UqSsz+mSLZktpZLow0AoA05BwHBCkKWF1Qrq5C5yvRQT48MjVKBaQ3ppwyINEGi3jscynIPKp9cGmM/TeV8AvpMJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHEDT8Wf1HM7gHM2ZUOXGNN+CMcRvGqxw0d2qNCtz7c=;
 b=Nd+YqCkaQDS8NoshPF5DzfLVCfDJO6Eyk9PlSihJEN6V9MO9j9fFO9FpxCBkyurM77KAaWO+U/9z6BMy7f4kHHjQo30/7sdVUbP+R359NMgwI2LjqjnXF5uk+9C5PZV2tP5R1JKjmUSY9GRdQHgAfkvptXZ6vl60MNRSCP/Vzvc6U9+D7saY99nSBxpYjSWaXq8/WvIiIOkorir+MJtGqKmpl8n9fljJQwFOmEkW7NiIWm0koC2fhOae6UGMEjyk67d2CjF2BC8g4fOQyj+n5GV79WcvUaKrFI5UmhqROZIfWU8HOKgEWSmQ3M8GmfPF5ZxdH9h3Snt/2B8zPKW3Ag==
Received: from AM5PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:206:1::15)
 by HE1PR0202MB2812.eurprd02.prod.outlook.com (2603:10a6:3:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 24 Sep
 2020 13:07:45 +0000
Received: from VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::16) by AM5PR04CA0002.outlook.office365.com
 (2603:10a6:206:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Thu, 24 Sep 2020 13:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 VE1EUR01FT055.mail.protection.outlook.com (10.152.3.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 13:07:45 +0000
Received: from SKLSExchange01.KLS.zentral (172.20.10.199) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 15:07:44 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 15:07:44 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 15:07:44 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v5 1/2] fetch2: fix handling of `\` in file:// SRC_URI
Date: Thu, 24 Sep 2020 15:07:18 +0200
Message-ID: <20200924130719.33118-1-leif.middelschulte@klsmartin.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa80d962-bd00-4ec6-69bb-08d8608ad41d
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2812:
X-Microsoft-Antispam-PRVS: 
	<HE1PR0202MB2812B3CEF444DB9544B2E89699390@HE1PR0202MB2812.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MgD9gVUrLSQ9+5zvOL6FNpYAe8ceU91AeSEGAaRM850PTSQyXHr14+N4uHxlzo8vZmBaTqTY8ElqveWWEpqdU6wt7U4i7sd0XKkxbp9hiFfkJZIMyQ9Xie9H5knGtFDbujrXrn3p/inVba0N2fNfvUTNO/3EPkQlyjAT4wt65SBTDZPtkVYXu4aMatc01xY/nu/yp8kstjS0jtTB+gKnCDZnEfpJEPHBCUjEfFDaZcGtRDTM5BrErlcHK2cfssRjMJ+ZZ6xlNbd4/Ebzu3eRemG1GjETDRft6o87+VnMTc+R7D3keaiIqax5/eH7+YIyhl19Bs5CZFZX3sFi9D6ByUnDkd039BlH/htpFo0I1TAEh0HsXG9QDp+LO8w1guOp6/H4vw362TBYkGvpcLpxaR0NEabTNk+htdJ/n5PAFO+lrE5J1rauwMadstOYH79jnbZjyHaPE2OqE1BHKfq6mPKkJ9riBApnWQ9+emMXfzYKjjzPWJ/0mi0rRnzpd6QU
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(136003)(46966005)(186003)(16526019)(82310400003)(36756003)(107886003)(70586007)(1076003)(966005)(44832011)(70206006)(336012)(4744005)(33310700002)(478600001)(36906005)(356005)(6666004)(47076004)(4326008)(316002)(8936002)(82740400003)(26005)(5660300002)(8676002)(83380400001)(2616005)(81166007)(6916009)(2906002)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 13:07:45.2607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa80d962-bd00-4ec6-69bb-08d8608ad41d
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2812
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Using backslashes in file:// URIs was broken.
Either the resolver would fail or the subsequent `cp` command.
Try to avoid this by putting the filenames into quotes.

Fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D8161

Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7ec1fea5..551bfb70 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1520,7 +1520,7 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd =3D 'cp -fpPRH %s %s' % (file, destdir)
+                cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
=20
         if not cmd:
             return
--=20
2.26.2

