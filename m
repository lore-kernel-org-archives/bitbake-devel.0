Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 21C4C770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:13 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id l6so73366948wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=9h+XcZMDyd+4Q03IspQZU7Or0lJZthE5rA+oA8o5wBs=;
	b=fcTXRFUzpktictODkVwvK1lhLb4t8ATRJXBc4bltwDheMkN27Qbnr6f+OJcOfeQIJ5
	c2WxUskfQMTZzfoSyc6raUdLddZhY9ZluhozfxYSjNuTD8GQmE3awaVK8LcwJaCVWBeH
	VTFH6CmECwW5EGoIlcbyjtf6CJchCfrP1aa81s/2ecGzndgGa6JzZWTAYiUmfaxw4NcS
	9C03rg6pugVya9gPIgpPSf4YdSYsKnGI+c3bUnvP5dIgL5EFLRqsIRGI/2ARebQr9cap
	NJJi4jZjXwpvwYs4ML/r7Y2kTPVVGOJ+bVEG0mCuagm5QRaCkwxxnZdWaDpYGkX4oTCM
	j6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=9h+XcZMDyd+4Q03IspQZU7Or0lJZthE5rA+oA8o5wBs=;
	b=f/+wkYOMrdIEQ72I3h2VdB6snPvmZRlusM8BiieuI0mCDTnrWLbHfqqThrKfwvX+tF
	lJgGwzXHP8oqsdTh6feW/N66CICQHtMHDyvlz87ESysUad6DNopKqvkhwb6Ds12+5+ha
	cnpg0Qn5Dw13jmt6g/Cqr/isx7Zny41srIbniIzYvPFkcl8n9j6We3Ko4ZpgHsxALo+J
	wwcAMXDRI/nk6jqvhiEnO0DIVvEHbEz10ElLsm+UVtiN+UaNjAfP6x9cBrO1jmEXVxhA
	QprT5nU3PXvkytoGytNAIIulqWwlq9p+fvBhyNDvlvG/4NEnPk9q0MHoU8++PCR3SPOO
	zisQ==
X-Gm-Message-State: AD7BkJIo4eFD1TDzL+5yUhjtwGov4HWnsF9ppxVULVDFSoiuQOHtLQyngcHzbK8XuI5EyttC
X-Received: by 10.194.20.193 with SMTP id p1mr20497843wje.87.1459961233643;
	Wed, 06 Apr 2016 09:47:13 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:12 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:16 +0100
Message-Id: <86361909e99a9a2de96ec6dbcfdaf2ad55eeabe8.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 06/38] buildinfohelper: improve handling of providermap
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

DepTreeGenerated event doesn't contain 'providermap' data in jethro.
Modified buildinfohelper to handle events without this data. This
should make it possible to handle jethro events coming from jethro
bitbake server by the latest buildinfohelper.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index b7b9284..e2161d8 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1246,7 +1246,6 @@ class BuildInfoHelper(object):
         assert 'layer-priorities' in event._depgraph
         assert 'pn' in event._depgraph
         assert 'tdepends' in event._depgraph
-        assert 'providermap' in event._depgraph
 
         errormsg = ""
 
@@ -1332,7 +1331,7 @@ class BuildInfoHelper(object):
                 if dep in assume_provided:
                     continue
                 via = None
-                if dep in event._depgraph['providermap']:
+                if 'providermap' in event._depgraph and dep in event._depgraph['providermap']:
                     deprecipe = event._depgraph['providermap'][dep][0]
                     dependency = self.internal_state['recipes'][deprecipe]
                     via = Provides.objects.get_or_create(name=dep,
-- 
2.1.4


