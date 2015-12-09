Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id A57496FFDD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 14:26:07 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so30661306pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ElyFa+xGpqouZeL4V8DmXYnhjLiA/rTXnGg1N0lwn4M=;
	b=JcMDQCEGojWwmWSqF8Q99ky2bPxBDRgb5MXNO4DUXUxGDi3SiXNYcq7vhfXjM4KIwu
	Hq78xuO+OCTSile9FnISpB5AFbOm2uaoRuLfF/dois4lfdK5uDCQhgljBOPUoOJ4S+mn
	aLdjwBJRCAa6GT5PEwNIGCAcZasPv/sz7vt9VZt5dHL/AOHyn6bpytIXjWnGniwbgXMx
	hPZGmLyxXUI13XF9rLuF/4oaZ1+4tX8eBSohn1FZF02tTYdwZSJwUvEXkyXlrBPcsWfE
	nf8wnP/kGuQLh0ldBQukKIWbgbDTKElz7AdTHS8RD3rPPvTb/6wVV6I2dWjazoyUk+B5
	xDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ElyFa+xGpqouZeL4V8DmXYnhjLiA/rTXnGg1N0lwn4M=;
	b=X8DTxgIlhJ/n3oqoEpDGaoHJAPUbgmHqWUIdzu33H2iye2R7EvtE1Jyi4p9Yc84ckc
	fvuqboYfDsuTqXLED5+AVe5z6njYTFddwd2YcBZEQCpD9WKqXCSjSUxD1kAyzstyrlhS
	odgjhc+XhoGOKQsJJ7hUw04AePtmibTqlUwCa54XAbTBIiYd48WtQ448uMv6X4N+j9d8
	4bcpOpc7ZG/jkzq30V17pr3n/Wen0NGVCf0KsFg1jkBgFWDLiZ/W4wz1tpT5KYI5NW51
	sREtIZIXpywPGkquIY9fibK/Erh0Q1fsNPbUFW3AUBv0tuhgT9Xx+UaSRgxlVrGIZyfe
	vevQ==
X-Gm-Message-State: ALoCoQnJ19NUJMFXiFDdFUJAbxHeZHyLJ5CypXBaOCa2NvZjrEYmXIyrQ+gXoTTnvQSBEF9c1pPfkPXScovZcU6FvUualbEJhA==
X-Received: by 10.66.141.41 with SMTP id rl9mr8233547pab.139.1449671168196;
	Wed, 09 Dec 2015 06:26:08 -0800 (PST)
Received: from draco.icx.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	k2sm12095175pfj.25.2015.12.09.06.26.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 06:26:06 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 14:25:49 +0000
Message-Id: <1449671149-9455-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
References: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/3] toasterui: process SetBRBE event
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
X-List-Received-Date: Wed, 09 Dec 2015 14:26:07 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Currently BRBE is known to toasterui only when build is
started. It's passed to it with BuildStarted event. This is
too late as if build fails earilier than build starts toasterui
can not inform Toaster about the failure.

Set BRBE as soon as it's provided by Toaster.
This should make toasterui to be able to inform Toaster
about early build failures, e.g. failures during recipe parsing.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 435cc2b..0265df7 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -363,6 +363,8 @@ def main(server, eventHandler, params):
                     buildinfohelper.update_artifact_image_file(event)
                 elif event.type == "LicenseManifestPath":
                     buildinfohelper.store_license_manifest_path(event)
+                elif event.type == "SetBRBE":
+                    buildinfohelper.brbe = buildinfohelper._get_data_from_event(event)
                 else:
                     logger.error("Unprocessed MetadataEvent %s ", str(event))
                 continue
-- 
2.1.4


