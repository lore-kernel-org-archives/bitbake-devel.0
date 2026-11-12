Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14406.1794493680246825804
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 06:28:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e34d9gPZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so2887887f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794493678; x=1795098478; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jrc58uSbBXhTCAuNJpZi+l4s+UEdNbNIXGayTGWE3R8=;
        b=e34d9gPZvLvljo8KXNEmfmFZBAJMgFAabTZhmIF4W/7WEAxA+Rdf2gcshkdhCxJG9f
         FwYkX9/AsQj3K/Hc6a14VEzaIuIDAYnLYZeNAaeaQ/QKv8Z1iyT/VnXpPCG39o7CF+3D
         5Qug0O4oM2A+La4PupOHLjQfxBZiypBk1jcwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493678; x=1795098478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jrc58uSbBXhTCAuNJpZi+l4s+UEdNbNIXGayTGWE3R8=;
        b=A/30m2spuanJSLqnZUtxCfoeeaZqAMGvEh9zD+BPSJKIV1SBNTtfvaW3vhFQfENpXM
         mAMJru86SQBSAmIRQTS38uRKzdnRhYbhw7FLP6+YUVgR8bHRi2Ea/1hTMN7kPViH5R6N
         FSWE7rxpB5qaW85hQSLUL2odd3T3HNWcSHSJLAy2CY8njfHItWYHsWKRziZpmk0EBydT
         D/kkDAtR55JgYgFsD2do0TE7dMCW5AikIpA+LwXAA9xJUVsDzPGDadT0Mv1hIlo5cfoC
         OkTka1L7d9//8Qcbv/IeKRcnAz8hMAZjO6HCuw0C2IqzxabYZoy0+xSCcMCSo0ElGWpp
         PY2w==
X-Gm-Message-State: APuU4Z+PLkG4WLuEq5iymNxgIVZ2mSnkfBlZedFtuNeRa1J0FsddlRO3
	fx1qDgjPF4P+rgoud/nsNdD4adIjSQ5EZp7MyyfCa1l+2167nDvNKS0KVKRvIqQ+YyAqvPhZtro
	REkEiVik=
X-Gm-Gg: AYBFou0sOv3L8+9N/cGPznmsjkpaoyZ0UrUY3h/8JsSyn2lGPYr0yfgLWwTn6nulel4
	Cl2gmOixlmP/7AWiFQtNOMEfktgijn/ura1GwOd5w7f7H3si9hziWT5mVllgPB0BxzknNa9g6XY
	sfiwGVAB+iBANUCzwPvWmvSIANyMI5jtKZ0ldbKO7zNiSKe/XAFUkFK0Zc6Klx2NCBA1ANZV6cB
	Tw4IeuFOqgszqAiUBsGYIwja5r9EGwBz6DJWaDizkqbKJvbZ3dLsAFO0q4YRlg2heQiRFY6j/3C
	jnxHjKAOpjChslOy2wouC1mEHP3QZW7PVCgJPwP7v7lN6QX8JbNgcF1yWva09XgyFbu/2gIad2j
	jf3azSlNLluIpDL+Z0FwnMn/MijbDhyfbnGUGnHnNSjnDq1M5iDR0gThb5+bLkzdcsPkHeP+HCn
	5evaUJbsl4LToVtnbFRO0vhCfLcAAklji1BG2Bu+C/RjyhXkgVd7ACkoz9wilp5WNeNdRg86PLb
	kg7UKh5jqLJOlh5/lgvQYYiAyW3f0Fh8HRfskY2jiUJf7hSNu6QUAipvRmw+qGDHIN9SNBvuY0o
	8SO4pCXPDrFJX6kQryQbnLnQsZuCRs6dpNSxtJgWnPK9KHhhYqH0RCskyg==
X-Received: by 2002:a05:600c:4f55:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4ba0938197dmr127672945e9.28.1794493678031;
        Thu, 12 Nov 2026 06:27:58 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1562:9f61:e354:1b51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm83090325e9.5.2026.11.12.06.27.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:27:56 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Fix corner cases where BBFILES globbed directories were not expanded
Date: Thu, 12 Nov 2026 14:27:54 +0000
Message-ID: <20261112142755.3343305-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 14:28:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20425
Content-Type: text/plain; charset="utf-8"

If the BBFILES glob expands into directories instead of files, the directories
are not traversed and the files are not added. This is in contrast to
the behaviour if a directory is explictly listed and I believe an oversight
in the implementation.

Rearrange the code so that directories resolved by globs are traversed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8a422e50621..af53135353e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1890,19 +1890,20 @@ class CookerCollectFiles(object):
             # Can't use set here as order is important
             newfiles = []
             for f in files:
-                if os.path.isdir(f):
-                    dirfiles = self.find_bbfiles(f)
-                    for g in dirfiles:
-                        if g not in newfiles:
-                            newfiles.append(g)
+                globbed = []
+                if os.path.exists(f):
+                    globbed = [f]
                 else:
-                    globbed = glob.glob(f)
-                    if not globbed and os.path.exists(f):
-                        globbed = [f]
                     # glob gives files in order on disk. Sort to be deterministic.
-                    for g in sorted(globbed):
-                        if g not in newfiles:
-                            newfiles.append(g)
+                    globbed = sorted(glob.glob(f))
+                for g in globbed:
+                    if os.path.isdir(g):
+                        dirfiles = self.find_bbfiles(g)
+                        for g in dirfiles:
+                            if g not in newfiles:
+                                newfiles.append(g)
+                    elif g not in newfiles:
+                        newfiles.append(g)
         finally:
             os.listdir = origlistdir
             if hasattr(os, 'scandir'):
