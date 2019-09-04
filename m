Return-Path: <wesley.lindauer@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id A492A72EB7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Sep 2019 15:50:05 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id r4so30003015iop.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Sep 2019 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=bigSN5HY3Wurb/pG0r6pdDOo5/QMf/0b4oQpKtq6RkM=;
	b=Oegracrm1IT0n4PnvbVpxslyewv4+IG/HG038v2ODiTNQC28m7pn7jvLqDrlvr8d85
	W/bJV6k63zBVIhqIcS0IGRiRVcfWKHNfAWmsg8nUIUxtGAo8i0HOUYxJPc089D0jIheu
	u/ELFsooYP43tncRirz37MmVqRHWzZdyoshK/zqLa75c5rjpTuM+4k9ueMr/I+ixTbql
	PKlwSvhQy34IFaXULkyWx23FGabyGwWpT/8r9WaRsWR468+h8szGuDdChgNwrz3he++9
	HtxpxzPCCkEE8MTtlZ5th+LMtST7jqf3nILFUOPoNGSfMIPjHvF05JipaRRf1CwaIvwH
	xeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=bigSN5HY3Wurb/pG0r6pdDOo5/QMf/0b4oQpKtq6RkM=;
	b=VDblTCB2EOaO4XnoAIUp9L+7ri+jaDG9QvX3UkeE0lHt1ret2tp6xE6tYB68CLxjL5
	V5Ks36CHPLpE6jQPOr1UaSxVYoVAhTQYKCEo408v7WqKbuYKywawtAS1fQi5aAaiULzh
	3nrWGMbBlFwN6DGANNVXlKbC5uTwppvrjMmyxq+TFuRybtNpHhbGo1eC7mVU2OEsOG8w
	+NiYqXiqX9tnphH9vFZoBGrENTIzKQ52ZQS3nJ8WeJXismAUcU8LLvkIjqmcUlxH+PsG
	ZAOAC4xUtLyOGSAcI/eRVu+tVgz3W0q6qJ/410wf15ev6q/sN8F/KDmDMbRJG+0qqqef
	6lnA==
X-Gm-Message-State: APjAAAXIqZLl7MYTXeklx+7tjfrnrBrp388b/Gi6kU1BwHDfD0MtIw+i
	hN0Pdn1ZE219lLa7TbM2VUZvVrtVqrfHklLC
X-Google-Smtp-Source: APXvYqx4aN5SJGSmY4TZgV8QdHBkmUBm1GxRjlxgmn6RNqWrvXcaEFrYifNKNXEip/AYo6DfVw5MAg==
X-Received: by 2002:a02:7044:: with SMTP id f65mr21070286jac.37.1567612206588; 
	Wed, 04 Sep 2019 08:50:06 -0700 (PDT)
Received: from camaro.lpdev.prtdev.lexmark.com
	([2600:380:5c13:7f9c:59eb:8f16:e2a0:29de])
	by smtp.gmail.com with ESMTPSA id
	j16sm17898353iok.34.2019.09.04.08.50.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 04 Sep 2019 08:50:05 -0700 (PDT)
From: Wes Lindauer <wesley.lindauer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Sep 2019 11:49:56 -0400
Message-Id: <20190904154956.804-1-wesley.lindauer@gmail.com>
X-Mailer: git-send-email 2.14.5
Cc: Wes Lindauer <wesley.lindauer@gmail.com>
Subject: [PATCH] bitbake: cooker: Ensure bbappends are found in stable order
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
X-List-Received-Date: Wed, 04 Sep 2019 15:50:05 -0000

Thanks to wildcards in bbappend filenames, it's possible to have
multiple bbappends that apply to the same recipe in the same directory.
In order to get sstate hits between different workspaces, we want to
apply those bbappend files in a consistent order.  Since readdir()
returns files in a non-deterministic order between workspaces (based on
inode number and/or time of creation), we'll need to sort its result in
order to have any consistency.

Signed-off-by: Wes Lindauer <wesley.lindauer@gmail.com>
---
 bitbake/lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0607fcc708..a9ee142aa5 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1869,6 +1869,7 @@ class CookerCollectFiles(object):
             (bbappend, filename) = b
             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                 filelist.append(filename)
+        filelist.sort()
         return filelist
 
     def collection_priorities(self, pkgfns, d):
-- 
2.14.5


