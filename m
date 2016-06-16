Return-Path: <george.mccollister@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id 392A3763F0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2016 20:22:23 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id a64so10194008oii.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2016 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=cEWUjiQxmfY5DRRHltlUC6kqG2V7kLJ325qFMNaZ2f4=;
	b=Kq83fVk56nOqll00x/Lle1x6Z9uf9T8tKrEx7xZ88yJI6R+ZYtksWFWnqNtWS6Yhtq
	CYcNJqU3LgdvI9F5PRJV9rPcGvk0Nl2ZdAQ5CL3WFFn1U6m3oi6a+PnEG5ezVFP5Q1cv
	yhVRMgoqXFs61WStPHCbQ+XbDb7ucOlovt+kh8v+591lD4Selio7pKqd8zhFT0MMas+L
	qBv8bAALwpiPqToueOyVz9eo5ddMUoeGRTasZvICfmHeuN+mtAalqHNgCrSzPgldIEwA
	vaSULj7lk5tqAOpUgXnlGaQw8F/H3oFAqrzwHK0msQ/53/oFdNHBEbqI58u9v3TJ75Fi
	Rp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=cEWUjiQxmfY5DRRHltlUC6kqG2V7kLJ325qFMNaZ2f4=;
	b=cNqt12wxDBuS1UF1gwegnyKAyNNhOrckqmPlqUDp0jH/MKVbVj+utGHSaY1CVyiu4M
	cN/VglOthapkAM9YK0uvpuff3xmEF1m7lt/+a8KzAtzRntyHPQhL5FOFnhfXQqB7tfUs
	0aITlUTCxknYrp4jKmXvLnZWw9oF7vAsFVFVv74EerHJcWjTs+dQgV9ujs0KiIrz35FS
	+Q6alpP861RMAPvnRmRWAkHnG0tbRp8DRF2HMguMMx3oKiIk11GOyibqVy0RAojxe3St
	dwC8YVTT1sRbGG/AAJPmL1QYyfmHkGpd+kdtXzm+cKhPmF3CQE/FpZQkCW8gzk0rbaxN
	wv1g==
X-Gm-Message-State: ALyK8tK7FYZ65GAkPTuOTHQs+VBCltiR4B6ExIQEMRS1iO7YRFQ/hiE/FzB+G5YpBeFzrQ==
X-Received: by 10.202.114.65 with SMTP id p62mr3892766oic.105.1466108544395;
	Thu, 16 Jun 2016 13:22:24 -0700 (PDT)
Received: from localhost.localdomain (216-21-169-52.slc.googlefiber.net.
	[216.21.169.52]) by smtp.gmail.com with ESMTPSA id
	k28sm11935458ote.35.2016.06.16.13.22.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 16 Jun 2016 13:22:23 -0700 (PDT)
From: George McCollister <george.mccollister@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jun 2016 15:22:03 -0500
Message-Id: <1466108523-2051-1-git-send-email-george.mccollister@gmail.com>
X-Mailer: git-send-email 2.8.0
Subject: [PATCH] runqueue: Use tid instead of taskid in find_chains()
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
X-List-Received-Date: Thu, 16 Jun 2016 20:22:24 -0000

In 2c88afb6 find_chains()'s taskid argument was renamed to tid but
taskid is still used as key to explored_deps dictionary. Use tid instead
of taskid.

Signed-off-by: George McCollister <george.mccollister@gmail.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b32e8e6..c9b6b84 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -347,7 +347,7 @@ class RunQueueData:
                     if dep not in total_deps:
                         total_deps.append(dep)
 
-            explored_deps[taskid] = total_deps
+            explored_deps[tid] = total_deps
 
         for task in tasks:
             find_chains(task, [])
-- 
2.8.0


