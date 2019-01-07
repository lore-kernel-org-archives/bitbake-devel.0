Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7E8FA7BE5B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 12:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id DCE2D183ED;
	Mon,  7 Jan 2019 13:32:42 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id g3jQYEA2JCyM; Mon,  7 Jan 2019 13:32:41 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 18CC518359;
	Mon,  7 Jan 2019 13:32:41 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 030261A05D;
	Mon,  7 Jan 2019 13:32:41 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1571A040;
	Mon,  7 Jan 2019 13:32:40 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Mon,  7 Jan 2019 13:32:40 +0100 (CET)
Received: from XBOX01.axis.com (xbox01.axis.com [10.0.5.15])
	by thoth.se.axis.com (Postfix) with ESMTP id DCFE32491;
	Mon,  7 Jan 2019 13:32:40 +0100 (CET)
Received: from XBOX04.axis.com (10.0.5.18) by XBOX01.axis.com (10.0.5.15) with
	Microsoft SMTP Server (TLS) id 15.0.1365.1;
	Mon, 7 Jan 2019 13:32:40 +0100
Received: from XBOX04.axis.com ([fe80::210a:724b:68cb:a917]) by
	XBOX04.axis.com ([fe80::210a:724b:68cb:a917%22]) with mapi id
	15.00.1365.000; Mon, 7 Jan 2019 13:32:40 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake-diffsigs: Merge with
	bitbake-dumpsig
Thread-Index: AdSe0/xhibk7Zo3vRa+EkjRBkozTAAHsOd6g
Date: Mon, 7 Jan 2019 12:32:40 +0000
Message-ID: <2deee2e37e2342469aef317615f4ebb3@XBOX04.axis.com>
References: <5c78468f443541ccaa18879364866f6b@XBOX04.axis.com>
In-Reply-To: <5c78468f443541ccaa18879364866f6b@XBOX04.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Cc: Armin Kuster <akuster808@gmail.com>
Subject: Re: [PATCH 1/2] bitbake-diffsigs: Merge with bitbake-dumpsig
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
X-List-Received-Date: Mon, 07 Jan 2019 12:32:43 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Since these two patches now have made it into master, can you please=20
also cherry-pick them to Thud?

