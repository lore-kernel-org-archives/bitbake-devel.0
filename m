Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C66C5CFCF
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:42 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18287.1786625320688963767
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 05:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SnLER6y7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so608255f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786625319; x=1787230119; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7rT1RqIT8yX3AchQLDVJfAbgqaqJmpogUeZbP9TgSno=;
        b=SnLER6y7VvIVkzpC9gaCEuaFBJsBeoSkjwCWWU8vZp8Z8XNZHY3eggCxeAAYzKjql+
         ZTjFGL89XPQMKke+Q5EoE8mvkOV8zEuR0c56Vsqa64IcDgEuJKs0c9kmLUkeJoXK+8XN
         rkkKsrKue9BmVF/HDaaX22nDSb3pb5CAulpvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625319; x=1787230119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7rT1RqIT8yX3AchQLDVJfAbgqaqJmpogUeZbP9TgSno=;
        b=dP6KZFJcQmH5cK61VvvOUz+9L1X3CGKxTlEP8c5Gu9PeeZaUyqBd2ZZpKvxBaDel3K
         dTV4HqGApmVnusryDcYFDSn2G0mDevSuYsCiPT7tjU1/aV8BjGYgBTLimUsfsHk2xFaS
         CsXp0IHSfRAb93joFuqyzuVmtM6d3CjgrKKWGzWZar8Bi2cJw5sDXkfv78zS5gWxgd4Q
         KBaHIyTHrB0ShwIx7xK9A6pYy2SEev3JqFEqCj5t11PhRVsS3hkOtLOf46+YcKKHAmEh
         mpnQ2dve/XOHDBYDFaabVtk5FEs33F+e1BRwSoVwgbFvhL/xo4SHxJaQ0wUEsg3JxFpi
         ff0g==
X-Gm-Message-State: AOJu0YyUws5FsPPRkBHXivkCpOeO3KUFchF9hAO1kl00vcCda6IwzaNa
	PCplOMFAwmj+J/vo2q5nXYhvyoSPO9rRURzXxyi5Ta8JS5f7RWP7RL/9wF3UbuTQFu/P+TGTfYh
	7vsBx43o=
X-Gm-Gg: AR+sD10nQKt3BZUbCK2GVhYfbX3vizWkHH0yuCBARODi4zJEkyaweVlrX9qshrP1IU/
	XCoIT+2PZoxVYgQIUyWcjo/uAMmbJ7rrX0wADOvGZb34PhQHx2Ko1sNTO/1Bvawcn9BFV0+O5jP
	anCdtTeIallOTav/P4jOHMbCYgC7saaTN+6wvMjYh3M4zz4yL6lDyYIEPT4J7vDQeKLy8KQ6Var
	IbPFdWBqV9Ttis+IKPLqQSP9w8eFLkaJB/1Puc0gOMNq/WwCOqV4sJgdHp6DgbIYFEZ8Nmxvs2O
	cLHl4fHezG/3HAE1Eec65issV+yJIruKl7J7PsfVR3RYlNrmt0Sf+SisC+N+4gDWlNf0vqHwdr0
	FLmFhZvqb7k+b9Gpudp6Y0pjrQiR7kUmShgvSE4whC1C5/qrQUt5VDIcAdmG6Vktdn34iRLyubp
	Bz/Vy+tXf+2HSC1zcvYlEgFYV/lGBoGOJhFkcGGFE5+sZAygaK+5kNyxp2nVdNqsvbUj2LnCvo5
	GS/xV39yioD67obLQ==
X-Received: by 2002:a05:6000:3113:b0:47f:80f0:8d33 with SMTP id ffacd0b85a97d-4815a058652mr7878740f8f.30.1786625318944;
        Thu, 13 Aug 2026 05:48:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm6685768f8f.25.2026.08.13.05.48.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:48:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/6] fetch2: Drop ESTALE error handling
Date: Thu, 13 Aug 2026 13:48:31 +0100
Message-ID: <20260813124834.1770307-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
References: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 12:48:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19925

This is old code and nobody I've talked to using NFS has seen this. Translating
this into a checksum error probably isn't correct, even if we did want to silently
handle it.

I propose we remove this code and see if anyone des really need something like
this, if so, writing it correctly without the ChecksumError usage.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 51db8304c65..2676e0962b9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1156,12 +1156,6 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     except bb.fetch2.NetworkAccess:
         raise
 
-    except IOError as e:
-        if e.errno in [errno.ESTALE]:
-            logger.warning("Stale Error Observed %s." % ud.url)
-            return False
-        raise
-
     except bb.fetch2.BBFetchException as e:
         if isinstance(e, ChecksumError):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
@@ -1976,12 +1970,6 @@ class Fetch(object):
 
                 m.update_donestamp(ud, d)
 
-            except IOError as e:
-                if e.errno in [errno.ESTALE]:
-                    logger.error("Stale Error Observed %s." % u)
-                    raise ChecksumError("Stale Error Detected")
-                raise
-
             except BBFetchException as e:
                 if isinstance(e, NoChecksumError):
                     (message, _) = e.args

