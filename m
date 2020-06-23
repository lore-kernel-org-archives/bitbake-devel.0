Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.3097.1592902878402218885
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2020 02:01:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=CPvLOFl6;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: onea.alex@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id cy7so9261276edb.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2020 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BY08iJasRByoEAfhjkwBRYIS8DoarCVqCK8tdtQWFmI=;
        b=CPvLOFl6G6Trx+W+vTDXcW4qJWfMokCcKTvquA4e8S5iE5w/L094uYdPxsFGgz6m4T
         JnzZWH5aXCqIMEIpnCgcbNdGtRrVQNXhvcu7/aadYH8s1uDetSBKS+n+iGm5066QtQoa
         +9onCl7ZwaaQDIaF8HsaoBiOP/cZQqihfDV5R4Sk5imtb2Ur2JyrUz48QlfLp4xSJ2X0
         MjP36Nu1Rcm/bd+89LDtIia/OzJ+wLYmkQBOD1Z3DeRtTueGzT+i3/PnwfPXrkcbMUqY
         /YvywMz/0s0PScLYR/XGU9Ow0GxoHmroXNoB1qgWVdOtpksBPCHNAAexKAPbA9sKE7KC
         1xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BY08iJasRByoEAfhjkwBRYIS8DoarCVqCK8tdtQWFmI=;
        b=ICiigSVCbvu0O418kOjiH0fz2/xDQ1i8UQVvRAV1kEuKjfpx5+xspwqlE6t7S1fx2F
         SjB1z5SgvWOk72fcprAXq240fgwwrfAmq+qs09VmRylgjTdmnU5ujdNgtcWhD0wvFy9k
         OlQMXKotDc7c+rJ54EAqTNREeI334Zzl8n0iHE+zBQssbJ6hmJUT2vEyuRyGrUl1IYHq
         g56aFibdRq5NbE/zcMQ+NNp5GM4Vl1ZH5WI3za+5tTZmdSIR3RO27SHpwMJsh+5DgCCc
         h/8SHi2QMTAo223+Mtx1P1wnCKqkMTKtJrHKdtmF+Vu0bcIIfAuy/yRIzPijXd3wvvb6
         RKGA==
X-Gm-Message-State: AOAM530KqgNbR95A/j6KVMOKM7rqAKbldHPYE5lmvhitNV4pyRlbv17x
	U+a9mpsjk+ydSX0Q3txuxtOLGMjM3Tr6xg==
X-Google-Smtp-Source: ABdhPJxFX2JWun1j/QhDNB7SBg1pXv7iw0QhX+Ptf35tDPmpx2inMz7fs0VR5F1JLKnez+ymk7NZUQ==
X-Received: by 2002:a05:6402:3052:: with SMTP id bu18mr20447164edb.323.1592902876485;
        Tue, 23 Jun 2020 02:01:16 -0700 (PDT)
Return-Path: <onea.alex@gmail.com>
Received: from localhost.localdomain ([82.76.227.25])
        by smtp.gmail.com with ESMTPSA id k23sm13229119ejk.114.2020.06.23.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:01:16 -0700 (PDT)
From: "Alexandru N. Onea" <onea.alex@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Alexandru N. Onea" <onea.alex@gmail.com>
Subject: [PATCH v2 2/3] perforce: add local path handling SRC_URI options
Date: Tue, 23 Jun 2020 12:00:50 +0300
Message-Id: <20200623090051.85367-2-onea.alex@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623090051.85367-1-onea.alex@gmail.com>
References: <20200623090051.85367-1-onea.alex@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements three new SRC_URI options for the perforce
fetcher, namely:

* module
* remotepath

The options are intended to provide the user more control over the
downloaded file paths by allowing the user to specify how much of the remote
path should be preserved locally.

The changes in this patch are backwards compatible, i.e. if none of the
introduced options is specified, the default (old) behavior is enforced.

Signed-off-by: Alexandru N. Onea <onea.alex@gmail.com>
---
 lib/bb/fetch2/perforce.py | 47 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 83128cde..6f3c95b6 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -1,6 +1,20 @@
 """
 BitBake 'Fetch' implementation for perforce
 
+Supported SRC_URI options are:
+
+- module
+   The top-level location to fetch while preserving the remote paths
+
+   The value of module can point to either a directory or a file. The result,
+   in both cases, is that the fetcher will preserve all file paths starting
+   from the module path. That is, the top-level directory in the module value
+   will also be the top-level directory in P4DIR.
+
+- remotepath
+   If the value "keep" is given, the full depot location of each file is
+   preserved in P4DIR. This option overrides the effect of the module option.
+
 """
 
 # Copyright (C) 2003, 2004  Chris Larson
@@ -88,14 +102,33 @@ class Perforce(FetchMethod):
             logger.debug(1, 'Determined P4PORT to be: %s' % ud.host)
             if not ud.host:
                 raise FetchError('Could not determine P4PORT from P4CONFIG')
-	
+
+        # Fetcher options
+        ud.module = ud.parm.get('module')
+        ud.keepremotepath = (ud.parm.get('remotepath', '') == 'keep')
+
         if ud.path.find('/...') >= 0:
             ud.pathisdir = True
         else:
             ud.pathisdir = False
 
+        # Avoid using the "/..." syntax in SRC_URI when a module value is given
+        if ud.pathisdir and ud.module:
+            raise FetchError('SRC_URI depot path cannot not end in /... when a module value is given')
+
         cleanedpath = ud.path.replace('/...', '').replace('/', '.')
         cleanedhost = ud.host.replace(':', '.')
+
+        # Merge the path and module into the final depot location
+        if ud.module:
+            if ud.module.find('/') == 0:
+                raise FetchError('module cannot begin with /')
+            ud.path = os.path.join(ud.path, ud.module)
+
+            # Append the module path to the local pkg name
+            cleanedmodule = ud.module.replace('/...', '').replace('/', '.')
+            cleanedpath += '--%s' % cleanedmodule
+
         ud.pkgdir = os.path.join(ud.dldir, cleanedhost, cleanedpath)
 
         ud.setup_revisions(d)
@@ -125,10 +158,20 @@ class Perforce(FetchMethod):
             pathnrev = '%s' % (ud.path)
 
         if depot_filename:
-            if ud.pathisdir: # Remove leading path to obtain filename
+            if ud.keepremotepath:
+                # preserve everything, remove the leading //
+                filename = depot_filename.lstrip('/')
+            elif ud.module:
+                # remove everything up to the module path
+                modulepath = ud.module.rstrip('/...')
+                filename = depot_filename[depot_filename.rfind(modulepath):]
+            elif ud.pathisdir:
+                # Remove leading (visible) path to obtain the filepath
                 filename = depot_filename[len(ud.path)-1:]
             else:
+                # Remove everything, except the filename
                 filename = depot_filename[depot_filename.rfind('/'):]
+
             filename = filename[:filename.find('#')] # Remove trailing '#rev'
 
         if command == 'changes':
-- 
2.25.1

