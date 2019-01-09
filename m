Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com
	[209.85.166.180])
	by mail.openembedded.org (Postfix) with ESMTP id D54DC6BDC8;
	Wed,  9 Jan 2019 17:09:50 +0000 (UTC)
Received: by mail-it1-f180.google.com with SMTP id g85so12731142ita.3;
	Wed, 09 Jan 2019 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=oWhtVWhrPBosHkpJrllyqnM9Cfb5xUeOf9ixaOPCeDI=;
	b=gj3QGxbbk/QBoILrQXUU+6baVkFTtBxNQVTqF8Zr7+YNEK9uVxEv4upLZrO561wxwS
	0GVaAU9yyhhwLc27GDlRmZlWwPrj5At9OhrAW5Xsfg2WOSdYylngMERN/t6MwppKJyCC
	TRl3AnCgs5aYv/OuUeElNlwqX9E4wogEn7o57Y9a8lcml6Qnds5rBc1GyZwoUhC52xG4
	8cL9L7WI2TNtZ3/hyyJEPjOk3vcrw6vSVNOGM8UlKbsQT+TUqvmpZWzmaRUZ1Avc7JcS
	sGTgsrZfcyH8Qa6tOHl92Kk0v7xCeMuRDY3siH2bb8V6a639s9c6E/BCT92uaF0tvqst
	m5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=oWhtVWhrPBosHkpJrllyqnM9Cfb5xUeOf9ixaOPCeDI=;
	b=aE0NK9b+hH31y1M/As0tMYHoL+tSOfCgSm6TSAHcGIIvNiyHQhcc15/jhYDZmXW1AT
	E6mfy+xBFUxnQxQvjfr5RCUW3Ubxfq7nllq2PeUVDZqh3M/7OirhekD17gQnmY0nqA/0
	s/HAmv9GqG9t1i3k3ZYAZGmrwz0ObyVasziYkhg4I3DxFXVIlxSH/IFL/LEiccTc0RoA
	93OOR5CYl4DuMSOylgObjUCEDC1Xlw7Ix1wpgzkBOMA+DwC7rq2h/qumNinJtJTLLnTX
	CzNaCcly5tAFksmb/XIPmJF8aGIatAXdkpkBhrbuhPkfgvKimML9/UiOrkrAATzGsSB9
	kjsw==
X-Gm-Message-State: AJcUukeeK4pOVJQ+3ka+afz0J46IL/IX8fGrt/UKYUMEmgqDhC6jSc9V
	mN6q6cHl53MbRgp3KCgIQ20ZPvuW368=
X-Google-Smtp-Source: ALg8bN5JrAN7/2EqMD5QZ/L/IblXC3X2jb/ijh5lj0/nod0f6ppT6nxxf7fzOZIB52W2frQ+jLE0vg==
X-Received: by 2002:a24:3c3:: with SMTP id e186mr4256215ite.155.1547053791744; 
	Wed, 09 Jan 2019 09:09:51 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	e16sm33468551iob.43.2019.01.09.09.09.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 09 Jan 2019 09:09:50 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <4cb097db5f1dc0cb1df7375cce6c03b31b34b3ff.camel@gmail.com>
