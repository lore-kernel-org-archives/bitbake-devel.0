Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 58774606BF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 14:15:07 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id q128so175291007wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=mDEZ7z4Td6/CVr/7vnK3gTkIs23N20+Yg8vhsKLwEuk=;
	b=tA+exb9VbdLpYFOcWOZDefe7FhKRh6m565162yBULJ6iiugGvMdSzdLJELog5lEa21
	wAbVCu1OjNGhyh9m6ANuyMjzXErLcGqaPgNtmEEFqDmYJvEKOfsFM9KhJy7rkuUCbf2B
	TxAwwpExT3uRko1u5ASItjNafU/2c0LAC5mGBK1h6fdTvfWyi/cw56kPUKEBLX0kemFe
	NqUiodJQTkSCRKGH/SJ16eh/Jw7SWYqYoDPNxr2sUWdAPEljm+1vCYBwc6YJxb4bUIGg
	HbXz1xl+LXbnlp66iF943u7B5iff6Bkjt3fOpBabM4f/kSB6RFyOt4hbU7XNd9SbTFcV
	LOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=mDEZ7z4Td6/CVr/7vnK3gTkIs23N20+Yg8vhsKLwEuk=;
	b=YHG5ReqdR8dIWGAzLolvW2lvC3BUv6R4qUL3h9MCaYsj30TrVT3W1qLF8DsmgRS5al
	ewPEHDHPCd7ZMertZIey+2B1zTMP5XmNNXkNkT8SLY37LJq7lw8Z40WXdjUy64Q5t8U8
	fBPFv5UPqVjpVDY/+8RSw2e3yRJHzKKtozmqtIq9jTFIWpSAvKhY54g8dzEZQgct4vDW
	zLgh8wiK/nu1KNmzIoEY2Ldk23GlIIMZVWbcDU7oe+wrq7hdcDewPhAexiYpXwByv/gp
	LTJ5ahsh+T0Z9gLYXfyl5058z3PgiZh8yOIouycVS0vEmwdIVmRmMEWuU4msi8lYGK7Q
	WdOg==
X-Gm-Message-State: AEkoouvpE18wmfQSfrU6TXbkrNYd4CE8J/nG/WOxyrJ8JdT4DFucY16l/8l32yc6IOQWXEL4
X-Received: by 10.194.57.244 with SMTP id l20mr21073460wjq.1.1469542507954;
	Tue, 26 Jul 2016 07:15:07 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	f10sm1221900wje.14.2016.07.26.07.15.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 26 Jul 2016 07:15:07 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2016 15:15:05 +0100
Message-Id: <1469542505-5660-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] lib/bb/utils: show subprocess output in stack traces
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
X-List-Received-Date: Tue, 26 Jul 2016 14:15:08 -0000

If better_exec() throws a subprocess.CalledProcessError then show the output to
the user as it likely contains useful information for solving the problem.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 995089a..ce52960 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -375,6 +375,12 @@ def _print_exception(t, value, tb, realfile, text, context):
             level = level + 1
 
         error.append("Exception: %s" % ''.join(exception))
+
+        # If the exception is from spwaning a task, let's be helpful and display
+        # the output (which hopefully includes stderr).
+        if isinstance(value, subprocess.CalledProcessError):
+            error.append("Subprocess output:")
+            error.append(value.output.decode("utf-8", errors="ignore"))
     finally:
         logger.error("\n".join(error))
 
-- 
2.8.1


