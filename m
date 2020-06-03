Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.3710.1591212682490317442
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2020 12:31:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=W6iqfK/g;
 spf=pass (domain: konsulko.com, ip: 209.85.221.46, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f46.google.com with SMTP id c3so3580918wru.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2020 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WQ+yjGZU52M2svCpfFAMMFKuTYB1DFNPyMFP4uNi/Q=;
        b=W6iqfK/g0CG+QFcVSZ+rE0SOIkDD0bTaqu4lGVtdOfUVPUaGECEoV/dbCcH/bnz63g
         lgm9UI0KY0jsrXDVV6eqrqglKgLlS5ReLFk+EC5nwRrqnIQ+w07pUbwI1+KqWdK66HzG
         B21+Yebc7wXAj8LT239CoLT2VRbdQccspjVtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WQ+yjGZU52M2svCpfFAMMFKuTYB1DFNPyMFP4uNi/Q=;
        b=Y2kng1c1DmELQxrC+y2VFYwDQ9Pzbna0wxKt+lcUdfLSDdk7eXcnrI+KPM3aAw0tYe
         PIXTXe9mK9fUK0OVZJ8pqhihVfVDsLJOUuGFZxPjgfz8vr95BSJ5dlg3oOYN1ShYPmjX
         IGWu7boFE2VtyXpNI+kre2V+K9vM1RWGZLxHdnFIKCloeP0a9H9yNIKF4TtZwdnNIN6Q
         PDiVkXenCDpe421fjHBX98SbmG1okcopTdcRMJT1EeAKZ9ithpqTrHorRQb3gHaU9ext
         +sub6l94ZzwMOVyAdmcEDqrCfbeh6yp+yo9PBuKycXE1tEzXLsyNwM9umPAd+U5G8kLP
         vBsw==
X-Gm-Message-State: AOAM531Alt0o3seaWKjWlDy5jXreqhfTX1WK/v4+bfOwFXdRQ99/Boj5
	XDXORmjDKV9+EijDNsJekUrT+KO6dZOIjw==
X-Google-Smtp-Source: ABdhPJyCIq5x4B00ngFz3pJGV40qA2IRm+IOuA+YIFtVJGzm/7WDqCfmSyOYhLItxwo370UYhXhQ3Q==
X-Received: by 2002:a5d:6601:: with SMTP id n1mr859547wru.23.1591212680406;
        Wed, 03 Jun 2020 12:31:20 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from ar2.home.b5net.uk ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id o8sm4331290wmb.20.2020.06.03.12.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:31:19 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH] fetch2: Add the ability to list expanded URL data
Date: Wed,  3 Jun 2020 20:31:16 +0100
Message-Id: <20200603193116.20924-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some fetchers may download additional sources along with those
explicitly listed in SRC_URI. These "implicit URLs" will be needed by
the archiver to ensure that all sources can be archived.

We can't just return a list of URL strings since each URL may need its
own SRCREV data so we return a list of FetchData objects.

Each fetcher can override the implicit_urldata() function to provide the
additional FetchData objects. For now this is just needed in the gitsm
fetcher to walk git submodules recursively.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/fetch2/__init__.py | 25 +++++++++++++++++++++++++
 lib/bb/fetch2/gitsm.py    | 21 +++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index eb112f06..756f6021 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1617,6 +1617,13 @@ class FetchMethod(object):
             return True
         return False
 
+    def implicit_urldata(self, ud, d):
+        """
+        Get a list of FetchData objects for any implicit URLs that will also
+        be downloaded when we fetch the given URL.
+        """
+        return []
+
 class Fetch(object):
     def __init__(self, urls, d, cache = True, localonly = False, connection_cache = None):
         if localonly and cache:
@@ -1842,6 +1849,24 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
 
+    def expanded_urldata(self, urls=None):
+        """
+        Get an expanded list of FetchData objects covering both the given
+        URLS and any additional implicit URLs that are added automatically by
+        the appropriate FetchMethod.
+        """
+
+        if not urls:
+            urls = self.urls
+
+        urldata = []
+        for url in urls:
+            ud = self.ud[url]
+            urldata.append(ud)
+            urldata += ud.method.implicit_urldata(ud, self.d)
+
+        return urldata
+
 class FetchConnectionCache(object):
     """
         A class which represents an container for socket connections.
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index e7083001..56bd5f04 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -223,3 +223,24 @@ class GitSM(Git):
             # up the configuration and checks out the files.  The main project config should remain
             # unmodified, and no download from the internet should occur.
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+
+    def implicit_urldata(self, ud, d):
+        import shutil, subprocess, tempfile
+
+        urldata = []
+        def add_submodule(ud, url, module, modpath, workdir, d):
+            url += ";bareclone=1;nobranch=1"
+            newfetch = Fetch([url], d, cache=False)
+            urldata.extend(newfetch.expanded_urldata())
+
+        # If we're using a shallow mirror tarball it needs to be unpacked
+        # temporarily so that we can examine the .gitmodules file
+        if ud.shallow and os.path.exists(ud.fullshallow) and ud.method.need_update(ud, d):
+            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
+            subprocess.check_call("tar -xzf %s" % ud.fullshallow, cwd=tmpdir, shell=True)
+            self.process_submodules(ud, tmpdir, add_submodule, d)
+            shutil.rmtree(tmpdir)
+        else:
+            self.process_submodules(ud, ud.clonedir, add_submodule, d)
+
+        return urldata
-- 
2.26.2

