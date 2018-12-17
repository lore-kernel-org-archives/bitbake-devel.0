Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 6E9BC7BDA2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 17:16:46 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id r24so5223671wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YJ3FCrFUa00PtNEyuEj9JaonsBUogxfX1ZLM5Z1knUQ=;
	b=NGj4LFU0Zc+aWFyGSaYnyx9WynOxYRV2tCb4Ew+sZFQH/8j6VPPwB0oyZreH7pEDP1
	YEM75oNFD4EZFFlarB5UcCeJ+bGIql9lhrfUBqSOywF1WXXtg7NedVvJQE7CnJrWWVGH
	KUUb6x2DnHsH8gAYwFNrxMcIv5s6TOoYThZo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YJ3FCrFUa00PtNEyuEj9JaonsBUogxfX1ZLM5Z1knUQ=;
	b=l1/Y8rxEYCFJQoFX+DrDfrbXyb9wgsT+sts4d0fyuaR03ZC+GGC/TqEDWlA4fiPiWI
	Eej9WZFYwTcTSlKi3GJJDK9mZpAkYhxj80ZTjpHzCowAfN4xCBIK60nPcodYDxBiQ4Df
	hGJrE4Brr4NR0WnhguzNrL8A9DHAfeEtyaUlVoJJnmhKHo5X71l5sCt9eooqcwgades4
	8wHkHSsVXMMcCfpeVSoR+ABuZpow3+7UV11zCOoNYcVrtDs0YgymvtzHha268DeulX3u
	EgQqcI4ZPvov4qrq/iUFIXGcWikfBElHUG36E3qncrZORIDqm23l4kXro9vW5lPfeKKl
	yj+A==
X-Gm-Message-State: AA+aEWYFYdRFhW+3C6/IB32HCym8KGKgzKnLZfjRxMHLTsDCbhw/wEmw
	fc7dpuf+7RfNeR+i60xBuYyBC1mMOyGDHA==
X-Google-Smtp-Source: AFSGD/XDnBr/HaAoZkak2ND4R5bIcyJxzGBMds2XETTJPb49PMdS1ElFgnVK+1oEHvWfSgOJ/w+5YQ==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr12915511wmi.39.1545067006746; 
	Mon, 17 Dec 2018 09:16:46 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	m21sm205794wmi.43.2018.12.17.09.16.45
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 17 Dec 2018 09:16:46 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Dec 2018 17:16:45 +0000
Message-Id: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] data/siggen: Switch md5 -> sha256
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
X-List-Received-Date: Mon, 17 Dec 2018 17:16:46 -0000
Content-Transfer-Encoding: 8bit

Similarly to the codeparser change, change to sha256 hashes due to worries
over collisions. The main impact of this change is slightly slower parsing
time as well as longer sstate file names.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       | 2 +-
 lib/bb/data_smart.py | 2 +-
 lib/bb/siggen.py     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 6bcfcf46cc..29c2388038 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -436,7 +436,7 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, whitelist, fn):
             if var is not None:
                 data = data + str(var)
         k = fn + "." + task
-        basehash[k] = hashlib.md5(data.encode("utf-8")).hexdigest()
+        basehash[k] = hashlib.sha256(data.encode("utf-8")).hexdigest()
         taskdeps[task] = alldeps
 
     return taskdeps, basehash
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c342adaa0a..1f45cd975d 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1074,4 +1074,4 @@ class DataSmart(MutableMapping):
                     data.update({i:value})
 
         data_str = str([(k, data[k]) for k in sorted(data.keys())])
-        return hashlib.md5(data_str.encode("utf-8")).hexdigest()
+        return hashlib.sha256(data_str.encode("utf-8")).hexdigest()
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ab6df7603c..24697f5bc8 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -213,7 +213,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.taints[k] = taint
             logger.warning("%s is tainted from a forced run" % k)
 
-        h = hashlib.md5(data.encode("utf-8")).hexdigest()
+        h = hashlib.sha256(data.encode("utf-8")).hexdigest()
         self.taskhash[k] = h
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
@@ -647,7 +647,7 @@ def calc_basehash(sigdata):
         if val is not None:
             basedata = basedata + str(val)
 
-    return hashlib.md5(basedata.encode("utf-8")).hexdigest()
+    return hashlib.sha256(basedata.encode("utf-8")).hexdigest()
 
 def calc_taskhash(sigdata):
     data = sigdata['basehash']
@@ -665,7 +665,7 @@ def calc_taskhash(sigdata):
         else:
             data = data + sigdata['taint']
 
-    return hashlib.md5(data.encode("utf-8")).hexdigest()
+    return hashlib.sha256(data.encode("utf-8")).hexdigest()
 
 
 def dump_sigfile(a):
-- 
2.19.1


