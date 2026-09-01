Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6FC61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 22:56:03 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.217.1788303361041677075
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 15:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BepRbcKf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f96c5b722so286812f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788303359; x=1788908159; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hxX4agm2BuRUlLZT0afoMbx4+nUAf+dcDLHyYvZ2mZI=;
        b=BepRbcKf2B/pscn1BJOKQsP/lb2Zwt2h0kEjdwTpXeY7xXNqsoEXWh6tlmmfhDRvJr
         298OHC/ycf6rQ5RzxaeFNZWIYe8iVwFmunJ1kW2c04clRCQ6M2Zd8jOHwZKCepZfB9sz
         Z8xmPhlvYGfDra+UA0kIx14+in6livXZYVMsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303359; x=1788908159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hxX4agm2BuRUlLZT0afoMbx4+nUAf+dcDLHyYvZ2mZI=;
        b=GdNsk7A68TPs4YQ6LTJc0FRKssHMnCOgQLnc4PbsSbxbolKyz+5r1nJimYtkfkogbl
         KLXkaWX7BrHqpECnrXhAJK0wFPe1ffx4YgthwdzQ4rpbb0ko4gGawnjC9N7GUV6Ez/+Z
         Pdkj67RKoiaPZg9UolvbTSJMcwIzD6dKYSz8LzcQzj9ZLC0ahy+nTOQOWd+ttpm0Sr7v
         ZuuUD/wfjk1FUm+LaDMAVy3Y07AqE3h8AsvEuIl9HVGGql6aIfkY8W0WzJUQS79pekSq
         uKlr7qktVjD9mYhjuBnZuFlWxUitz7TodsNw0963yHiU6ntMQCXiwdriR6yOFSgyKGLZ
         P//w==
X-Gm-Message-State: AFuF++lirlBUdPe/8NBkkNY5azdbM2Jn4+5rCIWpAv0prHcYuN/zZWCD
	OqLrFRss1cPJGVWk7jKkaQKJqUaXQsixfNhMNUQcG09Is7LzL3eGEgUM14SE2ieCJ8AJmCltSNJ
	Q3jQpXGk=
X-Gm-Gg: AYBFou3nNi7jcSnab5pHNf6Pz7Ef5vFuv4FWk9n/vBCuUbdQ3tbwkcUphdGxTabaNgr
	wbe3qilDp7tPPQFK/vfZ9Cr0ychhlgPfP6gmcjEBQe2RGgMdJboqO81KkkbK0TLWU3pv14aj67v
	Wc7tjWJQ/n4/34RAePBFxiIQhu7HFebkLyCqC4KWhaTfuTxL5MJXBaGnUq+kHGMdQsqB6IKkmiy
	YnrqJnX0+8gSSCSvd6wQesrdDZsBNr9QsHI0wIjdSgKq5Y/2yxOLi9JPQWynSKlz2rK9hTCIz4f
	w+PCpet8UVg+2hkcgz2u/BDBL735U7HowYjxXsEfMLMJdT0F9UMvpkE00+25LYPIfn1/8+D+ljp
	nT3CT1dsuYguBYh/lwumldEzUv5MmQ3GjChqDBBa/Rx7r7nAP1oF+yVGv2vsyYNnZO+On6ajyb3
	HAuQ2pi3VPlBgQKFJrheUmUsDg8inGvgp8ZPW8w4NPYhonp8VPCZW+SJf8pGjnasohw74fnS3pX
	q3teLTjhZ0VI8TY6w==
X-Received: by 2002:a05:6000:41d8:b0:484:3621:6341 with SMTP id ffacd0b85a97d-484913b97fbmr965915f8f.15.1788303359225;
        Tue, 01 Sep 2026 15:55:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm1644388f8f.21.2026.09.01.15.55.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:55:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/5] toaster: Update to django 5.2
Date: Tue,  1 Sep 2026 23:55:52 +0100
Message-ID: <20260901225555.2254932-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
References: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 22:56:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20141

Run django-update against the code, which still passes testing afterwards.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/bldcollector/admin.py | 8 ++++----
 lib/toaster/bldcontrol/admin.py   | 2 +-
 toaster-requirements.txt          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/bldcollector/admin.py b/lib/toaster/bldcollector/admin.py
index feaa888c73a..e5677a2a217 100644
--- a/lib/toaster/bldcollector/admin.py
+++ b/lib/toaster/bldcollector/admin.py
@@ -8,6 +8,7 @@ from django import forms
 import django.db.models as models
 
 
+@admin.register(BitbakeVersion)
 class BitbakeVersionAdmin(admin.ModelAdmin):
 
     # we override the formfield for db URLField
@@ -20,18 +21,17 @@ class BitbakeVersionAdmin(admin.ModelAdmin):
             db_field, **kwargs)
 
 
+@admin.register(Release)
 class ReleaseAdmin(admin.ModelAdmin):
     pass
 
 
+@admin.register(ToasterSetting)
 class ToasterSettingAdmin(admin.ModelAdmin):
     pass
 
 
+@admin.register(Layer_Version)
 class LayerVersionsAdmin(admin.ModelAdmin):
     pass
 
-admin.site.register(Layer_Version, LayerVersionsAdmin)
-admin.site.register(BitbakeVersion, BitbakeVersionAdmin)
-admin.site.register(Release, ReleaseAdmin)
-admin.site.register(ToasterSetting, ToasterSettingAdmin)
diff --git a/lib/toaster/bldcontrol/admin.py b/lib/toaster/bldcontrol/admin.py
index 1754bc11ccb..04dd4e164eb 100644
--- a/lib/toaster/bldcontrol/admin.py
+++ b/lib/toaster/bldcontrol/admin.py
@@ -5,7 +5,7 @@
 from django.contrib import admin
 from .models import BuildEnvironment
 
+@admin.register(BuildEnvironment)
 class BuildEnvironmentAdmin(admin.ModelAdmin):
     pass
 
-admin.site.register(BuildEnvironment, BuildEnvironmentAdmin)
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index d8e48b7f3ae..6941719fc0e 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,4 +1,4 @@
-Django>4.2,<4.3
+Django>5.2,<5.3
 beautifulsoup4>=4.4.0
 pytz
 django-log-viewer==1.1.7

