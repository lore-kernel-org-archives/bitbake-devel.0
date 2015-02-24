Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id D503060670
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 10:54:41 +0000 (UTC)
Received: by wghl18 with SMTP id l18so9434285wgh.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 02:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8ydkWZO+qVSb+7R29ptPrwJByJ5qq/Aewu3foDQnIXQ=;
	b=kXBR7YxKbQ2xqwjzbSs9/zj8YaFDvKYD0dgMxB2u72sOiCZPYREt4otL/tz/EQafed
	REEeyoAp4jpmr2LR4kb29Xm4mJNGkrpjrFjFeB4TJzAbicRfnqYRqZzOkVakD/FPjEHU
	oXiy0uSrSp46MTiowyEiRPOZh5HIxw+ggnZl3LNH7N51YJ6z3CANJnS+0u9EcaPSYBbu
	ofQ4wlAcdNMxkpTJBbKmQqVYPcAetT1GNoMjbsQKNxpj07mVsphoYxoVtMtnHUao3ffq
	v/rYNDgDyzoRr/GOKUiv/zTthyc58rS1YPC8U+NnnTNvFNttJiNIdHaJBBIahaL1IIRM
	YYwA==
X-Gm-Message-State: ALoCoQkzodTcF50JbUfOL6+rMDNqkV32NKVICtsONu/EnGmgm+6msvyiY2cJa/w9BFfckIXpz4Xk
X-Received: by 10.194.77.133 with SMTP id s5mr15561582wjw.71.1424948082210;
	Thu, 26 Feb 2015 02:54:42 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hg7sm778811wjb.44.2015.02.26.02.54.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 02:54:40 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 9FA65561A8B; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:59 +0000
Message-Id: <02c421674ef454ddeb45db7cd8c6f57dfe6b4349.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 11/12] toaster: fix typo in models.py
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
X-List-Received-Date: Thu, 26 Feb 2015 10:54:43 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The typo caused the tasks table to break when a task has no
help text.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 15481e5..01ad16e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -366,7 +366,7 @@ class Task(models.Model):
             return self._helptext
         try:
             self._helptext = HelpText.objects.get(key=self.task_name, area=HelpText.VARIABLE, build=self.build).text
-        except HelpText.DoesNotExit:
+        except HelpText.DoesNotExist:
             self._helptext = None
 
         return self._helptext
-- 
1.9.1


