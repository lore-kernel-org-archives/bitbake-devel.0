Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 004496FFDD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:08 +0000 (UTC)
Received: by pfbg73 with SMTP id g73so41646967pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=mo4A6Z8uo66f54RkATpu4uxumI7YFZzNPM8fQy8SRdA=;
	b=DPEhO7mvlaUDKnSaxTgZ7+eH2UTdHSFkpxje7sqeFXzSYwjpfbQaPVTv9rWxJ4PArs
	r+n7sFd5oG5uCzUdIOT3hGYPfNelllKz2Ap/fb0LAIea5Byg9KF3CH0jN9HDffii0vNV
	2o+pJS5XJ7qz3o7Xu0JT0jEpKLFxlLnT9BaSEIF/Vjsr/dACcSP+nhdSttK2g7EGFMRR
	9XRMldkJh0TRVGs4XtF5+yELyjkYqv9+VsIYmLF/YVH5DWaJ37OTiEAAjhVi02FVI18R
	XGzodHFkNSVZ2ITjxZV4iWIG3iSL1CLXK4tPYQqFbVwNyBjRSZ4FHh6HyneaLXofU41j
	yKDw==
X-Received: by 10.98.17.14 with SMTP id z14mr3551443pfi.55.1449719590069;
	Wed, 09 Dec 2015 19:53:10 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:09 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:37 -0800
Message-Id: <e58929c71749af6755810e9c560284ed68f67c45.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 12/18] toaster: Amend regex for MySQL database URLs
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:09 -0000

From: Elliot Smith <elliot.smith@intel.com>

The database URL detection doesn't admit a MySQL URL without a port.

As this is a common case (e.g. you would set the HOST to a mysql.sock
path if pointing at a local MySQL server, with no port setting),
amend the regex so it will correctly recognise paths, as well
as HOST:PORT URLs.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastermain/settings.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 7c559bc..b6bdcd8 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -64,6 +64,7 @@ if 'sqlite' in DATABASES['default']['ENGINE']:
 
 if 'DATABASE_URL' in os.environ:
     dburl = os.environ['DATABASE_URL']
+
     if dburl.startswith('sqlite3://'):
         result = re.match('sqlite3://(.*)', dburl)
         if result is None:
@@ -78,7 +79,7 @@ if 'DATABASE_URL' in os.environ:
         }
     elif dburl.startswith('mysql://'):
         # URL must be in this form: mysql://user:pass@host:port/name
-        result = re.match(r"mysql://([^:]*):([^@]*)@([^:]*):(\d+)/([^/]*)", dburl)
+        result = re.match(r"mysql://([^:]*):([^@]*)@([^:]*):(\d*)/([^/]*)", dburl)
         if result is None:
             raise Exception("ERROR: Could not read mysql database url: %s" % dburl)
         DATABASES['default'] = {
-- 
1.9.1


