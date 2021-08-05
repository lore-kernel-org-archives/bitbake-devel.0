Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.8001.1628167057452747203
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Aug 2021 05:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O0Xec3Y8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id b11so6357584wrx.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Aug 2021 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7UIuHXIg5Ji9K/HZPVD8jaN4BdJWsCg7pwN1kSXKtmg=;
        b=O0Xec3Y8ruTYSen+Ok/r+x95nta+aI76ZB55MAwg0gUql0hU7nONIi75ons1gNEydV
         dtN5QJsHy6Qtyg1gB8anMtfWiITyGJwLRYSQS7s3GJhyu5591aP9Df3/vY1ICzA9Oz78
         TDbzPVFFRnstkmW2tCiWoSZ7RNiYE2MdKBS4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UIuHXIg5Ji9K/HZPVD8jaN4BdJWsCg7pwN1kSXKtmg=;
        b=ag2NbDKIygC8qKOXVCUW2h5giultrINs6EAbKaBV2NHhayvivFb2AJBQHS1icl7ifG
         LC+yjpfxeHzHppo3U6kipFLApqNTU+O82GS4Xc2L11k22TpQ4OKUzjKnwDmOm30zsCBk
         eHlOBZO8xMZLGBBr1ZR3l5TvbT1mVtOUA7PTNFOTAhKM9HOdPcZaou1TbkuXvCTI6LEt
         EP0UzRPagtlJjR3/77oEN8ZhIfNGaXfmvcue5gPTy0JriPZYcu9Jjsp6f/HSRS7mpWCm
         F/cFEvUWTvMa3OHbVSm0ne5A2QzNZOAfiZdokhft1WyJ1SFj7EF2G+CybB6g+eyPhvru
         L9OA==
X-Gm-Message-State: AOAM532MRHh3MU5Y/Vop8Dwu+DF4KOhe3mYqf6da51Y4I24+SSXe02Rf
	hhrmBpK3qc1/F54WFOIrgNcT/SG8lE3/SQ==
X-Google-Smtp-Source: ABdhPJwJ5l7hjaZIzRfyZLvUmj4kBpmUhS78ymBT0SrjITF5le+KGaXGCRBq77Kcv0xllhQBaF8vbw==
X-Received: by 2002:a5d:6e12:: with SMTP id h18mr5047469wrz.236.1628167056051;
        Thu, 05 Aug 2021 05:37:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ea47:91d3:ba71:9eb4])
        by smtp.gmail.com with ESMTPSA id a24sm2106291wmj.42.2021.08.05.05.37.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:37:35 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] ui/taskexp: Fix to work with empty build directories
Date: Thu,  5 Aug 2021 13:37:33 +0100
Message-Id: <20210805123733.3572421-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
References: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If run on an empty build directory, taskexp wasn't working as it didn't
send the current environment to the server. This means HOSTTOOLS in oe-core
couldn't be built and gave an error. Add the missing updateToServer call in.

[YOCTO #14408]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/taskexp.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 81392977a0..c00eaf6638 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -197,6 +197,7 @@ def main(server, eventHandler, params):
     gtkgui.start()
 
     try:
+        params.updateToServer(server, os.environ.copy())
         params.updateFromServer(server)
         cmdline = params.parseActions()
         if not cmdline:
-- 
2.30.2

