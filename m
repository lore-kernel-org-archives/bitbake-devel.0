Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id 15D0C7D39C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:04 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id s10so4561245plp.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=f0v3WKOJFLSGahivqFK4MGF3dP8k1LRE8Cv3sCLguhA=;
	b=AMFM3J36Z9W1uFj+oyaUjE7MGNvoCxkxEXACBSBapF6nDcU261pcxfZg8zKCPpAo/F
	2Is2q1stbFiJNEmKpZOO9dP7JWm5RmSj9VWak5bJQ7EMSfv0VvkdiVO3/Zsn5ytS0o0b
	vfnSV0Qawd6e/HNhC7vaZzI6+rZm6Y4chSG+yllQNGTZ4FCfb7Vtn5ouoXA5M/63Mtl9
	L/CwkA8jBRRz/Qeeoa8VJdVmDNokwblvFNkWAzZ6ITdLtyeMBXcrmkX4FYMAtX3pM/Dg
	qFp7ktVKrLIBYh8JEX6+LhhmlNc+1P2pvfWz5E+uqPdcnh41CX9WlH62NhAW+DE/jLn4
	oC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=f0v3WKOJFLSGahivqFK4MGF3dP8k1LRE8Cv3sCLguhA=;
	b=cuefFuQxDdQQYdi9cd1UsSKvSxRHBjoVWW7/KxlfT8ft2XvMilSkFJd5gmtFqw5jq3
	x8ZuPeS1XGG4L5yo4UVtHwog6DIi3FpGlCERE6xm37QBbiY5t6s39L4IgCdC8cXAIsE7
	cMBMdb79RGQH7uo8R8CgN+GezJBZaZOfGhMkK295pF5XPIFhC2U89N8AWFeDDtQNzQ2h
	0sf0Z2aECVHpARO5qHTA8RV/MTwqVNFJ5n+uG+eduH9P9qw0OerOlHAkAjhQsOaTPDyz
	h+tqJIrizUywWSu9Wt5gFdAcQcShltkxusnFWoVKde0gUzTP6H03XJovns+73rOQWNX6
	fBAA==
X-Gm-Message-State: APjAAAWShQIOx1JKECTGcY0inuZmIYC6fRX5XY1v2HP634tlxiaa8fM7
	JrrdeMj0ERqs5wun5faOhO3GAmOs
X-Google-Smtp-Source: APXvYqwoJqZViJWrA9rx/2EDm0EzvkVGld3Jzhx8x1gHvWBwCjmHvnc1P7uDz5ghm1/0tqhKctJa7w==
X-Received: by 2002:a17:90a:bf81:: with SMTP id
	d1mr26506420pjs.125.1574526305931; 
	Sat, 23 Nov 2019 08:25:05 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:05 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:55 -0800
Message-Id: <1574526299-21018-5-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Subject: [1.44][PATCH 5/9] cooker: Remove a left-over comment about expanded_data
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:05 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

This should have been removed together with expanded_data in commit
e3694e73 (cooker/command: Drop expanded_data).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/cooker.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 20ef04d..e6442bf 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -371,10 +371,6 @@ class BBCooker:
 
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
-        #
-        # Copy of the data store which has been expanded.
-        # Used for firing events and accessing variables where expansion needs to be accounted for
-        #
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
-- 
2.7.4


