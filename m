Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 28AD47FCB7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2020 10:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 537D39C01C4;
	Mon, 20 Jan 2020 05:27:48 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id cvp7li1Sf5Cn; Mon, 20 Jan 2020 05:27:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E712E9C01CA;
	Mon, 20 Jan 2020 05:27:43 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id n5hTDic-ZTfS; Mon, 20 Jan 2020 05:27:43 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E8FF89C01C4;
	Mon, 20 Jan 2020 05:27:42 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jan 2020 11:27:08 +0100
Message-Id: <20200120102720.20868-1-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v5 00/12] NPM refactoring
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
X-List-Received-Date: Mon, 20 Jan 2020 10:27:47 -0000
Content-Transfer-Encoding: quoted-printable

Hi folks and happy new year,

These patches are part of a set which are mainly in OE-core.
More infos can be found on the openembedded-core list.

For readability here is a link if you want the history of this patchset:
http://lists.openembedded.org/pipermail/openembedded-core/2019-December/2=
90298.html

--- V4

These patches can be found here:
https://github.com/savoirfairelinux/bitbake/tree/npm-refactoring-v4

 - As suggested by Richard, a new npmsw fetcher have been implemented to =
handle
   the npm dependencies. Now the fetch of the main package is separated f=
rom the
   fetch of its dependencies.

 - Add the support of "proxy" fetchers. These fetchers (npm and npmsw) ju=
st
   resolves an url and forwards it to a "raw" fetcher (wget, git, ...).
   For example an npm url like:
     npm://registry...;package=3D...;version=3D...
   is converted as:
     https://registry.../...tgz;downloadfilename=3Dnpm2/...tgz;sha256sum=3D=
...

 - Add more hash functions for checksum verification to be able to suppor=
t the
   subresource integrity [1] returned by the npm registry. The supported =
hash
   functions are now: md5, sha1, sha256, sha384, sah512

 - More tests have been added for the npm and the npmsw fetchers includin=
g tests
   for the proxy forwarding thing (checksum, mirrors).

1: https://www.w3.org/TR/SRI/

--- V5

These patches can be found here:
https://github.com/savoirfairelinux/bitbake/tree/npm-refactoring-v5

 - As suggested by Christopher, the fetchers now use the shlex.quote() fu=
nction
   to handle arguments to shell function.

Jean-Marie LEMETAYER (12):
  bitbake: utils: add sha384_file and sha512_file functions
  bitbake: utils: add is_semver function
  bitbake: fetch2: refactor checksum verification
  bitbake: fetch2: add more hash functions for checksum verification
  bitbake: fetch2: allow fetchers to forward the donestamp management
  bitbake: fetch2: allow fetchers to forward the mirrors management
  bitbake: fetch2: allow fetchers to forward the done condition
  bitbake: fetch2/wget: fix downloadfilename parameter
  bitbake: fetch2/npm: refactor the npm fetcher
  bitbake: tests/fetch: add npm tests
  bitbake: fetch2: add the npmsw fetcher
  bitbake: tests/fetch: add npmsw tests

 lib/bb/fetch2/__init__.py | 215 +++++++++------
 lib/bb/fetch2/npm.py      | 538 +++++++++++++++++++-------------------
 lib/bb/fetch2/npmsw.py    | 255 ++++++++++++++++++
 lib/bb/fetch2/wget.py     |   7 +-
 lib/bb/tests/fetch.py     | 434 ++++++++++++++++++++++++++++++
 lib/bb/utils.py           |  40 +++
 6 files changed, 1129 insertions(+), 360 deletions(-)
 create mode 100644 lib/bb/fetch2/npmsw.py

--
2.20.1


