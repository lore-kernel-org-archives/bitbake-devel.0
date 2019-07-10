Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id A8F577F025
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:30 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id r1so4212460wrl.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=5gXrNJY3NR1m4Udgg6cVKMhJesQNrMa1F8uBnk6Sz98=;
	b=OJa+1VMVHX6s4kMcZiIyAQTggV4nUXAt3nMoYWAzDQDYiO6stJ3lJorndFebTQOLm2
	Dn7oWEwGPKqQdX+M0azwdwqCVJidhJK3wxNGIgBbb+sG3D+aH1o9NyQCzejzeTrmMIFN
	RQ4zRQVlS1cOGahHcCsKPVcaBSDnN775u6EW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5gXrNJY3NR1m4Udgg6cVKMhJesQNrMa1F8uBnk6Sz98=;
	b=g76UqO9EMnHHTnjc450iBMTxjbEB1/e3mchwcvKBADZ2Do+hsmyPRIrFoEgzMdUfvj
	0iEQQ7sfUArfYTQ8ng41rf5Zkib0T2iXQOVRRUwxXmtMWM/XKcOQNuUg7BGlsHHUzY5C
	bUNFUtHsQHdaccuHcnG6Ng+D7FK9Ws7Ns8HyL7KDfw+dMgQB2CFBxWFxqvpYXfJ62yAT
	5rQfD6NX6F1tdKvRbjFqkA3BiLECxSRSzaUYXI8BOslGGagwRERGwInn1h7EK1ozU8A7
	XOS3JNxwj+e51FCrUwCV39NW+AIsAtBP6pevITYpcfQ27Wpe5uR4+xcF72E9wqqEgwCx
	OrXA==
X-Gm-Message-State: APjAAAUCXfVvd+tIJLIUEt0QgM31hM5KHq+OW21QDLIciNFXMDAxDJR3
	lyt7mbr1ycGKaVNj4GpHLFnCP5w8uKQ=
X-Google-Smtp-Source: APXvYqwTwktlZnkVzIqUCLJO57dyl7V1Q62k7q1zS4D0Q21JZtRagxCkNZBnqOLIDCqEFtl11SL8+Q==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr244287wrw.96.1562802871170;
	Wed, 10 Jul 2019 16:54:31 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.30
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:30 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:04 +0100
Message-Id: <20190710235420.23825-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 10/26] runqueue: Fix counter/task updating glitch
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:30 -0000
Content-Transfer-Encoding: 8bit

Some tasks were not being marked as covered/notcovered since internal
calls were being made without using the external call points.

Fix the accounting issues by using the correct external call points.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9ec2f7d2d4..54dce83737 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2044,7 +2044,7 @@ class RunQueueExecute:
         for dep in self.sqdata.sq_deps[task]:
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
-                self.scenequeue_updatecounters(dep, fail)
+                self.sq_task_failoutright(dep)
                 continue
             if task not in self.sqdata.sq_revdeps2[dep]:
                 # May already have been removed by the fail case above
-- 
2.20.1


