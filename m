Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1U0yrp-0007jn-SV
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 19:28:11 +0100
Received: by mail-pa0-f44.google.com with SMTP id hz11so1842884pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Jan 2013 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=Er4yAzS2eDycepBTqDfHGBLEG4Ottr0TXNPuIcH9M3Y=;
	b=IsNHMwl/wBMsBYLswQwnV88HGMBzCFRFkFRZlrkms3X+XAxRlc+w7cWaloO5UqNIoV
	qur+gRwsH4ARhZrVefw0riKRmcATlCSmXtHRCgzwBrMi2FBcbp81GXGXkPJu01j4TYOB
	i/t0OzPZbv/kPYgHTnsVs2L2BSQIZuEJMaOoaU03So7pC4T77WGB6gmE55I+SVybuAgK
	44+y1BQKQYZPMNnJviryZOgcJqfV+YP/A7/nv4abpGy43pqMwdXMhccsBbGVowOUM39b
	obRS2JwwVYTJXYn8gWD5X/2wmPA8kRrkSFRc+LwoTY1uD3IEyRVs1r11WLat0dAX7uI4
	Qkhw==
X-Received: by 10.68.130.161 with SMTP id of1mr25115168pbb.32.1359655946217;
	Thu, 31 Jan 2013 10:12:26 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id ix9sm5676451pbc.7.2013.01.31.10.12.23
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 31 Jan 2013 10:12:25 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Jan 2013 19:12:09 +0100
Message-Id: <1359655930-1404-2-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1359655930-1404-1-git-send-email-Martin.Jansa@gmail.com>
References: <1359655930-1404-1-git-send-email-Martin.Jansa@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH][for-1.16 2/3] ssh.py: throw ParameterError when someone tries ssh://foo; protocol=git
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
X-List-Received-Date: Thu, 31 Jan 2013 18:28:16 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* taken from SFTP fetcher:
  http://patchwork.openembedded.org/patch/43027/

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
1.8.1.2



