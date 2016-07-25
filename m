Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3F128606D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jul 2016 22:32:32 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id i5so176267604wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jul 2016 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=q0ihsdGZvnkaATPP4Y5URwCuzLaLBGmbuI6ehyeptJk=;
	b=nB8M9YPfHIDniB4Exjd+kl3yTfsDAw3Qd48T/wnJnF3TM4J6D6x3n452DayYAaus5f
	rXpS9v8hpYvrvb84Y650lE3UaGtjZt9E5p4CS3LoQ9HeDhfSpSHRefWwQ8tXkrOoeusV
	pbpO3o3MQ2WEMQKWwaGbexFlO+vEmH4YZdaZYlcVZrmlKLNuoY2uZeGS+4WiYSHQm5jd
	ORw0epdOpPLneaZUIdMTJxZwRmG4H6/HPeIWpBr1cbV6Fiq7QR1Zc4BN8eKwNKRn/nfM
	3/dvssKk7uYTNlQGnE6NetNJsl/1rDEHd/CC7hVvBqPg0V2ALCwfEj53TeMiZWJPzkhs
	ziJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=q0ihsdGZvnkaATPP4Y5URwCuzLaLBGmbuI6ehyeptJk=;
	b=LtECTjbScFPUnBo6W4GAYgmyUKteKdyphz7y7GqBYGe+fsXRis9VC7PRQgM7ZNVR1I
	O06JnsBPWzNC99CQWuYVCvDzb6bHA/NsPSHISyUvx4QARJp1tUiseN8UR3gUcci8BIds
	TMZwGkHzXvEXL6aea5EXlc2DrBqeUsteyY7Gm0EeR16fIXRuHnRQYav4DqwueFzZQQou
	QGcZupRlR8zQ8ciKfhpQ5Q2A5dIrpk4skRU1mZ8oxE5lpHiDIoe2DjVfxbTUdN6PdMRI
	dtvK7TjSJrFDHnSkBD3RMvQQJRHzTcSyGOWYRCgUyEfwrpJRRNxplLl0AtnScmyXGz/y
	XBHQ==
X-Gm-Message-State: AEkoouvNZ7XIYE09aYxEgpRH7xgjF3FZjTL2FrZCFJqU8eaO1OkIPc6VJMsMBTxRcrahQFKk
X-Received: by 10.194.110.102 with SMTP id hz6mr17375913wjb.5.1469485952709;
	Mon, 25 Jul 2016 15:32:32 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id f4sm29564130wmf.8.2016.07.25.15.32.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 25 Jul 2016 15:32:32 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2016 23:32:26 +0100
Message-Id: <1469485946-6370-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] lib/bb/build: handle incomplete message fragments in log FIFO
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
X-List-Received-Date: Mon, 25 Jul 2016 22:32:33 -0000

It's possible that the logging FIFO doesn't do a complete read (or the sender a
complete write) with the result that an incomplete message is read in bitbake.
This used to result in silently truncated lines but since 42d727 now also
results in a warning as the start of the rest of the message isn't a valid
logging command.

Solve this by storing incoming bytes in a bytearray() across reads, and parsing
complete messages from that.

[ YOCTO #9999 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/build.py | 67 ++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index a4deb00..c632a27 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -385,39 +385,44 @@ exit $ret
         else:
             bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
 
+    fifobuffer = bytearray()
     def readfifo(data):
-        lines = data.split(b'\0')
-        for line in lines:
-            # Just skip empty commands
-            if not line:
-                continue
-            splitval = line.split(b' ', 1)
-            cmd = splitval[0].decode("utf-8")
-            if len(splitval) > 1:
-                value = splitval[1].decode("utf-8")
-            else:
-                value = ''
-            if cmd == 'bbplain':
-                bb.plain(value)
-            elif cmd == 'bbnote':
-                bb.note(value)
-            elif cmd == 'bbwarn':
-                bb.warn(value)
-            elif cmd == 'bberror':
-                bb.error(value)
-            elif cmd == 'bbfatal':
-                # The caller will call exit themselves, so bb.error() is
-                # what we want here rather than bb.fatal()
-                bb.error(value)
-            elif cmd == 'bbfatal_log':
-                bb.error(value, forcelog=True)
-            elif cmd == 'bbdebug':
-                splitval = value.split(' ', 1)
-                level = int(splitval[0])
-                value = splitval[1]
-                bb.debug(level, value)
+        nonlocal fifobuffer
+        fifobuffer.extend(data)
+        while fifobuffer:
+            message, token, nextmsg = fifobuffer.partition(b"\00")
+            if token:
+                splitval = message.split(b' ', 1)
+                cmd = splitval[0].decode("utf-8")
+                if len(splitval) > 1:
+                    value = splitval[1].decode("utf-8")
+                else:
+                    value = ''
+                if cmd == 'bbplain':
+                    bb.plain(value)
+                elif cmd == 'bbnote':
+                    bb.note(value)
+                elif cmd == 'bbwarn':
+                    bb.warn(value)
+                elif cmd == 'bberror':
+                    bb.error(value)
+                elif cmd == 'bbfatal':
+                    # The caller will call exit themselves, so bb.error() is
+                    # what we want here rather than bb.fatal()
+                    bb.error(value)
+                elif cmd == 'bbfatal_log':
+                    bb.error(value, forcelog=True)
+                elif cmd == 'bbdebug':
+                    splitval = value.split(' ', 1)
+                    level = int(splitval[0])
+                    value = splitval[1]
+                    bb.debug(level, value)
+                else:
+                    bb.warn("Unrecognised command '%s' on FIFO" % cmd)
+                fifobuffer = nextmsg
             else:
-                bb.warn("Unrecognised command '%s' on FIFO" % cmd)
+                break
+
     tempdir = d.getVar('T', True)
     fifopath = os.path.join(tempdir, 'fifo.%s' % os.getpid())
     if os.path.exists(fifopath):
-- 
2.8.1


