Return-Path: <armccurdy@gmail.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5863473217
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jul 2015 23:09:14 +0000 (UTC)
Received: by pdbbh15 with SMTP id bh15so3327718pdb.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jul 2015 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=ojbazpPma8ZvKLQbqE57lzkqUpf9OWw3YoMQArveAdg=;
	b=dMtpnUTGsBBhJFqGSxJkCEDkZsNKZZRfbPDXLoWy1nvvCsOp4beyPBQs0fLqEy0BD/
	9f6GLaFi7zlS0KKOwQ3qY6ndGplhbUG96jRIo/CGt+lkBB7lEemPXi68Dxrj0FzS2Kux
	kdGKHQwvL1Q05frKWTf1lLc6L8BjTKRIXM35BYCc/hlPEwExx357y5NUMZmOz373tdB8
	AytgVo31P3s99gD0ICoUMnLBpWXTGg1ASxvOJMW5ldxdrITCiFTUgu+T09KoL/xwbwp0
	DzyzRMlZ5BphxPHlG/MCEYppeboHtGaaY4NU4cYNNgfqkMhH4O+f7GSM4eEyopg16HFj
	VW9A==
X-Received: by 10.70.63.37 with SMTP id d5mr23981925pds.162.1437692954521;
	Thu, 23 Jul 2015 16:09:14 -0700 (PDT)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by smtp.gmail.com with ESMTPSA id
	da3sm10887056pdb.8.2015.07.23.16.09.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 23 Jul 2015 16:09:13 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jul 2015 16:09:01 -0700
Message-Id: <1437692941-7139-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] build: Exit scripts with result of last shell function
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
X-List-Received-Date: Thu, 23 Jul 2015 23:09:19 -0000

Since shell scripts run with 'set -e' the final exit at the end of the
script can only be returning 0. However, for correctness and to follow
the original intention of the 'cleanup' commands, let's fix the typo
and return the success of the last shell function rather than the
success of unhooking the exit trap handler.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3439964..764163f 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -313,7 +313,7 @@ def exec_func_shell(func, d, runfile, cwd=None):
 # cleanup
 ret=$?
 trap '' 0
-exit $?
+exit $ret
 ''')
 
     os.chmod(runfile, 0775)
-- 
1.9.1


