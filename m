Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
	[209.85.166.48])
	by mail.openembedded.org (Postfix) with ESMTP id 9854061C3A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 18:30:07 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id r15so6737706iog.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mvxqpoOqNtK0lkQrueP/KQ5GXfObDvTTNMsxEg9Dps0=;
	b=S4+UPRl1Sp3wNVTPHVkII1VihoO1jcrhx9TtXlt3ypVSscdKkjCOWbJ7IenKU1suKz
	hvtICa4Fi/UBO5LiCXrQrWQIpUfA4a1NUkNeujkhWen+tAU3tyg+VaAmXyY2liBiRbYx
	d14beI/7vcvVJd1b+nJI/iJNBn/llycwnylUPkFdO5ZDpJr5cT2NrIpiRMc3sKq02FZz
	2wkCwSN8DxjGydIb2KBtCd1kkbCQTRsLhBZpt17gPxNKJziBbfmOX8wXxnnnELaUty8+
	Ab/1v/SDKN9DpoY4Z/3gadPeCvm5HYJdArCQIClWz272Vg/AFkDZK0f35796eN28+TC8
	Ypcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mvxqpoOqNtK0lkQrueP/KQ5GXfObDvTTNMsxEg9Dps0=;
	b=sxE3yN2jhHsQ3S239EO4B7GAfUeXh49Y899UvzHQW8OK76vm8Ru8X/g7Cz6CEqpWLT
	5ybhoPL91SIH9GJfpj0Xk91Dtvbz0hxMr3dzO+MDdTi9sy13R/pEui2hPDrx2qBOFXus
	ZzJZU6E9/Ce5T5+t4EEpt5U0gbDBsTVw+74i6TJrkTFvnPhYHOFSZaOJQbk1fx/uWm4P
	McMG/thxj2c95kcMzao7Iu1B/RAQyjRCkeBgxv5q4SpM7PS4rXp2ZGXQRA7VwnyGlnRB
	8bQtgpgNNLaEYbEmpShjM3vT6al0kAREBVIUSzGGGTuZTVYbJAZoKMBzkgvWgECmRd0L
	7kPw==
X-Gm-Message-State: ANhLgQ2Ro6ZKZqYNdeVnv/7Kj+dfsI1zA5oIBmPio2tBG8qoIrmImsyb
	Bq6GMedbkqc+J7OfP1xDA0b6KcLMVbA=
X-Google-Smtp-Source: ADFU+vsITtPUAYnVw7/6t8XKkOyeVFT+awJs0GwIQ0ub/QFCMFCo3DaXIlHU5cjHM93oBEU7m+cTpg==
X-Received: by 2002:a5e:c743:: with SMTP id g3mr9035739iop.74.1584037808425;
	Thu, 12 Mar 2020 11:30:08 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id b4sm6929029ilg.58.2020.03.12.11.30.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 12 Mar 2020 11:30:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2020 13:30:02 -0500
Message-Id: <20200312183004.8339-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312183004.8339-1-JPEWhacker@gmail.com>
References: <20200312183004.8339-1-JPEWhacker@gmail.com>
Subject: [PATCH 1/3] bitbake: msg: Return config object
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 12 Mar 2020 18:30:08 -0000

Returns the configuration object from setLoggingConfig(). This object
has a config dictionary that contains all of the created handlers,
filters and loggers, which makes it much easier to pull out items with
specific names.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index c22d0d3e15..3f95e21cc1 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -270,7 +270,8 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
         if "level" in l:
             l["level"] = bb.msg.stringToLevel(l["level"])
 
-    logging.config.dictConfig(logconfig)
+    conf = logging.config.dictConfigClass(logconfig)
+    conf.configure()
 
     # The user may have specified logging domains they want at a higher debug
     # level than the standard.
@@ -292,6 +293,8 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
         #if newlevel < bb.msg.loggerDefaultLogLevel:
         #    bb.msg.loggerDefaultLogLevel = newlevel
 
+    return conf
+
 def cleanupLogging():
     # Iterate through all the handlers and close them if possible. Fixes
     # 'Unclosed resource' warnings when bitbake exits, see
-- 
2.17.1


