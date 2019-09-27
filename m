Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 24B497F2B0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:54 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id b9so2569884wrs.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=tq6Kx2YNVHiFnFdWoQotNINDedBAmuRQSenMyxID4kE=;
	b=aEvvNw8EIfEcVl+/kenQUph178dlnL1JLEyFZEHdP8zYVcinR1mDb8kRiVfsatt6rv
	ihpwuETHghzg45vDE9r+AquUKD6Lb7aPPIB2PPFWeOmCdux6acETRkL1NC0mDpPMccN3
	KXQb1cV11vxwIiXAqCZy5epK0hiZIOfYoUqk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tq6Kx2YNVHiFnFdWoQotNINDedBAmuRQSenMyxID4kE=;
	b=nsXZdyAP6qfoLWaiBxjsql7AgJjrupg5fahE6Y92VgEk/jy9/S7vz/JCMrhZlUc1By
	aSlW4UajvHiCoftrF6x3w2ILhBCYhU7IfC/sxLpaXBF1FsMiqHH8Vtuil/HLwxDA8kPe
	4404ilvNvaX+2MPdfLmC/pyjTWQCMpMGaRrPjEwiDAGiHHT0Voyks3sv9SDc3xb4t0hr
	NH9WWjkrRv/ZKIJ4Q2cahZzVarc20NhfBEVQXmJIVkcyvx4wbwQqJp7Lsa6ZMmjVMRHy
	VRWJ46HphhCjGWEAq7dxFCWClYJS7XJQhzKGlRsNP61zA45/lhf1qbpvP8+r0VwprzHJ
	4R2g==
X-Gm-Message-State: APjAAAWvaULfPBDFYbswDtI9CbkLl+Ddy7e6cbBWX4YN2K8g5PmVCBu0
	O0cL3+0AYMv8Zkrg8N1sW1sC607W7SQ=
X-Google-Smtp-Source: APXvYqzMycTOnOb/BDym2RixyuIMtV1XnnEgB9BMUQzYBHHwHB0O4DEofyv39sIXjun0CxOEHu6nCQ==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr2688355wrw.208.1569587634624; 
	Fri, 27 Sep 2019 05:33:54 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:44 +0100
Message-Id: <20190927123347.19276-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 6/9] siggen: Avoid writing misleading sigdata files
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:54 -0000
Content-Transfer-Encoding: 8bit

Use the unihash in the output filename of sigdata files else the contents
of stamp directories is misleading. Write the unihash into the singature to
make it clear what happened.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 6207cbca30..90f0926f25 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -268,7 +268,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             sigfile = stampbase
             referencestamp = runtime[11:]
         elif runtime and tid in self.taskhash:
-            sigfile = stampbase + "." + task + ".sigdata" + "." + self.taskhash[tid]
+            sigfile = stampbase + "." + task + ".sigdata" + "." + self.get_unihash(tid)
         else:
             sigfile = stampbase + "." + task + ".sigbasedata" + "." + self.basehash[tid]
 
@@ -296,6 +296,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.get_unihash(dep)
             data['taskhash'] = self.taskhash[tid]
+            data['unihash'] = self.get_unihash(tid)
 
         taint = self.read_taint(fn, task, referencestamp)
         if taint:
-- 
2.20.1


