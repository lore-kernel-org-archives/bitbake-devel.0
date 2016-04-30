Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id C455C605BA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:40:56 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id yl2so15271913pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=+Bt5u3p9OmkevFpDbjNKaRc8K7DvxXzca49NUxWOsjY=;
	b=kuRoglbszQmVFwGocFo94SyTLojwPeUITIP+pN0pzFRRilU26hNm9y491+93klg0m/
	1E2G2Vv/NehGexApCd6bzJDQffnBzifr2ER1PutaILL2tncJmGNzURIUDzHVp9hI47/G
	IBDn8L7W1Uepc0chvcSUBp7sk8WCW8Sz7OA3iCe4JctTJSVVj9kiMxE01xk4eLRkMLgU
	Yf3TzLrPz7HVDg94rdIgyA/TwNlslIa1xqj7gO6cpxIqZCupgpfdn3N4bUgyP0PEgfTh
	j6kmf/y3jqkps5CNO0d+c7m5e4/VSXb0Ojasg5jLaJd9oAIA2rGYtbcCdyyn6HrC/yC+
	28iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=+Bt5u3p9OmkevFpDbjNKaRc8K7DvxXzca49NUxWOsjY=;
	b=UiCVWxssV0xqewQLTRoAKcl1IbfAY52dVKdwFoYenjkvBEFfZMo5q669Hje7JqVqth
	mmXN2AaeKsG3grmdmHjzBBOCGu1SPhmixTyozgcC0kH4kCEpRo1agwtJhLzbQlJcROE0
	XWx7nHeKKVcbcZyCXz6o6z8vNIm40ZHlbSc1a8nhSNLiNjiZNxxxfHvpN2xK4J/47i8y
	eVO+TNrMOcnrtpCLhcxJiVk7B2n33+IPou6y4nEO3w4oxV338/jMDi7gfU4DsW2B6hsx
	GAcVU0midfudEBE917PagKwXfLAN691KE9lrF/EAEN27KAp2qteu2BItR7cUdMkC/++j
	1vag==
X-Gm-Message-State: AOPr4FUteZjQ5dJJlnAqhF6VbvhzlfUW+lvkBrMxJwJP7AdM72i3GHUAW1WgcxetwsI1/w==
X-Received: by 10.66.155.38 with SMTP id vt6mr4361525pab.157.1462045257091;
	Sat, 30 Apr 2016 12:40:57 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id h5sm40348516pat.0.2016.04.30.12.40.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:40:55 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:40:50 -0700
Message-Id: <cover.1462040905.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC master][PATCH 0/4] Convert bitbake-layers to plugin-based
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
X-List-Received-Date: Sat, 30 Apr 2016 19:40:57 -0000

From: Christopher Larson <chris_larson@mentor.com>

This alters the bitbake-layers tool to use plugins for its sub-commands,
following the same pattern as devtool and recipetool.
`<bitbake>/lib/bblayers/` holds the default plugins, and layers can provide
their own in `<layerdir>/lib/bblayers/`.

A few minor enhancements were made to the plugin loading function after
pulling it in from scriptutils.


Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 309f5907a3661821e041ed14645b5d165007b058:

  bitbake: Switch to post release version (2016-04-29 07:41:34 +0100)

are available in the git repository at:

  https://github.com/kergoth/bitbake bitbake-layers-plugins
  https://github.com/kergoth/bitbake/tree/bitbake-layers-plugins

Christopher Larson (4):
  bb.utils: add load_plugins from scriptutils
  bb.utils: use imp.get_suffixes for load_plugins
  bb.utils: let loaded plugins provide a plugin object
  bitbake-layers: convert to plugin-based

 bin/bitbake-layers                 | 1065 ++----------------------------------
 bitbake/lib/bblayers/__init__.py   |    2 +
 bitbake/lib/bblayers/action.py     |  233 ++++++++
 bitbake/lib/bblayers/common.py     |   33 ++
 bitbake/lib/bblayers/layerindex.py |  270 +++++++++
 bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
 lib/bb/utils.py                    |   31 ++
 7 files changed, 1128 insertions(+), 1005 deletions(-)
 create mode 100644 bitbake/lib/bblayers/__init__.py
 create mode 100644 bitbake/lib/bblayers/action.py
 create mode 100644 bitbake/lib/bblayers/common.py
 create mode 100644 bitbake/lib/bblayers/layerindex.py
 create mode 100644 bitbake/lib/bblayers/query.py

-- 
2.8.0


