Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web09.42387.1629220894619815531
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Aug 2021 10:21:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=SRS4vfiC;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id o20so104951oiw.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Aug 2021 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOt1J8oeNsq//K+ha8xnUzk3DNzwc7TCWrTLhU8d6E4=;
        b=SRS4vfiCJbcmXzZNyyb5ocpr/MpOYXIS0JmeoNFp7AtNhwspoLpgoOqP2EdM4qlB86
         R+ITKAoMUPIN+qkDQSjnK1IDkBHAuMkKpLnq6mp/6xrUTN9LsZeIdVKmgSP/usllszGS
         eFcutXfiBc8fbYv3V2t2x351qVX/y2OCc6LBT6Vb1uViIBiV8E9QlgsKLR1l+Ro8a3pm
         oedr0pfC6aMS+WGRt2i46qSNtVagivNg2mo7io8M5azKgGNcqQWSocqMPANKHGzgIGBu
         aJIFxm0ft1zj6EExGfDjXOtxO2CC8sWW/ZwZpDY0zF9F0LeUQiNpzNqlft0A4upI3XH7
         x0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOt1J8oeNsq//K+ha8xnUzk3DNzwc7TCWrTLhU8d6E4=;
        b=NbBxxyd4wtlSp2AtiAG+NsnxDAXvxlIDyjPhpCLkBU1GXl6RbQHoYE1wWENnIFsS96
         BwPVpZpvvVr3o8FJhX/Z0X0PMpvJlnpyt0q6ISrWSqoN4eZMjOJ9RD8b1w+7iAqwlUIt
         EsSNXJxOVH35Al9xCJQFIY8N5o7z4Xph9sHuIThyQAypo/4JedwFWDUp9xzXEioQhuxD
         eMTN/zEzEbzrO2ccbYbUOh7j6tVAakq2wnVMInMgZzNe9WsAeMr7ohVnNusya9NNKsxR
         PMM1OKBaGwb/XU1CKeBraxI7YVxh6yHWMmoqa0VBxe80XWZ5c2B5jZgJxfgMoo1ptCtj
         u+9A==
X-Gm-Message-State: AOAM532t1tuAM0gqRY3J2S1K679K5jwbw1uGi3zBiURtw5WQxQiKmw8r
	sb5NVKHO4sMw7nxn/XErL0GSTM/0p85aVA==
X-Google-Smtp-Source: ABdhPJw7a9RZmEOXo/Z4YDyBGAAZRV2Xj86fwObrZu5UHgVtIYhBJfysoNRsWTSpZnPVdYaoUEGrgA==
X-Received: by 2002:a05:6808:220c:: with SMTP id bd12mr3502289oib.157.1629220893454;
        Tue, 17 Aug 2021 10:21:33 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id q3sm545178ooa.13.2021.08.17.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:21:32 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] contrib: vim: Add "remove" override highlighting
Date: Tue, 17 Aug 2021 12:21:27 -0500
Message-Id: <20210817172127.20737-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"remove" was accidentally omitted when defining which override operators
should be highlighted

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/vim/syntax/bitbake.vim | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index d8aa0f1..c5ea80f 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -77,7 +77,7 @@ syn keyword bbOEFunctions       do_fetch do_unpack do_patch do_configure do_comp
 " Generic Functions
 syn match bbFunction            "\h[0-9A-Za-z_\-\.]*" display contained contains=bbOEFunctions
 
-syn keyword bbOverrideOperator  append prepend contained
+syn keyword bbOverrideOperator  append prepend remove contained
 
 " BitBake shell metadata
 syn include @shell syntax/sh.vim
-- 
2.32.0

