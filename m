Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBCCCFA1A
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 19:06:48 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17906.1762369605489517917
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 11:06:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L3M9gcW5;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso732222f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369604; x=1762974404; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt7a4edqAH7FZkPhUvSfQU8sQSgPwBm4w+DubrVJ5eE=;
        b=L3M9gcW5CIttw1xthWP4wfwLRobOr+P1EcZFN3poPvIr3r3Zo2bGfBNgp56J8g5KNt
         9Oo0ShNxjM79m+FXTh6IURuxKbXj9a3PsoTgKVbtC3jJgIF0tPIy/2O1V925U3ch7can
         2XW10+T4fm/jSBrTp7ZilLSAfJp4fU0M+EGwyommBatuh+eJHL3jf+AtpUa0GWPyged3
         YVuPG62kuaMkvYJuhFaLSVd4/92EAmyAs4Y/k+Mj2JYEkZU6ei9D5FpqDT9iEkwcnjzM
         5RONhQnDSxZTc4Ch4OK72HfvYEIH802i8xKl9hHSzmTXhOIpWqlwCWWcQDO0bidNfKCR
         XKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369604; x=1762974404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt7a4edqAH7FZkPhUvSfQU8sQSgPwBm4w+DubrVJ5eE=;
        b=s/utD2KHQH42hMZztdD/uQrHf/Bf89Ff5YfVodUd9Gjn1UGeTo2YsvaIE0JaDP/rxg
         0xjs7i47nLz0fEsfk4lcIkV4bUALZYGXxQUzRwD1EhrH4Dm4LtEYff7CD9out7Qbvgkx
         xE8xm5eejAIbk/5xlbubeQifxH/35x9j5R5JNyYrVtNCLTwoA3+uzmOtkszG7yUWzKGP
         /ufGPhWen1PRdWCdFh5cdFaojShb0hkhMuS+KMsld8S3oVB71hyimLFxjo5a8veh4Ral
         FNS4yKxkGQV+mY7mZgtD4eYO/fEBoILADh66PCJRRXZDLZhfS56LCgrIsoyhgxpPXmXe
         9lrg==
X-Gm-Message-State: AOJu0YzjudQKBOosmUbr2qqNIkwTfUb+3QzY20Y69A3X3LcG6hapujMB
	vSkecJgcoGh4JQjNaEc3Elust60IpydnwcHAEvGev689defrUxKdCkvb9DoPZA==
X-Gm-Gg: ASbGncsiAGV8CvW+aSVSnld03YtpS7LCuchtAVwHvUBLMOWSV8ozdFrlesHeuqGp3nu
	I3HSU0gGnVEyXDkVptTDmEz+VhA8JpdglAOcsBxb3QN+yz4xXJSU4ZdHioyikEhzaLOpJhd0QUw
	dxlwLp4UPpiP19ZNOE/ZSprBxvQAQqwPc/z7MqaVjN5RUmlnX4UPHy078JIrA7YnAJom6eb+Cdl
	FiLbwFdsQzmtznGJLJ5jP+AFev3p3PUskukvI/2V9nJPQ5mYQUGDyUGw497Qq6ifpXWzsg9FEyK
	aAUGoxwO/gtn9kC1jOc2FmRY5BNlqHRjbt9Wmn4V/ck2LvyjpMDO9x1OChNwPm8Y12+iISa5qNO
	frFtF63ZhmQ7XesLQjJ0h6nrk48ZnTMmxCWK+zqp9NTb+O0uJjTKtil9JtEcPS8RtBsRHEcloT4
	Vplx4q2woPJLbde269wtk/oPch/Xpn8QaacJhz
X-Google-Smtp-Source: AGHT+IEdsNzZHA79NebXgP1hSicAdqHb+AgXXFHKCOQyuXrGdhK/w2FIUIvIUh96Sm3vh6ctdXer6A==
X-Received: by 2002:a05:6000:420e:b0:429:cff0:1929 with SMTP id ffacd0b85a97d-429eb1a2c1emr518330f8f.29.1762369603875;
        Wed, 05 Nov 2025 11:06:43 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm313840f8f.29.2025.11.05.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:06:43 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 4/6] bitbake-setup: checkout_layers: construct 'src_uri' separatly
Date: Wed,  5 Nov 2025 20:06:34 +0100
Message-Id: <20251105190636.679388-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105190636.679388-1-alex.kanavin@gmail.com>
References: <20251105190636.679388-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 19:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18273

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Construct the 'src_uri' separately, and then pass either variant into
one call that creates the Fetch. Making use of format-strings to
shorten/simplify the code.

Also: using 'proto' instead of 'type' for a variable name, to avoid
the protected keyword.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 59b4dfdb8..ff753557c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -90,13 +90,14 @@ def checkout_layers(layers, layerdir, d):
         remotes = r_remote['remotes']
 
         for remote in remotes:
-            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            prot,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
             print("    {}".format(r_name))
             if branch:
-                fetcher = bb.fetch.Fetch(["{};protocol={};rev={};branch={};destsuffix={}".format(fetchuri,type,rev,branch,repodir)], d)
+                src_uri = f"{fetchuri};protocol={prot};rev={rev};branch={branch};destsuffix={repodir}"
             else:
-                fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
+                src_uri = f"{fetchuri};protocol={prot};rev={rev};nobranch=1;destsuffix={repodir}"
+            fetcher = bb.fetch.Fetch([src_uri], d)
             do_fetch(fetcher, layerdir)
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
-- 
2.39.5


