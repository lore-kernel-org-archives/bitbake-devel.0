Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 5DFEC6BCB3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:51:59 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id t60so1307255wes.18
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1KPGgFHhMQMqSapg9cbnhXc05Vz1P2lGSXPxK1UPpbc=;
	b=E3y8PlGNBgfz2+VIVUA00TWfUboXfty5qM1itVnFB9Lbx6509fPMdUQaZ3J3//0YiS
	vFAbBPsFAdJBsGEXe+4mUArw6VWBwXGXmMyMSp+gkAy8fOJ77FjO88VTE8S9RmbQ1KT9
	5I4dyTVX5G1Whxfan/s6RPwyG9pCmiOWdLDjDkj5uMt3OY67QJX4m68rFqueddt+ujBY
	C/4vWFl2faKBHr85vP+Qk6XyzETWAdaChISUiCEzHK5nvtizNkPElZ00IDsQ01GDkuYh
	cROJ05SccvWhQXGWEtIqXYUY5fi1yw7AAjG2uojCYjaQ+rwBED1T2GwYh0EBd8gjSRzS
	iCOg==
X-Gm-Message-State: ALoCoQkrE99BavcN25exkRwT45jTbuKJO5Mlg03NPs84G9Jd3HZK/ea/GKEjhCBXDedZGe7vQm3v
X-Received: by 10.194.80.7 with SMTP id n7mr61854008wjx.8.1402581119804;
	Thu, 12 Jun 2014 06:51:59 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ey16sm12704548wid.14.2014.06.12.06.51.58 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:51:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A775A56108D; Thu, 12 Jun 2014 14:52:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:51:59 +0100
Message-Id: <272a4bba0804bb6b5e0d498d3453321b5ed1dc76.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
References: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1402580802.git.alexandru.damian@intel.com>
References: <cover.1402580802.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/6] toaster: add function to get the database url
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
X-List-Received-Date: Thu, 12 Jun 2014 13:52:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a function that returns the DATABASE_URL
for the current 'default' database settings. This
is useful to be able to start other toaster instances
with the same database settigns as the currently running
instance.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 2c52b68..2ce10c4 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -74,6 +74,25 @@ if 'DATABASE_URL' in os.environ:
     else:
         raise Exception("FIXME: Please implement missing database url schema for url: %s" % dburl)
 
+
+# Allows current database settings to be exported as a DATABASE_URL environment variable value
+
+def getDATABASE_URL():
+    d = DATABASES['default']
+    if d['ENGINE'] == 'django.db.backends.sqlite3':
+        if d['NAME'] == ':memory:':
+            return 'sqlite3://:memory:'
+        elif d['NAME'].startswith("/"):
+            return 'sqlite3://' + d['NAME']
+        return "sqlite3://" + os.path.join(os.getcwd(), d['NAME'])
+
+    elif d['ENGINE'] == 'django.db.backends.mysql':
+        return "mysql://" + d['USER'] + ":" + d['PASSWORD'] + "@" + d['HOST'] + ":" + d['PORT'] + "/" + d['NAME']
+
+    raise Exception("FIXME: Please implement missing database url schema for engine: %s" % d['ENGINE'])
+
+
+
 # Hosts/domain names that are valid for this site; required if DEBUG is False
 # See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
 ALLOWED_HOSTS = []
-- 
1.9.1


