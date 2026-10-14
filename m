Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D342CC6B27
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 08:53:10 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8882.1791967976750307575
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Oct 2026 01:52:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Aap4EsxU;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so31623105e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Oct 2026 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1791967975; x=1792572775; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eU/yZXXNzOrokUXiJhszOHbMZpOo45xHE5+ESNnchZU=;
        b=Aap4EsxUTfz4ciQJcx0fCk4lyIVlinVCg0ojWePMxniN86E/F8JDMtdLnEwAali1vz
         QSFOmdoms8/RFXHjgDV2MVQORRPUqE5Qr9nk4L2WIuZF8DAidR4w7V6Wtv3zebfUITWC
         ToV/4NWdBVnGXp9ZtComCEjA6ex8lfz3as8KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791967975; x=1792572775;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eU/yZXXNzOrokUXiJhszOHbMZpOo45xHE5+ESNnchZU=;
        b=OKmXUmV5z9v1/gb0gRtT3Vs1M+nU2UMqjd/BgOYXb3hTngXwrVhLfgRP/o1LRQraBb
         DK53Ii8xJWwAeyC2kZW+VujAWfyUaj9ASk0B0o9KLZCkD8GeuciQedo+ke4JwKEMiJT+
         JdhUaBavYbl03g37CCb00Qc+IpwzCBUTZKAks8ngtjCewP8ysFreS65kfbSSWoz94WOk
         IVHI6Y/AZvS7tqehunlqXXx5oXz55aUOfW0v+RCSReZvtLMtvpX3tSeu7TehebZ6fKod
         eDBNdM98I+Ajp9EK54b8vZjkrkHMPhltJQfbPODabODCKtWMtrBw5AfKwJIVxFXsnNye
         jkQg==
X-Gm-Message-State: AFq9FYI/u+8ZRKbPmlxhTmkUFhEeSgY8zklqFoq0QVUaqA2cgb0hjT8D
	sRwAzMrp9ALOqGHluPPAK6LEqE7DSUhcnEPErD8Z0zO7vgw9fMUkL0rUNagKUjllDSQ3z4jM/+P
	1vFDrx0c=
X-Gm-Gg: AYBFou1lJq/i15fBFBIHcFo/Co/txmR/40LmJTHmy3hv5cDMN+Q4aINkqxHEbfrctXP
	8Ikl+X7Q22UPFxhf28IpPKEA3BCp53ZSyflQJfjw5RtsAYKDWoB/V+o+dy5+LzfT7EZnGsUeM5l
	4swGzHn12tI5PANyqw2exzJWI8IZ4g7uFRAm4LeTXYsc4cFN003na33X0lsV7+d7W7252x4K6Ef
	2xnywuKoOJXy09eg98MH1LyL1YjOrxK4veWj0HXHUyI5oghoVSAqK6RFSMz7fa6jifz/6uenKrv
	vfQ9IrhnZ9zlrZwdRiV+xq8/vEn6w4+re+fhmbgZdeIPvwg2noOqDN/0tA2+RIgNQd2ROzair+f
	GGkOgMM2SZJgfPdvpnV+8mOqx/Sh5xptUeYMjjRog6CsEL3/wDnBX0D1Uvi2LdPhE2G+hR3p5UV
	02ot6ESCpIvXYzz1FBkoCDgJPpAJGb7X8dE5a8jVKJJ05EEm9L7nobwyKnrDkWatMpqj3uqE9qW
	u6NYOYMj+Umio6eppQhEJGpDRsiHQmb/WHUpQrgzsLB1xEtRPTCKnFHQ9lMS2sbJbwr/LgHI1zo
	6MV4/qliV8AJQMdc
X-Received: by 2002:a05:600c:8184:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a18e4d854cmr264648345e9.31.1791967974815;
        Wed, 14 Oct 2026 01:52:54 -0700 (PDT)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm626222525e9.0.2026.10.14.01.52.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:52:54 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/1] Pull request (cover letter only)
Date: Wed, 14 Oct 2026 10:52:39 +0200
Message-ID: <cover.1791967883.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Oct 2026 08:53:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20340

Those are the patches from the last patch review:
https://lore.kernel.org/all/cover.1791708353.git.yoann.congal@smile.fr/
(no reviews, no change)

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4920
* qemuarm64-armhost failed with disk space issues (now fixed)
   rebuild in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/8/builds/4855
* oe-selftest-armhost failed with #16450 – AB-INT: gopkg.in connectivity issues
  rebuild in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/23/builds/5086
* oe-selftest-debian failed with #16236 – AB-INT: test_list_pkg_files: ResourceWarning: unclosed transport
  rebuild in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/35/builds/5058

The following changes since commit 51fd94a67fa17650a9ff623492005972bbc7d26f:

  asyncrpc: Close the client event loop when the client is collected (2026-09-29 11:56:42 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

for you to fetch changes up to 6e260eb6ab1631607ea414d9ff8ede1155faa5d9:

  ast: Make PyLibNode support submodules in BBIMPORTS (2026-10-07 14:54:15 +0200)

----------------------------------------------------------------

Peter Kjellerstedt (1):
  ast: Make PyLibNode support submodules in BBIMPORTS

 lib/bb/parse/ast.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


