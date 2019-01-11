Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4EA017C185;
	Fri, 11 Jan 2019 20:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id D976D18580;
	Fri, 11 Jan 2019 21:39:55 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id t6JOXW1sjtdc; Fri, 11 Jan 2019 21:39:54 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 0CF16182B3;
	Fri, 11 Jan 2019 21:39:54 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F05941A095;
	Fri, 11 Jan 2019 21:39:53 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB09A1A094;
	Fri, 11 Jan 2019 21:39:53 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Fri, 11 Jan 2019 21:39:53 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by thoth.se.axis.com (Postfix) with ESMTP id CF023247E;
	Fri, 11 Jan 2019 21:39:53 +0100 (CET)
Received: from xbox12.axis.com (10.0.5.26) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Fri, 11 Jan 2019 21:39:53 +0100
Received: from XBOX04.axis.com (10.0.5.18) by xbox12.axis.com (10.0.5.26) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Fri, 11 Jan 2019 21:39:53 +0100
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Fri, 11 Jan 2019 21:39:53 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Joshua Watt <jpewhacker@gmail.com>, Jacob Kroon <jacob.kroon@gmail.com>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [OE-core][PATCH v7 3/3] sstate: Implement hash
	equivalence sstate
Thread-Index: AQHUpxuzxnOh0rMji0qLx2VZP0GqQKWnHUaAgANvBpA=
Date: Fri, 11 Jan 2019 20:39:53 +0000
Message-ID: <ae964dc787d041459073dd050d9978b1@XBOX04.axis.com>
References: <20190104024217.3316-1-JPEWhacker@gmail.com>
	<20190104162015.456-1-JPEWhacker@gmail.com>
	<20190104162015.456-4-JPEWhacker@gmail.com>
	<6a611fb4-c0a6-dfa8-6bea-83cd2fa82ffd@gmail.com>
	<4cb097db5f1dc0cb1df7375cce6c03b31b34b3ff.camel@gmail.com>
