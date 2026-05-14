Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101BCD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 10:58:25 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8091.1778756301992651536
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 03:58:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0QrfWpRT;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 53AD0C5DC69
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:59:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7271E60495;
	Thu, 14 May 2026 10:58:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1962E11AFA052;
	Thu, 14 May 2026 12:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778756299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bm9NBmn6A5AVl7u3xDdQcu3IflffeU738CzuOeTIzFg=;
	b=0QrfWpRTfsBBusHqAtVeWkHH7KYbKf/F9XpPzeQnEXsSiUAjrKgB/fIlj2RjVnL2PmJ3iv
	a2AyibIEFcKyt2xRNNk6H9CE4HvrxEELleNk6UF3RcQpMMwWLfmdmD0Clh8BHbBEDQThQc
	vbdGHpCuqFktYkXoagSsESaRdWLe/PIHDuDGMg2SpJOa4u+7sXLmiNKhor/VyC/+e8Vhan
	R75Gzpaz9lHy9EicDrvuMHyI2psaSwmXyWZ5RHhGv2HOiQbNOjBlavC5A9lKEGfZQ2aGKS
	iEZ/DLx/8VjfpAPXDviyjseYAh746vd3LYeYcxGhqNEbDnxvcfw6Z2GetEdTNw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 14 May 2026 12:53:14 +0200
Subject: [PATCH 1/2] doc/setversions.py: move arg parsing to main function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-set-versions-fixes-v1-1-70b1fcdda8ee@bootlin.com>
References: <20260514-set-versions-fixes-v1-0-70b1fcdda8ee@bootlin.com>
In-Reply-To: <20260514-set-versions-fixes-v1-0-70b1fcdda8ee@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=PetKNsiwIA/r/Tn/XT4H5FszuRJrrqi/ASR4FWn25SQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqBaq/HPbyiOGhGgVazYYw8W4hNomoYDkH/fgPa
 DmHRGp3ZnqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCagWqvwAKCRDRgEFAKaOo
 Np0BEACKXD4uxhkQffiUyS1ggOPnaUcQk4IcsOKJrok1/i0CB9K49pKhs4ds6NXIDlnYMflg76b
 QLHbAKXkmG0+okZZMHkt14ovEGVCEhimvNu/+evys5jvXGZtTqLh19OqtLW8Zn+rBT7WYRrO+5c
 z1MojjpxyKj/hbpoEyyBGA/S7ZFmGg6gjYiXh+fhAA0d7W5oWgCBZKK51cfs5mb27OjiwVW3eZK
 zwLZQ8PTWo82MQhwocQzSb5szKHhU4Nwo4ClqXHTKLqLMDjWYhGnNFB+GuwvfvVP0y4d+jjCadv
 Mqav1LbYp5lafiSOy/6qdwRl3pGvueZPLAospm40e9AaadaWw/GGNfnBmrNKymVR1TV8Kn7RGED
 e1C545nUBhYAEheH20LXPioQIZD0aEV1zPMs8EXBungrLCu8jHUuEQCfS00PKD/pWlpXUwC2LyV
 AJTs/sbKsaF3Z2Gce2iFwj/49BS4EdQy/c0ycnTFRnkip/Cmu6rCZZ4Al8s8P4OBwBd9XPVZHDH
 l38oQzOiOiTdBsMpIsMTnwWF/5WPL+oDXl9WpMyBV1eAbXhneAwmv/5ELK9sTWYnPsTuPK2KyD2
 HtX4mt+OD0riEs/DS4YthiK8g+ShOxcKaiP2+VsnFR55qAq2q4pap54rLpJ3vK2km/LYamh2YSo
 cUq7eGL2IVIfF2w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:58:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19520

Otherwise conflicts with Sphinx's arguments.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/setversions.py | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/doc/setversions.py b/doc/setversions.py
index dc0bb11e75e..8e934667f93 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -24,15 +24,6 @@ import textwrap
 
 from urllib.request import urlopen, URLError
 
-parser = argparse.ArgumentParser(
-    description="Parse https://dashboard.yoctoproject.org/releases.json to get current releases information"
-)
-parser.add_argument("--get-latest-branch",
-                    help="Print current latest branch and exit",
-                    action="store_true",
-                    default=False)
-args = parser.parse_args()
-
 # NOTE: the following variables contain default values in case we are not able to fetch
 # the releases.json file from https://dashboard.yoctoproject.org/releases.json
 DEVBRANCH = "2.18"
@@ -95,16 +86,26 @@ if RELEASES_FROM_JSON:
     # current releases is also an LTS
     ACTIVERELEASES = list(dict.fromkeys([current_branch] + LTSSERIES))
 
-if args.get_latest_branch:
-    print(ACTIVERELEASES[0])
-    sys.exit(0)
-
 print(f"ACTIVERELEASES calculated to be {ACTIVERELEASES}", file=sys.stderr)
 print(f"DEVBRANCH calculated to be {DEVBRANCH}", file=sys.stderr)
 print(f"LTSSERIES calculated to be {LTSSERIES}", file=sys.stderr)
 
 BB_RELEASE_TAG_RE = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
 
+def main():
+    parser = argparse.ArgumentParser(
+        description="Parse https://dashboard.yoctoproject.org/releases.json to get current releases information"
+    )
+    parser.add_argument("--get-latest-branch",
+                        help="Print current latest branch and exit",
+                        action="store_true",
+                        default=False)
+    args = parser.parse_args()
+
+    if args.get_latest_branch:
+        print(ACTIVERELEASES[0])
+        sys.exit(0)
+
 def get_current_version():
     # Test tags exist and inform the user to fetch if not
     try:
@@ -368,3 +369,6 @@ def write_releases_rst(releases_rst_out: str):
             - :yocto_docs:`1.6.2 BitBake User Manual </1.6.2/bitbake-user-manual/bitbake-user-manual.html>`
             - :yocto_docs:`1.6.3 BitBake User Manual </1.6.3/bitbake-user-manual/bitbake-user-manual.html>`
             """))
+
+if __name__ == "__main__":
+    main()

-- 
2.54.0


