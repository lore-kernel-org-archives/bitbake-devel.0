Return-Path: <peter.marko@siemens.com>
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by mail.openembedded.org (Postfix) with ESMTP id 1232F7455D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Oct 2018 10:35:02 +0000 (UTC)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w9AAZ3fE024628
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Oct 2018 12:35:03 +0200
Received: from dev-6.vm6.ccp.siemens.com ([163.242.52.226])
	by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w9AAZ2Sv015628;
	Wed, 10 Oct 2018 12:35:02 +0200
Received: from dev-6.vm6.ccp.siemens.com (localhost [127.0.0.1])
	by dev-6.vm6.ccp.siemens.com (Postfix) with ESMTP id E5FF29550DC;
	Wed, 10 Oct 2018 12:35:01 +0200 (CEST)
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Oct 2018 12:34:39 +0200
Message-Id: <20181010103440.14201-1-peter.marko@siemens.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 0/1] fetch2: avoid circular recursion with SRCPV in PR
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
X-List-Received-Date: Wed, 10 Oct 2018 10:35:03 -0000

This change introduces fix for circular dependency if SRCPV is in PR.

Although it's maybe not a common to use SRCPV in PR instead of PV,
nothing prevented it in previous releases.
PR is part of overall version string and we have special handling of
PV string of custom recipes, thus we add all the "extra info" in PR.
When migrating from poky-pyro to latest master, this error occurred.
Please consider also this non-standard use-case.

Peter Marko (1):
  fetch2: avoid circular recursion with SRCPV in PR

 lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.11.0