To: Jacob Kroon <jacob.kroon@gmail.com>, 
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 09 Jan 2019 11:09:49 -0600
In-Reply-To: <6a611fb4-c0a6-dfa8-6bea-83cd2fa82ffd@gmail.com>
References: <20190104024217.3316-1-JPEWhacker@gmail.com>
	<20190104162015.456-1-JPEWhacker@gmail.com>
	<20190104162015.456-4-JPEWhacker@gmail.com>
	<6a611fb4-c0a6-dfa8-6bea-83cd2fa82ffd@gmail.com>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
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
X-List-Received-Date: Wed, 09 Jan 2019 17:09:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-01-08 at 07:29 +0100, Jacob Kroon wrote:
> On 1/4/19 5:20 PM, Joshua Watt wrote:
> > Converts sstate so that it can use a hash equivalence server to
> > determine if a task really needs to be rebuilt, or if it can be
> > restored
> > from a different (equivalent) sstate object.
> > 
> > The unique hashes are cached persistently using persist_data. This
> > has
> > a number of advantages:
> >   1) Unique hashes can be cached between invocations of bitbake to
> >      prevent needing to contact the server every time (which is
> > slow)
> >   2) The value of each tasks unique hash can easily be synchronized
> >      between different threads, which will be useful if bitbake is
> >      updated to do on the fly task re-hashing.
> > 
> > [YOCTO #13030]
> > 
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >   meta/classes/sstate.bbclass | 105 +++++++++++++++++++++--
> >   meta/conf/bitbake.conf      |   4 +-
> >   meta/lib/oe/sstatesig.py    | 167
> > ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 267 insertions(+), 9 deletions(-)
> > 
> > diff --git a/meta/classes/sstate.bbclass
> > b/meta/classes/sstate.bbclass
> > index 59ebc3ab5cc..da0807d6e99 100644
> > --- a/meta/classes/sstate.bbclass
> > +++ b/meta/classes/sstate.bbclass
> > @@ -11,7 +11,7 @@ def generate_sstatefn(spec, hash, d):
> >   SSTATE_PKGARCH    = "${PACKAGE_ARCH}"
> >   SSTATE_PKGSPEC    =
> > "sstate:${PN}:${PACKAGE_ARCH}${TARGET_VENDOR}-
> > ${TARGET_OS}:${PV}:${PR}:${SSTATE_PKGARCH}:${SSTATE_VERSION}:"
> >   SSTATE_SWSPEC     =
> > "sstate:${PN}::${PV}:${PR}::${SSTATE_VERSION}:"
> > -SSTATE_PKGNAME    = "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.get
> > Var('SSTATE_PKGSPEC'), d.getVar('BB_TASKHASH'), d)}"
> > +SSTATE_PKGNAME    = "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.get
> > Var('SSTATE_PKGSPEC'), d.getVar('BB_UNIHASH'), d)}"
> >   SSTATE_PKG        = "${SSTATE_DIR}/${SSTATE_PKGNAME}"
> >   SSTATE_EXTRAPATH   = ""
> >   SSTATE_EXTRAPATHWILDCARD = ""
> > @@ -82,6 +82,23 @@ SSTATE_SIG_PASSPHRASE ?= ""
> >   # Whether to verify the GnUPG signatures when extracting sstate
> > archives
> >   SSTATE_VERIFY_SIG ?= "0"
> >   
> > +SSTATE_HASHEQUIV_METHOD ?= "OEOuthashBasic"
> > +SSTATE_HASHEQUIV_METHOD[doc] = "The function used to calculate the
> > output hash \
> > +    for a task, which in turn is used to determine equivalency. \
> > +    "
> > +
> > +SSTATE_HASHEQUIV_SERVER ?= ""
> > +SSTATE_HASHEQUIV_SERVER[doc] = "The hash equivalence sever. For
> > example, \
> > +    'http://192.168.0.1:5000'. Do not include a trailing slash \
> > +    "
> > +
> > +SSTATE_HASHEQUIV_REPORT_TASKDATA ?= "0"
> > +SSTATE_HASHEQUIV_REPORT_TASKDATA[doc] = "Report additional useful
> > data to the \
> > +    hash equivalency server, such as PN, PV, taskname, etc. This
> > information \
> > +    is very useful for developers looking at task data, but may
> > leak sensitive \
> > +    data if the equivalence server is public. \
> > +    "
> > +
> >   python () {
> >       if bb.data.inherits_class('native', d):
> >           d.setVar('SSTATE_PKGARCH', d.getVar('BUILD_ARCH', False))
> > @@ -640,7 +657,7 @@ def sstate_package(ss, d):
> >           return
> >   
> >       for f in (d.getVar('SSTATECREATEFUNCS') or '').split() + \
> > -             ['sstate_create_package', 'sstate_sign_package'] + \
> > +             ['sstate_report_unihash', 'sstate_create_package',
> > 'sstate_sign_package'] + \
> >                (d.getVar('SSTATEPOSTCREATEFUNCS') or '').split():
> >           # All hooks should run in SSTATE_BUILDDIR.
> >           bb.build.exec_func(f, d, (sstatebuild,))
> > @@ -764,6 +781,73 @@ python sstate_sign_package () {
> >                              d.getVar('SSTATE_SIG_PASSPHRASE'),
> > armor=False)
> >   }
> >   
> > +def OEOuthashBasic(path, sigfile, task, d):
> > +    import hashlib
> > +    import stat
> > +
> > +    def update_hash(s):
> > +        s = s.encode('utf-8')
> > +        h.update(s)
> > +        if sigfile:
> > +            sigfile.write(s)
> > +
> > +    h = hashlib.sha256()
> > +    prev_dir = os.getcwd()
> > +
> > +    try:
> > +        os.chdir(path)
> > +
> > +        update_hash("OEOuthashBasic\n")
> > +
> > +        # It is only currently useful to get equivalent hashes for
> > things that
> > +        # can be restored from sstate. Since the sstate object is
> > named using
> > +        # SSTATE_PKGSPEC and the task name, those should be
> > included in the
> > +        # output hash calculation.
> > +        update_hash("SSTATE_PKGSPEC=%s\n" %
> > d.getVar('SSTATE_PKGSPEC'))
> > +        update_hash("task=%s\n" % task)
> > +
> > +        for root, dirs, files in os.walk('.', topdown=True):
> > +            # Sort directories and files to ensure consistent
> > ordering
> > +            dirs.sort()
> > +            files.sort()
> > +
> > +            for f in files:
> > +                path = os.path.join(root, f)
> > +                s = os.lstat(path)
> > +
> > +                # Hash file path
> > +                update_hash(path + '\n')
> > +
> > +                # Hash file mode
> > +                update_hash("\tmode=0x%x\n" %
> > stat.S_IMODE(s.st_mode))
> > +                update_hash("\ttype=0x%x\n" %
> > stat.S_IFMT(s.st_mode))
> > +
> > +                if stat.S_ISBLK(s.st_mode) or
> > stat.S_ISBLK(s.st_mode):
> > +                    # Hash device major and minor
> > +                    update_hash("\tdev=%d,%d\n" %
> > (os.major(s.st_rdev), os.minor(s.st_rdev)))
> > +                elif stat.S_ISLNK(s.st_mode):
> > +                    # Hash symbolic link
> > +                    update_hash("\tsymlink=%s\n" %
> > os.readlink(path))
> > +                else:
> > +                    fh = hashlib.sha256()
> > +                    # Hash file contents
> > +                    with open(path, 'rb') as d:
> > +                        for chunk in iter(lambda: d.read(4096),
> > b""):
> > +                            fh.update(chunk)
> > +                    update_hash("\tdigest=%s\n" % fh.hexdigest())
> 
> Would it be a good idea to make the depsig.do_* files even more
> human 
> readable, considering that they could be candidates for being stored
> in 
> buildhistory ?
> 
> As an example, here's what buildhistory/.../files-in-package.txt for 
> busybox looks like:
> 
> drwxr-xr-x root       root             4096 ./bin
> lrwxrwxrwx root       root               14 ./bin/busybox ->
> busybox.nosuid
> -rwxr-xr-x root       root           547292 ./bin/busybox.nosuid
> -rwsr-xr-x root       root            50860 ./bin/busybox.suid
> lrwxrwxrwx root       root               14 ./bin/sh ->
> busybox.nosuid
> drwxr-xr-x root       root             4096 ./etc
> -rw-r--r-- root       root             2339
> ./etc/busybox.links.nosuid
> -rw-r--r-- root       root               91 ./etc/busybox.links.suid
> 

