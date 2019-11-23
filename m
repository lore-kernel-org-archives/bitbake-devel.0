Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id 08C2E7BE3C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:03 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id bb5so4558070plb.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AMe2ALnYR/4ZlgWKRb1LlbuFnw/nV/ePL/gOP1er8vI=;
	b=NhL0R0pl/o8n1yBIYCr6tYbz5TY+mfP7qKTwjV7AOrV76HWJuby7/+kxonzSJacosm
	mn0Y6yg8hcz64Y/XGkkcw/rr7+Hs2eBp5LSSCuYJ+FplHHruhpT1iXBipEDqozZUSlFF
	CDV84FUi6Nyh8BUYUk5aBKd3yhDmk49oV8IEATlfI7KA5GsIpkhtHpO/iaJSYmjeTgUE
	AkjSNPAC0bngsHYFISgYylZbizLo6n3ZRE7HQ8/ojfXC6J9pXoRiXlOBgl3/XDuaY4zx
	Q/lVcflPyguAeS+APgyeQiBJuS6CgKFT8MGcaOS+JzeRBdfAjOzHUqwJhFmZanATTYiq
	7rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AMe2ALnYR/4ZlgWKRb1LlbuFnw/nV/ePL/gOP1er8vI=;
	b=EjrPkcYdoMxhuHzHZj/HvF4NM61FvxY1xqbau6KunY4BuV11tvtbrEtZeMvZeTtFrn
	U6PzoUqNBp9xYHEGKCv/4TIFb2KcMcuHo58R9abChDaiIXKr668VbW+BpSTXk7TA/p0N
	HrYfT65hKFrqvqRiF49EBYbAoc2yOOIEbQIlKHxPJ5juwewRdzz3fj9QWcY6LWugoYVa
	8nxnk0u9sZHLOfng2LCvFYQoJELODuAu/DmQig6mcY/MX7uitFW71CJpLWdzc5L5xKB8
	EZMcr+HLXfKel0mscumeMdvbNU7nHlulcsFH9aagDHs+8fdxnVakLTStCV9bunVrv8sT
	VBMA==
X-Gm-Message-State: APjAAAW1iYMgAfl1MoBDcfhWJn4b2BItphGz9H1BcUdQ/H5WbvAmzePu
	IW/aPjJ3YKc5YkvQs3FenAw/NIM8
X-Google-Smtp-Source: APXvYqyj8vQShgn4Wyyn2Kk+504ck9Nt/qk+M0AQLtlqzD8Tl+cz2tbCOJ6eh3GB9C/A2o1qH6VTNA==
X-Received: by 2002:a17:902:24b:: with SMTP id
	69mr19317159plc.203.1574526304851; 
	Sat, 23 Nov 2019 08:25:04 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:04 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:54 -0800
Message-Id: <1574526299-21018-4-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Cc: Gavin Li <gavin@matician.com>
Subject: [1.44][PATCH 4/9] prserv: fix ResourceWarning due to unclosed socket
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:04 -0000

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


