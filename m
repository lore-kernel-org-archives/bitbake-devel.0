Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.49])
 by mx.groups.io with SMTP id smtpd.web12.28547.1598560779158543176
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2020 13:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=l0Gm9G/4;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.49, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKivIStsA1OZDOjUJuLmODUZHY+FD2dX/XRHiXY7iNCcmY2C/q+5iE5Hgg9ZsPkQ4NJXlEqMPC4M8HTEhv8OimeMP82tXmizL21KipYvioFvQtpo/quuVhFhGgcfrG868klgh5lIB9BtjchqChIIX+6oLE5GumFgs/HCc0YIO1LSKSoJzXZBHBeAR0lSAZ8tIlUl75PFsKBL5eI3ZcYuznet9LLngMn54Xv/tl80T5Pm10u3Qlbyao6l28hzfqXWNedjJxaQ1mH4463oEq3FDsyF6UTGYHnZ8kFLaFQ3qIUBSony3oUJ6BBEjLukwJ9Od66vgaOigkMh6y3bgY7nSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbZCJeC4IgpgwleSkUXhj8rinzROe88gfSotRXsgTU0=;
 b=VHi0bSmU+DJUrFht8We9kaLUj3y7+wEZUeVcsUeznMFjskTRci99eg4FzDiffOClj6UUAAJst51o0+pj31JLXQaP5nRv9Gjj+NiZL698IkQ9ajBRX8Kk/Ib23hnQrgxsKL5f5cqZENvC34z1kJS+Peuvn6ji0t5DRYp5BTh99RliAYyt+iMWpT3xkbUq99H6n43YOd6b2oDZUsxFx7cscE97I5N0fVoBZ7ssa7eG5vDLAWXyMcfXgXY7eQCQOHHQHh/k2pRkldDULscd1Jau9YL6sSJpEfRSuEXvVloDXygq8iO86r81Ttao1jYPuFL8PIMVwnWGHwWEFmifzYUcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbZCJeC4IgpgwleSkUXhj8rinzROe88gfSotRXsgTU0=;
 b=l0Gm9G/4s51KMfW1TDSj8Hk9Uw7gwgJI9MawwkTLkDz96Id1ZW/bTiS7RzjbUk/J+kKHKJFrazk+TxmsomgNF853UVzDMEE4BlCMlTITzVknvZWqH35j7yxmV/F51pG1vGzdV6aVP2hFqaiuxRljOmR5V3VVQFYvuPn0yTMj1EvePONeWKh/3NYM7QM5HGFA/h0PkVG0eAw+uYepdcaV7UiPP0AaaMCitsKTUfL6ZrasKXDbvXbN8kJqd/78dPUsTVjgeeAZzE1rqKACHSvvTGI22I7xwmu3VQbq4i4Nxyf3AGrMztH4AkyReciC5xllCaOB2mRPgDGGx7gBgJVQwQ==
