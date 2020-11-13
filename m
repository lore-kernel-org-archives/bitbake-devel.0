Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web12.644.1605296966435528474
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Nov 2020 11:49:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=SCcjhvyN;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id s25so15295554ejy.6
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2020 11:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zH+Yq40+DPnAGlOM87Dcjo0LLaWKbaRB01WqyK+u1jc=;
        b=SCcjhvyNZ5ZykVVQcfHpDl6LSKyyoJDDCM+TJItjYdoOIaBntgx/6FUqolArZL3FX1
         qh48lJt/oMe8yD4jTB/bTIR/g/XesLlch5zoW67R+//q3JhRAAQwED27QPSxw0toiSvO
         WmdlNygQkl/LwbK1XIZa78Ls+Rd3XAEYYnr0q4Ehwzba81vXkGhtBQz52PStvl+DnBDz
         yywrdN1bjGZEDV2sp+1zJ27G8/km5I/9T7lMNR4VE1r+fI0PB50lAn87aEXMl3REaJpC
         yj6Evb7hknx5+IdznPaUDwjOiqTpzTOdjbiR62K3D0uvRdBJ9pS94enyiQr9X3unP2cK
         xMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zH+Yq40+DPnAGlOM87Dcjo0LLaWKbaRB01WqyK+u1jc=;
        b=r1bfjk0U2YyTSqiMrvWjqy4v/jN73qjmbDPNhlkMX0UuZocUhjODx5+/cTDwi+Ci2F
         7x2P+Ff6jZC1EvQNYmPe3LRnB86rYiYRmFTn5J1mBc08st6QkYQjLeYwp2RFaeQugSwQ
         skKxTAKqKQnEE3F9p0Ds1uAxhR29w52l57Uvo3ss4JglSIA1BZ9dAHMPlcUkoSUfTiBV
         hSjzAn42xX/NlAW2Paex2gxR3SzFRfsw7YIz0ptRCTLHVo6rpQng/UkNaC9Ri6pyWCp8
         +PI+9PXyKhdjBzabFlTHyO9RF5XtEm29VKnV+wIcW+HCoIHP65dpuFiU7YLA+AY/EpFA
         rttA==
X-Gm-Message-State: AOAM530fMtgWA1FAul4U5ozm/z6rCru+3hwhuLt5iF/i8TA3pWc0Fu3k
	rEzYygcmH2EraAwAuV8yXDc5lIa5RV608Q==
X-Google-Smtp-Source: ABdhPJxDADnXU9PyDuVeOUo+wFDt+XDVzk/8o+A1VRU3QJHJO6zpDrcgi+ErgKqiu3iTtojVEI/G6A==
X-Received: by 2002:a17:906:7f95:: with SMTP id f21mr3480867ejr.340.1605296964776;
        Fri, 13 Nov 2020 11:49:24 -0800 (PST)
Return-Path: <alex.kanavin@gmail.com>
Received: from linux-f9zs.fritz.box ([2a02:2450:1011:4f7:596d:bf31:3950:5bda])
        by smtp.gmail.com with ESMTPSA id e18sm4451976eja.124.2020.11.13.11.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 11:49:24 -0800 (PST)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [PATCH] lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetting
Date: Fri, 13 Nov 2020 20:49:18 +0100
Message-Id: <20201113194918.21461-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With introduction of python3targetconfig class in core this is no longer
needed.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index ca81bd5225..07b7ae41b4 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -853,11 +853,6 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
-    # Ensure that a _PYTHON_SYSCONFIGDATA_NAME value set by a recipe
-    # (for example via python3native.bbclass since warrior) is not set for
-    # host Python (otherwise tools like git-make-shallow will fail)
-    cmd = 'unset _PYTHON_SYSCONFIGDATA_NAME; ' + cmd
-
     # Disable pseudo as it may affect ssh, potentially causing it to hang.
     cmd = 'export PSEUDO_DISABLED=1; ' + cmd
 
-- 
2.29.2

