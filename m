Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id 916E47F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:31 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id bd4so19658275plb.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=pYJZrlTM0BAkluFIzDyFJq8aVbNCeqKkRa7nWMZK0No=;
	b=mvoGYBQKc1nI42H27UAQlPqZEePNQWJGRhrw817cc+oxp85JeehY+d/HGuWzLKr9cG
	wUufB40ee2wfZSL9DcOgRO+nnzy7TuYIVHNenP630ZkWxQ4Np3KZo8oRCpE2nieErbT3
	GVOx/WZf0oaL8tzLVTTKL81QHJHVMY+KmF/QVw0eR2hsbWmGcFu1sFqWNnkrpDSDgyG4
	V6+mhTYT8TOjJSgy+Liquesdh68VSOwIffl2tIJKbNbR2wsfMLDxWPZz4ruwSVJADFMH
	hAjiAyy2ImnsABnKCcrTQNNQo+yw7vZ4nIOCNVqXHBFS55zPsXGeaVHF3xR4RFsZogtP
	rkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=pYJZrlTM0BAkluFIzDyFJq8aVbNCeqKkRa7nWMZK0No=;
	b=V0S9TR9E6xtIMvFMfgz3T9gIb8B+0Mmq9fWdu2fxHDZadaslgNrjJ75R4a6oTwK2lc
	BspiMa3A59+NUwsAVWZzOLj1iBAOPSCs+7rUm+Gz4RmqGH3nBtCaocEi3WERbIm7kFg5
	wVvNZKXmcMnNsKYHclagtalAbOYVcxW5Nd2GbzlC2zORjSXKZMxGGFGp92dgPurgq6sG
	xmtLJ5xTmP4jyevG8c7LjhMquxfEd5P04U8hDBHVtkQdjOFl/OgrnVfWJOOU3tUpXhgN
	Gl8BrBspGNh8oIdN9LEmvFMXi4Jo2C9zeq+SzjveU+Bw0nWjAGPH6Ta55xXqYkump2id
	wtUQ==
X-Gm-Message-State: APjAAAWu8eu8EpV0A7qnWc3IXa46iYTM0xY9GYLSrmwtkC3/GPzQlbYK
	qaeDfvTVZoVEIPdULoHg65e2fTYhJ0M=
X-Google-Smtp-Source: APXvYqxxz9EUCKwHVYuki3Xp/6PM2A8h3vPcwfLlN6vGspc2i9X/qtkZ/y8Qan/vWCKDAyBAnUkFUg==
X-Received: by 2002:a17:90a:3a86:: with SMTP id
	b6mr30192868pjc.96.1578104612404; 
	Fri, 03 Jan 2020 18:23:32 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:32 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:05 -0800
Message-Id: <e731f72ca86629eb935bb1c4f7323421a125aace.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 20/25] prserv/serv: Use with while reading pidfile
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:31 -0000

From: Ola x Nilsson <ola.x.nilsson@axis.com>

Signed-off-by: Ola x Nilsson <olani@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6fa8a18ea4994031fdd1253fe363c5d8eeeba456)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/prserv/serv.py | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 6d8142fc..446e1fe1 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -292,10 +292,9 @@ class PRServer(SimpleXMLRPCServer):
         logger.addHandler(streamhandler)
 
         # write pidfile
-        pid = str(os.getpid()) 
-        pf = open(self.pidfile, 'w')
-        pf.write("%s\n" % pid)
-        pf.close()
+        pid = str(os.getpid())
+        with open(self.pidfile, 'w') as pf:
+            pf.write("%s\n" % pid)
 
         self.work_forever()
         self.delpid()
@@ -353,9 +352,8 @@ def start_daemon(dbfile, host, port, logfile):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
-        pf = open(pidfile,'r')
-        pid = int(pf.readline().strip())
-        pf.close()
+        with open(pidfile) as pf:
+            pid = int(pf.readline().strip())
     except IOError:
         pid = None
 
-- 
2.17.1


