Received: from mail-pb0-f54.google.com ([209.85.160.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1U0ys0-0007kG-R0
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 19:28:24 +0100
Received: by mail-pb0-f54.google.com with SMTP id rr4so1734106pbb.27
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Jan 2013 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=ldYs4Ai57poPQ16KNyXvcHzbbdM67vx9MVLQitYF+ww=;
	b=hduNxg934cs2VAfZJ2aeuRcqz5mxb0XQykZz93g5op6WrYgvVevCk3u3dNSdb+hmiw
	c/eecxuMDG8+GBRpyVONbW2LATuQA1u6rIYVqzMNOFtAfwoks1zSd3kCJ0X7biGSAiVr
	xukb0c1DThxqE4ycS7YWqB5id8QG7oc5nGV9VJp2c+XmCpHmmaSQm0BamIGdCgVlpYMU
	0hi8v+EBixJo8cnfHc6+UA92ZLYMmULMnUThvjG0oZgomCui0DYt4vam9vk3vYQQjdKN
	pIdt3Duj5UbM/Ov00veUU8akP/UBfUWc3PUfCobR2V/c3C8cW8hZ0TEEZNMqbgjRBBB0
	o32Q==
X-Received: by 10.66.82.170 with SMTP id j10mr22959627pay.9.1359655957143;
	Thu, 31 Jan 2013 10:12:37 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id qt2sm5664900pbb.24.2013.01.31.10.12.34
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 31 Jan 2013 10:12:36 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Jan 2013 19:12:10 +0100
Message-Id: <1359655930-1404-3-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1359655930-1404-1-git-send-email-Martin.Jansa@gmail.com>
References: <1359655930-1404-1-git-send-email-Martin.Jansa@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH][for-1.16 3/3] ssh.py: add example SRC_URI
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
X-List-Received-Date: Thu, 31 Jan 2013 18:28:25 -0000

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
1.8.1.2



