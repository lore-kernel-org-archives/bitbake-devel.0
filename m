Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A5ECD98F6
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 18:04:30 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25845.1781805862772026695
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 11:04:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aGE6R9FA;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so9814375e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805861; x=1782410661; darn=lists.openembedded.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq3lFTlnlJEfSg9ps+h7pt96NkKBY7l+xcjyCwK1g58=;
        b=aGE6R9FAE6xYZMfAhaPePczUK84AhOKZ8HLJeRN0JoVMsJ+TbTHIAShChGAovSLfG2
         EPl+H0S6etbshwif0/tI5Cek+8xrDvaIi7JwahUzv5mkT0CrKXKFfYict/MP30dLS06X
         rYTwQgRd43IOZF7D97xUREadKkYSedNBBig+ryPdbjn7NdOty6xXZsin6zIEsFyi/4mO
         1dhGZPxqxutFuVG/ptrL4kHVVHaK3oMJAG7lgWNJLbwrG/y0K0HmiPlHWg50ll08Szy2
         6Luz0wWZXiW7V1wYvQsOTWTz2Nfnk9ReE4nWtm8/11T0qG+XeQIfB5HrcuBAR74KR0rr
         mUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805861; x=1782410661;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq3lFTlnlJEfSg9ps+h7pt96NkKBY7l+xcjyCwK1g58=;
        b=FAwKp3Cp/YCzUHWj+OjpU0zJTYnN1oh6cLPvUN839pVc5uPH1ObMyeLPafBuEHAchs
         xnvLqHYA1ET5acjaSIUtaMMJgIrdRQdCj6dDEjmUQVHEV4EsidL+p94WcxTH5PNEBSeM
         jmB5fbZnMNZs6IjXN1G+mE+aAXYiZkLXnZr7B4v0BSVJN9xLrN/Em226ffHLsoqpTNGh
         jClYt2ZrfX4njIAZyRzyS0+SAiifIPAKmwXWt6PPaeJKd9Gf8h3Io9OiWrk3bdHyteLn
         ARor84FIa3KRpyJvd4PGuc4sgAh8an5eMawcV4VsMIirkS5J2msZPCHcAfG127dD6IZm
         hD2w==
X-Gm-Message-State: AOJu0Yx1XJtlprj9PiExiCKiAEfZz9jBQ67s0DZJKvWJ4AUwbONL65Vv
	7I2FdziMYRY6KscSg+WIj4PYUCAqQLOOgwz1bO4W7TMskVoz57VdZYuPuW1UH4zw
X-Gm-Gg: AfdE7cmwD97B5nWlBXNmxBQaNI562e9iteuSHMbILmeUP5qf3Rr9d2HMFIWvN3E0OCD
	qEYjWLsHskM5458syq/sP8obPROVfZ71ubyH0887NKQEWPC1t3d3lxBovfI0Pf/m/Fl6EWDgvCT
	uoR5LcI2ghIqZY5Tj54rJ5nFGxiI0DCPfWB4u0ISaLP90CtLLY7oNsZ+RcW/SMWow4p+w0+CQJf
	9MOfR/mlPzGUYnbVT6VAje34I7JSZs/RXYuOHz+vH1SnRgJHujX4B6lOTHf5knAjfZhtzEUU4Nz
	krvbJbTokX8RAoCkEGUmyMb7BP4VOW4Gu14/XglCENZGdf815e1VC6LS/UiYMK3XK1yC3u/hf3c
	jrwWA71X5goGb/9KRBacfxXZwmhW/VRq4OndwcjBzvueqtsa621rNm/FN0blghA13O5AdNA8YBc
	xVkqiug21vqeWjDSv6uJSKqsugR4aKeA4xeTULzAJyz6s2e3L8/zLbVHyIpsmuyPBjBc/hZPOWz
	1Eh0jw5dSThNqhC
X-Received: by 2002:a05:600c:3485:b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-4923f5a8fe9mr11945495e9.35.1781805860604;
        Thu, 18 Jun 2026 11:04:20 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47b48sm7813665e9.0.2026.06.18.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:04:19 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH RFC v2 0/2] bitbake-setup: add source choices
