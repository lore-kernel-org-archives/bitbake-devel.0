Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 025AC733CD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:14 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724285"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:13 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:07 -0600
Message-Id: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 0/7] fetch2: wget latest_versionstring improvments
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
X-List-Received-Date: Fri, 13 Feb 2015 21:58:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The next set of changes contains:

    - Add support for scan every version directory with _check_latest_version
      instead of get latest version directory, this add makes code more robust
      because sometimes upstream sites publish version directory without files
      causing to don't find upstream version.
      
    - Modelate version improvments for version comparision when version contains
      alpha, beta, rc.

    - Bugfixes and cleanup.

    - Update testing.

Changes can be reviewed at:
    http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=alimon/bitbake-fetch-wget-latest_versionstring

Aníbal Limón (7):
  fetch2: wget latest_versionstring improve _parse_path
  fetch2: wget latest_versionstring _check_latest_version improvments
  fetch2: wget add _check_latest_version_by_dir
  fetch2: wget latest_versionstring improvments in get version by dir
  fetch2: wget _modelate_version improvments
  fetch2: wget remove scape of - in regexes don't needed
  tests/fetch.py: latest_versionstring add set of PN

 lib/bb/fetch2/wget.py | 247 ++++++++++++++++++++++++++------------------------
 lib/bb/tests/fetch.py |   2 +
 2 files changed, 130 insertions(+), 119 deletions(-)

-- 
1.9.1


