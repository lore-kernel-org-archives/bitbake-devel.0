Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E7C433F5
	for <webhook@archiver.kernel.org>; Fri, 31 Dec 2021 00:22:07 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web11.5667.1640910121693805729
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Dec 2021 16:22:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=MvgconDz;
 spf=pass (domain: intel.com, ip: 134.134.136.100,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640910126; x=1672446126;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5NItFxBAXwhIaIQ7o3EKFN8HM7mxIBcaqij0ZIH8rW4=;
  b=MvgconDz+Yx/lCdglcOTlvUwTYikE59rtGieF4NwZ4zSrGilyUbv/M/K
   N9z5KN2ySzknSzj4FyqBTQzPAFBJLlqIS3teElezf/W6MaUFrDXbhtUJ/
   5vXQZL5O0sqC3F0fHbA1r0mndLV8P1dbrK6BoGG8QIaXzOj/CsysKUyXm
   t7qSYQlgOdLryRX7QuqkzyERwreNYNxW5sYLW5o+iSrSXQ+U0f/GDZMiA
   0ZWSqNlLoYpKQdvQJCdun1Zk9UL8W0OV7Taulg5c4XNOL0GCYiBNEazda
   LDyTSjm443OkgO5Tz5IMawoOiCRixbeLoSt+7uAP2MHP10FY4Y29QUVkg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305110487"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="305110487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="468943790"
Received: from jiayingk-mobl2.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.231.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:05 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 4/4] tests/fetch: Drop gnu urls from wget connectivity
 test
Date: Fri, 31 Dec 2021 08:21:55 +0800
Message-Id: 
 <92a16b425fee5f0c46122eb126ecd8b381cf1ec5.1640910042.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640910042.git.anuj.mittal@intel.com>
References: <cover.1640910042.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Dec 2021 00:22:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13208

From: Richard Purdie <richard.purdie@linuxfoundation.org>

These urls are no longer adding much to the test coverage but the intermittent
network issues connecting to them are painful. Drop the urls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit bdf5739c5d831dc97a7d81568f94a0953c71017f)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/fetch.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a85ebdf4..34f3a4f6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1378,9 +1378,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
-                      "http://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
-                      "https://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
-                      "https://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
                       # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
-- 
2.33.1


