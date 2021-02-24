Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.805.1614187620836932780
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Feb 2021 09:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mYjhnpN6;
 spf=pass (domain: gmail.com, ip: 209.85.210.53, mailfrom: aehs29@gmail.com)
Received: by mail-ot1-f53.google.com with SMTP id d9so2855515ote.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Feb 2021 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X42NJwL4CCfZmAuUmyX313UzBrJjTyAlwW/08sXMQ90=;
        b=mYjhnpN602t0YKwGNqH9cfThuZXUiOmbWgoDCj+xe4I55xQCs/MR48Xc5XheUa1AtQ
         SSNUJtM8EZ8Z6jKwUvYYN/+n6Ldx5csZ2PgPE8NUNlvRBQ24AbKcN1Qc1d2y9D5Yx9CO
         3yDMJ3oN7H0R9notgOcKMlWr4QlocEyORitQUBZrzhvjcLRC4+MkU3x82Pxh6lb5W/E1
         bRBzhS07+2gvwlp+xNULRFJ0vl/y4re25ClWwLLxCcpB/PtZBI2LaEm4OiRX5Dj8plP/
         GcyrQZx3rQM8erI7e2RI7LUp5bB4bTryFoSXvIvEC8R9A3XEBysspbfjwcDUErQ/KriD
         xSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X42NJwL4CCfZmAuUmyX313UzBrJjTyAlwW/08sXMQ90=;
        b=reiyPXxyLmm7+bUdUwQBDi9LnHS1T/kV80EigDH6QDglImugXT71YiihTy908XIJPv
         uZUoxZiiPYBsqCKDMGTb/LRgE3xdgGok1YZfP1PodNoBaWTwCnNb0BZrJ7WQobSmZkU/
         ZkMab06+I+nO97PAeZxZZCAvBjICo8CthZHQudMS1Qo2cx+AlkJHCda6Hn+F9u7NjYEo
         LXpGhPkMGhWzFaM+T3GP1OJ5kEyfQTQ32Oh7anIFfow70kryIITn5BflyOKN7dl98mSf
         e41nlOytWooEv5cjO1jnSecq7sHMGcai3lYWGVqB1nSK3NGL6v/JDPJop6+EZKcX7w7e
         N6cg==
X-Gm-Message-State: AOAM530zcv1cgyWy1H6vj+7VanQMaZ42xsKDGO85/bd8fljcGLHGoXx3
	EbhChQT64MPtb/F5RVspS8cgCHChiZp90g==
X-Google-Smtp-Source: ABdhPJwcbY/XXJaHheeUjKzgDyCvQSy7VhqI+KruWfSe+ZQryN7zc8/OswGnfOAwC9WKfEQWU8FJow==
X-Received: by 2002:a05:6830:2150:: with SMTP id r16mr2497478otd.27.1614187619189;
        Wed, 24 Feb 2021 09:26:59 -0800 (PST)
Return-Path: <aehs29@gmail.com>
Received: from alsamon-xub.lan (cpe-68-201-52-49.elp.res.rr.com. [68.201.52.49])
        by smtp.gmail.com with ESMTPSA id 2sm463590oip.3.2021.02.24.09.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 09:26:58 -0800 (PST)
From: "Alejandro Hernandez Samaniego" <alejandro@enedino.org>
X-Google-Original-From: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
Subject: [PATCH 1/3] bitbake: Add Azure Storage fetcher implementation
Date: Wed, 24 Feb 2021 10:26:32 -0700
Message-Id: <20210224172634.2127610-1-alhe@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

        Allows bitbake to fetch from an Azure Storage account.

        The fetcher submodule is compatible with the az:// URI protocol, its
        functionality is based on bitbakes wget fetcher, superior in performance
        to using a propietary tool like azcopy which can handle cloud storage
        account operations with more functionality (that we dont need in a fetcher)
	but less compatibility.

        A sample URI uses can be defined in the following way:
	SRC_URI = "az://<azure-storage-account>.blob.core.windows.net/<container>/foo.tar.xz"

        This fetcher can easily be used with PREMIRRORS and SSTATE_MIRRORS, e.g.:

        SSTATE_MIRRORS = "file://.* az://<azure-storage-account>.blob.core.windows.net/sstate-cache/PATH;downloadfilename=PATH \n"

        PREMIRRORS_prepend = "\
            git://.*/.* az://<azure-storage-account>.blob.core.windows.net/downloads/ \n \
            ftp://.*/.* az://<azure-storage-account>.blob.core.windows.net/downloads/ \n \
            http://.*/.* az://<azure-storage-account>.blob.core.windows.net/downloads/ \n \
            https://.*/.* az://<azure-storage-account>.blob.core.windows.net/downloads/ \n \
        "

        Can also be used with non-public access Azure Storage accounts/containers via a
        Shared Access Signature by declaring the AZ_SAS variable which will be
        automatically used by the fetcher:

        AZ_SAS="?sv=2000-01-01&ss=...&sig=somesignature"

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
---
 lib/bb/fetch2/__init__.py |  4 +-
 lib/bb/fetch2/az.py       | 93 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/az.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 19169d78..cf0201c4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1243,7 +1243,7 @@ class FetchData(object):
 
             if checksum_name in self.parm:
                 checksum_expected = self.parm[checksum_name]
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az"]:
                 checksum_expected = None
             else:
                 checksum_expected = d.getVarFlag("SRC_URI", checksum_name)
