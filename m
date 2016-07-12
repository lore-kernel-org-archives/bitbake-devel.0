Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 061F56067C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 15:15:24 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id i5so29621740wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=ChG83picOLHgojBsR4rAHDiTh73doqAlAYEwoXqkeQU=;
	b=huChJWC9QExWPp9bGt7IcVwNwvLfOhGA7sKb52vR2+6wyjMV1U82fbjTx5JYuSBClP
	k3tcMNN/zuRsBzh+R9/odnq/hwoKQ8IxlccHZrt+4nEGH3h/SOUaIzUvrJ0koJvEqr1J
	hZQMV8kR2FTsNVVHIF1qmGjEVixMSCt8JYYTtMbM37uUdMforSlAREoaeHEplydbRVYt
	LBoK7POvVjvO2wfyiUJsbTMagKWvuts3MsmNkxNChPLRgrOTXpL473DIadYLwOWfYvXa
	OaqsDRpVuhLB5OXt5J3OTprhOGy2kQk7gJh5wmFDK5Mt3Pnc2AAxCsFH8USoRCkf/PEf
	6Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ChG83picOLHgojBsR4rAHDiTh73doqAlAYEwoXqkeQU=;
	b=XTMrOj69msnmpkCpdM2phxGp4XEHLpaByCFmHx+UJ3qXGZYHjtXsXUwX29lCGGUAH5
	qmSLFD/9HfJFdbYWgmRqUN3MwdBk65e8Byes6DCv9DaqJer07bJ1+LZQOrfgMrSXRmhI
	xqBah9kRwDgltRFi00RRVM2PuWJvcM8HLufRFWAG8WkhJCpnWbKbdetaZgRHNf50X13z
	PxC2jJf1btrEEPikCutZN4THNCi9mTwhqENYqdSEkDULpLQrr5KggMG1x+cohQe2KZrU
	3B9WuJBTAB+iY9lL42t8HtNyyIg4k04ZJ1s23CfMd21zvWHFkOetSZ6pjVwuTWi5kotA
	bWpA==
X-Gm-Message-State: ALyK8tKdRSARYFOeKxggkAKou52lh7lPdK+lVI1uUsV9WW56O/QNUmU3mdhe3Jppt8RR82db
X-Received: by 10.28.48.130 with SMTP id w124mr4034776wmw.44.1468336524592;
	Tue, 12 Jul 2016 08:15:24 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id r6sm132575wme.14.2016.07.12.08.15.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 12 Jul 2016 08:15:23 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 16:15:21 +0100
Message-Id: <1468336521-8177-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] lib/bb/utils: fix set_process_name
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
X-List-Received-Date: Tue, 12 Jul 2016 15:15:28 -0000

With Python 3 create_string_buffer needs a bytes() not a str() but as we were
catching all exceptions nobody noticed.

[ YOCTO #9910 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0a1bf68..3bc2437 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1444,9 +1444,8 @@ def set_process_name(name):
     # This is nice to have for debugging, not essential
     try:
         libc = cdll.LoadLibrary('libc.so.6')
-        buff = create_string_buffer(len(name)+1)
-        buff.value = name
-        libc.prctl(15, byref(buff), 0, 0, 0)
+        buf = create_string_buffer(bytes(name, 'utf-8'))
+        libc.prctl(15, byref(buf), 0, 0, 0)
     except:
         pass
 
-- 
2.8.1


