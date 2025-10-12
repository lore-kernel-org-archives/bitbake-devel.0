Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9394CCD18D
	for <webhook@archiver.kernel.org>; Sun, 12 Oct 2025 17:48:02 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.23231.1760291272696349460
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Oct 2025 10:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ItFfRO4O;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f44000626bso2451093f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291271; x=1760896071; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw/Z0QptC/7wy8cG4q5wQlw2ytEkCRmIQUr4u3I2F/E=;
        b=ItFfRO4OB1J5WQR+dL219skQsD3O0N+QL+E5NyqJmUmn7Bmdh8A26AgJpgt7x2+VxL
         EKQD/2c2TETcS7Y/VoUj5jksuh+Bly7Fk9eW194t/gDtqgCF35fOzx9GDgCntl3zK8KC
         Uv8U3sHg1n67v7ZHQI3GrQB69v07A+BAYOL2ojHS6EbhNHre8K9hWWR680aI9jC9GFcY
         0s355xYXS/itc/gBCH8fnJ7F8LqcHa0AQnzMQ3yVOMZNWFgMYoq5MXYNh6DDuGJEJ8BD
         laO+mp/ZwrzyWDKY/zrVjQoAEJXjWydlqbNSGGNSB12DWlcZm3Pzbg75UFVulKaGK28d
         zuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291271; x=1760896071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw/Z0QptC/7wy8cG4q5wQlw2ytEkCRmIQUr4u3I2F/E=;
        b=Mu+ingBldRs/Hv1rZG9CgwqEQZOBgAwbJbdJHocMFwBHH8wdcweZPo/fHI5lXX77f/
         5V1st4Bhgiwgvr0qb+bRLnypTfrlXa9mOIu9op8JWo1wvqKRmvsrY/dqgFblThB7U90i
         dK6cKFfBEMvsByCXIUO/R4RzkAb7g4NXk1Duv+9eRGeAgh8lL0o72L4SVBuOOLcIO9qe
         GSK3xHCTuaOJgpo2iVTMRjn5z2VYJlH0kcXZsiHiLfI3RjheVx+PLiUsK8x401cyQOWg
         E7sPrOsEjEkSPjRIdSBC3Fo6KO1LeDc8Pn1jMR25fFiwF+G0+BUc9knUnB5U2F1QS8Vi
         m41w==
X-Gm-Message-State: AOJu0YzBGGpGBwvAhRmWvd1vXxCBxAHi+zQtF6dwYJURrabzRUOgXUCC
	KbU+GCumjeZ+BWU07nUc7L4dTEv5PuhwiCSkbXMzJw93jQq0Xakr/j8eg7U8GgeJ
X-Gm-Gg: ASbGncuDgo89v5JPekuyRPQ1J96T0Z8vppmLU2Fh4F8nDZoJEZaf7fqD9qXjC1nRMbq
	hyEFyBk593jH4jR9ZgcgXPCriV5wlH3+U+DXFznt2enLGyJea6EtQG+/jOG1yH+9gJV0ajg1Rg4
	R4XpcpUe2dSRwhrUWGI/hxty2nK479eUPVmUIZWoDMrkjv1k0RFVtQMnUXO5mECU9PPeaY915MX
	zWPD1HEV4BACB5ZdO8wvj+Tj5KHMuF34wH5HECsvPQMl73L438hQR22jMx/UOnNSeXtUpcqHGmr
	G/Cb0NohaSWsgeI9+q0ihaQcAkAdA36X5g9QPFyCZay/8mH9fzdc1j/2dJC2GT9ZlYiyN6BUU8F
	uUtnXMlofdJtqAIkPcQ/lADQsHusH+849++yw8K8m/j93vNzQcsQkame1Ccx9FI5P0F8CTNhxun
	qg85l7FN33MtDf6iXRrJFeG+9p4VaBUsRSK0txBHc1Je+gPcSGNJvFvU8kYMIs5oYDFkK4hAAln
	oQq
X-Google-Smtp-Source: AGHT+IGifhmmWEgDF/XkpsO1D6HoOxhMnCQmSsATmDbuAyg+3WC5X8hFTrZnk9x4nTixIR6CB4dMYQ==
X-Received: by 2002:a5d:64e7:0:b0:3ee:b126:6bd with SMTP id ffacd0b85a97d-4266e8db354mr11328646f8f.50.1760291271041;
        Sun, 12 Oct 2025 10:47:51 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm14170160f8f.17.2025.10.12.10.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:47:49 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 4/5] bitbake-setup: add 'metavar' for self-descriptive parameters
Date: Sun, 12 Oct 2025 19:47:26 +0200
Message-Id: <20251012174727.4191604-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251012174727.4191604-1-alex.kanavin@gmail.com>
References: <20251012174727.4191604-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 17:48:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18178

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Add a metavar to the argparse options to have a self-descriptive help text.
Otherwise argpase defaults to use the argument name in all-uppercase.

Before:

usage: bitbake-setup [-h] [-d] [-q] [--color COLOR] [--no-network] [--global-settings GLOBAL_SETTINGS] [--setting SETTING SETTING SETTING]
                     {list,init,status,update,install-buildtools,settings} ...

After:

usage: bitbake-setup [-h] [-d] [-q] [--color COLOR] [--no-network] [--global-settings PATH] [--setting SECTION SETTING VALUE]
                     {list,init,status,update,install-buildtools,settings} ...

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 94514fd29..94e38b472 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -751,8 +751,9 @@ def main():
     parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
     parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
     parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
-    parser.add_argument('--global-settings', action='store', help='Path to the global settings file.')
-    parser.add_argument('--setting', default=[], dest='cmdline_settings', action='append', nargs=3,
+    parser.add_argument('--global-settings', action='store', metavar='PATH', help='Path to the global settings file.')
+    parser.add_argument('--setting', default=[], action='append', dest='cmdline_settings',
+                        nargs=3, metavar=('SECTION', 'SETTING', 'VALUE'),
                         help='Modify a setting (for this bitbake-setup invocation only), for example "--setting default top-dir-prefix /path/to/top/dir".')
 
     subparsers = parser.add_subparsers()
-- 
2.39.5


