Return-Path: <Jhonata.poma@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A6CD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 15:01:41 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52401.1778511697782046297
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 May 2026 08:01:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DPLLIpEN;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: jhonata.poma@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd2087858c4so41081166b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511696; x=1779116496; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM5SXnpIStDHUjjoM8JAQ6RQ2XeY9xaFlXS2YoOUS5Y=;
        b=DPLLIpENEbSAOS4CrNvVyLhrJ8lqXyooRLvBNEwcFNtsZCXKhyKhiFjav87PsG+bRP
         eBKS7kRm5A5NH+WafFJsm1E9JfEJGHwlObAeXuDktcm1yJ8SHlPlpN2eIGe8ITl11f5y
         f3KWi60LbV/ymF+rqV3CDfIcjrAXgQtZfaSPHUaUTeKh9DiRo8xp7EQJSJ7Rd/diNF+h
         fxA12wRzLbzhRAbfhU/9S+3RQ016X7Zx4Y5ux8E8Tnszl0YjcDBKVelLSMVScI/fNKtS
         BdJL0TWOgGglNwuS7ksAoVXoufmPvt+aO4RK+/g6iMoemvh9zd/WbMo6G+KoKnpBNxRX
         4Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511696; x=1779116496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xM5SXnpIStDHUjjoM8JAQ6RQ2XeY9xaFlXS2YoOUS5Y=;
        b=XMfEotDyVnfPtAOjTRHBwrZXdoqWcv7dwvKzh/MSNzCwHLINA+i/f5WJwlp5yc60fY
         3ydnB3XlhX1lhIRf/CWudU/rDzbQGDaxQluOtq9jta5SIzyDAJUvknOvnezQc/eI6gsN
         akNV0wFAT8LerDQun9YPA9Q6IjqVtgO1KT0ZjIoWtEH+ltjZ+WS8JW5bEW+zp8I5K1ML
         0Whl1yHVdGYfIXLijHkImj1agLEPwTEyNqUTu9U9CRWIv71or2RvtlmoQ4bb0dbsX/d4
         8Qd57FM2TdJkS6JA2bIAepbKeb/jWN8eYZKrhcS+RA9/e2/5BlqXnwIdTYe/FsI+pIq/
         etpA==
X-Gm-Message-State: AOJu0YxnVR3ox/a7cMumAk/5PyLEgg0blp3ccdRL5x9jxhjVH7y4c64v
	PNyBarknl9TmaC0p08xz6ttSKs+G8bEGDcTOntQWL0Rpf0NaP/tDULvpZ8YuhPlD
X-Gm-Gg: Acq92OHVw8aqPP5NWILuUTRi/KYTk3hOYJIP388GV9SodJlgtcw7FWBgjayxMjtbkyr
	qLjzDhS0Gg3BoYfmdcOhCqXhHzd7ZjRZEvrTxGiOnmF+hnT/mpJ1yr9Ees82q95+46i4vrNUBjo
	3j/Sl+70pXipT94dhFYm/QeXmKRJwpQOJsEx6pzVgAZuNAsv8AQeSYhLmkPN2Hu60fK6bcHbzl/
	JaigvVBq83hDigX550/EcPgdm0h+2dV1QQm+COH1WTv/lFm7ZBByJSvUvNznGCU6cBKwFUtctwC
	qN5Ka2QmbUKZcgIaBu5XPVHMuB1vKAtDvXS2Khdf3aduyV7VL0/pzn+tv1mHX0SXORDjud2vz7w
	LMxpz9ZGBmjQ7yPOr0RuuX/50cvCmaoEfNadVND1soqTESm6KsAevXaVnfQmMQrZVpLjHrNWipK
	UOg3AFobS7dtVO8Wv7yL5hiuiUtVso9g5i0uQBvDirUvGYZdgpvi2XikXkDTaaFYK9fIBi0HNBP
	WOl69ardAKe
X-Received: by 2002:a17:907:9345:b0:b9d:1673:9994 with SMTP id a640c23a62f3a-bcaacd3d944mr839674066b.39.1778511695398;
        Mon, 11 May 2026 08:01:35 -0700 (PDT)
Received: from karaburan ([89.150.155.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd11371bad9sm102388466b.57.2026.05.11.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:01:34 -0700 (PDT)
From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	richard.purdie@linuxfoundation.org,
	peter.kjellerstedt@axis.com,
	jhonata.poma@gmail.com
Subject: Re: [PATCH v2] fetch2/local: verify checksums for file:// urls
Date: Mon, 11 May 2026 17:01:32 +0200
Message-ID: <20260511-b4-yocto-9993-v2-followup-1-cf3a8d2b1e74@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260511-b4-yocto-9993-v2-1-9d5a1c1451ba@gmail.com>
References: <20260430-b4-yocto-9993-v1-1-a54d842cd0fd@gmail.com> <162413fca4aa8fa53472aa6ba1e12b56c1a5c5c9.camel@pbarker.dev> <20260511-b4-yocto-9993-v2-1-9d5a1c1451ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 15:01:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19491

Apologies, the "Changes in v2:" section in v2 ships with two literal
b4 placeholder lines starting with "EDITME: ..." that I forgot to
fill in before sending. Please disregard those two lines. The actual
changes from v1, addressing Paul Barker's review
(lore.kernel.org/r/162413fca4aa8fa53472aa6ba1e12b56c1a5c5c9.camel@pbarker.dev):

- Commit body trimmed; UNINATIVE_URL trigger now leads paragraph 1
  (Paul flagged this was missing from v1).
- Dropped the long historical commit references (b8b14d975a25,
  6424f4b7e9c1, 4b8de2e7d126) from the commit body.
- rename_bad_checksum moved from a module-level helper in
  bb/fetch2/__init__.py onto the FetchMethod class; Local overrides
  it as a no-op so a ChecksumError surfaces without renaming files
  under the user's source tree. Four callsites updated to
  ud.method.rename_bad_checksum(...). No "ud.type == 'file'" special
  case in __init__.py.
- Inline comment in local.py trimmed from ~10 lines to 3.
- Tests reduced to two keepers in FetcherLocalTest:
  - test_local_checksum_match: simpler comment; same assertion.
  - test_local_checksum_mismatch: dropped the os.listdir loop,
    replaced with a direct assertFalse on the specific
    bad-checksum sibling path.
  Dropped: test_local_no_checksum_no_donestamp,
  test_local_checksum_mismatch_md5, test_local_checksum_named,
  test_local_checksum_directory_ignored (the directory-with-bad-
  checksum case Paul noted should raise; left out of this patch
  rather than widening scope).

Thanks,
Jhonata

