Return-Path: <luca.boccassi@gmail.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id D734C7C699
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Mar 2019 20:00:08 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id e16so525641wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Mar 2019 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+621melfWICWkD81vtg8D9mjNs+63pG/uVEjEjCCnQI=;
	b=FPQzjQWp+4DZMm2Swse4aFHJvi4bDJ2v2pxzyuxQQP4sQZnEfppg6ydamz+q5XQjAO
	1hhWk7GemTk6/odxNkJaACwaQC6KriXEGby4ezxHJelFwPSE36udg9/Lni2OE26CEWjP
	u6VQb2BXaDU+sxQKULkXK3/gGrjJ59cn54LVTcLHbzmoUFvdEUx1x22/UDHROKTuFusR
	8MMOsVeper0g6Z+QPXKofFq69Tz6f4mHb45wvJQm9+WtHiLNMvi1F0U0TlQhpVoweKvx
	KSABoWMyIqiLSvWgk836Y7YmZmxnTWfKQ0vyMw/ZlMlKaSV0u8A8x9urd4Hv2gHCszX4
	Ly+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+621melfWICWkD81vtg8D9mjNs+63pG/uVEjEjCCnQI=;
	b=dhsOjLmIb9wp/zfu6hAMPbIfT6Gqk1Ch2q/OHYcQZnHT2tjtFxT861SZUZNPYk2ky9
	aAZX4xRCMCSbZ7PQ0YxWC5a7jim3BJlqbL6hJjMaznMJog5jaO00hRx5pn9pKwcdasXV
	nrs44dsXHaf2pdMHih2uQD5yMIKwksE25y5VglbZZjLS7S0XyY5tMyqK9bDG75NtQLYc
	5xrjDY3brZXzh4qZT+DjlFWI2wofjso0PLXXCZk5QM1Yuftk2UXXabFYgdMpzhYMyHYF
	2baAhageDtDu6GgiH8eTQvqELVf9yHUqmUKa6PQruZFtze1jow6Wu06g1JpanE49ROij
	3GoA==
X-Gm-Message-State: APjAAAVK59SU3MeVAnOTnSCrynNA2k9Ke7eKhnAN0Q2jQQ30Ns4Zwrrt
	hAQumMcYb8C2F3P5pB2ebENvwNtj65Q=
X-Google-Smtp-Source: APXvYqyNMF+up6dwmQwIqNX+mFiyQJt9THCLu+x48gVMxhoFNBxkcSFhsEEAqccqtG7YDw6mSoArnw==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr3592777wml.116.1552507208947; 
	Wed, 13 Mar 2019 13:00:08 -0700 (PDT)
Received: from localhost ([2a01:4b00:f419:6f00:b00c:66c8:99df:336])
	by smtp.gmail.com with ESMTPSA id
	j184sm4671665wma.47.2019.03.13.13.00.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 13 Mar 2019 13:00:08 -0700 (PDT)
From: luca.boccassi@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Mar 2019 20:00:03 +0000
Message-Id: <20190313200003.12020-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Luca Boccassi <luca.boccassi@microsoft.com>
Subject: [PATCH 1.38] COW: Fix StopIteration warning
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
X-List-Received-Date: Wed, 13 Mar 2019 20:00:09 -0000
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Fix the warning:

WARNING: lib/bb/data_smart.py:235: DeprecationWarning: generator 'COWDictMeta.iter' raised StopIteration
  for k, v in self.variables.iteritems():

by using return from the generator, not raising StopIteration.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 407d6e07b09123c12c382b4a92107f002c314b05)
Signed-off-by: Luca Boccassi <luca.boccassi@microsoft.com>
---
Backporting this patch to 1.38 fixes running bitbake on Sumo on Debian
10, which about to become the new Debian stable.

 lib/bb/COW.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index bec62080..7817473a 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -150,7 +150,7 @@ class COWDictMeta(COWMeta):
                 yield value
             if type == "items":
                 yield (key, value)
-        raise StopIteration()
+        return
 
     def iterkeys(cls):
         return cls.iter("keys")
-- 
2.20.1


