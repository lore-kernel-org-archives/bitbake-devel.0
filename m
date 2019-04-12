Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
	[209.85.214.172])
	by mail.openembedded.org (Postfix) with ESMTP id 1306F7DB4D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2019 01:19:59 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id w24so4256876plp.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Apr 2019 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=21S4kErCp/SylCWFP3d0cVfxiMCQ7TXfko2QiZW1zog=;
	b=Ix8Z88pKz0fdMqgJ7CSbmnx2Fp2TqAnl0jx+rbjuOummd/qqy22qufbn/dds99TuX+
	r41VHEcePNGKCLscOJysnn7uyiGuthsxbokJsLlBNQcHvFMoppTJAtE7t+ykGangLLcO
	ZjPTxCo7UpDKIHw+8NobKyjqluIUaNl672VJCPEdhwyL9NloBH45hdbVlXg1zhMsRs3z
	v+xuUGvcsFHGDFSxu7gw6XaA+y8scufWT4V4lFn/zkYyggrV6TVfEs6FrfKafNwcgD0Q
	umD02U+pt1ZebYRp6zolhF27fnDvBJGfK71vgPdoJLg5If7WcmH2RAWGYEVaTb4EKtOS
	Libg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=21S4kErCp/SylCWFP3d0cVfxiMCQ7TXfko2QiZW1zog=;
	b=ZEOVcPW+kcJbNq2LcK85jaBYLghXLXVp6xVwHrTMXm/NzqLJ2ZaAZ/BF5WlLCQKBhY
	gax0F3H3nuESj+smgQgCTUt+TKkjLen44j7z7MzPepSNK5xbZaG8GvOyk/Q2nImEa1vB
	Ieu/7hyxiVxjaeilXs6S24OKeDZY/LggX33EWTElaP3M+TSOk8ofLNJfYw+kKIOkHjUl
	ytAJvd/+g4Dk2AeoC7n5rTybipD2zfx9I70wim58qjFS3pBglMVdK1n4Lti55OeE5UdK
	AjHMo0aOymplQz5h+cF3Omqfun79LdY6/rMgdMkw32kXHixAV/6uEo7JCzxVLHM2TmH4
	qcVw==
X-Gm-Message-State: APjAAAWN468bLrSOqmlCwQhjoR6ecvcf0/amtXpPrSIsCPVZiVqE4Rzl
	nchRy2Ly8KRmK5cwM/GP7h4a1dd6
X-Google-Smtp-Source: APXvYqzDMuAMsmoTneYEHEYqkqyAfak+jkS9RBCZ8Z1MggOTVz6m8KkcFhBYd6GAGVxmuQmjVMgq/g==
X-Received: by 2002:a17:902:163:: with SMTP id
	90mr24832921plb.34.1555032000220; 
	Thu, 11 Apr 2019 18:20:00 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:918d:ab6e:51fb:1d66])
	by smtp.gmail.com with ESMTPSA id
	g64sm93058384pfg.13.2019.04.11.18.19.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 11 Apr 2019 18:19:59 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Apr 2019 18:19:58 -0700
Message-Id: <1555031998-3975-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH]] bitbake: update masters version to some farout version
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
X-List-Received-Date: Fri, 12 Apr 2019 01:20:00 -0000

This is to avoid having master being updated when we branch
for a new release.

Also, master should not be at the same version as the last
stable release.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 57dec2a..952c47e 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -38,7 +38,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
-__version__ = "1.40.0"
+__version__ = "1.99.0"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 4bc47c8..a86197a 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.40.0"
+__version__ = "1.99.0"
 
 import sys
 if sys.version_info < (3, 4, 0):
-- 
2.7.4


