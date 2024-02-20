Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C2C48BC3
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 09:48:54 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.9927.1708422525037304285
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Feb 2024 01:48:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ia2fIdHy;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ee69976c9so115609266b.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708422523; x=1709027323; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTj4q9gzZvFUJ7RuIRI1DOPBEZrSRWBoiGm+TzJY2d8=;
        b=ia2fIdHyfrn8SJUVPwl1PbQU5uTHdcvNw1feGw0B8YIq6KogbcQBBxQnI0xgle0Jrk
         70UuaNrd8zMRe+OPDMKfqPxF2cBOTglBbK6dFB43s3BB14svYMShwJWs2YJP05TsLelm
         2RB6niJbaaeo+1OBfjSs+5cyd8qx4oDvN9sdkt4RAGjAXbYjgv9fpYl+E0Wat6kpaqm/
         UXF6FOEU5ed4mpLS7c/g0vZYVKn24MvZmAT5iY/+9PZTsrTBE2QG3NLD58EMVCvsbvqs
         UEtNYpY6iRI06RRbozBnfgU6jNjRx7y7HarWaTnxev1206lWrx3F0+jrUe0IQX6cfOgG
         Ctig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422523; x=1709027323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTj4q9gzZvFUJ7RuIRI1DOPBEZrSRWBoiGm+TzJY2d8=;
        b=aFOyyG9SiM+7xsGlW1cpiu47KBu6mJkxoH50thrEyXM1Iwyuwltla7AoS8jAnkTKWO
         92tDH1LFZaszgj7rE/XIL6tYN7q++PZO6Brdrx3mlpGKbHlns8GJeo+B0HQvlhglpb9b
         Pyd+UrTdtAijo1WursIoVfO3tLkI4ow/jpeGD3h61VH/TbPvYRzmD64FdAVK2fTpije/
         e5n7gFvYezoRopn7bCg3YBrCmpmWXQgBqZJpybDM4P2I6WdZewcIJ/B3wsZIaF+HrN8Z
         SruZlCrzp1MocHEkfEUTS8dXJXhpEewbRBQPw/4y5yL4vAxIXG9Ta03bvHlrEuN4HmdV
         xcqw==
X-Gm-Message-State: AOJu0YxL0FFOjGvbmvWXTZQjI9vEIfYHNYtwtO8CbFgDIKiFQaQj7j44
	pzT7IoZbfJ1JsSJkFMEjlvf24fQLo/UtVhKXBOgKhlU5WAIflwFwNzhJnT2P
X-Google-Smtp-Source: AGHT+IFwHz3eVDi2u1INs62+0VuEZ02dknelcmEWP2T1wmw9qyuTgKfEpLvBhq7hsvmDOuroLTjFqw==
X-Received: by 2002:a17:906:a38e:b0:a3e:f9e5:f543 with SMTP id k14-20020a170906a38e00b00a3ef9e5f543mr766423ejz.63.1708422523102;
        Tue, 20 Feb 2024 01:48:43 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a3e45fa1c77sm2956834ejd.55.2024.02.20.01.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:48:42 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] Revert "bitbake: wget.py: always use the custom user agent"
Date: Tue, 20 Feb 2024 10:48:37 +0100
Message-Id: <20240220094837.1150266-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 09:48:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15947

This reverts commit 987ab2a446aab235d6e86e97c05f25fb800d7acc.

There's been a report that this breaks downloads from Jfrog Artifactory
as self.user_agent is set to 'Mozilla Firefox', and when Artifactory
sees that, it sends a response tailored for showing in an interactive browser
(which in my opinion it has every right to).

If we're using wget, we should say so via wget's default; handling uncooperative
servers should be done on per-recipe basis, and ideally with tickets
to admins of those servers.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index bb38dd43582..dc025800e65 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -87,8 +87,7 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
-        self.basecmd = d.getVar("FETCHCMD_wget") \
-            or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --user-agent='%s'" % (self.user_agent)
+        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp"
 
         if not self.check_certs(d):
             self.basecmd += " --no-check-certificate"
@@ -455,7 +454,7 @@ class Wget(FetchMethod):
         f = tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
             fetchcmd = self.basecmd
-            fetchcmd += " -O " + f.name + " '" + uri + "'"
+            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=workdir)
                 fetchresult = f.read()
@@ -493,7 +492,7 @@ class Wget(FetchMethod):
                     valid = 1
                 elif self._vercmp(version, newver) < 0:
                     version = newver
-
+                
         pupver = re.sub('_', '.', version[1])
 
         bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
-- 
2.39.2


