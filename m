Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail.openembedded.org (Postfix) with ESMTP id D26F661A5C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Feb 2020 16:16:34 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id r17so7067481wrj.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Feb 2020 08:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+8pyYD7JeOFkyEOO6EB3ppBfbNLE3uST4lXgSCkDAyw=;
	b=ALxebqJe2Fr+cgCzK/LwTsr1g6mNtxDiz3BY+rYX+Klx54rdxfGJIPf3Ldbb/SiXAS
	3m3+5CUZsipciErAtjEKveKfvjjzKtiXdFHtKUquPru+8VKQORKZzFmi+ukI9v5Vrlbp
	SHiQ/4wwtZ9oyZOMh0f+zl4yfbcHJmZBGTqMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+8pyYD7JeOFkyEOO6EB3ppBfbNLE3uST4lXgSCkDAyw=;
	b=ltbelLhPPRi0IZrSi7c4LeCcmL93rWGHgyddcCSRiCU+CUXLhtXhvcT+t1QlvLyvG1
	69TXpnB9qcYE407+YJkfiB/wKP8oBldOpwJ3XtfycvqX6qsgIcJ6Bl9hSVCStXkg+FUq
	nc3m60dWK9npq23BST8OuTeqBdNVDo8cXzMRocKNiNMjlJXANvCtNB6a6GN7nvWjcTUU
	ysuyXsyjNvB8FAtqTz0eG3e3ett5GzdQ2/9A5QqQB+A3Ar0we5dfmgInGM7YBu0V3ec/
	SFexQeSj8VWWB5xCK16TAxLz8RqING5fm1QRuZtOPhITQTVA86556l/kuN0DIWMfxut9
	PgAQ==
X-Gm-Message-State: APjAAAXAEH2CDTWIyl7lao80qttbyYaTQ4lNnDAw50q7gPgQB/AVlOnv
	MPGasPB/ZPr5n9f5FQzAF+N8yrkQedo=
X-Google-Smtp-Source: APXvYqwPxhGJq0wKjjVznanUC/fUFECyaARZ+o1uk21GVIGTyKL87XlbM1GgUBR82Qt/HSvkQmElKQ==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr11792983wrs.360.1582992995175;
	Sat, 29 Feb 2020 08:16:35 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e8sm18295104wrr.69.2020.02.29.08.16.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 29 Feb 2020 08:16:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 29 Feb 2020 16:16:33 +0000
Message-Id: <20200229161633.496077-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Subject: [PATCH] fetch2: Limit shown checksums to sha256
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
X-List-Received-Date: Sat, 29 Feb 2020 16:16:35 -0000
Content-Transfer-Encoding: 8bit

Currently bitbake will list many checksums for a recipe when none are
present, encouraging users to add them all to a recipe. We don't
need/want them all.

We used to show md5 and sha256 but given the concerns about md5,
switch to showing just sha256 going forward which seems like the
sensible one to standardise upon.

There will be no change to existing recipe functionality.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b83347ad90..9734e21126 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -34,6 +34,7 @@ _checksum_cache = bb.checksum.FileChecksumCache()
 logger = logging.getLogger("BitBake.Fetcher")
 
 CHECKSUM_LIST = [ "md5", "sha256", "sha1", "sha384", "sha512" ]
+SHOWN_CHECKSUM_LIST = ["sha256"]
 
 class BBFetchException(Exception):
     """Class all fetch exceptions inherit from"""
@@ -580,7 +581,9 @@ def verify_checksum(ud, d, precomputed={}):
     checksum_dict = {ci["id"] : ci["data"] for ci in checksum_infos}
     checksum_event = {"%ssum" % ci["id"] : ci["data"] for ci in checksum_infos}
 
-    checksum_lines = ["SRC_URI[%s] = \"%s\"" % (ci["name"], ci["data"]) for ci in checksum_infos]
+    for ci in checksum_infos:
+        if ci["id"] in SHOWN_CHECKSUM_LIST:
+            checksum_lines = ["SRC_URI[%s] = \"%s\"" % (ci["name"], ci["data"])]
 
     # If no checksum has been provided
     if ud.method.recommends_checksum(ud) and all(ci["expected"] is None for ci in checksum_infos):
-- 
2.25.0


