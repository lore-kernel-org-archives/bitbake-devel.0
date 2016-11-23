Return-Path: <avery.brian@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail.openembedded.org (Postfix) with ESMTP id ECB7C6B6F7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 18:51:17 +0000 (UTC)
Received: by mail-pg0-f68.google.com with SMTP id 3so1637054pgd.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 10:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=WzQ5PYLtkQ6ra8yJp6Lnm4x1hDJ7vEd9RNXhrNfAIOw=;
	b=phaE2OHdjfPRVD0NmGWK0zNIKh8N7uZPbFlK1/Mzi2NgNcfuHfSCNbrxrrsSHd8awz
	G2u0n0b6hNg87SO2P8IbNCgDA222t7+NX+Ec9M25DuHb3ZyQ2UIjexNMw7iFLiLVKFhv
	4C/fnB5KZ9TD9DIV3xWlWE97mfCLStDZqiV+XRgZh+tI4twOD4P5uRx1wUnz7hNOyadv
	UNZpwxfxVB8aO5MUAVtCfswjM/2i1GGohmJ142sesZjTXTgoSKfLmdY6okn5NZlU8rIV
	Z/98pejlsvTWjiH5g0i9eIuVI0Md/OJQMGD2agl3kpXQRPogbwB2ZHKyfeLWLfHygeV6
	UtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WzQ5PYLtkQ6ra8yJp6Lnm4x1hDJ7vEd9RNXhrNfAIOw=;
	b=XVOxvze//wT3CCd6DH77x5FAWAAP/v7KzJEKQFFdgfrbetBW3hpHdNgYH8pLRB+4Nu
	6SjyaQ8w6Mo88wEKx6iQw9e2Km3rKQamO7Cn79occwil105Z1xyVv5+MvFcFCYYjBaKC
	3M/0PRsd12YKuEreFq41Z2lP1ngJFQhV+GarWGC2b/E6V0AiMAniB13x7tpELMSff2dY
	CRFSJc4RHgHL5XuEzsFi965GeIKhH2BQfeMF3PmxjPGZ1XsAhQP6ZhUCzPkTpmr4oKyl
	duUH5xOJuWWnrruZzQ3YfFxzR7FoBF5dQ6bptuyY3TK+BXMkLDGFnPXtD1Gj4X5kvwrh
	QL3Q==
X-Gm-Message-State: AKaTC010hEWIjrCmZ1Qd/CxWLP76HoIRdRhPpGLCW9LVWVYnQMazHco/8uUw0QDx72utxQ==
X-Received: by 10.84.198.3 with SMTP id o3mr604889pld.122.1479927079658;
	Wed, 23 Nov 2016 10:51:19 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	l7sm54469806pfg.35.2016.11.23.10.51.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Nov 2016 10:51:19 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Nov 2016 10:55:14 -0800
Message-Id: <cover.1479764304.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 0/1] [krogoth] toaster: settings.py , add * to ALLOWED_HOSTS
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
X-List-Received-Date: Wed, 23 Nov 2016 18:51:19 -0000

This backports 7c3a47ed8965c3a3eb90a9a4678d5caedbba6337 to krogoth so that
toaster can work with Django (1.8.16).

From the patch to master's message:
As of Django 1.8.16, django is rejecting any HTTP_HOST header that is
not on the ALLOWED_HOST list.  We often need to reference the
toaster server via a fqdn, if we start it via webport=0.0.0.0:8000 for
instance, and are hitting the server from a laptop. This change does
reduce  the protection from a DNS rebinding attack, however, if you are
running the toaster server outside a protected network, you need to be
using the production instance.

Fixes [YOCTO #10586 ].



The following changes since commit 3bf928a3b6354bc09c87fcbf9e3972c8d368aaa3:

  dev-manual: Fixed typo for "${INC_PR}.0" (2016-11-16 10:38:24 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/toaster/krogoth-HOSTFIX
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/toaster/krogoth-HOSTFIX

brian avery (1):
  bitbake: toaster: settings set ALLOWED_HOSTS to * in debug mode

 lib/toaster/toastermain/settings.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--
1.9.1

