Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.3266.1627470621941115929
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jul 2021 04:10:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HbwN5RJb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id h14so1994230wrx.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jul 2021 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9N9jMR9DQi4BGHh/dZNHcAqDjTXC6oK0RGc9u32hznA=;
        b=HbwN5RJb7eGovmc906XFXEu1MXTfadU+ztgfoGqx9TUBUZ+3N42uKDfD8I7Prg8OqI
         AGMEBdPBrR0yPdUw1mrLqQfPzIpfkRKBOMGpEgvUk1BK4oLDjFZMnPHV+P+fhOpwC7mF
         fxRfmIYDQYWNW09JFKYzX44/1NYFOXZsegh3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9N9jMR9DQi4BGHh/dZNHcAqDjTXC6oK0RGc9u32hznA=;
        b=ZuHjYGgAUc1NyWUoTN3eAXeeiy5rF7yZ8R8mnbJIg7nFlJuVtH6xLFEQh1p6gGoahp
         mhtmbqaeQWlLw5zm7QGhuIp1NFax1nPdGjwv9dEv+O77nn7VbXYcmV82z/O/TWiRSzPb
         +rZCZxoJf8p7K2actPd0MBY1+zc6juN9D6XL4GECUbPkXFUEVevsqDz6s16SXTq5Zz7x
         UunhVl19o0kHbCTceOIa5OgJdRM5wW1hqiBGjEwaOobocHHAOGhjy4wU8nlRGCqlESLx
         PW+ToMH9RYVcGs/zT2kDADl73KCxVRT1S35rCF3vLGrN11Re6tnabg+NVwZyvMai4ao0
         k/EQ==
X-Gm-Message-State: AOAM5300Txw64r8JCPnRV4nsuNVVclB5zH4Y26AtKJzIrATFLg+Udwyg
	4S/1bMgmArBqzPEF34p5uM9Dkvg3ufprJA==
X-Google-Smtp-Source: ABdhPJyflgMwQDKJxMkm+UKQNhs84zqUsWd3udaW0/D8gvYrzyaMfPBNvGN+UPlfZFukvt0cBWNs5A==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr3944147wrp.281.1627470620229;
        Wed, 28 Jul 2021 04:10:20 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:824:a750:d1fb:a5cc])
        by smtp.gmail.com with ESMTPSA id n186sm6711983wme.40.2021.07.28.04.10.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 04:10:20 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Allow colon in variable expansion regex
Date: Wed, 28 Jul 2021 12:10:19 +0100
Message-Id: <20210728111019.3280138-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ":" is a valid character in variable key names, it needs to be
allowed by the variable expansion code too, to match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7d257309df..11be3ce8dc 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -28,7 +28,7 @@ logger = logging.getLogger("BitBake.Data")
 
 __setvar_keyword__ = [":append", ":prepend", ":remove"]
 __setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>:append|:prepend|:remove)(:(?P<add>[^A-Z]*))?$')
-__expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~]+?}")
+__expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+?}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 __whitespace_split__ = re.compile(r'(\s)')
 __override_regexp__ = re.compile(r'[a-z0-9]+')
-- 
2.30.2

