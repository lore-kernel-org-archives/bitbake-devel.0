Return-Path: <marciohenriques84@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C17FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 12:39:03 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19571.1777552739762163035
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2026 05:39:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FcrJLYfh;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: marciohenriques84@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d75312379so1212048f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777552738; x=1778157538; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W3HsvYAxMlAVlMJlJvVZed0I3wE57twcaEn7xyjAWo=;
        b=FcrJLYfhNvv+JOds2imbpGRN4tz5cZbPAz2Csz7yziuxLBgmt2KJwyGXrnfeT4MA6P
         f5G7/UwBGTwAn9BurQPixeBY0DRQg7Ujn5bzCLxgN8v0cc74s8lgWApus7XRQMDIKtIN
         Io+TniVTavkOEBf+F7r0+t1S+aU76H/P6mUAH8DksWD+sNbR5uOdf+wRa3lA/OpMQLKl
         82Jh4GdikczNVQu08LkpaiwHo5qMYGDtOdNZ8mqcnHTKYfaW2ZULcs7XqXW9+H8sIVZd
         xfGxln0rEF9HI9x3HxfKnZioUUdnshqGdvuaxo5faXhoZFlOmCq1ZiIJh8tbRyP6+480
         Hglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777552738; x=1778157538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9W3HsvYAxMlAVlMJlJvVZed0I3wE57twcaEn7xyjAWo=;
        b=LWEDLZygY3l1lXbCnMAdVm2BBTSLIEQWsGZ0iBzy31xoyESBpbEfviFLgIdIXnwDA7
         B872Lf2eZvD/rvefW1fvFpBunjkkQwebvURKQjH+flrgzcaB3g56DJKwhM1O6cywoeiE
         5Oa7fIaOkdb2kOWiygB38dlHrn/d8/6jlP1Jiq1EOzu+ye1fmzEL5OVeQ4iMkg+Ye9Wx
         /fOIRdebnJjRDQfCiggn6Y1uSD4naKn4wU5SVci1xAjxXPaqsnoU7VM5nxMUsW2TgpW2
         xkHChtrlJLP3edt1EMjt7ca35BExE91eA3ZuHehSv+CQWlalYCA/GS6nsUkehkj1AYQe
         +5yQ==
X-Gm-Message-State: AOJu0YwmplhkThbjlJuoblcnb9qYIX2O24QeOUkEFAC8+06nnRx6YHFv
	w1dInNo8vxZAQzIZ6DM30WQC7JmHMwYuXHrgDU8xXykQ32gNOosuxDFc4buFkMDN
X-Gm-Gg: AeBDievEOmc7C4CiJTMRJTKouFWtBVJ71Hjo2Sjo+oelJICEFk/aqUWaQ/ETHkcQeys
	ueXcU1H7o+1ev7S+jR+Dzo25tRyaX3VjNYCFlnJlFC5mZXPg/TITwvw7euqyIjdw8DXZ/GEs7cJ
	8Y+TW8h7UlSUfiWkQoopE6syAsXJK47+JquP6TDZ2GvS1ZAjsXU6TMf58eF/sZuBPuGS2erVpKE
	H9VgY/zNAFGKESGVJAe9H3G+Ph7nENqbhzZI/snDosDq+8S6JaLx1BBr3w1XgSxGtumHrgDWiwB
	2IkR2HOX8bwlROgTlRoy6qhOnZHzKLJ8jio2jMewRkvMqbJ/qoZDY4nGXYKqz3QcyqJkkBVMPhM
	JBkiqZscKxtsD5QhTYQEiMflM0qxn3J2lYxyofiUvytxqiRNmGzdtPVNyee4NKgPPrqxIW8Tez8
	IVsfkSlNa3utkIOPdi5RuuQyUUypwSPEy85YyFHse0si2rW+XXIILvXPxeEzS55OkgEQeJ9eTUH
	E24kONal60aZkMyxnXdZMsGrO0Gxp+moPcT6SURFPzLQ/8A7lXnaDIP
X-Received: by 2002:a05:6000:288f:b0:449:df0c:c258 with SMTP id ffacd0b85a97d-449df0cc371mr1640423f8f.27.1777552737673;
        Thu, 30 Apr 2026 05:38:57 -0700 (PDT)
Received: from PT-PF3LTRXS.critical.pt ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216675sm12966638f8f.11.2026.04.30.05.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:38:56 -0700 (PDT)
From: Marcio Henriques <marciohenriques84@gmail.com>
X-Google-Original-From: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Subject: [PATCH 1/1] bitbake: add BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
Date: Thu, 30 Apr 2026 13:38:44 +0100
Message-ID: <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 12:39:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19421

In some CI environments, shallow tarballs are preferred as fallback artifacts,
not as the primary source path.

Today, enabling shallow mode also enables an initial fast shallow path that may
avoid creating/using the regular local clone flow in DL_DIR. This can reduce
the effectiveness of incremental fetches and lead to larger re-downloads.

Add BB_GIT_SHALLOW_SKIP_FAST as an opt-in switch. When set to 1, the fetcher
skips the fast shallow path from initialization and proceeds with the regular
clone/update flow, while still allowing shallow behavior and tarball fallback.

Default behavior is preserved when the variable is unset.

Signed-off-by: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 19 +++++++++++++++++++
 lib/bb/fetch2/git.py                          |  4 +++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 8d8e8b8b..1def16e7 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -390,6 +390,25 @@ overview of their function and contents.
          # This defaults to enabled if both BB_GIT_SHALLOW and
          # BB_GENERATE_MIRROR_TARBALLS are enabled
          BB_GENERATE_SHALLOW_TARBALLS ?= "1"
+   
+      :term:`BB_GIT_SHALLOW_SKIP_FAST`
+      When :term:`BB_GIT_SHALLOW` is enabled, BitBake will by default attempt a
+      fast initial shallow clone directly from the upstream repository, bypassing
+      the creation of a local full clone in :term:`DL_DIR`. Setting this variable
+      to ``"1"`` disables that fast path so the fetcher always creates and
+      maintains a local clone in :term:`DL_DIR`, allowing subsequent builds to
+      fetch only the delta of changes rather than re-downloading the full shallow
+      history.
+
+      This is useful in CI environments where shallow tarballs are treated as
+      fallback artifacts and incremental network efficiency is preferred.
+
+      Example usage::
+
+         BB_GIT_SHALLOW ?= "1"
+         BB_GIT_SHALLOW_SKIP_FAST ?= "1"
+
+      See also :term:`BB_GIT_SHALLOW` and :term:`BB_GIT_SHALLOW_DEPTH`.
 
    :term:`BB_GIT_SHALLOW_DEPTH`
       When used with :term:`BB_GENERATE_SHALLOW_TARBALLS`, this variable sets
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 21f5f28a..f72173b9 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -196,7 +196,9 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.cloneflags += " --mirror"
 
-        ud.shallow_skip_fast = False
+        # Allow disabling the fast shallow path so DL_DIR keeps a local clone
+        # that can be incrementally updated in CI.
+        ud.shallow_skip_fast = d.getVar("BB_GIT_SHALLOW_SKIP_FAST") == "1"
         ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
         ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") or "").split()
         if 'tag' in ud.parm:

