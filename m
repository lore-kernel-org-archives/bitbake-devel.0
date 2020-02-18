Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id 978B7601B5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 22:00:55 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id n3so2152044wmk.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dKTRv60EKBqteur+SD4W7ZnVYkaXXf5B6Yl8EIOPAGk=;
	b=XRGbI+rPYSIblInqxcokU8cZmrxcek2ztZF17dT+Ew86Jvb0cB0B7lt9Y2YM30nVj0
	nz5uBUt++x9S/41TeLkFsnhoaD5Op/sdR3f/9VVIlVTGJm0+jRkfAduKrTFLTvbAR6SC
	CVQP/5Q3nBlf4jQxhJnO/ToZ1JC/FbkdWU540=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dKTRv60EKBqteur+SD4W7ZnVYkaXXf5B6Yl8EIOPAGk=;
	b=pvlTIjkF010p1B6fxYBaI/+gzEhh0UOA1LwMK+aUOJ4A2B6zToFwu54en2k2fiGiEe
	4t1jl1NpuWiHU2Vl4+kLdriSX+4TXaRIuoS+oHhQ4wtGbVZplI88Ij5C08YuFjZnXniJ
	cXeOz40blXoxB88tE66j3ZK3Y0pJB/yYqn4gw9uumrcHUMfxRio7vDdGSq9zovZuGZUl
	SW3aiybtSb1xth8jMAN3/RP2HzENZvqq2wUkzNPEorvFjdPcwdEbySt2XQz0q0v0Z8Sj
	JLraxjhyrr3b54dAqCAjPL7V2DtAXx7rFP3FKvJ/EbyyUzmM/NQ4d0lKwuv3GNL0YJK0
	4OZw==
X-Gm-Message-State: APjAAAW3Nc6FhpTduDabJ9rM7VJMxLFZA2fvoV5z42bGuhRZ9wAatxj8
	kMXdbeCt+Elo8e/YC/KIDbJgqx0SrLE=
X-Google-Smtp-Source: APXvYqxLIzFNkp/hCSrGogD0HjEB8Yn+8vH4m/p21XYcWDLGyJNsImzZFhASan4s+YTWBj7e/wp4JA==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr5274044wmi.70.1582063255730; 
	Tue, 18 Feb 2020 14:00:55 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id q9sm66450wrx.18.2020.02.18.14.00.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 18 Feb 2020 14:00:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Feb 2020 22:00:54 +0000
Message-Id: <20200218220054.74923-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Subject: [PATCH] cooker: Reset loghandler
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
X-List-Received-Date: Tue, 18 Feb 2020 22:00:55 -0000
Content-Transfer-Encoding: 8bit

When parsing, reset the loghandler when finished, else the messages
can be misleading.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a05630d52d..2d937a413c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1949,6 +1949,7 @@ class Parser(multiprocessing.Process):
 
     def parse(self, filename, appends):
         try:
+            origfilter = bb.event.LogHandler.filter
             # Record the filename we're parsing into any events generated
             def parse_filter(self, record):
                 record.taskpid = bb.event.worker_pid
@@ -1971,6 +1972,8 @@ class Parser(multiprocessing.Process):
         # a SystemExit event for example.
         except BaseException as exc:
             return True, ParsingFailure(exc, filename)
+        finally:
+            bb.event.LogHandler.filter = origfilter
 
 class CookerParser(object):
     def __init__(self, cooker, filelist, masked):
-- 
2.25.0


