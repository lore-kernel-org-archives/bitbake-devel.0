Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.15664.1629667768475687994
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 14:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DfPS1Bg+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id z4so7565608wrr.6
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyHYQXGyI4yUaNI5JMvGFHOWOreVb03PkQiKl5tOdLI=;
        b=DfPS1Bg+fXGsDOcOF3nwt2LfDwbK+Q7eQjYK5Yzlds8cwkN7yQXT3qGgnMWqN8Asnk
         gctL2qPxLkWkXwzGhjD5vOqTUPdASHIMqoSExMlpw+ghPxba8iGJsFJk0KaeD9kiK14/
         G+9+EtCQdCHISmBUJoOteCjCvz8YupADwkMuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyHYQXGyI4yUaNI5JMvGFHOWOreVb03PkQiKl5tOdLI=;
        b=nZ1DVqDlfAiptl6xByJac2Ece+esEIvk9S55a4OAaMoanrBeKMtDD8ICetHXOUyLs1
         hIrdhHCBaHkLdZC8W2eSVsdNciJxttHtGtwVC1Kk7TnqSaWNoNhYpgBC9P8FhKRYRSlj
         xENhmfbik8p32CVvkrSa6yh8zvcqzoXZFy5O8tDaeb5jqoDNb4NSR1DFLgePeU8agJFC
         ZPPy9XJaHPWFF4In04e2lrPitxJDKB6d19/mDtFYAVbaVgkJXdQzACKaTqNGj1j7P89l
         eUfC8fZ6+7jSlNa1BEAKoKpHh0TlvGZXyCbHokouuA8ONlN+7hldVadd0cVEPlIcx0ND
         XJ2A==
X-Gm-Message-State: AOAM5335MVqlwI6tsvHCW0Vd7qFXsSyP+AJ1gQedVdtArUMbEOrQVOtm
	ZaACoyXI3Ec4QoC4wHHyE/fWL6YgX8ENmA==
X-Google-Smtp-Source: ABdhPJzM5wJZ1FoFh/axWyD7K+2wxt5KVI0UAbGtY3h5wFqx6MqZPm85zfUhBMXV6ukgT/2T+zzRrA==
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr9962475wrx.130.1629667766983;
        Sun, 22 Aug 2021 14:29:26 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:d09e:54e5:5f12:c43c])
        by smtp.gmail.com with ESMTPSA id u8sm5223102wmq.45.2021.08.22.14.29.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 14:29:26 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: Make 3.6.0 the minimum python version
Date: Sun, 22 Aug 2021 22:29:24 +0100
Message-Id: <20210822212925.612609-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OE-Core did this a while ago, it is simpler if bitbake matches.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index c1e30697b3..5c248d3655 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -12,8 +12,8 @@
 __version__ = "1.51.1"
 
 import sys
-if sys.version_info < (3, 5, 0):
-    raise RuntimeError("Sorry, python 3.5.0 or later is required for this version of bitbake")
+if sys.version_info < (3, 6, 0):
+    raise RuntimeError("Sorry, python 3.6.0 or later is required for this version of bitbake")
 
 
 class BBHandledException(Exception):
-- 
2.30.2

