Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web09.32411.1612179954059778543
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id E9A135BB4; Mon,  1 Feb 2021 11:45:51 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 0/8] hashserv read-only mode & upstream fixes
Date: Mon,  1 Feb 2021 11:45:43 +0000
Message-Id: <20210201114551.11475-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Implement a read-only mode for the hash equivalence server. This mode i=
s
  useful when you wish to populate a hash equivalence database from CI or=
 other
  internal builds (via a read-write server instance) and also allow exter=
nal
  clients to query this database (via a read-only server instance). Exter=
nal
  clients can therefore be prevented from adding hash equivalences to the
  server which correspond to sstate artifacts which would be missing in a
  primary sstate cache. This mode is enabled using the -r/--read-only
  argument to bitbake-hashserv.

* Expose the existing upstream server support via a -u/--upstream argumen=
t to
  bitbake-hashserv.

* Support querying an upstream server using the new `get-outhash` message=
 when
  the server handles a `report` message from a client and a match is not =
found
  in the server's own database. This is important as the `report` message=
 is
  used by bitbake when a task finishes executing to check if the task out=
hash
  matches the outhash for any previous execution. With this support such
  matches can now be found in a local (read-write) hash equivalence db as
  well as in an upstream (potentially read-only and/or remote) db.

* Other minor hashserv fixes.

These changes have been tested locally using the following setup:

1) Build core-image-base with BB_HASHSERVE =3D "auto". Additional logging=
 was
   also enabled following the instructions in=20
   https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user=
-manual-execution.html#logging.

2) Move the hashserv.db file into a new 'upstream-hashserv' directory. St=
art
   the upstream server in read-only mode using the following command in t=
hat
   directory:

    bitbake-hashserv -r -l DEBUG

3) Create an empty 'downstream-hashserv' directory. Start the downstream
   (local) server with an empty db using the following command in that
   directory:

    bitbake-hashserv -u "unix://../upstream-hashserv/hashserve.sock" -l D=
EBUG

4) Modify local.conf to set=20
   BB_HASHSERVE =3D "unix://${TOPDIR}/downstream-hashserv/hashserve.sock"=
.

5) Add an 'echo hello' command to do_configure for glibc to force a rebui=
ld
   which should result in a matching hash equivalence.

6) Build core-image-base again, confirm that glibc is rebuilt but then a =
hash
   equivalence is found (copied from the upstream server into the downstr=
eam
   server) and dependent tasks are pulled from the sstate cache instead o=
f
   being rebuilt.

This is an RFC series as it still needs documentation to be written and
selftest cases to be added. However it'd be great to get some feedback at
this stage before moving on to that work.

These changes can also be pulled from:

  https://gitlab.com/pbarker.dev/staging/bitbake.git
  tag: hashserv_2020-02-01

Let me know if you have any questions/feedback :)

Paul Barker (8):
  bitbake-hashclient: Remove obsolete call to client.connect
  hashserv: client: Fix handling of null responses
  hashserv: server: Fix logger.debug calls
  hashserv: Support read-only server
  hashserv: Support upstream command line argument
  hashserv: Add short forms of remaining command line arguments
  hashserv: Add get-outhash message
  hashserv: server: Support searching upstream for outhash

 bin/bitbake-hashclient   |  3 --
 bin/bitbake-hashserv     | 10 +++--
 lib/hashserv/__init__.py |  4 +-
 lib/hashserv/client.py   |  8 +++-
 lib/hashserv/server.py   | 85 ++++++++++++++++++++++++++++++++++------
 5 files changed, 88 insertions(+), 22 deletions(-)

--=20
2.26.2

