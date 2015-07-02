Return-Path: <michael.g.wood@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id B4FA475C49
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jul 2015 16:58:24 +0000 (UTC)
Received: by wgck11 with SMTP id k11so68532016wgc.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Jul 2015 09:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=w+HsfYQdijm8QV8rsYFh8L/O07hCXUb2qeynR4M514s=;
	b=ZpsYs98KrGwW0jSIsNfGFj9kwohmKleTauqIhM9FsgjAw+cHVApakKyayu30EDML3A
	mYnNvTIMjxFA4dMkBMQhEhbRWRo0KZibn9HJEpkuN0bCIK+5USkeEMtaD5soxH6jNNzM
	UEAdpTqRkepuVIndTDD9VKqXd80NHeEeK47IWAeXmQjwoHLmds9eCZXT99oimf30MEJJ
	6bpJeqA/0FfRY6cIQq3cPHwCW54GhWItuPaU06w5ZU3u+K90XFSVQgkVGbDOtfO0+/cJ
	GUkmZfgj9v9j4AmiHE5gw/EQvZW2IlTwwwVAfbwn1DqkvEFloy+i74xbHqsHayYmzTYF
	U69w==
X-Gm-Message-State: ALoCoQnQMgmzPpbQgt2eU8JebdHCxxL+nNJQ1WY3UYTdudiKaXmS+h4zs9jHHBbIy10GAuXnAMep
X-Received: by 10.180.80.9 with SMTP id n9mr55581262wix.87.1435856304128;
	Thu, 02 Jul 2015 09:58:24 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka7sm9007084wjc.36.2015.07.02.09.58.23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Jul 2015 09:58:23 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Jul 2015 17:58:11 +0100
Message-Id: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/5] toaster patchset - fix regressions
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
X-List-Received-Date: Thu, 02 Jul 2015 16:58:28 -0000

This Toaster patchset fixes regressions in current master where toaster is
currently not functional. It includes a small number of partial reverts
from the previous patch series submitted.

The commits are at:

git://git.yoctoproject.org/poky-contrib michaelw/toaster/fix-remove-mgmtmode-regressions
http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/toaster/fix-remove-mgmtmode-regressions

Thanks,

Michael


Michael Wood (5):
  bitbake: toaster: Partial Revert "fixes after html5 compliance
    testing"
  bitbake: toaster: Revert the addition of analysis project mode
    selection
  bitbake: toaster: Remove erroneously committed template include
  bitbake: toaster: runbuilds Fix incorrect variable name
  bitbake: toaster: Fix build execution regression

 bitbake/lib/bb/ui/toasterui.py                            |  1 +
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py   |  2 +-
 .../toaster/bldcontrol/management/commands/runbuilds.py   |  2 +-
 bitbake/lib/toaster/orm/models.py                         |  5 ++---
 bitbake/lib/toaster/toastergui/templates/newproject.html  | 15 ++++++++-------
 bitbake/lib/toaster/toastergui/templates/projects.html    |  3 ---
 6 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.1.4


