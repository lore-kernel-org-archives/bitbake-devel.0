Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id 755557BEAB;
	Wed, 19 Dec 2018 03:10:39 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id s22so14459733ioc.8;
	Tue, 18 Dec 2018 19:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=v47LJA9ed3Y3nMjV8LiTD72Tnr9DN2Cb3FVSgokJFbA=;
	b=Np1hcBS+rGeWTZwF4V90+nvRW5vwctARIUwGS2EyVUj9JkevB0o/G6MG9ExKP32vhu
	SNniilnympvINJCPFK36DZMHMq2yD/nuDsjNRUuLgTSRl9Rq8s2y5iACGPVJHRvJ/H8D
	vA9Ju+jBwOJUBnvK1f+URv9oATI6526DHBdNbV2CXQlT3P3ja3fcPc4xIp0F8slhdY5z
	hy57Bd82JCCEGsJ8w5BhCv8XYTEUWQxO5dUtBfVFBjsInp4+FgTWvkIaFuqF1UQppx3W
	YbM7i1O3qu/+qlBiS4RRNgaz3APkm5U4Jcw+IhFIlm/I0AyXc3b3GfUGzFPO6799vW1v
	y2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=v47LJA9ed3Y3nMjV8LiTD72Tnr9DN2Cb3FVSgokJFbA=;
	b=l64NR8AAyiJnUrbJQtSaaE/bNAiBaGagMQvnHpeKTaIPbXN8roZHn/Ahf3NHK4nuZg
	oPQGpTQ6hO9Glkykd/cZiUPemjCypOLJ+dzquiQ8oKWaKuYa+r1s24srYBigMQO6UNE5
	v4f7QhXTWDxndkUdnRo11Ayqx52p/U40TI/3aA3hBsxBzybkH/hnVN2ovmsotN/tGx8+
	dqjKsxyqNR2Ad4C0vqE4Z7RrMjQK/dbbOYi2Cn74KbV7zwZ8EMPFR+Mg7jmi2YDAbEFG
	GBj/woLbZ6kWQJ/6Xppdkt98sUzOskvNX5hc2ovwAqvOGBOKXfh4n13sTR42gzKikJ/d
	pU9g==
X-Gm-Message-State: AA+aEWbIC+/7/3zAgKIE+qcbceRL47F08d20X5Rg8coHs6X53MeNiH49
	+TtGQEBhuJS64v5KGQjobF7NvC9h
X-Google-Smtp-Source: ALg8bN6hWREask1yO1rq+rd8NKYlA6D5IUC99kvtmGsLyMdu9oqkTFETCx5VORWseJdVGF3jFZYzHA==
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr2455160iop.105.1545189040207; 
	Tue, 18 Dec 2018 19:10:40 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:39 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:27 -0600
Message-Id: <20181219031033.28045-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 2/8] bitbake: siggen: Split out task unique hash
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:39 -0000
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


