Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
	[209.85.223.182])
	by mail.openembedded.org (Postfix) with ESMTP id 62C8078EA8;
	Thu,  9 Aug 2018 22:10:51 +0000 (UTC)
Received: by mail-io0-f182.google.com with SMTP id m4-v6so5046562iop.3;
	Thu, 09 Aug 2018 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ekTCd2mda7zjlCst19KHQplvfLxG8x3MKf8o+DJFOqw=;
	b=GCfOEaR3lmfXeEHiLqVGgRwQF1XRFx2/8fntfo0P4VtY+XMwBO7pVBnEM+xuxLs9LO
	oPsWYhlW4APAapmgP7P88ftGzDAU5mXgLxVcGv6Bbxo5hO8B2NMWQDb5zMyGxH5KwPmd
	GD3IX8oVvopJsaEYnlONI3pncGbSIeNbeIb7dMxOY1Vm2vqTQTofqs/iNNTwuCFzlSLb
	89Bx/8VkPKnFg4WZyozuOdLXbs3ux/w/qXauDUBrgzutnxgyCTF7CuFgv0AIiELKem2s
	IQCeWDLYW/rpiAE13vo3Ssjhs4FC/63i5oxPITxa00aY45fsGRlFD/dCVt+Z6SyrNm8Z
	1/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ekTCd2mda7zjlCst19KHQplvfLxG8x3MKf8o+DJFOqw=;
	b=Xq5O20KKvwbTDozXw1NnX1RlBUmpwzfZxxX6Q118MgF22OsMHh1uKkGsUeM9rC4HFe
	o7Sd9nVoLER/JW9vRQLQUdwzOZZ3cTFrYFGx+tsmjeeAULaWgCVzuHu5ZYNWK6nSGApt
	Ls8neb/HG507r5U4s/ClRcXUouiA0Z8qicE34oCDo/9DKZDI5JtLB48ZhGyp0dMpsmh6
	ru5Mr2qQ6SjZxSynn0ShfBOfEuG2YCfzsfLecmvjlg2hT/KU9NvI4820ICmYHAFozSZ+
	wnwNxNnigjiSBkws/R1b5/8GiheV9rg5XvqilPG37Ga9Co65ylPQ2EeEid5qeslr8aBf
	S1OA==
X-Gm-Message-State: AOUpUlEHzkCtp6XfIxrY09EquWcyex3Jd8WA7x/cH0tJorPfEintWbjO
	tWwZfvUCSrAKGchUtNVYC+AZmm3/
X-Google-Smtp-Source: AA+uWPznBBRiaXuQPB7sJv2VendER9bm8F2n5dvFb7yds96+XDxxe3vXMUx1l8wnFGnJhxuYDcFxjg==
X-Received: by 2002:a6b:b496:: with SMTP id
	d144-v6mr3198902iof.26.1533852652298; 
	Thu, 09 Aug 2018 15:10:52 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:34 -0500
Message-Id: <20180809220840.26697-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 10/16] bitbake: siggen: Split out task depend ID
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:51 -0000

Abstracts the function to get the dependency ID for a task so it can
return something other that the taskhash

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 7fa5b35337d..4ef175edbbf 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -41,6 +41,9 @@ class SignatureGenerator(object):
     def finalise(self, fn, d, varient):
         return
 
+    def get_depid(self, task):
+        return self.taskhash[task]
+
     def get_taskhash(self, fn, task, deps, dataCache):
         return "0"
 
@@ -215,7 +218,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?", dep)
-            data = data + self.taskhash[dep]
+            data = data + self.get_depid(dep)
             self.runtaskdeps[k].append(dep)
 
         if task in dataCache.file_checksums[fn]:
@@ -290,7 +293,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
-                data['runtaskhashes'][dep] = self.taskhash[dep]
+                data['runtaskhashes'][dep] = self.get_depid(dep)
             data['taskhash'] = self.taskhash[k]
 
         taint = self.read_taint(fn, task, referencestamp)
-- 
2.17.1


