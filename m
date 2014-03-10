Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 794576F707
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 15:28:52 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id cc10so207830wib.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=02f/EoLpp0xHqwc6Q6ttNBHto+2ifmwn5a8mrOp7Xjg=;
	b=C5ZYN4gXrscI0AuhYy3xeyd8t2r8c5pUiSWsjy3z3lrZUY5FOR/TMPy8KayhqZeQ0g
	lMtOI2lIUqFm+Ra8sNGBFmRRnusM/h4RpRhgorEeLBtyMij66gSgTtOUF0gN1tcsJ3hf
	Vs/zmUSjx4qH2ko7TcSlBh3A3pmRk8U7/xmZ8HbgFA9enrM3RkTK3Axb3BwUuBu3Ihcf
	4+zI1uNQi1kA4dDkYccjKs/E7ngtCkPxappznSl2Q36yKvsLY7XElAwdFJufwVSJrhHf
	aekolwa1N69xnz3/6IRuackEkHEo6fdKXqecTbNBYzN/9idyd+z76HgmhoanBDgZtxSP
	omJw==
X-Gm-Message-State: ALoCoQmFbWDitFeMh3jGsjYRL/3OYfkNjwKACnsGrFm8Qfl9Csue9cykMItcWLQMZxoCG+JK3TxF
X-Received: by 10.181.13.11 with SMTP id eu11mr9223197wid.30.1394465333089;
	Mon, 10 Mar 2014 08:28:53 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id ju6sm51720249wjc.1.2014.03.10.08.28.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 10 Mar 2014 08:28:51 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Mar 2014 15:28:48 +0000
Message-Id: <1394465328-12842-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: fix typo in variable name
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
X-List-Received-Date: Mon, 10 Mar 2014 15:28:56 -0000

When passing -t with an incorrect server type, the error message was using a
variable that doesn't exist.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/bin/bitbake |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index cbfd2c9..5c0b2d4 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -259,7 +259,7 @@ def main():
         servermodule = getattr(module, server_type)
     except AttributeError:
         sys.exit("FATAL: Invalid server type '%s' specified.\n"
-                 "Valid interfaces: xmlrpc, process [default]." % servertype)
+                 "Valid interfaces: xmlrpc, process [default]." % server_type)
 
     if configParams.server_only:
         if configParams.servertype != "xmlrpc":
-- 
1.7.10.4


