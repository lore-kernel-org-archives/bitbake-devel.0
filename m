Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id 007A17FC3F
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:30 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id n13so6343051pff.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=f0v3WKOJFLSGahivqFK4MGF3dP8k1LRE8Cv3sCLguhA=;
	b=HtQz84L1WuNUENKi6RGuBg6g1qPUoNen6pCs1VqnGo8MKr6r3i0/HUFgqeRO/HZ8wO
	PcuTBYB8E3jEICmBpRqbsTOKW/5jdNh5rP2tQeZxpYvx25m+wBVU0hFIL6CZkWaBfeso
	GGWkuVPaiS9Uy46j61OUT4M8of14U8lKiOgCsINEYkyFCxZc+P5y1KHlBLoJRJPfhkdW
	+1EUP5kXGCAjkahxGX3ZYyPH7h55iqp8/1rB9pt9r3FLFWYSx7FaXRIwsBugaPmBCDee
	TpvsTiyNsLaHA8G+aui4TXnKVifJYXvFUxjFwb/pi4U1u030QoITyBSsD/n39IDUjmKh
	neCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=f0v3WKOJFLSGahivqFK4MGF3dP8k1LRE8Cv3sCLguhA=;
	b=rAD0mJVVALKoTxVUm+LEXFKqok4waKoYV7dPuwsXOBOxjCrpImFCYRVcHg5CZ4MkK0
	g47hhuHAivZ+sg5gnIzuEgPfelx4akbIJnD60EtEnL589pVgrqfl90uuZJtZwKFnqnOy
	oRuiE2w/rAVWBqNmwTUtslMGoYWrkAnTD3OSXHsGfRNd/7jkzJ6p9sb1uhDE/3RHY83Y
	Gy9pRXKjSXNE/RHjrYFIjTf7BLoEYTpLnUVNAvl+IvCwDSrHTFp94A3paU/5Idqgc6I5
	IFiLRpM6AmE7/g50Y8jTN6gMEOjY7R790clEYLw9O9DxC7yM4dssQQMYMrOgK4iLkfoL
	sotg==
X-Gm-Message-State: APjAAAWAAIuHecNgyvTTZ/hQsIhuoq0uvfZmbBxpfw6sLQz143QkFZT+
	HF+i6CDwwZMYzUGoLOLRYyc7ihwG
X-Google-Smtp-Source: APXvYqzz4vIwKwyIMIJPumlkCUFDXz+Woom6kEcszHhWaRVq2teSDicK3O+XcawGiRq/SSiw3ektSw==
X-Received: by 2002:a63:a03:: with SMTP id 3mr28823220pgk.117.1574639011791;
	Sun, 24 Nov 2019 15:43:31 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.30
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:31 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:18 -0800
Message-Id: <987996f01d55bc6433aeb7f43c209eb12f6d796b.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 5/9] cooker: Remove a left-over comment about expanded_data
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:32 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

This should have been removed together with expanded_data in commit
e3694e73 (cooker/command: Drop expanded_data).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/cooker.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 20ef04d..e6442bf 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -371,10 +371,6 @@ class BBCooker:
 
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
-        #
-        # Copy of the data store which has been expanded.
-        # Used for firing events and accessing variables where expansion needs to be accounted for
-        #
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
-- 
2.7.4


