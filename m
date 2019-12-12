Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 180EE7FA32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2019 18:58:08 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id z7so3875713wrl.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2019 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=H+2rWrYlHi2ep+tMPMoo9SdlPEs029QqCSiCjuKjmK8=;
	b=TZtCVpQAujGNUOON7O57tsb6aYNnnkaMpyPQ/dVCmpF0ek2v6V8bKjHCNbQBTkAGrM
	Ti/o4023W66W6hPbP7diHrxsQ3lqTcEEUvCVdTfceqP8o919iMcch2RtwA8XtKO20Ji1
	od677YeqZl14tF0oY5pjV8b3Z6ojkcz4j9h7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=H+2rWrYlHi2ep+tMPMoo9SdlPEs029QqCSiCjuKjmK8=;
	b=Jd1eB+L6sTamsgjTuPMWT6TEWH0rYjyGk7/TKsJ5HkoYKWmkKymc2rsVSiUsNx20yB
	mFSa+HwaRvhTQqLmoePkznH5+gIgTi8R0XcS0ZPTmQSQ3t3kadMlTdRiEadvrnVJqpkz
	VLZPwSazbTNfZnFuMw3+CKaVShDZFH3jMZdFFxXeoMtcCN7Kmgn6kgunhytEHAz3KEYK
	Y6z348EisTe7JD25dujmXHV8uFk5FYhu3xqVe/oyd24piqoSty2B0ncsxtcTvK0+227k
	USUSwwgqKJMICCV8Z/m+jfrzWJi0Z9LrYCdiUXXG693t0g8teygFzElMpf41OxXJmhfa
	A94A==
X-Gm-Message-State: APjAAAUFKBCV+FExIiY+otroVdNmJdMnyCXOhS3OQvXFsA0zQBlGj9eJ
	KtpcHEmENCUJvHcMS60NfHb0VhrEF/w=
X-Google-Smtp-Source: APXvYqyvdevWl3Jh/wwBOWBA51AYwJ6fi7y4uQv20VboukK7U4kp9SPEUKZJBzrKETWp5IkpMBUCpQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr7654094wru.99.1576177089433;
	Thu, 12 Dec 2019 10:58:09 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	i10sm6883963wru.16.2019.12.12.10.58.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 12 Dec 2019 10:58:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Dec 2019 18:58:07 +0000
Message-Id: <20191212185807.10411-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] siggen: Fix performance issue in get_unihash
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
X-List-Received-Date: Thu, 12 Dec 2019 18:58:09 -0000
Content-Transfer-Encoding: 8bit

There is a significant performance issue in get_unihash(). The issue turns out
to be the lookups of setscene tasks. We can fix this by using a set() instead of
the current list.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index dbf510238f..2fec8599b3 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -44,7 +44,7 @@ class SignatureGenerator(object):
         self.file_checksum_values = {}
         self.taints = {}
         self.unitaskhashes = {}
-        self.setscenetasks = {}
+        self.setscenetasks = set()
 
     def finalise(self, fn, d, varient):
         return
@@ -110,7 +110,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
-        self.setscenetasks = {}
+        self.setscenetasks = set()
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
@@ -157,7 +157,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         return taskdeps
 
     def set_setscene_tasks(self, setscene_tasks):
-        self.setscenetasks = setscene_tasks
+        self.setscenetasks = set(setscene_tasks)
 
     def finalise(self, fn, d, variant):
 
-- 
2.20.1


