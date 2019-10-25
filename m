Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 7B5997FA63
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 08:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3CC319C02D0;
	Fri, 25 Oct 2019 04:39:33 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 42SSw3qKlokW; Fri, 25 Oct 2019 04:39:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A895A9C02FE;
	Fri, 25 Oct 2019 04:39:32 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id lcmR9FObbZdR; Fri, 25 Oct 2019 04:39:32 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D20CE9C02D0;
	Fri, 25 Oct 2019 04:39:31 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Oct 2019 10:39:22 +0200
Message-Id: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [RFC][PATCH v2 0/3] NPM refactoring
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
X-List-Received-Date: Fri, 25 Oct 2019 08:39:32 -0000
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

Jean-Marie LEMETAYER (3):
  bitbake: utils.py: add sha384_file and sha512_file
  fetch2/npm.py: refactor the npm fetcher
  tests/fetch.py: add npm tests

 lib/bb/fetch2/npm.py  | 475 +++++++++++++++++++-----------------------
 lib/bb/tests/fetch.py |  82 ++++++++
 lib/bb/utils.py       |  24 +++
 3 files changed, 317 insertions(+), 264 deletions(-)

--
2.20.1


