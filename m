Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id B56B56FFA6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:06 +0000 (UTC)
Received: by pfbg73 with SMTP id g73so41646416pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=snEEP+lw4SrqdVeUKxsZf2CSrsvLoQw3A6mnlGPA+18=;
	b=aV4wrxG02oRtxbPKt6SzZD1GKrN8qVNDQdJAFBkzX9V8CzFcBJO2V1IZAefQNvqX9X
	khqvcc4pO6zBgNZIj7qoQ5eiTwJrMwaiAiWsDGOdXpu2+j4zw0lqaY4+UIjcfS0TvJGr
	yNMq4oGvN4wX2OwIDeGCvmmO7eHRPPBoCWz+PPhI2rG5eZJKj10FexAZAZzQLzx/vuBx
	f98dMOhV1zIUfq3dxQQuaUgbgtzXUFhTQpvP6IWutVVchL/Uj9B+6+lJu5ZJB45SCGHz
	4/uD3p1l7eXEQKbt3uSaOZglQJsPE86WEDivOuDwcugTR+A2mt2dioNb+b0WY8y1VB2H
	bSRQ==
X-Received: by 10.98.73.10 with SMTP id w10mr3556972pfa.164.1449719587331;
	Wed, 09 Dec 2015 19:53:07 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:06 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:34 -0800
Message-Id: <49f7318236cc2de14d7342ccb22592a141625efc.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 09/18] toaster: Update deprecated manage.py command
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:06 -0000

From: Elliot Smith <elliot.smith@intel.com>

syncdb is deprecated in favour of migrate in Django 1.7:
https://docs.djangoproject.com/en/1.8/releases/1.7/#schema-migrations

Update to the "migrate" command in Toaster's start script.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 528e17e..e3c7867 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -56,7 +56,7 @@ webserverStartAll()
     retval=0
     # you can always add a superuser later via
     # python bitbake/lib/toaster/manage.py python manage.py createsuperuser --username=<ME>
-    python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
+    python $BBBASEDIR/lib/toaster/manage.py migrate --noinput || retval=1
 
     python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
 
-- 
1.9.1


