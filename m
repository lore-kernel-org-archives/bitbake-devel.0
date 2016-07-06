Return-Path: <elliot.smith@intel.com>
X-Greylist: delayed 22914 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 06 Jul 2016 17:22:35 UTC
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id 5F88D60119
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 17:22:35 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ACFD41251EA;
	Wed,  6 Jul 2016 17:22:34 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-21-3-36.us-west-2.compute.internal [10.21.3.36])
	by relay.mailchannels.net (Postfix) with ESMTPA id 08C961248F2;
	Wed,  6 Jul 2016 17:22:33 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 17:22:34 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467825754320:1771088430
X-MC-Ingress-Time: 1467825754319
Received: from [176.251.41.101] (port=34400 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKqZb-0000c8-2u; Wed, 06 Jul 2016 13:25:19 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 18:22:22 +0100
Message-Id: <cover.1467825407.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH 0/4] add link to delete imported layer
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
X-List-Received-Date: Wed, 06 Jul 2016 17:22:36 -0000

On the layer details page, add a link which enables an imported layer to be
deleted.

The following changes since commit 7fad9160ca998496af82747fc7fe69d0f5886e94:

  buildinfohelper: ensure task datetimes are timezone-aware (2016-07-06 10:51:46 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/michaelw/toaster/layerdetails-save-rev-del
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/michaelw/toaster/layerdetails-save-rev-del

Michael Wood (4):
  toaster: layerdetails api Fix saving of git revision of a layer
  toaster: api Add util function for returning the error response
  toaster: add Layer delete front end feature to layerdetails
  toaster: tests Add selenium test for layerdetails page

 .../tests/browser/test_layerdetails_page.py        | 190 +++++++++++++++++++++
 lib/toaster/toastergui/api.py                      | 121 +++++++++++--
 lib/toaster/toastergui/static/js/layerdetails.js   |  20 +++
 lib/toaster/toastergui/static/js/projectpage.js    |  18 ++
 lib/toaster/toastergui/templates/layerdetails.html |  20 ++-
 lib/toaster/toastergui/urls.py                     |   5 +-
 lib/toaster/toastergui/views.py                    |  43 -----
 7 files changed, 362 insertions(+), 55 deletions(-)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_layerdetails_page.py

--
2.7.4


