Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BA84965E94
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Nov 2014 18:12:37 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 05 Nov 2014 10:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,321,1413270000"; d="scan'208";a="627137512"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.154])
	by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2014 10:09:51 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Nov 2014 12:10:26 -0600
Message-Id: <1415211029-25352-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCHv3 0/3] bitbake: Add support in fetcher for get new versions of packages in upstream
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
X-List-Received-Date: Wed, 05 Nov 2014 18:12:40 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This set of patches adds latest_versionstring method in fetch/wget and fetch/git to support get
new version of packages in upstream.

Adds unittest for fetch/wget and fetch/git for latest_versionstring method, these tests only fails
when minor version or none version of package is found.

Adds beautiful soup module that's provides support to fetch/wget latest_versionstring method to search
over sites new versions of packages.

Aníbal Limón (3):
  bitbake: bs4: Add beautifulsoup 4.3.2
  bitbake: fetch/git: Add latest_versionstring method
  bitbake: fetch/wget: Add latest_versionstring method

 lib/bb/fetch2/git.py                   |   38 +
 lib/bb/fetch2/wget.py                  |  239 +++++
 lib/bb/tests/fetch.py                  |   77 ++
 lib/bs4/AUTHORS.txt                    |   43 +
 lib/bs4/COPYING.txt                    |   26 +
 lib/bs4/NEWS.txt                       | 1066 +++++++++++++++++++
 lib/bs4/__init__.py                    |  406 +++++++
 lib/bs4/builder/__init__.py            |  321 ++++++
 lib/bs4/builder/_html5lib.py           |  285 +++++
 lib/bs4/builder/_htmlparser.py         |  258 +++++
 lib/bs4/builder/_lxml.py               |  233 ++++
 lib/bs4/dammit.py                      |  829 +++++++++++++++
 lib/bs4/diagnose.py                    |  204 ++++
 lib/bs4/element.py                     | 1611 ++++++++++++++++++++++++++++
 lib/bs4/testing.py                     |  592 +++++++++++
 lib/bs4/tests/__init__.py              |    1 +
 lib/bs4/tests/test_builder_registry.py |  141 +++
 lib/bs4/tests/test_docs.py             |   36 +
 lib/bs4/tests/test_html5lib.py         |   85 ++
 lib/bs4/tests/test_htmlparser.py       |   19 +
 lib/bs4/tests/test_lxml.py             |   91 ++
 lib/bs4/tests/test_soup.py             |  434 ++++++++
 lib/bs4/tests/test_tree.py             | 1829 ++++++++++++++++++++++++++++++++
 23 files changed, 8864 insertions(+)
 create mode 100644 lib/bs4/AUTHORS.txt
 create mode 100644 lib/bs4/COPYING.txt
 create mode 100644 lib/bs4/NEWS.txt
 create mode 100644 lib/bs4/__init__.py
 create mode 100644 lib/bs4/builder/__init__.py
 create mode 100644 lib/bs4/builder/_html5lib.py
 create mode 100644 lib/bs4/builder/_htmlparser.py
 create mode 100644 lib/bs4/builder/_lxml.py
 create mode 100644 lib/bs4/dammit.py
 create mode 100644 lib/bs4/diagnose.py
 create mode 100644 lib/bs4/element.py
 create mode 100644 lib/bs4/testing.py
 create mode 100644 lib/bs4/tests/__init__.py
 create mode 100644 lib/bs4/tests/test_builder_registry.py
 create mode 100644 lib/bs4/tests/test_docs.py
 create mode 100644 lib/bs4/tests/test_html5lib.py
 create mode 100644 lib/bs4/tests/test_htmlparser.py
 create mode 100644 lib/bs4/tests/test_lxml.py
 create mode 100644 lib/bs4/tests/test_soup.py
 create mode 100644 lib/bs4/tests/test_tree.py

-- 
1.9.1


