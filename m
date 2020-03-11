Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id DDCA261BF4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 23:28:51 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id t26so3763246ios.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BDD2k7q6fl2h/DR5DhF+hk2UKCmR+VmmiqsxZKSiIaE=;
	b=OWwCSjKRBnh4qQQHb2HrrbjuNf5a420oEKOknwF/83QVVqIYAmD0k3aHtYSvteAFjO
	yQGjsMalMrYEAvX1vbJNVfMeVxtRyxzhCWGPkdh4Kslxahlzj6wqLtU8o/ar5CpFaFoO
	1BXv6XfFfBEzcpGxY2fPKFb4pUa32oRYSncgZhujzOouzw9Wg7/X9/aA/dHCsGO0MtKk
	hV4oo21ZS9u3w+tVSR4fWZQj/DQMeZRp2duM7bDjtZvHgI7YaDNIg5ST2l36HfmJaoxu
	on4sMN9aUfB8IGnlPbIljFJiaGacKtVKlwN90Kmx9RCtD37QgWERygjZjizmRCflXKiE
	C7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BDD2k7q6fl2h/DR5DhF+hk2UKCmR+VmmiqsxZKSiIaE=;
	b=g7ABSwtlZl4lsmdFedU9kse/HT0uQl2Sn4Ek7ffPFa6KguKNzOsAfCliYFJL8oDFQv
	eup8YWb7oQRlZT0Ym6WxCAdbXq9PTV7um+a4Gdgzr89B8PJnJwEv34b4TheDGxv+1z0C
	GMGgVFptkReAHQjmXxgpr5Q+4NTURYCdRhe+W6WzxDbbbvlLt0tpzt3bx7zLoECJS7ba
	6U4P6AIoAjNFYr/MLAEyVSAaos8UcHOlOlj203zlhIpHTaUsAiYwzNtzBigywTXbpCNg
	fxPDnkBW2p9O/zbiBDd1N8pZM7H8F3WXb4KRADnOvUgyIpJVTzReQF0QDyDOWxd5dsXW
	jQyA==
X-Gm-Message-State: ANhLgQ0OADB8N1DhWK1hSmyS62udhr7/rNcOy8/dOIAD55hg+AcHsbQC
	0XIuFKg/YeVywMpNYjli5vhVGyJ1A3o=
X-Google-Smtp-Source: ADFU+vu44Lzf0+UaMUy4SH/wpn52VbqV/WtVDX6wNiIkp5yqp8DvOe8m4XqxYZJLhutKi5c/4Uf9aQ==
X-Received: by 2002:a05:6602:2541:: with SMTP id
	j1mr5208433ioe.37.1583969332601; 
	Wed, 11 Mar 2020 16:28:52 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id w3sm3297603ior.55.2020.03.11.16.28.51
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 11 Mar 2020 16:28:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Mar 2020 18:28:44 -0500
Message-Id: <20200311232847.2874-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311232847.2874-1-JPEWhacker@gmail.com>
References: <20200311232847.2874-1-JPEWhacker@gmail.com>
Subject: [PATCH 1/4] bitbake: knotty: Add logging cleanup
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
X-List-Received-Date: Wed, 11 Mar 2020 23:28:52 -0000

Adds code to close all loggers when bitbake exits. This prevents
unclosed file ResourceWarnings. A form of this closing existed
previously, but was removed in the new logging code.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py       | 11 +++++++++++
 bitbake/lib/bb/ui/knotty.py |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index ced605d96d..ee3c38b5a4 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -284,3 +284,14 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
         # TODO: I don't think that setting the global log level should be necessary
         #if newlevel < bb.msg.loggerDefaultLogLevel:
         #    bb.msg.loggerDefaultLogLevel = newlevel
+
+def cleanupLogging():
+    # Iterate through all the handlers and close them if possible. Fixes
+    # 'Unclosed resource' warnings when bitbake exits, see
+    # https://bugs.python.org/issue23010
+    handlers = set()
+    for logger_iter in logging.Logger.manager.loggerDict.keys():
+        handlers.update(logging.getLogger(logger_iter).handlers)
+
+    for h in handlers:
+        h.close()
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b229687ef8..2dfce90a4f 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -823,4 +823,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if e.errno == errno.EPIPE:
             pass
 
+    bb.msg.cleanupLogging()
+
     return return_value
-- 
2.17.1


