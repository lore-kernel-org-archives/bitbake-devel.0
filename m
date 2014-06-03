Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id D358D6B7D2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:17 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id z12so7005180wgg.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5vUTzzz8crITsOPijQw6yAA0YBws9Tr2Y0FnkPCIdE8=;
	b=hQVHsDZCT8rSGlv7MJzJW28ZgR2TlzyduSDi7AjvYLqbzjnr9GxS8gELWUQJWLiDN2
	ML2v6RyH1vB1PYHtcyXR0SwewBES+4Maoh67UyUuAF1sfyxbFYz0yEcbujwa1RU3EpRe
	hsTRlRkdxmAKAxJQaTxolcXdtRtY35qsTNo5RzWNp3FHlFpaNqf/ZdugMIjN8uFh2x0g
	KHHOnfk9yg538+NGz0mDDEMSDPt74iDw/S+r898VWdKxkdAYsKLXDr4M3OKAjd3De0S3
	ihTJQsPJ8SRC89u6hv5AnLGuLOq3J/RMu1lxxSsAcef4LjiS0seUBPJAyRAgKd4NE07k
	1bLA==
X-Gm-Message-State: ALoCoQmmurNA9Z9PvhQ6RCDc2grKvzdfeMmiwXUabwzNQ0rRD6atyT3TN7kLmMZza2S5751Rfve1
X-Received: by 10.180.75.236 with SMTP id f12mr129051wiw.11.1401809177990;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	b16sm44719491wjx.45.2014.06.03.08.26.16 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CDD455615F2; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:13 +0100
Message-Id: <6ecab61779079d4e0cd4ae7d4de82766a8557373.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/9] toaster: read database settings from the environment
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add the capability to read the database settings for
Toaster from the environment. The DATABASE_URL is intepreted
and used to override the default settings.

This capability is essential for easy deployment of Toaster
in a managed hosted environment, and for creating
build environments with custom database settings.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 645f327..adaa56c 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -41,6 +41,39 @@ DATABASES = {
     }
 }
 
+# Reinterpret database settings if we have DATABASE_URL environment variable defined
+import os, re
+
+if 'DATABASE_URL' in os.environ:
+    dburl = os.environ['DATABASE_URL']
+    if dburl.startswith('sqlite3://'):
+        result = re.match('sqlite3://(.*)', dburl)
+        if result is None:
+            raise Exception("ERROR: Could not read sqlite database url: %s" % dburl)
+        DATABASES['default'] = {
+            'ENGINE': 'django.db.backends.sqlite3',
+            'NAME': result.group(1),
+            'USER': '',
+            'PASSWORD': '',
+            'HOST': '',
+            'PORT': '',
+        }
+    elif dburl.startswith('mysql://'):
+        # URL must be in this form: mysql://user:pass@host:port/name
+        result = re.match(r"mysql://([^:]*):([^@]*)@([^:]*):(\d+)/([^/]*)", dburl)
+        if result is None:
+            raise Exception("ERROR: Could not read mysql database url: %s" % dburl)
+        DATABASES['default'] = {
+            'ENGINE': 'django.db.backends.mysql',
+            'NAME': result.group(5),
+            'USER': result.group(1),
+            'PASSWORD': result.group(2),
+            'HOST': result.group(3),
+            'PORT': result.group(4),
+        }
+    else:
+        raise Exception("FIXME: Please implement missing database url schema for url: %s" % dburl)
+
 # Hosts/domain names that are valid for this site; required if DEBUG is False
 # See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
 ALLOWED_HOSTS = []
@@ -51,7 +84,7 @@ ALLOWED_HOSTS = []
 # In a Windows environment this must be set to your system time zone.
 
 # Always use local computer's time zone, find
-import os, hashlib
+import hashlib
 if 'TZ' in os.environ:
     TIME_ZONE = os.environ['TZ']
 else:
-- 
1.9.1


