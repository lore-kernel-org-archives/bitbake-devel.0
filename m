Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC454C44517
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 09:52:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10155.1784281976198680136
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jul 2026 02:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=e9dGhMVW;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so21982035e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1784281974; x=1784886774; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lpQ0Dy416Z3LFmq5pln7ig4jBSrYUUQ0JIv55X/CjiE=;
        b=e9dGhMVWRP0lgUp6ma+zdX7Rw2+voH/xk84h3Hpk3+H6Ah6/Q9r0uJQpBOGBSWrcE+
         /w4LW8GAE63jP3nZSsXgTexll87g3pvFBwHGfvxwr2TFDxER3Qu9oy6gD3Dk70sGT31K
         6aUsXVLVyYIiHVtZUjaK7tBmqj9VrkrrU5s40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281974; x=1784886774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lpQ0Dy416Z3LFmq5pln7ig4jBSrYUUQ0JIv55X/CjiE=;
        b=b2FjHgDLsdCAvnLJM/m1lWLi5nqAS91KEHEl4YNlvayozsXQq/PVDTT17gfy+hCFe6
         7PuOqXzsa0GS/gE9ux2IEhGaPhYJ8+ZxF2cANrDVT1mJrlDOPg/Gz3xjW4jkDtOA6Jsz
         7G1pxmXiAhedmgTpJVuSHkMZDIyuoeC2r2mBMC0rlVCwVLb7oCwLbLV55khWCIPwkxWJ
         8KB88a11HPuGaFnQ6Zgj8DaiNwCiQLD3/5pBNEOgS1i8oPr8IBp+wmYJhyXXrIPxcKkg
         jPuOVbi+GjLzHbAIN4+zh9JsPeE4hkHA19oYqt7c+7UaWgD6fEb82UxqKMrf+hVSFrEG
         ikWg==
X-Gm-Message-State: AOJu0YzptKrcxogUI0+8SMGnrL3zGp3V++iY9v7ReD0tgl6A+W4GkP/f
	O51RQe1Cm+G1q8R0AedproJZ9HKNr4e3Rl3RepFT17fixDa9n8WmIxrI4pqMJk5YhaAeo3+rKE1
	Zqa0qX0Q=
X-Gm-Gg: AfdE7ckIfN1Xx7SdvFmhZEduXkvN1dB0z7r6IEU8+ItrVuQuIbMhjs2tFRVRkmMZ1IA
	h3HLUX0Zu+5p1DAKj/WzV5tJKtLDbi9pKDpKb7CM9v0XbqGcr7j0kszNfK3TgdOjVnBBl0v5ZCV
	KCLuctHxKRobbkfP0tUxTkp2VaErld5JV6PdvwkA1GJ4XcnsejTnSLZl4MLvpYgLzcMy37Kak/J
	fuLn8bc2QYeuiVQ6P5Aqki/DlE0LJPrvFecRN/V7C1jeX7AMZKJ63Gs1c5R0dYcZkBERw8vQXp5
	Q0n32zCpDZnf8mb6cZw8n2BkAZE+ZwSS76ekMewvDWCSrtAqg5iJABz6HKFZUxNhfTpgVTa/Oe/
	J4UfewrfgU+LmGLP7RQ1+s7eRxrQf8TGrG93t2ghHMIfT6yFxA9fo0ByGHuvScwEpz669eo+z0X
	Sv3ppgKCIZ26zwuPS7N2aG/iaBu/L+r5Roke/MQtiIahPnrJe11bpmrOm1YqvgbQs6hqnREfayz
	DNkRBA=
X-Received: by 2002:a05:600c:3143:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-4954a3d0cd7mr22619535e9.2.1784281974326;
        Fri, 17 Jul 2026 02:52:54 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0093f4151e9fe9f4b8.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:93f4:151e:9fe9:f4b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c9c929sm32932095e9.12.2026.07.17.02.52.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:52:54 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/2] bitbake-setup: always write newline at end of the README
Date: Fri, 17 Jul 2026 11:52:15 +0200
Message-ID: <a39c273eb6915ab5a1713695b3fd46c52ecb33bd.1784281828.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784281828.git.yoann.congal@smile.fr>
References: <cover.1784281828.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 09:52:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19842

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

When the "readme_extra" string was introduced, we dropped a newline in
the "readme" multiline string. In a Python multiline string, this counts
and therefore we dropped the newline at the end of the README unless
readme_extra is not empty (i.e.: unless the VS Code string is included
which includes a newline).

Put the newline back into the readme string and edit the VS Code extra
string accordingly.

Fixes: 92fd721941fd ("bitbake-setup: generate config files for VSCode")
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7e6466f48191c1e4ab9b91705deb237eff2c7f01)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 220540f7f..4d75ad612 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -415,12 +415,13 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     readme_extra = ""
     if init_vscode:
-        readme_extra = "\n\nTo edit the code in VSCode, open the workspace: code {}\n".format(workspace_file)
+        readme_extra = "\nTo edit the code in VSCode, open the workspace: code {}\n".format(workspace_file)
 
     readme = """{}\n\nAdditional information is in {} and {}\n
 Source the environment using '. {}' to run builds from the command line.\n
 {}\n
-The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf{}""".format(
+The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
+{}""".format(
         bitbake_config["description"],
         os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
         os.path.join(bitbake_builddir,'conf/conf-notes.txt'),

