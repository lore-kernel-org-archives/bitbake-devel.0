Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.3291.1631823771411481286
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=WMnGMJx9;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id t18so11509613wrb.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpMW46eGBKZLE7n+Zlf7KADwqi3ghVHILPuxY0Ts2YU=;
        b=WMnGMJx9KR3+KiuCQ5hU8Msie1ENGvpfKPIScaeg0qzqdx5nNlKrGCtwQ59KygsL0L
         zzN3YYbbTn3CaubQtNvZwCsglgHMEXd3nIRN3X6a+uaQvnLZsSzA8zPkjKpjHUebApzu
         5npjeZxZgIuHTQpAB1rN+Me7ORb365WRvVm98rlswDmI200OOujDszPO9kkHJfv6ab3u
         Xf2KO0YK8YdXtTLC+oNd8SF8WEZ5YGTM9Vu6S+KzSAbZd772KgDyQm98+Gl2A1nW3ZUW
         7G7aWyOYyJJw4Mbo4PVa+NZS8fi75sm1Un+cKyiGA21TkpaYUUx7/3zjxip9E+rUfixE
         sMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpMW46eGBKZLE7n+Zlf7KADwqi3ghVHILPuxY0Ts2YU=;
        b=p0RefhQiHHkC0DbBx2z7H9tHds/sXyL2ojM6bRRwHRcrf0rik4mYjUzdtop8uhmQ0r
         n/VcO7FOG5PVRelDE5qEkbaVRW9NiGNOptbeVGBq13gTA6abA3uugmTmJee7qA3xbIGk
         AExW7GU6qaxMzDvpR0HShmEOs8nzOpNOSDkBsAAYNcS2YLfnFlhQ3v40axqT4Fkcjvzi
         X+22jxETzg7PKvKUlbyh11WNJqobRz7E3pVXLnauq3R9Ibei8p8vuuNobVkz3O4AEVtT
         BPvP7LT0Un5p/JE0AK822KRtjfpvm8JzRBDjvIpExotUPAJ8YBMOIi6+7mu2Ka1C4wTp
         K94Q==
X-Gm-Message-State: AOAM533Lvahus6YGyltwfI12IK8aSxivFIiCP6oG/fPMXMFFUvme/n/s
	y3+OHmSi2lOsDVI3ZzF6QmtihvF3qmU=
X-Google-Smtp-Source: ABdhPJx6jaJs7qd63hZcCLp9w5dQVEjuQpYmI9iYi/LdE6PM7aft6fGKqw9dkZGSgF+8l10AiVEkNw==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr8119333wrn.400.1631823770076;
        Thu, 16 Sep 2021 13:22:50 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:49 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/7] bitbake: drop old rules for python warnings
Date: Thu, 16 Sep 2021 22:22:32 +0200
Message-Id: <20210916202237.1929584-2-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916202237.1929584-1-alex@linutronix.de>
References: <20210916202237.1929584-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These no longer even work, and it's much better to just see all warnings
and fix them as they happen.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/main.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 06bad495acf..639fc1885db 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -112,13 +112,6 @@ def _showwarning(message, category, filename, lineno, file=None, line=None):
         warnlog.warning(s)
 
 warnings.showwarning = _showwarning
-warnings.filterwarnings("ignore")
-warnings.filterwarnings("default", module="(<string>$|(oe|bb)\.)")
-warnings.filterwarnings("ignore", category=PendingDeprecationWarning)
-warnings.filterwarnings("ignore", category=ImportWarning)
-warnings.filterwarnings("ignore", category=DeprecationWarning, module="<string>$")
-warnings.filterwarnings("ignore", message="With-statements now directly support multiple context managers")
-
 
 def create_bitbake_parser():
     parser = optparse.OptionParser(
-- 
2.20.1

