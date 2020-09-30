Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
 by mx.groups.io with SMTP id smtpd.web12.7034.1601435564810995953
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Sep 2020 20:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@126.com header.s=s110527 header.b=CJW6iS4+;
 spf=pass (domain: 126.com, ip: 220.181.15.113, mailfrom: zzs213@126.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=U9DFN
	YTnBHwYKfX/Nh2HMexo8BFtDJK8arkbw5ckpss=; b=CJW6iS4+RlSD/dplZvvqX
	ahjHwiZv0qiU+wLGMqkPQr3M0TKgbJctIGtMmRDdVwR6tYd760QCYUPqyv5AaiDq
	c44xXZVifZufo725MPTJ1up+dvZF6YIzuNbGXJCmWQTyv0AtdmBdREexxp88RFuZ
	makg5ZXqFxtsMZSDYq9/o8=
Received: from localhost.localdomain (unknown [171.221.71.152])
	by smtp3 (Coremail) with SMTP id DcmowAA3rAB193NfVgjvKA--.11238S4;
	Wed, 30 Sep 2020 11:11:51 +0800 (CST)
From: "zzs" <zzs213@126.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] using same logic for overrides
Date: Wed, 30 Sep 2020 11:11:29 +0800
Message-Id: <20200930031129.9934-1-zzs213@126.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-CM-TRANSID: DcmowAA3rAB193NfVgjvKA--.11238S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4DAr47trWkXry3XF4xWFg_yoWxtFX_JF
	40y3y3ZrsaqFWxXa1ruFs5tr18Kr4DuF18AF1UArZaqa4Utrs8WryxtryktrsxuFyqqF9r
	Wr9xXF9xGws5XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0gtxDUUUUU==
X-Originating-IP: [171.221.71.152]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiZhevGVpD-cxyNwAAsq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 张忠山 <zzs213@126.com>

Signed-off-by: 张忠山 <zzs213@126.com>
---
 bitbake/lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 7f1b6dcb4f..7689987f05 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -648,7 +648,7 @@ class DataSmart(MutableMapping):
         if '_' in var:
             override = var[var.rfind('_')+1:]
             shortvar = var[:var.rfind('_')]
-            while override and override.islower():
+            while override and __override_regexp__.match(override):
                 try:
                     if shortvar in self.overridedata:
                         # Force CoW by recreating the list first
-- 
2.28.0

