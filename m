Return-Path: <zzs213@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by mail.openembedded.org (Postfix) with ESMTP id A0660731BA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Aug 2016 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LzWuV
	ArN+qPoFWSfJA/hMftkiSQYidTwVIwlXMCxTEE=; b=c2nMV6Q4EsXejM19yXeMq
	6Y4Nr5icLJr8kzxEwOn2wCDTjDQtyBXW4AxdiGYDXXzJKQ6v9eEGj5w2hwQef2s1
	6zkSfq9SGuhQuhGYzgk2RUlj4ruicQuOFeYPPd3mz1vnZep5BDR1OpR67dCOsmXA
	ztBwMeNxZ2HiXZPWsUfCjg=
Received: from localhost.localdomain (unknown [171.212.170.252])
	by smtp1 (Coremail) with SMTP id C8mowAC3QskA1b9XjwPpDw--.25134S3;
	Fri, 26 Aug 2016 13:34:58 +0800 (CST)
From: zzs213@126.com
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Aug 2016 13:34:59 +0800
Message-Id: <1472189699-6646-1-git-send-email-zzs213@126.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-CM-TRANSID: C8mowAC3QskA1b9XjwPpDw--.25134S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry3CryfCrWUKF1ktFWfuFg_yoW8GFyxpF
	W3G3Z5Ar1vg348Cr97XFWxJrn8Gw40vFW3JFy7Jw1F9a13Aw10qrW3K3s8K34UZF15J34S
	9rWSyFWYvw4jgaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHZXOUUUUU=
X-Originating-IP: [171.212.170.252]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiqAPRGVc1pdA8WAAAsQ
Subject: [PATCH] enable override for suffix just include digit and dot
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
X-List-Received-Date: Fri, 26 Aug 2016 05:35:01 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 张忠山 <zzs213@126.com>

Without this patch, if we write these in recipe test.bb:

	NAME_1.1.7   = 'version is 1.1.7'
	NAME_develop = 'version is develop'

Use 'bitbake test -e' to observe 'NAME':
	#
	# $NAME [2 operations]
	#   override[develop]:set .../test.bb:10
	#     "version is develop"
	# pre-expansion value:
	#   "version is develop"
	NAME="version is develop"

Obviously, override for '1.1.7' missing.

Signed-off-by: 张忠山 <zzs213@126.com>
---
 lib/bb/data_smart.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 59621b7..ea4ff80 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -559,7 +559,7 @@ class DataSmart(MutableMapping):
         # aka pay the cookie monster
         override = var[var.rfind('_')+1:]
         shortvar = var[:var.rfind('_')]
-        while override and override.islower():
+        while override and (override + 'a').islower():
             if shortvar not in self.overridedata:
                 self.overridedata[shortvar] = []
             if [var, override] not in self.overridedata[shortvar]:
@@ -637,7 +637,7 @@ class DataSmart(MutableMapping):
         if '_' in var:
             override = var[var.rfind('_')+1:]
             shortvar = var[:var.rfind('_')]
-            while override and override.islower():
+            while override and (override + 'a').islower():
                 try:
                     if shortvar in self.overridedata:
                         # Force CoW by recreating the list first
-- 
1.9.1



