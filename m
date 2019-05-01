Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail.openembedded.org (Postfix) with ESMTP id 331107D574
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 22:09:02 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id q15so30221wmf.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7Wfku+yJOqmRopumeUtHQ9kJ/i1wiFNusoMihUOnwLM=;
	b=fzQuMdmofppoC3LTAUDplV4+peBhDI3PKP2LYCfjKNod6ceouk9eE8JNxnL+/8O5rC
	sZijhTNGUr2dza4qmbDkcMl5ooC+LOFScqjQhBT3NLCEAzHSEJq+9EzOYYEJegAPCaF8
	nYJiNJGjdVTzs54zJs780FxE3ZIQAO/pJ5KSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7Wfku+yJOqmRopumeUtHQ9kJ/i1wiFNusoMihUOnwLM=;
	b=HaSfMv+ERM6Hyg5v1EeBhtpKlWhhQk4Mp/a8lOrMQQxqctN2tbpXTwMTQ+ggzsNzZ8
	qSsDQS9IFAIUpFrrazCTt/22rHDVNQ+ueyvP/i1XTWuZTVsqk9kzTxVNPI6wAkI8mwmt
	q+5wmzVihxPFz60IpsBTscS6tcq6mKdHpsZLNmSS1NqLey0RwoteErtJLjm+PxdEmCQb
	E/KDhNo+Hi4x89eMwaT0mzqI6Ba5AYY0i8KiHLjBRWG9QLQZ2ddiigHCNObkwx42xQW6
	s2RJ5gBLcdcMKqAzYd8qKb691P2LCfx0P4JBBQsbMali1D+jdyNC+rp1qo+zzOdI+ihk
	l+BQ==
X-Gm-Message-State: APjAAAVGO9ujW8g6Pw09uZGyGftGKYUaMQoWbQ76V6Ae57S7E+kr/MH4
	ZRx3h51toK79WK95bccuyQEBXXYOMpQ=
X-Google-Smtp-Source: APXvYqxeKXOMRnBRFT6+mQwIdcUkuyj1P5ieKGG6ZbPx4+Gl2ekwaHnogNx9ZNKHUemolS0dyOPYUA==
X-Received: by 2002:a1c:1f58:: with SMTP id f85mr48625wmf.17.1556748542340;
	Wed, 01 May 2019 15:09:02 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	w17sm21862673wra.81.2019.05.01.15.09.00
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 15:09:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 23:09:00 +0100
Message-Id: <20190501220900.26250-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] build: Disable warning about dependent tasks for now
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
X-List-Received-Date: Wed, 01 May 2019 22:09:02 -0000
Content-Transfer-Encoding: 8bit

This breaks with rm_work so disable the warning until we find a better
solution (and change the test accordingly too).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py       | 4 ++--
 lib/bb/tests/parse.py | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 8ad9f5de2a..a228b05ddd 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -818,8 +818,8 @@ def add_tasks(tasklist, d):
         if 'deps' in flags:
             for dep in flags['deps']:
                 # Check and warn for "addtask task after foo" while foo does not exist
-                if not dep in tasklist:
-                    bb.warn('%s: dependent task %s for %s does not exist' % (d.getVar('PN'), dep, task))
+                #if not dep in tasklist:
+                #    bb.warn('%s: dependent task %s for %s does not exist' % (d.getVar('PN'), dep, task))
                 dep = d.expand(dep)
                 task_deps['parents'][task].append(dep)
 
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index aa7adc40f2..747fc35fc2 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -203,5 +203,5 @@ deltask do_fetch do_patch
         self.assertTrue("addtask contained multiple 'after' keywords" in stdout)
         self.assertTrue('addtask ignored: " do_patch"' in stdout)
         self.assertTrue('deltask ignored: " do_patch"' in stdout)
-        self.assertTrue('dependent task do_foo for do_patch does not exist' in stdout)
+        #self.assertTrue('dependent task do_foo for do_patch does not exist' in stdout)
 
-- 
2.20.1