@@ -1908,6 +1908,7 @@ from . import repo
 from . import clearcase
 from . import npm
 from . import npmsw
+from . import az
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1927,3 +1928,4 @@ methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
 methods.append(npmsw.NpmShrinkWrap())
+methods.append(az.Az())
diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
new file mode 100644
index 00000000..3ccc594c
--- /dev/null
+++ b/lib/bb/fetch2/az.py
@@ -0,0 +1,93 @@
+"""
+BitBake 'Fetch' Azure Storage implementation
+
+"""
+
+# Copyright (C) 2021 Alejandro Hernandez Samaniego
+#
+# Based on bb.fetch2.wget:
+# Copyright (C) 2003, 2004  Chris Larson
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+import shlex
+import os
+import bb
+from   bb.fetch2 import FetchError
+from   bb.fetch2 import logger
+from   bb.fetch2.wget import Wget
+
+
+class Az(Wget):
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched from Azure Storage
+        """
+        return ud.type in ['az']
+
+
+    def checkstatus(self, fetch, ud, d, try_again=True):
+
+        # checkstatus discards parameters either way, we need to do this before adding the SAS
+        ud.url = ud.url.replace('az://','https://').split(';')[0]
+
+        az_sas = d.getVar('AZ_SAS')
+        if az_sas and az_sas not in ud.url:
+            ud.url += az_sas
+
+        return Wget.checkstatus(self, fetch, ud, d, try_again)
+
+    # Override download method, include retries
+    def download(self, ud, d, retries=3):
+        """Fetch urls"""
+
+        # If were reaching the account transaction limit we might be refused a connection,
+        # retrying allows us to avoid false negatives since the limit changes over time
+        fetchcmd = self.basecmd + ' --retry-connrefused --waitretry=5'
+
+        # We need to provide a localpath to avoid wget using the SAS
+        # ud.localfile either has the downloadfilename or ud.path
+        localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile)
+        bb.utils.mkdirhier(os.path.dirname(localpath))
+        fetchcmd += " -O %s" % shlex.quote(localpath)
+
+
+        if ud.user and ud.pswd:
+            fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
+
+        # Check if a Shared Access Signature was given and use it
+        az_sas = d.getVar('AZ_SAS')
+
+        if az_sas:
+            azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
+        else:
+            azuri = '%s%s%s' % ('https://', ud.host, ud.path)
+
+        if os.path.exists(ud.localpath):
+            # file exists, but we didnt complete it.. trying again.
+            fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % azuri)
+        else:
+            fetchcmd += d.expand(" -P ${DL_DIR} '%s'" % azuri)
+
+        try:
+            self._runwget(ud, d, fetchcmd, False)
+        except FetchError as e:
+            # Azure fails on handshake sometimes when using wget after some stress, producing a
+            # FetchError from the fetcher, if the artifact exists retyring should succeed
+            if 'Unable to establish SSL connection' in str(e):
+                logger.debug2('Unable to establish SSL connection: Retries remaining: %s, Retrying...' % retries)
+                self.download(ud, d, retries -1)
+
+        # Sanity check since wget can pretend it succeed when it didn't
+        # Also, this used to happen if sourceforge sent us to the mirror page
+        if not os.path.exists(ud.localpath):
+            raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (azuri, ud.localpath), azuri)
+
+        if os.path.getsize(ud.localpath) == 0:
+            os.remove(ud.localpath)
+            raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (azuri), azuri)
+
+        return True
-- 
2.25.1

