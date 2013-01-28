Received: from mail-we0-f171.google.com ([74.125.82.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TzrJo-0008Ir-Pi
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 17:12:25 +0100
Received: by mail-we0-f171.google.com with SMTP id u54so1553067wey.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=ZLqnRlKRLnDeEkDmzvUIUPOKK8rP3FKXLXkFj3HDV9Q=;
	b=v4FbqcuZ/xkLabJ8188toaC5c019e3t4B4dq50BCqE9s/3q2VtApyublT6KVhqPLe1
	mOAP97yJ+3ELx+xfADBdijBtx/iJsrxnT/WD8geBuZmmUN5UoMWB3rEHghrnD3sNv5tD
	Ub9LnFA8lSu2IX0QCSULpayh1cE0SF03zuAwTS83mOr8JY8D2XsAfNMrFQ9v4miMies4
	8vO04waSxhHF00FgTh1GAoTIrWnC4ANahb5HhBk3bLxWtA3RsRnXV1KV20gVxwXenJX9
	AFwGC6BLaC/Sbp3x5uXTtYdPl9J0R6ifUyAsyhnLeW2YlElEHARsXw1wpv0k9ZQqXp7+
	x4RQ==
X-Received: by 10.180.104.196 with SMTP id gg4mr4059547wib.16.1359388603665;
	Mon, 28 Jan 2013 07:56:43 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id ex6sm14060000wid.3.2013.01.28.07.56.42
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 28 Jan 2013 07:56:43 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Jan 2013 16:56:42 +0100
Message-Id: <1359388602-30536-3-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <1359388602-30536-1-git-send-email-Martin.Jansa@gmail.com>
References: <1359388602-30536-1-git-send-email-Martin.Jansa@gmail.com>
Subject: [PATCH 3/3] ssh.py: add example SRC_URI
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 28 Jan 2013 16:12:27 -0000

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/ssh.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 721fb35..8b5acbf 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -10,6 +10,12 @@ IETF secsh internet draft:
     Currently does not support the sftp parameters, as this uses scp
     Also does not support the 'fingerprint' connection parameter.
 
+    Please note that '/' is used as host, path separator not ':' as you may 
+    be used to, also '~' can be used to specify user HOME, but again after '/'
+    
+    Example SRC_URI:
+    SRC_URI = "ssh://user@host.example.com/dir/path/file.txt"
+    SRC_URI = "ssh://user@host.example.com/~/file.txt"
 '''
 
 # Copyright (C) 2006  OpenedHand Ltd.
-- 
1.8.1.1



