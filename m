Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.135263.1598019354940442910
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 07:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GjrTVlxb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id c19so1341815wmd.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2yuLI347OGIxsOChWmD769G9ROfU0Wo5oBUlFQKryg=;
        b=GjrTVlxbn3MJZ91ie6kMerS2GOcLAOUMBVl6I/xqgQ3ECwQ+UL6cdK2DrFljcYhMNn
         +jv5YENSSS09/gLWPhTUFDQ6de6Qu+ml+QumeCl1SZnFRYrJRfPe3tTNWMeOyFPp9/b6
         rhG0Z4q+UFQR1n4d9qWevEDoygJH+sAaj7JWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2yuLI347OGIxsOChWmD769G9ROfU0Wo5oBUlFQKryg=;
        b=P3u6zUB1zn2DSJ1v0q7JZOuRAa4XYcdZBgMDVY2RU1kZ4gqJxiwED04Dvxw3AprKcb
         f6R0zqQz5Q5p7DdOapgdYZPA73f4QO+qRGKTrrPDNZzo/tjX8882hAwWUhk/sQFABd15
         SvXxZm//VlhcEAwnUuJGWW1LBX+VEBX12rVJLbsz83ZN/AMklEyhTvYhtkwVkYj43l+K
         TVb0YN/PQnnN/6KKgsJlkGqVWpVM18t9upZ1Lf8utjVa4ReqiY9NGjM54Tafl9UDni8B
         HGY68iNsKa7e1myg4KyyV4KDwsnh8g3cJcXNOF5OtemWLKoAA3248wcg9Vs2PU9kV+4p
         CF6g==
X-Gm-Message-State: AOAM533lU70NcGXT/uJsIBUXpQrpKCRbmSeDhOYzXXebI5riRXO1Mfrf
	R0tv7GRfR369OqN4rvG9BVxZ9O2BKbiElEB/
X-Google-Smtp-Source: ABdhPJy9mVqfTuauwQpDb5Yg8ZtFpkJ62wuMAl2Xbwu2D6hmk6fh+ISK2zcG4P/jybQeWQryGCpbaQ==
X-Received: by 2002:a1c:98c1:: with SMTP id a184mr3500447wme.116.1598019352887;
        Fri, 21 Aug 2020 07:15:52 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id b8sm4750526wrv.4.2020.08.21.07.15.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:15:52 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Fix clean_basepath handling for virtual:X: dependencies
Date: Fri, 21 Aug 2020 15:15:51 +0100
Message-Id: <20200821141551.1278262-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like at some point this code assumed base filenames but ended up
with task dependencies appended. This added an extra ":" element to the name
which broke the virtual:X: namespace handling.

An example reported by Jean-Francois Dagenais <jeff.dagenais@gmail.com>:

virtual:native:/full/path/to/recipes-example/helloworld/helloworld_1.2.3.bb:do_compile

would get incorrectly "cleaned" into:

helloworld/helloworld_1.2.3.bb:do_compile:virtual:native:/full/path/to/recipes-example/helloworld/helloworld_1.2.3.bb

Make the code clearer by extracting the specific element we want to add
here, mirroring the way multiconfig is handled.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 4c63b0baad..df762fa226 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -752,7 +752,7 @@ def clean_basepath(a):
         _, mc, a = a.split(":", 2)
     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
-        b = b + ":" + a.rsplit(":", 1)[0]
+        b = b + ":virtual:" + a.split(":", 2)[1]
     if mc:
         b = b + ":mc:" + mc
     return b
-- 
2.25.1

