Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1412.1795801581247188472
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Nov 2026 09:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RJzGOZxE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49a92144733so4227444f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795801579; x=1796406379; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvcIPmcUDE6ZEaJGk3MtGoNcPY34D7eJmNkbgNv5YIg=;
        b=RJzGOZxEjWR8ta+JwrXUAVsgvLoppcdBzelDI9jbTgpVNHaA9JpNUf2MfbuTZQ6yEH
         LH3mCGL1x2vTCUAJpLPhXbnvqlZUdE0vjFdZcr9DYkWDmarzkrdyU/e9ZToBVQYK1Xl9
         +HSmH7oQrdC7aE7MWrHRcOkC+O5dyH/h8xbRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801579; x=1796406379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uvcIPmcUDE6ZEaJGk3MtGoNcPY34D7eJmNkbgNv5YIg=;
        b=uCzm7oh1nN4Rd2b4R//Ux+fIHZPQcTboex45puNRrUWFULubIMVS3AQh3ZW9InqQ6U
         NU9Y3bEmaJKSp9X9GDEBPJmKajjqFk6bAEFrJt6ArEQH2Usy22B5zPDfgvP7hvAvVhxc
         erpLckKOL+Ki4GHN3r3mHdAFt/cNK9aLb7iIYIbpmvypvsrHHJiPM1CCX8vFfRWidupa
         0R4vU5C1UuLIK3q83F1Prdi/N95VaX4hnoEKFCcmgquPUodeETfui2VWThrDI55l0+Qt
         8Gmlgy358GXctevhwr0sSOx0yZb9g33PaPzlSGmtsdCP0OvwiN8vfMzkygofMZ3+MQZe
         UZOw==
X-Gm-Message-State: APuU4Z9QhmD99wV6xa2+EspaFDGIkaX1fiZSy0n2rfbcaxNYzjk0GZUV
	nh2VHLDN0PQWyGTfBTgi6jI3rObfCwljq4QcGWGV7bEnrTOhPvuJjUqvrkSCT2fD/Ld+eKhRoQm
	NF/nkufc=
X-Gm-Gg: AZFdTZcTC56eFDBWXPYZstR3zaorYZw44wKLD2v1RV+kG7XC8+ySb//nmtv3Bp3VcAY
	aqDsymhIH0vsHZ1YtJHyqUp1bST786q3P4hgkDfYe1J/vG1D7UeDY7mZHmv7RgWTKdUmkjGxyWN
	V45DSdviezX3l2NtetiTI/G+uHUfUUe89rlBX2a1HVP33TVNJ+XavJoHHUgXwYWFu8xt0BZo9p7
	iBAUNK5DFP862vIGeZEpTZ84WvsI7p9iHO0eh9UMQjCO1UmZEZexZt/2MI3qyE9zUKUAr55Ridh
	cn2VHFYAaR4dmMniAjNF39mNw+lQiPG8mGs/y1g2bdzousI36nuwuAV+zq+oMuqx1CmnRag3ybp
	xOy7clwkaQv7sjXKOTmiUvGV4tl2TI9RYpwD4z7C4O34NneqqGStXwJJl6rdFgtY6f7dC9rqt1X
	k2RKSaU617GHgxqrVAxUBzgibIqyrkFmlLgUSA99Kb+WP4Y18Xc6fxKOfShji98LvlcnyKhdsQC
	7INxynrfkVIxbgO6ZfVJj8WZmpSLzyZTfZq098J0A6SFeXwHpBXr4m/WYGng8RRUIgNtWH3rTCk
	VFbHDeR57cXWqMjePPIeXHvaI8XMU/3U8Z/Eqt4wQBlFnYQydzVzKheYZw==
X-Received: by 2002:a05:600c:a117:b0:4bb:a5e1:7497 with SMTP id 5b1f17b1804b1-4bba5e18d83mr151895165e9.32.1795801578666;
        Fri, 27 Nov 2026 09:46:18 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:47cb:b596:3be3:8f97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm790022715e9.3.2026.11.27.09.46.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:46:18 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] uihelper: Fix exception when TaskStarted event handler breaks
Date: Fri, 27 Nov 2026 17:46:14 +0000
Message-ID: <20261127174616.2269186-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 17:46:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20479
Content-Type: text/plain; charset="utf-8"

If there is an exception in a TaskStarted event handler, we can get a
still get a TaskFailed event which will trigger a second exception. Since
our TaskStarted code may not have run. Avoid that second exception from
an undefined dict key.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/uihelper.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 3e077f04484..18079195ff5 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -25,6 +25,9 @@ class BBUIHelper:
         # PIDs are a bad idea as they can be reused before we process all UI events.
         # We maintain a 'fuzzy' match for TaskProgress since there is no other way to match
         def removetid(pid, tid):
+            if tid not in self.running_tasks:
+                # This is possible if you have an exception during a TaskStarted handler
+                return
             del self.running_tasks[tid]
             if self.pidmap[pid] == tid:
                 del self.pidmap[pid]
