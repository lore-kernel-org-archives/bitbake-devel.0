Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	by mail.openembedded.org (Postfix) with ESMTP id C49717CD7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 15:30:07 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id j9so7505597wrn.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8ucO7Jt9Z9c74tHf80r37CRvDr6M8l+xH7HQ9+MzfBk=;
	b=gD7/zB+tjA0dMtbajhV918A7ZCHue4PUV6aefFA58bVwGjuuxg/38LvnMMpNSlOZq3
	glONFlVAbPbii1ZwN7fjuWPVV9Qq7MdXEOQYQO4wNEPGCOvJfpep6qieni0iDvOUFcoK
	vU4vXKbK03m3zztCz91zihm0xns8XNRipgJJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8ucO7Jt9Z9c74tHf80r37CRvDr6M8l+xH7HQ9+MzfBk=;
	b=k+v5re3NJLlTm2HJBsoJHVB6qXokx5SUSlBT/Kkp9tMjhDQLwysav7tzOlECzF3l05
	uiSrcBk10jWsrshgp6z9MZGlIcsMJzxDaAgqbI2a8kU5mFsFqRrMaOyy+85i8Z5VKq7B
	T9fXS/yD+mFP/vhjUY/Ct6uI11PlQVGqhzm2cvXcKjzOVCZvEuHhijc8cimPQVX2E+hS
	m+D2f+1vcWx9kDUQtiUD7x2amaU5VqVfowj72GIwpZADwAadtzxBbVO3rmCHBBGNmyBp
	xj8308lB2cqe7ebQReKyd0MSTX3Ge9TU6bYHAiax9hKWdWK8uBtXVTIKPKuMHQP4S9VK
	PyMw==
X-Gm-Message-State: APjAAAVitW3OC/9Mk7tqRgM3aJsfb/kbfvhbGUk8Ja0Qp9o3WL97WL8q
	F4wfb5xbfCm/qyxKCAZgHeA0+xHPHRbCLw==
X-Google-Smtp-Source: APXvYqxt9yYj2UPu+w5OGlCzkrz2w+d2s9xYpRh5cAoDK8zRkDDVC/2bIlIBhz8qr6nvVNBk7aWbyQ==
X-Received: by 2002:a05:6000:46:: with SMTP id
	k6mr17302448wrx.319.1553009408275; 
	Tue, 19 Mar 2019 08:30:08 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g8sm14446149wrw.22.2019.03.19.08.30.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Mar 2019 08:30:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Mar 2019 15:30:01 +0000
Message-Id: <20190319153002.17984-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
References: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/5] fetch2/wget: Remove pointless lambda function
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
X-List-Received-Date: Tue, 19 Mar 2019 15:30:08 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index f86047a93e..3bb3e3bb0c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -290,7 +290,7 @@ class Wget(FetchMethod):
             """
             def redirect_request(self, req, fp, code, msg, headers, newurl):
                 newreq = urllib.request.HTTPRedirectHandler.redirect_request(self, req, fp, code, msg, headers, newurl)
-                newreq.get_method = lambda: req.get_method()
+                newreq.get_method = req.get_method
                 return newreq
         exported_proxies = export_proxies(d)
 
-- 
2.20.1


