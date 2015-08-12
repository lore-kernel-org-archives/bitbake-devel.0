Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 119CC76769
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 10:32:08 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so21572732wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 03:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=oS8AiIRgsy62eUB22B6EM6R712/zLpUsBZ46CSG5UDI=;
	b=JMTAo99uitgbvE9/4OlPG3iNPLFdrJ+YX5asTdmuO5Gl9V4QFiPeLgOTYlQlRqDAaE
	IXtA+JJCHLuwbW+LDrreatRLv8uIFl82hR0xVQtN/Vp+iX7Y+fzX1dP/JPwNO+DCGEdG
	0esWGajSOwKklViwz+WG0k033httJDhuOsOZFr9jB5gCGKYW4r2KJrCm+XvaUQfKufde
	QiijFbZza6RzF6ZQlzsw5V05QrrXT6DfX0WKx2UK1RrZq5HsDVr6tefOm0G7dykXwwyh
	9g3t/x8t6N7au5TLXacS62lulLRTxI0Os1xggPKjw9RHbrhsi/6oZ1b/yMQrjPA1zOPb
	4bfw==
X-Gm-Message-State: ALoCoQlwjCpBHX3TT3gtR9jYr312tPA11rnQVrz+r/6U64U4JWmG5wkVpqbonmh1YqQJlda5u71w
X-Received: by 10.194.95.71 with SMTP id di7mr68413233wjb.125.1439375528180;
	Wed, 12 Aug 2015 03:32:08 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gj13sm7630352wic.22.2015.08.12.03.32.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 12 Aug 2015 03:32:07 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Aug 2015 11:32:00 +0100
Message-Id: <cover.1439375393.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 0/2] Toaster patches
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
X-List-Received-Date: Wed, 12 Aug 2015 10:32:09 -0000

Reviewed by Michael Wood

The following changes since commit a8b723498c9a7106210db140452886894494b4d6:

  bitbake: cooker: Resolve file monitoring race issues when using memres bitbake (2015-08-03 07:36:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib michaelw/submit/bbarrosp/misc
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/submit/bbarrosp/misc

Alexandru DAMIAN (1):
  bitbake: toaster: fix invalid fields in the package details page

Belen Barros Pena (1):
  Fix typo in set up script output

 lib/toaster/bldcontrol/management/commands/checksettings.py           | 2 +-
 .../toastergui/templates/package_included_reverse_dependencies.html   | 2 +-
 lib/toaster/toastergui/templates/tablesort.html                       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.1.4


