Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 7D3A57EB91
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jul 2019 11:05:39 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id n4so17323028wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jul 2019 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=4XlXuvp/4ur1HPkFJ8HoHOmSCG1lzF794NFbrAcn560=;
	b=KWiunZMgNGORjOw/gIfZ9he7bzXSL4bfkOIEJm0fYwZVmKEMVC0YFb3CRLKCzwSI0Y
	F4zBU1vsS1spna91WPpGnyH+H7V3KmOE027jbYgKUjFi1qdDmOem8qK/Zts74BGv8Fez
	ny1gSpK9LAXa3McpQK1IUQ6A0fR0DfDZXeUBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4XlXuvp/4ur1HPkFJ8HoHOmSCG1lzF794NFbrAcn560=;
	b=ZKQ2dnKktJkhxoOCNGeiCAkcv/9zN628fc1OEXhMG3nNZP+oFU2z7uymrHc3NSIUhB
	iJ69qreLhUB4Oz6ef+6jMYWZXkZ4gaUEjLFm2zCEcsOefv9PUouVoEjKA7KzqGJcGnml
	3MDIbUm1A4VAzGouJf3qLfnZO7WZtNkyRU4hSaJm8vkaKV9/bph8HohP42NbEKvZkszE
	KmX3M03zcHSrqOO3Xw/OSPJgfJuMFSgjajRK5aHkX6CInzN9MEWEidv0tFaYfTiKyO4/
	D5IXevyiCnvW896UQIGzZde95gBznw04f3k6FtRcXiB0Wa+D85puHKEcg4R78ZmxKjyI
	G05g==
X-Gm-Message-State: APjAAAWbRF65J1hGDgCnuH5N2FpdyeGuH+4iQfRaLtuCiKu5YBMqDnfj
	Lvr8BTItUHlufJISsG5j1Fr2cjgeyfg=
X-Google-Smtp-Source: APXvYqz+dHq58611EwupYCGuKHl054/1RkXaMKJdJoPtiRqxbrybK0FcBNHHJ5WZN4lYGzXnHaS7Hw==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr24748429wrn.216.1562065540076; 
	Tue, 02 Jul 2019 04:05:40 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm2801068wrw.23.2019.07.02.04.05.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 02 Jul 2019 04:05:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Jul 2019 12:05:36 +0100
Message-Id: <20190702110537.13349-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702110537.13349-1-richard.purdie@linuxfoundation.org>
References: <20190702110537.13349-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/3] main: Ensure log messages are printed when no UI starts
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
X-List-Received-Date: Tue, 02 Jul 2019 11:05:39 -0000
Content-Transfer-Encoding: 8bit

If the UI hasn't started, no messages are printed to the console
until the server starts. This is confusing, particularly if the server
never starts. Flush the UI queue through the simply handler upon connection
retry so the user sees the messages they're supposed to be seeing.

Also point the user at the logfile for hints about why this may be.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index bd11619966..a1226886c0 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -468,7 +468,8 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                 else:
                     logger.info("Retrying server connection (#%d)... (%s)" % (tryno, traceback.format_exc()))
             if not retries:
-                bb.fatal("Unable to connect to bitbake server, or start one")
+                bb.fatal("Unable to connect to bitbake server, or start one (server startup failures would be in bitbake-cookerdaemon.log).")
+            bb.event.print_ui_queue()
             if retries < 5:
                 time.sleep(5)
 
-- 
2.20.1


