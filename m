Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF8EE36AF
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 17:24:06 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50967.1770917038683025080
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 09:23:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aexlXRkb;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so645525e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917037; x=1771521837; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4e/RKZiOKp4XIWHg/wAJ5/eDZNgKKOOVHbSeAD4accI=;
        b=aexlXRkbOMUE52MNovB3s3I01JHuwdEN/2bxbgWZ8elJWKge4GPt7d+X6lMrx5c0SA
         8x62jsUyO+mISeKC7vVGtFoLYdk5nnjWMaOrjl37ZX/f7uN1TXMrK98A1o1Mx+Eg36xx
         RbrnPQto8aJ85iGGgi3Q5QxyUhGIl+yMKaxcnK7GvKb4dpktoRDi0+w9zVQ/fOrciR6K
         9BllC4MlrMyUCgljQ8byLYY4dFHR53N6Kzw47HbOiuA48619T32sl9UHBUYGghVpXc8z
         xdXTmd907o1s/7HHHxNkUOtof6N5SDhLX2iWUoMUB/tO+TsMeupCexlU4rl4hnvbmIfp
         pEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917037; x=1771521837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e/RKZiOKp4XIWHg/wAJ5/eDZNgKKOOVHbSeAD4accI=;
        b=Hj8oEsa3k1++y9tlnmgtGK++ETc9GzcqkXBsMzAxNAniSxxDz7ZM/Sy4lQosjjlSJq
         4W9gBZz5tnvntCbx+y+KBREUBD1Gsecu4ebPz7mK5Y7LloyHA/CBOBb1OTrdv9T9RM3j
         QkkvFwUAmih8ki/IiYlf9wAQLZxXV+As3/JouwgL9o3UnFb0YwHlcrxZpdoe8my2nDmb
         fqRLZsLS+mnhl86Auf+anVIdygxyiwI3/bprdFhgc95/WOKT6jphEI/tjnzBxEyf2Sdf
         Ht8XYnz+yHCkflVtA/seNBOTSe7Vsj0S493pInVkZKvhDdRKeLMg5CC8FP2Lru+XOLmy
         FYZg==
X-Gm-Message-State: AOJu0YyGrToJiw/dXvgRM/In0G0Hy5Xj1o/cyWpZow+43ob5h4xNUfzW
	zqI3sJNJh0SIQt8rb82q48SVKR69Pq2F/tNeeAOj1euC1N75KkY9s+7b+lQn/g==
X-Gm-Gg: AZuq6aKRnALC5Nlsq9GHTRyUb0h8GKYxEMTbuGul7MJnBhD8Muf3IgZ7MqIwuOfY9az
	tuWmohI532AvaxhwVfTKoWXJ4PoPPB1cIAgZ9zoBgPjOX+YVWRzbL9HwIEdViKRsgmeS7WLqiRO
	NaFofBErXhyjos0OcXP3z4mktH2fCUaUN+qMUZL0k8N5MY8rQdLj1XQsiT26OHPo9jq/Km714pb
	DRlTzpouKOA4Ql2Vk/K1A+vJF28sPnOHz1pC9iGN6rWuE2judSUT1m1jZ+Rm+nvsLWb08l4oWbF
	4vHcKJbnI4NkvQ5w41d1n9DTHB1aiB0jJIet2n1KyWizE/wFckZw+oSQUPRF/Wxgll+DsOOUcxb
	+6MZ3822/cxPWlg7agR8ZRW8KKKXXsU1lucWgMTuDvLW0sIe85VNc5p7nXe3BCbn/FlsgsbcOZA
	hDG+Z/+7ATXUcJVRWb3L4nEY7BEa1v1yWh06Hogw==
X-Received: by 2002:a05:600c:34d0:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-48367162f3cmr48638075e9.30.1770917036352;
        Thu, 12 Feb 2026 09:23:56 -0800 (PST)
Received: from toster.lan ([185.228.162.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfd892sm13405542f8f.19.2026.02.12.09.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:23:55 -0800 (PST)
From: Jose Quaresma <quaresma.jose@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <quaresma.jose@gmail.com>,
	Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [PATCH] utils: is_path_on_nfs: strip not existing path
Date: Thu, 12 Feb 2026 17:23:28 +0000
Message-ID: <20260212172327.14204-2-quaresma.jose@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 17:24:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19021

From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>

When the user provide a path that does not exist it fails with:
| stat: cannot read file system information for '/path/to/my/hashserve': No such file or directory

We can strip the non exising part in the path and pass just that to the stat.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 lib/bb/utils.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 974611bc7..b2bda08cb 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2269,6 +2269,11 @@ def is_path_on_nfs(path):
     """
     Returns True if ``path`` argument is on a NFS mount.
     """
+    # strip not existing path
+    if os.path.isabs(path):
+        while not os.path.exists(path):
+            path = os.path.dirname(path)
+
     import bb.process
     fstype = bb.process.run("stat -f -c %T {}".format(path))[0].strip()
     return fstype == "nfs"
-- 
2.53.0


