Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id EFAF57FACA
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jan 2020 11:03:11 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id q10so36802518wrm.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Jan 2020 03:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=5ZEQXNcdGtz2RbRyxsIpHdG+mnzQ2LTmRAO5oE+yu4c=;
	b=FtN9t1gWxC9AxccSWhOWHp580EUxvOKJInHWgniSQSsLcT0Bc4CxCd5jeYPEv56EBP
	vo70kq2/VZTcqbGOpKe+UdxtHTJ1ZbdYF1fwAWjuSNZmsz0aCH/DUg3Uaj2f2zCW0WaW
	ih1hXmW3QD7s2v1ewQ4R8RSnbhAT8/nC+Inf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5ZEQXNcdGtz2RbRyxsIpHdG+mnzQ2LTmRAO5oE+yu4c=;
	b=Efx5xyBf0DL8ihKQITD4KQdfmMWePuQAph9hKsyWEUqZ27s2jbAbGCPs/86sB5FcpA
	OezwipArGYQYjoxicfn4zKi05spsz9RxC5zOIOC6O0uPhPZR0pzjdVaa1m34eMnh07Cp
	DdZqvGT3cn9FRSuOzKDA+h06AahrkXxuGQBmEI2EXW396kmpCp+dfFqDEk2B83GrwDrl
	4lJjVw3L2NROWJ6bu8aikZ8/88O6zl7RPnZRplV5E5nCievP0JRKAMBH6Cuyohf7XuDg
	8SuV8qW/L6iEJbjElgjz6RrBGzB+PY/iYKZNGYGB8zr2qyEDtvQBJtGFo1UsWHXfRrbe
	yDfQ==
X-Gm-Message-State: APjAAAWbUBv59ZrdCjahIUA9gTFXLjKM/q32fjWREoK8ToFZBFHVcxL6
	6OUfMaOysCkH3Kk13ggSY3CiOEqeFyw=
X-Google-Smtp-Source: APXvYqwu1Yw+B8lGqcyat8k6TKnmmaHlDJpes5ZEP2gziduU9B7brKjK4JuFN5s9/R8ewocbNZadQA==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr75996259wrq.67.1577876591586; 
	Wed, 01 Jan 2020 03:03:11 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a1sm5250672wmj.40.2020.01.01.03.03.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 01 Jan 2020 03:03:11 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jan 2020 11:03:04 +0000
Message-Id: <20200101110305.12317-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
References: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/5] siggen: Test extra cross/native hashserv method
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
X-List-Received-Date: Wed, 01 Jan 2020 11:03:12 -0000
Content-Transfer-Encoding: 8bit

Hack the hashserv to allow extra data to be injected into the hashserv
method. This allows OE-Core to handle cases where there are multiple
sstate objects for the same taskhash, e.g. native/cross objects based
upon BUILD_ARCH or the host distro (when uninative isn't used).

This has been tested and proven to be very effective. We will likely
rework the code to improve how this is handled but for now this
improves automated builds until we can get to that refactoring and
more invasive changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f982bf22bc..ded1da020f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -391,12 +391,16 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
         bb.build.write_taint(task, d, fn)
 
 class SignatureGeneratorUniHashMixIn(object):
+    def __init__(self, data):
+        self.extramethod = {}
+        super().__init__(data)
+
     def get_taskdata(self):
-        return (self.server, self.method) + super().get_taskdata()
+        return (self.server, self.method, self.extramethod) + super().get_taskdata()
 
     def set_taskdata(self, data):
-        self.server, self.method = data[:2]
-        super().set_taskdata(data[2:])
+        self.server, self.method, self.extramethod = data[:3]
+        super().set_taskdata(data[3:])
 
     def client(self):
         if getattr(self, '_client', None) is None:
@@ -453,7 +457,10 @@ class SignatureGeneratorUniHashMixIn(object):
         unihash = taskhash
 
         try:
-            data = self.client().get_unihash(self.method, self.taskhash[tid])
+            method = self.method
+            if tid in self.extramethod:
+                method = method + self.extramethod[tid]
+            data = self.client().get_unihash(method, self.taskhash[tid])
             if data:
                 unihash = data
                 # A unique hash equal to the taskhash is not very interesting,
@@ -522,7 +529,11 @@ class SignatureGeneratorUniHashMixIn(object):
                     extra_data['task'] = task
                     extra_data['outhash_siginfo'] = sigfile.read().decode('utf-8')
 
-                data = self.client().report_unihash(taskhash, self.method, outhash, unihash, extra_data)
+                method = self.method
+                if tid in self.extramethod:
+                    method = method + self.extramethod[tid]
+
+                data = self.client().report_unihash(taskhash, method, outhash, unihash, extra_data)
                 new_unihash = data['unihash']
 
                 if new_unihash != unihash:
@@ -549,7 +560,11 @@ class SignatureGeneratorUniHashMixIn(object):
     def report_unihash_equiv(self, tid, taskhash, wanted_unihash, current_unihash, datacaches):
         try:
             extra_data = {}
-            data = self.client().report_unihash_equiv(taskhash, self.method, wanted_unihash, extra_data)
+            method = self.method
+            if tid in self.extramethod:
+                method = method + self.extramethod[tid]
+
+            data = self.client().report_unihash_equiv(taskhash, method, wanted_unihash, extra_data)
             bb.note('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
 
             if data is None:
-- 
2.20.1


