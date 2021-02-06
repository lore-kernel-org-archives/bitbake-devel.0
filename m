Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.13627.1612652941018108039
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:09:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mohTQ7Hu;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: akuster808@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id r38so7294710pgk.13
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mu11dPHWCCjmnha3Uv9U8mpnGxhSAudvWTZzGIdQLyU=;
        b=mohTQ7HuUE9FxrW3BOIim/LGr5+641zRtj07DyfWqyu7Y0xVAVtm2jxUWOkQrPovwh
         io3O0G7DIjgWF1B4MnE0RvoTsvQIXNw2Iz43kdRrJatdqnmI4BLmVKg2Wn7x9Wx7iXaO
         Vxoas9NFETo1W7R5KaAPI6ssHDQZPAhBcMtx2LbQr+4g0B72OtD3tsZ8dFdErFg201qD
         4wuIvGOShxZXJKoLcmxjDnyl+fD1eKepfnVUNGyzaTuwEIw5TzCB03bnNpCKEqm9h5HZ
         YPLm1qH0pOOJgVBGNvQRYOPK+L8y2Lb92vGzVsQh6oasoq0B5lSbETJPwIfOUZsXwYx9
         Yutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu11dPHWCCjmnha3Uv9U8mpnGxhSAudvWTZzGIdQLyU=;
        b=kwLvs7K8BmisxcQ8i6zYOhKA/cJya8RlWNkKGCsC/fRZXe6zGtlf/iXoQIE3KomWRf
         tkOtr4o0S7uyVXM3BxQ3PlyumY2aTR7BsTlEBPvlfvW6WQ7CSquvrqisK+/ENE4k9FPo
         gGzawOBo8N56KTetzS9q7uNrkM0HL9tJlE1GlFHdOlDHsYZ/G/R2bC1Q+ThTpQU7nOx2
         +DpeNSvZnPIXEKFEkH831vY732qRlnGukrldOAGTeHAPZzPuyhMnXFY9HzjLyq+2A1bs
         weyIyiIOwTrDgQfUjofrCA7RtLJ8xhzXAu5Q3/LRgrR8qCnyOvJOUp3q95Z9/7N6Vprs
         hzBg==
X-Gm-Message-State: AOAM533+ZiiTqsnMkW4pc3oEBR/XAjyCQvkUO0HvVtNKX16LXa10TQmi
	ZCqgmnYQfcFv8vVQ19dj9BpegPPPfRY01A==
X-Google-Smtp-Source: ABdhPJyNWLevJcZJHb79RW90dE2JN4InNEWniNECQZ540PigmUfkEEv/aLsK94UBfrzF+wSxkc+8yw==
X-Received: by 2002:aa7:80ca:0:b029:1c1:b636:ecc2 with SMTP id a10-20020aa780ca0000b02901c1b636ecc2mr10938403pfn.20.1612652940474;
        Sat, 06 Feb 2021 15:09:00 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:09:00 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 08/10] zram: fix sourcing of zram parameters
Date: Sat,  6 Feb 2021 15:08:45 -0800
Message-Id: <bdb79efaba481b2d9807eab59df04fb67e5277dd.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Søren Andersen <san@skov.dk>

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 3c8ad9192c1c9f4323bdc7ff28456f11db689adb)
Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
---
 meta-oe/recipes-extended/zram/zram/zram-swap-init | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-oe/recipes-extended/zram/zram/zram-swap-init b/meta-oe/recipes-extended/zram/zram/zram-swap-init
index 0643dbca23..ccc3aafe3a 100755
--- a/meta-oe/recipes-extended/zram/zram/zram-swap-init
+++ b/meta-oe/recipes-extended/zram/zram/zram-swap-init
@@ -14,7 +14,7 @@ fi
 ZRAM_SIZE_PERCENT=100
 ZRAM_ALGORITHM=lz4
 
-[ -f /etc/default/zram ] && ./etc/default/zram || true
+[ -f /etc/default/zram ] && . /etc/default/zram || true
 
 memtotal=$(grep MemTotal /proc/meminfo | awk ' { print $2 } ')
 memzram=$(($memtotal*${ZRAM_SIZE_PERCENT}/100))
-- 
2.17.1

