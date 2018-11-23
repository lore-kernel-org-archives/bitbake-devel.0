Return-Path: <ross.burton@intel.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 85D336C670
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 15:01:25 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id x10so12636913wrs.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=RPJQUAb11/AefQdaESqbzDflIumF+/gg0uxU9Mp9+Rs=;
	b=pZPiCNEQMZ6GE6ttZFav0PrC7oEkYUTh1g5IX1GuuoJ7+dPUB853DCVLx5orJRWVr+
	meKzNvVgVa3t+yFTpl+mETAbuDPL1iJPtX7TJiEFa3PY5DwkKWRf6yKZ7AxD/nIc3ruJ
	C55FWxpCAOC4QBpzRPpe2BNFCdvv74nJPa7iks+JUMbO37myiud2pPrgxZLg813rN7M4
	5xdKch2VTrEVp8S5fxRFUcn9stfGnp/korYBhfuQrjLrQHHnP0lSCxSt0szKkWiv7uNk
	iehVbXuakMVavSDm9H7yf65/WTev+Io5ASf+7hn1PzaxuTLZVNjXYHCDnGH1mVIxudzQ
	hWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=RPJQUAb11/AefQdaESqbzDflIumF+/gg0uxU9Mp9+Rs=;
	b=Mpj0INY5tOje/ld9zVBkaB49B6UJ9EKBwWS9j5T3IXKTaIPvV8+oasQLQrKqBk659b
	Ci9NpGoZx3hJKceSAV1qGWIJxQl5eYaIuibbAwoxN5v7HHNG/iIcpmroDEay4PdNdDxP
	LGtrqBjYozf919g4d8DFbiWAjE/TuDtmIWqY1mu7SN90+iRmNNHifGjFmiC5zyJtnYsB
	k6lVpi0nYPQLwgExqR3w9v/RcHfxRxxVdzaYpiCe5r8P0HoWGdExdy1w8cdlhNw3y/Qa
	J1TBtZXgPVYeXjlk932NNESkoiS2LsWjk8o7YU727ekpJmco54fHsZrFp0ol7XuF0xLW
	9tOg==
X-Gm-Message-State: AA+aEWY5JA7x+AZl3xdmQq2jqzzz70ab1hl6w1C0IzMr6NlChTftQa0l
	pZV6atZ5g5oYbU0uXGs4Z77H76Ml5YE=
X-Google-Smtp-Source: AFSGD/V9rnskIsP/uTwMY1+fOCSbSj+bMEF3sIpWGl9860+55FTT1+wvYrmPGDkgpfBJzMXbgL2ihw==
X-Received: by 2002:adf:9521:: with SMTP id 30mr13661763wrs.192.1542985285900; 
	Fri, 23 Nov 2018 07:01:25 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	n15sm25204205wrt.21.2018.11.23.07.01.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Nov 2018 07:01:25 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Nov 2018 15:01:21 +0000
Message-Id: <20181123150122.23585-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 1/2] layerindex: don't use shell=True when cloning
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
X-List-Received-Date: Fri, 23 Nov 2018 15:01:25 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bblayers/layerindex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index 9f02a9da2ef..b2ff2268ea6 100644
--- a/bitbake/lib/bblayers/layerindex.py
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -28,7 +28,7 @@ class LayerIndexPlugin(ActionPlugin):
         layerdir = os.path.join(repodir, subdir)
         if not os.path.exists(repodir):
             if fetch_layer:
-                result = subprocess.call('git clone %s %s' % (url, repodir), shell = True)
+                result = subprocess.call(['git', 'clone', url, repodir])
                 if result:
                     logger.error("Failed to download %s" % url)
                     return None, None, None
-- 
2.11.0


