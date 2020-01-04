Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id B63E97FC8F
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:34 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id c23so19660761plz.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=hmALHdmhxRw1EUAOm7N9d+epIQ5T83F4X+sc2/jt1p4=;
	b=qEJJFhyWR5AZpURdXrjutt9gvQysS+zP6FHyGOMwVdxUslZlAzM1vI4vF6/wKRO7Hk
	B/TYimGlnJE4gX5bZxQbXPrKU9rvOgqLrydjZS0RZLriGBD+krQ9HKpPIdbbx5m+3LgK
	QiU3+e9AsyO19a0Z1BjDhjBgV6+qqrnCNaa537g5sfyEmPu7coKA9i7NRc2lu8MZRavM
	VXFK1YDutaqjECrEmz4s4+wNFXuxpZH4zRzB//9Wf1gMLPVgPkxJmlOjXnsV1BiM0FyZ
	jPOSIhxH65HGgTxQERgXPzlo62+95Ea8/IKBKorA+sDMBzT049a+MtQKRJJO9AP6N9P3
	Q+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=hmALHdmhxRw1EUAOm7N9d+epIQ5T83F4X+sc2/jt1p4=;
	b=AK8FL7+7lBeDp0Um6ZYtmmZSeHmuCWNVcuFJIGxfTHIo0HO/dkrY3pzFGdqa9W5Gym
	G0B+ljyda/LM8sIbO62U996TyBNndxlmhTDVspiHtyr+BowZTSgHADjOP6RzDF0ZJG3r
	qA/HvmLt8C1qFmG6fMQr1b4cARN0CCdGuWujpQ86AkD73H3/+ozRiXKjmWdo7eH+lhFO
	nuGJj665+ao82oWwVljukJQprbr4qowNrNWjCtT1LSY0Amq1jo63ASk3H2ieuDrQ1wOy
	DFLT7gdTV4ARbf0kqrt56ChpdAjjxfug85kIHerBkzu1KNmlUjXhTahUSv1lhtI9Oh3z
	h5aQ==
X-Gm-Message-State: APjAAAVNcU6rILEWbhc7tL1PrDgt8t1aTmuOrH2YHyL0nhjR84kl6cfp
	akXjXijx+34nhyK2O/97UibMuc5CImY=
X-Google-Smtp-Source: APXvYqwUA3WwfniIETGi9QRvWnvm+WaPOMq0wmZnPLCfY4myoYC+rgtDHhTYmItDzNzijdqP13Nh2Q==
X-Received: by 2002:a17:90a:b010:: with SMTP id
	x16mr31246483pjq.130.1578104615663; 
	Fri, 03 Jan 2020 18:23:35 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:35 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:09 -0800
Message-Id: <e21bf572cfe18e805d3f849777189685f7391a67.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 24/25] siggen: Test extra cross/native hashserv method
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:34 -0000

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


