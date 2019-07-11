Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id 4857C7EFE9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:12:27 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id p17so6907704wrf.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=UBeJBS3p+Z/C/Mwa1v+13mvPV/Skap8e8Rma9uuEjVw=;
	b=D11xp/HN5YafLJq5KL0OI/IR/xSx98q/MMHPmzn2N9/RjdSKNrO9XDck+JLRlYMXze
	e3YbG5Xa21MTBAVUq0iVP0VcBQkeZnY+uD4UrywJye8SIx3CM8+3pKK8JHjFIAsarrjs
	zdQS7AN7yT1uHQqYQuJMt7CZuZ5s9jQaZdza8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UBeJBS3p+Z/C/Mwa1v+13mvPV/Skap8e8Rma9uuEjVw=;
	b=cDJtBDARdBH8NrzoAQQxe9Q11LDAWqctxq60qqnk3gS8oT0p9sfRg6O4Y+rix8mSjl
	VY094xwiv4AnTTO0q2gC4q04C0R5FJ3lmgAbMDN3wqxdHQIDfbnfsVc3NYrV4WShTeAm
	5Jj4uiigky+SBfBN10S6+1+gCKTd2RRPBe+ahPOfN8odLr4lK5/ZtjYK1+DOTIpCV/n5
	o32X1/tCFKOSwmmci0AO37BX8fisVQCzGTagefamgldAGY/jFQ9qA19vz3R6Yy5mYcjx
	rY07e0AZc2HcfnXUs2UYjV4Nq4d/fkL1hsuBAF4GLYfm7Qmjn20J6Vh64EVBkjIDboff
	Cm0A==
X-Gm-Message-State: APjAAAVsdFUpFHkf8YEHomvijWmobqS994sUjTmQs67FpdnoUoiItoEc
	mxNMI2l8nPx2EfF3x8aFYo0a327wkPU=
X-Google-Smtp-Source: APXvYqxvC1MY8XG427oURwZbci3Od3Q4Wu3+HQF1g8+HJBJSBw3BM6xT6PYTaLagV/pfSNQ/up69vA==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5674265wri.224.1562861547938; 
	Thu, 11 Jul 2019 09:12:27 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c7sm4841279wro.70.2019.07.11.09.12.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:12:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 17:12:22 +0100
Message-Id: <20190711161223.12376-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
References: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/5] siggen: Use unique hashes for tasks
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
X-List-Received-Date: Thu, 11 Jul 2019 16:12:28 -0000
Content-Transfer-Encoding: 8bit

Now that runqueue optimises based on task hash, we need to ensure
tasks have unique hashes even in the simplest siggen mode. Use
the task name to calculate a unique hash.

This fixes runqueue tests when hash optimisations are added.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3b017219ed..f9c4798e3d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -49,8 +49,9 @@ class SignatureGenerator(object):
         return self.taskhash[task]
 
     def get_taskhash(self, fn, task, deps, dataCache):
-        self.taskhash[fn + "." + task] = "0"
-        return self.taskhash[fn + "." + task]
+        k = fn + "." + task
+        self.taskhash[k] = hashlib.sha256(k.encode("utf-8")).hexdigest()
+        return self.taskhash[k]
 
     def writeout_file_checksum_cache(self):
         """Write/update the file checksum cache onto disk"""
-- 
2.20.1


