Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id BA4527F898
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:29 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id 4so24278370pfz.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=aYPGjXLf6XivrgBH5cjcAjQXglcJR21U0Vx1oKVXJ2I=;
	b=KqtCC5pDIyUex71MPYyH3o69gpJ6251MgEv7WAVesb/7I8wcysqfTUtiVHvuydCe8B
	/0LMEuD49uwFBC8nr0eoo4bgNXufLIxEJ/aeYeDcXbyyRoyyrgw+XwT3Qq6er8/juJFt
	fl56e2psAXvlkDMgese6x6KsWXmziJBfERzXzIq/Zk6+dRwyfZlGzgVPaivXqG21lVzZ
	4nH3QE8sBPculHMKkHv/d7F3NxsLlEsB6wIqEmUm8oec4f4cESyZkOyrus5U83LYfG8D
	5/SgUuHbeCl8w204duSWVphnsJUM7VFjCqgPgmwU3zR+HIrXeNPRJ47PSaLln8+HWhqo
	zq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=aYPGjXLf6XivrgBH5cjcAjQXglcJR21U0Vx1oKVXJ2I=;
	b=tuTWngJOnxlMp9hA5GnlM6QHewlW5QmdSa62zNRrFvtLXdixImnp/2h6QwkzbEiJ1r
	t31IBRosxncojvjj4mgOdjOSPUIsEkMH6Lw6+0DI+PITl6MM2gHYI8F0XAtQA3bqThd8
	sVfkOeYxBXzzT4vRXyP0cZoTUAMVyCFHLxnq5wmSTg4SggiFWw0lN3YqQiePM8iBaR84
	CL4qZYSxcAUZ8bsi4gP4m316bH1SFaZEJKSIsRoJz3zH4Mp5BDmRKmn/R5OLyItyBcD0
	mtwTj2upCrjbbBRO7kfX56zKfWs4qdXzNiwOl5gYCEvGU+5vosHiIc+zyN0zRW8CNQD9
	IbZA==
X-Gm-Message-State: APjAAAXAQr/oSObkzivjMiQKLUVgZK9sn65bWdv3k2CUU8yJN4LHM3N/
	XMw65p5bSsa/P80ceukChsSXh1vkrJ0=
X-Google-Smtp-Source: APXvYqw8pE5nG72MRS4VABRSd5sUMAPLXM4ZG4u7Kv5wR8ALBC5Cu0BfhdwYBQs0N7YFBPU9Sjs6iQ==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr103180452pgi.220.1578104610667;
	Fri, 03 Jan 2020 18:23:30 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:30 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:03 -0800
Message-Id: <f224201b5003b89367d688b1f08a062754fce13a.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 18/25] lib/bb: Optimise out debug messages from cooker
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:29 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have bb.debug(2, xxx) messages in cooker which are useful for debugging
but have really bad effects on performance, 640,000 calls on recent profile
graphs taking tens of seconds.

Rather than commenting out debug which can be useful for debugging, don't
create events for debug log messages from cooker which would never be seen.
We already stop the messages hitting the IPC but this avoids the overhead
of creating the log messages too, which has been shown to be signficiant
on the profiles. This allows the code to perform whilst allowing debug
messages to be availble when wanted/enabled.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f04cd931091fb0508badf3e002d70a6952700495)
---
 lib/bb/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index c144311b..ce519ba3 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -43,6 +43,11 @@ class BBLogger(Logger):
         Logger.__init__(self, name)
 
     def bbdebug(self, level, msg, *args, **kwargs):
+        if not bb.event.worker_pid:
+            if self.name in bb.msg.loggerDefaultDomains and level > (bb.msg.loggerDefaultDomains[self.name]):
+                return
+            if level > (bb.msg.loggerDefaultDebugLevel):
+                return
         return self.log(logging.DEBUG - level + 1, msg, *args, **kwargs)
 
     def plain(self, msg, *args, **kwargs):
-- 
2.17.1


