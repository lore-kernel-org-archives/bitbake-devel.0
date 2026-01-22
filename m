Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD491C44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 08:09:37 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32955.1769069367652013309
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 00:09:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d45GDL1m;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-435903c4040so391050f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 00:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769069365; x=1769674165; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3G70b/X5XXZI1BX6mwo0H39NMCVFCVpKHr5c3QUrt/c=;
        b=d45GDL1mZuAI/wqUk1UUbe6z4y9fIOBZcU6F4xLi244IkXZ1e/7jPNgKDWOlsFx92u
         wbrPBWHTLO28E1BfEEJyq6jzJu/MTYnRYjXSpOortOBrgLZQbrK8mFj7c4OrJ9cydDUk
         9LqnUp2GuqeHNnMJDDWCCLcdz/W7uqpdKSQ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069365; x=1769674165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3G70b/X5XXZI1BX6mwo0H39NMCVFCVpKHr5c3QUrt/c=;
        b=P5FgQdSIMEIwEbSUZGTrRYuq8OLw1DVJCp/fPCiklsWpXh2KqvQJ/hhdsP/3Td8ulL
         QRHwR7wlC6NxFEzikpHih3Hxv8dYZiY888d3SC2UqvgbJP+dyzKXG7Y39TVvp1dtiRyQ
         PbfH4Mf5GgzsopgiCFySc2DiABP2tslN/HEE/ZEXXa8BvbNPUgqhC6otVw+EsIxk1Spt
         Mmo5rn7Wmguta0ncPZ3cjPyrMsS3hyE2PB+6YWQbJhITZEjpZI9oV/IQYSZ3uhkbzySf
         BbeMpNFtOTyq0N6bO/EluSLbTTSFVSFR8v7MIb+GpJ8Ef6gCdX9hdLZ5Ve3qeh4WmnuT
         e0Yg==
X-Gm-Message-State: AOJu0YxqSPpMpLsO4YEwBgTmJTtJ12mcCGJIT0B6CnoPpnSk/ifygugl
	LPfMzViAtoqQrsZ+Gbo5pZH4cunus9/nz+TuJrYq6iwDlaufCfYJf9yZFr8oRxpJ45TptNA//5Y
	RTn4xgc8=
X-Gm-Gg: AZuq6aIVgzVV3nuUOu5gvricm9Fk2IUgx3yIMTxDEEmdIdadtGbCL07S+WNmjTwwcCl
	KlcP3iz5lK4CxukxhL3kNobpysDtX73JCZTZYjgyjFkb71eF+UNUbF2DNn7dRdxoNPuFy8FiwJz
	c4y8S8R0xuoshpqUvcxSWQIgHfumsVK4tjlEB1crN2ng84ablst9bqVdoY2NaBgjKzENvMOHqjX
	DvmqCzSkmnR8T70gjqGOkVSqR6tyYV9qkkO3G0NlviCK0dE6WE8gGpY8rlGtTaucBCreKkjOtHT
	avKIT/rhiTQzmgG3h4iYxyGKlB3o/amD+XJocn6oSyXRMpVOeRnZB/H6btPKQR25hDkeCSOgkST
	4hohOj525toQu1H/79P290puPPISGADCATYS4auBILhcCOMjt51RSB2uKItxrmwQOo2k3qI/abq
	XVRcpWPiHy3PkN5wq0tL0VK1a9QEZSXsACa5Jjsh4=
X-Received: by 2002:a05:6000:1883:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-4356a0538c8mr32750960f8f.38.1769069365041;
        Thu, 22 Jan 2026 00:09:25 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dddsm44589731f8f.6.2026.01.22.00.09.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:09:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3] fetch2/npm/npmsw: Disable npm and npmsw fetchers due to security concerns
Date: Thu, 22 Jan 2026 08:09:22 +0000
Message-ID: <20260122080922.1695912-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 08:09:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18842

We've been made aware that are security issues within the npm/npmsw fetchers.
The issue is that the code accepts data like checksums from the upstream
servers, rather than verifying it against local data from the recipes. This
means the upstream servers could feed aritrary data into the build.

There have been maintainance issues on these fetchers for a while and despite
asking in multiple forums, we've been unable to find anyone to help fix the
issues. Until that issue is resolved and we can be convinced the fetcher is
secure and modelling best practices for reproduciblity (inc. mirroring), this
patch disables the fetchers. This has been discussed and agreed by the OE TSC.

Parsing will not show errors but the recipes using these fetchers will not be
available. Recipes will be skipped at parsing and will show an error if a user
tries to build a recipe using them.

The import is local to the function to avoid circular dependencies within
the hashserv selftests.

[YOCTO #16105]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/npm.py   | 6 +++++-
 lib/bb/fetch2/npmsw.py | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e469d667687..72a24c8c35f 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -150,7 +150,11 @@ class Npm(FetchMethod):
 
     def supports(self, ud, d):
         """Check if a given url can be fetched with npm"""
-        return ud.type in ["npm"]
+        #return ud.type in ["npm"]
+        if ud.type in ["npm"]:
+            from bb.parse import SkipRecipe
+            raise SkipRecipe("The npm fetcher has been disabled due to security issues and there is maintainer to address them")
+        return False
 
     def urldata_init(self, ud, d):
         """Init npm specific variables within url data"""
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 2f9599ee9e2..322c7b331e5 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):
     def supports(self, ud, d):
         """Check if a given url can be fetched with npmsw"""
         return ud.type in ["npmsw"]
+        if ud.type in ["npmsw"]:
+            from bb.parse import SkipRecipe
+            raise SkipRecipe("The npmsw fetcher has been disabled due to security issues and there is maintainer to address them")
+        return False
 
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""

