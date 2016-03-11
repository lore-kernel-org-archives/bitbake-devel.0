Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 0928770101
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 09:03:38 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id p65so9087598wmp.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 01:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=NplCot3HJT/+6Fuye8YlzMlOYRU8fPil+vCxM5ChQv8=;
	b=BX+TK8ty/16escevxT5AHpsHd1n8CfTM0nFEIOpizd4dQbGWK5IOLEV3zaROsS/3Dw
	lpcFHIPOScG088G0/S91dpTzbKSlmxZ3a07U+I4uoth+J8MnsQSKKJ11x8PXYri8UZEO
	ibmAZH6JKotgIooDV56QhkeOm7sVFmpcTHKtqV3i1vTKEM1g95OU2cYMTJ7CC58axNdn
	KjUeIw9BHW8GkLXGD5WHW/2+N4yC5f8fC9WGau2Ao2cWsk3x59kdJJkRTDD8Pac2raEJ
	RcFOge5grsF4oful2ELA4xoHDjVbi1oki0sPkGAvLjvUDg91q33+GMfFnPtcnI2dbXoT
	YyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NplCot3HJT/+6Fuye8YlzMlOYRU8fPil+vCxM5ChQv8=;
	b=fIkMQhLceLSkCUc+moGDFrf2K+6Tm2rPyPRDotbUduDdUtodgzPVQrQ6Oyi6a7F8Rs
	LkBDK7Ecq1ppXafPn7tiP0helt9XTmzWo9c8sFXWWB9pRHPmDQd1jZ/1uJs6Hl/FzUQK
	8TYnicXBBNCpR7IgAiP0KwDYP7ZKi/HTnHRD35uUOBmSL1TO6lPO6iG6LL8gRItFflBZ
	nFglRO0dzbHKcvdMDBtSXavjL6ICfQZHOLE7pzvb4alyOX2JVqP9zthbEgU5JnOnle8C
	JWWSgCzWO+sVYoYflWOUj3Nd5YvXm6EXBlPjCcWk0+sUkY7IS1ej4NSbF3uu5AzRvFXA
	fZXQ==
X-Gm-Message-State: AD7BkJJGGUDBEdU6PPJHXS/9tapqP+RpmWWGq9kePKMmUzzArqADObya8wKbSmmvUIwnBg==
X-Received: by 10.194.209.204 with SMTP id mo12mr9157637wjc.69.1457687017963; 
	Fri, 11 Mar 2016 01:03:37 -0800 (PST)
Received: from localhost.localdomain
	(LPuteaux-656-1-252-235.w82-127.abo.wanadoo.fr. [82.127.113.235])
	by smtp.gmail.com with ESMTPSA id
	n66sm1242640wmg.20.2016.03.11.01.03.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 11 Mar 2016 01:03:37 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Mar 2016 01:03:32 -0800
Message-Id: <1457687012-16384-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2: include full path to recipe in 'SRC_URI not found' warnings
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
X-List-Received-Date: Fri, 11 Mar 2016 09:03:40 -0000

Showing PN only is ambiguous if multiple versions of a recipe are
present.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f86014c..72cd055 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1102,9 +1102,9 @@ def get_checksum_file_list(d):
                 if f.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                     if os.path.exists(f):
-                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
+                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('FILE', True), os.path.basename(f)))
                     else:
-                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
+                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('FILE', True), os.path.basename(f)))
                 filelist.append(f + ":" + str(os.path.exists(f)))
 
     return " ".join(filelist)
-- 
1.9.1


