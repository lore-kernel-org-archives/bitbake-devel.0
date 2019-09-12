Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5C3727D30C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Sep 2019 12:36:19 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id i1so27678725wro.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Sep 2019 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=nfGdWjt02rdvmw142NusuqZA66HwflsEvZc0B/qLh9w=;
	b=e+Nh7BJHBYVrfse4TA7Z9nrUcwtnZEQUo4y2xcZH2Z3PD37pRFA7u/gIII2y8o0Pj9
	ZsEulLvlEWB5fMIJ/7Yo0+nNQpqmd2we6bb4OcnQdQHZ1eEtX2U7BfJYf8ttSWStwVqp
	+g18fMduj8WfY7cB9BYX95PlfK+eP+wnPULuYAcAmTWitao1hzG27nc/1c1KYsq3ZXsq
	ArOXwkNRDYfdjBGvJQ4F30H+pQ9CeXie3WNybpM9dqwfAOLAtDbHI4XHe2oPkjcUov3P
	APaGEDGzf49YRG3UNtcMmlZ2ZbmYmHdJGr67B5MgiWCxEZIVP95zLgERmyTruDq0UpsV
	j8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nfGdWjt02rdvmw142NusuqZA66HwflsEvZc0B/qLh9w=;
	b=jBE2Q446QvjRk1jFHjNJ1ccjYYGDbtX4+6kPttKljnSFWDJwIozxh7JYrtN2gB9K3O
	yG3Rn9lj2X4v/UFQaT26eiExUuexCQXjKVCg2cilm/SPB90hN5b5LF2Ebl0DlZzZjcyp
	/fktcibzz4scbcjhHOJ19qZSbvxe2NMdbYCSu0rBZ1NfW+g4Z/inIJftSGs8ay3zzrQR
	jmtPiXTJbdgkzimhm+hkE7ZYlFDRpVch7/vFz7i24Ge1Ukbh9FuUNhvxILop0MGpYfcT
	+sndhZrxhS1QwVDG9OklRUkKFOLdLkyV5Bj3XB2rGq2SsgX2dh9uH1hdWot6qeAHl1vT
	kKXg==
X-Gm-Message-State: APjAAAXRBw5BeifaaNAM+PtOrV+5A6HNkNF+Tii6JKkzNf21/XGtUFJg
	avFK9LNSOB/pWD35Xgo1zWPjOk8WF8Y=
X-Google-Smtp-Source: APXvYqyflIsuVikI7+43QEhUH+cXQi4UNGX0r2eoFl69O/BCtVLsU9BGxsgs8GJhZfNcUoq9yWyccA==
X-Received: by 2002:adf:de8a:: with SMTP id w10mr32992683wrl.276.1568291780496;
	Thu, 12 Sep 2019 05:36:20 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id
	o14sm15846148wrw.11.2019.09.12.05.36.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 12 Sep 2019 05:36:19 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Sep 2019 12:36:27 +0000
Message-Id: <20190912123627.96-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] Revert "bitbake: cooker: Ensure bbappends are found in stable order"
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
X-List-Received-Date: Thu, 12 Sep 2019 12:36:20 -0000

This reverts commit 94c0c7f15c7a6244a8576ed948ffc21afb96ba82.

This ignores the layer priority, making the issue much worse.
E.g. I'm seeing a lot of failures caused by missing users, because
base-passwd bbappends applied in unexpected order caused different
passwd.master to be found in re-ordered FILESPATH.

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cooker.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 89d1916e..a0e60024 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1855,7 +1855,6 @@ class CookerCollectFiles(object):
             (bbappend, filename) = b
             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                 filelist.append(filename)
-        filelist.sort()
         return filelist
 
     def collection_priorities(self, pkgfns, d):
-- 
2.17.1


