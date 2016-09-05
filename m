Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 66FB6760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:55 +0000 (UTC)
Received: by mail-pf0-f182.google.com with SMTP id w87so7236903pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ysvE5Ds3zLMYq1dNNFkfDMgsAbAjT1iiWr4RXcO4Lto=;
	b=y8R4Hc6fMJ4BIRW//MQqKl+rKrEjSQVU4oBM1jUkIx+8JzaT72TGahOL2iCo7lG8Zz
	bw+/x60UoRynjHqDCVVoe4L6rOpoQJmId9yvFtDdYO2MPGWYa3Y+LUUX8oZmcCy70sl/
	ckEZ1fC2hY3z5ho76yMQYXoPeDRopxpJp4sNIIHtfZGaZatG3ZjhYxQzO3Tf9BHngqJn
	WoUJ69rV3c0DtqUYfxEtkFd+giwTGAJkb8TP4B10wsDB1U5nnSRS/vXPEgqnPsQ/b0ae
	LiDXD6rQqMZ7ng8MsYAFebY6Tqnpqxxr+7ZFv5t2kjiebsd3d6aK7ZWRKOZEkn8cITBh
	sPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ysvE5Ds3zLMYq1dNNFkfDMgsAbAjT1iiWr4RXcO4Lto=;
	b=kANNOdcrq0djrvHCjpt3U756TMgiN1C99sGIT4KtmV+6FGJNMgR8LR2eVycxL0yQRB
	ruLHJGP+CKDV/Nk1v+tYQzO1WQ08iDGc1siIuqJUSZvOZhxJgtLQZcGH7+2ekqLZXRPt
	6s1cEwAgOGX+liv+RYXPAThKtgm2z2zBtXzq4E7Gd4Xt94fiT5MoKQYPb1JHGK8A4gcE
	9+PnfD8a1HpG32x7Aq7Zp8yugYYil9wxgRmHudb2AWhCOp3M4hvaCWcxwUDnIXa+G7Ji
	QqvuiNqccxacikFXTD1Udtrn+r5ASaqpwqFh0n5HIUzMzUEDM3UtTgVUyy5qI72fG0qc
	z3Qw==
X-Gm-Message-State: AE9vXwPpqdnoqxusqnTvU8I9mCtIxHlyoDLvIPdtzvZcIYIt5JgQZ/b3mIQH6nk88FOK0ejW
X-Received: by 10.98.65.139 with SMTP id g11mr22183790pfd.145.1473085795870;
	Mon, 05 Sep 2016 07:29:55 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:55 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:28 +0100
Message-Id: <1473085772-17878-8-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: David Reyna <david.reyna@windriver.com>
Subject: [PATCH 07/11] toaster: keep layer name in variable history path
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:55 -0000

From: David Reyna <David.Reyna@windriver.com>

When converting variable history file names to relative
paths, keep the layer directory's name so that the user
can distinguish between conf files with the same name.

[YOCTO #8188]

Signed-off-by: David Reyna <david.reyna@windriver.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 0f09b5c..96166dc 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1127,7 +1127,8 @@ class BuildInfoHelper(object):
                         abs_file_name = vh['file']
                         for pp in path_prefixes:
                             if abs_file_name.startswith(pp + "/"):
-                                vh['file']=abs_file_name[len(pp + "/"):]
+                                # preserve layer name in relative path
+                                vh['file']=abs_file_name[pp.rfind("/")+1:]
                                 break
 
         # save the variables
-- 
2.7.4