//Peter

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 28 december 2018 18:37
> To: bitbake-devel@lists.openembedded.org
> Cc: Paul Eggleton <paul.eggleton@linux.intel.com>
> Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-diffsigs: Merge with
> bitbake-dumpsig
>=20
> Assuming these are accepted into master, I would also like for them to
> be cherry-picked to Thud, to make bitbake-dumpsig work again.
>=20
> //Peter
>=20
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> > bounces@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> > Sent: den 28 december 2018 18:31
> > To: bitbake-devel@lists.openembedded.org
> > Cc: Paul Eggleton <paul.eggleton@linux.intel.com>
> > Subject: [bitbake-devel] [PATCH 1/2] bitbake-diffsigs: Merge with
> > bitbake-dumpsig
> >
> > The functionalities of bitbake-diffsigs and bitbake-dumpsig are so
> > similar that they can be merged into one. Add an option --dump to
> make
> > bitbake-diffsigs dump the last signature data instead of comparing
> it.
> > Keep bitbake-dumpsig as a symbolic link to bitbake-diffsigs. When it
> is
> > called as bitbake-dumpsig, it behaves as if --dump was specified.
> >
> > Also make -D the short option for --debug again (the way it used to
> be,
> > and still was for bitbake-dumpsig), so that -d can be used as the
> short
> > option for --dump.
> >
> > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > ---
> >  bitbake/bin/bitbake-diffsigs | 139 +++++++++++++++++++++++++--------
> --
> > --------
> >  bitbake/bin/bitbake-dumpsig  |  95 +----------------------------
> >  2 files changed, 82 insertions(+), 152 deletions(-)
> >  mode change 100755 =3D> 120000 bitbake/bin/bitbake-dumpsig
> >
> > diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-
> > diffsigs
> > index 4e6bbddcd8..b0869e1143 100755
> > --- a/bitbake/bin/bitbake-diffsigs
> > +++ b/bitbake/bin/bitbake-diffsigs
> > @@ -1,7 +1,7 @@
> >  #!/usr/bin/env python3
> >
> > -# bitbake-diffsigs
> > -# BitBake task signature data comparison utility
> > +# bitbake-diffsigs / bitbake-dumpsig
> > +# BitBake task signature data dump and comparison utility
> >  #
> >  # Copyright (C) 2012-2013, 2017 Intel Corporation
> >  #
> > @@ -21,7 +21,6 @@
> >  import os
> >  import sys
> >  import warnings
> > -import fnmatch
> >  import argparse
> >  import logging
> >  import pickle
> > @@ -32,7 +31,10 @@ import bb.tinfoil
> >  import bb.siggen
> >  import bb.msg
> >
> > -logger =3D bb.msg.logger_create('bitbake-diffsigs')
> > +myname =3D os.path.basename(sys.argv[0])
> > +logger =3D bb.msg.logger_create(myname)
> > +
> > +is_dump =3D myname =3D=3D 'bitbake-dumpsig'
> >
> >  def find_siginfo(tinfoil, pn, taskname, sigs=3DNone):
> >      result =3D None
> > @@ -59,8 +61,8 @@ def find_siginfo(tinfoil, pn, taskname, sigs=3DNone):
> >          sys.exit(2)
> >      return result
> >
> > -def find_compare_task(bbhandler, pn, taskname, sig1=3DNone, sig2=3DNon=
e,
> > color=3DFalse):
> > -    """ Find the most recent signature files for the specified
> PN/task
> > and compare them """
> > +def find_siginfo_task(bbhandler, pn, taskname, sig1=3DNone,
> sig2=3DNone):
> > +    """ Find the most recent signature files for the specified
> PN/task
> > """
> >
> >      if not taskname.startswith('do_'):
> >          taskname =3D 'do_%s' % taskname
> > @@ -79,73 +81,81 @@ def find_compare_task(bbhandler, pn, taskname,
> > sig1=3DNone, sig2=3DNone, color=3DFalse
> >          latestfiles =3D [sigfiles[sig1], sigfiles[sig2]]
> >      else:
> >          filedates =3D find_siginfo(bbhandler, pn, taskname)
> > -        latestfiles =3D sorted(filedates.keys(), key=3Dlambda f:
> > filedates[f])[-3:]
> > +        latestfiles =3D sorted(filedates.keys(), key=3Dlambda f:
> > filedates[f])[-2:]
> >          if not latestfiles:
> >              logger.error('No sigdata files found matching %s %s' %
> > (pn, taskname))
> >              sys.exit(1)
> > -        elif len(latestfiles) < 2:
> > -            logger.error('Only one matching sigdata file found for
> the
> > specified task (%s %s)' % (pn, taskname))
> > -            sys.exit(1)
> >
> > -    # Define recursion callback
> > -    def recursecb(key, hash1, hash2):
> > -        hashes =3D [hash1, hash2]
> > -        hashfiles =3D find_siginfo(bbhandler, key, None, hashes)
> > -
> > -        recout =3D []
> > -        if len(hashfiles) =3D=3D 0:
> > -            recout.append("Unable to find matching sigdata for %s
> with
> > hashes %s or %s" % (key, hash1, hash2))
> > -        elif not hash1 in hashfiles:
> > -            recout.append("Unable to find matching sigdata for %s
> with
> > hash %s" % (key, hash1))
> > -        elif not hash2 in hashfiles:
> > -            recout.append("Unable to find matching sigdata for %s
> with
> > hash %s" % (key, hash2))
> > -        else:
> > -            out2 =3D bb.siggen.compare_sigfiles(hashfiles[hash1],
> > hashfiles[hash2], recursecb, color=3Dcolor)
> > -            for change in out2:
> > -                for line in change.splitlines():
> > -                    recout.append('  ' + line)
> > +    return latestfiles
> >
> > -        return recout
> >
> > -    # Recurse into signature comparison
> > -    logger.debug("Signature file (previous): %s" % latestfiles[-2])
> > -    logger.debug("Signature file (latest): %s" % latestfiles[-1])
> > -    output =3D bb.siggen.compare_sigfiles(latestfiles[-2],
> latestfiles[-
> > 1], recursecb, color=3Dcolor)
> > -    if output:
> > -        print('\n'.join(output))
> > -    sys.exit(0)
> > +# Define recursion callback
> > +def recursecb(key, hash1, hash2):
> > +    hashes =3D [hash1, hash2]
> > +    hashfiles =3D find_siginfo(tinfoil, key, None, hashes)
> > +
> > +    recout =3D []
> > +    if len(hashfiles) =3D=3D 0:
> > +        recout.append("Unable to find matching sigdata for %s with
> > hashes %s or %s" % (key, hash1, hash2))
> > +    elif not hash1 in hashfiles:
> > +        recout.append("Unable to find matching sigdata for %s with
> > hash %s" % (key, hash1))
> > +    elif not hash2 in hashfiles:
> > +        recout.append("Unable to find matching sigdata for %s with
> > hash %s" % (key, hash2))
> > +    else:
> > +        out2 =3D bb.siggen.compare_sigfiles(hashfiles[hash1],
> > hashfiles[hash2], recursecb, color=3Dcolor)
> > +        for change in out2:
> > +            for line in change.splitlines():
> > +                recout.append('  ' + line)
> >
> > +    return recout
> >
> >
> >  parser =3D argparse.ArgumentParser(
> > -    description=3D"Compares siginfo/sigdata files written out by
> > BitBake")
> > +    description=3D("Dumps" if is_dump else "Compares") + "
> > siginfo/sigdata files written out by BitBake")
> >
> > -parser.add_argument('-d', '--debug',
> > +parser.add_argument('-D', '--debug',
> >                      help=3D'Enable debug output',
> >                      action=3D'store_true')
> >
> > -parser.add_argument('--color',
> > -        help=3D'Colorize output (where %(metavar)s is %(choices)s)',
> > -        choices=3D['auto', 'always', 'never'], default=3D'auto',
> > metavar=3D'color')
> > +if is_dump:
> > +    parser.add_argument("-t", "--task",
> > +            help=3D"find the signature data file for the last run of
> the
> > specified task",
> > +            action=3D"store", dest=3D"taskargs", nargs=3D2,
> > metavar=3D('recipename', 'taskname'))
> >
> > -parser.add_argument("-t", "--task",
> > -        help=3D"find the signature data files for last two runs of the
> > specified task and compare them",
> > -        action=3D"store", dest=3D"taskargs", nargs=3D2,
> > metavar=3D('recipename', 'taskname'))
> > +    parser.add_argument("sigdatafile1",
> > +            help=3D"Signature file to dump. Not used when using -t/--
> > task.",
> > +            action=3D"store", nargs=3D'?', metavar=3D"sigdatafile")
> > +else:
> > +    parser.add_argument('-c', '--color',
> > +            help=3D'Colorize the output (where %(metavar)s is
> > %(choices)s)',
> > +            choices=3D['auto', 'always', 'never'], default=3D'auto',
> > metavar=3D'color')
> > +
> > +    parser.add_argument('-d', '--dump',
> > +            help=3D'Dump the last signature data instead of comparing
> > (equivalent to using bitbake-dumpsig)',
> > +            action=3D'store_true')
> >
> > -parser.add_argument("-s", "--signature",
> > -        help=3D"With -t/--task, specify the signatures to look for
> > instead of taking the last two",
> > -        action=3D"store", dest=3D"sigargs", nargs=3D2, metavar=3D('fro=
msig',
> > 'tosig'))
> > +    parser.add_argument("-t", "--task",
> > +            help=3D"find the signature data files for the last two
> runs
> > of the specified task and compare them",
> > +            action=3D"store", dest=3D"taskargs", nargs=3D2,
> > metavar=3D('recipename', 'taskname'))
> >
> > -parser.add_argument("sigdatafile1",
> > -        help=3D"First signature file to compare (or signature file to
> > dump, if second not specified). Not used when using -t/--task.",
> > -        action=3D"store", nargs=3D'?')
> > +    parser.add_argument("-s", "--signature",
> > +            help=3D"With -t/--task, specify the signatures to look for
> > instead of taking the last two",
> > +            action=3D"store", dest=3D"sigargs", nargs=3D2,
> > metavar=3D('fromsig', 'tosig'))
> >
> > -parser.add_argument("sigdatafile2",
> > -        help=3D"Second signature file to compare",
> > -        action=3D"store", nargs=3D'?')
> > +    parser.add_argument("sigdatafile1",
> > +            help=3D"First signature file to compare (or signature file
> > to dump, if second not specified). Not used when using -t/--task.",
> > +            action=3D"store", nargs=3D'?')
> >
> > +    parser.add_argument("sigdatafile2",
> > +            help=3D"Second signature file to compare",
> > +            action=3D"store", nargs=3D'?')
> >
> >  options =3D parser.parse_args()
> > +if is_dump:
> > +    options.color =3D 'never'
> > +    options.dump =3D True
> > +    options.sigdatafile2 =3D None
> > +    options.sigargs =3D None
> >
> >  if options.debug:
> >      logger.setLevel(logging.DEBUG)
> > @@ -155,16 +165,29 @@ color =3D (options.color =3D=3D 'always' or
> > (options.color =3D=3D 'auto' and sys.stdout.is
> >  if options.taskargs:
> >      with bb.tinfoil.Tinfoil() as tinfoil:
> >          tinfoil.prepare(config_only=3DTrue)
> > -        if options.sigargs:
> > -            find_compare_task(tinfoil, options.taskargs[0],
> > options.taskargs[1], options.sigargs[0], options.sigargs[1],
> > color=3Dcolor)
> > +        if not options.dump and options.sigargs:
> > +            files =3D find_siginfo_task(tinfoil, options.taskargs[0],
> > options.taskargs[1], options.sigargs[0], options.sigargs[1])
> > +        else:
> > +            files =3D find_siginfo_task(tinfoil, options.taskargs[0],
> > options.taskargs[1])
> > +
> > +        if options.dump:
> > +            logger.debug("Signature file: %s" % files[-1])
> > +            output =3D bb.siggen.dump_sigfile(files[-1])
> >          else:
> > -            find_compare_task(tinfoil, options.taskargs[0],
> > options.taskargs[1], color=3Dcolor)
> > +            if len(files) < 2:
> > +                logger.error('Only one matching sigdata file found
> for
> > the specified task (%s %s)' % (options.taskargs[0],
> > options.taskargs[1]))
> > +                sys.exit(1)
> > +
> > +            # Recurse into signature comparison
> > +            logger.debug("Signature file (previous): %s" % files[-
> 2])
> > +            logger.debug("Signature file (latest): %s" % files[-1])
> > +            output =3D bb.siggen.compare_sigfiles(files[-2], files[-
> 1],
> > recursecb, color=3Dcolor)
> >  else:
> >      if options.sigargs:
> >          logger.error('-s/--signature can only be used together with
> -
> > t/--task')
> >          sys.exit(1)
> >      try:
> > -        if options.sigdatafile1 and options.sigdatafile2:
> > +        if not options.dump and options.sigdatafile1 and
> > options.sigdatafile2:
> >              output =3D
> bb.siggen.compare_sigfiles(options.sigdatafile1,
> > options.sigdatafile2, color=3Dcolor)
> >          elif options.sigdatafile1:
> >              output =3D bb.siggen.dump_sigfile(options.sigdatafile1)
> > @@ -179,5 +202,5 @@ else:
> >          logger.error('Invalid signature data - ensure you are
> > specifying sigdata/siginfo files')
> >          sys.exit(1)
> >
> > -    if output:
> > -        print('\n'.join(output))
> > +if output:
> > +    print('\n'.join(output))
> > diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-
> dumpsig
> > deleted file mode 100755
> > index 95ebd93546..0000000000
> > --- a/bitbake/bin/bitbake-dumpsig
> > +++ /dev/null
> > @@ -1,94 +0,0 @@
> > -#!/usr/bin/env python3
> > -
> > -# bitbake-dumpsig
> > -# BitBake task signature dump utility
> > -#
> > -# Copyright (C) 2013 Intel Corporation
> > -#
> > -# This program is free software; you can redistribute it and/or
> modify
> > -# it under the terms of the GNU General Public License version 2 as
> > -# published by the Free Software Foundation.
> > -#
> > -# This program is distributed in the hope that it will be useful,
> > -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > -# GNU General Public License for more details.
> > -#
> > -# You should have received a copy of the GNU General Public License
> > along
> > -# with this program; if not, write to the Free Software Foundation,
> > Inc.,
> > -# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > -
> > -import os
> > -import sys
> > -import warnings
> > -import optparse
> > -import logging
> > -import pickle
> > -
> > -sys.path.insert(0,
> > os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
> > -
> > -import bb.tinfoil
> > -import bb.siggen
> > -import bb.msg
> > -
> > -logger =3D bb.msg.logger_create('bitbake-dumpsig')
> > -
> > -def find_siginfo_task(bbhandler, pn, taskname):
> > -    """ Find the most recent signature file for the specified
> PN/task
> > """
> > -
> > -    if not hasattr(bb.siggen, 'find_siginfo'):
> > -        logger.error('Metadata does not support finding signature
> data
> > files')
> > -        sys.exit(1)
> > -
> > -    if not taskname.startswith('do_'):
> > -        taskname =3D 'do_%s' % taskname
> > -
> > -    filedates =3D bb.siggen.find_siginfo(pn, taskname, None,
> > bbhandler.config_data)
> > -    latestfiles =3D sorted(filedates.keys(), key=3Dlambda f:
> > filedates[f])[-1:]
> > -    if not latestfiles:
> > -        logger.error('No sigdata files found matching %s %s' % (pn,
> > taskname))
> > -        sys.exit(1)
> > -
> > -    return latestfiles[0]
> > -
> > -parser =3D optparse.OptionParser(
> > -    description =3D "Dumps siginfo/sigdata files written out by
> > BitBake",
> > -    usage =3D """
> > -  %prog -t recipename taskname
> > -  %prog sigdatafile""")
> > -
> > -parser.add_option("-D", "--debug",
> > -        help =3D "enable debug",
> > -        action =3D "store_true", dest=3D"debug", default =3D False)
> > -
> > -parser.add_option("-t", "--task",
> > -        help =3D "find the signature data file for the specified
> task",
> > -        action=3D"store", dest=3D"taskargs", nargs=3D2,
> metavar=3D'recipename
> > taskname')
> > -
> > -options, args =3D parser.parse_args(sys.argv)
> > -
> > -if options.debug:
> > -    logger.setLevel(logging.DEBUG)
> > -
> > -if options.taskargs:
> > -    tinfoil =3D bb.tinfoil.Tinfoil()
> > -    tinfoil.prepare(config_only =3D True)
> > -    file =3D find_siginfo_task(tinfoil, options.taskargs[0],
> > options.taskargs[1])
> > -    logger.debug("Signature file: %s" % file)
> > -elif len(args) =3D=3D 1:
> > -    parser.print_help()
> > -    sys.exit(0)
> > -else:
> > -    file =3D args[1]
> > -
> > -try:
> > -    output =3D bb.siggen.dump_sigfile(file)
> > -except IOError as e:
> > -    logger.error(str(e))
> > -    sys.exit(1)
> > -except (pickle.UnpicklingError, EOFError):
> > -    logger.error('Invalid signature data - ensure you are specifying
> a
> > sigdata/siginfo file')
> > -    sys.exit(1)
> > -
> > -if output:
> > -    print('\n'.join(output))
> > diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-
> dumpsig
> > new file mode 120000
> > index 0000000000..b1e8489b45
> > --- /dev/null
> > +++ b/bitbake/bin/bitbake-dumpsig
> > @@ -0,0 +1 @@
> > +bitbake-diffsigs
> > \ No newline at end of file
> > --
> > 2.12.0
> >
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