In-Reply-To: <4cb097db5f1dc0cb1df7375cce6c03b31b34b3ff.camel@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [OE-core][PATCH v7 3/3] sstate: Implement hash equivalence sstate
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
X-List-Received-Date: Fri, 11 Jan 2019 20:39:55 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Joshua Watt
> Sent: den 9 januari 2019 18:10
> To: Jacob Kroon <jacob.kroon@gmail.com>; openembedded-
> core@lists.openembedded.org; bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [OE-core][PATCH v7 3/3] sstate: Implement
> hash equivalence sstate
>=20
> On Tue, 2019-01-08 at 07:29 +0100, Jacob Kroon wrote:
> > On 1/4/19 5:20 PM, Joshua Watt wrote:
> > > Converts sstate so that it can use a hash equivalence server to
> > > determine if a task really needs to be rebuilt, or if it can be
> > > restored
> > > from a different (equivalent) sstate object.
> > >
> > > The unique hashes are cached persistently using persist_data. This
> > > has
> > > a number of advantages:
> > >   1) Unique hashes can be cached between invocations of bitbake to
> > >      prevent needing to contact the server every time (which is
> > > slow)
> > >   2) The value of each tasks unique hash can easily be synchronized
> > >      between different threads, which will be useful if bitbake is
> > >      updated to do on the fly task re-hashing.
> > >
> > > [YOCTO #13030]
> > >
> > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > ---
> > >   meta/classes/sstate.bbclass | 105 +++++++++++++++++++++--
> > >   meta/conf/bitbake.conf      |   4 +-
> > >   meta/lib/oe/sstatesig.py    | 167
> > > ++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 267 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/meta/classes/sstate.bbclass
> > > b/meta/classes/sstate.bbclass
> > > index 59ebc3ab5cc..da0807d6e99 100644
> > > --- a/meta/classes/sstate.bbclass
> > > +++ b/meta/classes/sstate.bbclass
> > > @@ -11,7 +11,7 @@ def generate_sstatefn(spec, hash, d):
> > >   SSTATE_PKGARCH    =3D "${PACKAGE_ARCH}"
> > >   SSTATE_PKGSPEC    =3D
> > > "sstate:${PN}:${PACKAGE_ARCH}${TARGET_VENDOR}-
> > > ${TARGET_OS}:${PV}:${PR}:${SSTATE_PKGARCH}:${SSTATE_VERSION}:"
> > >   SSTATE_SWSPEC     =3D
> > > "sstate:${PN}::${PV}:${PR}::${SSTATE_VERSION}:"
> > > -SSTATE_PKGNAME    =3D "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.get
> > > Var('SSTATE_PKGSPEC'), d.getVar('BB_TASKHASH'), d)}"
> > > +SSTATE_PKGNAME    =3D "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.get
> > > Var('SSTATE_PKGSPEC'), d.getVar('BB_UNIHASH'), d)}"
> > >   SSTATE_PKG        =3D "${SSTATE_DIR}/${SSTATE_PKGNAME}"
> > >   SSTATE_EXTRAPATH   =3D ""
> > >   SSTATE_EXTRAPATHWILDCARD =3D ""
> > > @@ -82,6 +82,23 @@ SSTATE_SIG_PASSPHRASE ?=3D ""
> > >   # Whether to verify the GnUPG signatures when extracting sstate
> > > archives
> > >   SSTATE_VERIFY_SIG ?=3D "0"
> > >
> > > +SSTATE_HASHEQUIV_METHOD ?=3D "OEOuthashBasic"
> > > +SSTATE_HASHEQUIV_METHOD[doc] =3D "The function used to calculate the
> > > output hash \
> > > +    for a task, which in turn is used to determine equivalency. \
> > > +    "
> > > +
> > > +SSTATE_HASHEQUIV_SERVER ?=3D ""
> > > +SSTATE_HASHEQUIV_SERVER[doc] =3D "The hash equivalence sever. For
> > > example, \
> > > +    'http://192.168.0.1:5000'. Do not include a trailing slash \
> > > +    "
> > > +
> > > +SSTATE_HASHEQUIV_REPORT_TASKDATA ?=3D "0"
> > > +SSTATE_HASHEQUIV_REPORT_TASKDATA[doc] =3D "Report additional useful
> > > data to the \
> > > +    hash equivalency server, such as PN, PV, taskname, etc. This
> > > information \
> > > +    is very useful for developers looking at task data, but may
> > > leak sensitive \
> > > +    data if the equivalence server is public. \
> > > +    "
> > > +
> > >   python () {
> > >       if bb.data.inherits_class('native', d):
> > >           d.setVar('SSTATE_PKGARCH', d.getVar('BUILD_ARCH', False))
> > > @@ -640,7 +657,7 @@ def sstate_package(ss, d):
> > >           return
> > >
> > >       for f in (d.getVar('SSTATECREATEFUNCS') or '').split() + \
> > > -             ['sstate_create_package', 'sstate_sign_package'] + \
> > > +             ['sstate_report_unihash', 'sstate_create_package',
> > > 'sstate_sign_package'] + \
> > >                (d.getVar('SSTATEPOSTCREATEFUNCS') or '').split():
> > >           # All hooks should run in SSTATE_BUILDDIR.
> > >           bb.build.exec_func(f, d, (sstatebuild,))
> > > @@ -764,6 +781,73 @@ python sstate_sign_package () {
> > >                              d.getVar('SSTATE_SIG_PASSPHRASE'),
> > > armor=3DFalse)
> > >   }
> > >
> > > +def OEOuthashBasic(path, sigfile, task, d):
> > > +    import hashlib
> > > +    import stat
> > > +
> > > +    def update_hash(s):
> > > +        s =3D s.encode('utf-8')
> > > +        h.update(s)
> > > +        if sigfile:
> > > +            sigfile.write(s)
> > > +
> > > +    h =3D hashlib.sha256()
> > > +    prev_dir =3D os.getcwd()
> > > +
> > > +    try:
> > > +        os.chdir(path)
> > > +
> > > +        update_hash("OEOuthashBasic\n")
> > > +
> > > +        # It is only currently useful to get equivalent hashes for
> > > things that
> > > +        # can be restored from sstate. Since the sstate object is
> > > named using
> > > +        # SSTATE_PKGSPEC and the task name, those should be
> > > included in the
> > > +        # output hash calculation.
> > > +        update_hash("SSTATE_PKGSPEC=3D%s\n" %
> > > d.getVar('SSTATE_PKGSPEC'))
> > > +        update_hash("task=3D%s\n" % task)
> > > +
> > > +        for root, dirs, files in os.walk('.', topdown=3DTrue):
> > > +            # Sort directories and files to ensure consistent
> > > ordering
> > > +            dirs.sort()
> > > +            files.sort()
> > > +
> > > +            for f in files:
> > > +                path =3D os.path.join(root, f)
> > > +                s =3D os.lstat(path)
> > > +
> > > +                # Hash file path
> > > +                update_hash(path + '\n')
> > > +
> > > +                # Hash file mode
> > > +                update_hash("\tmode=3D0x%x\n" %
> > > stat.S_IMODE(s.st_mode))
> > > +                update_hash("\ttype=3D0x%x\n" %
> > > stat.S_IFMT(s.st_mode))
> > > +
> > > +                if stat.S_ISBLK(s.st_mode) or
> > > stat.S_ISBLK(s.st_mode):
> > > +                    # Hash device major and minor
> > > +                    update_hash("\tdev=3D%d,%d\n" %
> > > (os.major(s.st_rdev), os.minor(s.st_rdev)))
> > > +                elif stat.S_ISLNK(s.st_mode):
> > > +                    # Hash symbolic link
> > > +                    update_hash("\tsymlink=3D%s\n" %
> > > os.readlink(path))
> > > +                else:
> > > +                    fh =3D hashlib.sha256()
> > > +                    # Hash file contents
> > > +                    with open(path, 'rb') as d:
> > > +                        for chunk in iter(lambda: d.read(4096),
> > > b""):
> > > +                            fh.update(chunk)
> > > +                    update_hash("\tdigest=3D%s\n" % fh.hexdigest())
> >
> > Would it be a good idea to make the depsig.do_* files even more
> > human
> > readable, considering that they could be candidates for being stored
> > in
> > buildhistory ?
> >
> > As an example, here's what buildhistory/.../files-in-package.txt for
> > busybox looks like:
> >
> > drwxr-xr-x root       root             4096 ./bin
> > lrwxrwxrwx root       root               14 ./bin/busybox ->
> > busybox.nosuid
> > -rwxr-xr-x root       root           547292 ./bin/busybox.nosuid
> > -rwsr-xr-x root       root            50860 ./bin/busybox.suid
> > lrwxrwxrwx root       root               14 ./bin/sh ->
> > busybox.nosuid
> > drwxr-xr-x root       root             4096 ./etc
> > -rw-r--r-- root       root             2339
> > ./etc/busybox.links.nosuid
> > -rw-r--r-- root       root               91 ./etc/busybox.links.suid
> >
>=20
> I went through the effort to try this, and I'm pretty happy with the
> results except for one important distinction: It's not reproducible in
> all cases because of the inclusion of the owner UID/GID (I used the
> decimal user and group IDs to prevent the dependency on the names).
>=20
> For any task running under fakeroot (pesudo), this works like you would
> expect. However, for tasks not running under fakeroot (and possibly
> others that copy files from tasks not running under fakeroot?), the
> files are owned by the user that is running bitbake (e.g. You). This
> makes the output hashes not shareable between different developers.
>=20
> I'm not sure what the best way to address this is; The UID and GID are
> an important part of the reproducibility and *should* be included in
> the output hash when relevant, but I don't know yet how to determine if
> they are relevant. I'm going to dig in and see if I can use "the
> current task is running under fakeroot" as that distinction. If anyone
> has any other ideas please chime in.

You should probably not rely on UID/GID to be stable for target. That=20
is only the case if you have configured the build to use static IDs,=20
otherwise they are dynamically assigned and may vary between builds.=20
The user and group names should be stable though.

//Peter


