Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ADDC0015E
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 13:05:03 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.42149.1691759096535880064
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Aug 2023 06:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A71C4SAz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so16963755e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Aug 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691759095; x=1692363895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYNh+wkrNWm1vYZx5P0ozBrF28zqmdNwSwnrlch4er8=;
        b=A71C4SAzA7glZV0baDMUPhpi6C9c7sNBKESoZfOoEAY/W8lkrx9Q22O52MRcOInnje
         f/K/gyqmKhy4e5OtgetiRP1Q3xiW99Ng6foVNyBG2t0A2YdioyweSRqllj++/oc8Y9qI
         8Az+tMU2jiQHviaKQs208OJyyNyPh21YpD6Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759095; x=1692363895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYNh+wkrNWm1vYZx5P0ozBrF28zqmdNwSwnrlch4er8=;
        b=hoDphrhY3q95GycSrkmU6SbJklov2XSNwV5cfsZJH77v8QDBH23Ks9t2Y4ingp5nRB
         /+ek6+KbmOMsI51nBWLgZFRRrJdhkUrzUWvu+DOgh5T5L/WzLoBduJw0QLNwmmpyH4eL
         tEWesddjH8ebO3qYZ1743cAb/P5iR6zEGHq2pa6NoyqOCEiiFiNRRLduin3n0az6+/u1
         heujz00VRcw/rAG7vHvVvvSPcV58rwcHzPlXlpW2abzxJ6iJjkIwarx+YmEbnvPbLQVh
         +2KGnSBzDtecbIcdb5obGCKztNhllUJp/GK7nI6P+bwq7YgEp8ihIi9TJBK+yUG2pgPN
         NNCA==
X-Gm-Message-State: AOJu0YykVDr3zyxWStC0S4dpg3Jx/ofkXPgBsTpUFH8hzNHZvN4tco24
	RLsPG7UJxMJ1fad8ORedrSJhaYAes2W1dVz7PBY=
X-Google-Smtp-Source: AGHT+IGeh6YhVbXJoW6P0OtSOAVnyP5/LZNnXwEyvsciKaDbR2h6ssR8a5KNnW/HBWCUq1kZw1O2WA==
X-Received: by 2002:a05:600c:11cf:b0:3fe:3b8e:1cba with SMTP id b15-20020a05600c11cf00b003fe3b8e1cbamr1528928wmi.6.1691759094792;
        Fri, 11 Aug 2023 06:04:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:abc2:839a:7473:990f])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bcd02000000b003fe210d8e84sm8156962wmj.5.2023.08.11.06.04.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Add new srcrev fetcher API
Date: Fri, 11 Aug 2023 14:04:53 +0100
Message-Id: <20230811130453.29278-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Aug 2023 13:05:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14936

Add new functions to return some of the get_srcrev data in new and different
ways. We need two different forms of the data, one is a string to inject into
PKGV, the other is the full revisions as a string to include in hash computations
so that the hash changes when the input revisions change.

This allows us to clean up and simplify the code in OE-Core and move the
version information from PV to PKGV.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2428a26fa6..c42961cb04 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -753,7 +753,7 @@ def get_autorev(d):
     d.setVar("__BBAUTOREV_SEEN", True)
     return "AUTOINC"
 
-def get_srcrev(d, method_name='sortable_revision'):
+def _get_srcrev(d, method_name='sortable_revision'):
     """
     Return the revision string, usually for use in the version string (PV) of the current package
     Most packages usually only have one SCM so we just pass on the call.
@@ -774,6 +774,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     d.setVar("__BBINSRCREV", True)
 
     scms = []
+    revs = []
     fetcher = Fetch(d.getVar('SRC_URI').split(), d)
     urldata = fetcher.ud
     for u in urldata:
@@ -781,16 +782,19 @@ def get_srcrev(d, method_name='sortable_revision'):
             scms.append(u)
 
     if not scms:
-        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
+        d.delVar("__BBINSRCREV")
+        return "", revs
+
 
     if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
         autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
+        revs.append(rev)
         if len(rev) > 10:
             rev = rev[:10]
         d.delVar("__BBINSRCREV")
         if autoinc:
-            return "AUTOINC+" + rev
-        return rev
+            return "AUTOINC+" + rev, revs
+        return rev, revs
 
     #
     # Mutiple SCMs are in SRC_URI so we resort to SRCREV_FORMAT
@@ -806,6 +810,7 @@ def get_srcrev(d, method_name='sortable_revision'):
         ud = urldata[scm]
         for name in ud.names:
             autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
+            revs.append(rev)
             seenautoinc = seenautoinc or autoinc
             if len(rev) > 10:
                 rev = rev[:10]
@@ -823,7 +828,21 @@ def get_srcrev(d, method_name='sortable_revision'):
         format = "AUTOINC+" + format
 
     d.delVar("__BBINSRCREV")
-    return format
+    return format, revs
+
+def get_hashvalue(d, method_name='sortable_revision'):
+    pkgv, revs = _get_srcrev(d, method_name=method_name)
+    return " ".join(revs)
+
+def get_pkgv_string(d, method_name='sortable_revision'):
+    pkgv, revs = _get_srcrev(d, method_name=method_name)
+    return pkgv
+
+def get_srcrev(d, method_name='sortable_revision'):
+    pkgv, revs = _get_srcrev(d, method_name=method_name)
+    if not pkgv:
+        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
+    return pkgv
 
 def localpath(url, d):
     fetcher = bb.fetch2.Fetch([url], d)
-- 
2.39.2


