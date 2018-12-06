Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id B6ED26C1AF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Dec 2018 18:55:37 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id g76so3071108itg.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Dec 2018 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=b00ldJJ4cVXIJQl+zAJkpZlKWKshJvcAKZfYdQvmVvw=;
	b=UIFb0ATMpvpJS7Pg2/IuXW696trYnR5ix5GnJ78Alzer09AMTixSavOYgRZLBalwy4
	GEOYdk9bhhmv800rEAq0PrdEs54yBniYu/9dr1JBpghY5vZhVese1KXl0YMg9RevMLy5
	YXccJRkBwsYpyTPuqRjzYEiLN78FVSixh9hdkqMfUfXjpNTkTvvWxfJoSG7NLUgR6qkk
	qiLS8cuRKR82IiDJvMZH1Gb9zL8Hz6OyUS5A4BmD5L9K8eq32zxZGnkmYaRy80DXqcth
	1W9bXv6SWx7m19lqGFotkotaRfwnDF95Rve6RWeP7Zcm2/Y35wRHbmUcL0JdMuYIvHJk
	APew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=b00ldJJ4cVXIJQl+zAJkpZlKWKshJvcAKZfYdQvmVvw=;
	b=TyFTDU+G48PEhwkOovQg7dppAQC0DupFB5Df0E++i8kB+P2IJk0Nlf7BeAN1BN/PbE
	OthG1p6Pni6mVDeAA9T1deX5/62GmPR1QukgzplzKPcWwG6WfgYLBJoPUM7MTbWQ8TDk
	RmueFIhtNoi/oU7FCVOuIGSbKs0xWJj6VOI09QWc9s3/lX6Ryq+70/xZ6tpPu1x0pwDP
	IVxPhc9mOjzXzI3LyjMn4fXilR/aRL2RFSEvIlON5EllCj1z2UEnGEO7QZd9Gf+AQL7x
	e8IPSg9zk0TF3zcH2WByEuaPDD6e2ktnwpcNP7Nn5lExNIGS05s4Q0jKyA+u1qw4DcMl
	5NHg==
X-Gm-Message-State: AA+aEWYWqUSKC6MCGbQ1HrioB/pJDm8/5E3qNMpo5KCw8v6Oash153xZ
	YIcE61toIn1UDXbKlmp8jnglzSbC
X-Google-Smtp-Source: AFSGD/WU00/NOuunv7Zv6piucLngmx0ayKCvx2glpIRQB4S++Slt52iyRoKw19yU4mruZ6psXF845w==
X-Received: by 2002:a24:f609:: with SMTP id u9mr22089573ith.116.1544122538439; 
	Thu, 06 Dec 2018 10:55:38 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	e141sm1129295itc.40.2018.12.06.10.55.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 06 Dec 2018 10:55:37 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Dec 2018 12:55:35 -0600
Message-Id: <20181206185535.12523-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] Add a variable to pass flags to fakeroot (pseudo)
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
X-List-Received-Date: Thu, 06 Dec 2018 18:55:37 -0000
Content-Transfer-Encoding: 8bit

It is occasionally useful to pass additional flags to fakeroot (pseudo)
either for debugging or for behavioral system changes. Add a variable
called "FAKEROOTARGS" that can be used for this purpose.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/build.py    | 2 +-
 bitbake/lib/bb/runqueue.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 4631abdde57..20350319bf0 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -371,7 +371,7 @@ exit $ret
     if d.getVarFlag(func, 'fakeroot', False):
         fakerootcmd = d.getVar('FAKEROOT')
         if fakerootcmd:
-            cmd = [fakerootcmd, runfile]
+            cmd = [fakerootcmd] + (d.getVar('FAKEROOTARGS') or '').split() + ['--', runfile]
 
     if bb.msg.loggerDefaultVerbose:
         logfile = LogTee(logger, sys.stdout)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f2e52cf758c..de04ccfcb91 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1175,12 +1175,12 @@ class RunQueue:
         if fakeroot:
             magic = magic + "beef"
             mcdata = self.cooker.databuilder.mcdata[mc]
-            fakerootcmd = mcdata.getVar("FAKEROOTCMD")
+            fakerootcmd = [mcdata.getVar("FAKEROOTCMD")] + (mcdata.getVar("FAKEROOTARGS") or '').split() + ['--']
             fakerootenv = (mcdata.getVar("FAKEROOTBASEENV") or "").split()
             env = os.environ.copy()
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
-            worker = subprocess.Popen([fakerootcmd, "bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            worker = subprocess.Popen(fakerootcmd + ["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
         else:
             worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-- 
2.19.1


