Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.9950.1631284042285197057
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:27:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bdszkf65;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id x6so2879005wrv.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IUQqwmYL+NL0642WspVHHv1ewFI7Ejx2gQf4pVpuQCg=;
        b=bdszkf65hRuyRWNi466zN6adjeK7XTe6o94QPgbfgiX9kwlUlDvZ4rGmegKu4g9Ml0
         Xuly47TmBxtyBE0Zyhmls1Ik+p6rYIP6XAB47F1N8UQgkfIrCSoeEvm3husTpHxcKeWQ
         vy+wToJlP4y+bFSAx7UzDN+VKu2XZUc6CwYP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUQqwmYL+NL0642WspVHHv1ewFI7Ejx2gQf4pVpuQCg=;
        b=Aw96uFdqJEyoPRmQRYiTSozKhqi2OQVe6fBpgbwT2etIwWPF239BEjwMjwj4QO4cQR
         MD5NenJ6iQ/fgcLujIETDChB6keSzeykki95sLHdO0aj/oj7nqbmq9TYuBRXO787HscJ
         ZKgn6ljsc5Jl3HvLqjhrK283djQiHrkZ96/CL+7I+JGdA+tEcvFUJTPHuJHlggpOEeKU
         ARvpBygXnVbHpLjl7Auj2ElyRA25uN+ukJreobagBlxrC6VR1q4+cNjdU7bCrDH2Th2R
         0po8UuNepwW58BinM7nYZSoQOumNTQgTc+NTJ2jX2ayIGjGH5tVFao7R0PXkdgd3iHMg
         8rkg==
X-Gm-Message-State: AOAM531qm/XjjCfs3j7hxvEXNWny7dGU4rENea/Pufiifp1IlrnruYwY
	6cdOTQ/TR7yWqKPMJvOV7MCSEBha+bXUaj5G
X-Google-Smtp-Source: ABdhPJyOAidWzItbVNKw3/r+IvEOF2xRn7kQYFOq4UnwTy9fWnGZBCnD4PDjQWZkvKIL6c0ksmTgpw==
X-Received: by 2002:a05:6000:344:: with SMTP id e4mr10483757wre.423.1631284040570;
        Fri, 10 Sep 2021 07:27:20 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id y1sm4737586wmq.43.2021.09.10.07.27.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:27:20 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Show error for no BBLAYERS in bblayers.conf
Date: Fri, 10 Sep 2021 15:27:19 +0100
Message-Id: <20210910142719.1257009-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910142719.1257009-1-richard.purdie@linuxfoundation.org>
References: <20210910142719.1257009-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no BBLAYERS set in bblayers.conf show a more helpful
error and exit.

[YOCTO #14340]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index e54858cf02..d6206b7319 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -342,6 +342,9 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS') or "").split()
             broken_layers = []
 
+            if not layers:
+                bb.fatal("The bblayers.conf file doesn't contain any BBLAYERS definition")
+
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
 
-- 
2.32.0

