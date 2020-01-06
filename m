Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
	[209.85.216.47])
	by mail.openembedded.org (Postfix) with ESMTP id 876007FE0C
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:13 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id u63so4497150pjb.0
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=hmALHdmhxRw1EUAOm7N9d+epIQ5T83F4X+sc2/jt1p4=;
	b=ML50smiLNSjQ7owufqYZXbDb7D5XSiudnn0RJLEtMTQoTk9w1H1NV9KL7q7ygXkfcA
	Y71UQNHuXG4eby6Bv8FftNZ+a/aisbMNXUJcKWDOWe1FfG5RLIsuKtIOfaZ02P6x2fE7
	8cQkEXOjlrZ47A8BGDRez+KkK7NYIY/XWQHFdAwqgivo2gxWKS+xanwDDL6kShU6J1XY
	fHppcYkUpL5TnOx5UrrmSS16ZzK74lb1lRVCnX9nWQwD7Bo+MofOTk1U5TMVqnMtYXt7
	0PXwGSylapXAdD/6KJBAHBhhhk1T/a3Dtr6i/IZf4Gmr2X/umbNNiYYun/4vACtsJr6B
	+OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=hmALHdmhxRw1EUAOm7N9d+epIQ5T83F4X+sc2/jt1p4=;
	b=ORMRDesyqBj3RcinvUMvujuVGhZjGfoWAM/5wG8PL1WjdVcNB1qjiM/i5//mIn3oii
	otNhwiWHuYxdiV0/JANmj4xTSoWflDeAJwhLtFVHh/KDLybruKRpPVyKIxQYRKUeb32z
	6xy59/XIWh8MoulR2S7ws0mDW7I0q+X1B21aEW/jGLBDZn1G1MmHQDj2WMNJVhVV5InP
	wmGP0vS1aOQirTfgVNcfN7NdOuSICjB9zDX1VpjPgdq29FcdYfnCE9/Nbs9q0/+ggFye
	pymege5BqBhUcbekRNen6jkdM5VOhz7TPsY88h2ych9u+MLEe9af8fXsdu0qdlJdD+aD
	PwFw==
X-Gm-Message-State: APjAAAUoGHPMwogTOoDRdzvhFDywPZrDtxmrDdnVuc5OHZajaGqKSTfu
	7/PyU1J1GAJEpvJbW/mt9EcDiyFT
X-Google-Smtp-Source: APXvYqx0au00XmZL57NkqIBb/dXGgdaCV+XNhPD5xfPf2qP46xW9ywkgmgapCWPDzyytNSavqcAFzg==
X-Received: by 2002:a17:90a:c708:: with SMTP id
	o8mr44571796pjt.104.1578328034466; 
	Mon, 06 Jan 2020 08:27:14 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.13
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:13 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:45 -0800
Message-Id: <e21bf572cfe18e805d3f849777189685f7391a67.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 24/25] siggen: Test extra cross/native hashserv method
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:13 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Hack the hashserv to allow extra data to be injected into the hashserv
method. This allows OE-Core to handle cases where there are multiple
sstate objects for the same taskhash, e.g. native/cross objects based
upon BUILD_ARCH or the host distro (when uninative isn't used).

This has been tested and proven to be very effective. We will likely
rework the code to improve how this is handled but for now this
improves automated builds until we can get to that refactoring and
more invasive changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0a09b0fa03d1afc08037964dc63a18ef7cff9c78)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/siggen.py | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f982bf22..ded1da02 100644
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
2.17.1


