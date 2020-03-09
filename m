Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com
	[209.85.166.175])
	by mail.openembedded.org (Postfix) with ESMTP id C92BD616A9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:04 +0000 (UTC)
Received: by mail-il1-f175.google.com with SMTP id b17so9265381iln.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=b28k5IksuIOB5UYEOsckZR3pAhNFeHaSY6AkGtWEhJ4=;
	b=Za/zPDgWYX+x/xWJBo+kcQqTqkSOOy0YmrNzHWaXRfCXamPukgOsP+XZeJnJQZMSM6
	OOlnCZCfvHEDg2ar/YhvLN3DDb0cyGEv9nL0zwqlijX4YMZluzWwKpqV019NebGnPaZZ
	bgSGaDHiEMV9Dp1y/W0wjfpnRKk7Ad39KL3lWgMn2pbWzpPLSTo4QJJfWHEWIYYcZEyG
	v/En6ZS54s2uVeLDCYeO4Rs13VpF4mHtErx/NHcAfvKiCagVFNyblKLvJbr4WEBqD4yb
	V8kosMcwKaZCTvQHQ2JtjJ560rt7AQoWCMyrWbMOMAJLqJ5VXNepFA7Y/3MDt0gctQHi
	Es8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=b28k5IksuIOB5UYEOsckZR3pAhNFeHaSY6AkGtWEhJ4=;
	b=OlbXegYr6NJRB8U6hgJzW80lDE6O1gnQjvXmIupxrQRmrkZ8HPO3Tuy03h59kPb+8P
	Es6+uwEgeb7jX7DA4d/gsjOSzlVo07lI8AVUKik3qYy0aMBcVd60cXCbUluRDeLeOk06
	PGbCq3/BVBeptRZZ1SilelkKmnKTFi/4VR0XaxnEjNYt5bQKxgBK+pbhnEQZbU7kfLCW
	Fy4ahaqNkqgvlE4n92xQydBacnJKLmFspVX4vR6OVqQydmgGB3uhwpTf7Yy5IyXW4WAk
	L9ohmx80LbWlkHR8PNLxUy3+jLanKDLhRAYfPONzTeE9fb5Ilf1azy3rB7P5kLmnUxbT
	G56w==
X-Gm-Message-State: ANhLgQ1bOG0NGFeHxzt/IR3D2PBvJtEams8yhAk6UCXtv/gFZVNvpbGG
	aw4uNPWgGTyYCpRbLE8SqVFYgU5/HCw=
X-Google-Smtp-Source: ADFU+vvmyXSFXQ/mraWG7Y9+tv9LNxsBsbwYVGg4yNDT3qs+1k/V0JDtLPDJptDN9rs5kaz0i070jQ==
X-Received: by 2002:a92:d09:: with SMTP id 9mr15200985iln.191.1583771645606;
	Mon, 09 Mar 2020 09:34:05 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.02
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:03 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:45 -0500
Message-Id: <20200309163353.15362-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 07/15] bitbake: lib/bb/msg.py: Remove unused filters
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:05 -0000

Now that the filter are described using the python logging structure,
these classes are no longer needed.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 8561826a6e..cab079e333 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -119,22 +119,6 @@ class BBLogFilter(object):
             return True
         return False
 
-class BBLogFilterStdErr(BBLogFilter):
-    def filter(self, record):
-        if not BBLogFilter.filter(self, record):
-            return False
-        if record.levelno >= logging.ERROR:
-            return True
-        return False
-
-class BBLogFilterStdOut(BBLogFilter):
-    def filter(self, record):
-        if not BBLogFilter.filter(self, record):
-            return False
-        if record.levelno < logging.ERROR:
-            return True
-        return False
-
 class LogFilterGEQLevel(logging.Filter):
     def __init__(self, level):
         self.strlevel = str(level)
-- 
2.17.1


