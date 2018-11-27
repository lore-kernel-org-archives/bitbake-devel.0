Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 1DCB46C5BE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 22:14:48 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c14so18679699wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 14:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=8sXZLD0xDtzlzuxfNr19xrFUAh5PMqLA4KJUXuolL5k=;
	b=X+oybOBZHfjML6D4IHO7/rPjwJvzEHY9UJkmT1lQ8oMxHlEGV0HrkKjWjrSUk8M8uJ
	1ZQEeDILQjiY2P9NptrxV5ehxmMP29i4fbmyKjwut+7Hg222XEZeYv2ujWasjh6dmEyu
	YzETCEa0cQakphuXv2iKKb9CKDBr5l6KYUdtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=8sXZLD0xDtzlzuxfNr19xrFUAh5PMqLA4KJUXuolL5k=;
	b=L/bbJ2scQrt+V9lpQ+tvxjI569HPMlkmEB6cPdVpam4pP5oUxF7Gt0jL00jSUJsG4+
	aZXGYfk3otenvXJyoQXv2K9CbC7L/tDGBhnS23t9uyLIi/mLIzyI9TupUlVkD8EUrNoW
	+0JQeHxwTDb4zz8QYb2uByDOjkPT75+4mEmizove4k3ASw71rclewjjGPj8Wf9oJGh1V
	ZzdTpUA0ypTB9Wmx4yEER+MOBkG77XenQlKC0ArIHxd0dQZtpMAVP1uBgeItoXXzIlE+
	nTTRktoU5jdGgI9JN31JR0CGJwx729ExMQ1qum75QPdnqI7V19JiPvWz/50sr1Q6jOnf
	ti7Q==
X-Gm-Message-State: AA+aEWap4/4DpnpgwenQg16M6TFU2K2lEAqYhTRiTNGg6DmRRZifyoCm
	780OBTU7aNFlDSyU/lioNMMMw5aRkaA=
X-Google-Smtp-Source: AFSGD/X5XCKAgNIzMx7x3H3qs8zXZsKd8KQyRpNLcG0xvc4ZlCbNoTSWrhnOtbIDMgMiK90mEK/2WA==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr27979669wrv.147.1543356888533;
	Tue, 27 Nov 2018 14:14:48 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p6sm4160084wrx.50.2018.11.27.14.14.47
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Nov 2018 14:14:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Nov 2018 22:14:45 +0000
Message-Id: <20181127221446.30899-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127221446.30899-1-richard.purdie@linuxfoundation.org>
References: <20181127221446.30899-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/3] server/process: Show the last 60 log lines, not the last 10
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
X-List-Received-Date: Tue, 27 Nov 2018 22:14:48 -0000

10 log lines may not capture any full traceback, increase the number of
lines to 60 which covers most tracebacks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 38a62fa34e..efb4332394 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -428,8 +428,8 @@ class BitBakeServer(object):
                         if len(lastlines) > 60:
                             lastlines = lastlines[-60:]
                 if lines:
-                    if len(lines) > 10:
-                        bb.error("Last 10 lines of server log for this session (%s):\n%s" % (logfile, "".join(lines[-10:])))
+                    if len(lines) > 60:
+                        bb.error("Last 60 lines of server log for this session (%s):\n%s" % (logfile, "".join(lines[-60:])))
                     else:
                         bb.error("Server log for this session (%s):\n%s" % (logfile, "".join(lines)))
                 elif lastlines:
-- 
2.17.1


