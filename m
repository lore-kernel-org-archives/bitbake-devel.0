Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C7E7717A
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:14:04 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.17029.1733418838097559850
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 09:13:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U990bKm2;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385dece873cso667868f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418836; x=1734023636; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsyHWR+7C2p9Is5Zgx7ReXXJAj65L5Vs+zIIl6m76JA=;
        b=U990bKm2Z5QmSGMnBghmAFMc9MAeFdkVtN6TZm7IQv/njgMTTrcy+t9q47CewowTcK
         cdOT2MvwVkxjNgQ/xeX2kerwA01tK6kh+8DYtc2Xr9LlSxM93RkTbrkXc2Ub9EdhfuIg
         N4+WszZeSHsBz5wF4uh6FUxTn8iD7OyYTpM8YOAfA2uRXHCV1TuvPMvOS2j9GL9M8pin
         +7YzkwZotqbz2UEwWDrLWoxg2vOauv4NgEh2wRwMeUvAyg47qDARiCkqvHfwaCOacrI/
         QVK/akhs3g2kHKhQpAT/uB0wiUjNLGH9pNjjcXCNpX3wlA8/YvN1GQa8cocjW1Pz/Tk/
         8h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418836; x=1734023636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsyHWR+7C2p9Is5Zgx7ReXXJAj65L5Vs+zIIl6m76JA=;
        b=NgnrlQ8emC/WzT0dj/B0hQqKiWoYgWOeh8CsetaSDoi7WqVlhMK9BZPwnKte03XNoo
         7nesHUKvKyJIW8YnbeYjUidifV14X99vEixsFbNMjT+YeYusjTldiy4hi+BWbnylQv08
         flKm/aevWzhDVPBq3Im/mnaJP6GoJmn+sdNFHeSlYKzl+KaeoFPlFTvvr1H2TzM1Hqtq
         XIOZJN1Fkwbghd54ORfbkMAxS6girUpjDlsKnj9il/rOu4NT84khX09iqDoCbfjy66An
         Qc3DGzt5mzYuM9DOOLVB11hNZch2sWXASbm/GinR5XQG3HGqeR2m6Ilmz46M1lT4DyzM
         lzNQ==
X-Gm-Message-State: AOJu0YyTiiatvDQxAdU5qpuQ+AmOYtJ4REn5AZ9kj/6nLee0QbNy9nYk
	Nr04fkmIkyry0GZ68A8vMEPs413d03grvEty9C53XeB185IF9at5Hmkutw==
X-Gm-Gg: ASbGncvC7nMx4Ks0SNuQdI+Pry1bf+SpNKrUhmkzP5ICxj2mS4fMUQB7lHclVJ9CVoA
	/haJCze2YEqIvwFdSjUhKQMpljlAnWNiBf5ytRLrc0/nRmlp/jn2YlAUcH/0L1P5jJHQQG+oagL
	g0wvIC2ggRvl7OLaRr6j/IaJLnxzjrEd4vNIS3S+EjlOqTcKkHSG0P8xIb/qUX4TSxo7wvFZZB2
	ntV4RY1sX0p/iTkrfUQOZYAtEWq0/ZZJYVp/F7G75VGSekVE/tRAnZ0PFZa+fDHhpemhMCLmjxd
	t4IVu7VYJxU=
X-Google-Smtp-Source: AGHT+IEySqyclzDAelRCZ0PUGKOmwLeH/idsn+dAXV5amITcAswZcYYXCNVF4LzK5yeMpXn734hOng==
X-Received: by 2002:a5d:588b:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-38607ac1ad6mr7514237f8f.13.1733418836290;
        Thu, 05 Dec 2024 09:13:56 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm30238775e9.35.2024.12.05.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:56 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v5 3/3] bitbake-config-build: add an alias to bitbake-layers intended for managing specific local configs
Date: Thu,  5 Dec 2024 18:13:39 +0100
Message-Id: <20241205171339.4051793-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205171339.4051793-1-alex.kanavin@gmail.com>
References: <20241205171339.4051793-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 17:14:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16886

From: Alexander Kanavin <alex@linutronix.de>

This was prompted by adding support for config fragments (in a separate
commit to oe-core); after some deliberation I concluded there should be
a separate tool, as bitbake-layers is already somewhat over-stuffed,
and this will give space for more build/conf/* operations in the future
that anyone can come up with (such as tweaking site-specific items
in site.conf etc.)

The alias completely reuses existing code via symlink and
the difference is in where it looks for plugins.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-config-build | 1 +
 bin/bitbake-layers       | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)
 create mode 120000 bitbake/bin/bitbake-config-build

diff --git a/bin/bitbake-config-build b/bin/bitbake-config-build
new file mode 120000
index 00000000000..11e6df80c4b
--- /dev/null
+++ b/bin/bitbake-config-build
@@ -0,0 +1 @@
+bitbake-layers
\ No newline at end of file
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 7bd3ea20e47..341ecbcd971 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -18,13 +18,14 @@ import warnings
 warnings.simplefilter("default")
 
 bindir = os.path.dirname(__file__)
+toolname = os.path.basename(__file__).split(".")[0]
 topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.tinfoil
 import bb.msg
 
-logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
+logger = bb.msg.logger_create(toolname, sys.stdout)
 
 def main():
     parser = argparse.ArgumentParser(
@@ -67,7 +68,8 @@ def main():
             bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
 
         for path in ([topdir] + bbpaths):
-            pluginpath = os.path.join(path, 'lib', 'bblayers')
+            pluginbasepath = {"bitbake-layers":'bblayers', 'bitbake-config-build':'bbconfigbuild'}[toolname]
+            pluginpath = os.path.join(path, 'lib', pluginbasepath)
             bb.utils.load_plugins(logger, plugins, pluginpath)
 
         registered = False
-- 
2.39.5