I went through the effort to try this, and I'm pretty happy with the
results except for one important distinction: It's not reproducible in
all cases because of the inclusion of the owner UID/GID (I used the
decimal user and group IDs to prevent the dependency on the names).

For any task running under fakeroot (pesudo), this works like you would
expect. However, for tasks not running under fakeroot (and possibly
others that copy files from tasks not running under fakeroot?), the
files are owned by the user that is running bitbake (e.g. You). This
makes the output hashes not shareable between different developers.

I'm not sure what the best way to address this is; The UID and GID are
an important part of the reproducibility and *should* be included in
the output hash when relevant, but I don't know yet how to determine if
they are relevant. I'm going to dig in and see if I can use "the
current task is running under fakeroot" as that distinction. If anyone
has any other ideas please chime in.



> > +    finally:
> > +        os.chdir(prev_dir)
> > +
> > +    return h.hexdigest()
> > +
> > +python sstate_report_unihash() {
> > +    report_unihash = getattr(bb.parse.siggen, 'report_unihash',
> > None)
> > +
> > +    if report_unihash:
> > +        ss = sstate_state_fromvars(d)
> > +        report_unihash(os.getcwd(), ss['task'], d)
> > +}
> > +
> >   #
> >   # Shell function to decompress and prepare a package for
> > installation
> >   # Will be run from within SSTATE_INSTDIR.
> > @@ -788,6 +872,11 @@ def sstate_checkhashes(sq_fn, sq_task,
> > sq_hash, sq_hashfn, d, siginfo=False, *,
> >       if siginfo:
> >           extension = extension + ".siginfo"
> >   
> > +    def gethash(task):
> > +        if sq_unihash is not None:
> > +            return sq_unihash[task]
> > +        return sq_hash[task]
> > +
> >       def getpathcomponents(task, d):
> >           # Magic data from BB_HASHFILENAME
> >           splithashfn = sq_hashfn[task].split(" ")
> > @@ -810,7 +899,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash,
> > sq_hashfn, d, siginfo=False, *,
> >   
> >           spec, extrapath, tname = getpathcomponents(task, d)
> >   
> > -        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath +
> > generate_sstatefn(spec, sq_hash[task], d) + "_" + tname +
> > extension)
> > +        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath +
> > generate_sstatefn(spec, gethash(task), d) + "_" + tname +
> > extension)
> >   
> >           if os.path.exists(sstatefile):
> >               bb.debug(2, "SState: Found valid sstate file %s" %
> > sstatefile)
> > @@ -872,7 +961,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash,
> > sq_hashfn, d, siginfo=False, *,
> >               if task in ret:
> >                   continue
> >               spec, extrapath, tname = getpathcomponents(task, d)
> > -            sstatefile = d.expand(extrapath +
> > generate_sstatefn(spec, sq_hash[task], d) + "_" + tname +
> > extension)
> > +            sstatefile = d.expand(extrapath +
> > generate_sstatefn(spec, gethash(task), d) + "_" + tname +
> > extension)
> >               tasklist.append((task, sstatefile))
> >   
> >           if tasklist:
> > @@ -898,12 +987,12 @@ def sstate_checkhashes(sq_fn, sq_task,
> > sq_hash, sq_hashfn, d, siginfo=False, *,
> >           evdata = {'missed': [], 'found': []};
> >           for task in missed:
> >               spec, extrapath, tname = getpathcomponents(task, d)
> > -            sstatefile = d.expand(extrapath +
> > generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + ".tgz")
> > -            evdata['missed'].append( (sq_fn[task], sq_task[task],
> > sq_hash[task], sstatefile ) )
> > +            sstatefile = d.expand(extrapath +
> > generate_sstatefn(spec, gethash(task), d) + "_" + tname + ".tgz")
> > +            evdata['missed'].append( (sq_fn[task], sq_task[task],
> > gethash(task), sstatefile ) )
> >           for task in ret:
> >               spec, extrapath, tname = getpathcomponents(task, d)
> > -            sstatefile = d.expand(extrapath +
> > generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + ".tgz")
> > -            evdata['found'].append( (sq_fn[task], sq_task[task],
> > sq_hash[task], sstatefile ) )
> > +            sstatefile = d.expand(extrapath +
> > generate_sstatefn(spec, gethash(task), d) + "_" + tname + ".tgz")
> > +            evdata['found'].append( (sq_fn[task], sq_task[task],
> > gethash(task), sstatefile ) )
> >           bb.event.fire(bb.event.MetadataEvent("MissedSstate",
> > evdata), d)
> >   
> >       # Print some summary statistics about the current task
> > completion and how much sstate
> > diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
> > index 64800623545..e64ce6a6dab 100644
> > --- a/meta/conf/bitbake.conf
> > +++ b/meta/conf/bitbake.conf
> > @@ -867,7 +867,9 @@ BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD
> > BB_TASKHASH BBPATH BBSERVER DL_DI
> >       STAMPS_DIR PRSERV_DUMPDIR PRSERV_DUMPFILE PRSERV_LOCKDOWN
> > PARALLEL_MAKE \
> >       CCACHE_DIR EXTERNAL_TOOLCHAIN CCACHE CCACHE_NOHASHDIR
> > LICENSE_PATH SDKPKGSUFFIX \
> >       WARN_QA ERROR_QA WORKDIR STAMPCLEAN PKGDATA_DIR BUILD_ARCH
> > SSTATE_PKGARCH \
> > -    BB_WORKERCONTEXT BB_LIMITEDDEPS extend_recipe_sysroot
> > DEPLOY_DIR"
> > +    BB_WORKERCONTEXT BB_LIMITEDDEPS BB_UNIHASH
> > extend_recipe_sysroot DEPLOY_DIR \
> > +    SSTATE_HASHEQUIV_METHOD SSTATE_HASHEQUIV_SERVER
> > SSTATE_HASHEQUIV_REPORT_TASKDATA \
> > +    SSTATE_HASHEQUIV_OWNER"
> >   BB_HASHCONFIG_WHITELIST ?= "${BB_HASHBASE_WHITELIST} DATE TIME
> > SSH_AGENT_PID \
> >       SSH_AUTH_SOCK PSEUDO_BUILD BB_ENV_EXTRAWHITE
> > DISABLE_SANITY_CHECKS \
> >       PARALLEL_MAKE BB_NUMBER_THREADS BB_ORIGENV BB_INVALIDCONF
> > BBINCLUDED \
> > diff --git a/meta/lib/oe/sstatesig.py b/meta/lib/oe/sstatesig.py
> > index 18c5a353a2a..059e165c7ab 100644
> > --- a/meta/lib/oe/sstatesig.py
> > +++ b/meta/lib/oe/sstatesig.py
> > @@ -263,10 +263,177 @@ class
> > SignatureGeneratorOEBasicHash(bb.siggen.SignatureGeneratorBasicHash
> > ):
> >           if error_msgs:
> >               bb.fatal("\n".join(error_msgs))
> >   
> > +class
> > SignatureGeneratorOEEquivHash(SignatureGeneratorOEBasicHash):
> > +    name = "OEEquivHash"
> > +
> > +    def init_rundepcheck(self, data):
> > +        super().init_rundepcheck(data)
> > +        self.server = data.getVar('SSTATE_HASHEQUIV_SERVER')
> > +        self.method = data.getVar('SSTATE_HASHEQUIV_METHOD')
> > +        self.unihashes =
> > bb.persist_data.persist('SSTATESIG_UNIHASH_CACHE_v1_' +
> > self.method, data)
> > +
> > +    def get_taskdata(self):
> > +        return (self.server, self.method) + super().get_taskdata()
> > +
> > +    def set_taskdata(self, data):
> > +        self.server, self.method = data[:2]
> > +        super().set_taskdata(data[2:])
> > +
> > +    def __get_task_unihash_key(self, task):
> > +        # TODO: The key only *needs* to be the taskhash, the task
> > is just
> > +        # convenient
> > +        return '%s:%s' % (task, self.taskhash[task])
> > +
> > +    def get_stampfile_hash(self, task):
> > +        if task in self.taskhash:
> > +            # If a unique hash is reported, use it as the
> > stampfile hash. This
> > +            # ensures that if a task won't be re-run if the
> > taskhash changes,
> > +            # but it would result in the same output hash
> > +            unihash =
> > self.unihashes.get(self.__get_task_unihash_key(task))
> > +            if unihash is not None:
> > +                return unihash
> > +
> > +        return super().get_stampfile_hash(task)
> > +
> > +    def get_unihash(self, task):
> > +        import urllib
> > +        import json
> > +
> > +        taskhash = self.taskhash[task]
> > +
> > +        key = self.__get_task_unihash_key(task)
> > +
> > +        # TODO: This cache can grow unbounded. It probably only
> > needs to keep
> > +        # for each task
> > +        unihash = self.unihashes.get(key)
> > +        if unihash is not None:
> > +            return unihash
> > +
> > +        # In the absence of being able to discover a unique hash
> > from the
> > +        # server, make it be equivalent to the taskhash. The
> > unique "hash" only
> > +        # really needs to be a unique string (not even necessarily
> > a hash), but
> > +        # making it match the taskhash has a few advantages:
> > +        #
> > +        # 1) All of the sstate code that assumes hashes can be the
> > same
> > +        # 2) It provides maximal compatibility with builders that
> > don't use
> > +        #    an equivalency server
> > +        # 3) The value is easy for multiple independent builders
> > to derive the
> > +        #    same unique hash from the same input. This means that
> > if the
> > +        #    independent builders find the same taskhash, but it
> > isn't reported
> > +        #    to the server, there is a better chance that they
> > will agree on
> > +        #    the unique hash.
> > +        unihash = taskhash
> > +
> > +        try:
> > +            url = '%s/v1/equivalent?%s' % (self.server,
> > +                    urllib.parse.urlencode({'method': self.method,
> > 'taskhash': self.taskhash[task]}))
> > +
> > +            request = urllib.request.Request(url)
> > +            response = urllib.request.urlopen(request)
> > +            data = response.read().decode('utf-8')
> > +
> > +            json_data = json.loads(data)
> > +
> > +            if json_data:
> > +                unihash = json_data['unihash']
> > +                # A unique hash equal to the taskhash is not very
> > interesting,
> > +                # so it is reported it at debug level 2. If they
> > differ, that
> > +                # is much more interesting, so it is reported at
> > debug level 1
> > +                bb.debug((1, 2)[unihash == taskhash], 'Found
> > unihash %s in place of %s for %s from %s' % (unihash, taskhash,
> > task, self.server))
> > +            else:
> > +                bb.debug(2, 'No reported unihash for %s:%s from
> > %s' % (task, taskhash, self.server))
> > +        except urllib.error.URLError as e:
> > +            bb.warn('Failure contacting Hash Equivalence Server
> > %s: %s' % (self.server, str(e)))
> > +        except (KeyError, json.JSONDecodeError) as e:
> > +            bb.warn('Poorly formatted response from %s: %s' %
> > (self.server, str(e)))
> > +
> > +        self.unihashes[key] = unihash
> > +        return unihash
> > +
> > +    def report_unihash(self, path, task, d):
> > +        import urllib
> > +        import json
> > +        import tempfile
> > +        import base64
> > +
> > +        taskhash = d.getVar('BB_TASKHASH')
> > +        unihash = d.getVar('BB_UNIHASH')
> > +        report_taskdata =
> > d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
> > +        tempdir = d.getVar('T')
> > +        fn = d.getVar('BB_FILENAME')
> > +        key = fn + '.do_' + task + ':' + taskhash
> > +
> > +        # Sanity checks
> > +        cache_unihash = self.unihashes.get(key)
> > +        if cache_unihash is None:
> > +            bb.fatal('%s not in unihash cache. Please report this
> > error' % key)
> > +
> > +        if cache_unihash != unihash:
> > +            bb.fatal("Cache unihash %s doesn't match BB_UNIHASH
> > %s" % (cache_unihash, unihash))
> > +
> > +        sigfile = None
> > +        sigfile_name = "depsig.do_%s.%d" % (task, os.getpid())
> > +        sigfile_link = "depsig.do_%s" % task
> > +
> > +        try:
> > +            call = self.method + '(path, sigfile, task, d)'
> > +            sigfile = open(os.path.join(tempdir, sigfile_name),
> > 'w+b')
> > +            locs = {'path': path, 'sigfile': sigfile, 'task':
> > task, 'd': d}
> > +
> > +            outhash = bb.utils.better_eval(call, locs)
> > +
> > +            try:
> > +                url = '%s/v1/equivalent' % self.server
> > +                task_data = {
> > +                    'taskhash': taskhash,
> > +                    'method': self.method,
> > +                    'outhash': outhash,
> > +                    'unihash': unihash,
> > +                    'owner': d.getVar('SSTATE_HASHEQUIV_OWNER')
> > +                    }
> > +
> > +                if report_taskdata:
> > +                    sigfile.seek(0)
> > +
> > +                    task_data['PN'] = d.getVar('PN')
> > +                    task_data['PV'] = d.getVar('PV')
> > +                    task_data['PR'] = d.getVar('PR')
> > +                    task_data['task'] = task
> > +                    task_data['outhash_siginfo'] =
> > sigfile.read().decode('utf-8')
> > +
> > +                headers = {'content-type': 'application/json'}
> > +
> > +                request = urllib.request.Request(url,
> > json.dumps(task_data).encode('utf-8'), headers)
> > +                response = urllib.request.urlopen(request)
> > +                data = response.read().decode('utf-8')
> > +
> > +                json_data = json.loads(data)
> > +                new_unihash = json_data['unihash']
> > +
> > +                if new_unihash != unihash:
> > +                    bb.debug(1, 'Task %s unihash changed %s -> %s
> > by server %s' % (taskhash, unihash, new_unihash, self.server))
> > +                else:
> > +                    bb.debug(1, 'Reported task %s as unihash %s to
> > %s' % (taskhash, unihash, self.server))
> > +            except urllib.error.URLError as e:
> > +                bb.warn('Failure contacting Hash Equivalence
> > Server %s: %s' % (self.server, str(e)))
> > +            except (KeyError, json.JSONDecodeError) as e:
> > +                bb.warn('Poorly formatted response from %s: %s' %
> > (self.server, str(e)))
> > +        finally:
> > +            if sigfile:
> > +                sigfile.close()
> > +
> > +                sigfile_link_path = os.path.join(tempdir,
> > sigfile_link)
> > +                bb.utils.remove(sigfile_link_path)
> > +
> > +                try:
> > +                    os.symlink(sigfile_name, sigfile_link_path)
> > +                except OSError:
> > +                    pass
> >   
> >   # Insert these classes into siggen's namespace so it can see and
> > select them
> >   bb.siggen.SignatureGeneratorOEBasic = SignatureGeneratorOEBasic
> >   bb.siggen.SignatureGeneratorOEBasicHash =
> > SignatureGeneratorOEBasicHash
> > +bb.siggen.SignatureGeneratorOEEquivHash =
> > SignatureGeneratorOEEquivHash
> >   
> >   
> >   def find_siginfo(pn, taskname, taskhashlist, d):
> > 
-- 
Joshua Watt <JPEWhacker@gmail.com>


