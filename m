Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.2084.1591989338960333009
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2020 12:15:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WyUvn4t4;
 spf=pass (domain: konsulko.com, ip: 209.85.221.65, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f65.google.com with SMTP id c3so10835252wru.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2020 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gojB5dwlW4ZOUHaKLQy9R4CMxnJKl5ipeHOWaLn7YTk=;
        b=WyUvn4t4LmZpbzSfbDxD/XegNos9kSaIqwOyUrQz7Zp1FOM54YuhfaizIgd9fW1eB3
         KlDKT0prRMME4p5esjBLXusNLNwZgNIaAN3Rn/3aiXrBQr6jfy3A3q9Y6cPRlv1p6gcD
         L7B6A2raWApiwcX3ieAzTWl0rEBR9O7AVfAOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gojB5dwlW4ZOUHaKLQy9R4CMxnJKl5ipeHOWaLn7YTk=;
        b=fDyg5rVSjK+jXF1P9OYq4pfdhIk0XVMeekjFosxNvhJ3paTVqouMhLjaw6Uo9sBgmS
         onSMCT4fu6XVHRgM+67xp6pKFG77UxPiQo0ZDfzqIPGDOTPFOzqjiUbLVBh7CzBI+SWF
         jKwoJ+zx3jL1HkefRdEcw/4CUluHDZSe0AszULUG1Nl6+E/xd0FQtXV7lkAcbBe4vWId
         fQSNYO62JeLUyeTQoM5cXE5+slPFxF6JfVHi7qSZGPO4qN0cxt8i6zC0NcohDT+MB4+u
         81GmvajiRjZkKH1PpbLz0dfbBEduP4mOWmgii9Sc4gbN3S2DCLFvxSGY5IPIfQqYH+li
         RVPA==
X-Gm-Message-State: AOAM5325jUwiVjopate65ho+KUXlIDS4aKwuCzSPF9D5t2koZuABIF17
	bkvlHuZWxaG7QDT/9K93eVbwq5Np2bhwvg==
X-Google-Smtp-Source: ABdhPJyhau/SizcC07LLIN9m/Yj4vmEIasa9f/O+PZ9LfKoRqN7Zql6Zov5CjTuy3f5vjaykjAA6gQ==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr434133wmf.18.1591989337109;
        Fri, 12 Jun 2020 12:15:37 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from ar2.home.b5net.uk ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id j11sm10781334wru.69.2020.06.12.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:15:36 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 2/2] fetch2/gitsm: Make need_update() process submodules
Date: Fri, 12 Jun 2020 20:15:22 +0100
Message-Id: <20200612191522.12352-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612191522.12352-1-pbarker@konsulko.com>
References: <20200612191522.12352-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the bitbake.srcrev nugget is not present for the commit we're
interested in we should not just bail out and say that an update is
needed. Instead we can recursively walk through the submodules and check
for the presence of the required commits.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 175dee05..d6e5c5c0 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -143,12 +143,43 @@ class GitSM(Git):
         try:
             # Check for the nugget dropped by the download operation
             known_srcrevs = runfetchcmd("%s config --get-all bitbake.srcrev" % \
-                            (ud.basecmd), d, workdir=ud.clonedir)
+                                        (ud.basecmd), d, workdir=ud.clonedir)
 
-            if ud.revisions[ud.names[0]] not in known_srcrevs.split():
-                return True
+            if ud.revisions[ud.names[0]] in known_srcrevs.split():
+                return False
         except bb.fetch2.FetchError:
-            # No srcrev nuggets, so this is new and needs to be updated
+            pass
+
+        need_update_list = []
+        def need_update_submodule(ud, url, module, modpath, workdir, d):
+            url += ";bareclone=1;nobranch=1"
+
+            try:
+                newfetch = Fetch([url], d, cache=False)
+                new_ud = newfetch.ud[url]
+                if new_ud.method.need_update(new_ud, d):
+                    need_update_list.append(modpath)
+            except Exception as e:
+                logger.error('gitsm: submodule update check failed: %s %s' % (type(e).__name__, str(e)))
+                need_update_result = True
+
+        # If we're using a shallow mirror tarball it needs to be unpacked
+        # temporarily so that we can examine the .gitmodules file
+        if ud.shallow and os.path.exists(ud.fullshallow) and not os.path.exists(ud.clonedir):
+            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+            self.process_submodules(ud, tmpdir, need_update_submodule, d)
+            shutil.rmtree(tmpdir)
+        else:
+            self.process_submodules(ud, ud.clonedir, need_update_submodule, d)
+            if len(need_update_list) == 0:
+                # We already have the required commits of all submodules. Drop
+                # a nugget so we don't need to check again.
+                runfetchcmd("%s config --add bitbake.srcrev %s" % \
+                            (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=ud.clonedir)
+
+        if len(need_update_list) > 0:
+            logger.debug(1, 'gitsm: Submodules requiring update: %s' % (' '.join(need_update_list)))
             return True
 
         return False
-- 
2.26.2

