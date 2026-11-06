Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.921.1793980120173958333
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2026 07:48:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=m2iaxKM8;
 spf=pass (domain: gmail.com, ip: 74.125.225.133, mailfrom: sympthicode@gmail.com)
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so3651275e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980118; x=1794584918; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=18sR86k+N5hoqmyWPBtTgWO+ZZOT/qMRUt/fo8EqyJA=;
        b=m2iaxKM878f5Ey9pS9cGjQyFGaLKJrDNOZB6k8cItzyDh2Hr1YqGaz1aEFAtl9dRV+
         L+lYg0jTsurnkl5Vihk0a9JQfqfk6pSWTEe9SgcQV9obRx0I92eeOQjLrhx6PaOks0/M
         aJvnKLKHLKCW8rt+WeE2pq/rowmpCBokmPxuULNUUc/cXCxr7qUiKtjm1HCNPcmGSnKE
         N3tOGRqdn+Q37U0rRuLQbN01OOdE+Ro4C1e4K1ZvStcVgfqR4e1H2yQ0nqxNhvcqDg/R
         lN3TiCQcbPF1R4B0LMvyVXEUrk5Z2aQKA+bFk7npOZemiR23X3mb6+fwvyRvdbFaqIP/
         E+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980118; x=1794584918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18sR86k+N5hoqmyWPBtTgWO+ZZOT/qMRUt/fo8EqyJA=;
        b=Sk7a7krTCxSq67qpFB7Jc0KRZslulrEmy6OrdyeygkxDCiTYfvp0YFv7lf0wgXP+L3
         cZ2jVXnJpTPJAgmJZmaODr+kdbyrRd53eJcJjCFRFcmuza72panFvnrYW6rzRiPa7RE9
         9tzGQt85EKQl+OKA1TdGacs89JTC5FSpEPHXG+peHXemc/6Ju4T6ZfueIH4U46mRS6XL
         R3AFN3e6y87F+IhmIpnwcWv2HEMC6YgeKGyP6LkOarT03Ermt86MHlrhWpEacntTr0P7
         NMhP8Kw1tPptew03Z6rCOLnntn5Rc6g5qzH+3yeFbWoL1h9kwL3mp3Y+7hPtAfUlREsy
         21EA==
X-Gm-Message-State: APuU4Z/lCBm7Io+WZ226ZEaeaCwZvzOtjk7viyW8nZKKtwLqCLe8pNQ+
	n9lldxZpkcGSBhqTVfx3RpEwGf2tjGjYvL4LzPBEknDN3DY49+zsPzXCU42NMaE7
X-Gm-Gg: AYBFou0pnhJhE3nmrKhLorQVnsbz3ySIEm81GuqYAWUGb8+lL5FP2fmp+OAqxQthNfh
	8sH22PyZF+kEZMYXhqyR8rLEYSkrN/iLXsK6BQz7T3ubZHbKdR5JQXOxLCYPLylHk8MTjoLEyCX
	uLQfB5VjB9CuCAgnXK4bcn2hDrA7TO5ThsZJ3t6GpWUVe+vzQTMghdjZfdB0fGoGqCwNxM4opoL
	zs/4HeKKUk5yOATQ1/+aSj8lb49/LvPgxI4zzoO5f3BFHLYTIBTjKQ1NwpHBctujh10vOi8FXt/
	JtP4pugsZUn+aoL5XAoHEwD02l7Ics+r3w5k9MRC8w5t9uSvMfBr6EKVuDQ7H+5+IPa0xyJYqNT
	MxZ8VUlOTg1yFhYvv+71ea2gXD5JDCB5852EYr01hf4Sk9Vb9JxSKhuTzpjULAmFPRtlAP8OU8u
	T/GLUIJNzEhDL/5BJhc4rxqwEufc2puCcU+pOCK034Yo5ZYcQZB4tcLl0I+FaxufjmflY9kObMK
	mCAvFgafzpiJWtu46AHZnabQQUNPJM8B9YfDA/B13vKD3eVVWnyZDveSWkli1xlYMPTCMjULfGo
	xnkK03zcNi8DL99uoLb3r1dUzE+51jKbOZL+csftCKyiwuDKc0SyyPxWWbuG4ex5tqDGSKxTcIL
	9r84nczuRnw==
X-Received: by 2002:a05:600c:3b29:b0:4a1:fae5:f2e2 with SMTP id 5b1f17b1804b1-4b6db4a5d89mr54318965e9.4.1793980118291;
        Fri, 06 Nov 2026 07:48:38 -0800 (PST)
Return-Path: <sympthicode@gmail.com>
Received: from FLK-9XB2VN4.fortive.net (83.4.108.218.ipv4.supernova.orange.pl. [83.4.108.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e24012c3sm62545075e9.13.2026.11.06.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:48:33 -0800 (PST)
From: Krzysztof Kaszubski <sympthicode@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: sympthicode@gmail.com
Subject: [PATCH] toaster: fix lack of whitespace around assignment
Date: Fri,  6 Nov 2026 16:48:28 +0100
Message-ID: <20261106154830.599244-1-sympthicode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 15:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20405
Content-Type: text/plain; charset="utf-8"

Introduce whitespace around += assignment for INHERIT statement
in the local.conf.

This fixes the warning:
local.conf:XX has a lack of whitespace around the assignment:
'INHERIT+="toaster buildhistory"'

Signed-off-by: Krzysztof Kaszubski <sympthicode@gmail.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 16a64bab6..ea82bb1e0 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -293,7 +293,7 @@ case $CMD in
 
         # Create configuration file
         conf=${BUILDDIR}/conf/local.conf
-        line='INHERIT+="toaster buildhistory"'
+        line='INHERIT += "toaster buildhistory"'
         grep -q "$line" $conf || echo $line >> $conf
 
         if [ $WEBSERVER -eq 0 ] ; then
-- 
2.43.0

