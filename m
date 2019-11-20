Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 92DD17F87C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2019 09:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CC5A89C0410;
	Wed, 20 Nov 2019 04:34:34 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 9J7QC5LxlQ6X; Wed, 20 Nov 2019 04:34:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2A5809C0407;
	Wed, 20 Nov 2019 04:34:34 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id DyX9pC1m_Aih; Wed, 20 Nov 2019 04:34:34 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5B3439C03AF;
	Wed, 20 Nov 2019 04:34:33 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Nov 2019 10:34:05 +0100
Message-Id: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v3 0/7] NPM refactoring
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
X-List-Received-Date: Wed, 20 Nov 2019 09:34:34 -0000
Content-Transfer-Encoding: quoted-printable

These patches are part of a set which are mainly in OE-core.

More infos can be found on the openembedded-core list.

--- V2

 - Add the 'check_network_access' function before each network access to =
check
   for 'BB_NO_NETWORK' and 'BB_ALLOWED_NETWORKS' variables.

 - Add a 'bb.tests.fetch.NPMTest' test suite for 'bitbake-selftest' to te=
st the
   npm fetcher. Here is the list of the new test cases:
     - bb.tests.fetch.NPMTest.test_npm
     - bb.tests.fetch.NPMTest.test_npm_name_invalid
     - bb.tests.fetch.NPMTest.test_npm_name_none
     - bb.tests.fetch.NPMTest.test_npm_registry_alternate
     - bb.tests.fetch.NPMTest.test_npm_registry_invalid
     - bb.tests.fetch.NPMTest.test_npm_registry_none
     - bb.tests.fetch.NPMTest.test_npm_version_invalid
     - bb.tests.fetch.NPMTest.test_npm_version_latest
     - bb.tests.fetch.NPMTest.test_npm_version_none

--- V3

 - Add two more tests regarding the BB_NO_NETWORK variable:
     - bb.tests.fetch.NPMTest.test_npm_no_network_no_tarball
     - bb.tests.fetch.NPMTest.test_npm_no_network_with_tarball

 - Restrict the version parameter to allow only semver versions and the '=
latest'
   tag (do not allow the npm range formats).

 - Split the commits for better understanding.

 - Add helper functions to handle dependency fetching and unpacking in th=
e
   npm.bbclass and the recipetool/create_npm.py files.

 - Remove the progress handler as it does not work well while fetching th=
e
   dependencies.

 - These patches can be found here:
     - https://github.com/savoirfairelinux/bitbake/tree/npm-refactoring-v=
3
     - https://github.com/savoirfairelinux/poky/tree/npm-refactoring-v3

Jean-Marie LEMETAYER (7):
  bitbake: utils.py: add sha384_file and sha512_file functions
  fetch2/npm.py: refactor the npm fetcher
  fetch2/npm.py: restrict version parameter
  fetch2/npm.py: add utility functions to handle dependencies
  fetch2/npm.py: unpack the dependencies in a node_modules directory
  fetch2/npm.py: restrict the build to be offline
  tests/fetch.py: add npm tests

 lib/bb/fetch2/npm.py  | 576 +++++++++++++++++++++++-------------------
 lib/bb/tests/fetch.py | 103 ++++++++
 lib/bb/utils.py       |  24 ++
 3 files changed, 441 insertions(+), 262 deletions(-)

--
2.20.1


