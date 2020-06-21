Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
 by mx.groups.io with SMTP id smtpd.web11.1586.1592762187577460119
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Jun 2020 10:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DZd9yoqO;
 spf=pass (domain: gmail.com, ip: 209.85.208.67, mailfrom: onea.alex@gmail.com)
Received: by mail-ed1-f67.google.com with SMTP id x93so11733742ede.9
        for <bitbake-devel@lists.openembedded.org>; Sun, 21 Jun 2020 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVuo2whyDHTlnkexvCXXDa7ehzP7z25os8k1eCB9ox4=;
        b=DZd9yoqOqcEjkygQclOmPXntFMgkpsymEPQiYP7+zc3zxDmK9zZkx7uQ9a8yP+s4H4
         6CU4JqmJ67fpVZ/HELzRd+Jx4iatqtZNpszhm63qoqDwZbid98CAiPqUeMtEDwtODONq
         uNuqIQKQyJOJAA30hGFxIb+CiGc4lmD+BKoCDzefb4HOa1QouYDVsQcntlApCHEffBcR
         40VST8RYY8r2zLyrd2DRdTOsy3O+sqqJBtvY+ueszMlPWH/2ToU6BotYMpWjWbW9VXhQ
         NsuhP62JUuUip0t5fVRbSwOvTygwZu0pV3eL/BPKnwRvOHIxxu7Kodk500AvFXX4eHJh
         THjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVuo2whyDHTlnkexvCXXDa7ehzP7z25os8k1eCB9ox4=;
        b=N+aQCool9gTJJ4wzUOE+GDp1Yk/l5H3veHJCY5ib4VWl4N+yMWn3JLSQYIqx+Nu2CV
         xgcW9N/g96gYBCeh4h8kk/tQMBWnoF4ByDXeImRAy6wR3mgrWIPyIEwBg7xbYLcZKCpT
         CBI5PG2JxvLQ0/FvPf8o7UtawbypbbAazhMuz2B6A+e2jFPVgSBH+BOGs4ySSD3yRG2o
         8Eb1hzo5poVgKGGSBQ8HTOl4XHGXKSHug0I0GTaOh8L+m+gCbG9Yw7fnTaTTQAFEAC6t
         BCwxB40wFtMOpERlTnQ5Sk9zS8C1otkCX3+mzM3CbB3eD0KwOcxykSQZ2/L2aN7xHh2l
         7f1A==
X-Gm-Message-State: AOAM533CGzkZ7BPRegUM5CGI+SY0EaCftS0qeCEeCgsiZTPhYWnJ0lRY
	0XvvsrnB3wZvtMvxdJAUN8OEpVZRlbcy7Q==
X-Google-Smtp-Source: ABdhPJwRCu1VPtAtCLpW+bZNa/8uCid5+P5G3t1j50WzrpBbZ2N6PHTN0RGBWy+Faj8yYdF7Fmc13g==
X-Received: by 2002:a05:6402:31b8:: with SMTP id dj24mr8160493edb.188.1592762185664;
        Sun, 21 Jun 2020 10:56:25 -0700 (PDT)
Return-Path: <onea.alex@gmail.com>
Received: from localhost.localdomain ([82.76.227.25])
        by smtp.gmail.com with ESMTPSA id f17sm10654346edj.32.2020.06.21.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 10:56:25 -0700 (PDT)
From: "Alexandru N. Onea" <onea.alex@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Alexandru N. Onea" <onea.alex@gmail.com>
Subject: [PATCH 2/2] perforce: add local path handling SRC_URI options
Date: Sun, 21 Jun 2020 20:55:30 +0300
Message-Id: <20200621175530.894393-2-onea.alex@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200621175530.894393-1-onea.alex@gmail.com>
References: <20200621175530.894393-1-onea.alex@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements three new SRC_URI options for the perforce
fetcher, namely:

* module
* destdir
* remotepath

The options are intended to provide the user more control over the
downloaded file paths. The module and remotepath options allow the user
to specify how much of the remote path should be preserved locally. The
destdir option provides a mechanism for grouping and separating
downloads in case of multiple perforce entries in SRC_URI.

The changes in this patch are backwards compatible, i.e. if none of the
introduced options is specified, the default (old) behavior is enforced.

Signed-off-by: Alexandru N. Onea <onea.alex@gmail.com>
---
 lib/bb/fetch2/perforce.py | 55 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 83128cde..3237b038 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -1,6 +1,25 @@
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
+- destdir
+   An additional path element to be prefixed to the final file paths, for each
+   file in the download, helping with grouping files in case of multiple
+   SRC_URI perforce entries.
+
+- remotepath
+   If the value "keep" is given, the full depot location of each file is
+   preserved in P4DIR. This option overrides the effect of the module option.
+
 """
 
 # Copyright (C) 2003, 2004  Chris Larson
@@ -88,12 +107,31 @@ class Perforce(FetchMethod):
             logger.debug(1, 'Determined P4PORT to be: %s' % ud.host)
             if not ud.host:
                 raise FetchError('Could not determine P4PORT from P4CONFIG')
-	
+
+        # Fetcher options
+        ud.module = ud.parm.get('module')
+        ud.keepremotepath = (ud.parm.get('remotepath', '') == 'keep')
+        ud.destdir = ud.parm.get('destdir', '')
+
         if ud.path.find('/...') >= 0:
             ud.pathisdir = True
         else:
             ud.pathisdir = False
 
+        # Avoid using the "/..." syntax in SRC_URI when a module value is given
+        if ud.pathisdir and ud.module:
+            raise FetchError('SRC_URI depot path cannot not end in /... when a module value is given')
+
+        # Avoid destdir values which don't reference a single directory
+        if ud.destdir.find('/') >= 0:
+            raise FetchError('destdir cannot contain /')
+
+        # Merge the path and module into the final depot location
+        if ud.module:
+            if ud.module.find('/') == 0:
+                raise FetchError('module cannot begin with /')
+            ud.path = os.path.join(ud.path, ud.module)
+
         cleanedpath = ud.path.replace('/...', '').replace('/', '.')
         cleanedhost = ud.host.replace(':', '.')
         ud.pkgdir = os.path.join(ud.dldir, cleanedhost, cleanedpath)
@@ -125,10 +163,23 @@ class Perforce(FetchMethod):
             pathnrev = '%s' % (ud.path)
 
         if depot_filename:
-            if ud.pathisdir: # Remove leading path to obtain filename
+            if ud.keepremotepath:
+                # preserve everything (the leading // is removed below)
+                filename = depot_filename
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
+            # Prepend destdir to the final file path, also remove leading //
+            filename = os.path.join(ud.destdir, filename.lstrip('/'))
+
             filename = filename[:filename.find('#')] # Remove trailing '#rev'
 
         if command == 'changes':
-- 
2.25.1

