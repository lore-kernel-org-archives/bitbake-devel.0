Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
	[209.85.128.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1F3157C66C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Feb 2019 14:45:41 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id x10so12365506wmg.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Feb 2019 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7hOCf6l4+YODwUB2aZ8FrCqg/+Ugc0Wyj12pb7Utsqc=;
	b=fi9KxbSZVf0LzXHHWoZsnQ3R6Rlw0yXWyomdPdoSpOkbilbHjGvNULUuF0IWUGUS9s
	0ssuKAcE/C3sOn++TlYTHft+lEk3ZukHHbJ2pa95CTiZqsWSlgH1nrJ6EiTTXT/jX18N
	K9ms6fa6EMXyYHd5fKlDqJ/taJTsXIbjJcGx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7hOCf6l4+YODwUB2aZ8FrCqg/+Ugc0Wyj12pb7Utsqc=;
	b=fkpPRaQ5Ktg5oFlX6gNWbU7myllMqnw5GDj5wLxFC2rInTOh/Cc+1SkOclNLVcgoY/
	GynDB7TUYDzoAWMx6n130lWtSxinOk5zzvuwimQnufIeVXeGwXPXIlETxv+Jt5/+lcTW
	178Hz0HEF52LN13RgQ0AMEBrUlxNhrEfqVItvTVzsZfl/vg00tODy3wA36rWRF5bDYes
	f3QUQAmpRomExJtr/0VplCmShAMnymi2OJme1vftNbhhtkyODxzTe2GOD9Hwe2JfC3OY
	4+OY/5xJTz7pGvk7KXzC8vmX8QdNZdfIlXNFcMp8GfdjUhu0Ixu5pTeO9+tjwcMkEo4L
	w9jg==
X-Gm-Message-State: AHQUAuayWhtrXp6loex1sNfhLxJgHAZqt9zHsYDcFJD3WIPrsFBwEzsc
	/a4whyFuQyGbpcjE6fv/UqbmYtNw3uo=
X-Google-Smtp-Source: AHgI3IYGkPeVpnIYexhCa1NWpAKTcgLuSh8ESGVRUQgHA68Oc3i/w7NzBrpXqJ3ifYQ/ToONfx8dbQ==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr10589814wmh.76.1550328342243; 
	Sat, 16 Feb 2019 06:45:42 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	m16sm6970456wro.78.2019.02.16.06.45.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 16 Feb 2019 06:45:41 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 16 Feb 2019 14:45:40 +0000
Message-Id: <20190216144540.1653-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Fix dependency loop analysis 'hangs'
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
X-List-Received-Date: Sat, 16 Feb 2019 14:45:42 -0000
Content-Transfer-Encoding: 8bit

Currently the mechanism for breaking out of the dependnecy loop analysis
code is broken and doesn't work leading to bitbake appearing to hang.

Add in a custom exception for this purpose and fix the code to exit
as intended, fixing the hang and making the dependency loop code
usable again.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 80ae8a2a46..71f178de4f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -410,6 +410,9 @@ class RunQueueData:
         explored_deps = {}
         msgs = []
 
+        class TooManyLoops(Exception):
+            pass
+
         def chain_reorder(chain):
             """
             Reorder a dependency chain so the lowest task id is first
@@ -462,7 +465,7 @@ class RunQueueData:
                         msgs.append("\n")
                     if len(valid_chains) > 10:
                         msgs.append("Aborted dependency loops search after 10 matches.\n")
-                        return msgs
+                        raise TooManyLoops
                     continue
                 scan = False
                 if revdep not in explored_deps:
@@ -481,8 +484,11 @@ class RunQueueData:
 
             explored_deps[tid] = total_deps
 
-        for task in tasks:
-            find_chains(task, [])
+        try:
+            for task in tasks:
+                find_chains(task, [])
+        except TooManyLoops:
+            pass
 
         return msgs
 
-- 
2.20.1


