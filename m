Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id D629473174
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:12 +0000 (UTC)
Received: by pfbg73 with SMTP id g73so41647752pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=L9ByPCLkChjErnvtIkdtXIz0d2ewZoH53IHpASnHz50=;
	b=AM0pcuLM7HRS9oUvwdYEKPKuUKWdfGYw+UjT4uP8zIjibSUK43r+NzbTZFU44X8JY8
	nhz7S6LqTPwRbrgTqaaGwoU8Jz1tiRowuqdZe0jX4xARy1UeAbJussyhQkSGy5ty2D7G
	CyBi2gUDN81RED8/Hi87SSg8vSJkyXPRzMjwcELx4J3ksSH3hbT+uCH4SqQBJFhQOVzm
	9tKR2ML9GZGAe6WbiNOG7eJuEW00rqPfRG+bnUEUx8ruOeY3nG+DsItzf9xR9eqa3IkK
	SnExMQ3QThVd28NPKHMT+jz/H+zYEpeVV4onVdYGAVWfsuZHuBYXx37OS8ejutyssbKv
	N3jg==
X-Received: by 10.98.75.142 with SMTP id d14mr3529252pfj.91.1449719593552;
	Wed, 09 Dec 2015 19:53:13 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:12 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:41 -0800
Message-Id: <b9e3f256479aa49591b782dfc29aad68262a67e4.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 16/18] toaster: removed extra calls of migrate
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

One manage.py migrate should be enough to apply migrations for
all applications. Extra calls just slow toaster script down.

Removed calls of migrate for orm and bldcontrol apps.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 0862a35..7645c56 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -58,26 +58,8 @@ webserverStartAll()
     # python bitbake/lib/toaster/manage.py python manage.py createsuperuser --username=<ME>
     python $BBBASEDIR/lib/toaster/manage.py migrate --noinput || retval=1
 
-    python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
-
-    if [ $retval -eq 1 ]; then
-        echo "Failed db sync, aborting system start" 1>&2
-        return $retval
-    fi
-
-    python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
-
-    if [ $retval -eq 1 ]; then
-        printf "\nError on orm migration, rolling back...\n"
-        python $BBBASEDIR/lib/toaster/manage.py migrate orm 0001_initial --fake
-        return $retval
-    fi
-
-    python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
-
     if [ $retval -eq 1 ]; then
-        printf "\nError on bldcontrol migration, rolling back...\n"
-        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol 0001_initial --fake
+        echo "Failed migrations, aborting system start" 1>&2
         return $retval
     fi
 
-- 
1.9.1


