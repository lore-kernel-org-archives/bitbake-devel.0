Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F2FF886D
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 09:31:21 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7632.1777455077790970521
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 02:31:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=gtp3l0xN;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C17541A347B
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 09:31:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90378601DF;
	Wed, 29 Apr 2026 09:31:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CB3E10729A5B;
	Wed, 29 Apr 2026 11:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777455075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZrLFkNvZ9e9PHtFy7sw1zpSa/HMQ0fXhIQDAscyhFT0=;
	b=gtp3l0xNF66B9kbmdIOb1Dri/dCy/2Xcdb8uEtAiWX8YxMj3Mi+TaVlS3u0W11baQ6rapa
	WmbSBLswWzSK3vemxRcCKElCfqeYB4UaVrvRHLAJu1B8jykHcQTUsvpeW9nzmv2V9ERO7W
	OiO3zoUphAToArSp/644t591t63NnXCedjZ3SaMsC/HSITrW6bYEH38BO1bmyR6A8PzLxx
	e7IvDIZWoTu/5LVUXqYNkyOpTL1GwR7mEHUpoejz3NdAw8Bzb9rdZXfr+Yop5i6l6S5gyE
	o28YeZUwtmDt9hmPnBwhLKJwm6ojxJbm7I7muf5JQP81hSR0/n8+IMPAGH3ApA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 29 Apr 2026 11:30:49 +0200
Subject: [PATCH] doc/sphinx-static/theme_overrides.css: switch to a fixed
 width documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-fixed-width-html-v1-1-c5673a4828d6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPrsQ0yraq4gP1YxmxdqSpFUQ7
 94EHz+Y+Q/ycAJPj+wgh594ea8RRZ7RYJ/rBBYTTVrpSt11w6PsMLyJCZZteC3coC+VQl3rGyj
 ePg5pk5Jtd9l/+xlDSB06zz8IppFBdAAAAA==
X-Change-ID: 20260429-fixed-width-html-9eb500e8823e
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=v5Y816xMwHNLRvcUbl0ohzdfQRO6VU5aaeO7Xs9GoJ0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp8c/iNMuq2q3gk4agJTlTU4L5OiMPs9U+zO0DO
 G5K5O2V6mWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCafHP4gAKCRDRgEFAKaOo
 Nn4FD/9IHAYIoAcfaCpHA8wxCVjC1qaTrTbLqXweCHVHNqg9R2Ac27DLAsH0ncPaGRuTdoPdCl8
 KkBDORRvplr6Mw11Aqi/aiD1292V7vga4FKuecE3yiOb7tcHxAeyZNIpiE2wd8HAQKM4RnWlZG4
 seTdkQn7h+/AafHlhNDd0FaPGVYkgXkY/nAKiIY68FmOkfAFNrNllvczSQR4BPLsjHFVwTpLa0+
 w0N0MU2OXC0VorlipuD8pC7cDagKLCWz3uIRkY1SxW7nlcRnfHRczXj+3BtePzaLB4ynOe42SED
 aJSe9LVXQTrwwVovUjTcoXNaXdqyIAAYT5Gz5kCxP344J2CMHDREp5OB+/k7dJGwIGJQ3Fu/onl
 Gyif+pXp41ZMcajZPesNRBKMqACgUkJlaE8sL89E1KLu9SA9TyOkWtEjyISr1PDnDQ1mMJ3L/Zd
 V98LzKWKsRosq0iGfr4JAaeoNEqVkCdpmR41hXEytxP104NB9t4L6gntWQtDk6hMlPaN4FaQD0Z
 /zufP/Va2YnhpLNEwEB6A+ZXjvrVE6Jn9Fu1lZlI3vD5Yvtnqghw1zNnHc77ML28pyLNrjzrSA9
 EKzTL3QobkDwKSmg1EoXQNEAdAC4FLFk++Bq3J7tKh2QQzHiGHKsWg6aWgn3Vni5TZ0PlNkkKAi
 0YG1mClbH1Awm8w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 09:31:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19413

Like yocto-docs[1], switch to fixed-width documentation for the HTML
output.

[1]: https://git.yoctoproject.org/yocto-docs/commit/?id=98234c9d3a0846d719630914bea8599da9f51374

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/sphinx-static/theme_overrides.css | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/doc/sphinx-static/theme_overrides.css b/doc/sphinx-static/theme_overrides.css
index e362677a7f9..3a303c8e1ce 100644
--- a/doc/sphinx-static/theme_overrides.css
+++ b/doc/sphinx-static/theme_overrides.css
@@ -99,14 +99,19 @@ em {
 [alt='Permalink'] { color: #eee; }
 [alt='Permalink']:hover { color: black; }
 
+.literal-block {
+    background: #f8f8f8;
+}
+
 @media screen {
-    /* content column
-     *
-     * RTD theme's default is 800px as max width for the content, but we have
-     * tables with tons of columns, which need the full width of the view-port.
-     */
+    .wy-nav-content {
+       max-width: 1000px;
+       background: #fcfcfc;
+    }
 
-    .wy-nav-content{max-width: none; }
+    .wy-nav-content-wrap {
+       background: #efefef;
+    }
 
     /* inline literal: drop the borderbox, padding and red color */
     code, .rst-content tt, .rst-content code {

---
base-commit: b79667b6599494a0ed209d48bf8bbb7e8921d926
change-id: 20260429-fixed-width-html-9eb500e8823e


