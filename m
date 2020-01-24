Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 52C997FDEA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 17:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8FAEB9C02BE;
	Fri, 24 Jan 2020 12:08:21 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id r_gK4ohQxdbN; Fri, 24 Jan 2020 12:08:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B0C269C02E8;
	Fri, 24 Jan 2020 12:08:20 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id bYg6HHPsHJfY; Fri, 24 Jan 2020 12:08:20 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 97C599C02BE;
	Fri, 24 Jan 2020 12:08:19 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2020 18:08:02 +0100
Message-Id: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, rennes-dev@savoirfairelinux.com
Subject: [PATCH v6 00/12] NPM refactoring
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
X-List-Received-Date: Fri, 24 Jan 2020 17:08:20 -0000
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

--- V6

These patches can be found here:
https://github.com/savoirfairelinux/bitbake/tree/npm-refactoring-v6

 - Fix an issue in the "refactor checsum verification" patch:
   I forgot to fire the MissingChecksumEvent as it was done before.
   This should fix the "md5sum" errors seen on the CI.

 - As suggested by Peter, I remove the "bitbake: " prefix on the patches.

Jean-Marie LEMETAYER (12):
  utils: add sha384_file and sha512_file functions
  utils: add is_semver function
  fetch2: refactor checksum verification
  fetch2: add more hash functions for checksum verification
  fetch2: allow fetchers to forward the donestamp management
  fetch2: allow fetchers to forward the mirrors management
  fetch2: allow fetchers to forward the done condition
  fetch2/wget: fix downloadfilename parameter
  fetch2/npm: refactor the npm fetcher
  tests/fetch: add npm tests
  fetch2: add the npmsw fetcher
  tests/fetch: add npmsw tests

 lib/bb/fetch2/__init__.py | 218 +++++++++------
 lib/bb/fetch2/npm.py      | 538 +++++++++++++++++++-------------------
 lib/bb/fetch2/npmsw.py    | 255 ++++++++++++++++++
 lib/bb/fetch2/wget.py     |   7 +-
 lib/bb/tests/fetch.py     | 434 ++++++++++++++++++++++++++++++
 lib/bb/utils.py           |  40 +++
 6 files changed, 1131 insertions(+), 361 deletions(-)
 create mode 100644 lib/bb/fetch2/npmsw.py

--
2.20.1