Date: Thu, 18 Jun 2026 20:04:03 +0200
Message-Id: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMzNGoC/52NQQqDMBQFr1L+ur+YSIR2VSj0AN2WLmLy1Cw08
 hNFEO/e0CN0ObOY2SlBAhLdTjsJ1pBCnAro84ncYKceHHxh0pVuqkY13LackJeZU1zEgd0Qg0P
 iMGX0YjM8Z6Sc2Djta1srezWgkpsFXdh+qze9ng/6FNlJHDkPAvvnZVWs2CoY1XqUirnnKNZju
 7g40nF8AXdx7vjhAAAA
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 18:04:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19742

A previous series raised the idea of defining multiple named source sets
in the top level configuration. [1]

Alex suggested selecting sources before BitBake configurations, making
sources and source-choices mutually exclusive, and discussing filters
separately.

This RFC implements the base mechanism:

  * Config files define exactly one of sources or source-choices.
  * Existing sources configurations keep their current behavior.
  * source-choices are selected before BitBake configurations.
  * Positional arguments use a source-first prefix grammar:

    bitbake-setup init <config> [source-choice] [bitbake-config] [fragments...]

  * A single unexpired source choice can be auto-selected.
  * Multiple source choices prompt, or fail in non-interactive mode.
  * The selected source choice is stored and replayed explicitly.
  * Source choices can have an expires field.

The prefix grammar means users cannot specify a BitBake configuration
positionally while leaving source choice interactive. They must either
specify the source choice first, or make selections interactively from
source-choice selection onward.

This patch series replaces the release-specific OE and Poky registry
files with consolidated examples to demonstrate how source choices can
combine the existing master, whinlatter and wrynose configurations.

The consolidated registry examples intentionally do not preserve the
exact setup-dir-name behavior of the existing release-specific files.
Today, setup-dir-name can substitute oe-fragments-one-of selections, but
it has no way to refer to the selected source choice. Possible follow-ups
include a built-in source-choice substitution variable or a different way
to model source/config combination metadata. For a substitution variable,
we have to prevent collision with a fragment choice.

This RFC intentionally leaves documentation out until the feature shape
is agreed.

Changes in v2:
  * Make sources and source-choices mutually exclusive.
  * Select source choices before BitBake configurations.
  * Store the selected source choice for non-interactive replay.
  * Add consolidated OE and Poky registry examples.

v1: https://lore.kernel.org/r/20260616-bb-setup-source-choices-integrated-tests-v1-1-a1e51bdeead5@toradex.com

[1] https://lore.kernel.org/bitbake-devel/CANNYZj9rKRS0CD-LGq=phvB_T1XS+SmR5Uti0p8tu49PtTm-QA@mail.gmail.com/

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

---
Ernest Van Hoecke (2):
      bitbake-setup: add source choices
      default-registry: consolidate OE and Poky release configs

 bin/bitbake-setup                                  |  71 ++++++++-
 .../configurations/oe-nodistro-master.conf.json    |  47 ------
 .../oe-nodistro-whinlatter.conf.json               |  56 -------
 .../configurations/oe-nodistro-wrynose.conf.json   |  48 ------
 .../configurations/oe-nodistro.conf.json           | 117 +++++++++++++++
 .../configurations/poky-master.conf.json           |  73 ----------
 .../configurations/poky-whinlatter.conf.json       |  80 ----------
 .../configurations/poky-wrynose.conf.json          |  74 ----------
 default-registry/configurations/poky.conf.json     | 161 +++++++++++++++++++++
 setup-schema/bitbake-setup.schema.json             |  41 ++++++
 10 files changed, 387 insertions(+), 381 deletions(-)
---
base-commit: 733161c76bd2ac777555d3eac113ff54b4c63ae2
change-id: 20260616-bb-setup-source-choices-integrated-tests-5c2d3a31a95e

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


