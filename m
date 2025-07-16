Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B72C83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 15:23:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.25146.1752679377200204447
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 08:22:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U9gSsznc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d6ade159so49588225e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752679375; x=1753284175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVQLt1CUON5KJWr6SzIIaRU2HUAEfuMIimTjk6DBmMI=;
        b=U9gSszncQnR8A3XYkHDbeoCFfUrQ386YT9feWQqEhGaoxzIJdpcsGepn8OKo5Tp4KI
         gVcCnINijtak14WSr+xreS0Xwxj2Hd1K0Vog2lv8A9ewkUvh1RJDHgqfGNPBFOUza1qb
         /ZxOGQ1uNUigvrNImPgqXOGQP5n8l9PjRM6vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679375; x=1753284175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVQLt1CUON5KJWr6SzIIaRU2HUAEfuMIimTjk6DBmMI=;
        b=E6mV0xOU6qxgib1iFnwFtjrT0L9fIS6y6qX86LjBU0NVSUKj1gdoyyVnIaBlsb489+
         zxxzS+FTCcNPRvfCUutYlmb0TuDCZB8l3EaSK/F1AGU3DeCpw0esPjjusX3plPCaBf9R
         RFNZdWNUIoIUV7JGb6BK65a7B1wVKu6CA4CryZYy6MfxsYlQPMDZASzMGIQ2YlIC/59L
         WYmoRozOY/mEXB6tuTzih+5tBfm+frySWzcCjgJ/Noz4zgRk/Je7w0NyApPGFhjhxJTZ
         rDSMjdsryzKM9HwIMWjTMGZHXl5iGyN7GrxjOxO/tZ5BxG+YhIdXK8co6SNHjc3astXf
         9Ipw==
X-Gm-Message-State: AOJu0YxBlu1ZiMW6MWMhVuU97kQAuDP+jrZZmCIQnXo+uTaN4ZnSKfkg
	Isp/7N1uP15AtQWl52EGh5+9yjpNohnwKnJ8vjxm5iQ622k7y37mvBKveE3wVnWAx+DV73CywHB
	ZNrvg
X-Gm-Gg: ASbGncubiLMw0CxHbRD8Wbr6xa6kMgbML6p/ls99Ap0OQCGnGtXBHKgorgheh10EXmD
	cmcl3XIcUJ09OAhY+pFLsQGYUkF03aRXUy/h2P1ziPIlP9f8PPNMP8ryLboNAOHk7tzoEcE/Amf
	GvHh6obzbHKMrZVsZHCXVy+iRTh5Y29OYWuCZUk4nUKw7JqRsSSJTg2c8+3wSDRfXVck41/iWk5
	wePr0fta8xlBBWYUom43p1joVPzmjlVPgLycEWvCY7CJnPYieKZAuvxKFcyL0Gs4pHTTfk93Ejy
	cxud0xr3/f/Jlznp4V/YPKWjPPKJYGX31cJZBEn5WThdpViexIckLYKkwKBpJu6pCjQ7m3piMPQ
	Y9gTB8sNqqg0C10zBUBpMsDT8xjMetq6koqam/Yf2Ox3KvJTreBY=
X-Google-Smtp-Source: AGHT+IEiGgNNKh7h0wg+9BDGZirJhZR56VI9DGnqYOpqQ7lynJonf4IMqBgaLQZ9Vv+jcQFsTlw4lQ==
X-Received: by 2002:a05:6000:26d3:b0:3a4:febd:39f2 with SMTP id ffacd0b85a97d-3b60e523ce1mr2510006f8f.37.1752679374978;
        Wed, 16 Jul 2025 08:22:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:22ad:92e1:8848:8bb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm18362725f8f.60.2025.07.16.08.22.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] main: Add an option to specify what to profile
Date: Wed, 16 Jul 2025 16:22:49 +0100
Message-ID: <20250716152249.96126-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
References: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 15:23:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17782

Starting with python 3.12, profiling now stays enabled over threads yet
you can't extract the profile data in the threads themselves, which makes it
difficult to use for our use case.

Our main loop starts the idle loop which starts the parsing threads and this
means we can't profile in the main loop and the parsing threads or the idle
loop at the same time due to this.

Add options to the commandline so you can specify which piece of bitbake
you want to enable profiling for. This allows some profiling with python 3.12
onwards rather than crashing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-server       | 2 +-
 lib/bb/cooker.py         | 2 +-
 lib/bb/main.py           | 6 ++++--
 lib/bb/server/process.py | 6 +++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-server b/bin/bitbake-server
index a559109e3f5..7a13de60de6 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -30,7 +30,7 @@ logfile = sys.argv[4]
 lockname = sys.argv[5]
 sockname = sys.argv[6]
 timeout = float(sys.argv[7])
-profile = bool(int(sys.argv[8]))
+profile = list(sys.argv[8])
 xmlrpcinterface = (sys.argv[9], int(sys.argv[10]))
 if xmlrpcinterface[0] == "None":
     xmlrpcinterface = (None, xmlrpcinterface[1])
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 74b2d075d00..260cba1e212 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2027,7 +2027,7 @@ class Parser(multiprocessing.Process):
             self.exit = True
 
     def run(self):
-        bb.utils.profle_function(self.profile, self.realrun, "profile-parse-%s.log" % multiprocessing.current_process().name, process=False)
+        bb.utils.profle_function("parsing" in self.profile, self.realrun, "profile-parse-%s.log" % multiprocessing.current_process().name, process=False)
 
     def realrun(self):
         # Signal handling here is hard. We must not terminate any process or thread holding the write
diff --git a/lib/bb/main.py b/lib/bb/main.py
index bca8ebfa090..597cb278464 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -208,8 +208,10 @@ def create_bitbake_parser():
                              "failed and anything depending on it cannot be built, as much as "
                              "possible will be built before stopping.")
 
-    exec_group.add_argument("-P", "--profile", action="store_true",
-                        help="Profile the command and save reports.")
+    exec_group.add_argument("-P", "--profile", action="append",
+                        default=[],
+                        help="Profile the command and save reports. Specify 'main', 'idle' or 'parsing' "
+                             "to indicate which bitbake code to profile.")
 
     exec_group.add_argument("-S", "--dump-signatures", action="append",
                         default=[], metavar="SIGNATURE_HANDLER",
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 78d0a606e23..da3f833f1d5 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -140,7 +140,7 @@ class ProcessServer():
             serverlog("Error writing to lock file: %s" % str(e))
             pass
 
-        return bb.utils.profle_function(self.cooker.configuration.profile, self.main, "profile.log")
+        return bb.utils.profle_function("main" in self.cooker.configuration.profile, self.main, "profile.log")
 
     def _idle_check(self):
         return len(self._idlefuns) == 0 and self.cooker.command.currentAsyncCommand is None
@@ -401,7 +401,7 @@ class ProcessServer():
                 serverlog("".join(msg))
 
     def idle_thread(self):
-        bb.utils.profle_function(self.cooker.configuration.profile, self.idle_thread_internal, "profile-idleloop.log")
+        bb.utils.profle_function("idle" in self.cooker.configuration.profile, self.idle_thread_internal, "profile-idleloop.log")
 
     def idle_thread_internal(self):
         def remove_idle_func(function):
@@ -603,7 +603,7 @@ class BitBakeServer(object):
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
         serverscript = os.path.realpath(os.path.dirname(__file__) + "/../../../bin/bitbake-server")
-        os.execl(sys.executable, sys.executable, serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), str(int(self.profile)), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
+        os.execl(sys.executable, sys.executable, serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), str(list(self.profile)), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
 
 def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface, profile):
 

