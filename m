Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.9667.1631282863942605055
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XUvLyeZd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id w29so2057345wra.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OWoeRQmss+A1S2hOb5yi7ZDQciRuT5INNJxcFY8D1gs=;
        b=XUvLyeZdpTuajFq72JifLFJQbs0+/ZGHuixABt7LuOLxPafvzEMMgLB8inNKSzwwhs
         Mf+itM227AapJtxrEblX+pa3FSfJ+7f828+j2BptO45wj1pGtA2dt1CG73rSsHadW4vB
         AF1+46l+TOW49Ag11bwWkeQsgQhTSAX1dx/3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWoeRQmss+A1S2hOb5yi7ZDQciRuT5INNJxcFY8D1gs=;
        b=oc1tqT6rI77oo+bUqd2Md7k4tzPWQbHxZgYtj14Pj6eVrxUgVOM9eq01hUSVn1FuZR
         0YfCllh9TMCoZNH6H06B/MDVPuREl45dSJZv+g9Psza+LW7tONX2AIrv7m5Ao0lw8f13
         r5HevSX+PstEtNMcUyZArPZBTkNDhliVY4AFVm5Oqe6FPF0y/johuMoIECHI0PqCrLPo
         GLuswEt3sudxOW9hDBncRcRoC8GQgup7pNK4GPH8Vu3Q+MmG0uJyJOU7wyumYe5rTgvT
         xKVrrWGtYZoUJXs2HbZMkEWsxnwRXU4bAf2+CbGNGyTRLWYhI9ACbBMiyIRcQ021O99m
         px3A==
X-Gm-Message-State: AOAM531zdDxRF7ag7NBXcVrGzqObDiSxsnPSwNHthQaY/hyfOCGgnNq/
	/L42dj/jI6048FlJgUgMYbwPSPiuKUXiwgSA
X-Google-Smtp-Source: ABdhPJz+gu6nsvTpx2xnObdKkP3E6w7DFqFT49Zl4JzKm2He7F0oYBUuGgT8uhMKT5s0GkN1o4rTSA==
X-Received: by 2002:a5d:4e51:: with SMTP id r17mr9929272wrt.308.1631282862466;
        Fri, 10 Sep 2021 07:07:42 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id l10sm5292231wrg.50.2021.09.10.07.07.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:07:42 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] fetch2: Add recursion guard
Date: Fri, 10 Sep 2021 15:07:40 +0100
Message-Id: <20210910140740.1256597-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
References: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users sometimes put ${S} references in ${SRC_URI} without realising this can be
problematic. Improve the error messages if they accidentally do.

[YOCTO #11593]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 47a4943369..d9e1599a05 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -754,6 +754,11 @@ def get_srcrev(d, method_name='sortable_revision'):
     that fetcher provides a method with the given name and the same signature as sortable_revision.
     """
 
+    recursion = d.getVar("__BBINSRCREV")
+    if recursion:
+        raise FetchError("There are recursive references in fetcher variables, likely through SRC_URI")
+    d.setVar("__BBINSRCREV", True)
+
     scms = []
     fetcher = Fetch(d.getVar('SRC_URI').split(), d)
     urldata = fetcher.ud
@@ -768,6 +773,7 @@ def get_srcrev(d, method_name='sortable_revision'):
         autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
         if len(rev) > 10:
             rev = rev[:10]
+        d.delVar("__BBINSRCREV")
         if autoinc:
             return "AUTOINC+" + rev
         return rev
@@ -802,6 +808,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     if seenautoinc:
         format = "AUTOINC+" + format
 
+    d.delVar("__BBINSRCREV")
     return format
 
 def localpath(url, d):
-- 
2.32.0

