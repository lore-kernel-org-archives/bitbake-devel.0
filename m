Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id D98CE745D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 19:27:12 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so23610702wmw.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=cuGDT/n0afxx8FJ7suP4hfkpLsmKzxshtj6JeRyJ/uA=;
	b=h51pHjIEbraG3HgTh8pLSKywYXyRspnQndWnNygNdOWbXwci3gV1PGC4FxH235hpo5
	CidotvjlBUZDGd9fPA95G/72RxW9nVIne5WRDGQfOr7ARv+tJuj9tQu9rXmIw+0+BQt7
	uLBM6DGZh71gLxCVyRSHrjxzgiVST6MvcwNOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=cuGDT/n0afxx8FJ7suP4hfkpLsmKzxshtj6JeRyJ/uA=;
	b=k60OJ4K4FME2ePr969h7knOCKFW//9lxBgClP4eFxzqOTVfroTRE6TxSW5NjFisd4L
	mVRMgDgAk3kfSc92D1r/3PAZuIqLOIyaajg5L/0yvjEwvqpHudiry3yjXRcdWOxTr5l1
	f2azk5nsFzD9cU+RT9jbe6yt9WqZk+ioNNVRTW5b0YgMX4AgQsBkkVyrQjvPkS7xEKe5
	NOATxds/rsodX3H4Sc0Nd3L4ruig+Jme5dq2tSRL2pxRvJSqHltS1ErUz7iXSPk729Z2
	mVarHIkSXEWAWsYiZ6V6aKG7nzpsNk0PrcQengbzAuzgWFcY1qmTP6YLDedH0eiA0k1W
	ZvUA==
X-Gm-Message-State: ABuFfoh38RvGUFEF/p3R3MjOkWBSNTy6vZJLct0cVF9uogkUbFSGMo/X
	TP3PZKjX7ODJRtr0cff4sW7oqvXpomo=
X-Google-Smtp-Source: ACcGV61KWmAkw7m5zulnGT1ekcGJSGEv5BjVgNZSTZPXEodwNFuaPHWE1Oqpv9O5jRXREvuPyHhLyA==
X-Received: by 2002:a1c:ae15:: with SMTP id
	x21-v6mr17307105wme.73.1539718033143; 
	Tue, 16 Oct 2018 12:27:13 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j2-v6sm11979148wrw.29.2018.10.16.12.27.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Oct 2018 12:27:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 16 Oct 2018 20:27:07 +0100
Message-Id: <20181016192709.15771-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/3] data_smart: Preserve history when renaming variables
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
X-List-Received-Date: Tue, 16 Oct 2018 19:27:13 -0000

Currently when a variable is renamed, all the variable history is lost.
This makes it hard for users to understand/debug where values came from.

Improve the code so that history is preserved across renamed variables.

(Expanded variable key names are a special case of variable renaming)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7b09af5cf1..4434142a02 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -267,6 +267,16 @@ class VariableHistory(object):
             return
         self.variables[var].append(loginfo.copy())
 
+    def rename_variable_hist(self, oldvar, newvar):
+        if not self.dataroot._tracking:
+            return
+        if oldvar not in self.variables:
+            return
+        if newvar not in self.variables:
+            self.variables[newvar] = []
+        for i in self.variables[oldvar]:
+            self.variables[newvar].append(i.copy())
+
     def variable(self, var):
         remote_connector = self.dataroot.getVar('_remote_data', False)
         if remote_connector:
@@ -619,6 +629,7 @@ class DataSmart(MutableMapping):
 
         val = self.getVar(key, 0, parsing=True)
         if val is not None:
+            self.varhistory.rename_variable_hist(key, newkey)
             loginfo['variable'] = newkey
             loginfo['op'] = 'rename from %s' % key
             loginfo['detail'] = val
-- 
2.17.1


