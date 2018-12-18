Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 8CD5C7BFEE;
	Tue, 18 Dec 2018 15:31:12 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id i145so4726565ita.4;
	Tue, 18 Dec 2018 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=v47LJA9ed3Y3nMjV8LiTD72Tnr9DN2Cb3FVSgokJFbA=;
	b=aR0dEBFuYdOjfAFTqjn+8HRrpgsVLX/YEC2vD3y1PkBzO3vnOW8BTszkv++qA6Yq9L
	2rT8eXF42C9sfvAKWO1EJIzmk0gA73nyBnMUXFPvcmmDk2d+EPfEE2KvclRcNv6NTx3y
	4Q5MQ0Gp63QWmYeLG39fgZ/2T8bdnfSmeT/A52bhb6XTmYF3+DON8vckTq47RPbGQIM7
	C4Au32otXVXi+/lauU6hkS/VIF6qJdfbidKBE+PPWCERKQS4h8Km8/mTPiJxhpXhuaEm
	h6jB9drRlCLPVvVxWKQX7qy5BTXcfS4GuZhU6DdXyP7t3Vsfxn4TX/gvk78vH0s1G1jC
	/4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=v47LJA9ed3Y3nMjV8LiTD72Tnr9DN2Cb3FVSgokJFbA=;
	b=EHySGefCGujiDF0XKDKou/7sz+iCKXxrCoUaC5uZiV1h2MfgS7lWhuD0FbHHzKr+0L
	IwvNcaPJzxjcQP24h3SXr/Kh2MOml4ITgbTtMVDEyiebqf/6TS3OxXJiGMaQHEXkwnHo
	Db9Vh+AZ4n+ysuph97+iIxeHELrnx6KuSjRHc563fA9Ku5uCPxhnik8S9ltCs6ZZ+Hq8
	7AiXno6Gbm2KQHaph/feIj7uDhH1NsN0BL9wbGBG5+2DSi5pQdbJciYSYYLqYxSFClOR
	xWL4YO8EqJ1sm0C7PQweNYcp0x0fhtbC3Y67lto13gDtGmz2zT2VHFuHLJjMyu4lBlgb
	ILBg==
X-Gm-Message-State: AA+aEWbbLOc/67iwfEKkTxzP4DlU+7oR3GMEOQS0JOj9nCTrsDLcVZni
	o8TRW5LcObaiHsh+g90ezLD/KwAS
X-Google-Smtp-Source: AFSGD/XPqQj9j8I6ox88gtCNRXT+4sKzsreBFWPnpm8gFNUyyFP1ikxiPbODZNYMyXDmmtZZTdOzPg==
X-Received: by 2002:a02:8c1d:: with SMTP id l29mr15486722jak.93.1545147073058; 
	Tue, 18 Dec 2018 07:31:13 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:11 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:55 -0600
Message-Id: <20181218153101.9212-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 04/10] bitbake: siggen: Split out task unique hash
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:13 -0000
Content-Transfer-Encoding: 8bit

Abstracts the function to get the unique hash for a task. This hash is
used as in place of the taskhash for the purpose of determine how other
tasks depend on this one. Unless overridden, the taskhash is the same as
the unique hash, preserving the original behavior.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index ab6df7603c8..5508523f2da 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -41,6 +41,9 @@ class SignatureGenerator(object):
     def finalise(self, fn, d, varient):
         return
 
+    def get_unihash(self, task):
+        return self.taskhash[task]
+
     def get_taskhash(self, fn, task, deps, dataCache):
         return "0"
 
@@ -186,7 +189,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
-            data = data + self.taskhash[dep]
+            data = data + self.get_unihash(dep)
             self.runtaskdeps[k].append(dep)
 
         if task in dataCache.file_checksums[fn]:
@@ -261,7 +264,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
-                data['runtaskhashes'][dep] = self.taskhash[dep]
+                data['runtaskhashes'][dep] = self.get_unihash(dep)
             data['taskhash'] = self.taskhash[k]
 
         taint = self.read_taint(fn, task, referencestamp)
-- 
2.19.2


