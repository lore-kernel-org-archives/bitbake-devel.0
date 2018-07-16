Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id 313F47883C;
	Mon, 16 Jul 2018 20:38:06 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id g11-v6so5789358ioq.9;
	Mon, 16 Jul 2018 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NHU22ETBVf463UgMPi7qMCL06nuVW78XN54Bv67QoO0=;
	b=CGuq/8jCMnvkT1aKKuUbLpKNh7ru9M4wrCmsgLM+QMN5zwjv/TWkjcCkNJ1Nnc59bb
	tGQdzxaR20y7MX/AEOqzDJuHLz4O6xjx8BU9oMBQrXBtSsXi/PznzSOCIMzFf9Zg13og
	GrA5Xs+XZxThKYAgMQUIu7Wcc/EOzxvPF2qtCr5kxvl/TEdefNUHAuqNZHUQIs+8nohA
	SxP0bYPWCfZaY4ar96nhvWAMVfH06OR1OaC/QteZFBrEAEcu9t8qdJZrNPh4++hRaaaj
	Lsnodh5w0XSmjUOms2+b6UhKnGbeZCFzAWjdP+W1o07X+BQCMutBCkHDpxmRa4f3n4wX
	MqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NHU22ETBVf463UgMPi7qMCL06nuVW78XN54Bv67QoO0=;
	b=I1cr94LCq35rrrojNjq2n9uy+z3L9NHBEhRVhTyTTRnOKEvbTmhJPFbAJnJqf2ApHQ
	lFFV2QZf6ecUrKt8szmRFvjWaP3VKToCgZtmIrseGfraTzCW49UfHsYIiQIAyKfQekjT
	/KGIaLTr02MA5LmCFtesXV+2/HHlESLtrPGsgnXF6deKBfiAucv1Xwzd4NxetfOCwZmd
	iUaSDj7Jb/YTIBNQq1C9TLpNNVQ4lFWlexAS13m2CaQw1srsYbGZH+We781XKKr+obkS
	iDjYOlPBmHVPv8RShb+Y0Z4FoBEWZqIqLVniwfN0Ao7pLvvKC5rkuUJwRccLrY30DRjo
	/dmg==
X-Gm-Message-State: AOUpUlFmlVaB92TiQq7Rfp4ctJIzxWsfX+yF9i4tgaI2F0IJ+VtmfE7Y
	yQbwk0BAVzDghX+3NL8VBckjOLCp
X-Google-Smtp-Source: AAOMgpfQC3eJ5QlaW7SWJDkUfm1HBGVlquNh57H4OxnzmL7kCFFab5fSbMrLZQdVcIaIvueFnF49uQ==
X-Received: by 2002:a6b:450c:: with SMTP id
	s12-v6mr13955906ioa.273.1531773487094; 
	Mon, 16 Jul 2018 13:38:07 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:22 -0500
Message-Id: <20180716203728.23078-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 3/9] siggen: Split out task depend ID
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:06 -0000

Abstracts the function to get the dependency ID for a task so it can
return something other that the taskhash

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index d2dfcbc3fdb..0b1393e21d5 100644
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
 
@@ -206,7 +209,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?", dep)
-            data = data + self.taskhash[dep]
+            data = data + self.get_depid(dep)
             self.runtaskdeps[k].append(dep)
 
         if task in dataCache.file_checksums[fn]:
@@ -281,7 +284,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
-                data['runtaskhashes'][dep] = self.taskhash[dep]
+                data['runtaskhashes'][dep] = self.get_depid(dep)
             data['taskhash'] = self.taskhash[k]
 
         taint = self.read_taint(fn, task, referencestamp)
-- 
2.17.1


