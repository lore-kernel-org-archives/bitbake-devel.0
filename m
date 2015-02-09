Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3EBA3606E9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:01 +0000 (UTC)
Received: by mail-pa0-f54.google.com with SMTP id kx10so20129525pab.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=OFTxyEVatDRUHq5QSY/5AG65KNfYRWcLCyyH28zSwGE=;
	b=YV+Q6vBB74o4FuQ5J0fZk1UIXl+Fhx8b21DDdOuXArhK9pDmqSrttbMV1MuaOj4Wsa
	TVy/8cd5aaFELBcZ78PamTSFhQXUlcM0t4HjOJJZwVNaazYBtZw221IkPg5ok1moGYtT
	X6ghrvEVGZRAtd0hKwiiT6G2hwXTg1IHr2ve1DBfju3QiklfQpeNGl6DpYp4YF/Nu5iw
	+AT6mzV4ZjdfgZnOw8Rj/VB/jQGp5nr3EbFW06U1b3d6hblZbka2HOxFXDdz+xqzif5D
	eEdU4avu3Qh/IDv/1co7hRTiiDO4LXC9ucPzDsLIWdYNjoTulm1if4+8Gqon6wVIbGjp
	z/zg==
X-Gm-Message-State: ALoCoQl8clZMikVOVTQ3vMDIYodeXDZ/pvAmzX2r3DmjywZ/Ss/OSGrfSE89GiS+FtrzE9PxJ6cm
X-Received: by 10.70.42.11 with SMTP id j11mr30592989pdl.21.1423504922422;
	Mon, 09 Feb 2015 10:02:02 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	kp1sm16959910pbd.54.2015.02.09.10.02.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:01 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4BA24566192; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:34 +0000
Message-Id: <2a18952a525d15814389584817674f6c3aee12d6.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 04/27] toastergui: fix loadconf error message
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Toaster crashes in loadconf if it needs to raise an Exception due
to poorly formatted error message. This patch fixes the formatting

[YOCTO #7276]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/management/commands/loadconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index e2f61e4..9163e9b 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -59,7 +59,7 @@ class Command(BaseCommand):
                 except ValueError:
                     pass
             if url == None:
-                raise Exception("Error while looking for remote \"%s\" in \"s\"" % (remote_name, lo.local_path))
+                raise Exception("Error while looking for remote \"%s\" in \"%s\"" % (remote_name, out))
             return url
 
 
-- 
1.9.1


