Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id C747B6B96C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 15:30:04 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id w1so15736020wrp.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=5RrF1ztTnHYIfny5Ep+nm7yaDZOA1fTabBOAxHSguuE=;
	b=Z2t1ZgxztOkwbZDhd5fcikTWvk06212xm+QHY/qH3uoCngIMP85VcFjiHmRlvyFP8P
	1fea+AIh7BLeJXFhVwGqALm01BLWA2ifdiST7Y9o4QcTdsd9py7fWi3BNaZ3g1m1lOhh
	R+R9VjplAzC+4z6B62rFsGOUAjVnXAdoCtkc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5RrF1ztTnHYIfny5Ep+nm7yaDZOA1fTabBOAxHSguuE=;
	b=X6xJej7EY/28TW92ibEOkIoag7GW2sklZ3JmXSB7allty6mH+3hGAGz4bqCQT1Pqxy
	q4YeZnQfDft1+cj7cIkJJt6hsmp2qZXtK/JBlknye7RQr6XD3cKva1xgxjO+xXaAp/X6
	bZgeUn2RFA5DZJynPDNiUZy2feIEdi6D/EyTd+FET8EDxUh9ip+MGAETjiBIbQ0CyHK7
	6SNqdBatyoEkihvMAtD+5mfF6jNc3rUY567WsimG/aqtkeoEwbwotDCq/3LXRF9gDlxk
	sIvrkYzPyQe7dKD4feP8wXrV33Y8JFgsBw9EmHVC7VSjaShNMR8bL4VZ/CT/B+Cq6iyr
	h7Xw==
X-Gm-Message-State: APjAAAVTdMaHyl6wjHQPap3THtly75nahUTs0dyvEg44Dfc8S+PojgEz
	0NlpAvonplRUnv71+AGO+OqOU3u8YpCAGA==
X-Google-Smtp-Source: APXvYqzASKYsBgpRg4pLKYSgpTVTQBuupB2bbH7tMu3nFlR7ZPhywmoIdVmj+31Z/3dxclITWXdOXA==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr17238133wro.216.1553009405542;
	Tue, 19 Mar 2019 08:30:05 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g8sm14446149wrw.22.2019.03.19.08.30.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Mar 2019 08:30:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Mar 2019 15:29:59 +0000
Message-Id: <20190319153002.17984-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
References: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/5] fetch2/wget: Fix typo in proxy handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 19 Mar 2019 15:30:06 -0000
Content-Transfer-Encoding: 8bit

Fix a typo in a variable which would affect proxy handling spotted by
pylint.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 8ec5731b0c..24ffd22186 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -296,7 +296,7 @@ class Wget(FetchMethod):
         exported_proxies = export_proxies(d)
 
         handlers = [FixedHTTPRedirectHandler, HTTPMethodFallback]
-        if export_proxies:
+        if exported_proxies:
             handlers.append(urllib.request.ProxyHandler())
         handlers.append(CacheHTTPHandler())
         # XXX: Since Python 2.7.9 ssl cert validation is enabled by default
-- 
2.20.1


