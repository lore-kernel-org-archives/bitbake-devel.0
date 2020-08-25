Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.775.1598376161118604135
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 10:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D4F2ibdw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id w13so13249159wrk.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBCWhA0Rj0QRJpXN3cO5NugbaYMJfEanCgsCTnyHR/E=;
        b=D4F2ibdwkK9OIr2Up10ml1jKFHdPD9j0jyzcvEzBaPFPv6yU4kkG2SVoyfCvy2fKJX
         8nz/ouc0usrjFoRZmWSRikp2G135ti/0WS0Lw0zfdYKk0VodjOI3a843AYL2mbQXtpOt
         WydqbiU6NYvJH+ntHo9p0Cno7yL8KSxeoMW3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBCWhA0Rj0QRJpXN3cO5NugbaYMJfEanCgsCTnyHR/E=;
        b=V3KZLZnVoJX2Y+jb3qBmaJze35TuQI+OZ8HEn9pFjYzsioxlD6Pw//dai5vQiQDwBJ
         NldiZc6ZioOVSnHR9pl9UJoEs3SOoU3RihaWgdiz+8hCw894Dl6naTNvG23/mLL6zD9q
         XrC738lyNP0VDPtLtJf9flkEpg3mqWNRutzkP4QySUBjv8cQOh7uuRRGY7jHatKJ3Oyh
         7lMQkpDE5wJqQBLuluZyUTjjZNTwQJ4CBE5nWEcyRkK2Nj//3NrmgG3PBUtEO8UdwTQ0
         eadWCkxvzcjNsCNTkcgzx6njI/xFituZ3MzdX5SR1Uo2ieVN9ZT6wSCMLboKwrfILGGA
         bOZA==
X-Gm-Message-State: AOAM532O114qBuiZYItJeHn+CcrQLYB3+69TCD5LcJhhfYi4Pw04RjU1
	1B1krya5OU6u/7NKoxN48iydaGcdRLSz2x+k
X-Google-Smtp-Source: ABdhPJw1cP4Tj7xRQXF+7zOu1j3sv/u6Sck9pkaee2pFxwtkgsFJdKistymneMJfQCI4hh/6RQLVsA==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr3471453wre.99.1598376158917;
        Tue, 25 Aug 2020 10:22:38 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c407:538:d07:8b9d])
        by smtp.gmail.com with ESMTPSA id p14sm35690729wrg.96.2020.08.25.10.22.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:22:38 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Use sys.executable for bitbake-server
Date: Tue, 25 Aug 2020 18:22:37 +0100
Message-Id: <20200825172237.1435589-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using sys.executable ensures we're using the same python binary for the server
as the client, which is probably advisable. "bitbake-server" is left as the process
name as its more distinctive in process listings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 74cdd3f3ea..6d936ed457 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -470,7 +470,7 @@ class BitBakeServer(object):
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
         serverscript = os.path.realpath(os.path.dirname(__file__) + "/../../../bin/bitbake-server")
-        os.execl(serverscript, serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
+        os.execl(sys.executable, "bitbake-server", serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
 
 def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface):
 
-- 
2.25.1

