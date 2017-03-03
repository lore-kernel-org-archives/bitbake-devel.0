Return-Path: <armccurdy@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 7EA2772F3C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Mar 2017 00:24:27 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id 67so3745106pfg.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Mar 2017 16:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=8k96ynedceFf4HGZfuHr9gxAQN9jO70f5WKm1FmkIW0=;
	b=GrMaayGmoaVn1ai4THmmrZXTIElqXKQ8uaDof4O2LZFa1XCrJ85s7wSTjeYF/jL2p8
	TIWkIduqEUGxOWJb7Ndym7P9f+DoUUp/eQdzRazZc+2BYMpTXg9u8alW47jOcp7Yfgih
	2b/18+qUW7iODKGBrIkXgmuUnacLYWuqDAidvjTnP8VuBgHbSre9cxfufoF+CHrxmZ/m
	EdXpJbcrnr9oi47EYjWx3Lgj66p2NXo5UAuLWgcPe/7fWjhinclnqoqHaJgSIQV+8Qg9
	1DnzoR5xMomZuM7tnfDjcD2JiwYM38yBj5UtP5NBTntZz3vgP26g5oq9Dyuk19+dNIzc
	2cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8k96ynedceFf4HGZfuHr9gxAQN9jO70f5WKm1FmkIW0=;
	b=iFAzi/oWGN8S9bhpyw9/EVmNJTKJpsKA0ZMIIYktN+a+qR/0Iletkg4yVnljZ6PnvJ
	D2ZH+Sms70y3J6jN3XioOm/VAjAvzyjb9pQnw5MH5whmfHvfNnMA4nMbgZUIWzPdJO+H
	JYdUwOpRBmxZ/tQnEaoJKoqAPTf/doUsAO5x3ysfywxt8JGHIk6WGGqY9sBGR8sOeCCw
	yChY+Ru/7lvjQyzd2M0i4FDI8fzNu2YpkI8p4omsbUHq/C95XWR1i8SEPhd6qTQMUiEO
	KhC4qxXt7EnTdI4GqFqI/wvAYwER5dLxyv21sPwwPF2rf5gnB6vAKn4CSlTZOYjx8EwJ
	Flag==
X-Gm-Message-State: AMke39l0HPkd1HzMjq5/FJMtXxZjB28V2wS/cr7th/xLFsbEp0to1QflYDilVbl6M2/d5A==
X-Received: by 10.84.133.36 with SMTP id 33mr22401154plf.87.1488500668455;
	Thu, 02 Mar 2017 16:24:28 -0800 (PST)
Received: from e6520.cablelabs.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	g27sm19198233pfk.95.2017.03.02.16.24.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Mar 2017 16:24:27 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Mar 2017 16:24:22 -0800
Message-Id: <1488500662-2237-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2: pass --no-same-owner when extracting tar files compressed with 7-Zip
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
X-List-Received-Date: Fri, 03 Mar 2017 00:24:27 -0000

Treat tar files compressed with 7-Zip in the same way as tar files
compressed with other compression formats.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2f9813e..e635318 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1400,6 +1400,10 @@ class FetchMethod(object):
                 cmd = 'lzip -dc %s | tar x --no-same-owner -f -' % file
             elif file.endswith('.lz'):
                 cmd = 'lzip -dc %s > %s' % (file, efile)
+            elif file.endswith('.tar.7z'):
+                cmd = '7z x -so %s | tar x --no-same-owner -f -' % file
+            elif file.endswith('.7z'):
+                cmd = '7za x -y %s 1>/dev/null' % file
             elif file.endswith('.zip') or file.endswith('.jar'):
                 try:
                     dos = bb.utils.to_boolean(urldata.parm.get('dos'), False)
@@ -1431,10 +1435,6 @@ class FetchMethod(object):
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - could not list contents", urldata.url)
                 cmd = 'ar x %s %s && tar --no-same-owner -xpf %s && rm %s' % (file, datafile, datafile, datafile)
-            elif file.endswith('.tar.7z'):
-                cmd = '7z x -so %s | tar xf - ' % file
-            elif file.endswith('.7z'):
-                cmd = '7za x -y %s 1>/dev/null' % file
 
         # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
         if 'subdir' in urldata.parm:
-- 
1.9.1


