Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2780FD41D45
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 14:26:03 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10336.1765463152863250845
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 06:25:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QHFfW93w;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42f9ed40b8fso111285f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765463151; x=1766067951; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w+MKpO1iFq+PRm1njJInaGAotTj17Qh3O4toYc/64w=;
        b=QHFfW93wlOk/ZdTkSkiZ8jRCJKMBx9v24Z2QD8HGDP3geXpn5C1t2F6B1FjEpPHAbB
         EVdwwOtLR9XS/uXY5BhKgzBdKHJTXnZYvy7no1gtGnOxjNxd3HnG95M0zQc4D21MCYE6
         2f/sjsQ4jopAQ+F639VoPwf+HLN2+hUmrWMPH16n/lft7cXPDYQ6yif/LFa6qJV59e8m
         QBqo95B2FpOuFZpHV+Mn99YbvK7aJDotx+sR+YHO1WavJ/R5UIy+25B1MSZ1BF0Y4zeJ
         mervYL44e4WBW9Cek12Dxe2mO+utLp6b+GmSZA4d1qsZLb751HzbCm1ZPy0ySIPxCkX5
         4JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765463151; x=1766067951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6w+MKpO1iFq+PRm1njJInaGAotTj17Qh3O4toYc/64w=;
        b=cyBhPmr1zLVEd0M21Yl+BKy+L4uiwjvk+KHKlVcGTi6PLQPZyqXuUUXYwjgHoGn4CK
         C4joRHLYlU3BlMu6CittAXf9gDnoJTN48AVS0o7ODspVnfHWO5lsOPb6vIKZRgdS0Dj9
         M8r2vlqCgH0TBHDCExIz5x75d0U3lomIFH5JRgzR+/qYD9W6WDdOoeEC0tGGamJ8hoiF
         OgVN/C/jOcG6zqhQ4qS6Z2LR/F0CO2esXzzIM5VyX2pCZ3ZmmHoX+TLdy0537HoZ0W/u
         XoQgcGcJpzpwf82OhVdaydFOPWIyERiPBfEO/d8UuAq2N8sPtPK9G2piz7XqgUdnaMYq
         cpiQ==
X-Gm-Message-State: AOJu0YzpdbrS9iYUVJZ6VLT1tk7iKAkYmpy05OunRz7FZgNZWXZ3QjdA
	avTKg5rtLx/SFzDQvhcm9gVccJGSCcxL6pGz5Xk/jnwteS4UmEiDahB1znW0aw==
X-Gm-Gg: AY/fxX63DeUpkmSiJoTEw4Ou/MTvrim9YUhd6EjA9b8JuI+H+fvqFKTSawMeKPcJgJF
	ChMfeXu1KEraH1UZ4UawatMTR9Etnwh9Sbe3z8jn4gGvrUpQUuD4OhrxLMG+oVkAXqj6ORI6LBZ
	3FxKLUfhbXmcoDlGp+cpCiMlU7jzKZSFZ1cCmwnXnuoIrdQWhB9ECPJYP16n3kLYbc4WrOF/dfZ
	PBja5zw2DA9M8NrivaZwpmn/QTIQEGlDDOfGsUrKyn1uifUensXfcrKz3ZOy5BfI8qt/9Tx+ju1
	Z/RrJBgIsVPAuL4R25BB4ovmK+ILTkAssjQgJxfg7lfp5ub8lWC+nMKy3Tucs3na6W7Kz9Buih5
	PNCEhEpX1rMEpqs/EQZVX8jGiQAVnxWb6lP9tGONwLOWkoXYwHY7TIMkzdz4PC5JgqqayUSnKCN
	Jcul3kV5kx5qT6YbgBmDx12SKugijwWwW8nmyDHbuDbKPbDTA=
X-Google-Smtp-Source: AGHT+IEfu4KLFFJX8rh27VU7utFYCJMCRzkzv2Axop06SQZiV3bgwhK7aCh5cXTX5Di/a26CH5lKpQ==
X-Received: by 2002:a05:6000:1c6:b0:42f:a990:96c0 with SMTP id ffacd0b85a97d-42fa99097e4mr2832884f8f.29.1765463151059;
        Thu, 11 Dec 2025 06:25:51 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a70394sm6214200f8f.14.2025.12.11.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 06:25:50 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/4] bitbake-setup: override complete source entries, not just the git-remote properties
Date: Thu, 11 Dec 2025 15:25:30 +0100
Message-ID: <20251211142532.983960-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211142532.983960-1-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18568

From: Alexander Kanavin <alex@linutronix.de>

The code was assuming that a source entry always contains
a git-remote property, and that is the only property that
should be replaced.

With upcoming introduction of local sources (using 'local' as a
property as an alternative to the existing 'git-remote'
property) that is no longer true.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b1d751899..8d4e9769a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -323,7 +323,7 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
         if k in layer_config:
-            layer_config[k]["git-remote"] = v["git-remote"]
+            layer_config[k] = v
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-- 
2.47.3


