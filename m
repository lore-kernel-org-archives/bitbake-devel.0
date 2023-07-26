Return-Path: <dit.kozmaj@kynetics.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6749C001DC
	for <webhook@archiver.kernel.org>; Wed, 26 Jul 2023 08:05:28 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.6392.1690358722059201745
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jul 2023 01:05:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kynetics.com header.s=google header.b=ZuCNc91T;
 spf=pass (domain: kynetics.com, ip: 209.85.208.177, mailfrom: dit.kozmaj@kynetics.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso5801421fa.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Jul 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics.com; s=google; t=1690358720; x=1690963520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxKjbNFQt/vJMQ33jorhDafrW70G8J4d2wC1O2AGaqI=;
        b=ZuCNc91TSMdfi401dchY+8lg3l/amh3ND2nkSxUqDOwjnHNYy0hnjFkw/+j+bi9rQ6
         pr3jGNvQkfon2ty8YZf+jw6LtG3cWOzXXWdNhh5cmOzX2IIqV/MIsLxKPC/nGRvCD8A1
         QW/u0zG4BS6RRCSA5tTxxyBc3Eh81UPU2HXiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358720; x=1690963520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxKjbNFQt/vJMQ33jorhDafrW70G8J4d2wC1O2AGaqI=;
        b=JqSg0c82hx+1EV0BtvFBR8+zLg6nkf926SWXAteKMjGbT+VCUu4UedBLRdCAo5ThTC
         cjnwDehv1GuU3tge0mBN3ZOgPqfogkCQs35azSDwNMo39+tPDd+uKZ+pPBdvrIrRech9
         XGGYAFVbt6+9+ZRx3EZwVm3xv3xXud2k8CeMCLtZtCBun49YnNKUjnx33QLoAGE4HfDm
         L+mJdIxEIK2CNGAI1gnOfQ7OBuPkfomB3eou8zoICw4O2AqSWO5SZ0tH0n2GgWgOAesJ
         iZeShhJtZFu01JOSO7zW1gTirgJfoLwv+7P2TYKnORNZYodLebqvCjJuEpPZb27+2f7P
         sEFQ==
X-Gm-Message-State: ABy/qLbUwnIw2LOSS3c/GSAQ7iuGFOO3E9ijG8nld62z11s9UFva+l11
	BGL4GVksPVcMC4cZQE6gUD/L+SDjSILGB0I2KPnVLg==
X-Google-Smtp-Source: APBJJlF/P6HNYZWxPvKtZM6mfZtxbzhYnDoJ7fpgymR5mqpGojT1Bpf03Aak4vZg6inniHPoQLI06Q==
X-Received: by 2002:a2e:9d99:0:b0:2b6:cf0f:1fbf with SMTP id c25-20020a2e9d99000000b002b6cf0f1fbfmr952187ljj.42.1690358719701;
        Wed, 26 Jul 2023 01:05:19 -0700 (PDT)
Received: from ip-172-31-5-183.eu-west-1.compute.internal (ec2-54-154-19-36.eu-west-1.compute.amazonaws.com. [54.154.19.36])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003fd2e898aa3sm4152162wmq.0.2023.07.26.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:05:19 -0700 (PDT)
From: dit.kozmaj@kynetics.com
To: bitbake-devel@lists.openembedded.org
Cc: Dit Kozmaj <dit.kozmaj@kynetics.com>
Subject: [Patch v2] fetch2: Set maxsplit to match expected variables
Date: Wed, 26 Jul 2023 08:04:58 +0000
Message-Id: <20230726080458.12840-1-dit.kozmaj@kynetics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Jul 2023 08:05:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14890

From: Dit Kozmaj <dit.kozmaj@kynetics.com>

Set the maxsplit value to match the expected number of variables.
This also avoids an unnecessary split as the parameters are in the form 'key=value'
and the 'value' could contain the '=' character.

Signed-off-by: Dit Kozmaj <dit.kozmaj@kynetics.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 bitbake/lib/bb/tests/fetch.py     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 770021de16..8afe012efb 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -388,7 +388,7 @@ def decodeurl(url):
             if s:
                 if not '=' in s:
                     raise MalformedUrl(url, "The URL: '%s' is invalid: parameter %s does not specify a value (missing '=')" % (url, s))
-                s1, s2 = s.split('=')
+                s1, s2 = s.split('=', 1)
                 p[s1] = s2
 
     return type, host, urllib.parse.unquote(path), user, pswd, p
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 20593764fd..c5d15e9fd8 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1342,6 +1342,7 @@ class URLHandle(unittest.TestCase):
        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
        "git://git.openembedded.org/bitbake;branch=@foo;protocol=https" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo', 'protocol' : 'https'}),
        "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
+       "https://somesite.com/somerepo.git;user=anyUser:idtoken=1234" : ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtoken=1234'}),
        r'git://s.o-me_ONE:!#$%^&*()-_={}[]\|:?,.<>~`@git.openembedded.org/bitbake;branch=main;protocol=https': ('git', 'git.openembedded.org', '/bitbake', 's.o-me_ONE', r'!#$%^&*()-_={}[]\|:?,.<>~`', {'branch': 'main', 'protocol' : 'https'}),
     }
     # we require a pathname to encodeurl but users can still pass such urls to 
-- 
2.25.1


