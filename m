Return-Path: <jamestiotio@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C1FC64EC4
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 04:31:57 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.12195.1678422708119935254
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 20:31:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=FDlLN+PA;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: jamestiotio@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id y2so4185697pjg.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 20:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678422707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUvfZO493D0FnEgV0V0oq/WT3YWYeZjvAXeux0fx/Bs=;
        b=FDlLN+PAdgJmqTVmA6IaUeDwfuPEPycZAuqUi6AMacu6bnrg1TsFKxH1+gpR3+8rt7
         tEQt35bKAbNOrewy3bzbtlledB18cPd0YaC1AuCTBkZZT/TYRU+sZissDj9uSQzG3+aV
         U8Lwr/on9cASGXJ/0qX94D+lmAnkmL+9OcXKojI6+WZAtRrzLV/rpnazoH7hMqN4+kEW
         GOdAB5ms3qUNCHAlwij9KJzPzhjm8NTkBpVoJjmC75Ng+K5YydrHxSVQlIkrOJpc5Uqs
         9cV04y0WWQGs0Gz8nW/uVKLSbUcfsKxDa/yhJvn0nn86g7Z41NkqvNaajw1wO3kV/VzM
         mz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678422707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUvfZO493D0FnEgV0V0oq/WT3YWYeZjvAXeux0fx/Bs=;
        b=wRfUszyDuQsm7JKo6lNYf0llfJxaQScKFNfDX66oHoaUy+UZOiGLQUp1E8Ubs8zfr9
         nF3NFr/qQcx5uSyyWKDYN+8hRalBqPVJvYSZQALcUagPLX3lvfM/9U6hP//5J+YG1+O7
         pcuEs8xu/jekKtUPH2Nb0kuqAbCHnnxPO+YpO5EjyyNDHRFNNQFzf7wRu/EyJnQFMOnn
         mLhbXwiUHi+VL2A607Ug2maa98b5+M8mwoMAyDIHhZwR2SgFY+aW0yTjT28M2jsso56G
         g6KJXd0weiHq3wSaZEOZRwd92YjoiQ2gnpxErKxLryzw2UTl+FyENEieJmTv3dsKMOKd
         ZYEg==
X-Gm-Message-State: AO0yUKW4Ye9Inz+GiuYNMZO/4um9SNBeVeyiYmi5sdb5U7BTZJuSZu3Y
	w4ijS1FBkDPeIkza8eZoOXc4Be/wETV3fQ==
X-Google-Smtp-Source: AK7set+LWP8+bFVUbCBZGKcw8q0CKhpp0Qz49uwV6M9UujCKRj8LgCbK/6gxjzuH8wEzxLUlL60ZAg==
X-Received: by 2002:a17:902:ecc6:b0:19e:8688:86fe with SMTP id a6-20020a170902ecc600b0019e868886femr30164407plh.42.1678422706934;
        Thu, 09 Mar 2023 20:31:46 -0800 (PST)
Received: from JRT-PC.lan ([103.252.200.22])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b00198f36a8941sm400744pll.221.2023.03.09.20.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:31:46 -0800 (PST)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH] ConfHandler: Allow the '@' character in variable flag names
Date: Fri, 10 Mar 2023 12:31:11 +0800
Message-Id: <20230310043111.270225-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 04:31:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14537

This patch enables the usage of the '@' character in variable flag
names.

One use case of variable flags is to indicate and set the namespace of
some systemd services/targets. The filenames of systemd services/targets
might contain the '@' character if they are template unit files that can
take in a single parameter/argument and be instanced multiple times, as
indicated by systemd's official manual page.

This patch is successfully verified by creating a custom BitBake recipe
which sets the value of a variable flag with the '@' character in its
name.

`bin/bitbake-selftest` has also been successfully executed and all tests
passed.

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 30760672..f2b8a2c9 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.@]+)\])?
 
     \s* (
         (?P<colon>:=) |
@@ -45,7 +45,7 @@ __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
-__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
+__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 
 def init(data):
-- 
2.39.2


