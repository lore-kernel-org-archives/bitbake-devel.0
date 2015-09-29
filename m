Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0562877030
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:59 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so198601835pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=O2HzYvCMLn8YKvueQOxQ1xCuTI9N0lSoNO98/AHKIfc=;
	b=e+JXDQQPuewAdhnXEshTSEJ2dqHuMWVbLdUttXENDWAobIow4+QfYWH/vqy0Lv9BBc
	XqzwXvVLshZ9z67lZ6B+05vR8ssROnlB0WpuGi+y+NjCkNEgexx0IpAwPJ/oWO9rV8EL
	6exDyyDg0XAwe2gwJVnpHoPcY391G3Kgt/9wvesQ46KUfeZdLgykAFjacL0eTX2qym+f
	eiC3dMBYjeCLvSZWLVr/kMx0PugZH3xltxIxdJtH2PZ1zrdVmRhbEhzul/QUyjOoIUU+
	C/KTpGQ021YzlA339+vXowCiAc+bzworyY8LgQR3cdqDeJ2TmcyNPeJ/BvfRatL1RMiP
	Vo8A==
X-Received: by 10.69.3.228 with SMTP id bz4mr31119690pbd.79.1443501840130;
	Mon, 28 Sep 2015 21:44:00 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.43.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:59 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:16 -0700
Message-Id: <5daee42dcb5899b07565b912b4c5f20f8e99f0ad.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 06/22] toaster: add nocache option to the ToasterTable widget
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:00 -0000

From: Michael Wood <michael.g.wood@intel.com>

Useful for skipping the cache mechanism when debugging.
Simply append nocache=true to the end of the url with the table in
it.
Also adds a debug message if the table is using cached data.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/widgets.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index aaa59c0..d7d5efd 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -253,11 +253,14 @@ class ToasterTable(TemplateView):
         search = request.GET.get("search", None)
         filters = request.GET.get("filter", None)
         orderby = request.GET.get("orderby", None)
+        nocache = request.GET.get("nocache", None)
 
         # Make a unique cache name
         cache_name = self.__class__.__name__
 
         for key, val in request.GET.iteritems():
+            if key == 'nocache':
+                continue
             cache_name = cache_name + str(key) + str(val)
 
         for key, val in kwargs.iteritems():
@@ -265,6 +268,10 @@ class ToasterTable(TemplateView):
 
         # No special chars allowed in the cache name apart from dash
         cache_name = re.sub(r'[^A-Za-z0-9-]', "", cache_name)
+
+        if nocache:
+            cache.delete(cache_name)
+
         data = cache.get(cache_name)
 
         if data:
-- 
1.9.1


