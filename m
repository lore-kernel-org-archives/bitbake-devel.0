Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 06C1265C78
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:33 +0000 (UTC)
Received: by mail-pd0-f173.google.com with SMTP id ft15so3357238pdb.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HouocGPQw7kYF4ZpwBal9RZghME65nLTwATopsQynOA=;
	b=CGYCx6PbsWZP7y5Lher3wGeIDra5jFMFMXzSS4955X/lbXjq+PDARjyjdojl2mog8N
	p7EqsqBV5Jyc6x1txOZCE98WEfrtMpqQthRHaeSWs7hBj+2/daLqv7Lsu7hDt566xcvU
	k2iDCOG5EUE1ycwx8H4nAjdgTRrzRvH0/xa3F6DhhFERbtVgmdEiu1yizxDVZYeBEoEy
	vj3jWxTVTHIst16PY1yuD1wULDTiqL149CT/WjNuJTBbiUCKugUsjKOWLDbjT74TtFKV
	nf5uL/uwz3KAWXnkamSI/nY8n2yV6B44eC/yrkWs5m9qfTL3Z4OJ1LqYKoIyZ8l1QnnY
	w1UQ==
X-Gm-Message-State: ALoCoQlbNa8CZlvC6U5kE0rnOxb2F/sIo0lLQwGQfn2rMUx2Lab4flaF+oNszx6ikEMt1NkrnoeA
X-Received: by 10.68.190.229 with SMTP id gt5mr8912246pbc.119.1416500853875;
	Thu, 20 Nov 2014 08:27:33 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ny9sm2501985pab.25.2014.11.20.08.27.32
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:32 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 78D4A56410C; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:18 +0000
Message-Id: <3f614295d688c33b690f63ff7eb28e6988707919.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Subject: [PATCH 02/11] toaster: skip virtualenv when searching for django apps
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:34 -0000

From: Michael Wood <michael.g.wood@intel.com>

If we are using a virtualenv in the current search path we end up trying
to add modules to the django apps list which do not have the correct
load path or are internal to other modules. Fix this by skipping the
virtualenv path.

[YOCTO #6896]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastermain/settings.py | 4 ++++
 lib/toaster/toastermain/urls.py     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 8de3b52..0974b90 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -264,6 +264,10 @@ import os
 currentdir = os.path.dirname(__file__)
 for t in os.walk(os.path.dirname(currentdir)):
     modulename = os.path.basename(t[0])
+    #if we have a virtualenv skip it to avoid incorrect imports
+    if os.environ.has_key('VIRTUAL_ENV') and os.environ['VIRTUAL_ENV'] in t[0]:
+        continue
+
     if ("views.py" in t[2] or "models.py" in t[2]) and not modulename in INSTALLED_APPS:
         INSTALLED_APPS = INSTALLED_APPS + (modulename,)
 
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 1ae6245..549fda1 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -55,6 +55,10 @@ if toastermain.settings.MANAGED:
 import os
 currentdir = os.path.dirname(__file__)
 for t in os.walk(os.path.dirname(currentdir)):
+    #if we have a virtualenv skip it to avoid incorrect imports
+    if os.environ.has_key('VIRTUAL_ENV') and os.environ['VIRTUAL_ENV'] in t[0]:
+        continue
+
     if "urls.py" in t[2] and t[0] != currentdir:
         modulename = os.path.basename(t[0])
         urlpatterns.append( url(r'^' + modulename + '/', include ( modulename + '.urls')))
-- 
1.9.1


