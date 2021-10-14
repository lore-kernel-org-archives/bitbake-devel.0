Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26637C433F5
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 16:33:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web08.570.1634229190422403098
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 09:33:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1571211D4
	for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 09:33:10 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B41013F66F
	for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 09:33:09 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: document checkstatus API
Date: Thu, 14 Oct 2021 17:33:06 +0100
Message-Id: <20211014163306.1022764-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 16:33:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12777

The checkstatus semantics are unconventional, so document them.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index 259b2637a6..63e619ab98 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1780,7 +1780,11 @@ class Fetch(object):
=20
     def checkstatus(self, urls=3DNone):
         """
-        Check all urls exist upstream
+        Check all URLs exist upstream.
+
+        Returns None if the URLs exist, raises FetchError if the check w=
asn't
+        successful but there wasn't an error (such as file not found), a=
nd
+        raises other exceptions in error cases.
         """
=20
         if not urls:
--=20
2.25.1


