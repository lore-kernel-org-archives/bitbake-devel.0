Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
	[209.85.216.49])
	by mail.openembedded.org (Postfix) with ESMTP id 7452C7F67E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:33 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id o14so5601526pjr.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Oxh2CzT3JzHrCDAsLAy/ngKb5Ze7jh6N7vXYXYy+k7g=;
	b=QDLAMUi7hD2RFC6Op6VrMDGKCmGG78v9LvZ4/OgMnhkrHX8QWu6eGwi7TpHRdu5yyV
	nVCTYedCGlGlfzq25K+M7ib6KmRNofwfqGOYSItbrB/UmOwqplE7dvj4HMPGF++eKxpa
	Nh7xr6Lc1BH0crqJDkpbw6nUDQKMTLr/aEYTfLUp1WUIalijm0xWre2QktGA1wZjQ0G/
	7ZzReJ6qg5b4/xlsBVIonPnPEhyhuiThL3LKFHi8bFrrkwO1UnYYOhdArHfTyFNnCZ3u
	r73AbxOQOvIO1gK4pjfbZ+MjarlDPZXyP8PkBUNWQ5VdrvhCNUxRpwtim1jbGqVikhHH
	9VWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Oxh2CzT3JzHrCDAsLAy/ngKb5Ze7jh6N7vXYXYy+k7g=;
	b=AfYbwRaq5PnsFUvCWJbYrgG3VMex9i8+2ucIMYO2HY9T8DQqjxcC282wMW1JC9E9Td
	lLMUhAGqe935LmsJ8DZnn4fkJGAOByXXv9CFJjR1xMfT67k8LOaygBdktBw5f38k6UCM
	EmTFvThcBETfztEye0AF9303mWRevX4wqXDq5pXnOf3HUOlsQfmk7qq8uMe5TDDFarL5
	NJkqHPPn0rj6QsN5Kg8ac/7HNarzJlcqg9Xq4F53owm7BvQ2NwSXWvGFpSnnb7skbgMm
	G+A8dVMDKna3nsNUERjv+19IjbL3fYNKRVKSDB6UYPgTlebtc91NSa+Lq2wNCtRRNi6b
	I0/Q==
X-Gm-Message-State: APjAAAUwNS9HmN7NpQ1I9fKqMi7X6i48RRdLb5HQeKSuLJNXp0D/udNC
	sLfj5pG6r/gdWg3jmYhXWPC7b6rS
X-Google-Smtp-Source: APXvYqygSFB8JzF50eAvEsD6nPBV+W97inAuXbTCbJcbI+rl/keIHTmDxeY6OkFS8io/ABSwH65DmA==
X-Received: by 2002:a17:90a:868b:: with SMTP id
	p11mr12216166pjn.60.1574639014277; 
	Sun, 24 Nov 2019 15:43:34 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:33 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:21 -0800
Message-Id: <2cccc14304855cb55f339e465f6ba6ed0c69a7ab.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 8/9] fetch2/clearcase: Fix warnings from python 3.8
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:33 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is" with a literal. Did you mean "=="?
      if command is 'mkview':
bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'rmview':
bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'setcs':

Python 3.8 is quite correct and we so mean "==" here, fix it to
avoid the warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/clearcase.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 3dd93ad..e2934ef 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -145,18 +145,18 @@ class ClearCase(FetchMethod):
 
         basecmd = "%s %s" % (ud.basecmd, command)
 
-        if command is 'mkview':
+        if command == 'mkview':
             if not "rcleartool" in ud.basecmd:
                 # Cleartool needs a -snapshot view
                 options.append("-snapshot")
             options.append("-tag %s" % ud.viewname)
             options.append(ud.viewdir)
 
-        elif command is 'rmview':
+        elif command == 'rmview':
             options.append("-force")
             options.append("%s" % ud.viewdir)
 
-        elif command is 'setcs':
+        elif command == 'setcs':
             options.append("-overwrite")
             options.append(ud.configspecfile)
 
-- 
2.7.4


