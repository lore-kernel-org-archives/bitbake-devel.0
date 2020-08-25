Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web12.14009.1598363807010378470
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 06:56:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EtJ1nHeO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id t2so2548175wma.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttR0ft2JFZVDOJmXRjMVnEOUclamOF09OpltY5wJJKM=;
        b=EtJ1nHeOh5LfRAeTx9vK4KLrNCn+mhor7xqvRE3Mtgc6R24PPJ52axCGWHKaEL3mk/
         ft05eFnvzNNmaj6gKyHK2b1HV7cYZu1Wliptssp5t29fJbsZEd51w3M8BvZReP8Ev9NB
         j1UCoBqdJGMwuasInqDEFHnjX1Y83DJfN70pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttR0ft2JFZVDOJmXRjMVnEOUclamOF09OpltY5wJJKM=;
        b=RAxLH2z+l3b3cZqJHZqyYJ2x9P9F4i9wDFIuC8BYG3cO610CADKwq+QDSpYKs1bEZo
         CAAA8PhAGWERZbGMnriJjrBciaRyVxc4WGh/K4hqOr18dO6v0x0eITQiNEjE6b2M2naH
         WB9po3TGEbKMpzDyr8cmAEd7GXghYxFlnF0zEV24C+iX1IUp+4mcdPK9ijSlicDJlzQk
         kVhnILXeb5jPe3Pa2zl1fKRpbHo+9EHs6y1wRFCFglrjIdnQ8OE6Qy0arFSD5uI2pNqA
         yUVBW6rWRG7DWSs++IUdqdk5pU8DAyVoNSrDT0u6My3CYFzlOOElIKbGftVKLCNmmDge
         v8Ag==
X-Gm-Message-State: AOAM533ckxuZwqtgyeccmnP4Jny5z6MaPdZUT54jee2FPwO1yn3hiK5E
	59UvvMbaUCKs8m3OTVgjpLfWFG1EysKihV+1
X-Google-Smtp-Source: ABdhPJzhoI76BP6oCEyXg4H0CL89qB/9wURykNbTGcxipc33P4ndYDEVU+fOtXLOSsOAuyUaLGr5Yw==
X-Received: by 2002:a1c:283:: with SMTP id 125mr2343017wmc.12.1598363804738;
        Tue, 25 Aug 2020 06:56:44 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c407:538:d07:8b9d])
        by smtp.gmail.com with ESMTPSA id j19sm6551425wmj.25.2020.08.25.06.56.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 06:56:44 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Drop globbing supprt in file:// SRC_URIs
Date: Tue, 25 Aug 2020 14:56:43 +0100
Message-Id: <20200825135643.1422253-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Globbing in file:// urls is terminally broken. Currently when its used, the
file checksum code is basically bypassed. This means changes to the source
files don't change the task checksum, the task doesn't rebuild when the
inputs change and things generally break.

To make globbing work generically, we'd have to scan the file system for
all possible matches to the glob and log whether they exist or not. We can't
simply log the files which exist, we have to also know which files could
later exist and influence the choice of file so we know when to reparse.

For a simple file://xxx/*, this could be done but for bigger patterns,
it becomes much more problemtic. We already support file://xxx/ in urls.

So, lets decide we'll not support globs in file://urls. Worse case users
can put files in a directory and reference that, moving files into place
if needed.

Remove all the glob special cases (see the comments if anyone doesn't
believe this is terminally broken) and error to the user if they have
such urls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py           |  2 +-
 lib/bb/fetch2/__init__.py | 12 ------------
 lib/bb/fetch2/local.py    | 15 +++------------
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index b819a0c2da..9e0c931a07 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -636,7 +636,7 @@ class Cache(NoCache):
                 # Have to be careful about spaces and colons in filenames
                 flist = self.filelist_regex.split(fl)
                 for f in flist:
-                    if not f or "*" in f:
+                    if not f:
                         continue
                     f, exist = f.split(":")
                     if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 756f60212f..7ec1fea5d0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1195,8 +1195,6 @@ def get_checksum_file_list(d):
             paths = ud.method.localpaths(ud, d)
             for f in paths:
                 pth = ud.decodedurl
-                if '*' in pth:
-                    f = os.path.join(os.path.abspath(f), pth)
                 if f.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                     if os.path.exists(f):
@@ -1365,9 +1363,6 @@ class FetchMethod(object):
         # We cannot compute checksums for directories
         if os.path.isdir(urldata.localpath):
             return False
-        if urldata.localpath.find("*") != -1:
-            return False
-
         return True
 
     def recommends_checksum(self, urldata):
@@ -1430,11 +1425,6 @@ class FetchMethod(object):
         iterate = False
         file = urldata.localpath
 
-        # Localpath can't deal with 'dir/*' entries, so it converts them to '.',
-        # but it must be corrected back for local files copying
-        if urldata.basename == '*' and file.endswith('/.'):
-            file = '%s/%s' % (file.rstrip('/.'), urldata.path)
-
         try:
             unpack = bb.utils.to_boolean(urldata.parm.get('unpack'), True)
         except ValueError as exc:
@@ -1613,8 +1603,6 @@ class FetchMethod(object):
         """
         if os.path.exists(ud.localpath):
             return True
-        if ud.localpath.find("*") != -1:
-            return True
         return False
 
     def implicit_urldata(self, ud, d):
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 01d9ff9f8f..25d4557db6 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -17,7 +17,7 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb.fetch2 import FetchMethod, FetchError
+from   bb.fetch2 import FetchMethod, FetchError, ParameterError
 from   bb.fetch2 import logger
 
 class Local(FetchMethod):
@@ -33,6 +33,8 @@ class Local(FetchMethod):
         ud.basename = os.path.basename(ud.decodedurl)
         ud.basepath = ud.decodedurl
         ud.needdonestamp = False
+        if "*" in ud.decodedurl:
+            raise bb.fetch2.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
 
     def localpath(self, urldata, d):
@@ -55,12 +57,6 @@ class Local(FetchMethod):
             logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
             searched.extend(hist)
-        if (not newpath or not os.path.exists(newpath)) and path.find("*") != -1:
-            # For expressions using '*', best we can do is take the first directory in FILESPATH that exists
-            newpath, hist = bb.utils.which(filespath, ".", history=True)
-            searched.extend(hist)
-            logger.debug(2, "Searching for %s in path: %s" % (path, newpath))
-            return searched
         if not os.path.exists(newpath):
             dldirfile = os.path.join(d.getVar("DL_DIR"), path)
             logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
@@ -70,8 +66,6 @@ class Local(FetchMethod):
         return searched
 
     def need_update(self, ud, d):
-        if ud.url.find("*") != -1:
-            return False
         if os.path.exists(ud.localpath):
             return False
         return True
@@ -95,9 +89,6 @@ class Local(FetchMethod):
         """
         Check the status of the url
         """
-        if urldata.localpath.find("*") != -1:
-            logger.info("URL %s looks like a glob and was therefore not checked.", urldata.url)
-            return True
         if os.path.exists(urldata.localpath):
             return True
         return False
-- 
2.25.1