Received: from BN1PR14CA0019.namprd14.prod.outlook.com (2603:10b6:408:e3::24)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 20:39:37 +0000
Received: from BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::2f) by BN1PR14CA0019.outlook.office365.com
 (2603:10b6:408:e3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Thu, 27 Aug 2020 20:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT047.mail.protection.outlook.com (10.13.183.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 20:39:37 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Thu, 27 Aug 2020 14:39:15 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] COW: formatting
Date: Thu, 27 Aug 2020 16:38:38 -0400
Message-ID: <20200827203839.29669-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f033ab70-0c48-457b-4403-08d84ac950ac
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SN6PR12MB28159D164144FA53ADA3F9AF8B550@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mrcIxxeXi3DtJ/piIADIwW642l+n54G8xwyeUhdR70tBlTWMjO5vcWA4QQnmw//PX/xVAbX+x4Tenk+MmMWnR6tR+sw3WELUYbqyYoCJKpQWR6Tal59n+KmVO5Pb2NGyY5FMQTpPp6QEQYumwHpQiqzojxleawUuN7DgbwdCPWR691aJyBM8g3oCJHftNsZ33BRwAdJhKTW39iLMr5PZNLw6W1jb55Tjt6L+bwpnZRT1EILheP8dGyp109Lkz06EqP3VcbCZMcQatwUU7PnLC+vuMJMZrRCr6s2c4p/wVhEb12WoKFUlH19e+g8HvXD9UPIqErlm1xH09p8r1xE+u179r0ZfN8YUH0JZS0RWN5u5cjDtoDgc9K512BAWIFFySuKcthiBz3zcyv5ZeaOEETGu3HTOBTxabMoP4+qJ0cs=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(29502001)(46966005)(86362001)(478600001)(6666004)(82740400003)(82310400002)(6916009)(4326008)(47076004)(7636003)(26005)(186003)(107886003)(356005)(83380400001)(336012)(5660300002)(8676002)(1076003)(70206006)(36756003)(8936002)(36906005)(426003)(2906002)(956004)(316002)(44832011)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 20:39:37.3524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f033ab70-0c48-457b-4403-08d84ac950ac
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/COW.py | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index bc20ce38..3785a8b0 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -3,13 +3,14 @@
 #
 # Copyright (C) 2006 Tim Ansell
 #
-#Please Note:
+# Please Note:
 # Be careful when using mutable types (ie Dict and Lists) - operations involving these are SLOW.
 # Assign a file to __warn__ to get warnings about slow operations.
 #
 
 
 import copy
+
 ImmutableTypes = (
     bool,
     complex,
@@ -22,9 +23,11 @@ ImmutableTypes = (
 
 MUTABLE = "__mutable__"
 
+
 class COWMeta(type):
     pass
 
+
 class COWDictMeta(COWMeta):
     __warn__ = False
     __hasmutable__ = False
@@ -33,12 +36,15 @@ class COWDictMeta(COWMeta):
     def __str__(cls):
         # FIXME: I have magic numbers!
         return "<COWDict Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) - 3)
+
     __repr__ = __str__
 
     def cow(cls):
         class C(cls):
             __count__ = cls.__count__ + 1
+
         return C
+
     copy = cow
     __call__ = cow
 
@@ -70,8 +76,9 @@ class COWDictMeta(COWMeta):
         return value
 
     __getmarker__ = []
+
     def __getreadonly__(cls, key, default=__getmarker__):
-        """\
+        """
         Get a value (even if mutable) which you promise not to change.
         """
         return cls.__getitem__(key, default, True)
@@ -138,24 +145,29 @@ class COWDictMeta(COWMeta):
 
     def iterkeys(cls):
         return cls.iter("keys")
+
     def itervalues(cls, readonly=False):
         if not cls.__warn__ is False and cls.__hasmutable__ and readonly is False:
-            print("Warning: If you arn't going to change any of the values call with True.", file=cls.__warn__)
+            print("Warning: If you aren't going to change any of the values call with True.", file=cls.__warn__)
         return cls.iter("values", readonly)
+
     def iteritems(cls, readonly=False):
         if not cls.__warn__ is False and cls.__hasmutable__ and readonly is False:
-            print("Warning: If you arn't going to change any of the values call with True.", file=cls.__warn__)
+            print("Warning: If you aren't going to change any of the values call with True.", file=cls.__warn__)
         return cls.iter("items", readonly)
 
+
 class COWSetMeta(COWDictMeta):
     def __str__(cls):
         # FIXME: I have magic numbers!
-        return "<COWSet Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) -3)
+        return "<COWSet Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) - 3)
+
     __repr__ = __str__
 
     def cow(cls):
         class C(cls):
             __count__ = cls.__count__ + 1
+
         return C
 
     def add(cls, value):
@@ -173,11 +185,13 @@ class COWSetMeta(COWDictMeta):
     def iteritems(cls):
         raise TypeError("sets don't have 'items'")
 
+
 # These are the actual classes you use!
-class COWDictBase(object, metaclass = COWDictMeta):
+class COWDictBase(metaclass=COWDictMeta):
     __count__ = 0
 
-class COWSetBase(object, metaclass = COWSetMeta):
+
+class COWSetBase(metaclass=COWSetMeta):
     __count__ = 0
 
 if __name__ == "__main__":
-- 
2.17.1

