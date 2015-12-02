Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 992AE60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:32 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48535819pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=aUEC5WmVeAfukY6caAkxqxw1FRGHdXWnEev2bl1G/WQ=;
	b=zxU9T9TFvnmqJK8LcpNUP9ubpCLWt10CuIHsTZvjI6WPuTq448rCSpEsRNk7B7BJ83
	/9RlFw2YeVAymonBZ9Z7PdI+3OsM5X+f6kh790r8ptjWH0eDNPeuXjtWL8x8Y3nTH1W+
	lfq/kcHCxaOwKsb+fTvpEhD6rKQxN8rLtd2L1IZejrvP4rJ9ddfpklYEAaDiAvYxxfNa
	aRKgVq159ki8d5D3jWcxO4x+mbKD9CP9lLhzqW0yz0EpngANAcrkQ3POGpJn+2ZU6zLQ
	HcHDdRdGX1KKHUlObHf+uuftFcNcJpyyxbt0ALpC4Gcff1Nv7XNfDHUvwcz06k7+IGP/
	YwoA==
X-Received: by 10.98.14.15 with SMTP id w15mr6461426pfi.145.1449079172912;
	Wed, 02 Dec 2015 09:59:32 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:32 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:34 -0800
Message-Id: <1af0d9455e414673b2cad068c652acdb2fba07ae.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 02/30] toaster: implement get-dburl command
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Implemented management command to call getDATABASE_URL API.
It will be used to get database url from toaster shell script
by running 'manage.py get-dburl'

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastermain/management/commands/get-dburl.py | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastermain/management/commands/get-dburl.py

diff --git a/lib/toaster/toastermain/management/commands/get-dburl.py b/lib/toaster/toastermain/management/commands/get-dburl.py
new file mode 100644
index 0000000..22b3eb7
--- /dev/null
+++ b/lib/toaster/toastermain/management/commands/get-dburl.py
@@ -0,0 +1,9 @@
+from toastermain.settings import getDATABASE_URL
+from django.core.management.base import NoArgsCommand
+
+class Command(NoArgsCommand):
+    args    = ""
+    help    = "get database url"
+
+    def handle_noargs(self,**options):
+        print getDATABASE_URL()
-- 
1.9.1


