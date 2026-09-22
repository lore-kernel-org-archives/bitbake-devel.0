Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC56C982FE
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 01:55:33 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1250.1790042125802636339
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Sep 2026 18:55:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tHsdoUB6;
 spf=pass (domain: gmail.com, ip: 74.125.230.205, mailfrom: twoerner@gmail.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb7so367641285a.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 21 Sep 2026 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790042125; x=1790646925; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qG+YLcqc+7OwaxKT514qpY39673hQTRd2VcCszc0FQQ=;
        b=tHsdoUB6zDRlRcxJIVnACqnnfwYDB7Lee95tpl3Xpr8d+1V5uhvahkxsuE7RINfoJo
         wuoTgUF9TyHEPAv90gjFtOae7RLIsteomAc5aUORs8/qBgMHSwK2XSDzzmOMGBlb1sPj
         zRKfKXcjbdGsJSKZ7cBR++Sg9A+LVKmJPCmLJhj2VwuRncgVKq4xxHjVeONXt3ZZv9Ie
         jxmEfYCKn7cdXnDo56DIn1H2xb/MlVXa5N87upkMXogycXuMMG+yJn5cW8XoW39eJhJD
         Q+/kYCSLkTrc3xVKTI3Y27vgljpPdXSu0MvsjDkagds7iLkkt7A6sgCtyNKtASIl6tNv
         DKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042125; x=1790646925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qG+YLcqc+7OwaxKT514qpY39673hQTRd2VcCszc0FQQ=;
        b=VsrXoO037kBCkVgk3ZLdLYlaG3T7z/NDBZIr2rLcWZoGJgzuhBEBqWvx4N3xwAD1fO
         1VzdRcx5poTvf8MN88bD2Wnyxb9x3VJkkSLZKhNw16f/OQR+paGWV94EnGyaZVxJuWoH
         K6ribATi6pTbDsQKGSdmnTUgIVuIY02HuEuQZ1a/hYoC9PjuF7jpDhjrkHH1Cqww0O9x
         FCbnqi4RUe8i2FU78LPgy8XWiAnnmctQaGPU2Jnut/7amCztakqZyAJS5+lcHNvg32Gy
         KPW6LvV9uPZopLxIRIogFGh9b1myvDilsmg1/ZeBZYhb3zdYTU2U+XDbLC/JXxlLjYtt
         wIAw==
X-Gm-Message-State: AFuF++kyUBQjd6zNWwWT+IskdLQHhSQwmEdYaYwR4EnnOv3MflcJ6DOg
	LCIxs6XTvvOFkU4vlG0GBjvyPxeYzg6HttzU1ItM+JwBcRTFBEgjwkYQsXHLxQ==
X-Gm-Gg: AYBFou12RbodZRd9rKItwWDZ1Lh72XiJS/dgKnSSbkcPn/zJx4FY+4GGNExppVsKRT9
	+gQPRrzT+A3gXuZitf1N4+c/T06crFASEKUmP+aS8cf/vHcfCm2V1a4RNsvYr+hhtGY8GeUzGqz
	wjzfgSMTfOTqp+4+L163upwCI7aH9NNm/GMG1391jewis9y6ZijP3ZJ4pPKdNc3eSv+doOw0hif
	/qZxQWHfzgsDAYyzUeU3wkrwuJoTjSr3gMNO+zxJDlash1Vw1T901QPvBYH5pHtF9lNI421Idhv
	jw3EI/UZqnUu8MP7cH2POg+i4q3qjXsFr/kaKFe5OC7TS7eAirg3G21DP0OBsOA2G9R4dbrMa++
	EwTABZqSjZ1aG2BSSSe/QdScrgOk8uFeuTOHqtsXR34f7mVKiO9BHHX7CoaV4Xvwk1mpMCX1Emb
	6Cp83at7jyp2zV+utNsZRyrIWD7MT8jhI9HkafyU/uw+s84L0gnx/Mm5dQmpd9TSHsrm6te/wa0
	VfZIDkFaYBCrsdBZQiWXJ+SVs5lbem50gz3tEP6
X-Received: by 2002:a05:620a:2611:b0:939:57ca:7e08 with SMTP id af79cd13be357-93c15d7632emr352987085a.2.1790042124610;
        Mon, 21 Sep 2026 18:55:24 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d03b170sm16640985a.16.2026.09.21.18.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:55:23 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] doc: document the conventions used in the manual
Date: Mon, 21 Sep 2026 21:55:19 -0400
Message-ID: <20260922015519.313312-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Sep 2026 01:55:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20233

The manual uses angle brackets for placeholders and a prompt to mark a
command, and says so nowhere. A reader can only infer both.

Add a page stating them, in the sidebar beside the other top-level
entries, so it is reachable from any page of the manual.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
Applies to: bitbake, on top of master. Paths under doc/.
Destination: bitbake-devel@lists.openembedded.org
In reply to: <20260831031444.4070152-1-twoerner@gmail.com>

Changes in v2:
- The page is a document in its own right, reached from a toctree in
  doc/index.rst, rather than included at the foot of the main page. That
  was the part you objected to, and the sidebar entry means a reader meets
  it from any page rather than only from the front one.
- Retitled "Documentation Conventions", short enough for the sidebar.
- The examples are the manual's own. v1 shared a file with the yocto-docs
  patch and so illustrated itself with core-image-minimal, "sudo apt
  install gawk" and a root prompt on a qemux86-64 target, none of which
  this manual contains or is about. The placeholder example is now the
  <machine> already used in BB_PRESSURE_MAX_* , and the command example is
  a bitbake invocation.
- The root prompt and sudo sections are gone. Measured over the manual:
  every console block prompts with "$", there are no root prompts at all,
  and "sudo" appears once. Documenting a convention the manual does not
  use is what "not related to BitBake itself" looked like in practice.

 doc/conventions.rst | 36 ++++++++++++++++++++++++++++++++++++
 doc/index.rst       |  7 +++++++
 2 files changed, 43 insertions(+)
 create mode 100644 doc/conventions.rst

diff --git a/doc/conventions.rst b/doc/conventions.rst
new file mode 100644
index 000000000000..a10795d456b3
--- /dev/null
+++ b/doc/conventions.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: CC-BY-2.5
+
+=========================
+Documentation Conventions
+=========================
+
+These conventions apply throughout this manual.
+
+Placeholders
+============
+
+Text enclosed in angle brackets is a placeholder. Replace it, including the
+brackets, with a value of your own:
+
+.. code-block:: console
+
+   $ tail -F tmp/log/cooker/<machine>/console-latest.log
+
+Here, ``<machine>`` stands for the machine you are building for. A
+placeholder is never text to be copied as it stands, and an example
+containing one will not work until every placeholder in it has been
+replaced.
+
+Commands
+========
+
+A command you run at a shell is shown with the ``$`` prompt that runs it.
+The prompt is not part of the command; do not type it:
+
+.. code-block:: console
+
+   $ bitbake -c clean foo
+
+Where a command is shown with its output, the prompt is what separates the
+two: the prompted line is what you type and the rest is what BitBake
+printed.
diff --git a/doc/index.rst b/doc/index.rst
index 9f2a9067d385..0a2bd9ce2ecf 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -27,6 +27,13 @@ BitBake User Manual
    genindex
    releases
 
+.. toctree::
+   :maxdepth: 1
+   :caption: Documentation Conventions
+   :hidden:
+
+   conventions
+
 ----
 
 .. include:: <xhtml1-lat1.txt>
-- 
2.50.0.173.g8b6f19ccfc3a


