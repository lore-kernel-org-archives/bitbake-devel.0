Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
	[209.85.216.46])
	by mail.openembedded.org (Postfix) with ESMTP id 6368C7FDFB
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:09 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id j11so7765627pjs.1
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=pYJZrlTM0BAkluFIzDyFJq8aVbNCeqKkRa7nWMZK0No=;
	b=Bw6J7Oi1e50957rBcg2Vb0HcgrFRlkT9YTBKCn/c6FGB7dimVoVPUEqOWshlhnWXOD
	h+7pjfltcH40XbUuG4CSWhCO0Rljli1xDZjLaG3DmLCE5shajYkGv2ytyBQvR8RFrbTP
	95fAMhrDQ87XVn3GxzKyhYkg3/riGBFF+uL5zW2nBg/dIebvcMkEVOXxIhhFnr7sy/hX
	t1OCI3L2PX82L/44nqJhBeYE2DIZivUytQwX8yRwjRsYrvc5XKZT3/D4GIr6OkNTVCi1
	wK+5KUre6Zj+kZIcNBk6W3ehSXKjNPU4U+8+oPOnfPHv0MlaYfRS72OspfPMigHe5lx0
	ws0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=pYJZrlTM0BAkluFIzDyFJq8aVbNCeqKkRa7nWMZK0No=;
	b=TCrCRZEEsZrPtm4PLSdVfvvTHEBtmoWs12p1qa2LuDY0g0xSPSKR8Npuh2zHhPGMLJ
	KQCdZuCNnq1vVao4la5fBD3PybEfSh6tYkeRjel3sfp8eNL5HJyq+jIB24RweRhZeDHZ
	SkYHq1a4SJ+6B7+sNckefhMxzI6SlBnoYCjoIwbwfk+h0C/47FNtn43yZ4HP+oginc0O
	QI50Q+ZcbnJrVhQDBYU6Fxh3hYcWlSm8psVgALed8sjcCxuXGL54qoyHapsbR9FVkwaQ
	31r7D0k3I0UmxmyZyuhImwWBSpzlmI/EclOJwNvuyMyoRQHmBPgUP68t2DHW70uVqrpv
	WYJg==
X-Gm-Message-State: APjAAAVBUA90Za3JiZS4lzeb0CCncf9izJbmO+wjkLUfbMW/0z/Ujd8N
	KexziMC2mwjTKhAXhytjy54nhT2m
X-Google-Smtp-Source: APXvYqwWp51dFz3ltp2VehzO1r5KNjg+g1XIZ3uun8nkEnc0cm0XVK8uM76QaniY+RDT3QhNB+A2yg==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id
	o14mr44867246pjq.11.1578328030333; 
	Mon, 06 Jan 2020 08:27:10 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.09
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:09 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:41 -0800
Message-Id: <e731f72ca86629eb935bb1c4f7323421a125aace.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 20/25] prserv/serv: Use with while reading pidfile
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:09 -0000

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


