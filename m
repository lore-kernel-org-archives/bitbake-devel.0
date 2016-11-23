Return-Path: <avery.brian@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail.openembedded.org (Postfix) with ESMTP id 02AC66B6F7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 18:51:20 +0000 (UTC)
Received: by mail-pg0-f68.google.com with SMTP id p66so1634006pga.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KOlBtvvtw0SoDZD9hY7O0Fl4829B1VpRDjvW83BEeuM=;
	b=0z5CnqzWiBYPrCUBsWYi/YtRjqtwnBSB4YQU4hCF0/gJyNZoLoI/+DzSZiGBxfzW+b
	GR03SNmxtRjOKlk1ubWEnDljNA2kM2q3hLNEGyFkR/epqyna1cZlfSUO+0ttq6krAIXU
	cm+/yvHJkvKc677rqFbBoy6KT8Jh4PQjCDbuJF3c5GzAKf270dbxllZRNONwr/mvG9tl
	+KVO8cEVPxsoA+pOAn/Vov1idcdeknSKcMDLpKfG29WcF8V5EuSvUnxBOMvu1NDk6JVD
	hSStIOvUMUe2KT+mwpOLCk3QvPvqCLurOLPQpjD8g42nY5mBZYZ6LoaPYjW2dXdwlP4v
	gNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=KOlBtvvtw0SoDZD9hY7O0Fl4829B1VpRDjvW83BEeuM=;
	b=BnLXXJDE/VXOZBsvk/ptjRwRkRea2fTdSbv4kecnWzoT2XrYr566JzaSZTFPRW8Pck
	3g9UgxB2b9BFCH8fbjo5sY8SDOEhwTGevEx19ZYXKyfk4gWKQzc5VlNgQ9X8674MxMeE
	av3Wj/gWx0BCfZsfaoH/V7WsWckWagY1r6aTpRDUQzVi5NUwWIhCoVe80oRlC+OFrKge
	Fk27lEJ1gwjJIpTnazYw7IIsNpFwTADvAArQC3OC/EgkBRci8AL6qpyFx+vbBFjQNeeH
	dXtflLUwnhgNeje8Pc/qYBr8+0Br9FPAnVXmonQIcCI66wFnsPLopoWfX9VqXpHfWrg4
	8A/g==
X-Gm-Message-State: AKaTC01Ux1ainRvIEMGsaW3jHqh7DgkloqO4QEhUdhZX4WBpEndJWvfIGZP3puEo8T6X2w==
X-Received: by 10.84.216.28 with SMTP id m28mr9706514pli.107.1479927081718;
	Wed, 23 Nov 2016 10:51:21 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	v1sm36537583pgv.33.2016.11.23.10.51.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Nov 2016 10:51:21 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Nov 2016 10:55:20 -0800
Message-Id: <d407c04fa487bb2021e9b3cf9025ac8c413eb4f3.1479764304.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1479764304.git.brian.avery@intel.com>
References: <cover.1479764304.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/1] bitbake: toaster: settings set ALLOWED_HOSTS to * in debug mode
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
X-List-Received-Date: Wed, 23 Nov 2016 18:51:20 -0000

This is a backport of 7c3a47ed8965c3a3eb90a9a4678d5caedbba6337

From the commit to master:
As of Django 1.8.16, Django is rejecting any HTTP_HOST header that is
not on the ALLOWED_HOST list.  We often need to reference the toaster
server via a fqdn, if we start it via webport=0.0.0.0:8000 for instance,
and are hitting the server from a laptop. This change does reduce  the
protection from a DNS rebinding attack, however, if you are running the
toaster server outside a protected network, you should be using the
production instance.

[YOCTO #10586]

Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/toastermain/settings.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 74ab604..6572acc 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -107,9 +107,19 @@ def getDATABASE_URL():
 
 
 
-# Hosts/domain names that are valid for this site; required if DEBUG is False
-# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
-ALLOWED_HOSTS = []
+# Update as of django 1.8.16 release, the '*' is needed to allow us to connect while running
+# on hosts without explicitly setting the fqdn for the toaster server.
+# See https://docs.djangoproject.com/en/dev/ref/settings/ for info on ALLOWED_HOSTS
+# Previously this setting was not enforced if DEBUG was set but it is now.
+# The previous behavior was such that ALLOWED_HOSTS defaulted to ['localhost','127.0.0.1','::1']
+# and if you bound to 0.0.0.0:<port #> then accessing toaster as localhost or fqdn would both work.
+# To have that same behavior, with a fqdn explicitly enabled you would set
+# ALLOWED_HOSTS= ['localhost','127.0.0.1','::1','myserver.mycompany.com'] for
+# Django >= 1.8.16. By default, we are not enforcing this restriction in
+# DEBUG mode.
+if DEBUG is True:
+    # this will allow connection via localhost,hostname, or fqdn
+    ALLOWED_HOSTS = ['*']
 
 # Local time zone for this installation. Choices can be found here:
 # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
-- 
1.9.1


