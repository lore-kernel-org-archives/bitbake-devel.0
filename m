Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 95A7E6FF7D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 14:26:01 +0000 (UTC)
Received: by pacwq6 with SMTP id wq6so30479004pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 06:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hii0uaKiM8ptp2fMxRnHBlWxndcPFkhKucLIuyIYz3U=;
	b=p528jSDb1+8Ku2zAqO7+GRKKPQquoGkvDUQ9/9VcJw0qWvgxhhZ8px+YQFqFhAQzED
	ljFUhHWeVDclg1ggCGQYeGD2KSU9QPwjQuKEUvltNOa6ZySbJU/kT5ZOYWp8XXSlSIq8
	VnwJbgsGvyU3kDHlbYU4FGXYpSnodBB5mmv5SoBI8c+rRu0u4/E7R8BJIuolLttX9mgM
	9feoBToOCTpOEc+JE92MmP45LyHbyNoaYvxUhQI8SIOQlLSiEGgi4oAdwtFrVad5QcLe
	ttN283ig5lSiOQMIAc2lCCHMNuzOIZbOOjcbT+p2HanFcEf9MArqSR7zRlpQKdqkCn/t
	lzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hii0uaKiM8ptp2fMxRnHBlWxndcPFkhKucLIuyIYz3U=;
	b=Ee44FToe9WiFeFTRU9TRamrwxvME4euHAm1FcRTLnVcx2r/zOUpqVY9xfTe/h3KmYT
	yzjfFmyXaQm+JQfkNRd7NAbhv8RSQ9pU96kAxJDBRe8CPW7/RUFaDpqlPrfo75rHCPxR
	AnoVIYJavQCC2h05WblczolsqfZCJLI2af/ikYwFXNJZbjtHzefLhPUJyC/wzY8/jz2q
	DtxSpQKgUT1Fw74WBXGMbY63Fym5KlKA57JsZjL43gw4e2WMQJA6+hzVGd/AGoZ7FsYQ
	LogDt6d0h6SrpXYJ3xx/rQtHfVJwBX5L6+x+QDOM9+fLWRpLmPBvTdsSJLWgvYDmejp/
	ZrEw==
X-Gm-Message-State: ALoCoQnDT1QPK7STeSDhwzLzqQw1JS6byuCDa82RP9w5QL2eRGWGnisYJ2hQuAdj0OhtF8yppsgAGczibF76jTzfBCvy0xe69Q==
X-Received: by 10.66.100.163 with SMTP id ez3mr8413908pab.5.1449671162510;
	Wed, 09 Dec 2015 06:26:02 -0800 (PST)
Received: from draco.icx.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	k2sm12095175pfj.25.2015.12.09.06.26.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 06:26:01 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 14:25:47 +0000
Message-Id: <1449671149-9455-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
References: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/3] toaster: implement BitbakeController.triggerEvent
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
X-List-Received-Date: Wed, 09 Dec 2015 14:26:04 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This API will be used to pass data from Toaster to
toaster_ui and buildinfohelper.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 8b99318..781ff73 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -55,6 +55,9 @@ class BitbakeController(object):
     def getVariable(self, name):
         return self._runCommand(["getVariable", name])
 
+    def triggerEvent(self, event):
+        return self._runCommand(["triggerEvent", event])
+
     def build(self, targets, task = None):
         if task is None:
             task = "build"
-- 
2.1.4


