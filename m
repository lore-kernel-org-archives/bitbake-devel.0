Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f170.google.com (mail-wj0-f170.google.com
	[209.85.210.170])
	by mail.openembedded.org (Postfix) with ESMTP id 6F6EA6013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:04 +0000 (UTC)
Received: by mail-wj0-f170.google.com with SMTP id tk12so19377198wjb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MD0XfTY/VNfLQD+xhV0ah/XgtnhIwZbmRN4c0ziX/+c=;
	b=LVmF9m75A2lU+qwyvIyWmINY0hJbKSsf6gtGLAcFy4VmtcgadSHkZ0Qn6F7XkAp8+d
	Sl46tIWno+0lIGXowuWnkpdm2YHURPUq0K9Ko/S+NbafdocesAqaMvCbKSbw9xAi+eMM
	EX9R97IbNAMHiJV1hAXW0zWEAxmCLbgrtfe1BhZDDqSGq3/8awuzv/0FfgAaSi2ta/7z
	BihPGttOOhoW3JXpm7rrxFPksaHDup1gllURtqOVjnNbVTHgmyibRqaeCBZPQM7ajfyR
	DHz71dhHWyQTea8I/eYVBNbYIHie09zn/kZaQoUxZfgpmKYRbqqDAGHHJb8fZl2++zHE
	TvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MD0XfTY/VNfLQD+xhV0ah/XgtnhIwZbmRN4c0ziX/+c=;
	b=EmNg0yLYJcia01d4WgmnqZSr8qID4G4fUlpdHRiAjOe/yKxBtWqvtjWfnlDJf0T9YA
	uJphX3nVbfeSVtudZsRpeJhctNlCv8659077aqPWUPuXBQmDskSGMU92rAJkyQrA1yYB
	yNAqt2k2D8RH7Kdbl65uTfPEytYerOzCskhzGuj+Y3611qytsYKx4xklS3ieZsllWIMN
	DtLsnycLOT7C5Fp2oZDe4kQffdI7MhqZXCf0SwVXj1/KYWK3ETXywPp3aAr/CM6LcIkE
	ULYONI0TUrytjRSZRYibZxPqJNgQvHpt7sWJGftuEKhAhACyX+C4b6MK8dlnSbZOSR4X
	tkew==
X-Gm-Message-State: AKaTC00asavai/8QyKC/xWLAcnHZ3EXu8c8nJwSWMPVbj7eErTMbnUXKLUwuT72Jetxmw7tl
X-Received: by 10.194.123.103 with SMTP id lz7mr79301480wjb.100.1481302385159; 
	Fri, 09 Dec 2016 08:53:05 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:04 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:43 +0000
Message-Id: <1481302375-7985-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 02/14] toaster: models Layer fix whitespace
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:04 -0000

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8816fe0..4cd6683 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1385,7 +1385,7 @@ class Layer(models.Model):
     name = models.CharField(max_length=100)
     layer_index_url = models.URLField()
     vcs_url = GitURLField(default=None, null=True)
-    local_source_dir = models.TextField(null = True, default = None)
+    local_source_dir = models.TextField(null=True, default=None)
     vcs_web_url = models.URLField(null=True, default=None)
     vcs_web_tree_base_url = models.URLField(null=True, default=None)
     vcs_web_file_base_url = models.URLField(null=True, default=None)
-- 
2.7.4


