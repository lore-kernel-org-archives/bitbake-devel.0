Return-Path: <jacob.kroon@gmail.com>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
	[209.85.215.44])
	by mail.openembedded.org (Postfix) with ESMTP id F36FD65DD7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 15:07:06 +0000 (UTC)
Received: by mail-la0-f44.google.com with SMTP id b8so3918184lan.17
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:subject:date:message-id;
	bh=8byIEZ5tsF7O34lAqRCOAcyqRffvynCsTWlBTK2WgA8=;
	b=cjTs4t6Uf+wT1/naFFNp1/pZ7LQi3SiGOX8n+PQJGNnoC+gz9ijCYYpMUwcDdg5dj+
	JFYbsVxq2qdZV/+xUlDMhlC0Ac82LJFyHYKIXTrDs8W1u8mHYB5ZZO9GRJNMzwRdrBrt
	IhTo/HaRlI9KgNBUNVxqttjIl/w94bk1rmN/Mbd+621lBYyUbfkvo6Q52b+nyGoklUqR
	7LUwKUhJvAX69sBcZhbSJUZmBnr3utc0Lo74171dFpMYjHjN3mXpiFPs2YoVWO38hFXR
	hINu5p6UK2Up7Y2QZsIfimLvYkNwi8xPe2Zq//tOr/C+Zp9/81AZGycmWbeavnNRxjNJ
	0jQw==
X-Received: by 10.112.13.35 with SMTP id e3mr380880lbc.44.1398524827558;
	Sat, 26 Apr 2014 08:07:07 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
	[89.253.118.72])
	by mx.google.com with ESMTPSA id j2sm4045076lag.12.2014.04.26.08.07.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 26 Apr 2014 08:07:06 -0700 (PDT)
Sender: Jacob Kroon <jacob.kroon@gmail.com>
From: Jacob Kroon <jacob.kroon@mikrodidakt.se>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 26 Apr 2014 17:05:30 +0200
Message-Id: <1398524730-16722-1-git-send-email-jacob.kroon@mikrodidakt.se>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH] bitbake-diffsigs: Fix runtime error when no arguments are given
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
X-List-Received-Date: Sat, 26 Apr 2014 15:07:08 -0000

If bitbake-diffsigs is run without arguments it will error:

    Traceback (most recent call last):
      File "./bin/bitbake-diffsigs", line 121, in <module>
        if output:
    NameError: name 'output' is not defined

Fix this by moving the check for output into the inner else-clause.

Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
---
 bin/bitbake-diffsigs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 78757b0..08ae00d 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -118,5 +118,5 @@ else:
             logger.error('Invalid signature data - ensure you are specifying sigdata/siginfo files')
             sys.exit(1)
 
-    if output:
-        print '\n'.join(output)
+        if output:
+            print '\n'.join(output)
-- 
1.9.0


