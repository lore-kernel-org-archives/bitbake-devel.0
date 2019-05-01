Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id ABCF57D9AE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 11:19:00 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id n25so6710909wmk.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=12EZxVSbHyW2U0gQ/Iu0aUTQ+Txv3bpj8fhJNycB7kw=;
	b=W3BeU3Y3WXYfOV4OzFf26G5X4Gdsg+7dMjkYmbFAzAC94xkB6j2J1ZtfMdNzyPMU+4
	R7jtwvdvQVSE7+HpBbjLiamdU+Ix2bHxrlHtZOrYn2SV5SZXRinzUcIub1KgTTDr67YP
	HCsGpH3CelaK8As9Neldy9BukrT0G3r4e4Wv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=12EZxVSbHyW2U0gQ/Iu0aUTQ+Txv3bpj8fhJNycB7kw=;
	b=Tq+cieomP6G/YjoIbVizZpudjre1BlhMMO3pezAZH7BstAqQwKQMsIYgxsf0O6ofLd
	DI9Qg8LrUC4f4q+EZWkKZ0KmOhaYfz9JbOspJz+nGEMJqZLXygmC41YQpZ/JJimP0kOt
	ohXebd68k3LpI/fzX5b5QciWD94fWx6eP6iNCGB0pUeId57MdvD7Un+OfIngq1te3e5C
	r68Fic2VfaY/w0ybHUndRhxG1vkSGQSjn58aZLgvfnaGuBnPMPEV3aF7HM3nD+La6yLY
	VpkWq07SwefmtoFu4+zzHoXJMKxFUt1JguiDxQBQSnvg6uiSg4IKO/S+acGC7Q8akso5
	JIQA==
X-Gm-Message-State: APjAAAVmSnCM3W7mgmfJ7vs9HOQsIJj5ypHbO/5bdx5UzpNvGqu0CnnW
	uLn02+TXrnovcAaOK8GEU/zhmPPbDLo=
X-Google-Smtp-Source: APXvYqzKgRozfJUOVhkczmlSGphNasIG1m3zBubIyXmsbmRH9VcIZRZh3jBqQotoedJ/pugAWxF6cw==
X-Received: by 2002:a1c:c142:: with SMTP id r63mr6663577wmf.97.1556709541038; 
	Wed, 01 May 2019 04:19:01 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j10sm3494597wrb.0.2019.05.01.04.18.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 04:19:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 12:18:54 +0100
Message-Id: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/6] knotty: Implement console 'keepalive' output
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
X-List-Received-Date: Wed, 01 May 2019 11:19:01 -0000
Content-Transfer-Encoding: 8bit

CI systems like jenkins and buildbot will timeout applications which haven't had console output
in some period of time. Add 'keepalive' output to knotty which gives output every 5000s if not
other output was made and tasks are still running. This reduces some problems encountered
with our CI testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f362c23afc..4567c148c8 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -234,6 +234,11 @@ class TerminalFilter(object):
         else:
             return "%ds" % (sec)
 
+    def keepAlive(self, t):
+        if not self.cuu:
+            print("Bitbake still alive (%ds)" % t)
+            sys.stdout.flush()
+
     def updateFooter(self):
         if not self.cuu:
             return
@@ -467,11 +472,17 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     warnings = 0
     taskfailures = []
 
+    printinterval = 5000
+    lastprint = time.time()
+
     termfilter = tf(main, helper, console, errconsole, format, params.options.quiet)
     atexit.register(termfilter.finish)
 
     while True:
         try:
+            if (lastprint + printinterval) <= time.time():
+                termfilter.keepAlive(printinterval)
+                printinterval += 5000
             event = eventHandler.waitEvent(0)
             if event is None:
                 if main.shutdown > 1:
@@ -500,6 +511,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, logging.LogRecord):
+                lastprint = time.time()
+                printinterval = 5000
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
                     return_value = 1
-- 
2.20.1


