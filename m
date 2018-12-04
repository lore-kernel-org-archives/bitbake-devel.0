Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f176.google.com (mail-it1-f176.google.com
	[209.85.166.176])
	by mail.openembedded.org (Postfix) with ESMTP id E43AE6C64B;
	Tue,  4 Dec 2018 03:46:29 +0000 (UTC)
Received: by mail-it1-f176.google.com with SMTP id m8so10190807itk.0;
	Mon, 03 Dec 2018 19:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cBB8aGgY8jfDv/62Mlk84y1ZctqrXntqLD/F+AYTD3w=;
	b=a1kHK45JGgDbdvKJk5fduFREaLZ97Ss54ZyC+3mlw8TZGRnJi8urdxdE5EmpEZKAt7
	0VppbtK5B8dEm325AMAnB3MsT80RNxYTQs4R9f+lizWL4+Rbf69VrcKX9FmzEuBQMLTo
	CNJfDdLd4EoAfnLx/Uy202COVD+b+IOD79LkhOVSu6UKnK565U541JVAAWxKvELqVBEV
	zktvRI+ZAtGO8QpYwIv99SsaoIm/e/2Y6CEvpBAZzjCxkB9cNy9mYFx1jauPA0gpYaFt
	zUEiFtuOD40VVQErjS2mDgThL11NIh0DAFaLPfDTfTIACSJWt9xcg6cptGt6IkcMVQCu
	p38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cBB8aGgY8jfDv/62Mlk84y1ZctqrXntqLD/F+AYTD3w=;
	b=BbQ8xBYGUeqEGyWP/6SvHEVFKAMiQMqjQPBXGE/jfIYDVM5iHamB5gLoVD3ZjTr19J
	aNIG73i0u6OrjBNNX8CYUdSbSdEf/4mufyqae08/KqHGhFCC2dRe3JAnxrD/Pwczpc8N
	cBNA34CEThODx9fUHtKplUXjc1tiCDaBBiLr+Irx6Hd2d+YDiDqI97hVWT3C7xmBEjKW
	8UbI4QHnjtxO8b9fGSmx9PzI+imtFtZg7e3pW7KTQzFYrrZGTIZO3Wsxo7jPcQXOunT2
	oHTFw3HXk7LH9JPvHx0e5DnFUn1XPkD2NtBOLfpBIY/IqbnOaX31JGuoF+tTF3efjYlo
	SfVQ==
X-Gm-Message-State: AA+aEWYXI7Iw2YdfgbGDNWpjuwFw7PtyqU7bSZdyl+bIt+cg8pBXStLo
	t0d8kGdcJcr4pRv/yYxYvpl13hz8w1k=
X-Google-Smtp-Source: AFSGD/Vb3P+eUV5Hz/clJLbr+gaRg04WjazKeN+6c6UMIqvbTu22yg1dY0BxvLKYDwEqkpklDX8WDQ==
X-Received: by 2002:a02:b093:: with SMTP id v19mr17981671jah.64.1543895190654; 
	Mon, 03 Dec 2018 19:46:30 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:30 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:38 -0600
Message-Id: <20181204034245.25461-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 10/17] bitbake: siggen: Split out task depend ID
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:30 -0000
Content-Transfer-Encoding: 8bit

Abstracts the function to get the dependency ID for a task so it can
return something other that the taskhash

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index ab6df7603c8..2daca70538a 100644
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
 
@@ -186,7 +189,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
-            data = data + self.taskhash[dep]
+            data = data + self.get_depid(dep)
             self.runtaskdeps[k].append(dep)
 
         if task in dataCache.file_checksums[fn]:
@@ -261,7 +264,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
-                data['runtaskhashes'][dep] = self.taskhash[dep]
+                data['runtaskhashes'][dep] = self.get_depid(dep)
             data['taskhash'] = self.taskhash[k]
 
         taint = self.read_taint(fn, task, referencestamp)
-- 
2.19.1


