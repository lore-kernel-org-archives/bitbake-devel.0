Return-Path: <raj.khem@gmail.com>
Received: from mail-pg0-f54.google.com (mail-pg0-f54.google.com [74.125.83.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3A6FA719AF
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Oct 2017 08:33:24 +0000 (UTC)
Received: by mail-pg0-f54.google.com with SMTP id b192so7093229pga.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Oct 2017 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=qeB43Sj2WbjKPiwHWIh33GDQkxUa1xdWmqlcZKP1Mfg=;
	b=Gh0G+fftVr2T4FW+WeAjQVr9hgKRMzlVyYrOQvrNfs2kj0yKTtF3PEGw8tNE8JaY7H
	OMRPhV2Luy1dfNvHoEfg3TWhmxSPKJA4aFOULFTr6jgTQkZJRYXVb27SpvaFiSUQ4K4x
	xjEJqKamp4Y3JOg/2FaNfM+vBQg/mJdUsU/skrZe0NaiWZM9c2W8IFRmvR2zwnVsqX8a
	xXGIpa6X5wXQO6tWwA8zuOPw7giKgwRUYd231D74AGf/wilf61X1x2oU5fqZtvDlLri2
	26OEX0qsHEVcmdAhy+U0XGLLSmyp471ihfoKufOckPMtattDC6D4X43ebldTMbeSstpI
	A3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qeB43Sj2WbjKPiwHWIh33GDQkxUa1xdWmqlcZKP1Mfg=;
	b=krgdh7bOYhASp6w1heuv3uNpenssARfiWpOAHUAxoN8KQtRk561H234WX5UbDR0Ncl
	NcxB6Ne6fCpbt+mVawU/jPwedOCoVjk/IqFLL9maxfxOjk7TBkYxmAJbla5LfHSYJmJD
	NkoWA+L7rCi1cZ6y1iS0l57uZMuiAqWXjChTFFuMSPfWS0UTJa66EXVD3auyqlUYJJwd
	uzV0pX1/Su9DI8AxVX2Wb4pDxwcCH+Mdv1yTyVH+dIhWXRB20WUdy2R5NDLap8WBJOD5
	PBuStIUdnxWOYHnEoV3DbpU/BLdu2t4eQB97I+VIU4gJqxJ4Y9T0f1duWvpj5ej68uH3
	eDZA==
X-Gm-Message-State: AMCzsaWsAwbjtHgC+Y3z5VuI0xYjx9TlY6PPFHfvrPBYHMqceyR5GlCU
	cdgqrZIh25BbG/8R/KyEzylAtQ==
X-Google-Smtp-Source: ABhQp+T8+jrR94mGNDpUwXN3EAhiwbnFSV531lT/P6O77lu/JrKu9Fnv0+n0k+fbgDKDnllji9DMZg==
X-Received: by 10.84.131.163 with SMTP id d32mr2362263pld.73.1509179606052;
	Sat, 28 Oct 2017 01:33:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8882:b8c::231f])
	by smtp.gmail.com with ESMTPSA id
	g13sm17343898pfm.130.2017.10.28.01.33.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 28 Oct 2017 01:33:25 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 28 Oct 2017 01:33:17 -0700
Message-Id: <20171028083317.34774-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.14.3
Subject: [PATCH] bitbake: Update version to 1.37.0 for development
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
X-List-Received-Date: Sat, 28 Oct 2017 08:33:25 -0000

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index daedd647..431bb4b6 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -38,7 +38,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
 
-__version__ = "1.35.0"
+__version__ = "1.37.0"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 45559b99..cd2f157d 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.35.0"
+__version__ = "1.37.0"
 
 import sys
 if sys.version_info < (3, 4, 0):
-- 
2.14.3


