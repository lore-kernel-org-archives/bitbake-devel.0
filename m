Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
	[209.85.128.180])
	by mail.openembedded.org (Postfix) with ESMTP id 5927B77CCC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Sep 2017 09:24:36 +0000 (UTC)
Received: by mail-wr0-f180.google.com with SMTP id o42so7669527wrb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Sep 2017 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=MEUHktrFo/sEu+YIbgMJziobVa5KF8RCnRth7tUHvT4=;
	b=EwuQfZ4Us5PjHMSoQ5VaGHDo9s9YBDCesQ9BzseB5/DcSZH4giMMcNB43lbvSVmmsW
	INwcK2F6HhaL0eGV5trBnGj7FmBBL5WdrEMff6WjDnH0Fj7hLWQfXa7ydl6eM24P8pyR
	t8KnsNUGjKy/dUEyZdZAQNebkkcRC0BCgSJLLPdZwS5yitix4vu3Vd3xWRSHjz46VNKK
	V44CEcBdlKgpTJ/E/FuPyXBB4oGdqsE/J0XcDFU3092ta7FaUOB6Qq2EcoKy/LVHpgzl
	vA/DMaGIxjZ745bE3nC+T5qD1D1b3cfaK+mwYcDo25bFjgs1uOdaCKsHM0CsOrGMCyul
	ojUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=MEUHktrFo/sEu+YIbgMJziobVa5KF8RCnRth7tUHvT4=;
	b=s8Gsbko/+4Iu4UMt7OA5p3BPAze7AV0WmtLkTnTy9qcaz7hXMm1RFBxsgZn2SrV132
	7jD6JX9w7zOWUatEmIhRV5bZVShqAz3B7vmNuadcWVMIc9DUwU0FZ+j4pp2SU/w1nzJV
	oammT54B0yebR9z8sXmUZbIkuNqryvNamYLdo2/t3oB45oFWtLbmx9do25ITDbEhPiTg
	U00sQPoGazDMcrIMHv2mAbKT8UBc0SzsAbQ/sttC4Qsc8Prs1jX3GgN7f0komgfacqtZ
	O+/gzu90V0wRZ8CnXnufMt1K7lF7OGy6QHHJw1V5TRsWyLK3W1kRd1/lHxdEqCxAvE1k
	7S9Q==
X-Gm-Message-State: AHPjjUiE3dvqQfJw5Ks8iGqtCVAudjQ8P4qFedp8J3xMhKzdLEHRxdfT
	JXGMc3MzgUtRkTVHRQo=
X-Google-Smtp-Source: ADKCNb4gLQ9w7T/a9GMOPwjCEoC6sSp5FHjahAiPgMH83wWozJiaWllahEJ4mlFhaYNelsHMwcOWag==
X-Received: by 10.223.150.73 with SMTP id c9mr1460712wra.284.1504776277376;
	Thu, 07 Sep 2017 02:24:37 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	a39sm3635221wrc.48.2017.09.07.02.24.36
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Sep 2017 02:24:36 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Sep 2017 10:24:24 +0100
Message-Id: <20170907092425.25124-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 1/2] fetch2: add stub latest_versionstring to FetchMethod
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 07 Sep 2017 09:24:37 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 3eb0e4d2110..f70f1b51575 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1559,6 +1559,14 @@ class FetchMethod(object):
         key = self._revision_key(ud, d, name)
         return "%s-%s" % (key, d.getVar("PN") or "")
 
+    def latest_versionstring(self, ud, d):
+        """
+        Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
+        by searching through the tags output of ls-remote, comparing
+        versions and returning the highest match as a (version, revision) pair.
+        """
+        return ('', '')
+
 class Fetch(object):
     def __init__(self, urls, d, cache = True, localonly = False, connection_cache = None):
         if localonly and cache:
-- 
2.11.0


