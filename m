Return-Path: <elliot.smith@intel.com>
X-Greylist: delayed 156261 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 06 Jul 2016 10:59:22 UTC
Received: from gainsboro.cherry.relay.mailchannels.net
	(gainsboro.cherry.relay.mailchannels.net [23.83.223.65])
	by mail.openembedded.org (Postfix) with ESMTP id D5DBE6013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 10:59:21 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0EF7D1270F8;
	Wed,  6 Jul 2016 10:59:15 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-21-3-36.us-west-2.compute.internal [10.21.3.36])
	by relay.mailchannels.net (Postfix) with ESMTPA id 6E308123C1A;
	Wed,  6 Jul 2016 10:59:14 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 10:59:14 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802754756:3271362506
X-MC-Ingress-Time: 1467802754756
Received: from [176.251.41.101] (port=50290 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkad-0006Ud-2o; Wed, 06 Jul 2016 07:01:59 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 11:58:58 +0100
Message-Id: <cover.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH 0/7] fixes for toaster-eventreplay
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
X-List-Received-Date: Wed, 06 Jul 2016 10:59:26 -0000

Fix the Toaster event replay script so that it is able to run dumped
bitbake event JSON files.

For testing instructions, see
https://lists.yoctoproject.org/pipermail/toaster/2016-June/004875.html

The following changes since commit 025a2de5d67e491208fb7e76996ee0293d6fcf07
(toaster-next):

  toaster: views Fix most frequently built target in project reporting (2016-07-04 13:37:28 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/ed/toaster/eventplay-9585
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/ed/toaster/eventplay-9585

Ed Bartosh (6):
  eventreplay: add MockConnection.getEventHandle method
  eventprelay: implement setEventMask command
  eventreplay: fix event loading code
  eventreplay: replace MockConfigParameters with namedtuple
  eventreplay: reorganize imports
  eventreplay: rewrite the script

Elliot Smith (1):
  buildinfohelper: ensure task datetimes are timezone-aware

 bin/toaster-eventreplay      | 220 +++++++++++++++++--------------------------
 lib/bb/ui/buildinfohelper.py |   2 +-
 2 files changed, 87 insertions(+), 135 deletions(-)

--
2.7.4


