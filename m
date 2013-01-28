Received: from mail-wi0-f176.google.com ([209.85.212.176])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TzrJk-0008Io-K8
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 17:12:25 +0100
Received: by mail-wi0-f176.google.com with SMTP id hm14so492085wib.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=ILJ2stXaecMEEqW02Fq5p90Eoezot4H07PPvKxYMkS8=;
	b=X659fwR1ya3/eO2T3ngqE/KM6ZJO463RBcNzVYW5GLeLIDA5HVMsP4qiAW5GcFb47W
	RQyquh0yxNTG1PCgsl/7SAtrWd9O++TNQgEIwsk4zLNzZjNJZXWDaWsgrsQWeAMMqlwb
	otA+obzToU+4WE0+5ycIUr26e4vbosV/YVtb/Y3mkuhieq7L6ABpdIeQznvxyO+Ps+Wo
	W7LidLqo5wksH5sywF6TTOkQPE6Zpv+1ogVLlnSnd4XS4ecXCwmjF7F+x+gpAEuZ4yoL
	lnOYaJeaAlLatRfvTYe9jOOY+/lrfRiiNN9VODq/QuG0KLlxfRYpoYL9r1mFXWk/0QVW
	2PIA==
X-Received: by 10.194.76.165 with SMTP id l5mr22121447wjw.14.1359388602256;
	Mon, 28 Jan 2013 07:56:42 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id hu8sm12676414wib.6.2013.01.28.07.56.41
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 28 Jan 2013 07:56:41 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Jan 2013 16:56:41 +0100
Message-Id: <1359388602-30536-2-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <1359388602-30536-1-git-send-email-Martin.Jansa@gmail.com>
References: <1359388602-30536-1-git-send-email-Martin.Jansa@gmail.com>
Subject: [PATCH 2/3] ssh.py: throw ParameterError when someone tries ssh://foo; protocol=git
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

* taken from SFTP fetcher:
  http://patchwork.openembedded.org/patch/43027/

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/ssh.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 61db435..721fb35 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -73,6 +73,11 @@ class SSH(FetchMethod):
         return False
 
     def urldata_init(self, urldata, d):
+        if 'protocol' in urldata.parm and urldata.parm['protocol'] == 'git':
+            raise bb.fetch2.ParameterError(
+                "Invalid protocol - if you wish to fetch from a git " +
+                "repository using ssh, you need to use " +
+                "git:// prefix with protocol=ssh", urldata.url)
         m = __pattern__.match(urldata.url)
         path = m.group('path')
         host = m.group('host')
-- 
1.8.1.1



