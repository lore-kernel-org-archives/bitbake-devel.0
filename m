Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACACCD98CE
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 12:41:45 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44454.1781181702592124586
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 05:41:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qWl95p4m;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so88569395e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181701; x=1781786501; darn=lists.openembedded.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jt2zy/JNNL0LpeQtU+bESkacj/g4D71Y5PjGQARcBq0=;
        b=qWl95p4mBnzRQxD1oviVV+yBvhuWF5Eb5foVXaYeOqBnLfLZPo3Y9F0682MTMU/u9Z
         MVhiIC9/TB96RnXtrBUQg0zPHmLFNHETddAMiwk+OSKC1lZINTvhkySIHYrGjSl/MYZ/
         hASXi9Eh1Gv314EvW8YycbbeBn4Fx6acwGJjILBed1aoaQo2AydvSIbHZ7XUE190OReQ
         AjYkC8XNsbhjkUgMyQ1RQpPMXIjiTN6X/12/Fgw7vn7jp2xTf390dLGcPBxwgPNDGVt4
         ov9gt3OEeLwg5OP+wpbQmLkQaITLUgUVKCs8zj+ByCD1vOIJdu1HI5JKNqdWKT5x+IRh
         vCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181701; x=1781786501;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt2zy/JNNL0LpeQtU+bESkacj/g4D71Y5PjGQARcBq0=;
        b=p1GS1DIsGI9+0jwv7aqZQ8Sv+ycLlZxhZ0yifbkoiLEpVYmxd4WJ7Ggxx3kgxpJ2Yo
         hHanOc261/lVE7LP1lFKT7nvFzXD0XlVMv0cICTfXwNq7OwXgrKx19wI6+vgxiUwGdl8
         5IbGTSknGAk6xEEvyMwV26g12cOKkGBJJMtiXeL4IyC2ONfkPQc7DFcua2mdLDkalYrH
         Xy/8T6w21lqvSfwX72PZJs1iK91vA9aYWLyG4U0F886rR6oUbQtjTFhN+Zj/0aijYjg5
         0ly67Q6Qp9S31kit0HStgPejT6PlQReBkWuT1fxw141ga38jISDWuoWsvJR7XVbwX3V3
         7QcA==
X-Gm-Message-State: AOJu0Ywf46C7m5gj3on+yjmK1eVMBaV7ZhWPiGBiJ7P1H3BZXWmrfU5j
	p/sTe8F7bnXVhWKDBn0slqIdhzZ25UBKe7let3PMxiyHR3OevRIK1ZGui0cGZQ==
X-Gm-Gg: Acq92OG0QIun3jIvy4lP1B1yZ78JhGMz1EkffAI1hKyLLd30VO1KCgdx8z2LIkACASy
	8fphtoeHhWCZ6KCLoHlSPPDGsCQhr8QId1fIJV8oft1s5rHcFvWJ6jvFhIeWtlvtC0xlKfdPb6l
	LDDxst6vRSBYQMb2qobkLyE1qso4cBTJQ7hKqEyRI9WB5AOMB25kf94BnyWVtDE3+W6mRX4fL2i
	IXhg5TE6aArSes9w3eHRFzan7wOpDXmKVxKeiEZxhhq6lueQApCGARWsZ9Ult/t4YUIg+cFsFbm
	QffZPUzKsiw8YQGvgFO2/Dv1ZtBJDIU5BkCcZVvv9I8mQ6SE1IYUIAbHBDynghDdcuOA0FMSW9w
	Ti5MFsISGZEVLB356Y3x/9Qcw6/GIGIYenyVKVjKcu1AX9c64tBVR7ixAdkwX+AwwdAg6tlPR0C
	/Boq4+htxfz8s5fN2uP11EGZdVkOqbfxT/bS+5782PBr/wK+oPncBeSUsh/FaIyl26ZWY86Zx8y
	NwIYaVJOjSw1wspuQy7dduA1+V9d1r9rDtu+e6dmGMs8kE/
X-Received: by 2002:a05:600c:8b29:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-490e55d0b08mr36954795e9.6.1781181700671;
        Thu, 11 Jun 2026 05:41:40 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm68665423f8f.31.2026.06.11.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:41:40 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 11 Jun 2026 14:41:32 +0200
Subject: [PATCH] bitbake-setup: always write newline at end of the README
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-bb-setup-fix-readme-newline-v1-1-5f5dfc57ff28@toradex.com>
X-B4-Tracking: v=1; b=H4sIAPusKmoC/x3M2woCIRRG4VeRfT0b1ECsV4kuNP+pDWWinUB89
 5G5/GCxOjVUQaOT6lTxlSavPGEWRdd7yDewpGmy2jrtjOEYueH9KbzKnytCeoIzfg/J4AN8Ohp
 tfUSieSgVs9rv58sYG/wWnYRtAAAA
To: bitbake-devel@lists.openembedded.org
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 12:41:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19659

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

When the "readme_extra" string was introduced, we dropped a newline in
the "readme" multiline string. In a Python multiline string, this counts
and therefore we dropped the newline at the end of the README unless
readme_extra is not empty (i.e.: unless the VS Code string is included
which includes a newline).

Put the newline back into the readme string and edit the VS Code extra
string accordingly.

Fixes: 92fd721941fd ("bitbake-setup: generate config files for VSCode")
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 69c9882f4c45..767b7e3f739b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -415,12 +415,13 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     readme_extra = ""
     if init_vscode:
-        readme_extra = "\n\nTo edit the code in VSCode, open the workspace: code {}\n".format(workspace_file)
+        readme_extra = "\nTo edit the code in VSCode, open the workspace: code {}\n".format(workspace_file)
 
     readme = """{}\n\nAdditional information is in {} and {}\n
 Source the environment using '. {}' to run builds from the command line.\n
 {}\n
-The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf{}""".format(
+The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
+{}""".format(
         bitbake_config["description"],
         os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
         os.path.join(bitbake_builddir,'conf/conf-notes.txt'),

---
base-commit: c687d42b81b17e7a2399099cab0f1a6aafcf6520
change-id: 20260611-bb-setup-fix-readme-newline-3e8d91028bed

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


