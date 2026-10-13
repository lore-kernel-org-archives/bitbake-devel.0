Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE44CC6B15
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:15 +0000 (UTC)
Received: from prod-mta-13-01.swg-srv.net (prod-mta-13-01.swg-srv.net [185.255.28.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7765.1791899585987667800
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 06:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=SlwtIl+D;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.34, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a13589be810008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=RJfEoYaYyMvnPmWOucpiTwe5xDjr0a0e884qPrGieMM=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=SlwtIl+DXFWQ/yuBf2D6lwDPOhKUQnHWHmBxBkZlXx7B8kSUv9s8sPdUJ5LTHeAO+I3u2YPiD
 vcT4IoRG9pJS97kL6sI7AFkTj/yyrtSKGl86Q02ZA8DblvsZc1osfy6LHtEm3pEQGGU/3Hp1Wdo
 AjKuY/+BXFf6TQfM2VXvAJGUsZfCcKxlsMsJ971/02ntm4C3tu4B9lUNutBdTj4ixkxbC79mzKJ
 8pJTj+0b+4SoDXNu0ac9Qv0lrFKG4UohY+2FcdWZSh5pQEs1gdI/Fyq3jvdDOnNHzdShaoH9G0I
 6Upaggp6ePM5G9kqnkGjnlFzVmTlsnU74eTxdqx6o8YA==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-01.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a13589be810008425.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 13:53:02 +0000
X-Zone-Loop: 7a093494edbb227fb686e08196a34012cddc07a4fc70
x-campaign-type: default
x-transaction-id: eda4fb8e-ec62-4bf7-b12a-396c62391d37
x-swg-uid: 01-05a2a698-d378-472c-9fc1-67612e314ffa
X-Mailer: Sweego
Message-ID: 
 <1791899582.8631fc262581453bbf619ec5b2062170.1a13589be810008425@vates.tech>
x-swg-bid: 1791899582.8631fc262581453bbf619ec5b2062170.1a13589be810008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 85EC6827DA;
	Tue, 13 Oct 2026 15:53:01 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v3 1/4] data: add a (failing) test showing non-expansion of lowercase variable in override
Date: Tue, 13 Oct 2026 15:52:14 +0200
In-Reply-To: <20261013135251.168428-1-yann.dirson@vates.tech>
References: <20261012084202.103724-1-yann.dirson@vates.tech>
 <20261013135251.168428-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.16c.e72e782e71e849cf.1a13589bca3.e5f4fc3970535837=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791899581603
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 13:53:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20331

---=Part.16c.e72e782e71e849cf.1a13589bca3.e5f4fc3970535837=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a minor variation of the test_append_in_expanded_override test=2E

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 lib/bb/tests/data=2Epy | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/tests/data=2Epy b/lib/bb/tests/data=2Epy
index 491774747=2E=2E31a1ec323 100644
--- a/lib/bb/tests/data=2Epy
+++ b/lib/bb/tests/data=2Epy
@@ -416,6 +416,17 @@ class TestOverrides(unittest=2ETestCase):
         bb=2Edata=2EexpandKeys(self=2Ed)
         self=2EassertEqual(self=2Ed=2EgetVar("TEST"), "base appended")
=20
+    # Test an :append whose override name is lowercase
+    @unittest=2EexpectedFailure
+    def test_append_in_expanded_lowercase_override(self):
+        self=2Ed=2EsetVar("machine", "qemux86")
+        self=2Ed=2EsetVar("PN", "gizmo")
+        self=2Ed=2EsetVar("OVERRIDES", "gizmo:pn-gizmo-qemux86")
+        self=2Ed=2EsetVar("TEST:${PN}", "base")
+        self=2Ed=2EsetVar("TEST:${PN}:append:pn-gizmo-${machine}", " appe=
nded")
+        bb=2Edata=2EexpandKeys(self=2Ed)
+        self=2EassertEqual(self=2Ed=2EgetVar("TEST"), "base appended")
+
     # Test renaming to a key which is itself not expanded yet, as native=
=2Ebbclass
     # does=2E The dependent override keys must be left for expandKeys() t=
o rename=2E
     def test_rename_to_unexpanded_key_with_override(self):
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.16c.e72e782e71e849cf.1a13589bca3.e5f4fc3970535837=---

