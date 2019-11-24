Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
	[209.85.210.169])
	by mail.openembedded.org (Postfix) with ESMTP id 9B9FE7FC39
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:29 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id s5so6319715pfh.9
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=AMe2ALnYR/4ZlgWKRb1LlbuFnw/nV/ePL/gOP1er8vI=;
	b=g8934eXdLyzd9kDEs6FJ+sOI01xl7DJW1U//uUORrD0zqFYVGhxgJaYTOvmWKKwW9j
	Jjsmeuk9zBg5iT5TXGfWPyHKbMLl5erzs/066PeZROoeEGL85l0S80l0Xw4/eBsFo7ZM
	6fnlSN5eOmP/8zfyr4j15R2oZNskYAvgSethl0c+U8KUGtoyRZFXcWdYVnfhtwBSxEjG
	72Bklsq5ob4rNEvdVq3YhvCYfHwYRbizY+6e/aqoEXPFbV5L6OY8Swb9Gn8Lsx/ad5yU
	099Gx/R5soQLPek3IzVv+ecpQpv6Iv/s3qIYP5Kdi69kh1h6IUd9VT8ZexDLxEBq7GXj
	uTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=AMe2ALnYR/4ZlgWKRb1LlbuFnw/nV/ePL/gOP1er8vI=;
	b=ajgQS30W5A7LnndTDaVbob/2dTaGjhvPe1egRMQwaYTEHUDy8bJa8cbJgy467rqz9o
	Psob1d44LUMRMX4v2zzL7KWPiYrTpTeeUL/OQf8QA6p71bj6oFbgccBmkjMSkEioPKLs
	wuAbD06UqRQ9VSnIbhb0OMiSLtT071jXzetIUMLbz7RL3BpPRoXaD3YscBUync3TtDzZ
	YYSeg6Ui6AWEysoE+ponA/CebK4SIX8bwakE+IKZEf1kBs85JcfyqaeTbhmG9dvUFm3T
	x9+PCwjDCP3BZK7UOM3uM6viUxvxKBi+0lrVAY5GFDfWXDiQYtV832OOqCPBilp6pf0r
	SyFQ==
X-Gm-Message-State: APjAAAWjXg3xy79vO0j+OxJd/uT0d8Jpc0oFij6ZNPZQuHBtw1Q4eG1Q
	SQUArEEkgf2jl5B45ZR2u5NxdaJD
X-Google-Smtp-Source: APXvYqxri0E49bPVl8OQe7+2CF5c6/QTvaAvPGxGCysg8K34GE7MifJIc9kyJRtrRv64AASvadXVlQ==
X-Received: by 2002:a65:44ca:: with SMTP id g10mr29089151pgs.104.1574639010653;
	Sun, 24 Nov 2019 15:43:30 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:30 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:17 -0800
Message-Id: <cd970c9efa805ec3e7ba952df1701b347441ec7b.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 4/9] prserv: fix ResourceWarning due to unclosed socket
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:29 -0000

From: Gavin Li <gavin@matician.com>

With PRSERV_HOST = "localhost:0", this message would occasionally pop up
during the initial cache read:

WARNING: /home/matic/ambayocto/poky/bitbake/lib/bb/cache.py:446: ResourceWarning: unclosed <socket.socket fd=10, family=AddressFamily.AF_INET, type=SocketKind.SOCK_STREAM, proto=0, laddr=('127.0.0.1', 45655)>
  value = pickled.load()

The file location stated is irrelevant; it just happens to be wherever
CPython decides to run the garbage collector. The issue is that after we
fork off a PRServer, self.socket is also duplicated. The parent side of
it also needs to be closed.

Signed-off-by: Gavin Li <gavin@matician.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/prserv/serv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index be3acec..1d9148b 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -243,6 +243,7 @@ class PRServer(SimpleXMLRPCServer):
         try:
             pid = os.fork()
             if pid > 0:
+                self.socket.close() # avoid ResourceWarning in parent
                 return pid
         except OSError as e:
             raise Exception("%s [%d]" % (e.strerror, e.errno))
-- 
2.7.4


