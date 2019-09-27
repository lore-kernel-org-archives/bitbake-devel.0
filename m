Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id C15C77F31C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:56 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id p7so6412357wmp.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=lkAHh7kq1xF/poLGZ+cSCsmrLb3Wv55nkjGQn4Szqq0=;
	b=JvwmliPruO4ZBf5eb/MGnvChx321H32e6fB2wj2pH7FfAgAZRRLyVHXY7+hR4sjRxA
	fVKBS+uqhbD7L66gPTlIEg95pQc9qZ1+fcOQlcc4Dr/vUe+tu8+48LzN0gF3VmmKw5Qa
	Tn3Kllwe5NLV2yE6xHDdR4Iwdbz8xmOrd8Rg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lkAHh7kq1xF/poLGZ+cSCsmrLb3Wv55nkjGQn4Szqq0=;
	b=f3OxI+r6TYyIqVBn0/P9T95kx9aeWZv4VY59VkMBe+nKtW0hkNYK15BAZE4OOSEB8p
	yIUyqGza6idnhOsU19SY46kNHYQnpVFAkuPhJuLKin2u7GLPO7sod280K5S9i4N8m/Z+
	IajN9qJ7oVgks3xS3AXDN4yzrnoFokq+572COiYkDjcynIEsHOa95LvGyRgIflsr09Cu
	I/A42MirAw2r/ED8oroGBbNwhkdGkxy6cTPtb+t0qxVyzYeSxTwOz8j9b3ks6+wXUBO6
	tnDxpjsAfTSAvKiMjaJaDNK2t8ImtbvFAjYjzIYl7SkB47plmlfhPGE2ZrOq5hZj2dwC
	GqzQ==
X-Gm-Message-State: APjAAAUuxkVHoq52Ycsf1F5uQRtnDAwymObIRLYPmMLy+b6U8JNtFcu1
	I3IhxvFnKioqykmabA3dJCV9MXqRl58=
X-Google-Smtp-Source: APXvYqwAYNeasotTC34m+0pB1QIdMjEblBo+SBaz24G02aE7hZkf7nTr4s1kdBYRKlCc6sxwMJc4xQ==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr6669895wmi.82.1569587637202; 
	Fri, 27 Sep 2019 05:33:57 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:47 +0100
Message-Id: <20190927123347.19276-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 9/9] siggen: Remove full path from unitaskhashes keys
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:57 -0000
Content-Transfer-Encoding: 8bit

The full paths make the cache useless in the sdk. They also bloat the
cache size. They're for human debugging benefit only so compromise and
reduce this to the filename.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 90f0926f25..a4bb1ff7fb 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -386,7 +386,7 @@ class SignatureGeneratorUniHashMixIn(object):
     def __get_task_unihash_key(self, tid):
         # TODO: The key only *needs* to be the taskhash, the tid is just
         # convenient
-        return '%s:%s' % (tid, self.taskhash[tid])
+        return '%s:%s' % (tid.rsplit("/", 1)[1], self.taskhash[tid])
 
     def get_stampfile_hash(self, tid):
         if tid in self.taskhash:
@@ -457,7 +457,7 @@ class SignatureGeneratorUniHashMixIn(object):
         tempdir = d.getVar('T')
         fn = d.getVar('BB_FILENAME')
         tid = fn + ':do_' + task
-        key = tid + ':' + taskhash
+        key = tid.rsplit("/", 1)[1] + ':' + taskhash
 
         if self.setscenetasks and tid not in self.setscenetasks:
             return
-- 
2.20.1


