Return-Path: <msm-oss@mcclintock.net>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 363D87735B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Dec 2016 09:32:49 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id u15so9336037oie.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Dec 2016 01:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=+3wb5y+JhTqCQg7fqBvTokD3w6V95k1aby7Fz/X37dk=;
	b=CKFUCn4LWkhLubzl9tROITpSMqom1Q6w6VKy0bp9hOYAAjyxB7an9lf6vlY5KC6V49
	jpp9mes4CGP/qmBP/7/R9JmZ/QkxfXnxoGz18MgFyYYiYk/Gd0teWJcZrDzFPMQD26Kt
	SivrtfKSlgcMID26wvtqrd1hUZLdeFGZ6H9yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=+3wb5y+JhTqCQg7fqBvTokD3w6V95k1aby7Fz/X37dk=;
	b=ZKcx2TG8uKSp94pn2tkKC9Ef6WcB0wKaB7izHS6/wOZBcLt3jBar1WdLQPIoPqz+AK
	9xFtMU1pEPfL1kywmN62XUSMQNxt2U2NHqOeURnHc/pY6vHoAEI822EVcTRjvn+aNurm
	qIes8DItRn4dW9XEqeJmpWnXWxOywU2mi0CzcnLbrKSJ7qHUgojyoSIYQtMN7SOKvtsF
	yGDRf4fiHIvIhrqd5UikG3/LdT/hIKGQDHHIhM9E6Su2U4HcwEYYvpupu/PQLusFudmt
	D9ZtTS53ghfcc9GpwXgV3VH+fz0DUpHjjJN28wBrhYbOruVa6e2sQ8n9bPds0pUjY93T
	eNXw==
X-Gm-Message-State: AIkVDXK2ZdVftCUzNcyUyUsXlBLvDfMpfyhGjzfBUnVyuR0hFh67KXBinuWMmftD1GIymw==
X-Received: by 10.202.197.17 with SMTP id v17mr1302883oif.16.1481880771163;
	Fri, 16 Dec 2016 01:32:51 -0800 (PST)
Received: from pandora.lan ([2605:6000:1019:149:5a77:b80:8e7b:e835])
	by smtp.gmail.com with ESMTPSA id 31sm2141740otj.26.2016.12.16.01.32.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Dec 2016 01:32:50 -0800 (PST)
From: Matthew McClintock <msm-oss@mcclintock.net>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Dec 2016 03:32:42 -0600
Message-Id: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] fetch2/wget: add Basic Auth from netrc to checkstatus()
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
X-List-Received-Date: Fri, 16 Dec 2016 09:32:50 -0000

fetch2/wget uses urllib to check the status of the mirrors, wget will
use netrc to pass login and password information however checkstatus
will skip that.

This adds netrc login and password to checkstatus so both will work the
same.

Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
---
 lib/bb/fetch2/wget.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6dfb27b..88349c9 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -305,12 +305,24 @@ class Wget(FetchMethod):
             r = urllib.request.Request(uri)
             r.get_method = lambda: "HEAD"
 
-            if ud.user:
+            def add_basic_auth(login_str, request):
+                '''Adds Basic auth to http request, pass in login:password as string'''
                 import base64
-                encodeuser = base64.b64encode(ud.user.encode('utf-8')).decode("utf-8")
+                encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
                 authheader =  "Basic %s" % encodeuser
                 r.add_header("Authorization", authheader)
 
+            if ud.user:
+                add_basic_auth(ud.user, r)
+
+            try:
+                import netrc, urllib.parse
+                n = netrc.netrc()
+                login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
+                add_basic_auth("%s:%s" % (login, password), r)
+            except (ImportError, IOError, netrc.NetrcParseError):
+                 pass
+
             opener.open(r)
         except urllib.error.URLError as e:
             if try_again:
-- 
2.7.4


