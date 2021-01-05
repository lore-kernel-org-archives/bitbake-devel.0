Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.3097.1609839140493264196
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Jan 2021 01:32:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista-com.20150623.gappssmtp.com header.s=20150623 header.b=q5d7RVm+;
 spf=permerror, err=parse error for token &{10 18 websitewelcome.com}: parse error for token &{10 18 _spf.google.com}: limit exceeded (domain: mvista.com, ip: 209.85.210.172, mailfrom: mshah@mvista.com)
Received: by mail-pf1-f172.google.com with SMTP id h186so18062713pfe.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Jan 2021 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=OtAWXfkdINN69cltriT7UVMiRINGHCJ5185qmlbGTtY=;
        b=q5d7RVm+Ihsfc4XDtWeKzhL5RzaU1BTndtM/ze6XGA5SnEu+erOPpn+1EDLigD+KDv
         qITsc4K+PfApqwyYIq9BqTvNOO8pj3mTlLAI5jjIXm8qgbgtkYOVahKAvhzlCe1iSi0y
         cQYmIxiSiqWpH2Bw9KSF+5QKkUSRTTHSp2do4xHHzy2jwQ4t6ksJxYJClzfEU5XfL1Hv
         DZc9R1TiFZrXDN378C4kPJfY6A8jFoGY3hbj5CHNLdTtV32V2ZQyV6HOCJeuni4VYZIy
         FC4lBuoVww0rnz/aY3KOqBe0voDbJ7F7ZKmhEmdggPD0FuzkPzqmTTTRwhnjiwwJMo2c
         /xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=OtAWXfkdINN69cltriT7UVMiRINGHCJ5185qmlbGTtY=;
        b=tLp3ILt0Stkc5tI8BDI1g+DbkmV5Rkm39QV1TBFuPI9+zyBEdmUulKSQyVgTdV+67/
         OYdjR6nvP+KnX4BCnYUhTp9eVxrTf7fgUMy2n/ilovCcjJhB1deijNnQBnefxn0F2FvU
         kFsUo7GMUhczMSA1eTnwiUN2KzRtN2YNrNh/0MW0Ar86GEtTDdG6gGxjRY7+N0pocYHg
         CkXwHegMYp6da0remfKK585OKrPoBfHOwjy01FBUCkRFQQpKz/0Z7g66zAfYJgUukNs/
         +PIp1nVYnrkIsg7F1/ft4KL81wE55OPP3v0PJA4QQR4veFk45JqlRdaqTPSWG/wPvT+H
         VjCw==
X-Gm-Message-State: AOAM533HlIVWMfpKdgdXPRpO6erBgGSd0gL3ERfDSGbprmJOWzseEDm2
	MWzKB6SRDK8fnf6sY8kDBIe5RZTPhhVJNw==
X-Google-Smtp-Source: ABdhPJyICj4CVJ8L6MnLZHy9xV7FueH7+KYmsW4eAL7XlKKBEbi/k7lkuTFrJxJnW16HnBVdknFNcw==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr33232879pgg.195.1609839139419;
        Tue, 05 Jan 2021 01:32:19 -0800 (PST)
Return-Path: <mshah@mvista.com>
Received: from localhost.localdomain ([103.102.57.109])
        by smtp.gmail.com with ESMTPSA id d203sm58192004pfd.148.2021.01.05.01.32.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 01:32:18 -0800 (PST)
From: "Milan Shah" <mshah@mvista.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: utils: add docstrings to functions
Date: Tue,  5 Jan 2021 15:01:58 +0530
Message-Id: <1609839118-2342-1-git-send-email-mshah@mvista.com>
X-Mailer: git-send-email 2.7.4

A list of functions that now has a docstring.
* vercmp_string
* explode_dep_versions
* prunedir
* prune_suffix
* to_boolean
* contains_any
* export_proxies

See [YOCTO #9725] for details.

Signed-off-by: Milan Shah <mshah@mvista.com>
---
 lib/bb/utils.py | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f73d31f..5c775bd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -129,6 +129,7 @@ def vercmp(ta, tb):
     return r
 
 def vercmp_string(a, b):
+    """ Split version strings and compare them """
     ta = split_version(a)
     tb = split_version(b)
     return vercmp(ta, tb)
@@ -247,6 +248,12 @@ def explode_dep_versions2(s, *, sort=True):
     return r
 
 def explode_dep_versions(s):
+    """
+    Take an RDEPENDS style string of format:
+    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
+    skip null value and items appeared in dependancy string multiple times
+    and return a dictionary of dependencies and versions.
+    """
     r = explode_dep_versions2(s)
     for d in r:
         if not r[d]:
@@ -692,7 +699,7 @@ def remove(path, recurse=False, ionice=False):
                 raise
 
 def prunedir(topdir, ionice=False):
-    # Delete everything reachable from the directory named in 'topdir'.
+    """ Delete everything reachable from the directory named in 'topdir'. """
     # CAUTION:  This is dangerous!
     if _check_unsafe_delete_path(topdir):
         raise Exception('bb.utils.prunedir: called with dangerous path "%s", refusing to delete!' % topdir)
@@ -703,8 +710,10 @@ def prunedir(topdir, ionice=False):
 # but thats possibly insane and suffixes is probably going to be small
 #
 def prune_suffix(var, suffixes, d):
-    # See if var ends with any of the suffixes listed and
-    # remove it if found
+    """ 
+    See if var ends with any of the suffixes listed and
+    remove it if found 
+    """
     for suffix in suffixes:
         if suffix and var.endswith(suffix):
             return var[:-len(suffix)]
@@ -956,6 +965,10 @@ def umask(new_mask):
         os.umask(current_mask)
 
 def to_boolean(string, default=None):
+    """ 
+    Check input string and return boolean value True/False/None
+    depending upon the checks 
+    """
     if not string:
         return default
 
@@ -999,6 +1012,23 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
     return falsevalue
 
 def contains_any(variable, checkvalues, truevalue, falsevalue, d):
+    """Check if a variable contains any values specified.
+
+    Arguments:
+
+    variable -- the variable name. This will be fetched and expanded (using
+    d.getVar(variable)) and then split into a set().
+
+    checkvalues -- if this is a string it is split on whitespace into a set(),
+    otherwise coerced directly into a set().
+
+    truevalue -- the value to return if checkvalues is a subset of variable.
+
+    falsevalue -- the value to return if variable is empty or if checkvalues is
+    not a subset of variable.
+
+    d -- the data store.
+    """
     val = d.getVar(variable)
     if not val:
         return falsevalue
@@ -1560,8 +1590,8 @@ def set_process_name(name):
     except:
         pass
 
-# export common proxies variables from datastore to environment
 def export_proxies(d):
+    """ export common proxies variables from datastore to environment """
     import os
 
     variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
-- 
2.7.4

