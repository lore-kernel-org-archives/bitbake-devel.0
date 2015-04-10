Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id DD80F65C98
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 15:14:29 +0000 (UTC)
Received: by pddn5 with SMTP id n5so25555941pdd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 08:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=luGgD0iA3dn/lfqE5rdFRvkxbT4WGHrmrM0N+NFghAc=;
	b=YeSRhvNyyn/XYP3PQCZD+swTntyRkc5cagCyzIweCgDQhLCoPj220MP3bswtZO7Gsx
	3s+yVRx6M+9HfMXBuZxPfzxcI5BneVRDul9hZ399yk5SzXu5Lfd1uQAfN+X7poYn9fuy
	XvSknWMeCd84ZC4hPx3V5RNkuyZdk8h5cvV3xfxqKN3MfNtvY5G9nKmotm7suYQfDV4B
	DgP/GXX3m23qGjbUdLn3LSNPKWPHfdy1Tk57pga6sNl9KBgUaoTC3avA9BnAX9dqCsZD
	Nrf1qaDtCXPvjyxqNezJ8uitIReRu+GaiS5SdwD46P+G9gDbHT/k4xyBFdh+VhTBrEbK
	Xwzg==
X-Gm-Message-State: ALoCoQlgADIUrh6Dnm1EzIQh1rlkuccNTWFRfc/rEDLq1869h6CdfRo7XlpilKj/dsgUj9r2b8W+
X-Received: by 10.70.96.142 with SMTP id ds14mr3406820pdb.129.1428678870694;
	Fri, 10 Apr 2015 08:14:30 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fl4sm2599996pab.8.2015.04.10.08.14.29
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 08:14:29 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 872E9560ACB; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:04 +0100
Message-Id: <1428677827-12371-5-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: [dizzy 4/7] cooker: Further optimise pyinotify
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
X-List-Received-Date: Fri, 10 Apr 2015 15:14:30 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We currently add crazy numbers of watches on files. The per user limit is 8192
by default and on a system handling multiple builds, this can be an issue.

We don't need to watch all files individually, we can watch the directory containing
the file instead. This gives better resource utilisation and better performance
further reverting some of the performance regression seen with the introduction
of pyinotify.

(Bitbake rev: a2d441237916a99405b800c1a3dc39f860100a8c)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 614d47d..e965bcc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -180,7 +180,10 @@ class BBCooker:
         if not watcher:
             watcher = self.watcher
         for i in deps:
-            f = i[0]
+            f = os.path.dirname(i[0])
+            if f in watcher.bbseen:
+                continue
+            watcher.bbseen.append(f)
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
                 # the parser. The parent directory of these files may not exist, in which case we need 
-- 
1.9.1


