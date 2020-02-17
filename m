Return-Path: <bkylerussell@gmail.com>
Received: from mail-yw1-f67.google.com (mail-yw1-f67.google.com
	[209.85.161.67])
	by mail.openembedded.org (Postfix) with ESMTP id 55528613E0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2020 15:26:18 +0000 (UTC)
Received: by mail-yw1-f67.google.com with SMTP id f204so7942686ywc.10
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2020 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=lACI1ruLtnGKLKV6ASguQCFbIso51AT+7u19hH5S0UY=;
	b=Gi5rpoArqLCXzdcA1jhi6z9ov1WpVRUOV7v0TY7dKMTgfrmjXa1LldkPsNQX4DpByJ
	SSJpd0yVtu4yNTOAE0cV/1syDxxWzK2JWgrvOD/C5gzosxFcvuvT1qazP2QwzPvdBtW7
	16h0u+7bj4oMVosQ+BTxWDku/XsZ33A06fCNGwV1Q7AK+gTZA5yIqW5Q7O7pFKRAvpkz
	IExzCq6Qp+8rKbA9TaD/Ic6yF9EI+qw18jymU7tIo0WJNNT4Q09SLFgkKV5LYCe1nP18
	Zf4o69x8qu7LDpyYPTY/n6BltB0aAQEr8l6BlZbu/tRao8TtqylelsjH7AteX6eLmB+s
	Br6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=lACI1ruLtnGKLKV6ASguQCFbIso51AT+7u19hH5S0UY=;
	b=LxVS/SoSpso1q0FLWPHRib34UDZHV3MnCV1XEIswu1dz9eVcxiEQwoaBPtXNnFlhEJ
	4OOp/M0oWBRvlHw5Z4bgvzRsflWqx+tXgsLjGdETG5cBV9InSxw/VjCOnL1qGQ3dNxZr
	TyZtrMy6ft3BgGi2aEbXm1TqGY4mZJPYIXEbtbkm6hEg4izNEeXUfNkHkSQjrgXLCIUT
	i+sWvqcCy7mVScsGnkULPuHI8y8StttSjvTiRThyFqdxbQqnthO54c3OJIvAj6MxhnoE
	WQ9TDly+yT9V+ygaviK4XgXH8XwCJzE188fziBmGcHVgwB3uRsaTruADMj4IJthTt+nB
	IEcA==
X-Gm-Message-State: APjAAAU9y7TbTOC+yAhMfAmX3ORe1uvvKNSYVsD61sC8vX2DPQ7LRBMv
	2qkZrBuGdzcSZC6QWYjY1gzpV7wv
X-Google-Smtp-Source: APXvYqwRQJtjQovXLCGZp9w09DvDfLtvUtkbl7ykxbDKO65L7cEyOqIf9H6VRQkN1hKFe5tX2f7aUg==
X-Received: by 2002:a81:98f:: with SMTP id 137mr14013303ywj.151.1581953178975; 
	Mon, 17 Feb 2020 07:26:18 -0800 (PST)
Received: from poirot.dhcp.lexmark.com ([192.146.101.90])
	by smtp.gmail.com with ESMTPSA id
	l37sm340824ywa.103.2020.02.17.07.26.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 17 Feb 2020 07:26:17 -0800 (PST)
From: Kyle Russell <bkylerussell@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Feb 2020 10:25:52 -0500
Message-Id: <20200217152552.31991-1-bkylerussell@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [][PATCH] bitbake: don't allow renameVar calls with equivalent keys
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
X-List-Received-Date: Mon, 17 Feb 2020 15:26:19 -0000

While usually a programming error, the behavior can cause a Parser
instance to eventually gobble up a significant amount of memory,
greatly affecting system performance.  Try to avoid getting into
that situation and alert the user about what they attempted to do.

Signed-off-by: Kyle Russell <bkylerussell@gmail.com>
---
 lib/bb/data_smart.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index dd5c6185..63a32bc6 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -607,6 +607,10 @@ class DataSmart(MutableMapping):
         """
         Rename the variable key to newkey
         """
+        if key == newkey:
+            bb.warn("Calling renameVar with equivalent keys (%s) is invalid" % key)
+            return
+
         if '_remote_data' in self.dict:
             connector = self.dict["_remote_data"]["_content"]
             res = connector.renameVar(key, newkey)
-- 
2.17.1


