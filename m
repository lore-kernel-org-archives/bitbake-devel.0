Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
	[209.85.166.169])
	by mail.openembedded.org (Postfix) with ESMTP id DDE8061C56
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 18:30:09 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id c8so6495283ilm.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IApHjogu4zAVQg6zxEBwm9EYKlIsnvjCwdV/jFWqW28=;
	b=l2/z/Thur0no5l9BcyOHEauUSLnfbbbuB2EhwdJFig4ibb7J3oSB+fWxAzbO99Hd4C
	AdkflrSsBY+Ax5p550sFqVSKYyAG80M4dxFtGgm5ckT/IaGCHN5f7K5JcEv1Mv4BJ1u7
	7CBgbH0a383OCzQqH1oY/sSE2T7R9cdOFkwlici0iwoAb79kBQXTj2acTk3duhL8T+43
	KtS7wWMlrBSUfG/fSR/z1AyMW1enDGQCNHCfHse1DsyeNXnGyI2FmY09j0q/wceV+bbd
	kHFwD5hhnu//gJUKFRh/lPkZG45di26XQJyrH8WddSmaWXW+uZcy1LneXAz6X2hntRoJ
	Oj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IApHjogu4zAVQg6zxEBwm9EYKlIsnvjCwdV/jFWqW28=;
	b=B4enjUM2huirpvwPu5dlZ8rFkre54r4pL2NBlqSSC1oQVQSAuF9f/7XsrnKeIRPwY8
	jimRDQv/4E2sxz1yf7VrkzSp1hcOGb7Y+rfWro7/1j6gOJ3h+KR6GaiIfz4v5I9sotyl
	BFqrpaInsLCcU3+y1mc83gYhHd+RK+PyOWSHoh3Vp0XgPY0svOOB+Txm3n1Fv1xjI4MO
	SKTWtHBo9omgpBJIg5Mi3jlY7cmTZHKRhlQ6Aj4vvSoOlbLlGd+JDRj1x/v2k0t+gsjE
	rgqVOmo+28Awm437Z0/zKOs6+eFW+I8NnTLbrKfp6nUh0E3/Mk0OxY8aBK06BfqLE0Ab
	BXnQ==
X-Gm-Message-State: ANhLgQ31ZBpvAxZIRBEfNpBQp7JynIUMnyTtuVL9eRbUw0mIiyXNPcpe
	WLNxMkyAS6pv+7Y+gLEcg9v5B3MRrls=
X-Google-Smtp-Source: ADFU+vsOd/6vDHIl4EGNlxBYiJOX4f+BwX2GNig3XvXdL2rD4G1/7eT1ny8FRXOrEsQCFYtEioTsFw==
X-Received: by 2002:a92:9642:: with SMTP id g63mr10198487ilh.223.1584037810669;
	Thu, 12 Mar 2020 11:30:10 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id b4sm6929029ilg.58.2020.03.12.11.30.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 12 Mar 2020 11:30:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2020 13:30:04 -0500
Message-Id: <20200312183004.8339-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312183004.8339-1-JPEWhacker@gmail.com>
References: <20200312183004.8339-1-JPEWhacker@gmail.com>
Subject: [PATCH 3/3] bitbake: Use logging.shutdown() instead of bb.msg.cleanupLogging()
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
X-List-Received-Date: Thu, 12 Mar 2020 18:30:10 -0000

The logging module provides a shutdown() function that does the same
thing in a much better way

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py       | 11 -----------
 bitbake/lib/bb/ui/knotty.py |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 3f95e21cc1..29f0a3999e 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -294,14 +294,3 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
         #    bb.msg.loggerDefaultLogLevel = newlevel
 
     return conf
-
-def cleanupLogging():
-    # Iterate through all the handlers and close them if possible. Fixes
-    # 'Unclosed resource' warnings when bitbake exits, see
-    # https://bugs.python.org/issue23010
-    handlers = set()
-    for logger_iter in logging.Logger.manager.loggerDict.keys():
-        handlers.update(logging.getLogger(logger_iter).handlers)
-
-    for h in handlers:
-        h.close()
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index db4511844a..33ee891256 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -871,6 +871,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if e.errno == errno.EPIPE:
             pass
 
-    bb.msg.cleanupLogging()
+    logging.shutdown()
 
     return return_value
-- 
2.17.1


