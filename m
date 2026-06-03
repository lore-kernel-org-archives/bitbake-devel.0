Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34702CD6E6A
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:50 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17037.1780483727076549145
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G9Yisgda;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so4020884f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483725; x=1781088525; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X7/VkxGpLygk3H4QJQED5d/yOCUnPfDRoRBAsQwOQY=;
        b=G9YisgdaesHaGMvrBrIMtJ+QSnrPoQeaFiSjOKRL4hr335bNUf16K9kFzRbNdzh7GP
         Nz0EamLgpnzTiv1fHC1PGz8c0f2WKTan2nadCOuXPsOoHhXhCN9WWy82h0zoWXBqREu+
         MEgFC5JqQetznjhwOZ0sNsKp1K8rYfvR+Sk7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483725; x=1781088525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9X7/VkxGpLygk3H4QJQED5d/yOCUnPfDRoRBAsQwOQY=;
        b=VR1iqwcglVnnADIDu7WLTG6yanY4pgZ5JTc7AoQnrEFhvSXZyArwLGSmFb6so8/u7n
         m9bKq3XItE83n8OFHQThDmWW9q6syerHKZ1GmV+QxzrCy/5EhQjPxFNS6J9Hv3BsuvmB
         78wCsSorN3lpbw0UMfI722hzLFHMONMnZY9PUr/My4jPKL0z1zjFkcg1q1OWaZlkso0a
         kr7M7xH7I974D146qJgRb/6T95XHh/ysyoCk88gFJ74FwbPuLs/K1YWdpi4b6lotMnd5
         pcPG99nneRB3UiNRdziYqDSnCSni0fCxjWEdvqQesS6HplBBNrqPyGKmktmnVd8fwFOH
         NiWg==
X-Gm-Message-State: AOJu0Yx06n8ls04LXrlEYgdqdzmTWf+V5UdFHl5he2AxsP5NLW0s2XXA
	z5XYPxmreuP4kluVRbqEnGJpFGynimpDF+gS4e/rN511ZQOWx1VnkhsAplS08O2M/XrZ2oLP/uB
	tzVPp
X-Gm-Gg: Acq92OFSP/DaBFmyQ93cZYWBdRNViRK0Xr9w2HfMAGTOgUmmykNZ/jdGGeyWS/cu2pR
	kwmqka9YP+kZ28j/YnvklXmANSpYkIXx5dUbFOeUA8QEY0IXJWNUIpG4hg+zFBHIdwW0BXQSsw/
	fmeRn4WWRkPWRSGkbio7zzj6YlTrTrFiOQ9GkFaZBLuxq0qaDiLdHzEx2Ms0Kq+m0GSDen3bgDq
	FmFGYDbxZnTa6uFKpfwM69MBq5dqTGbSPSN+MwkZvJCVf30qQaF19eQQEVKSiFNSwUEHVo4gtc/
	nTQ9eaNpHSjrrowGpVj0ovAi43ffMMloD7tHHjDZhlRqTDnN8NMa/ZjUX3GadAEA25KveHvztlV
	b+m5yk/Qbe4JVmocKcwF+UM+b7GTpYSVni5jePG0PXLY9NoPtSAi5/yNhQJPD8iA4JMxsBHYhPJ
	//M4Ay1WyPKTuPy0TYEcGB1bDbMXpWBxSfn8qFM3Byorl3CAhcKCtY6Rl0UulX8ftUsYG4MbYR
X-Received: by 2002:a5d:64c9:0:b0:45e:ea2a:dd79 with SMTP id ffacd0b85a97d-460218aaec9mr4106046f8f.4.1780483725378;
        Wed, 03 Jun 2026 03:48:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/8] fetch/{sftp,ssh}: Convert to use lists of command arguments
Date: Wed,  3 Jun 2026 11:48:36 +0100
Message-ID: <20260603104840.815399-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19597

To follow best practises and avoid shell=True subprocess usage, convert
the fetcher commands to use lists instead of strings. This improves variable
quoting and models modern coding standards.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/sftp.py |  8 ++++----
 lib/bb/fetch2/ssh.py  | 28 ++++++++--------------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index bee71a0d0d0..021a092f1f3 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -48,6 +48,7 @@ SRC_URI = "sftp://user@host.example.com/dir/path.file.txt"
 
 import os
 import bb
+import shlex
 import urllib.request, urllib.parse, urllib.error
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
@@ -83,10 +84,9 @@ class SFTP(FetchMethod):
         """Fetch urls"""
 
         urlo = URI(ud.url)
-        basecmd = 'sftp -oBatchMode=yes'
-        port = ''
+        basecmd = ['sftp', '-oBatchMode=yes']
         if urlo.port:
-            port = '-P %d' % urlo.port
+            basecmd += ['-P', urlo.port]
             urlo.port = None
 
         dldir = d.getVar('DL_DIR')
@@ -105,7 +105,7 @@ class SFTP(FetchMethod):
 
         remote = '"%s%s:%s"' % (user, urlo.hostname, path)
 
-        cmd = '%s %s %s %s' % (basecmd, port, remote, lpath)
+        cmd = basecmd + [remote, lpath]
 
         bb.fetch2.check_network_access(d, cmd, ud.url)
         runfetchcmd(cmd, d)
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 2a0f2cb44b4..56e455fb47f 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -85,18 +85,16 @@ class SSH(FetchMethod):
         user = m.group('user')
         password = m.group('pass')
 
+        portarg = []
         if port:
-            portarg = '-P %s' % port
-        else:
-            portarg = ''
+            portarg = ['-P', port]
 
+        fr = host
         if user:
             fr = user
             if password:
                 fr += ':%s' % password
             fr += '@%s' % host
-        else:
-            fr = host
 
         if path[0] != '~':
             path = '/%s' % path
@@ -104,11 +102,7 @@ class SSH(FetchMethod):
 
         fr += ':%s' % path
 
-        cmd = 'scp -B -r %s %s %s/' % (
-            portarg,
-            fr,
-            dldir
-        )
+        cmd = ['scp', '-B', '-r'] + portarg + [fr, dldir + "/"]
 
         check_network_access(d, cmd, urldata.url)
 
@@ -125,28 +119,22 @@ class SSH(FetchMethod):
         user = m.group('user')
         password = m.group('pass')
 
+        portarg = []
         if port:
-            portarg = '-P %s' % port
-        else:
-            portarg = ''
+            portarg = ['-P', port]
 
+        fr = host
         if user:
             fr = user
             if password:
                 fr += ':%s' % password
             fr += '@%s' % host
-        else:
-            fr = host
 
         if path[0] != '~':
             path = '/%s' % path
         path = urllib.parse.unquote(path)
 
-        cmd = 'ssh -o BatchMode=true %s %s [ -f %s ]' % (
-            portarg,
-            fr,
-            path
-        )
+        cmd = ['ssh', '-o', 'BatchMode=true'] + portarg + [fr, '[', '-f', path, ']']
 
         check_network_access(d, cmd, urldata.url)
         runfetchcmd(cmd, d)

